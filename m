Return-Path: <bpf+bounces-53503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D6A55605
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E985E173A65
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2D2702DB;
	Thu,  6 Mar 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nH/dVGuR"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291425D541;
	Thu,  6 Mar 2025 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287287; cv=fail; b=c9LTMdnQHzV6M6NM0H2M2sNDNE2ChLDfYhemAgWbomFLXDrq9+b4RL6dxSWTuqxuY/ZttoVyhsxrLKk9hKDQK/Xh/ObXg/3UR5hA5lDFwJKX+f7KZkcHDlUY2u9z58VEbttFmgfkEtpGz/bjNOjQtrlwBZhSCWBMdPouZ1g4d6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287287; c=relaxed/simple;
	bh=JbK/LN6s90RD/XGeVWowa1k1Q4lR+7aZCjoIu3zt8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+Xic+1HQyf/TeAUFcG0QN9AS2sh4BeCEL8W6AggRdl3dryHC3pS8rJzrZZwanoZpq5j/Q+3CRNSBQQbZsBa9xzqXtKFg5IYx777OWz3O5w8fqwMD7JvI/IXqYIl4Ehj92UvemkhBFesJ1IUUfAAdPceLWUFxrCkCYGRFqIirfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nH/dVGuR; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbwxaIov2oOsnJOTXC5N/Aq8O/Dj0eJMOf/wTiNrTBt49HlK268wQxmtJUWmY+sqhKDY0kZu4Ppb9eJ32ZSrrxMV1CdxhOWH77nerKFpO9VFLI7sKLVeyRumJ4UhWZwFul1fTZesqYhn4h+WKNQRlvkjdeEnoixLBZAc8Qq0TJPBtFL5azteclm6NUcpEJqNlefniBS819rols1NLm9qprHiim29E/Mcbr1uY8FNGBXjOieGSl1ykI9l/08dFa+v1wjAj1L0kcMVmKVKofpKZF/GPBI5cK1jrzZ/RT/5WnFSy1qUNHk9JfPcY7GDJIJ+rLkOueChPN2JHcrHY725ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWoc/rCC+zYssdVHtSa2L7pmd7F/3CbBx+u+f/aSh9c=;
 b=Mi214EVjkbvJACQDZXG8a8qWmVGRtl2nGKC8NCgDm4Bk5j4rsrDzvzeSsefrkct3LXVPxNoCAoCgAnfvHffvBrKgcN2eMm0LbQvYZkFcPjb5eu/ir2/or8OcMYWyK57rlEsCA6VJWiXcCM6uiUHzyRYUVk13raO2iC92xhVt4qlgZB10v1RTOtCOd2uQM+4RY1jzLgh07e8zEF9ZUhjkH/FPeREqQACK2J9nd6YobxkICs0rMyjyffv5N6a9Oj0U54vNQWL4FZYYaug8LTMH68zIQ/oRRE5NX74hHQokPJWrdxLoZsNP/7fiPHHLue5AHPFp9R15A52uVRHw0lxU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWoc/rCC+zYssdVHtSa2L7pmd7F/3CbBx+u+f/aSh9c=;
 b=nH/dVGuR6SUrVtViM2ur0eDvc9N3zEkG4g6lfVqbesZhQFwGike8BoDTiTrewcGlyNcTMD4Wi5aLeZ8IJ9bCJkz7fWTYJxIeRo76dZNHt5QeG1uR/VgvKFSEN6uhAONph6lc5c3ivp/7bdD7d65l3lsk6bXh4Le+VJ8l4MU+tOAfjRw6AqwXBu0WxYNnzlEWEQ7bdoPmpTwpm7A/2zKJTblU3aVYxGOg6trDyMzMvtizBcOfVBzZQOhifam/+Bvk2xMXo2x5GJ0AEE9v1R8NjpEwOZD9O7bQqMzyow+oY5ks1q1J9NsP+KCQL3LDhk8hMA/A6HH1Xva84XkI6TdrBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 18:54:42 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:54:42 +0000
Date: Thu, 6 Mar 2025 19:54:34 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with preferred CPUs
Message-ID: <Z8nvam-WarNqdLw9@gpd3>
References: <20250306182544.128649-1-arighi@nvidia.com>
 <Z8nqpyEQmmff9E8X@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nqpyEQmmff9E8X@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: ea60a80a-16cb-4dc9-740a-08dd5ce05ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQSRT/29oILQiPyq6y4yDrDkvxY0YBDCbaDj5YnobHZN00LaAk/DFnnkGAzy?=
 =?us-ascii?Q?F+QkjKQKpa93oZ52eSqRS4BQ2Zn5/olyFUQztbA4bj8XX/CuAkHige1ZJdgd?=
 =?us-ascii?Q?D32cnk/JSfHXA+/Oa0a5ixbkbqO+5lPuyP1UE8P2n33+uEIhSebycNz6OGhi?=
 =?us-ascii?Q?wEGZvQRcyBKdrfX6pOwrB8w2YVqqx+VCKK1k7yNZv2HuIj11c5gbQUBuZ0wH?=
 =?us-ascii?Q?r4eUpVv5Rvah7mW8rYIZriUkzp66tg3pOvpenoDaNlEvjTVlpRd4ihGDa2Z4?=
 =?us-ascii?Q?5AqB87h6GnA2qzJW76Ny7t9L0LyGrTcmZgC4E65njhr+mgRmLRhbb4gIOLvA?=
 =?us-ascii?Q?CLfDLvk1+yU79Nbzd7050GbKmgQPfVLKyzWrnKi5Dp1xaKpUU4p7FP4NvyN1?=
 =?us-ascii?Q?3Ibr5ti0DrYm0QwRFQwlHoGid6j6PCuz6UVbmpBHxb7brEtIAt5+N0GJJaid?=
 =?us-ascii?Q?bR5pFSyVb+hUvvxFRpNC8tzjbTbQWODRF7RMlMDW+0163HATao7ILgPc4c04?=
 =?us-ascii?Q?jZ3dgv6AgbEgot9p9JMm14qQCUbitv20+AipVEOU+c+jk0TZ4etlTkInfeHR?=
 =?us-ascii?Q?X7VyM1I8uNengxUolldiqAZRJc3Zxp292YXkk8CDy4/+wPF1ZWkvyw5ORYbo?=
 =?us-ascii?Q?TcAzKigih5xfHo/Tueg9AK+7o/KXlRdyGCA9vkwL0tNrauHchXyVNDKRntJB?=
 =?us-ascii?Q?ow1sZHuQHU6j6tONvsmjFfZ64y6dS9go+ulrwu5RJzy8d6y8SeaQh/0KLrp1?=
 =?us-ascii?Q?o8zP2+Pbri96Pj32oRuUS18/Jv+Qzm39s0QO94JF3Bu/iMwBm5Y7uI/Px8A6?=
 =?us-ascii?Q?e4NtqFfyj7yAuR54VqnCjl8KV3eQtv0Hh+acn3Oi4ZgeThIzWotw6e4RGb9R?=
 =?us-ascii?Q?NQL8btyskfDcZZckquIiyPhPI8Ls1yar3CuP8SfZGZDGMHl3+uovlH++++BX?=
 =?us-ascii?Q?WkC2V6SXcaSVNwDutZswXg2Gw5A2DF1n1BU6Ij4wakDDVL7po8bRqGPb+e5+?=
 =?us-ascii?Q?H5ERbF/X3TWtwA7gwoq6rOX4wQbdlEBC8S4u1hczcfxUtt1TbzjwUjibajgn?=
 =?us-ascii?Q?+x4KF0FKe+iJWytC/STsDIK+X6KeajzkVQGoDwjkeQMvUSMJP7BsIMTHU3xY?=
 =?us-ascii?Q?Gl0KHEeb7ECGLD++oW8Sx1cHdlrV5yYYBSEKWJ1otrnVtCqGe/vBbXl//P5Z?=
 =?us-ascii?Q?Jn+WQtUUWyXirrW3gNV3lALepJEnqwf22lInAMbE064jcaK1Qqjxxb4urbGt?=
 =?us-ascii?Q?KySmFQwZf0femrE9GqIp6BSXII/4vD3SeSocVUHPdzCQOJWNe3rvveGGMrKr?=
 =?us-ascii?Q?gmWwyEmQBvLW5KidQUo10zEQmX1hV6f2Eby6KtyS5TFm1y33SBNuA13Rt0PH?=
 =?us-ascii?Q?47wAhiGZ678YaMEZJ4E/tGn2bXqp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h+mUN2YdNDoY26V1uJeTCH+izicTLDt98idhOFafqAjzPqWymUvuCZViNd9v?=
 =?us-ascii?Q?fWrSNq4ipdkwO2wafk+6tkQGR9BYA+H1FXaapoe8F/2yZ2uaVIr84MMzOPDL?=
 =?us-ascii?Q?z/07MfJqEcm7dSztoS1R8aJyjG7boi9Vp8URUX2QVM+ZNc2MA0YQ/2Zn+Pd3?=
 =?us-ascii?Q?FMi1ik6OTM4NeY+D3pny+SKg8QsZTnGEHwX3hDpAGHy6WpitFpMkeFf8ka2F?=
 =?us-ascii?Q?WuWpOSguHrXuEphbQ3ZoHJ4BreQXnRGEVLHKHVufr15Civ7Wm7TRsjSGqdXD?=
 =?us-ascii?Q?8jOAGsuT/OguI2gdzggLgiWCyZHTPayYnC/pddKzcYg1p53KENFcbqiFy5+D?=
 =?us-ascii?Q?ObYmcWFAEi8pXlYHtwj8H1DQ+v8cd+F+bRcTrzkbQW1eifTFuacUDNmB7uyi?=
 =?us-ascii?Q?6HjbWlnl6PWn0lHt+zcCXi2zDXnrk6jvvWVETxOYq1c8DoPCUSa4TzozNagR?=
 =?us-ascii?Q?28FoDUHXzYoJhXQmda1ARsm9zR5XjMvqIhx1ehVK8Nm9UdpKAsCweDsdNIgU?=
 =?us-ascii?Q?N+OgObiIBV9jbS4z2Oht1z04/o3/meXUKnsEW1zjIckMcPkqJyXQzWsoOOSr?=
 =?us-ascii?Q?NHuemdMuMDVfggBFvdzPW8GlE4MkuWEV1MeYIM3DIIM2/anTUOqfxeyR+Rbg?=
 =?us-ascii?Q?b0SJf4qfkw9xa9k4tEMPNcdHa9F/V5BPw8pJmkr5K0bzv+nCTd8YUa1fxv0X?=
 =?us-ascii?Q?ug6Z9WV5w83BrGTTLgOl0cyEyJI4LMXz0wfeIW60U1Zl/9VrTlsJ2ay1mYtL?=
 =?us-ascii?Q?ndGVc2GuodEf2jJyxKp3PJiWhyA9B4gH/3dtrip+K9tpl6fLQcyXyo9Tw9h2?=
 =?us-ascii?Q?mxCF28ISID4O3NfbkUE6DmRJ9Mx5nhixD4bs5+V/bdiFiAnyuoUxTei6683S?=
 =?us-ascii?Q?Jm8rCq0aMJZXBLmtmjGJgMD9XQQLLb93kskkMgzLjJHto9UAiDP3u5SqWpKV?=
 =?us-ascii?Q?hmGF3ZQGJ2FnpBUa0pMnz6l3F4sqPw2yCCADOT/DV9Uc5GBygRwJJNNydJzl?=
 =?us-ascii?Q?DI0Hy2GRAk5yKbKBR86l+7fIm34wZzNfV5gW0Foa/jmFhpe/uIXxfyBWaz8X?=
 =?us-ascii?Q?+2ZF6eHk3fvjr5auP1Pid9Lleavks2do0jPtmc71ew9moRxvE10rPV1NEIZU?=
 =?us-ascii?Q?DHSMmi3leoeeGy2RHQBKaLeft/0OXXTX9v/sXw9TwQsiQT+wtfDP+PYRZ1ys?=
 =?us-ascii?Q?2RJ6hrMzyKA7AD0Tgyo8vUlWK6IflqaGn1aSBOQx7repvI9AMtj95q3OnS2i?=
 =?us-ascii?Q?V+oZhDwMDI7AH2UgPOvitfv1R9rDWfHYKSXRsVWeFeIFglJFvenDR0SuS+iR?=
 =?us-ascii?Q?MniWtenMrVPQmdMZzRzM9+XsI2Hr9MtJ6stjBqEuBnzFmtjbpmKxmqFh5UWr?=
 =?us-ascii?Q?b/nzq0FEuGGOXjoBI+8KF3eL1pADkn9lCyE3bjeAuG3EGETsbiHxr74/xqtz?=
 =?us-ascii?Q?rzZYVL2rmYR2Fh4+A6CX+//8psFyCs4B5WRew3C3AODdkdyQpigekuO9MLua?=
 =?us-ascii?Q?vFUc4K0NtUpgyWnkBSppd2z3OsAWCnJD0z6hYNbKHzzP9zcYCM0ZK0p1N5a5?=
 =?us-ascii?Q?zqQw8R2qqn6ONtIDs3R/ZAAnplEsbyqBxbnu/dfE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60a80a-16cb-4dc9-740a-08dd5ce05ae6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:54:42.4878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI5nByWyPK08lLhScC+Hb3tNEpj82Z82vtnks38hUahEbo+qmtDXxMXoBRdtwbTVQgi2FowgwVBKWx4DSp4NKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

Hi Tejun,

On Thu, Mar 06, 2025 at 08:34:15AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Mar 06, 2025 at 07:18:03PM +0100, Andrea Righi wrote:
> > To implement this, introduce a new helper kfunc scx_bpf_select_cpu_pref()
> > that allows to specify a cpumask of preferred CPUs:
> > 
> > s32 scx_bpf_select_cpu_pref(struct task_struct *p,
> > 			    const struct cpumask *preferred_cpus,
> > 			    s32 prev_cpu, u64 wake_flags, u64 flags);
> > 
> > Moreover, introduce the new idle flag %SCX_PICK_IDLE_IN_PREF that can be
> > used to enforce selection strictly within the preferred domain.
> 
> Would something like scx_bpf_select_cpu_and() work which is only allowed
> pick in the intersection (ie. always SCX_PICK_IDLE_IN_PREF). I'm not sure
> how much more beneficial a built-in two-level mechanism is especially given
> that it wouldn't be too uncommon to need multi-level pick - e.g. within l3
> then within numa node and so on.

Just to make sure I understand, you mean provide two separate kfuncs:
scx_bpf_select_cpu_and() and scx_bpf_select_cpu_pref(), instead of
introducing the flag?

Thanks,
-Andrea

