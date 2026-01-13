Return-Path: <bpf+bounces-78645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BDD167F4
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6127C303E673
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59C2F12CE;
	Tue, 13 Jan 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EtG0eNel"
X-Original-To: bpf@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9968A2F0C49;
	Tue, 13 Jan 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275017; cv=fail; b=hVEDm8ExloEIfMrvseeBIVR7aJAQWA1rzFtysTkP2TrPZVI2eG82oIpiVcBPxwozX7l56jO3kk7MWjeVCqS+A/PQ0tXn1Ipo69bJ5NZ2dT6Gxk6DxQlYyjB580gTarRQYOXT98Ol/KMnN4YNibAyrB0GQ8ILCPaTV/Sh++V7dys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275017; c=relaxed/simple;
	bh=g6WTvqmcA/iCohMv11G3ilVoM2/IPr5JTOUYV6Y56Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a7c2/qOrLpDng+QV5tVV0OTKKkeaBMk/V8Q1VjFGrTk4kdpCi1WVds3BYg98I5IGbPGZ2lXQ6dx5X48i31JzATtA49fRgnsxpjyeiB5UE/Xq1Jh9zFnlRI9YQtI+S2WrRN6ToPDc6heyU4MJvzItelwItPP9hdE41QvgcUNK3hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EtG0eNel; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxbhUZ+eTNYbrgaY+zsqGJW2zVPrlQp3EwGXIPd7zZXSLzKVSyJ63qk+o1+HSrrxKdBylkbHknLC5MlSvDxgLPJm3WE/MHn91eI+bRHzz1oRTDpmAPnc0AyS2eBpFzYl8v45PKkb6//g7RRJcF5qIpI3psuqfxJvKMPYOOW7iIJCSN8/nF6zIo6ri4VRc4gu3bGuVVwNE96LZR20wIE0Zw6JHR79cQD0pdZkABuwwHFl9iYvy1OUNpAUXOPjJDZwmXhliZo5RQFz7DgaPDaML+B1Yrz69JSUDzQYRNaOXmBHcr00yb6ahSqA0aCeH+Nj8RxHsDo7H91Y/7gnqPf/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAyk3GRAE0BBFq4LKYg/GFYIBS9lo2X+5dhnGVNW84M=;
 b=jGqscBRpX5Er0tNO/r61ExV4XPQUsQAq3+1uKOvbwdsehrRFCA92nyoDdBJVOKG2hnApKF/vqs6b9D1wmsTxqIla2jx0ya4AtolNoSuAnrX0MZKWCFrKucANDpDAzDs3VLFXh+rPFhmtDSmnNoVZCmMOanDJyFtsoMjtkJLwW0OmUbfdqCvlxiCU4NbTVZsqS+qEkjJz5B6Sv6aQg89z+vtL/wXxB8UOE6sq7ihgUjpj7BP2Tey6Ksrl1D1XcXUYLm6GdfMegN8QVIJ7B7Foks5p1gJNq7hWvw9r/2/nn6h+JJ+BuZk9cRincuV3kuazIEwJ4gg8DbhphDHjwzmc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAyk3GRAE0BBFq4LKYg/GFYIBS9lo2X+5dhnGVNW84M=;
 b=EtG0eNelXuZZGlHpZWp6KbNd17cGLIs5FlEfERHuz4pkEzGfUZ2wFE2lv/+WXVRR3EzL/34c7WRiRShcDZXF2+B/sRCnb8OCX6XC+WLfEuvUyVzz4uBAHdKocDXf7ge0lY/bUVeJ6A5rkW8+xHuj8em+0gAlE5K6DeV/oxh3W9WJ/gFOQ1MW/NUHVJw4/mrHNxULt1zzt9f3ue95txD83NxqyjdDQ0dPLp4mK/tqWYWS8ZDnq5Pbkp0fwVZMZpI2L7kUODJeqzKeZuEhpj3SWkJdG0cXvgsAZGixMLnSYj/qU4PjlUrpXlCsRKn1l0Z658/Hkzw0rc96a53NQYoJGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB9395.eurprd04.prod.outlook.com (2603:10a6:10:35a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 03:30:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:10 +0000
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
Subject: [PATCH net-next 01/11] net: fec: add fec_txq_trigger_xmit() helper
Date: Tue, 13 Jan 2026 11:29:29 +0800
Message-Id: <20260113032939.3705137-2-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b52a76-4d97-4f23-6afe-08de52540e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EEFBNzhc2oZOB0fW/gq9Aze1IPeEvpzHEePYi6/sgjdNcXNkoGcYIj5TUvem?=
 =?us-ascii?Q?Z6+3q4QT7LZ8Fq/pdEAizHVRxqQImJi7UR6nC1u3UOUvh0x/LRaAdVXq2k2+?=
 =?us-ascii?Q?z8yvQSNFj4i6AX3VAntK12YoYjcL7j9hmttoubCkn7u0Xh/5+GAgU2CyVF55?=
 =?us-ascii?Q?eSEErXFcw/u6XsGZO3klAts9AHlhvkeY0TiEOzpC/4ezvg6h21wSHwW2qa1b?=
 =?us-ascii?Q?1X1YoyztuFP9EIiLtjO+Uf7GS+5uJQXQHULGEExzcDCmvivvXPOFZIRioFeZ?=
 =?us-ascii?Q?0amWO0JGoj6lFq5YkoC9KyI8OZ1TlfHAe6ff3gKktCcndlKLPmuraLL6QFp1?=
 =?us-ascii?Q?/nuJaqjLSFWvJMKpDsJGotXBhpXhBYGPU0YtEJrz4ErOj+brQPkw2zZTUMkr?=
 =?us-ascii?Q?/lWodt+b9DqtnSsbBBrCMeXdZJo1eauWdtrRboptk403oBGVYzWQqeK5qUto?=
 =?us-ascii?Q?+Llkkz5lzpegE6Mnkd9QP4EiHZwkQCKF5NMUFxhYzzBSYE0Gf3hvc9zXLnZA?=
 =?us-ascii?Q?dgBsUaFg5Sbj8LJG344qv4S0L2VNFOvM9HfLJtPJv/T5fOX9MF2q60K0ae3P?=
 =?us-ascii?Q?FAImWW3akWnZtjKMfWX/7Zc6Edb20ycmHwtYhzWn0SzxVyt4mBKJgfjZJBkA?=
 =?us-ascii?Q?A04e6dC2ydKhuACyFVv5gVo0agZnHnvtqQfTS0JT3z/2hNFkke0ILve6Oy4A?=
 =?us-ascii?Q?9GU5cRZEmNbtyGcKpdyXZTpkWjFmQ9jP1sBhAgreZxkmNsTfIY+OX+w4FqOT?=
 =?us-ascii?Q?3zD5dXaYrgDa1FYZ56X1Id6lSgfioqwJdpOxEcJZxoi5J4gJZp2tgbOvQ9Sc?=
 =?us-ascii?Q?gZSItu+6pMcMYvBXhgR9DFCjC9KEoXd0sNiL4D+D9aMP4EFKM76ExK5Ey+4P?=
 =?us-ascii?Q?07LaXErVynGoYXYv3sL9uHHywRJUmS2ItBEliAEb4Ag5eNl6g0h4AoO1fIoQ?=
 =?us-ascii?Q?tenNW2nE4l8TbD2CpcS+LbEfy20mbR+bnE2Af1OYwNpognLYEZIjQMUTMRBg?=
 =?us-ascii?Q?xP5qwI9MWUivRyzoBs2zDlnV1MCvByT5AMnKoQ0QzxZZGZkbGlD7IPUlZ6ZW?=
 =?us-ascii?Q?KIYzNpAb1M+Ft5zQTfGHnwwjNHc8pJ3eX9U9OcQfFtFDIP6S2+ihv22VLhOn?=
 =?us-ascii?Q?x4i+SinQhMH6TRannXIIuHNovW3Mzlz6IDzhOfjMut5FCE4C3l/vul27Ijgw?=
 =?us-ascii?Q?C9csItIgvLNzWoFyq8WLyDQHC4yF1PAIIoSCHG+NiaYVfGJihKIF9KrVeab7?=
 =?us-ascii?Q?n5/WMwrLY7/knV6KL7jeOFM1kFvQ8m8C6pRRsM9mNiJjKlQ3k5V4AX0WXZQY?=
 =?us-ascii?Q?OXku3MA2a5dRjZBMpdNSp2Mw2c5t7QkUeSvPrwLHDaL9b+XhrCWxtL9ceWHv?=
 =?us-ascii?Q?3fFJC7GNlNIIe/vsw8sBPDPMNTkJM1vlRW60yPqANhtDWtXa+8/JmZWmfzfR?=
 =?us-ascii?Q?lKbkm6H86MzbHKccf/asZWK4oVBiZZmTGK3jcKXD+18O7slFskGqWfVazWZE?=
 =?us-ascii?Q?MYaz3oUJ2+5YR+faV/dcRzv6jSlBB6ANMWmo5QniaG2anSnkoFS+C4bfMg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yeOAhq71gH8//9FTwdkXed4HDaMdH4H+HwhO/XRQsrhYYc3drCSFINKNb3K8?=
 =?us-ascii?Q?9mg6NB0iqeFiB8TaVsRW5d/ygQ/RwgQTGXvDDA8GZGHSlOR6xLKxEvQS4UQF?=
 =?us-ascii?Q?lTqqZ3z93OOhIgJ1Vyr+1LYvgGJfYOFQLOUNUHFMTH8bHfkg5DEvyIBQ3L4C?=
 =?us-ascii?Q?FLrl0q1L5LOvCPtXzoOGqX7B7574z/25L5dz/jBFlKMNbV3YxD3k2MwjQ1Qa?=
 =?us-ascii?Q?vLAZPo89MWKj3i18UVLX5VPm6GQuylpg1Beh7LA0DdNMHD3FX6uqJjJulRRZ?=
 =?us-ascii?Q?jNAvSt3GiIzeqehLjVAGvpU+5NN6TWMOqNRO6RaqrKbuIe0fotGT8ZoUhKxd?=
 =?us-ascii?Q?h4+RQHovht2Qekx0o+tDtDfAfxxZF0mrKX8+HnO4hI2Dl/mrXtibRpHjp0lK?=
 =?us-ascii?Q?apXZvYni1d+ndWZBPlZpdJ/2r6/kta4RwgmwR7FsvOQsIzst2hR8jjUDm3Ty?=
 =?us-ascii?Q?ec+rXPmDqXglKedGD5WwbpZXYw2/wT6mZqhEchXeQ//xwwkyNz3koP4C4I2l?=
 =?us-ascii?Q?CKchzQuDEseWNi+/V7dQxAYuuI8NqJyt9Yj0oMe7FLs5bMeFmpU/k7zhO9j4?=
 =?us-ascii?Q?3gmeNc+Zo1AKSs4uc6TgudhdlhfsJhy3Y6PmXFLEJRjNawttNX91MLdTCoJO?=
 =?us-ascii?Q?eeBCTx0NNzkBIqWmaOFSsc2jv+kPFi/3NK98StOfUmogpG2VamsoTome7xwb?=
 =?us-ascii?Q?WyLDPzy81jUZ0J4Ys9qyPX5EIuXgZ/LXscumUViKtABnf+9+qvpHCXMGJoV+?=
 =?us-ascii?Q?nhxn5DxlhTeLzLOxJQfKW6jgngvMxMa0Z//UI0e5yK8fiUuTYEaffnrSH9AS?=
 =?us-ascii?Q?H+nSTlAvoxU3Iqva3lvGRpRkQXNFyGQfYwU7i6EzhohnWf6Ukkc0wZNisvKG?=
 =?us-ascii?Q?XCBTKjjYitL6qzrP57F9O3T6Mp00wfpnhcJevTkoTXOD+/mEmBUHvDFPr3Zo?=
 =?us-ascii?Q?WRfdpvOZkc7RIu/b9/Y5Fgo45Xe9RGp9Y6OrEIAEoyATgB8lrzBOQ22+jJcr?=
 =?us-ascii?Q?jFR2tFFEn1UTt0rej48N1lhBOOTzl/B4yggDFh5dEAwz40mTOA1HYMsze9FW?=
 =?us-ascii?Q?2AWoXgLoVOY/MB5kk73w9hHvhmtg9njXJ9O6HpUlfMslWOWnsn5EkOdgZzh6?=
 =?us-ascii?Q?9qWaLijvVumDhdL81tm79Cr5FEj0lE5LjFhK/hXh4a/narypasLgRsL/ojkR?=
 =?us-ascii?Q?mV/NTQPisB5OiZPLiJ0Pa+bflgovV5CqjobyJ4nQPHTctMUukeWglnR6ckUC?=
 =?us-ascii?Q?oRkEUpbAJ/nxbfzEP31yQptZ4FBJSfp7ARxW0tYfMtXf6U1zAEMkzhGVMjXG?=
 =?us-ascii?Q?65qXw2EPSxDElFQUpiMW2rIwKu130oBlnzwa/yXBrKroQ2cKSKxLbamz8aK6?=
 =?us-ascii?Q?XEtezs+qUiKsIdtsEm05ruVPepFLoOwogbuMO59Q42PbgoXyWshEXkDrzuxa?=
 =?us-ascii?Q?v+WaqIQLdRwm7aTNBw+l+QEG24lhFODoi+G12YAw/nUEGxLLzEhrb9hMrJi1?=
 =?us-ascii?Q?zndOdN9xs3ubax8NQQ9ERZfgPHiGA0YRLxMyVaBNBdi16Ewaqmva9NhSPLoU?=
 =?us-ascii?Q?L1kQEsQPHvJQdSJZ48lm8rMbmhBnIQyPtKkMVktsVvMDUUXhwIEUh7tpLn/G?=
 =?us-ascii?Q?muGprp6q8ck2ve/065nhX01rHuGYX1g4N7nbcwFDPFa8fxZUCjs+ekN3Iexr?=
 =?us-ascii?Q?a7xFe5iLki9pIwGkVrFmLE7FvvfOcU2ZNlktxeQJR0XLB+8DZ2qLwRk4QUic?=
 =?us-ascii?Q?5vW0E/GTHA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b52a76-4d97-4f23-6afe-08de52540e20
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:10.5116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTnHhx2Uge4OE/Lioq68ZERH+smr1uui+tK2ffu6NPSt4aO+LEhio0FNVvecDJW9Th1OESuqxgTXECqT2W2UEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9395

Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
so add the helper fec_txq_trigger_xmit() to make the code more concise
and reusable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index cfb56bf0e361..85bcca932fd2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -508,6 +508,17 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	return err;
 }
 
+static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
+				 struct fec_enet_priv_tx_q *txq)
+{
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
+}
+
 static struct bufdesc *
 fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 			     struct sk_buff *skb,
@@ -717,12 +728,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
@@ -913,12 +919,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 
@@ -3935,12 +3936,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
-- 
2.34.1


