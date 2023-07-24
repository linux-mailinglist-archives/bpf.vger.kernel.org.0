Return-Path: <bpf+bounces-5697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB875EA28
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 05:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621C41C2098B
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 03:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB515B0;
	Mon, 24 Jul 2023 03:41:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F2110E;
	Mon, 24 Jul 2023 03:41:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D1191;
	Sun, 23 Jul 2023 20:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+foiyXN3Txa5wpoVTf02QPGJqBYskbG/W6BJC2Sekcm5VydwlEUdHP6n45CIBMZ1bctLN9YBQV4kWeSFXPirKhNhEvHb9r2ZRSQR9pkVnni8sDsX7fWiVf849/7m5MygJffXHJe0YL79ze2eJlbESlZIPmfLQZUUjM50oXlzZqGM6uFKRDg9qHumSEaARA81a1zBAvc4gMjLsuZt2welJ0cLznADq/XhTQtQ8mSGxv6dWNA6RCA81atevDXksORa6Nb2nArStAmxnx5eMZmajW29TopU++flVZFw7rk481LVCqx+jmHR48LjH+bv8+dXuXZO5CYyuZUoXdNvjct5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpY16pSmomnFEYpXTws0UaY23QjCR2HG+iPfMc2Mitk=;
 b=gKUDL0fr61MRN2XhOIA/XSo5TFPPmovxuble9hU+R2ydX1mqcQrThWhT0z4cLVXMLqMNW9CFGU6MHoUqvoC34g0o7NUvm6AMJaAzJssTYPOEzeGDwl50O2Z2VjkK5kVMjYjnmEOCV5mgRwTZQpm2Kr1JNrElyg2JDKAlxXU4tBa5ZOYezYGZbFzoyVVivX9xTxHHZknaelY073uUOeOIqVmS3tgwrEflVw5krrd6amyD0QpJ0bfN7iqIZbRg+qBI587s7tvBmJbXBXpFkVlaXoD0BsTu1KsEkjmO8+dYUqWvypTt2TyPmYp7Hq+4V7+9TYVsQ+A0CYGZUG6BiYIOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpY16pSmomnFEYpXTws0UaY23QjCR2HG+iPfMc2Mitk=;
 b=cLIlmSLpnnCSThEpP/0/nC/kAVzYSzS0YqIiwq82OkioX7ss9D3kAE21I62TV3pF3ZPhj59A8irXl1vVEYLkqMSdIfnXH5j6BQP2bQYIMZimFoY735GHWywGOzS/4sVwndwm6PJtdzajYr7hwpHUt7Z82yCP+d34YapjpAZU7hmhjjvhntpgYpON/oj87brOtbj2Z2NBtjPmVbkVrgn58ZLVYkvHbJ9NdfOCIOPOpi9mKfWQgENTDcT3FlIMtvdgCRHwF48sdMZTpWGhBjBa7bqdbDHkZd8kDjCZBTvOnqLsXKnR+Np58Fl+xQeUPCzEOihD/+hPTbQQ0Sc35UxVHA==
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 03:41:33 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::36) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 03:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 03:41:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 20:41:21 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 20:41:16 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V3 1/4] virtio_net: extract interrupt coalescing settings to a structure
Date: Mon, 24 Jul 2023 06:40:45 +0300
Message-ID: <20230724034048.51482-2-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e13de78-6e9c-4aae-b4a2-08db8bf7dff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sK+KmUpSr7CBooW6yHz78UTFhrElvNDbkfmdJUqhrkQur/h3m+gSDl0wtKL9JW6p2DZyIGhwBxSk7rSYHurWBCnazGXTryL4Hw77TeJFfEMjWuaMtCUqLM8Sy9sCsPOUWZ7YpbD8yXPm6zmbdOV6hjCMyOA4j0lms0MTZc9Cb3yaPjyRjpqm9790TVegdX8sXJ3zsdlIm/MY1MCkW6oLKEygI6MFLiCUgEYaF1lVTbwN5S+Z6GO9mzJ98dfU/O7UXgiNhV/+aUrHJvLZ3CAwMKxik+YSh0xQSJcJf3VC/p80x0auf6gcTdoWnTTE1PTvORMm41szQmAgW1hi7BOFi4m22xpWf25udszeLIB9QNJf0svzoEfznEh4Qwx/uiuWtaxQJnTR9vIUa+e4BA83EpKLMi4/NOGnUXIDdz9tdGiglqji1kbiMT1RgMPh6XsazCiThR5Y0Zb0SZ1H/kXC68GicFB47ApOG8QNTa/Gp4reZjuu+WowWjEhXKyqIsPW8OzYCAx1pkGXotFd+mOFYC4tXdfiMdWVlwp+Gkmhr6k5iqccTNtusYfFexh8q4KXZp/TatFVMr7Ve9gPXcGKNgonYjSMnH1ir4PcJvacFcoOb/QKdaLUgbdpmfDVVXQ1B6jmvYw6ietfNifSF4Q3PFqSPqwA6WXMXsGskez5W/WlQ9poWtZJyYBTYiYKFVujX46B3bP0W8/2iLDIz3RxeGx7aJi30X3CB7Z9UhMEJalF0CB40reXcZXSE/3375N5NZ1dzghtDAySyoAnbaeX6a/WQ/FtPQatLnL2XDF6Bbk2k+N8/MbU9/ANQIYmpwP6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(16526019)(478600001)(110136005)(6666004)(6286002)(7696005)(1076003)(336012)(186003)(26005)(54906003)(2906002)(8936002)(7416002)(70586007)(70206006)(41300700001)(316002)(6636002)(8676002)(5660300002)(4326008)(7636003)(921005)(36756003)(356005)(86362001)(82740400003)(36860700001)(426003)(2616005)(47076005)(83380400001)(40480700001)(40460700003)(55016003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:41:33.1590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e13de78-6e9c-4aae-b4a2-08db8bf7dff2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


