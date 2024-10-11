Return-Path: <bpf+bounces-41744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B199A695
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E30A28608B
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F582C60;
	Fri, 11 Oct 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l6MpjNGE"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6478C6D;
	Fri, 11 Oct 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657619; cv=fail; b=lFXjq7syo8kZqsmEfhX4qAQMiPtCKfsIUW09Tc8brueton1R3f57DfjZ8WsKz7mhjOidHy53hEFgl5gna8AnFBbhUF2tWPiWZxusJcZaDFa8ZPWgkc5pv2MmDbzZ9tNwD7J4xdo8SRFo+yzrqliMFHp/SDGKU/tA9baEdXF6gfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657619; c=relaxed/simple;
	bh=YYcE9KvYPVIrjNLzA2lCrBX3x+HXTreEJ0wTrIWULj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pNWxlJQPgM/65h/NqJ4YrE9Q/yfRuVvfPPGRBoiChvghblI0d0kn2BzNQWdV/YwvvwzlsG5pudX7gF4ygLXcjGU+P0shyDrMSYKXlj1Wy9ny+lI/XZzlLJ4gGwPlZextY/nzQ5o9drzztDodKkux43JgoXupByNJLeByxpmlp6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l6MpjNGE; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duwvlxs7vwyLnc1x+iId/KvILqoJ3oMeutrPtEbjzJqveAVXaDdPbmBwjClYlQabvosv8ZDsu0k50qUhBcoYom/h7Ypd1VmAQD9vvcffll/0MrhlI0MdIMNIU7oXAJt82XbkHtprFb0nRiM9fp6fAKtXZfV11W8WF2TwavAXezSD1YYBASGuOkq0WY35MX9StQnVgqRfCeASN5DEIbCBY41IVuUYwETjoBQfdm+Zp3kwmdNzvLJL7B251oV/d+CdCbLiGntdb3LMWpSZ7GZuaSsReezKZvBUjnpkzASr/DknwSuuhaIKelm5m37z8FnuFoGGQN4DPMG+KgiNOkvG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7GxwD5nJM5u7NLSyZiscJFhoKoCGC38EiGj+g2h6pc=;
 b=kE3qdjN9BpvLgohxNnMFPMRSa0DEzMzvRRJPo2t92ISDyVkKUdAIaKWPe7PODQVpdpqsJp5TkzwraxAnvbsYbHL6vqR+h7X98iG11t7FveTp3AhjfriDbI0yzLt/BRti4k3Ob0D7elPo+M6nN0vByy+obFUSxqDD0Fh/U+pQ6P9wPYWVl22AFVc1vym9CUa3kfW4qpwovKAE16rjygfn87YEle+i1L6XmLIGdJh75yovK74RzasFAKfd9b2kHoUo5OvNghRg/4VYwivmw5KcUFp38B1A9A5dx3yRsSlphjNaU0v5MzSjtV6u0VGvstnSRE3JcEfNtvHIvvThpQZlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7GxwD5nJM5u7NLSyZiscJFhoKoCGC38EiGj+g2h6pc=;
 b=l6MpjNGECfYvEVigSIdpGKQK0z3KyUnTMUG0/xBPVCvy4Vkz3SABe8sDcZF+Gdyu+G70mjbdXvjqcXyEQ/zh43if/S1B/3Xic4crlicLxNSY2shhBnJShXj/C4Iqg24zb9brwGN8HyjiIPSKYz/c+R9cCjMGUkMnEME+NEB8lnL0wg4JWfOGDZqaAeXv/jSwEl/20Aoirw2KeSsrKv4+CnkETzyI1RCxeZOMyus+4ME+/JfPCJ5JCVQx8DD6V5gcKD332cFug0OaryMVCZIBaeAO47Th9NQ81Zx8UuGS8aZ5K5THaRvb7Yl3IXk2ca4fPz/BN736ev1V2PlJPHR2UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10562.eurprd04.prod.outlook.com (2603:10a6:150:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:40:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:40:12 +0000
Date: Fri, 11 Oct 2024 17:40:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, claudiu.manoil@nxp.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org, imx@lists.linux.dev,
	rkannoth@marvell.com, maciej.fijalkowski@intel.com,
	sbhatta@marvell.com
Subject: Re: [PATCH v4 net 3/4] net: enetc: disable Tx BD rings after they
 are empty
Message-ID: <20241011144009.ydoyf5vlxqrdj2pu@skbuf>
References: <20241010092056.298128-1-wei.fang@nxp.com>
 <20241010092056.298128-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010092056.298128-4-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:802:2::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10562:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ea86af-2514-4f34-001a-08dcea029ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gDchBetlcWTE+STv4j6sYAkXWebeN2j2LIW11jNM10VrBTwPIPA0FoAmfh6u?=
 =?us-ascii?Q?v18yw1GLSwI0S+OZEKk60I3qahTJx+JMk36wvVCA+BnffaqAbyohglt2Wfvb?=
 =?us-ascii?Q?i+iv+GP7D66u7xkGBlUR5+Q4zN/6jQqGHYoJYGyAdQjTA9vq8iprdKnQPYiK?=
 =?us-ascii?Q?rZfcFUMUGg87uwTHH41YShcJj4iQZ8AirTEgJnOxdLHXqbdPUtKkLRvqRvyy?=
 =?us-ascii?Q?+ahABZtN8r9sg+vKtvlXeRZ7l3vjLPw9gp+f+M4MRAvGMFwbptikKv2vsEfx?=
 =?us-ascii?Q?qGFJnKLV15UpRN5IjQdYn9CmXbxKLQvbwAYtLliIrOQEoV1fTuvjmen4vmKU?=
 =?us-ascii?Q?Y+OiCUj/TVsZQFfkglwyla8eRGQzWzWHsL/TRQRPmhbtSwZht3xyftNOGRFO?=
 =?us-ascii?Q?/1LVp3ZHYjlsTx13N0cYHSdqQ+we3to7a13L+yzURPP5OK36elWw1s9AH833?=
 =?us-ascii?Q?gAUtzPSjnygi1kXu5KgSRIzo4wwmuz3RJFdrG00t75kJFyK50WzgnQVln4GR?=
 =?us-ascii?Q?sVCfqdLrRQhulDqEGJ+255LbTVytRkI069HfopJ8Fb3ZwqqIhNl81URMM2uX?=
 =?us-ascii?Q?CPjoF/WrduV6cRauUJLYq6NjkwJ9ieRlFV8x7n8lKWVLIC4TppZMc9nxBwt9?=
 =?us-ascii?Q?ChLIh6/WNWdYv27MD4A52mSrdxLnJdyRvA5o58wFYDyB0ozXB6q4uHsMh1bB?=
 =?us-ascii?Q?WCbxfXMYc6ZiAjKsTKdnzaQ96xirk09kzcZmjwd4lPzHzXk940XkHeBae1SZ?=
 =?us-ascii?Q?TbtCh2U0LkIZofkE/Gql//BuHXzHbPsQ6jUrzyuuJTFyUslcEnQuixIjcUj3?=
 =?us-ascii?Q?J2cvBmAdytFE/1fqyDN/+IXKmu3LPTjZx+dGHymnj3UspGQJfB8LtkpopV1M?=
 =?us-ascii?Q?5TL7YpKgpR+DVMMty60zEAhxEgkPsWLi9oAHbfim4xhDoPZlrsS8LegD1ZcM?=
 =?us-ascii?Q?vDhBpOrLz2dEf8VTDze7+i2vqmk2LK9l4ZQbmAVpRJm+8pjlzEWxDFf65CkW?=
 =?us-ascii?Q?qPC2FI2sxl4VQvh1bT1r6pEGo32Ipwe2OlZRCKioCptflrZfzF4NfK1HtYJL?=
 =?us-ascii?Q?787EAMmQBxYcaexEToHmkWBgnkJEzCaJFYXJbEIng6cbgGGQabhROD7uT4rH?=
 =?us-ascii?Q?Lnn14eT6jtxoC5Y9RWdTOP7NagLQcupfBDx1NrdFPm1DRQ29WzcwayuS3uzf?=
 =?us-ascii?Q?A6UmKVhDR2HXvpmkDd9mCQyEwF+RKzBHsHroPiv6qhNAxvQ9C54NXhXEWd/i?=
 =?us-ascii?Q?CME2SAaumQo+jD/Fjzv8l8U4gznBaj6fRLsHSplNiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSs6fpCdFHKSplmiCXp9cMX4fpKGgKlD77+so4RIQ5/knRxURgaZ8HIbXdaK?=
 =?us-ascii?Q?pnc2BYkI7y8gtYz/KqQ73XFxEJCGjMetmdc/H5na9uWvBWeNcWtEmFIrzeWx?=
 =?us-ascii?Q?Ky0Nq+IthgXCMVXc0NwU4u3iDDeZu3mebl1AMXtpFBaYEYHGqL0eZ7rdUW6p?=
 =?us-ascii?Q?ZHo3tiqlbsbmHmZ58a/6pY0BnDvWY/j3NgjVd5pfC0rRCzdD00KKxcdMgzy6?=
 =?us-ascii?Q?v+DTH84c4/ABZNq+fmDgwdUPkL/DVOtRDZlMoIFZTvOxq2gfK9wPG3CAt/6t?=
 =?us-ascii?Q?jHx1ilyNe9lL8LHlfLU3LKeg+VSdjPgI92tF31jtt2PCXgXA0WCZlBRuaQCU?=
 =?us-ascii?Q?+RSNHBGPZACdcVHrJ8ppw5TJUDvPQgR28d/HLLKjfINzdstTJYqooPQ97DRG?=
 =?us-ascii?Q?3i+0EXmearEXuYtfzUnfJMjrwO+Fl+WJZ5qP9elJ0V6WlXPPxwnieguu5LH9?=
 =?us-ascii?Q?vvSt42dpdvkSY70wTiNnwAv7BGVFq5wmhj6hTm/dCDXQHsyfeOXd5T4NjQ4F?=
 =?us-ascii?Q?FY/ZpQ37O2hhLH0llc+CstlgeNqOhPCrCXWVdWo+25Wbnood/NYrng1pp8IM?=
 =?us-ascii?Q?V2U8C7HL+OWZL1Knip2kRZq+7XVn/yOQWAoS72AdHqwbjvY1KWh8uHAU6Hi2?=
 =?us-ascii?Q?ETpzzjK/NG0KqvhJ42/MaYLeIdrTkkyrdA/Q+ztFIlhWDKx6SwL6j/UhxxTN?=
 =?us-ascii?Q?5MUpiSwYvpmI8seo6giz6gSGUO9VPoh9WUt62maZm+R5HPkfhAAiFfl1H3AV?=
 =?us-ascii?Q?sA0fjuQISnxzc9ifi6EvAuHpRKRY0j8iDyq+dynKD8eai7ipIRH5vYrVNTVZ?=
 =?us-ascii?Q?ZQWvQn6BGDPekCGYOXAlouVIpKPVCmmGluCtR4j1Dh7GeWEhY9onECQY0bWM?=
 =?us-ascii?Q?uNTHpZNHMMxTqKKoe98UoD4J88I0/i6oEBLUDXuckDbHPBwHaIduQ7Aywplr?=
 =?us-ascii?Q?2dxtEI79B4b9L2lew7Vr7Rk7F/ayO9b3peK0Ig/97BfRT8XSqRgQKOkDhQ/3?=
 =?us-ascii?Q?8yj68dLaKTdAOtjledC21qKHwDy7Sc+9R08mbuFUeRG5TeBI0bgGPcg4tpHN?=
 =?us-ascii?Q?f8lIj2J0IkJRfGCbBtGy/nrP1xmDMKRiV0oDjkI2w2iB1wecX1Z4oEtmuCiT?=
 =?us-ascii?Q?qLjk4uOS9apJnz3x8iwyls2J+xzFrGpLb9X2h91LFJ4t7HkmtV85xO/pM7cF?=
 =?us-ascii?Q?nyAG1CWGgBTDdXSIyexkW/8XcDC3gIaljott9RyDAnLHhN7fTnS+nUMe6soF?=
 =?us-ascii?Q?qTXM1xNbTKJaeNpxGM52SSNR3wqPU9gOnAAHfNTCWa00ABDyrnhLSKT/MT97?=
 =?us-ascii?Q?lL1O9OQEKHrvdkDgvcLvE55+1A+NxORlBk+OyxeV8ucLNeP27KJe94D4jF02?=
 =?us-ascii?Q?D6kugO2KS6jJplREg/mQYMcIRaVIiVayjX2mpVs5F/b4nuHqP3LOulkDXFpD?=
 =?us-ascii?Q?A2x0ENioXxSI25Lsn73GSoLQOVOHP2W7e7XFQJIWLNFO+bsgCQLpSKW0gO2R?=
 =?us-ascii?Q?X1nPB+P/EN2fp8wFKqUUjW788i5qZT0Y4TTa10MYhAYl9dAtDw9aczygqkf5?=
 =?us-ascii?Q?KMCbG7Iu/fbYVh5qfF2orCp4GnTkfhfxJ8TSsoTQF8AJXX94YZyIwAkzJHNA?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ea86af-2514-4f34-001a-08dcea029ce4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:40:12.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86iEWGEaYhiPU5rZ9QaiPjrRwC2DCDiPpxhoS9VLunDouyUzSu6uSJJHhtbeX1SMf7yQGZBcl9sKR5IApT1+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10562

On Thu, Oct 10, 2024 at 05:20:55PM +0800, Wei Fang wrote:
> The Tx BD rings are disabled first in enetc_stop() and the driver
> waits for them to become empty. This operation is not safe while
> the ring is actively transmitting frames, and will cause the ring
> to not be empty and hardware exception. As described in the NETC
> block guide, software should only disable an active Tx ring after
> all pending ring entries have been consumed (i.e. when PI = CI).
> Disabling a transmit ring that is actively processing BDs risks
> a HW-SW race hazard whereby a hardware resource becomes assigned
> to work on one or more ring entries only to have those entries be
> removed due to the ring becoming disabled.
> 
> When testing XDP_REDIRECT feautre, although all frames were blocked
> from being put into Tx rings during ring reconfiguration, the similar
> warning log was still encountered:
> 
> fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #6 clear
> fsl_enetc 0000:00:00.2 eno2: timeout for tx ring #7 clear
> 
> The reason is that when there are still unsent frames in the Tx ring,
> disabling the Tx ring causes the remaining frames to be unable to be
> sent out. And the Tx ring cannot be restored, which means that even
> if the xdp program is uninstalled, the Tx frames cannot be sent out
> anymore. Therefore, correct the operation order in enect_start() and
> enect_stop().

Typos, no need to resend for this: enect -> enetc.

> 
> Fixes: ff58fda09096 ("net: enetc: prioritize ability to go down over packet processing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

