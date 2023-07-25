Return-Path: <bpf+bounces-5819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D61761961
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B961C20EB9
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F671F196;
	Tue, 25 Jul 2023 13:07:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F301F177;
	Tue, 25 Jul 2023 13:07:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC4E77;
	Tue, 25 Jul 2023 06:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTDeOkcvt4ESxuL9XAXNrTg7rKwjxU3Azf6gPqpYaXPTbs9sGxRoknUMpy85zpr2NPQ98PkGeQuN/QJFPEch0+G/90ybM/JsCBUc5R0DbV8siRrv6phHzDOex5W0wXPzHyTAYmg4PnCoi3uqWJvpqSVMtXTaqLuZRh20qXJ3k3khc7Ci1aE99GdVZcbMOScWymGOSALVa7H4HRpunNyKsmEutDvPILsSyS82VgN03GheRWNYKbWMTEL/syz5Ss53tpx0pxMZBOituOi3zwfewKRiD+H1jI49gK+rQTaUTqOSI2NWILX2fItLqJyYcWtJgOeRaRWcf54XvyrEBTwo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20aBci1OFdwFvsDpaLEFiJkR2sQ4epxhqzCuzTx2G8k=;
 b=MhX7LnNIYmKEG77Pd9vfycia48R/sWetMJbz/qvbpmoLT+qXwHpi/hmTBHVaYGTQIzG2kVUg2hZck8XIaVwVdb3f0kW2KYapb7yGl4y3TW3hcbXDPA2GFuGMCrFbwiykQ2TARz4uQapXqAsNidYyUQAWWgina2ZMqKBWhHnYxusL1bDR5fZDF9+/b2ep4Q9FEtOOE4nyI7Hid+ZNREJXU7cC3Wc+y8ANEpUTfOeHMgQA/1XIrRvffmL3mspvkBEaiMr7ScV7N0wPPYE876tW9fLqd3AM7htHJRC4qem2g52u4u2aR7IBSTz10kRKx0uiNWs94xd0iJEltuGG+WddbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20aBci1OFdwFvsDpaLEFiJkR2sQ4epxhqzCuzTx2G8k=;
 b=CLMjxkZHhoKDJOS6QtMk6ZRqBppl6xM76hmNaRKYIDVgh9DKGCVLri7ELPpykFuYvmO+dy2E9d81BDOWh8zt5AbXQtNEW1whkYhTIgPHmcPhN1C/azO406VqpJM1/Sm2O1LVPSePC093+uFkEP5u/1dUVSkVJ5evHzQBtfqs3oQwoFe3GZp7gTk0SbAbdRqEjCeMwGR4/mngyfE2gIeBerHptGbba1EBGqOrQAKuJAOvZneaXQXoAj7HXPcTG9Mf92Vpsn1nUil+Yl0o6fNZEsAQGO+y4o4/VFzJhKUSdRmCwpCT7Xn8Prf+zy+xXDQ2mr1XV7fCMQqCxqntPYteHA==
Received: from BN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:e4::18)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:07:47 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::1a) by BN0PR02CA0013.outlook.office365.com
 (2603:10b6:408:e4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 13:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 13:07:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 06:07:36 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 06:07:30 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next V4 1/3] virtio_net: extract interrupt coalescing settings to a structure
Date: Tue, 25 Jul 2023 16:07:07 +0300
Message-ID: <20230725130709.58207-2-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e55f75f-75d3-47ad-6289-08db8d102481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xi7uvXUlyJA+QlDXDNv89taXMiIy2DQrScj7yxQXJaSGLSSb/yD3vqADDzd1FHU2ZP29tti9y8JJbLCXt97GxriKY5wdqQTezq/Fkw69ybFzYvlI9ryWSrU0k7KqR5c5hT3vD2DlNup7HYwcX9NxpWxI4L92T0M0zurV/SYeEQI3R8qnmBX7n6cfMJQCjx5tGRkfXcT4yF7FJgnPEJKnAHC+xSMzyRrW2PlqvqpuYaE7OMTJGDvabaoBZXVzSRu1CzGnWK01R/XZx6bGnE/7oLtkthY2ZH6P/LnirgE+B9l5f7gftb6lIY1yW+eEeFeEx6bhNgUqipM/5NV7ei+YbDntYM62urSyQbLrdgEzC6aHgS0jXEEdVzIalKCE/DYKBnoObXuNu4lbuX+oH31uPBrelq9ti+UZtKrbB+iETLH3q+RIBbR3njo6C/V3M8HIrdx1n2VH/1sPajfGNA4/qT+m6HbctXjAXGiH5iIjI2ZxcwOePhdMbEcelOW4ZKkSe3x1JP5RtP/BLv97G46C0XSUo9l0Eg1z2bwqg+auW1Mf7FF5nPoNU2VtpZjgMqN6FXc3Sm94DDU0x/9VPgvJi9wLX3sidnwJIc40uZlMVOWdkFt8EhN0w6WMev7ybTYJeTAp9lbIGch4Ts1ol9Lh2s9jKiTVS2xl9TTO4MQGR1X0eqRwESs4n0ZFdizGiyriWeEt8CUnZer2nG3brQjgkfsjzPYDOcWV4hgW10j15fT2eslGG1KdIwFK+fYmSUKSsT/FtsBVO6FI4dAuzCD23HhpO0kFDgnyyaK3vB5zxLeAoBMUzUpiRMHQTMNVeQGc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(82740400003)(921005)(86362001)(110136005)(478600001)(5660300002)(41300700001)(8936002)(8676002)(40460700003)(7416002)(54906003)(6636002)(316002)(4326008)(40480700001)(6666004)(70206006)(70586007)(7696005)(16526019)(336012)(186003)(47076005)(6286002)(1076003)(7636003)(356005)(26005)(426003)(2906002)(36756003)(55016003)(83380400001)(2616005)(36860700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:07:47.2634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e55f75f-75d3-47ad-6289-08db8d102481
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extract interrupt coalescing settings to a structure so that it could be
reused in other data structures.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
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


