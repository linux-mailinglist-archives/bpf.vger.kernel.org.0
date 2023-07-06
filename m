Return-Path: <bpf+bounces-4198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C66749751
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55CA1C20AF4
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298B79F9;
	Thu,  6 Jul 2023 08:17:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017C1C3D;
	Thu,  6 Jul 2023 08:17:17 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967C1BD3;
	Thu,  6 Jul 2023 01:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQGD6lzOeA/IAg8gn6w5yzNpVDx332n45gZdjh5vCGPq6AzplvNCbGsbIeoDhW4nKjGpEUDWxU1S2Zeg5x8dovv+CZM2BXBUR/LDuArAxqFW6DGCIzs7VdHZSZJnSiRaDwu6b88Kv6G+iIKzitFlCWcvX4KOzD+c/4WYVjmA5Jw4xKDBFxFvTVJD1UJcmiZ7LeP0pDZxJ2WrI5pFpDReZor8GLK1UWi8yw8N3kFLO6jSV2SvvjuNEMLwIcgKRW6TxEeFGpfrXjBjVx8dBc2MuFRoYH6BZlBPTXyrUT7JD4kcLvAGn2m4ixianxdtvo7c1Azo4bZ4gTAtRo5Iw8tqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLRwXCv59vuptQfXAOAJE6Y1TBzkjUHbkt8CpsUbpuY=;
 b=LHDS2uwaNQlQD278GERsdnCtYgA+y/3lnxY5FNe3WfAWAd54y8xmXkDeB0rxEQD7LlDr5JfjFv1KRAXqvVzHxI6ZZ/8cWMaU74LVoJZH2owfwZEhXp+Ka+kkw+Bt9ujX5eULxWbEtPJI8AdhkhiaNl5SkakIUxRg2drlEYZz8fAy1N9w4Z/+V6vhNTBEYgyFIWPyAtUzhsgCmSEdgPBD3Rj+WErhTT6kQIeaQfeYCo5ZM2V8a81jI5qrF3/7E3VUxmYYXAO0YM9UJT2dw3wssqs3jbA5AdNWuCROwJgHU16uKb/CnI/8O2EKQhPvz7p0g8z/d/ixmepaqrUcr+9l9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLRwXCv59vuptQfXAOAJE6Y1TBzkjUHbkt8CpsUbpuY=;
 b=pZ9fCUzObE1L1/7Aa1i3Jt/Eotn2BatwUoFFqpy0nbge1nIuBaV/OZMkvpWX/QKDea6Yy1o9ySC+o1OnYBZVp0sQbUS5T6vpidzutrISutsFqOQPOWfmYmtMavUSdj6F1MZTE4A/0BZ3TClflThRp5j9P9RH2qLmNSTxLgODrsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:17:09 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:17:09 +0000
From: wei.fang@nxp.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH V2 net 4/4] net: fec: use netdev_err_once() instead of netdev_err()
Date: Thu,  6 Jul 2023 16:10:12 +0800
Message-Id: <20230706081012.2278063-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706081012.2278063-1-wei.fang@nxp.com>
References: <20230706081012.2278063-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a163be-09a6-466b-cc15-08db7df964cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oPiufv+bBynqxI6pdXhIdn89YwMoVWuRoyh4ZaKMWfMr4MHElC9Y64HVAg8OqKYuiE78gTQXKUX89RzgLK2m87HZy+a1gAeSVDPyRSIC8DdCK8SZeKxDocYELdkeLwvtFhulVhtPRVSE49cqX5Lma6ANzFGb4u1ueTHaENq02ACQIo6AY99ptTl0vBx9/iot6QmudM7KL9b+oblyyOB7eZ0FtiKHzJ9qFoX6ZzYRuCck1D6INlL5Tar2qOWz5GleFRo+MHA6DFXz1/a0+8KqgVYxcFSdurZDVe/fHWSjDwdGRBGHw5T4smgEV+HEWV/HaOZ2c0aXLLzpjC2z6CZ5AsF6+VkjGmOAX8qLNosL1hRJsN7PxvKOr3B6FzEGgy/JNNMU1MNMPg52+FIkj2t65Evt9IiX2r2uhd/k4b5PiU/tWUNyzNOq0kk8qj2twfIT75tp/j8SWJUuW4xSdNOP1Bp06e0JsKAyahUBUZDAKX8DwW7wxsAs7SpnQJsUk7q6sNtwYUT4yNFxdeYzymZ47T2a2jNcYWFW/ml0ggwI7M5YcrbwTz3iqIWJchT8nAgt5jRnHKes+i8KcAWGsDorq6Q8Sdws9yTt6dgSLozIiQ1yTvVr/0lj9ytqJyQ9BRfo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2616005)(2906002)(66946007)(1076003)(5660300002)(7416002)(41300700001)(36756003)(921005)(6486002)(4326008)(316002)(66476007)(83380400001)(6666004)(66556008)(6512007)(478600001)(9686003)(52116002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IcuYFogPkWaeYi2+UU0sUQ6PJ0nCoidFEIPd31XQeiG22w0grRhLaDlZM/lA?=
 =?us-ascii?Q?pXSt73siLxWaag8paO6H+j8GU5L/RsPbgsyLsq59oR8tx1aVp0oar09QHrAN?=
 =?us-ascii?Q?MjiiDTPyr03aHq1t8Laoa54E+FZBHwdpoWPOPVjtEZJggnv+2h7pfAjnXdpH?=
 =?us-ascii?Q?MNQWhHQj4meV7Owm7AFbFMOdUlnlK/JIV7CMlPw7yeL+1+ZMyySH6+JB9E3x?=
 =?us-ascii?Q?ati7WsJ/UE+aUSZ88QvLB94+ga7KKm/Ph7YEO54fu+0gTe5eypjS+yYRo9bf?=
 =?us-ascii?Q?Ql/VlkcLxJDmUj6hakw/ONiYoiIs73tALt92VD2A5Q/G6S0CB9qh2ftHguXD?=
 =?us-ascii?Q?sp4/HM7X4HA54R7Be8yHUaaW41FH5csLGG7LIFI3j5Vn3bT7AXTfWqhsjVIN?=
 =?us-ascii?Q?RTxLXWA8RsufCG8iRKW35Vg0L7oBph4zKQMJNU6b//d5ruRHQ3RS0ovtZWkl?=
 =?us-ascii?Q?/gGiSbbPpjwTVc8WYLsPIt7IzdhWZ+vXkEDTZgSRjnbEWR2Bgy4yYOmrRIZX?=
 =?us-ascii?Q?D2KnRItUTiGBaiHT4VABBIQ8mkm6RPeeCsxHatG4jeIuuY401uopCIEjWjWp?=
 =?us-ascii?Q?v6q5HKBs9rhUxe8WLmgZMCNJ6PlkwHUsjkZMa75339iNETHXfsUIs1Uz/Yug?=
 =?us-ascii?Q?s/7ohtr+wZZdv07S7s8rsnJf3iHZSZEKD/NC5l3sPZ0lIBfBrVrjjuYRF49u?=
 =?us-ascii?Q?j5xmP3pJ1uBPmVHzLXH9caRaJLmgKq8grUL4l7eox2XfAl45dueoPeA5lkJ7?=
 =?us-ascii?Q?sKeS9Jmd8GY6ILSu2xV+zudTLAmvQ9PEgSvMp252zVjQpP4YdfoeKhcwvFzu?=
 =?us-ascii?Q?Sad8zBaA/HujdD7Kf+yOUA3g9L9S6OzprybdrqwtjwSmmxOCj57aPG8QcaxK?=
 =?us-ascii?Q?aL0eOB3dw9VTBkPQcJg0o+B1L5sdmXGuaCakiqiF/edCWUykk6SvbMdTR6jG?=
 =?us-ascii?Q?W42PrixSjZPPeQ6+dlA9jRS052Oml1bpJ3QaEaP5FEyMV14bGoinWHfVK1MV?=
 =?us-ascii?Q?Y+xh8cpmNdlHwASyGSuiVnm5de1aSHBEkd786LCsW7iK6BayhhLCwH3Rr4jb?=
 =?us-ascii?Q?xkqnl/qFLvUayCSPfMmrMZzXWYYkdqa1/Iy7jg7ZQiy4sCd5RzTPmG+U2XD0?=
 =?us-ascii?Q?SP5bOn6KQvNObvN+dPaN0Nv3m0yUR36XsWr82W52Pf6fyDcM6NTY/ttb3lkP?=
 =?us-ascii?Q?mnnudrFWJzxYv4ICQD4pEN6tcRQFvKoT4oS1Z9Rr4Q/LqZYJJ78LHvVWx8JC?=
 =?us-ascii?Q?5OzMeXGmOWfxNOmKkEunpUskJQBkofEWpHaKP8oCUoNUK6s3qq7247cfmfEu?=
 =?us-ascii?Q?iCJvVxou4xMu06m8Md/hIfMahOE+4hQzsigC0bpdkszoZ4+TNBaR1KKeBpvH?=
 =?us-ascii?Q?JbtGRlohxYScIg2uZ2iIPzFHQe3Zd1rwuBg5y+dBQEQ8XXWZ54LJxW+dmrSR?=
 =?us-ascii?Q?A6X1jsHN0+SjLVPatX06z44CP5cSUxev6T7PRjNVNMk9B7ZgMG403+T2Q+e7?=
 =?us-ascii?Q?+CSK5uEPl9INyIO8sg1ids3bc7oghaxgi2OcygZtpAhW+wm/aAXDZOpV2bxq?=
 =?us-ascii?Q?7NzzA/zYgUlBZdxDomEmgyY8wYgO59IlwX1ICzRo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a163be-09a6-466b-cc15-08db7df964cb
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:17:09.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onmyxbH86IqXyG3cPqAsP7Kb+tqY/lRz0/oTvQbtEEQdHgO94H/jOgqS6QD/qr6DY03KVzKpZdKwGTHZk4TMBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>

In the case of heavy XDP traffic to be transmitted, the console
will print the error log continuously if there are lack of enough
BDs to accommodate the frames. The log looks like below.

[  160.013112] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.023116] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.028926] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.038946] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.044758] fec 30be0000.ethernet eth0: NOT enough BD for SG!

Not only will this log be replicated and redundant, it will also
degrade XDP performance. So we use netdev_err_once() instead of
netdev_err() now.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 change:
This is a new patch which is separated from the patch 3.
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c59576ab8c7a..ec9e4bdb0c06 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3836,7 +3836,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	entries_free = fec_enet_get_free_txdesc_num(txq);
 	if (entries_free < MAX_SKB_FRAGS + 1) {
-		netdev_err(fep->netdev, "NOT enough BD for SG!\n");
+		netdev_err_once(fep->netdev, "NOT enough BD for SG!\n");
 		return -EBUSY;
 	}
 
-- 
2.25.1


