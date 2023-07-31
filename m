Return-Path: <bpf+bounces-6404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF99768D38
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9427A281218
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280C46132;
	Mon, 31 Jul 2023 07:09:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5025612B;
	Mon, 31 Jul 2023 07:09:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A419A2;
	Mon, 31 Jul 2023 00:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMMdk/Fwp49gEHjL8IkVbQHrTMoKXbZlboj9JaeWT5zSLfidIV9i9KKbszW9RywHnpawOnvDsgVBpsEp/peRoCSib7had9rOWeodQuBjap/JHFuw1FUp2/eHqYRZ5qtRUQ6DFO1BZV/jbeWrGCsl2BMtNCWeftWTt1MfiUt4hXyFYrYC4DnhLyXL9kyXZpmBSOAk1gzdYx/8h3NUFnV+xmo95XM5wPGWjpcgbPm6YqVrPArN42fHZriANp4fhL5ZOrWevwWW2O9Zzp8qbIwbbJvH8VwtBYd1VqQZRp+vfQSH8H4Vy4OfbHdrvLamhHR5llKhgeAZkJr8b0139cRITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyHrllRuGSHidLiftuVT/bNiX+LVYPuVS1xWCIqvSFg=;
 b=VWrWVsr3PXOfMEdLEBTlYavcVuW0bn2dqQuTIZjUeOpUewfRyY3Ge23yu1ggapjP5ikY33blVP8eYZb9qyqneoHhZg2JtANUqznUSI0vhq26AzJB7FD3BR02GH1hGCtvKIadOdGPlqYclaDtJCDnVX/fqoqbnf49oQPzWsUjZgzJMfV75EAbdCUxvVXh2ZUzupsmqzoqvmmp6yiCXkUxZqJf+7xbV3qhs1JdB+Xeu5fV44goXMVhMwvwi2TLQlnCHx9pGg8bX4Sj/lfCdOzDPtTJazMXPZ/uqegCRIAWFPFfGRt6FGuXY6V7hI7pN2t9EgrF+lYGZJLpQFA0ip3yPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyHrllRuGSHidLiftuVT/bNiX+LVYPuVS1xWCIqvSFg=;
 b=KFHij0Bza6j/pfXu1QENLD0E0gkcov+kZ6CXyu3FeGmweX6AFv4XoBiCTAqBrI04wps5w0ohkhAMNY0dtCMpN+GIpmxyNAHIH+q5TB+Rl4NLdxpA8Ge4j8G0YgAoeH/KWlc7bGiBWHgu5xhJZFv5LXAUlxoTx0E+EahlLIk+2IL2wZIwbhnPED1CM8yQX14zPnT7B0aVPw9mMKs7spJhguXaj8hdc4px5v0Rwl20DOFOZMYZMaxIGtYxB87WvY9yRELH9FHgvzbZeIkvmfDN2vs5cPoKRgUHWjpEloJbIw8F2yUPPjbxUzneAbd2t7WX3BHrzSEMPCcaYATVyqigHQ==
Received: from MWH0EPF00056D16.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1d) by IA0PR12MB7776.namprd12.prod.outlook.com
 (2603:10b6:208:430::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 07:07:44 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D16.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3 via Frontend
 Transport; Mon, 31 Jul 2023 07:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 07:07:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 00:07:30 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 00:07:25 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next V5 2/3] virtio_net: support per queue interrupt coalesce command
Date: Mon, 31 Jul 2023 10:06:55 +0300
Message-ID: <20230731070656.96411-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731070656.96411-1-gavinl@nvidia.com>
References: <20230731070656.96411-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fef090-bffa-4800-f67d-08db9194d6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+06SnYd5Sy7X7QGWbCcy7IkCuPuRzGCW3NHLY4D/sHLgJonBx+2A52k17+s73Lep54uhRF1hu+WdTv/KCelkIsif+xc3gh5OAiaEt6pKkHRY8WZXaBg7BMfDzFKUwVVh8bt+mWkBSmOY1Ao6l0BxtmTXu+N6MU6NZ/ilA+Ric+TWQ2Ss8S9Cq0kt9fCOxOR6i6S9bChigsov7rlN0AHiamyCZGfST/Bvooabx72jIIHjRu6k3M9JDnrkAHrjwYfOnCKivSnA9PdBvTQpqPmOmItSzE5ErI4gZy1uUSKMWY5jVZaCzy3Lfm72bF0JVCHB4kgaMHRZQoY70hTcxXx8l6Ef9r8nTeSPkLNCnUA+wFRzaLrpiJM0kp7QEYh8gJh+O78w31fBu8YLNyZeYPyiaiLDRr6lwQnun4w67dEMFwFWABV/NbC1TLms3XtXZ/u197b0ALDpDq4hje8D+MimVGgBEdNYEnkRk0efmluKOXmJsTYCt2GyhnV9XOFZYOQsmTylpGtoPrUHUV3I1sIjUUH4rICBLgJ8rAuiSZdguel040DRVpH+BMHr43lqV5pbtOiTIfRI/BuwJyONX8FGZlJ2M+PvFmnN4zRw0nYRyCDcKXi09Is+/ltblmfNlVIFjE+F5gzOswaR6/YzqcRuo4jmIUJ6JT4hjo5ENJSjObLkDKJON24Xvt4M6oqEKlsThqeXXff48zbBT2gB74qoW+Xz0dd1YHEkn+jcFKQYsdP8/G/n49F/FVATJ4so6+JS2YtYHiHM8kA1XRH2/WQ01zxHBuFCtPsyrg61wyfhN2Pe4YsNx3IusbEq6kzpTdgC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(7696005)(36756003)(16526019)(6286002)(55016003)(40460700003)(40480700001)(2616005)(1076003)(26005)(83380400001)(186003)(336012)(426003)(70586007)(70206006)(7416002)(7636003)(356005)(921005)(54906003)(110136005)(82740400003)(41300700001)(86362001)(316002)(4326008)(5660300002)(6636002)(8936002)(8676002)(2906002)(6666004)(478600001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 07:07:44.5294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fef090-bffa-4800-f67d-08db9194d6b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interrupt_coalesce config in send_queue and receive_queue to cache user
config.

Send per virtqueue interrupt moderation config to underlying device in
order to have more efficient interrupt moderation and cpu utilization of
guest VM.

Additionally, address all the VQs when updating the global configuration,
as now the individual VQs configuration can diverge from the global
configuration.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c        | 149 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd5fec073a27..6640474f46bd 100644
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
@@ -3093,22 +3147,42 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 	return 0;
 }
 
+static int virtnet_should_update_vq_weight(int dev_flags, int weight,
+					   int vq_weight, bool *should_update)
+{
+	if (weight ^ vq_weight) {
+		if (dev_flags & IFF_UP)
+			return -EBUSY;
+		*should_update = true;
+	}
+
+	return 0;
+}
+
 static int virtnet_set_coalesce(struct net_device *dev,
 				struct ethtool_coalesce *ec,
 				struct kernel_ethtool_coalesce *kernel_coal,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, i, napi_weight;
+	int ret, queue_number, napi_weight;
 	bool update_napi = false;
 
 	/* Can't change NAPI weight if the link is up */
 	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
-	if (napi_weight ^ vi->sq[0].napi.weight) {
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		else
-			update_napi = true;
+	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
+		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
+						      vi->sq[queue_number].napi.weight,
+						      &update_napi);
+		if (ret)
+			return ret;
+
+		if (update_napi) {
+			/* All queues that belong to [queue_number, vi->max_queue_pairs] will be
+			 * updated for the sake of simplicity, which might not be necessary
+			 */
+			break;
+		}
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
@@ -3120,8 +3194,8 @@ static int virtnet_set_coalesce(struct net_device *dev,
 		return ret;
 
 	if (update_napi) {
-		for (i = 0; i < vi->max_queue_pairs; i++)
-			vi->sq[i].napi.weight = napi_weight;
+		for (; queue_number < vi->max_queue_pairs; queue_number++)
+			vi->sq[queue_number].napi.weight = napi_weight;
 	}
 
 	return ret;
@@ -3149,6 +3223,63 @@ static int virtnet_get_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_set_per_queue_coalesce(struct net_device *dev,
+					  u32 queue,
+					  struct ethtool_coalesce *ec)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int ret, napi_weight;
+	bool update_napi = false;
+
+	if (queue >= vi->max_queue_pairs)
+		return -EINVAL;
+
+	/* Can't change NAPI weight if the link is up */
+	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
+	ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
+					      vi->sq[queue].napi.weight,
+					      &update_napi);
+	if (ret)
+		return ret;
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
+	else
+		ret = virtnet_coal_params_supported(ec);
+
+	if (ret)
+		return ret;
+
+	if (update_napi)
+		vi->sq[queue].napi.weight = napi_weight;
+
+	return 0;
+}
+
+static int virtnet_get_per_queue_coalesce(struct net_device *dev,
+					  u32 queue,
+					  struct ethtool_coalesce *ec)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	if (queue >= vi->max_queue_pairs)
+		return -EINVAL;
+
+	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
+		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
+		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
+		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
+	} else {
+		ec->rx_max_coalesced_frames = 1;
+
+		if (vi->sq[0].napi.weight)
+			ec->tx_max_coalesced_frames = 1;
+	}
+
+	return 0;
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3279,6 +3410,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
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


