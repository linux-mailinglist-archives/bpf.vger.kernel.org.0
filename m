Return-Path: <bpf+bounces-45455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8479D5D70
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 11:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC08B218ED
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752A1DDC29;
	Fri, 22 Nov 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DAAezalt"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48650187321;
	Fri, 22 Nov 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272260; cv=fail; b=p+S1rDpgJTZtFX4sahqGuh8eABbfTR7xYSzbIvnMAJnkXMnHW0zZ+JF+yanWRaAB3IvB9EIjC6OPEC8AC3Ir/FLWFFzozNBQqpkmX65LyoDoMTHLeXT0NGB09FA/P923n5/XGf5NA2f1fSY5tUY0Z+/aHNMwsQDGM8egZzNLnw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272260; c=relaxed/simple;
	bh=1C1X8vk2tW4GsLtuGW9weyHGwlvmFxQQQC/KVMla0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASWppR273nHsQJgVQClHjVVbAizPBzJfBDAQDLYUeOh/RLSUK/YJqkmaSWZ7oqZCUnlEuUN0fhLv0xfAX6W9K+0D8dCmM314OAfFbGJd5x9TUFrseCuTe1oigTucqlfvm8DgRyYW8GaNAMrTGwbtX2JozrJgupksaLDwtY7K6Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DAAezalt; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljh3iilaaxR0uJP2SeG1zHns445Op3q+2UCM3PnzkqniHwlB4Ce78rGo9SPOOf7mJMJZ7h/wiyp0vT64DArKamVvEWIySSL00YCiXV75XvaYBijvwtZ6okxWTL1vb9IKZn9tCxvd+MszGw1CKQu4RdJLnOx7Qpf2HLJoaLJiPctNjvSZvfOBggMJ9kAXvQyzRzeewd1s+uG3GvQgfIHjK5K1eE2T5FvP5DcA6y/xSAAHhvISX7hj3iW1d1HT0kuMlrZfzK5Ia/bP3N2KTtUzIKZWZiySaVlhBMGqVP5H22xUUJaBsLTyBcpW+1uD/pe86sF/gbMxE2yBsjGokZMcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpj8R7ei6l9fd5zmZChIujCOhuw7Pm44G54HWCH3JFY=;
 b=Rj4Qxji1TgMGFFkwRUkwBdMeEXgwf6Lel1xBxD8ltm3Nd4Xc12HrBt5KBku4RSiCxgceEjiRrrZ1yWH2aIH0C1m4iL5xUKKkRYEeCezBZHMjbL0lnxDyrU8tQ+qxjtFdfDA1Ts44Q9wDXEdgWxTWtRP0/+Z4TIV2gjawlsxab8NlPEEumi0mafhNkENUz5YkSP7vdpBy4QyFh1wrm/PCoxeDTvZIBPc8w7hbwe9YGUaiocht5OGTcDO3nhKPM8cEHiIJ6M0mX+YMjQGJtJiV34XHRw8gqu0Fd7wKmsdM6H5779UCCZjpokwVoZA4+FSjoYsQmMB8VLk2cFZG0CJAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpj8R7ei6l9fd5zmZChIujCOhuw7Pm44G54HWCH3JFY=;
 b=DAAezaltosvTAFrX+Zb7fuYQYxXE6lNqSC/181eN87Lk/FlxaeZXKPibrkv00aImyYqBz9hwyJSibys3kPzslX6YB9vapOBWm8JIziIjE1YlcpB7dKIClY1ThJsRBZRSEbrV4s/S3nx6/T5yQv8+rDLZV8JYYqYW2drOnE+1AVFvj2M+DULsgJDKfiYb8anRymDItGDDnuGPWmjiH2jdxz+bn+EQXzUUDhXKaGhGU2mvPxgMjpEyU/xaGnyb2YsmJgL7sFQFboE7A0glMHfRaGSGeUcLwZkqoqYyMUNM+Up+P8t9kPlvJPQZsVM2KOzIgm7d8ey5YHJhNY9ArdiONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 10:44:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 10:44:12 +0000
Date: Fri, 22 Nov 2024 11:44:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com
Subject: Re: [PATCH] selftests/sched_ext: fix build after renames in
 sched_ext API
Message-ID: <Z0BgclDODUyPqzFU@gpd3>
References: <20241121214014.3346203-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121214014.3346203-1-ihor.solodrai@pm.me>
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 469df62f-bc1c-45eb-8e01-08dd0ae29971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mr/ygPPwOVrBhno4cKZNLWXN8J9gyEzlrILk/OyjluOwR+W0Ri/uE9GiZUoG?=
 =?us-ascii?Q?9dT5xUp46c6XyxAMW+8fbcWMHpW8rD7HisGcnfI/GSnt05NJ+1tXTDo6oq+Z?=
 =?us-ascii?Q?N1AuaBDJCGO6VG/a66m4tXKK84SFd9dbA+MInSL9+4yM9j8/A0VSQ3jwnirB?=
 =?us-ascii?Q?k6vDnPpbTDgY27rotrUrnGDdIxYZWLJcR1G3Ca5hW7Zs8E62iNTecpjA+DPX?=
 =?us-ascii?Q?f0KF9r0U2bHA5qWC1U3ZEiKRkWlLhSnGyTuvRgnpAcBnXBbyLCI6DwTr4MpU?=
 =?us-ascii?Q?QJSMb6WdrDwFhNdQulJX4I+G4E+7621fOxJhikBx3SPzA5gYdp6kv4VuumeH?=
 =?us-ascii?Q?x9ljMCwIFPcgKL9un+vRIrDl4vkl8xRT7B2T04fEG1TOT9X2Ld0dSuu8nhR4?=
 =?us-ascii?Q?20xbpVraE/tCYoH5rHWOH1dlsbbogeYOIQL0k8ZdhVGXvyL1z3lSzSoYghPo?=
 =?us-ascii?Q?zsrY7+m6NS0BG3YzH74ErJvDRTtudGP7+PlYtyNh7zkTJ9wAVfoELlZPUK+4?=
 =?us-ascii?Q?sa+DoCvrPqnUouW/COwSagrVUQIEcI6ugdq8TuvclPWTEMJp0snXy8t5TdYR?=
 =?us-ascii?Q?gvqFpEBuF/Mc8nMHMiFmjytJ1ZTHU6TkNxOSQIsEwN4zzvx3xph+TctHIGgL?=
 =?us-ascii?Q?JL5uhE/1YXCXRGaV8rsavvdm/Q6raXbFkIGSIIMV2VUo6+LZNBrkOF7KzeNm?=
 =?us-ascii?Q?q3CCJj00sN9HIeH09WTTRwqY2VjaR/Y9JhfgEGhNu3gJ7m9CezfvjsCuHd8r?=
 =?us-ascii?Q?6dMq8FVJ+SzQ75rCmUW8Ll/QKwfUel5ydcN2pHgjosWJOEKrVVuL8eUBN+FL?=
 =?us-ascii?Q?tL96tSnEpQ4kPjkSrH9E+EGKaoACtv8+9niyGYRNjsucZfc5DKdyZN67c+44?=
 =?us-ascii?Q?fk7xQOKGJ8gttUmgN426lh2msQ/BfVCWhuPSZE7nxEg79WTWw/XfTejFxT9B?=
 =?us-ascii?Q?f9LC3j83ze0Qf2e4u01Dq6hN71o6E5qNJMaTjHkksOCCUH3QXN3ZDl1+NpPG?=
 =?us-ascii?Q?B7cm5ekY6OOz7Ons/riePxw8YJ+LmHJQVuZ4FflRIPuY8J9Vqfru3JlfiRzS?=
 =?us-ascii?Q?jWZqXmDJxuK6beUiovUxl0D5ez9/YFkfidNV5xl276bpEkOQLMOkpB/rEJcc?=
 =?us-ascii?Q?/0qfEunvNS+L7ib1bGPtHQvNR0EvSyvLUIlILGtGCV2bP+DBb/JHWXt8fzw7?=
 =?us-ascii?Q?Gy+lRk5qU5iHVSIYALuV7BrdwTlr4SOsl2SnsVQ5CjRHrob+ov7guOr3P2hr?=
 =?us-ascii?Q?ZBvQHaI/MEfKpAURik8hgjHO6KxOuQokXZWNfe2yR8Xhlj3M3kzsHD6ATm8p?=
 =?us-ascii?Q?/H9N54W70HE6buhQzrid2uwF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5SoLtXcYEtAcoqT+g9XKLG+c06y0OuytqMgiIh6lvITx1liyJdm9UTjbcsC?=
 =?us-ascii?Q?hvGPn5TEwDqLdk0o5EvPw/xIO4USJ2PPLKSyW6JTN9926hU4iT2asN0n2RN6?=
 =?us-ascii?Q?mr+I51bLyZP5Cwo1CS32MZrv+9Exs+eLP4xPa4Ljonw5sklBfsQ+8H61Lh29?=
 =?us-ascii?Q?EoL3aRgDdNxXaOKd0b3Pp57osZQf1LPXgdiyvnxW1ETubmrhFr/A0FBFy9NU?=
 =?us-ascii?Q?xZ4fwO2rojS4/oPlPkKjFhcNryEu/2f+0RgO1Z7npW9mtbB2tjCpEWqw1f2T?=
 =?us-ascii?Q?xpctOOupyLquMvhYfLpHeosNsatjvscpLT2l0mDNS3Lc4Ui13XXQGdIF451s?=
 =?us-ascii?Q?GzyaBljJs0bcdhvXL8NqOUj+JcxQCIjZfI3BxAJXoO+qXQdr8iqXhIQQ0PcB?=
 =?us-ascii?Q?fO/+4b2YXanbPfMekCQtH6vLBYSTwzLLLp/+YsC1/pukE6v4c+jKzf4B7djL?=
 =?us-ascii?Q?mkLCnCvFoNiR9VTfd7MUWGVyZWuPMwI4JMHZMwNcTyNAr/eyRxujyYtx3wDv?=
 =?us-ascii?Q?sJk4Q/xfNlDJkEgtsLkbMF3Z0taDgDWiDeeoDFgwGqbYKTbbG/fMazi1eC1j?=
 =?us-ascii?Q?4KdTP/Q8u9CGUwd0T59MTkZZ/xuKk0ZMdTln79KMZVgpxvM5rH4k9Luv2b+K?=
 =?us-ascii?Q?y7BieXl2Slla2zzKv975v5P5Z2L+BGLEUp9c8UlucAY3fJ3D3HoLudrzXiGp?=
 =?us-ascii?Q?4HxcVsTU/DirMWLKT1n2sEAl6SfjyfEE8PxzcSloAuie2kTWLGZnDzuAm6bD?=
 =?us-ascii?Q?cnsV4Sb+YYJ8mSfYEq+HUp7cXuxR4/5H92oyB9Ti02o9QIytlBBN/QeaiIQR?=
 =?us-ascii?Q?MFsq7Ob7t0KAA9ohAM/zfClN9PwBlknD6WS1RWTDV2MBHs1nd6wU4qMzpFeR?=
 =?us-ascii?Q?zzZEwKiwoF36Pv1eLgK0CSnD8+f+WmUh+iUdkilwMFhCVqWvglQlJlBodKNp?=
 =?us-ascii?Q?k/acO57t3IiZ9kwLr7DPUVuPJumO9q0RNJpndokF4DowiGnS4QolxJDRGTwL?=
 =?us-ascii?Q?3h/UFxl+cqSk5l+WMfP3U23gKVDA4U84konYSUUlxW70OQXCgMQ39SKfVr3J?=
 =?us-ascii?Q?R91aiZ2zNwUKarltBtoiGt8D6nFkfn24+v7VOgZo9e+x4wm+Wvw/wb1gY0Rx?=
 =?us-ascii?Q?PMjJyemiqS1oXjEuaisTF3iFCpEFBW9VSjnd2WjMP30rYx/DhugS4g/9Ng4V?=
 =?us-ascii?Q?dR3Mssrv5bvzJZF5v7mgv3JIoG7vknVczthlo6wcJXUXasM2JpyvVwWlpZko?=
 =?us-ascii?Q?M8PM12Mzr2+nlYDxxy9L939NCW6e2rkjsKbtxJu+r55DyGbUvwPDNcb7Ax+v?=
 =?us-ascii?Q?Ez0StgnMtBMcy/cB0pcK0gKsPtb8Tn4dKgLNFmBzFZt5kFIvHq8YzS8ovnet?=
 =?us-ascii?Q?3ZMMO5h0l901LYEEnzmidql8GxYxsDsOH3iUdNFej7+AwE//CAQcvZovmmRZ?=
 =?us-ascii?Q?J4TkP2XXo+IRi/U1HYfC+wx16C7TLOxTe7y9Zj1Sc59poOpbz2evJa/AFz54?=
 =?us-ascii?Q?QeU3iJTFYp/TCOQdCcahFObKLBmIz4v3GLseDIou+8RICJIsucdruFph9k6k?=
 =?us-ascii?Q?iieYrIULpvf3Drz/zsfhYOU2cOnsjaCF4IofRk4n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469df62f-bc1c-45eb-8e01-08dd0ae29971
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:44:12.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnwDoL8eES/ssy4fAhjIQ3YkU0x9IE3jIl9kcOnnomElQaeqibMxfa78TJhuk6f+iMp8g4zviqUMCcO2GTSLhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

On Thu, Nov 21, 2024 at 09:40:17PM +0000, Ihor Solodrai wrote:
> The selftests are falining to build on current tip of bpf-next and
> sched_ext [1]. This has broken BPF CI [2] after merge from upstream.
> 
> Use appropriate function names in the selftests according to the
> recent changes in the sched_ext API [3].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=fc39fb56917bb3cb53e99560ca3612a84456ada2
> [2] https://github.com/kernel-patches/bpf/actions/runs/11959327258/job/33340923745
> [3] https://lore.kernel.org/all/20241109194853.580310-1-tj@kernel.org/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Looks good to me, thanks!

Acked-by: Andrea Righi <arighi@nvidia.com>

> ---
>  .../testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c | 2 +-
>  .../selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        | 4 ++--
>  tools/testing/selftests/sched_ext/dsp_local_on.bpf.c      | 2 +-
>  .../selftests/sched_ext/enq_select_cpu_fails.bpf.c        | 2 +-
>  tools/testing/selftests/sched_ext/exit.bpf.c              | 4 ++--
>  tools/testing/selftests/sched_ext/maximal.bpf.c           | 4 ++--
>  tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c    | 2 +-
>  .../selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   | 2 +-
>  .../testing/selftests/sched_ext/select_cpu_dispatch.bpf.c | 2 +-
>  .../selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c | 2 +-
>  .../selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c | 4 ++--
>  tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c  | 8 ++++----
>  12 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
> index 37d9bf6fb745..6f4c3f5a1c5d 100644
> --- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
> +++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
> @@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct task_struct *p,
>  		 * If we dispatch to a bogus DSQ that will fall back to the
>  		 * builtin global DSQ, we fail gracefully.
>  		 */
> -		scx_bpf_dispatch_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
> +		scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
>  				       p->scx.dsq_vtime, 0);
>  		return cpu;
>  	}
> diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
> index dffc97d9cdf1..e4a55027778f 100644
> --- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
> +++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
> @@ -17,8 +17,8 @@ s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struct task_struct *p,
>  
>  	if (cpu >= 0) {
>  		/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
> -		scx_bpf_dispatch_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
> -				       p->scx.dsq_vtime, 0);
> +		scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
> +					 p->scx.dsq_vtime, 0);
>  		return cpu;
>  	}
>  
> diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
> index 6a7db1502c29..6325bf76f47e 100644
> --- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
> +++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
> @@ -45,7 +45,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
>  
>  	target = bpf_get_prandom_u32() % nr_cpus;
>  
> -	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
> +	scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
>  	bpf_task_release(p);
>  }
>  
> diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
> index 1efb50d61040..a7cf868d5e31 100644
> --- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
> +++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
> @@ -31,7 +31,7 @@ void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
>  	/* Can only call from ops.select_cpu() */
>  	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
>  
> -	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
>  }
>  
>  SEC(".struct_ops.link")
> diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
> index d75d4faf07f6..4bc36182d3ff 100644
> --- a/tools/testing/selftests/sched_ext/exit.bpf.c
> +++ b/tools/testing/selftests/sched_ext/exit.bpf.c
> @@ -33,7 +33,7 @@ void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
>  	if (exit_point == EXIT_ENQUEUE)
>  		EXIT_CLEANLY();
>  
> -	scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
> +	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
>  }
>  
>  void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
> @@ -41,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
>  	if (exit_point == EXIT_DISPATCH)
>  		EXIT_CLEANLY();
>  
> -	scx_bpf_consume(DSQ_ID);
> +	scx_bpf_dsq_move_to_local(DSQ_ID);
>  }
>  
>  void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
> diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
> index 4d4cd8d966db..4c005fa71810 100644
> --- a/tools/testing/selftests/sched_ext/maximal.bpf.c
> +++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
> @@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
>  
>  void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
>  {
> -	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
>  }
>  
>  void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
> @@ -28,7 +28,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
>  
>  void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
>  {
> -	scx_bpf_consume(SCX_DSQ_GLOBAL);
> +	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
>  }
>  
>  void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
> index f171ac470970..13d0f5be788d 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
> @@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_struct *p,
>  	}
>  	scx_bpf_put_idle_cpumask(idle_mask);
>  
> -	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
>  }
>  
>  SEC(".struct_ops.link")
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
> index 9efdbb7da928..815f1d5d61ac 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
> @@ -67,7 +67,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
>  		saw_local = true;
>  	}
>  
> -	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
> +	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, enq_flags);
>  }
>  
>  s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
> index 59bfc4f36167..4bb99699e920 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
> @@ -29,7 +29,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct task_struct *p,
>  	cpu = prev_cpu;
>  
>  dispatch:
> -	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, 0);
> +	scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, 0);
>  	return cpu;
>  }
>  
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
> index 3bbd5fcdfb18..2a75de11b2cf 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
> @@ -18,7 +18,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_select_cpu, struct task_struct *p
>  		   s32 prev_cpu, u64 wake_flags)
>  {
>  	/* Dispatching to a random DSQ should fail. */
> -	scx_bpf_dispatch(p, 0xcafef00d, SCX_SLICE_DFL, 0);
> +	scx_bpf_dsq_insert(p, 0xcafef00d, SCX_SLICE_DFL, 0);
>  
>  	return prev_cpu;
>  }
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
> index 0fda57fe0ecf..99d075695c97 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
> @@ -18,8 +18,8 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_select_cpu, struct task_struct *p
>  		   s32 prev_cpu, u64 wake_flags)
>  {
>  	/* Dispatching twice in a row is disallowed. */
> -	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> -	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
>  
>  	return prev_cpu;
>  }
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> index e6c67bcf5e6e..bfcb96cd4954 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> @@ -2,8 +2,8 @@
>  /*
>   * A scheduler that validates that enqueue flags are properly stored and
>   * applied at dispatch time when a task is directly dispatched from
> - * ops.select_cpu(). We validate this by using scx_bpf_dispatch_vtime(), and
> - * making the test a very basic vtime scheduler.
> + * ops.select_cpu(). We validate this by using scx_bpf_dsq_insert_vtime(),
> + * and making the test a very basic vtime scheduler.
>   *
>   * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
>   * Copyright (c) 2024 David Vernet <dvernet@meta.com>
> @@ -47,13 +47,13 @@ s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct task_struct *p,
>  	cpu = prev_cpu;
>  	scx_bpf_test_and_clear_cpu_idle(cpu);
>  ddsp:
> -	scx_bpf_dispatch_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
> +	scx_bpf_dsq_insert_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
>  	return cpu;
>  }
>  
>  void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct *p)
>  {
> -	if (scx_bpf_consume(VTIME_DSQ))
> +	if (scx_bpf_dsq_move_to_local(VTIME_DSQ))
>  		consumed = true;
>  }
>  
> -- 
> 2.47.0
> 
> 

