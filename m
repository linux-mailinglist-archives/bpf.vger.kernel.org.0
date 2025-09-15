Return-Path: <bpf+bounces-68390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA7B57A4E
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180E216C95E
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0938304BA0;
	Mon, 15 Sep 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RmRltNp0"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46927FD49
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938834; cv=fail; b=fwi6MX0wafmjw3z3IhvDr/VMJOIhVIZviSC3AW26xVL3lZHhSBwjG+hvM7eRL2M9M3sKY5editY2mL4I6OoCaHVqA9sEWusa6+dlZsv459v9IQK81plUXbIjOC6H8UDK3rOysG9PyMgFQ9CvnmR+WqIkrg5ryvQiTDN4tuWW5NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938834; c=relaxed/simple;
	bh=tk4DkgY/rXT7FNk6LZgkuXNlqxYEwUdDAMb9gCupXHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=un9m30cRTzzT781c4OVGh7v5tJ9B6fmMnhZaJj6VN3qwuFWe6IO9KG4P1jnJyinmgT6JcnJufeHKsQ+GeEcVGdXyHitQqRUzBOMxzZWy0PU89HKl9xMLx0Lsm0njf2clV6YRMX95bjZPbUsgA2I9gHtxzkA4TVx1jh6dPTS9CHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RmRltNp0; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oun8+fORRWwTclSGq0LlsDeYtAKSnHoMlgcAYAUYA41OJGovpFceKn8YIr/lyJxm3UxlYk8QmDLMteVPO8AOF0IxMrokpcAQJm4l4hiZxiegdgWsXvvDA42b2KuTdb1PYQxYk5wS4HbweScgISdp7ScNd/tviCd400XNbCeaSzeYiTsJ5gAQA9TdvAmYn75ZEureTcrqgZQVptF17ZrWHKyUP8JBjXQ7R8JzaRfXd0Lvz2MUsoAUQsXge/VTtlO75+/+l6VSuxjoXoTZ9bjhxxWVV8zUrsrFwJnmHVRY8k3J0Wj2rZPAvVAeise2kTMRfRLw9ajqM8zMwoURw5lURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLYQSJXcyqkQHlCc+TNkBnNnYC/3UOnofSKzH1EF1d4=;
 b=gklc2nGaUlqnYq7NODLcw8mKGqCumCV/KuCAL45LgJGD/bs/hRH+VbLLs4fuklzNE20edH5AYaDt01sU5M+tsR3RFZZW7mcpU0IebZ9RbhnXrsxrY0Ia5VjvX2vgLIX3TL6Qhp2AuKk3VzUJOxWFBGUkhoQoMapVo+JsThM7e1W5QdjCx9YlCSiZp9EY8z2oxAsEoQp92q4+bvdyd3XoWAqxFwNEtqP5QIuDGyNLozcFBlIpWszDcJGIPzKp6EMbItQpp+U2Tlj4DSQaLENCfr9RsBFvdRS8QWj/U6dr6YDvBFkSxd2IL0u1UY9GYvBNICRuwIhzuq2I0aePoOzziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLYQSJXcyqkQHlCc+TNkBnNnYC/3UOnofSKzH1EF1d4=;
 b=RmRltNp0vtflMX9yo+uuPkr8EdHzVBg3lq4GrciuCNSL4sggU8+YVan4pA8T7v4jp2R8lWmUz/tv05rqnOOm6JIZ/7tJHU6IhhkfOuIIk5TOJESr5aZhhsDV220Khwp65qcfrZz8bAFkkXfWfXVgITUuw9myZyarnupGUMKFr3/SimYvWCNuzQDPs3KxxCXlrzie8XXnNvEA+gVtWljk7/s9k4Ajgw5D/OhhPmVXXyIYK0GRh3DgWSOPfOMAlEoIGLWRQZwDXjwVJxdRUvPsnqVLrRja8XfTAVublCD9eIkjnnrmun2fAyB+KBvCX2f8z90ybdqDmBvsxEeWMhRW7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 12:20:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:20:27 +0000
Date: Mon, 15 Sep 2025 14:20:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 0/3] Update KF_RCU_PROTECTED, add KF_RET_RCU
Message-ID: <aMgEh9GXHtTXvPam@gpd4>
References: <20250915024731.1494251-1-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915024731.1494251-1-memxor@gmail.com>
X-ClientProxiedBy: ZR2P278CA0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: f39ce6c2-44a0-4541-715e-08ddf4524114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?noSDfH0YAO2mbtAx5XovoWa8Tr4/QEu6DbtMBVG2ahmMn59IHmLcElo6uaRp?=
 =?us-ascii?Q?YtuW0Qdp1e9oClMBZSOS750VCukSjqB1Xo/RCkJiUqzogFyH6/5IauNMQbGr?=
 =?us-ascii?Q?wGGmpIpj7Bz6pUY/Pmzz5wMW0E1RXoHSw9ll3OKqzfD2Wr214vwDnSgQJSe5?=
 =?us-ascii?Q?Q/xJ1TymYb+EzU0HkHf5YaB9AvKeHJkm/ede9KyDKkxeKQAyXNqi9+FuQtLB?=
 =?us-ascii?Q?fz7mhcEpRtM1JpCUciB8mUmHVFgk98AUG25/XW5PI8NllgF7p+K/ygUxHXJU?=
 =?us-ascii?Q?rTNSs1YW1wUw5tHhYPxlVtgkHcX6sK2zdmTiu1Y4w9l4nIavY2Cjzbs8MEMQ?=
 =?us-ascii?Q?g0aFHxqSWnpUjtFrPaq8lraOWVOjtg3j0mbkuL6uJGUACTbOG492XjXedbM3?=
 =?us-ascii?Q?ESZQTab+mDyVnR6kk79LXWS8hlAUbDjYG5nCS68Kd/9Ps7exPzPOFlCX3K0e?=
 =?us-ascii?Q?Wu/idnAdZhCduDmqS5vpffp6upZA2x6S4UME/uPtWKNB3XlOCRQKTo0k/TBX?=
 =?us-ascii?Q?H9R6tfYr2R0OuElDnWTkPoR5gfj3lPXg7Y1cZ61WrmS8nLUqrI01G10MGuro?=
 =?us-ascii?Q?6cWdXxNRcCC3n7UOGcC0A1BWg8A2ZNMA4uRdar+tPuHATTdNIPHX8Clzo/sz?=
 =?us-ascii?Q?albdwivCwWN/9TGyjMriyFUUu6nK6QvrsV2Zj4e6UjYY5ihkR7AZsAyE8xqM?=
 =?us-ascii?Q?LFc1dauET1gIej5B5oQ9OKXzAaVHiDafREj3eexQ8Mj/hSyXTgvvcj3p9Gf5?=
 =?us-ascii?Q?cYZ1BEBQo90jyROnrb9vsIId6hGM+zysf84HaO2K6KvpeThmUKGPp3pl8Ca+?=
 =?us-ascii?Q?vCV/uuPW5NCT+eNgq8hoCF23rlqjOjwsACZtPU2zq62JdgL1iT6VAIbVbpIT?=
 =?us-ascii?Q?teDRg94y2xreplcowZ6Q2H13Jk7XpUTwgdZ46kJeEtwtmFPrBzrLqt5afnFK?=
 =?us-ascii?Q?DeauQ9PvDQcI03Eg0hoQcSOewJ5beQH8m7tl0GxAcYLW5ELvNEywfmFEeyDh?=
 =?us-ascii?Q?n4Y72htHrv7bB44hTrdiMChC01LDJ0IvBif4FNA6SXfhqUYV89nK+BhEyius?=
 =?us-ascii?Q?zInVye6qlDDtzyPQpQun8aRjg53IA/AqmZKMW13ClaSHO8h/xDS4gOt1z1Kz?=
 =?us-ascii?Q?dtTk3tih6KT0OI1+2hZZuoKHj6IDH3psNKm0ekIM1TsIrTRV1JuV+do1IkBS?=
 =?us-ascii?Q?IyuFxBMNbJaNSz34i9r2NwFbXI5pUjmHZjyro0INqTwQgl5/C+nb1B6AdSn+?=
 =?us-ascii?Q?GzrOHRTK/yrSpjRE7hvFIogIcjRNn4uqAz9aocaw+gd0OPEpXnImeXkJNY+S?=
 =?us-ascii?Q?TcG0m7oVc13QwyCVoJB/5LX0+pvTF9SHdS1QKO2lKxWzZCsP6w9+6dhqEIpd?=
 =?us-ascii?Q?hwJlTjL+z5JDDUQdBhW/DYAMFuSRi3OQbwnw/uFzMS4MOqiCcdW5xcpY0tY4?=
 =?us-ascii?Q?O7M8oGr9EM8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UnUq2laG5MeSrUP7ZCRComZpztUzxaDnJBh9hVjJ7AIWgDILKLCfjOorxyL2?=
 =?us-ascii?Q?sKnYD8lHM2F6ri8qXlwPvSZ9EjS7unNRNXjVxrQhmuo7KiJwDgqeTvOF/14e?=
 =?us-ascii?Q?4U7/ze1LCQXdlPTpf6AVV13VOBz3926TlxB9y+7J4ZZhDIC92wfVI2LFQbh1?=
 =?us-ascii?Q?QRNRf4a3ZluPzLnvaphD4f2XK1g4qvSvgLzDZcaixrdc9Cs91FfbwRS+qiko?=
 =?us-ascii?Q?Wv/fSRN4T2C7gGfrWui19/M7ALrdu+rxiE9canBYVsGZrqZyVbi6MMtQDKC7?=
 =?us-ascii?Q?3tKwzJnwJfctGT7l62vL8761ruf0wihJR6/3THu3hzp7SNf0oFnhFDR/LDsu?=
 =?us-ascii?Q?mPafddVKlSQ4yL7nUpwwp5TN7sYZUlwhGM4647RkpEhXT+5cwrPm+J6eQHg5?=
 =?us-ascii?Q?R8OWdLk2SN+MpHp5gBkCdiR9Sf1bmKGd75u5Pc0qULtk/60aoBEI4BhG3tYC?=
 =?us-ascii?Q?TzfdhW5yPwcMIieRNmDsYlJmH13rgCI6hZ9ChwDbMKtjemQWATHYmq7aek7g?=
 =?us-ascii?Q?2bVEDQosxYqDbT+/B6KeSvkA79YRiIuZEhvo9JK7KIfgDF2ogTuv/XPgJ7mE?=
 =?us-ascii?Q?Q8gx7shNJcj1N0nCVFLMTVsQmTIToDdjchADtOTKFE/frytlc6qRwIirccrt?=
 =?us-ascii?Q?yNQ2yoo314JqKAqUEHXt+Zqb6dZb/l7c4/PuslzTwelQwHmoq082ljHIxBKt?=
 =?us-ascii?Q?axWHFFHn8QL7I408+SCuNyfAahzXJkk7575VGH/3C8WS6x+lS+JAMWvbil5H?=
 =?us-ascii?Q?qsfkFLB0SMq6sninw6DKsSNg+8yPU060QqGM9VJOA66+6W8H6v/VFgTrwpVx?=
 =?us-ascii?Q?dff43AqqYVPS9JXUHd+1ImzT8vsrt5X86jKYkjQVpRlNpnW7V4OGUjRKCwuT?=
 =?us-ascii?Q?zhuYCTI0GbQRX+K/5wCdUqxY5A87/LuZTOtBvb5ALgtZq+iXKE3rn2ZiQkIM?=
 =?us-ascii?Q?wlyAJQY4Kqg3Ilu4EIwhwdeeRGKFJ5qEMUExmfIKxpDnF+No8PC0lR0ifFRD?=
 =?us-ascii?Q?QVVEo1MFOXHUD78nAjs9IB9fqMqa6M8OCFZYWb5y9YScm3qfaK3CC7DN8RtC?=
 =?us-ascii?Q?Cc+m8qdUZyWq6pjqWMG6GSQ9Y3E5i7wnaLl0ZNbetrGpIgeDNJiNhtkF4Pq5?=
 =?us-ascii?Q?BWmPB32Pn38v1+zH9/+4RiTlpnvL3dKSZBhovT47eFuU4/Y55NasZD6uE3Jx?=
 =?us-ascii?Q?r1BWCMyEzswmXC6HAK+ISdgG6O1RbMUqDAQ7eNX81kBN4G9keRvxlC9i0P2h?=
 =?us-ascii?Q?WbqiVkU4Es9j6fAFUZeITBuk6zl5Dy5g9CgllBwRy3alQu+GR+LOx97tI2p8?=
 =?us-ascii?Q?vpfy7f+88dYcdv3kyHiCAHzS4qK43cRwKMKkSx0yQhxg9P+ntdNCI2ueUXr9?=
 =?us-ascii?Q?yt5Q5bX4oiJ86zlIDold7EPFLd4lBX3VjwUzKzX/Bh43GWjE+XNnw1Bd722u?=
 =?us-ascii?Q?pYMqb/h0uQAa51WTSSOZ58G1+2Hh5EL3QZfqHcG9WXUISbX5QXwyWZj4Xo2Q?=
 =?us-ascii?Q?E5SRuQTB+cF8UcXpKyiEvjJrmxeUvSeB0ZKVxBKtsYZC9e+hZvZJxL6wpxN4?=
 =?us-ascii?Q?9mKkx+IPvRrMkSQHLQbjPIEPD1AoI1dldy7CoWCx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39ce6c2-44a0-4541-715e-08ddf4524114
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:20:27.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roVooMUA6FVN8fxIvOnUxLwM9gOK15NqmoHb9llPyOPirgTMZ702T2Irqex99EkiGAKP4icWsrDwoF/VWz5BRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

On Mon, Sep 15, 2025 at 02:47:28AM +0000, Kumar Kartikeya Dwivedi wrote:
> Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
> in a convoluted fashion: the presence of this flag on the kfunc is used
> to set MEM_RCU in iterator type, and the lack of RCU protection results
> in an error only later, once next() or destroy() methods are invoked on
> the iterator. While there is no bug, this is certainly a bit unintuitive,
> and makes the enforcement of the flag iterator specific.
> 
> In the interest of making this flag useful for other upcoming kfuncs,
> e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
> in an RCU critical section in general.
> 
> In addition to this, the aforementioned kfunc also needs to return an
> RCU protected pointer, which currently has no generic kfunc flag or
> annotation. Add such a flag as well while we are at it.
> 
>   [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
>   [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com

In the meantime, everything looks good from a sched_ext perspective. With
this applied we can implement the correct scx_bpf_cpu_curr() behavior.

Tested-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

