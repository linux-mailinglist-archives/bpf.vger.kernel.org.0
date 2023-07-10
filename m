Return-Path: <bpf+bounces-4580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E974D14A
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 11:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D281281064
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1F101DE;
	Mon, 10 Jul 2023 09:21:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1C101D7;
	Mon, 10 Jul 2023 09:21:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::628])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015818E;
	Mon, 10 Jul 2023 02:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxndD8bttaTnbolfHJq4coRzXkMEyGcRu0ba5r6vrO7bvu/jWKA27KYgyWtCUTMLGvzyVB7jIPK33dFsw7rFY5wZf0KM6k3OA9ps0Ayp+acRa8TAZrL3L33yfLNHuHPFoplk0DuzDp2/YSprxSb7DMw1DnRLFLDKYOojOUjQFh5y5UF0iY0MdqCpSP+79X5S9jOp2/GqUGr4ZoEQmDd/0/yt2eHLJAIXwCO81Ms4717AmFO4b2uy1dpoQqg8Buxcpcu5gnQikC02aCOBh0x/4nClJEANAC6AoyAkk1KFRa09VKdULfQxMtRPkcpGUYpRNIUrQniXFJ0ttL0Rgt32hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SWmaZkssxm/63HkKMMcLHDwl31FnbHnufrPN+g/VQ0=;
 b=I9oNrPMYnJ32My6mF5uVZYQuNa+yCz5MBxy39e0UNBEN05IZZS2FHmz3cHSZWsglCg+MzNVmN8dB6W8y8fi1edCmj9eHqvO0Dx6sEE+2TqxTAWuzqlx8eAcZdpSYopISvWQ2lTkRgmCTjUkP908FjSELGjJgmT++xl+gQbujRc3V71+JRwRrF5md8q2HUi2jYpjMg2XpLv5zQaq44kKp9b1dJmmSpxi9g0VZysTADOuXbaE1Fl/BEQq0kkc/ZStLi4w9l5XCEagApBZFulH/yZXhQHtiivAwuA/yUjPUsJaiHjRpQTFTCjjSyv5iN8ocKJn2AQu7jvuC5FJxMNCmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SWmaZkssxm/63HkKMMcLHDwl31FnbHnufrPN+g/VQ0=;
 b=JRhT99n2pfeR64O9iN/FAAZjtiLqAUxqfScMcgeTsU/YPiBrA6l5/6CmBtQD59lfyg1dCqcocKu5T7nkqxcH+9cumLXQfLjXSHTy0bYVIbg3Rk2io4ejl7Sk0Cv19DHps6a9AOgAS2M+hHD7iZgCHOKCCXDCYBHB2NLdS85WfhLuZCxpJdoTU7YP950H88u3BBXoVhQJ3GqU0d2/aFNWXO8ttVPk5CEYEDYJ2ah3wv73fcNhvaswSYmFuYbLhqQ3XZkAN5bGeCkLz1I1EtjBXrt1XHIN++6fmhj7GWGwPko2SIwOWFQnxHQ8xFGiL9XoSniSUwCMTy6NEgQLI0qaqw==
Received: from BN0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:e7::9)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 09:21:22 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::94) by BN0PR03CA0034.outlook.office365.com
 (2603:10b6:408:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 09:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 09:21:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:21:02 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:20:57 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next V1 3/4] virtio_net: support per queue interrupt coalesce command
Date: Mon, 10 Jul 2023 12:20:04 +0300
Message-ID: <20230710092005.5062-4-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710092005.5062-1-gavinl@nvidia.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aae8c8b-4f67-4639-aef6-08db8127071b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OALTX+Ne+i6ZhZUj1MpGw7DveHmmuTGo+5QATLUNqkcAenhbaj82dL5eI0EAw4ycVKfy83V0Fqx3Wl4fFKQwyZK+WhwuZjfcMf83BqrBSibeWrzvpzNwMrf7DzY029UMgHVIGhmAz7kaqJ0EpwDe7c6gQNGBxEe73+PgLtVzfha+RjY1BQgq78+CcWAABX1zPXesqM6tTXF7z3jO9A+nPzhNI1RpnzFlo+SIKOSysd2xpk9SYR1M+FoLDAcD6Ho7xNxyELcVeoD8i5sit6H9YqKmKyhnhriX83Kv3ArpiUucl9ZrG3vlaK/1DW1MtaIzajZ+qGAvL7khU8x1gOydGNuL1Ms93avr9FAXT2wiqqmFZv3Cs6qKZm/YGga9rNSXmyUiEiMxCj1FXRzGG14Nt1L23qsMok3Ezm9HCPe/zzoEhR1r4T1WLfvnadMCgvXQBjRLqJwbRIFjb7dyGm9sQBOpJGmhWln25hNcrXAqdnV2QL58MZCEwrkZSSwzEVD7egJpNce4d3n2KkmjCTEea2/8YtUZ0knGr49GEeLBGOamPXqL/TbW+rga+eku3KLecGIu2kJQuCKhhmQJ6yZWcqllUb+m8cHGpXNjOViFMlXUFJ0OgWFIg0yaICg65cIJACxn8EzeMAREaayGLtSfhYke0vGpYeIfCR2KzCQhg8Rartm79Gx8NAJ9xM8fSVc0BtB+6jTWolKScbg19X9Py28kWSSQY2XYOTZ3cCytJakb6c7KXnyBtYqjLMapITGuUF06+/FM/XrD5G8AUo2TTdlzCosac8OeGbMlIwKd7Fc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(478600001)(110136005)(54906003)(6666004)(6286002)(1076003)(16526019)(26005)(186003)(2906002)(70586007)(82310400005)(5660300002)(316002)(41300700001)(8936002)(4326008)(8676002)(70206006)(7416002)(356005)(82740400003)(6636002)(921005)(7636003)(40460700003)(36756003)(86362001)(2616005)(83380400001)(47076005)(426003)(336012)(40480700001)(55016003)(36860700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:21:22.3832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aae8c8b-4f67-4639-aef6-08db8127071b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
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


