Return-Path: <bpf+bounces-5820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E96761963
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469B528176A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E01F926;
	Tue, 25 Jul 2023 13:08:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455F1F177;
	Tue, 25 Jul 2023 13:07:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B511BCC;
	Tue, 25 Jul 2023 06:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4s4kJTUXuZ5W9QktJWld7jXQSMRLBkqSxdEvW6Ub9IvM7hBuWph+lAQ7okcg/mzbzOgMhRyFD2LwfQC72/LhUIx1/ZlVOgOWTr7u3WRbn/Usu414gCLx6SwnaFUIylQN1vZaXvMp4vZWI7uOAm6R2sq2XCNxstLoYkLMiVxGr12Dx7YEo2dAZT0lNZRxxTBwlzuhgaUx1P676Srw7mK/JVPkjaiDxV6D+dRCTq+DZb6b8UUDA92sEqeFzzR+wW3PVxuLJ9SaFzD43gomXDpfGVZcthytxlvNJCVy4mw94wiLyduDgNSD5Q+DrzWb5iX2xpDqtRruoNvm2EnB6Gd/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9TXQ/feYFEyNyoGICnA+T0LCAynvvLGhxglyeBkYjE=;
 b=V+4qu1tZm2CjAy8zM2tnGCFBmZwB54Ff/dRxQWlWIsIOLNlYPTWMwOVbSKM+FC7K4kk/0q344suK3Bv4XcH++diudOTUk1VyUksrt/ST8+LhDlzbpv5yMjgjWZzHkcQqZg/Eh6qH//+0ug7Ko40SE4dfR4mRdwPWbpzr8iuOy4fOd8mrM2VbO3T+pMID1KPzmWDQDqTsdkHfgpKETvuI6XWSqhZ7e49fOflydCn5oJQgXUOFdgGTTtjTI0mkIv/q7EkgvgTT13ND3p6mve2UA9f8+vxuANydMcrYrRveNn+zRip6hJJMUV+hB4OTZgS+W/bVBBWjJZcaNVz8KgD9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9TXQ/feYFEyNyoGICnA+T0LCAynvvLGhxglyeBkYjE=;
 b=SIPRFhFCJgqPa2Cw70cH/fbOwH6XwbcovZJMPbCGoIqWaW9sItj7R1WXuKmAhtNd3FfvfqgpHIW9b7AXHmCshxL22k7M5u0d1O5OQmPELp4cQXptGhNNjVWmEh3rZaq5sRSQI2nydIzczswUaRarPGxiF1+J3x5dX6w0Ye3CsYD/+3iEjOhpeTyjdbfMQvEAeXZtou9Un7bqo7fSKKMebTfkz/BIDf7Uy61JTBJz3PT0+FQX/xQoFkTCgCVSEADdNO4AFoj0JDjUNr6+4WLCt3LQWIjjywH9C5QZZT0JaKny2XJSBFYT+nLDgBfC5fLANgvQCJCEFUesR2RitcvlHg==
Received: from BN9PR03CA0431.namprd03.prod.outlook.com (2603:10b6:408:113::16)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Tue, 25 Jul
 2023 13:07:53 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::c8) by BN9PR03CA0431.outlook.office365.com
 (2603:10b6:408:113::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.34 via Frontend
 Transport; Tue, 25 Jul 2023 13:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 13:07:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 06:07:42 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 06:07:36 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt coalesce command
Date: Tue, 25 Jul 2023 16:07:08 +0300
Message-ID: <20230725130709.58207-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725130709.58207-1-gavinl@nvidia.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0a7fd2-49d8-4ccb-d044-08db8d102846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1msQQKcp8v/VtgChQkcaX5XJ8QfYcqqWRGxtIE27TZDyYH5vq1RUNaMIuvBoUcYnmHvqHVvADzbD+RjPH1KhizRL6akIMFIujT+RKVjXZRrYSYKjFBOfKoJ9rvAZY+UCy2BTrbTgfYW+AKKPVLkwQxq8xSvuOIpAvvUD7MZvwF9hgpT56sRV0cP6ZLSHgfqeVWy4fZ8a0QtaW/wdfvxOhKkIAtOsM37ZbdTlJS3+l0BNswoAXLbNvJhhWs1V4bxHvzUQ3C8rrz/jSE5Jd0N2EFUdE++VH41C6+HOZHd8N447ihA+K8UHyTPlWFxiHOe7agYtkDuiReQnDVrLPVuvMHHuzrGUS2MBA/f0CjYqRBc/UyjXg4r4Wj1tnXj7IsEFUxuJQ/GDJpz63bfIlfoKzWE8uUogn4YHkZ9OWiOmK/g+hnGHg3c4ZG7Zw4nJxvcpwdXiFpqF3YadsPvPCxvKOr2UgGTWd6Q3by00JGwaZafg9zWKwXwddG5QWy9dk9UkA9mnO5lVgg63Tjhp/dV0fK3XshP5vf/qxhTU0adAAYYnZioQnSRuPFNQidWlsElqtPZR0Q1b8UVDQ/k07jOgDju/1zFa3/GdYyUQKXwSwFuyAywTYYfbONwz1NI5xv5fvRmqO++jtJWNzQwwg0Bph9lD83i/KF4Wh+E78nowjVli9o+42s3DqRzKd6VJV8nBCDIfBJdvNN0FicDq47SR8cDDzoOwvs1CtT+cI+4WqCKGGmQg4J78+EIeZ3JaQ0LH4HhQzNggcYJUI0JqHdcImDMwEoGx4fw6W6JShmGI9IAy74WfPedHJ5qtmL/ArxfW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(36756003)(478600001)(316002)(86362001)(4326008)(6666004)(7696005)(110136005)(70586007)(70206006)(6636002)(82740400003)(336012)(186003)(5660300002)(6286002)(41300700001)(16526019)(26005)(1076003)(8676002)(54906003)(7416002)(8936002)(2616005)(426003)(47076005)(40460700003)(2906002)(36860700001)(40480700001)(7636003)(356005)(921005)(55016003)(83380400001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:07:53.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0a7fd2-49d8-4ccb-d044-08db8d102846
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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
---
 drivers/net/virtio_net.c        | 149 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd5fec073a27..c185930d7c9d 100644
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
+			/* All queues that belong to [queue_number, queue_count] will be
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


