Return-Path: <bpf+bounces-10703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECB7AC62C
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 03:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E0B42281BB9
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75C363F;
	Sun, 24 Sep 2023 01:33:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259E36D;
	Sun, 24 Sep 2023 01:33:42 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75611D;
	Sat, 23 Sep 2023 18:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqRPZfiUkatgU/oBiEZO27DpQ3o1UOMSQ+RqNcapj6OGJDxvktNnW4H4LFV5qEwzjIOGQkJbA0At7B69x/S8B6lp+wlotDizjaUioVyd1P/RBIFBM2grYYz/F0TdWSTdGSN6NKkatDA7ruHeXBlkAmXeY0ekUvhWo9BdIYYAmdFzi5PAvbHQORMKuWb6QD9v2bRQpSYsU19bBA6FS4R0mgst7w/LRrjv2yrCcJwWmgHKUp03XUg6gT5JrtRk6I9wYdKSRyKMcvfGLMQyIUVRGr50iHFv7/YdyShniZQVBh2qUCasClBmaagoE0Z46uLjGYFgpiqgDa/EFyt4JOfi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPBHGr4d8D8McbJSo9Zz/VAuWF9uuj073tZYcXksau0=;
 b=YXDtg3110MCPeAXB4kTexytQopyh/R1AYV1OQUe08tg/dBu/8Pi71IXKWDwSkb92XQ1hb/jaNrhXyFdzEcpReTKRPibiN87ym1tmY6wDynxzV6kQXxXmYbyXMqRML6kOswUvcwWyXUAULvg8lR7UR8mdfn+Ga+Zv2HE5gJvC02kSNEnoK8lwdS7MyTiPiMQ59U+q/MdRhrduSAsH/JdQ8oMctutTtvvoFRtE2W35cdDeLAybjjnLGAbnm2lVHve+MEvSEmcO7zL6SjOouxZI6v2nMnEj52BnxRnoe0CTFS0C6vkth6CeNyHdRoDkXRw6J+l8Ytm4tUznmKZ3nWNE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPBHGr4d8D8McbJSo9Zz/VAuWF9uuj073tZYcXksau0=;
 b=edybGDfK6+Rb2C6WQquo3rQ55PvFHWCtuoMkX80M5Q51zpeccPBcZrPUxtOygTlsg2kcbBcJIdp66IRRRHaIWd2+wmGIxmL0wBHZFfcvVWPmqq3zLGdMVUGYPXFcW/FFHk3hNKUkJJmSZUyskSTyL4yJwEN18GMQ41ReKHXBwpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by SJ0PR21MB1323.namprd21.prod.outlook.com (2603:10b6:a03:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.14; Sun, 24 Sep
 2023 01:33:38 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::827:4af:136a:236e%3]) with mapi id 15.20.6838.010; Sun, 24 Sep 2023
 01:33:37 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
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
	stable@vger.kernel.org
Subject: [PATCH net, 2/3] net: mana: Fix the tso_bytes calculation
Date: Sat, 23 Sep 2023 18:31:46 -0700
Message-Id: <1695519107-24139-3-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|SJ0PR21MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: 334162eb-c530-4449-d3b5-08dbbc9e4685
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 /Fgl+lRoWZkDJnC/oYgWOXbr12yzKjfAYVnZgfciZ+Qm97XcyXmWOP6vX0sz/mgLQT4y8hzRPwRqq/7C03r/ZqOQaVO8f1TaOvDqW4NvMWL+lXqtM5L4/MzZyGSLOKtEI4AMbsAznf/ISjCV0n17utHHdg/JjpDiyY68Qh/V1SBvmMaO/qKpkOjeMUYE3l5Id07rxuwM30h+oOtHYuPDmZMgXqXYAkVaYkytK7rRq8hoJTdWDaD3RPmptCSmYnlb2nGMipeiZ98NQ86ghkFWMSBDiE2o3D2EL6FRkhuy1QfySGqbN1aH36oXvmm1q8DarsrNl+JJfJ6htk9+Q0lhwIp00y77bbTWQPboey8JTcsCFmpN/F8fAYVYeDaSlIByvUK1Y70Dye4EaSyw9myBsnpuvYI7Qt4KEr+CixUHb6dezruv2IeWVC9JUA8Pl0CKD3SvwYMCpOO029/Kew3Ydn18wRVMNKUJNa4omLrARMbYgCmdD8IUdnP5sr8NxFEMIRiaGLTQuZ7x8QwtIGnwTllPY+zARTDIO4OVkhG1CjXYzrF0JHfFPNR/epV6VVaIveIGInUSgbJtoVtyKe2oi57U/50/xG0RjDCpJUChQszhqWCsLSHXOB/kKjHBg2wWlgy5WCw66y/gZLdjSs/uPQINmJqccGa9MMNHUwGanVI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(52116002)(10290500003)(6506007)(6486002)(6666004)(478600001)(83380400001)(6512007)(26005)(2616005)(7416002)(4744005)(2906002)(41300700001)(66476007)(8936002)(8676002)(66556008)(66946007)(316002)(4326008)(5660300002)(36756003)(7846003)(82950400001)(82960400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?1k9Pm0/rbZDuyIlafAuARAMTLF8l6G6uieRSTm5Akbf64eMYo4UuoZSNqZTU?=
 =?us-ascii?Q?6/kJrSNwNmTIu1NBAWijmmNSPlHzNN5zyiik/tJ5uzn6OeiStLKApsi7jvYx?=
 =?us-ascii?Q?Up6PfzRuZyYgzpNGSFp5o2+6E7evUFBlABc2esfTWeFcPtBc5rdeqebvpcIX?=
 =?us-ascii?Q?6neGaCrX5wDI5E3GMjuF4g/spKOhW1UUwesNVFNJ//FmmUf2C8NBcVC86HJM?=
 =?us-ascii?Q?m043MctrjHR8TvILIeBaLh/kWIMANsVPd3FY2o/sotPXYzJrUgtlyIFzgvoA?=
 =?us-ascii?Q?Dt++jR9Y8me32PsAcI54jUeLnPayHVkRxCMJTIYBxpLzKdFz7IMVF91sBNTg?=
 =?us-ascii?Q?w0aVZ0FeqI2iAp2jTkhxsx82smKKfm6fsRggh+Z9zkahNjH3QTBWJ2ob0XIE?=
 =?us-ascii?Q?euH55If7FQ51g5IUasIfMCPBkfSDZYql85ooTmjQwbLGehB01epdcnnfgpsj?=
 =?us-ascii?Q?iWsRvvW7YkClfb29c5SLzbOJz3PsC927cWylQRYKsmy8Wtty02PoQLSWhgkT?=
 =?us-ascii?Q?cCrMAWfTacNEvypnKAGQza+8s5WWtY9p+Cvk1WbR9L0BRibVRlesTS1gWydh?=
 =?us-ascii?Q?6W7ARN9qbprmUk2RAT5Bs1MwemSOmzM0HC3DQU4FpgEUIh7m+h4rSVGjDX25?=
 =?us-ascii?Q?LlJlno5upMYllXWXqxHaD7acoU77vaX3Gd85MJUJ94tBwT2uvfTsZ0I404a3?=
 =?us-ascii?Q?UdtzX2K6doL3WQpBHxgSoxy/eupPWj4oBHBpkWNhwhFs8GpexsCnLzoMoYII?=
 =?us-ascii?Q?mR73whRzXMELQoeJsA3zu/EtL6GTqXW4VYmtmkcIlyzCt0kBxs4qTqVzrnoz?=
 =?us-ascii?Q?qFwMnwcZb8Z5Fru81DmnvnM8GS58vL9KRQcNujzQyNKEReZcKFgJmBYMm3/q?=
 =?us-ascii?Q?17kOJ+u4gRWkRmpxXdMFRcD/9oxbuTs12hB30b+Wq7XSjNplsVduBNWSaq+3?=
 =?us-ascii?Q?tF5l7GYQYfERhgEu95bM5nDiL3sLYXzyF+lNpy7RlZcjJvrswrl4qVMKL0bW?=
 =?us-ascii?Q?EXTLlFBX/SV9jk56A3WEoLmcIi1eEBrCAGrqj47auwTNmZCb3MXUAwobT4C7?=
 =?us-ascii?Q?LDIMAyRWK7dQ3/d+ALSOZXPsC+iy/kkndUdjmWlv/DmiySNTPwDs80d3RuuD?=
 =?us-ascii?Q?uNNDvmbgYd3D6YI18mhPnMaRh5mRIzLrAlbvWyo9R13nKfuElFVPoKzYa2Vx?=
 =?us-ascii?Q?4yzdETQN4FyD8UcK7Vp26GpaFzgs9gX2bDIxalhZU/tKJyymPcEtFRRvKmL6?=
 =?us-ascii?Q?3G+T1T4u1v6Au4DOHBfziK7+hsByp9y+zCYV0+qTJnVDLY79+o6g48xGaQJn?=
 =?us-ascii?Q?c1r9GTli9TRrfA+2Wsrl5x2eaDt9FTEuHluQPmMJBYJJ26q51/iUGDlaEZ1R?=
 =?us-ascii?Q?EBbGifNM/3JpVPgUWq6yJISc9ri0ORvYTX5QntDxC9DoLzUSbcS/e39v4PUu?=
 =?us-ascii?Q?ZDCg2BTj4UQvvqv6eo9qItOcVKL8k/aphOadT/NYTAgUXvt/nCq6FL1h5aJi?=
 =?us-ascii?Q?7uEwnWxL16QhObDYkYWxmbhNuMh7xEZHgrx/N8w75YsAkjPnkt4frb4LxcCj?=
 =?us-ascii?Q?+eEBX85wFix2HSJV5MW1150/0Cyr2wmJaum864ez?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334162eb-c530-4449-d3b5-08dbbc9e4685
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 01:33:37.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCr8iJ9x9XOrto7M95QBXFnOskYyiRkKkPMYtQSZ8CmFKtFmkjNK0uZ7XGmvlHgjNO8YziEh4Jtiobtz/T59Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sizeof(struct hop_jumbo_hdr) is not part of tso_bytes, so remove
the subtraction from header size.

Cc: stable@vger.kernel.org
Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 5cdcf7561b38..86e724c3eb89 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -264,8 +264,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
 			} else {
 				ihs = skb_tcp_all_headers(skb);
-				if (ipv6_has_hopopt_jumbo(skb))
-					ihs -= sizeof(struct hop_jumbo_hdr);
 			}
 
 			u64_stats_update_begin(&tx_stats->syncp);
-- 
2.25.1


