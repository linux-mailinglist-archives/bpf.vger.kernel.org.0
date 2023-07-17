Return-Path: <bpf+bounces-5092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADF75666C
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E555D281241
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3985BE62;
	Mon, 17 Jul 2023 14:31:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D5C142;
	Mon, 17 Jul 2023 14:31:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B777C10D8;
	Mon, 17 Jul 2023 07:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6IGdTxa9k+wSz30PGkI7ZBGHKTVQACykVWh0d1BAKPrQgaRRDQ7OrhofLLpvTy1M64vY9ZXmWGkC4v1QGgwnVKL0l5DOcN0/ZFQ/beHtZ4ul8DszNH6trj694YwJPkljMpKd58KFh1SlAkCUiKclJJwfZ1w0V9lmBD6hW2RHNVsYKFEHBQlrHd89+RX1EB5XRETOr3spo9/cYdjUgAVjHE1yIi+K61oMH+WWYri/kdZqSthdGAbrZDYS7SqYZGIJFNaaak4cBXwSK7k3UZCRnWRDjZU/7Q9Q3Vrv2kl4QQV0/9+2QV9L+pn9c9GJzWdHIVdFxxQD7KZiFPOnzhlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpY16pSmomnFEYpXTws0UaY23QjCR2HG+iPfMc2Mitk=;
 b=lmaMgTEr2DxCw7JpV3t1WatyVff7Pt2/kf5GHbUzd8qwWRR6ockHYVrwsUPbQm7mCosWcmc0lSRdSd9jiyDjrnbv4NwHG1KNY0e5qs4BSuuE9Ab3PLIwYlYyjkoHpex1Msavh2v5ki0ybyRNj3Z1jV+LebA5RpSu8bFh3m/NegbRTfRx5RdWFN34/IZxgLlDIftj9zucYzIV6ppHpZYQV/oxrYGX25rkZybwj90jYub43RZ/ENUQGuW1Jj48v1zMhDaNoYI4KFMluU3J+VebxQiiHRaHslbk3SKW/G3H2f3CMVaz29ioJ2PJqvPYeGx8q3w1dej+aTGFPEXeGfRWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpY16pSmomnFEYpXTws0UaY23QjCR2HG+iPfMc2Mitk=;
 b=jx5xTrRY/50/Ml+qy99qRUeKpx2fhuWsDsOi7xsXQ7iRxPa0cNNh1YGGvA7QRyaXMKifyp9E3221bp36u1txsKP2mOLCVDpag2u60RBT8wXdtxNVFv601vxCi+zUe4EL/2OIh4UBZU/ojl3XaypV4GDpmS07MM8hEwkP0jbYAcIPKyIFkY9Kj+n3y68DgnXj2LxUX2aUv63KkVqsW0+YW53XHaJD3WpImdJ0N0N+TrIgjBZwXBuc4UZsrtTjKnDgutVTuMybY5e+Nrh86GwiCAxdOw4i4sXWOa5WU6Ky6Pnx3jd1qBPMOApkOw/wjsoSu6e6ml48+YcJ/MVELSddXQ==
Received: from BN9PR03CA0582.namprd03.prod.outlook.com (2603:10b6:408:10d::17)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 14:31:30 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::c2) by BN9PR03CA0582.outlook.office365.com
 (2603:10b6:408:10d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 14:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 14:31:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 07:31:14 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Jul
 2023 07:31:09 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V2 1/4] virtio_net: extract interrupt coalescing settings to a structure
Date: Mon, 17 Jul 2023 17:30:34 +0300
Message-ID: <20230717143037.21858-2-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717143037.21858-1-gavinl@nvidia.com>
References: <20230717143037.21858-1-gavinl@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: c8df80be-fe64-4b85-0a8e-08db86d2835c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O4eXk4gpaPcKwpMhHaAgGFWry7oljrCimS3uiX0Wy4z95HRHP4+/2S/OYZln0HZKOwK2RmUaxJS1Xn7B13TIdDT6Mdsf4ZywGl3z5wqj7IJcpEJrzEcXOlPfqVFu2C+xMFu49pkvR9gfUoBVvx4R0T0NYsCu+J0z6pT3vxgXFHLa/rubBzj8SBemhaG2KiVeDrplAfe+DX/A9Nc1K5uWc7TGGSSGCb1s0W4t5fgBysUHoV1wY0I9h6avAxPNcCpo8lzC/JzGb26svHZ//ROAictlvC2YHbwnD3+iZ4Eh9Xr3ZCC2Bgi8gSfUEmdew1sDvcf1bLD/X1FPP/isc44Ec6IhHm3blbzJLEttCKri+W6JXEemSDWl4GCbgUaGpof5XOJ3JTGWBCs+iof16BeZnhlVYvTy2E0uzplJg7N9GWtDfM4mdqKJXNr6fOMnth8MX+IZ9T0+hn6hnMewfc+OUJvFzqfSC2j1VLarsTVmu7uQsoubxBFA3wfgdzJjSelUMOaGo00CoXGbTawU29jtDqhbLwmGnmSiphFLooTB1HmNAzfqo1lR39XYTuPjuzz4QU0opVp1uwWur2+S0bwHlyMR6SRpHJ91+KZnmUzum88gk4EnU9bChT6EEN9HDk86yWgYmjA8ieAB/5q3q3SNFP7x4V+PHlnka2BhD2LsgmiJ+yZ7XdVGi2qcTUa9k09orQUxmbWSzBy2/ESBSFwBw3XSjAZt539WkBj2PiUk00Vt2ddy7nmv4s3gnKW+Te/8WSdUx5v4OE0lZ6QSQWD3fYpscsRFlRxOWsGrENlItqbNq4vmkzPjl03wec4rQHLT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(86362001)(2906002)(36756003)(7416002)(40460700003)(55016003)(40480700001)(47076005)(83380400001)(16526019)(6286002)(426003)(336012)(186003)(36860700001)(1076003)(26005)(82740400003)(7636003)(356005)(921005)(7696005)(54906003)(110136005)(6636002)(70206006)(4326008)(316002)(70586007)(8676002)(478600001)(6666004)(5660300002)(8936002)(2616005)(41300700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:31:30.6283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8df80be-fe64-4b85-0a8e-08db86d2835c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extract interrupt coalescing settings to a structure so that it could be
reused in other data structures.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0db14f6b87d3..dd5fec073a27 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -126,6 +126,11 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
+struct virtnet_interrupt_coalesce {
+	u32 max_packets;
+	u32 max_usecs;
+};
+
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -281,10 +286,8 @@ struct virtnet_info {
 	u32 speed;
 
 	/* Interrupt coalescing settings */
-	u32 tx_usecs;
-	u32 rx_usecs;
-	u32 tx_max_packets;
-	u32 rx_max_packets;
+	struct virtnet_interrupt_coalesce intr_coal_tx;
+	struct virtnet_interrupt_coalesce intr_coal_rx;
 
 	unsigned long guest_offloads;
 	unsigned long guest_offloads_capable;
@@ -3056,8 +3059,8 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 		return -EINVAL;
 
 	/* Save parameters */
-	vi->tx_usecs = ec->tx_coalesce_usecs;
-	vi->tx_max_packets = ec->tx_max_coalesced_frames;
+	vi->intr_coal_tx.max_usecs = ec->tx_coalesce_usecs;
+	vi->intr_coal_tx.max_packets = ec->tx_max_coalesced_frames;
 
 	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
 	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
@@ -3069,8 +3072,8 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 		return -EINVAL;
 
 	/* Save parameters */
-	vi->rx_usecs = ec->rx_coalesce_usecs;
-	vi->rx_max_packets = ec->rx_max_coalesced_frames;
+	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
+	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
 
 	return 0;
 }
@@ -3132,10 +3135,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
-		ec->rx_coalesce_usecs = vi->rx_usecs;
-		ec->tx_coalesce_usecs = vi->tx_usecs;
-		ec->tx_max_coalesced_frames = vi->tx_max_packets;
-		ec->rx_max_coalesced_frames = vi->rx_max_packets;
+		ec->rx_coalesce_usecs = vi->intr_coal_rx.max_usecs;
+		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
+		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
+		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -4119,10 +4122,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
-		vi->rx_usecs = 0;
-		vi->tx_usecs = 0;
-		vi->tx_max_packets = 0;
-		vi->rx_max_packets = 0;
+		vi->intr_coal_rx.max_usecs = 0;
+		vi->intr_coal_tx.max_usecs = 0;
+		vi->intr_coal_tx.max_packets = 0;
+		vi->intr_coal_rx.max_packets = 0;
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
-- 
2.39.1


