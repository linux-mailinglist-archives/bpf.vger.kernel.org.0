Return-Path: <bpf+bounces-54273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0101EA66889
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 05:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD9E7A4468
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA021BCA1C;
	Tue, 18 Mar 2025 04:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="anFfo59h"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C319ABAB;
	Tue, 18 Mar 2025 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742273005; cv=fail; b=f+TKjARX6GsEBpPZSQplsZDVPuF0nZzPuv32q9WTBpckU+D1vm04VnoAmMQi0HyqoOtYyKledXTKIMd7VhSaW29PUKI4jfeyfYQK1UanSUTXTM8BAGIbm1msJAJCoxGqz5j8hdCBMK6w4Xb8t90+eZ6DyOphVnjzGEzn8O+br8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742273005; c=relaxed/simple;
	bh=FZrsxqqVQPFlNY61GoAFqEweFSbIWvBTZhQIciCp2aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SgB+pgMlmgRyoOSIb77ssJR13kb1YjFzrlt2dVJhg8NfaQwk3SyeKDR6rcwvzqr9O8tW4PeFrfSLpR4VgI/mTOy4IvKRqU8sAwj0YT6KqBqLjPAryMz+N38fUL3VjzTZb2IS6yvW7KZqlnxmDpWNuZI+Xn4TEpQTLl8YpVbptUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anFfo59h; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoAx2xoV4dvyA5+CBl8NeMXfrXDt+d3QBttNQDioayTuWKWYVig6kcQae7B5s6V1oTCoPKmxbqToopmX2vnmB9NEXV6zOGVvOHxjASq4enVrVJLJAMiMZfglm58xF3FKc08JqYycl+zateYzfywNGbXZMJ8us5yzSgSAInruHKcUcaqwC3wounXIkQLNoDVip2ELjNTa2e0trZ81IAUO2FwXPt7gHkPYN+hdhDi5GgJvlw3gAxtGS/wzNCBixaFOh5Qh1BHL9CQnPudJqPYxbVCpoCvuwQC536Uox9TeQjvl5/7mGcRT/+JeERLgs7J6zbeo42iRi8mVrznIqC1Acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XACfIBqclQ2dLXZCi5Z+yYfU3dRdA/pBdzRurLAXRLc=;
 b=XifQYUtPAdgKutp+BczaET9kt6TTjxFUrDc9dFBLvrblIa1OeFf2tgkW2/dOJqc6mJVJUerV+GWWRpQfPvhim81N2TmsCq9wzDTPGXtHxdceryWKC3E8dizs/ikyrM5zP2M7WO2J+Z4+3Gt7tUAxvZAeSUNqlsUaqB+jahmjazcJGZH6WIIKHPtU0Gwo2ot/C7pWVuabUpl7YodeD+w7cgzbuddqjoyO02F53dzwb6uJ6DpZbCoAzh8Cj6y4TW3ghABtHmqpZP72wKPFL1Mup3D79+X+T3UphWjwSIorrhEEE43T1MqRTnqeOqQ56I/VWTOXUSfcZ4Q/z/aGaAGAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XACfIBqclQ2dLXZCi5Z+yYfU3dRdA/pBdzRurLAXRLc=;
 b=anFfo59hhsFBRYO25ofbIwJt/6PikDMLfFDOnGYyx9OK1mTref5y1f7FD0wC7pqdkUlXH8ZUQtf1h7iK7KRkapAViiNwYMtRA0fN6pC77WU0V8Q8Wud6UPCBCWeANXU/1n8Pa1imNNz1tfnC+Fr3KLQMvi0hnEIdDJMmSfSoPCJthg7aWQk01p33hn2p7yYprLfRVMD3ucBKTKRnxrFtAHM1NVF7l1srIQyUBwT7oNUbJi3QgOHqHpzSI1ENi8b5EnrSxGo/VoMvYiDnJE2QAQSlzgLYc4hr1NZFROiOsStdhsG4rtTquUTXx70vYoMR7QOZAdYqw7W2oSQowDQjcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 04:43:18 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 04:43:18 +0000
Date: Tue, 18 Mar 2025 05:43:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched_ext: idle: Extend topology optimizations to
 all tasks
Message-ID: <Z9j54Jbgqsqyf1OY@gpd3>
References: <20250317175717.163267-1-arighi@nvidia.com>
 <20250317175717.163267-2-arighi@nvidia.com>
 <Z9hoa5iPpDEOnXKt@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hoa5iPpDEOnXKt@slm.duckdns.org>
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 036a42fd-e0cc-489a-f479-08dd65d7673f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVVAThm+CGBVUuyUxPrbMa58JgQeRb4767xFoMm+qwJaVPPdPTL8HninC8vw?=
 =?us-ascii?Q?gNmktSv98/D0zgBttqsa+RHPGyxD5793Aku2FT63vnrwz6mUdicHVsdC3+Zv?=
 =?us-ascii?Q?p+rvAYhGLnJddnUqqGzL75bBZ+IiFAqTJazCSMcIBP1AWhOej6k3D7YSOiSX?=
 =?us-ascii?Q?oBwV486rsRhCqK/xC5nPxA//88kSJQbtPKYDZUUsBYu2ICz1HC5sAoMwNXzr?=
 =?us-ascii?Q?G1gYe6BjTWNE5iGGMokC+WgyeiRo/NDKeC1iNbg7ZjSUvsOSmjIQlK1GSirX?=
 =?us-ascii?Q?l81N+Aj0pojaLXLTH8YxOi21cCGS25EgCzliv0fEKRIP8PzHVxQWzd4Qq4RQ?=
 =?us-ascii?Q?H8afP5hE9VrZ5DXcddmAqwj+VIr7yYUZ+7VerAKC/Klp05RhWzj7B5JYXcef?=
 =?us-ascii?Q?IU02hKB8lmffZecF0e+KQ1SfV1BR/9jnw62IjvdQrkzojwGQhqfFNlasYSZc?=
 =?us-ascii?Q?K3hB2JVFUEkRpQFs+p84oAIsIkQ7IYNx3Pp7hMV+PN0PlfNuFbF6Sx6X0P/H?=
 =?us-ascii?Q?ujwFngHYzcF979gKJrtRi0P7+KvNH6yD3wU7qJa4G4ikgSeYpcZCGX+LmKzP?=
 =?us-ascii?Q?zp31PNlhvFoAYvlJ46bX9Yhm3e8uN5ADOVeTsRDRyXMJ9MGlDJx2x3ClIO3J?=
 =?us-ascii?Q?XSUtd1lE3C3neRDAIXrKFy5Fzjd9SfWP053CDdZF47aQHqWKWyxQZBPNn+ZF?=
 =?us-ascii?Q?oyFHle9QLyH+c81XRVpl+DzC/RaT1ZV9r3Bgx8rAdLCtevRSCrIcARmFFeV0?=
 =?us-ascii?Q?eGwBZLlcl5qgr7+qgOAfFWgsd/YKfh+aspV7bhDoWL8264j7lDOacEd0+orm?=
 =?us-ascii?Q?VuV86vABvtvqKjmhfXGUFkXmvRh0mTyrVATVKN2aWOcFJQTPfOtq5TG6NejV?=
 =?us-ascii?Q?u1AVfeQo3LrIDYbidl5//HyVFQcwe9tLOhAd3OOPdlyqbP5snbmxhYWsXNvz?=
 =?us-ascii?Q?es7psx7shQyFTwvILHmKkHky2QYKC6tI+z3WAW7aHlfXTyVajP9gfhIOxZu+?=
 =?us-ascii?Q?fyA0s1iHJnvNDj2km09EzbOxQEYk2BKogVzS7ZT82M0zdGL+N9i4lkr/YV4u?=
 =?us-ascii?Q?zULOLF1Nvr2yrf9IBy/L+Xb+OwnzdcfFFLr4jGUf2N9os0zq++MC7TkCQc1z?=
 =?us-ascii?Q?bnC4FTH22MNB5REuk6/om7AS2F30Dq6bBguUyTblxkwdIHP8XJtLNMGxtDSW?=
 =?us-ascii?Q?Au/28FaISsa5hSJw80Kxm6zTWJMRioT1StXGL8s7QI54EGRqoNxV7kAk+vEn?=
 =?us-ascii?Q?JttfgxtJpGckoclFRvugIxeSpyuVjMWTOF6K+AW6TyIvSaNGyb2Zz4bS+WwE?=
 =?us-ascii?Q?nZv5GaiGz6WWWtKNFGnyWi9DiLiXwAwbPIp9ulFCkUyDFe4Ra5gtf1uGgeoJ?=
 =?us-ascii?Q?ubGObEx0SK9cijl1HtnkRRCE3b5u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBIau7P7IqDn6wfpGIkOlxyq3m8oFYANzFHzSoD8lLBLeaG4ntaQYsWN4XBx?=
 =?us-ascii?Q?JC134Cuv8MbjdWBdx6rofbelQTv1SzpUd2tBOXmCOIWlH0K4Oxsxyx2pqcl2?=
 =?us-ascii?Q?kfOtAdEuIdJQkufz0y8DOxdaSAj1R8eTLLuixpZAAw4UnLPk3Ic4davEDcUS?=
 =?us-ascii?Q?tYa1PKSaqlzgMOzOhBDNhhmyo5ULHK1dMGriJS/TrpLHIs1fHLHyYHKjf1qN?=
 =?us-ascii?Q?ByNLfPn5zMPLsjky5QxEuwsblWyHCXiU6eoLivsnn4B/O7B1019WnxZatXH9?=
 =?us-ascii?Q?pf5cK/FBZjcbA07KvdDE6eK4iVOO1Pq/dR5hemQ6SY3lnH8j3ije86ECXuP9?=
 =?us-ascii?Q?dLVwm8pxjt1r5PBGr3PdW9f5g0ZJh+Djdl8sntMmYjH8gAA8Kwo2/b2tgOO9?=
 =?us-ascii?Q?1vZonzxYECmGynomxYtV8gkjAG//kFdGNPq7ZHOSBMJb5jAmRzOU2pJhyRwQ?=
 =?us-ascii?Q?PyPgyYOa2vXlEC4l6rhYGz30bffu49Sp6lVGquhzdS+UUdNtsFGM9ZfNdq+g?=
 =?us-ascii?Q?pOhR0x7nFeTfy+b9yQBdfUi/80tLfZxP5/vsovTuhtebHceAMrouMpNOKZUc?=
 =?us-ascii?Q?Bxnj0qh9CYEsEj+bvfxIuLQ19ksVxps2hkYBHQhNRa+cO9jSSy+6ExYlW5JO?=
 =?us-ascii?Q?hlq9Ie+/w3pyKaDl13qvOYI24ohXSv1B5QOFH2JIQe32NtVkdCbUPoFHQxtM?=
 =?us-ascii?Q?iVN2fVIDHWRuMHq3N0RFBiGUV+xe8LQ4sgQ9rANKlswPc8UQ2eXD0qDjGHBf?=
 =?us-ascii?Q?GAruVKh5x0ZvSJ4a9fo4SII8i/lk57sbTLxSweVSOYq1n2iWFBpodcgIJ3ad?=
 =?us-ascii?Q?Jaa0eK4yiqe1Ny3OgD7ykFsEsLHopO7cr8eRGC3SFENczK8vLieM2kIVxO1q?=
 =?us-ascii?Q?zhCmMqwNcuYMQ8RpaWifBIHBExmP28m+qSfHXFl8LzrEgcPG/rN5X5R/GyXt?=
 =?us-ascii?Q?l9rvCfdZTG6aA/NZ9TNP6kIyYTGtep4DJbMMJOED4snFX8uzOd2Oc/cKrqcJ?=
 =?us-ascii?Q?ntjNGILZD/IePd1PX+KRKHXWYzws+D5D9Haxc+Rjfm3gQFKUeMHn6PKob51C?=
 =?us-ascii?Q?0CiRuMgN4oKjv9FY7731SGm5w79NYp3aQ8th2DV4Ar2F558c8frRai67727J?=
 =?us-ascii?Q?iXTZQh9IpjmvoE2RJBYWpbsif7uDmQmD9osw7Vd/UwhczZ8xeBevBQPc4Fma?=
 =?us-ascii?Q?dPRj89uRhBT97tVcv1+G9jYNk6IGnTKbJTyeZksseCn51fFF7QZkXuB1kJBB?=
 =?us-ascii?Q?V7FroPrZKZMJW1hRwDQZL89QWp1V9VyzFzKfG6Wcg8uxnHidOVLdw5lwSitD?=
 =?us-ascii?Q?Fkf5xXkI+tLXZ/hCFGFUhi5r1cSIyoR5YbN0UBDc2ZnM88JGwY7b+xfCOHSs?=
 =?us-ascii?Q?lMRez36kvG72PkMN9w0aQMWIiIZnq6vwALGXlZ5+M9m4rIaqsV1aeKzRPTyl?=
 =?us-ascii?Q?tmRQx+EacFXR3SkCmL+egrtOCL+V9PtQrKGDXAADaaNwI5uCNK3LwV5Joiz6?=
 =?us-ascii?Q?rNJGyOfKoPIOAjNwf3KotB5Ui0Pc56lXHUqlBTARRMGuUj70EkdJ7iiPwSYp?=
 =?us-ascii?Q?IolzwgjKro67C4Pau9zIlbVda0K7vfHAq/7McyUk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036a42fd-e0cc-489a-f479-08dd65d7673f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 04:43:18.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xBJfqY+XNNL6ZBYqT3YXXBVUgrVK1cnEytBBWXikTes9YacBQ7GE6/3sZVeVHqyBGsc9fTnWkSRfwQNKCM/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

On Mon, Mar 17, 2025 at 08:22:35AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 17, 2025 at 06:53:24PM +0100, Andrea Righi wrote:
> > +/*
> > + * Return the subset of @cpus that task @p can use or NULL if none of the
> > + * CPUs in the @cpus cpumask can be used.
> > + */
> > +static const struct cpumask *task_cpumask(const struct task_struct *p, const struct cpumask *cpus,
> > +					  struct cpumask *local_cpus)
> 
> task_cpus_allowed_and()? It also would help to add comment explaining the
> parameters as the function is a bit unusual.

Ack.

> 
> > +{
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

Oh that's right, I missed that between all the refactoring, thanks for
catching it. Will remove it.

> 
> > +	    cpumask_and(local_cpus, cpus, p->cpus_ptr))
> > +		return local_cpus;
> > +
> > +	return NULL;
> 
> and return values need some explanation too.

Ok.

Thanks,
-Andrea

