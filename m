Return-Path: <bpf+bounces-78652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE1D1680F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 730B9302A793
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4891E832A;
	Tue, 13 Jan 2026 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Is7D9uC6"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795653126A7;
	Tue, 13 Jan 2026 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275061; cv=fail; b=sS8ivpP2kVJCRNAjYfpVipqYy/kFpfn9GDfKLp/TiEGPI+qi4zB5W8ms5R2pzj+QO5yDrZi4oRHF9qoXysZrBVHjCIgaVRwo2bHOKdzxV0vh7ZRP1Dkz/2gvt663IR1OWLOBpJK/yGEVjQ2x2ptkwVaMkvnMr3UYl9IOywm4+Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275061; c=relaxed/simple;
	bh=bPPAmFdrmLk6GcgOh7j4lvLZy2yNTdvrwNGcJpIGHQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/uDxZ7Qenm80ZBhndrcMAUrYrYTv9pT/Br4xUKl6oOoNmukIQIj/Ar6RZ+/vz4iIMI/6z/3x5r+LhsSo5iRFX5j21j/UGg7fvoA9MYEwjUJNWsCvRdthZccASukEdpMOtj+VARDMMnIUlwhQUgRMbTQKG89G57V9h08KqIzq1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Is7D9uC6; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVZV9V2Xxjed3drcUoJfb/PSBdhVUNcxm18zOj1oZV2g01vQ2JpvRDRMzYeqG4apDnCgLNtuaV1FYLbPMrIfXpu+4pc9VCr7X2ge5mbNb3V9J3pqrR3QUJZ9xju/jkOWXxg3BEW2SwWqA4MYG5FnlvmwtyEpES1XHH6DWgeqSxnx483h2b0MtVTbNiblqfKsnsJx8kll1G7MYcaVJUTWP4dliG7RzJyOW/VDX+gQ9LdBpLgHTxekSzeRrbHerYz2O6jWJxbC7gvj4c+cBJKFEBcgi9tMOjVKrQKGe9vL3MwTXkYYjfjXzoLXGcvZbEUsYtaqFeIKL4GXqy9xmG/+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYzS4EuiZGETi9SNZm0VYDFKW4RLr1OX1rxR06wONa8=;
 b=fdEQzGa5TYGeUINSrpaoGXlMk/9ktFYjf2tNNGFd4BoFl6CUie2qYi2bW9Jh9msRxm4OItoUmlMU+iT6Xd+HZ6QCAhJWCwM/kURCFXus9tpsxQK3I2Q9rQrJCgNAiRd/9aERneyDFCPk0ljBq4yPy8h2SRin0ZAyYfO8EogFy+2mYIN2yrGY72K9XGdtaMx45X7SPUxa+HrMlUgHN4JCU/F/b4SRdTWJbIIY/+7dBRElpOjc+M5KguPOTV4bBZSuQpeOLkWUPspK66ELGlfiD4bcBHu9cc75C4f3ohe1QFBzc6OMiW6e0Q8DDTz8/b6RQDwTqlWfEnna18H7Lkgpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYzS4EuiZGETi9SNZm0VYDFKW4RLr1OX1rxR06wONa8=;
 b=Is7D9uC6C8/UqnMlQWG6mca6wkGg2Ycbyll0Mo3+g/8ycmP4Nxe7vDQ2wOczAQBMOlmSoBqTaZrDIbB5dvNS5Tyrg69I81T3OVg5bd11Ao1Ftf0B/4X50oC18i03P53902v/PaAlcweqMY/AKyfbUyuIqeaYShS+ymWpkJLcIrCp+F5XpUywLqioU02dWMKfu6h5UI7Qb9COp+4ZlEGoLAPEs3kBtUzafIxDLaPOC4Du8hRXQYz5TMrM5VChYE2H4GTr3ozbdNcfEWem5CLrMxeU3t9fwDiXZOvk1KxbMWWvMWa3jT6Bm3mk0pb0HUrtdtlXzcWlKbdvk3Mu8eha4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:44 +0000
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
Subject: [PATCH net-next 08/11] net: fec: remove the size parameter from fec_enet_create_page_pool()
Date: Tue, 13 Jan 2026 11:29:36 +0800
Message-Id: <20260113032939.3705137-9-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04d896bd-f642-4c40-65dc-08de525422a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xcHe8WCt+kMdKXQfJXAp6KRT5iddgrcs+RJKSTxrwFgMri7MAdAq61QFt4Nl?=
 =?us-ascii?Q?2DYGIw8kXnOnp1meF4cSN3OxiNRCtdpe4kpOPC0n+N8WE/RjVE6ZSPhU4yeQ?=
 =?us-ascii?Q?gPQOEmGmV+mfUIMAxS2GI99wgPqlLdDWPG0Cd/qFUnN1MB8yku8RLPMZShMO?=
 =?us-ascii?Q?XzlzgYPVtgGyr2yVwS3/grxwoCNFnTCoLUrVX4doSBpaWtRBEtWTkosJnNI9?=
 =?us-ascii?Q?0KxHVqCe2Zu5fYNnmxqv9Olwee5cea43Dye7sGgxkfNe3vb4ZZFu6LTOgVhf?=
 =?us-ascii?Q?AhKo2uKNE7qDl7owS7n1T5xaZKEqrusX4YeG7AxfjMBrUpQNnfj1jZIIr52s?=
 =?us-ascii?Q?7bysAsYcP89trmnPmt0COhQoEY6xu1yTbwUvKQ+0TT/OEbKP1P9OkN5IgNPM?=
 =?us-ascii?Q?FHmY8IMEBVimn6Y/Klkbv+xOrxTKfKpe/qQ8JzsDlBHk1YLik5l9Wo/g+Pq9?=
 =?us-ascii?Q?h4EuQqinxPw4s62fDswNGNGvwIf+eT/2oig3shgLqy4t+myZU+4BKUMMVvtk?=
 =?us-ascii?Q?/uZCrwmMHnU0UoFkvX14F7DeA7jwq56y53Rjs/0uedtJlt3aEUsnACGmGH6c?=
 =?us-ascii?Q?yN4BBwZYDjn8eLZM4AMC94GtPyDGYIckchPH4RJO5pu9d3rATINn6hDEaSrU?=
 =?us-ascii?Q?iRdDYI1FWS1igKZXiYCsRmhaRAtC5quka1mBXB9IoGDLGS5XQuV10Gg+lKk5?=
 =?us-ascii?Q?gRnghO5szdzEQiWujpgV0VMhYaS9xXWMwp9AdKc0R1YvylpDoUq0wzsN50Y4?=
 =?us-ascii?Q?dBXos7zYyyfDWvZd6l9FUpWzvRb59WakHSHZeQApT8KUTTbCt85VDABYH1m0?=
 =?us-ascii?Q?2rWq3irKn6bYaBzLuVRvKjr81BZlWm+eFzx3Vw3VUOKm5JDGxNbSYl+HMCKq?=
 =?us-ascii?Q?B1KjQgWUaXfnzF5gZYUG4jjI87b1WNff4f0K1EXY3jHddb+Utbf43xO2O58Y?=
 =?us-ascii?Q?t4t14pB/KT8a82Ornl3TlIVAnMxVnwbhXN60E3ksS4n4ZOyE7eKUu7vlIRhG?=
 =?us-ascii?Q?ByBMOnR3jyN3OadBwpFy9hc7zdkWy2EXQRxQkSX39g51dFfb9CIltB5tCUej?=
 =?us-ascii?Q?GTXmUoc/thEIIrJLTe9PFH6PNkJLZEOAh815y2lPOwTN4q13CGb9RRnJYzfx?=
 =?us-ascii?Q?exX9B5R1u4BWzOOhlDv7SZWboEnGx6CpGoiB3zVo0PJKeyYubqE2MjYLCEEG?=
 =?us-ascii?Q?Wbg1ZRrdJcl+3H7vKQWy7uRTkdfxNmkbK3guNAzW0o1cd4E1iYC2ViLH9nMs?=
 =?us-ascii?Q?aJwIZ+xir+NgQXi0J2RB9SmD3J0eGq0x9RBdKo/dcJZR98fTWFVTUPz82Aqe?=
 =?us-ascii?Q?H2f0qYVl/cQhXJGUrxxmK2BnPxoqYGNhtynCBGljaiLgwHTWAdxeYCVaxsDV?=
 =?us-ascii?Q?ke7S+KRwXvk3DFsivKkGjklymJrJZJWkap8JMdMfM8kBv7e9/lXWao0N8NXh?=
 =?us-ascii?Q?JK5OYLPppVEoHaARb2xIfdB3Cy5IRsPhKplTWphG+CIUjpl3Aoqzp+2ovMuO?=
 =?us-ascii?Q?0gNFE5UgSJnYOMgXfj7jr/xlKe9s2MUrni4yTI+7+H8kNOIH8PZ6/aSWVA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dbpzd/6Ach38E5vw10b3VP3KczzPImxAno0SeBjy0aKXPDY+kKNEKxx3ow0a?=
 =?us-ascii?Q?5CO/EfiQcvfCMiIGgnjIz5KwWhMY7mUCOv6CCrd8v/UHlulo5g/lOY/3YmTM?=
 =?us-ascii?Q?Bjs0EoVEFpusppigqBWx5v+IXDtOwXK/zkAUtKvH3q/OC+Q7lkn+kh315Htl?=
 =?us-ascii?Q?EXOQyEADql5j0a9kRnS1ROr84CtdD31E7WrP+Zq1iNuYCNHRl7J6cFuYkvKy?=
 =?us-ascii?Q?oXvUpW4sJFe2NVqC7UoB8AalQ7wgjmN93Ca/dHEuME1yNwens48wznU7gkUn?=
 =?us-ascii?Q?dOpxr3IXrniIrXNZjTz2DagXVVJ5JZAFgSAfBLg2iitm4wx6i1TN4ULzT7dK?=
 =?us-ascii?Q?l47axwlTsHpOM6ovNl8LfbXmH3Owga1PH8sl28SrHXBUwkFJbxHixq2K19uz?=
 =?us-ascii?Q?vB7IeCwEqqJzpf3Jh8zrzDKHXnazwJ7Smld3XAtNEikHu/XE1f6TgpLnN8Jb?=
 =?us-ascii?Q?eTCmzjDdJ42Wrn1Nma+xarffCwW1L85zt/pcddMPkIKmVRcSfrccQr7NWZch?=
 =?us-ascii?Q?1qn+RN8c9GzxlttgQIFN71O33PzhkYmK4YxTEjRRGWgMI6gtww6cQqoMMsx+?=
 =?us-ascii?Q?k1Ir/GgbtNS1i4HV/SRNnCv9L/LnuWHuZCsKfofSDQQXPBHDEMPe7NJKIFxx?=
 =?us-ascii?Q?Nq4MGojsMBnRo7Vj7pnFSMdgTnQu0YicIzxbgy7Pp3ubc9uy1lSqDbPPdR94?=
 =?us-ascii?Q?pHKrww2GiKKa19LfY5hLxWY+ckGZzo3PPgqe8eAZGMdLiD+ruRvFn1+WFnG4?=
 =?us-ascii?Q?zRF7vzJoYD4hzBhDrtV9bA9+Qjpb0BJR4seS3/vwrfwwNYKKH/QIGxXbWL+0?=
 =?us-ascii?Q?xesGylt5fCD8MsY8tPVRag5Cui7MEyze/Q1rzYZbtN8DAxOJcAUxw0mThG5j?=
 =?us-ascii?Q?rr9oKvfmr5OuO3rreri5Jx81abTpPf1n5gR7GcK8rxEE/C0+/Vby33P4eu1h?=
 =?us-ascii?Q?43xAXIAQrZ34d2xatT24FeftKrA+H1v6VS57XKHNh9Api6movw6rtsEaMGyG?=
 =?us-ascii?Q?mwY0J6JEZIHCaYtK37zfF4MU2blGRGgrEsPB3PQ3pOiUUsPqYpW/KK9Clm2z?=
 =?us-ascii?Q?1t/vseqx2wkBuSNuMwzVjYcpOY5xGpr/cq9HLpFvGj6UFIBRYnbArQq0bEdP?=
 =?us-ascii?Q?F77tGEFhpp6dCS7eZ1hGOooWbqs/Fk5CO1tukWoyPXoGcQznQTBd4mFCagsL?=
 =?us-ascii?Q?xZd2KQ53LRKvku+5PjjqdpYS7t4XBLnMkpP8NF3P//6Zxen+fdbs0nshLCwK?=
 =?us-ascii?Q?h2XR6rlMGiI5WjmkvLSwWW8IldfVc9yOEt4yqZtZy4wlDBZ1boOF4JPGRvHe?=
 =?us-ascii?Q?R9FWCIFv/n1FOl2xoaLcGAaT4DBzyqFOWplhmEwusE5KnVqLOE3NJC2gs3XY?=
 =?us-ascii?Q?Vv32J8K+dnMu3Kzn4vLpSEiZVb9oN5Zvk4LIkB4haVe+tS+TrY6wLoR18cwr?=
 =?us-ascii?Q?Q5X9AikpPjN5+j9j6BeawGlTBawUQwUFCEmhBya2JiWrybqPDO9I2We88W8t?=
 =?us-ascii?Q?runRCMQEnF0jaX9p5V+3l5AI0FxKA8WHJNIG6ujvHVJDN2BQndB0ySqUlStp?=
 =?us-ascii?Q?IUW7IMJJbQ1iVglB9aXF+38WbWiyM4Abwrmj0cXMlpROY/gNDR15PwiMVBek?=
 =?us-ascii?Q?y7SK6w02KXmKToBENeFRk75Tuzg95AvVudaxjTfAWEykoUsNcyCIMVnljuXP?=
 =?us-ascii?Q?dXgT8jn8skT1kH8bJiQO1ZgXluZYzyzn6cYja20yarSK7d4prE5yUTdm7m2z?=
 =?us-ascii?Q?szvogOoDPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d896bd-f642-4c40-65dc-08de525422a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:44.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKoe7xAb5MAEsovSKeOl0rd7Rbd/nJV6dp1ppvzjimPldC6te3s1UI8H04370utBMT6qzdeMIBvYyVTsuEo/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

Since the rxq is one of the parameters of fec_enet_create_page_pool(),
so we can get the ring size from rxq->bd.ring_size, so it is safe to
remove the size parameter from fec_enet_create_page_pool().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3bd89d7f105b..f41cc26d1a46 100644
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
@@ -3536,7 +3536,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	rxq = fep->rx_queue[queue];
 	bdp = rxq->bd.base;
 
-	err = fec_enet_create_page_pool(fep, rxq, rxq->bd.ring_size);
+	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
 		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
 		return err;
-- 
2.34.1


