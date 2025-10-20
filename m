Return-Path: <bpf+bounces-71399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B1EBF1B0F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94663A7F80
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EBE258EF5;
	Mon, 20 Oct 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZY+TB9h"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277815A86D;
	Mon, 20 Oct 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968847; cv=fail; b=mMPs/fMn1XeDnFHMfYhNHDpIhrQF2scq+NsFs/R8VCCPtqbKx+RetRavGKSSiWaxeQKBRAHrqXnS3Anvnwc5a+0R+qxSA5r2s4nAQEV+mdP0fPh3Lm8JLEpMBj1sDUSbLq3awcWB+POKNUVPlUqmpNeu6FolAapNxY4BseudNn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968847; c=relaxed/simple;
	bh=BRukxVfXwWIv1JxoQEwygZL8kSI6KwpSkySXLOB91/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2fHf+wtNRn5FaXNCOstIiHfEXEdGZIA0NkYzOl8ldF5ea8L9PJtn0aswagrKSvvorv6hqTIl0FJW8DZkatHrNRrgRNF0BPaiEelcABGmCRoZXKa2jrff14+aNCm8KoP6IvI6MTF1qwyzsTOyXnvphxN64a/YVq3hbQ4zA4ekA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hZY+TB9h; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EADYMccwBLomXzLjWpS0ywsNA2ly/GVHx5hkntyCDWoyjiv7iC3Fxo/lNnJYjjmvrgSwElXMjK9yMOLcuM0eSoLdZcouFFDPy9JSSaBgez3kHw8n6S1y4HrwJUXDXVSPl7Dck9VoVpPBQjiBNkQScn2xiotVriR5FKA2Wih7kbASCSF/G4Iufw4nhyx3CiIiKY3nMeBccvGET0uUbaSN1REdCC/Y/gVl9Ko9LId9Yz8UAjOtx1vbih+flzqPHHQZUErr6QNnrEvW0lmqAwKBCvdbwZ2VhlukT4w1hb3foMlTxgcyP5jDWOExumwfIZTCTPfS/gG5uIKF5jwpkpInpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Z6uVtCLQ7Hz8laHono8r59zeFkImHMiIHiEthr/3A=;
 b=Jk1jZ3gtcpragV3Mb+GGSn6O+PVgAY3SIByOBlF6SQbhnX7wfYSgAILHOUJIsEHhT4FZJTs+r9wG5cksQ6mul+N1q5qft+mVJFpG3xGUAIHpizbOjMtxlKlWO8MPDZ/McRTFHj9draP9TpJ8wAR4bUR4/G/UU9FkNlaIiwpiF3a1+eaBusXGx0KBmTBXHWCjicCk4wbk9OfWs9zsaMuBS1vxQhjcvEVae9svaBLSnECCKAZEdLf1bRXgu3Cp1lT629tqDTzKZB3yztXNo51BzQm8ynKgTtDt8VaPMT0fmdfQMIP/lTCSqXZf36TRZi/DwsE7BS+DmcfS39V5DeWWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Z6uVtCLQ7Hz8laHono8r59zeFkImHMiIHiEthr/3A=;
 b=hZY+TB9hspmPkLPNqReT4k7DoeGrEWHC3ltSmUfK1a7GwtPJJwHYJIxXO/F9RZjO/g/ErIKXV/L5tggSAwsnpMMCnsqEMMaUjf+AdeHl54ibh9g+9p634Ttropi9gnPz81EAwgjEvndakYFeeOzAs+Y5avT6TXMptxmwuMJWJ6nz98lHmIYecyJhqRw6JRw5Bv2HVklgCFMP/ScVTJy0giqqWqvt1jzN1dOQT14Av+ZMchgkfIWb5KyiKa1TOiRhmEEVH/82nWxQNi81e/00SrCjZCUKP22zmmqjsKLDBEekoa47/FdnYYSzuifEivY0IkbH5fPdZdgPOrQWiWSQcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 14:00:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:00:38 +0000
Date: Mon, 20 Oct 2025 16:00:30 +0200
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
Message-ID: <aPZAfsRs0kxAypYo@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
 <67335454-6657-42d2-bf98-d1df1b58baa6@arm.com>
 <aPY_YHK-oWZp0KK1@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY_YHK-oWZp0KK1@gpd4>
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfc612a-5b20-4127-851a-08de0fe10be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lo8+Oicao/4qkBTDJheeYeDmH8RlWz5HNmpnlC7GODyyg+DPP7sL3ErAgLlk?=
 =?us-ascii?Q?3T3GPLiEq5TdCrnQ643uCQV4fIo30t7YSUGlRbJ55wZmLeeOAu8iNQVXxjxY?=
 =?us-ascii?Q?Z5MQCYXNYwlJ1ZrX54zl2n7JUc2XelEfyJH2mJqXXA7wq9rLph1Nkv7EjOio?=
 =?us-ascii?Q?AyVVSpfwuI8qSzsGYDVyEwXYrrMG2bJPB/ks1rcEDkm331UVFJ8q0APZtcKQ?=
 =?us-ascii?Q?3IDgjVanRxSynrqTTHWMfb2mBvB2RDzttxxRL7UYabdUux9ZJDPWbGP+eEJA?=
 =?us-ascii?Q?vd4vILuiKAqVErcNBqHrG0ogYpn9Bq41VhkVBxHDTiBoiOmBB00vR9hebvnK?=
 =?us-ascii?Q?GsH8j1of0Nd7FM5f8SeW+/okG3felhbKkfQ2ww3oXPYIEy3qrLs/N2hw8snC?=
 =?us-ascii?Q?jlmi+MbJKQaj7wY3War0rE99lC2bLsXOc7muOy7x1Y9P5v9xbcXdtDO5Q+dQ?=
 =?us-ascii?Q?VVRVo2m1hoz65ubzsK48bjykFFM9rhvTEpP42Iuv5kgRF/RVr6U2Y+nkYP9p?=
 =?us-ascii?Q?tHJBjRtmCGVSxLHlWT2XlEFOBLI+8ZqJM7g62fhxsSWKtAWx/abETKT8LunY?=
 =?us-ascii?Q?BDAsZfmcH15NfLeDFPYnlqoKK0Jv3LCEnRwqMwomFRjTeLcjcLt6L6G5XP9v?=
 =?us-ascii?Q?C69V445UwOUo06knW5rJ1u98AmOkhklbVocPK3s91TGpzRUopv4KETvMio7w?=
 =?us-ascii?Q?cgyfSN/WIQPrg8P/crIS2lB62Zfsxs9f3FDYPg3AQ0mhNOpsxSZN7F/pYPlR?=
 =?us-ascii?Q?dg7eKG0izL242eFjLz/9KmzKaOxDZs3bOs74VmuvYwNOX/+r668PXb8jRCCh?=
 =?us-ascii?Q?d1WMN3mkI73adpApIWTF9kvM0AHXmqTQJh+lKnPFWKKjPUFASIv1HKKzKPDM?=
 =?us-ascii?Q?xbTHlxp8D285mMm1hr40dVvdrsKqMNE5hZGSe9KVaTBQLzyWbVvhCWCr0qcD?=
 =?us-ascii?Q?k/c1k9crZaeeEnWCUjP586j8Qvtmw4J6nNMNRfu0jaSTZGgbi03bp3ixxU8N?=
 =?us-ascii?Q?mfWyju1VajAbQtuF5kV+k/cez+Jnxdku7Jr3bw6lA/xdZBAt2rEyHpGXEtGl?=
 =?us-ascii?Q?G2xYtiLBoC1bincLwJ6F5D0DqRgJ6m+nDsr9t0F2JIV3evLUUfm/LvnyqJMC?=
 =?us-ascii?Q?SftIXFX5t7BPn059i5IJpxu0YnOEhyd7gj20+MbojKm4woXooxq1MVOhgb4t?=
 =?us-ascii?Q?+VoUZVEs8x/XLIgXDwY47PezHKn0EkoYObi7OIpDZyI8QqT/kvsSvpZgHwxz?=
 =?us-ascii?Q?JhJXXqo5eNnl1hVTdq/hYM8bpz/rpxEpPH3/1Xa39nUAXvUZCoaGHwrUql1J?=
 =?us-ascii?Q?xNeLzUKj/qY68Mj+SepGXiII836t/AKC/tN0Qn3nBARp5efsZowP+OMb+vy0?=
 =?us-ascii?Q?9GKx9hSbZ43q+C117Z59yiQ6p1qQU85gZqD9O+xAXPVyjFS4RpeAbOqU95Vm?=
 =?us-ascii?Q?COX8iLM97rhiAajxYQ0v0nFg4Z7QZmJY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RKXnRrdfAQLqcCdVOVovSWExCqZqRh7thmHg34YwEwuib+uZKlBaXFisiKs9?=
 =?us-ascii?Q?GGs1TSLVFWDT4Wg33VGh0R7rfKzkUroT6H+qRdTPaeIgCp/L1YIzvEOXPig7?=
 =?us-ascii?Q?HM5pCVVTk7dYc1QqFvOqr4SmHfgW2fAtypW8lNsr/WZD4iZmeEYJi6+v2O+f?=
 =?us-ascii?Q?LFtbFOgyvbPXJ1VjvhXkDB/yh/Dru+ktW+TEZI1p/Ia4cBWjPEf5Zci30/0c?=
 =?us-ascii?Q?31OH6WJcXMsMouLJh/kzUo1wpru25oWafyAopllcjeAQ3IrY0DFGapicXgIn?=
 =?us-ascii?Q?WplcI+mPWQ3P37wpWO8mwwrPGmfyPT2ee1sVGMSD8B4+zsUEprko7/ZeNzlI?=
 =?us-ascii?Q?+FdP0yOTo1/+yuRdeSLxB+CBgw8VYeBKN00iw2kxiFLviH9PNW2/yfH1OqHC?=
 =?us-ascii?Q?ztQogwIkeT4Ph3a0ihsskgEVGIbIBAcYu4O6f2QQ40jaeb9FyMuL+FC1FkTM?=
 =?us-ascii?Q?3BDyDxb9O2vxlsXDY/bbEP8e7YGxh+YlekgCyCeBzplSpIOKQkcVQKUOi3m/?=
 =?us-ascii?Q?bffK6AyHNj7kKIlEp7UzfmTNMuq1lfdKw+AW/ekPAl+aaTkFJeu7GhoRXTna?=
 =?us-ascii?Q?fyCWwBGp+I2lFOc+5MwodnFoCe7j0GFtxEvOsuUiybifE91mfgdYJSEEx4Oc?=
 =?us-ascii?Q?qncrARWFPT+/RYsTUh+yHF/9DsbnS5LVEZqJ/MyPte7Lo1z/37BEW98T6vdQ?=
 =?us-ascii?Q?Ik0PNq/t8lp6oPQ74+j9k2yZoO59AFKaiHmcCLzvU+H9jFdCuay2Z9i9SxBu?=
 =?us-ascii?Q?HUTB+tlc4QokGqclGbaF2SHOnpWJAuNqC6IEZOpXW1oO8JgH1M0Lz12ExT0z?=
 =?us-ascii?Q?Nd77hEzR2F7gCvTodxQpq/Npn6FOuS0LrAAsxtL1VsubkZtTIRSbxGAK+2VS?=
 =?us-ascii?Q?jYfd6lqWNDeCXL3VR+JvhNceshqp5jRmwIN4SwaG1Td8YabzAleFgzr5379x?=
 =?us-ascii?Q?l36DWZdILf59EJs/VlfNkegjr102OYearmcgmYSNsuHzJrQK3wzIgUPP2XSf?=
 =?us-ascii?Q?W7/RRncFMK1CGSmpko1NvL+ukevvp9mIhJ/pM6BagQJwwYL7FYZLV47dE55v?=
 =?us-ascii?Q?oSmHbRpGwFECcTJufXaI8K/ufUeFoXgT+gb0f9dAOGIEIiGidMaHaccw5Wyd?=
 =?us-ascii?Q?/zj3kf0QfF5CgaSIn9Oyka1XIAOxsEnM8IQ+jezVuC3vzXrD8v3fMO/a36Vl?=
 =?us-ascii?Q?b6xrwWiXcQ+PFDajxYtwoWFin3R5wmGNExSSHT4/py5Gbr6S9vchKYELW8Si?=
 =?us-ascii?Q?Q+sx70vHeM61EJUoBqyX68XJcCZm0mfIRS7vvXM9/UAHPJuoFuX4M+Dem1NR?=
 =?us-ascii?Q?0YV0KCN38jyPi7UPPlZSQPXqBKBAAbqZnYiVtNgRGgcXdsMRwYeKnO1gvGe0?=
 =?us-ascii?Q?+Ag7Oi76YWre9WDXq0Uy8ZzjGkvVQ9FTL30QzcVTcu3q8FTillr9Ewb18miG?=
 =?us-ascii?Q?6ZqJM51HbjZWcXICBLndwhddve38eRM7OVDaF9Fd8sNpeJd1yIDYtC5g7Cch?=
 =?us-ascii?Q?UeMUSk36QubHEAbrqIo2xdgYh1PA6clKVqZAi4wlgVyzXdwcSQltZTqhRfDe?=
 =?us-ascii?Q?pjwc/waAcpnm+aqk0JEPGydS0bH2KkAI9K+UxBD+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfc612a-5b20-4127-851a-08de0fe10be3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:00:38.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raPdb8ZYNhEDxMeHr6e5sUyab3MNovgrZtl3VyrMe1yNRi6x8oixrGH9EMFbgfder5sPcSSMsJ5KmlIt4zc/FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

On Mon, Oct 20, 2025 at 03:55:52PM +0200, Andrea Righi wrote:
> Hi Christian,
> 
> On Mon, Oct 20, 2025 at 02:26:17PM +0100, Christian Loehle wrote:
> > On 10/17/25 10:26, Andrea Righi wrote:
> > > Add a selftest to validate the correct behavior of the deadline server
> > > for the ext_sched_class.
> > > 
> > > [ Joel: Replaced occurences of CFS in the test with EXT. ]
> > > 
> > > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> > >  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
> > >  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
> > >  3 files changed, 238 insertions(+)
> > >  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
> > >  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> > 
> > 
> > Does this pass consistently for you?
> > For a loop of 1000 runs I'm getting total runtime numbers for the EXT task of:
> > 
> >    0.000 -    0.261 |  (7)
> >    0.261 -    0.522 | ###### (86)
> >    0.522 -    4.437 |  (0)
> >    4.437 -    4.698 |  (1)
> >    4.698 -    4.959 | ################### (257)
> >    4.959 -    5.220 | ################################################## (649)
> > 
> > I'll try to see what's going wrong here...
> 
> Is that 1000 runs of total_bw? Yeah, the small ones don't look right at

s/total_bw/rt_stall/

-Andrea

> all, unless they're caused by some errors in the measurement (or something
> wrong in the test itself). Still better than without the dl_server, but
> it'd be nice to understand what's going on. :)
> 
> I'll try to reproduce that on my side as well.
> 
> Thanks,
> -Andrea

