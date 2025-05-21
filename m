Return-Path: <bpf+bounces-58650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A46ABF3CD
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D043AA6EF
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380732673BF;
	Wed, 21 May 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TkAKFNof"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1909266B52;
	Wed, 21 May 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829410; cv=fail; b=bci29b5D6d+MO+4u2BXhB69FBoB6BmoOHJBKh/T9sRqzena1CDq4A1uETDMUjbLf/5IlG4PY0ypqsLnKk0NuQoyKruB+NfcgCkVuTRlpE51S+fQ8ITTmjniM0Z1qpIOXc3d/3sy7b7doxB18AY55Kd3JYSG1EFWW1TusBbNhecE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829410; c=relaxed/simple;
	bh=QVqreS1FNKdfu6T7MdeuqPiZ+J5zBOXCyXF7On580WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujhW1KN1l1XNJM3Kq6IiGUHtlkbQNZn9jEgHCenaK5goMyPos3wHCQuwm5vCQr+Lku8XjO0EzKR6eCRkv2r/uUzxdq+KQFqNZyh5BG/1MatIeu2qjojmCy397nvPkpidQKwFkcxA0eesE80U3W9DFXmRGsNLB1kuNxFG7VwB3IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TkAKFNof; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdN2AHAYhvkRU9BjXe6AQ23yW+DBYIhNE8Yy0TiX3DnvYB/Dt+QQNZIBfXJFxYR13RM3LlAZRFVVugJDPnBh+AxPi19HdESNhTCXauUfRt53+2eK1tIz5FKGV7m4Pnik+pe/mPgjWgYgBHW8947qIrVpJmDMQCW/8yv7QiUObuGSxWnIU0vxw8imA8Y6vLXaKYgkHNYoH/veOMEsdPgRPh4bquje2V+LCzp3ClHYD58LW8wF7k9kCz8ByAUFPf8deX61Vdc0tB23AArmdlfDESNNJXWP7uEvjXx/pBK+Lobs+VzdkHNBRb78TkcMQhVHHpDTyA5lAkMSGL4/1ke+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWg5oYYazKWzDrDncvIh9ophWw/l7xzZQnXZDpTmuN4=;
 b=giAv6efKGI19aDBhWUNCWHOlMmDSklESlrhTlloSjjlsfObQUYC8XSxBnHxvTaGM8cpkfs/tlhWSyzDq4OXaorLv5AMdeXK9K1fp+EG+RU4FZ4c2Iiyhd5QUzWukx12Xenu8h5LNvKttEWUBc5+3TM1A5EJuGg0ufwblhEMnsRQnHCe/sdroc1PtEQo+KG0JZ6nznpwxa6kutVmy0jD1IByLAkrOJzRuZ4zHR04ZHGgyPhm6ONsBYSCnsOPgMnakQtsbizq5RxYgZ1qxkrD36ZK+K3xwMbUzcVlz5SbkHVY9c6NATaAYmeRQ5WV39YsRAypRC1KrsH9wONFEAqucaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWg5oYYazKWzDrDncvIh9ophWw/l7xzZQnXZDpTmuN4=;
 b=TkAKFNofyzoxZLsn7wd+SAq0kRCLMTYcnmqO99I0wAjD8WxiER/ZzL0o3XgSVRQeNLNr2jSDdS1ZDOxpo6uqt+dpMd7FJvTI7Sw8S5za1xDOegDtvyIJg1cHC4/X9HhEXkOdOeR/FVlSU/iKN2marOQUob10uJL8w4ADiceYpqXL9AGmLUL9vyJ2x1yGnSs85tmNshD/HDtzTpzfQUZZKtf0SlBc7a3GA7BolvOa7q+uBLbCXqf80xaHyN23v0OwnPprsisuPyCv8Hs+SR4XMmaujpYq3AAnmk0iOvK8H2GsPDM9YildaYWMfiVvAeePlk9mF6nuOQiZOUXhEJXN9Q==
Received: from MW4PR03CA0314.namprd03.prod.outlook.com (2603:10b6:303:dd::19)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 12:10:03 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::e5) by MW4PR03CA0314.outlook.office365.com
 (2603:10b6:303:dd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Wed,
 21 May 2025 12:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:10:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 05:09:50 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 05:09:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 21
 May 2025 05:09:44 -0700
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
Subject: [PATCH net-next 1/5] IB/IPoIB: Enqueue separate work_structs for each flushed interface
Date: Wed, 21 May 2025 15:08:58 +0300
Message-ID: <1747829342-1018757-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 9585f803-1830-41e0-b2f9-08dd98606abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16HOwt32GqYSwkd4/0lkdSoAwJI1vav07jWd8qz0oXgBjPwm/E5bYi/hdATE?=
 =?us-ascii?Q?FIHGQTEEkbuDUpJUA1quq4/dJld1XI8EwUjoEhG/TwlZ/5cQlodYrj9V/9Np?=
 =?us-ascii?Q?hACSReEx9KLRrwxTM9jrtRGbrbgE0rvui2iHkSwbCpXLLDhaeAohf5Aq5o9k?=
 =?us-ascii?Q?tO8a6SlVJMQxz4oE6RnWSDXil/zmC0ZQJM2MA+ErZCNujoNAX1bTqDQu98Jd?=
 =?us-ascii?Q?uzzrqc20k6l7p5X07OElnrTCF5nm0sD+oB5e9YQLpvmfTLHu7QXF2vf+/eDH?=
 =?us-ascii?Q?OTxFOJUfoseyUNYX2aRnpqLD8Df61s/AwTQfSmYWNMEgnWDUXbwM8gicoZhN?=
 =?us-ascii?Q?M3GCTZtXl8vg7Cq56aqE3foaBX246gyIHsCX5+tCLinH/LbYZ6KwEvM7o5OT?=
 =?us-ascii?Q?JZdxKt7+3khPTtE2+yaZsYJEfenQHo3556cybQ8qfjzn7QeFQGAmpoCzyvP2?=
 =?us-ascii?Q?I0JwjuNocov0MLWM3Yk1iJYCfMLANJbQEg6Eh/+4CR/6jzZaqmsqH4fwW4HR?=
 =?us-ascii?Q?k9uX86qqoA1NcsZdMPmCYi37ZKjEyVeCafoXIAsZbJi6xarVu1TqcQHivRQY?=
 =?us-ascii?Q?tl7nJBDeuUARCgVXZehLdplAlTsmq0Xq3TFv0eE6Ny2dXWYSaYr58gaYoQx2?=
 =?us-ascii?Q?sS9WutNE6dYau49gCdhUV68pZ/5D7XAclLIojUZnwP9xDugpfw7DPv9sIhY6?=
 =?us-ascii?Q?yQ5XB+5jKwJQaTYNa4MEXC76mGpNIfsoodDxYlk9Ws0VgXZ5U98E6+9OsE2b?=
 =?us-ascii?Q?ji/zl0eHx5vrm/1Hf1IKIVUwLUQC3kPUOlLFVBfsJ1mRL/Ujoj/SzxnItXfQ?=
 =?us-ascii?Q?y1t8P+lxYig+/Y7pymmTvJoN30y3cuxJjtN7xNJ27bE5WxYD1eYdoibYH75W?=
 =?us-ascii?Q?v8T93BXZmOQ9MhEV0UAcGB201jitmQ8Lz5z8VnHS7lOThu7CG/YGYwxmRy/k?=
 =?us-ascii?Q?twjKHDCqDLChPlEbbTWlRAsGBY5xjMfb3LPL3SpxZjDmOJ2PfWfW7bvYrmou?=
 =?us-ascii?Q?MZJqvx9ArHgiicBL9Ux5vs9eKH6BQYn2eekk+1uUrNEPLmGGhlNkFFTLL+kI?=
 =?us-ascii?Q?M0dqpyq0cftHUNjWRrm6qUC+V0YgPdGhlY1K534HkTwNhr3Crv20er8iAmnz?=
 =?us-ascii?Q?ZweSWqWmZLJJ5/bLuNWHWS1I1DDQ5NAQ3kw8PfR0Rebi0BN3yOadYoDUCcbe?=
 =?us-ascii?Q?Sk5OfEGEFhppCCcIemJ+cnSnyPYWNsdmSqZ+FD8C05Lm0+ZukPNdQcaAjApv?=
 =?us-ascii?Q?lZ3PndWCR4+6fjhAsKSEGti+orummY/7mCG9eLps96//yMqvh+AVkBJWLYEm?=
 =?us-ascii?Q?5LcA7BQzE16fdiuZAcvXI8tuJw2YeZP+p/CxlqNGzpCTNMbHKdTwPHo66Jg1?=
 =?us-ascii?Q?uDeCqNDZj/E89jlqsiAxjyOV3+C7+/MnlaZHCBGSdkk0blRRXz5+BcBHs1oh?=
 =?us-ascii?Q?y70rwFSm3gVbef8ACf3X5VZY1DsJR0ic6V/37G9D3dmbhMDSkbczhMSkFdM0?=
 =?us-ascii?Q?Xnzc4B9LdQ9DLoKEsYXwvK0HfY9wPScp2xlL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:10:03.1252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9585f803-1830-41e0-b2f9-08dd98606abd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, flushing a netdevice involved first flushing all child
devices from the flush task itself. That requires holding the lock that
protects the list for the entire duration of the flush.

This poses a problem when converting from vlan_rwsem to the netdev
instance lock (next patch), because holding the parent lock while
trying to acquire a child lock makes lockdep unhappy, rightfully.

Fix this by splitting a big flush task into individual flush tasks
(all are already created in their respective ipoib_dev_priv structs)
and defining a helper function to enqueue all of them while holding the
list lock.

In ipoib_set_mac, the function is not used and the task is enqueued
directly, because in the subsequent patches locking is changed and this
function may be called with the netdev instance lock held.

This is effectively a noop, the wq is single-threaded and ordered and
will execute the same flush operations in the same order as before.

Furthermore, there should be no new races because
ipoib_parent_unregister_pre() calls flush_workqueue() after stopping new
work generation to wait for pending work to complete. flush_workqueue()
waits for all currently enqueued work to finish before returning.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h       |  2 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c    | 46 ++++++++++++++--------
 drivers/infiniband/ulp/ipoib/ipoib_main.c  | 10 ++++-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c |  8 ++--
 4 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index abe0522b7df4..2e05e9c9317d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -512,6 +512,8 @@ int ipoib_intf_init(struct ib_device *hca, u32 port, const char *format,
 void ipoib_ib_dev_flush_light(struct work_struct *work);
 void ipoib_ib_dev_flush_normal(struct work_struct *work);
 void ipoib_ib_dev_flush_heavy(struct work_struct *work);
+void ipoib_queue_work(struct ipoib_dev_priv *priv,
+		      enum ipoib_flush_level level);
 void ipoib_ib_tx_timeout_work(struct work_struct *work);
 void ipoib_ib_dev_cleanup(struct net_device *dev);
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 5cde275daa94..e0e7f600097d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1172,24 +1172,11 @@ static bool ipoib_dev_addr_changed_valid(struct ipoib_dev_priv *priv)
 }
 
 static void __ipoib_ib_dev_flush(struct ipoib_dev_priv *priv,
-				enum ipoib_flush_level level,
-				int nesting)
+				enum ipoib_flush_level level)
 {
-	struct ipoib_dev_priv *cpriv;
 	struct net_device *dev = priv->dev;
 	int result;
 
-	down_read_nested(&priv->vlan_rwsem, nesting);
-
-	/*
-	 * Flush any child interfaces too -- they might be up even if
-	 * the parent is down.
-	 */
-	list_for_each_entry(cpriv, &priv->child_intfs, list)
-		__ipoib_ib_dev_flush(cpriv, level, nesting + 1);
-
-	up_read(&priv->vlan_rwsem);
-
 	if (!test_bit(IPOIB_FLAG_INITIALIZED, &priv->flags) &&
 	    level != IPOIB_FLUSH_HEAVY) {
 		/* Make sure the dev_addr is set even if not flushing */
@@ -1280,7 +1267,7 @@ void ipoib_ib_dev_flush_light(struct work_struct *work)
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, flush_light);
 
-	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_LIGHT, 0);
+	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_LIGHT);
 }
 
 void ipoib_ib_dev_flush_normal(struct work_struct *work)
@@ -1288,7 +1275,7 @@ void ipoib_ib_dev_flush_normal(struct work_struct *work)
 	struct ipoib_dev_priv *priv =
 		container_of(work, struct ipoib_dev_priv, flush_normal);
 
-	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_NORMAL, 0);
+	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_NORMAL);
 }
 
 void ipoib_ib_dev_flush_heavy(struct work_struct *work)
@@ -1297,10 +1284,35 @@ void ipoib_ib_dev_flush_heavy(struct work_struct *work)
 		container_of(work, struct ipoib_dev_priv, flush_heavy);
 
 	rtnl_lock();
-	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_HEAVY, 0);
+	__ipoib_ib_dev_flush(priv, IPOIB_FLUSH_HEAVY);
 	rtnl_unlock();
 }
 
+void ipoib_queue_work(struct ipoib_dev_priv *priv,
+		      enum ipoib_flush_level level)
+{
+	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
+		struct ipoib_dev_priv *cpriv;
+
+		down_read(&priv->vlan_rwsem);
+		list_for_each_entry(cpriv, &priv->child_intfs, list)
+			ipoib_queue_work(cpriv, level);
+		up_read(&priv->vlan_rwsem);
+	}
+
+	switch (level) {
+	case IPOIB_FLUSH_LIGHT:
+		queue_work(ipoib_workqueue, &priv->flush_light);
+		break;
+	case IPOIB_FLUSH_NORMAL:
+		queue_work(ipoib_workqueue, &priv->flush_normal);
+		break;
+	case IPOIB_FLUSH_HEAVY:
+		queue_work(ipoib_workqueue, &priv->flush_heavy);
+		break;
+	}
+}
+
 void ipoib_ib_dev_cleanup(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 3b463db8ce39..55b1f3cbee17 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2415,6 +2415,14 @@ static int ipoib_set_mac(struct net_device *dev, void *addr)
 
 	set_base_guid(priv, (union ib_gid *)(ss->__data + 4));
 
+	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
+		struct ipoib_dev_priv *cpriv;
+
+		down_read(&priv->vlan_rwsem);
+		list_for_each_entry(cpriv, &priv->child_intfs, list)
+			queue_work(ipoib_workqueue, &cpriv->flush_light);
+		up_read(&priv->vlan_rwsem);
+	}
 	queue_work(ipoib_workqueue, &priv->flush_light);
 
 	return 0;
@@ -2526,7 +2534,7 @@ static struct net_device *ipoib_add_port(const char *format,
 	ib_register_event_handler(&priv->event_handler);
 
 	/* call event handler to ensure pkey in sync */
-	queue_work(ipoib_workqueue, &priv->flush_heavy);
+	ipoib_queue_work(priv, IPOIB_FLUSH_HEAVY);
 
 	ndev->rtnl_link_ops = ipoib_get_link_ops();
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 368e5d77416d..86983080d28b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -280,15 +280,15 @@ void ipoib_event(struct ib_event_handler *handler,
 		  dev_name(&record->device->dev), record->element.port_num);
 
 	if (record->event == IB_EVENT_CLIENT_REREGISTER) {
-		queue_work(ipoib_workqueue, &priv->flush_light);
+		ipoib_queue_work(priv, IPOIB_FLUSH_LIGHT);
 	} else if (record->event == IB_EVENT_PORT_ERR ||
 		   record->event == IB_EVENT_PORT_ACTIVE ||
 		   record->event == IB_EVENT_LID_CHANGE) {
-		queue_work(ipoib_workqueue, &priv->flush_normal);
+		ipoib_queue_work(priv, IPOIB_FLUSH_NORMAL);
 	} else if (record->event == IB_EVENT_PKEY_CHANGE) {
-		queue_work(ipoib_workqueue, &priv->flush_heavy);
+		ipoib_queue_work(priv, IPOIB_FLUSH_HEAVY);
 	} else if (record->event == IB_EVENT_GID_CHANGE &&
 		   !test_bit(IPOIB_FLAG_DEV_ADDR_SET, &priv->flags)) {
-		queue_work(ipoib_workqueue, &priv->flush_light);
+		ipoib_queue_work(priv, IPOIB_FLUSH_LIGHT);
 	}
 }
-- 
2.31.1


