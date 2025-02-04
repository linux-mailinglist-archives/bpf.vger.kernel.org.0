Return-Path: <bpf+bounces-50404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4747EA26FE7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF50216016E
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0620CCFD;
	Tue,  4 Feb 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FP5s8BTv"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A420C015;
	Tue,  4 Feb 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667250; cv=fail; b=N42HVA2NqKDxuZNPf0vG/S0LLVevN+vV3oHiKQ4j9PwKzHKNB9WC/B0PPhlPji0tnE475PUK7/pwSmwfDxyazU8ebWEHbm3ohYLQJuuLmvegMft0peMixmdQQ5egqGHPFENYDYRZtbffx1J7Lp1dwGqm1MgNJEOgruXGjbQvXYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667250; c=relaxed/simple;
	bh=E8uBKIgSpEs1jyNf808uOyLMa4QtcAqRfyysf8ih4hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esjAViHfUrCG2LcEGu+NfiLkk5QJacWKkuBGwlUnDjbFOEXRY0jhEt2r1u5ewHryNiXnx7cmpicudgo2Fiph5GaB9CpkGxX0xDJ2mMQ0RPwgewHG6PDKIgAzzlYo/8WeOZacdKH/X8utXUcDptSRUQnHroaBY4DDRvEwEEdrdaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FP5s8BTv; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aALU/Ike7FfRTtaXGw2Eo73dphLxKyVeTLrFD/zS3S+OScTsw9j3ZfH2ki8evq4sPtIOPCyPh8s9UhSmWBQBc8Z8AcrX1zgryIkUZ+CgUB2OJ7RduOoQBkuOmZkxftvABMccx+LVIxfoGxrzBasmUpcZIFFFx28RH7eEA7C9DUBZtaFIZDBoGN4MrnCJpFDTYin6SYanZjOQT2s4VoXZliw2D0emEceNWfP/ILZ1UdBV5Ek24UdUJeqFKRL704DgBgxR5xTc0f3nICqRXhJNR6+sWpub9i8b53Uta18gyvC5qvb4z4PY+p+ChRmDDACV0YjcQg4qMyQohkcSvSqM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XObqEn4BKNXRbus8YAorW1YINyPcRh9LpbJzVu8eFZk=;
 b=Dxw4l+KmFCUFYOC5AIBF8nwPtQc2T1ULYx3efMN2oYQ9dxVxUYGpet0d7Wnbn1RJZZHtPEeR6mw8fzKotbc25tnoEgr/3B0TAesodTmdnWWeolItGL5MqpRLEtGInUUOW23ZZjZyWQnEqv1HjG3tvaxqy2a+iTMoU+CelmF8LnIKV4TFNgNQNDYsPMKeshvQ4ErG/CXIcUDWqRbok1MyK4yZa7Sagc7XlflWIsUybWXlUzJsm6paDraR5n05gwNCYamXGLgi9lT3w7rZAb4gQ5blRqxdMECU0WI66Pz4Dl4o+MkhnpjtGS6P/s7xRjSE4etSitbgdz4nuh9BkqC0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XObqEn4BKNXRbus8YAorW1YINyPcRh9LpbJzVu8eFZk=;
 b=FP5s8BTvuZn7a1jIlniT1C9l+CQexNWGr7+fK0LLFE1sOCHl2wkLn2JMizPQhu0Fau2opmV7a3lPYuFRgRnOPP2c/VDAr6DIWE63RFSlKMRaXxX+VaNgFsBkW0t8awk/f0267co1zxpne+G+LGEijGYTJw+hvyUTyKgCsywavMkvxQjd7kSl/lb/6982TN8dpeBqvQ6UHjnHv+d9rEw1FHU8wLh0yaWTAP0qnSzWypI2IUAeHDnXTyYf+g8HsR19z3xd3+/tF/KwVw0ZzHV3LVgKrn4OkOwo0g+19TUNxlZb1RdtesR0KfWhakQTepThAPHMzYPTnAwsgeLgiar+LA==
Received: from CH2PR17CA0014.namprd17.prod.outlook.com (2603:10b6:610:53::24)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 11:07:24 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::51) by CH2PR17CA0014.outlook.office365.com
 (2603:10b6:610:53::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 11:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 11:07:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 03:07:13 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 03:07:06 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 09/12] mlxsw: pci: Initialize XDP Rx queue info per RDQ
Date: Tue, 4 Feb 2025 12:05:04 +0100
Message-ID: <56b84bd23f1745fad0547b62e0da17b656fd3f4c.1738665783.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738665783.git.petrm@nvidia.com>
References: <cover.1738665783.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b62449-a42d-4335-ba0d-08dd450c1a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnjKjkM/CPcERhJWA2tPiuN92Tdiy6E+aqONmA/pYaIv4snsgh2GZTMwkHLk?=
 =?us-ascii?Q?2KmSk0Y+SJl8HfQXnEa3SblFTruQgqww0uL/m35G0iWQ1r9DotZKDV7sfih9?=
 =?us-ascii?Q?YGnj18sYi1LrzzwUbQlV7N7GZgCj69g1JdgS2WGSuxjhTuI3+TlAN3AHORrH?=
 =?us-ascii?Q?tH4Htog8u5TMgKAjKSKLbV8RpZOpOQ4YLbImOihwMioWeuHEYZoferYma7pI?=
 =?us-ascii?Q?Sov75dMvjzK/CIix9TNP4oMZGYv0l+v0wBFc4R9B9WNxvSa+vVwvdOahPuHs?=
 =?us-ascii?Q?ixl7AHKMPJdCW03LQNugAupaURY/5WfVbH5ZpyVZnx6ydLTLqbtugLpr3Ftl?=
 =?us-ascii?Q?Vq42HveUl2IfTeL44M9IUlb9xSTI+t4ctFygyUqmMBuo9mi9kR4C9FogIvd2?=
 =?us-ascii?Q?MRwe7eyoKOUX2oI4sH1VbVinjV3iH56kKs3C0HenpLbssQJoSAMIQJdg1F8o?=
 =?us-ascii?Q?3NypIpMDm0VBCQ2+ECxACpUOQeYqMUD8L3drnOl2qZFLDfDpjomG1IFDmkMp?=
 =?us-ascii?Q?AQDA1qwAUsrkQ6K1PaOg6gRVtE0hcG6UDbSqKLHXsInn4Zv1glxW6FYU8tXv?=
 =?us-ascii?Q?CExfETgUbnoSrYgSPIjHdqPDmMdVOUM3jU9u3Fu+O0K4YOK7AnyzoOGTo/8G?=
 =?us-ascii?Q?fOOWRygax6TqpFuD+TXZm4SQAlLwXC8RoW49HVGryAggi+aE3kvosFKqgKKN?=
 =?us-ascii?Q?I/HNkLpcqCr12aEjuFp6qxiihWCWQsy1xHtCu2EGpEaZ4X2CNd+DQB70h507?=
 =?us-ascii?Q?uTu6/oxrW1lfR58/M5T+grT2LebE/iwctqO74yvq48cudNUaiQWIyskxFSPJ?=
 =?us-ascii?Q?gZCe/fh/uEtZDsxRIuGLm22Wwc/t6Xb3FR3s9uGRZc1v86UOcpkN/4hvgo1j?=
 =?us-ascii?Q?kzC72U/qeBTAeGssdhFCVfODPHTSqgViqnHor7n5hhGJcXhUFQoFCirvAUCr?=
 =?us-ascii?Q?pPwe9eKA2pbUk06KqBay6GXO2hPsSn5da55EhGluOVM1kgpOlYef8uFtOpkM?=
 =?us-ascii?Q?ZenR7MGkLUQJhDGV0pLt/9Ny25mOZwT+waoHi93y595sxOnB91PPMZP4u7zu?=
 =?us-ascii?Q?feE8wKhqtDJ8EGDYft2KUJ74SrN7C3Gb8q3ZSKt5sEeNZkrmT5nuMjBPaO0E?=
 =?us-ascii?Q?Yd3gPBtW9r8ulc3q74ABfUfosdv0vYN6Tnl6hz/HEy+7YianPJdUAo7rynXC?=
 =?us-ascii?Q?dHNHzlhEvydOEv/Ny2eXlZtApGo7tcASq+rFEXtHEiqvad5h9aUvyHOHLLvq?=
 =?us-ascii?Q?j2IxVT4bfbTVj27bbLCR+HmFTkROv0idoeewzXtlI3G1ETRqK7P7SAL14/Hl?=
 =?us-ascii?Q?ASvVmr6maLAWbbKmyp/eDIykBYSvVqjtBWWymqYnw4FfbnjE7aTzTL9pzHYs?=
 =?us-ascii?Q?QgqIae1f7jazop5/XyqeUazTzTPHutiEqJ4m+OHwiDlpDXAFXIZVdRduiQ7n?=
 =?us-ascii?Q?SdlWX/L6F5pJ2Yb7o8P0xAwqUsfGjM8fQM94Nv7HoOMW++JOsM11sGdv8PKv?=
 =?us-ascii?Q?fOxTl68O2awfU+8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:07:24.3359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b62449-a42d-4335-ba0d-08dd450c1a9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141

From: Amit Cohen <amcohen@nvidia.com>

In preparation for XDP support, register an Rx queue info structure for
each receive queue.

Each Rx queue is used by multiple net devices so pass a dummy net device
(unregistered, 0 ifindex) as the device.

Pass a queue index of 0 since the net devices are registered by the
driver as single queue.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index bd6c772a3384..b102be38d29d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -14,6 +14,7 @@
 #include <linux/log2.h>
 #include <linux/string.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #include "pci_hw.h"
 #include "pci.h"
@@ -93,6 +94,7 @@ struct mlxsw_pci_queue {
 		} eq;
 		struct {
 			struct mlxsw_pci_queue *cq;
+			struct xdp_rxq_info xdp_rxq;
 		} rdq;
 	} u;
 };
@@ -624,6 +626,11 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	cq->u.cq.dq = q;
 	q->u.rdq.cq = cq;
 
+	err = __xdp_rxq_info_reg(&q->u.rdq.xdp_rxq, mlxsw_pci->napi_dev_rx, 0,
+				 cq->u.cq.napi.napi_id, PAGE_SIZE);
+	if (err)
+		goto err_xdp_rxq_info_reg;
+
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 
 	for (i = 0; i < q->count; i++) {
@@ -633,7 +640,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		for (j = 0; j < mlxsw_pci->num_sg_entries; j++) {
 			err = mlxsw_pci_rdq_page_alloc(q, elem_info, j);
 			if (err)
-				goto rollback;
+				goto err_rdq_page_alloc;
 		}
 		/* Everything is set up, ring doorbell to pass elem to HW */
 		q->producer_counter++;
@@ -642,13 +649,15 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 
 	return 0;
 
-rollback:
+err_rdq_page_alloc:
 	for (i--; i >= 0; i--) {
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
 		for (j--; j >= 0; j--)
 			mlxsw_pci_rdq_page_free(q, elem_info, j);
 		j = mlxsw_pci->num_sg_entries;
 	}
+	xdp_rxq_info_unreg(&q->u.rdq.xdp_rxq);
+err_xdp_rxq_info_reg:
 	q->u.rdq.cq = NULL;
 	cq->u.cq.dq = NULL;
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
@@ -663,6 +672,7 @@ static void mlxsw_pci_rdq_fini(struct mlxsw_pci *mlxsw_pci,
 	int i, j;
 
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
+	xdp_rxq_info_unreg(&q->u.rdq.xdp_rxq);
 	for (i = 0; i < q->count; i++) {
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
 		for (j = 0; j < mlxsw_pci->num_sg_entries; j++)
-- 
2.47.0


