Return-Path: <bpf+bounces-41390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F39968E7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B921C232C5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60E1925A4;
	Wed,  9 Oct 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEnwUckv"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013015.outbound.protection.outlook.com [52.101.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548818FDDB;
	Wed,  9 Oct 2024 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473708; cv=fail; b=uhCa3V4skupk+pPcgbAOOUhwP/6BuIZ0q2ValZ81RE6HulzrU8B75BXZnMCHhB6tEDL8GV7DldzV2hTeXc5uWyGnXsHvuhneY9l25lM2XtrdOHl6+YBD/+PkiROt/RNQapHflXSn63+TsB1Y3/ruIN7vl24u9r0UKNmawxkgD4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473708; c=relaxed/simple;
	bh=RbOPBVC469RnJyq6PPokYFTs7gJB+SSDG8mJb2IygCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=trbNbpIUfst1yeWuDJ2+fsu3+wPqrla6jm6oocg+/dEDrZoeZMrAR8V2kv+uJ3IEA1pOluwqB0rXuQu/oEZ7/Dd90P9q8LDuzEy/ODZ9InK4rWTAmP/V4fepb9iNN1xMAVg/3CgF3LQvBDs0DVorddlAWLXmW2RFwzJnfCe0j1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aEnwUckv; arc=fail smtp.client-ip=52.101.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K41Ixppa/53IjNVAWJQ8zr5IHEAGdn4Kl+cVN+Efhry91O33Wq6nh4j4edDNopdYrt5JX/AjKNW7TNLhy8u8711s8VrmeWd524n30IjlfXHh5caqQEcXWbDrPexxwwzJIDwkeEWV+pG6LdzpnNi6zX3w6saq6VW7uUcLMGpra1Kf+hrghP2r0JhyvQEAQIwRVySz/o6wahCpgp5YrG2cEu73QH/eX+Qc6NYgWqiV1JE8idVRxh2eP0HK6IDjOvUhwEsJwuibpoVWwtAlIYDpI3ElzdRqTZs/0xBxHWw3CrvR6sA5V3KpmOLyfSHd9GNdgGAQKHo8KLjRSCfRGMtXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nhXaAavKc056smaNXO1FXB9xHo3f+nMXXLLPL3KkDQ=;
 b=OrC4O2sMc8HO4XlbqGMFsg74DikXAccfaZ8Zg1A3x2F7S7a6i5EKLwpiB8BkGMaFOvZnMlaY/KX/rocRgEfCdToyXRWfVdaZytQy83TLqF2V+KH7a0N3/JDq6P6ixSjHw0xkjcxbrBHLFAN56lCcZGRJhEvnfcOUiFHwYQX6uQ/KnjaVHW12TJPrlQx881OiyVMTVxsBVFjFA1e5Fx7hkwSLiFm/3U9RV+Qrotyz2YO7hsMlfLQm/KjFc2vH2WiPqa9yOFebSfn5jh0HFew5R96LE11NHmzvgRjbEY/P4aqfkuS02My9vB32zS7uqEHEfj+RP8Ss81lkSHCWvICTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nhXaAavKc056smaNXO1FXB9xHo3f+nMXXLLPL3KkDQ=;
 b=aEnwUckv2VWPeFMCOTkCfyEqufzS91MlqLEJY3CTe5SILjlpN3/XznSoipTgdWTws4AwhKQDAVIDDY5df/SKMl1PlnO9Fa3ovINb+0KY2cQGPLCsdkF6EXptb6TiDlfdS0HlPiFbtefoQzL05J9xM9t0BtI8AHbRwoIFBATu0gkTxi6a8s7qHipzcdywb1A9U/8t4EajEyk4BJ3C10L4dH2tZAG95X6dBu2jOcjbXY5zvVvUPx5KopnQLWZaGTTugGANyRc84vyjZQIXIUrne0KxruHmdYU+IOPTY7To9rTyK0amfFLZsSusQc1ZcIovtEvuuAIWfQ96x6cIAKc4Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7646.eurprd04.prod.outlook.com (2603:10a6:102:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 11:35:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 11:35:03 +0000
Date: Wed, 9 Oct 2024 14:35:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v3 net 2/3] net: enetc: fix the issues of XDP_REDIRECT
 feature
Message-ID: <20241009113500.kgd75g72wlknb46n@skbuf>
References: <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009090327.146461-3-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0239.eurprd07.prod.outlook.com
 (2603:10a6:802:58::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1b776f-8799-4932-5dfe-08dce8566a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPJU4LpVbpKIxnpSmK0+tWis22X/WWxFLIUkbPkFVJui/TnS191L8Us12hEv?=
 =?us-ascii?Q?OJM/UoZ39pJ+OD0NG/nPfQ3kyOBjAxBE8FM7B1DyTSdC4wrtaSQtGLFcpSOm?=
 =?us-ascii?Q?ftILgrhJKnouVDrfysQNuHRFQVPyUhYXEU2yc/SSfrW6eiZwvIM6pa2hEtO0?=
 =?us-ascii?Q?3AFO61Oh6ez8rQ6wtXsSAGTMOM45xG9QGu72hmqKNZxluf00jMJmE0BeZyo3?=
 =?us-ascii?Q?Kh5pAytwG/XGhZTfAMAykV8tiC+fEKf50l+iYeOQ34xNwcQWucUL7dZomnyo?=
 =?us-ascii?Q?03iLjOxu5IJppuw5V9Nh0N6ESbeYcMnt0Xivaj0aVSdcm024jDqslnYCN9Td?=
 =?us-ascii?Q?G7dLzm7HsgzMbttNydHJnzUTpxDTzL64bB6E1s4+BWpP4s39A8eil2iu3Gtn?=
 =?us-ascii?Q?8u86xLWDz5ofwc+NVZBRJPI+mT/toGZA0T/40BJNC7YA/WNqWzhWv2mAMUyJ?=
 =?us-ascii?Q?+YhklzsqawG1v75XbNPsoGs51GnHaNKyOtLCTTAge3YhVKkpDpahalvy3Cxf?=
 =?us-ascii?Q?pCYH1+nfSVJyELT8xVob4Qe6TdxTJav2JpR+lVlwWJ5e7C+TrnDRtS1LwMiq?=
 =?us-ascii?Q?vUF8rgY7eKSX6Mk1414tXz3OVRaFxUpWAQtXAYqf+FA9LOk2kOjyDgxQpDyo?=
 =?us-ascii?Q?o+qx9zJph6L6OnfrDn9Fd2rSRMKshliqP9bBS8ELdf+Tas1lbEAHggcwjldm?=
 =?us-ascii?Q?bp6D+/ikbUmhZXBFPxKd+oCEvX7NfSp/MMJC8c+kW9Y8rbOjtgv+pX5XOkNA?=
 =?us-ascii?Q?I+JPYxxhynrHYAXzTAtJYjICRrr/oUQWRFWUl1yqNlgOL4K1ZEhsLBK2r8f4?=
 =?us-ascii?Q?riz97FTdoA/8YaW+PGxvEOJdhLPv7ulukbS9bUc2qBg2dyt/8zPIPkawbxvC?=
 =?us-ascii?Q?yr0W8qsQaRLBhTnMxf8kbhqtPVqavf5TawvabhzisXDHJshzthjeUEO0Sa9y?=
 =?us-ascii?Q?hjkCyYAcUIwGBlVnegv9TYkYVwbW7DQzrRXApUjsTrb8VodwXSGqlCjzDFgV?=
 =?us-ascii?Q?HSqXrEZJvexltAk1FO6GHWpP3V2bBS46mPWmWZbtHlZW3+YxpEk+YkSquloB?=
 =?us-ascii?Q?vcLgdRZ7FS4dTyKMSeBDPYZ7c2HHV+4SU3D3D4QYXfb0WpzxFRnvlyDFFOLu?=
 =?us-ascii?Q?4bbmgZUEkhGCUZbrY/RCp2XrbqH3EIlV0KXjiMtr6FBgHiwJAQKq6XK2wqd6?=
 =?us-ascii?Q?41Kp3GWgpkllb8dnJYdqzBfONcNus1ZklbyA03JONH05yhcJoeh0AASL7bcq?=
 =?us-ascii?Q?mGjkP/wH62VgRkJS8aIOjNApGOoXokHLteinvH3PRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OGSk9zeiWQlevxsLNCp1dS+VNZFKkaA0WH6v4JqOWjuO8TE8MP5kV0PWjSM4?=
 =?us-ascii?Q?uwNgxCryRkefEKeRnq2oashtsk/imJwqc4HQ68zBvqUDa9NRrbZ03msClEIe?=
 =?us-ascii?Q?ZJRm/a2nYTF+Rq+KikwtNsI44lv8d/v7ReOumTrZyU0hcmH6nyDWGWcM+bYd?=
 =?us-ascii?Q?kVrCSj+K2u3KojYYAPvjxg0J0GxqA7SfoHV6WiRVqnBh7bdltPkfb1tmd674?=
 =?us-ascii?Q?oEjbeqZNE3d4t+ctrpDMysGHZV1dKZgRGAs9prW9GnQWoldGT+P2pbu9+kWY?=
 =?us-ascii?Q?pMNhW/KqEFKsKTno+s9H32rrmTSugace85L0r7Yf9qOyxTUQ8qMAfkkmqOFm?=
 =?us-ascii?Q?4c3fKkbnISFZRr0CwQTC5lRhbRTo70THoMmwm1XwVxd4dWAbX9e5FM3QNh0+?=
 =?us-ascii?Q?4H4nrImCulz5HcQGYGMhTpjVW7iJXCOKD8SnGYCSfJKfjzILOvmIgCmR6BB1?=
 =?us-ascii?Q?O7DuepNP8QQxhnJ6T30AwRK54GF8OtwS32YaTK/GA8MYYGmUF8QIvRdzwSh3?=
 =?us-ascii?Q?g7GiGM/zBieiD48OVM0KFFSANcaTljNRxkj88E7JhDzETE9RgFYTu0bDCxOa?=
 =?us-ascii?Q?+Vg5rOhKbbfeLNg0uAVqWQaLnvrQR1+sUOqJNqtHPQycyOUZfp9Cjui958qy?=
 =?us-ascii?Q?DX31Ywh0aiw4VE+ABFz/M8SxD+ZlaL6/+dWUYtqzkgc/2WNSlHDl120k6aDd?=
 =?us-ascii?Q?2s8djBB9WBzccyNyuQ8SlrCCiX16RjHNUkG7l0zQWQza6r/0vEScnVoY/FH5?=
 =?us-ascii?Q?Z3+5Be0HNP4K+zH+LU2rt02WCMizcCeFYm37k9Mn0sWEjRrxrH2SgdK47yCd?=
 =?us-ascii?Q?8ywBIRWLvYsqU9tZ9VniA/G0GbYCkjSpnHERB7y8EpAUpCgonTwntotJ9Pe+?=
 =?us-ascii?Q?rOXKLscX6gbReaBOi47MI23q+ZxxrsLAxlIhoC13Cqt13lsSbAN9BBglmARh?=
 =?us-ascii?Q?hdOqDbq8MqRGGTAS+O36DEwPHLoSJXxD7vUQ+1NqKf43CIdiN2Vbzl7DeL0k?=
 =?us-ascii?Q?YjcLVh3WicFfxHu/ujWrsgKhdo6/zVl3WxJ/m/xTl44yG4VrU/0RrRwuNXZF?=
 =?us-ascii?Q?otVl0kO+ANH4EFdmjSrOww1VYlRMCXoUk27aUaMhBqB9CbP5ts+rHmOYpeER?=
 =?us-ascii?Q?QXYKZzEZNCui7f2o2uWuLQuIIzh8ap1CrsV2aFpipjAh6HhreOOCbqvpVTxf?=
 =?us-ascii?Q?URwwSYOmH0de0IU0XP0/TegCL2eLgWbn7CIF4AZHUcyIA5gAkMh3/vFdPLNA?=
 =?us-ascii?Q?kOboLgwVoaj/kw0QsCYenrNSqjMaKVYKWxU8Hwqge3SOLnTbS0XXIyPcY388?=
 =?us-ascii?Q?z3djoOJGJW9QcPbM4yD1CcyU385dQM+gd78aL5rNE8i731C9J8i1etz8JWzi?=
 =?us-ascii?Q?b6z2mSpY/9H/xFJHCN1q9hxBGUFG6ATp31PcYHl7ihWC+1Nn6J0U5a8fmzAr?=
 =?us-ascii?Q?6omXEwiPL+OEqiCp+hVcWgQ+U1vHgdbK/orqw4lUzyu/+Xj+egdGJh8zY1bG?=
 =?us-ascii?Q?BwGXV25RCxXfRPyq5XWVIzNDFlm1HwUhgWjweI/75y3yC3+04+6Z4wUIdTZp?=
 =?us-ascii?Q?gzgTBfWI4MnJkm1DwRdzly9rLBW507V60sxOiEVmbKI9oRX3bE0GTi6gifdb?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1b776f-8799-4932-5dfe-08dce8566a97
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:35:03.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLUdYGyR4IRqJB8oz5tZJHpiRlr8sWDcRxVUe/Jgr1Qw4hSv36rbzFnVsv4TaMigoVKrhKYCJiE6PjoKDkDx/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7646

Commit title still mentions only XDP_REDIRECT, whereas implementation
also touches XDP_TX (and only makes a very minor mention of it).

Wouldn't it be better to have "net: enetc: block concurrent XDP
transmissions during ring reconfiguration" for a commit title?

On Wed, Oct 09, 2024 at 05:03:26PM +0800, Wei Fang wrote:
> When testing the XDP_REDIRECT function on the LS1028A platform, we
> found a very reproducible issue that the Tx frames can no longer be
> sent out even if XDP_REDIRECT is turned off. Specifically, if there
> is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
> the console may display some warnings like "timeout for tx ring #6
> clear", and all redirected frames will be dropped, the detaild log

detailed

> is as follows.
> 
> root@ls1028ardb:~# ./xdp-bench redirect eno0 eno2
> Redirecting from eno0 (ifindex 3; driver fsl_enetc) to eno2 (ifindex 4; driver fsl_enetc)
> [203.849809] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #5 clear
> [204.006051] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
> [204.161944] fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear
> eno0->eno2     1420505 rx/s       1420590 err,drop/s      0 xmit/s
>   xmit eno0->eno2    0 xmit/s     1420590 drop/s     0 drv_err/s     15.71 bulk-avg
> eno0->eno2     1420484 rx/s       1420485 err,drop/s      0 xmit/s
>   xmit eno0->eno2    0 xmit/s     1420485 drop/s     0 drv_err/s     15.71 bulk-avg
> 
> By analyzing the XDP_REDIRECT implementation of enetc driver, we
> found two problems. First, enetc driver will reconfigure Tx and
> Rx BD rings when a bpf program is installed or uninstalled, but
> there is no mechanisms to block the redirected frames when enetc
> driver reconfigures BD rings. So introduce ENETC_TX_DOWN flag to

(.. driver reconfigures BD rings.) Similarly, XDP_TX verdicts on
received frames can also lead to frames being enqueued in the TX rings.
Because XDP ignores the state set by the netif_tx_wake_queue() API, we
also have to introduce the ENETC_TX_DOWN flag to suppress transmission
of XDP frames.

> prevent the redirected frames to be attached to Tx BD rings. This
> is not only used to block XDP_REDIRECT frames, but also to block
> XDP_TX frames.
> 
> Second, Tx BD rings are disabled first in enetc_stop() and then
> wait for empty. This operation is not safe while the Tx BD ring

the driver waits for them to become empty.

> is actively transmitting frames, and will cause the ring to not
> be empty and hardware exception. As described in the block guide
> of LS1028A NETC, software should only disable an active ring after
> all pending ring entries have been consumed (i.e. when PI = CI).
> Disabling a transmit ring that is actively processing BDs risks
> a HW-SW race hazard whereby a hardware resource becomes assigned
> to work on one or more ring entries only to have those entries be
> removed due to the ring becoming disabled. So the correct behavior
> is that the software stops putting frames on the Tx BD rings (this
> is what ENETC_TX_DOWN does), then waits for the Tx BD rings to be
> empty, and finally disables the Tx BD rings.

It feels like this separate part (refactoring of enetc_start() and
enetc_stop() operation ordering) should be its own patch? It is
logically different than the introduction and checking of the
ENETC_TX_DOWN condition.

