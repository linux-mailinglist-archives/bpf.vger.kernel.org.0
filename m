Return-Path: <bpf+bounces-53537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F9A560F3
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91DD3AE2B8
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 06:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEB1A2380;
	Fri,  7 Mar 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/uW3T9x"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FC19CD17;
	Fri,  7 Mar 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329332; cv=fail; b=QW9JoEVOXaBIgiTWGkqv6AwbLZifel39agH5yk9peDFo47bZQHW2MMNvzCFldFnviUfvBsdQ7Eu4cI+hOj5S5kFVdUdGUc3N7Cu6VOkr5nanBd7sXrkNiKBqWejXDXXgY4QIJ4E14r+kIdSuMTZdNZoQWPEjpLTfccZ9SbjkAPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329332; c=relaxed/simple;
	bh=fTx+Hs1kFVXxA9hCyKMudTQfHl3yjsWlFsT/B2AETy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mU1yn35J/hmvzIMQglwq4O4pchFPzO82Gl5WTItW2eve1pe4QJ38om9ehYOLsRBobF4hDU8HFVDa0rs8g8iQ5VYoJ6pSTgl2ZE7fp115L5dQ7AdlPSJB3bGasS0Ijtnla9NPyJLMsr1DqGj8VTJa03BopwrsQXw/qSnfLr7wJ6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/uW3T9x; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5EYiothc6Zu5FH+d7HyEzBh+9kwW1BTGqWRwY3vONy7vW7GEJe2WMJdV9AFOAzw/zOyWfOg///DPuZ4SQl5psea6xNVGfHgyTxr41q49IZKnEfV37TH0MHyes8RnaiofYCksKHldUaYfRLrn6eZ2o1jz689sNu11dk9FAFQGeIl5fActMlsoRo1G1Kp1iUKErcW8XFxtQVFy+Dy0TM5rZVn1F0/ufBFQI3Wo8B8kNpqEEgkiNVP0L7lyElZBNkVK+Hg+bJnUaPn8FP6BKgm19irnvntCkl8Z8C8mKyCuU/4UjPnKh2i+nhIXYL71EQp2sHmz9Yh6usu9C8iPxaCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG+v5MPo+u+657NPm4cxUJSEdJZvFeoSyH2SAxmFkyQ=;
 b=rE6cRizNfPWCpn47W1M1Jd5FiWn0GEUq/6WUL0LpRNcfpic8uQSy1PuEC3JUye3fGxF+R+uvrHkFrGDOm+Li6pZ2mPdtHfpBt2ZZw/vtoOHe0O7WUISp4j4Ml8oCeHUXkjdVTC6RiZNA6+vKtfYJ4tmbalsnBWubxuBYdBbK2kUdOlmN/0wmflyg+T6ul07wF0WtMfHr5ekes7dSoypFAtE6ewcVx5QidNSs70MIJ+P8eJLlKhPO1mzvkY0gzVh5DL/umJ8VDEYwPYNLWRiK3cRY0gDdlujiGO0chvyOEdKgWpFUnbhzVmzENKgQhYm6yYpb6n/mdWnHx4eDc29XzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG+v5MPo+u+657NPm4cxUJSEdJZvFeoSyH2SAxmFkyQ=;
 b=s/uW3T9x1caF8im1Ea7y31esOoidA3wt/cVcFev8OogpBycWjio5CANgNBBLISQ8nwWNDXRT8Ze5U4oI3+Xlb/Z9a3XDKhmtob+3SY6ZnGr40dulmfdcU9PDrvi8X32k4i5RqXIPNdCc/zCQ77P0ytVV0OJ/Vzq7gehu3WE9L3/K6cDJawQo03HlfNOW7PKJLWMwOdzhr0867N2JjDDMVuEDioTPMjkgjV4FgZp5hmKxblTVjDFz5Cto8AJ4g/9qA+oNzkUPTgg3DMuy0fMk2ZbgNGCLanOs2HxraVYWg2VMG2xwl38SOWWiPPzJNSAUbvMaHpq+ZZf6HkOfdztGiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 06:35:27 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 06:35:27 +0000
Date: Fri, 7 Mar 2025 07:35:22 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched_ext: idle: Introduce scx_bpf_select_cpu_pref()
Message-ID: <Z8qTqgrMmFeAD4yJ@gpd3>
References: <20250306182544.128649-1-arighi@nvidia.com>
 <20250306182544.128649-4-arighi@nvidia.com>
 <e3d578fe-5be5-4db7-8621-798468faee03@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3d578fe-5be5-4db7-8621-798468faee03@igalia.com>
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaab73c-b28d-4bf0-a21b-08dd5d423f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/GqDbwLPr8e24MRhaM9V2kMAu5FTTtlgR08s3VFyY6T74Mhzcr2Ti/7dyXs?=
 =?us-ascii?Q?8GwUw0OQS2uPfSpNUr2DzB6RUWH0+B8i46zRXRmqp11TZ1wz3DbEZ+c5R0Ty?=
 =?us-ascii?Q?E4armS7+RkSxLdvI9nx4LwEBRz5jOOmMYQL2ZVwflU9fqPOaMefFdXD0FZ/J?=
 =?us-ascii?Q?auPX8AQLQo0lYGamgZSk4PKph2YP2xCSD8wHu2MCRb9vYVkl29KOlhhk71oZ?=
 =?us-ascii?Q?z6GGBO4qsG6MLHhT7axkyFXLc97Q48EpgG68/K7w/UhQ9DQQmCJ51V2bPW/R?=
 =?us-ascii?Q?mWNeB5zmZcKKfyXf2Sd0zEjwb0JQC4MgyF4FCMa+0aB1WQ79NANiqTqf2o0T?=
 =?us-ascii?Q?voi+fycEybC6ov5aREofuMpN49A36Vu73BKgQHPd852G7GaQG2/EXy1BNR3H?=
 =?us-ascii?Q?yWj1QTp/IY1izX0kehzgTdk/6T4YrQLLHg0tsWpKxvHJ5DfesnBifIugZSI6?=
 =?us-ascii?Q?ns5GJKijFIRIdvGr6z4WcaeM5qBtNdYSsBatW+oUKwyE4k8IOAg3cFHBRn+Q?=
 =?us-ascii?Q?InOSYLDtIhraCi2RIHJnxdOYxh67Je5NhuoQzb8j93ie/5xvQmSyzHMdispj?=
 =?us-ascii?Q?Wy6OlUbxh1n3dBmlQmrNYvSCo6d2dxbDIMEsLgA37cs2dGOffCywz+zlAgdU?=
 =?us-ascii?Q?EOGW7kZCCm+O40P0JbHIguDsVL01ZNfQ2TJlIrV9P2vAczjeD1rIVjLhCCPC?=
 =?us-ascii?Q?x3wzcQoWL6YBHOjq1PU3Hquv/bjCBKKYIPAEdg/duo2NXjv+3ARfIf6/epIq?=
 =?us-ascii?Q?SmizUb3xtgmb9PDKhZKLySBr+OuCxjl32uBeb4tZwqYDnKavBrMmX+bKXchm?=
 =?us-ascii?Q?/9SgfwkIZCvt4IoCBSxROlxph0tqb1OQ32EEPVDMmsb/nwOM2vcvLdTbPZCz?=
 =?us-ascii?Q?i83BOfyBnTQaEYE/yaLtN45e9HEAhwgH1Z3qnYp8dhmgbff59uklyt/05Mt+?=
 =?us-ascii?Q?pwawiXDnesCDJISej4iFaBXmTsY3IcQasHQfucsb/F+AOJBpgduyTIAR+DJn?=
 =?us-ascii?Q?RQ2gtjIOQZjr58f6o/wyumktRf0t8qpc97UBdphW4fJUDpG/x8yhzfanVq7l?=
 =?us-ascii?Q?CXUscymD0KKkd5AF6843MtmSsdAaghYz/TMHCRkKsDkhSdNrHqgl0eMllREF?=
 =?us-ascii?Q?tXbKCe+WJd6wZxQT1Wlgsi21joBFo+HIAUGhIbdJ0/0P66o9PmwARDCRRxcH?=
 =?us-ascii?Q?uNwEA7rKoz/6V08/vjSDEvIC8j8q+g0MEzyU+nOkx0DNXDSgAqP2sLBm3mYo?=
 =?us-ascii?Q?J2e481YYPj4/uyKcCsYrF32JZA8roSwYYPQ0F1TQ3v4F6gZJsRavUft+vhvj?=
 =?us-ascii?Q?4Xo6R/jDDhnlBDTl2ufZ/BZopVKqBeCsJt7RPZBRw/hbJMdPmstDhsxT9ptK?=
 =?us-ascii?Q?zIlCDGgYWSz+OP7Ee2A7EYzSZRYq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KAEfeULMD3FJabzeb6p7KAxEAN6NK57rroBtIit6TKcg9G3pUuRziCHTBMHL?=
 =?us-ascii?Q?6hgrI/EowfXsQ4yVI6vbo5OCP8beHHr2xU97UrphGgjkqJ9MuGT2vwVCO/DY?=
 =?us-ascii?Q?PQaixyEjMhKo6ruaPhiMhQxRRXjaq9ylBPz7ss5pf2hixV6vWXcdgPj7H+ve?=
 =?us-ascii?Q?vVwcHSXlGNHW5UajPBcsuRWkjd0mmw6JC2Gl1xo4/VEx0+tJYT3LpmiyFWwE?=
 =?us-ascii?Q?c6PwLIcvVhrNQ8wFt9QFWoRSojs82tBKOhGOEOBsvMkaBrxk1zcbRu/O2Hp2?=
 =?us-ascii?Q?8RS44eYS3fp16bH1Tfcf2TlzZ8/woyhiQTPyF+tFe5kj/yG3ZcdD5UD8Q8hI?=
 =?us-ascii?Q?+Q3QPeZHHPgRR842Ak3305/eaHNaQQ6Y9d/cWk4B+YG2E8jo3PzCyZ+iT0UW?=
 =?us-ascii?Q?5tNTFQlphPkz/aZcPyFZcc72TwobXB0HUJOI+m3jUwd+fo3ATLwiuQFDghbf?=
 =?us-ascii?Q?yHNklDtZGqtcr63uzLTBXMjclk7QX/llRO2l7wOum1aBUoqLwtKR0o5w3+T4?=
 =?us-ascii?Q?/rxTyY21eLG+w/2AfzuVWVV2faTkzd42tP5AggicL0TfbarmaXEeBZRHvWny?=
 =?us-ascii?Q?w1esGqIYckq4VNGNDtydIFVYAxZyDFG2Lf3g946BNPRhXf7dJGALDYyuRXHv?=
 =?us-ascii?Q?R5fEKK0BsNZXcPR2tT4hlQC1r1HYL+6JNx168rfecOQB9JVXLrAjFu/LXBoP?=
 =?us-ascii?Q?x5Dudx1mu9xFh3HJ9yFGfBJ9IxHGLGy/NHxoVpat8vpoSYzkiYeNjtSlOubH?=
 =?us-ascii?Q?xJlkcUcm1BhrCQ6xKgOCC7fyjg1fUdk6l+H6YuWZzL/8EIaI8vtCx3QknAUS?=
 =?us-ascii?Q?0qX/muK/jdtEJiegiJr7/YCVHKe3mFQawT8I0FR0FXxfAeafIXKASeQX9Br2?=
 =?us-ascii?Q?uzdo2IdsDNxL88Sd8dU7vK0ZcgCUFwv+F6csxSBFWyX0ojp/8MHRfgExfWPI?=
 =?us-ascii?Q?4eskkklP1KWbemfnD5E3fUUg8dAUjnHb4R09Qc47qfi9EByFphX5XXOr3Amj?=
 =?us-ascii?Q?JI7fRhmrHKXw+9lf/qEWcALJiskVPO3LgqYltlW6v5M9pQVbDWSxDYx7Kzk/?=
 =?us-ascii?Q?1l1CEXtLCgrnFaFlazkUbREhHn1OfQa8CT1N2Tn5J5QITJzH3M9UBmXzerfn?=
 =?us-ascii?Q?7w7hw+e+a/v0QyUkmfJpsAqo6F+OMNNG02XzPF5/zo87ZnHWiXZLGLLfTH1E?=
 =?us-ascii?Q?ihrj7zkdIIYDf/AEaV2Cbxxt5sSArLrCykUclrO2NZS/lkcMWDZmvZgUeTm6?=
 =?us-ascii?Q?8AnEHn94/av9rXSNujtz6/8V+OvNzQ1oLufyaeeUQcyVJAe+ci20Ic1h/zCi?=
 =?us-ascii?Q?vzl+lTZuHMosqrfekEyHRtl40l2vH/YU9fNfYsLzQdRDqbsW065QFpmltdco?=
 =?us-ascii?Q?4cmmrzKP2gNLZHdWQWRAA0W8Lj5IhSczf0CfrQOCDM1DoI1q2qoRRGpd+wk0?=
 =?us-ascii?Q?VIBJUEPofWBXyrSqz0ScQOLm6bv5424KhBYaKDQ/dGjgSHKe2or9Zy+GEOEa?=
 =?us-ascii?Q?xHGmSFomOId4te2Eu7CsL8jsIIjCxz2FEC4eZHq1MWy30VgEgrkdGcSfpsWq?=
 =?us-ascii?Q?6bqIT9vbWf+Ft3IAu/pviljrAILH3HQMfd7ZR0Yt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaab73c-b28d-4bf0-a21b-08dd5d423f8a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:35:27.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueaxjOUuFReH2BJHpYqy0NLShr4rvpLj+zNrgmCdSFCP0kFjBOOoR2zsZsL+4ASCYYNI94yMojMtzYcHDWnYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

Hi Changwoo,

On Fri, Mar 07, 2025 at 12:15:04PM +0900, Changwoo Min wrote:
...
> > +__bpf_kfunc s32 scx_bpf_select_cpu_pref(struct task_struct *p,
> > +					const struct cpumask *preferred_cpus,
> > +					s32 prev_cpu, u64 wake_flags, u64 flags)
> > +{
> > +#ifdef CONFIG_SMP
> > +	struct cpumask *preferred = NULL;
> > +	bool is_idle = false;
> > +#endif
> > +
> > +	if (!ops_cpu_valid(prev_cpu, NULL))
> > +		return -EINVAL;
> > +
> > +	if (!check_builtin_idle_enabled())
> > +		return -EBUSY;
> > +
> > +	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
> > +		return -EPERM;
> > +
> > +#ifdef CONFIG_SMP
> > +	preempt_disable();
> > +
> > +	/*
> > +	 * As an optimization, do not update the local idle mask when
> > +	 * p->cpus_ptr is passed directly in @preferred_cpus.
> > +	 */
> > +	if (preferred_cpus != p->cpus_ptr) {
> > +		preferred = this_cpu_cpumask_var_ptr(local_idle_cpumask);
> > +		if (!cpumask_and(preferred, p->cpus_ptr, preferred_cpus))
> > +			preferred = NULL;
> 
> I think it would be better to move cpumask_and() inside
> scx_select_cpu_dfl() because scx_select_cpu_dfl() assumes that
> anyway. That will make the code easier to read and avoid
> potential mistakes when extending scx_select_cpu_dfl() in the
> future.

I agree, will do this in the next version.

Thanks!
-Andrea

