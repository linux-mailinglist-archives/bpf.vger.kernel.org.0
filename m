Return-Path: <bpf+bounces-4587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1674D291
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9586A28113E
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C991096A;
	Mon, 10 Jul 2023 10:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E410954;
	Mon, 10 Jul 2023 10:00:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F5170C;
	Mon, 10 Jul 2023 02:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3we+FhqjQXn+HbpCqb43yEkd1/NNYftExOaVuvGa/epsIFwH2GBh1k5NDcG/CK6GU3Enu5jR5fk+5CWEFUg3h0Dl9tOd00XkiNIdKXHUpPXHGal2hurvc7WXyIYh3JVfwf9iQeeYMbuV3WiIhdikl4ztCPNKaztN/JRUM/gN7hSXkGMPdRTrR+0YsaiLfDcMgDbkzLYdl9m5sZ3nvwQjI0WacVpA+4d0620ET7bweeDSZtdXE3dxaH0cA2j6wVcvZqtsp2bxOHwh89X+ps1vK3tTmC9P5mTh986pp1CrPldhZvKcnGY7PhlACrDgEEFsS4GMLGH+W0mGJQKSgcWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnwAzz5ZvOGHhKN+xXy7unvd0kcKuNmiauGFOL0S3gM=;
 b=jI9JOnSqPcxeFzAYpBfzcxwproGpp07UwfIzmZ+RJgKCw91ngZ2UUuGB4IMq1/oWUA9Ooj5VCb/9GK2HcAwXTH5v+pzusgqj3MNCYDXT0GBkCi0/TaliDpz3bT6Q9UIeG9euEPfBMUq5kSstk7UKW8pW9O0jL9CMR/2Ugnrtyx0cduilZrq8qW6l0FdiRLQcnQYrYWBwKXOOCu8fRmpCWUReL0NDEAGVKrTe+9UQWrgqTFHhwMBDx5EebGMa119d3rGkqBUM0hXuJcnj1IkZRXiNYy7puO8zYmKWXDvrVqKkCR6Iws+z7+EoFTaup9du60oiRVJqPXDAHFsW6aEyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnwAzz5ZvOGHhKN+xXy7unvd0kcKuNmiauGFOL0S3gM=;
 b=ofaPq/4V0uJ7LgRLEWkZCXN1qtP9jqr0MO7aw7nQ5/9achAMlHry95eZcAfN7/Tl9o75jQDRSwg0rky3r7nKtgNlo8ZacHsBr6en8xsSATkJCoeNRySKnqLZuvs4WrrLzDfbFqLMn5y5XKBIQ3hgHiKaE55aEAkss68i7Fw+bCNoz1QPu5vMoJZDAAHAQylmuze5Lp4Cby8lGspXR9o3BTxt0ARcBlXWuN0ogne8K9PzjnbbkslG5pq3Uis8FDH7qqYAoIdYeEUboGj6VfrP/lTxeIUlhdDHPP8Ol+whYOWSZ5k4+8LVNaBh8jvvyDaDZFNAcavDD24EgGnBRh+NuQ==
Received: from SJ0PR13CA0148.namprd13.prod.outlook.com (2603:10b6:a03:2c6::33)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 09:59:34 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c6:cafe::8a) by SJ0PR13CA0148.outlook.office365.com
 (2603:10b6:a03:2c6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.18 via Frontend
 Transport; Mon, 10 Jul 2023 09:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:59:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:59:19 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:59:15 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [RESEND PATCH net-next-mlx5 V1 2/4] virtio_net: extract get/set interrupt coalesce to a function
Date: Mon, 10 Jul 2023 12:58:48 +0300
Message-ID: <20230710095850.2853-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710095850.2853-1-gavinl@nvidia.com>
References: <20230710095850.2853-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: dddc8930-185d-45ee-4355-08db812c5cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pm1rERezufsNL4fBnaNBlh86lThhrCOaUzS+9Pr43dVw+7lBZDMzOj5qd8MUemdvBlbntgmtCZaR2B+L7eBKQGp97wOAdRuUK5pCB8L1s6xmp2tG8ozYkoSXBYKFbf1l8PIhWjFW9m+OUTWnJQ5ImdRYnnBrk7WsTq2I7TuedRyIikbq2q/G4DIo3wFnJqkIn73WnjymYwDyy+m4yCUkkSgy8si3EB+Juqela2OCwMqiR5wzFh/Xzxz+Qxd7Z9Z0HLn1IIauKi8jYPyCd/7bxaYpneaywmP0iitbbtcqmDxszoexGzJvHXBFDiva8WztbRlFQujhz6nOpBJ54va985LWvi/+VFYuHj9eqeD/d8wiXA8Rw1QYGoyKT0BdRwC6whBDjnfRC4iMuZslpMAvrAWjI0nTD9rDPWCacWnWJAisUz1f78lNN8jLT6lVulDEVNdY3Gnt9vRG3xqzhU6ThLOUrn0oZMSKH3U1z89xif8qwQ/O4+59w0QcSfp1aC3A0GzzpWLdiH3fyN5gYAOnh9AsG3revPkC/1GXh6+988Nei3VPi5rHy29RgI0b6VmGde11vl6ilC0ipghrPl3HYFMLB4dH9eWTNgAKZ+0bE07DkJWxjDdjWj5lDVVJ6Kxs7dui4iFgP9BXQqEAuVCXKZY5LffkPIrHh4Nk01RDseQQOc6YhrPsKpLQbAHltBcYtJkcqlmpXu++gI12lY24adQwojyU8jCstEBI7zlzakzEbyNrh4oZd06a69sAyKEFPa832AqdNpmUFevUfYWxDNG4r8itpvlgx7guWtUtkk8nxUqQw212CjoqOHzGS0wE
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(478600001)(7696005)(83380400001)(47076005)(26005)(1076003)(2616005)(16526019)(6286002)(186003)(36756003)(40480700001)(55016003)(336012)(426003)(40460700003)(36860700001)(316002)(82310400005)(2906002)(41300700001)(356005)(921005)(7636003)(82740400003)(70586007)(70206006)(6636002)(4326008)(86362001)(7416002)(8936002)(8676002)(5660300002)(110136005)(54906003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:33.9344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddc8930-185d-45ee-4355-08db812c5cf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
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


