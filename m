Return-Path: <bpf+bounces-41745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C699A6A4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6210F1C21720
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8083CDB;
	Fri, 11 Oct 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="br928flG"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75692E62B;
	Fri, 11 Oct 2024 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657736; cv=fail; b=Jz9o2m9kzOeQ1JuSqj5bz5IiwHmOyD3WB6xuMZAZMmWbb0g6Uxwkm+uLmoLN3OjNVBZUlG89W6cP2B1kUu9z4f6bcAAeMiM4cEjoQ8EMyrcquIB9HhtawWUqLMI8gmjvb4UV70egGkBL5MY4enoVJHfvQZ8AFj4p//JGcO0Cx78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657736; c=relaxed/simple;
	bh=yqK78EaIovS4HZrq/qUHF9ciAyYucCH5MJdXwVCMlDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpDbYSfwijYVf0sBP4GZDpCbQN+LZPSF1DCuMJb1mlqSHYV80qHWrVZ2qnRkcJdpsk8AMuYnQjNwnqpQqk3zwiLxyUOU1TO7WOCIIEq64QT7F6SJAuckuKxaupTBC+/f7SSqd9Ev9Iam2wFcbbCion4ZQp/oVHlL1CxQyqCCFIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=br928flG; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en83H8g1dklI9vxbyWT3jbgt8xSCIlUULdHBytZy3rmceCUYOHCUGV3pphWtp9rgA8jcdQTdEnjfXbLfSZicfd9yvYdG1E5wAd31jKeqVmaCeU8c1sheujU665pFnZNUz3jygoZUmEL4CQo9SoupYwBK/sCZCqJyWmfF6p4sc6xf+YtmKhTpNIEOt4I5ove7FQnGQysaIyo5g+NxZa200aH2GHxKrvH6MQ7c90AgPfQEkMvU12TcPa1sbFoiKSAK6Cm6QNf/3oDjw7F5Qu4/qfirn6jyBA3sq3rqMl2pLepOpziLpHvMjYUWeVqvfhf2LszNoqoYFW3ChGyXBCeOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+Gzsdr8xdbTHTc0ZLcvBXcf0FNwlBq7Ted3GEigE5A=;
 b=LwjongGdOgxEX8aNc3Yn7eo1EfvsYzC1/jNGCogm5+POD1ZwfL5uAAtW6FVbG7lcxxPGAUbYySK4zAQMboy/l4PQ6R7lqfJsfdFWhNnmnr2iUCA53WSaAAqk/vCbGBpm3mIGvooibA+6OqdZ8EHGmUmOTsi2AHF7YQp6J50gPB+MyEdin6AQPvLMBzF/cKQAS1uUUg0ezIE2rq+4PUcpgyn14+0s/bDIW4KdR4tOjdjA85gKCq2jK8bOa+vUX71oateblluN0LjqbbTK7iwRusMInm2Bp/SvWw6PtyzrZcwJqQrhmK/tq7aB3vcQmQ4DtXi0WMKY/gupeKHWlChiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+Gzsdr8xdbTHTc0ZLcvBXcf0FNwlBq7Ted3GEigE5A=;
 b=br928flG+mdvd+G242n0gnYAM5gHWEar3HaM7/93O8t8CSur+bWiJbk9HGLwE7BYCq0FIABwPvtJkMJyvfNXiOQud1nhC6rDcAEN7PPoLtr5oBk+6ThsFzRLNoQuK19XEq5ZLRvnGrACAFD1xs63Kx4DY+kjVJ5xo5DAUClBEIImHBr0Pncvg2qGme2gE9Qz3c2HRza4NR0ytcMqaSsVVTThZF23yuMVnly+QKnBIglojMp4ZGU/WArcXx5nUIAYrPydBW4oroBtTnvj1tTCB5bAV2W+InDAj6KLhcco1fcToyqsvkQnc7j3lVyeSsf06j2xvmNyOX640/GS6B1XwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:42:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:42:10 +0000
Date: Fri, 11 Oct 2024 17:42:04 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v4 net 4/4] net: enetc: disable NAPI after all rings are
 disabled
Message-ID: <20241011144204.4gpywu2i2ygyk26v@skbuf>
References: <20241010092056.298128-1-wei.fang@nxp.com>
 <20241010092056.298128-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010092056.298128-5-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0271.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::38) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: bab3beff-5705-493f-73d9-08dcea02e183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7kH5KGLsKUGJ5PtPW/MEZDT0Z5rNW51DhYrczHTD/Htje/HbmD7oZSpB89TW?=
 =?us-ascii?Q?bOKSCj3IOmx0Ts6pmaZscnZiRk9VbxSnqUVWaznReYPxRqd5dtuuVc0PUBMq?=
 =?us-ascii?Q?i8/hSRduUd/NlbFcovWfxKXnXvTOiGUdJUHuPMBc+ReIB2X1gnSJIrQBsXia?=
 =?us-ascii?Q?zTkoA9hmKBVI/8M/7bUZOa7tG7KqjTXl320ezsWoGX/Hb+G4v8qhS3Gp4a8e?=
 =?us-ascii?Q?1JbdYXBS3abmK2qm42WohcNnBrUqeA7cgSPgZk74dIyeKH9V4+2NRyqiLWpn?=
 =?us-ascii?Q?6WpjLvym0Fh75AM55tf3TR1PbHWu+yeBUJ2kXu1oGsaQqNCkO27N6wnzVowy?=
 =?us-ascii?Q?Awk9uGPsoJKjjdKs+88NPi80iTTd/t5xsxk+SS55I6KUY7Xqu+Aj6gEsa/ag?=
 =?us-ascii?Q?ZvTF/LjMjWmdAts0w/E3QmY7xW4wKS4pmS84Px4kho7eN25/57erfG6vCOwx?=
 =?us-ascii?Q?VvpZFhUdyG6SC6oDRbx9zSIvqCUIk3YInBuRYUVkjNAgOjcq0JhsJeILAAKz?=
 =?us-ascii?Q?ogqzphQ8rpR3DmTkdKFYDKtOONAxBt/rW2wDS6uX6FkH8zn5Wl59N8ooYbty?=
 =?us-ascii?Q?xDshifYBVRWdB6UJC+rP7npSUM1iwymnxzzOMMGoeWPCWjZIyMzBc5ZzDKvz?=
 =?us-ascii?Q?mWfd+vvPxY/j9Lnxjue1TF8o2jk0ft5HED3U7iWgQq2uB+5ogqk6BSYsInXN?=
 =?us-ascii?Q?qXBXZxzBpEBEAFtQawRzYr+XVDeJ8OEz6IVcbDUeXAiKv5lbEJx7JgS5XI1+?=
 =?us-ascii?Q?ipi/F5PeyN3Q3Muq+upna6UCkmb9vJIVhO3zNX7e8HLPSikkm8fvgxDSatK3?=
 =?us-ascii?Q?yUiOwjdC+hiBWmC16iItPF/LU6D4lm4V8ak4S6tSywxuEYVnhUZml/NbHLCA?=
 =?us-ascii?Q?Kck/gfOsVuLt+vGJElKM2bE26kjQMnfDspi5HC2vPAa48XKlGNlkNOmzI5b0?=
 =?us-ascii?Q?D8w8/URH9/Byk5izV7WgHU4TqVsu9OLbxHkkbR29z9YKy0lzJ5aFbOJX92If?=
 =?us-ascii?Q?8zj7v7ey4YJQTsXH3WNOrywyOfjYP0XdcKNSgRlHArrcs0s1cibRbVbsX19Z?=
 =?us-ascii?Q?OfwaBAI7B74dC4Wd78XpqGfuhWg2bLDQfgKaOuh+HVgtVU5n/DcWw4Tsdth8?=
 =?us-ascii?Q?xAgi2MzrokKH/xAHbSe8ERfDo+j5m3Eg7ghmN4FdVtUXmYzkFiBXiIxTP+SR?=
 =?us-ascii?Q?xP7RS6kjgLu1HQ39DX1Adanx3eptsIuNBkZaDexALRL7jCiI7BqiAUq5iQBp?=
 =?us-ascii?Q?HV2MrEbKHR+jCErvKqx9XUbZ51lWwzxa/eX/nxsfpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sF8I9Q350SNN5dlf3EuEX90Eg/dYQmikSdsS2HmGUbG9FMzWBu0qC3gJ1ELt?=
 =?us-ascii?Q?9dIDLD9j1dZCwAG8CP2xW7bwOtyzLN2Jbmm9QoHfdO4S5bIC/CCypLaoHMcP?=
 =?us-ascii?Q?dyPMGMY/vpHkbctp6loYuUGweUtzaNYbaN8YA7uwXJsWFDN9MLMRRLJQRm2d?=
 =?us-ascii?Q?DlTsnWFhx5oFfpBdUxclK7okJuqM0bzCcD8McV8vPGGBs/8s0DIqIU8zAO9Y?=
 =?us-ascii?Q?u/ZkiVfc3ZUS3obeS5bZzCIgeFU4/GPPdtf7kzMgkfGiM6wuHnf2RTeNlMR2?=
 =?us-ascii?Q?s0V1URy+9h4P9Sywgy9RazdA+uknt/QRgZK36Wt4u5Z2y1OaPXA56TTbmRZp?=
 =?us-ascii?Q?NCykn9BkBvB6sp4mO8zWs2AU0nlcE9aWytQQX3PHlKtJ8aPsq3iIoCCeAyOR?=
 =?us-ascii?Q?AFRQCn1g3DzSprak2zXDsiPS9kJ8ZpTnSDGR90vm1EIKq0DYmE/rNN5bqVdv?=
 =?us-ascii?Q?WFOBvXfRlrVU7Ng0nJQ6ZXG61pql1ssHytocClFXoE+NI6ZIWrkF8EkrfZVY?=
 =?us-ascii?Q?reAiwy51eOEn5iEf3ME+MfZuNOgmjZMthegQOV/HlNg7LB9z9JS287S/n6MX?=
 =?us-ascii?Q?T0T0Vsycw1nyFshUAZyom5/XqzCu1xOBCv2gGjzIVTg+m2S2InFQ68uGZO8O?=
 =?us-ascii?Q?3ONCt/JrFAdWzPuK8F5jIfw/4pck4uNmBR/B8SRYvv9pIKcUMWt6Gg3NEyqo?=
 =?us-ascii?Q?FOSTxXPSq2suH4npMN1XcGLzcEOZ2IfXVWNNbDw/AlVfb6o5Rg7K5OdNiyfb?=
 =?us-ascii?Q?9GG54woL88PilPi4d3YvOQtjDpfVVwjt+gChz3tTH8j9rEqZQErfy5KFE/RQ?=
 =?us-ascii?Q?VTln94rrnHyOm0g0YkKIdbkvcobAJwVUxNl9d+UeF3q8thj3gq5LCPFbbNej?=
 =?us-ascii?Q?ORj6H+NMtdKyVJBsk2Vo5htzmNOmzKyaKeERYB0z/A1RGd30Vw0EE4s5Ie5O?=
 =?us-ascii?Q?pSVsvWa8A9ln8ifk8kQ+TKCmbbJu/SUoEwKlhB9Lzwxu82EybfTuEVU/GYCt?=
 =?us-ascii?Q?8FgfAxRXCGEhul8I4EMsJKnzZ+OPGlBjVRvl6egYfeMfgSJ+DK7SMm7/ZVeX?=
 =?us-ascii?Q?SJJy9fZTWvAsk4lfupnzyr4cWp4/48DecA42sbXAt0Sqo4opHeOqe1+RjFtA?=
 =?us-ascii?Q?KrW3QXgOnsohwlp3IaDW8/NXSoTQOu8Z4Q9442YrD5iFxZR7kB9e5LfYBU1D?=
 =?us-ascii?Q?iaknjVmnPEXq3hewW0K2xYXBsti3mOZmwUuA1u+fw7UoWBl5jxp4S+Ii+31C?=
 =?us-ascii?Q?svAWG9qt98oi/eJHmuzTYv8yYwsMOdyyqfaIQH6dnnhWGvsJKE7AG4diyHDJ?=
 =?us-ascii?Q?y5eAOSanOcp5lLXAylCgyQ0Fn71a9fx5eNEoDCKoLOOHt/1BX5JnNk3Cbitr?=
 =?us-ascii?Q?6HWej3QXH8zq2LMAqRBKcYpaVQWroUEzSM7pZ+jb7NRxYVlSkwT/ihPdt+7v?=
 =?us-ascii?Q?CHKuZE0pidj8IrioM1ZNhe50ekJKoFPPSwrl0NdJkbs9bt7y4pF6sWzkGhWo?=
 =?us-ascii?Q?wtH7Ed4XFMAhDWnpX2OD1RuvmeaZtDPFy07A0WqTrem+PpqR+tQgwTdBd1jB?=
 =?us-ascii?Q?NBzGP0CNVvmhajeh10gX50Erme/gJEmI4jEbjOa8r4qxDwNFBkqZeWlunhsB?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab3beff-5705-493f-73d9-08dcea02e183
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:42:10.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAHogCU2fnkeHKrLQE3VzFJh3nI/dJMpt8T4li7+UMi4Z97O5X4zGeX5IW3a0Phb+mSizOP0Ax0g8Vs8QdP0Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952

On Thu, Oct 10, 2024 at 05:20:56PM +0800, Wei Fang wrote:
> When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> on LS1028A, it was found that if the command was re-run multiple times,
> Rx could not receive the frames, and the result of xdp-bench showed
> that the rx rate was 0.
> 
> root@ls1028ardb:~# ./xdp-bench tx eno0
> Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
> Summary                      2046 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> 
> By observing the Rx PIR and CIR registers, CIR is always 0x7FF and
> PIR is always 0x7FE, which means that the Rx ring is full and can no
> longer accommodate other Rx frames. Therefore, the problem is caused
> by the Rx BD ring not being cleaned up.
> 
> Further analysis of the code revealed that the Rx BD ring will only
> be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
> Therefore, some debug logs were added to the driver and the current
> values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
> BD ring was full. The logs are as follows.
> 
> [  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
> [  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
> [  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110
> 
> From the results, the max value of xdp_tx_in_flight has reached 2140.
> However, the size of the Rx BD ring is only 2048. So xdp_tx_in_flight
> did not drop to 0 after enetc_stop() is called and the driver does not
> clear it. The root cause is that NAPI is disabled too aggressively,
> without having waited for the pending XDP_TX frames to be transmitted,
> and their buffers recycled, so that xdp_tx_in_flight cannot naturally
> drop to 0. Later, enetc_free_tx_ring() does free those stale, unsent
> XDP_TX packets, but it is not coded up to also reset xdp_tx_in_flight,
> hence the manifestation of the bug.
> 
> One option would be to cover this extra condition in enetc_free_tx_ring(),
> but now that the ENETC_TX_DOWN exists, we have created a window at
> the beginning of enetc_stop() where NAPI can still be scheduled, but
> any concurrent enqueue will be blocked. Therefore, enetc_wait_bdrs()
> and enetc_disable_tx_bdrs() can be called with NAPI still scheduled,
> and it is guaranteed that this will not wait indefinitely, but instead
> give us an indication that the pending TX frames have orderly dropped
> to zero. Only then should we call napi_disable().
> 
> This way, enetc_free_tx_ring() becomes entirely redundant and can be
> dropped as part of subsequent cleanup.
> 
> The change also refactors enetc_start() so that it looks like the
> mirror opposite procedure of enetc_stop().
> 
> Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over packet processing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> 1. Modify the titile and rephrase the commit meesage.
> 2. Use the new solution as described in the title
> v3: no changes.
> v4 changes:
> 1. Modify the title and rephrase the commit message.
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

