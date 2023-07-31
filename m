Return-Path: <bpf+bounces-6403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C5768D2F
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4BD280EEC
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197E86107;
	Mon, 31 Jul 2023 07:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469D525F;
	Mon, 31 Jul 2023 07:09:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C6173D;
	Mon, 31 Jul 2023 00:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDz9jUi6eWUOL/TuXdKKi3jOrKRfr5jdxu30nNZONa6Xu+s8Is+VBLzSn1CMiufsYwZ2BBQvAaR2x4GpmReqtfCN9DiL0qt9AhrUW1rdtYqqlXqgaVrf+OmX8kb/WocBvUxakoEBNQc+j2xDcm65H5mza6wRS38wPEayjOtDSTkjFIzCWrUoJBivW5gccrMyFfErOfEcfD8S7uvdi68oUprvXlWT63FQuY/km21IlC/aAAGj9CFtgxV1sPWtdpQW1fa2FViDXTlQYGSZ16/TcM8XCdcSfRs7SR80IuayUgdSxSScmaPKsv2ECRvFOTuMpfYohsW6gVDxvCfF0myhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20aBci1OFdwFvsDpaLEFiJkR2sQ4epxhqzCuzTx2G8k=;
 b=ndTmgQuAiBZ0k0aXNiv+V9Hz+UbUj4juaF9RStyi4zunDn/pwtHlXRgjXeL97bBVxtYYKrUhT3VjoZZsOM1UP/okN/hFaI1+R5FkCsZshI0ujO0A87w4WhYIRdNgSjNjkY+Glt98LbnfXbVZpr/c5czvlaz5c5o3UlTJvxEmIO7KeUynbmX92ObOlykpPCRuidvZi9Mu5K2rmaL1LzgUCNEPM17XcDbRMFknEbyzd4SfhFby1r/luAPUl111jP7C4F2Cq6Ed6vX7rGGqlKf+XRRRNnT1F331y1lrqx3N2u+6BrhWn+nBrLBoUwBGZkC89U84aRr7qKxKqOlruFPrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20aBci1OFdwFvsDpaLEFiJkR2sQ4epxhqzCuzTx2G8k=;
 b=qg9MCB9/N2dVO908w8rmdhtjrHoyjwO4SJZyKQ7vKO4aziUj50EkpAXER8IbRaBlKIL4hpwd3cV83h8q1T4w0L4QSajwZQfsf8SLoaTJOX3O1rc41BIt2BTlz4rCkEmMkcjfmqnT+U/grUmwAdZnhbRRwvlp32bD5QxkE4dGz//qbc5cC02tGtC8UpLXHK8jQWioNQCx/EU3CB2Z2+0ELKUywcBrDXYdFQRDTaVpUBbgIehT7GXtP2p4yWsPPxukhtRkgYTN3vDRFC4acNGoIdeUruK6ATudVRTlnYGgyNjE3264ZTowC4YwBkPrv7u9gneoa/NmzdnXrWo8y5l6zA==
Received: from MWH0EPF000554DF.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:4) by CY5PR12MB6227.namprd12.prod.outlook.com
 (2603:10b6:930:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 07:07:39 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by MWH0EPF000554DF.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Mon, 31 Jul 2023 07:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Mon, 31 Jul 2023 07:07:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 00:07:25 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 00:07:20 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next V5 1/3] virtio_net: extract interrupt coalescing settings to a structure
Date: Mon, 31 Jul 2023 10:06:54 +0300
Message-ID: <20230731070656.96411-2-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 10701c4f-20df-40b6-7965-08db9194d37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kTnCczYQK49GaG+Bfh98KcvS0IrVWcktYuGGIpv7VKx+hCwETYlzp++RDj/Pj24Y/Zw0FRw6LETNpee0kQGy3ztMrbqwgUEZ8HBVJKh45RBgRDsM0VJVEUdaYZiUSH6rQdbwMkw/HjB78L9WPfsNV2N5gK4CXRL9Bz+ZBMTfw8iGUaL5oN6lv5lT9LqZbEoHjuL1QVq/G0dSrmyGn38ZAfsvNk21LNquImEls6IHyxr7YZC8L3sfiNYmIB71QZMsTvNSu/Yl6MZGveqE7DTiwiCRs1aDBMUVMvrnaST+5RXLXowoBXMsTNcoB1W0g1yJO67WG1sG9Xzh3nUNYye9qq6nIW/AZ/ttJ4wbgqpuFJAC2/H7YxwauculJbhW6Y9v6ZwspFpTidaCosd9pqr7K4iujQuw1dvgZmpPYCUXwj27uYq+hohhZY2ciy6oDfFDIO9CprPdt1l3WT7MxBNVO8leLwRyEvv3A1Fbhxx9W/pl/mAdMcFDuOeFAS2XRwOpPFAfMfyJw+V67BO5kuisckx8fY8sR0UUReGYzfqdIoNGWFlJmOiUd+grNVgvubia2SRqmQqIssg870ymbW5ASwI0+3EQMnh1saY4XH1SSzzPfoWF6vgOdPhTZpyGGa4owNaqdvnhacMTRQo8kzvHT5z6ICSuhIla/QwPnQIa/oDOCZH3Hj+0Vmz66lvSNZ9i2ZJ5nbbdGOPlGgNJ16F8PmPYTqoYj5//BProlAZ7pe72ldiM0F/RxC6qdtj3AG8OFGoeBKfG99ahnXs2lFKg6EywE2JnxvfL+AErqKzA2EvTx1QPhoHJtzxod/RgYyO+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(5660300002)(7416002)(8676002)(8936002)(40460700003)(4326008)(316002)(6636002)(70206006)(70586007)(41300700001)(55016003)(2906002)(47076005)(2616005)(426003)(36756003)(16526019)(26005)(6286002)(1076003)(356005)(921005)(7636003)(186003)(336012)(82740400003)(36860700001)(83380400001)(7696005)(110136005)(6666004)(478600001)(54906003)(86362001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 07:07:39.1391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10701c4f-20df-40b6-7965-08db9194d37b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


