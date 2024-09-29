Return-Path: <bpf+bounces-40473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51C9892D0
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C235C2838DC
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B6224FA;
	Sun, 29 Sep 2024 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ED8HuMqn"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1898BE7;
	Sun, 29 Sep 2024 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727578844; cv=fail; b=n0dd+CSt4AotcNjIyCfWZjZKXvkMXF+qPbWpRvGoH5XpmWzedIysuqtsKvEQMF8gFWXQ6/GlLhH/KudkO38ldwxjzcOCu4hoDmVicEl9dHfxa5WwBLGOVxCdjPNzzwvbXru274Gut79vy3CdZjxlcTyYETgup1wJ66GyyGow04I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727578844; c=relaxed/simple;
	bh=+MUEPLguGX8fYq84Znn4lytDLx/KISrgs7dC4x9cmR0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OOMHt3qoeBVECaewvdAcMJVfvEQz2WyhO0c5qYccwwiN1CQ7lB9PmNM02K0gUz/zOHgQz/yj8Szv15GMSG1OsOeXY2RmfiJncFYBsyT79b3OhGeHMhO022qc2GvoPipkaAbPgZjFNANxEWVUQwCLhuxnRmGdFL5JAhEfbsS5HeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ED8HuMqn; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM008ffO6gvAenSALYDzWKEG8fQ1Wgq/a9EPCYLKi3pbTmEmkZB6InKXseFe2DBlFaGXUF7phog0kybmZcIv6w3RhyyRdvwlgp2eyr5SLsVbyRQNuZj6hMknRDkkOizz8/RZ6W+oY80ojLgfn5SWagiRLF3iIy0rUi9Z69rtK9XIgV8qgXu0NQJlYgcn7A9krMk6oZwp00cDiC9R8fGA5XHXpOUBf7iEKQzoNIDQImvk8820KeLRbm30NIgC8BRfb8+RbYYyOBht9Oc9Td1t95FKe4hqjVWxOcZoR4p+ME0s0WtLn0D4U7lfgdQXeElxkFNC2avvnApNGsRrj2/fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+npkUDHZQItdA8r0Av4kBXt0Y+/u2JuKSBl2xXNWO7g=;
 b=v7137Kskz2TikD/+h6C39TwJ6lPnumV/+V9XPtJ2bk3y/bV2h3EWyzlGFf9rEX3g0E9tHx5E+pMSpCYKyhXrOxgAQZ/1//EEfa0Wakz0AXtsJ2/oVRFD24+qPDmpOsdnZ0FeR9b6BxUHA1SvmcZupIxNX6xJCZpqufl5um3QdFTgNoT1gQ9QzHAtXALYkPw+ZC82bzhO74/dU2+AAXo7n8zGQOdIzlYdAqEkQTnOHsPkqSplV5yToBJKqkLXgK6wRJ6YmxWhXqZGQLdDcx8vE3SlBE5MDB9pFG3o/tFLyYE7SnJapVQOBQ+qQz9z74G/uEJ3JkF5605wIadz8pbBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+npkUDHZQItdA8r0Av4kBXt0Y+/u2JuKSBl2xXNWO7g=;
 b=ED8HuMqnmkDNC9yq/q71ZoVYEzbbqev9BwtQEcybdaI3AwjPpAm7wMlOR07vTkv9li7nFKGgs3qq12N4Pts3A8Z4gaW7ehTXF7KZSOm4FkqdD3QTlUDTUvG0FhGU3jusDL+7hoieXf2ZYSFcEUTtqRNnLRygZDzVCNj9Z/lWwyATHr0FUeXCK3cpx3VvAZ26UWNDi4Zydg019NHuoDV3IpBhnVntNHGJrkG8MjZeFqbHo94SNanFvh3k39h7IGgCvjR5hKfBRGdQw0yCZq3ThZwoPs6aR5HBh8G8EbASvaX7yZFa740k0BPWh1B8/K411E6rTCkBE13Ucn2Ttp0Ddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10690.eurprd04.prod.outlook.com (2603:10a6:800:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 03:00:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Sun, 29 Sep 2024
 03:00:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	rkannoth@marvell.com,
	maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: [PATCH v2 net 0/3] net: enetc: fix some issues of XDP
Date: Sun, 29 Sep 2024 10:45:03 +0800
Message-Id: <20240929024506.1527828-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10690:EE_
X-MS-Office365-Filtering-Correlation-Id: 01828681-7e92-4b08-b12b-08dce032e1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NcAT19ifSE494E9lTsGimMHOG1sYd69tNRqGCoJElIDsyCXUw5r+oWnV7EVM?=
 =?us-ascii?Q?Qilq86CTnuM+iR45TNZcRdfAaALhcB9lH3oYmj3iTJU8zl0b6LYRk1pZ43KY?=
 =?us-ascii?Q?vERyYTNUpA2W3uVgAnfnz7VWOL+AGNoXdBmKKrTRfeGGZsQuJeX22fv7HTjh?=
 =?us-ascii?Q?OTCHz7EcZ39OKoHbJFxTkZ5KpqSIzXKRKqYGayT9zvhibVyX0FWvHF+Uh7tV?=
 =?us-ascii?Q?aXqbsGyB1yue815r9PDZcvBSsxUBxlhnK7poHv7o00glK8yLn4jZjGkzRame?=
 =?us-ascii?Q?IlxaeS0fXYVEB6Wu1U23P0ncEtIvrRhHmtJOxjy9pVum1s+AODjo21UJrSpK?=
 =?us-ascii?Q?fdlkMSjA2S+64wHx+vWLgGiVUsy4yfErA6nl9SY9N2MTQy6UOJzcKViTVHw5?=
 =?us-ascii?Q?B7m6gsqsptIvLa4Y8s//3YfR2lm7GDUopFD66XXWQpPmt0nIH41nJ30/dQOX?=
 =?us-ascii?Q?J0Vdx+MPviEIGj1tcROd2Tmyg0LCJvcYwKDnapCVTYw0qS1h1y+18Lou56qr?=
 =?us-ascii?Q?jjpdq5ZmTI/2PtIa2g2d1rbZEdqA2JAQOUI6YbRiu8l+3oLmln9UGHe2Nm7P?=
 =?us-ascii?Q?IdslbnwZvKj3Hj/mhO4o/EWT2biL6/dhO7CtHhKmUzdutHntrp7jgCNd3LCI?=
 =?us-ascii?Q?siD/6TqOcWjPH4+1JUdgge1mn4s+dtCWKzDvusIieyy8tWkpb8KaPRENWEts?=
 =?us-ascii?Q?hQRZ4LqwdnkwnbIXmVIRCQyFZ9u+CgoPhD83opasSMs2rvAL0KDDMUjbPBO/?=
 =?us-ascii?Q?EvcoDV1kkGTfDL49Nd0NcuXGBcfoUYnTlASHraEeoSoa5y2l6ll/+9Ytg8e7?=
 =?us-ascii?Q?bj1PU4aCCedpyLw7ZyFiXXK4w0UHXIko+F/W70eRNszSMexiLs2Yt9HDKJm1?=
 =?us-ascii?Q?M73xUJrBEsMm/ZTREcF5k2Qjj2APBdtFkGnzVCgTi+s8m8pd5LDv2/O9HJCX?=
 =?us-ascii?Q?ueSz1cFBgcHDnCu0xIK0CcGSvOrSqEQdaVEt13gd7OkYYUaXuHj3SCt8e+H7?=
 =?us-ascii?Q?reFpXEZ0Niy7DGGVb7fXb+YRvwhGVb5lctxBGZ29smF6vKw2Wae+C7pumDKD?=
 =?us-ascii?Q?gDfB71Yb+FKZz2Wv1K1AggsaK9Rk/d9erDTM1CtvWCtkhhUh9Lx3BOTi86Lg?=
 =?us-ascii?Q?GbTMj3yGXUV75HdHdGmbt3X9zswq3AgoZLcg4xAod26VhHfuZYKUJvAbJ8EB?=
 =?us-ascii?Q?LpaV7G1tJy4qbDDV/24BKY8+q/IGHNgZcYPcb5NEmhpkR79hIAQdysc6Slr3?=
 =?us-ascii?Q?BX22a7BJ/1EP9/XIiOjyecdBpg2UUQboEhsaFHosaeJv+/Fc+Fmt7PjHufFt?=
 =?us-ascii?Q?ylGyGqd0TE9FY1sJ5wcY7ZeBJ96Tnxli5ieT4tQz30toyHYhidHNks21dwJp?=
 =?us-ascii?Q?S/ISP3J6Sc3X2Sqn6zvUaKobXNKDu3Z/S+g58vlSSAeN8hNdeVox/5qwGeof?=
 =?us-ascii?Q?9cN+JDNsOfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQ3XyP1e/MUnsyKi3JRmDe7C6dDMRgWkewHlzKetBodtNqRB41QTtzwKKJ7D?=
 =?us-ascii?Q?xlb2N6clVH2AKw8EN/yG5ZxYUrGDH+JOo574G/R2Zqm1i2ebpcjFg6s6w82H?=
 =?us-ascii?Q?5jwSTDrYUvUu+3/a0V92yv9RjTUXpaI7YMHBQLwp4AiDxAZcfXVX8Z4Ty/S2?=
 =?us-ascii?Q?Z+av6zIBT8tdYc4y9PXlYODXNuRT5dZvu4DGoQdvLkOeM5ESFzGRoXtfwFcd?=
 =?us-ascii?Q?9TmXu37TZXeLhuDV+r5sTMqhYHSP4sLtuxWACXlj01BBgU4uvONmvuRDyxnn?=
 =?us-ascii?Q?ghqUASvqSNNZ/h3Gq6U1bmr/l8QnEj0zw2AC6v4A9MLjMQ1vRjrvvw/X6NGR?=
 =?us-ascii?Q?VI+brFfaU3oruqCKBDPF/HnwZasDe6B3e7fpDcDMkMTweaPsmyVK/EUJ+xO0?=
 =?us-ascii?Q?Cjkq50jQ1+a1WXF3e9Mcx0Ufe5N7i4UdrMGYIdifTo+rY1yrX06QXYQt3lZh?=
 =?us-ascii?Q?SpixaRoVIUT9OTND97RfTN1ou1B92T0cjeV/Juwxmn3uH/bfnxX7f+5DLfmn?=
 =?us-ascii?Q?i6Fu4yKFhHw0rTujP+rlkjodOD8X83vwdzpVZIhuipyj+n3K9bWgAYc2J/HH?=
 =?us-ascii?Q?YlxptlOhWUZXT3xBgfqgf3Y/PNXwgsAsUIc0Q1hAzalV2cpRXMuePqaw5I1v?=
 =?us-ascii?Q?D5WqNOV+Qt+mCvUzTxeA1wAQ1Bs+d4ld/sDJvmDlRpmSiF7mrU26w/EH5T7a?=
 =?us-ascii?Q?QySaeVoHJIv0j9HxPPqBxSwsTMLjQGN8PsRIuCg/gtB+mpXrekSM2ViOzrIo?=
 =?us-ascii?Q?X/mf2dnTuIVgcO65t+dADTSWHjCihVJvhReMcql4ADMYgW7+EnqjN3asCAc0?=
 =?us-ascii?Q?lfkEfgSuTHE8PpvUWMswwXqOsb+mITarVafkzvI0/8xReNE6w/Rdg5zHW4Am?=
 =?us-ascii?Q?E3hP6zg1jOM/7Wa5wUsU+NUcmt4cxGT8XmS9+1O2+eB7hLgoQD83wrHFVEhj?=
 =?us-ascii?Q?3myqZFTZnBNKiqvwUxxldG18J4V8RL5Y4KkZB9rjdTcT4L5GCoJ10p0XYIiv?=
 =?us-ascii?Q?Wsl679P7oDy9zicNeWJxtgAjW4TeFV1YW4JmLCMaB9We8IfFbw6K/jxZJbG2?=
 =?us-ascii?Q?SffY6AIYVFPlZd5dsM8KbXsnWBSr1gjZ64nsyKBh8kY+rShe42FAP5z0gu4W?=
 =?us-ascii?Q?UTNdOnk5PA9hRCV38wEehWpwHd9ZbxRU2DUldm9d3zR3ddg1eQv0/GcrCCKx?=
 =?us-ascii?Q?EF7N4ZCPsMwTQ87/gc3OqC53rncmcS7sTnIa4YTejp+kuwll8WKYrGk1FIM6?=
 =?us-ascii?Q?mCxgBW1anMijExoP6zPCnex2uoAmLvSr89kprh5528Dber2L7fsidrVQwgTq?=
 =?us-ascii?Q?cZVp6TMuygoP+zx6JmQKaaxtJMapV9SwvKiFyoRJKp2750Rn4kj/gd0wMPlg?=
 =?us-ascii?Q?SE+sP3D3q4c/8Jf2hkxLflx7QRL4lPKgzo9oquVq2W9rnuzYBfTsJ8CINr9h?=
 =?us-ascii?Q?tLEshiY2PkXMkyK0g5GuYeST7ZGKeOtWDWlObWfspjuEC5Yt0XtfSaJY8XAF?=
 =?us-ascii?Q?371xI5HuxSnWXt/4JKernSrDuF8yReWKaxy9jCX+4gokcgoGiFaLgBt9xzQV?=
 =?us-ascii?Q?GzfSfZ9cTyEajLkfwCV+A0M26O8oQa+Nvpo/7h7g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01828681-7e92-4b08-b12b-08dce032e1e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 03:00:32.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH6Pd0TwbpyK08S6CnZSzNEFUbJh4VdFeJG+oAm6vVt7ymUX2oTBsPuvY1Vox7Ood5RutVofKUtsOCkZ8FI1Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10690

We found some bugs when testing the XDP function of enetc driver,
and these bugs are easy to reproduce. This is not only causes XDP
to not work, but also the network cannot be restored after exiting
the XDP program. So the patch set is mainly to fix these bugs. For
details, please see the commit message of each patch.

---
v1 link: https://lore.kernel.org/bpf/20240919084104.661180-1-wei.fang@nxp.com/T/
---

Wei Fang (3):
  net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
  net: enetc: fix the issues of XDP_REDIRECT feature
  net: enetc: disable IRQ after Rx and Tx BD rings are disabled

 drivers/net/ethernet/freescale/enetc/enetc.c | 50 +++++++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h |  1 +
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.34.1


