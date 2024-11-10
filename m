Return-Path: <bpf+bounces-44461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101439C32C8
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 15:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C448B28144C
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2A29D19;
	Sun, 10 Nov 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M1SOWtPV"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E767D2FA;
	Sun, 10 Nov 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248515; cv=fail; b=P6iFWJan/o+XbyEuVEdBIBZdo31l7kQes5bcFCgNKHnByESebsLTX8sT1khVD5O0hftQRVGhRvUCrJKPNmqDXT4Y2v5YGEmUPyZsB0FJjbeFZxyCUj2ZwAAgSTYSlbOH4r6hddqOn6SbHWgxRJHc86XpU4BkEXU1P2EEgvZDJjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248515; c=relaxed/simple;
	bh=sLY96OeBvcEF33/58SMH+ARu1NsdtlgcDZ+oLjfy9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZR+rUSu5j1t4BocRtudZ6NA9v5rZGVwPe32HSVV/BUyzw3CEzlhCn+sVQ3f65frV8CTHA/KwxyXYa8F5IbauYOx72gmt5nDWY56a8XpH6q+jhrTnJTBz/5/uBusAyr3jNWiphfYzR+VWJrVEf49l0JgpVACBxUmyB7gVIbeZP40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M1SOWtPV; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBTG++ZZR9vrJXoeqF5J7Rsl2zy/w4eKY1HvWbtPltr3sPVcZCNNWXJ/rWNRUxGtBstR0ukUkIgE74a4PdgvDAxqraic/hAShzWlGvRt9aunaQC0nUuMTkcXPxdDXKZSNA9IWNMV4zSLv2c2QBvI+Zq5ux6Z4UVf9ZmIybYvsk2PzhFrQM4J2ldNniRTE9scWGZmDl7ZcjsJIEWWtpw2qZnIjUhg0nI5bCeJo2yrOxgyuKqLGs9cBw2YNnsdK8n9OWUAWWig+4pU15lPLvwbxzvDp5vihpTRc5YSrQR5aj7T+PMZ759LGS8TWS4cYL5MBUMpISzJiKTN3cmeaRF4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DCesIV1cHrZTi0bk6KaGQDpGDPlU86qAPsZeSh3n0c=;
 b=Q/4/9M62X1jKWMOE9DgH+nUDFqIjOHtSTKtcQUzjDZJrjHDiacxDYJ2vSjytV6fmeM5LM/QNrWmsNSEUCseEo2+4RKJNKySWlGMPE9PDLrm2alXFewVUI9bS5dQApUACL6P5C3/puR69rUqsdL94HrPCw4WP2lbydOIMEs65J9Q7TzTJgu6YlttZUNK/pEpYmmPs89hwidDn8ItYcjMNgFZR4oA+rHqvyyM+QoAXJ/MorCm7f2YZBLqiIVpg+WsI79V3fUbV7r8wiVi/m0oknlxSbRO0odJEfzAIqKSIxQUK+9sFeVnebUoEsMLS/PeatmNfdRPX5nbrfxgNyFQIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DCesIV1cHrZTi0bk6KaGQDpGDPlU86qAPsZeSh3n0c=;
 b=M1SOWtPVopx4GoNGwJ0YThrExaTMeP/uxbF8wIGvh4YLe45EfaTNel2NGI2EObVxwSFklW7e3FBvcnhltziVz0iQSUv9UDkZXB4qUhv4pswZRN237s+WykHxJoWuhNeKhfQrQ4QyuoqTvt29HvdaC8iMwc7rZZbHod3xBNW/tF17j7tvhpMMKxiQvF04dhSDlejZ0w8K3xnrUXmUA1x7lcdweYunAI8l3q5aAY/4sldqtgJWg5gVrMpIdc1YwQctudcF6OsHYE5/X0Vf8Z3qRCidPUSLClFrX/IdQtwgpreprEKT8tuDXjZL5A6MNllUfPmXaZlMkz3mElESIP49Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sun, 10 Nov
 2024 14:21:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 14:21:50 +0000
Date: Sun, 10 Nov 2024 16:21:41 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] bpf: ipv4: Prepare
 __bpf_redirect_neigh_v4() to future .flowi4_tos conversion.
Message-ID: <ZzDBdSZPTZ1OvcAX@shredder>
References: <cover.1731064982.git.gnault@redhat.com>
 <35eacc8955003e434afb1365d404193cc98a9579.1731064982.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35eacc8955003e434afb1365d404193cc98a9579.1731064982.git.gnault@redhat.com>
X-ClientProxiedBy: YT4PR01CA0456.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 345207dc-d0e9-4816-cecf-08dd019304a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IIxKaf6mUJIUsHFBxDoNT2m25SWqcdpQPiQk2wP0liIUQ8QkfijTpCBNaF7o?=
 =?us-ascii?Q?sbCrruenL8KHPSHNhhwv/fhum7ELz9E1rtEfkVoquq9mPtGtsQQBkdqfAjY4?=
 =?us-ascii?Q?xBS7bmEitlq13SQMvfrPv9xvwlpRn3qNteKjmoFMn6ZhYmJiwHt1Jg7QVqtR?=
 =?us-ascii?Q?Y+njBeZg4l83ARhyQbnyPQ9h03LaYzBosBnGERQC0ffbzpQmNen+yNcjRGF8?=
 =?us-ascii?Q?syIXBAVn/SXsMWgIX6WH6aziDCPRe3wKKAzoSu8ehsKarh1Uq244aqQ1e20U?=
 =?us-ascii?Q?t+ovAKIfuqSBJpzg20sSuI5J9dJbrwnlS3X0ECeyblCigmF64pDhYxJNGguF?=
 =?us-ascii?Q?nt9w74zX954nMkKRbJpa1s+G4rfHBQ98BjNuYJv/C93npKn4GYFy3EwJzoBb?=
 =?us-ascii?Q?wB/hx2xd05NRVXfwbcjH9DhKFxcVjJE/mjBiJGlo+jLmLNevsdAM4o6buN8c?=
 =?us-ascii?Q?kv+DXbDMXx2IKTXLKbQbjHof1aNdWHSrPoGPbKSwHqcKxNgsMFc7zzF2GlgH?=
 =?us-ascii?Q?WexYcsvUpvf+fXov/dQClGTG6jhmG13depoMAkDlnnhe+Xaeee3Ux+DQUZPr?=
 =?us-ascii?Q?vsyrewnMNjRHF4B2q9VZOMdETmgyd1PK/kEaKh+cMB6fROXODPIiE0nD+/a/?=
 =?us-ascii?Q?6uoRWKrPeiXJmer/CQEHKWWvfliDxZ2hqUpiO3BERqltqQBMrmMu4DiVX4Ri?=
 =?us-ascii?Q?RjiP+9Qxl4HOJjY0dfb6DVVyGILoQiBvrBYHeXOOSrXf2r1FhBIdTNnn7eLf?=
 =?us-ascii?Q?zZBJ9WDGswXMEGYuExTtGkGGo5Iu0YCApsIPdU0WVtYsAtS1RybaI2a+RfPA?=
 =?us-ascii?Q?Mhrp070qCtg9rwPG9Cu3PNwP5BjSmvk4PU7kaJUjPPaer0J1WqYoBzu/Recg?=
 =?us-ascii?Q?4RUjxy+ZHIsElUWz2Ln6m0LpfcXi8HgPb0hQY1afijSJ4P7dFZP6bY/JHXJg?=
 =?us-ascii?Q?XT1tRmm9pmB5uwZMhr6MrFovQXKwZnf5RcGG6XEm9bBLrOCq0Yp8HDuz3aWQ?=
 =?us-ascii?Q?LMoQVmlxNAITspjge49zOmWnVEz773VOgn3xZvI3kurhAFhAbjBA25DRuNAo?=
 =?us-ascii?Q?Cq8kDi8XBdnMFq9wlOMhoL1Q+3baXe8mKmmEeUprphQJdBVSJu4+/Uv6kcTg?=
 =?us-ascii?Q?GrUvYseemkVN/EcEbXJCUGoftMsOHnBOiPcgDwQitYjdTVn9ENdyhYs0ecGz?=
 =?us-ascii?Q?bBaRpsbkKgV7isNIdoV5BAgNyIDDpk7vCHIu663Un3zC+cm4LUNwOooWx8s3?=
 =?us-ascii?Q?r1jcokf+j9v82N9MnEAcIBWezD8Fr2JMo4WdENr/6KH9eiRbRe2wuQ+YsoNJ?=
 =?us-ascii?Q?zVbykGHYU0qo7AC4bZ7O6tCT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Tvb5axDyaS2H2kiDEroMs7JKPih38/uuEePE6W7yeZyYW4NkhEx8XDm+PQ2?=
 =?us-ascii?Q?bZ07FgXJrP2gEax5sKqxE1vc1QD7/0vP6PRmAG+KEGulOIiel7zAmXz7nSwA?=
 =?us-ascii?Q?UGHe3hFGp/LVcuYyTMKRyuNd46F9xrau+ccKKbSQCK1RnsWqV0KYm7XHShNq?=
 =?us-ascii?Q?SMc37lRJ9oU13mJy4HYzOJfSpF591Aj64f7Zl9tN37UNtE2bapFb7X+y7o+b?=
 =?us-ascii?Q?W3F5FrUyysgYv+ognBIoIy9JvnkfgbxepB+JbQy2ByHexvMavhrnOHBdhv+I?=
 =?us-ascii?Q?OEblDUuRh8CHZq5gb3Ce6DTFuy5qpRA459pumj5CW33Bu7YWIUWS1lQy50SI?=
 =?us-ascii?Q?ZvQrkbov+D83jjSq0ma/A/tepSa8+DqygfyOg/iXT0L3Zjfgvf//Thlwl+ZK?=
 =?us-ascii?Q?etNZ6zT3NbGcMfyKcRqibAU97+uE+iEhQ6moyYnyBXKQTY4ogckDuHHtbQ8i?=
 =?us-ascii?Q?HaEr2Pqoq0x5dX59JjMsonxOcK4XNp3yr+m2rLjaSf+yyq0/yGvXJiE6gutG?=
 =?us-ascii?Q?NTIEARb7BpnA9IHzwmUYN8OoOr+F52PxmPY0WtATfDfDXtTpNWs8ug1Bztyu?=
 =?us-ascii?Q?NFcJjITZIeKraZDx3IKq/VU0wmnzpRn/kHR7UmWXmG+n/am6N3Wh66EWK46w?=
 =?us-ascii?Q?UcOPLuXSahn+XoRI3pevYe8IkghV7C5Kr/L23/5b0odmgKaIExFfIB8agj+x?=
 =?us-ascii?Q?V5hzKb5MjhmOPYWyGUeb4qVSrA7I3H/lCmIt9DowPzZMBtNSkjHvTbi8EhpP?=
 =?us-ascii?Q?8a9iE+6XTT3csk+HAxB7hq+QpSsy83Z7MW2srJQS4s1CXauPgQ13wBxHplH5?=
 =?us-ascii?Q?3aX75wsjiZrf254AQ8VgGDtYfzmualChn6YKVB/JZVwIiemmj8KnknaOYWjf?=
 =?us-ascii?Q?NdbjRsVGnUPBEwknMnRo1MruweMnMf3aVLRca4FwXTpIlStY2R8npn0mFyPA?=
 =?us-ascii?Q?r6mkQskipk0lzq8atvDx782pwwjmmFyRgM0RSb1FRdNf3ymFGaAICtNt8aGm?=
 =?us-ascii?Q?yXp1adpKTf04VDEqahGT5h7EwbUlcjRmrOhMUBvetBlDNtWcgvcaeKoPW2NE?=
 =?us-ascii?Q?wmSA4pZcM+5xlyVR4jCOQ9SAvanZzwd/SkQJZfrB/iqarXate5DXZZHMZ2mS?=
 =?us-ascii?Q?4A9ZhCSlvrQQ0js1MqybPZi2v43kYVkG4gleK2oQIG+RB1zY0MhI5XbaPGlU?=
 =?us-ascii?Q?tWJThtXkT2LseeGC1jqVHrLcrzhONVXuJygjptfM9/pDnC3sgoEMet0RnDmS?=
 =?us-ascii?Q?lHHIvaLYpU1YDj2C1AIcYyNVOMUfzdNmfJv+zlbQtPQMPoxfKWRJMaoRpGl8?=
 =?us-ascii?Q?dOzqV8PS6xZn8re6T4ba8nfWhY6RUFdaY8dlEwAUlIDJnMVIpN52O0OaIXi4?=
 =?us-ascii?Q?LHWHHWRxGjknQNfT0FDr3KQ2kviZno3OukxkEcWgodjUivFQasy+cF4fX1fL?=
 =?us-ascii?Q?agdqWYSzMKQlWnGBPfQDZTxOH4/xaTqdEOK6Ki+W1A6ErKvX3jxcn2M5FZeG?=
 =?us-ascii?Q?7LeyToxl53BnHzXaF8wX27gILvWSyfWtWw50C90mhBJfigww4sCk2R7eLaA5?=
 =?us-ascii?Q?D+G55sCsnSNQSgbpmN6fkd3DpT6Lros5WVvCP+9C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345207dc-d0e9-4816-cecf-08dd019304a6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 14:21:50.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/jr5ge4jEOgbFMg3dJzPfl/NSAgccppBNdAJLiJqVcdlSqe9xVC5kutqKWVTSp5g6fN8nrxP2Tx1vKRWx9sVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

On Fri, Nov 08, 2024 at 05:47:12PM +0100, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

