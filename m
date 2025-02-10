Return-Path: <bpf+bounces-51067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC40A2FE88
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6311656A2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75E260A42;
	Mon, 10 Feb 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lNhPluWa"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2075.outbound.protection.outlook.com [40.92.91.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20D253356;
	Mon, 10 Feb 2025 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230830; cv=fail; b=Sy+hpVTvc+foNkLCrqwo1zGz3GbEUVwRQ03KWCo7KVbyzW1hoHf36bGTQFGUcU/n/x05ysHSfBrTXPMdR88C5zvVhoTaV8/P/9TnMloUbdED6NEv3XV5C/faa540TaiRdXHy21evJ42bBsDG9QeUU8Nxni9ZdR7Tj83nswcTx9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230830; c=relaxed/simple;
	bh=VpHt0cuiurkkGsDADJENIP3mxjTXm7pRmFKhzOEI3Wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETdaf0oZP1j0hOxbMsSfBbUlZ/7fJX/ZVBwyT8OV2N03CiJue3g+aY5IKXAqr+ylgZxfMmw8xhDhyOX4CxBnEkvMjxGNxoItMQjsaY/6mbUrv+1KKbdJgBw+hPznxFf8qbm1yMhRxsb3kcFlxNUyhtGZOgOGxdeeYmshi5NuV3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lNhPluWa; arc=fail smtp.client-ip=40.92.91.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu3VGokOhYIjZIuPerkBUGMx3VhWncFGWp3AyfOnbDiR4cCi7BRt1PtH76+rxxmsQ4Njdx+1sJbMl6efZ5peBkHR7vivaNmfBuMCbCIfA4aLRK2gVRqj/RFDY7HdySsgJ0dwZ7cx7m7jr/JpUmvvwUfo1j8Goou9OyB4M3NDt1wfBwdgWEfKmgsO7bUpHB/ayXOyzBNYtL+kcs5O2niVPPqXHj603Yp5KS3K+xdINUQviXr9Eu5NUOHS7SDCvPbBYPEK4fkL6tJNMcY9nv4ny8HU6kJJqqXrl05mG/0lm6QdaTnz+z9cbQscHh+yQPyvXJQFfl+ERNKLgGg2Sh6faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMDPDd/iZNebyGG8kdvQs1YTyGLuwcsdaWMCpYVtJDo=;
 b=u+ZSZ6MAG+N/re7JPu0qzSdwUjFKjPRfkS85xz2cXh7/NBcSKgtVWD6RTWmyZV29acdxo4CzVbWYmnQFZRoflyYdYUe5uFgGMOTkW0QHtOGebvQjx2E3na9iQhel1wpLwd4+Sjq7FQ2CgZRfeXv0D9aiZhiPjb9edW4NLJ2zIk7FfOM9PzBPivyC55B+abH78p7zlTWtqJC3BL2alut0QisTIVg+ix3+zqC9pbt5vH6MmQOh+QYkflBoA8tc1KayO07OT3dg+uioi0LlPVUG2hXdcMbFD2Ez46vlg/BxbKNe+QW83tbVW9Mkq3dyGVqm535foNDuFF9rK4RcCrQIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMDPDd/iZNebyGG8kdvQs1YTyGLuwcsdaWMCpYVtJDo=;
 b=lNhPluWa0qR1W+nre3gGlqHoY2EodDrydTGufo/3hsfVzMX9UqR8Ld0PgOGDAEBmC5zZNDqDf+fHfjAxCv53CsqXQWtswwar+ODA6MuvU39iomPZiWuGZ0bZ+yduRh+i2gDJuVk2qAMwm/dQ4oyTRrrgOK5cHhFcRwxsGviC611j0q9m3x4sNsBXh6ZFuoBCStY4Q/2gVYwV6iBuZorRZM/aw4Pejo9jU6q+Q+3eGcWF4FWHpBDGiq7Ilt+6HZZVLDKzF0csPTXT1/UCRNJEz5Y6lN2yJHWbZPEORChs0RFnCC2/OVxOUuTSnrYAcxuggNaQYipg5yaDdO8OTZr7yQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB8042.eurprd03.prod.outlook.com (2603:10a6:20b:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 23:40:26 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 23:40:26 +0000
Message-ID:
 <AM6PR03MB5080933CC30F9105A617351E99F22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Mon, 10 Feb 2025 23:40:02 +0000
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
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQJZnNj3KGcy-MKz_F2KEiKWGpXchxVx1zuGA-5g3SO=HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <afa5543c-a17f-4564-8757-4de2f1930070@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: abac90c3-618d-493b-da47-08dd4a2c499d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|461199028|6090799003|8060799006|56899033|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG15MlpGSnpDdlpnckJxWjFlZEsxNzB3NGQ2QWZhVS8yRlVua0lZVDB3ME1n?=
 =?utf-8?B?b0JnVDFhNjB2bXpaMDh0bVVhbzN4eDNxVXlHSGczelpwSCt3bGVnaVVTL2tu?=
 =?utf-8?B?aGZ6ckVad0ErQXltV0tUS0UrOHJvc3FSWWR2dzM2aldTVHV1TWRtVXpjdHJz?=
 =?utf-8?B?L0gzbGJmaVpXN252WmJTZHBWZ016N0UyeGphdENRRFJKYnhDdzQ1MzBGQzNl?=
 =?utf-8?B?MEp1czUzQkxzVDRxMVNLRW5lQndpNVo1akZRalN0T0N0RnllNEFOVnFid0Jq?=
 =?utf-8?B?SjZ4djcxR1p6MlFhTU5qNFc5Z0N3YXVRQmVVemRTbGFyUnorVU54NDBHZlRu?=
 =?utf-8?B?alFHZDdvODBtUHp0MkU2eTVkMGJUQjFkZVJNbnZWUFRFdGx1RUFBcTJUeXpm?=
 =?utf-8?B?ak1ZWUMwblE5RXEvUFNQQStsVjJsSUNjK3Y3K3UvaFBLVnhyNDlGRTdaYzJE?=
 =?utf-8?B?VHBWU2NtaXFJV0U5Sm1EODFwQllrR2wvejZkRW1aUGp4WjcxYmZ0VXNDdnEw?=
 =?utf-8?B?dDZyMFdhZ01Dd1ZkL3VEbWNhNDVXc25NUlhwS1habzd2SXlmZlVmaFNNVEdX?=
 =?utf-8?B?SHhvQVcycHFXWDRtejFpUEZNZUxONkR1RlpwOHEyL0FCTlZrYW8yWG5uWWwy?=
 =?utf-8?B?SVRWc3NnTUJkWFJIQXFYNmo0aGI1UGIzMHl4RTJnSWpQbmpyRFZwU28rMHF4?=
 =?utf-8?B?S3ZPdVArMGVZdnlOM2Y0TkFwQXUrbUFlSzVTc0VhWGEvOUdNdzQwclk0QXJV?=
 =?utf-8?B?ellad3FDVnBmYWVtTWFOOE1uc3AyUEtVZmlyYktjUHF5eEw1aDZPeHk2VDFk?=
 =?utf-8?B?K0FBUW5pVzVLVHA4ZVdUeVJVN1dFV3NSU2RuTWkydmJtZS9Zbm9WS3dEWEJC?=
 =?utf-8?B?SFEzRkl6QlN0SGdCeGUvUWJBZ1FtajF2SzN6T3pKb2srZm9KMHMzOXF2RjAv?=
 =?utf-8?B?NThVdHpsZGZkUnZ0QjZnYTA1cWxUSkpPM1h1MGZ6TzVZZ3NZbzgxU1EzU283?=
 =?utf-8?B?bjlXR1JoMFNVWlVPd09UWVVQZFNzUFJEVnc2NjRsaHFiTE5zY09nbUVVNmZH?=
 =?utf-8?B?ZW9qYWZGK1BHWUhic2FSWm1FbDE5VjdJM2tpUm9FSThzaXlpSzQydkZGQU5w?=
 =?utf-8?B?THV6RGJwcFZlMFpHdTlnZXBEY0RDWHZSQWZDT2JteEkwS3A4Q0VENmdaNVlW?=
 =?utf-8?B?YVlCUVlZUEl5dWpRQTRKTmk5SVAydytEd1VuQ3Jad0dON1lGU0RKNVlpL2dl?=
 =?utf-8?B?dGJaOWJvbWVPMTVzWjhBSk5jWVRZWW9jQnRlMlgvbjkrT3hoV0tURVJvdDEv?=
 =?utf-8?B?VElBdlJVQndOVWt5a0JHeEwxaDJBWTZxZ2EzVWJ4ZU85RkVVOHFPSHZDWVh6?=
 =?utf-8?B?MjdYdTQ2RUVPaHN1Qm9WanBHSDVrL0hvL25sWVc0NzlXdDFoRU9uTmprMWxD?=
 =?utf-8?B?WlcxNjR1RDJ3am1BbTM3UXYxUFpUZjJHeDdGa0tlQW9IK0Fvc0wyZnUxcmpR?=
 =?utf-8?Q?fUCELg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdpY0RBOEdwWnI5U0xaVEFpc2VKZVpJUU1RcUZ6d0ZFNUJDcjNVWjJCeEEw?=
 =?utf-8?B?dWpQaG1kY09SSEFrWDVyeHdBaGxlLytneFJOUjhWUlZlK3FsenM0VVFGZytQ?=
 =?utf-8?B?TVlmZlVFdjMyRU53NytXN25YQndmSC9rcFN6VWVyV0xxQ3ZSZm43OTFwUTln?=
 =?utf-8?B?QWJQU2tKMThnWlBWTFlwKzB3TS9McDlKUE5qZE1RQ1paMlJGeHo0UFBWbG1G?=
 =?utf-8?B?UTR3MHU0Q2JIL29OREFIUUQwQ0xPM2lZT2x2ejBpWUZ5SVhTNU12ekNzTE16?=
 =?utf-8?B?RFBydzR5UjduaTQ4MEFkT3MvbVVza29JUFRiZEM1cUZETkVDbTdJbUI2NHZ4?=
 =?utf-8?B?aldhakFTMUx6eWpVK2FydEt4NysrMFBGZ0w0VDZUbytoNkVVeGR0ZElJS2Za?=
 =?utf-8?B?Z2NYcERFZHc5Y1ErTU5zVmI2ME94aXUzM2dKTXBJRW5mendVNTRTUEJqbERh?=
 =?utf-8?B?TDR4a1V2WTlKazRQV09HOW96SWpoc3p6R21GVWZrY3c1TWlWdzZzcjZESHk0?=
 =?utf-8?B?OG14TFlvNnAwbk9IeGJHa2JjeDlhTUJ4bmVMaWRwWXRIRTdXWEtyS1hRckFX?=
 =?utf-8?B?NVN1bzhVTUpZM0twWm03VGVhc05pazJualdRWU5xcHRzUmJqTlU0aWsra3N2?=
 =?utf-8?B?OVAxNjE3d1RLanRGNjM1N0UyWlpoK3FlbEdDMG1WaHo3anF6ZVV3aktFeFFn?=
 =?utf-8?B?MWFvSXk3R25Dald1RTJWbk9uV0NaSG93WHF5R3h6ak5WSSt0eFlySE5SZTlv?=
 =?utf-8?B?UkdhdVV0VjB1Ty9wMFl6dkNsV3hXbmpyUm4zZHZlQkJlOVFGYmR5YWlYUXRE?=
 =?utf-8?B?SFZGNjB4eGtHVHZucXcwWlAzbjlkRFRZOVp3S0FFKytRa2w0RlZJaFZ3YXlT?=
 =?utf-8?B?aEZ2UVdNRkhObEFmSEtmb1VLSDJTZGZGeml1QVppdEpYSERlOVVlWFBHVTlH?=
 =?utf-8?B?YkNpSEpmQVVHeC9zYWhKdXM1bjJxenlCei9CMHdGdmx3L2xyMzd2UzBoUmVJ?=
 =?utf-8?B?OE01WmtDS0d2OVdSbzE0QWZnV0ZocktmcnQ3a0RtdjVLZ0RSTXRsb3JpS0NM?=
 =?utf-8?B?dWp5bUdVVEo4Vkgram1TMkhHclpLazQ0eDhzMm1xalFmV3hzYWRlbEJiamxD?=
 =?utf-8?B?S0luc0lJcmdhNEUrZlFNZHFMUVFsUnMxRnBpZW5JUFdtekE2dHJjbWYyeUJj?=
 =?utf-8?B?Nk4vWlRXYUpKdWl0NGh4VWhuS1VpNkJJcWs5SVQxMjdSNUxneTJ6ZFRadjJ4?=
 =?utf-8?B?ZlFIUWlGaXNJNGM3R1cwTWpkb3BQdWVlVEM0Q0MyV0JEU2IyRmprSXdTYmxZ?=
 =?utf-8?B?T2wrVU1rUlNmU0VvWVIzTVd6dGNCa3B6aW1sNnBjdkVwbkFraHBVUDBLUWhz?=
 =?utf-8?B?TmZ4eStkdld6MUxvOVlmTWFEQ25aZUQ1ZWEwZ0FMRDROMjJlL3RlVEowK0k3?=
 =?utf-8?B?ZE8vaEIrZ3ltMzRMOWNMKzQwYnEvVEVRcnZ2VGpUb3c1Y2xsdFJhUUpQQ28z?=
 =?utf-8?B?MUhIRTdFdjBqVmt0VktwZ0RWT3h6aytmRlhHSndSUzBWRWg4SHdVWGR4V1h0?=
 =?utf-8?B?V3MyQkN0MlQ5ZFUyOFQvM3ZRTnRDWlpiRG1kUWM0aHdKaDBEbTFYbGV0QXA1?=
 =?utf-8?B?dGZGTjRVRkkwbXRCYnJYWllSZDhGTVBSNGxzMHFtU0o1NzliaHMzWVNuQVc4?=
 =?utf-8?Q?JNyLNggy0o2eE/DV/EXk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abac90c3-618d-493b-da47-08dd4a2c499d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 23:40:23.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8042

On 2025/2/8 03:37, Alexei Starovoitov wrote:
> On Wed, Feb 5, 2025 at 11:35 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch adds filter for scx_kfunc_ids_unlocked.
>>
>> The kfuncs in the scx_kfunc_ids_unlocked set can be used in init, exit,
>> cpu_online, cpu_offline, init_task, dump, cgroup_init, cgroup_exit,
>> cgroup_prep_move, cgroup_cancel_move, cgroup_move, cgroup_set_weight
>> operations.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/sched/ext.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 7f039a32f137..955fb0f5fc5e 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7079,9 +7079,39 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
>>   BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
>>   BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
>>
>> +static int scx_kfunc_ids_unlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
>> +{
>> +       u32 moff;
>> +
>> +       if (!btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ||
>> +           prog->aux->st_ops != &bpf_sched_ext_ops)
>> +               return 0;
>> +
>> +       moff = prog->aux->attach_st_ops_member_off;
>> +       if (moff == offsetof(struct sched_ext_ops, init) ||
>> +           moff == offsetof(struct sched_ext_ops, exit) ||
>> +           moff == offsetof(struct sched_ext_ops, cpu_online) ||
>> +           moff == offsetof(struct sched_ext_ops, cpu_offline) ||
>> +           moff == offsetof(struct sched_ext_ops, init_task) ||
>> +           moff == offsetof(struct sched_ext_ops, dump))
>> +               return 0;
>> +
>> +#ifdef CONFIG_EXT_GROUP_SCHED
>> +       if (moff == offsetof(struct sched_ext_ops, cgroup_init) ||
>> +           moff == offsetof(struct sched_ext_ops, cgroup_exit) ||
>> +           moff == offsetof(struct sched_ext_ops, cgroup_prep_move) ||
>> +           moff == offsetof(struct sched_ext_ops, cgroup_cancel_move) ||
>> +           moff == offsetof(struct sched_ext_ops, cgroup_move) ||
>> +           moff == offsetof(struct sched_ext_ops, cgroup_set_weight))
>> +               return 0;
>> +#endif
>> +       return -EACCES;
>> +}
>> +
>>   static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
>>          .owner                  = THIS_MODULE,
>>          .set                    = &scx_kfunc_ids_unlocked,
>> +       .filter                 = scx_kfunc_ids_unlocked_filter,
>>   };
> 
> why does sched-ext use so many id_set-s ?
> 
>          if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                               &scx_kfunc_set_select_cpu)) ||
>              (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> 
> &scx_kfunc_set_enqueue_dispatch)) ||
>              (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                               &scx_kfunc_set_dispatch)) ||
>              (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                               &scx_kfunc_set_cpu_release)) ||
>              (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>                                               &scx_kfunc_set_unlocked)) ||
> 
> Can they all be rolled into one id_set then
> the patches 2-6 will be collapsed into one patch and
> one filter callback that will describe allowed hook/kfunc combinations?

Yes, I agree that it would be ideal to put all kfuncs in the one id_set,
but I am not sure that this is better in implementation.

For filters, the only kfunc-related information that can be known is
the kfunc_id.

kfunc_id is not a stable value, for example, when we add a new kfunc to
the kernel, it may cause the kfunc_id of other kfuncs to change.

A simple experiment is to add a bpf_task_from_aaa kfunc, and then we
will find that the kfunc_id of bpf_task_from_pid has changed.

This means that it is simple for us to implement kfuncs grouping via
id_set because we only need to check if kfunc_id exists in a specific
id_set, we do not need to care about what kfunc_id is.

But if we implement grouping only in the filter, we may need to first
get the btf type of the corresponding kfunc based on the kfunc_id via
btf_type_by_id, and then further get the kfunc name, and then group
based on the kfunc name in the filter, which seems more complicated.


