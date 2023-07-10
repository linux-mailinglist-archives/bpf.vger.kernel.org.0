Return-Path: <bpf+bounces-4586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3D74D28A
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE841C20A3E
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38938107B4;
	Mon, 10 Jul 2023 10:00:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB7107A4;
	Mon, 10 Jul 2023 10:00:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CDC3593;
	Mon, 10 Jul 2023 02:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zox8OuCREVM0sVgVU8jOOBfT2oD6tQGa9uHmWgbG/sDw5d/1+sbhhOLYHPCccI8naw/JLWvR2GUU9SbsvlSYtugBCM0TiOnm7hGvN3qj5vtV40U/vyA+4cf0C4xU5npyIeTWpP0oV27TJXQi9xizxGnBvQckee23FVAOGZkElvidC7Hx1Fl11sYN/O8xkEIsikrOf/mbv6Pg+YBtBnZY2N4bXsf4C07lgM+LM2mT+U2/Co/lm5bB/Qpvn3aeZULv5PomAbqgA9pxwA1LOPDpUYP7n4t6StLAxvZ91wLgtlsUU/kOc69bEFcRoDet11avuKZHOz84vj48UWBOsXUhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SWmaZkssxm/63HkKMMcLHDwl31FnbHnufrPN+g/VQ0=;
 b=MQgRMD/6Obci6wvPMHFy7dKHa1tkMA0w6UL7yER5D4FbYpS3h57lSJ/1wyKQGJbiwUJiEb1h7iWARuaDnuRHMANf8i0gdFmbleIrCyPE1cw/mZrL32vnnhNLB76stjKVI1gpFNtOKKeIzVaJ5yl0D9PM3DXDs2jIV6rh7K6p1PM9dnev9fbJCxXXFqZH32myeVeKltMMFFNo6SUUM6lJ4OGVXAOpgmdt69Is3bf44QT6unAqHpJtg94nESh7S+Eo5fZPp8DguJXGHKia+twnYkENgXe4DVUdNm7ZlzYe7nSs18xtxIbW+l1sG0eOt/V4Q+OkBALxBpGGSs4KMEDEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SWmaZkssxm/63HkKMMcLHDwl31FnbHnufrPN+g/VQ0=;
 b=boQUzCfphWhc3hldy6a2bxAlZzXN+76MS6ngjmbHufsCKAPIcUFAWGXo/ClmwvUkNUBGWVzhTIt5ECB1mwFctUBhY1oOBGBzYnoQDyijUlbGa2j7li+Mddw2XDVhM+BENtdg0PRMBG9ctn5266bDS2uecH62n9BpcOV7qCogvgy0L+gHjSLMc4dzkQGiTMs9DQL1JgR9evM6VGRbZvRmo2rW/iN3LBw8Mau9dmxtMuVBMARR2j1YAMvAkagoo+KtsFMUkQFCkyzwcdR+fWzDXNR3BRegG+O00/S/dcPjKCJz6ygeXt4j/sMh0l/tFf+cyRI56+c/yv5aIj7mH1bEIw==
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:35 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::9d) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 09:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 09:59:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:59:24 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:59:19 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [RESEND PATCH net-next-mlx5 V1 3/4] virtio_net: support per queue interrupt coalesce command
Date: Mon, 10 Jul 2023 12:58:49 +0300
Message-ID: <20230710095850.2853-4-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6617d1-823b-4877-6b12-08db812c5ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bfl2aigIDTjhWR5JVjuXX+0guuYsI6MGQFNmdjN/z9y/X5XVRusdjFq0czKtJFkXUduOfZUd6BsjIKWNAZ4hhgBtu7NA0x3ZAq5v4aO67dY/LMwCTzYDYIZoDgm12O8ITGGFKs9JTmSPIMC/Q9f3SYG77JdMEYr429FEBcR9TlQ27mUlxrOdIHRT5qRw3ZsVeTftSpGcnlAkQhbsOdLQhxj+btgVspA2uHcXDvD65+oKxn/NUjtOuzhXPgpGEA9zrZwKsg7vhveSe0vjYEMCWL3khvzT/QR8ii39RlkaI+xUDciW/A2+pM/pncowFBVzYGRJZK7SC8IE2ypOTcPwWoVcBLbpQP3KIJ1OtqRefhE3q/vJK1juP5k25vwht1JfY5E8mAWxmdXdGocfVIUOxHsjDiGP5MrebNwLtvl/wPmnKIWFdM6BSDPXvGWCmemQa4p0wSLSOdUGHViLAO3o72SON1XrVWo7NONslzldQ5t26x8qJ7vOUNLefb5Gm/CvPDNVhgUOSV7e2MaOw2lM/XUI29TugPRHoAP2/bnj20tg3vGPHPpTCq96NDt2mEpmguDs9GdX776rz63RQ7PjZhzXXvAbrdiF+VsulkjOtnYUPlYNtp39XnciI43rTufqFWeeT2gVpKW4WcfQw+jL7ZpMroTjoYzWnGXJ6NY/uPAUvXJ2ruWcJlS9A9y9j2sJTHj+5Wdy5njdNZtu9QN4/NreoBUtxi0mk3f12/4GaSUsffC7PbaR2v7KIKIBR/yCeroiLnESl3LTcRYXXiu+N3Ld3NldqzEDFsQawandOk8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(55016003)(6666004)(7696005)(110136005)(54906003)(70206006)(70586007)(356005)(921005)(7636003)(36860700001)(6286002)(16526019)(26005)(186003)(1076003)(2616005)(7416002)(5660300002)(2906002)(316002)(478600001)(8936002)(8676002)(47076005)(336012)(83380400001)(426003)(4326008)(6636002)(41300700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:35.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6617d1-823b-4877-6b12-08db812c5ddd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/net/virtio_net.c        | 117 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |  14 ++++
 2 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 802ed21453f5..333a38e1941f 100644
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
 
@@ -3078,6 +3082,56 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
+					 u16 vqn, u32 max_usecs, u32 max_packets)
+{
+	struct virtio_net_ctrl_coal_vq coal_vq = {};
+	struct scatterlist sgs;
+
+	coal_vq.vqn = cpu_to_le16(vqn);
+	coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
+	coal_vq.coal.max_packets = cpu_to_le32(max_packets);
+	sg_init_one(&sgs, &coal_vq, sizeof(coal_vq));
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
@@ -3094,23 +3148,36 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
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
 
@@ -3118,7 +3185,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
 		return ret;
 
 	if (update_napi) {
-		for (i = 0; i < vi->max_queue_pairs; i++)
+		for (i = queue_number; i < queue_count; i++)
 			vi->sq[i].napi.weight = napi_weight;
 	}
 
@@ -3130,19 +3197,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
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
 
@@ -3158,7 +3235,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
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
@@ -3291,6 +3382,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
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


