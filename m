Return-Path: <bpf+bounces-4577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A874D13F
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413DF1C204DA
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD1D300;
	Mon, 10 Jul 2023 09:21:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E3C8C9;
	Mon, 10 Jul 2023 09:21:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297318E;
	Mon, 10 Jul 2023 02:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6y/Y/d/q73UlUiSAUGzoy2RzcYa/2e16E4pNgDBhG+P8bmXsQLR7FBCbhQGH/xfshuglYWMCOT60ZED08BW8OxuQ9eIwr1DSq/6+L0L3tuLuFSRvG+xDp/v9ZMbLQSRqWWn+Kl8ps8WSyP2zt4mi7qX/MFQTP099thjvy6DprdykwJZuQ0GWQfSXb2k/qbZ0bOBZxKBzqtvJoFGGrUQyjAT/2GStpNCEC7dTkzkR5BFvYQ739qCSAOCk0cLPyEv8W9TSOGz8R3RVQFLubU5t5pqgYRkQ6/ch41BmcOMmOSVhqTB6+qU2hWvqC+M0HJlrxQCZEFGZoYYCzaKMpSqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T7xFue66UabcZ5Lt5gTbUtfirJ4UZ7HQaMClC0DXU0=;
 b=LDWhAEtfYeCfJ1+AEGgspsBuooHnkUY2kxVIg2hAkU4YWmbH3jbYL9VXh+FlxK/LqAoKH36tcOcfo5zOZiewYYwp4P6m95MYtud0JVU1mkrsk8rOFgV8eVL1QaeaDgadrgJInfkdnYc20dRWMSv9SRDspqwacdTjn7Q1Xbm70hFoiu+/zsc88mDnKLhK5KS2plXd9zTRU8YwhnUTI/N0hUeUEJDArOvlFNmgldHSLMFS0n5MWjdAdu5R+thW5u09J/3p9atQY2cu2LXi8VnIfklcdCDzwky8hxpCLsyeuMtVi3GYclFwCbEzR5BvxsoAhRyyuOGmv0D88zuztDOhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T7xFue66UabcZ5Lt5gTbUtfirJ4UZ7HQaMClC0DXU0=;
 b=qZPJoZUHVBuklFy+TI9Q6wfqSNB2lu2iR9oiSLSH6ggKROdByzX+WsBuTuQmyraSABOKWGZZ+I56Iy12JbQUf0atrgZaeDZMPOUg4xI037/PlTllEhAd6tOXjZZvKJPPsv6apoLo/blN/3pJ+6JhnBQXek6Wo8N/1+MsqW3D7pjdWSs4ruXsOysgcXh9Ta/Bg4hkXp9kYekksJlCUhQ4uK6lRxvhv+6bCsVr24pFGloDxsKxEFMSbu88PQ2s1wEsCjP0BjEI9Z8eGBaOywgGslWSdZ4VBZuG+hgSmVgZHb91zTKlH/l8IzQ/rw0oohYjFVvMkRR8ee+vaMxX4Mu74Q==
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:21:01 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::24) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 09:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Mon, 10 Jul 2023 09:21:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:20:53 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:20:48 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next V1 1/4] virtio_net: extract interrupt coalescing settings to a structure
Date: Mon, 10 Jul 2023 12:20:02 +0300
Message-ID: <20230710092005.5062-2-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d1cd04-fa29-4ffe-9840-08db8126fa60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XT9WnnlzTMj3qE/5owCKt2GquHRU96qeZJE1ZR4jv32g8kw8gvJLKoo17MMsNWzC/UoENQpoOEPxhoLoAQIyfWLRFzGU/Uhvjwsh/CjapxvQUPXwK2WYxvxX8iICXiwxdXVpy4rpODC3OaQxT3bFQ9Ge1EQDNAW8oWPsMtZ/kKez2wHCwvWh75wCPuOcqyuJ7Kao2vrqUB070fFyvn94/OPx6Jm509Oed9+63XYtIyrFH++dsnbYtR18NmZC07kWRpUQnTlIwdASBOd+Y8Bk+VXE8/RogsIgY2YtsbqFVv3e21xlak8kq+bYkuyGHImB88+WOOPTgPTAa9GhMblLVjQ7Viy9A1pLJ4QigWrKxW4Jv7ysJ5c84dTw27ME8TZ9U6cqX4x5Iro4Jie/FOC/4sv0Nbphl+puEKrlErjVPSZszv/1ycqiFZ9E3RSIn+xvEvXxqUDtmfC9ug1m9o6Z5tkrRLwaZ3HGAmG1W25HRq7WWi1/B4LtPFjzznPJq1BKomrVcYvQKUPa4lSZdU+Q/1JC8WbLbCChYTcNmf8Jj7woBf7kqia4IpDa99ijKQ1733z/pMDc5R+bG9BS7gvEgadAuNWOzryGBYi1x0UkRqmp3txG3wXvseqxvQmVo5Q0MgRSoBcU/tZfvVQLEVkRr19grO9CZ4pdOAkb3MBFQbhoW3m66Db6g08NQnUVCqVdsnRroqFR2wClsIj2LJeqzvCLbQDi8lrlbRDy+cLC/DoVflMZe/muWXTjUYPkEqkxalHBB2ByeL633XRhloHkq2VHV+cXfavBKhnu0yvz51mRtmohsCcpXFyg26Aydi+D
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(110136005)(54906003)(6286002)(1076003)(26005)(186003)(36756003)(16526019)(2906002)(82310400005)(70586007)(70206006)(41300700001)(6636002)(4326008)(5660300002)(7416002)(8936002)(316002)(921005)(82740400003)(8676002)(7636003)(356005)(2616005)(40460700003)(86362001)(36860700001)(83380400001)(47076005)(336012)(426003)(40480700001)(55016003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:21:01.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d1cd04-fa29-4ffe-9840-08db8126fa60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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


