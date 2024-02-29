Return-Path: <bpf+bounces-23066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22F86D1D9
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84081285A57
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422A7828E;
	Thu, 29 Feb 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TuAnxGh2"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E43612E;
	Thu, 29 Feb 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230596; cv=fail; b=J4WA9rvgzER4zpBXsnimSIXZFvHeynVZTYwyTKBVHd88+Z7reByR4QB0MkgzM5hOmywPLo9NsMmZiO0k8jZA/j1eiBj7N+luxAmkHN5I7chc+dsm3QRCzUmMRDboCuGOApy+f440p5BkAIXc0AYpFAHjPHRoq861loOWAH7gnCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230596; c=relaxed/simple;
	bh=N5vLpdRP6KkXNaoD8Sf2j5und+8KQ4Fu6kM50k5bxGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BJP2nLZNXMe20ueFJCbURL1REFOn+rgHX2aK3VLee42G1CE2QAvtr2En9S1WRZvAC8xxBJ23ZQ/6s7P53EloQtbJ00/lt/TjExiqbsLY2DBdxOemd0xk6+ENtGPb5jMxtFqoB1cYZzO5QZgFGUSeOQdk1cKbdwg/tzfFTX+d678=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TuAnxGh2; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSq3uaGaopB3b/XXB+kqu13xPYTUdpQQkK1EyCU7lJJvViaQt0K8Y04/bQJS/FyDgXZ/vh0NoO6lMOOE8N5fhwwTFmSPBCr7v3GgmTJReAhCTY89RtR46LNOTX45fe1rz/HO13k54BlTR3Y/9dEjszLIulh7bpqJfhnbG4t3VioeL7eH6rP0F6uHr0PevzAFJSYu6Nn0uHwsDXdRAtAGLdyK9p4nki/oC7wlTWg112vgH+li9qweaSvuKPEnw1QCohOYW2u45xioObJLrDnUnVknai0KUQJatrMFVZDlqY3CJzG5oFyJ4EfeuMlfieWeNdhWxqJXaA/MGN4FFsIuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEO0KVT3IgM3+d6YYeHW0lcQptgN2LfLd0x+2bYGoj0=;
 b=N6zuNifLZPywEoR3l9v41COJpAWWfiLpQrtHS9NvXMpKGZgM31iWtNfmyDZ0hw+aIPMMY6T1GMrKwuNPrQqP6MqgF3PcSeZMtt/7KkKkpgVk9tPZLqkEzXhR6o3zq/30ndrplWLnLig51HcvZTVtp+tKN2lSO00aTR7jDUjToRpNBgryvLXfSLMQqKwEezECPvgd2WLf6GsxANPJS0fxUOYgJSup+dhTyXaFfOvy060GpXcPFrLasRtNhxV3x81c7nxCAiKVJgzgBVikIvIv+t6+X9goB3n9V2XCmCyZhHZphD+eDTx57/YO/XUIBlrCp/6ztZpf9RkV3ovDUHVPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEO0KVT3IgM3+d6YYeHW0lcQptgN2LfLd0x+2bYGoj0=;
 b=TuAnxGh2ULqH1AC/Plp4bSi6M0NPTnrbOuzzfopvvd34zPRd0IbW6ovwqNv6bZAhNbOrlittD4UiS4el9KDAR9uQ9dek66HhTq/cWDJCt6gUJUCdySO91q3Py0i8J7x1HQRjOi4Yl8G69DjpgAPIX+TO0KZAneEqfIWpvo1E2SIqHpIeFJ6AP0H8htg9cLynkQwfN51BkNQWQ/o/93MXLZiqdmPjNuwjF4RrscAW5kHxkz1tFX1gnc8I5wrSBBcG/k6y7Pkknxr/yEy7rFpsL6t+c9Qe92Y7+fl7GaCtsXEMOHGERkN9OHfmKsi/OXLV1LDKpUIhauAirGVXnunXog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Thu, 29 Feb
 2024 18:16:29 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::6848:122d:93ad:24c]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::6848:122d:93ad:24c%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 18:16:29 +0000
Message-ID: <f248cf92-038c-480f-b077-f7d56ebc55bc@nvidia.com>
Date: Thu, 29 Feb 2024 10:15:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix linux kernel BTF builds: increase max percpu
 variables by 10x
Content-Language: en-US
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, dwarves@vger.kernel.org
References: <20240228032142.396719-1-jhubbard@nvidia.com>
 <Zd76zrhA4LAwA_WF@krava> <856564cf-fba4-4473-bfa9-e9b03115abd1@oracle.com>
 <983b98db-79c0-4178-b88f-61f39d147cf7@nvidia.com>
 <34157878-c480-44bb-91d6-9024da329998@oracle.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <34157878-c480-44bb-91d6-9024da329998@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: aa29883e-45d9-468a-f510-08dc39528c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/CsjFyDfoD8hANedOWVf6ibmo90aaXuxOWtZg5ldAg4q5k/uv92aVRUl0XU+I3TqR0+3AH5u/HIw/H+6lq2t8VuQwGDr3m3ay224vpKH3sRm3ZA9ZLPBOvC8NYo+HVvyYXxjQUFUbGeVEdLXJsRvNrcYRJDv9Zmimi9ALVwzqYfBK8HvO1vUCf2gy9321fx0VrKdplrbHZrX9Qd1NX2LgWdZhso3d9P6n+ftMfplj9LPPaoo3pKgHepaZ1h2m/XcP+bLv3VFePHzvYsRxnw0TBXVY65rdyhFoBJbgj7eQZA4Y69dRy2//Z2VAKawjleAU8CBTIBxeZks/1nCxjsdVdx4hEpFy0yDKQLKYUAUfBISEuLhq5FXi/tMafYHeAwF+8Lc4TffmGb7WSGDSL+u1vitxiu2CAlLkOTP3siRgbOU8Aa8x0fbAAALckrMm8cQUn8LC4xyIklXcYbfKGNtnsXVz+FMeKpYtVxYx7BdFERki6rBprqGkUwWTSliyJXmeULRaekNmYMeM5FCAiqx96TQcT/395ElWVKds3lGUty8NLa1T4osqoVeu5sr6jcODr8BDrQtnewdfGcpSxzXb73miLRvgM/16GW6qxKNp89h4D6P9MVZZxQ7gAcrmib0OfsLrOIj1exgYu4MweUpfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXdpU2pYVFQ1YTBkbForSUhHVlp0cHVhcVBrZ0VlQ3NxdFRqSnhJWjBReGxZ?=
 =?utf-8?B?TWpHdlE0N3drZGtqK0dBZXhqSEV2eUVNVGdCaXlBVXQzOE1oRzRVcUVOVlN1?=
 =?utf-8?B?RWw5MXAxak5LQXdEWEpWWE43d3dTUHFFYzNVNGFLQkJnWTlMU3dMTUFudHNt?=
 =?utf-8?B?TTNpVGxQZTJHMmJwb2FBMk5OZm80OUZoTWRtOXJVVW1CNFFkOHQrWnNDQ1VJ?=
 =?utf-8?B?cnpYZEZQbFlLUWRzZ1JFMUZvd0R0cm93c04ydUdTa2JYMk5uSDNwVkpQd2JK?=
 =?utf-8?B?QW9INHJxYXpUaXBxV1YxdTA4TUJncnNDNTRCV3lRTXAxcnB6MldycUdGQkht?=
 =?utf-8?B?Q3NmMjFsTm01UUNkeGZNUk9HMWMxTjBRY1NhbU5mYnRXNTNjNFliVHN3MGhy?=
 =?utf-8?B?d2Rqc2poOEwxYUd6SDFRVEVwSDFqSHZIWjJyY0JQWi9aWVBuWDl6VEhuK0Mx?=
 =?utf-8?B?QkNKa0d4SDNiaGVhQ2lyR0NLcFptVjd4TGcydTI2Q3U4aW9DR01nLzVuOXVR?=
 =?utf-8?B?bUdUdCtSQ2xmRktTRituSFZZZkNxRHRweEN3dmVWTlhLMmhsRlFqSFpRWjUr?=
 =?utf-8?B?b0ZZMWp0TVNVejVWVzlFYVYyUW5EOW5NOHVJbmZYcVFQc1EvRWhFbVREQ3BR?=
 =?utf-8?B?dGRjR25JdzgyZzd4YTFVbm0ybGhqVmJaQzl2bjNvR1pLM1JFRVMzd2NQcFUx?=
 =?utf-8?B?VmtTWnlGbUFwUkFCTVd3YWJROURLc3h2Tnd0TnNrQXFkTk44WDh0a0JpSmdi?=
 =?utf-8?B?cWRrb0pqdnhveG14YktUT2dWM1dPM1hzWlpXeXVnVFdaR0dnWDBDQ0E5TjUx?=
 =?utf-8?B?QnA0bVNRb1BKdUNEK3hRMDFQK2JaZmd5TmNVM1c5dExQT1hVT1RTaDAxd1Q3?=
 =?utf-8?B?cTdvVXpWQ0tCY1FxbVgxSndYaTgrQjJleXk0MEVWUXQrVnlXQ3RCVjcxM1Bq?=
 =?utf-8?B?WWZURFZ0dmFSN21zUHdyUEFmWjJFd0ora0JwTmpqa1YzYjNOK21GbThqaWFQ?=
 =?utf-8?B?VnJFWDVmNUMxUXhGQVRBVEdNaGxLb1cwdSswNzFZQlRTb1FrakFGUFB0U1po?=
 =?utf-8?B?ZFlwSVd2N2o5N1NSUjE3MXBkdGU0c2ZBT0doYXRJTzYxSXFodEJJRW90ZFor?=
 =?utf-8?B?ZFNnVjYzS05GWGUrT0xFNHVMTm1JYjBMVlVTdUJMN1daM2VJWjRpMnowanpr?=
 =?utf-8?B?QTl0eDNOOVRwRS9zSlYwNDFtOURPT1YvWTVPeElkRENCeHlqdVU5aTFZUzR1?=
 =?utf-8?B?MWZkWVZwcHpNc096TUczbDFOYXpnRmtzbGRPNFVTald6dlZTdllodzFpaDBj?=
 =?utf-8?B?bTRZU3ZvUDl3ZjlFY0FHQUFxcUc3WWQvMFJ3UmpLNGl0T2dZajNydVg4cGZT?=
 =?utf-8?B?TlhlZkFpOVdDK3lremljanZlalA3emlhaUNBWWVwbVdTMjhuTWVWM2ZjS1N6?=
 =?utf-8?B?enBQM2oxL2lxaGFncEt5VXluOFJhSmtaeWtHa1BqaUJtQkc0WG9lSXlIRS84?=
 =?utf-8?B?eTNQcWRnRE04RVhGaTJoTmtkQ01tbmNIN2ZnSGdOcitva2k0TURWWmZ5L3Z1?=
 =?utf-8?B?RGJhUk81WUxJVDAyMW9rZ0hGSzRyVDVxVkRpYzUraVpOQmN3VWZlTnUxaUZz?=
 =?utf-8?B?Sm81RHFZQXNHaVp4ODJYMjFBeFM1OUUzTlZXS2dmOE03YkhwN1NaVldEQmRC?=
 =?utf-8?B?bEV1R1hhYVg4ZUhtajVnRUYvcTd5NnlkUEVMaFB1WXhTQVZXSVYyczFrZkJL?=
 =?utf-8?B?d2NrMVBxc0taNGE3ZVpDV3pvaGFhL2VoMWpHUDU3cWZrY2N1cFJqemRQMUMw?=
 =?utf-8?B?MGlvSWc5RjllZDdKakN0d2pjYnAzaXI1Q3FIUm9CWHFMUGJJMVp3SUcrQ1U4?=
 =?utf-8?B?OE1KdVNicERjbGxQSnVpbzcwZ3ByYXhXTzNKNHRtbkZLUHlkVHJKUTVVYTNI?=
 =?utf-8?B?aVRpRjlvdTJoU3FXUXkrUmN1WEpFbCtyZURqdWw2QTdwelJaaXNEOXNrSzVK?=
 =?utf-8?B?cllQRVVWQUNORmUyRzFjazJKMU1mR2RjbWZ5b2RueFBrTnlJUkdCdnJCQ3Nn?=
 =?utf-8?B?TnVkVHIxVUpDL2IvRkNDWnh1RnpXSWE1RVpMak5zdk83bXoraldmdEdTOEc3?=
 =?utf-8?B?c1M0ZGU0cTJJWG1PcFBRdjhNVEExTWZJRGhMdXYybDFBR1A3TU5ZaVdRY1Vo?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa29883e-45d9-468a-f510-08dc39528c9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:16:29.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+DpI3CDQ/nkskHjg5RkH7oKeNvJspyc+5IIeUNYh/u/egRjLfknPU6P4dru+xTMX4vN4zBtYCQ7KhcsJ1cXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496

> ...
> Running
> 
> bpftool btf dump file vmlinux |grep "] VAR"
> 

$ bpftool btf dump file vmlinux |grep "] VAR" | wc -l
4852

$ bpftool btf dump file vmlinux |grep "] VAR" | tail -5
[136994] VAR '_alloc_tag_cntr.9' type_id=703, linkage=static
[137003] VAR '_alloc_tag_cntr.5' type_id=703, linkage=static
[137004] VAR '_alloc_tag_cntr.7' type_id=703, linkage=static
[137005] VAR '_alloc_tag_cntr.17' type_id=703, linkage=static
[137018] VAR '_alloc_tag_cntr.14' type_id=703, linkage=static

> ...should give us a sense of what's going on. I only see 375 per-cpu
> variables when I do this so maybe there's something
> kernel-config-specific that might explain why you have so many more?

Yes, as mentioned earlier, this is specifically due to the .config.
The .config is a huge distro configuration that has a lot of modules
enabled.


thanks,
-- 
John Hubbard
NVIDIA


