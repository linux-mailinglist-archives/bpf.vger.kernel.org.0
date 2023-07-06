Return-Path: <bpf+bounces-4195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47F74973F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA2B1C20CFC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF34408;
	Thu,  6 Jul 2023 08:16:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82215B8;
	Thu,  6 Jul 2023 08:16:50 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3E1988;
	Thu,  6 Jul 2023 01:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkpUu3JIDEEtnLRr9DVpehXTY1q5yIfyQra+AP3ag27HZoX1bgm8rsOriTTv7Qrv9w0H9kVxsXUeOfB5yT7gvR6gTUf/nwsLx47tM1seTKrQ9eAP09QYC9axIvk2c2Mh+w7TpiOcxh6zlQxWuxHtKgzvbKXWKzucBsp79XLC4VfQHtfdG0ZEKL9klt1nT1KvB0hzqLAxZZTlgJiYA8Hyjl1ai1d52FpfBFGm47HqDzoiZxOchr4yX3zvOZQzZ5JDOIAjsARN2BIOVqHqtQuQU+hviH/6QjQpqRjP2bM9o2Df9n/ql6s4mGwZDYvdQFwaq57bEf83CJSPMMktNfG/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj4R7Y5dbUrxgslYFEgNMVMvIZXmB1XTJV0y1X7ZxOQ=;
 b=c3NRdMTRzfly9AA2rw8A9lR9CSQkYUAN+2HTcTZ8qseMYsPwdL918yXL8/BegI3020YF/dXUXZyG7pa8l3CZGZHskEWGboy2NuPPGDzgG9WDnaiOluIxlcurkx1DsrMQY+c1Qle5zllEcyriHiWwJM5rg+dbeyMR8riqMMBfyUPiAdEjf5qA9JcXeV9jZ760I1vB4Zy64xS3IUacHRZY9fxGQZUZ39RKegbFSCvLXzrwHh15bs8KBDRFHsWLDQKUrMjYjk3DxaumSLbcnOLa2jdLrWLiRwBYMc1h8peG2Dzyjtq76aA/wYr5qLEO2z5ckuT6cCCart+5nLt/zFmcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj4R7Y5dbUrxgslYFEgNMVMvIZXmB1XTJV0y1X7ZxOQ=;
 b=S18NEYlt3zD1JhPRAam6z+9CmrmV6qkpAejqMvvuaxoZSd+h4beVmFp7sCI6x6KoxTvKV6jQOyyTsMp0qgZNBgHTeEiUWd4faQzfzlTZGyyZbEUoPYDXr0M7kmZGPBoWVdhFTTKTibxTRIvOEUo7h5MxbpiOfjR9IH6Iw2G1iIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:16:44 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::1edd:68cb:85d0:29e0%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 08:16:44 +0000
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
Subject: [PATCH V2 net 1/4] net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
Date: Thu,  6 Jul 2023 16:10:09 +0800
Message-Id: <20230706081012.2278063-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c350074-a6a2-4163-7e23-08db7df9559b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X3LyRV4Yek7A8Ydjrpj1VowhYWvBuLbu96s3OyVydnhqIs+Z8BbrnsTh86Mxggr/RusrkA9PpOLzDg+scTd70OQX8Ezo1Mwt+Rm7oeqW5hdPd8H3b90W7bLmRz/Ux6/1tjWbsYrg/dgaQQMwdYIg73iGL1fUSu6ml2/KA3EMnmjbO9Xk5sWh4K7JjNxVBaUxgQ0oCueTPzAqxE/E2Bd7GfgGRZucJjvt2UOlSH8wIJEAZtwx7bP34Ij30kcG+P/Q76OisuHkDPlMnUl+7BOnHe/ztc5F1K7aAwNrlV1pq1ytCe8cgzr5CsIfJm0AZo71spvN2NSGN8xSXz/S0260kUx3M6n5tb7qmPkpRUBkznHruzhPacvJ0el8PJ3fu5v86594ZfQ2BvxBmPuk7Ns3Oucop3Jyx7XV6OonS8x4MxnwMjPfXGflPsGm2VJ/ku69UgPIpYWRmPmM8rC0jrspAnqTUMbOS/+qnxbOsfIltklSKO8dyfysatiKBepZRMxYdJDnFUNzJV4COfrA03pDAxSHC3FqacpWKyyoYbnJNaG8m0PismnKGrWyt+LqietIXMPPDexTMMB7fGNX/ii466lrFMQTChyX/3w/eHx2Zsrj4yYzHp+prvGuBiJHutFuDIF3zFEQXSAKmhyzTEj7fQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(186003)(8676002)(8936002)(6506007)(26005)(2616005)(2906002)(66946007)(1076003)(5660300002)(7416002)(41300700001)(36756003)(921005)(6486002)(4326008)(316002)(66476007)(83380400001)(6666004)(66556008)(6512007)(478600001)(9686003)(52116002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sa0/J4gBsm2P3ie+43HQ6vSJkXNx5rCXlJs/y68bt44OIz6V7DRAEBga2UDS?=
 =?us-ascii?Q?nVOhAqeopYCo7OiVaTJwcpU5/cvXzXUWvPCwi6+nkB+no/Qxuepwy3SpHXxh?=
 =?us-ascii?Q?+7tb62c9E8DvRnbpyOaMZ+eOBvcjXeXEEQ/Oc0Mg3fSZ21L3ogrg7/8bFaPa?=
 =?us-ascii?Q?3/beh/uF2O1PXE/udbpLjOFw7MFkAoQun2UK+XFxV2jMSub0WlH1G46wyCrp?=
 =?us-ascii?Q?0b4ZN8Ck+je1TR6jOJ/qfYTo+HzgX6p22xIGxfMJZjeq6ctjTGm9xVns580C?=
 =?us-ascii?Q?UkJeIuEd+ZU0pkI/+5mlBXPe+wxefzR4V71ZPMPIqHS0889NQ+2X1/H1tJ/s?=
 =?us-ascii?Q?K5T/jo8f28YmiLyyfTA9T8iO+edB8G4BhWCAP/118W2FMrwRqaBgWSItGuzv?=
 =?us-ascii?Q?DIbJSjkdUwjxvm7HaLeN5C6EOqmkzt2bP4ZAYy8Zz+hq1BHIETiSd5Ux2LEr?=
 =?us-ascii?Q?Q2KsNNPMQMCvkHjT+sO29kYSa9uja9UrIYaJ6NVwe81VZLoytCGpE72od6tA?=
 =?us-ascii?Q?xVTy/9IXWKmCSTBQWKAzW/h9YkvXL5N/MdQ4ADVo3tiONQYZRWnwSv5x0c32?=
 =?us-ascii?Q?B720WFAmtZnc3CmVWdSddTJefqRWVZ6l000XorflluPjXRb7Okfdm7zoYOX8?=
 =?us-ascii?Q?YslSTQy9Iv4ZTgsX2l0KqawuHlK0APwBuXfB+CzA00L07nuNBZKrSJEFP/YR?=
 =?us-ascii?Q?21WwKvRhwkavGI0ruN4GTyG4XvxS3PeDVfpJRQYGCGvKpVJaj0cJ0369ZDCK?=
 =?us-ascii?Q?7pu2cz2COCVGyIYFlJku6OIIvmtKUSK0zcl9FjxxvEGsHp3xSKCznEbDRuCG?=
 =?us-ascii?Q?p341G75Yb3fDykFveWxCtsKaO2ROy9zaIHIu9cdyEuv8bPxEUZSyWSDIwuXO?=
 =?us-ascii?Q?eHKfsjZ+Qv5aF/nUQn64MR57bfZj1k2spko21091kqKOaSIeU4Tm5klWDlVX?=
 =?us-ascii?Q?pnu3rQJGB5Nt1ewOouPEtgBo6kLQbTrd3uxwJcSotll51R1vb5wuP5tmLQQg?=
 =?us-ascii?Q?6d8RBmhfLBAyB2E5L3wKbGhrACM/UwGqavo0/2U4YmHFS/3OTxySXjAVDIYy?=
 =?us-ascii?Q?H3cxs4pFtypvoYt9bez6cMPCparuSffkB+0M5Z4NovelX3GBCvYCJ+vJ5WQH?=
 =?us-ascii?Q?BxKw5GApBo1XDAEuNEjwjoKhXprisfBpr+eTm0Mim9E/XGwXH4fvJdcp4iJq?=
 =?us-ascii?Q?D7OQcYIOOwlnjsrSaQe42UnzNwsFRbXho+QbBxv7+PEd4y0/r+6+aH/oIz0i?=
 =?us-ascii?Q?qeEvnfqcMkGDtgNG34OChECHNdicBMI0ZiS6kwn/SiTAzLLxilrZImjxNreJ?=
 =?us-ascii?Q?re8YsM7Rtzj/zlFU86Ncpo/idCIl9331T6QN/wh0I1Yp7JyGuj6ARtlMWV3e?=
 =?us-ascii?Q?T1+T6EHmFfHmH/rTZ99Fk9fhP4REy7QvTN2bQJE66TsG+qKASnFtzG/ir0dy?=
 =?us-ascii?Q?j9SUH/u+RkcNYoS2eIOYWIKvjVzLWdC/HvKeaQCBGTL2Qw0FfjzYXuK6vDJn?=
 =?us-ascii?Q?lh0clbREjyZE2I68uX1VYm3tbimkaxj8YhLQ8Cwifw6EomkX8AF48mc9QlKq?=
 =?us-ascii?Q?b5qXQxvkp4VNO43Utu+EmCd9wH7kJ1M0CC5iHV+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c350074-a6a2-4163-7e23-08db7df9559b
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:16:44.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHm5gvQexlFtYOjFqmbFTQn3epXxD7rBaIg38h4EvV/5pkSOAThQiljz+5UzjPYsXe1o/4MRXvna5kHTP2IC8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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
V2 change:
No change.
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


