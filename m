Return-Path: <bpf+bounces-41743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61699A67F
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A37B22ED5
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532E193407;
	Fri, 11 Oct 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BG57y2Br"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FF82866;
	Fri, 11 Oct 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657533; cv=fail; b=qXJijBaompeUUkWimhfyp2al5mtc7tkdVbKdwpwPkXiY5ITrkjfXjF5bRjCxkvui1WMHVesIefDCA77ggKgpvSQQcAD4DBYADUZQyFSa0sVblxriC8e8mKDBWlTJLMIVVF5+Z33h66sY64OX4QF2n1U1rRymnJzw5LhjCvZGVzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657533; c=relaxed/simple;
	bh=vvS7kqB1IEMn+Bf6YHXRB2CwMyt0Jj+Vu6zNPmHibTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZMnPM3yitjKv6s3WRUYNPWUFSt+f7vhp6JLBGr8HBNKs7yHWtzwMRtL9reIx3bsNdc7qiLjEf2hgWzlid+C1957LuUaqci5EhIbbVZ2sw5FvoBP+T53fCTkq6sU4rr4gwK3tFGxSqZC5pRUxyV/txXxhFe385/sKS4vh/inS7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BG57y2Br; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/1zUeifphdFFWnx1F63Jo+Kn+BeKQO7gBpkDaEhvI66jMjGsLAGFH1CP01BAhvMgM4y6nCRfWqOYO/gjS3jQSNUVsnHfHh/TYlRJx73+J7yh5E5YO4tl959MKlEl7QFZBpPje6Pt8pOclWHJuh7hXSzryCa+PbQNmLsNuvYKsX+mIrmRfossFAWK+yFjJYTQNvH5xBYSnD1bR1URX/TIlh5mBZHeJsCT/ILzDHRdsPdz2+2Gi3/06NFJ9FEiNNiSuqaKJxwtRbalmlXecblZ8luaq790TIh4JZ2dcEHL3OtFKXfXG2f2hu/Z4ISX1maX/mCEHEjWeJA+ak9E99MmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1IBjiBPIi8CHUJozZfWAmr8AAJKh0QARz1a4JYfWbo=;
 b=Dgm7KlrIu+yK3fNKJ1U0CLe4q7v6SECJned0q0aXMiuMqCcJWGycLbL1O+LBYbVseGRM7S6tFFiyxOtoxd142uKE6i7SDvfVdlhKq1xGpa+XgN04Lq9EInLmIbcOWtFu6jHrw2o2sFb84xlVcFwMtY4y5w/3KdMTqjlmYv5mUdlPKW8+MgWAudkvYeZoIQlrkNNpwPTq4xP35NcweYfgDiOrzUYi3irN2MvNYgZZP9PGrFD7Btc6nA6Y2PHY6NXHyyT02mPNNIOPiOsttpVV5HBj2mfJTN1eToZ1SWLQobR+thJ7rslcULZ3fYk6lKjS/dpVORo4zg5gRMQN1tPK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1IBjiBPIi8CHUJozZfWAmr8AAJKh0QARz1a4JYfWbo=;
 b=BG57y2Br7hU8sD3jyBWAEq3n4Y991bhbu6MBamrqVH3ZCezFwojM7838kjeEVMO8iSzkuet1Q46WHWfxXXGeNVy7mKDNQb6fuUWKcqbr0Pwp8WqBTne0+r9Gi3FyJF/7sAYMD7hskSL7xYmFjaDiipGUvqe8JVdisgyCey5Z4009ObLHbXH9i559GOR6YIBgL05LGLoXgrMloRiaW2uxobzuA70DEntimLcjRc1tFGmFigfsC7U/XJUqXgRXiuE8nUytTC3yaLbgl+ACtX5ibBs0Ujj34dpDqrX5spYHX1OWmW7Zq3JwEQdgxPvqVbMd5zlAVle1pnmGv41NW6agaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 14:38:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:38:46 +0000
Date: Fri, 11 Oct 2024 17:38:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v4 net 2/4] net: enetc: block concurrent XDP
 transmissions during ring reconfiguration
Message-ID: <20241011143842.zmbelkh57xuk4pnt@skbuf>
References: <20241010092056.298128-1-wei.fang@nxp.com>
 <20241010092056.298128-1-wei.fang@nxp.com>
 <20241010092056.298128-3-wei.fang@nxp.com>
 <20241010092056.298128-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010092056.298128-3-wei.fang@nxp.com>
 <20241010092056.298128-3-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0430ee-26ae-445b-a311-08dcea02697f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbX9GD+TF4zd8AGyNThDRjCkpjhDnvav0Q8VOL2HkxZDFDy/2CxoMVMK73lK?=
 =?us-ascii?Q?KPkqk3uLlTGhsUwbIXXpHo10pn9BnBPa8Mwp03WIjD7sq6+THJA0K/aZQ+AE?=
 =?us-ascii?Q?3oWddkMMaaI1GjD6Ixrgq0p0egPz7xGUGmzVBrNxxK+xr+eY3vzqHKRCS8x9?=
 =?us-ascii?Q?vYxWylGtwnKKfNmJxNL/j7unBDaAnMjT3DnpDtoJIs9NKbCA8sFftKqa677/?=
 =?us-ascii?Q?wWT+AZFDPFp1DYS8WKvHD86MeKTTy3pNC+FO0p5vQORCYBDz1/y0KiiOKDhx?=
 =?us-ascii?Q?PsAkEg0rzzLBj1uIKlQ2wJdvP7cmNu4pbyD6zBNwitM37jWguFH26kS+IZzH?=
 =?us-ascii?Q?Zbo1lKpxbMgZORU8WIMZqMSIpNOHY0ULEHRdy/mqh5zWGy1DJo2d/ekGaik4?=
 =?us-ascii?Q?FtIX0yezJ+M//koJfHGceebrXxhjNsMcWKJz6uALZI6X60d59BlRDsqhtC9T?=
 =?us-ascii?Q?F9iUQnj05D2hGCHeryqRITwpk8Kx0KnjxOLXJxyqqUPT5rDuvJzxQWr++LVp?=
 =?us-ascii?Q?Ng7ehEasbIS7g5bFo+6TNnwhOi0n/d982ip/UVI4TMauAyxB+gxH72KbNesi?=
 =?us-ascii?Q?fsRWz1kaWUR6ZmzNSabbVvFlIpOVTX3yskYZOP/LM62pxDKZmyYIlzgbDUDt?=
 =?us-ascii?Q?+OKlOL+Ox99Ii5cjt8X1hRSYWuSVq7UiMoTX14irxPFHhMeKP/BeNTpvYbGO?=
 =?us-ascii?Q?keF222PX8IARvS39I6QriUsMGbPA3upd0LS0Ari8XGp/LIlV4r77f60LFghx?=
 =?us-ascii?Q?5tIES/NyfQ8tZdX7MV01o/jGnx4PCTzQNZS8D4Ze4ZWA4fxy/qSr4EIxkguj?=
 =?us-ascii?Q?F2M9d/u6d9Dbwp5PaMPBsZy7vNltO6osDfSILFILSJAP/phR2MRbcRMmEOUa?=
 =?us-ascii?Q?y0XXSpPMap8KfusjscqSBa/+o+xJ9yWt8vlkB/9G1j2ZftIjsKL4Ie+6cKNX?=
 =?us-ascii?Q?Qm6+u91R9OS76VvSwHG0CAJweM+/Y9OSkigmfSTMhhR7czW7ZTioPD3n1Wjs?=
 =?us-ascii?Q?kc172Fv4dg309oFM0nw+yvzmx1AmUbQShxyr4WwppHR54Ocp+yrRm2Phg1E+?=
 =?us-ascii?Q?CrdGh0vXmE6MxUkTylRI6tbJ59gfKnTHIUiGy2uhHodee4256dhQvnEa9eCo?=
 =?us-ascii?Q?cfu50PdR1tj+M/9qFcZ63fombQW4iu0Nhxz0C4Bs1oLhg/yibUstUMQhcQGK?=
 =?us-ascii?Q?vDLnjqBeb/GGrrVBZZjveGaJHzuw+cGJUn7xzU4650rOISbJGTDtTRqyGNyc?=
 =?us-ascii?Q?rFuarFalT7LRSScOI2M/jHYGrhni86hKqKU/ipzf/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XsbJexM1tXdpbVL7ulWL3nx13b2L0qabJRH80AVUzi20MUVwrWF7jCWslwjD?=
 =?us-ascii?Q?Ri8791fLklsf/UvkMMf98T+70lqGKxyXVg+seeu6xprpnL3oUKhpR3RJ9iby?=
 =?us-ascii?Q?w0eZp/M0UoCWq1TuLOvWZVSeL5VatSIuTEbckwoVeDHR2116chfrJgnGJSY9?=
 =?us-ascii?Q?WOTTMpbZ0SnKg6jprBMDC5vx8j+Rfwtk9ienroHOAwE6AW1F7I9i2fKQ8tIc?=
 =?us-ascii?Q?I+0tBvuloexlE8NezPZnBYXYAsqykNkYEsR7+qJ4Q9KFSsbMr5AuXs6JSLtj?=
 =?us-ascii?Q?wvjwrTUpWlLPs0w62DofJb5UIrX0F6dxHwp/flcmvkRAkkF11JBSpvlWyHUX?=
 =?us-ascii?Q?a4c76SuUfe1KN/mzKcagJvZy6/xqpvIRwiyQTrZjQrjUPlt1CDKsDrsjVnOH?=
 =?us-ascii?Q?WOZpZxnGWyWkpC+xFNTdFXRRzbSkWi+Y0xxd7r+fTqC+picX13Ghvkg+bHNl?=
 =?us-ascii?Q?IC2tYDdnK1h+6xOUy4e5TupwejqlmFPUnal+2FEthItEXhRCMoAYDhgf9DWX?=
 =?us-ascii?Q?GcQgwyyoxBEr5Jppd8Xx+osOCofZxKGX6DJE9k+g40nbCTNmPznBGKKRPMjV?=
 =?us-ascii?Q?rU/W4cjNBJfpgFwos0GXnP+WKyVTczKCssqAEpOoQ4HoBoWPy0D7AiGaA9TU?=
 =?us-ascii?Q?3VhrPh8ZSaaDCKUQ6wDVOk0q5HpO9YcT4TyIstw0GkTAFFF+Slf0NoT+bgpb?=
 =?us-ascii?Q?PDO/5s4NxTQn2HHOIurWKUuggasIIGySRCsWOgJY7dPqXEVV1SWi2ovbCUTr?=
 =?us-ascii?Q?WIjAVtQSIwCDWnRMfzkTKXSH9tJIDzJL1ZXV0Ze0aiNnssGdm+KrCtn4TYlT?=
 =?us-ascii?Q?C5fD107DneFTsqtB0nv4DQqCiUd/ZhCCSvwy5pSfOmIIN/Q23u6r6eSm8wcN?=
 =?us-ascii?Q?UsFgHdbIsqFImp/Xo6v3UVb/Z5a4MciNr3uHoO16A3VibQP2VwldtZHrMyeI?=
 =?us-ascii?Q?9M8ZP3Z4FGuNkvCH6ih/q7QOVBIFumogiDLJ/qhIL1N9KtLPoYlKp4jDdbUW?=
 =?us-ascii?Q?DfFMl9suH44jlteh3ZZJLDk+Z74PBaTlk7QxKMlS8GCt4xyTlshpMhW/R4vY?=
 =?us-ascii?Q?f4k43xgECBoC6jIrcacrYFFEOZ4/ytLhzM9rwOLTLNPekcE6gWtFPfXyXZc/?=
 =?us-ascii?Q?unn8a2RsokqJI6tkNtLQ2hLAzsdopt4j+DUhzsv8MDQ875wKo+hw7673mJN+?=
 =?us-ascii?Q?TY16lYzbu79Wi1fQ5V2oLQc1wlNY1sXYEXTtd+I3jZrHZsXtJwg8SdGaljby?=
 =?us-ascii?Q?k8ZOscb0fvhp0BLdpG7EwxGtsPH1EPzsLpXLjeTQYJsK8nSL0zT4CwCkmd8D?=
 =?us-ascii?Q?A3O9BBXbokXRb2F1mpRer8U3o7tqALwRrnxCOeS1niGMorSpCXNkXVFAkqyC?=
 =?us-ascii?Q?jnfyhYa52yNSLBFlgL6SyusS/S938zOLCqlYxwyUYNIcYVIJ8H0+Nm9Rq6Lm?=
 =?us-ascii?Q?hmQXoa/olTM1Cl0KMLwe48fzfD1ML8BGztEHfa7YSygXt2MZNIeUYPzkil77?=
 =?us-ascii?Q?LWFcgojMpRJCiT+UhwDClIxEsrUya0xNV6WCo5sOq48U0TU9mDDFG3j9Mghc?=
 =?us-ascii?Q?X+Kl9OIMV3uOGjx7pFG9SsIDOFnc4yNBSdC5GpxaQRQ4TcRbATvDKI6POOK+?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0430ee-26ae-445b-a311-08dcea02697f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:38:46.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsaGURpO+pPhh1PD8PK5xPdeYSVB2p5GgsxqCIA/erVmJnh7usRmz7Lel/7cWaZTFZppTfqTeYdFexiewQqZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

On Thu, Oct 10, 2024 at 05:20:54PM +0800, Wei Fang wrote:
> When testing the XDP_REDIRECT function on the LS1028A platform, we
> found a very reproducible issue that the Tx frames can no longer be
> sent out even if XDP_REDIRECT is turned off. Specifically, if there
> is a lot of traffic on Rx direction, when XDP_REDIRECT is turned on,
> the console may display some warnings like "timeout for tx ring #6
> clear", and all redirected frames will be dropped, the detailed log
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
> By analyzing the XDP_REDIRECT implementation of enetc driver, the
> driver will reconfigure Tx and Rx BD rings when a bpf program is
> installed or uninstalled, but there is no mechanisms to block the
> redirected frames when enetc driver reconfigures rings. Similarly,
> XDP_TX verdicts on received frames can also lead to frames being
> enqueued in the Tx rings. Because XDP ignores the state set by the
> netif_tx_wake_queue() API, so introduce the ENETC_TX_DOWN flag to
> suppress transmission of XDP frames.
> 
> Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

