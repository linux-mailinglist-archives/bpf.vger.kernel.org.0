Return-Path: <bpf+bounces-51602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CABA366DF
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2A77A1FD9
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AE1C8613;
	Fri, 14 Feb 2025 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J4ctWFkr"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011078.outbound.protection.outlook.com [52.103.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31413E898;
	Fri, 14 Feb 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565038; cv=fail; b=jsr6fepmxa+UbZLnRRKmdV95tqYqAxPQ/hnOhqsPiD0geN31SNYTR+CVEgUgcXmieUgcjPRDDKZSxNBAIe/hjODC/6RTC6JFAIC5TSxazQoltg+opz54aFpSQW8ykQjno/+kGKDmD7EfejKuCWIfZbDSvXPhlC5o1sHTF9bJC2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565038; c=relaxed/simple;
	bh=iyoujd/vLClzq61/KJ1DZBKIYLRmoYR7AwL8ucF6xJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aa100OAKcJa2iLArftipQEx2Pwc50g8fCBR3IxPBkvpFK2HijNTET2mJaRfU62nHLlAW79vIN36W6n/DnYRQXiw+XVcXwzgbRmIuUNWvk+afNYvrywcFJ10Uvk1Y+fnmzBb1hQj+X21Tv2uGlOAe4OcHsfXKATHbIB35n+W3nSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J4ctWFkr; arc=fail smtp.client-ip=52.103.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7rgo1V7xaM+P9HHszmUHSL5xAYSpCJTkOzoehGg68DI7Tc16XMrJP25pOj0wiMgjEWttFFp/WF61Jix5uvXlPIM6jAVD3qSKzq7ezikher/0N3CkG4hqGOnrWHxH+fRPBfr0E3CmrDq/AKpou6SUPZHNaFuBYbTpfjuVCuF3y1dyzf0JhGLPnNbYkvQSMfMl+gDQqte16SRpDTbF+UIZdufVMqgi90VIRBGPz7tO44FKIV/IvaxqDB+WvYsvp8X3R2EMQRs0LLPy6wt/rydfSYxseNoOykD1gFlEyPu0BDpZLycvMV9BF4TO+STwc8ed38aBvASj6Yf178yRB8LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzJjbKxdgm5C2X5JhCAQrFB7ECGqr242WNe8WpKVBEE=;
 b=v9sEN+giehrj+7rA3uL7XlocZPhbbpTsU+0rYW8+XDSEiZ5a09XrIsxvp/tDq+a6eMN2b3gX+o1gEAF9sMM25SWd3J/5wMwYorMKHJABhfDWr7d2g9gIyLu3xmrS/87l+Rd1n2zzzn9uLcr9KoiEAcuLdpj7G8dm2+ZhC2OfXzGH1JkwyDaKmNvc145p6lQkD5WjSIIMe69sCuKWBy2cOU03YS0riUgxznhqfPvyEd97O9hndtnJ7b4rK97RrDr8Ibi4l1DtOfJqMwm81xZfU2nB+cL1b9oFE0b73j94pOsB6fbkBTuFPAM2kiTpaZKNtOC132AwZPuwQV3lw0Wz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzJjbKxdgm5C2X5JhCAQrFB7ECGqr242WNe8WpKVBEE=;
 b=J4ctWFkrKbq2wVX+txWVk9TSckZLSzmWm6uG2iZ0U6jMqbHX1yfr6xI5ih20xd7dGKxrD0a388xX49FdftwIwnR9iZBjWz43vk/SaYiLchxYTKeYNZ85PncZpaTKIRgMKybQLIeHQyl8UXL8ExbJnGTJvHRMAlG32ElNIARY5Hx2JwbgDZ1Znj4G7vvMjSXI/CYDF5OfZqVE/3eZY9j15Klt0fZO2on7lPrQgzHrWwI2madt8rCMXhO6Gwj+rriuRPv1c2q5FMhOc5exgdIMsnwuauklRWjquYhl4rfNImaZWFIRkz3dbhEB1TRUAAG1h71oSS9h0kugJsS9J7lvpg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by PAWPR03MB9034.eurprd03.prod.outlook.com (2603:10a6:102:33a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:30:34 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:30:33 +0000
Message-ID:
 <AM6PR03MB508083D0D2632436DCBEC0A399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 14 Feb 2025 20:30:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 6/8] sched_ext: Add filter for
 scx_kfunc_ids_unlocked
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 changwoo@igalia.com, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>
 <AM6PR03MB5080933CC30F9105A617351E99F22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+BmPeDxZUJ51qBQjK+yMSVkVLR2maSbe03tr+8T+Qnqw@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+BmPeDxZUJ51qBQjK+yMSVkVLR2maSbe03tr+8T+Qnqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <23bd784a-e77c-4359-adf0-9dc1fe603871@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|PAWPR03MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6efdcf-4f20-4c0b-b749-08dd4d366e81
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|6090799003|5072599009|15080799006|8060799006|56899033|1602099012|10035399004|440099028|4302099013|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm81R09zcjhXVHIwY3lyYzFYdE5TT1JOekJHTGNNZEVSS1hINjd4ZFlSRVVC?=
 =?utf-8?B?dTg4VVUwSEtXUi93OThuNDFBR3hPc2ZqY1VhbUFCMSt2a2Z0MVVuZStCMTRM?=
 =?utf-8?B?OFoyUWZHREd5ZTgzblZxN1ozRDMzMmxNYkhyVXJodDVMVUJmdGNySm53TWhx?=
 =?utf-8?B?bCtFeloyVHBUUm5KVU5GSXM3OHA3U0V2ditRZUQ5T0NjcjZJRHJUY01aZE8v?=
 =?utf-8?B?M2dxdng4VnpORXZGbmdQRUprOWl1eFl0Yi93bmdyNWFiRXJNUFpvbW5IcnlE?=
 =?utf-8?B?UVNVTzByZ0Q5blNtWHU4dGtqWHFYR1IvMDdFY01QVE9YeFVnUUhSTkcybVZx?=
 =?utf-8?B?emxROExIV0ltTUpRdVRhdFc5ZWFyY1FERkJqVStlSDd2TEJwS1RJWU1jaldz?=
 =?utf-8?B?K3NGY3p1czc1SXJqak51bmNFQlVQMjVqU1RCdHlFQ1E5eW9uSVdscTdoYkZY?=
 =?utf-8?B?WERzNE5jMHlFYUx0YnE0NWY2K0VmQ2NoVGpxVlFKeHBVSVZXbEdVRzgrQ1NV?=
 =?utf-8?B?eTltNURhRGhTYmtCMmFPWTFqd29nOWczOW1laWJ6OVozN3JEQ0syWmVVcTNC?=
 =?utf-8?B?RFBLQVo5MWNIY1JOZVE5b0JaaVRnZW1seldaYnlUM3RTMGRhL25UZlN6d1p6?=
 =?utf-8?B?Ri9WektPNlRKVDZBb1oxaDZvNFIxRkV3MXNRd0wxL2Z4OWRrZ3FMZDNQS1Rs?=
 =?utf-8?B?eGlTNEpjbERXd2xvWTByM0tzSStrVnNEdVNkcVZxRUlZVTd6YlREblMzSXNS?=
 =?utf-8?B?K0s4UEZKendYQndXeVFRbzR4L25wcjdTY3ZDeDduaWZhbUNoNlNDQ1l3dUZa?=
 =?utf-8?B?U3B6cWhhWWFnWms4UDN4ajdCUkh5RUlVa3VUTWtYdDZkTjl4S1lXRWwrNTJF?=
 =?utf-8?B?MWJ6dDRWM3IyMUdPMU0wMjZoYXZUOXJhWXBlaUdZUjgwcnN4RStFOTN4TDFX?=
 =?utf-8?B?Tlh3TWkvQ25WTnJ0YnowcUNGMkFHV3Y5bzU0QlI2aGttbDZvYWVQMlNNWUhv?=
 =?utf-8?B?dlR3bkdKbGNiMnpuZ3ZmS2hOckJlb3BQZWFMNVRoOVkxdVorS0JrQ3JPek5k?=
 =?utf-8?B?TDE5OTc0eThxUnJ6QVNvTXlJMDBkbDhmMXFoWkxhcmw1ZnNTQTBDYjBFVUds?=
 =?utf-8?B?aHZ0OW5weU04dUJTOFU3blA4eTBrRUx5RGtFQkx5cmNwckNORHd6a3JubDhZ?=
 =?utf-8?B?M0JyZ3puS3haWWVzM1B3TTRYNWcxZFNtM2NhSXNZRG51ckd0S2EycmdwdUNv?=
 =?utf-8?B?QU1ZRGhoRE1pN20ydDBpRzJjY0pDaC9xaklWbE93eWs0dkI5WHl1VTYyMjdD?=
 =?utf-8?B?bnZESHArSElmQU1NcjBtcHo1VW9RUWhRNGQ4UDV4UjdUcktZU1BFWEl0Yk05?=
 =?utf-8?B?RjZlVmsyRFJ2b1FVL2NtcWtTMk8xbVRmcGhMQy84Y3YzcEhvSnZuRFRPVUt6?=
 =?utf-8?B?ZkZLTVkwYlFHUWlDWThXeEZ0M1V1azBPcUdpMlJJUHlxN09YSWZQSlJRcVRh?=
 =?utf-8?B?bUVUTVllU3NBNlc2ZGZDdGZhS0k2QTczRTdzR0JkOE1LMlgzMXBQcFhvREs5?=
 =?utf-8?B?cG1CbCtQaWFxUnk1aEM0WmpkTEhNYkgxS1loaTJZVEJqZVVpVkxNV2xseWtn?=
 =?utf-8?Q?IPS3jlbiYQ1rmQ1mn5CIrFAm20O5edfwcrTPkTDuaDFc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlLOWdIdnUrUnhnaitYTTVZL21pTGF0bUVXUytzY1pJa3dzdUhHNThZZ01n?=
 =?utf-8?B?RUpOV2xpY1N6WnJtaXRaMFJmRW9jMW8wTWVyMDMwYVVDWU9MR244ZlY2WFM4?=
 =?utf-8?B?Qy9QYXRkZDcxUHd6dVdwRkxzWFRGWTN0Zjh6QlBiTDlaWndPUWJBdkVTUFpM?=
 =?utf-8?B?ZnU3RUhxTDM5TVdVSWJQNlFuM2RhWUVCUDBmY2pyREtpSVQyVzBRUjFqdEI3?=
 =?utf-8?B?akw0dkdFbnNyZEt1Y2pZeWVucjlaTm41WVh1aG9wVXhvTEZHNTd2elR1ay94?=
 =?utf-8?B?T2ZLZWFzL2hZc040R2dHUEM5UDgyQ2w0TGFITFBXUi8wSmQ4TFg3R0ZYKy9u?=
 =?utf-8?B?TGdQeTBGbDRISmt3c3l6a3JlQ0hXLzQ4OExCTmtTNkkxMkhCK05Pa2ErNFdH?=
 =?utf-8?B?dHlmbGVDTmFOT2JsQ3phSlVKTFNld09uSmxQZDdFOUJsbVFWcGs1WFNFS2hD?=
 =?utf-8?B?OFFWSGFIcDViYXFjNDJoNmVqd05QN0dxM0U0Q3hOOHZIOTJsOFpWYVhXc2tT?=
 =?utf-8?B?VVAyUnp4dzdQVTc4SSt3SUdubVNvVk5JSkZmRjdmYkNzdkhsejRlL05Xc3ox?=
 =?utf-8?B?aUxiNnVlNFFwdlhHZTF5bG1yVVNLMWxSSWdOeWtOU0VTN0dZZS9pOVVrZE4x?=
 =?utf-8?B?azlIblNMZDZSTFB5YjFvbjVNdzJXNTlNUHorTHhFWXc4UHdDWHRDQXNOaTlT?=
 =?utf-8?B?aExSaUhjUkNvQUlaaFFhUzk5WG9kU3Yxd1ROOVJiVzU1OStIMEwrRk1US1ZW?=
 =?utf-8?B?TVh5bld3QUx0NFgvbXNvY0lTakp4cnhGZGJ3U3E5NGluckprT1o0ZTFTM0tt?=
 =?utf-8?B?czk4ang3QkNaZHE0Rzl1MUxOYlBCbC9nZDQrNUMzdzBkZkM3OVlycEN3bmJ6?=
 =?utf-8?B?blFyOE4zbWFEYktCMVEyQmNhaHZDZFB2bFhNbWlSQXcwYjFRSG9LQnhsM0F0?=
 =?utf-8?B?NW0ydzB3NHBCN3R5SVgxWmJEMEZ2bWF6ZEk0TnlWU1k5aGx0ekdoUTU2cFkz?=
 =?utf-8?B?V20rQ0RvS3RJUndsZXpDZ3BORkU2MFRyZ2pmN20vKzVzOWsrYm5hdVE2Z3Jl?=
 =?utf-8?B?cGdkNTdXNFVjQ3RiekdVNVYxTzltM3FPak41UXZ3b2FCTitEL2lua1czZ3NY?=
 =?utf-8?B?K2lLN1kzR0dycTd3MFZSNzVyNHlwUXJhalgrdlRoNDdOUjMxZUs4Uml5VGRj?=
 =?utf-8?B?WUd0YnUvdGhyazRKZHQrNm9Ja3FITXdWakhsWHZHWXl1YUdzdENGSjVmamxz?=
 =?utf-8?B?SGVFL3J4NCtuM0xjUlJWcjBYT1p2amZVNStLY2pGNytFUVJOWFZ0N3lLd3VU?=
 =?utf-8?B?aHcrR0tybkdwM2h1TGh0cWZ2T1dQQ0RzTDRqSW0zRmhIVUd1V3pYSkdDdDZZ?=
 =?utf-8?B?MnZlTWkyNlpnM0JxNmNnbWNucnUvUTRFUEFzbmVzSXhPTEsyaU9sOXhGRG56?=
 =?utf-8?B?TXk3TldlRURYNitWMUxJcHlEa1lyeXFzVktxUUwzU3Y5R1dXRHVBR3dEcmNZ?=
 =?utf-8?B?TU5GTlpLV0I2MUJNdGpKY3l5ak16dk9Nd1c0MWdnR0ZuYkFhYVNJSkZIWjd6?=
 =?utf-8?B?ZVdjOG1MVFdaNWxra1lmYzhyNUhkUWU5YXhRWTNDcldSQzFVZHMyOWVESVlE?=
 =?utf-8?B?ZUFMeDJsWmJDODBWQk9xVmxkMklaS1J5eTRGNXp6K2Q1cGdiUSs0UVBiaWU4?=
 =?utf-8?Q?CJjivFYBzu2LtFX7bn8y?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6efdcf-4f20-4c0b-b749-08dd4d366e81
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:30:33.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9034

On 2025/2/11 03:48, Alexei Starovoitov wrote:
> On Mon, Feb 10, 2025 at 3:40 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2025/2/8 03:37, Alexei Starovoitov wrote:
>>> On Wed, Feb 5, 2025 at 11:35 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> This patch adds filter for scx_kfunc_ids_unlocked.
>>>>
>>>> The kfuncs in the scx_kfunc_ids_unlocked set can be used in init, exit,
>>>> cpu_online, cpu_offline, init_task, dump, cgroup_init, cgroup_exit,
>>>> cgroup_prep_move, cgroup_cancel_move, cgroup_move, cgroup_set_weight
>>>> operations.
>>>>
>>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>>> ---
>>>>    kernel/sched/ext.c | 30 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 30 insertions(+)
>>>>
>>>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>>>> index 7f039a32f137..955fb0f5fc5e 100644
>>>> --- a/kernel/sched/ext.c
>>>> +++ b/kernel/sched/ext.c
>>>> @@ -7079,9 +7079,39 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
>>>>    BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
>>>>    BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
>>>>
>>>> +static int scx_kfunc_ids_unlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
>>>> +{
>>>> +       u32 moff;
>>>> +
>>>> +       if (!btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ||
>>>> +           prog->aux->st_ops != &bpf_sched_ext_ops)
>>>> +               return 0;
>>>> +
>>>> +       moff = prog->aux->attach_st_ops_member_off;
>>>> +       if (moff == offsetof(struct sched_ext_ops, init) ||
>>>> +           moff == offsetof(struct sched_ext_ops, exit) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cpu_online) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cpu_offline) ||
>>>> +           moff == offsetof(struct sched_ext_ops, init_task) ||
>>>> +           moff == offsetof(struct sched_ext_ops, dump))
>>>> +               return 0;
>>>> +
>>>> +#ifdef CONFIG_EXT_GROUP_SCHED
>>>> +       if (moff == offsetof(struct sched_ext_ops, cgroup_init) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cgroup_exit) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cgroup_prep_move) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cgroup_cancel_move) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cgroup_move) ||
>>>> +           moff == offsetof(struct sched_ext_ops, cgroup_set_weight))
>>>> +               return 0;
>>>> +#endif
>>>> +       return -EACCES;
>>>> +}
>>>> +
>>>>    static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
>>>>           .owner                  = THIS_MODULE,
>>>>           .set                    = &scx_kfunc_ids_unlocked,
>>>> +       .filter                 = scx_kfunc_ids_unlocked_filter,
>>>>    };
>>>
>>> why does sched-ext use so many id_set-s ?
>>>
>>>           if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>>                                                &scx_kfunc_set_select_cpu)) ||
>>>               (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>>
>>> &scx_kfunc_set_enqueue_dispatch)) ||
>>>               (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>>                                                &scx_kfunc_set_dispatch)) ||
>>>               (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>>                                                &scx_kfunc_set_cpu_release)) ||
>>>               (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>>>                                                &scx_kfunc_set_unlocked)) ||
>>>
>>> Can they all be rolled into one id_set then
>>> the patches 2-6 will be collapsed into one patch and
>>> one filter callback that will describe allowed hook/kfunc combinations?
>>
>> Yes, I agree that it would be ideal to put all kfuncs in the one id_set,
>> but I am not sure that this is better in implementation.
>>
>> For filters, the only kfunc-related information that can be known is
>> the kfunc_id.
>>
>> kfunc_id is not a stable value, for example, when we add a new kfunc to
>> the kernel, it may cause the kfunc_id of other kfuncs to change.
>>
>> A simple experiment is to add a bpf_task_from_aaa kfunc, and then we
>> will find that the kfunc_id of bpf_task_from_pid has changed.
>>
>> This means that it is simple for us to implement kfuncs grouping via
>> id_set because we only need to check if kfunc_id exists in a specific
>> id_set, we do not need to care about what kfunc_id is.
>>
>> But if we implement grouping only in the filter, we may need to first
>> get the btf type of the corresponding kfunc based on the kfunc_id via
>> btf_type_by_id, and then further get the kfunc name, and then group
>> based on the kfunc name in the filter, which seems more complicated.
> 
> I didn't mean to extract kfunc name as a string and do strcmp() on it.
> That's a non-starter.
> I imagined verifier-like approach of enum+set+list
> where enum has all kfunc names,
> set gives efficient btf_id_set8_contains() access,
> and list[KF_bpf_foo] gives func_id to compare with.
> 
> But if the current break down of scx_kfunc_set_* fits well
> with per struct_ops hook filtering then keep it.
> But please think of a set approach for moff as well to avoid
> +           moff == offsetof(struct sched_ext_ops, exit) ||
> +           moff == offsetof(struct sched_ext_ops, cpu_online) ||
> +           moff == offsetof(struct sched_ext_ops, cpu_offline) ||
> 
> Then it will be:
> if (btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ...
> && moff_set_containts(.._unlocked, moff)) // allow
> 
> There is SCX_OP_IDX(). Maybe it can be used to populate a set.
> 
> Something like this:
> static const u32 ops_flags[] = {
>    [SCX_OP_IDX(cpu_online)] = KF_UNLOCKED,
>    ..
> };
> 
> if (btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) &&
>      (ops_flags[moff / sizeof(void (*)(void))] & KF_UNLOCKED)) // allow

Thanks for letting me know this method.

This is a good method.

I have used it in version 2 [0].

Also, I figured out a way to require only one filter.

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u


