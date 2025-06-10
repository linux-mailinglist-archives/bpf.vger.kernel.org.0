Return-Path: <bpf+bounces-60133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB10AD2D14
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 07:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A08A3AFCDC
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925125E823;
	Tue, 10 Jun 2025 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kX7+Ot9Q"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB54C96;
	Tue, 10 Jun 2025 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532374; cv=fail; b=SBOJb4+YcjilHLY6C2fwcCok1RjLbJjAN5A102IzIrhcrntoJx+k2XIJoa26UA9Zn/+xaTbQsTp3tsFXTHHbRJAXr4hj4sJiXgk4ooSmcWWLrMi5DoZV/Q7QjUdjzpJC6Sr/vv76Fwyz6atSeTHLlcVgyfVrfUL1cMF7Pa4Rcls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532374; c=relaxed/simple;
	bh=LJS/i5TZRcT+txXFh0PId3n5bsnAioAyRXeUes/ssYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iu2p+o0wFZP7lsSmWTe1DPwu7POjNPbAbLT0jzPKZy6Jehsg/JBC/Ny6a7EtX5Q8kmoGjvu3W7P95BsDmjhPvcfBxEXGByhYFCV0QQXX5/EGK5R8SCq8q73GSg9EQ43uakWQNWFF/qDLtqVfz0UH52hanJzCgdUiNghKvx89OaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kX7+Ot9Q; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnL8zV9qwS0EgwyHno36kM2GcSZOoyVoOEGoh1T5K2BALXW7wwMJ3dx5alrC/AR9gumCAh18F1gCmlxnqoxhxOUXyI3JBbZTbbi9yRMYQ13k1AdWQBWK/H/d8terkytkRS6ABmAF1Vw+lVlJqFWS5oZfdKbZ9elxV+hhBI+9q5FVHtCXGJafo7zg2DuiDCUXuPGjTfelWWZdyDH3QkGu6E9ihtrpfeEeEgaRWgSjlRuIpAi5jvFxwisw+sNdwbeSWPt6px3JAWgVtbm9pgdWy+GesGpWixJy5et9pTtydxH2P53hdWMWRid+05MT3HboH6m/MKgjvbAEZOnRSfZ/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9PdJENnPRaHbETiclIbHRSZoPFQV5I3ddpli8jmMcc=;
 b=O2gOWxaT8E+C2T4+FI5Nz5MNUR7K0/XTsfNxwJQCvo68tNiAO3tHXloHynjOuUTRSEaWBlQdh1VgiQQ6O9obho9MW2DFGhKS48fYK8MDv+Vyc2j8KLEl+IvsMqGRqGKc7IZsS+0fMekd9LmtiqVJHGv2AUIZE8vNTJWHGGGJyK60z3p7CDId62q8oEKm05AlnYDg3hI/8h+LJtMkPGOP40+IIMyUdxZCPOtmbZ7X/FITGKaFeBPJPi22yZDtM3wCcUigbTnOYB5pDpphdwsfvQPgGioFePk+1XjixskmZCYpx3mP6DEDrOc81hjYlWDjGERKFJroiCQoU+ZgYlS8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9PdJENnPRaHbETiclIbHRSZoPFQV5I3ddpli8jmMcc=;
 b=kX7+Ot9QBaVoKOIPX8WkM3L5OB8JcLiYxwk0YKhuNr9auZBb9oril8pwROSR5Ve2M7zY94M2YxgPb0PCJQQG19HoLrlGvZMnhKaFbg4mgB+N5ErxjBa4yOfOmzd38vxUoT6axkBftGHtfmbaSf3hV57iXOBT6KsdBappMGmIwwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 05:12:48 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 05:12:48 +0000
Message-ID: <dae6bb73-9c13-4b44-a766-0c7c09e5b79f@amd.com>
Date: Tue, 10 Jun 2025 10:42:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf/amd/ibs: Add load/store SW filters to IBS OP PMU
To: Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Joe Mario <jmario@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, bpf@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
 <20250529123456.1801-2-ravi.bangoria@amd.com> <aDq1iG3P9_BBnx7C@gmail.com>
 <aD6bkAXjRllFvRTV@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aD6bkAXjRllFvRTV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: cc945512-f193-41ee-ad94-08dda7dd7104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDMwSGZ1VWdsKzRRU3hPM2U5Y0o5SGR0ei9ET1NPSmFHWFMyOWxIQThHeE1U?=
 =?utf-8?B?aDhaZ1BkblorZERCeHU1VWFjRFFyL2xucEg0OU85U0FTN3hXQm1YVlg0VndT?=
 =?utf-8?B?YTRtVktHYU9KSGZJR1I5RmZBajkycFkrc0FwQ1k3aGpXU0ZuWXRmR0s1ODJS?=
 =?utf-8?B?QXZMSldOaFNvQXE1RW5ab01oWTZyU3Zuc1hDLzFwSGtJakYxOHJ0TVFrVUsx?=
 =?utf-8?B?ZGxPdmhzaXkweEhhSWhxZUc4NXdoZ1h0dEttREJuNVZWV24ybXhHY3pmeUFQ?=
 =?utf-8?B?SE9XMDBaNDc5VmQ5cXNnWWxKYTVTRFhkc21zb1FNOEMrNUM1K1NXbnJuYTJl?=
 =?utf-8?B?MngydnRvUncyL2QzQzZZcktvc2Y5STl4cmhYRlNyUkt4WEtSRlNlSFVST1lP?=
 =?utf-8?B?Z2NIK3pPZFRMRU1EVEs3YlRqK1lKWmpCYk1XRG8zeXU3QUhsNHExOU1oS05o?=
 =?utf-8?B?R0V0NkpSK0pPYkl0dHd4b0tTcjhpMGZoSWxieHJjY2tRQkxFTVQ1RURBTWVT?=
 =?utf-8?B?YnVOUWRvOHZTbFdJL0pkNHhOalhHYXkxKzFiYVh0TGVIRHpIUE9Nd0J6VlR4?=
 =?utf-8?B?bUV3MXZjdnJKNXoxMmFMRXlFcEgzYU9JUENHdFB5U2xiRFQ4SmZDc21id2ox?=
 =?utf-8?B?VHBxaERvQVRJUld3TUg4WTcvakJ1S292YUhUamtUZ0dHc3AyS3c0bFBkQW00?=
 =?utf-8?B?RVhURE5rR0dtM1dMR1NGVXZBVUtyMDFWMU43MU94K1oyUjluUkE0dEEvMlNO?=
 =?utf-8?B?TGpGTUhvYXpFSTdzN1NBcDhCdlhTYUcxNDFITm8wT0xUMDNPUkFpZG1Od25J?=
 =?utf-8?B?cllHSlNGbmI1TVhKeTdpZlltMFNZSG0rRG5UVEVzaXVta1YyWThiaCtYWHhk?=
 =?utf-8?B?Mnh6UURxN1MzOXJmTzJmcmwwd1hMdy9sTU1INEVNUEdEMmxzRmsrd1JuNGoy?=
 =?utf-8?B?Zm5VYisybXF0WW54cXZ1MDdEZS81Ujc4OWtqM3Y0K0JPN1NqWTEzdit1OU5o?=
 =?utf-8?B?aWJJWlltUkIrcTBlcWJNNlpjNE5qWTk0aXNiZm92UUJtNmR5b1VSeHFsWnV0?=
 =?utf-8?B?cnBlZzc2TUxVeGY0bkdzeGg4K21iQ1o2YjZ1eHUybGlkQlRIMkRwMFpzNHho?=
 =?utf-8?B?bEowU0ZtdEg3M3ZzTGhZZUJBNTgveFJja1grOHdHQ2hZNUlVRktWa2tGdzB6?=
 =?utf-8?B?NGRjYVY3R2xKL1dHLzJuT0sxTTB0UWhxYXhrYUNqeks4K2I3VTJDUUZVSTFI?=
 =?utf-8?B?MlNTVVVGVGphd2FkV2RDRWJNZ0FmWkhVSlQ1elVZQXBDeTNhOGZERVVoZngv?=
 =?utf-8?B?dDViRjh0bzhyTmJ4ajdQL05WOVRGL1RKSkxVVEVuYWlZU2pVb20rZG4xT00y?=
 =?utf-8?B?T1BOemx1aE1jdkpMeUpHMVRmRFVYVkxMSjZWQXVPa2IveDRmdkR0bVhqYzUv?=
 =?utf-8?B?NDQ0UW1PQ005UExCWnFPWDFJUnhJQk9QbHhUZWFwMktpQmhGTDlIdDd0SWRX?=
 =?utf-8?B?aG45cXREK3VzaTBvSzR5U2prMmk5MUNLbXlMaDRyNEJLc3dSWWN1NFB0RWln?=
 =?utf-8?B?ZllIVXV1YlE3SklqQkhybEhwc1lHcFNBeU9vRVF0b0o0L3pRM3BGUW5HMnhQ?=
 =?utf-8?B?WE0wbCtKdUxmYk81aVVodTFSNUtEZVpWUE9YM2ZtbUxmWnR5SW9vU1dUYVN5?=
 =?utf-8?B?QkJjZHZhaGRyTEN6Z0o0bTM4d3c4UzZNWmttbWJka3pMTlJvL1FRT21TOGdC?=
 =?utf-8?B?RXh2V3NTY1hKUjlzMkdWSFBQWVlWSThZejlxbE9zUW1INE80SlZ3TDZHL0dI?=
 =?utf-8?B?c2hHN01DMVpzTE1KMTllQ3ZEZzJBUVVMazJwUm1STURpRzZHdnFUbW9iWUFv?=
 =?utf-8?B?ZkROL1NqekhSUEx4SVNwdDJsYm55Tk9PbGpuUnJILzJZTVlxRzFVNFQ2bk5G?=
 =?utf-8?Q?eQ6tkvqgcd4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0lubktkTUV5dWZGYU1aUWlSazczMlpLVCtDeXhyQW5xSUJlUDNnZDBnQ0RN?=
 =?utf-8?B?bjlTNHRTQmpIZHJsVDdtQm5oT2tpNjcxVVlRd0lXT1ZNT3lNTHBTUmlFUnVn?=
 =?utf-8?B?RXlUdlg2dGxDQUcxT21PT0hISy8zc25lVmk3NEkya0hQQU1OUWcxd01sTWwr?=
 =?utf-8?B?VkgwdlF6N2c0c3gvL1BVVmUwTSt3WHBXdU1XenNNY3d1VUl6czhZQXc0R0JP?=
 =?utf-8?B?VlEwVFNZbm43Z3doNjhQeWlUSVlMSkpJaTVnNll3U2RoaTlnNVp6TFEzYTBJ?=
 =?utf-8?B?TUU2UXg0bmlGLzFLeitJRm1EOGJINmNUU2pGWnMwSFlmN1AySFJkZ0E3c3A5?=
 =?utf-8?B?VGJBQjIwMDM2b05ueXFMMkxXbHpkQThtQU1XTVJyeEtzVEhrOWxlWmdrNFBJ?=
 =?utf-8?B?SExTcnhHNjZ6UXJjRS9FMk9wbVAxTll4ODFYTEZZWXR4OFJhbnZwRlgySisw?=
 =?utf-8?B?aEZYaVlzcDU2VFp0L2l2a2IvTEpjc3BDRVVPbHVORHNzdmZKSHJzR3g5bWo4?=
 =?utf-8?B?TXp5MUVEcVJXa0ttaGQrQWF0UWltT1N5RmJzNm1XNUhVWS9hSjhhTEptSld5?=
 =?utf-8?B?RlN3WHk5Qm56NGZSekpkQ3lpcWtjdkpQZTQ3RVlpbkxJS0F6SkVGN3JWald4?=
 =?utf-8?B?SVJEcUFsNi9Bb0NEZ25UL2VRSStTeHZsVWh4TnNIUWpwekFlY1pEVVF2M0Vx?=
 =?utf-8?B?MDl4bGVoZGV3dXJjbkpBMTRTcGJLb0JzTUQwS0ZsR2NrNGtSRnE4Z2Q4R2N5?=
 =?utf-8?B?c29EQkxHOHozQUM5NWFtMStKaFRLVmZqK210cEdGVVhRcG5qeFQxUlRSRk1Y?=
 =?utf-8?B?ek1xTncxanVsbndZc2xoVGNKRDE1VHpDNzhuMTNJTDNlVkVaVXF3L3Z0aHpy?=
 =?utf-8?B?REQ5QU9nQVAxaHM3VDFmd1ExdnFjYnZndE5UUDRIUkU4QzRCNk5FOUVBTTh0?=
 =?utf-8?B?TWcyMjBPQ2RBNGYvT09WMnlBNEdRMllPcDRTb2owNzhCb0N2dU1qVUd2N3hO?=
 =?utf-8?B?aGNtNEtBZlpDdUxjZ0pKSTRaK05LR0haVzVTdmdHb3B3ZExLMjFkQUcxNlpp?=
 =?utf-8?B?NUdETERWQnVEOHhHY2h6dXNPRHhCWHFCeEJmN3VFVmo4SHNGY285WDdyMXdy?=
 =?utf-8?B?Zy9Tb2tPSHdoUnJTNkE4bTR6UktDNWFnc1hsTTAvT2ptczEyeFlqM2ppeExj?=
 =?utf-8?B?Tjk0WGtIeVFLVVB2NG03QkFiV2RORlFHdmN6dGRERm8zcDdodjFYS0RyelNV?=
 =?utf-8?B?SDNiVjhiMGVuN2IyMUZmc0tzTUkxMUZJZ0pHRVVLTEFLTU9zNkFWWTNqa3VD?=
 =?utf-8?B?ZHgrS2gxMlpmNEFIS2hMUDQ0WG9lUmlqd3JMaUcwajhQMU5kbDhJTzk2S01D?=
 =?utf-8?B?VGZ5bTNvVHRCLzR4L0dTZ1lDY1JjSEc0dW1WL3c4aDdJQWhFclY2bWkzVEZY?=
 =?utf-8?B?cUZjMmNtV2QxeWxtakR5eTZLNXArR2JDam9mbmFqYkR0b1Z4VlQxMjc5VjFx?=
 =?utf-8?B?WENwRGJpSTRpS3k4N212cVRYNlZnMDJyMWJyYTM4R01JOUFoQmtscDdlcnJZ?=
 =?utf-8?B?YjlvNU5xVDFSSE80N0N2MWZKZ1BocEYyby9wdVlmUFBVMXBoQzRkU3dMWVpj?=
 =?utf-8?B?K1pzOVJVWWJ4dloxZkNwdXFjamVjc1lUUzUrNGlwN3hrT2dQd2luZXlrVEJS?=
 =?utf-8?B?OGpYMlBxK3F0UElhM3FaNmZqV2pXeGpPSEloTGQxdm1UQjgvSDRiOUU5Z1VP?=
 =?utf-8?B?VjA4eVljVWI1S2FNZVZKalI3bzlILzZMdytIY0hUWFNSaE54OThiSG9ZWm5D?=
 =?utf-8?B?T2I5ZzFFd2Znb1VLTFV6eVhTcWFJS3RVUGxiczY1QVAvS0hlOWhpVjZPQXdu?=
 =?utf-8?B?VFpHVzljZ1JnV2ZqYXFnY1NsbTJOSU9GdXlLeE5hZGFGZjE1d0ZVbnB6TXZw?=
 =?utf-8?B?RHQ3R0JvYkpWUG5sanRtbHBzQTByMjNjR0dRQUVuMmhEMjl2c2s3MkY1enF5?=
 =?utf-8?B?aW5CYTVNOHNSN3g3WmovR3lTZWIrdU9lOTkrV3lmWUNkSWxYMkxmU1JJQmpB?=
 =?utf-8?B?dmVUclZsWEVZb2M0OFlndzlYd1JIN2NUQ2YzNUQ0TXR3ejMxT3d6MTE1TXoy?=
 =?utf-8?Q?FgkavuxwRk6SzNzpQYABKx4ab?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc945512-f193-41ee-ad94-08dda7dd7104
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 05:12:48.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1H4g7OChAuSpL783sjUUiQR4jBgQc70mazi8P5XL4bqWjGJQSU/uIYE3KzIeS6m35ylQ0G7s7rDIfZa/apHwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569

Hi Ingo, Namhyung,

>>> An alternate approach is mem_op BPF filter:
>>>
>>>   perf record --filter "mem_op == load || mem_op == store" ...
>>>
>>> However, there are few issues with it:
>>> o BPF filter is called after preparing entire perf sample. If the sample
>>>   does not satisfy the filtering criteria, all the efforts of preparing
>>>   perf sample gets wasted.
>>
>> Could we add an 'early' BPF callback point as well, to fast-discard 
>> samples?
> 
> I guess that would require a new BPF program type than PERF_EVENT and
> handle driver-specific details.

Right.

>>> o BPF filter requires root privilege.
>>
>> Could we add 'built-in', 'safe' BPF scripts that are specifically 
>> prepared for perf events filtering purposes, that can be toggled by 
>> non-root users as well? These could be toggled by tooling via sysfs or 
>> so, or even via the perf syscall if that turns out to be the better 
>> approach.
> 
> We have BPF filter framework in the perf tools and it can be run as
> normal user.  But root user should load and pin the BPF program prior
> to use like below.
> 
>   $ sudo perf record --setup-filter pin
> 
>   $ perf record -d -e ibs_op/swfilt/u --filter 'mem_op == load' ...

Thanks Namhyung.

Ingo, Do you feel the idea of perf specific 'safe' BPF script is still
worth pursuing despite similar functionality is already provided by
--setup-filter?

Thanks,
Ravi

