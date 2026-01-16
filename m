Return-Path: <bpf+bounces-79217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B03D2D66F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FD4A300F24F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22AB34C121;
	Fri, 16 Jan 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BF2iUnXv"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BC34B197;
	Fri, 16 Jan 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549414; cv=fail; b=VmrEBenjw0R/jKLlnpqdJBXQliqBx0trob/TO6+HJZvBHx9co3wg8qssUCjsi5ibUMg+EXOWXy2kvpvMc6mL44niWdl2ne67uw/blAKhgv9DwBCQg+PDFpqEHdPJN4AE3FfVcUJy1PVJX3XMEF0bN9YeOBf9p3g1DCMbMS4XGAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549414; c=relaxed/simple;
	bh=S2YNTyaDK/9geerRluKEJl0v7sAh8h+wpjvloN2js2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fK4E+Ptia0IYjas00fZPUq6GnwXbFLclAZptR+ETS5A7hfhAkd1IXpKdwnz/3fXWbeRwyv/gwFIh5RewNJHa6e9VD6euQZaqsKSOytuF3qm1xtoVC3uH1UyommRG1Eu98jgGshlPsr9dLv6EzvFmCsxPQQk9wm4/Lx+B5jlaxdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BF2iUnXv; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGTkTvFKNzT8TrA0dWXlDotrEOXqkJ/U0PcrBBtn3j7SWnq+8dwy7zhjw+e9xf94uJiXuz7FD13XBmLLJrXHVH3BNKXSrn+d3NsPfkNJM0RpuoL7kkhnqGgPjKR9yFdSOBKW963ZqJbYTn7jgMt+K99rXK93+tPAJu/GCvvsS3CfX3iKyK8HRFhs1bNCKI36PUuQzisaYM7aJm/p/PKHc9PLKQfnl3py2mZ/IxBNe+W3tye2bhBvsPoDDfS3zpzkcfjYYgoqCySdXbDfSRGhCyB4/VaOc3W8TL7YInLaZQ5sd16TDquI5cbISxyS6ED8odT/uZxVVcQ07NfuB1LVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJIlswXPOC7LcM8xigJxQcic3o2GTsFvrMKuZIUG/0U=;
 b=QSIrHgPbe6P3FTr4Co8K+leS3P5WAV/vQKOtLIfOpKBQ2svkXPwt0DAVv4/9ilCY4ZzKolq/QSwLd/ySnN2KdAG05dKk7zKKL7SW4aqSqECjfyEeViW0x+2lYPo8nXvvazSyxyFbfb3DsD0pSEEYVjbAlKRuoH3rw+MnASNYC0T/F7ohEGqhab0skxN8gwyh+wItpoXbhlWFWX3sciUtsI0T5WoubgMN1SD8IqqNm13CaGKvwp91OvWFBcr1oEOwMP5NlfH98eTPI/mIfU9fWm9rP/ouCtrzF0yCMxFw+8Ij4X/emGNYEVFDHTbDubzf+XNYDiaUZMDZ6CWSQoTd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJIlswXPOC7LcM8xigJxQcic3o2GTsFvrMKuZIUG/0U=;
 b=BF2iUnXvV/15bflw8InWeS0xvXAPrKAJ75PeE4HY7YTDhwpyvy1/og9iAQtumthM/x889y2eaNvNwwNpuK6sKKG6mtePgpJdSku9n6TugxVwr2HU+pvb4aRchDAgfw1b0TWLz2MtEQdoiep0weXVzW6xO0m1ngKPNyY85oQjDP3PWlk9QTcCqahyoNz+6If9Qw7yYa1nO3aW9ErNLLbFveML+feiayyHmvt9t600bFVihiVKXGGD+RmmQddqngM0KhQrdiZ1uUNEnd5xEG5MdJ8J9anjWDVvzQU/N3v+UY/WdI1+PMQSX6mviDwvaht4zeh/5XDv1GXidv1iJ/536A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 07:42:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 16 Jan 2026
 07:42:15 +0000
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
Subject: [PATCH v2 net-next 14/14] net: fec: add AF_XDP zero-copy support
Date: Fri, 16 Jan 2026 15:40:27 +0800
Message-Id: <20260116074027.1603841-15-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a0f9b8-66af-4c82-cb5f-08de54d2c478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohie8sX5Qr3usKKvTNEnVGEvcKfDe1kIO1/NRmM8Gx4nkEMGW7nUfDQQfYHX?=
 =?us-ascii?Q?JNCfWN8ipmSX1oTQCj0CxcF9dNWY2HxUo5TSHa4laM9UTG0VX5PC5CMWuR+Q?=
 =?us-ascii?Q?qDbSw6O5TXTd1K+P2OnQFa3Gefz7i2EPu1CAkl1vpxUWePG09HqhOpMEg2i4?=
 =?us-ascii?Q?TsJT/f0pBupY4pZC2Af5XOT27xTutpCkzaTpLDeWI9WRcnVgOrKYp7XMrS6Q?=
 =?us-ascii?Q?T0tQZ53RPzufGccp2Wihk3pUHbcBu1+xoXKjNKlIxIl4Dwbt4Pav4ngyy4c6?=
 =?us-ascii?Q?0yk46dsmAaJFzrj7XDGZz4PK+RtrwcgngLpuUaq+By9oRb3aB4ideJZyhre+?=
 =?us-ascii?Q?NO2nsl/o2L3E+aCqdhlRfhDdMJpIlyhiG3AaBhqxFSmf3a7qzqVs9B/dm0fc?=
 =?us-ascii?Q?LFRwYv5cBqSVFCToNVb5epi69VCenhDmVLrN79+WWd1HAO4oBOG+leny9S0z?=
 =?us-ascii?Q?XxgT0vSmoglFsXpVBRD2OFZsJpS2wpAdaM7+lXyAr+YxyPXZafy+0mRzKObf?=
 =?us-ascii?Q?ngETFegQgw08G5+xwMp0zqbTE81VBabOym4UKo9+605nXq9TN9oDL/3tK6yp?=
 =?us-ascii?Q?BuY61EVQvBRJlUrGDZoKQ78aSUJq6mZqyHy9Izob4g0pq/g/94TmU1A/fIds?=
 =?us-ascii?Q?tqjW7hJCtS/fcSVwTulyGC7LBP4ZzQhOGHsY7k0+NV96Gj56opu7I+uSV2iN?=
 =?us-ascii?Q?95jyce9U5ztw+zdMPYdVA+0h3GzGVPJcAbCE5y4VEKXpHg3Ac/9vlzKgHrKW?=
 =?us-ascii?Q?m48ssrXBxEtWSKHzM/NDKb3r4Gc78Pu0WWTY8Qu14r4flW40mTzRS0VV3TOD?=
 =?us-ascii?Q?9m31f9spXsNbIhb8RxWXex9DeQAAiXIv/4qEgN7p8atQepxKHVVTj+j6vUr0?=
 =?us-ascii?Q?XOeiAja4cklLj/Y4RycgLbsxsb34rs1+H03aHMNlUJr0MM2DxpEiJ0sz24ek?=
 =?us-ascii?Q?3DsUz6Jw/drNoqMZM32JWo7CgL6L05oBQKGqq+IyXwqmX+rL5Se/0tD9OD+m?=
 =?us-ascii?Q?u9j0JkuBwba+pyb0+ntFf1rqqMqZ+ys4i6dxHlkBs9puHLnJQwWQwsrc4cC/?=
 =?us-ascii?Q?JAifqazsHqSuRAJN1PyU4pVCmFXcAdeBIH/Qm/apBSd7r5/5BAIKBzN2kCW7?=
 =?us-ascii?Q?/Q95CMLg8G8P9Dy9xTiVEZytYjXhKq2spP5b0M9AlaEVk5oNc9Pe3OI6zMuE?=
 =?us-ascii?Q?luH2DQQCLdgew1a4hXBTp580AsX7D9IzZkUvVx70Zczt4Wv6mHFAqOed+u6k?=
 =?us-ascii?Q?k86YEQ6Qsn31wpL4cJsUlGg7JwgJRNkKpNU1M6a//XUeaGRSK0s0K7Kaancz?=
 =?us-ascii?Q?L9hcwNrgrJiW1SoJG4R1Wy0sBxUnRJ4Wfx4s7diQ4yCDrZS3XgD4FJSu3rYg?=
 =?us-ascii?Q?VqdKG9gOFpbPATFAEgr9jX6fj8GoriECK1SpWH7rTvIqDRM31G6qH9bUK9QH?=
 =?us-ascii?Q?bTA6NnsUvoH4yStmabNgODAU6YsHyyLjGzkIahvq9d5DOaD6iNk5KUY5PQeH?=
 =?us-ascii?Q?98iZPeiPzERGbR7RoMI7VJX4ovHTY7SQN7N1X6FzC8DZ5JJAV9nJZaFWSDRi?=
 =?us-ascii?Q?/UzcV/UDUq07nBzNfWEIuaBaMqffHNzF09Dqe2e4qs2oF7X6PL1ExAX+woum?=
 =?us-ascii?Q?BVEr6zOxBcE0U2qCdvF3xkVs+GGGqkrqS6T1Ioqf0Qql?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/cvI4JWr3bDiwQAgDRw5SowawlY0lLQUuTj+m8P/tQg3BN/CoNV4Po2xWy0?=
 =?us-ascii?Q?InDX/AGYVrlDlkIONt29rRbJVfzhFrjkUDhyBx4w6qe/7v+pKSMBkadvvWyU?=
 =?us-ascii?Q?q6+72J7LuDSi55g00tLq164lfqzfmh7hNlMgsR+L86QE6Qf1L3e1eXK9xHFV?=
 =?us-ascii?Q?KJXaNAUVdQzucoGmWsMFW6tgDnmMwcDqFf+pdhLGZIH/WdHjjerZLvK0mqtw?=
 =?us-ascii?Q?yp4bQsa0xaT+gKEYNUmo9yCU2TPhP04OB+wV0u675Es0YVc5lDyhfw9oC/pI?=
 =?us-ascii?Q?DtBHuFJ5RFiAH3eK3i0lG2k1C47bms7inL5j2blW14dNk4Ys/+V6v5vdxlUj?=
 =?us-ascii?Q?B38RTTw9zr+1cKe0WH1DE1w+UgF0Z/GzRjHEota7p8saOdxXYz8uZzDnTMSA?=
 =?us-ascii?Q?hY5pGmwkTSRdUZ3pAg0r0c8a3rzd1CpgbxLGsIG8AihCxulaBJ97ptG/MblZ?=
 =?us-ascii?Q?iL2C0+2PpyeTLqzFWA1YMotVCDnYNNkTFFl52vIMmgpJgpqwrX4VC4ypTM/E?=
 =?us-ascii?Q?VXs3NF4J2ap+SZDzBBfdFvPDtuj2QFG0U9C86/uuwyFH4Ym+CH8iUtN4FayW?=
 =?us-ascii?Q?A8a9GS5N2p16ZsePmQFxYVP2iyPKJudEeGl8F6YcZeTPZ/8Iwr+udPfJtZX/?=
 =?us-ascii?Q?Ocq4j/zEmvh0wsnrbjhWgQkHOrPfFlX0Wln7lkqTVxGJFyHUcd4WV1BV0qt3?=
 =?us-ascii?Q?ivo1JemFNiGb3AGRIfiGZo+SRhyIKl6Zoak2beSZMuLokB9vQK2kO/lRVz0w?=
 =?us-ascii?Q?Dsoy9w+9wFRx2rqDom7VgwcHvblidQXSiGyxF0dRWec8ZJbXtYXcwZJg4Avs?=
 =?us-ascii?Q?j/gNQuzsv6wD3Ni8isqyEj2l1e4LzDk/cmJbikIxrEQqF4BWHtq16J2Bl9iG?=
 =?us-ascii?Q?Yvkg+b8Po3uFWncNSsZ/VAUWHuT+emMhIjiVCSlG51kvIpdS32NXBr4qkMDv?=
 =?us-ascii?Q?iOLEEq2qxz7KBTt8+oQSGo70dAgFfjUVj52OSNNShEi5CZpkm3PsiqX9sqTG?=
 =?us-ascii?Q?5BSIB1NM2nODqEOSZjvsS5C23efRj1EIY+uWbK2SkFxXlaXDGmvEzdTnAyo7?=
 =?us-ascii?Q?Ato+OlIh8zmlhVpumfqZ4xS9cy5atp093RCrft9ciNLYbA/nW7aSTKRvCLjO?=
 =?us-ascii?Q?Vvn9qlAAdzIViWcNCKEfN+Wj7uY3wdAZbuD2tDEnvXsEfBxy93n9KuGOAgFg?=
 =?us-ascii?Q?zQv/NsnXqkaqSk5z9EAH9ADNmIb2yCH/zjE9r9nsnS7pnzA30fRie+YCKY/8?=
 =?us-ascii?Q?NHDmS3XNoT4Seqk6HewAW0742x0uFTmS2Sy8oe3dWOWjYC5GRaxbiztvIr2U?=
 =?us-ascii?Q?lw1qsXvgq2Qor4vq05O84Y1mmxFCJhLAVhudg+z6ttR27fr1J6xlQfurLhqZ?=
 =?us-ascii?Q?gRf06R9fEKxtTxoEvxDOrG5PVGpWP58Sl4rgB5HtsSVVqLTRgnwg0XsG068l?=
 =?us-ascii?Q?znK12dnrU+sJ2TU+Oq5rIsWhrWwXq68gFNK30o9FkQ+JzujiwPgT591eRjUy?=
 =?us-ascii?Q?eH+P9+j3IzGv6IEsLcB49pbvWVi7O60gFwC82inDavFrd6hVIo/jm+R1VXNN?=
 =?us-ascii?Q?0MjBxzin5fgMJojIGy+qD4wpMKV2Fp7uapa/Px0Rmx1KDrEkvj8vYYAV4tcs?=
 =?us-ascii?Q?LUXpPVuYE+fOgalFEv+S++Or8fSiHGjb5jcZVHjsTfz5bTKyhTVftjsGQFAW?=
 =?us-ascii?Q?UXi4mQ7d6ZKpLechfGDKuF/w6F0Y4BnaqC9fKp3Y8HpW2E3Lk1CHp16c5frT?=
 =?us-ascii?Q?eKH5xjT6qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a0f9b8-66af-4c82-cb5f-08de54d2c478
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:42:15.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orOtSy4/yVARRXuOr0cnon2jupscBNLfwSozrB3KLS/Z4pRnxgZXZv4hVWhkSb7ysRlG4F6cExeroxJFTWywMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712

Add AF_XDP zero-copy support for both TX and RX.

For RX, instead of allocating buffers from the page pool, the buffers
are allocated from xsk pool, so fec_alloc_rxq_buffers_zc() is added to
allocate RX buffers from xsk pool. And fec_enet_rx_queue_xsk() is used
to process the frames from the RX queue which is bound to the AF_XDP
socket. Similar to the XDP copy mode, the zero-copy mode also supports
XDP_TX, XDP_PASS, XDP_DROP and XDP_REDIRECT actions. In addition,
fec_enet_xsk_tx_xmit() is similar to fec_enet_xdp_tx_xmit() and is used
to handle XDP_TX action in zero-copy mode.

For TX, there are two cases, one is the frames from the AF_XDP socket,
so fec_enet_xsk_xmit() is added to directly transmit the frames from
the socket and the buffer type is marked as FEC_TXBUF_T_XSK_XMIT. The
other one is the frams from the RX queue (XDP_TX action), the buffer
type is marked as FEC_TXBUF_T_XSK_TX. Therefore, fec_enet_tx_queue()
could correctly clean the TX queue base on the buffer type.

Also, some tests have been done on the i.MX93-EVK board with the xdpsock
tool, the following are the results.

Env: i.MX93 connects to a packet generator, the link speed is 1Gbps, and
flow-control is off. The RX packet size is 64 bytes including FCS. Only
one RX queue (CPU) is used to receive frames.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  13 +-
 drivers/net/ethernet/freescale/fec_main.c | 611 ++++++++++++++++++++--
 2 files changed, 582 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index ad7aba1a8536..7176803146f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -340,6 +340,7 @@ struct bufdesc_ex {
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
 #define TX_RING_SIZE		1024	/* Must be power of two */
 #define TX_RING_MOD_MASK	511	/*   for this to work */
+#define FEC_XSK_TX_BUDGET_MAX	256
 
 #define BD_ENET_RX_INT		0x00800000
 #define BD_ENET_RX_PTP		((ushort)0x0400)
@@ -528,6 +529,8 @@ enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
 	FEC_TXBUF_T_XDP_TX,
+	FEC_TXBUF_T_XSK_XMIT,
+	FEC_TXBUF_T_XSK_TX,
 };
 
 struct fec_tx_buffer {
@@ -539,6 +542,7 @@ struct fec_enet_priv_tx_q {
 	struct bufdesc_prop bd;
 	unsigned char *tx_bounce[TX_RING_SIZE];
 	struct fec_tx_buffer tx_buf[TX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	unsigned short tx_stop_threshold;
 	unsigned short tx_wake_threshold;
@@ -548,9 +552,16 @@ struct fec_enet_priv_tx_q {
 	dma_addr_t tso_hdrs_dma;
 };
 
+union fec_rx_buffer {
+	void *buf_p;
+	struct page *page;
+	struct xdp_buff *xdp;
+};
+
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct page *rx_buf[RX_RING_SIZE];
+	union fec_rx_buffer rx_buf[RX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7b5fe7da7210..8e6dbe564f52 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -71,6 +71,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
+#include <net/xdp_sock_drv.h>
 #include <soc/imx/cpuidle.h>
 
 #include "fec.h"
@@ -1034,6 +1035,8 @@ static void fec_enet_bd_init(struct net_device *dev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
 			default:
 				break;
 			};
@@ -1467,8 +1470,91 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void fec_enet_tx_queue(struct fec_enet_private *fep,
-			      u16 queue, int budget)
+static bool fec_enet_xsk_xmit(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u32 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xdp_desc *xsk_desc = pool->tx_descs;
+	int cpu = smp_processor_id();
+	int free_bds, budget, batch;
+	struct netdev_queue *nq;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+	u32 estatus;
+	u16 status;
+	int i, j;
+
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+	__netif_tx_lock(nq, cpu);
+
+	txq_trans_cond_update(nq);
+	free_bds = fec_enet_get_free_txdesc_num(txq);
+	if (!free_bds)
+		goto tx_unlock;
+
+	budget = min(free_bds, FEC_XSK_TX_BUDGET_MAX);
+	batch = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!batch)
+		goto tx_unlock;
+
+	bdp = txq->bd.cur;
+	for (i = 0; i < batch; i++) {
+		dma = xsk_buff_raw_get_dma(pool, xsk_desc[i].addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, xsk_desc[i].len);
+
+		j = fec_enet_get_bd_index(bdp, &txq->bd);
+		txq->tx_buf[j].type = FEC_TXBUF_T_XSK_XMIT;
+		txq->tx_buf[j].buf_p = NULL;
+
+		status = fec16_to_cpu(bdp->cbd_sc);
+		status &= ~BD_ENET_TX_STATS;
+		status |= BD_ENET_TX_INTR | BD_ENET_TX_LAST;
+		bdp->cbd_datlen = cpu_to_fec16(xsk_desc[i].len);
+		bdp->cbd_bufaddr = cpu_to_fec32(dma);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			estatus = BD_ENET_TX_INT;
+			if (fep->quirks & FEC_QUIRK_HAS_AVB)
+				estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+			ebdp->cbd_bdu = 0;
+			ebdp->cbd_esc = cpu_to_fec32(estatus);
+		}
+
+		/* Make sure the updates to rest of the descriptor are performed
+		 * before transferring ownership.
+		 */
+		dma_wmb();
+
+		/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+		 * it's the last BD of the frame, and to put the CRC on the end.
+		 */
+		status |= BD_ENET_TX_READY | BD_ENET_TX_TC;
+		bdp->cbd_sc = cpu_to_fec16(status);
+		dma_wmb();
+
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		txq->bd.cur = bdp;
+	}
+
+	/* Trigger transmission start */
+	fec_txq_trigger_xmit(fep, txq);
+
+	__netif_tx_unlock(nq);
+
+	return batch < budget;
+
+tx_unlock:
+	__netif_tx_unlock(nq);
+
+	return true;
+}
+
+static int fec_enet_tx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
 	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
@@ -1479,6 +1565,7 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	unsigned short status;
 	struct sk_buff *skb;
 	struct page *page;
+	int xsk_cnt = 0;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1552,6 +1639,14 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
 					   0, true);
 			break;
+		case FEC_TXBUF_T_XSK_XMIT:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_cnt++;
+			break;
+		case FEC_TXBUF_T_XSK_TX:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_buff_free(tx_buf->buf_p);
+			break;
 		default:
 			break;
 		}
@@ -1611,16 +1706,37 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
 		writel(0, txq->bd.reg_desc_active);
+
+	if (txq->xsk_pool) {
+		struct xsk_buff_pool *pool = txq->xsk_pool;
+
+		if (xsk_cnt)
+			xsk_tx_completed(pool, xsk_cnt);
+
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
+		/* If the condition is true, it indicates that there are still
+		 * packets to be transmitted, so return "budget" to make the
+		 * NAPI continue polling.
+		 */
+		if (!fec_enet_xsk_xmit(fep, pool, queue))
+			return budget;
+	}
+
+	return 0;
 }
 
-static void fec_enet_tx(struct net_device *ndev, int budget)
+static int fec_enet_tx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int i;
+	int i, count = 0;
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(fep, i, budget);
+		count += fec_enet_tx_queue(fep, i, budget);
+
+	return count;
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1633,13 +1749,30 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_buf[index] = new_page;
+	rxq->rx_buf[index].page = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
 	return 0;
 }
 
+static int fec_enet_update_cbd_zc(struct fec_enet_priv_rx_q *rxq,
+				  struct bufdesc *bdp, int index)
+{
+	struct xdp_buff *new_xdp;
+	dma_addr_t phys_addr;
+
+	new_xdp = xsk_buff_alloc(rxq->xsk_pool);
+	if (unlikely(!new_xdp))
+		return -ENOMEM;
+
+	rxq->rx_buf[index].xdp = new_xdp;
+	phys_addr = xsk_buff_xdp_get_dma(new_xdp);
+	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
+}
+
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1794,7 +1927,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -1924,7 +2057,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
@@ -2039,6 +2172,250 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	return pkt_received;
 }
 
+static struct sk_buff *fec_build_skb_zc(struct xdp_buff *xsk,
+					struct napi_struct *napi)
+{
+	size_t len = xdp_get_buff_len(xsk);
+	struct sk_buff *skb;
+
+	skb = napi_alloc_skb(napi, len);
+	if (unlikely(!skb)) {
+		xsk_buff_free(xsk);
+		return NULL;
+	}
+
+	skb_put_data(skb, xsk->data, len);
+	xsk_buff_free(xsk);
+
+	return skb;
+}
+
+static int fec_enet_xsk_tx_xmit(struct fec_enet_private *fep,
+				struct xdp_buff *xsk, int cpu,
+				int queue)
+{
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	u32 offset = xsk->data - xsk->data_hard_start;
+	u32 headroom = txq->xsk_pool->headroom;
+	u32 len = xsk->data_end - xsk->data;
+	u32 index, status, estatus;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+
+	if (!fec_enet_get_free_txdesc_num(txq)) {
+		__netif_tx_unlock(nq);
+
+		return -EBUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = txq->bd.cur;
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	index = fec_enet_get_bd_index(bdp, &txq->bd);
+	dma = xsk_buff_xdp_get_frame_dma(xsk) + headroom + offset;
+
+	xsk_buff_raw_dma_sync_for_device(txq->xsk_pool, dma, len);
+
+	txq->tx_buf[index].buf_p = xsk;
+	txq->tx_buf[index].type = FEC_TXBUF_T_XSK_TX;
+
+	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+	if (fep->bufdesc_ex)
+		estatus = BD_ENET_TX_INT;
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dma);
+	bdp->cbd_datlen = cpu_to_fec16(len);
+
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
+	bdp->cbd_sc = cpu_to_fec16(status);
+	dma_wmb();
+
+	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+	txq->bd.cur = bdp;
+
+	__netif_tx_unlock(nq);
+
+	return 0;
+}
+
+static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	bool wakeup_xsk = false;
+	struct xdp_buff *xsk;
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	u32 xdp_res = 0;
+	int index, err;
+	u32 act;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		xsk = rxq->rx_buf[index].xdp;
+
+		if (fec_enet_update_cbd_zc(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		pkt_len -= sub_len;
+		xsk->data = xsk->data_hard_start + data_start;
+		/* Subtract FCS and 16bit shift */
+		xsk->data_end = xsk->data + pkt_len;
+		xsk->data_meta = xsk->data;
+		xsk_buff_dma_sync_for_cpu(xsk);
+
+		/* If the XSK pool is enabled before the bpf program is
+		 * installed, or the bpf program is uninstalled before
+		 * the XSK pool is disabled. prog will be NULL and we
+		 * need to set a default XDP_PASS action.
+		 */
+		if (unlikely(!prog))
+			act = XDP_PASS;
+		else
+			act = bpf_prog_run_xdp(prog, xsk);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			skb = fec_build_skb_zc(xsk, &fep->napi);
+			if (unlikely(!skb))
+				ndev->stats.rx_dropped++;
+			else
+				napi_gro_receive(&fep->napi, skb);
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xsk_tx_xmit(fep, xsk, cpu, queue);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, xsk, prog);
+			if (unlikely(err)) {
+				if (err == -ENOBUFS)
+					wakeup_xsk = true;
+
+				rxq->stats[RX_XDP_DROP]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(ndev, prog, act);
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			xsk_buff_free(xsk);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
+		xdp_do_flush();
+
+	if (xdp_res & FEC_ENET_XDP_TX)
+		fec_txq_trigger_xmit(fep, fep->tx_queue[queue]);
+
+	if (rxq->xsk_pool && xsk_uses_need_wakeup(rxq->xsk_pool)) {
+		if (wakeup_xsk)
+			xsk_set_rx_need_wakeup(rxq->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rxq->xsk_pool);
+	}
+
+	return pkt_received;
+}
+
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -2047,11 +2424,15 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
-		if (prog)
-			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
-						      prog);
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[i];
+		int batch = budget - done;
+
+		if (rxq->xsk_pool)
+			done += fec_enet_rx_queue_xsk(fep, i, batch, prog);
+		else if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, batch, prog);
 		else
-			done += fec_enet_rx_queue(fep, i, budget - done);
+			done += fec_enet_rx_queue(fep, i, batch);
 	}
 
 	return done;
@@ -2095,19 +2476,22 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int done = 0;
+	int rx_done = 0, tx_done = 0;
+	int max_done;
 
 	do {
-		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev, budget);
-	} while ((done < budget) && fec_enet_collect_events(fep));
+		rx_done += fec_enet_rx(ndev, budget - rx_done);
+		tx_done += fec_enet_tx(ndev, budget);
+		max_done = max(rx_done, tx_done);
+	} while ((max_done < budget) && fec_enet_collect_events(fep));
 
-	if (done < budget) {
-		napi_complete_done(napi, done);
+	if (max_done < budget) {
+		napi_complete_done(napi, max_done);
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+		return max_done;
 	}
 
-	return done;
+	return budget;
 }
 
 /* ------------------------------------------------------------------------- */
@@ -3398,7 +3782,8 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 				struct fec_enet_priv_rx_q *rxq)
 {
 	struct net_device *ndev = fep->netdev;
-	int err;
+	void *allocator;
+	int type, err;
 
 	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
 	if (err) {
@@ -3406,8 +3791,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
+	allocator = rxq->xsk_pool ? NULL : rxq->page_pool;
+	type = rxq->xsk_pool ? MEM_TYPE_XSK_BUFF_POOL : MEM_TYPE_PAGE_POOL;
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, type, allocator);
 	if (err) {
 		netdev_err(ndev, "Failed to register XDP mem model\n");
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
@@ -3415,6 +3801,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
+	if (rxq->xsk_pool)
+		xsk_pool_set_rxq_info(rxq->xsk_pool, &rxq->xdp_rxq);
+
 	return 0;
 }
 
@@ -3428,20 +3817,28 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 
 static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
 {
+	bool xsk = !!rxq->xsk_pool;
 	int i;
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
-		struct page *page = rxq->rx_buf[i];
+		union fec_rx_buffer *buf = &rxq->rx_buf[i];
 
-		if (!page)
+		if (!buf->buf_p)
 			continue;
 
-		page_pool_put_full_page(rxq->page_pool, page, false);
-		rxq->rx_buf[i] = NULL;
+		if (xsk)
+			xsk_buff_free(buf->xdp);
+		else
+			page_pool_put_full_page(rxq->page_pool,
+						buf->page, false);
+
+		rxq->rx_buf[i].buf_p = NULL;
 	}
 
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
+	if (!xsk) {
+		page_pool_destroy(rxq->page_pool);
+		rxq->page_pool = NULL;
+	}
 }
 
 static void fec_enet_free_buffers(struct net_device *ndev)
@@ -3481,6 +3878,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -3597,7 +3997,7 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
-		rxq->rx_buf[i] = page;
+		rxq->rx_buf[i].page = page;
 		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 
 		if (fep->bufdesc_ex) {
@@ -3621,6 +4021,40 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 	return err;
 }
 
+static int fec_alloc_rxq_buffers_zc(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
+{
+	struct bufdesc *bdp = rxq->bd.base;
+	union fec_rx_buffer *buf;
+	dma_addr_t phys_addr;
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		buf = &rxq->rx_buf[i];
+		buf->xdp = xsk_buff_alloc(rxq->xsk_pool);
+		if (!buf->xdp)
+			return -ENOMEM;
+
+		phys_addr = xsk_buff_xdp_get_dma(buf->xdp);
+		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+		}
+
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	/* Set the last buffer to wrap. */
+	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	return 0;
+}
+
 static int
 fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 {
@@ -3629,9 +4063,16 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	int err;
 
 	rxq = fep->rx_queue[queue];
-	err = fec_alloc_rxq_buffers_pp(fep, rxq);
-	if (err)
-		return err;
+	if (rxq->xsk_pool) {
+		/* RX XDP ZC buffer pool may not be populated, e.g.
+		 * xdpsock TX-only.
+		 */
+		fec_alloc_rxq_buffers_zc(fep, rxq);
+	} else {
+		err = fec_alloc_rxq_buffers_pp(fep, rxq);
+		if (err)
+			return err;
+	}
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err) {
@@ -3954,21 +4395,83 @@ static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
 
+static int fec_setup_xsk_pool(struct net_device *ndev,
+			      struct xsk_buff_pool *pool,
+			      u16 queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	bool is_run = netif_running(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	struct fec_enet_priv_tx_q *txq;
+	bool enable = !!pool;
+	int err;
+
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	if (is_run) {
+		napi_disable(&fep->napi);
+		netif_tx_disable(ndev);
+		synchronize_rcu();
+		fec_enet_free_buffers(ndev);
+	}
+
+	rxq = fep->rx_queue[queue];
+	txq = fep->tx_queue[queue];
+
+	if (enable) {
+		err = xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
+		if (err) {
+			netdev_err(ndev, "Failed to map xsk pool\n");
+			return err;
+		}
+
+		rxq->xsk_pool = pool;
+		txq->xsk_pool = pool;
+	} else {
+		xsk_pool_dma_unmap(rxq->xsk_pool, 0);
+		rxq->xsk_pool = NULL;
+		txq->xsk_pool = NULL;
+	}
+
+	if (is_run) {
+		err = fec_enet_alloc_buffers(ndev);
+		if (err) {
+			netdev_err(ndev, "Failed to alloc buffers\n");
+			goto err_alloc_buffers;
+		}
+
+		fec_restart(ndev);
+		napi_enable(&fep->napi);
+		netif_tx_start_all_queues(ndev);
+	}
+
+	return 0;
+
+err_alloc_buffers:
+	if (enable) {
+		xsk_pool_dma_unmap(pool, 0);
+		rxq->xsk_pool = NULL;
+		txq->xsk_pool = NULL;
+	}
+
+	return err;
+}
+
 static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	bool is_run = netif_running(dev);
 	struct bpf_prog *old_prog;
 
+	/* No need to support the SoCs that require to do the frame swap
+	 * because the performance wouldn't be better than the skb mode.
+	 */
+	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		return -EOPNOTSUPP;
+
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
-		/* No need to support the SoCs that require to
-		 * do the frame swap because the performance wouldn't be
-		 * better than the skb mode.
-		 */
-		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
-			return -EOPNOTSUPP;
-
 		if (!bpf->prog)
 			xdp_features_clear_redirect_target(dev);
 
@@ -3994,7 +4497,8 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		return 0;
 
 	case XDP_SETUP_XSK_POOL:
-		return -EOPNOTSUPP;
+		return fec_setup_xsk_pool(dev, bpf->xsk.pool,
+					  bpf->xsk.queue_id);
 
 	default:
 		return -EOPNOTSUPP;
@@ -4143,6 +4647,29 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	return sent_frames;
 }
 
+static int fec_enet_xsk_wakeup(struct net_device *ndev, u32 queue, u32 flags)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+
+	if (!netif_running(ndev) || !netif_carrier_ok(ndev))
+		return -ENETDOWN;
+
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	rxq = fep->rx_queue[queue];
+	if (!rxq->xsk_pool)
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&fep->napi)) {
+		if (likely(napi_schedule_prep(&fep->napi)))
+			__napi_schedule(&fep->napi);
+	}
+
+	return 0;
+}
+
 static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
@@ -4205,6 +4732,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_xsk_wakeup		= fec_enet_xsk_wakeup,
 	.ndo_hwtstamp_get	= fec_hwtstamp_get,
 	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
@@ -4332,7 +4860,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				     NETDEV_XDP_ACT_REDIRECT;
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	fec_restart(ndev);
 
-- 
2.34.1


