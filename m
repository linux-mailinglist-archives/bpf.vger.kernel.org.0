Return-Path: <bpf+bounces-5699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CCD75EA2C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 05:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9F1C20983
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 03:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6041865;
	Mon, 24 Jul 2023 03:41:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEC1863;
	Mon, 24 Jul 2023 03:41:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54898E70;
	Sun, 23 Jul 2023 20:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky62tRQML8MpDd6PAaOuo+kit/wO3gK6owVgmFeb88NnZIYBlclqg8wq32sokCeSnkq/eAjQOXlhzYRTTN5cu8XzdHQYoUNzbS1KYN3O06+srgVQzFT4At7lV+4YIHbmBa9/KBzJM2L8vDUrQ2i69QSjlRaOzSt3d6RzdpZJvBUbrtIWri9rTCYHuYdhee1kACVDWv/WsLkTfSzSQ99r2Ycj/K1alnCZkeMBjjCEqHrh8uevWNQ0+jgAiSvRhuTG9SMmkNoV1wGXBLvttS8X2SpO/MGpexDORoUUVaxC6+LwpV3vXZy3szVruik64cOGFOKYGXtKOiirnzBg0Mu/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX5SGpxJxl1oANNUDFL2eDZTz44t12pk7QvPkVGEQSc=;
 b=L49WFVQRq1RXaqxQwdGaMnGa6OFoNmPZHuhDWmjC2CtFNXCqbjqx93gEpm1L3gcev+LyMnFM29QDfF5KNhvCRDW74LLcpzyIYyNcKUVNZjeHKvxsqANPI5u2aRYgh1Zr3ilhgO4M0NI2pj4NawGaonnSNArb1n5ZxUpiVwmmR964aM03ojEOjyIt6zx9/UQLJ1xgFj2E+t66v7F/huAx1H3LpdC8HT2I3hNyLq1i8LCYRGYSZCEvUj1YZvDDiGkdha83IMwiQLhylWPDrfO7fW7z6aAgZNbYUYncVEr/DzwsXKDTm/6jDt3e6MI8crYzMPgBNC2IFcx/QAa0hJHl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX5SGpxJxl1oANNUDFL2eDZTz44t12pk7QvPkVGEQSc=;
 b=UmUdIMOhdTEC53JjouB815flmihCuP0xbGaOF17zcjUvB0JSKa1cFFsbPpo0inmDEwDskUSNwA+R+GbIqht+8dgUgFTdF/PTHhKG3XnyK8mPA8QoPfXKkPxk8yy0vWUG1MG/DpbUg+1/CSTDirfk2cn4BazB65f1kWWZPHb9ZpdzVIhjtnXU7CLs+J/gJ9bM/8gBHogsyXucnUARC89u1jiLidQtqdfm7CWFB9FLBDynh+wZNXse39wrI2kSCr5AyPuWefW/BlvKi7jU4CfDMU8FR7mZA9sIVLkFTrEu6Azx8muboqLeFRJ4RJz+OU5rPXRefjEXhA+REtno6YbVpQ==
Received: from BN9PR03CA0405.namprd03.prod.outlook.com (2603:10b6:408:111::20)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 03:41:43 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::cd) by BN9PR03CA0405.outlook.office365.com
 (2603:10b6:408:111::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 03:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 03:41:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 20:41:30 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 20:41:25 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V3 3/4] virtio_net: support per queue interrupt coalesce command
Date: Mon, 24 Jul 2023 06:40:47 +0300
Message-ID: <20230724034048.51482-4-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724034048.51482-1-gavinl@nvidia.com>
References: <20230724034048.51482-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|BL1PR12MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac13ff7-bcc0-49e9-ca1f-08db8bf7e5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F5OHA18IbPW8EoQAPFE+j3KzhRM6iatAmQAMAZhw2KtJKXPjPeOYIg/D/uGZCNWQ98V2PlNkb14RhAMvtOUUprfjFlOYvNUaYiB03SKSBiLU0x3RjB9bKtkiDvsPRZgg1elWJyKZqgB+jSK1VdgTbmpdf17/6lFBXMiYTZopVFThzLJjRjygpXEFRL/IVEQekjXk86c6j+sH9Wj0acK5PO93K8ZugJHTXCl8KkYqmTJ2nXGIWyJQDx2xoNUQIiouc87xECKXtEWj+4ioUpDetMRtmKUY6n7KBreQChoD78qjRyxN6X2O4WaNJuszU5AlX/F6IciUcng5WN9xCpLSGNU42Sn9bxpsZ7hL7itDi/vgjDJytw1/AzaTA6Pi0x6P1SC2+DGZM6UzpbguW6um3Dlp7INlX6lpm8JF7hMtLzR9Er76DceLaTN0UkP5h8TdNgrwhuJ/zQojnOXx/WH2LufRICa9PCGqUSxI/uS1A2Ih0nnjGDclfskHvg9aHLJbzK8/b9/OIEVW+uJKw7w1N0cv0hVDklHzUGy3v9quXDHWZHUICjJiKPAvFjAIdwtrTN8pSw7mFOgzg5jeBlNhxSKzxaLGGmIEraHYGP7tCoMB5SIWqmXm42psCmoghhP6+TzcXYbUehDOk9HckpY6plZWUKaMp3ThY6rtkta9VDaawaNZp/dqaICO8NcTb+R3m7X4iaYXQPsQnneLlfGdq+VE5Jyc1SdKJHuqpBvH+BViSyE4rPoOS/89ZFHzM6yNtnDg94Tfz7ubETtI8IWCa9vOyJlq3V7bZowQ7MrDrgZtyPsnt1ynPyeVMuGKQ57c
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(2906002)(55016003)(40480700001)(7636003)(921005)(356005)(82740400003)(83380400001)(426003)(47076005)(16526019)(6286002)(186003)(336012)(2616005)(36860700001)(1076003)(26005)(40460700003)(5660300002)(86362001)(8936002)(8676002)(7416002)(36756003)(6666004)(478600001)(7696005)(4326008)(6636002)(70586007)(70206006)(316002)(110136005)(54906003)(41300700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:41:43.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac13ff7-bcc0-49e9-ca1f-08db8bf7e5db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interrupt_coalesce config in send_queue and receive_queue to cache user
config.

Send per virtqueue interrupt moderation config to underline device in order
to have more efficient interrupt moderation and cpu utilization of guest
VM.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c        | 120 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |  14 ++++
 2 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 802ed21453f5..0c3ee1e26ece 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -144,6 +144,8 @@ struct send_queue {
 
 	struct virtnet_sq_stats stats;
 
+	struct virtnet_interrupt_coalesce intr_coal;
+
 	struct napi_struct napi;
 
 	/* Record whether sq is in reset state. */
@@ -161,6 +163,8 @@ struct receive_queue {
 
 	struct virtnet_rq_stats stats;
 
+	struct virtnet_interrupt_coalesce intr_coal;
+
 	/* Chain pages by the private ptr. */
 	struct page *pages;
 
@@ -212,6 +216,7 @@ struct control_buf {
 	struct virtio_net_ctrl_rss rss;
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
+	struct virtio_net_ctrl_coal_vq coal_vq;
 };
 
 struct virtnet_info {
@@ -3078,6 +3083,55 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
+					 u16 vqn, u32 max_usecs, u32 max_packets)
+{
+	struct scatterlist sgs;
+
+	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
+	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
+	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
+	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
+
+	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
+				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
+				  &sgs))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
+					  struct ethtool_coalesce *ec,
+					  u16 queue)
+{
+	int err;
+
+	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
+		err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
+						    ec->rx_coalesce_usecs,
+						    ec->rx_max_coalesced_frames);
+		if (err)
+			return err;
+		/* Save parameters */
+		vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+		vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+	}
+
+	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
+		err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
+						    ec->tx_coalesce_usecs,
+						    ec->tx_max_coalesced_frames);
+		if (err)
+			return err;
+		/* Save parameters */
+		vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
+		vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
+	}
+
+	return 0;
+}
+
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 {
 	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
@@ -3094,23 +3148,39 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 }
 
 static int virtnet_set_coalesce_one(struct net_device *dev,
-				    struct ethtool_coalesce *ec)
+				    struct ethtool_coalesce *ec,
+				    bool per_queue,
+				    u32 queue)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, i, napi_weight;
+	int queue_count = per_queue ? 1 : vi->max_queue_pairs;
+	int queue_number = per_queue ? queue : 0;
 	bool update_napi = false;
+	int ret, i, napi_weight;
+
+	if (queue >= vi->max_queue_pairs)
+		return -EINVAL;
 
 	/* Can't change NAPI weight if the link is up */
 	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
-	if (napi_weight ^ vi->sq[0].napi.weight) {
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		else
+	for (i = queue_number; i < queue_count; i++) {
+		if (napi_weight ^ vi->sq[i].napi.weight) {
+			if (dev->flags & IFF_UP)
+				return -EBUSY;
+
 			update_napi = true;
+			/* All queues that belong to [queue_number, queue_count] will be
+			 * updated for the sake of simplicity, which might not be necessary
+			 */
+			queue_number = i;
+			break;
+		}
 	}
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
+	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
 		ret = virtnet_send_notf_coal_cmds(vi, ec);
+	else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
 	else
 		ret = virtnet_coal_params_supported(ec);
 
@@ -3118,7 +3188,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
 		return ret;
 
 	if (update_napi) {
-		for (i = 0; i < vi->max_queue_pairs; i++)
+		for (i = queue_number; i < queue_count; i++)
 			vi->sq[i].napi.weight = napi_weight;
 	}
 
@@ -3130,19 +3200,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
 				struct kernel_ethtool_coalesce *kernel_coal,
 				struct netlink_ext_ack *extack)
 {
-	return virtnet_set_coalesce_one(dev, ec);
+	return virtnet_set_coalesce_one(dev, ec, false, 0);
 }
 
 static int virtnet_get_coalesce_one(struct net_device *dev,
-				    struct ethtool_coalesce *ec)
+				    struct ethtool_coalesce *ec,
+				    bool per_queue,
+				    u32 queue)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
+	if (queue >= vi->max_queue_pairs)
+		return -EINVAL;
+
+	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
 		ec->rx_coalesce_usecs = vi->intr_coal_rx.max_usecs;
 		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
 		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
 		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
+	} else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
+		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
+		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
+		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -3158,7 +3238,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
 				struct kernel_ethtool_coalesce *kernel_coal,
 				struct netlink_ext_ack *extack)
 {
-	return virtnet_get_coalesce_one(dev, ec);
+	return virtnet_get_coalesce_one(dev, ec, false, 0);
+}
+
+static int virtnet_set_per_queue_coalesce(struct net_device *dev,
+					  u32 queue,
+					  struct ethtool_coalesce *ec)
+{
+	return virtnet_set_coalesce_one(dev, ec, true, queue);
+}
+
+static int virtnet_get_per_queue_coalesce(struct net_device *dev,
+					  u32 queue,
+					  struct ethtool_coalesce *ec)
+{
+	return virtnet_get_coalesce_one(dev, ec, true, queue);
 }
 
 static void virtnet_init_settings(struct net_device *dev)
@@ -3291,6 +3385,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.set_link_ksettings = virtnet_set_link_ksettings,
 	.set_coalesce = virtnet_set_coalesce,
 	.get_coalesce = virtnet_get_coalesce,
+	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
+	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
 	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
 	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
 	.get_rxfh = virtnet_get_rxfh,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 12c1c9699935..cc65ef0f3c3e 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
 #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
 #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
@@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
 };
 
 #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
+#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET		2
+#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET		3
+
+struct virtio_net_ctrl_coal {
+	__le32 max_packets;
+	__le32 max_usecs;
+};
+
+struct  virtio_net_ctrl_coal_vq {
+	__le16 vqn;
+	__le16 reserved;
+	struct virtio_net_ctrl_coal coal;
+};
 
 #endif /* _UAPI_LINUX_VIRTIO_NET_H */
-- 
2.39.1


