Return-Path: <bpf+bounces-54278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533EDA66BB3
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C07F7A360A
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCAE1DF727;
	Tue, 18 Mar 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gsMhIsES"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBC28F3;
	Tue, 18 Mar 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283098; cv=fail; b=GLvSdBdN+Nf22uKERPipj6rqgUbMsX+VugI54+kfex+V62X6rwkFpxOpW61TVeu4hsn7aBfiq3Zd71UcNcxYBtwlXjhj1Ye/uxfcY4cOG5COUp8wLRiJnrjWAdU11TmOIMsqVRVhIUAUHTFXH0Y97/VH17AKX2fFUrwV5PF5t4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283098; c=relaxed/simple;
	bh=Ap1uuxiIie64xK60CXY3EwKv7sFew44pdrm1O9IV21s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8L5FUZmY71Jtr0XCOa4g/KZfgZ+ddXYOgeGazAL+MGdMPGRShtQNkpEPQC+lWBvVadXrN3KtCPXUjIDH6Qh24TlNyA5bnKkqCi4OmTFozcYWxFMlL7KA+KE5+VgbPEcBNFUwRnmatNeZh1n9fZORyAv078ZbI3hYpestISomVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gsMhIsES; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaTzWcEKKo140V6VTebs3JWvh0PkdBE5icsWVYX0D6lCyN+dPjciIpTDLetMr6BvCUvNtMVZA96VzfkOxsbDLnuLYkppH4KmcOQDNSQTxDZB3o+3h/6GwaznMPcw3A+vjVG1ogCNSQ/Bg17/jhhAbyp5NqVmTUTdLGpYv3c/e/TcpkQppPIfRPMrlwC15Aj3pAHKWveiQet3JqioW1vPdPy7KglA9Ya2KoJ4XdfV3pK9YvhFUl3feSjo3VKdtuyvyqNJWHbefxP3N9l+8folMK9VnSkSWQOooJNPxMrSJ0Ma7I8KNoRpHzTiSEhx0kvPnLKxlNQ6iTG3CUpY/2GTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq4nWBqIfhoQHW3VcNz5mNQ0JL2QPQr8CX08hh/Caa4=;
 b=JJmvKQNB1hHlDfS+XgigHGEh1BhNvK9Z1zu9vEs5j21hjD/KmvJKgTXssH379xbw4z67kRYOxdAA/y+rn2WAeGzi4ZCyEFaor2bng9GKdChrr14pUg4t66Rv5aCV6uJat4S/m6DDCWQxPZiNgX4LoDeDXpKWHnLbKN0oXaUhJO/5X7ndCv357l13hh6oph1/abKLeAzeZzGqozGo6Qyta7A+qqrc7NFTxlYv25qR6dJNmZYyw7R9omYVn++YlY4rSU6FeMtkmJE750UZrsnelAQ4uMHDZLlkOflwNL83ieYjNcNHQOOgonJWlfYrotvE4IBU7Rrr/ttEI7gNI2mfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq4nWBqIfhoQHW3VcNz5mNQ0JL2QPQr8CX08hh/Caa4=;
 b=gsMhIsESdN6RLFflu0DXDwSaQOPqzoqcq8sYvoxON9x2fDceW2KmhDPl4o/KsVvcBv53nqJUXDSdCNmHdHwL+tA8iFEMCq95maEMKdbzVmktyvF1Ge9w4fv2mkb4L3JeB4vNqFCwEhvWiKk22Kg0F8Mt01yDprzPMDSnNej68fWCkx9pSdSvMpBfVkvHFAjURgR4+ujfN/I7ahCv1QAHV4xXXEr52TOMLfxA1nSLu6Q9yncofCFAIwpTNssdY683NeCPmgHUml8uoVvAT/HLeeY5jIXW+YACS9ZR0G4Q2gXl2Om5x/zVLUBALL6r7D2wpxbRqPiNyF8yUJca3zLHog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:31:34 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:31:33 +0000
Date: Tue, 18 Mar 2025 08:31:29 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9khUVcHNfnQuN-u@gpd3>
References: <20250317175717.163267-1-arighi@nvidia.com>
 <20250317175717.163267-2-arighi@nvidia.com>
 <Z9hoa5iPpDEOnXKt@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hoa5iPpDEOnXKt@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bedf10-43d7-4b31-6ecd-08dd65eee89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?is6EfUoJiOb7i1vxTVMOpbFRZRsCdR+9mqYqGD45BsPOLjwkcri0/prNI7vL?=
 =?us-ascii?Q?RV2MRL7Fw0g5RDxLb4VV2kKu4b/9kaJ0Uv3AnLHTPYikfaTy5KayUaQyS8WW?=
 =?us-ascii?Q?kLKQejlBef+N6JS6x6rSbfx+uf7hHLkd7Y6z+LzV8nmt9GIey9jhQ0NVmFnE?=
 =?us-ascii?Q?WRXrxrxRYjmN8/bRKGgo4I/M1rTgQgFZhT87DrCO41coiqYp/HfuMvEIvbsN?=
 =?us-ascii?Q?lQU3n97XlFvnbQGdaxedQmEnIEpDgZvUU68EHHhkz6zrHMI+itRlzdM5tj27?=
 =?us-ascii?Q?urzHGHfgHu4F1eLkzVlodb7lq7y3JmvseHL93QtfzQj6/7+qCRcTotG30qwA?=
 =?us-ascii?Q?o7qydGmVTeqQMhU8lb4uab/YJPPY8wKtVdo57DIcYsfw2c19OoHk6jY6ZNIj?=
 =?us-ascii?Q?uEb0OKN5VwKHpQ0ya72N7n0JOiZ17YfiM+AIKoV3h7Dekh0chdXbsp1NWNeR?=
 =?us-ascii?Q?ezRmQu6YPaJ3LN04gXlcNs/gJBKl6SrhF8JJtgdNhq0OTeCP+wkePVSQWUuX?=
 =?us-ascii?Q?fJPW9z3Ude5kOt0P8wnIImjCgxA7/skHHETqyT47xxzKYQgtWssi3I46V9UO?=
 =?us-ascii?Q?ZdnYf+7q9Fogk7n5MrIJjBZCFMv42lCS2oWbC1GirRfgIzZk4kkHEu9JROPc?=
 =?us-ascii?Q?D1RSybLIfTopeNbMW6Igq9wQr5muR2SOVpo6qsPQxH3t6FtIWxPpz7iY+Hnx?=
 =?us-ascii?Q?lj8ybWUeamF1yF2bWM7IoFcj0k5jnjC1+OESob5EC0T3tyqK5ZROZVoEncjM?=
 =?us-ascii?Q?KIQb1WClqripuTbq7NY4nk9iGwT+QKndIQXL2zto6QcKIbWu/bq3aoOY+fPG?=
 =?us-ascii?Q?iTh/ytempxkDrr2w6FHA60MMieiEVfQ3Uh2XNfPHhhRE7Jf6riQAIwhl8aFR?=
 =?us-ascii?Q?Ml1t8R3rlcCIDSIcZBE27VWyWXbut+TxsebLw/wS93W6OJjIJzP3pfOpFkBf?=
 =?us-ascii?Q?iCV8H2lYCSHVGis8gqA92ToD5aJS0lKGLgY1XFkd35w1SK88NxuFE8CD1yVp?=
 =?us-ascii?Q?+21kEaRLbN+dfoVuVbL0CB9Gwh7D5o1CcJnEu+NUm/ZMOPAU5BfufVbaxUXq?=
 =?us-ascii?Q?Ct3yxHEV5OkoES2ETdrwyf3/6733yH8DIwPrIfzVd4XFi0F1/wpTyyOVl8lC?=
 =?us-ascii?Q?mqWZlty4qNOVG05/fpcU8LARESFlPC3J2BRp6uG8EsJWrnC7EekojflQhRfr?=
 =?us-ascii?Q?jYgVKzGv3Y/EWg4du/G5Nve7FvMHIDPXaXvXGrSewVsMPOj+afZ7aajUdDM/?=
 =?us-ascii?Q?eHx964+5J1iGl29IMGVLvQmSoxquIJRZw5+wDOLxGhu9XusELmuQ/GHi6Xbv?=
 =?us-ascii?Q?+nR6KeMq3fN36ziNWPvIYnrl6sPECrK5/FLZ5YZUXgc1MZYPr3U+o6R3qvxU?=
 =?us-ascii?Q?CcRE1vWZsM1BYP8iHwHnauysQwfv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hb3b5qV4CDGGEAw6BkAgxCgdHpe6RmlGstb5ZWYB/ephjWwk5maJacQzK4+3?=
 =?us-ascii?Q?0rUvQQzj75gf9/UlGJN1Js1sQcWqMLS8qX9seCmcNSXSnr8Lj143K1qkYYjt?=
 =?us-ascii?Q?JuUEpeeECL45xpLV3hVqcbRPYxHOcNQYtoX0CWWhn7e5SsPpPImpAtv+dDeF?=
 =?us-ascii?Q?1aIXuFev0k8hAD5TV6VJP5EYpew8pX1yF4C5R//qm7E02wsNgU4i+PhnBjZV?=
 =?us-ascii?Q?pJZwT2fEfpHN6euYslS5E+04AlPr7yy3SPBEWyu5yJXwbZuQsFNin0NCEp2+?=
 =?us-ascii?Q?B4rJku5EkZmeKXEXy350z/Jt/ZSUs4ULJgaPIHrov0m3GddAGfJeAvYX8VoB?=
 =?us-ascii?Q?8alYG4GgtcLKoSzxiSE4Nc8czH+4ELk2KowQjr5LUxQoSQHI6vJfC2G9Xrgp?=
 =?us-ascii?Q?QcX0PNbqio2igmL3I+7EDntg0pc9eXGMMTJU+kbH6uiez+tv5rD0ujpl2iXo?=
 =?us-ascii?Q?TSEiY3MzPgVlJ8P96knjZ3Qa2AEr7oXhlVt6VfpRTi84NVYATXSJSqyhAz/q?=
 =?us-ascii?Q?NPycMBmlWtAsY+ZwuWIdCcoS25UsMbNMYD7qqJGyWCdPpa9AbM5OueNhsL6X?=
 =?us-ascii?Q?3178VZD48WsdY+lo6wKAjwo3/nu9J8UaLxb6vi0mBB0oMASLCy0lPDsavggD?=
 =?us-ascii?Q?t2E1FiDnusqA9yo3tSiHaZH1fVHgJOV45jTwEVzUfM24BIIXrcKdEAhh8Dh5?=
 =?us-ascii?Q?pG7/gi8os2UGbutot7xK/FUBlK4xNu5MRYTUGanld3ld2BEzqOFJ1SigcN+y?=
 =?us-ascii?Q?2RzlsrtzJt1U8XMo4m8hReVLB5kJo3PZmH9P0IfpNmK5E6WtlQd0R+2wYTn5?=
 =?us-ascii?Q?4ALxhAYxXhJoJg31j0g1btpDymqDjyFELB1wrhmEvJMU33UdH/QBjisAuNQc?=
 =?us-ascii?Q?lEh/dCpKNoyhbMp9pzfHW3fkP2r03++DsUb/76QN6VM3p49bbE8x/HoLIHXY?=
 =?us-ascii?Q?qtb0IsVUOzAwdoSKyNCcTj2B2o2OQPBVNofx4WyQLT+lnWZvx097rg+AmGQm?=
 =?us-ascii?Q?Mjq/23w5H/6oOfF3kywIhxJ8fqYrNfsCfeiDVdHu1pMhaXOwnolCt65hZ77G?=
 =?us-ascii?Q?9QjY7FmDxFodOs1u6kKjeadhM9uOeyjNXCzxJfahvHFjS3TlNHjmYGpqqBms?=
 =?us-ascii?Q?FWtw1J6BJrp/oCzc30CH1m4iy0ITI7UlOyMOG4boyZh8tqi2BQgrMmvOZsIy?=
 =?us-ascii?Q?qu+BfeEklQktR9VMBANAq4azDuJ7jOfe1LyduFlMKgKNhEMj4Y0KEx2Vv4jX?=
 =?us-ascii?Q?dBZ91ex39C47FO715KTlg+tBCe2sL4e6rx40NlKEGLb2xbqE7ogJZ9oj0GqQ?=
 =?us-ascii?Q?uj6QjiMvTVl0fiy9j0P6yUHxVXaEOBNtyJhzM6vbc9ycqnh744xG0kRTPgJt?=
 =?us-ascii?Q?72AdgPVXjgftpT55QYN7We8ituvpBZiKCBTbp8CW0+5Nn/bjtzdu0V/+vAOz?=
 =?us-ascii?Q?cBBaAnCIZFKl60A+at4X3+mjHs4L+m14AIdCZOz96dKph4y+ZBU53KUVfjda?=
 =?us-ascii?Q?9N/yuISKyQbJ7vGDSXN5k4HAvDTe9AofS2BZ0txYn2QW7OpSeZMZ2m77ib/m?=
 =?us-ascii?Q?xV/7R5g3oeoS+1jYsNjXjSMJ3fGmKzV5UaRkzhzw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bedf10-43d7-4b31-6ecd-08dd65eee89d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 07:31:33.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWZXpVZS+vzVQn5+axo5GfM04mLmPu8e4Q2u0ekxSM1C9IZ/2bwQsL7076uto9edrfJsW2JWyMepke9amxf56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665

On Mon, Mar 17, 2025 at 08:22:35AM -1000, Tejun Heo wrote:
...
> > +	/*
> > +	 * If the task is allowed to run on all CPUs, simply use the
> > +	 * architecture's cpumask directly. Otherwise, compute the
> > +	 * intersection of the architecture's cpumask and the task's
> > +	 * allowed cpumask.
> > +	 */
> > +	if (!cpus || p->nr_cpus_allowed >= num_possible_cpus() ||
> > +	    cpumask_subset(cpus, p->cpus_ptr))
> > +		return cpus;
> > +
> > +	if (!cpumask_equal(cpus, p->cpus_ptr) &&
> 
> Hmm... isn't this covered by the preceding cpumask_subset() test? Here, cpus
> is not a subset of p->cpus_ptr, so how can it be the same as p->cpus_ptr?
> 
> > +	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
> > +		return local_cpus;
> > +
> > +	return NULL;

Also, I'm also wondering if there's really a benefit checking for
cpumask_subset() and then doing cpumask_and() only when it's needed, or if
we should just do cpumask_and(). It's true that we can save some writes,
but they're done on a temporary local per-CPU cpumask, so they shouldn't
introduce cache contention.

-Andrea

