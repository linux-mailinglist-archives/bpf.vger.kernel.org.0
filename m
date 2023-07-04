Return-Path: <bpf+bounces-3943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95D746C0A
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A825280FCE
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403143FEC;
	Tue,  4 Jul 2023 08:35:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D918468C;
	Tue,  4 Jul 2023 08:35:53 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E8138;
	Tue,  4 Jul 2023 01:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhGr9YTNBE9SSfyom+QtVq8uDNlIdyQmNFv/fLd20Q+eXAhx2KpmbgEcE8M/GHGGoy6Dj6fIyWhLHr9yBSdj4nx8IH3GEOBFpbKDLODIHcD7Scp05rYVKozxwskhqIxIKCN3iya2zd6YjW31UAMNGQQtJAcL2rnJ3Mo0ekdB+qyrIjVCxAecIpdOr5qgmubw2z2pMJ1/JaTyImY4mDKOoy7OwZT5p7bKjedk67nhqDmRyIWLmKzGSlBYad9783O16XIOkwc44DhVYQpr0esWBdOamZ/zEvIHIGyt6MDDkmaBQI6ZYoqGXvwEkxAjCDttWeha5otnNZBW0bLl/0s0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKwh4skTvICviWikmus1DwhacGnEq4RXoL8P+3xT/dg=;
 b=j93WB6dri5NbXaGPFYjgrI+shb8J03ZF1sKqbGSI86C/XREfVzsssqy5mPoAsfpGnp46y0mGwcDlOA8GLHQU3tGj3nqmocACIqDG60GLPDc1A0FDl30+8draDiLCEB9g9e1NJezqwaWzIaOgExEveUuA7BvNypKHoScgxcORzWvCDjOJGfioKzJDUnwIhLAvKM/Yiebop86lfMvw15qUtHpAHVjNnzj0TpjJFwSkMRHmyFuLAlvZl5a7l6wtFp15LjpsGKWGV1ivs5bnGZ03w4Ntk5SnM1XWr648K5DRT7AArzwDrXyavbGVO8bBQ1V8SCzkCFL53vOkospfj1RrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKwh4skTvICviWikmus1DwhacGnEq4RXoL8P+3xT/dg=;
 b=iYoKrR3aBCeIgQ61aJ1uF75r1fbP458tcs84hYcvZCgsT5sQbKWw1t4NaxXpnNscjzOfEb4MMSHlOHBqGIT9m3UBAhSO4df35NJ1N3TfQlJV/2Xj2WFrGQ4RbolqjjOsQ/9C+0/vISP3M+SbtJxOnnSdckLWhjVaT+Pm6UeLhOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:35:46 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:35:46 +0000
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
Subject: [PATCH net 1/3] net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
Date: Tue,  4 Jul 2023 16:29:14 +0800
Message-Id: <20230704082916.2135501-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704082916.2135501-1-wei.fang@nxp.com>
References: <20230704082916.2135501-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0168.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::24) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf61f70-19d7-4480-d18d-08db7c69a999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fJTgt89LSwGP5cbpSvmmlI4/dwuAeWwqqpzCXILYP5KCzhAPrh0gjyGXlZR8MsVxplTvzz3hcXwSDeHErUJAOj8njUdihg7orDtI1dA0QH6PNmcqlkoWTyJyj5JkFGBnoueGF0Q4F1kjaCZPT17UQF/jyEpGHV/un2eUBNbNDX8BgNQauv+LUYzrwzE6IKKBi4gRUbwQvBGqNfuVjdTT/0ZIvMHKVDmDPgr+9pIESRcvrNmUzofRd4V0rfaoL0E3YL5E0lYGC0wHhJ/Xm66uXMFnBO1Lz04qaXHyic//RnK7e1/FjtYIPDanY8y0WuAEEkpUJ+Gvo/sgeXHEsY52FZSEA3+6PMKnMUia/FmFJn8Ik8uQ8d699KEUtqwvJYu2LoiXEs2Ecp0OXgOzpX5v9sbwVKZ46hM4sMrDT34tbeyOvsk7nhOfuORoqhofsTUGGM8rvloL1iIxRvo4KAbqMQzFKjaJg8L90zFL3LM8827j3TuYVLiLuGARUgJWEZeHCaii/xnXfsOlVcGRNfLc1KftSCP9E1A3cmGbtjjx6NbW4voygrSrDrjsL3bsuPvj7R1BWlRf+5ZNnGGaZZSyBM6v4mGDvARrlmyCovORVE9P2NLUU1PbLAszVEBHkVpU5xE2uUOS82axVcwp9S9QyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(1076003)(921005)(6506007)(66556008)(66946007)(4326008)(66476007)(478600001)(41300700001)(38350700002)(38100700002)(316002)(2616005)(83380400001)(186003)(9686003)(6512007)(26005)(52116002)(2906002)(5660300002)(7416002)(6486002)(36756003)(86362001)(8936002)(6666004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5w5QM6aghxASRVP5i7sH/XgC4AouGNgUO+9jfK6x3iLI0fD5N4KLhywIIqWl?=
 =?us-ascii?Q?2NXVEj961uFTRBrqQV9N369kkVGbMS+J64wD2IldLVoxjZkNLGs0FAMzwOoZ?=
 =?us-ascii?Q?Ls1rJDywhdZ5mEKFd3dRIS0QMEYAE8CiDPnDmg25QTW1xhBvYgCIGCnLln5A?=
 =?us-ascii?Q?OHirSv79z2GE35FpnAX0wAcHdcUZSEOhYMwxbZo2+Q7U9yJmQ6PTO8ja/bio?=
 =?us-ascii?Q?v+y6wp4/fHVj60u4aAHGft5LrZfQSZvP4LWREPJbCrY7I6X7aUrFq2j3RDcw?=
 =?us-ascii?Q?epV+6iUeaBBvY83dc7O7jYHTMolQkAevUGbfIZyo3l81a6sAygmGwZk83HVo?=
 =?us-ascii?Q?fsYcM+oBlUZ/SdOzQnPYtfCENzHLGl0kZCB5iglriClXWIrizRQbK+WwrPx+?=
 =?us-ascii?Q?khQ9jWkttblwy7mb01UIRs/pq2Jsp6xep2+BnBbvZkQo0aNW/Kfs9kLtn2yB?=
 =?us-ascii?Q?HaYhWlx9R/zmyYpp7TDz7CB/HAK/e4Y1iebq/XxH5u6XATmMgij+nI/yfgmE?=
 =?us-ascii?Q?Pgx+ST+iJyTljspJYwjk35hgAbP7A1vBOGlf8BIss1LZkfhJJpucI5hiFbaC?=
 =?us-ascii?Q?EqVJvL3N9p5owM3usK1MBxZby25bwuew8SJBeXkozUbRsIu2+8MRvIWm/d8v?=
 =?us-ascii?Q?+erHbmlvP4n4k7SFrtbatqP1Bw7YPx4RZkuQXHwnkCTs+Bf4cc/WjqR/wonO?=
 =?us-ascii?Q?T4RYg8uGoND2yYTaDr0kTyrZz3bMGjsGLNTldWdMZ2z/w7GX9lNRIhBwf724?=
 =?us-ascii?Q?N0ymTkRewU1RlS1A2d8WVOcx8pxWAZzG4x8HVpdUqRfIuzjSzLOZD7LHZIeU?=
 =?us-ascii?Q?+fgHPGnzecKqMFKU36B6w2rp1tQvBLbwJ6NXvoJvRkKKaIQBHYPN8Jxa0ao3?=
 =?us-ascii?Q?wpvCC4RsBjNCDsWQWyqqPBI9wq2GXyv2ytlbcfvx9F2AUZH+ViUpFQynADRK?=
 =?us-ascii?Q?EhWazEtj5eQyUrd3BqOJN2q+wwmo9m7ppKRejo7I70Q0z8VksxxhkaUzH/0h?=
 =?us-ascii?Q?FBnkUsvK3WngExnNJRnhcsuKbMJisrf7fSJAShqpXwjxzwFieSW10v4P/HDV?=
 =?us-ascii?Q?bL/qSiC5wg+nPNPnECxjYlRie47ZUfgEKDDNX0I+UXBrfPGGgfFlQWKdKgai?=
 =?us-ascii?Q?2/qeX74gE4FJLEMzfj7lRN2H8xXSHlGS6GZwTetVlWXzfQewu57DDQiueY+h?=
 =?us-ascii?Q?EjV8hc/JbYhHp6EgodYamuiKskhBqSuQvC+38K4TrrLMFJN78T8sozOJstaV?=
 =?us-ascii?Q?cBduzGemg9ggnl5LDiuXp+SRFq79N6sHMSb70OAHB/jauWURu2RpRpRvayA3?=
 =?us-ascii?Q?0p+8HFcTMrU3J1tdYQ1ou9hKc5MifAzr0+gDEBvxxzlGngSaUfjYetnXFPRw?=
 =?us-ascii?Q?WGFltLdlw3sS/nV2B3R3pvDvUj+anAkfCaxg7nh6eS9Cl9VErZgycXo/3EgN?=
 =?us-ascii?Q?qhR3R3bDQ+On4WdY4Ep3hOKlqHVfmCt53XRtV1udpuseG5ZB9nkdei7wYHc9?=
 =?us-ascii?Q?UH1O42IdaNRBtj8Wih0e8YHOkbeWTJti3Oov4Y6UTztzZedBbGy5ZnW0axUG?=
 =?us-ascii?Q?5t+fFC9HqnNjz+nkZSp5uHVrpPxjhgWhPORUwdQm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf61f70-19d7-4480-d18d-08db7c69a999
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 08:35:46.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxBmvTeF2JPBK3Xos4LO88d/v8CVwnqaisa/qnA4aZigrxkvOU1P1me7uA45W3+haGSumsiZGJSXh/vWMvPLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>

When a XDP program is installed or uninstalled, fec_restart() will
be invoked to reset MAC and buffer descriptor rings. It's reasonable
not to transmit any packet during the process of reset. However, the
NETDEV_XDP_ACT_NDO_XMIT bit of xdp_features is enabled by default,
that is to say, it's possible that the fec_enet_xdp_xmit() will be
invoked even if the process of reset is not finished. In this case,
the redirected XDP frames might be dropped and available transmit BDs
may be incorrectly deemed insufficient. So this patch disable the
NETDEV_XDP_ACT_NDO_XMIT feature by default and dynamically configure
this feature when the bpf program is installed or uninstalled.

Fixes: e4ac7cc6e5a4 ("net: fec: turn on XDP features")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8fbe47703d47..9ce0319b33c3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3732,12 +3732,18 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
 			return -EOPNOTSUPP;
 
+		if (!bpf->prog)
+			xdp_features_clear_redirect_target(dev);
+
 		if (is_run) {
 			napi_disable(&fep->napi);
 			netif_tx_disable(dev);
 		}
 
 		old_prog = xchg(&fep->xdp_prog, bpf->prog);
+		if (old_prog)
+			bpf_prog_put(old_prog);
+
 		fec_restart(dev);
 
 		if (is_run) {
@@ -3745,8 +3751,8 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 			netif_tx_start_all_queues(dev);
 		}
 
-		if (old_prog)
-			bpf_prog_put(old_prog);
+		if (bpf->prog)
+			xdp_features_set_redirect_target(dev, false);
 
 		return 0;
 
@@ -4016,8 +4022,7 @@ static int fec_enet_init(struct net_device *ndev)
 
 	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				     NETDEV_XDP_ACT_REDIRECT |
-				     NETDEV_XDP_ACT_NDO_XMIT;
+				     NETDEV_XDP_ACT_REDIRECT;
 
 	fec_restart(ndev);
 
-- 
2.25.1


