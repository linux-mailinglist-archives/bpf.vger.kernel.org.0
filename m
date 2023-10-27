Return-Path: <bpf+bounces-13437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646897D9F62
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599F92824DA
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889E3B794;
	Fri, 27 Oct 2023 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XcnwuTLi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB739848;
	Fri, 27 Oct 2023 18:07:53 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE7FD9;
	Fri, 27 Oct 2023 11:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMCBn2kMiesrpcELmZ4QUbAQsZtbyZEURNdeXmwnH17QlLnRDNPywKZ43A1oErTS4hybnTdcasi+9N0OWz9V58wDmBwZ1N+w5eLKCBp8Z7I24vexkZ6doHUD2rhlz5WPYEjqE02WIdLB+2N834dDE+oozXRrBnGBy/S11WROobtryfmS8naykOdyF0wb/ZQatC/m6cPAb4v9Kq0TPqALcFLeDWYrDS85mmvyQsm+kpLDUguqF11EoLe6QJ0GJELB+dW9lTYBX+I4KlsNBANofGllb0b9Oyk8uUqd5xSn9m0SHiROheP7EvgHGygpB/H2pK58bjOLQeNWpo/jKRxOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShfL1zsfe+Uf5JILIL66mY9RziPKGLNbtlGosHYqzDo=;
 b=ROh5Idz1gChtlmRncAlYoylDAKHLPocDR5fH5zCqkBBo/CIIPxVH5XJo2mCmmGRXhEXSjaoTvrEKhoWbyHUnGpd9h8+TU68Mw/oSjEG01/M6c4EVTB9EfSzlpOH+drfIwAcnJGigX0/4+r5WdchDoleI4+GPenYTQWF+rNDZsTxK30ENY3L1cthOXGnbyE274mK+qyanhi3ShCmqlYEVQBGmi2dTvnOSAcfYOA92Nt50whBIyNX5axwkiPH5NL8xNg56v85MoSKuSxqe77FOEscjRV2oixroP8yICQUyy7v6CDznSo8N3gKzLAPwsyRCAdqEb8WnEG1jMEQ+5GnSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShfL1zsfe+Uf5JILIL66mY9RziPKGLNbtlGosHYqzDo=;
 b=XcnwuTLisY3hzJIDEKi52bx924hirKRXAGemtI4I32wKEX/rIhEdV4iegDN6G9zB/zwhl9K4w/VL90728lKMXGbBKrzw53Jezg6IaCl25fa7Bj0iy/IveOsKhtNytHN11i6ds6uUaAbVypcatfXU+CHsYAB1h5ka4zig+8e/9jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by MW4PR21MB2004.namprd21.prod.outlook.com (2603:10b6:303:68::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.6; Fri, 27 Oct
 2023 18:07:48 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::c099:1450:81d3:61dd]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::c099:1450:81d3:61dd%4]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 18:07:48 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	sharmaajay@microsoft.com,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	Konstantin Taranov <kotaranov@microsoft.com>
Subject: [PATCH net-next] Use xdp_set_features_flag instead of direct assignment
Date: Fri, 27 Oct 2023 11:06:51 -0700
Message-Id: <1698430011-21562-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|MW4PR21MB2004:EE_
X-MS-Office365-Filtering-Correlation-Id: af73b9b8-c548-4c37-d48c-08dbd717a04d
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 5y95vUVM5C1JjxGgHXqOEcQAwA5wK0icf0YZ/SRB+IYaLc9WGMZPvlLRwI1Ea73BRBJ3SHMV08GTCYAuUoqOLB/sbiQJw3CmmtF4RVpQia18WqZtIyJstomu88E3bwFlENTkF6U/a9bSxHgcZcN1QIUH55IZlWiE289lWPy92ivWvFRNtNJZeR3Af4oNlBUxLrOpE+TJg8XAE7RdXT5MGJaGZvIyeYcSv+0kpP0uD31vM08DT0vxpm1IjECwwZhklqTXPKa8Y4STPIUa/0eR04nhuwK7iuVdh7CE3tVjjCMOIYTr+jbJc1acnsEHvlc9bQgU5x9uMOfJ/+tTtcSj6QdXeLFpcj5SlWeMWiz7kHKWYIMsR4xtMX4gogphjJpJMpC4dQowmktumWxidxksuobEHEmBJG4g/1hCWw57029KCq+rcrfqRRUwL5GFOJiLSNPxiFAkaYkuZsYLEV3p3FiZrE3xcYCFiVwQna1Mf0YVVCLsH3WTucIQUrf2lkfNXkkvwroF29suin5evA4o9Q2FpdKiSbLIcEPhTI7Bf07ccG2WHvDcvTWNQGscWXEFv47leXtFrqEKlLKQ3Sds/6nzsgnHpPAgegEe8WlG1+vLxV2hERPbHtwBjunWDsVIBmM1mRdD91np+7MKcWt9TzutAgB2GTT2znjkmXOoF24=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(7846003)(6506007)(6666004)(52116002)(10290500003)(83380400001)(82960400001)(82950400001)(107886003)(2616005)(6512007)(7416002)(38350700005)(8676002)(4326008)(2906002)(6486002)(5660300002)(8936002)(316002)(66556008)(66476007)(66946007)(36756003)(41300700001)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?+DaRE5YgmwM0ESVce0CLJ0I3afDkPVOZu7TbkVxX2EhXI9sMmf2FKH9tivDk?=
 =?us-ascii?Q?yorjjvWNh80sKgOneP7uGtuO4RNWVHmpGPsZULptwfcTLE/2+1n/SHwxIA3b?=
 =?us-ascii?Q?jIQo3wA9WQCbOtSrHC02KxNo1pFW+pns0slwgg9desyuJfScxvhN5MJJGlSZ?=
 =?us-ascii?Q?ufXtODneChKUAR7Q/kG2KpZusETK8oS4Mkek2/WUfSKcBaSO+BQ8NDAspxZJ?=
 =?us-ascii?Q?JoHu/oJmHsYoouulQK5IVYz/p3Y46/NOYu3LkEh3NfvlmN9S3mNqO+QWArmL?=
 =?us-ascii?Q?9jDmpZMqpQG4DrG0i3Q0RNCjljKgd5XJTHvGL6veNmmYqhllGSXO3LwrvtRg?=
 =?us-ascii?Q?I2mP029AYNoaRjTPlpeHO+I/GdJeEZntPPUKGsjs0M/HKN7as7NhaC3b4She?=
 =?us-ascii?Q?1VETzH6NscP6WY3iBnn1JOtl0hChclRrXZxUL2vbD6JCslk7Xckc907LheQy?=
 =?us-ascii?Q?aOLv9nz7u9FXyYzsgmlBScCT39gI42UiGtlOPlxnVJUBf/5XY2NWSaviWJhl?=
 =?us-ascii?Q?EOUiaZo5XM6fgNyPMcvJINNMlqDfNitlJ1YK7azv1Dqa3OtxvDGNM6ZA92p1?=
 =?us-ascii?Q?1R7aYVqxjdL9P+4uty8A66gFrMbRTh3VRk9gCeGqpE3hSNX9OcHFV1H2g3Of?=
 =?us-ascii?Q?otnsZoYY9b9unNMakjbVo4joCJ4HOgyGHy9EqYIZXeiMHMPywIBoL0geIG+e?=
 =?us-ascii?Q?4y0ieo/rhEWJWr3KFGD13iOGWyiT6rkmsuKnVqndzbX/DUZ1G9350/ss8BK7?=
 =?us-ascii?Q?FrYv7EgeeAIkrYfkQ1IzPfKF8WuEbkXJMn3Wsj4cXfISKrzaMe5c37xF8dD5?=
 =?us-ascii?Q?gYfKxypPD8NlK7u5DX6yUnleoYt24v1N3rsb85wpAp7c1p87Odq/J8NWb8YX?=
 =?us-ascii?Q?Uwhyriw0unY2z2H3GaNdux/OmaeJVytuHrzTQlfkVA1x8VR3s86abtxGBn4d?=
 =?us-ascii?Q?sSC+4XMgc8t21yrXztDZB8fH8MqVJvtyGhsB+1MDuB5ZgJuDrnFSstoI+sE1?=
 =?us-ascii?Q?1GfUplNklWwjrWncjuIdYXkk2vHlq5g3rRsQ8WpAZy8y5NKRlKUM2QTLVshF?=
 =?us-ascii?Q?uW2C+SqiF90PHEp+zREqIpX1lnU/FhowDp5exd7S32aM4GaGBHsnnHGxVZNp?=
 =?us-ascii?Q?BxxQQ+n+kl9+EuNJrpc1TT3ZaxNF5E+V2x1shnMUBY1gewFmqYkLtc1nhRCF?=
 =?us-ascii?Q?JyAYSAMCbLalkUxRrXrOXglseRWCXZHaT3QmBq6Sl+VtydrEfsRmugQg4x9g?=
 =?us-ascii?Q?JhG4oOlqvmS7JotofXjJqWcXGBaeFCg7oui4/FJjElblgNY2ae+WdAEHfxtv?=
 =?us-ascii?Q?vfg6vDpoUgWCfxBpvhEgjsuLJCFsqUF/FvGZkDG92vtAM6B9xiNlADCQosiZ?=
 =?us-ascii?Q?evKZWCHsEgm7c+E/v1s2sDep/RVj/RAayB4ZleAJrDdOVVrxHAszIA9OP5Re?=
 =?us-ascii?Q?Ah+VQiKbol3figxggw7QCWdNoGMjSnjnrPO+g7Zko2BaO5NRIq5esWbARXyl?=
 =?us-ascii?Q?Y05AT3gMZ0btExyuUNWHCblYdMk1gZv36uDhn0FZBfBKEsA9cU57oMhvDzFR?=
 =?us-ascii?Q?rKaUBghoIqmEtVcLDUF8ckCWxCEWXuApg+H1hNPe?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af73b9b8-c548-4c37-d48c-08dbd717a04d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:07:47.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65i/T8yZ633olQs8clDBWRG5Otb8rk4kodq4yW52YU49kZpXHViVvdz8aZXBDFvc8Rum6VkDFaEe2QpgGhXOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2004

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch uses a helper function for assignment of xdp_features.
This change simplifies backports.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 48ea4aeeea5d..035f24764ad9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2687,8 +2687,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->features = ndev->hw_features | NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX;
 	ndev->vlan_features = ndev->features;
-	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_NDO_XMIT;
+	xdp_set_features_flag(ndev, NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT);
 
 	err = register_netdev(ndev);
 	if (err) {
-- 
2.25.1


