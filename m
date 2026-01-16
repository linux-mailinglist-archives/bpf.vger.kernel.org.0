Return-Path: <bpf+bounces-79213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA8BD2D6B1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8609E3067F77
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06E34FF68;
	Fri, 16 Jan 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VaRJ5bDc"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B634F250;
	Fri, 16 Jan 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549328; cv=fail; b=h/z/P7w28Au/3ZSpl3/ZF4qkyUyuGbP0HOKFUQoErcbdHKEb6ZngO5ZImPDoMRhBbx6ULpNOhhkOb4Z9gUsWWHLFEi2/uhkAQh0qaqlcMlT9R7rBpLtljHaya7WaCrikfbuXyLYHCTqNCqDMfIeGRG0tTYhTG2x5l88kO/MFTMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549328; c=relaxed/simple;
	bh=pFr74NeqHty4i6FE4iQWq8HiG+XG1h7fJHmSwP7611Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOEEqeqsgaeRq37NHkNHRpVJo+Uxth03S+HXmIqRuN5RbPE0DcKMEFsaA+NHamELpjTHSXs0XuGtvI0l93oKY2AtRNGgJ66cKrXQCsdsWaAFR+Yt6hF8o4znkvu26pY7x7etoPgJ1XCETez+sVUfc138oIvgKCwKaogyV34Rydw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VaRJ5bDc; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ+iwiTNTB910Ge1CAD6KXIhqTmF1Cmy+yvuMra73tPdnWaxO40Sb6AW/NBJBRj6/2/YORomJsXbcdgLarb1lE3d/dhrHzCJOvFI18QImOvXjEvXos+8U65mW01MuIHRHBmbn6O1tTSfTPFRE2FmsyOJuKLsgoT9YkUlB660sNm7Y0vf7g3mLCzYSXbAJtZz4gn/zZyj4yfmFk4HJWaMa6knP/4OnXQr5AQiZ101KvD+z6N1TSYNiOh1CbJ1rLeIVyaOGyDUUTNBNeAsnwyqNb2Qz2l5aOCQe4Oyfywif92H7C/GiAJBG/87t3X2Wj+hc+aSx4Yi2qxp7jUWpJDnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69o90vG7GqEldS+p645t17Evsw197bm3UWFe75pHoR8=;
 b=nqlrw91CTtABk7vsqh0zEqLt8Z1cJmqtXfXBEH2xGzR3pz0TbZnUq3p3wxneQ2JodY9F0Nthv7UweEskfGzNLKveMd1y6REJxR+cNoKTgrzV6Hr63k9nsbjgAbOjYG91cgtv2NVrBXxtGjHXBcYPH3zNBlqlb5hbWta7XeA0ZoWwrly3O+GE2BT/0FCdMX9HR2KA0lULzJ4SD3v2K9nUCwBSJ7ZcTYG8H8DFBbH6oprmU/+0bs2ltDeYmEaH2IifN+JWNR32IK0fe351FFJTdBURa8DqEVtUKVJ6t7D/31fRFDelTYZDX0xfpvmk9vyO/RLcGcxbY5EOYEokVDqjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69o90vG7GqEldS+p645t17Evsw197bm3UWFe75pHoR8=;
 b=VaRJ5bDc/25Y5zzc0I9imZzSV+Pm/nA1CfZBkME/5u91XDCkJiG/95FkSDbLYJGT337FpFvP/LHFFjiKSpbYQuS0QWuOHBWDUag9t9aucKNH1TsD6HHpX2rXye3UFvrZUlF/d6B+uG61yPqY37LOiwjeRIbA2iG6QUOlDKlh+I5KGZoNf/YwBxWfHeHw2YBySo+HLX+EF0DXQYBAxXWyNR5KHTUEb/9YpESRzmG5PASVaPIa4h8Gm6Do1quSpG3ZROk3CxEQgQo+XbSbX+rqrC6GzD2Ni8GzLyvukZBqH9qLobLoCywrzkXCLTwBHhL1SMCcRTw1JcJVckjtXbZt3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:41:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:41:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v2 net-next 10/14] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Fri, 16 Jan 2026 15:40:23 +0800
Message-Id: <20260116074027.1603841-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116074027.1603841-1-wei.fang@nxp.com>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 27813a7e-44c4-4e95-b7a5-08de54d2b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzjdhw8eOvPIuwZ+cmlcoLU9vPxgA0JVXiTCAjZyq23DnKlyYtNIhNPF9/i0?=
 =?us-ascii?Q?+ximExBNUVgZxCqLwti8pD3XcF1x0+LNadQX2aBCs8EnJ7I9qjmWPI1V5N1E?=
 =?us-ascii?Q?IafUDi+DbEtFwBKS/PG/vfGtrMnmm97UXRVCk1M7ImplpXs/yGr8rlOzRfQK?=
 =?us-ascii?Q?co9SBtP2WURacExDCN0td8HwsWPsp97N4sHW+rO239eXWhZ3SbTHXPrFsIEG?=
 =?us-ascii?Q?+OUR5BIHhwdLBc21h94cNw115P6J2//Acx+5Cwb7KfqbpLOxCU4mCzlzYDIj?=
 =?us-ascii?Q?7FwJm+lbxlK9WvgkB5yDwaIamdk+luNrSJQCVXSwmm0VSDvzFvv09I0iRHzn?=
 =?us-ascii?Q?a/enTwdoAU3++n3L1xmaYlNKP9pDQ69mZSioQMvm/18PFQP8knflPn+6A2Xq?=
 =?us-ascii?Q?3SSzUW7wgQbmwW25f5xI6ieosSURSiCGeVFIMsaBVNrAoMfz8O4vrsLI4Icp?=
 =?us-ascii?Q?o2MZxMmLmIS5z26OzJgmwE5dbVM/9FFWKylx3hvd6BiUOmA8C/xyn4po4DnL?=
 =?us-ascii?Q?jU7PIxqNwDa4Wyvp/mw7ODlyNy6k5pWiGDpiZ0ODWiYeFTsF2LEtZS8IKyoW?=
 =?us-ascii?Q?KQ6W+xkxtzfAz/9sdx20bbGcr/+0dvPAdGCu3Iexv+ybl3Joz0AVYav3o+Ox?=
 =?us-ascii?Q?RC3t27gtMo4yhuI910ZuJ/TV/okdM5x+2pVJozg29E8Gq1XcvBfnjq7jGs4Y?=
 =?us-ascii?Q?ibWgw9yBA829p9ZJVzIOvpZtTLXBd18uUFpcNP8KQ7Lc0+I0LcUKY1lhIk42?=
 =?us-ascii?Q?AzfY9H4rDqM7UOpBQRdWQL4Q3DyjzOw4dfmjFFNQL7caEcjb6ODsmV0vfC9f?=
 =?us-ascii?Q?awqtKX3ejrSqf5/WMYdW6IduiotRnJ6BMvd9raLkoMsv3NtwSh3wigyMb8vx?=
 =?us-ascii?Q?NXk08Uae23fs3V8mH5NfjR2tI8v9tD2UkK2+qRjY7B0Rt9Q5MVWJdmflI7im?=
 =?us-ascii?Q?HqBlrdRNqyataMTJuUbR1arx4hWw63+INe06AtF765zf3ph3q6q9nVYZL7xi?=
 =?us-ascii?Q?HyTzSDtaeaUUu5FOrrkBPdqI+FNIZCKN00GMtMUrgTZKU5PEFaPEuBPDPWb9?=
 =?us-ascii?Q?NHHBa1ESwE9R9js/bpPQSYE30XG/ZBqC9HZtyKujCc7rZOUBMlVRh7YjWfFI?=
 =?us-ascii?Q?/TH2gWp8RReHzXgwT2g5Apfg6VATIS6DkTp0VrA5CpPq+fCN/a+1jV6cPIMg?=
 =?us-ascii?Q?D6BcQFkN8zsIOMuK8LS0qQmH8xeTKFOnrApY1/u19v8ohEGT71JMnNWTV7yQ?=
 =?us-ascii?Q?i9MWgFAqU07Y7+vCwSFALASK7J4nAmC+7hKZzC7YDinYIHG/O2LNtLKA8d9n?=
 =?us-ascii?Q?73TO+RpiZrUfS7NU099vX8SXyDzTwPgDuv3547/zhgSEzDiMfWwp+hGy18Kn?=
 =?us-ascii?Q?l4mAhrxpO7vxMeYvBNojm+2c9cXLj2CFXkKmNJXi0MXOxo10C9loKdUdT2eh?=
 =?us-ascii?Q?mUQPl4pSZqsrDTC+flg4uQFleUSfkDMgnYzCU+InOpHIFVayfkpvLSzjJ4+m?=
 =?us-ascii?Q?11bD6+c8a9Nvf5g+jl1ti+xHelOD0Mn6eCEv1O48UEHU2Mm/mGgvttlJJ1n7?=
 =?us-ascii?Q?Pgxyjc93qk3azWF+08XTzALGzN8tXlWPK5hBGHWC+wSNdbbHQgi3ELcqsL3H?=
 =?us-ascii?Q?aK43bvQcs9SrVoW9WVZB1jJxuTOGiB/PWkYHuBtHy0lV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaDwKtvVNW/utN+vsgMuh2wlHYdfsXjkj+I+uCx9/j2E9oVeMfcMGG1AO90l?=
 =?us-ascii?Q?FSiQUUCDNPO5bTZuTsE8Jbc1TtrmNvCbLdCobTYx0KDmJij/aRJTRJO6xAY/?=
 =?us-ascii?Q?RukI4sbRiR9bCwG2pM2IjKRyVgbd+DIf87kUBEq5By11CWd5Lef+dDNcoNeE?=
 =?us-ascii?Q?8667lZ0cJc503ZeoW1yjuOoRExMdqPMBlZ14r2QW7DFfmefNsl+wcH28NR51?=
 =?us-ascii?Q?PzGvQs5UoB7BHGNwwuToP2iyMSPktPi01qo+UEwTCgzesNP8gdr6Xbc+5o0s?=
 =?us-ascii?Q?FoDhd/Om2veU8BNbr0GX2F8T94VzXPa8DumxYM3AxI/x7WYR2LVvIEbubVSr?=
 =?us-ascii?Q?4DJsjF+OdC3g8HDMkU5YVbW8ZQiDJtfLecfptQ9i+hVBapIDDTdSfapXRCAH?=
 =?us-ascii?Q?XVwxqpQy7j0BKqZdIWoKUz0WostWY/ySoUA0OQTyFI/6ZHncxOd7MdmNxgxu?=
 =?us-ascii?Q?RY9a36nRmNajzC/c9s0+1CSKPWpYHnVXYBY0jCyhQXkx087BWKLibpWzIJvv?=
 =?us-ascii?Q?rVKokMGnavmNyfFbpiREblDS9Oa6ArkfgAoaSLLDFITyHIhiRM7dT/kG99wb?=
 =?us-ascii?Q?DAKeyj7gBSL0hezA7FFsy1T+XHNJPd6A7RJxGsmyakmSflT7wzIUgpCvYGs1?=
 =?us-ascii?Q?9fQLNEQbtD96BBXD0/Uk4UukhklhOP/UBcOC6Ho/SnzD2I7G0cHEsvikdMHG?=
 =?us-ascii?Q?DNdD70vm/5ItOdFkYitPHlZmDpmtrFuoZu0urD9g5266dBPafMYjhkkAMccS?=
 =?us-ascii?Q?fonk3yi/zsG11zCb2sBdAYVJLhCwui9J7mIApAYzwWZDxQXdHkqhM6M3jh9c?=
 =?us-ascii?Q?STH48BXcTocTt+bx9otcv4OlPz+k5gzmSbYM2pzODBvCcvu/5CHcHiVj0LV9?=
 =?us-ascii?Q?SyCRIVcZPi7HpTFt0vQPtlRmhkwQ27uVHJ07kuCPHyCik7CAx1h+U2u6fDon?=
 =?us-ascii?Q?LwA63bGyFGIcCJbQKySdMO/XBAMjjA1bPY0ne1MNJzz76oSa7JwL6AKrktOS?=
 =?us-ascii?Q?Jt4ZxmJm1Ya166XzTMt8Eni2O6Qt/jeHPyb+S/zGmVsXvWT0JB2DDBcjCPyu?=
 =?us-ascii?Q?66emmPadIxnttxGA3LEiLTfCmrplOIimEaE/E9cR71dWFR7972ooNt1r1Vrj?=
 =?us-ascii?Q?UPyGconn9m9z4VbiwwJSJ5LBV4reC13uv+Igo56/Ru9pT2XN8q3lvwod5RZG?=
 =?us-ascii?Q?y+2BlDBX/ubTrrb3m9qn4Y62kJTK35PQZ3JLZYpvLhs8SMQb/0BskGwJUqRe?=
 =?us-ascii?Q?k9tewOyEHvjtU0qy41DEmSWiL2OHKY61iigAFmLolNKKF8RH6KFekcFYMFE/?=
 =?us-ascii?Q?JdlouQ2X7XHD88zHmDpyKdJiGdb+Mh8XFSaH4O9qLXDJo+TOO09Dtk7FgSEF?=
 =?us-ascii?Q?Or6ZnKqT/3x5L+bcfJVr1J5IQ61eySOZBM9SWUIbv7iVlRr8ExNs52Jj22Xx?=
 =?us-ascii?Q?3FN0DnFqZSmRte9tlxodXxuBJnLj0R2L6EaQRhONGYIDxCp3vtD+g3geXDiE?=
 =?us-ascii?Q?s8wywDxhhpV6k2iTh2YK3rWIhDtu4xI5sijFIHLeMLfnzJowuiMYMFDIC6rf?=
 =?us-ascii?Q?yDOobWiIsCMvOkpSdUEx6BENAsjF9FqrTQvtZ13KHzL8D3tFxZkyoITTq3+g?=
 =?us-ascii?Q?lFpmdOsZNU7vdpyUWCqeWkO/zEM6yQBB0I2EwvJB/MU5VpZcpeKIIBRHSHwZ?=
 =?us-ascii?Q?Zvs/Hajg+Rysqi9px5ah9B4QV6EZGj2GpgKBJ3cfmFDFqGO0yo2B/LAgyDSg?=
 =?us-ascii?Q?TGNmwXDkcQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27813a7e-44c4-4e95-b7a5-08de54d2b935
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:41:56.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLzJi9hhKQqMrR9tGgdijue7BtrO/HLKDTJAwCgaxcwtjMFkWVK5GZhavuSGZgXSktRD05Gw29qTu9FGu2K+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

Since the rxq is one of the parameters of fec_enet_create_page_pool(),
so we can get the ring size from rxq->bd.ring_size, so it is safe to
remove the size parameter from fec_enet_create_page_pool().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2f79ef195a9e..c1786ccf0443 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -467,13 +467,13 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 
 static int
 fec_enet_create_page_pool(struct fec_enet_private *fep,
-			  struct fec_enet_priv_rx_q *rxq, int size)
+			  struct fec_enet_priv_rx_q *rxq)
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
 		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.pool_size = size,
+		.pool_size = rxq->bd.ring_size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
@@ -3552,7 +3552,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	rxq = fep->rx_queue[queue];
 	bdp = rxq->bd.base;
 
-	err = fec_enet_create_page_pool(fep, rxq, rxq->bd.ring_size);
+	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
 		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
 		return err;
-- 
2.34.1


