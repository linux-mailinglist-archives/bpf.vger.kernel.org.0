Return-Path: <bpf+bounces-76104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD644CA7AD2
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8F73394865
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAD329C7D;
	Fri,  5 Dec 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IWKy3AWM"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44D32142E;
	Fri,  5 Dec 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764931976; cv=fail; b=IQ/6K4tS7o0UXkz2POPlYilYdO9IFmMHNuLyCrY95cMzEvaFYmk5rdX5SRengMKRjLKw0hyenWuHos3x9+2MEX3MdtuacTp74NeoRRsRJC5CRkl+QQZQ3maOkboinnYabVRYKy1Ukpp3Vd2iFG63BlqJ8Yrexmw4mZC2oflGSeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764931976; c=relaxed/simple;
	bh=5NWXuy5ouEWE1RX7jShX+GHpxM3YyP4Dsp7FedL36+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MPD0UX9HTZBR2sxcfEZnN3Q/S4A/NHmYeXdyUFSHMwsiaFsUQcJ/9GNeEkCJ0XFyv/8IvgOLCLsl7YY1Khf+ewC7X03AFe/H07LAek4RdeSrcUzSlikRHXNAA1x9i5LEbCe983au1biB6alKR7Qdwze1W4JWU11FIkH070VJ+qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IWKy3AWM; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCcGyY42XmpYuS7Va8ZW1DT+dVaFFu4QKOXkhA7du0cTG5t8KkJyg+Cgi5co7MrFh6iWc1G9l+IeFbL+nNHwWkiD82AY3853VwVzZCkhad4ziu8s8oJ+MNcj/4oV4jVg0H0cW8PI7JpcHoQ3G4ZP+7bQT+m3DQoPTLmHAXT1UyoElLdfemcbsWRJNg5dC2GWXII7FCjZ+WUJFnLKqwpu5DYM5Nare8V94gvfDiRpdDlVnNwhM2qDDDdLxbgnN28vL9rReIIzTVmddCoZC/lV5IRMbEtQGBkt1iZ4QSJR2//ipFBskIlfAp839lpEjjkI5mHugZIJlSvWBmnStZ/jHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvHjXdxemrUrSH5heix8TjZJTBwznHDYaIjiXLMTUlU=;
 b=Qa1XZk2YjlNwlXgeNVjZxx6MyoCnf6918qzt/t/LNyZ2eWIpl4zHKhCf0osa03I9r5h0oao+crNMKwWzvxqq0d9WiPhDj4maLTFhtS3UZ0tHl273CDvFrL3zxp7xPEPwOBof876asafePYw0WQPYdedFeuybJaQU95T2Rztti3FJ3ZkKAAqLcNZTkKohZzyq0Ts/gdoq5MYip71ydGqdlOfN4NvZo8Ywe5+QFifhw9oRU9cvwa5UmhcE5AzBH2GSMI5wyztYql9gUOGKfVT5iJLNe2LJdlWBjDc1Vtfa6gGuNognDxL92k075HeVCksVOYe2gl/Wun1LMvK0ucmSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvHjXdxemrUrSH5heix8TjZJTBwznHDYaIjiXLMTUlU=;
 b=IWKy3AWMFCJ+HncQo+HXmKvOHJlAc4LWmbKBTBSbgYVXOpMveWlCeszh+CRGtwAb3OHl6uitPA8oZDRGHqwujSUhr/RUWUm36A7JqXkMo6oUDeSE+BMbnR1WcvP9PyAo2GSE+ojGUFQ7pBQqKm2ROlz2FPvlSBVKB34dFU+lO3eEe7c6QTkUjYCpjcwE2gj6J1U1qjTGT0HGeKwDWWBANrh1rA0ao+XEIsbzKZPU7FEkaCxPr3Fz2Pr39Fp4P9HZzL1Lxykn5PQgZErqQrFNeUB22Q7NWBVxpDok0e0FOKal2vfYvFbGdw8iW3/zhpCIjmJ1U0qO0n8BblWnmQeSCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 10:52:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 10:52:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
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
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] net: enetc: do not transmit redirected XDP frames when the link is down
Date: Fri,  5 Dec 2025 18:53:07 +0800
Message-Id: <20251205105307.2756994-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f53134d-0f6f-4fc6-3451-08de33ec6aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69PlwF7uM71k92/MAKLl4svJnIhMUF5at9W0VbyEbHOPf2nUHb331eRgJguK?=
 =?us-ascii?Q?m5PrIGmLWd66iW+npmRAyK0w1+7F/oDqaXCIuVR0QTsigASjo5fd6BeV52l1?=
 =?us-ascii?Q?QwodtMBvGjN+nA3UV167bS01dmrEKc0Q9oL+YG64h61chx40pH0WCNODNp30?=
 =?us-ascii?Q?hSMQYawiUwd8SytFwXJ1vwUoY9v9sBFf/A1/7/lLiUc17IKNsX01vPcUdHmy?=
 =?us-ascii?Q?Cs0XdwKUF5CsodqYYNzkJM4CaUlGnITWJT+O0zEKqsFksvc/qP7TCzYKQxZ3?=
 =?us-ascii?Q?4wSh6F4cJYTn5Z8KWib5oRqZYGViMwfV87+kvi0wolio0kC6dTMjTtvPH/zh?=
 =?us-ascii?Q?CwNPVpUZMrlRkDqyKNza7i9tm0TMioT5CriDa9pQ+wfSXNQb4dQkpEkEPxa3?=
 =?us-ascii?Q?6T6JJ8ysRoFQXGi0Qre9tiJsfyxQgMetUJEuywZKe1+j+/TuNU2DQjQGOqhx?=
 =?us-ascii?Q?FSDgI7MuwugBtOtA0N4MbHvfNV9tPdk8SDhh4pbB2Rg7sQHOBD19/Vag7ud6?=
 =?us-ascii?Q?e/AanIJ+blnMKbWzm7+qFzBqt8FR3cIa/2qL94dVYqILFBIvR6SiqvoTeKDf?=
 =?us-ascii?Q?id3uYANs4FY/kBo0vzTW68xpPuC2yFAaj1M9cTKRhOz2nu9E7NUyzm3ClSC1?=
 =?us-ascii?Q?hJlFSOJIoBWjH53FOSxj5uZNGkoOmn4mGQq9NG+TGdFJ+2BOeXiK2g4jDbEH?=
 =?us-ascii?Q?z8ShYapGndY8PGj5fp2Vg6N3S9gmwWXZzY/Nl/FElcKevtrBkUltmUpRxxqn?=
 =?us-ascii?Q?/YR7PnogtdRzLPnEh8VK9skzsVeRrs1vyDd+JpCAfPaM1h+6+0lqtxOoYSSW?=
 =?us-ascii?Q?HsWWXEJtTpX01NWxPEqcIgEnJVATbBE1fMy+Aw7S3Th1V6Cb3R26eXaEUolT?=
 =?us-ascii?Q?L5g13lXdOi160JYcFPOV0hbIemZxMukYr6MN1aTYGTXKNT6kYFJxhHZzy955?=
 =?us-ascii?Q?2WwnWMFo0drDm31FJpVtX+VZncOhCGBCdl2u4PIyXZ/e+fmNvKQVNDHarwN+?=
 =?us-ascii?Q?wdeE3V+tox86jGFWw/Usm2VrRV4kopHkmu8PlQxQ3obOb8R6+7SXVJA0NuqQ?=
 =?us-ascii?Q?kCmiKECmRPhkTuqfOVs42hGfwU/2uHDOzVSuOdXAU1lgDBt1xfPKxmJJk0dM?=
 =?us-ascii?Q?nTPNkDKWeMK+bnj9BCFNdAcSVR4CxpdVl8tYyCvKUg3uTGwhXQREYrGtWbkL?=
 =?us-ascii?Q?vArt1JvBy90xn99ls+6YXeqiaMYBofalWyAYKQgvYhxVRfabGXfD6KJvf9IY?=
 =?us-ascii?Q?8mCmXmRFN92hP6mwYDi+PCmUUOEPFbO0W2tOA6jd1pevJEpes9PHkzYntBQ7?=
 =?us-ascii?Q?+pqIzPzBgKjvMoDDyQ+mCnCksBtjBfiSsKp6GlNtzUbDOHz1a/ELB5fn9x+2?=
 =?us-ascii?Q?0MGemZmsx89UF3QGxayGw4cTJr4MfqpCSVzDAaF19gya2LFIURMeV+kb1kiA?=
 =?us-ascii?Q?Zi1JQRRhSx8q4VJ+fr2p4wnSaecoV1WkKLbLZHUrAu33NYZb+1oYwAkO4rro?=
 =?us-ascii?Q?sLkVDOFrq8FokdS3xMOStili0sRaqrtRwrst0faNsWhQabk16lQgyz5Xbg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GMU4gKtY18a6e5n6u7n9k3V+7VrbpLMstr7tzBIPJ6kqq6cAl2wVIbRTx4uD?=
 =?us-ascii?Q?fwgMRKSdRDyvzjP8ZBov2D5oFDVzPBqih70XsplrXxU/13xKgE5o4V9VrKTz?=
 =?us-ascii?Q?D0gnBViEMtGBzDOfpTaXulzLm93Y3Dp7udSTNfv6rX18iPQl8GbPDRjRmVsl?=
 =?us-ascii?Q?OYuE3wL/ZMa172Gini/5YtRMGhGFaSizVw9PtOPdTDPDNDFJY52TriepUUMK?=
 =?us-ascii?Q?WayeXcyl9fPmgmhHjFa7BY5CcKXWfyAHOH1VTznkHr30TwyL/riMd6kipAWX?=
 =?us-ascii?Q?v3cSJawFsytge0BoERitoIzb5+O4y56tZ7y2+pYy9W7alX3tcRR2K7hckDvD?=
 =?us-ascii?Q?HZdBsIRazPmw8X6EbK4DGmx850yjVlQnUiSjYuK2XryHRp+MTNk3DbLjNU92?=
 =?us-ascii?Q?On4mLobK5a/A//oUWktz6rWddwF02DcKxYOaNMrUVXUszqr0JGtY/cThTYSF?=
 =?us-ascii?Q?CRiht4rCygBQeDu64UbvMLciHYLzAmb1LSZXZk8HIpAfbH/f7hauxoeVl+P/?=
 =?us-ascii?Q?+XA6TeEgStUa76AjtSeSlr2o/jQnC2ZzePKJU2Yev2kC7ROEu5LorDO8Gu+9?=
 =?us-ascii?Q?vH1JVtqcrbytkxjVyBO88KtLwWV/liBIr8oTxIEqJMvDKtYysuSF24xVFtJE?=
 =?us-ascii?Q?OLXw0pNRhhrHC3sJrafltAkiAOMFtu+DsBXJmY8kIxFOMQDfY4HjmCWDuUv2?=
 =?us-ascii?Q?7SA3R22rZD2r5lPrCgUJscjF3F8uvxpTLQwHSHQdXr8VvjSutJCUs4t76HRI?=
 =?us-ascii?Q?imS5xWZSgj3/zE42QNQMTwBlqt6cyM6ah12q/z8CiJxjGTRg1X0Sua2i7GAH?=
 =?us-ascii?Q?PHd1JLksqfhgzPlhP1YOfLchLnY+7UI+SxpdMKDOJHURNWaGn4Gf+nn/kb/G?=
 =?us-ascii?Q?iSqrk7AjUh8oJeLhymZjTlqZAACxFcyWCbCSZZjsP9UBK7UJnGfNfzclYREi?=
 =?us-ascii?Q?g0oLKi1B7Gp5NcW6Drq4ox6P2HPuFK+NLEOdebVZug4NWnUYPJG1GgwxaQSc?=
 =?us-ascii?Q?Xlg7rbbUsux1tGlZit9A/7CPdvCCWPQ6fA5ZWdhDu6uHbiXuGVC+Ny57szKA?=
 =?us-ascii?Q?FvokoLahxoJhCKyjcjUvEGd5if3f9H4KHoiTBbJxFivhjQsll2pVLi0/CaUI?=
 =?us-ascii?Q?KzbVZKlWwAGsgzPq2pha6GzwQ4SWrfBIq7eYFuYNThHA67cOMXciExrc79Mb?=
 =?us-ascii?Q?HWfJGeiXkcfqwIAAtaBNHDhCQRqLg3oeGz/0Co/X8pIASdiUYe+rYlVoWd+L?=
 =?us-ascii?Q?/q2gUjHOMx1R0kHg6jcEUrDW0Woscog30lXGjgSJBsjgcJrsV2qCTLEab2Ds?=
 =?us-ascii?Q?DKnjYoSqneukGctaZpGcRs8o++i2ljmcA1P8wQff5SPzkJ4REp5vhHYotur2?=
 =?us-ascii?Q?xEHVxHONE7VYjKjrGueTkyjGVdugJ2wm7rQYGxTkuFJkUH7uBGPuNlSKVW0p?=
 =?us-ascii?Q?dk+XOROgA3M9o29RIBA6TkEhwI7EXBuFWSanjVpUumqanyLObB1cetcdPVhz?=
 =?us-ascii?Q?acTV8tCWzlepnPE3fEmx+pP8/NJpWTRHgdk8y2pH78autnXfhmcr6zRPrCTi?=
 =?us-ascii?Q?GiCYVzbpv2FwrSE+xjZwLVXQPugUu+zE/XK4Jscs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f53134d-0f6f-4fc6-3451-08de33ec6aba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:52:43.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BcYlapiWJRiH60IwnumTKhpmupSWjwRaAOCxRX/Ktk/eJJeX3cXR+FOUweO3IH2gy4t9apy/sWFI3MLq2W5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792

In the current implementation, the enetc_xdp_xmit() always transmits
redirected XDP frames even if the link is down, but the frames cannot
be transmitted from TX BD rings when the link is down, so the frames
are still kept in the TX BD rings. If the XDP program is uninstalled,
users will see the following warning logs.

fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear

More worse, the TX BD ring cannot work properly anymore, because the
HW PIR and CIR are not the same after the re-initialization of the TX
BD ring. And I see no reasons to transmit the redirected XDP frames
when the link is down, so add a link status check to quickly fix this
issue. However, this solution does not completely solve the problem,
for example, if the link is broken during transmission and the TX BD
ring still has unsent frames. I think this requires another patch to
address this situation, but it will not conflict with the current
solution and can coexist.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0535e92404e3..f410c245ea91 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1778,7 +1778,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
 
-	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
+	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
+		     !netif_carrier_ok(ndev)))
 		return -ENETDOWN;
 
 	enetc_lock_mdio();
-- 
2.34.1


