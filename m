Return-Path: <bpf+bounces-50851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360FA2D532
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0423216A950
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA01ADFE0;
	Sat,  8 Feb 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ez7WtAqH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210001A8F93;
	Sat,  8 Feb 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739006387; cv=fail; b=h/pIxsI3WOZ/gxHRu4RuTqzdkPpVXkPS5YbWQXvKLIzQ0fP22Q2v9hMAiHmNbaGUV6Rco/i8VTNL/c/59hNNQx4dOzO/ByhWoB+O113fs82KWp29ZfTOXB9fdhrwm8YtsvCJCjs/s5Y3Yy/uwtb4UPlx7EfDQfHWpiKHcuRKGXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739006387; c=relaxed/simple;
	bh=zN2RJ6Y69/R1B8LPA5A++9qdgCL9uyWfw4uUzZGwaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tx0ZICA/qPDzfmQSI+3ILZIHFi1GvhReNb4ZahN91JZ4mUMAValUI8bhxQym2Y+r6eEFvIqv5VzSPcFONO+WobeUmvM/LBno3DAIiwfiMgLnDgZ55skVDrGZBXSoQkwcGFszwVR9/P5b+7nMBcawQ5AD5yxaDvSXwhhs6d7zIL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ez7WtAqH; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSFk+tWAiVS3DZh9uFgaq9T2fVvxS71qV7s+cPryJOCNaKhiJHRRH0IkGhudIOkIXiXqW2DlJ97zkVkCGhvO7tERzBsw21pOvw/jHiPGdnhW6BXSHDxESHjLBFxdKV77htrcN2je8s0gaeb1dhjfc+ImaWRCFcZJHQ+WKOy+JqvRihGPMTsEJwZffAfVp6uxu1sFFECeiUHVHhM8vgJFJI791E0jZlq2Ar5CGUmwgZYZvv1FNLtkm4t1kNYqXgVCf9n45Hk95ds3LArkJVazIUBQh/6EHJM8dRc+wJq7C8FZQ1VuPzvixQo6RzquZVtWuEDWazmXP+ULjAWjqGJ8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCXlSoyNeTkWrRR5bVA3t63zNn8cu0VhU94gJ4q3mz8=;
 b=KntEnY4aEe0TPxVP6VM4Heyo4Bxh/CTUvZKYY5sNHKdbeaLVgDewwjP4yjdc5hnZezNHkPLZzOc1dWfFNG4+EaNcMKABxM18DoqqcJRWlXfJY6B9Swg7rBInYmfRIK8Npu/Sd203C7QBU7vf0dBvFFewcCg8OLKQvYUyFSgHe2OyvDkFAxiPSEaaEVLYRBm2YCyvlcCBgahVjnDdpbSwnoe0N3gtMSUP7F1ZOwfcVJDtrGAcOkWDTnVOxV7ApcRcapqUe6IMTr25BV9cZ7QnTGij/Rm4Hkkv+Y/whwpc0ZlmfHa0B13oflFVCEzBOZMQTP700ya2g5dL0LGXsEoqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCXlSoyNeTkWrRR5bVA3t63zNn8cu0VhU94gJ4q3mz8=;
 b=ez7WtAqHOCacJiQ2EJs665xeKsjuof3t9pDMXevWBr0E26qookQFhAjk5Cch+6WVVAXlSnLa2yigVsMpTtTR3NCvXrZBttVL4jHJfJQkOP5lY5L55fMO9Gm+4x71hAQNjdDRl0TYxCMQoxODLkMGshB2+TE2l7WVO3VcErI8ggzuazTG4J/5bhiywEjI5ZYuKjvEWuDSgZRDAZarMCjbf4XNNdp7VUy9Vj/N3KchzkX9Nz+f0Drfh+UR6J3TOmtcWTrmj8axv8TIqrrSK/0fGhrx7L1eqZRvRE5E9GtPEzdy7fO0rW8pchQzHVDTZc7i1KOyFF6ROWCtlEQ64knhsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 09:19:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8422.010; Sat, 8 Feb 2025
 09:19:42 +0000
Date: Sat, 8 Feb 2025 10:19:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z6chqn0Xf6xhL5gA@gpd3>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-7-arighi@nvidia.com>
 <Z6aLvYaYlQ3KRZQM@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aLvYaYlQ3KRZQM@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: bc448a19-3e43-456d-1723-08dd4821b89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRlp1Chk0EuILuNKRM9xd8ZZSI25wRhGYp/dMu68PJJ9jfCndykFdY9br7t2?=
 =?us-ascii?Q?BNeC35HL6oho3ebHrC7VLOHfaR42GyXn1KZwbp9j8REJWWFIVv2swrNlfQR4?=
 =?us-ascii?Q?RDKOnV5iDioMUySpKwnBw5hr1J7gUWrUEVDMRSz5cJ6pF9sOZ6VBKC/qztiO?=
 =?us-ascii?Q?DezES8z2KWkv7sCQOelA5RMugxwEMSbCTub8FJPfkYx4nJmWhBjCJ9Z8Zxfv?=
 =?us-ascii?Q?tG60oMrXTPwvBzJ75lECSCw0J0LuGshjUTLrUlQZV8QtRnlLJHYpQ7r+5fpt?=
 =?us-ascii?Q?9svuImK3w11LUdJWKJovAVSCzQ0dcArtO1HULbcMr/tdDRPaPep5k4iLaj9S?=
 =?us-ascii?Q?vHsF+Rvv9EwLlIbnhBUBu1V9qDQ+r7nhNzGdlHzNIY8DK+wL/BWqLVA/qGBY?=
 =?us-ascii?Q?yeoZIMlXXu9TLI2/7+aWBghpZ2r4uNWcv+c9L/+0Mqm6rxvsxgV39Y6jGtTG?=
 =?us-ascii?Q?o0McXffPZciIw2wRN2WCzQ5a7zL/SXCE5nqZQbBHaACPxK6uZTyS7dzMAEUw?=
 =?us-ascii?Q?TV5NQWc/0AuKrP09qkUpATRcGy+yXeIYbEW90bbVjAvzMauNnCti6lAv71Od?=
 =?us-ascii?Q?Tn+D57qDPXmr8FoX42FBOxhfVXo5KTF4DkF5dzdzbgrEPweHQTGK8r/f3LAI?=
 =?us-ascii?Q?SUyQlHgMTObynhzmgqTVgEhrGO+vsUXjJu7PjoFAArS+b6qGVB9t3cPCwqWD?=
 =?us-ascii?Q?wNYolV8vU1mfKpPxeO5jgt8Vwa6xeNsjuEqkRzNDHrwGVzUvygOkf8awSZfk?=
 =?us-ascii?Q?zvFfnRcqDUAp0I8WctJ9d2MIgOGjKeFZj9jmAU7GH+IQPKCoF2zzz7gDJxyW?=
 =?us-ascii?Q?IsuEXDuoESJEM5vHoQhVNTZ8YgTYtFs0JeETxYRP79NCH9RdliQo6HyqQDZa?=
 =?us-ascii?Q?ctgJ3z3lehyE4C5phMQnO8E/Ku/mLX5mYzwM2qa4g7nj4QzHU8P17TbCVV+v?=
 =?us-ascii?Q?AfoX3MXXZO4goDfw+gjMbZB/2B/lHEO+o4UHNcCT/ptgWdl2uncFuX9ffJkZ?=
 =?us-ascii?Q?U+Foi4yJi2a3YsmEMKErUX/zKl9iLIURgmrD0MAieRj5c5lm1poZEoYBp4ol?=
 =?us-ascii?Q?PXRjswqMBqBE0UWXHVJFOAQoGqOKPjoxfiPJs9X7DT/JQh/Y44KX+NHF4/95?=
 =?us-ascii?Q?yJjCpuC6FBFTOxI+Knh91wiOborzcVfcV5YrVe7hqTXRdlFuU94ymRW814o4?=
 =?us-ascii?Q?X4KlNeHDQqwZ5lmoexHatks2uUA/0d/CLM0GLepC2UIahKgfykRW1wK72FS0?=
 =?us-ascii?Q?Zgw/pHEWejXBAkbLrbkchKduA6H46oBeqHDK5+fornE+1CH13BeOUEA7/FUM?=
 =?us-ascii?Q?l6L5TITMcjzmXrCecNs5zs81Lh3mRnqXKAcuoY459Q46ic1aLymGbvIP82lZ?=
 =?us-ascii?Q?X5iIPCG6Ume1ILzVkCZEjnGM6if5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dwX9d1Z7RRO6ktl2GCW/mTCqt/f4Zg+S1Xqn5i5Uw81lYUcuYoHU5BmzBs7?=
 =?us-ascii?Q?6hvfroZmYef5dzdI81nNRzWSnoX+oX/edoY2MPYbbEDs8nhw7/co6GD2/UVw?=
 =?us-ascii?Q?krx5GWmQNIfYXvQxgp9BXls5SE89rILp+hRpLim9CaXQ465+JEzHQjUNgq+5?=
 =?us-ascii?Q?NmWudfpg/aS9vYG9gAcf36QVP6N3xiDxRMhLF2ie3aFWcEAgMBl4j1lNU2bz?=
 =?us-ascii?Q?Z6KN7FPyRWMdxrHM66AN+nZt8N0kfRJdGCXUwCa3LPaA5Tc9vs3jwi3owalQ?=
 =?us-ascii?Q?XAcWkj/93MjVjj72M9iIJAOJ8QhI79XPljKPN5a8DmKHRSSml12rvhmKNt8k?=
 =?us-ascii?Q?8bjPaYSf52V7jrXIPatkWGEgJKeTUjnMWIWmP3TJhdb3nAqArwfvAKS85oID?=
 =?us-ascii?Q?vQiFTt6L8TGy/TUIo7ey+USFeNxo5JhNnrCMzyjn8Vw8kI5q+FK+lqUaqbtv?=
 =?us-ascii?Q?TxKBix9/0Db+XDAQaZB94bb3T7DNytRUWwahjVVsI6WEQhnlRsj7Ot5Zns1s?=
 =?us-ascii?Q?tFMEvCbQIZa5gZw0fFQXhQCrnOM0bLCCU71Za3CdUj8XNkOuS4fEr43bbsWC?=
 =?us-ascii?Q?vIKpDNb1oXKh/2aZub0U6Zm3yXfBtf9Yx+DhCUDJiRUXW4rk9qTSpHezRNEf?=
 =?us-ascii?Q?VFRG24V7HrLIzrP6xxRn4R5YLzQNHTyAB0+Boc+Hv7w0jms92ueT/PfdfWxg?=
 =?us-ascii?Q?wpKKJEIzq0zcI1qz4IqkQYL80X/9NsvuF3DSyb/8RLEnbNiBcsF0tY6xldv0?=
 =?us-ascii?Q?dZJf9YpG8S4MOjZq44R4PV5BVYbGoUNwvDRZRAG0txtvGQ4ZYj/e71M2TcnL?=
 =?us-ascii?Q?d9g5yOdzYsy7ZGpgHUw1pLrVjKAXctP533ZgM8FZMt30PToV8KtcZlXWuwuw?=
 =?us-ascii?Q?D/0lgzTZoAw3kUeUO1mbAO62kZYWqftA2/rlYseCeWqwpk9rZD47bpp+7C2o?=
 =?us-ascii?Q?DFmJIod5gqPTQdSxXZd2tc/cyD93cJVYYpVtmDH7PvX6GOVtGe3yw3WSs7D+?=
 =?us-ascii?Q?T4ogSNDBzskIMkZkdyYMbXAkBKwO1iMovoY3re0cz5DTa+BYFjfecOYrl4cB?=
 =?us-ascii?Q?rcisKLgXhgtallGi+VRV1PU8lN3kLt9S6kRvNgjLVSeM4riT7qpsK//YJWSI?=
 =?us-ascii?Q?YBYUXKdwavhmp+bYDbpcvgruKqDLu95Ydd165X1Pow1a3Xk9n0dnsWh393gk?=
 =?us-ascii?Q?ktjW6SQA6DJftljF5mpkYbuXWv5fYMTo9IZf4DbBkvjmJXAxwQ8M5VuyrqD/?=
 =?us-ascii?Q?CNgz/NtsuW8J6Ul6riNKOQ663vsBj1bsNUwb+TGcGUUewCFfiRzPHjn16QSL?=
 =?us-ascii?Q?Pplmn/d+fdrQSDm/oxhF4o4DSgovDU20XjWbWi84Vr9+nWsjsfRKqmp5R8Zp?=
 =?us-ascii?Q?WGGuEm8ZgUwHB1P1oD4j91vaibZ53mC5tzSEGPq2TDAP6hgv3sLOaIj/OH6l?=
 =?us-ascii?Q?KZ2MAVTCXNCBOWEi/5dyHmcDhpqEWuKd5Pegsc9IKNfpJmA+GV9fpWnk4A87?=
 =?us-ascii?Q?M0miDya3yNyMtc3obV28HuOOW+E+4vXwKJMkxnGkEIt5ChDnu7WUZuH7T0VX?=
 =?us-ascii?Q?nm1hjCHYvKJpcY7uIWuJhZgMROLocBwcm5DaT9Vx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc448a19-3e43-456d-1723-08dd4821b89e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 09:19:42.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxDisZYHfigiESBqZ0ao73rGK6JgkNaohyTycMYKe9Kug7MPW/xS9sNiyOdm9HMDgruwA2a2zy4jClyuiriDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277

On Fri, Feb 07, 2025 at 12:39:57PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 07, 2025 at 09:40:53PM +0100, Andrea Righi wrote:
> > +/**
> > + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> > + */
> > +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> 
> Maybe scx_bpf_cpu_node() to be in line with scx_bpf_task_cpu/cgroup()?

Ok, then maybe we can have scx_bpf_cpu_node() for the kfunc, that wraps
scx_cpu_node() for internal use.

> 
> > +{
> > +#ifdef CONFIG_NUMA
> > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > +		return -EINVAL;
> 
> Use ops_cpu_valid()? Otherwise, we can end up calling cpu_to_node() with an
> impossible CPU. Also, I don't think CPU -> node mapping function should be
> able to return an error value. It should just trigger ops error.

Ok.

> 
> > +
> > +	return idle_cpu_to_node(cpu);
> 
> This is contingent on scx_builtin_idle_per_node, right? It's confusing for
> CPU -> node mapping function to return NUMA_NO_NODE depending on an ops
> flag. Shouldn't this be a generic mapping function?

The idea is that BPF schedulers can use this kfunc to determine the right
idle cpumask to use, for example a typical usage could be:

  int node = scx_bpf_cpu_node(prev_cpu);
  s32 cpu = scx_bpf_pick_idle_cpu_in_node(p->cpus_ptr, node, SCX_PICK_IDLE_IN_NODE);

Or:

  int node = scx_bpf_cpu_node(prev_cpu);
  const struct cpumask *idle_cpumask = scx_bpf_get_idle_cpumask_node(node);

When SCX_OPS_BUILTIN_IDLE_PER_NODE is disabled, we need to point to the
global idle cpumask, that is identified by NUMA_NO_NODE, so this is why we
can return NUMA_NO_NODE fro scx_bpf_cpu_node().

Do you think we should make this more clear / document this better. Or do
you think we should use a different API?

> 
> > index 50e1499ae0935..caa1a80f9a60c 100644
> > --- a/tools/sched_ext/include/scx/compat.bpf.h
> > +++ b/tools/sched_ext/include/scx/compat.bpf.h
> > @@ -130,6 +130,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
> >  	 scx_bpf_now() :							\
> >  	 bpf_ktime_get_ns())
> >  
> > +#define __COMPAT_scx_bpf_cpu_to_node(cpu)					\
> > +	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?					\
> > +	 scx_bpf_cpu_to_node(cpu) : 0)
> > +
> > +#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)				\
> > +	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?			\
> > +	 scx_bpf_get_idle_cpumask_node(node) :					\
> > +	 scx_bpf_get_idle_cpumask())						\
> > +
> > +#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)				\
> > +	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?			\
> > +	 scx_bpf_get_idle_smtmask_node(node) :					\
> > +	 scx_bpf_get_idle_smtmask())
> > +
> > +#define __COMPAT_scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags)		\
> > +	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?				\
> > +	 scx_bpf_pick_idle_cpu_node(cpus_allowed, node, flags) :		\
> > +	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
> 
> Can you please document when these compat macros can be dropped? Also,
> shouldn't it also provide a compat macro for the new ops flag using
> __COMPAT_ENUM_OR_ZERO()? Otherwise, trying to load new binary using the new
> flag on an older kernel will fail, right?

Right. Will add that.

Thanks,
-Andrea

