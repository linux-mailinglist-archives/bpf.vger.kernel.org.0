Return-Path: <bpf+bounces-38392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B49643C6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F32B24028
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B001917FC;
	Thu, 29 Aug 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m28pwUuR"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010010.outbound.protection.outlook.com [52.103.33.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA218E756;
	Thu, 29 Aug 2024 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932984; cv=fail; b=M++0Na4lM8i7khv2kZfzu54R8C9Nl8eFsF7bJrWs1I1vnNTBSzPABN6hoOz+SM6+AOTmnNc3w+PnCvNH6z2GNB/CExrzXc419X6/Vsh0qW8Mp3n2NUGYoKNebXbKKEyILX3+c79TygpdOyhrvP4Fp/aY3Q8bgMgEVmQ0aOG+YnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932984; c=relaxed/simple;
	bh=fc0Z3Pv+OnqMx/QuDcBUkAsyqWOj76znw+vGY4gQddc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rg1nnfGcv6j37ZxjmpADWqk3Vi3R19Ejp7sNSkEHOagg/6keJqZLGe0MPxl7f110Anf1sbt7WUIgXJ2u22z7d1nH5h8luXOb9YghPvW2wlD7Td6eRYEYGqtkbpn4IMHJvnvI+TjyCpqhc7c/p2XO5xtOrjmJ4vZusONfkbQUDEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m28pwUuR; arc=fail smtp.client-ip=52.103.33.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWotNL+b/1lIKl9pFo2yhxxIrgIOBZ9umDuMJYxaWztHBIuer0j7AyNg1sjxIeRaF3FLzfLenVQ37FKiQU6RAxEMH/RP5slThxxlzPCxb5e8uAAAmUSekYx3F2KzepvtM3abh8ECCsG4P3O7tvFwouX00n/sm1fy217P75VX8fdM+UCbv8rKZ2DRYat5lBN3tbAoxr9fMuQ/XSeeZBOVWtLbfqGHy+VvGXwz47+eGvdKAoCx3p7lFaTIQ0TWUakgW6BScYAxliZElJYzTbKvzGI47VUoNqmPuTcp4d8HgkEQK9KAmjYHSxaqQpZbpdwUJQsQB06n2yZxHn2cANMCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc0Z3Pv+OnqMx/QuDcBUkAsyqWOj76znw+vGY4gQddc=;
 b=oekRArmewtSXG+BOfL4jx8JnlXtolHacnse6zksfsDeSxAx+dZcKr8oLgcU1Ef9SCZpofdnpUmXeEIpLtJNPhaZnbJV0FiMPJvKk17y7yMWoLwWWiGhoac+eF64URKYTZDDVS3HMeIoERWHYxvQIJT/UAGIMoRyuShueJQv6rKTDHQ8YvYMLT1hP5d9m2HHPYGt9kICM7WQ/UFxP0R4o9ZnBHel/M38GGr3iWwcYoeTjpQwcBZyIPAK4vvZNP0inXfCdCnCmjW5AqwZfrK0u3GngNUfuc/OGuEoGO0t5lFYL8UlCE40bhUIWdmY7OFlG0tBTzPXM5bFpftzQNU8EIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc0Z3Pv+OnqMx/QuDcBUkAsyqWOj76znw+vGY4gQddc=;
 b=m28pwUuRHvPH3iR2Mweczz4MowQzHhchNAcBRQmoqwaS0y8SkxugzG7f174e4bCklG4JoDzcr/E5NoTg+Mt+gK+iXhaPO5wQLq+uSyrs0CYdgTFL9NW3sblI8cu0J97tMGGHuNBLXxA/wAUKpgAA2e2300DoPYkk+FfQx5+gN1K2XPz5xiYHezdH1ZWi64Q6EeE6OJnTnS9V91bH3RTOlfYsdmTW8YPbRLiRSL8rx1mm3dxAGusY2IlF5u4M5NkCInER8G1XwUECdKxHzHOhCRkYrOO+gmwmNlg+Lh+MxFg8Ri3eWtt11QILoBinAA/hu9gbJMEZjsR2opui6QcHiQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAXPR03MB7715.eurprd03.prod.outlook.com (2603:10a6:102:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 12:02:59 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 12:02:59 +0000
Message-ID:
 <AM6PR03MB5848CC486825EF56A7DF0FD699962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Thu, 29 Aug 2024 13:02:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for iter next
 method returning valid pointer
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848706D6E610747C4BB6F9999962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB5848706D6E610747C4BB6F9999962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [XPt2yJSDF2SMYOF1ZcyFUHSqrDpgEe8f]
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <33ecf659-cd79-46c8-a1b3-6b7ea21a0dfa@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAXPR03MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b68439-62b5-47f8-1085-08dcc82286c7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|461199028|8060799006|19110799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	BHgFluVvYugZKO04zKRvIuuW+eDv/tm7FEFrEBwr9kifFbhw8zxWQTUW6ywZS54ZY5x9+DMQW5e+4RPZdiK6sxg+6cZeuoyb5uNxOmGuwB80OWR3460fmDeau5kXDC/QK/bqqntZItZV4737/zxEjVdAQbo0UaSp68aosL3gvu4MEXnAK0EnkkRRECG+Q7Qibz9MDVdCt8/XvJinuMdfscWuAYKu6ZRGs/Becf2rhxhb3QiesjhH2M7JX3gSGqaJepBCZCI7CeIR43hU6NicC+Zw7YCPf0kaQjAYVCl/ZlEtZQ+XZ1HokBNHRQD8BtnI3qsTZOfe9EulQKf78r5hSkJvzk8xFEKpnQ3wDMOgUfDtTq1oEgyijeuFalN4qKCAbfgAetSmpXnOr9asvFd00INxxjvpeJUM3gDSilsajs6Sil5g1TCtjpAGrMdekhCbz8KTfpgHcNv5u1ILaq6NKaZbvxZmowFHyxXH/Qu3Q2tvpg5b0bhO66kZZ4RLDvkj+rhmLx3f1KsLE8xIUiQW/geGcCnDZR6TKWo552yPbN5jvYEPvqZKC3hB1GQcd0UFcayGsIy8LQEnNubDA748qoOOtwGuS2N3OQ4ssv4UZoq92wND8XJbwzFJfXYAHgtQQysIR1xp4ZehsOwB3W1ooTaPAMCtfAwNYS9oChUzbCg0/oHrqAfxJzg+k6eF4LKuG/C/1UzQdnufCwja2N8UBh2bHTqSGGSnUftxnvUhOOI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3JmT2d0NVpnUHljSmxoWDBYUGpMazF4T1NGWlpwOW92TEhNTHpRNjVtVTYz?=
 =?utf-8?B?SVlkbUxEbzZoTXl5bGErN1Y1TjkxYUxPa1VlUVU3dCt1TTZEM2lQOUlBdUZj?=
 =?utf-8?B?ck90eGw0WHlYaGRqdlA1Z2RJOGNkYTFHcmZSK1k1bUVrcmVhRXgxRFZCOUdC?=
 =?utf-8?B?NFBXV0NiVWU3UytjQk14ck5uVjZIUUlUUXkrV1BSVHVQNU1mOHRqd2hKMFFR?=
 =?utf-8?B?bjBsVjdCaHo1bTBLTFltWS9Ic3BIQ0FzVVRSRFAwMEtBU01vd2Y2TGdpWUtT?=
 =?utf-8?B?c2YwVUlmbXJBemtYNzIwamY3U3FTM1NMZysvbGFWYWJ3aFlBc2J5dnM1eVBE?=
 =?utf-8?B?REk3cXo1YktzUFU1REk1NFV4aTd0TG8zZmdwRzgwdFR0Q1k1NElSdHg1MDhR?=
 =?utf-8?B?Rk1hZ0ZDRXdVSjZZM1JEQy92bnNSbTE4ZjI2bHBlTUV2aGl3YWhwV0xWbzFR?=
 =?utf-8?B?UU9tZGs1cGxMWHlhZUw2OXZtUk1xU0hOTk5iSkJtVzFoTnZqSnozOFRvMTJj?=
 =?utf-8?B?Nk14Y05FRlZuWko4NUYzaEI4RmpyV1RzWkMyeGZzNkVqc0tRQWVjUURzanZQ?=
 =?utf-8?B?aEhpQURpWVp0R2xKLzVneVprbTRUMCtQU216L0xyYTlwbmVDbllwVFNTeEJy?=
 =?utf-8?B?ZWtGUWp5bm1xVnJnZ0NnN0E3NjE2ci9xMTB2ZVFLT0pnWmJnUGpkZnhGY2t3?=
 =?utf-8?B?dU51azdTOGxsc2NXakhTdHpUZHJJYTlzUUQrYXFQSGxGc1RVWnRSN1hkR0tW?=
 =?utf-8?B?WldWVDVhSk5lTzhySXdkdWVkNGVMOFlHVEgvVmpjelRxU3AxY3paVFo1UzFC?=
 =?utf-8?B?YWorbWl3OCsrYzNkVC80ODFzYlBmVjg0QjVOTjF6T0NwWURKV3hQeU5oQzY4?=
 =?utf-8?B?d0pHdk1tVXI4R1BKeU42RThYQ01ndktYRkZNUUUxcmVrQXJDLzRBS1RkZnhl?=
 =?utf-8?B?UThsa2NaU2dSTWFLR2Q5cmh1dG15TWx0YmxoTnBrVXkyK093TkhVL3Z1MHJ4?=
 =?utf-8?B?SS9PWmFIOW4wR2NGcGtlcVVFcXR1d0djK25sR245cWZCZ1FUNzAyM1Qzb2ZW?=
 =?utf-8?B?M3lhMDE1dW9HOG9ZWW1aaG1LQXRmSlpEU1V0VjRpenlqdm54eWpoaXB6SkJO?=
 =?utf-8?B?L1JGRWdqL1VRK1pOTWpjVzY5MXp1dkFlN0U3N0dQUnpTaWZ4ZS8rdFhQU0No?=
 =?utf-8?B?OWlVdEdqNHZhcXlKRXVNSXZzaHJremJtR1FQQ0FRTGJmVXBWb2tCVmtQNWI5?=
 =?utf-8?B?Tk81RG11OGozV2NsRHlsTXJ5b0UvN0FhL2pJV3BFMUd2MFJHSGd4c2t5cHB2?=
 =?utf-8?B?NVlXQ1dSM0E1alNzUEE2aUVuQnEvSHJsLzJ3VXNrM3ZZUk4yL2h4OUM1OHBz?=
 =?utf-8?B?ODdGd1ZEaEtaNXNGZXUvWlRXK3ZyU1BoeXFaNkVjZU9wbW1FSGVldlA3NDdG?=
 =?utf-8?B?ZXZ3enZrZFVHeGZQQUNOYTZLUlAxaVU3bWhXRitTcFNUWlhtcUQ4SElkb053?=
 =?utf-8?B?b1BJQStxc3d0YVVkMjZLZkZwNVFWQ2EyalNhc2lFdk1LaW8yUFZQT0hHNUxH?=
 =?utf-8?B?WkNJMG9haVVPSFhCalJYTDdPK0VGcFBKMDJHNmNrQTh3ZVlTUFJyU1VVUkdo?=
 =?utf-8?B?SFRvN0V6ajh0ekdGMUFWREV4VVIzaXRlRGhDWFE2NWdhU2JPK3ZEYjRUSXA2?=
 =?utf-8?Q?CMAEP9qptCuc6E9zPbsC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b68439-62b5-47f8-1085-08dcc82286c7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:02:59.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7715

I saw the s390x test cases in patchwork failed, but based on the error
logs, it looks like the errors are not caused by my patches :).

