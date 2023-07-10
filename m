Return-Path: <bpf+bounces-4579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78B74D147
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 11:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBD01C209E3
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2426F101C8;
	Mon, 10 Jul 2023 09:21:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA284DF6C;
	Mon, 10 Jul 2023 09:21:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D0EB;
	Mon, 10 Jul 2023 02:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGx1Cy3B+fvFSE0xF0Ufukj+ggkmMOJ1Vv3iNJ5G82FqeYHzOGO9wuh4Or5T8J9rB9jw/Usv15XsnGSwuFZ0JRGHpnFHNoamXP3tOL17ryKhrC6pYJf2HxaZE8b81UcnH/vi7aGhoCz9DmacCNs4XfZaZjWcZrZLA99yFcSohC9fhttyYlQLYNeKbOtzdYv5d6L2CqIGmhlbwgW2slphGV8rJwLYtflXX/+U365cuBKaZ8t52DH1DEJ6Hx5FCC4Lz4AQtwzy8gJbF4YEp/eI140f3XF+KGPWOKItP1THxyDVvIAVBX/B9cOfsPnf9aa8F+83h3GxFX31J3yQu66kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnwAzz5ZvOGHhKN+xXy7unvd0kcKuNmiauGFOL0S3gM=;
 b=mQN+GCbh7cadxSkPypvX1OzvkOeKP69vwYb6gfl14TDjnXd4iocXAL5h+kgkdQOlQrtUEk/RCXkRwRjvHEA7VO79B+v/ENbAE4VsEwnaNAoV6YzPJ2dlo0QaTDUXWZXGZbvzwspEhsWvuTYvu0jA5vA8rZmNQ1HNp98UEU59YeKo5aJZGpE7n1ZHTdAhLnGqG1s6AjvsOR+MZG7Qe/BuiyoylsE6BsDfppebT3KFG/Uy2dypeSg/aa2r6mnPruryy68bnvQbzbhLLdLIAOP9JcBNebR8SJw6b9wQwOe1jlMBZqTNYckbrciWh7PZxQzzSpy/dBp0bJa4i43fkWGQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnwAzz5ZvOGHhKN+xXy7unvd0kcKuNmiauGFOL0S3gM=;
 b=RrQA/FJMPiQ2rBUaDtDB6gxLNUiqTm6k+tDHuVkRmPsINXFxhCqvqryTU5X+qAQLJ/t8gq5maWGz9aXfh3tgerb6LV4eWm2+/aKAon9VeXKVLDbD+GOMU+NVwPzAGd8UMUCGk0jCRIWDPSUmFkTKcjMHUkYippg3oIEk8S4wi8zcgvtLX/n79pnEslA6j4T7JyAgLVeFq3AfMl4oI3Hu4jA/WpBGKjrPYOxQJbm7ZkjwJQkgatVbOx2NC6/q9qeht0szxDH/d3sABGULU1nLUYSLPv4OX1C0SkHWe5Sg8DGeTVFRybYEIuldzTK5v9FZfZU+Y7hpIB8pjd8O8+e+hw==
Received: from BN8PR15CA0065.namprd15.prod.outlook.com (2603:10b6:408:80::42)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 09:21:18 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::a2) by BN8PR15CA0065.outlook.office365.com
 (2603:10b6:408:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 09:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:21:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:20:57 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:20:53 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next V1 2/4] virtio_net: extract get/set interrupt coalesce to a function
Date: Mon, 10 Jul 2023 12:20:03 +0300
Message-ID: <20230710092005.5062-3-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e69d6d0-4de7-4d6a-35d8-08db812704a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vFUX1LGVEG1e4KgJ1fKiU4gEzUMjaRvqr6qDbSydAZkcisDG8EWi2BPKU7C7p92X5pCEztVm1sF+zDlKDVbcUpeHFekOL8VggLoS25HtDY8NdUv5vtn/0Hd1ljYlwWoZ1a4TXOVc5eBGDKPAJOisZrrHzpFbVpD4lRBlS+Z4ohrNOczIi6uLMO2FSqGk0RzgFH18nfyWetbJhuRki2X3Oq6x1Tfb2pRHE4RH8TIH+MrSc6G3MdCFhjXnMFT6AgUiA/L+Lv8TYE0am+H1uCWhJXCdKSkTG6u6V1X2hS9MXYM10er4jAz5ulhMAt+mEuYmsPpy4/euVVF4nQIRuvnb6Snv7ceXDYebJdyuM8OzWsAy9gcv40q/HdmAxDkHSQ6HGAMwVCUs9+k8p0BUxfrfYXY37iOgPK5xHCQUUA+PAOUcMxL33c0gYAA0U+4MKgrJ/B/UhkkstUwgRzj3HXGQEV+JVQ/8GilbWgKBoOEVndTkGlO0igwf/PESHmfooq5o4uAw9jMq9FOPtTR8sIy+CXH9G0RwjJLJbcjlmhBKnP5Tc6IiiXzYmbBTZiDF+JHpjELapaWx4ynzDfCgeC+Qa3LrmSwn+CG0VyIJBEultnum4NMRaIE4+EboX1Jeh3v2KUYmfD2txV/E9I/ztrshJvx1jXaUzIxI0gYsIeRsS2VYYpDcteKYERHrVjGEpYemMfVj52KVGw9u2Q9SDlntQ3KS5mLPcxh9Ot+KKZj0ftePHDhV9rAvD68Wr5vUMam87za3pulgcxOuOJitWmfdP5LAAjSSmTDZyv7BWGrqd4eGa/d/L9+IkacpDgEFVYu4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(36756003)(86362001)(40480700001)(55016003)(40460700003)(921005)(356005)(7636003)(82740400003)(478600001)(110136005)(6666004)(54906003)(7696005)(8936002)(8676002)(5660300002)(7416002)(316002)(2906002)(6636002)(4326008)(70586007)(70206006)(41300700001)(2616005)(336012)(426003)(26005)(47076005)(1076003)(186003)(16526019)(83380400001)(6286002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:21:18.2669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e69d6d0-4de7-4d6a-35d8-08db812704a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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


