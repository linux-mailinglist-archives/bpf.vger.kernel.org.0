Return-Path: <bpf+bounces-54101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF4A62993
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 10:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA3B3AC50A
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302E1F3B9C;
	Sat, 15 Mar 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4QM+gwv"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399D18FC9F;
	Sat, 15 Mar 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029724; cv=fail; b=LmRzRWJFs1lxxw87Bpwc+3zaaWKAIGX1UO+f/UZ4yuG0C7PFg8KIt6IWJ9QVgfVW3F4um23L2qDZkvY+s1JL/+++kbgfgNacElpI8GihhNhKVS9XqJmr3s1eWt2GQiM+dWoTCn0gqDkIEmiX/kaRlKpJw76VynpYHdUjdvVBJEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029724; c=relaxed/simple;
	bh=cgqOcTqM0X6XPBbKAoEUVX6K+P10bgTYPyeZvCWgdTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JPi2K4fkd4YSR1JmbIgYK52WkwBc4xVr/UkkLnM7RZHcirUr4FL+MDQ8VwGF/Q2q+XT0JGbx60FdS6cqiEzsYaUwoOhmlTy5T/NTgYqtzQUEBlBoVhvGYQR6oQw1vGCHwrsj3Aa9ttR/vtmhBfnLuyy1bNsWOZIu0GQnV1qHA08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4QM+gwv; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pid5UHIXMvY4y5wBnh6m8DZ10BQP1ZaMWm0+o1emf7/vCoHSwQfi58CDp7E7DDWSjU04mNgfu+SpkJR8CZbaXJUR6/efmthvX/VVD4qgCev/Xm3huD7H23269ybAzTj+0d7yOq/nJSu3aHGBr8pJrB4+IrGLPLYmSIkZZkCG0iT7rb0bTb6ZlEFm6vzmIk7hCKZXCG+5PI0u9ofLlLjOw2TZRs6RX0yPszg6npf4B2vSfRTbSZwsBtHFnPaRyHGQxUv0kkzyNrOflok7r9grkk87DY+OXO/ZGvC7WTHuUSqE0omtJk+7kQar89to3Cc/lldcgo2KFJIDEi5XouawGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Mt5oPIluIZIHC2dy1KjT/rgbHtEnBDHsi+KwluchqM=;
 b=oEZ9nmBAODvwwAmWZc/mfwLxqwO9zyrhNH2le5g6rRiaN1RpP+3CA29SwRNkNMHzZcRaOKVfW+3yEZJX8JXIdwO9UtHI7ayt4NyVPsw/WZQgeQtnib14pU9T9ZjBJfWD9rPWnxbwKuAVss6naTAdq1tZNEZfv7vo/GFEG2gxbTBpLDwqhRzYhtKlEiiEWzBTuF1uwbAh9TIn7gyLGyTwsrUFpKXqxov2IbDKt0uk1dT1oXwrmDzQUj3LaWLGz+h7r/eea2EJhNHFpuhxdgs6JLHRyK2aYxxxBWsE7Madi0wR4eMJ68opZ/2HIa/JqFz8S5j/ppkvCTEJS6lCWL3mBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mt5oPIluIZIHC2dy1KjT/rgbHtEnBDHsi+KwluchqM=;
 b=K4QM+gwvOrtXiz9wtfUIYk449AJDGq6Vvl9IY5+7gsb5tC1JrBPkC+0gDSPKNqe34P98sAZ19r5MrC8O6/LMaX9oPVzgb5j3/yoB+vLpvck/Iw1vJNQuVzcc4zVafJiAKWmFWla6q2N7beg9tulFRld43iSYHAEinBZJGy1JC07eCuG52PNXSDjoUs/mmSmK3G+jJ9V4WIf/okc42n6ywOCqG8djyZLFqVPW/7IbzTBelH6W1oGRxinOoVpCgLRY/Bt3JgjDYRoqICmNtrHpMmvNgHLFNSNZDL9aFjrU1PN2pO/4EdzQco2N+J0VvlxSWC7Ka7/rQE13rmfAx3lQ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 09:08:39 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 09:08:39 +0000
Date: Sat, 15 Mar 2025 10:08:28 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
Message-ID: <Z9VDjLzd8CA-Xf9N@gpd3>
References: <20250314094827.167563-1-arighi@nvidia.com>
 <20250314094827.167563-7-arighi@nvidia.com>
 <b350d05c-3279-4d62-86fe-555ef0985f03@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b350d05c-3279-4d62-86fe-555ef0985f03@igalia.com>
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6a0481-1501-4f2b-66fd-08dd63a0f986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCMZGfoU8FeKwXDwkIeRlpLFABXYYsOv9Hwb9H31GvEiDt0zgAHtV9DFsNnB?=
 =?us-ascii?Q?8KIP8HXiDu+feoAaqj1f5FXGGsq2hwNMFweLNlIPbtf6FGrYYWrkycGjlOZ6?=
 =?us-ascii?Q?J563EFUdaMtAfa2x4zjGg4lnygdr7eulFqTzXd4X7LRFJhZTzgS6p2QTrVAY?=
 =?us-ascii?Q?PdkRyAnpOnYVdJefTrNwJV9uF8nZsd2r86SzjBPSIQ7vCcVh26hxrTklfL5p?=
 =?us-ascii?Q?wHx9S2VNat7JipkYV47PrHSnecDXZaR5Ut5DO+27EBapItJXwm2bEC1hn0/E?=
 =?us-ascii?Q?wT9BKbAaif+3cWRvdBULillPP7I5bSLnShGpLhHDytCAhevpT9G8tj2/sN3p?=
 =?us-ascii?Q?iLH16GAvYqxpTu/CnQHqL1LzsfX4eklZHH4DA/LSnBV+IvPyTXJjo950E5wW?=
 =?us-ascii?Q?0N9TM5dCWVHv2SIPTJq3bDdjXJHbNpDVf9VojjKmYR9aWnfPXUDONNadkfF1?=
 =?us-ascii?Q?5ukl7O/YnNOQ3roe9IA0hIDzA51YHnao0Lfx8xWpDBDFUpAdDvhuns6d70kq?=
 =?us-ascii?Q?L+dkCL4tWm3xJE2DY0dEIbM83pEFE5tUzG3da0rXQb6Z7ijT6nIXKn3zAKn1?=
 =?us-ascii?Q?1+jJzETUq+2y2XsBQPGFhKVqDLQon0tVqw7gcAj8RejkPZ0CrWZ1MjGEbjSt?=
 =?us-ascii?Q?FB1kOuzQl1vLTJZeDIdN9r4HNniGaSkl0f2Vx0toxIvsH7su01ibPE9eW9+2?=
 =?us-ascii?Q?3CcvBz7JE3ZF191Vf5K8Ln/8xSJ8KbmROIjj8yI0nkOwvhQvu2jbFn+9U/3q?=
 =?us-ascii?Q?ScK1KQhEoPKYVHzWnT7Wwb0ptYYPBQ+6UcA5OXND8XGp/KbT7n3Jdsu5U2v9?=
 =?us-ascii?Q?81ssEwbbZpkWXSx9nbz/M2TNPJvRmUNp5PncXVgNDNbvI38SDcy83paAkF7V?=
 =?us-ascii?Q?plvQ1EfwvrSWtdZ6ypYM6FH7TkfoADkMjAlD9X0i+ycBQS5mHOqCCey/IHvf?=
 =?us-ascii?Q?N9mahjpXFUo69sWFIfdsW7vEFdgjamTHntKhTAFGqUd84DK59AasPX4iCCfH?=
 =?us-ascii?Q?7vXTSTvS33kp49EY9KQqlPgv42cpVihKXoXPbaSjoHIpG0mevs2a+IbmjL8K?=
 =?us-ascii?Q?Y2Q2mFBB32OoDh9XnFNUuyGfl983xA2HOTYoqKZb2P8c5dDW8wF/XvBY44++?=
 =?us-ascii?Q?KXAbl5hIPJ+kI/HK3M3mDGobwUNMmO9IRMmroJUGWsBxQeaDJNT7AjRFHmgf?=
 =?us-ascii?Q?MmeMGQ+6v3D0KpldoDIFbMDgbSvcju5rd6APF7Y7+iHmErrZG0rmskULCuPr?=
 =?us-ascii?Q?/Crrw0jN4wFQKl3qLDkpjTsWjMKZ1GNL7W0CLwvk5JDKNOhf06wfGEwHa8CQ?=
 =?us-ascii?Q?feGETef1wGLer/UqYMV3GdiTPaRT2dMaJ38nQXd0rPCw837rzLU95M2ITyYp?=
 =?us-ascii?Q?uWm2Tnxfk1nW8/bLV6mxSIm+Zxus?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4lrKH06jLUvQpnZp6pYCNDWsu9rs1o8Q7BApnU21vbDM7+yTMUlQxouJPlQ?=
 =?us-ascii?Q?z36EsDk5BEhUuCKfvOXQRGq76+w/TWYSfeE3RSSqJKYqw0xvHVMIfKk/IP9k?=
 =?us-ascii?Q?ShvJbeDKEzrD3gLQEqk/zY8hWhNU/7ftt+dL2TJVcI4TI2sfVwqPkqRjkwxr?=
 =?us-ascii?Q?tLETqysAScRjNcDG98BTVAGI0Vp7CtchbYjRDEBQPgS39G7hZUf3+tWhzVzO?=
 =?us-ascii?Q?6k8ub7u5rCotUDINBirMIl9Uk82qrZ7UsaX+yiBlNp5fRwLh5vhzKAedklE+?=
 =?us-ascii?Q?sYMOGAZU4qVn9XMgWANqYEK64IfJ9kA30Xv4h0lI3ctKOQy2VFjVlbUm81oZ?=
 =?us-ascii?Q?qiy46S13CuWCl0i3XM8JQUbePiIpbOfb/x+s9g0eJRJ6OmO/rE7AD1VkHDgr?=
 =?us-ascii?Q?KyEEu31RiQiUXvCWDeh1PRqwtIlcwPA/UbE3doRqysIqR1MyveCmYBCovMdh?=
 =?us-ascii?Q?9a22SwHU+p89u7IN6N2pDrr4Tt+URESg/JQDtDFSwtU5DF+bALjQ7wAQ2HNT?=
 =?us-ascii?Q?+1Xu8913LSTKoqMhHgGqJj6KG5onEO+LOFkML9iV6ZhaHQluO1zJWvta6L8B?=
 =?us-ascii?Q?oCMyQdF5nH+bYbQYHPguMGv3ydYqs21M8MAXe2AmhUjyxbTfD8e3k9hzW7Sc?=
 =?us-ascii?Q?ROJiifzvs9HdI5fJkM/nQYwOmEVr+0OsVVebHEi4lfpZZV0jr9lEQTf6579K?=
 =?us-ascii?Q?69f1v3QpsfhgKhD3GhhcDwYOhh6hvirXt3wR3fLD1UarKSHmPZqaAm9/DgdA?=
 =?us-ascii?Q?n7hM9tQ9+qm0qHIwX6UmuL0AArPjMynHREzprGIJlIIZmCgJkrGOJnYPGEj/?=
 =?us-ascii?Q?ie1/6lvzqj2RIq5EavXzpriKMYRRI6Pqa2eXM3DTel+fj+l05jq6YZJPrxah?=
 =?us-ascii?Q?KO91ZcujXQJL7KBOgwjBvL/toZiSvzLGK+gmyBqN18OsNKoqaHO6urYEHQad?=
 =?us-ascii?Q?Hb1LPV3COEGwcY0Lu9+uvFm+S5c1ATEf50rUNZpltRoFsGWEInpeiTZ587DI?=
 =?us-ascii?Q?uMUktYan0kKTMi8lBboBnarBmjQZAfmPJeFr6DAobWgAJkIdxUbMWqJvZWTH?=
 =?us-ascii?Q?i1kLLS7RqlMnAgup7zczBg8itVJX236FZSlpF+3pvmVl4cLauSjPGcSMqBOy?=
 =?us-ascii?Q?IlN1B/YaTva4U2Z7bYyVyy+fnbKUttb47U2bGn8wF0IJjrTFq0ll/DnAb/Cp?=
 =?us-ascii?Q?ZMyCUm/T4kq+Bwkh8/Ldsnip8B8qvMG+zbxp8TFBqoy4VnxZTwZNtgVej4Qi?=
 =?us-ascii?Q?S/j7eW259kaI4yLSkl1fp6xXnkbcD1pV5vRkmFhzVMMDpckuuxHq6PLoT7KH?=
 =?us-ascii?Q?Bn+hbSqsoNrZnp5PCcj/CUY8QiCQvMVvQS+gpkXPekzcc0tdcEcOkfIHDuto?=
 =?us-ascii?Q?/Ws2EDiCV3FWjLHT3eqIamPKUNBJ9M27Wpby6wMkK4kxzaoUGEJm2wcyFM+e?=
 =?us-ascii?Q?UcUBnKtBAoMxNZ04gP1x3XaWz9ytcp5i3bjkd0oEgoZppOa7Nr1QsJxyeGnJ?=
 =?us-ascii?Q?UN3cBY5JU7ioeWH4dmBeykozIFkyEAZiNfP9wwVDJaegLubt5rwPJaDWH3WP?=
 =?us-ascii?Q?pvG7Z6i610c/Pba7j4Wxz9eMjPaPz6+Xnq53Aevo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a0481-1501-4f2b-66fd-08dd63a0f986
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 09:08:38.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxgDdknppctI8xOg8UOa3BPjAPaub0jU+sP8fIuKEtT82trNs3oFWywvBgrr4P9NR4wi69miXhQTikPcfHjSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729

Hi Changwoo,

On Sat, Mar 15, 2025 at 10:35:03AM +0900, Changwoo Min wrote:
> Hi Andrea,
...
> > +/**
> > + * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
> > + *			    prioritizing those in @cpus_allowed
> > + * @p: task_struct to select a CPU for
> > + * @prev_cpu: CPU @p was on previously
> > + * @wake_flags: %SCX_WAKE_* flags
> > + * @cpus_allowed: cpumask of allowed CPUs
> > + * @flags: %SCX_PICK_IDLE* flags
> > + *
> > + * Can only be called from ops.select_cpu() if the built-in CPU selection is
> > + * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
> > + * @p, @prev_cpu and @wake_flags match ops.select_cpu().
> 
> I think that scx_bpf_select_cpu_and () needs to be allowed to
> call from ops.enqueue(). That is because many scx schedulers have
> some logic similar to scx_bpf_select_cpu_dfl() to kick an idle
> CPU proactively.

That's a valid point, it can be a good opportunity to consolidate the logic
used in most schedulers, where the same "pick idle CPU" function is called
from both ops.select_cpu() and ops.enqueue() and have a unified core API
usable from both contexts.

I'll extend the scope of this kfunc to include ops.enqueue() in the next
version and run some tests with it.

Thanks!
-Andrea

