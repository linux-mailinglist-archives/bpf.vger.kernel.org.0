Return-Path: <bpf+bounces-68646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE1B7C78A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83BC7AF176
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25493093C6;
	Wed, 17 Sep 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OK7NMHTs"
X-Original-To: bpf@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255E1C07C3
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097667; cv=fail; b=d1hFfTd8fB6fWD/BF+m+7vGE2NNfqtvucJpP6O5s/JD/vPZPsRh45Hf5dCdg7W8hMlcEWj3UpWNG6hAgHjD0PT/WmRgXbYx+1vAN9txHt4accL9OPByRUoQpwTjUr68PKL/Wf8l8lPAFvCVrnsJ6a1wV7ZVCFyI0uzah9ALBSg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097667; c=relaxed/simple;
	bh=XDfRT7Pu/SMyGCKWp39PLRUJlKh/Bq54gZMcmJF9T38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qhhol4h8MOXnz1bOUBhF/Af5G6FAKHsSqxlPvdip5UIq4lZRf/WYTc6n/NXIj5hrAe1pu0ZrwZ/Pcq8JKThieZLm+rMOX1IgR83XoyIyn66nNc1K4ezPoTka88x8Ouq7CIaj0uZzbP5tiMSjoawE2zrDsoEy7oL2ngcrLI20LvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OK7NMHTs; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXZnSVBWqLqW4VaAW4AbvGeF/zJRZCqmpD9Pc6Yd+cxYs6IYsMwF8Ko7XJS9yxBs8kvNgQoTn0XZIyn9ZNaGuKqm0amJxzbnojCirQRVBK2K/5wDv1sl4SXQ096p0F07WSr/O2xhApRAKRFF1tbz0bbpVcQKQdYAyB5ULxeVcN0L408oH7apIRZefm3RVZ4W+g6hs3SLUUCHQSArHcuG97K3G2aj8A3YuFzUm9WsV3fkU8ciF3NGbkkoZcxplsxiED9GYzbWYXIuJLISEpwFP6rkz3YXZGC6hYH30WAr5JosVdDSysKGNQxNt8LKm6qFcTcI5zwb0rZsjK4bSUn1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh6D2IBcd9cghFuEDlhh+Txds8neqf+3fUrKEHm1Bcs=;
 b=rjhU3BFnZ4ipQZ8AQF2aUAkP98/AaFMeAUheNM1a/DvmHpqYsowXMqGe6aTmG1PdR6zO6ZLHIJzY6TBQ0bEH8S+0+jTsK52IadbCGfJ+UKeNYKvHS4trPPymu+J1b69fyOv8LoTUE31UAAsjeR7k4yoRk4JPW00cpCJB9kZmbfpT3Arozn25/1up+huV4fRUHxwKt4r0/4zPcj0tYoRzL98Myc3y07ka4wJmiYYbzKDP1L4rRHOKOEfHFQ3kh1Z4oOxq0TcCCidltVgxp3mmcKzvezX6lojyxKAvzqriCj+183OtEeDU7jDUZMCBWEZM8ZY1ROpz5yolDYPxvsP16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh6D2IBcd9cghFuEDlhh+Txds8neqf+3fUrKEHm1Bcs=;
 b=OK7NMHTsF4a5BhKH3sp/SK8JUhMA6G4rd0hhEFjEqeDRFSgig3CIKOyouJUWphvASsikgypcWSElv3owpXY4r63XtyHZoH5anYplmyFSe188pJzUIJ/Gbxw0qjH5xqUvXoCBCyEkZH/J4z2/vghrBA6TlAMca+mNsAnaEMZCWs0bkfWUvVQR89wPCbcNkx2L3S9ZiixuSEz2zRVs+oeAKu+U0lYae1lKzj7EYBirhSaC1uYinEz9H9UtY0/V/gDL7jyNOJgZRLZmKXpDchJ7zXb++vXJxuUGZXddHvRVT0ZEjZoRJmM/c1V1aNx1eYAJSflhRvewO/UhJHWAbkZrQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 08:27:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 08:27:42 +0000
Date: Wed, 17 Sep 2025 10:27:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 0/2] Update KF_RCU_PROTECTED
Message-ID: <aMpw-yi-dmhox3h4@gpd4>
References: <20250917032755.4068726-1-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917032755.4068726-1-memxor@gmail.com>
X-ClientProxiedBy: ZR0P278CA0102.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: d07fffe8-c946-4bd0-c74f-08ddf5c41202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S2W9zMXstJ10L6B2lF8NmVRx0u6HAuJHsDlz5fqm7Vu+D/g3hYdshEMIs0Dd?=
 =?us-ascii?Q?boUjPAP/TDQmG4fpe4pBUn6VcUstbKXuAQt4m6NuCFBjY2sUAdz94Jdg2cpj?=
 =?us-ascii?Q?HSwVmMowpWpuyhZ8o8xzGdVhCgvxfCYBMcrPKYMB/u1z7iMfiBxyARxP7kwU?=
 =?us-ascii?Q?3hB4nhykU8j9az0p4H77NuIerJDYpExw7eKNyogg0NyDtVSPPihzmdG38j3f?=
 =?us-ascii?Q?JIQGfMNum4gcaS0CWBWKDrTSXPVM+b2JyIpfNpCOZb9BB9WpYpEvyxC1A41A?=
 =?us-ascii?Q?nUP7TixLg68uEfyMrF2vAvq0AuKqyyyMeMWcNWDU2BthYQJatI8mcx7i8tyk?=
 =?us-ascii?Q?/auPFPA8YC43as2hyuRSU6sSD3irqF9S7TRHAtZrAGjwqzHTQTTTKDjsNxLn?=
 =?us-ascii?Q?rQx2ZafwK7iRInz7tipTkgK5qz9bErWP2RSoTfRl16uVpoPgJ+KQUBGbvAe6?=
 =?us-ascii?Q?i1ijumDaPinLJ7qBVn+R5XaPGo9+ClF+bYJ6b9nDvg27839SG/8Yg/hK9dgE?=
 =?us-ascii?Q?k7qD3HDE+t31M87Z7N0IsitleVVd8hDs4fZRR+HedPdsxDUJ3crzHwWDO5dy?=
 =?us-ascii?Q?NQ3LhZ6cLMNSAwlviq7AgUPyA56Lji2dPYSHsNAjX3SQXKySDtazRaWbCrI2?=
 =?us-ascii?Q?jJmucbtTDeXBigAcWyW/ENqVT4HrgXSK6y2Un7Rmxs9BFGgm+DRRyaM6exH7?=
 =?us-ascii?Q?PF8tbNBvGZYos80ITxybghAr6GRviw18GuU+6lXopgeg8Qj3XqnlmoRjL1ch?=
 =?us-ascii?Q?tqukTmqgJe9l/0ADCBtgSsqCCT5B+fxTVG+wUZDq3tdP/QxJo8puADPGQxy7?=
 =?us-ascii?Q?WWTkhDDXh+13mFzYHgf4x2N+PlbI2TG/0+OMg9hdiZ7f50aVMwnMI18FkBE8?=
 =?us-ascii?Q?dImyiIkkGrnpEr/C5brLybNV/kUemoTf1vy++apHLHCZXKStsd2pqzWYFHVF?=
 =?us-ascii?Q?SkYxtnfFMpnZC25RWvXPWExpWL9GB8YWM8YDwTHFrRWGjXjwGvOXtgKRWcHs?=
 =?us-ascii?Q?8OadeFMMKc/JeHDMsnddV1zqkCUafE7Id6W4qGgRMRPBTj8jTKeopQVtYETb?=
 =?us-ascii?Q?Z08DY/7pHVSE3c3UeBzIaOoa7X92f9zv/UU0fk/31VA3D1McoVBG8h0FMUfo?=
 =?us-ascii?Q?MGfUQooV6mZBjckXO9iHNxHw5GU07EXI/cxMgas5vDhFy5wnkdo8yDmg96EX?=
 =?us-ascii?Q?ZRCnY+JzCBe01HGp0hheGRKu9jlt+6BduOT6hU8bbN3o3PFpDtPSABzLfd+f?=
 =?us-ascii?Q?zkwrzbuWfwaedbf0F2t7+SuxUXi/z8FW3WCN+eHLkSkOz/b9dWQeenUPTRk+?=
 =?us-ascii?Q?6la9KT50FT7ja/fPHGV1qk13CPw/fed2y0svOSQdmPNSd3re3pN2/U6kaYzX?=
 =?us-ascii?Q?lhYI32rv++JGkdjVYeHcmqcgKG1PCyBhKSm1y8NSpcfYn+xYhLCixaDYVS/1?=
 =?us-ascii?Q?gxDdxD6YQig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QEG+dYQP6Bc3BNHHojDaOyIwk1vg63WG3ecdON2Q53Vn284fd5k/mnxET1P4?=
 =?us-ascii?Q?WVFKGeA2DQJXLiqCGYzvf70ztwcLZwzpe0JcSEFWwOvJZAwpQsXyzzDqatzv?=
 =?us-ascii?Q?iYfHBBwSkEwjTi+E8F1bEerd/3Ipler6N1OJvsW6NHMaiDZqh4Ugxk8hPMX/?=
 =?us-ascii?Q?dOiDm9K589AhhwZhyJS9FZlDe1Wztp8OdvEVgjKwibNn/q5uJwnxltW6tPEK?=
 =?us-ascii?Q?THNe5PW9WdMuZ0wH3/uQrXjz5axcWeaNqat0fgJVm2QN4k5c2JcmNiizWsMc?=
 =?us-ascii?Q?u0WF0zfvh7SVnmRjQ98q9z8BMOxBXWvVEWsEN1xWjBQVlezSXIxdhE1o+RP+?=
 =?us-ascii?Q?EWNW/gyM6vk7UtO8oc/pmfqzXAhBRo48zOqidLxS+7VUiNqL659znr0dNTPg?=
 =?us-ascii?Q?MB8NAZakki4V61mE3uGhqCzgV6JDJARTL2lsRW/Aowyp4umTYz+OuBWBfH60?=
 =?us-ascii?Q?sPM0IAkD57L3OCtPYitNC8wvlueHQ3cQ4vi2dMmc4OnHGmcfwcDGMromZxfv?=
 =?us-ascii?Q?7FH5RxvEDL5DM5x55Jdh2rYtWIjeGILrtvAyMuEiWbbimSabPWgl1fLa3/pO?=
 =?us-ascii?Q?SR5psyZ/5iibcqPxyrAD8BQkpgbKDvGu80+thh/5uawBa/maDvtmHbNq1KE4?=
 =?us-ascii?Q?6Tw14inAgw90WpunlMTYKO6pbR6WMKuWyiJGA9WJ2sGVMZ9w4GEVnh3DT6mC?=
 =?us-ascii?Q?MUvHERmoAf+cIK3M3YjrARDGG3t6bne1cJ45C0sVG/IyptSW0uebBOodD6uX?=
 =?us-ascii?Q?TMwnGAci3GinnOMXqe0WGlinLfdtM8f6m6g+SZz6vBnD2G7OGSGxfvFmvoti?=
 =?us-ascii?Q?3gV3/b6IRJffDMWEdE2TAVdmWUsOjrA6NlqsUPlLD4fis4bJb92CZrJAMrH2?=
 =?us-ascii?Q?wmiw2uADshAsuyPN5rHAvbne7caOdogkCTG3q9L+fQRuAk2wIYeeggzTL7AK?=
 =?us-ascii?Q?2u67RuhJq3+cCBp5rXp/xg3Xyzjy+cK51rJRrRxavuQBalBRknMnIe1WskE+?=
 =?us-ascii?Q?62LdQYbNO910MAmubd8XI160A7IxABLCVmextG9EqdstJ411M/bQxATBWlLe?=
 =?us-ascii?Q?qeiOXIpUJbA/9MTKTCxlv/rm+SvAfAMuFXXUjkCaHdvgRweKB9yH1KYl7KZh?=
 =?us-ascii?Q?Fg3a9e2ffuXXsojpfaKCuyFepRC4Q0qzKYqZO6TjMuRGfSYxsjd8D1OvWve2?=
 =?us-ascii?Q?Gj/lfZJgp+Jp0LOlFstnlSUCspwTOfX3BPCeeVWPM/edll9TM6Upc51n/PMl?=
 =?us-ascii?Q?SuJq2A450/6Q5N89rFc2ZEcmDd2zT8VwG2WZs4N9GmrzViIRUISnJ+ckMMqv?=
 =?us-ascii?Q?2J1nIs6m30T1JgUnV3q08dGs0UKvHDknJRdFNrpacxflB3BOJl9wc5r+9jEZ?=
 =?us-ascii?Q?SryWzcMaKF3VfA9TwJGehCdMWwa7CteIsozHAg5dU5AmUKXp+o2tBrDNvr36?=
 =?us-ascii?Q?PpDxpudLMzh+jec+qM64JjJh303p+2BgUpdcZciUiZ8LhU0A8DXjsV7aXqy/?=
 =?us-ascii?Q?hn90ZuWsLFTOhilpE0AJk0yMi0rs2gqupkzz6WNrotyiCc5/5ERlw+Ee9z2m?=
 =?us-ascii?Q?wLPiX3rucCjV3oGuguVinKLWryM0GkYbCZhVRqSk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07fffe8-c946-4bd0-c74f-08ddf5c41202
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:27:42.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgIZ2OZ+H21XC5xqpYbOqhHSMz+Hu9BSVqLD5Ja3K2H+SDaTKinDdb65etArR3XwxxAwvEzG9mCn96HIoTQocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

On Wed, Sep 17, 2025 at 03:27:53AM +0000, Kumar Kartikeya Dwivedi wrote:
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

Everything looks good from a sched_ext perspective.

I've also tested this with the new scx_bpf_cpu_curr() kfunc, marked as
KF_RCU_PROTECTED, and everything seems to work as expected.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Changelog:
> ----------
> v2 -> v3
> v2: https://lore.kernel.org/bpf/20250917032014.4060112-1-memxor@gmail.com
> 
>  * Add back lost hunk reworking documentation for KF_RCU_PROTECTED.
> 
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20250915024731.1494251-1-memxor@gmail.com
> 
>  * Drop KF_RET_RCU and fold change into KF_RCU_PROTECTED. (Andrea, Alexei)
>  * Update tests for non-struct pointer return values with KF_RCU_PROTECTED.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Enforce RCU protection for KF_RCU_PROTECTED
>   selftests/bpf: Add tests for KF_RCU_PROTECTED
> 
>  Documentation/bpf/kfuncs.rst                  | 19 +++++++-
>  kernel/bpf/verifier.c                         | 10 ++++
>  .../selftests/bpf/progs/cgroup_read_xattr.c   |  2 +-
>  .../selftests/bpf/progs/iters_task_failure.c  |  4 +-
>  .../selftests/bpf/progs/iters_testmod.c       | 46 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 12 +++++
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
>  7 files changed, 91 insertions(+), 4 deletions(-)
> 
> 
> base-commit: b13448dd64e27752fad252cec7da1a50ab9f0b6f
> -- 
> 2.51.0
> 

