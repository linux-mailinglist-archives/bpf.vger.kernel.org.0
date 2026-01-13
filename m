Return-Path: <bpf+bounces-78651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 231EED16851
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9ECB303A1BC
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073034AB03;
	Tue, 13 Jan 2026 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CH/aA/fa"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF834AB0B;
	Tue, 13 Jan 2026 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275059; cv=fail; b=E1Wx5sf6hrL+eljBd7cNU3OwMtKxuF1OUB46FxRMVSCkpar/r9XpbcUfynoxf3+X9Rqkd9olNiICBQ9xUeoLJxFe6RcvrERDiAlnrg/Ly7OggKH8G9C5pSkDZaDleyaUJt364zK/db6f2hcuAjC/Vcq+KL3lpQlFPxaPp2OFjKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275059; c=relaxed/simple;
	bh=oKd2PW0A0yUu2hBZQ9aNSReZP+o3o+JPH5hPtu1DxRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHl934vIgeU9jvzIvAkqGRUemgykQXfxY7uLXU7TX/C56rhqhuoPgTBbQbGAvxvBL5ghBLYTtL+jtus+sJ7l5xEddSuux5h/Bx5PzXa0/axdqb6QiisDIx0THtk7AIbmZDKiwmoHIeutd8S6QaeegZPC7aXKYlz4My853f+kDQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CH/aA/fa; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy+cltTEI730Iy+KKVObHrQqtKOyi6wnbPN6sc5XKd6cWR2N8yvhz/xMrK6v9X7crRguqbrVW1dB0zsO84LwswsONanPe4jVervV5/TnWzLea54dKXmP+LYhqSO3djNxTktNxlzEmIxvbLQ0HjwfAZwsztdM/b2OtW1DI1Tm05eAEEN5g2RX71LjqDF9LByPqQUUwxzHfY5DL3AAYQoUIRTNrt6HJTrBAzo9GPP1naCNWxuqZ5Xezu00e0tyAxKdxuEbIhyVeHwllgmRVLJIolXwYWjV9J7EoER6Irl189dZeqx7HkPWZOdfkJ5z2Rn1nZzcLAneQGjEAQZn+X0efQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zitAE1PO0LPQK9GZNCo7OqxchBfLHHmqZNXAN8kjU3U=;
 b=AHeGaGDuUDzwXiBkRJEqQHCw/5qoKsfcwv29o+U2Zj6UwWDxQRqd6jv0EO0zN3LVKpN1FKyj28l3ibbp+GW/Gov4t9TT+UZ9CGTF4na8Y/eXVqXP+l3ycxIlHMsmZF5Kwx4HMHf+kCxXEKtDquCvXpELC+UjwHtOWb9Vm/2r2TLt+ztOxUgsGiyd7oKmKnp4fMpxdYMj8j0RlO+X03/3MPEp794LjaPPgq4K+ARQQu4J4dKPyC7lyW+EtEdUJKvYdD6tWna2ITgPhz3JszbIhW0yKmZ+1YAq6Z+mQ0vUBZ7SXKfoO3OgeZhyRi8kPwjrkRQsEvmiuz10AO/jwiP1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zitAE1PO0LPQK9GZNCo7OqxchBfLHHmqZNXAN8kjU3U=;
 b=CH/aA/fa2xNK4bkxwA9aLfapwgbp6R+YS7wWCOmVVWS+jVlPDAYpD0O+tchgyM5Zir5ac3ILdQamI4/3TBOOKEk5E3JLC2VqS9Yl2HywYQIDG1cqkf7jf9nb6WOFNUBb2Kx+61XbA2T20Fwv4PbB1L29qWuKYfsBwOq9Q/pZpVUrHSINPSIX2wDkkUMFk4nCnoT95QQ7SFvjQzAIwIx4UAvhIYoicUmJcPYrzwjHtK7E536BN5cknaOXxALyOIrY0VrxbFi/iaMZdJUStRlnQRMLGas6zyqrE4q2dcHq8hZ2nEVEKmjIeFHLNjthaTR4bTnkKSYiTLdfGdk+yuQr4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:40 +0000
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
Subject: [PATCH net-next 07/11] net: fec: use switch statement to check the type of tx_buf
Date: Tue, 13 Jan 2026 11:29:35 +0800
Message-Id: <20260113032939.3705137-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113032939.3705137-1-wei.fang@nxp.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 19072e28-afd9-40be-98be-08de52541fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AoFD/7nPvB4o+iB9IWlLjZkexFIt4VQA91EkOv4k6/UW6DQogpv5Jyt4Wokn?=
 =?us-ascii?Q?Bj8AVv7IN+vldkxb/az98r1OcLg5uxJKNPNfHX6N0wJVALiuZ5i1tZHnwWCR?=
 =?us-ascii?Q?hCO0jrzE2ad7oLI9/49unz56dCdYolqSbGsV4sEn6hf0nOdtJVWV1C/9+UzF?=
 =?us-ascii?Q?Ij2f1wlzk7Mi5mvWdp3CgL5IzmlbqCYdgOB5J4NiqmxDR9+DoyXjwRHHxoJq?=
 =?us-ascii?Q?sgG5Mwr7FLSP+6dZEhkBkNhJQvuVgdl6XjlAaBJTwxZqnt4z4g1Y5S/JPJCN?=
 =?us-ascii?Q?QJtCulr1iyzHa72AlS5tUKFdpPZDt+FRfaOvuuv0AQ/Gzx0K5gYBF/bLbgvh?=
 =?us-ascii?Q?siKMrNEJ42uJtlFjfVB95n1Q7eSagoM/PmT7168zuvg6FgQWRLEPK0/dnsmh?=
 =?us-ascii?Q?+rg2yocK4nV9SnqALD+GeCZHkz4FqQ+XIxOtSaX4Kj/ZqNA9xOnH28bjJByD?=
 =?us-ascii?Q?2uWz322fbDU7XqIwBQIO9M91LeX9a9RdQxez9PC44kEfwTvdtiS25UJN3Is7?=
 =?us-ascii?Q?mLOAWM8FOq+dSl9cy+Pt4eeml46N5u35U7sXBy87CemFkm+4byQ+IYtJTt0G?=
 =?us-ascii?Q?IMorcwkZ5Pk88a3/ryuJGlognLIQNoPOI5tlOvKC+7z9m2a4XbVFjQ9Uj+u+?=
 =?us-ascii?Q?JACVneGkJbFZ4ZELaDG1ptjqgJIxKLlif2Pg5+rHjLz4xXwToChUFLcddiiR?=
 =?us-ascii?Q?OdMMLQQM14dMBBNNXMr8oCGuYaA0P/BltpkoAE++MkUd9yRj8jguREnjcMXL?=
 =?us-ascii?Q?hshEEGE0ACiKgQw7zgwQ/kEAG00zd/5Qs2Qroile4K5ZXFDqln/O+x7iivKK?=
 =?us-ascii?Q?P6fdkKdY92t6ofzPYvE3/1Sf2ntcHIUUM5UY/xIz85NyTPR7mOxcCvvlgPS3?=
 =?us-ascii?Q?2tAOwvo87/F30OQblzFeX/eu+hkxbIrM+4lnIqjdsEZXqzdUPoE0Ui1ulxDN?=
 =?us-ascii?Q?KRl83+Dio+GuD+HSgDLZVTPrFSwSZ2ujdjM9nZ6y8u18ChNbFr37tmqCgpOr?=
 =?us-ascii?Q?4M8PMRb1EVEmwt7/W4vjWMBAgfZYvTQ0LA/HEk19yc1kBeWHi3aQqIrioqH9?=
 =?us-ascii?Q?hEVIAIIIF/TtFn/Pr0bUzMRJK/iOrCxLdMea63l6t1lxiu6wE8qf5toWwyZS?=
 =?us-ascii?Q?xtcsdzYcmDH0mSTkDuo/PjVn1NQRmY6WDgzfRuzZddScbsUsjtFkJvpF1YzY?=
 =?us-ascii?Q?uM3xizOknO6PLjrSdcM9q1VpR7jUfoICTCghtkD5j+W8HelnbSuSUHQa6Vpt?=
 =?us-ascii?Q?cRw1lVEg5jltsEE8rGMDywDDCoueVhj42IwpZWN8TgX4DL1V2Cb5Rliq1ma4?=
 =?us-ascii?Q?HWEpndVEnvd/fRW4fVNmo0RsKdF3CFDamAfpkoDyDHmah9GbdcrPLZ+AkUKd?=
 =?us-ascii?Q?vgp1sjg4tmsepk1G3CNsYV2xeajt+BaLW7M+NoFV24LZ+pd3fJa43eK1X1KO?=
 =?us-ascii?Q?w0cDGB38m2DqsEdLteSZhp9p6Am4gSjnb/Ql/1VNIDEgdfNyZocVZ5YjajBH?=
 =?us-ascii?Q?+vfBPNzQTmO7412Oc62M361ZrZlRSqQcXklL/SM8bFHUTltPS6srRA7aAg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2pugUhnwECuaout0kzL5mAQBJ9JDRjciTih3yYJJVZ/pn7rWfiMOY2/jKDPr?=
 =?us-ascii?Q?WQIaotcFoFOB2b9qjTirnB+1n3IgCA5SQGe1TsKnDs6xB9nr+p/ZrhzsswlO?=
 =?us-ascii?Q?+Fri1iRulTE3RfZ8aaasiaoci4iO8+/eb8PLO9bgOtN9v2oYD5J9rHnpiCTX?=
 =?us-ascii?Q?KSoMc5phTEevG2NlkqUP6URb0wjA5GlI3oyRPC2ATqel8REiKAUrICsJTKva?=
 =?us-ascii?Q?WgIos6UAjJAx0VVewRs3VIo6lEfIacRHmDr3+YYRZrHjJRxKHsOA1yXsAmS+?=
 =?us-ascii?Q?td2D0gFFmxKxOu/uRauwesAUyt3Q/snPE1oJc1cLDDroK43K7DrPOpU8+k7D?=
 =?us-ascii?Q?0MfuLSo0Q+I90TCM0Xn+1onuaFWpMVQdzazbJQa8g0SeZQAZku7ALyBmTe2r?=
 =?us-ascii?Q?OQ3RmGlb4p4oaMvaOXPaJpbORArA+H3dPaWAm7L+bhqAVTSq5AGW3NY35bAg?=
 =?us-ascii?Q?xZvzFnAQSrt6yj1nxzcl2u3vOf/htKrfpXaEBNSS6wH/fIFCK2V5n53ywbms?=
 =?us-ascii?Q?DiTd/Rx+5N7zmF2F45weS2yvoFyYtxsdHokndpUz8YRWrDYDUxMyVxnN+iPb?=
 =?us-ascii?Q?+sgcqX2oMTkEcIm+B/oAXLBDK6gvd1kzatZ17iD21iC162XOjgDymIQT/vII?=
 =?us-ascii?Q?YoaTAmDB6xlSfQdF+2Bx4lOViqn5ggNXS2gDhAsyUhnYV/H3wnt6V77bHhk0?=
 =?us-ascii?Q?FTtLX4n2A5pxTGk3ffUPkSTVi/VKOpEso4dhHQT7TNFRZpEIvCQwS1wpOyBO?=
 =?us-ascii?Q?s2rsD4my2jxxYLMuJszR89M69H/TCvZiQGMlyTQ5N0Yr72BBahpna7f5zR/E?=
 =?us-ascii?Q?Qr5BLjpNWzcOjvkxS0maYHcgBBEEw4WkCJy9p8CUaiB7DHw5ijsP9cU8PIzi?=
 =?us-ascii?Q?773gohAPFz7trPUI2fmebwvrwlhfozQQurOrJA9PfaGnw+vAFIlQPe2kMpdG?=
 =?us-ascii?Q?NzEjKRENqPtA324awbgqfQDlr2njcpuExM2GOf+4BzTTR0IvdG6lYbuzaqkO?=
 =?us-ascii?Q?x8iW3feut9bA5GCcbOVw7fcFrGENbVCCB0WonyehnmOh9gZWJwpEZao5P6S9?=
 =?us-ascii?Q?FsIFNNZDNGG6TTB/kM4dmc45EGHz5Nkr+GFXh+troplWggvFyJq3Bz0156nR?=
 =?us-ascii?Q?XAi7e41u/DdVlMisr97F9Zy8tTAEskIuLgBas2ZdyTluZgoYY5YPt3mE3J95?=
 =?us-ascii?Q?9jmbDvwl397LseZYSavETL0jnbAEr2dkysQrnhrui5jOgy7Gac/NDGtcO0JA?=
 =?us-ascii?Q?1HjpmpMBBfE0iCO9M33py/dxw6uQUxtBZUC7WYlztF8KAcIjMwuGNI+RYqi1?=
 =?us-ascii?Q?LExS0YAViqttpaTvKL7LXZ+F59pKXL+2CfNNRQRrY/rOy5grf5meIPX5FNTj?=
 =?us-ascii?Q?QO+u4jUS8Jeme2X18tg4VRKh3bMq8B+59JXSJHNyGUBwvmsSUOXCxCFEmGfp?=
 =?us-ascii?Q?v5hh47wQz50+ObTfpCc/tyjiFP6u4kqJItPbZigErda35xmTIScBaACl8DKy?=
 =?us-ascii?Q?5gfbbsoSXzUyiy58inEwCU7ByvjYeuHrVrjIB6oYOa9iBE2wpod1lu3ESZC/?=
 =?us-ascii?Q?kjUXGNH34dVWhWQiNUOYDH5WgEAEkCFWAgFRJ9EIO99hqkpP3UJHIU8VY7C+?=
 =?us-ascii?Q?yxhhi3msdaP0tl89nVertJO2210LIzsWRiX0C0z7hS0S6t5EsxGZIMc5W7y9?=
 =?us-ascii?Q?T328lllHmZQy1y3epV+KGgmElIxxxwhqLqLBLRIMe5MrGcFDf+QQJ5Q9pNIN?=
 =?us-ascii?Q?DEsVakeG5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19072e28-afd9-40be-98be-08de52541fc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:39.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqDGRV5bziiEjnNKWeAYhml238x4DN+FKuBk+u38GIA2HKn3+be3j1fkrkf9De+CWf2E1S1jpEKa5d4dWcChJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. For example, if new types are added to
support XDP zero copy in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements to support XDP
zero copy in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 167 +++++++++++-----------
 1 file changed, 82 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f3e93598a27c..3bd89d7f105b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,33 +1023,33 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			dma_addr_t dma = fec32_to_cpu(bdp->cbd_bufaddr);
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
-				if (bdp->cbd_bufaddr &&
-				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
+				if (dma && !IS_TSO_HEADER(txq, dma))
+					dma_unmap_single(&fep->pdev->dev, dma,
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
+				dma_unmap_single(&fep->pdev->dev, dma,
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1514,45 +1514,66 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			bdp->cbd_bufaddr = cpu_to_fec32(0);
+						 frame_len, DMA_TO_DEVICE);
+
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
-
-			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1572,11 +1593,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1585,35 +1602,12 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
 		/* Make sure the update to bdp and tx_buf are performed
 		 * before dirty_tx
 		 */
@@ -1632,6 +1626,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3413,6 +3409,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3436,20 +3433,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


