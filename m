Return-Path: <bpf+bounces-76346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD3CAF4F4
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 09:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81554302EFD2
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939332D3725;
	Tue,  9 Dec 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k7bsBNVe"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89C1D9346;
	Tue,  9 Dec 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765269342; cv=fail; b=qGZP/SFspyYKzmLLfC2GxfK0zmHw9RI3Y9giZzDinpX35bcZ7w8eZnFhVwPcJkpwffzGbiD88QgcFaZ5UzaguGJCQvtumN1iXEJ3M9TyN+k2C9ULsth8JE46IeMxoscB80qndgMNS/CTFHDDFELbyjZ5WviTqQoiZP7ZA2hxwEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765269342; c=relaxed/simple;
	bh=jUTbJeR/XIF0Dl5vCgPesluptkIx8Yjl0QWMhY9mprE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5BgoZmF1VQvA/cFqiSiKpjtK30L+VcNK/qBoBJVm0XHDc8XSvo9FeYe4hnEKJFvqCYJmkFyLhptSDoEe3teCESvDEwAbCQD+5ShMBVjtSM18uPl/a4aSa1NXaNXkOthPUnEoxQbSxdfZY7guqV5PxZbLhtAPeU9exolvz67zoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k7bsBNVe; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viSDH0uAC665yod+Hn0mAGHScEsBXxUUrRJH8HWHLug0yAd9k7eKUhE2FfxACGWZSwKVbYZ2OohEB2E8OYR11e9Ead0tagbivWiWbNeJearg6W/y3z2F4hsn+gAkDZA+GAh7euh7WU+pBHqSFkgZJPMDRtwfrHy0BEOiRRObpXvz1YzpMmmPQXv9AOGqO3Bm5LYKp3XlYgYLq3VWmepolTJL4rSbjgKWhthOlmN2xRuK9uKuUpJLYAnvD1ZZYz/LwsXwzsZav7kX8P7Tc7k6EI227yd7MQyUJubh/W/90Xx0ED6jM1Tdk1RYHHxmYpKKdN/73gRa1jVpUO5G0ZTSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xux1SUKV337m3JfDQHkAej0SPriCTUqKHVTNxE+LZWI=;
 b=ZGEaRQmT2cg+jMnTm9z0T1BPvTh8E7zy2sB/HmBs/aIOvGPmcN7zRXfX/E0+iiSX6DSm1DroTkeQAZq6IP/07S/2rmDbKPIn6GsIEQ54GHAhxHgNvjGagr6iL2vp9W4+r4DzqRq/fQS5TQb/BgJDaPocDciwea2Atj4XoEPprdH9EqpGFZk6JJFVpRz3G0MpXm7xUORP2ecSu8by/ZNuq9EtsI8Fcxl1A+qXTpRBF6YHoVtXnaoIlj2X88v7XCW6GNisd/Rbm/XTnPuXOSNMoDKDYUcC4Kd1uFH8ds+05Q3qZAF7uzL/lEZP+BiBxx5EJCWRXoguA+KlMw1P+PtZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xux1SUKV337m3JfDQHkAej0SPriCTUqKHVTNxE+LZWI=;
 b=k7bsBNVelQeGT8zI+d2+chp5Vd9dGtWca6RLXb0u7rie+viSVoDMpHqtDtR1XsdlOIWMFEbNcy3+WiC0aflb++JLinmFv8hFif4JQb0XZ06prRaFeLkrZonzPK6j10gEKegnfaXd06jI76cyMHqC/8xUUQPgQsCsP4yMC/Xtr+MwDhe2zRAKWLhP5h63AT4mRs0TR70FTAenFbSnz9PBPEl5xg4EWv1JI2OHGAZncc3DwDXOtJExilN01X6RDTr3jESs1+DCMe56DRhzmYMzpIzxAMKgQdS7ZaCwm2tbDHCBOJvujwZnzpDzh8FBh9NkuahN2auL6YRrw8hE/9um/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 08:35:35 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 08:35:35 +0000
Date: Tue, 9 Dec 2025 10:35:31 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: do not transmit redirected XDP frames
 when the link is down
Message-ID: <20251209083531.2yk2lv2rahouytv2@skbuf>
References: <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251205105307.2756994-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205105307.2756994-1-wei.fang@nxp.com>
 <20251205105307.2756994-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR08CA0219.eurprd08.prod.outlook.com
 (2603:10a6:802:15::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: acca7561-8365-4e2f-15cb-08de36fdebd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYmPmHKJW3H/jyTBZ8L6ALiRO9aPOwStegHID6bGFC6QJ+vjbB1A0VWDoh82?=
 =?us-ascii?Q?UYTRxZfoCl9cU33l/x8iRrZuHu5+GXIOpMn9Dmo6Eq2UcA3ht95rWnGs3DKa?=
 =?us-ascii?Q?BhuFcvRoVqrtD9Q/j0vTFWh12N+YHK6DPr8ekq2MpIfGohVkZmwx08dTpGzz?=
 =?us-ascii?Q?t0BX3Jt/1EJI4ZZaDRowkNP2mPnB5ecHKqW0kGayhmk8HLMh5ayNORJP+SFP?=
 =?us-ascii?Q?jMdxZeG39B8bEOkp8NPXJCfMUwh+s4tOjZqEr/EJzz0pNbqMapL2nMeuOQKG?=
 =?us-ascii?Q?eqa+iB/Yy/T0qrXKU24RrR7RQ/RdmmuyR3mzd2+PB3fUWRQqXneUZXAF1NCw?=
 =?us-ascii?Q?MRhdZ0VJvEx1AqOYL9KfQMYI2i8Gby1bND34WbIe0p1swggCmtlCPkxGXEuN?=
 =?us-ascii?Q?XuViTrwOA6UVitTGPjTXnK98hhXmpD+X/ikXp6BxY1NxNst0T3ll1yHfIUg9?=
 =?us-ascii?Q?EotuQpZ2W5vig9mffA/DiDS0Mh96SFWtxV7F8SPJwqvYoMkkYeu8Wh9c8jHn?=
 =?us-ascii?Q?oYm8zEXNS68x0BhMISlbTYJUlXdvgzWmyAVn/cfykQqYui0SGb+He+b3u2TH?=
 =?us-ascii?Q?TDmaAUhQmoCZPqV/0+yBRfubqW8/oH+a+STtU2011NBXmlWbXJx+B2H+dihq?=
 =?us-ascii?Q?Dr3tBuX0C0Rn5sEg/9ujMSqVDJhG/B1CiV2m+UyugnfOFQDvlzawpz7KHUGv?=
 =?us-ascii?Q?WtCMjr5dgsGEYcM6nVQy+kknPTAwwmoO+uWjhDDrduB70uc83grA+InyzjGg?=
 =?us-ascii?Q?eldFytA80wF5lCfwPNAvdfIEhPymmM8CxdKSz9RVEZEvSis6t2a+9GNRH4oG?=
 =?us-ascii?Q?6xbFJ+CJXp9vtFvXuc/uNCmjBkgURw9KduB2Gt5MayZSjB6IzYtDUQkc5OVc?=
 =?us-ascii?Q?V781Unzum/KsYYYlf7jXYjhKOuW3qnMaX4Uq8AiQh4yKbQqer/pLkAgm1ckT?=
 =?us-ascii?Q?IC3aT9eyXNp2Z0mkQHfHuegMOAssvfMRI/sfsOrdVs3diyvF6ddXYaK2W9iV?=
 =?us-ascii?Q?6fAgzCbvwfHgTpTgf8STMFloWw0/uOzBf+cju8RQse0THHnqXvPXVhzPsZFX?=
 =?us-ascii?Q?yTzA7CXA1moQZThWAFwan5fil2ukrhxfv3FhYO1TIM2mFh+rm6ZcTbYJoixb?=
 =?us-ascii?Q?RrfCTnxl3gnqoiF2fIpSzahzA7DBkRGHe/5Myefc48iY3hB3aSLEnIy2dMyz?=
 =?us-ascii?Q?sA/gzJnlkdB3Vlxr1eNDTISB8Sb17HSxOTShpoCGYDYtDJqhwMy4HCVpaa9X?=
 =?us-ascii?Q?q8JbtBHmBYPAcOvAJkfky2F76Z2K8D1/pjJ3lf9wRvYykgbWlFUIbEz3oAcP?=
 =?us-ascii?Q?Tzj1+D3c1imz67pMjBFyZzIYA1hFZ7jSqmvaPpAkYnps6XlyHxQ1Jp+tSKe/?=
 =?us-ascii?Q?BqZc6dPtbKceeWixUMAvJjVNs2pZS2iHpNQag5WS/+CORB1kwrYeuh7Esooo?=
 =?us-ascii?Q?zfmhFWT+cvYh8Tfyf2/OzfF5n4mzdJ5D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vvT7O314QxU8B9y5gFI4HJgj6v2tnPoepBQbYgijTq2gOkEbvQNLaUquX3VV?=
 =?us-ascii?Q?MHMrLY4QWt/EJoDg2LfQkM38p/N+N7RDGKhpNnKmIM8hWHxVfnft9kBj0zXY?=
 =?us-ascii?Q?ONKX3Vt9coCATQQue47B5E4HH7RV/+sX4HQtjnja6JTIw1OBNZQSnG2uaTSZ?=
 =?us-ascii?Q?5lCjOH2HymE4c1VlDbFqMzlt4M3K+q+vRN3o/jpTb3UcO9GpQYH7+qjc0/jz?=
 =?us-ascii?Q?2iKAGzgC9EYNlyujXO2DipR1nN0owDwjx16kWVNhYYm9UsJYiHIvKdOmAU2m?=
 =?us-ascii?Q?r3wU9sJ0cv/7ivmf0IhmtfUuOrme26JcRrkIyGGtFgJjSJ07Ub8Ci9/Ete0O?=
 =?us-ascii?Q?iTRDCmfqyjRbMj05cki4OggOBDgsNshK4cA65xK/8woWUSwnNY0ExRUmE/+I?=
 =?us-ascii?Q?M4Dbj4xq0W0jmp7LFD+H2FKOXhOEzousI9dv4l0vdftmpTnQpwYUDlka+kmo?=
 =?us-ascii?Q?9n+nWA2IYQL1wl6iJSRI8ci8cOmVCA2VGLcqqp1ZtkTiJh+DKcKyfarm4h5n?=
 =?us-ascii?Q?6f3PmEyPHuFpB8rq29lO2Y+mecl8bwfcKq/mzhpJgOXNm91fOVF1/f2GGR28?=
 =?us-ascii?Q?jLQIeZ5Uj2YnYxexAz8g2/Hr5UvceVEoJrrejsksOfOxcb4vXGAWvEVB9NWW?=
 =?us-ascii?Q?VbRRpsI4eN/9bee+fsvehoWP1CVvlWuZoSIIitKxBd8L8gZ9ONwv+dCKZmrW?=
 =?us-ascii?Q?r5oK0JifWlmhXd8+hdF2QJ7XwmpE94GAuFE/CdE5qasLt/Q8sV1eX+dekn+4?=
 =?us-ascii?Q?hiRL4N1B8v9fx69iUEvkrLYxDuG6+zLNFBviefky1hS0wM0kxv+rVR//2Ero?=
 =?us-ascii?Q?YnvwcKu8TijjDCZB3mWPXKMRieaK62A7eNc1E76l1DLhX5Ecn9r3qq0iDawZ?=
 =?us-ascii?Q?IRg5ozl4/HJqrFO3gaSSNqZUDfMG9p49/kU30sYFwG8s7D6gFc1SYKKeZgBH?=
 =?us-ascii?Q?lqlQjigV7AB+5LSDj/1lenCKvTu2s6BDrI4+QDWb0GDsld/yMRuWiKKhdiPY?=
 =?us-ascii?Q?KZsmm51pdimK3D7tUXqfsg/EJtHWmViqE4/peEaciYo7yxR0EoNyfHAFHb3Y?=
 =?us-ascii?Q?3BdmmPo+Mckczr2YcOqVFYMJbLIMHvp7e9uykCTSJeaz/cvOdgrTNoZoCkJl?=
 =?us-ascii?Q?3bY/2VwSsOQVs/o66CG9GnA0zQRIVWsEsYqtWU4euuxe7+cM60yaFidQhj7G?=
 =?us-ascii?Q?Woj2ZjY5bmFe3M4b3mHRdZMU6sgW5EYVzHMry+OPSuJvViQJ1CYUJ4I4R9Jx?=
 =?us-ascii?Q?WP1VCwFf1CYJawU2E9F6IJB+gm0dbferOIaVwCNg0mHWnvRAl4xNyOiHDljr?=
 =?us-ascii?Q?xRI2H/7ui3Nw3N7jnDV5BdMvF2Je6QJa7hH68niO8xRCOvw8dxmyzPkYYTMJ?=
 =?us-ascii?Q?4EX/E2PeTCxcecrzrthqhNZAZpBRGr9ce8eM7NhwCvd76RNGc+YjY7HcfM7j?=
 =?us-ascii?Q?VLX2uaZbjyDld0VraOVmRoMhXdi9AEHZdcmGA3Nyzx6P6O62qsF0q3hiiOcm?=
 =?us-ascii?Q?7BrcMPmf2H7K6K/vrtzmSt1xboKweHbgy3JNKrNVbmaiLeqyiooBg9tEzD2I?=
 =?us-ascii?Q?UbQIznCX4Q946e0/DXXRKF6azygP2pptJ/H5P3O5I90j0q3BwBJcZZUPTisW?=
 =?us-ascii?Q?1ozATXEnF5WoNV79dD/q9B/pyG4WUn8cmDJ9XBnFpcQ311evYrpGow+elyH4?=
 =?us-ascii?Q?petYhg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca7561-8365-4e2f-15cb-08de36fdebd0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:35:35.6149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7lu74f7wUEBM14Fp5CEHFZCbhRD5mj4iza0QuVEnVjvgUFqAzXULw4bf4Eql2c/nxft8SwiNj/ziXGN0u6EWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

On Fri, Dec 05, 2025 at 06:53:07PM +0800, Wei Fang wrote:
> In the current implementation, the enetc_xdp_xmit() always transmits
> redirected XDP frames even if the link is down, but the frames cannot
> be transmitted from TX BD rings when the link is down, so the frames
> are still kept in the TX BD rings. If the XDP program is uninstalled,
> users will see the following warning logs.
> 
> fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear
> 
> More worse, the TX BD ring cannot work properly anymore, because the
> HW PIR and CIR are not the same after the re-initialization of the TX
> BD ring.

I understand and I don't disagree that the TX BD ring doesn't work
anymore if we disable it while it has pending frames (the TB0MR[EN]
documentation says that this is unsafe too), but:
- I don't understand why the hardware PIR and CIR are not the same after
  the TX ring reinitialization
- I don't understand how the effect and the claimed cause are connected

Could you please give more details what you mean here?

> And I see no reasons to transmit the redirected XDP frames
> when the link is down, so add a link status check to quickly fix this
> issue. However, this solution does not completely solve the problem,
> for example, if the link is broken during transmission and the TX BD
> ring still has unsent frames. I think this requires another patch to
> address this situation, but it will not conflict with the current
> solution and can coexist.
> 
> Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 0535e92404e3..f410c245ea91 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1778,7 +1778,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
>  	int xdp_tx_bd_cnt, i, k;
>  	int xdp_tx_frm_cnt = 0;
>  
> -	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
> +	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
> +		     !netif_carrier_ok(ndev)))
>  		return -ENETDOWN;
>  
>  	enetc_lock_mdio();
> -- 
> 2.34.1
>

