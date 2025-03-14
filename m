Return-Path: <bpf+bounces-54068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D9BA61C16
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0104E4606DE
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936632054FA;
	Fri, 14 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTIWuCpI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E31FF5EB;
	Fri, 14 Mar 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982724; cv=fail; b=cWl3R1z/NYRop8ZUcJL/o0+5R12TPqKxLcrE68BXLlsBTwM9ARC5NZxr6PcFINbFTmwcvd0RuuCFlxtBbHUsTUPFn//j10RCyQdvALN5D1DmNJqPaX0arlGQZHT6AUHQ4rBqLf3Brk+zANDCmU2R60zHDttL6LqGy58nbFYavYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982724; c=relaxed/simple;
	bh=zLpRO6ulm/ncl0/ILv8oFwun6q2G0Zt+Opn3IOdGQuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g9M6kVoGLDAHlFlKh9cAToH2f/Sf3FiwE8WbYvhmzjDTdX6d7f3im/4FZEDlJ3wwkfy6kHTVhVUpoUTDkrS4wa5xzjkohBj7wsCwd4cCYG9NYWASYd1Ip0sje2yH0w4yAwSwOQtT16Nq8l7LfmCfyxyN22c7E0U+7xdgQJ81+Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HTIWuCpI; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NINUkRlTRinr3DDBQLB2U5UcSItHhulP2X1fm4hihQoy35xF77Yl080meBZw7Ditwuo7LOG9CPjz4bD67CdAkGW6HD7MmahWm0cIa9VSkerXwg3oTbUr87G/SZSzKod6RC6B0uB7J+njtDJ9lPGusA5uzqR7HXKgR5az2iA2lbFbolVP90LhNarIoe1WUOHeoB5UwCg50e5tfVrjElcUKDcuXYA7vXm73XOruIE3mUEuRYPNi9+C+pYly0dbsc/xl7zqXpyBwy3MBnUG/Bveeq172HX9HNxQ0a+I34W6OfOEhjO/aLYB2vwMgs+c1q6VzgDHC/LJ16dSrvuRHys+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN1CZcPc1IUhcRW3VgOEUX4o/R7g3uUXa+1ffpp9UsQ=;
 b=dFa7kK+lQG4S1+6kKpvt4nrbUhY1vDuayyoB2oqbUeqkK/B9BNCYN4sSACJN5mTaNkPM5dzgrClr6hejNDnQb5+MfEazvvbuukkIa2kUQzNb8HlSEmrOvbnnT8eRVI5Yu0CPEr9F/1Bx+eDa0bUMEngFz7SMxDQnaQHnyw1BWRl2N6BRxPlhtbhKT/wwUCGDztR81BRPvMMnSmx39Kyh4YXj1ZgiccEj6DdSFV0DDH97bJkm5jaAjz/eKyv9uQkiMrWwX631U/fUjUo+yqQaFXguB/joJm5b8r+N03ECrzu2X3nMEuaGl2o7l6XMN976zF2iWFQAwHvWLcCHsI9fnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN1CZcPc1IUhcRW3VgOEUX4o/R7g3uUXa+1ffpp9UsQ=;
 b=HTIWuCpIXEupGI0P0wOwN7wovep0QXWjRPNJTvpyL3agCeekGCFQnEPkhfO9EW409PFAZ1P5QC9gcSPy4mL5HtAi3P3cExVeEW9L75bL1P+/zh4/GJ3Ygg0POvLLgf5XpxBO6w8BNgt/pqqmO1Lm9mC7+TWT/uaqnIb+mfuLyoniUdbkhkgZX9fJgFPNylv54vDlb1jx3KjH6Kh/UxqsiXzd8HfJypUMIHmglE9QsXF42eJr7heZlEwsAGYAVXndD3xLP8iMpahckQMd+uxpWriVBMC/4gSodWV2vdr5Ap3sYsyWvY97Ia1kDL6KzSFIfbAgvJjkjPGxzLr6Sk8xmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 20:05:19 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 20:05:19 +0000
Date: Fri, 14 Mar 2025 21:05:09 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9SL9chJFYswO5MU@gpd3>
References: <20250314094827.167563-1-arighi@nvidia.com>
 <20250314094827.167563-4-arighi@nvidia.com>
 <Z9RzvWMiHWqiO2v7@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9RzvWMiHWqiO2v7@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 48254257-6bd7-4d21-1bb7-08dd63338b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vI6Om3HX20DXT0AE0UZP9M2VJbeTWWuPrtQ2OaKPqrsPTaFUr9BJBBf3s+04?=
 =?us-ascii?Q?5OWn//mem+nY0LmVZRVsFJsn1inqADFJ2B6A8xSs2VPxcFvT5qV59QkLNyiT?=
 =?us-ascii?Q?Jc75u55IXF4H0nGyTzHt++uLBvHCuwU8Sw5GLBH+Vz2PY2lNeHJcEz07fwWs?=
 =?us-ascii?Q?PtpfdDOsjVpS/8kNbD3qh3cVIMjAmukJ65iDFJO7elJPwCwCcMy3IeObkbtr?=
 =?us-ascii?Q?bzN5KdJaXcZGkK/6/IUYo1oPH9YjYvHG2D4IYL2uD9/o8gb2Y0TIRrKLRTY+?=
 =?us-ascii?Q?ubAtRXKtzXb7a72hqPWQlJb9UBj9yWViVflv28fSziMC4b4Y9aroogq9zgZW?=
 =?us-ascii?Q?b9geOt3dlEomT1xN3n5TE6LOMH2IXIk00BuX9fOz4+pJmQxG2RHWD8cOoDZt?=
 =?us-ascii?Q?WgKPKiGSj3Go6zeskD2YEH3w49r+USdWLQQs7zxnlg+rF9+TwzTs5EP/zyo3?=
 =?us-ascii?Q?YrTlTjTDXiS1uAZPkAaveNKIaUHzmEAdEQps6m9jWQZU1NaWujiAxYLWDgpE?=
 =?us-ascii?Q?DOtk6zGp5RuNwNhfC89wlDno6EyWJ/Dd7HokmDwmz3ABW2Cc7x8dpEXs99tk?=
 =?us-ascii?Q?RiSlGfe0JbHz9DBn9N3iGM5sIivQTogOxUSWjxhGxrMAYmGomUMzIkhrL8n+?=
 =?us-ascii?Q?kEy/si+6NLuL6XJIsaDq9tH6oqpA/r4qIQv6sBVThO3MUVuhqHJY5dXw1WQ3?=
 =?us-ascii?Q?z/XUcs2CMN3NQZUSWvgzlIK41vMfABr3CLT3yRk+YQWx/UeHPSSpicksk56H?=
 =?us-ascii?Q?yZGHUWpex6s5bXWm2XD3ljZ+giHyqCfH49/gMkoZJ7ts62lcBCK8SjRIQsaN?=
 =?us-ascii?Q?gTLxH+FIjYkyl4mE6KzQZ3xFkB2V9K028CiuBfr8+7MMe6M/5VWyPdc8k15N?=
 =?us-ascii?Q?4jNhxmnTq6GYIEZMhZIGcqgn96BCg7Lbn2xaVlxIdVheMLmyYID2Ud+AYxwR?=
 =?us-ascii?Q?dYQ624ZnJKaEnWyzRrAX6wKORQ7xH1RCvgWVn7Wj+QLkHB90fzARbZyylQ4Y?=
 =?us-ascii?Q?3bUuXv8NhonQ78iFR0C1jF9HQjYDMo1WIJbguvRxQFX6AzTZ7sUD372nPz1n?=
 =?us-ascii?Q?tITFiNT9rjIChWiUCryPpQDQX2HZRP0/LzkLhWpjd+giy1SfBcMwQZfw4pAx?=
 =?us-ascii?Q?HKhe/6GDUJFp62JFK/bAhBd0p9isFamKxwjVI89azMQeVdM+E/fUVOtWgZqj?=
 =?us-ascii?Q?eI3RqwZUArs4ExRNO80ML0sQUw9Y3R+DXKAhxXvWcCfRRIwEUa0S8ukgYW3t?=
 =?us-ascii?Q?XLYhSdScUNkY0umOewtTqMvZwbgckha9Jvt+3v6ePC2zx77yp+qfNJLajPyo?=
 =?us-ascii?Q?hZJsVV+H9LAyUA9whFkaBgFWB/kalUKK+bOUllFoqAHKTBtOsUpreFUn4sRo?=
 =?us-ascii?Q?RZw0wpVLC2POShVtZf/svM22LC8P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D9kdcnoBNeBkNRT0ysSCFuWcshqMW67ojXDwl2RgQbiPb5EJNUFY4uuEh0Wl?=
 =?us-ascii?Q?quLcx3TWtcQeOtg7/v53AbY/R4mqbrID9z4oiXQGR1m5IHyf+dA+abAr8mY5?=
 =?us-ascii?Q?fJB8jaTzlfwqUH/+Uf+yPInGjLu0Y9C5PB0xTGHiyjhxnC3fBxkEdBQ/03wM?=
 =?us-ascii?Q?NztvmWoNQHsGt8mal0DuzIZlLy1o8w8aW81cFq7Ovbve5+gxpjLJu2XuOHIH?=
 =?us-ascii?Q?QyXC4zVPCr/AFIyPuf+v16U+Se3zMh/tO1jfc5pqWK2Jw3mPUz6mJcfdjc2r?=
 =?us-ascii?Q?jlLlVPlzrYgPMMOBkWiuZZ6CXpgDvlCX7KBspf2u3MLhFrNJ6pEsLxkwBZwC?=
 =?us-ascii?Q?jM2CCzZFL9tZdriXYWIa7b2q17NU+9rvxrXvK6bqSmkU3liYhp6dEFH1i/+U?=
 =?us-ascii?Q?ltL0rwuVCO+ZtPElpCa7PujwXZQLcP3hK5jRSKWnjFKSexE5aVq3cPJ8Zw12?=
 =?us-ascii?Q?+030r1TOnZs1/zhuvLr1prVmE3zXhYXiIcu4vtVzzaVVCQSNzIojaeJTCnhS?=
 =?us-ascii?Q?BWsUG3jRxEQOWsVgBBpM40S6SbsVVP3DsURGLsBskT/jV3uuJQqbluPhXfmm?=
 =?us-ascii?Q?oDEj6/AT3nAd111YP2263C9nOpgHKzM+kOBWUtoGk0xFiRSOJio7J8xGazzY?=
 =?us-ascii?Q?eEcz/JWZkQWpwzqz6XW9MY+juE0FfVkyUKNlI8dcKIK4/KaCaChQDIh4sEGs?=
 =?us-ascii?Q?ZkoHO3KLPfMNTMbwPzFBKZKPhYUwhU2kR8JYAVLiBQ1+o+eX998S07kOipA2?=
 =?us-ascii?Q?QD+i9HmQWGKxlm3dgXtQhM+7cSv+vOU7sjNBN66zmTX6D0PHAvCh9uB6VQ/D?=
 =?us-ascii?Q?86ZeBWAvW9rPeR+JMJmWlnNYplr63k7+UMA8pQkqNKswPYRzIRBMaGrqpZbZ?=
 =?us-ascii?Q?INeCqoiy2h6/3Gi25cF955CkPzPqTEATNBlh/NZH+AWQNbHYUyxKg1xjdpCN?=
 =?us-ascii?Q?E1SPvCdZ5YbglVLEwrV4PR3Bd35aEYOJj6J4UQFgJM9wTG9JGgXmHs2AK0fv?=
 =?us-ascii?Q?AreGHMAlMIm+1kiOz200/p2nwmhf0BEmyuen/gOHM0+F9X0//orVCRSCR83q?=
 =?us-ascii?Q?GCcQi5oesNQwLNNYd6JYLlgAUuMdkgtwOvocGr3Y6glqCaMDnpm/SvSK2+qi?=
 =?us-ascii?Q?E9cGC5XgsUTxl+uANQy8XJpfV2/E5jl+eMd1eD5Exl9wohqHr1oJekMvM1ok?=
 =?us-ascii?Q?1YBCngSLHj3/ErMnYpWRHdduvjWj6vtWIHE/GOtpr5glV/rQwq0EcVS3DcJN?=
 =?us-ascii?Q?oOBn/4/smE37dSs9It3kiozjJFhqXaJ+6k7ndbiA0kEbq2Rq/fsUIoGfbG0R?=
 =?us-ascii?Q?gQiEQCJADAJuYCf74jbGfntKeYn6PtvjXz/I3gPdENrT+jBRDdXCMJWzJ8gN?=
 =?us-ascii?Q?1hV9W6mIpdxwoU2GgdaqToaMtxCkqYKLR2bvsmlnVfjkuMxfiQ9bRUhAokoM?=
 =?us-ascii?Q?H/X1PF0cCaxZCkIxhUz99eVja3s6hIK6hwpxk7/WeBIz8BwHr90hKD5XBlMf?=
 =?us-ascii?Q?9YteRONR6Th16q4O+OLrAHxkWB99Q02Upgievygo1UJp7nWkDZvUIE7B3WTI?=
 =?us-ascii?Q?lTwjF1ZzoiCouV/LpJLlNCYxzawAg9zKTHtfPqbl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48254257-6bd7-4d21-1bb7-08dd63338b97
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 20:05:19.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hitvoaHtUCIg4gN52TxlQVnabYqtD2vdfKsx3pgIn7cDQ8vReVfoYArAMgaGkmn+ROUAwWWyv14e78Xv5Ph71Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657

On Fri, Mar 14, 2025 at 08:21:49AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Mar 14, 2025 at 10:45:35AM +0100, Andrea Righi wrote:
> ...
> > -	if (p->nr_cpus_allowed >= num_possible_cpus()) {
> > -		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
> > -			numa_cpus = numa_span(prev_cpu);
> > -
> > -		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
> > -			llc_cpus = llc_span(prev_cpu);
> > +	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
> > +		struct cpumask *cpus = numa_span(prev_cpu);
> > +
> > +		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
> > +			if (cpumask_subset(cpus, p->cpus_ptr)) {
> > +				numa_cpus = cpus;
> > +			} else {
> > +				numa_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
> > +				if (!cpumask_and(numa_cpus, cpus, p->cpus_ptr))
> > +					numa_cpus = NULL;
> > +			}
> > +		}
> > +	}
> > +	if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
> > +		struct cpumask *cpus = llc_span(prev_cpu);
> > +
> > +		if (cpus && !cpumask_equal(cpus, p->cpus_ptr)) {
> > +			if (cpumask_subset(cpus, p->cpus_ptr)) {
> > +				llc_cpus = cpus;
> > +			} else {
> > +				llc_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
> > +				if (!cpumask_and(llc_cpus, cpus, p->cpus_ptr))
> > +					llc_cpus = NULL;
> > +			}
> > +		}
> > 
> 
> Wouldn't it still make sense to special case p->nr_cpus_allowed >=
> num_possible_cpus()? That'd be vast majority of cases and we can skip all
> the cpumask comparisons for them.

Yeah, that's probably a good idea, I'll re-add that in the next version.

Thanks,
-Andrea

