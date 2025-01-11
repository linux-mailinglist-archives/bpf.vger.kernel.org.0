Return-Path: <bpf+bounces-48624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68802A0A262
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 10:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F1016B6F3
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F159187FFA;
	Sat, 11 Jan 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDOfraOn"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1F12E7E;
	Sat, 11 Jan 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736588734; cv=fail; b=LBQrfvJgcaZhd458w2vF7w9co0+dzvxrt2jvT0b5B4ByOA4phpqHMffZDzgtAqAFc56BenGGtx51QYT84tn5j+CLc9tUNhZA5ngs1KrHdkG4qrK/ATFwLcZcIPJQp1eopUSSQwTMul924PR09npLJ/J/SpCezFLIhcsdSyOl1cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736588734; c=relaxed/simple;
	bh=mp6V2jmOTw1nML6dtSmtbMaUIKW0g9LD5Tp8LZ8IKak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdZSS4Z44EUlMvQGPiLtH20UrJg+X8foJRCFPLK1IJHoybWlJ354jkPHN374dk2pX+T8OgsedtN5p8avl0XICsWWlfc1p8zzH36HL8cnldPO8Y3O8TanIiXqae7xa7Q/ee2CNQdub1TGIeiVAD6j/aNAK/FEQjD4nWQEd2Oymdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDOfraOn; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox78wgWeqM6TFshRiKBL1TioTx/O9njOETmo1Isv0wXm874oEwjdunD0/sNr0Ip3VJf8JCd2+r64nFx9b0a5306g9hG2Fg5+wesWgqk2an7VAsAly5JEsPdGBvM4URul+rss5G4SfaX55sd1HT5mh+2sWIqWc+zUEgVmsVxN5DiFfntSR2y8AUtbX5xpRrkFirtPz7Jkdc3Wxr9BMjnfvUYu0/EUBeSQ6D1B+Nh15byABHmSKMHZ5aaeAhb4wenhTau3dGLhy99IkjZTBH6G3PKT4HtGr8ynZp32+bD9yySwQ1UvgPEPMKxqF/tH/3WpkMhCTrtKLN8MWYwRsoBY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp3go4pKoDFGq3h1uk4pyxl/5AVTGZrGdt4jFUCjioM=;
 b=tjG11+Gw6anJCSt5HYofXIhC4G7A1JMMRyj+aU6wqpDtdPt3HR81slN8YobwXg4TRSh28mUXwK+vf3UqaPD7v+JKWAbg9FHiDxJqtf3St511xI3dMqNid+uvaZI99o6GUjuql3KvWaHutHoFBHxPjvIxBgaixIqZYQc56J3Z/rQPobg4YfyyIhmhTXLDGINUSenVEWH6gINo7uaNvVY4qzHbzwLun8DfJAGSQCJ0h3H04Rej7/RSEbjmFpFo5oyEu+4cMW1QWr+UysBHcNXCIcwdfVblH/hYUn6ZyqfsltfuHYkTXwBo98pcU6X9kqf1iulabGIu6iVXCMLbNySa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp3go4pKoDFGq3h1uk4pyxl/5AVTGZrGdt4jFUCjioM=;
 b=oDOfraOnYA8ucjwnHVvcQL7KGwZiCRwEvkva08vEdWzpyisyMGeBPdCIAFbcnUodiga9/hsqIfD4nQrNrFEjOCanapng9wKZOm/rymmq/lI5YeUzff3ueRuPVKAhLw8cg3U4SsZFY3h/a4ol4FidibzA1tr0Mm3FJfQy8Rygji83XM12O1if6eqkVcEBQsy5Q1jKXJi7+YXjfpJqYN3sWS0VUa1oIm+bUV6TLLqiosMpS5Ds+f+c2R7xpZ9S+nMCDHLDP7FwHaUa2pANR8xS2ep1BO2ZOENfiUAontD3JquCv4EEATGEy41WFCtXVKlxMKjMUlH6uFWUl5cruBnVJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 09:45:30 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8335.011; Sat, 11 Jan 2025
 09:45:30 +0000
Date: Sat, 11 Jan 2025 10:45:25 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: fix kernel-doc warnings
Message-ID: <Z4I9tXouDIVdWBN5@gpd3>
References: <20250111063136.910862-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111063136.910862-1-rdunlap@infradead.org>
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f91051-dd4f-4874-afc8-08dd3224af40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfEK66IebuyIYP2dbOYx5z6RD+m9IzQI7aDIeEyBwOHawDxn4S2mgopPhL3L?=
 =?us-ascii?Q?4zNh0HHsK7f8ifoDRWwrDbNzxzOUh4vDeDu+l8MLeJM4FeoLETIM4Kuzrw3H?=
 =?us-ascii?Q?3o5EoxSIHNoaULs4+6L49amYUhThlSv6pSU1hAUqogOV/piUS4rpxtc12YHY?=
 =?us-ascii?Q?YW/HBCIDZE0eA4kIAGAcHGK35hWizuoiOMQHOJBk6UDOlo/uENs0m+g142MQ?=
 =?us-ascii?Q?qOMLGhy4IYGRf/z6dnxfjy3K/JWTSlLtoWtVblq6kHeYxBdq6ISeC9cV37L+?=
 =?us-ascii?Q?/Az6my4vRT/SVRZzrvSJqkG9vaw6B2LkGw4hOaLKRQvA54ExIys3y0rVV27P?=
 =?us-ascii?Q?AefDU7MzzpCO2t0YP6m2Mqd6PmHRh+xqHzkAHs3vZvNZd0QxwmroQCLMzwux?=
 =?us-ascii?Q?qCopehSyD0NNWykmy3IC2cym97rYDIvoJIuojx5ZSoCV/8Z5FqR+zzhD7+eH?=
 =?us-ascii?Q?36DYrB9hlW6NTLHjx4I6oNOJoT378iHwMPWk8XdZcZU56YK8QNAAHjVLuVXL?=
 =?us-ascii?Q?aCt+8COoCs5UERtmWS7RnNTAVfcQ0lR1xbWNhHkbAaeFwsuTJTtf3dJciDR+?=
 =?us-ascii?Q?ZrlMcJmf71fykRLp5UgBuGBGFGZKfeB2VmuU9B4Njeu43tpWbi85GMjPatMs?=
 =?us-ascii?Q?SXPO/NwOLNXt+BmThRSIhg82sp51B1BJhRGhr1v5iANgaHrSe2CsB/Nh3A+7?=
 =?us-ascii?Q?3uTdoTZOfXkeCuR4Jb3gwcjjVC3Di09dTG+/2TqRfcXBU5bIEfKvI/J6OPCj?=
 =?us-ascii?Q?tMrAnIg05PfgOdh+faU/8K9KV3RDc4dHrOrJwGwr3Qvt0y1Grbo1cMd2azHl?=
 =?us-ascii?Q?eqriwQrh6gCixZVBG0mTUaoygX1GjzGQwaAH65bWZdfHa1csJsYRewUPV9mO?=
 =?us-ascii?Q?tnC5bvfO6p7w182cGd7ukrVaLjtEofR7wkW3zaHRhpbg7ewnsztMIpo2ZMxH?=
 =?us-ascii?Q?HqantVl5SU8mTBMP7a6dDGIEI9aycSxkWycDVLSHjnnkjDrRjjDVa9FUS05E?=
 =?us-ascii?Q?j0H1j4uURjOHQskaWvvYxSHNgupOVXw47N6v5a3e+dTKX1HvCQBqKEPYy4R1?=
 =?us-ascii?Q?HZnPig2h665THOX2VRhL/UkG/GHnTonExxh8zSEC0J9j+ffXJO3UObxFT+l1?=
 =?us-ascii?Q?WNWe+Hha4vYYoCxPwAJUCmNxWrncOODFHYMiUAe5/GW2Vn6uoE/3a+ZiuAk+?=
 =?us-ascii?Q?w0cdvsGFTFaH4byvbaTj7l9VL0RBQOoVYIYT3ZZ1zscCOccpzwPiXofBR0Rv?=
 =?us-ascii?Q?vjK7Hf4oDdiIiTgzL6zGQN18JjLPRYW1sOX8Snzvqw3voSYjLmiCPF0NqhRQ?=
 =?us-ascii?Q?omQ47Lyjcn9byg/JnQv/SflY4rUKKfXSLolT1gjsu8Y3fhR5IOFKLyYEFdEm?=
 =?us-ascii?Q?daCrG9tdLN/hdNFOyOCG1UpkNBYX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3xSNYIMOCP1VoQONXkxGmfCZ8+f6/fKh+WwEr2j6HR9mkGKTM4DXK1HmlxQ?=
 =?us-ascii?Q?ApNRZh1XTlnsRAEgi/MSmr2RAuhQOzo2656fpZxpDfysiBc+T9YT/yU3wspb?=
 =?us-ascii?Q?Di5wRiHgH9D1WW0JPnWmHlyXpv/H6vMhzjqGqgGh8mhBv5WoKNmdMjwqUoKB?=
 =?us-ascii?Q?Ham3bTzRqwzSl+tBx8qQdiqH3LbacfciOQl1njnETnljkJedF7xA8+rhygEQ?=
 =?us-ascii?Q?xSV/i4m5kOpRIuKfdP69x1Hh099L/5pjukG39T0jc2YJ7ieNncmH9PlFslOz?=
 =?us-ascii?Q?bdYpQihx9AaQEfZ2UJlKck6FYrnRoisAZK0P8VXHptuqJaQYJrP+A4dD1syK?=
 =?us-ascii?Q?A0PsXuYsV8jLOJe9fa40cHmmGAak3Dtek0LE22WQxDOgUoJbs6pd5gehT56q?=
 =?us-ascii?Q?sQS+ya8j8EVLCEYwkT0te2Ymvnf5vLznGJYvGWat0vY039Ej9c2VhMGnq/v+?=
 =?us-ascii?Q?bfmWVuoWQxLGE0N28BeN9Nth3SQ+cTqzV03LaXG67BbzlS1dsQpborUoqrNS?=
 =?us-ascii?Q?0Jwg33rCdB9XJSn3IOn5zElSPl12JmbBKsP9nQLzGi4hyR54v3cu0/QhJ5yW?=
 =?us-ascii?Q?jknE31DRwc+5Y6ijnBJW5cj8/BqBiym4xY3MHQOaej7Qc54FdpDHrmN21Xz7?=
 =?us-ascii?Q?8sci9wqyGf0zfKzlYFYRAE9jbBOc+1dTSvp/Y9ZAeg/nvpeintRMORwKS1VQ?=
 =?us-ascii?Q?C+z08ifuCYWgXo2NaQzG1vJXAnmJCwB7YuE8AMlGrmVIxdAyoA3cdDJzZRq6?=
 =?us-ascii?Q?kGndByAfbXUlq1pxcdnZniercPnw4aC34W6hpr3vEieD2VjI1IH65y7uwj+N?=
 =?us-ascii?Q?yAqh50BWOgaOHxwlzwQ+iGBu1PZW43fUUvK3oANI9JYMtbEsGGCLy5w/koMi?=
 =?us-ascii?Q?MihH3loCUmdvRJSojKUApkXrponQhv0LKOYtXCObeq5ADEcGqdz6/84INg6g?=
 =?us-ascii?Q?xVBiR/hs7tnogsO0plDeQ1+9luYrKEiJKhNFYwWnCoABR8AQ0LG1glzo97ZL?=
 =?us-ascii?Q?XepHva4NPOZGLFnt4gbeKYh1zric53dUFUeBoa4GEGV6lLHC9jY2UydP3r/g?=
 =?us-ascii?Q?oPkpyHTH5472SN/pc/22NpQ27npAH5SFZ5suFDFzghgMqPTKw9AuQefFFc8Z?=
 =?us-ascii?Q?HTCVGQmqzSgp5bEnP9wskLjh+b67kuzQL0RoGu9RmwPErE927zaF4hrhpm4/?=
 =?us-ascii?Q?CB7Z9BB7M5xZEmwbrc+ekMr2eYu1PWJrSKW9sdSunpZeMUCCvvuwUzGgy4xS?=
 =?us-ascii?Q?CJw+fH1hm4Ys6ygDWX1VsyH+lZPX9XJBIU0Bw+n918KUDh+jLYn2KCIEQIHD?=
 =?us-ascii?Q?rC1G1ZX5IaGbvDP1TO2or1b5azzWtr5l1Zp83GuEihffoUWiG+XdmGvNS0Gc?=
 =?us-ascii?Q?IWbXoismWwNv6OAZXztp6tr0P6rQQnsyPZIuuS9SGFxHi8OxKGmLJHGuberY?=
 =?us-ascii?Q?xZkBBw3hyI7NqZ+WUBSVm0zdksKWcgZx19uG9Fpu9SOTeQ0nRJutI442Y5KN?=
 =?us-ascii?Q?GP53IhQFI6VObBfsCQcWIpxs+UpjfMbTuTFV3zq29j3/Y2lnLxv0Y1qex7N3?=
 =?us-ascii?Q?bHoyJ5SxaA6Ohfv7JqWV90dGUIXE8nyESrnR3kHw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f91051-dd4f-4874-afc8-08dd3224af40
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 09:45:29.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU1neN+V38yIaSc+9S4lp4TzHDqq4bKVVkQfgwQzjdHp5Y6HCca5uRCvwJt1HvAnYa7AAV1LaSvIlMFIuFy1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

Hi Randy,

On Fri, Jan 10, 2025 at 10:31:36PM -0800, Randy Dunlap wrote:
> Use the correct function parameter names and function names.
> Use the correct kernel-doc comment format for struct sched_ext_ops
> to eliminate a bunch of warnings.
> 
> ext.c:1418: warning: Excess function parameter 'include_dead' description in 'scx_task_iter_next_locked'
> ext.c:7261: warning: expecting prototype for scx_bpf_dump(). Prototype was for scx_bpf_dump_bstr() instead
> ext.c:7352: warning: Excess function parameter 'flags' description in 'scx_bpf_cpuperf_set'
> 
> ext.c:3150: warning: Function parameter or struct member 'in_fi' not described in 'scx_prio_less'
> ext.c:4711: warning: Function parameter or struct member 'dur_s' not described in 'scx_softlockup'
> ext.c:4775: warning: Function parameter or struct member 'bypass' not described in 'scx_ops_bypass'
> ext.c:7453: warning: Function parameter or struct member 'idle_mask' not described in 'scx_bpf_put_idle_cpumask'
> 
> ext.c:209: warning: Incorrect use of kernel-doc format:          * select_cpu - Pick the target CPU for a task which is being woken up
> ext.c:236: warning: Incorrect use of kernel-doc format:          * enqueue - Enqueue a task on the BPF scheduler
> ext.c:251: warning: Incorrect use of kernel-doc format:          * dequeue - Remove a task from the BPF scheduler
> ext.c:267: warning: Incorrect use of kernel-doc format:          * dispatch - Dispatch tasks from the BPF scheduler and/or user DSQs
> ext.c:290: warning: Incorrect use of kernel-doc format:          * tick - Periodic tick
> ext.c:300: warning: Incorrect use of kernel-doc format:          * runnable - A task is becoming runnable on its associated CPU
> ext.c:327: warning: Incorrect use of kernel-doc format:          * running - A task is starting to run on its associated CPU
> ext.c:335: warning: Incorrect use of kernel-doc format:          * stopping - A task is stopping execution
> ext.c:346: warning: Incorrect use of kernel-doc format:          * quiescent - A task is becoming not runnable on its associated CPU
> ext.c:366: warning: Incorrect use of kernel-doc format:          * yield - Yield CPU
> ext.c:381: warning: Incorrect use of kernel-doc format:          * core_sched_before - Task ordering for core-sched
> ext.c:399: warning: Incorrect use of kernel-doc format:          * set_weight - Set task weight
> ext.c:408: warning: Incorrect use of kernel-doc format:          * set_cpumask - Set CPU affinity
> ext.c:418: warning: Incorrect use of kernel-doc format:          * update_idle - Update the idle state of a CPU
> ext.c:439: warning: Incorrect use of kernel-doc format:          * cpu_acquire - A CPU is becoming available to the BPF scheduler
> ext.c:449: warning: Incorrect use of kernel-doc format:          * cpu_release - A CPU is taken away from the BPF scheduler
> ext.c:461: warning: Incorrect use of kernel-doc format:          * init_task - Initialize a task to run in a BPF scheduler
> ext.c:476: warning: Incorrect use of kernel-doc format:          * exit_task - Exit a previously-running task from the system
> ext.c:485: warning: Incorrect use of kernel-doc format:          * enable - Enable BPF scheduling for a task
> ext.c:494: warning: Incorrect use of kernel-doc format:          * disable - Disable BPF scheduling for a task
> ext.c:504: warning: Incorrect use of kernel-doc format:          * dump - Dump BPF scheduler state on error
> ext.c:512: warning: Incorrect use of kernel-doc format:          * dump_cpu - Dump BPF scheduler state for a CPU on error
> ext.c:524: warning: Incorrect use of kernel-doc format:          * dump_task - Dump BPF scheduler state for a runnable task on error
> ext.c:535: warning: Incorrect use of kernel-doc format:          * cgroup_init - Initialize a cgroup
> ext.c:550: warning: Incorrect use of kernel-doc format:          * cgroup_exit - Exit a cgroup
> ext.c:559: warning: Incorrect use of kernel-doc format:          * cgroup_prep_move - Prepare a task to be moved to a different cgroup
> ext.c:574: warning: Incorrect use of kernel-doc format:          * cgroup_move - Commit cgroup move
> ext.c:585: warning: Incorrect use of kernel-doc format:          * cgroup_cancel_move - Cancel cgroup move
> ext.c:597: warning: Incorrect use of kernel-doc format:          * cgroup_set_weight - A cgroup's weight is being changed
> ext.c:611: warning: Incorrect use of kernel-doc format:          * cpu_online - A CPU became online
> ext.c:620: warning: Incorrect use of kernel-doc format:          * cpu_offline - A CPU is going offline
> ext.c:633: warning: Incorrect use of kernel-doc format:          * init - Initialize the BPF scheduler
> ext.c:638: warning: Incorrect use of kernel-doc format:          * exit - Clean up after the BPF scheduler
> ext.c:648: warning: Incorrect use of kernel-doc format:          * dispatch_max_batch - Max nr of tasks that dispatch() can dispatch
> ext.c:653: warning: Incorrect use of kernel-doc format:          * flags - %SCX_OPS_* flags
> ext.c:658: warning: Incorrect use of kernel-doc format:          * timeout_ms - The maximum amount of time, in milliseconds, that a
> ext.c:667: warning: Incorrect use of kernel-doc format:          * exit_dump_len - scx_exit_info.dump buffer length. If 0, the default
> ext.c:673: warning: Incorrect use of kernel-doc format:          * hotplug_seq - A sequence number that may be set by the scheduler to
> ext.c:682: warning: Incorrect use of kernel-doc format:          * name - BPF scheduler's name
> 
> ext.c:689: warning: Function parameter or struct member 'select_cpu' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'enqueue' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'dequeue' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'dispatch' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'tick' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'runnable' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'running' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'stopping' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'quiescent' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'yield' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'core_sched_before' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'set_weight' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'set_cpumask' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'update_idle' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cpu_acquire' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cpu_release' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'init_task' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'exit_task' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'enable' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'disable' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'dump' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'dump_cpu' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'dump_task' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cgroup_init' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cgroup_exit' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cgroup_prep_move' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cgroup_move' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cgroup_cancel_move' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cgroup_set_weight' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cpu_online' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'cpu_offline' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'init' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'exit' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'dispatch_max_batch' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'flags' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'timeout_ms' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'exit_dump_len' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'hotplug_seq' not described in 'sched_ext_ops'
> ext.c:689: warning: Function parameter or struct member 'name' not described in 'sched_ext_ops'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: bpf@vger.kernel.org

Thanks for this cleanup, looks good to me. I left a small comment below,
but feel free to ignore.

Acked-by: Andrea Righi <arighi@nvidia.com>

> @@ -1408,7 +1409,6 @@ static struct task_struct *scx_task_iter
>  /**
>   * scx_task_iter_next_locked - Next non-idle task with its rq locked
>   * @iter: iterator to walk
> - * @include_dead: Whether we should include dead tasks in the iteration
>   *
>   * Visit the non-idle task with its rq lock held. Allows callers to specify
>   * whether they would like to filter out dead tasks. See scx_task_iter_start()
> @@ -3132,6 +3132,7 @@ static struct task_struct *pick_task_scx
>   * scx_prio_less - Task ordering for core-sched
>   * @a: task A
>   * @b: task B
> + * @in_fi: in forced idle state

in_fi is currently not used / not passed to ops.core_sched_before(), should
we metion this? Like appending (unused) or similar to the description?

-Andrea

