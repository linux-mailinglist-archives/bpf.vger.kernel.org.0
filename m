Return-Path: <bpf+bounces-51124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA63A307A5
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1A3A72F1
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F41F1909;
	Tue, 11 Feb 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lS+ChZZb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012371D90CD;
	Tue, 11 Feb 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267458; cv=fail; b=d9htUVnHwFOPCYFQt1T061fe9nIvDdfBAztUen8NfeOo0oU3WnG0MvZlmwRQzqH3FHrVYv/6lDW8iPE15t3ztD8W0P4+ubvoQHw9t6IQsHVpWOk1mViDcHvMDu8POnB/Qj/C3GPExKURArfy6jdmNetFqRVE3fP3H2aVI0b+EEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267458; c=relaxed/simple;
	bh=pYcmvIccccUKlGbSb8InhIuliSgcgLAt1TW2xqIRWtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pvrcc2ZtPY+DE+gLcRNWWRId3tarFYnt1F+CBcQFmnOF/ehnSzz69F93q/Ogg9Dz4U+/t58Ifu7lwmTfrs118Dhf481vYc/xbylP/T5Ue70WIPsix6VcDVvVqSMKBnj+g24JzC6bzQ94p9FNZ9DtMyGRLPTew3qHJdeN5xepPe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lS+ChZZb; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONHztYX5EbecqBiLuiQnehiciFrnYhtm0mo5brLEa73D/NdKhFMqKO9ecN7dHbCsjUZl0ipUEZ+hCMxK07uEem79AdhE/5qxx5O9pl44vhU6xSgBcTAC37uMU+Pj8HM4h9UCScwju/+K4mATioNsAFRevMR4ReQsKvRBwAsXMpEK437bQ+igSELmyUXC82KMXl5vuosmEwLxIqH9HHBVW3JFsdH6/vtpde/8ry8Kj2HS40Hiu9u9dzuPxikEMUDuGjBv5/9cr+9YUIOszOKLhkjeSF9D3gn0xW/c6MMIhhwCtDS+yOdsrMxp4EGIOqJLx7W9TgggSIY3WpldF8rpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HXhle5SmLxRBRQ6zMU/GH3GNJyHbPw83MdLhMCueEc=;
 b=SdniuwgwWVDn+uWi3alFncStAj+WUToA0CT0jAYdn/ewXyb196xJg02TF5zo4woYUpI63fHdyw5YcMZCCszjAwLjyxV4mu/HJsMfW14cWfbhhYBeZwi93pNv5z1GzdXqJKQiY7GSbClMbXY5xj8AuhJixF6q884mdd3FMlRj9uF54MDSuURlLFCwnNh7q3IzzXedEwTT5pUGdEAXqTsKLUBptSSi/k2TE3y+x9Qk1kSCjDolq5dE2tjELF4cjiOLXf3Xwr5lS1d741VXgdAYGnIN+7XrD+cN+vpPzA0JoOMPmGWEInk+0+lr/Td+g0cU3F8lh+aBc9SZcOobyPXlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HXhle5SmLxRBRQ6zMU/GH3GNJyHbPw83MdLhMCueEc=;
 b=lS+ChZZbg3etaT08lZbSDsTo2ZLUIgJqlccj/nrh0JYnDmd0c76ysU87J+HEqTAr3CAjrliz85fHRPcAUnNhjxoyJnQb8d7uBYKuboNJC4tOvXzof47Eb11xU4zN6X7z+Ah63vFRby5Ca2npz+IBj+QsCieWVRt3Zn2ahfSMZO+notD9SBBonwRSoDocmlVDJtMpVLv+xdmDSD9UaVocS+rRwJsfU0h8PWyc4NqO/jDE0r0ahPoubaFSQWCz/5Qx7byHdY6SYOm2tIYcXlCIDzG/qWNkdJIvPl6bKbC6dQnSCsbf9xYFZoDGhu0IJRO5ziSxsBBkzbudtDTWuikORA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 09:50:54 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 09:50:54 +0000
Date: Tue, 11 Feb 2025 10:50:46 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: idle: Per-node idle cpumasks
Message-ID: <Z6sddk2otmAVrfcb@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-6-arighi@nvidia.com>
 <Z6ju7vFK5TpJamn5@thinkpad>
 <Z6owBvYiArjXvIGC@thinkpad>
 <Z6r9H6JukZi19dQP@gpd3>
 <Z6r_NZui9GibrQHY@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6r_NZui9GibrQHY@gpd3>
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eabc64e-3716-4b81-b544-08dd4a819344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?122iYSnbJT17f6b83C/3euo8bNNsye3FrRQLtaYz96fsNaDp0eReaApzInZ/?=
 =?us-ascii?Q?L2zFAkKJRSfyWLGkdW9p6QpLDVm+79hYCrezl/wAKMTwHsE8AW/eB+CzGu1w?=
 =?us-ascii?Q?j9duxtyoXY7RMM+XEPIJtX/7NJ6gOBuEIoiDQTr6btlv+gia7nIE2jr8Rk9A?=
 =?us-ascii?Q?FPza9EyVB221+/We5clOCyCCa35WQ5rFoN6AdBIzhePHzoFEEkn69UEaSx0g?=
 =?us-ascii?Q?dGqfondZGYH7ybgXWPWyI1hb1Jw9bNiRFQGXhs0xryhny/PX+1kgZtY4u2w8?=
 =?us-ascii?Q?7WxoAyMlErrL6PFx5Z6ESCRJovnelGLFQu5znMpRK6bbckK20lUJJk+3Mp54?=
 =?us-ascii?Q?ZT2ynJ4AoSFkG+U4nauRUsxXZojzU8Ejf+uk+1JW0MTLRS+DAwzgmNEpxBMG?=
 =?us-ascii?Q?R5uN/zqCxwqKKKYH1OAkK6JnOkG6yardBNcDphLNHmJ+GazBPzSDlx398Fw2?=
 =?us-ascii?Q?oQNkZIkS6nrJAMina7Jye0er50QXH2KsAaqlsn6//+IZEzdAe4K75WMuZNPa?=
 =?us-ascii?Q?LhxAdQnWM1TKMl0+m26u0tIp+nSGRLJMS9t91Gx028DFK9KFh+o2BwC+7rcv?=
 =?us-ascii?Q?D+tpE614j2IeYshx6nPuFb2I0+qZO7zcb7T652pen/261dcupB0ot8fsm0Gq?=
 =?us-ascii?Q?ZlG/+2QsOiJ+NcsHbN6l9w9xfOgi4EyoatXJ9fKEmHm0NJVZlWoGdiUhqwYW?=
 =?us-ascii?Q?U7g5j4iY0jdCb+MZ0hGSXPwL+p/XdY24m01TAxQual5q1aYd57Mi+AN7tcu7?=
 =?us-ascii?Q?/RWYDPBX7AZnSjvDSHgecCDmqwiSAIdAdFrcQ3uXDGlmHQ6JqA3f5PscoDms?=
 =?us-ascii?Q?4Cq/FD6TqchErKc1McYALizEumXLMi+S+YKp+2sRjWsUO6/NZGLziin1F3A0?=
 =?us-ascii?Q?O5nSeVzV/xpzJSGfGEJJWrsi+jyBrrHBsl6m2ki8vjMkOfHTXWN1UyD74EYg?=
 =?us-ascii?Q?vlqn7FSMDK0ltiDrTNHwzbG1WX2YLWwTHxxJKK8ji3/uRj1f7vhNURkUVYeI?=
 =?us-ascii?Q?ALGqWCZcZNbGtCyCTLY4TlW7KaUs6JjtA93ww4R+iYgxRIWc2FMx8m15uoRy?=
 =?us-ascii?Q?JtOKp5bE4XuQuMUWNRfibbbTmA0OXATm8vwjfFQs+plTIumHDPUps2wG+Xms?=
 =?us-ascii?Q?XT6oqRAzrp/my4fgDxY8xctXx0p0vQEZ6CiRG4utZ/ZxuThijswtbv1Olper?=
 =?us-ascii?Q?gUWBWG6zIWuE3G3jSkI9Utgtd1p26GybhtGnNzNrgVkZa5+F/NLraJm6DEdo?=
 =?us-ascii?Q?yIRxYyRN2w8nxw/tEDO94BnrA7GEACuAniMDVZl5Lvec5BMZovdZT/Hywkn7?=
 =?us-ascii?Q?Sr7aAHllzlL7WIGP5DWDcDll9FD29ck+EupBOYSBnqivabWFpWx/7pPE+NFt?=
 =?us-ascii?Q?/ShjqAsFZIbrO1MDg9J2loorVj/8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbJECftB/376v84lWcPEjdX7NeN5Z/m1CsyLnFjucvc9p+q3wxtkNewJW/wJ?=
 =?us-ascii?Q?BjdTelApXbduUVTLrzjbcqsiN4XQiEYLJZt+/qUY7SZGduvuiH5SaIhgdJuT?=
 =?us-ascii?Q?pdEU3c1x1MNpTj9wrq5GurJ/OTI8ukFCJcSPBvBn5r22KR2V4zuKVO2ZJCLQ?=
 =?us-ascii?Q?FqG4dXqnKod9ehNImkNSF8hTTai1Z2b6jcPneij6Evpe97PNNLn2y9lR0QW0?=
 =?us-ascii?Q?AmfXSyIwVStV+tna4NAy+6R/MFRxSbYhsGQRYXWFpf2CnXcVlwYm6E/C9jKp?=
 =?us-ascii?Q?4HIaMv5GgrKZNLqVCOBGmK8ojp/vtNlySUz/borGxRg37mGLLSl4K1ApNDQA?=
 =?us-ascii?Q?Ri89MCTndvcootHx0zLC2Pt9Bvq7Mks4sLMRa7KxIXCPeBrIQ5ryV9uJ0+mg?=
 =?us-ascii?Q?JPgkaAIcEXC3dwhWxvc41WB1klSc/AW28qYDz3S4LWtUonlpuDXJVyDDJPWd?=
 =?us-ascii?Q?6ntIVQC1wJ98CwEHI8jlA+mQaxSIp7j4bEcyi6UsQTzOG/pZS4QoMKjhXYqX?=
 =?us-ascii?Q?2WZxSX3vQ1QPRZCAD0U9FpY+9xyYFj57MpzVkIXF49LpA2X2WBmsBkPO6JrV?=
 =?us-ascii?Q?i2BCeI27GQan8VDSiASzE4bx45pgZdlX/FtbFCml9J7ONbRKsVlB0FLmltlq?=
 =?us-ascii?Q?kcWA0RPrevHG2y/PYvfO236rxH5brMkO07idy5Wyg4aNEV822lMUK1DfS82h?=
 =?us-ascii?Q?WFXBFNeWQC33bpx9I8EF8eOnmSLNxwFpnis2iRALkS8+SwelUcHi9tRzZ7Ki?=
 =?us-ascii?Q?5rhyh+v9A+ekWp8Di9rTt/SSnhKLwte0acvXX+p2GJK+2BDSUwSsEoNKb64G?=
 =?us-ascii?Q?SHKtO0jPY3DAlWSr0GsN0CvI9QYe01CPd56DG+2M/F9YClCnM5eDxXovInpn?=
 =?us-ascii?Q?6p4R40H+KMB/b2ZYn5OLwVDmFQWcIpmf8HL4KSRlPkW6/ZgCfi45UppcpOBG?=
 =?us-ascii?Q?SB2cMr3Q8n3N5hwiFgyFv2+WzZBrklMFdz7v0rMkdk+3DTO1HB0llrVwZJ6s?=
 =?us-ascii?Q?9jkY/ErOWV7VJkZqvp8sFni/LrYHW1Y5UhcxY4zVzYX0FmzI4kKrhNyojeBv?=
 =?us-ascii?Q?64H4yJmgO0aJC6WYSRYTXBqfpf/KE450dZ5mwMyXkmGvQtboMMcDwHrJovcM?=
 =?us-ascii?Q?Irq7bIk90AIC6bcssVBW/0BBT6/Ebnqnd2Slca7t1xWI/bTIgGUmm5WLv0i7?=
 =?us-ascii?Q?m7sNaUVtuv0Mqz6MgKzuCXeg5Y3jKzYUnCml8x52rUG9g7pKXDEFsCgS0Vtf?=
 =?us-ascii?Q?YTDzzLlxfvj5bsnZNZBgV/DUIHUlvCDtYtiX/0zdZhHCmkY71c/H3xxMElSE?=
 =?us-ascii?Q?akiIKCkcKEY47YkIwO50ji46SnS/vIS0dcw2zhSVyr4ecS6jFJvKHed3yQed?=
 =?us-ascii?Q?1Za3N3ivqjR+Fch+/3UGgUqy+ezDEVN5yQxMdcAckPtloEQ6Jgeb8TfQvlh6?=
 =?us-ascii?Q?UurB8UUDy4Qs66ACVL+R7O4d8OTwFBpBVZTh+gKE+OKkVz7Av+c+KKe1K3hN?=
 =?us-ascii?Q?pZ/b4QR4TGbfAlK4lSKMZGqgrj8ocwbEgfr01v1lmEhUWCriq6HHS/M/VqIV?=
 =?us-ascii?Q?0YtH9+biHJXMtHuXlLg7lBOEJsKkSLznY3kHPTcj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eabc64e-3716-4b81-b544-08dd4a819344
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:50:54.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P0w07ObTnVCu1YGEXrg5bwg3mPMcfLBtH120FBgIx91oD71ECY1WzFeH6dvOtyv8nMr2QXeXJg/SfJo+c5yZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421

On Tue, Feb 11, 2025 at 08:41:45AM +0100, Andrea Righi wrote:
> On Tue, Feb 11, 2025 at 08:32:51AM +0100, Andrea Righi wrote:
> > On Mon, Feb 10, 2025 at 11:57:42AM -0500, Yury Norov wrote:
> > ...
> > > > > +/*
> > > > > + * Find the best idle CPU in the system, relative to @node.
> > > > > + */
> > > > > +s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
> > > > > +{
> > > > > +	nodemask_t unvisited = NODE_MASK_ALL;
> > > 
> > > This should be a NODEMASK_ALLOC(). We don't want to eat up too much of the
> > > stack, right?
> > 
> > Ok, and if I want to initialize unvisited to all online nodes, is there a
> > better than doing:
> > 
> >   nodemask_clear(*unvisited);
> >   nodemask_or(*unvisited, *unvisited, node_states[N_ONLINE]);
> > 
> > We don't have nodemask_copy() right?
> 
> Sorry, and with that I mean nodes_clear() / nodes_or() / nodes_copy().

Also, it might be problematic to use NODEMASK_ALLOC() here, since we're
potentially holding raw spinlocks. Maybe we could use per-cpu nodemask_t,
but then we need to preempt_disable() the entire loop, since
scx_pick_idle_cpu() can be be called potentially from any context.

Considering that the maximum value for NODE_SHIFT is 10 with CONFIG_MAXSMP,
nodemask_t should be 128 bytes at most, that doesn't seem too bad... Maybe
we can accept to have it on the stack in this case?

Thanks,
-Andrea

