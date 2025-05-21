Return-Path: <bpf+bounces-58651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4458ABF3D2
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E3D4E41E3
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAF267B1F;
	Wed, 21 May 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VyOj3JUH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6D265CB0;
	Wed, 21 May 2025 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829422; cv=fail; b=pPzQSh5GICZ8hecwH8sF4tacWxM1Q5jZssDjRn2YU77Y9kC9el7DHB5AC0q2yIx5N+YrpcCGfPXFz5BEXG6R5sF/3Z3+UgJ0CRbj5sTG4j+y+Q5yoWGUtsWB2bAjJxIPBDpaL9R2B5jcypqzXmr54WKCXt77RyHgIXbVk9GQ8G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829422; c=relaxed/simple;
	bh=kisSevErLWTYF6ab9499ZV4KUTrd2ZADH7xbxnr3CKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCTkJJDv+OmkLje3Zi4wD9wUow4LWRfb1dmKV2IZZBF7cDW4ZK7KpSx0nv8+5Kf+DoLECqE72FmTrN+B55pgQSPwJUQF4z+d4Uu7VJyrB5noaRMwgWtsQfR02G/UDQm4802Rse7iRaYCU2/ffRa7hC5Ze+V6l4mNXSwhCLMT3/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VyOj3JUH; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHuxGJJUFrZLYDAHbmX7rYEWHPYMICkRbVXTmG+ItJ9BATSr+yMYq4N5jLU33lI3ueIya4BVHaboeybcb8WbYNMaiL0rA+TL136PfPTGsBfraLxlO+tcccKcQaQ6Rz7CZp1Qi8itQN8FY4i+yQqrmE+QMyFEWxa+ecCz2ZY/HJO7lP3wfPQzCbihYiUf3yyIQqAle9eBojphy813KiK6H8AzgUQ827myfgS8mf6MlWdCgJ48C3QhD/PWlzmLurcEWEQjXRWesdXNE44ndUzzA+TzoJlGreFvmg2JPL0ZLfh98UR3GBTAjmLFwfuE6i4eeOZwZBzrAxxliorG3eA5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItESPl4gXUfxTF91Eln4pdw2pxtL1M4mEHH35cbcqW8=;
 b=iljPp/NexDk4I04crGK9EGXG2Rpq2LDUL0TZ0fgTj/MRiVHcqlq2HmPszrmwqxSI3lQWNZoSSx8qmdRt6P33+Bzw71TZ6V2wOcIXFepVGJsMBZtmtbdXc9d6/0Hs151GlyehFYdMjjIC2lGDtqTj1BvTbLoekxHxCZwCVUQ2xfkEXFVIRCdgvYvtZNwU1rxkhoovqkQKr0bW8Bf/4qhHTee0amfdAVhRoFCjYOrhj3YnpckEjHwrqZwgtJaaKbltlrkh1zgGLVaCixwdJNxyi+fgOsuy8AFayR79Wr3wrYqdJSDiQdMoGjEkL4NmxOUo9e5UJvQd3ny22B1sbZaB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItESPl4gXUfxTF91Eln4pdw2pxtL1M4mEHH35cbcqW8=;
 b=VyOj3JUHLLTVg0iBNoc/aKcKM1GZTv+qTaeY1Uz3ncL7gfSIUPDT4+2ORLf98DKbQO051Eyi8JYE4GVY/8DB+Gk6gtk5fgWXB7936c7ss1YGgleUhZ0k/PLFRg4U6SkSkfWsHIHgzsz7WFFBdsfCOME4BUEYVZBL/i4hkivVYXe2garFU8imaeZJ4IZQmVxsfZ8vtfSZQqyrBPvNzUuooglmWY+uTxAN5CHneTMIUEobU3wxRnZUYBm/KEBQ8IQ6B2u+ZGblLh11u0z0yLiyqec3/fj36rgryt71IlwkaikxWYEBS4hcL8IQRG7b45zeogStXc0tjFYShqYrOgHUbQ==
Received: from SN6PR04CA0094.namprd04.prod.outlook.com (2603:10b6:805:f2::35)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 12:10:14 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::6f) by SN6PR04CA0094.outlook.office365.com
 (2603:10b6:805:f2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 21 May 2025 12:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:10:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 05:09:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 05:09:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 05:09:50 -0700
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
Subject: [PATCH net-next 2/5] IB/IPoIB: Replace vlan_rwsem with the netdev instance lock
Date: Wed, 21 May 2025 15:08:59 +0300
Message-ID: <1747829342-1018757-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af59c4e-e122-49b3-9bbc-08dd986070b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2CecPO2o+oW0LRWuPqwHpeRomocU5f4bROeyC82HAnab9e+YBK+oAMc0wol?=
 =?us-ascii?Q?jvSh5hndgbNM+s6YCxGmTwGM5iCMM2OxFMHNplzxZ+2+o4glVwBn4R9wHPDt?=
 =?us-ascii?Q?g5hOB/aEYm26ubgo/89HPoKK98WDuUjKIPPnQ5ynszIo6an7JvRzAZ8MxIkF?=
 =?us-ascii?Q?OgUca8uUF2cGHuuFZwM/aC6S5t7PvUdYsqe3sEMJpL9Cat+2QqATEG3CUQwg?=
 =?us-ascii?Q?wU2BPFbKjmyWcCU+XWLniUAcH8ZzSxxq6ruMrYtA5eQh/0EsA15bMXSL1Qhr?=
 =?us-ascii?Q?ytPIYhk8clVGUw3G3t9iX+q5TOlw/U72UbnNLY+AdbDFW4aKI2pe+BX5EYY+?=
 =?us-ascii?Q?Z9GKAPvm11ixfdsGrSGqJwoq/A/+kn1hUPVVOn3TNdbOegH9TVNS2sVovAOq?=
 =?us-ascii?Q?hUSUShBsNlMS2AVXlJacrk01s7yPH28BcTy8GP0PQQYGF7aY9/6eibmk6YDP?=
 =?us-ascii?Q?3j4G9x1ZNBuES4ShiGTpoxIAFjw0MTVx59HYJnzZxDkoCTVOsVcY8qDjjV94?=
 =?us-ascii?Q?VNrIBhFLRPUpznddgubKmq7pbW1+bTbdwfigbZmJlCFVWzSNkDLLhTSWnWNg?=
 =?us-ascii?Q?0Pkyeh9P2p2n7CxyMHhD6hC1arDJeACQf1+su3dvwUmW4vvvbfgBgT7IH1G7?=
 =?us-ascii?Q?3mipsg9ALJUyPqjwN30tL9jrzPIScuT7/1CkoxXktOlDLQO18zlxTtOT9gHQ?=
 =?us-ascii?Q?OgfXqfjbaCcGH8igjoRDyKde6AdHSKGYtyvlD+duDCsEL6P0NZyc+M8uecHZ?=
 =?us-ascii?Q?wOnG4T/RoiK1+yhfefIqfjkJ7qWBdcpnW7O+EXuELhSxe6Dqnx6Y8unPYOXX?=
 =?us-ascii?Q?2VK2D2P4e7D9FyZfFqgf5ukJflZv+NYAXQOwSpJi7BmjSisebLgJjpXwTZ6L?=
 =?us-ascii?Q?AezhlYOezsb4JwO+jOnlaF+w/ODTX5H0TO3887KCIE8hexJ5fHr4FWmsODFk?=
 =?us-ascii?Q?YWhcV4Xp6oi43BeLBZhDYNK6y89Gyz2H55R1jB+bKAw59GpDZcTHMU7eqqKu?=
 =?us-ascii?Q?xOQvHCS9uzQW9JRmILyM/yRw/RfSQr83Z+yhqvca76ORm+QeANAiGBe5Oq51?=
 =?us-ascii?Q?FaxALKj/SqcYWRGSvp/xHV5+IEp2wq0l/cK6BEMtkgMOXWgTAo+O4BkZZzNO?=
 =?us-ascii?Q?k0o6bcn/UaDR+uXUM69JsAcypJyMozGFxmc/QVjImDzbeF2wPI5GlA9sptKD?=
 =?us-ascii?Q?7bDCubnhS1zbnzJZfYk9ZzdKHDl1fuKtpRp48PNeKEBzbAsPiuZHIHjCMH68?=
 =?us-ascii?Q?8gIlBqkAG6n/k3eopy+LjyJmrcCRmPij2e3boi95p1O/ogS+DAGGgNP/zrvo?=
 =?us-ascii?Q?UCyET6Xh2hbfsi/1OIzkeNUufiDHrj5svlVrbP6Oi0HFUgUhtN6cHi3lNj7H?=
 =?us-ascii?Q?Zp7FNiLv9J42+GbuU8dskxx20mo5x13f73S/U25SeIuZ/BQY7CGQeowIunf/?=
 =?us-ascii?Q?V0cwuQhUSrroP1r8ifm1G25vx7nY9tFQQkajaMN1eLcbhW2FOWY7DZwC7iR8?=
 =?us-ascii?Q?DO1PhOS3ZnQuPRi40dTYYPNJhl7PRHHtwHc8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:10:13.0522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af59c4e-e122-49b3-9bbc-08dd986070b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548

From: Cosmin Ratiu <cratiu@nvidia.com>

vlan_rwsem was added more than a decade ago to work around a deadlock
involving the original mutex being acquired twice, once from the wq.
Subsequent changes then tweaked it to partially protect access to
ipoib_dev_priv->child_intfs together with the RTNL. Flushing the wq
synchronously was also since then refactored to happen separately.

This semaphore unfortunately prevents updating ipoib to work with
devices that require the netdev lock, because of lock ordering issues
between RTNL, vlan_rwsem and the netdev instance locks of parent and
child devices.

To uncomplicate things, this commit replaces vlan_rwsem with the netdev
instance lock of the parent device. Both parent child_intfs list and the
children's list membership in it require holding the parent netdev
instance lock.

All call paths were carefully reviewed and no-longer-needed ASSERT_RTNL
calls were dropped. Some non-trivial changes:
- ipoib_match_gid_pkey_addr() now only acquires the instance lock and
  iterates through child_intfs for the first level of recursion (the
  parent), as it's not possible to have multiple levels of nested
  subinterfaces.
- ipoib_open() and ipoib_stop() schedule tasks on the global workqueue
  to open/stop child interfaces to avoid potentially acquiring nested
  netdev instance locks. To avoid the device going away between the task
  scheduling and execution, netdev_hold/netdev_put are used.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h      |  11 +--
 drivers/infiniband/ulp/ipoib/ipoib_ib.c   |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 110 ++++++++++++++--------
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c |  19 ++--
 4 files changed, 87 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 2e05e9c9317d..91f866e3fb8b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -329,14 +329,6 @@ struct ipoib_dev_priv {
 
 	unsigned long flags;
 
-	/*
-	 * This protects access to the child_intfs list.
-	 * To READ from child_intfs the RTNL or vlan_rwsem read side must be
-	 * held.  To WRITE RTNL and the vlan_rwsem write side must be held (in
-	 * that order) This lock exists because we have a few contexts where
-	 * we need the child_intfs, but do not want to grab the RTNL.
-	 */
-	struct rw_semaphore vlan_rwsem;
 	struct mutex mcast_mutex;
 
 	struct rb_root  path_tree;
@@ -399,6 +391,9 @@ struct ipoib_dev_priv {
 	struct ib_event_handler event_handler;
 
 	struct net_device *parent;
+	/* 'child_intfs' and 'list' membership of all child devices are
+	 * protected by the netdev instance lock of 'dev'.
+	 */
 	struct list_head child_intfs;
 	struct list_head list;
 	int    child_type;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index e0e7f600097d..dc670b4a191b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1294,10 +1294,10 @@ void ipoib_queue_work(struct ipoib_dev_priv *priv,
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
 		struct ipoib_dev_priv *cpriv;
 
-		down_read(&priv->vlan_rwsem);
+		netdev_lock(priv->dev);
 		list_for_each_entry(cpriv, &priv->child_intfs, list)
 			ipoib_queue_work(cpriv, level);
-		up_read(&priv->vlan_rwsem);
+		netdev_unlock(priv->dev);
 	}
 
 	switch (level) {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 55b1f3cbee17..4879fd17e868 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -132,6 +132,52 @@ static int ipoib_netdev_event(struct notifier_block *this,
 }
 #endif
 
+struct ipoib_ifupdown_work {
+	struct work_struct work;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	bool up;
+};
+
+static void ipoib_ifupdown_task(struct work_struct *work)
+{
+	struct ipoib_ifupdown_work *pwork =
+		container_of(work, struct ipoib_ifupdown_work, work);
+	struct net_device *dev = pwork->dev;
+	unsigned int flags;
+
+	rtnl_lock();
+	flags = dev->flags;
+	if (pwork->up)
+		flags |= IFF_UP;
+	else
+		flags &= ~IFF_UP;
+
+	if (dev->flags != flags)
+		dev_change_flags(dev, flags, NULL);
+	rtnl_unlock();
+	netdev_put(dev, &pwork->dev_tracker);
+	kfree(pwork);
+}
+
+static void ipoib_schedule_ifupdown_task(struct net_device *dev, bool up)
+{
+	struct ipoib_ifupdown_work *work;
+
+	if ((up && (dev->flags & IFF_UP)) ||
+	    (!up && !(dev->flags & IFF_UP)))
+		return;
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return;
+	work->dev = dev;
+	netdev_hold(dev, &work->dev_tracker, GFP_KERNEL);
+	work->up = up;
+	INIT_WORK(&work->work, ipoib_ifupdown_task);
+	queue_work(ipoib_workqueue, &work->work);
+}
+
 int ipoib_open(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -154,17 +200,10 @@ int ipoib_open(struct net_device *dev)
 		struct ipoib_dev_priv *cpriv;
 
 		/* Bring up any child interfaces too */
-		down_read(&priv->vlan_rwsem);
-		list_for_each_entry(cpriv, &priv->child_intfs, list) {
-			int flags;
-
-			flags = cpriv->dev->flags;
-			if (flags & IFF_UP)
-				continue;
-
-			dev_change_flags(cpriv->dev, flags | IFF_UP, NULL);
-		}
-		up_read(&priv->vlan_rwsem);
+		netdev_lock(dev);
+		list_for_each_entry(cpriv, &priv->child_intfs, list)
+			ipoib_schedule_ifupdown_task(cpriv->dev, true);
+		netdev_unlock(dev);
 	} else if (priv->parent) {
 		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
@@ -199,17 +238,10 @@ static int ipoib_stop(struct net_device *dev)
 		struct ipoib_dev_priv *cpriv;
 
 		/* Bring down any child interfaces too */
-		down_read(&priv->vlan_rwsem);
-		list_for_each_entry(cpriv, &priv->child_intfs, list) {
-			int flags;
-
-			flags = cpriv->dev->flags;
-			if (!(flags & IFF_UP))
-				continue;
-
-			dev_change_flags(cpriv->dev, flags & ~IFF_UP, NULL);
-		}
-		up_read(&priv->vlan_rwsem);
+		netdev_lock(dev);
+		list_for_each_entry(cpriv, &priv->child_intfs, list)
+			ipoib_schedule_ifupdown_task(cpriv->dev, false);
+		netdev_unlock(dev);
 	}
 
 	return 0;
@@ -426,17 +458,20 @@ static int ipoib_match_gid_pkey_addr(struct ipoib_dev_priv *priv,
 		}
 	}
 
+	if (test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags))
+		return matches;
+
 	/* Check child interfaces */
-	down_read_nested(&priv->vlan_rwsem, nesting);
+	netdev_lock(priv->dev);
 	list_for_each_entry(child_priv, &priv->child_intfs, list) {
 		matches += ipoib_match_gid_pkey_addr(child_priv, gid,
-						    pkey_index, addr,
-						    nesting + 1,
-						    found_net_dev);
+						     pkey_index, addr,
+						     nesting + 1,
+						     found_net_dev);
 		if (matches > 1)
 			break;
 	}
-	up_read(&priv->vlan_rwsem);
+	netdev_unlock(priv->dev);
 
 	return matches;
 }
@@ -1992,9 +2027,9 @@ static int ipoib_ndo_init(struct net_device *ndev)
 
 		dev_hold(priv->parent);
 
-		down_write(&ppriv->vlan_rwsem);
+		netdev_lock(priv->parent);
 		list_add_tail(&priv->list, &ppriv->child_intfs);
-		up_write(&ppriv->vlan_rwsem);
+		netdev_unlock(priv->parent);
 	}
 
 	return 0;
@@ -2004,8 +2039,6 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
-	ASSERT_RTNL();
-
 	/*
 	 * ipoib_remove_one guarantees the children are removed before the
 	 * parent, and that is the only place where a parent can be removed.
@@ -2015,9 +2048,9 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 	if (priv->parent) {
 		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
-		down_write(&ppriv->vlan_rwsem);
+		netdev_lock(ppriv->dev);
 		list_del(&priv->list);
-		up_write(&ppriv->vlan_rwsem);
+		netdev_unlock(ppriv->dev);
 	}
 
 	ipoib_neigh_hash_uninit(dev);
@@ -2167,7 +2200,6 @@ static void ipoib_build_priv(struct net_device *dev)
 
 	priv->dev = dev;
 	spin_lock_init(&priv->lock);
-	init_rwsem(&priv->vlan_rwsem);
 	mutex_init(&priv->mcast_mutex);
 
 	INIT_LIST_HEAD(&priv->path_list);
@@ -2372,10 +2404,10 @@ static void set_base_guid(struct ipoib_dev_priv *priv, union ib_gid *gid)
 	netif_addr_unlock_bh(netdev);
 
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
-		down_read(&priv->vlan_rwsem);
+		netdev_lock(priv->dev);
 		list_for_each_entry(child_priv, &priv->child_intfs, list)
 			set_base_guid(child_priv, gid);
-		up_read(&priv->vlan_rwsem);
+		netdev_unlock(priv->dev);
 	}
 }
 
@@ -2418,10 +2450,10 @@ static int ipoib_set_mac(struct net_device *dev, void *addr)
 	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
 		struct ipoib_dev_priv *cpriv;
 
-		down_read(&priv->vlan_rwsem);
+		netdev_lock(dev);
 		list_for_each_entry(cpriv, &priv->child_intfs, list)
 			queue_work(ipoib_workqueue, &cpriv->flush_light);
-		up_read(&priv->vlan_rwsem);
+		netdev_unlock(dev);
 	}
 	queue_work(ipoib_workqueue, &priv->flush_light);
 
@@ -2632,9 +2664,11 @@ static void ipoib_remove_one(struct ib_device *device, void *client_data)
 
 		rtnl_lock();
 
+		netdev_lock(priv->dev);
 		list_for_each_entry_safe(cpriv, tcpriv, &priv->child_intfs,
 					 list)
 			unregister_netdevice_queue(cpriv->dev, &head);
+		netdev_unlock(priv->dev);
 		unregister_netdevice_queue(priv->dev, &head);
 		unregister_netdevice_many(&head);
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 562df2b3ef18..243e8f555eca 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -53,8 +53,7 @@ static bool is_child_unique(struct ipoib_dev_priv *ppriv,
 			    struct ipoib_dev_priv *priv)
 {
 	struct ipoib_dev_priv *tpriv;
-
-	ASSERT_RTNL();
+	bool result = true;
 
 	/*
 	 * Since the legacy sysfs interface uses pkey for deletion it cannot
@@ -73,13 +72,17 @@ static bool is_child_unique(struct ipoib_dev_priv *ppriv,
 	if (ppriv->pkey == priv->pkey)
 		return false;
 
+	netdev_lock(ppriv->dev);
 	list_for_each_entry(tpriv, &ppriv->child_intfs, list) {
 		if (tpriv->pkey == priv->pkey &&
-		    tpriv->child_type == IPOIB_LEGACY_CHILD)
-			return false;
+		    tpriv->child_type == IPOIB_LEGACY_CHILD) {
+			result = false;
+			break;
+		}
 	}
+	netdev_unlock(ppriv->dev);
 
-	return true;
+	return result;
 }
 
 /*
@@ -98,8 +101,6 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
 	int result;
 	struct rdma_netdev *rn = netdev_priv(ndev);
 
-	ASSERT_RTNL();
-
 	/*
 	 * We do not need to touch priv if register_netdevice fails, so just
 	 * always use this flow.
@@ -267,6 +268,7 @@ int ipoib_vlan_delete(struct net_device *pdev, unsigned short pkey)
 	ppriv = ipoib_priv(pdev);
 
 	rc = -ENODEV;
+	netdev_lock(ppriv->dev);
 	list_for_each_entry_safe(priv, tpriv, &ppriv->child_intfs, list) {
 		if (priv->pkey == pkey &&
 		    priv->child_type == IPOIB_LEGACY_CHILD) {
@@ -278,9 +280,7 @@ int ipoib_vlan_delete(struct net_device *pdev, unsigned short pkey)
 				goto out;
 			}
 
-			down_write(&ppriv->vlan_rwsem);
 			list_del_init(&priv->list);
-			up_write(&ppriv->vlan_rwsem);
 			work->dev = priv->dev;
 			INIT_WORK(&work->work, ipoib_vlan_delete_task);
 			queue_work(ipoib_workqueue, &work->work);
@@ -291,6 +291,7 @@ int ipoib_vlan_delete(struct net_device *pdev, unsigned short pkey)
 	}
 
 out:
+	netdev_unlock(ppriv->dev);
 	rtnl_unlock();
 
 	return rc;
-- 
2.31.1


