Return-Path: <bpf+bounces-78655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A290D16827
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7296A30619C4
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4833334D906;
	Tue, 13 Jan 2026 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lbf/mjfj"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B634CFA8;
	Tue, 13 Jan 2026 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275074; cv=fail; b=ckDntcLxdOc626ietB15y7TkEgrUeDrzeh2oLRbOT+OnGiN/TYBLIFOx48v6tXgtcxvsr9pECUlFlpBJlLtNGnfYR28gYwQULWIiVAoCojKyF0YiybmScy7sSwEUYbZRhQSXaJ2/V3NFyv+57qERmDH6biB6+ExiPp2PsOySZCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275074; c=relaxed/simple;
	bh=fWo+IqtWUBsfMf7CIcwglIkTzHx/NTjNKiXMiH4S29Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5RGu5JOYtMfIrK0eKYNELCJVAW1Li7jlAItCWXLUeeYO3lv/hYJjw3zDBiEah/VxOQtv5DDLoGEFOGgnghcfCZ7Ij6rihTum7EYPuT20aj58QE9Gbw4CqgTI6rZFJT7rMZpeIxpELVgjDZWdjeaybvjf7S/QKif+j+7rmvUolc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lbf/mjfj; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKmks+CaYMHv9TkWq1wc7IwIkfybxoR0FGm2nHf72ZbJQs3MAG+nb61DMKvk1vnrD4NfpSUJsW+Xq3VYGVqQSK438JJeE1danXlVpn4qhh41+/TLft6zKXGUV7ThOTe4cnnGKAtTEOR3HaNhgjGTDL2gntgoBx+hyvUiLBxU/ROLLHmIR3SenCgsMny8GOBSPiyk03C9C5U9qGmDokVu9WrTZaJQhamSV3My1yDxw26fZhvPq7B21VpjFB+SfAXE09SuqwwI1w1hEjhl1ZowS3o5p7L6iz1hCS2JhsEWHhps9ltWT/c81meSoti56tbth5+nN7e4XiZb7/8dKRHYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j455E+8B7IU7kRnFL2Glp6iGlZWBA7++sGMaX9hWyb0=;
 b=GGVI3hknRfuq/TcJrg0f2t46uFdr4TrSDgNC+xcxNtFrH2NB5vVNKGPxKPOktM22tAs5WqcRpsLx9WkGEyK3caCytg6LdttQXMj9Y2H4Hro1cIxx0WmRptG1WiO5b2HQGVpX+VEthf95jkC5GtF/cXO+gwBwZGnwUOLTg91+UAEsP38tETR7rTsiiGBGXissVTSUNOj5MxjkXOlSdljaTwiMYHEoH4iKBWZXbq31SgJogN/vJ/BXbi+RvFk6s2/IcNlW1jdiwxEwdz3NN+9OG0BKb6wUvULnUplpP40JD7oPWMJJEZ0afEpt2fUnnMf+OgiL1uMZTkrnFR2FTwKj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j455E+8B7IU7kRnFL2Glp6iGlZWBA7++sGMaX9hWyb0=;
 b=Lbf/mjfjxMzb1A0V/nHz60L2kxDFEPDyDrL8FlM/JKtkzvPLBBexGhmtZhuZX1cYjtXQdcvCJn+1cD6vgb+DviH5ItUfGf6jG2/iuQHmiC6+jMTMiJdNXBqfHek63vMY5yym/0lLXiyQQ/HKmA4jmB3DdNoSrU3vhfksofYi5PbE4WhhPJKjr4hEB3lA7vKsUhbruvcNk1MT00tVGG3Dh13DAMr7Yty6jwbPVf+crJV39HGEjX9+N6wMH11pDib2zelx2otH3XiUwxMvApEPjxr3xPlC0J1jCsMjzoOmg5n/4Tf5SzBfJ0ilSdP7rPy1+4yJguiNFY0wVuRt7x6Fpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 03:30:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Tue, 13 Jan 2026
 03:30:59 +0000
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
Subject: [PATCH net-next 11/11] net: fec: add AF_XDP zero-copy support
Date: Tue, 13 Jan 2026 11:29:39 +0800
Message-Id: <20260113032939.3705137-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58b7a6fa-99d5-475f-6e58-08de52542b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PAdQLGt0z0+LsowH++2wVOtWKnOymfKOpK0ZLqhnHji9oFlNzg2gcMiNt1B3?=
 =?us-ascii?Q?FYNNhAa3lFKlktaFXokce3r9NepBtg8ox8Ert8+CCfElPjO5d4KOO6sljt//?=
 =?us-ascii?Q?ArIGpHmd2NDtIcw7w+2pu4qkquyo9JrWI49qWRh2jplrgl7pNaqw+7DZNUPP?=
 =?us-ascii?Q?E3+LtcFjJZGi9vvCnPQou+3iXSLI8V+OEzIHchfaZZvoJcKABIIbPz6UwWEs?=
 =?us-ascii?Q?9b+MDUhCcWRv6i4gE2xwOBUHNg9/TsWDPT3qtW9+t+XlNMAN/0uev4O4+9b8?=
 =?us-ascii?Q?FHXl0KF1mZNqZwjA9xUFRffi+CV5HlpmdibcDwlPdCt27R6QsTy5bQ9kOnKs?=
 =?us-ascii?Q?nElHGxkD2BXAak37FmXDoABDxzUHk0qkBRXeCzMHB1ZRUMx9wKra4X54rrwL?=
 =?us-ascii?Q?l5JparuMxoVZW2CKXka8fIS1IpC89LgY64/f4Fy+boR3Rmen57ycW/Z/x/Kz?=
 =?us-ascii?Q?xLlP8lcIsqCD7w4MQQyDFzs9CKGMldoh2YG/ypcPUDDLJVQ3mWptmk/r8+QG?=
 =?us-ascii?Q?sQYuBi7DoOCGKY2mAEM/CzBV0FK/3N05yigniFxgEDpBx63X6DUxWs0PX6go?=
 =?us-ascii?Q?qlq9P5+wLxR2xC7ojUNIPsIxvDYIn/KsmYbAL893uY3MsEeIbV1GdC5DsdLI?=
 =?us-ascii?Q?097qEtUQOMGKOt2jpRfI/DGWh8gbAHNxZI20mU8VqDOPUeII0lbSRhn6LnXi?=
 =?us-ascii?Q?sfgiSKY9LmvJivhDyBRkCjdwG8YAC7wd3yRu2x7QEH3dxvhGArj8aa25mYtw?=
 =?us-ascii?Q?ws4Aafj5KlXLCYT9m4p5YH977XdoASK6pVvjLVRWGUWn/RxTWb3hZ2ocK/UO?=
 =?us-ascii?Q?jMJggT60llGYSU8LecDUhCNl8OHE4q7Sy7+ZxqiRBDv5V9eVyKaINxGjpjiX?=
 =?us-ascii?Q?3RlAcVT8ymg2Ol/BNAJmCNsxLW2/r7hEtLgDyx+SQkBMYCOeboSyG462ivrx?=
 =?us-ascii?Q?OGvNYlYvlQv78LABt+o3xBVK676dpF/N5aboernJDr2lWJekXPPHvjDwurc7?=
 =?us-ascii?Q?TtWMVWi37Xlt+B9uSIoNIJcK8BrThsxVo6VADU2DYEN6rMHwdgCO4KLFjd4a?=
 =?us-ascii?Q?BLMCaW+o9FaJT+cJK4c/9p9SCOFHjRO2tixS3n3y0E9bn7y2F0RpLx/GrkCp?=
 =?us-ascii?Q?Tc/faaDYz6y4yjzR/+mqRbcIiASy6TeBBPW+rZb1tPdVaBOm6XaLAClUYid0?=
 =?us-ascii?Q?6ItQzF6O75hMsU15qMyKV0yr2xYHcRtHdNGFAg7opePXFg8AMByFUsY3M39K?=
 =?us-ascii?Q?yy/cf7UulCiIobJRk9k17oOElWfovnMf2l+E5P8+7F+SVOUfH1A1q9rS4VNe?=
 =?us-ascii?Q?hIvehakTtOJmOzoAuOWKYeHpzBqkgFCcAvoG+j+vGfWMwCx7E5FRitYux/Zh?=
 =?us-ascii?Q?mBFevz0dFNVmRpLv/mQ/g6MqnrOa/MRotgVAvNq6zLktp4vD6HOsz/3BL9Fq?=
 =?us-ascii?Q?eJ/VNCHTzuw/j9EqFZr5RMF+SZYGZrK2jz8XOs1ClYAmphqzgOpsja1tbw3Y?=
 =?us-ascii?Q?zEWSpXK+XUf0XJ3iZx+qOmrVdYaz7/OHm/hInafyh/xk43PzdmiPzP9tVw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okMmnWtLQk1KWUEw3IXf2M6a7MOhLYA8Bnq5scB42FkWkWVnehQDAgnMWBq6?=
 =?us-ascii?Q?W8sUli4nXH/B22BtPO4t8v9rfb2w5+LHB/hOcY+lrg6rZta4dLLVtwdft38v?=
 =?us-ascii?Q?ZRMczL6qb4naFbHbwoAQzht5uPvG7aXUbUKXlZb6d5YeQZvdVW6+Iltuvvdm?=
 =?us-ascii?Q?Kkx17qc8BHIdyct3iC+mT/ppRq3euF3U6t0VgmJXWIStfuvFaJc0F9j31l7z?=
 =?us-ascii?Q?TXN+1+A5Po2UiAQTBGL01lh00gXm9BIfan55+OkOtDlxVDjZY0eFdJLZ5SWt?=
 =?us-ascii?Q?s+xCea9P6yTTZa0nvvh+mmkCxW3v3KfNozaszvnfYjEol2UD7K9C+YfF42BZ?=
 =?us-ascii?Q?9QvI6monx6DJo4KqQFthHSdkqbynpPtsfwb994Z7k4QtqQp32SrB0a7z90Vi?=
 =?us-ascii?Q?/oCnoX4VrU3qQHV48pag5M6MWcyctvcX5BpSuF5LijzynqnN32u1UmREqs8U?=
 =?us-ascii?Q?NU5hYWJcS4kmYa13jEiMsgu31gTiaENXEKrRqaS5OlrvPeY8by7rBqL1afM/?=
 =?us-ascii?Q?6l8ay8gZ8d28Tqrso142vP7dgV4PTICedTb8FjuKDF1MupqVSrHFZ3qpxI7Z?=
 =?us-ascii?Q?fiDIOaPEtcXIEwQbIO8RS0+HpZPnSmxceWMI8dQNfYBmMyRfT5OTfiTdR022?=
 =?us-ascii?Q?djAGhA3WS1zoHcKqjPxx2sOBEuOA/uWtFD/nsxOjMhyrOuBJTc7vxJaeP/8Z?=
 =?us-ascii?Q?Sjx9F0gvG972o8liWkLiWMPPwj+ncrBH+P2ckM4V/W4Ahw3NKXGddw2sslIA?=
 =?us-ascii?Q?VmA5V7eNoW1O3PG6+3fZyKEXDQuvMxbNWbNDBBMinhsh+y1CwyzkSVOytCzw?=
 =?us-ascii?Q?eeJs1k2y8vfPMCMLiXEVLumaZqAB8mLIUgZLLffLTRUepHk72IX7B9dZ1Wsi?=
 =?us-ascii?Q?XVqEx4j1RV4TIE1vW+EPNV13+cUrdiMtQgdoPca0ihJZReaYMeTL7fGW53pf?=
 =?us-ascii?Q?wrK8tnGlSPQJQZidveYljYAgy+YdEaD+GIbPZNSRmYuVk4ZQDuCaLuOHVYC2?=
 =?us-ascii?Q?XBAxBQEc3JoKJiUrnA6/a8tRsfQZmwG/CWwXX/q4sAkMN2LEyMOxfqzFcG/V?=
 =?us-ascii?Q?9UpkZEZ1qmz142REf1WkVpsbw8pEmH/LE5939l+67dT0KxPbMQP1zeZ62TcR?=
 =?us-ascii?Q?qN6ZnsxUpciHmZmKZo+fYYEwQx5n+bcfDWcGBX1ce6BiEDWCFLmBHy1JW/4i?=
 =?us-ascii?Q?UP9dnSAYZx/iSD+Rfc5EubNYtsXrGRdKR/c4s7HuXdapy0Tzqh/5O5lJ8l9Z?=
 =?us-ascii?Q?ZiUV2MZ0qmjgcBqfv8J43711hCALH1z2+f0gc/vlxscx5GW4up94mJIl//BL?=
 =?us-ascii?Q?KGYL73mGhd3jhPj7HAewh5jAk7u1VqhSfRwmohfjkgGHvihYX6d1YQ9V9Oyu?=
 =?us-ascii?Q?0J7l9WFsBJQ7dBugQOt7i7fL9kjjLQK3TSq9+1GPxvztZ0k3Q73s1AGBcwiY?=
 =?us-ascii?Q?jbFiGUX+qcWvnWt6Lqsg43VKsFx2zFXHxgNYT3jwIhf/yTUEDYEHMuVcJtUo?=
 =?us-ascii?Q?liCdBP4WvhwLoP7tahjVpOiZEwFz9F8swN3SnER22+GJiju+P/21VdArU71k?=
 =?us-ascii?Q?JeL9yxtjtmmw26gfeClF89e8hmpp6h0CB1YC+dI7HZux9h2ndP2sjJIhSxpX?=
 =?us-ascii?Q?c21Nx3uHEIecpFZFQmTtklNvkuLXNJv402GQUmowMKuwJ4LmGmlVYEObsIgF?=
 =?us-ascii?Q?y1fpvk0hpS4JRfbSqgdzmc4YSZ9IwlcCyoCybgU0GuYRYf0U5Fmr3x4rrjQe?=
 =?us-ascii?Q?lHFEFISaOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b7a6fa-99d5-475f-6e58-08de52542b41
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:30:59.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4X0k1wFLXDbr+QQ6t74mZqTA2IGU8Pm5p8iDZFNbVTN2PIcc0kFkuRI6Coc4FjTJ/ZDQBcYzp8GKJN+2z55Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

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
 drivers/net/ethernet/freescale/fec_main.c | 634 ++++++++++++++++++++--
 2 files changed, 590 insertions(+), 57 deletions(-)

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
index 29ee9e165068..e3071c9ff87d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -71,6 +71,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
+#include <net/xdp_sock_drv.h>
 #include <soc/imx/cpuidle.h>
 
 #include "fec.h"
@@ -1032,6 +1033,9 @@ static void fec_enet_bd_init(struct net_device *dev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -1465,27 +1469,104 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static bool fec_enet_xsk_xmit(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u32 queue)
 {
-	struct	fec_enet_private *fep;
-	struct xdp_frame *xdpf;
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xdp_desc *xsk_desc = pool->tx_descs;
+	int cpu = smp_processor_id();
+	int free_bds, budget, batch;
+	struct netdev_queue *nq;
 	struct bufdesc *bdp;
-	unsigned short status;
-	struct	sk_buff	*skb;
-	struct fec_enet_priv_tx_q *txq;
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
+			     int queue, int budget)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = txq->dirty_tx;
+	int index, frame_len, entries_free;
 	struct netdev_queue *nq;
-	int	index = 0;
-	int	entries_free;
+	struct xdp_frame *xdpf;
+	unsigned short status;
+	struct sk_buff *skb;
 	struct page *page;
-	int frame_len;
-
-	fep = netdev_priv(ndev);
+	int xsk_cnt = 0;
 
-	txq = fep->tx_queue[queue_id];
-	/* get next bdp of dirty_tx */
-	nq = netdev_get_tx_queue(ndev, queue_id);
-	bdp = txq->dirty_tx;
+	nq = netdev_get_tx_queue(ndev, queue);
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1556,6 +1637,12 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
 					   0, true);
 			break;
+		case FEC_TXBUF_T_XSK_XMIT:
+			xsk_cnt++;
+			break;
+		case FEC_TXBUF_T_XSK_TX:
+			xsk_buff_free(txq->tx_buf[index].buf_p);
+			break;
 		default:
 			break;
 		}
@@ -1611,21 +1698,41 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	}
 
 out:
-
 	/* ERR006358: Keep the transmitter going */
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
-		fec_enet_tx_queue(ndev, i, budget);
+		count += fec_enet_tx_queue(fep, i, budget);
+
+	return count;
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1638,13 +1745,30 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
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
@@ -1799,7 +1923,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -1917,7 +2041,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
@@ -2032,6 +2156,255 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
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
+	/* Trigger transmission start */
+	fec_txq_trigger_xmit(fep, txq);
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
+	dma_addr_t dma;
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
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
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
@@ -2040,11 +2413,15 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
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
@@ -2088,19 +2465,22 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
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
@@ -3391,7 +3771,8 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 				struct fec_enet_priv_rx_q *rxq)
 {
 	struct net_device *ndev = fep->netdev;
-	int err;
+	void *allocator;
+	int type, err;
 
 	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
 	if (err) {
@@ -3399,8 +3780,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
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
@@ -3408,6 +3790,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
+	if (rxq->xsk_pool)
+		xsk_pool_set_rxq_info(rxq->xsk_pool, &rxq->xdp_rxq);
+
 	return 0;
 }
 
@@ -3421,20 +3806,28 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 
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
@@ -3590,7 +3983,7 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
-		rxq->rx_buf[i] = page;
+		rxq->rx_buf[i].page = page;
 		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 
 		if (fep->bufdesc_ex) {
@@ -3614,6 +4007,40 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
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
@@ -3622,9 +4049,16 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
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
@@ -3947,21 +4381,83 @@ static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
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
 
@@ -3987,7 +4483,8 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		return 0;
 
 	case XDP_SETUP_XSK_POOL:
-		return -EOPNOTSUPP;
+		return fec_setup_xsk_pool(dev, bpf->xsk.pool,
+					  bpf->xsk.queue_id);
 
 	default:
 		return -EOPNOTSUPP;
@@ -4147,6 +4644,29 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
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
@@ -4209,6 +4729,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_xsk_wakeup		= fec_enet_xsk_wakeup,
 	.ndo_hwtstamp_get	= fec_hwtstamp_get,
 	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
@@ -4336,7 +4857,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				     NETDEV_XDP_ACT_REDIRECT;
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	fec_restart(ndev);
 
-- 
2.34.1


