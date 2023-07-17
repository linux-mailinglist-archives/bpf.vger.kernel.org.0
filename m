Return-Path: <bpf+bounces-5093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9575666E
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA56D1C20B0F
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E2BE71;
	Mon, 17 Jul 2023 14:31:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B526C8E6;
	Mon, 17 Jul 2023 14:31:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1A1700;
	Mon, 17 Jul 2023 07:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy8Rg8QXcfBUw3RzC/CRgDP2d2ZJyUbsDXuTEd6E9a4bdZ/34MRgFKxZJlNieQYRkcMZ+5uPD8OrY1C3IThsQCLqY5kH4zWMTkTD/l5bcSeEnTYwRYZIhgav9uotDKRviA7KqE8iirsOsEhtY7PlY7QVCmp0Q2dsgxToNBY2PY47XGleeFcW36ahUY3bRCrwP/ONuK9YuaFht0lbAHST+X9bO/KpWce/wfruy+LDFa5hdRun6IaKKwYlmMF4k1r5nlm3P5mTAztLPPPYZhLhOBnZHMS8p9PIzx7fwY6pAH03JXlmlAyoFtBvaTTmtwZMf5EdlZ7o/Sau3YML+s7mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HnE17WXvUiKdousTex6K1czsq9mCbCP2v/hVcbXrVo=;
 b=XlreOFbKiYjNlQsohuVaUp8K26bT8HrsRTuJbVx6t2w8VymWp/QHk1TZQRycl2265bfXrDdcU26RMEpdEhwG4L1nbO6XGFrkmUfaTcpzp0ugXoG0CC/VArJcSMlkMxE7fXPgcu/oqWyfwSqTmBBfsKigxAyBrAV+rXjJ//QbHHt3ulgA2gg9gqIRExkIQcxRKMT0HhU7R4uya9Yc1lLLewsuf3Gg0boMBw34GTP+PxzjmmukVZcpzBAN6BgIHT1yhZ06Sb2RMmBOIh6wwM5VLnqK+3pZ8guolpn3Q8LXhNrP1Ri44v2nValbJolyayZ/3LdN6IiNZ4ypGZbrQ/1vdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HnE17WXvUiKdousTex6K1czsq9mCbCP2v/hVcbXrVo=;
 b=cOrOdt7bTtC1GuP26rsti1uEz/6U/mDAEqRRjLOSe/zdlPkvoNiCGt1CGmOCuqUvE/8t80w/ndsR+m09JVBpZ+hhrAh8GkXYp14LQzF7D4Pku4fT1nuZihG6TmHSj2VSRc5+cV65fil1ldUxY/nA0dmbj6ZaYT+lERb0nP+uAhfwRD+JjXKtllKkQZ1RBzLcQiHkuHCjSPMxto6JImI76xjCPomVW4WWme3pbNwRaA4KPD4b6GAvN/KGle1xe2YDxyowtnbXcHY9aOyAFP/kruygsp3jtU/VLbFrznxqj8Lt16PvGmQVeGISKKj2q7nZZpiAQ8DmbdasftBlFY3seg==
Received: from MW2PR2101CA0030.namprd21.prod.outlook.com (2603:10b6:302:1::43)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 14:31:33 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::da) by MW2PR2101CA0030.outlook.office365.com
 (2603:10b6:302:1::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8 via Frontend
 Transport; Mon, 17 Jul 2023 14:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 14:31:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 07:31:19 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Jul
 2023 07:31:14 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V2 2/4] virtio_net: extract get/set interrupt coalesce to a function
Date: Mon, 17 Jul 2023 17:30:35 +0300
Message-ID: <20230717143037.21858-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717143037.21858-1-gavinl@nvidia.com>
References: <20230717143037.21858-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd93da9-b68c-4264-d639-08db86d284d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0xtLmoSPchXHC598K683zCrkzxHImS6Buv95nHYSSbjnQ/P/fAiSXRNL0AMRKvem8KSA9yUGfzUv9K/bqBImlhJTa4bOKYAzaeDo/1Jn2Ge4xmlLCwXt4BnMG+maoDMHg52CTM+3x8vQmP0bpWn8hxYkrqenTNrRkKsDMPJS0mQcMnUNryHQkp5ZLTxMKw6WX0z4oSDFmzv+edEV9o6Atgy0n8oGo5N964GxFK8QzMyjkoPwbzCNmosrKrAZCMh+iS4b4jzWIn7JpjyQx0cHsRT2NqoQQ//RIegzcYFf1rbmK4ZFPVwtl7ZS28EYiIQ8lI2NgStCKFtIVn7G8LBfFkTkQuUYyiQQOAyyTQHf3s0/24HrjTyq4S2GGcaZxg+sBos//7ix1UFqdLm6v1x7CGChJxwNn2P5yYgIDtNW/XSTy3gmfIJUZMPnks+SNC/nolNgoEFbvsKPLj3K3y6ka8v2s7Xg4xCSo/o9tWT+wGA1GR7EaCoLD6GMx2Ul7g1zdISrHo0/t4pjwPeIhjAo/aXI0FbW/bgk1IPiX85XwOxuAmD+qQDdayDCsIZh1fCgLc45nAAEFxRBRIzchDdFP7VV63Ie0i0bqb8X4uP9QN2JqdO1w1H3OPypQ7arslRQAWBqc5A+YNKHFExrUTigINePe24fyZLvcBq6RdGbyotqC12e1KjH8ZG4okfOKMQUF9UOtV9XDzI4gtu+ZO5T+ltitPvdqJmdlGoVrmxXDtAvpISHr35Ogtk2M824cwwfYzm3oPb2KAPV3+COGoWrRmnYm9x5Fe8kuIhamYBfor9B8b+9PcEMFNvaXZbah+RF
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(36756003)(7416002)(40460700003)(55016003)(40480700001)(186003)(6286002)(16526019)(336012)(36860700001)(83380400001)(426003)(47076005)(1076003)(26005)(82740400003)(921005)(356005)(7636003)(70206006)(6666004)(7696005)(54906003)(110136005)(70586007)(6636002)(316002)(2616005)(4326008)(5660300002)(478600001)(41300700001)(8936002)(8676002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:31:33.2045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd93da9-b68c-4264-d639-08db86d284d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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


