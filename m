Return-Path: <bpf+bounces-4585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2974D27E
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BCA1C20A2F
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753710786;
	Mon, 10 Jul 2023 10:00:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE0101CD;
	Mon, 10 Jul 2023 10:00:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C110E9;
	Mon, 10 Jul 2023 02:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foyxsCxppf2+qLH6BmZbq/254iE6FfITeD3V6JP2fyIl6TNQYIaOKtpR3ncROpZmIwr9XHyWKgDHCLXOAuRI5qA/WLUu8BgT6Ww5f0PN9iTuOcS296vZ9v8/x1lndfb+dZLNcP2ud+wa5QJ6NcSZzuPcb0m1FZ6JKGUjAB9+B1nNfTPvEGFtBnTvNEMwKyrpFUpvcYswqJiGCo7/XqaVYdoKeDViwjh6RGsq6W1FUa8af71u7f7kiRkdA1OFDA/MvytPxvD+eb/l9NyQjrEA8/juL61jLlDLT/JPV00jYChL4AsL444VlbtIQ3k6mRNSYd2jWaVxy43boHb5sxhwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T7xFue66UabcZ5Lt5gTbUtfirJ4UZ7HQaMClC0DXU0=;
 b=P0cO2OtSh+pgw9E1i1WVvSAqkHxy/JtnG63uhW9Hc4SNEo7LOriBRBcKcxf2Th8xkbYwY/AIXgdoMi9PWzm/MgBSBeWPR65HCK81bAcBNYY105NJ5OLmGRNRHgCof8fbeDbpeh63WpRgcJYFiJliuizqLgklDWV8fmeAq4Fy142ylDDyR6FIv3iSK9GNSPMLcoah4AKhXYsngRUjWoTFSKThdSjtVjjYkjPQMeqppT6ah+CiE1RTJcYxo5mkqO92qvGSkWh2EbFhVH2o7byYE6uWzKe7MjcitmqvhaCQvylonD1Mg3A7WJ9FuHKn2Aoy9xQk5cnpuKn4PhfI35ts+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T7xFue66UabcZ5Lt5gTbUtfirJ4UZ7HQaMClC0DXU0=;
 b=Nxcbt92/mO0r/G5GeiZAhLL8YXVwDar6Gy5nJ5pPb3cN4HYKnLra63s067D0oNuNpq1YvLtJVXM+dARzBno8BCACR3nfsYpOaD2jRspTwm+l/oJyg6bpVwMa4cXmsfURXSx5K3AoCIIPmys/5yDkA9wsPFYtCFOXRtoiKm7amKKfEd8PXeviuZTiRM7pEV/Sv+KzNyKl6tR/HMWnEAty84RKhe0RdnxNrJcMEntrlRRXVMcPTZ1x4+btdeKZPfY5u4ouwxcBPS7M027U3vlDJ/mhvRRlupCNNpouXght5lbmeRAveb3Jt+afYDydPhYlNqdWvczD21H28bPZxwmPng==
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 09:59:28 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::1d) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 09:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:59:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:59:14 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:59:10 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [RESEND PATCH net-next-mlx5 V1 1/4] virtio_net: extract interrupt coalescing settings to a structure
Date: Mon, 10 Jul 2023 12:58:47 +0300
Message-ID: <20230710095850.2853-2-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710095850.2853-1-gavinl@nvidia.com>
References: <20230710095850.2853-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d29dcdd-7fd4-4cb4-1a01-08db812c597c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RkGvrj61TmfuaJb+oeRsLLRpzml5x8sI5I74uZI5PmjPTlEHA1hkUJ7Vkl+GpQCbiCXfCYgVxnJ1ghBRqpq5dvm0l4RQekD2jBumXkN1CJoe4+VWiTJTmLWVdXzKnLnocyUdp3zKvxQBtBq6r/I6lHvEkXavIyu5nsh8SJB4++eZ+4tAYQsF/yCc5vFUngAlbIegy43FSfqmmX3GGf7XPbKl5PNof7qpYauG4qafwFBnRXP1Mz71ihuInYK9pc1PbuS6UT4XJVG/4vFp+uHuxiMLay5i8e5H1Y69az4G4VazoFhAYiqrlF/ui9kn0yp7okKeOxGphxRz/LfbuIHrH7seyjYWKU817kaSpvrhqIaPQBta2Ko3QbQQjJuVHo3lPqRe8rR0hgCFk3lNolUxqzuKQd7EYwdtDyDkgakyh7iDx/eRodF6vAAo9PgSX1bPQfflWm/72brToPAnrU9yCp3mpqpcNG4si2cfBtS+zWBtJqkBTdzKSRKALhSFLZwvrB27EFy34BfD2Cy0J/87jdv2puwt/0b4Am0nFMFV1ym9RCcq+UFF6Zh+lV33ZH4tSRGr0KHFxLrNSluvjJQwkNVRgOclzqZptY39a7Dk015B7qZjOPC4vwhmYN2ezZo8sOKLeaZugx8VrdXzSLCEWk1l1dyNzqkdvdiTX7qwwwZm9gRl8KyOyM67aJk5NzARu7YrDjkZmcmC/lBRbcBNy4Vq/QUlA3tR9OXkRLi3lsQt0UMnwuo9gAOHYEf9HmF8wst7Do63zD9YdsHe3p9a8U3tKkK/vmUAcabV2fEpGi85vXoYJTnaAS4j+E2zXD8z
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(110136005)(54906003)(36860700001)(47076005)(426003)(336012)(83380400001)(86362001)(40460700003)(36756003)(40480700001)(55016003)(2906002)(70586007)(82310400005)(186003)(2616005)(1076003)(26005)(16526019)(6286002)(82740400003)(921005)(7636003)(356005)(70206006)(4326008)(6636002)(316002)(41300700001)(8676002)(8936002)(7416002)(5660300002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:28.1969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d29dcdd-7fd4-4cb4-1a01-08db812c597c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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


