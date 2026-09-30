import streamlit as st
import pandas as pd

# Page configuration
st.set_page_config(
    page_title="Cart2Insights",
    page_icon="🛒",
    layout="wide"
)

# Sidebar navigation
st.sidebar.title("🛒 Cart2Insights")

page = st.sidebar.radio(
    "Go to",
    [
        "Overview",
        "Sales",
        "Customers",
        "Delivery",
        "Customer Experience",
        "Sellers"
    ]
)

# Load data
orders = pd.read_csv("data/processed/orders_features.csv")
sellers = pd.read_csv("data/processed/sellers_features.csv")
order_reviews = pd.read_csv("data/cleaned/order_reviews_clean.csv")

# Convert date column
orders["order_purchase_timestamp"] = pd.to_datetime(
    orders["order_purchase_timestamp"]
)

# Create order month
orders["order_month"] = (
    orders["order_purchase_timestamp"]
    .dt.to_period("M")
    .astype(str)
)


# =========================
# Overview page
# =========================
if page == "Overview":

    st.title("🛒 Cart2Insights")
    st.subheader("Decoding E-Commerce Performance")
    st.write("E-Commerce Analytics Dashboard")

    # Overview metrics
    total_orders = orders["order_id"].nunique()
    total_sales = orders["total_order_value"].sum()
    delayed_orders = (
        orders["delivery_status"] == "Delayed"
    ).sum()
    repeat_orders = orders["repeat_customer"].sum()

    col1, col2, col3, col4 = st.columns(4)

    col1.metric("Total Orders", f"{total_orders:,}")
    col2.metric("Total Sales", f"₹{total_sales:,.2f}")
    col3.metric("Delayed Orders", f"{delayed_orders:,}")
    col4.metric("Repeat Customer Orders", f"{repeat_orders:,}")

    # Monthly performance
    monthly_orders = (
        orders.groupby("order_month")["order_id"]
        .count()
    )

    monthly_sales = (
        orders.groupby("order_month")["total_order_value"]
        .sum(min_count=1)
    )

    st.subheader("Monthly Performance")

    col1, col2 = st.columns(2)

    with col1:
        st.write("### Monthly Orders")
        st.line_chart(monthly_orders)

    with col2:
        st.write("### Monthly Sales")
        st.line_chart(monthly_sales)

    # Order status
    st.subheader("Order Status Analysis")

    order_status_counts = orders["order_status"].value_counts()

    st.bar_chart(order_status_counts)


# =========================
# Sales page
# =========================
if page == "Sales":

    st.title("💰 Sales Analysis")

    st.subheader("Monthly Sales")

    monthly_sales = (
        orders.groupby("order_month")["total_order_value"]
        .sum(min_count=1)
    )

    st.line_chart(monthly_sales)

    st.subheader("Average Order Value")

    average_order_value = (
        orders["average_order_value"]
        .dropna()
    )

    st.metric(
        "Average Order Value",
        f"₹{average_order_value.mean():,.2f}"
    )

    st.subheader("Order Value Distribution")

    st.line_chart(
        orders["total_order_value"]
        .dropna()
        .reset_index(drop=True)
    )


# =========================
# Customers page
# =========================
if page == "Customers":

    st.title("👥 Customer Analysis")

    st.subheader("New vs Repeat Customers")

    customer_type_counts = (
        orders["repeat_customer"]
        .value_counts()
    )

    customer_type_counts.index = (
        customer_type_counts.index.map({
            False: "New Customer",
            True: "Repeat Customer"
        })
    )

    st.bar_chart(customer_type_counts)

    st.subheader("Customer Spending")

    col1, col2 = st.columns(2)

    with col1:
        st.write("### Total Customer Spending")

        st.line_chart(
            orders["customer_total_spending"]
            .dropna()
            .reset_index(drop=True)
        )

    with col2:
        st.write("### Average Order Value")

        st.line_chart(
            orders["average_order_value"]
            .dropna()
            .reset_index(drop=True)
        )


# =========================
# Delivery page
# =========================
if page == "Delivery":

    st.title("🚚 Delivery Analysis")

    st.subheader("Delivery Performance")

    delivery_counts = (
        orders["delivery_status"]
        .value_counts()
    )

    st.bar_chart(delivery_counts)

    st.subheader("Delivery Delay")

    delay_data = (
        orders["delivery_delay_days"]
        .dropna()
    )

    st.line_chart(
        delay_data.reset_index(drop=True)
    )

    st.subheader("Average Delivery Days")

    delivery_days = (
        orders["delivery_days"]
        .dropna()
    )

    st.metric(
        "Average Delivery Time",
        f"{delivery_days.mean():.2f} days"
    )


# =========================
# Customer Experience page
# =========================
if page == "Customer Experience":

    st.title("⭐ Customer Experience")

    st.subheader("Review Score Distribution")

    review_counts = (
        order_reviews["review_score"]
        .value_counts()
        .sort_index()
    )

    st.bar_chart(review_counts)

    st.subheader("Review Score by Delivery Status")

    review_delivery = order_reviews.merge(
        orders[["order_id", "delivery_status"]],
        on="order_id",
        how="inner"
    )

    review_delivery = review_delivery[
        review_delivery["delivery_status"].isin(
            ["On Time", "Delayed"]
        )
    ]

    mean_review_by_delivery = (
        review_delivery
        .groupby("delivery_status")["review_score"]
        .mean()
    )

    st.bar_chart(mean_review_by_delivery)


# =========================
# Sellers page
# =========================
if page == "Sellers":

    st.title("🏪 Seller Analysis")

    st.subheader("Top 10 Sellers by Revenue")

    top_sellers_revenue = (
        sellers
        .nlargest(10, "seller_revenue")
        .set_index("seller_id")["seller_revenue"]
    )

    st.bar_chart(top_sellers_revenue)

    st.subheader("Top 10 Sellers by Order Count")

    top_sellers_orders = (
        sellers
        .nlargest(10, "seller_order_count")
        .set_index("seller_id")["seller_order_count"]
    )

    st.bar_chart(top_sellers_orders)


# =========================
# Footer
# =========================
st.divider()

st.caption("Cart2Insights – Decoding E-Commerce Performance")
st.caption(
    "E-Commerce Analytics Project | "
    "Python • Pandas • MySQL • Streamlit"
)