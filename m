Return-Path: <bpf+bounces-71398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59EBF1B09
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6C84F6C6E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4732F658A;
	Mon, 20 Oct 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B+awK0hd"
X-Original-To: bpf@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE71246768;
	Mon, 20 Oct 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968558; cv=fail; b=uLdE/yfj84n/mJ2CrDO7ppMB4ImnFcTeBPUzHDw/iDEdx12IV/vMuBOe2x4TXC0MvgfMgbAnnklydhGnfw2IgSM4fFjbpljg5sG9Vgkk8KqFvdeMmDAAnnoZfZ1IvqgIRp0hzpAzwGWlNlG1fyd+haoMrn/DH53ZiP+Axn6ZMao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968558; c=relaxed/simple;
	bh=AqLUjR6GjWBuIw7ak5mmRejwVBGHpzAeY3xEK6Ra99c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DLrKBfzj3juzH0HK1ESM9hgezhJQ/sB13bcexsaskyLAyQ/7pvDzEfvJDad9ezKpVymF0WuwKSIGEQXz/utlyD2KOlV+lLON7eW6WcebljQ5t3IjBQcaWoTCU1Do50A6A6i3jNUDRoo2CsuGKwtTJexgAd76JhCPfhoTpZSqjtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B+awK0hd; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nio3Gv/d4x/dWENWlMGlRJXUS43RqMpRfEVaHCWzFHF8Esqm1kmSGZr2ep3Oki71Q0aymGnl2mwjdROaiB5Sth+N86TpTrHV4nX9ITFQzd8AbB5tTA17g7xXQzVofMd1C0zjLEKoUopusaWysVtCSNgg3u93j+2ksRvbPAKNHG+6F9/xe7jFCSQDDjY1J00unIsT7DhYoJZk735q1RLFv5ZF98JHSMcehQMRFO1d6y9+4ThMHV3CZbW3oXdVGSjPSr1K/BJZzemEbeFVO8prXPJK/PHzkfwgMACgwwpW+igpICoWmu1w9NoMjy0FudMxT3Pz0sQdXwAJ3phDlddWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv34eZMvlqF3K2GHmnpEc3EM1UWR/R+FMF9Gv6J3kco=;
 b=xJgSnqPkuuPUwE1TGIfWCcUDw1oOGE+1gp3BVjSLL1NKOd64yvoQJg4Q8yirKzlxUFLwtDmN6j1+9SN2rHieVaV/FuKEgiVNFtQtX9trMz44ROLEE7YYeedpGxk8wTQlNCB0FjdfojUo5dbDp23Bj3lhrOO1M3MdzP2nRVUr2KM3b9KPW34JXyogVBKRQg48i+o5EZdwGXUHELZBwMX386jivHTtZkqYty9vCfWfEKXt+pBHPh6ex+iKb63q5exDYf8gfRfA2HFnMhz+JatS7KQL+ueFDBIFJ8GIgt7keHpDxjjQsfi4LNAHaMBbes7ImjomPLOo448DkUNPM8zdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv34eZMvlqF3K2GHmnpEc3EM1UWR/R+FMF9Gv6J3kco=;
 b=B+awK0hdTsgaupwoy+rtfZSLrgdzkbIOYrwuK4Vnd503DpSam6Hlcc4j4vTz1DGwavDNpL2EK8afPC87i8rsbP1jLIWgl+d4ueCeCmpOhUdUpC6F2mw6+Nwced8sfIRE0Z1wTETFE7nYzvclC47BAh3Y2mURfneHckYuMavkrsko8nVTf3OB+5ZG+Zwp1cDCi3HI0CWTKB3AYD9ZSDydl5ukjf7SE4S5s3czPIv1NeLfRyYeBz+w9wfQxPIyuVBJlByNJDBFNz84gxJz8c3Tt75v+JOPbBYwee1HOiz3WF2ImQAnwSX9TeLTnQcjAOPv5kMooknoZJcyfvZMvnGclQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 13:55:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:55:52 +0000
Date: Mon, 20 Oct 2025 15:55:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext
 dl_server
Message-ID: <aPY_YHK-oWZp0KK1@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
 <67335454-6657-42d2-bf98-d1df1b58baa6@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67335454-6657-42d2-bf98-d1df1b58baa6@arm.com>
X-ClientProxiedBy: ZR0P278CA0089.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d09bbd0-bcc2-4215-18da-08de0fe061ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ozleiUqkzrbAU7aw1vi7uQ4ovyzQMSH7XM9RCJRvUTQ5h378BW7W3LYpSzin?=
 =?us-ascii?Q?KEfqgr67hXIetlEISt1/oEIU69ZnzmXkDIuhwWgTfozeso47uHi8lbIC2Cmj?=
 =?us-ascii?Q?5bx29kI/SwVWU4+ZBpPZnOtp+Wi1rdgOqYApJd+yNt61wK4NetS7uyNdXx0Z?=
 =?us-ascii?Q?b5GYGWoBSCQeoR+1AVJ2I8Pc1/PWwFF5056ROdIq4GDcKATmqEppl8PQeAdU?=
 =?us-ascii?Q?LpELd+bip3XB6lDBLoi8EsPjpXWNa4Q1HYKlf+dpPs12uTkHAi1yNXNFE58/?=
 =?us-ascii?Q?PT10OanU9RMVCMaDtYud3EOW7XtRPMQiet0BjE1RZdKbOhHMhRHkvagKwKT6?=
 =?us-ascii?Q?deayB45aMBisL2FqMncn0L4czEa7kgdf9kiAz9TyfWkKtFaDRu7FFxSzdi6d?=
 =?us-ascii?Q?IAeN3k1ggmFrgk9NmKDL4PIfvLN3tLPtA9s5T0PpYrBshm25rpERD/mFCb7q?=
 =?us-ascii?Q?1II/ZnbsD1xCalr7qGtyqJoDGPwhp+33fAGGOP4lKWmgcUZfDTkh0OsG+tAK?=
 =?us-ascii?Q?8FC1bq0sJyMWwZlCVonymgcStCrKpt7e0wRjo0ayn5VzK93ZT/H8PTcVKN3q?=
 =?us-ascii?Q?JQ6lXiNXGvHxlgkphSynnTKa8adIH4YR51OLML2KzvFpNuDEO20i1bW5PT7K?=
 =?us-ascii?Q?ne+nR8eelSIno6AkRgiEw+7FBVxOYGaTh0lFJhDZ4PhP+NWr6HVqqk+hiS4d?=
 =?us-ascii?Q?SnI6sHkwBOb85Q0w9heWqyq7p0dPVNIBUfIBNiy9ycMZ/xlBtNZm/IqesU/4?=
 =?us-ascii?Q?DN2WzdaE5CWbleitrg6zRY0s0TVvwlxy7hQ+VvDq7GpmhtwT+Pon/edfqBfB?=
 =?us-ascii?Q?caq4Q8PUdcwQOCrbpqESUyARessr33MLEBf50NRhYveuzksDR1oRAt37o69q?=
 =?us-ascii?Q?/rQ9X+qOefcsOArWU0yTs/9kbBFXexuV7pF+3ysoKEpY5QNG1xMulgEVH+Xj?=
 =?us-ascii?Q?GQCTg7NLhR5Yj8Q+Rq8C8LOuIsz0iL2/vL+UYcip3B28ZhNaO/98L8UrwzY/?=
 =?us-ascii?Q?a7HCai3J2LvBg+9oYeQDaeUeTKwz8deG9k09rYkIzFkkAoOxMulCoI90fPyE?=
 =?us-ascii?Q?YGAfTlx+/+0GUzAbOV/nDH4A95VSahAZAbJhCeeir0hrqvBbnsXwG2pZrNNI?=
 =?us-ascii?Q?Bt4vM6C0+uYfP7BvxJe/PdHp2vWwfRVYt6XEZNri/EnIsdlY/3GtsBOXLerZ?=
 =?us-ascii?Q?TOEtSPOvjPWsMV9LOkjgfxoBUf0rZBXunrxJb2T7xwcobeBoY4Zd38I8M2tg?=
 =?us-ascii?Q?5QgEDzUTOsBeQiwXERE/IS7j4xt3EaF+iMt/S/bcCTPDawA5mdDMLw0Cu552?=
 =?us-ascii?Q?e+KtMJaRWvoDUdniwnQWZsYVqd881Bjy0Ihk4aUL0qi5rDiPsqZJ3EeU619T?=
 =?us-ascii?Q?T1haFFWyvmeYMQQdRlcR6nH2ZW4HZEcQKqNAv9HtvPVfSMBOpl7Qyx5pJzc/?=
 =?us-ascii?Q?nnaL9t3y9xArvBKnkv0S3WHGCKdj/6bd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s559qzRfnTioSjviF2Zo7v6iGKKVz6lsOYMd5ZMI7WdJu+XIz2qQc28lnUNt?=
 =?us-ascii?Q?48dfTqkj9yqORnXUU3KJdXncAhubM66EknTinWKmYao9qj2Y7XSVD5RskPlC?=
 =?us-ascii?Q?BeAf+zoTupLmwGXy/ukkiXzLhFCHE1dY2rcEp6nGquNnvV8ykA5m3TOeKI8R?=
 =?us-ascii?Q?4gXvVqDNOJu6cJ39vRtgyQNodruvFl58e+7PXt2eAtSpwQsNuavx/zEdTA6R?=
 =?us-ascii?Q?J2742tp2zJ5yAllyR+qKUxii5++AuTEFRFRm8MIj8iYflE8d7EIykr6jMuD5?=
 =?us-ascii?Q?U2SfQp5nOIYmLGge/syOnwY3tDLuGcGjDsvHprbnN98QW4LZDVpiIaOgaQk4?=
 =?us-ascii?Q?ZjnfTFvZGf4XS/B0l4mmtZiU25WlGNmQiWXWiA0t7JS58BwoEk3Xsp4Bv954?=
 =?us-ascii?Q?AkNLVnRtARwW3QGTS5Bz7vSfWH/z6VbsebWUejyOAVp5PEj/zQXLVJPrASg7?=
 =?us-ascii?Q?VCT94uDeCBBCvEHmWf2MLaxECREAFiKxgP/P7quixaqrEWfF33S+Ch/r4OEi?=
 =?us-ascii?Q?EeQ4++CqhshOmoOmaDWA4IYid7XAvQsxQwg00oW83S7hyxadpGH+18nSMuqd?=
 =?us-ascii?Q?NH6m0uC1EkwGS6HUJeKNuRZwpAfS1Sq78kTR0aLipaTvYXdQdg/+Nxuz1at2?=
 =?us-ascii?Q?mk30bzWWsK80U9aEFVFvCxW4ORyioI9VQPzrwKJWeBDe5VUuTiWuvX4VWY0H?=
 =?us-ascii?Q?O5mdTCmE+Dp+DQbmMGmeFGNdoUPTGcJxYLmkjU1ENBHCPzMfqu/Y1MjXUyGl?=
 =?us-ascii?Q?AycZQtQFQuieBly4Jvq7+/lVGwIhb2wIW0DsdnGPzvE39hFRUpEN7b0lEmvG?=
 =?us-ascii?Q?GtbPx7wXp86ofvqVPUftg5mnZbxCvuhEJuDtoHN2yuLtaepjiAk27jc+4TGs?=
 =?us-ascii?Q?HLHLtowKgJAURUyho1D6a9Up0+/5vkGBcJntrTIEcWG17CwtGTkoxpnV1at5?=
 =?us-ascii?Q?f0xlODWf5dufUUj+mg2kCRju8yvaBjprjZ4DRLgbbEgQlO1NKDK1CZQnnlB9?=
 =?us-ascii?Q?KPjsxEteOxGnkZ4wT2WWLjvwNb5E6ejqUvtbGkNW1LVTrHpAsawZDL/mNxEQ?=
 =?us-ascii?Q?31rnaSOzzomvmMhxjCIv20lZ8wRQG1R2CQcLKy2miJQE2GROuLC29WnHv/cM?=
 =?us-ascii?Q?dkzsq1zAtA/YeD4W9wf1X6AYWHKbs4LcteRCnDDMrSKgb8v69+CW118Rw8Rl?=
 =?us-ascii?Q?rYmaXhs13Jk6OJGUX4ljTgs/Vl3sqD281DLJHqKycwrvmJAbAc8CoZ1uxN2e?=
 =?us-ascii?Q?frARZnf9M5IQnnSgxueNwhVgmBysNJ77twnYokEg0jaTScy37fU2DPVGIcNN?=
 =?us-ascii?Q?dMJvo89UqBtma+7Qx3d7RndLzdbTEnnD0PmKURwKC4/3hNa1pS3VzaoMtbhC?=
 =?us-ascii?Q?Q/Dgd1MRspISE2uqC44RqUzZS8v7x9LEqmiZQsGb0kDxmsqQ66ab21NSNY70?=
 =?us-ascii?Q?9QITF4XaI8XhicQ2iFc7JSMb0iMUBqDvByYc4afMQ/HMe7rgGux92XOYNNzt?=
 =?us-ascii?Q?abReqorgVIUkO2y818VsFFueHfgSDr/nCeoGPApQ3zUizCVGKNsT9Y3LYLpP?=
 =?us-ascii?Q?OFo+wpanU7t4pyVg8BN8S/QZv6MoDGafzZNSYzTo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d09bbd0-bcc2-4215-18da-08de0fe061ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:55:52.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuAyEnVHceOuC58GiLeS+k2fFKwQqfiA5emBC6JhQ6O7RWmkjUlTva3SJiyCzp61p56/Vjrrlf7VTTXE+mR/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

Hi Christian,

On Mon, Oct 20, 2025 at 02:26:17PM +0100, Christian Loehle wrote:
> On 10/17/25 10:26, Andrea Righi wrote:
> > Add a selftest to validate the correct behavior of the deadline server
> > for the ext_sched_class.
> > 
> > [ Joel: Replaced occurences of CFS in the test with EXT. ]
> > 
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
> >  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
> >  3 files changed, 238 insertions(+)
> >  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> 
> 
> Does this pass consistently for you?
> For a loop of 1000 runs I'm getting total runtime numbers for the EXT task of:
> 
>    0.000 -    0.261 |  (7)
>    0.261 -    0.522 | ###### (86)
>    0.522 -    4.437 |  (0)
>    4.437 -    4.698 |  (1)
>    4.698 -    4.959 | ################### (257)
>    4.959 -    5.220 | ################################################## (649)
> 
> I'll try to see what's going wrong here...

Is that 1000 runs of total_bw? Yeah, the small ones don't look right at
all, unless they're caused by some errors in the measurement (or something
wrong in the test itself). Still better than without the dl_server, but
it'd be nice to understand what's going on. :)

I'll try to reproduce that on my side as well.

Thanks,
-Andrea

