Return-Path: <bpf+bounces-76465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B389CB5AAA
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C1D30136EA
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BC2FFFA8;
	Thu, 11 Dec 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="igpSJU5U"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03732DF121;
	Thu, 11 Dec 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453235; cv=fail; b=qU/0ZK0fz3WM0VzKFIaTETyKPXHd/0Be3xWt1rVcXwDQfaU1b0T3FMB4qigmxWltbTHoEZor6z5LfsMGZtuISenHfnE+b4aXRVSx7vHzU/HpnfNjGTigKRMhSLODVrA6hVYNesaK29XPMedxqEanSZGlGHIA8+G6D4oLgcTvVbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453235; c=relaxed/simple;
	bh=lT+1O07jfAPnU3cZmNRgQzOdTxIQHgcClTXUqCXfFkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RiwGyPhZE0mMV5Vk+MtESREdIueyrduGFiTqB8aCIcm5cHApKnNISgld0CV6fXujtNgkf6BH0CF9EDFdOnqqR0S+jFL13dhug5P+XDS+O0e4TW72TuvqUDBm2bnjXDhsITXskIIRMDDy5fJ9T5BwmVqucVm2MFeiU57jJI5bkJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=igpSJU5U; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzkHM89YW2FU+SVa3pIkbiORo9kE6Hz2EaatxWAmPgw4ZE13rl17xK2j9/SmjEUI+sdg3jwXgr0Wxk1c2m0PIMVv4XA5Z1sRUaHE5L4xiMc9RuroOYBtHCK+EhW4WO7GzCWvHyJ6sMgs4v4KuWXsQnarwCAcIArOV63RDR1cd9X2er03iuqywq/7v/+cL5ua3sEhRc7zGA8MVZ+WOaDqJA0XjSLzm/rkQd/5q1JCUx/5miIn+8T0a18691KC9PzCoM3Q5xDDVgSJObDqku7I4l992cKDlnvz61yX2AqCGDLc2Zgn3yR1LfqZ6g2AVGU+0a9gLhgjO5afBN8nmc1YAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ4LlO0duDYbQlRwAoGcfdMcvhi92MjA4uBjhzBHsvA=;
 b=wm/CrNH4wTMGDE8ufb4B483cU2l2O5RAj7kR9JP2NTvB080Xyb/c8PmO06P5eVbGL+2yiVDP0u0O1ZeQH83Kiz2cya4NVR8udY2hlMhT7U2HTdCdJUE5wlQaL/WiDMGxI7+PLlnd7sd6O5JGfFMv5ol6Fg0f4/7p3kGDfE5kP1g3lMzTB6dGgU15pGD8dYHJNO0RwAK73AXdv8bRK1Krd6QrvKgPkapgGIKBChKwy0zSe3p+WSAFwRyRKLWI/7X/vaPjZl2j1st8LUsXtESK15RLxnkYvst4F7FTkWKMo0MyKrSitnnB5d+DNHs1gOWO4Nxo0SARTLehvdVfoSExyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ4LlO0duDYbQlRwAoGcfdMcvhi92MjA4uBjhzBHsvA=;
 b=igpSJU5UTluTeDZfU7kCXe4lbLsqEiINPTkZ/C+C2QEUU0ZnWpjJXJxB49OulnXiDa3Az9yYfXNelg2SDRoNiEHpCU9wB+xspc+zUDvECoTOYQ+bcuBHrZhddBODFh0RprwT5oFdmI6XVfmGbFSW3MtCYpFOy7x4HFZtBVeTsq/WFHZbmVCaLczW8LuepI8kfWhD8n71GvzkGUF+KCj9CFizVuE/0xsxnSpDSGNrQzYQwZ7p97qzNBwvLsHEM2gzTkixzSVNzrkAi9fu1XQH3CJsIuP9IznLr7+hp66yg/MQm2nRHC+YLLKqdbB0aR9LnqhVg1P8MWICJxuGuwOoRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA2PR04MB10258.eurprd04.prod.outlook.com (2603:10a6:102:404::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 11:40:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:40:28 +0000
Date: Thu, 11 Dec 2025 13:40:25 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	frank.li@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Message-ID: <20251211114025.3gqkeh4drdcp2tv5@skbuf>
References: <20251211020919.121113-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211020919.121113-1-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA2PR04MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3358f5e8-d927-4a96-f520-08de38aa154c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NG8ilYpi/pAomiwL2D/yDGTHOhy6R2Dq9o+mmw4An6ynQ33WuARO4chsvZI?=
 =?us-ascii?Q?Fy2tTeT5JBnj3wr7iqZ8nZTrQHsKfOacYGm2xBGf3gFyJqsXCRLieWspSCUp?=
 =?us-ascii?Q?NfgDzINvzguiS25mYBtbxgp0mXY20EdiQ+7LxmxnbylfXndebVs3u0rqbTAj?=
 =?us-ascii?Q?rwYOEhV1fYYNYoT2bU18OtxruU/mzEZCHFS+T/fPQqwmfdK32uM8NPjkuJUb?=
 =?us-ascii?Q?ntDm3JC2AsoerQTHPjTJurqusmN/ogVBdS+JCWe/mxe03pSAq97SbBS6Gd2N?=
 =?us-ascii?Q?ePlUoUG/fSV0fem9bU/ADGe0yyvvH9XodwlnCxcvjLnNCZTJ2M+iGyc/n6ce?=
 =?us-ascii?Q?R10TDMdKxyLLMTsiGIxYqe0ACrfWFAWGAigLgK8Z+HtNCyaEVyV5L/AO1JYX?=
 =?us-ascii?Q?Y+dA7RSxO2sVja47JSnlwCl4/ZZ00sVbXjThgfJlzN8anXPCicVYlDXpMSNZ?=
 =?us-ascii?Q?Ffpl5Gc5KfdysJdDx2sSsQaqRP19zXt/uVH2VH6/C0LKi3WiFYeCa8nD6LOF?=
 =?us-ascii?Q?ZcMo1MH4j22a+YzfVAsJJUkP6GmzexiH1GVVtMQeQjx9InZA/AZw7LAAhMhH?=
 =?us-ascii?Q?zS6ecUkhM+OXcO2xhK2esGln/J0TecvBcU52GeHxyk6nKZ7C7nNgll/DmoTq?=
 =?us-ascii?Q?blISQGIWIU98OqC7GW+HniaBldpR0Js2hXSxCbiJRlMp9gZh+2SgSp6dAX8q?=
 =?us-ascii?Q?2GAdJENlHRl+5Er/FDPDV3QqeZice3T9y1b5GdP/+4+F9ebxeo3OxyUhcN24?=
 =?us-ascii?Q?8tb/ynF2VRN1/79sKInX/VTWmVlBqW+ddflHfyue82DKPjcrT9mnHjnQzTG+?=
 =?us-ascii?Q?cRbt3V+V029mVVB9E/sihD8Rz9XCYPsN/G8d31ZDwFiqnZJo5yBuDiHLsUq+?=
 =?us-ascii?Q?P1nD2VE/ngk/dxaCLyDlYNoimlUKAI+Xz9qs3phbCgGlfGZQSPfErGu4ICsc?=
 =?us-ascii?Q?d0MCTjvKTwBMg8A74qqTM7mGlWJJlanpnZTfC4hYnDQ005jqE1UMh8es2e9B?=
 =?us-ascii?Q?43rJXBId765LAMbOqDeciu50S1zN0aSpd4W9t17sTC5F8sIN6E52nOEACRKp?=
 =?us-ascii?Q?tgRpP6mRotJ/Ec+jsEP1mnRC+bh7oT+KwRzWGaOySs8BWBK0LMrMnTYxjtnc?=
 =?us-ascii?Q?R3GIJ9I3WM3VkpjbiJkh98vWugPUWy/JkbFqRRh8pwjZTaHFd1y+Ng/8gbWQ?=
 =?us-ascii?Q?MpBdshbwX8qWRyXmMqndixRK8oEXgfPKSiOPc8uW6SRNkCUkt72TIy0TUGdf?=
 =?us-ascii?Q?FFqyV8DfQM6Zd6nlKWRLJ9OIJTtzC9OCFyzFK4YdV7Svv/h19IjkR+T8hEts?=
 =?us-ascii?Q?y/25K4duFoIjOlIlZvFiqb9ubMkfgmAveH7OX13Ea20ZkZ+6eQ1nQo1EoevJ?=
 =?us-ascii?Q?9y5BlfARysX7SPQHnMz3MMIm2Z1eBxj2NgGf5XMqPbB9U23BKk/IuJV0Zr/4?=
 =?us-ascii?Q?8ofhiNBy6IHrsg/O6Ec0sRswWoJce/AR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IwD6HhqcHhr/fzQlqSb7b8eV1JYVbmkPCcwM3EpdLVYpRpjdGLTwQsazR1HR?=
 =?us-ascii?Q?aMWolfk4e0/KcQJ0IheFXTyC9/HjXDHa65nHK28fyWO+7I8b7atOGywKsusE?=
 =?us-ascii?Q?8uspziX3Sw+f0nWXr0mZJtQpaTaRYbu/xEV1K8+d9AsVQ0phosIdOlPjTUCl?=
 =?us-ascii?Q?5I7IdUm2Bxw3dIOXbr3U/GNDl8NU123FubewnO58+tM2FU5VG8bvp1sjlRP0?=
 =?us-ascii?Q?96VzXoH5SGQtC5ntTsOu4ih1dho5kF3fZckPbXNGXs0mIq/CBoQQ8XBSx8AW?=
 =?us-ascii?Q?SOLKV871Uxo4GObcbnLLbRIZU8hqCPRdsPijWWtVpxtoY6E9Dl+B5wR9jgRB?=
 =?us-ascii?Q?GgwhbIqOqGJZcSeZR36rgroTonuoWrM+2pbVG2b70diE8i4SIvm7RzYXYOpR?=
 =?us-ascii?Q?o7GWa8JQI31cPv1c3yDlGfUO9u692pDoN/sMSN79HwMt5ZwVvGdIMPHjBJvF?=
 =?us-ascii?Q?q8gQoNCW1ZCLhfGTP6q5NbRGjmVmGCOzNpYv/JPwfalfIbZPRdW6O4iwGTzP?=
 =?us-ascii?Q?Q6c9XM8L3K1L48g6KgUXLrPrP7Y9hvYUdrNW9e10pedw79oJB0fuZxO7ux6y?=
 =?us-ascii?Q?PdpEWUxU6ulz3OAoHo62MBYgPpF5Xwb+ZQ+yHRiuB8XbBJKDE/jcioh3WdQo?=
 =?us-ascii?Q?EgY2rHldr18i+6Jw1Hg9hydYi+WogRJLuflNWYUHlc/653b4PZJpinrfKXl4?=
 =?us-ascii?Q?05m8NoP8Zhsz1wQEIL55VeCNVgS1VTc1LUvqNpSzKJb7aPPVW4OWuNs5tsT7?=
 =?us-ascii?Q?cePqvAa58fxFny/JLHFawnZ031o9SdRCR2m4DxK4W66XbjvE7rAa2v3zKIfF?=
 =?us-ascii?Q?Ie0afFKc2185gdcCy4HfwFSW6Nb2Ii6yqiJeUwkfn9ihdkOTrJ9TgRDTJ3aJ?=
 =?us-ascii?Q?9Q/qmiqtA51oYzOc04KBjwZULGns1il30xJgu+6SOioBatepi9iUIk2+EZz7?=
 =?us-ascii?Q?TJruDz6fJMITyW8tw3LYNm9ygdllhOdRkOVE5mWEAs3xTa95PLoeWvApYv4i?=
 =?us-ascii?Q?fFKam4l9mmNK0zVD+90jd1AT9rjWU66g8EaOOKZc/IKdmw5uu7X5ayU42APF?=
 =?us-ascii?Q?MDp40Cm/su6qV90EVxNDDYyMXm9aXjpbHNKticZJVab9qklMOzwq0qJ2e6vx?=
 =?us-ascii?Q?XvEvHuwqL1KjEvDeTjawr3A254CJ+/rhjQHdmHt9O2VjOmYU8VFpOfcjsCfg?=
 =?us-ascii?Q?sm3egmW/Hb9kzFak7nialRx+h12eTKcMyi5663Dwyn7WFQ6hz/mGuZ9ir8OI?=
 =?us-ascii?Q?8l29NG4Vr3q92F3CJ9AxhpoTEzO225qQtAnTCQCcpX5i6qVnBsdYxWf6iCgj?=
 =?us-ascii?Q?QaSHCY1Y1rTs6GwqhJFGNn8V22fDgOgkods2phrtipuCrbDyoPCMggqH+mzu?=
 =?us-ascii?Q?3w70NgEatnTcuRAzfzFR16T5Z1s8tUw8RKvyDGTpXIR0iTn9ZDmQRaxL83+4?=
 =?us-ascii?Q?WeY4h4wkCOANV649kOIsaoba8cqb6tq9VACM2VzOBEqt5vYBuFL2FpOkbd0I?=
 =?us-ascii?Q?c+mBeHVylK9TEML/LCyFwREE1jT1CJDKMfSqYKOIP+7gfNrA9oa3mIlQNlC3?=
 =?us-ascii?Q?SObc3v0S/JE1HYI+YILFEdF538/ChRzFPceKzhniRSYxiI1UE00AzcS1A9Ws?=
 =?us-ascii?Q?FIk0fDNJAYpDIN+T30hvBhgw4MzHbPK0TTk46DKRl3GLvSsNFcZQo0GFgBtA?=
 =?us-ascii?Q?4EMPUQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3358f5e8-d927-4a96-f520-08de38aa154c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:40:28.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wMWieGP1m8+dwoTIW4jaJCwJ/g7qnbEv17XgS2Pok09cTNyPeyyGJI09OwH5HLUPTrrCqISOIx9J8DPrbAHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10258

On Thu, Dec 11, 2025 at 10:09:19AM +0800, Wei Fang wrote:
> In the current implementation, the enetc_xdp_xmit() always transmits
> redirected XDP frames even if the link is down, but the frames cannot
> be transmitted from TX BD rings when the link is down, so the frames
> are still kept in the TX BD rings. If the XDP program is uninstalled,
> users will see the following warning logs.
> 
> fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> 
> More worse, the TX BD ring cannot work properly anymore, because the
> HW PIR and CIR are not equal after the re-initialization of the TX
> BD ring. At this point, the BDs between CIR and PIR are invalid,
> which will cause a hardware malfunction.
> 
> Another reason is that there is internal context in the ring prefetch
> logic that will retain the state from the first incarnation of the ring
> and continue prefetching from the stale location when we re-initialize
> the ring. The internal context is only reset by an FLR. That is to say,
> for LS1028A ENETC, software cannot set the HW CIR and PIR when
> initializing the TX BD ring.
> 
> It does not make sense to transmit redirected XDP frames when the link is
> down. Add a link status check to prevent transmission in this condition.
> This fixes part of the issue, but more complex cases remain. For example,
> the TX BD ring may still contain unsent frames when the link goes down.
> Those situations require additional patches, which will build on this
> one.
> 
> Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> ---

More patches to fix the other conditions are coming. I can confirm that
they do not render this one useless. xdp_ok_fwd_dev() only tests that
the device is administratively up.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

