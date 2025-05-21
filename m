Return-Path: <bpf+bounces-58653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38959ABF3D9
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545A1188E860
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432026A09A;
	Wed, 21 May 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="grNf7JRq"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4A268690;
	Wed, 21 May 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829428; cv=fail; b=mYux6/50mbpN/5rBsJRkU+rCFYgXv6HcOwyuGMMlrNRQTTCSi21SjGK1x170FdScRp2XZe3G9at/YJEBZmbMk+HBzxLbyXwW+VfbwjR/CZUvuIROJTrDMBLja5cNJIhztJuQlSLuNPewqDEWf50arHKaO+isZroKY8JtvODeI4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829428; c=relaxed/simple;
	bh=3ncon6ta0gWsqdvYlqPU6POpYbAdmRb8DIQzRfdfGKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijbyxzZs5LKhyauhH+PIB27Vjkj/4VYqKQthYGlzY4gOHPuJP74zQamdetGQfy/xSYuHzm4/O3DtNY3zIRu+L3oVlLhq6MUX8mlVcd8H2VDG8WFtdWVF7p15MHfT7p7ptsnrKM37q/H7P851ri+MoLseou1a8AcEUQuw4YUYULc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grNf7JRq; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2/PZsF/4N4w5Huom+sTYDCXArlcF4kBfwAF/IU3Kr856696DdYorlumpobbo6X/5fzuLRvt2gvV4jsoa271c2v4ghooo3G/rrS6cU4hf6Ojl5asGFuU7nbVrsWYLKf1GhHniyMMt9fcF5LfA94ClIti8UjI3YSvCFuQSuaCd6hvcRZ3tGPqcpTgFm7L/JHCjPel5uBIWySpjVGjuU0wPXgWnzoffErCZ8M2/cILgvGN0BLYiQ9Ty+AHES663fas5I6yqRZ0OU6Drf2DnA7jMS70Z2mwwIBZ+wMSz38iqrOpObxGaQYQmCYBw78CVs5b9hDFWXQgoW9L7vxvVcfoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=590wC9aOMtp9de48HYbocZtv6/4hQ4j3SJMHxdKCDbY=;
 b=ZewxkIVi+C0put1IFEOaUtd6X1Tya248xcLYc4ntOH0CgQRCLsTUlOpYCC/qQSM8LlatAD12/T2vezziHo7CDpcUa2JVWlkTsN1DP3OoJCqrxfhMnL33kDIcr+jgWWMLTJy/ZiBhyb1hEUQ4/V4gMRO8PUI9EQlUqbUfQl4jU3nUawreMHN4VUe9uVUah9ZWqyIHttIzpxRRzu3t9vMY161fR1disVrctz8BcdNUaILj/C3NmP2FbYNsVS4uqjoloaJ2lIwnEfc5IsguqmWxmHlUxGGl6q00Nbz12B+kyVNIlDdPcly77+01gR2ItTpGQk2FuZztD8IyIWQ5/I3o9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=590wC9aOMtp9de48HYbocZtv6/4hQ4j3SJMHxdKCDbY=;
 b=grNf7JRqsH/hBd8vgziUwqtQfMXYtWn9GX3BxLMr8aZZaPxksXnVkeZkGaQSWi/MMBsd8sJYrxuHO+eXFXkXW3+xg2foukOmXtSl2sI61+uYTcNsB3oi0u58GjpOFv/jgBtSI9zs1VwsgM9bx23ro9+Qcq9Ynz07DvU/X9ZVJMTFiYnLn0/R4BIh+VkP/nxpiUuqp6sqYScE4fsrfjMo2sXO9aFqUb/amypDAgbJ7UiVfkXiXWwP2O00AmdIo2x7zTVLHY4M3QS8GqBEnm+z9lLee1Nfk7YcJedXuPDUBVnrK2BXdUPmsRDQPPNfdyNVIJsxgmIzvpm040t5ualuQg==
Received: from PH7PR17CA0044.namprd17.prod.outlook.com (2603:10b6:510:323::15)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 12:10:20 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::c2) by PH7PR17CA0044.outlook.office365.com
 (2603:10b6:510:323::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.34 via Frontend Transport; Wed,
 21 May 2025 12:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:10:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 05:10:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 05:10:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 05:09:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 3/5] IB/IPoIB: Allow using netdevs that require the instance lock
Date: Wed, 21 May 2025 15:09:00 +0300
Message-ID: <1747829342-1018757-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: f989acce-6e0b-4cd6-2fb8-08dd98607483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hYo7lwr/YEnTSUaNY8tuOJIfetF6OCinOeciaJQAw662oYQFVO8m693/jiK5?=
 =?us-ascii?Q?Xup5yM4Uc2iYdf+cHSBdfyMN/fJ5dFONfcPnBVsC6Io3oJ7rtr3ZLOMvvk63?=
 =?us-ascii?Q?s4kUSctlqWNvfU2KW5TQ0envSvB1s2LpAnv0HW2BKZVvYuGjNkGCknPezVBf?=
 =?us-ascii?Q?kW7mvQHXtm7DRIoxApsnWg1eYfi6RSGlYQo16sgntC2vM3RyQk7n04OQIqQ+?=
 =?us-ascii?Q?DQMaOJuISJRIZD352mxnZkXbQpCvp58iUbeAm/UG5Y4KKVgk0KLFoUlbbyfY?=
 =?us-ascii?Q?ZmmnYMZQ8ZvrGBlcPoDmyTObd1Y2zdjTBZOexgH1wjqHUfbH1HZmV2+W4Wcy?=
 =?us-ascii?Q?xbjL0EE6i17/Wn2WVnPCFBTsEnVYknjSyZfRKw5mKONuiQ9aA242ZBpQygKv?=
 =?us-ascii?Q?wjV+RXVTIvl0ANQK9E9eys2EK+ZaQtul6B6CZw3LpPIPb4uwG7IbRKVQV5H2?=
 =?us-ascii?Q?dHl6NgKQq0UfNw7cU5hf908gsRbNoE48bpIUPb7UYPMWk7mGsHHjUVTwC5WM?=
 =?us-ascii?Q?Jmh6LnHQWgmNIerGnZAkavesXaE3qi2nIRNcpTaQM/EFsmWNZEV4lS+CzJSm?=
 =?us-ascii?Q?aw6E/3VsqJaiEGYfpkH96VDumD/dHFReVZrT8K68fLINCy4YKuq4amvD5/Tv?=
 =?us-ascii?Q?jScvFC0FhujNoSBrn/NCcWaUo/esPe5l4X73EE0z1kLjYNR9NvXJO3ZAWt93?=
 =?us-ascii?Q?Nicrh4Unk+6AbToelAZIQEdn1pmMnu1XWntPNbiDq6m9SKzM/KY76tmGwzHe?=
 =?us-ascii?Q?YoQT6ul5DrBOdb2jxgTQyji+zB189vjv7j8QBZIj0SD4ATRnTkjpWGsbcizq?=
 =?us-ascii?Q?6bFo1CqVZBMkZNYJAG8bplT0psZSXJsKXYrygr6dYFsN4YZYXvwgL2aXX4lj?=
 =?us-ascii?Q?0F+6jelaTNp63j7OXtqC8Fn+k179EWMCiGKCCkYCcKUIBh/7pFAaDUXauh3K?=
 =?us-ascii?Q?cWx6zXcMoGVbCN/y1tXnjVbS45tDeCowi8m/CW9z5R7tOhyxWlVeGtSmcinz?=
 =?us-ascii?Q?0B425XldlhUhfn187OkMXeaAJcd6y3zZ7ZjZfRFTTlE1FNPAw7cUrHoMtc+2?=
 =?us-ascii?Q?rxiZtKTK27aVORdvo4uRwu+i6aNr16M5y9qXlhPpQBxhUHYKP6Pl8o6sI3UW?=
 =?us-ascii?Q?dlIStu2NethrzxxZ6bbhREiWIExC3TOr0LfbEHMJivcdpeFGzwRJ4g4XiuVD?=
 =?us-ascii?Q?2yIwqulfHl/bx08bO801x+51RGVK3Hh0bdqIOO5YjJDSAbdMF4JrfK62Us9h?=
 =?us-ascii?Q?Xe3ML3TGr8sTvOc+/aTD07xkXD/5APp3DwDfijib/S3UjgZVxfQYGtkI1U3M?=
 =?us-ascii?Q?7Lq6Evls9hqIRSTxbfH+MT1mbLuQQeE10It6/Q9jCs50Ra6m/qZSTJ7jJwvO?=
 =?us-ascii?Q?j1k2AewwhJGAln2SBuow0WeyQapCloENrgBfIhMtaTszLAlv+6jMU9s4VJCs?=
 =?us-ascii?Q?UsWCwjRBXqELURc1AUeyBuMnQIMpPg6DlVegfnx8ha7WmHOD1YSLvGAx7yqk?=
 =?us-ascii?Q?WRkNeGnNLtCLSmX7hI9Lyd9mTwLb6fbew565?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:10:19.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f989acce-6e0b-4cd6-2fb8-08dd98607483
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

From: Cosmin Ratiu <cratiu@nvidia.com>

After the last patch removing vlan_rwsem, it is an incremental step to
allow ipoib to work with netdevs that require the instance lock.
In several places, netdev_lock() is changed to netdev_lock_ops_to_full()
which takes care of not acquiring the lock again when the netdev is
already locked.

In ipoib_ib_tx_timeout_work() and __ipoib_ib_dev_flush() for HEAVY
flushes, the netdev lock is acquired/released. This is needed because
these functions end up calling .ndo_stop()/.ndo_open() on subinterfaces,
and the device may expect the netdev instance lock to be held.

ipoib_set_mode() now explicitly acquires ops lock while manipulating the
features, mtu and tx queues.

Finally, ipoib_napi_enable()/ipoib_napi_disable() now use the *_locked
variants of the napi_enable()/napi_disable() calls and optionally
acquire the netdev lock themselves depending on the dev they operate on.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c   | 19 +++++++++++-----
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 27 ++++++++++++++---------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index dc670b4a191b..10b0dbda6cd5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -40,6 +40,7 @@
 
 #include <linux/ip.h>
 #include <linux/tcp.h>
+#include <net/netdev_lock.h>
 #include <rdma/ib_cache.h>
 
 #include "ipoib.h"
@@ -781,16 +782,20 @@ static void ipoib_napi_enable(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
-	napi_enable(&priv->recv_napi);
-	napi_enable(&priv->send_napi);
+	netdev_lock_ops_to_full(dev);
+	napi_enable_locked(&priv->recv_napi);
+	napi_enable_locked(&priv->send_napi);
+	netdev_unlock_full_to_ops(dev);
 }
 
 static void ipoib_napi_disable(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
-	napi_disable(&priv->recv_napi);
-	napi_disable(&priv->send_napi);
+	netdev_lock_ops_to_full(dev);
+	napi_disable_locked(&priv->recv_napi);
+	napi_disable_locked(&priv->send_napi);
+	netdev_unlock_full_to_ops(dev);
 }
 
 int ipoib_ib_dev_stop_default(struct net_device *dev)
@@ -1240,10 +1245,14 @@ static void __ipoib_ib_dev_flush(struct ipoib_dev_priv *priv,
 		ipoib_ib_dev_down(dev);
 
 	if (level == IPOIB_FLUSH_HEAVY) {
+		netdev_lock_ops(dev);
 		if (test_bit(IPOIB_FLAG_INITIALIZED, &priv->flags))
 			ipoib_ib_dev_stop(dev);
 
-		if (ipoib_ib_dev_open(dev))
+		result = ipoib_ib_dev_open(dev);
+		netdev_unlock_ops(dev);
+
+		if (result)
 			return;
 
 		if (netif_queue_stopped(dev))
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 4879fd17e868..f2f5465f2a90 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -49,6 +49,7 @@
 #include <linux/jhash.h>
 #include <net/arp.h>
 #include <net/addrconf.h>
+#include <net/netdev_lock.h>
 #include <net/pkt_sched.h>
 #include <linux/inetdevice.h>
 #include <rdma/ib_cache.h>
@@ -200,10 +201,10 @@ int ipoib_open(struct net_device *dev)
 		struct ipoib_dev_priv *cpriv;
 
 		/* Bring up any child interfaces too */
-		netdev_lock(dev);
+		netdev_lock_ops_to_full(dev);
 		list_for_each_entry(cpriv, &priv->child_intfs, list)
 			ipoib_schedule_ifupdown_task(cpriv->dev, true);
-		netdev_unlock(dev);
+		netdev_unlock_full_to_ops(dev);
 	} else if (priv->parent) {
 		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
@@ -238,10 +239,10 @@ static int ipoib_stop(struct net_device *dev)
 		struct ipoib_dev_priv *cpriv;
 
 		/* Bring down any child interfaces too */
-		netdev_lock(dev);
+		netdev_lock_ops_to_full(dev);
 		list_for_each_entry(cpriv, &priv->child_intfs, list)
 			ipoib_schedule_ifupdown_task(cpriv->dev, false);
-		netdev_unlock(dev);
+		netdev_unlock_full_to_ops(dev);
 	}
 
 	return 0;
@@ -566,9 +567,11 @@ int ipoib_set_mode(struct net_device *dev, const char *buf)
 		set_bit(IPOIB_FLAG_ADMIN_CM, &priv->flags);
 		ipoib_warn(priv, "enabling connected mode "
 			   "will cause multicast packet drops\n");
+		netdev_lock_ops(dev);
 		netdev_update_features(dev);
-		dev_set_mtu(dev, ipoib_cm_max_mtu(dev));
+		netif_set_mtu(dev, ipoib_cm_max_mtu(dev));
 		netif_set_real_num_tx_queues(dev, 1);
+		netdev_unlock_ops(dev);
 		rtnl_unlock();
 		priv->tx_wr.wr.send_flags &= ~IB_SEND_IP_CSUM;
 
@@ -578,9 +581,11 @@ int ipoib_set_mode(struct net_device *dev, const char *buf)
 
 	if (!strcmp(buf, "datagram\n")) {
 		clear_bit(IPOIB_FLAG_ADMIN_CM, &priv->flags);
+		netdev_lock_ops(dev);
 		netdev_update_features(dev);
-		dev_set_mtu(dev, min(priv->mcast_mtu, dev->mtu));
+		netif_set_mtu(dev, min(priv->mcast_mtu, dev->mtu));
 		netif_set_real_num_tx_queues(dev, dev->num_tx_queues);
+		netdev_unlock_ops(dev);
 		rtnl_unlock();
 		ipoib_flush_paths(dev);
 		return (!rtnl_trylock()) ? -EBUSY : 0;
@@ -1247,6 +1252,7 @@ void ipoib_ib_tx_timeout_work(struct work_struct *work)
 	int err;
 
 	rtnl_lock();
+	netdev_lock_ops(priv->dev);
 
 	if (!test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
 		goto unlock;
@@ -1261,6 +1267,7 @@ void ipoib_ib_tx_timeout_work(struct work_struct *work)
 
 	netif_tx_wake_all_queues(priv->dev);
 unlock:
+	netdev_unlock_ops(priv->dev);
 	rtnl_unlock();
 
 }
@@ -2404,10 +2411,10 @@ static void set_base_guid(struct ipoib_dev_priv *priv, union ib_gid *gid)
 	netif_addr_unlock_bh(netdev);
 
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
-		netdev_lock(priv->dev);
+		netdev_lock_ops_to_full(priv->dev);
 		list_for_each_entry(child_priv, &priv->child_intfs, list)
 			set_base_guid(child_priv, gid);
-		netdev_unlock(priv->dev);
+		netdev_unlock_full_to_ops(priv->dev);
 	}
 }
 
@@ -2450,10 +2457,10 @@ static int ipoib_set_mac(struct net_device *dev, void *addr)
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
 		struct ipoib_dev_priv *cpriv;
 
-		netdev_lock(dev);
+		netdev_lock_ops_to_full(dev);
 		list_for_each_entry(cpriv, &priv->child_intfs, list)
 			queue_work(ipoib_workqueue, &cpriv->flush_light);
-		netdev_unlock(dev);
+		netdev_unlock_full_to_ops(dev);
 	}
 	queue_work(ipoib_workqueue, &priv->flush_light);
 
-- 
2.31.1


