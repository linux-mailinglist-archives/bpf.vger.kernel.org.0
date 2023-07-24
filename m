Return-Path: <bpf+bounces-5698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76875EA2A
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 05:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810DF2814F7
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 03:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8117FE;
	Mon, 24 Jul 2023 03:41:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8A15C6;
	Mon, 24 Jul 2023 03:41:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813ACE43;
	Sun, 23 Jul 2023 20:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWSuNhsW02m7Z2b7MFCQ6nJkFSww7fuUnyo5o0XPjP1NHUCZV3sJ7lJkgh3jiccn2WOGuE+o3OUvgrrrq8qBZSkMyOqvWiAj5dF5RH56QpMY1T6bLIzWWqC9omyLji3+X3q3lU38sxjOpHa3mFUI6OxLRpVCgiZ+tzrgNWLyr2S/cyQHLY0udWPopIUh6jmWFqDqfZw5XdxkUdC4Qq+qqIZkoiTguJS5H1ps0puMtKZ9eMRMZdf+JP0SojDyDv9ZIeuP0/YcC8NBRpGOwJ6x85dsR0YxA8ntG+tlG4utDE0cJ+R0/z2/0XiBGUL52Yz8+B6jgeVdOM3gSrRrAj03Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HnE17WXvUiKdousTex6K1czsq9mCbCP2v/hVcbXrVo=;
 b=OPM2kJkA0uNluw4p2A/S/WoJ4xWj4tNCbrH1lPTq0Q7Tg/aegOVq22yuxL1jn4E9IlEPHdHkVELt8vkmbKPMBa3bdNTWsqcOmdMkW7KTlX+UcW2NMIEZvgg8kCYMB3VJj2jzT8Pb5Y01GjuGEecvxFCyAQgJfn2TjN9Ze1nlH5mXymaqgRkTHXhKD3RXBghyBUVNljJw8yOVN4+qPAkOGpCClPsunwcGXOtBRCDEYnG9W9a/ptFkfhOkerOoAO4uWe2zkBCkn9xSLobNjQfnvOj6d8Bs8AIkZZPdmvBETRABLXfMWqINhhK43lDC28Djl3aOkaPyVEXgTnS7Rc71/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HnE17WXvUiKdousTex6K1czsq9mCbCP2v/hVcbXrVo=;
 b=hAB31cwhpHqCDLWO3ExUNQR3s5nDGKuQI/ymaaGlGx5+5C1aT7ENlBBn0MS+skj0rnfEWwDR8pxwb72Gl500gqciLcTNoe/zD0B8zpudo0jKHk3jFa7vV0MIYbb/PB8HFu5sVQ38CvDtiux0uWaUoIjG7QeQT0leFYqiH2Mb0tucuTBMO/tBDlDjXMyDPpab/nyxMUcOv93aNlxcqQtdf14NtQ1X8WaAP6JJQnLh62WjYzwYB7V9dVCoB//dHSSSEqZz53KSC07q5T6lwH03X6CcAnoTHxwiCc5N0RY1GdMnZ9GUqZ19nwljuKzR+PuoWSVwPCYOAWqCJMYmopOFPQ==
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 03:41:37 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::ba) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Mon, 24 Jul 2023 03:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 03:41:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 20:41:25 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 20:41:21 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V3 2/4] virtio_net: extract get/set interrupt coalesce to a function
Date: Mon, 24 Jul 2023 06:40:46 +0300
Message-ID: <20230724034048.51482-3-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 93be3d80-f69e-4fbe-619c-08db8bf7e221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F9DgAj4ndXfrcCZd3gR7AwsZnc6wtj8hd0mXQT4oEIrCvRXcNGD1pNkejQaNaiN6C75IVh3F6n25BT/RdACYnpFXiS/WcVQei1PGDIh7BU+lXGFbev+jI8BEJjEAYv2HlIXHDLY1ZafzeE6/JwtKhWS9g1oc/q/aSYydz5Q9GSZ9/jUkAtAEz7im4x2ISi+IN0kEqaEWHSHnELE1Ht6iILYoTzZpAc++uW16tpP1OMYB06DnLWafV96gUB3d6ewa7tBbqcM8iZedYfrBV98i4ngQ8W+uuxLLZ225Im3fpmwWteCUkgFA0yxBFnj2txDyAtHNPNbvqqbpzy3exAu5MDh2OZTQ8/C/TfU/ogqpivAc4v+pCJUVKr9jE6vTa/NGuiTuC/21FDviqYa0W1HsHnSGyT4m2adGaHqm0A1foIZENI4uywfHQNaqKoy6tr+b+bcpvYHMpnBb5mXmehDmNGP3yKY0I6aYtcbDXBeCTn4YTaCoZe4R7j+zeJoudfM2XPLmBxCDBD2ZoeCajh7Fbfl9SjyMaTj7JJdFkvrC8ZIhBc1QqyzFD4Er1SBFkitkc8+wsw8TYsT2MrpkGN9/ZMSSedxeB1l/19n/4Xi+Hq48nNnlPfxVzZY7FPScnRqT8BkpqHZ7+pTvwPz3PVkg8+SXHEXX5C1wdc+zQ8QSr9GEgjorx9YhjCVSx7Pl8Ni/rmYwAkc721TsrC3rDbHgZEedXuRDNPJAYDEAB9pcacRUBEO9TIrxrpEd1eIaXxyRL219WatY5CsabB5uASkPCE8rcNN4T3bqgMrAxmO8+8YV72v9gj+NXu2ePiLf1Ys8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(82740400003)(356005)(921005)(7636003)(40480700001)(55016003)(2906002)(6666004)(7696005)(2616005)(426003)(47076005)(16526019)(1076003)(336012)(186003)(6286002)(26005)(36756003)(5660300002)(41300700001)(70586007)(70206006)(316002)(6636002)(4326008)(478600001)(7416002)(8676002)(8936002)(54906003)(110136005)(83380400001)(36860700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:41:36.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93be3d80-f69e-4fbe-619c-08db8bf7e221
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extract get/set interrupt coalesce to a function to be reused by global
and per queue config.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd5fec073a27..802ed21453f5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3093,10 +3093,8 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 	return 0;
 }
 
-static int virtnet_set_coalesce(struct net_device *dev,
-				struct ethtool_coalesce *ec,
-				struct kernel_ethtool_coalesce *kernel_coal,
-				struct netlink_ext_ack *extack)
+static int virtnet_set_coalesce_one(struct net_device *dev,
+				    struct ethtool_coalesce *ec)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	int ret, i, napi_weight;
@@ -3127,10 +3125,16 @@ static int virtnet_set_coalesce(struct net_device *dev,
 	return ret;
 }
 
-static int virtnet_get_coalesce(struct net_device *dev,
+static int virtnet_set_coalesce(struct net_device *dev,
 				struct ethtool_coalesce *ec,
 				struct kernel_ethtool_coalesce *kernel_coal,
 				struct netlink_ext_ack *extack)
+{
+	return virtnet_set_coalesce_one(dev, ec);
+}
+
+static int virtnet_get_coalesce_one(struct net_device *dev,
+				    struct ethtool_coalesce *ec)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
@@ -3149,6 +3153,14 @@ static int virtnet_get_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static int virtnet_get_coalesce(struct net_device *dev,
+				struct ethtool_coalesce *ec,
+				struct kernel_ethtool_coalesce *kernel_coal,
+				struct netlink_ext_ack *extack)
+{
+	return virtnet_get_coalesce_one(dev, ec);
+}
+
 static void virtnet_init_settings(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-- 
2.39.1


