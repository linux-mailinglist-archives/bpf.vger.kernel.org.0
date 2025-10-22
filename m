Return-Path: <bpf+bounces-71681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40AABFAA60
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26695581145
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED122F28EA;
	Wed, 22 Oct 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/JhsAXo"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53F2F3C1D;
	Wed, 22 Oct 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119017; cv=fail; b=SqTq2g8OULQualV4a5LdHzvaGOBR8T03V/qn9jGS24ZCzIgcoJZLj9LRLZYrkRHmmWoVEDGXXPV48grDVGTtPWjajr4I7XYbyWBxKCdyRaK7RVhdhWlC6VOtdU91ZhK9gqRpZnyOUUNNv0S0xWhdVCEJ/08uWvVKubwCAi4NuZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119017; c=relaxed/simple;
	bh=Zvd4ibBhW+WV95Q5t/wvtJMgE8M6AVHU0oglNkf1Z+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mzwsh9Zo0WrHNh+DJ7AnmcwSTGJirWjAmGDjfdVO2KiRJbsFg0uFwsh8L5UzNDK7gsie1+T2gDLiSgwApCEBbFnos3EqJUtVXNducWwgQHNgJVjF8cJ16YOJAf43cN50ltwGqxrkhPAqE06txFWKrDna13NTBsQnkK6wvtu9+p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l/JhsAXo; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGa8l10B/uX5M9W/0D8tcFBL51/bAJ/35hBvQIEbwekG5jgBzSXEUvaFcrybNzy7hNuL7L+JFe3Knzq5YUit1OqYN82YqQbGGyXNgK5cI+dyepuHeYYGAMWY35Zp2AS16W52gxxZ89PChxiigYARo+pyqDtY3gSGtniQwkiqZ0FbejVFd01wOg60e70ZkNfAqCXMJ2RF+GlgTbYDIGNAcLQFjOR89nESeG4cKnX06QUzLB1uCHBfL4U51cmh35wspc62w7K1A2hxG2lxvlnzl6v2R5UY37YwFNQS632mc5ukiHECzIvrW1hPjfjAl1zZK49+9oKSloCL4brEPMvUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEkufWkbhKWFdJ4nAIJ1t7DsoK6WXxnhthDPcBOkDqc=;
 b=JN9oORO75EryE+gGN03QnBrblUAFDoyXTlWP9wQkDVHQ41A10PPhVY0YKt0SvDmzQf8vCmSbsRZNgGb2zuruMhJNNkATxfwnNbpMBH8A7zK5a0xo8HvJS7E4HTnDVC3M0qZIsHEcpMuG7IQ4Sr/g93fe3TXeic9YSPsOwwtWI7GoG2OgegKwr7+kAn2ns7qYMugunFf7/HBchP59Rybyn2qZhMEkLourCGinFagq1Pas4iOJyQBWmK4mjGVlCdOPGHc60Sj1AR9Py0AIkaD5wCRBLWnpRKMhRY4B+WJIYTAqqRaVlnqaNQuk2BkS12IMtuZ9a/U+xW4iQ9EVSCrYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEkufWkbhKWFdJ4nAIJ1t7DsoK6WXxnhthDPcBOkDqc=;
 b=l/JhsAXoAB0QW+zmDru5tRiF+9oiS6TEywnI5W9E7BH5cGRT34+I7xFyh04nwmTluwEwc0QOCmY7hPKTU8x02yrY3y7nquks5kaVCcnpucPHJaPv7TDXZcQ/coJc7I0sC4JeI7eXgERbX6S07BW+B0oRjY0W3y+n2eNpt8mQ9IpKqOlYGzTyj5X68N8/hA4c/cUm3PRaY1VWpPXe1yJkbNQpe6XuY57ZXevhHYxi8bXZvhfxAT0EnGQQJeg58sG/afl6q69gpVLYl9WdtNTmaiT0x/+D4EEzhv/6mepLe5iepTB99/+OaVBFXBXEhpoAR5E+N/7ngYGZ/0z0+cXo1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9393.namprd12.prod.outlook.com (2603:10b6:610:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:43:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:43:33 +0000
Date: Wed, 22 Oct 2025 09:43:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: sched_ext: Fix SCX_KICK_WAIT to work reliably
Message-ID: <aPiLHWVf0Vp1qUzV@gpd4>
References: <20251021210354.89570-1-tj@kernel.org>
 <20251021210354.89570-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021210354.89570-3-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0071.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 9468c6fd-52ac-44d1-4680-08de113eb36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBfGJg7Pe0xkbWSPMVfPE7punFg8c9b3+lE1+VeQzRq571C7qRLcwPtxWvIO?=
 =?us-ascii?Q?vS8NsjWGnkx1Hj4PmTHOasg6FJMjf6LUxaEpDzD7DRI4aAehddSrLZr0P/8X?=
 =?us-ascii?Q?EllBIQND4fS9bfrSvez07qJPLHXc4X2vN8gCoeDCx2S2QqyGyN+q3k9Ny+UJ?=
 =?us-ascii?Q?bXIyNagvZjqse4pdLWYMa6h3U9VvVmG/oYd/GG+xBzA9rqw0bSKzAc+sCI8U?=
 =?us-ascii?Q?NwsTjxGmgvhJQOfSyjeKbJI68D6YOCCTLAtOCVTmvdLZjb1iKF2kzxv68Pv5?=
 =?us-ascii?Q?4QX/Ub9SnzC/BCqMqPfI5XvoKf0b3LX5qbKmJiNpwXrwfAmZjBwU50tDUYjo?=
 =?us-ascii?Q?g7rgUp7c2KC7GuxOTS3BTqtDf2KewIHp8vNbCH9mKBJ2zgGOy4ocSLPQGypQ?=
 =?us-ascii?Q?g4v6GoMy/dlWFJKEdwIkNcjElh3BYcOVZeH/4EK9yYYkaMmJDTq3lovr9HS/?=
 =?us-ascii?Q?ktUDQc+WxcBrQw5aIlpGFlCfTJxwawjH5jGZx3iIc2VnY7YRmK74li9kEuld?=
 =?us-ascii?Q?S2+RY4zYTmZUtZ6wAzWiHpG9NDg7gB6j42yMnsnmTeWo4lkB5EBmF3KyG9ml?=
 =?us-ascii?Q?P/sS3pcz5Te/h9L/RK1Fv6N+wfueqzY92NkaCgiF3uqyz6ljgLOafsM6LPuP?=
 =?us-ascii?Q?ECSJGiLbYWzJGyffcMhSiov6XqXvCIWLzK2RXISUX/04c7Dj2ZPwOtR6tS+f?=
 =?us-ascii?Q?G7hP0ml8Elc/oLsd+zveHFq5jEtrjn/PnbsBQzlY6Cle4q8DWV4UhPTwRks7?=
 =?us-ascii?Q?P4kI2txUOiGFnLJtEHxMdCZzBYqBgyqYiMvtvSYZ17SEuvSrs7kqoOjfgRed?=
 =?us-ascii?Q?LvULDeg4/73LiLHAzX3+tUWaMOaPHn5j9EkAf+WaImvSrfz8ZMlxCEvK3TXL?=
 =?us-ascii?Q?ZKYV/Dg4tg2GQ9aTNeYeIZ/mKoNOLBKR+6NAQ9jcM3LRM219q9ORYALf4WjP?=
 =?us-ascii?Q?Lw272MM7we3bcngFw/dtPaAsuGvHgaCP/owxwVhk+SgAGLT+8Aw8h7nfIzYr?=
 =?us-ascii?Q?8mlBcXT0XHb402f309A+yfYHcB1b+afmj28lcrhB2f5mU0t6SpizR42jINPY?=
 =?us-ascii?Q?mCuZJ9tWcb3iJ5V+CEqK8xghYxWEa2rzkHUJghYgxGM6Sr8BcTN6H6y3hH5+?=
 =?us-ascii?Q?S3vOVmRLbMittpIjZ9RiA4pGAsFhAJUjKcZBMmNmYMzFKThjp6ZPkFUR3j7I?=
 =?us-ascii?Q?Cb5pECOppU+qzzzP8PGQXMIzUeBpFLLHr26QeBx/HCnXUX+zqcu0FS/8rb7l?=
 =?us-ascii?Q?11jTM4DfY9AYubYDHFZcGAHaIuryIwZFb98fNcsJsJ0nB6aGAtIm/jpudmox?=
 =?us-ascii?Q?O/YvkSQA+lpcHWGc7PPJSyWCq+PZ5NIrozaI6v1GNwExS4Ks5jvSecGhxd5J?=
 =?us-ascii?Q?nA/xC3fuwHpZB0EhVGRKqrTC987YrVes5CTJAXIBsoeXGrYPtQm3aoaOoZm+?=
 =?us-ascii?Q?MyAfoDP+G5aU65aCpUjcWI1oeXIAQMrvjCrhD511WhWbmtkMcjhPKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eh9wi6nXNvnNFZc3m4ZDoXIDxp/tF1Cop7LPbeCNsIU0ssM9m7AdidGF/jPZ?=
 =?us-ascii?Q?JMFQoydoVfXk+Qcn5vLupFIfaFAxpN6gUTUlo1TY7AtzFpZjZf+8qOuik+Pl?=
 =?us-ascii?Q?3B3avPzgpbscO/QGLItoPwUXU7UWp5T+cjFBXxtbSgUN9OUa5VxmpIZ732MU?=
 =?us-ascii?Q?Dg8kV6bKVYJV0+Rh4UuLRuftf7WSArlgaL+uQAAQnXa08FZyemxEiV7Nuq52?=
 =?us-ascii?Q?WTwEQOuUkBWyA6wOcCJlTC/QP54EUCLWz979uTI2VVtZlG05de0lN6zzuQ1z?=
 =?us-ascii?Q?s5YxP9pgKewuvVF2LR+HC+KqpNMuaDiE0msB8lB2KGH7Hxp/7DTdrApod2sC?=
 =?us-ascii?Q?KRHcvT5zopLGa32lccZo8wZabpWn1NTKkEqNxxZjEY/DCjQ2tyHbKhjRVeMJ?=
 =?us-ascii?Q?M8t5mxurD321xgN3+y0d+9sdhowx4w30Mc+xSFOPc8Zdp0YdtCuNrot0buDw?=
 =?us-ascii?Q?V5zFPIWPbU4gendq8DjEqAdm4cOvg08MaMrN7VxSElUAFHEQvmP1FWItZDoB?=
 =?us-ascii?Q?7esszToMt6nNL8S2qXcIrX8LMFtMYmeyc3R48dW3CFEEV00TF7dUMx3YZnNl?=
 =?us-ascii?Q?JNxvtwDAmleS4hP515GzGnJSYTs36ItyW6sGRgSHGpexn8VYJeYpCeEbtTl0?=
 =?us-ascii?Q?q1el3C6/vth5SogllDXc1aUrBSKoqJPePMv3I3oM3+X3+4qZZmcJe6aueeKT?=
 =?us-ascii?Q?DmyP9LpceiUA70el0sD5mZza34C+/73yqGgarQxLhsQuYgDnuYFacQVscTH6?=
 =?us-ascii?Q?cmMZsFL6lkKMIjSn75Xc1K8SOB3m2q8PSi/OxE5ymEbj3E5QtzZ9p7TTBBTw?=
 =?us-ascii?Q?iWUNL4SWOomdmTSqfU+zqnUHDYLNYXRH+I/Ddpglj6Qtb/qwgfCR987hkRAV?=
 =?us-ascii?Q?MvK9+Kz3S0iiEuLUGNNfcsSM094Ig5vg1AaT3hXpjM5i9x/eezj7IeMb6jwD?=
 =?us-ascii?Q?q6y4oB10EV++zvB6NoWLp0HMXOh1r+Hb2xr5alWHAFFsHT4/KN4FgNtHwow2?=
 =?us-ascii?Q?87Rqj5Hgge6H5W+iXWGD0NzU+psL13oph2vCTSCC2w8q+rCYbg+aH/q+8BZu?=
 =?us-ascii?Q?60YnJPQGqu7ATOMjlwBVXzwrJzk+XJiCseV8BKcbv/J7S1jYZVifEQwn/lcf?=
 =?us-ascii?Q?8LPdCmAP4NzGkgOpxdl4cQskF/m1b6oV2D0yMMLPo+mjOZ19a1LX3ad9Kkr6?=
 =?us-ascii?Q?9N+rCHzZTKgQWdjOqQmR/vrZ/BZ1i92H3huA2NiM9a5VDBi1Xb9/7+fY24c3?=
 =?us-ascii?Q?6WMY5RPrq7Blpwbgl31eJq7xv6IZDG5rGwi41/tUJ+NXWUUkpamRbr224sTw?=
 =?us-ascii?Q?z0QDgrL+5GGG096Xf1EYOCRbx8pGgbhZCbVtwhZKQMUfCUJO1WijGxVCRRAJ?=
 =?us-ascii?Q?w6+navWivB9gRwvrg3pfQGwyuDEjcxEjLtpCdPcYhNaeIOJthmF3ISGTBKtH?=
 =?us-ascii?Q?RJdM5cjvlWI8faW/CNbCIQutRRs506GVoqtgUJecnnyqURVGckkkcw/D6K0j?=
 =?us-ascii?Q?ArC+kpdrBDy0qHroJ1/pDBFm9+F3NT8t/D55TuvpmmyaSDSLd1o18HOqKWwV?=
 =?us-ascii?Q?lvmr6sqKajva6OSvam2cxj8IamkOSdiChIO/YUMZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9468c6fd-52ac-44d1-4680-08de113eb36f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:43:33.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0aldvrMTQhB0ek9AjLwzptvTayAKJeLUTFPYzEqfaDoeIeAjzGjr8gguIcszte5Q3WsyYW5G69r8P5PeCGp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9393

Hi Tejun,

On Tue, Oct 21, 2025 at 11:03:54AM -1000, Tejun Heo wrote:
> SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
> a reschedule and can be used to implement operations like core scheduling.
> 
> This used to be implemented by scx_next_task_picked() incrementing pnt_seq,
> which was always called when a CPU picks the next task to run, allowing
> SCX_KICK_WAIT to reliably wait for the target CPU to enter the scheduler and
> pick the next task.
> 
> However, commit b999e365c298 ("sched_ext: Replace scx_next_task_picked()
> with switch_class()") replaced scx_next_task_picked() with the
> switch_class() callback, which is only called when switching between sched
> classes. This broke SCX_KICK_WAIT because pnt_seq would no longer be
> reliably incremented unless the previous task was SCX and the next task was
> not.
> 
> This fix leverages commit 4c95380701f5 ("sched/ext: Fold balance_scx() into
> pick_task_scx()") which refactored the pick path making put_prev_task_scx()
> the natural place to track task switches for SCX_KICK_WAIT. The fix moves
> pnt_seq increment to put_prev_task_scx() and refines the semantics: If the
> current task on the target CPU is SCX, SCX_KICK_WAIT waits until that task
> switches out. This provides sufficient guarantee for use cases like core
> scheduling while keeping the operation self-contained within SCX.
> 
> Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
> Link: http://lkml.kernel.org/r/228ebd9e6ed3437996dffe15735a9caa@honor.com
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c          |   31 ++++++++++++++++++-------------
>  kernel/sched/ext_internal.h |    6 ++++--
>  2 files changed, 22 insertions(+), 15 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2260,12 +2260,6 @@ static void switch_class(struct rq *rq,
>  	struct scx_sched *sch = scx_root;
>  	const struct sched_class *next_class = next->sched_class;
>  
> -	/*
> -	 * Pairs with the smp_load_acquire() issued by a CPU in
> -	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> -	 * resched.
> -	 */
> -	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
>  	if (!(sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT))
>  		return;
>  
> @@ -2305,6 +2299,14 @@ static void put_prev_task_scx(struct rq
>  			      struct task_struct *next)
>  {
>  	struct scx_sched *sch = scx_root;
> +
> +	/*
> +	 * Pairs with the smp_load_acquire() issued by a CPU in
> +	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> +	 * resched.
> +	 */
> +	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> +
>  	update_curr_scx(rq);
>  
>  	/* see dequeue_task_scx() on why we skip when !QUEUED */
> @@ -5144,8 +5146,12 @@ static bool kick_one_cpu(s32 cpu, struct
>  		}
>  
>  		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
> -			pseqs[cpu] = rq->scx.pnt_seq;
> -			should_wait = true;
> +			if (cur_class == &ext_sched_class) {
> +				pseqs[cpu] = rq->scx.pnt_seq;
> +				should_wait = true;
> +			} else {
> +				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
> +			}
>  		}
>  
>  		resched_curr(rq);
> @@ -5208,12 +5214,11 @@ static void kick_cpus_irq_workfn(struct
>  
>  		if (cpu != cpu_of(this_rq)) {

It's probably fine anyway, but should we check for cpu_online(cpu) here?

>  			/*
> -			 * Pairs with smp_store_release() issued by this CPU in
> -			 * switch_class() on the resched path.
> +			 * Pairs with store_release in put_prev_task_scx().
>  			 *
> -			 * We busy-wait here to guarantee that no other task can
> -			 * be scheduled on our core before the target CPU has
> -			 * entered the resched path.
> +			 * We busy-wait here to guarantee that the task running
> +			 * at the time of kicking is no longer running. This can
> +			 * be used to implement e.g. core scheduling.
>  			 */
>  			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
>  				cpu_relax();

I'm wondering if we can break the semantic if cpu_rq(cpu)->curr->scx.slice
is refilled concurrently between kick_one_cpu() and this busy wait. In this
case we return, because wait_pnt_seq is incremented, but we keep running
the same task.

Should we introduce a flag (or something similar) to force the re-enqueue
of the prev task in this case?

> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -997,8 +997,10 @@ enum scx_kick_flags {
>  	SCX_KICK_PREEMPT	= 1LLU << 1,
>  
>  	/*
> -	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
> -	 * return after the target CPU finishes picking the next task.
> +	 * The scx_bpf_kick_cpu() call will return after the current SCX task of
> +	 * the target CPU switches out. This can be used to implement e.g. core
> +	 * scheduling. This has no effect if the current task on the target CPU
> +	 * is not on SCX.
>  	 */
>  	SCX_KICK_WAIT		= 1LLU << 2,
>  };

Thanks,
-Andrea

