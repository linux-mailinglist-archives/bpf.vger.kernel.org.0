Return-Path: <bpf+bounces-76031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2809CA29BC
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 08:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A026301EFFB
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955EE28642A;
	Thu,  4 Dec 2025 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cEN0mtXr"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A7261B78;
	Thu,  4 Dec 2025 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832381; cv=fail; b=JsrAqpvyrwawwJVm9AtmQTjhBiinTsk8OJO81RI2lySugMdk1MW9DFqqzbvck0ViJAQ6d/2ptPvTlQBNQq25N5Z5O9vWMkDyI+RENrKkjolL6KnEtv5bjhFXMyN9ICa6HlE4juLPpXD8W3+vT6gLWWPoNAfk0l1O9YW52Nc4lJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832381; c=relaxed/simple;
	bh=xw9D35DUnM8VEI23TH1/p7l0tvHgf+n8PG/copK/7nE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PiA7nWNE3cmXsWOxsqcdGXE2n9Y8S9RUBYaL7Xsunhc/P+WYG0BgpFLMnBZ3C4W3v6NV+JHaswfuoXywi6zBf8hdXhxAbseLCFPUGqpnGidQzuvaEu7JpGF9I1BoFEzVC47lgaZ6HS6VaxcolI19r7BzA2+WBDErM++zCBQh4ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cEN0mtXr; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1Teo5GNe4e7exitoiOgX5n37HBNVuVsKo/9WBKtyVAd5CVkKGlD2I8CcO8jvpsSwqIoSGua4D1HyAJH+y3RyDwdvLnagdFt0wU0cRFwvB7//nmeEgXzvpU3VEgwI9MtmaKXMho44mYkhiFS+r0k14DjmByaEhORd7VTgS/Jl0gWRIYsPNnVOowWYVJuewFprR7NsS9hSKyPoGRxLvXPJnGMWw4Jx32AiXYNcd6GpCbKn7AjkVwUtBlZ9vxAN1tXGBIUOPX3aZNLGWg5qSDKvKDczWigHWX66T53gO6bNgwfWzw1m3P2Qvzcr3AnshpftzSZUkAoYazFfWB44BNIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIP/R1Am2jtLn2tNTHREzJcdQj6E6Ch3IniE5mg2gic=;
 b=ubUyuSfxsP5EVOJksaSxdeSoe1kzjmHXkU5TucHSQ4OmC1vV3jmOzNAE/CIRfcrtuFwRdS0dyK26t8Q5zK6wL+d7GoBI9w2d8cADWo+b3HmZnwMhQoPstFIaYYjCZmk42BLe6mBkZM/g1On+rDZtLG+hhR4O4p9EiPBlU+Cf5VLTSfPtFRrQCPAdUbqW/IrJ+A6PknYl+JBeTOKK/4iWh0WWzCMTpClkh52Xk60DaGhAahtKlsYklBZceAuPNOC9PbW3/i354bfVFIgDEDSZhNenvEU+lt+dWqxg0PaUtODXuDnXtQYHp2LX8Vz6q893HsUU3JqRKhHIy0qhNX2WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIP/R1Am2jtLn2tNTHREzJcdQj6E6Ch3IniE5mg2gic=;
 b=cEN0mtXro7qbnLGrWM1KaCgLDsa5m9IBST6gFUyBHJNApAwkRqeNq+WdqZzrgFRSBaS3uPIM78qgxLok7lh7vBOR8Od1v0+lhluc3QOv+aZX3MtFXfUqrQpMVcc/w3va/OfiaETH4Ew9uKU0cOU+oUT653UHrQ/7BtedotR6mN3u7ow9M8E5jDLD2M5ajiithrkIc/dXPiByMJy32LDn2DPHs+5ZkpHWnEiHkrAdeyswiVMvrLJsqlmi0cengQIhg5AkOP/Df/tVRv1+OajVuq0PiRmnYGk/Fe65nc+Ar3Cigi/pXobnGBohn9ExEvtd6OP8Rnv9Ix1lS7p4nHBEnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU6PR04MB11184.eurprd04.prod.outlook.com (2603:10a6:10:5c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 07:12:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 07:12:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	rmk+kernel@armlinux.org.uk,
	0x1207@gmail.com,
	hayashi.kunihiko@socionext.com,
	vladimir.oltean@nxp.com,
	boon.leong.ong@intel.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH net] net: stmmac: fix the crash issue for zero copy XDP_TX action
Date: Thu,  4 Dec 2025 15:13:32 +0800
Message-Id: <20251204071332.1907111-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU6PR04MB11184:EE_
X-MS-Office365-Filtering-Correlation-Id: c219e869-efa3-4d5f-5d36-08de33048bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcDDwxt+KD+0QNhn2qWvhyfnjCQRM91J+yoMcWPIT/mobinI6YqT5iwBHQm4?=
 =?us-ascii?Q?rS6v8T4CLTiF98cCJiX7mMfGHMTUSDVt+GqemOvqLCOkmXVVng/jrvgbwcmN?=
 =?us-ascii?Q?R6BLmdq3/GkndTFJ6itbD7TJTuhFLViOXX/RCqHn5o8OVWcux1gIWhF8DD1A?=
 =?us-ascii?Q?9QThSZVxJRRYlefyXRXe6ExDxpsSuzhofliB52s3reW6qPwwX2XbG6VzvsKO?=
 =?us-ascii?Q?Tnk9seBdZ7W+lqlu+e9eBk0toF9fFUmI2EorUMHAJldKTZ26i72ZuZt2O3EG?=
 =?us-ascii?Q?LELDIyqRynz0zAAFFCAZYMbvdvC/9LDhbdBAKZzG1M7c4VrjpVsnk87elyhR?=
 =?us-ascii?Q?RT3TPwirbyJEvugMWiEat2hZq5ZLh/2KAt2v8IqNjNgc0DidjI+ZJ9TTXE4j?=
 =?us-ascii?Q?Uvi9lZetGSKo8n5n42YegI+i77+sPUJNgcjkJnyolIlhmzdJH2s2cJWpx9LW?=
 =?us-ascii?Q?idlc3ndoX8RFbmII4eHtM+234a5C8IIK/oUm5FVIv2bSgOrkPk73YEwnSo5a?=
 =?us-ascii?Q?6kMrsN9fRBU/Z7c2Xfo2ZkMyrdLZc5Oh7wbrNXAAE63AFExC8DC9PlWc0jrj?=
 =?us-ascii?Q?LO97fe0o9KgrQJx+hhAg2ZeBarhbic1iBRjjeWShRrDHq7sfSV15jMLXg5zn?=
 =?us-ascii?Q?yOW0FKNjNGMfW2Q7Odztdu8kZhfbydl1kkRYIMteJOkyOS+Znw41V1JoJa1c?=
 =?us-ascii?Q?dX3qTqNCXXLKHODb2ltRvGrMCPqfDN2bhKaztKvKoI6kSq/QQpQ0PGKXowTb?=
 =?us-ascii?Q?lFUpyRaKEP7SNbiREUF61IfAQJLwtzurKIkMhcUOWS6mcJSVv186XSOEC4FT?=
 =?us-ascii?Q?WbUsC/R6bBBqaG8RPUnNx48sP+Sr9AKZp8dHzhIrNesMCWPxlMwDp3Ngl+HH?=
 =?us-ascii?Q?b2dY/qTGw0nZLrbGPWQcEUcjrvwLGvV3vKzfpFwbdZljCLDySqU4X+uwwHNF?=
 =?us-ascii?Q?PrtOdBQHSWnRtjbOqECQJAz8rzq9xUHLVPCSbFtw5JXp9MJ7nXK3chkbMGuQ?=
 =?us-ascii?Q?O4tLJMGdizUD0vtesS8sN0UJ1l9fFubtOd2kCTRz6qzHBOqw+0MhF8yz5waI?=
 =?us-ascii?Q?uIR4bsnVz9o7QOU7As2VVuXe45IL+8MMzUHRe9mfNUilOHRWVzhY/I9uqB6S?=
 =?us-ascii?Q?Rl4tyBZhFodnRBqhlSlZwGfmupdSYQhfnm5PvNMRzy67SdNz9VebMlytf7qS?=
 =?us-ascii?Q?YiopF1gmVrrwNwmGukNRGxHq6EvnDuJ0W4UU3Sgr6pHdFUzW7uzesV56GrEu?=
 =?us-ascii?Q?6K/e0iyOTomx1Yd7M5kbsTHEzd2gDxEeibr3KHaO1VIwM0IglDBRfynW7zmZ?=
 =?us-ascii?Q?jFfOfryHDUvBdVaJ606fSNU/EhaR7U1mF/4BxpBDW/JMpHk/YAGlbzOgoe1t?=
 =?us-ascii?Q?1Ta9K5JtBLalyEz8nfacnkUq5KPEB7wqg5HhsnL0NQjeiyr3nol4qbGYduDJ?=
 =?us-ascii?Q?q4Z609+F1pNasiNcGVIOcm6hD00BWJ+vOWKJB4zQZAzI8fqVjh18U+WVDhJ8?=
 =?us-ascii?Q?8VoQ0am4C40HYFcvo+GCVBSiNzFpKDiJNS2r693Jehn1oajDhIKnIibu/g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3OcbNs0OusLY+pwDq1AnjB5cViSU1aQuh4k0Tyjg224piU+eVRlo53nKTFK6?=
 =?us-ascii?Q?UM61uV7dFd7sUcOzFE9kQYzvYemU3Iatw5sPLnDIU4+T/8+tAumNmqiypcxi?=
 =?us-ascii?Q?+J1zlDyEqYRTYj3nsaBq21Oz/x1p7pf5AdW5I0T9UXlp3en0QBjek/3zn6Nz?=
 =?us-ascii?Q?Q1NQXk5i8k07mUeOV7Aw9iAiqyXIm4OTO12/JTSnzo4S/w71OtFOGAWNJr28?=
 =?us-ascii?Q?e/yEHV+6zyuNKW0WQxebSetryl0i5LvHs42ZadzUxYE8Yns2k+qBVYOWSpra?=
 =?us-ascii?Q?cuSX1PLPNPG/C72Z5AHzdCM7XrLQzaLie5MsuROWHiRb3UMAzK2osNt41VlB?=
 =?us-ascii?Q?2ALGEEaivKQbnutWHyuCAITLEVHEV495DVvnOZ3DQMU4bxhgD4ouTR5hElAQ?=
 =?us-ascii?Q?1AIRw6YB+7isMpdX8jShmkuOXmSuS9aLa2VfJCZRyGbDN49BkVMcQcG5qzs7?=
 =?us-ascii?Q?ukNVQxH1QWVuWSYn3xJwtVH2jtL//vl1burQg65oqF5HPplNMb9xlXELFfw0?=
 =?us-ascii?Q?qGvOEqcTzmKJP2xTXNz08D4w/yKb0DiHO4dMutHmVRi8KqhGaQooF99/FEKp?=
 =?us-ascii?Q?TzYt6PwuVQYntcBfCpIRcfEdhBFNmbplPDdsfJQ6t2yAcC1k+ihIlGNyRC/f?=
 =?us-ascii?Q?o/vNXQGZr4dQUS0T0BfPYdVUCkRNIwIkjaC92Lkh2WPEQueuXoGsGhFD3hsp?=
 =?us-ascii?Q?6PeC8xOjjnS141Np0TFODM0QasgY2CDaeUZxUTyQ2OoAWWLQI6Ia2FWtaAZh?=
 =?us-ascii?Q?VEGzLmKuvoPktdEKUd2+xj97cYCYd4jnfty9gBlnXcuPfY/nNgfLx5nItndM?=
 =?us-ascii?Q?UY1cDyL2xTMNBak4l/pl+mb8ytASiLnnogRrZCOFji0aqo1eWFmzy86IkT4I?=
 =?us-ascii?Q?eGHyxFQRMcAZmObQt/trT55SE/M2rf+iSvK6BmlAdgIPu6CmFtrKpaTXaF+a?=
 =?us-ascii?Q?bsVJA2ddt9KHjbpWKcy9IlOTgeBr5G+W58ZZx9Xurc6kVBQo8AL3QcC4vVgw?=
 =?us-ascii?Q?+DCItbwefZ2Iba/yebXjKsqyZzb+45XeucIaCJBV/B6e9vIIUHRsjqf+9DsE?=
 =?us-ascii?Q?bZpzAUY+utL6NENFz5FBukZSj8oCwY5lKlFsTCI6yLjv5T4GsEdzQ/ZRi4yF?=
 =?us-ascii?Q?+lOTtJpoKqP6ifW0YcPQXgAqCvKB2qFPgT340aNUtBHzXexNafwu3f+V34nR?=
 =?us-ascii?Q?Ip2CFPHO83SmkXbQqQGbkxtGqprKCdAGEi/drb2aN3HN5adHnJaj0DzGJmuI?=
 =?us-ascii?Q?0SWLpiSMF/sSmpBFCo6BzghJuqNYkjhj0F0CGOu6AlXMRhh3SB61y/Nybu+Z?=
 =?us-ascii?Q?ojHnH8qZplND/V7RnQvJNT1Wl1DWzOrQOloRh9i0R4rAv9Rhv86FjNOqE23l?=
 =?us-ascii?Q?wLMt9s+FUu21JVeSirbi1Pub+sqqkMwvBUkKxoYLrX5SnfNUipYdTR0FEk6F?=
 =?us-ascii?Q?wKDQY9KBBMl74YvyOZ6OhPzvBYCg+cP6XBVCYKGID01o/C4NZHnEps4YWl8F?=
 =?us-ascii?Q?r/71T8sNG8vKNH3WfkRYoj1MkQq3jiWiFzbRLua5Bc0wxckNTLX93Fa4E9zF?=
 =?us-ascii?Q?hnra8Mzf5PWUAaAbdN7f1EutM9ldWwJmyZS2ug5I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c219e869-efa3-4d5f-5d36-08de33048bc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:12:55.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKXbyn/EBiDm07D9I9e7BaGcdR4xFnnI6vr9T2xRUNl9tzrYbuh4EH6xt5ximR8hKfM/XOrI7VMNzSAFnAkZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11184

There is a crash issue when running zero copy XDP_TX action, the crash
log is shown below.

[  216.122464] Unable to handle kernel paging request at virtual address fffeffff80000000
[  216.187524] Internal error: Oops: 0000000096000144 [#1]  SMP
[  216.301694] Call trace:
[  216.304130]  dcache_clean_poc+0x20/0x38 (P)
[  216.308308]  __dma_sync_single_for_device+0x1bc/0x1e0
[  216.313351]  stmmac_xdp_xmit_xdpf+0x354/0x400
[  216.317701]  __stmmac_xdp_run_prog+0x164/0x368
[  216.322139]  stmmac_napi_poll_rxtx+0xba8/0xf00
[  216.326576]  __napi_poll+0x40/0x218
[  216.408054] Kernel panic - not syncing: Oops: Fatal exception in interrupt

For XDP_TX action, the xdp_buff is converted to xdp_frame by
xdp_convert_buff_to_frame(). The memory type of the resulting xdp_frame
depends on the memory type of the xdp_buff. For page pool based xdp_buff
it produces xdp_frame with memory type MEM_TYPE_PAGE_POOL. For zero copy
XSK pool based xdp_buff it produces xdp_frame with memory type
MEM_TYPE_PAGE_ORDER0. However, stmmac_xdp_xmit_back() does not check the
memory type and always uses the page pool type, this leads to invalid
mappings and causes the crash. Therefore, check the xdp_buff memory type
in stmmac_xdp_xmit_back() to fix this issue.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a55e..a6664f300e4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -88,6 +88,7 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");
 #define STMMAC_XDP_CONSUMED	BIT(0)
 #define STMMAC_XDP_TX		BIT(1)
 #define STMMAC_XDP_REDIRECT	BIT(2)
+#define STMMAC_XSK_CONSUMED	BIT(3)
 
 static int flow_ctrl = 0xdead;
 module_param(flow_ctrl, int, 0644);
@@ -4988,6 +4989,7 @@ static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,
 static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 				struct xdp_buff *xdp)
 {
+	bool zc = !!(xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL);
 	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
@@ -5004,9 +5006,18 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	/* Avoids TX time-out as we are sharing with slow path */
 	txq_trans_cond_update(nq);
 
-	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
-	if (res == STMMAC_XDP_TX)
+	/* For zero copy XDP_TX action, dma_map is true */
+	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
+	if (res == STMMAC_XDP_TX) {
 		stmmac_flush_tx_descriptors(priv, queue);
+	} else if (res == STMMAC_XDP_CONSUMED && zc) {
+		/* xdp has been freed by xdp_convert_buff_to_frame(),
+		 * no need to call xsk_buff_free() again, so return
+		 * STMMAC_XSK_CONSUMED.
+		 */
+		res = STMMAC_XSK_CONSUMED;
+		xdp_return_frame(xdpf);
+	}
 
 	__netif_tx_unlock(nq);
 
@@ -5356,6 +5367,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 		case STMMAC_XDP_CONSUMED:
 			xsk_buff_free(buf->xdp);
+			fallthrough;
+		case STMMAC_XSK_CONSUMED:
 			rx_dropped++;
 			break;
 		case STMMAC_XDP_TX:
-- 
2.34.1


