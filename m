Return-Path: <bpf+bounces-49721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66828A1BE8F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A803816E5DD
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E51EE009;
	Fri, 24 Jan 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rFjW3k6P"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2057.outbound.protection.outlook.com [40.92.49.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4611E7C34;
	Fri, 24 Jan 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758703; cv=fail; b=kuITL9OWKNFE7IZ9wsEfDid9mKR3sO7C0HHoyZRs+u76K4sVkKEGUKU64GW3G9/0dUsrAymfGuzza0csClrJTxZc2JBOl86fa79AxF22FAOUrc2ccaXRatnlIHXxk0xmGJzcjmEH7z15cr2viNU0IOJmKCiPKoVWucacz/j92Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758703; c=relaxed/simple;
	bh=o1A0tt9bKjc8H/b/4ug5XnMiIVO3NWWngDCcdGqoJQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W1JoIGqkxUo59zxaxhvGcQYl0AhuAcOvY02CjK5lvG0reHtBtfN4UFyAaqTiWx8/aRymlxsnij7AdqcQK+R57bRtTxUfK4XmDfmPZRLCyVp694h1WmTgP1wyXqlzZ5sJYf2ZWN4gGHWHb+YL0C8BS+hnL+HSLHoRxnwHxw6ncvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rFjW3k6P; arc=fail smtp.client-ip=40.92.49.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1YqSi3CUMlkUIpkoiTn/DvDApwLRqSfe6LHmqNjjw379n2+P/YERvtFKExVeUsHeb8Zw/7bR6f9/Wqr2hwUSBokzD8l9sxDSQPZgTuA1ZWUpxMaGF56iM7iG9AFpt5j0XL3W+W0VH5InFkZ75Cxqnn8He83/qF50sEQ6geO/HwVBl22mT+yRA/44WrD55fkDBkZazaI4OiGfpKFibSels84jC2Scv7rOzEvUa1z+jYWbpEMIKetAefcZDD0AZNPXtmFigv6j20w8kgGguTk7gZ773trmHXUc8Q1ztmvH2v5COEBhCOh4AikpdmH3XFWlgtfg8RE14nsfK3k2nwOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MKLfsBNGeGeW29DMbNhi9WJqmM+wjp9SEHkAdLTJDU=;
 b=lq6+UE1aWJG4eYNIqELmghUcuOqhcWbN7Q7kFO/lT9mKTo5FRwIU+pUPojs02WXsarXKuXb7lm+fHE8rGlTYq4xqhOfaZ46n0THlpMWyJvmMxuIqAGUW7lH3orhyjWyOyjvMAxEBs6k3keY+IDR1EFl1iFR1HGTQ0XcrhiXHAer0a3L1/DIdI6Pm6wSM2+Q+1wmRx+WRWi6uzx/fJo2pvwiyi7dk9XJf5wGYM2RhMZhDe5M89sZlgRe1MH53UFz+g0ott/20oxOG8CDesMNnLYtPoXpgGowNfx2N9dcNv4nRqDEmnB0Q9vmJytMGV21aZWRlR6OUZAPV/+Cuesty7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MKLfsBNGeGeW29DMbNhi9WJqmM+wjp9SEHkAdLTJDU=;
 b=rFjW3k6PXYut3mQGyh2l+u+TXkozAi3rTahtoqOZ/F5MTE+b4/FI2vDs8WlDsavqQomjOldMEyrObXGot6mgWs5akxVRmpjxIqGvz/aSQZwViiogyUCXY8Z/vdrJ1adYcZydaIaz1USN7Yo2FCt5JobwCGT4CLMbBrtmMPMEIJA7cWby4BxuOILTmkuySSuHd51SG27W9NeFtsHqGALtXJU9K732BhMR1ba/LRDX8BmxJgy02ZoP4NRBkt9xSMaRvyWJ7hvrEHctscM0niwAP39LqD69uWIRPymVuJHvtPXOKvrMTesg0FvHiIZqx92AlrqdIV0+Cc2hjaB7Pvmv1A==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by PA4PR03MB6927.eurprd03.prod.outlook.com (2603:10a6:102:ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 22:44:58 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 22:44:58 +0000
Message-ID:
 <AM6PR03MB508053DF89CDFEB95CBEB20C99E32@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 24 Jan 2025 22:44:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 6/7] sched_ext: Make SCX use BPF capabilities
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
 David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802A825536C00D2B53333C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLidcL-WU-VWXZtBph=qjJfAhoyrsYWyL7JwB0ZEH5KFQ@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQLidcL-WU-VWXZtBph=qjJfAhoyrsYWyL7JwB0ZEH5KFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <6daa8db9-bdba-40de-a5cb-308fe58c3d52@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|PA4PR03MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5cbb62-6add-4762-3c11-08dd3cc8b9f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|6090799003|19110799003|8060799006|5072599009|440099028|3412199025|12091999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0lDZ2pTZDlhNm1OaGRVekJNb1ZseGEyNGhVZXE0RXJNQXozeG5mT2x6WUxH?=
 =?utf-8?B?SS94NjM5MkwraXV6RGJtYkkvVTlLR0taOTkwK0xtVDl2Q2xRYzd6MG91c2h4?=
 =?utf-8?B?OFdLN3l1OGJmNTlpbFo4MVQ0WC8rdXZGT3ZhQlBwT3hTQXI0VWdXOUoyMXJF?=
 =?utf-8?B?Q0I1MWd0R051VUwyZjgxcUQ4Qkp2aWNheVJZUHFGOWJmTWQ4cW5DL0NzZ2Rm?=
 =?utf-8?B?ZnE2aGMvMUlPUzV2Qjk0aU9ESWxERFRzYVBEWWlLdzFvRlozbkprbXFrakov?=
 =?utf-8?B?QjJPTThwSUJnaldlYTFnVjVxd2xpK2tmYW5xSlVDanA1QTZVSllQT0hxTkxX?=
 =?utf-8?B?eU1scUVQckhIZDh6OW1FbjFOR21hWXlWbXNlYWs2Q0h4QitobmVTMjRDa0hn?=
 =?utf-8?B?Nld2dG83Zjl2cU9rUy9TN05nQzFZRjlRcW9XTDdvQm1sUVNWWkFuekNYOFl5?=
 =?utf-8?B?eHlOVkZpdldjYjh6Wmdtdk16M1AzVWQxMEtsdkQ1Y1kzS1FkeER2c1BRMm9j?=
 =?utf-8?B?VDRHa3M4VSt1RjhhcDlZRW9TNFJZNXpGVHV6MUlwUzRuUlpsWlZ3RXNlOGtE?=
 =?utf-8?B?MjZXUW13L3JzVVoraDBGYm03UEtLb1JJWHhXU0RvNG9NLzA0RW9IU3hFYUMr?=
 =?utf-8?B?bWhtOFAyQjFZN0NyVVF5dWdtV3RFNHpkVmNXcUl4VStoWDNaMFdKaHZWekJv?=
 =?utf-8?B?M0x3RU90YXIrcXc0N0d0UFZ5WDZrTGJvL0lLMjZEYVp6bk5vVDBsWkhwd2Ft?=
 =?utf-8?B?dnI1U1k0ZjFzOXFXL2I4V2ZJOVpCRk1wZGl5RHFkRkpTYWh6dlp3L2N6ZkZR?=
 =?utf-8?B?U3JiTlB6YnUzMk9FaTRIREpVdU5mQ1Z4QXg2UXA2L0pxMEFialVGQjdWNnZu?=
 =?utf-8?B?YlBNcU14c3BsY0YzV0J4QkNWdDJIRlFPMUpRSmVjY2F0eEJGNXpxU3FOay9s?=
 =?utf-8?B?R0NqczArSzl5clFNZFZUdUxMMHY5U05Pd0pqTzYrQ04yOHU1QXJkOGV1Y3pQ?=
 =?utf-8?B?d0owM3NCbUFpaTQxMXR2WDQ1a3ErR25SL0JRcXl6V3NqcW43Q1E1dkVjbUcw?=
 =?utf-8?B?ZFk2Y3ZVN2lFUGk5ZHErckVFMmtUSDhDT0IrZTlIc1crSkdQZ09ybVYxOXU4?=
 =?utf-8?B?QmVkMnlielRRd3A0STJtajZrV2hYYSs4MHY2dDh4QnhpTTBHanB6Y3ZxNzht?=
 =?utf-8?B?T1BMUkM2bDhUaXVxK3BXSUpCUVo0L0E2SWx4dmo5dkZmMzZlQkRjWFMydkJK?=
 =?utf-8?B?cmMzclVGeXVzeEtta3BNWW9Zc25GckRSR2ZjaDg1MHV5RWhsN2Z3QWZjblJF?=
 =?utf-8?B?bWdabS9kWnN1TnhKTlcyVkRJdmJnemh6QUIrbjczOGZpUWZjTS9ybGpkdkZI?=
 =?utf-8?B?MTlSUGVFbDE4M2JnbUxPRHdWVk9jZmxOS08rVjlkblJXRzU0dWZKTi8zcDdr?=
 =?utf-8?B?ZGVWWitieXpRc2dORFJ1enlPdDJmS3Ewa3U3ZnRRTFV3VVZSTlQ2ZHUwVW14?=
 =?utf-8?B?NUF0RXhJTHhwdmZkUWhnb2JwVzMxWnFnOXVuWDhxTzlJWUZ5TUdab0wxVHZG?=
 =?utf-8?B?L0JMZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5jdjlwbVhBR1lMZ1BoNHZrSTdKRFRoMnV4VFNkcE42OFhONXZDd056RHpO?=
 =?utf-8?B?TkpwWUNsOUtEaXNOT08yZWVzOGVoTitaanYwdVBNaGljRjJ1NmoybWUwWUZx?=
 =?utf-8?B?WS9ZVDAwSU5vR2FKb0E2UW4wQk16Y3V1QlI3ZnNwdFphbDdZZU1lTXVDNmhI?=
 =?utf-8?B?TU5JS0tnZjNXNS9tZ0R5Y1RWbEJsblFjQ0hlL29RT004cXhLTUljenlhNXRy?=
 =?utf-8?B?SkluR2FXTmhGVkJ0R1JqT2gwVnpwUE9XNURCaFpkNVR4cDl1TENWOWR1M0xn?=
 =?utf-8?B?b0dQUEtFVk5pRWh2NENHVS9PeEk5N2hXdlc1SXpuYnpiR2VmQkgwdS8xTHNC?=
 =?utf-8?B?TDZ3aXc0eFNab0ZRWDAwNWhaVFlFZUZLK095cFFMaDZqU1VnQ1dRMlJ1bVFX?=
 =?utf-8?B?ZVZhcXJ4dnNpSG9LUTBVS0ZaZUxVWExRdUZ2c3lzSzc3Zy9nbjV0OWduZXl3?=
 =?utf-8?B?Q2Q2TUV1ZG0rd09HY3R1M3E1TUk2bG9iS2dxWDBIOGFEekZJbjM5Rklhb3BB?=
 =?utf-8?B?ZkJqc294ZkxJaFdPT3ZqSEJnUTRCaDdCNTJkVG5IWDR0VmZ3M3BXQkFaN21N?=
 =?utf-8?B?R0FjNVZoZmp4V0xMMzNJSWw3cGtkZ1VjT1l6YUlGbytkTk02QjdWeDd3eXZo?=
 =?utf-8?B?dFlhZmVJU09LYnZMempyM1RDdUtJazVCczV4OE5Kd1JPNS9qc3RhTFppaWJ4?=
 =?utf-8?B?R2xTVmhiTUU4S0pSRkpON25zZ2hyU3ZZaTJ2YklvNVNhQm44T0ZUYnFIbWMv?=
 =?utf-8?B?WWlhOERXVjl1UGdMR25hY2NPTytpSWdneVVFUTBTcVl0VkovMGlhVWRneFB0?=
 =?utf-8?B?VHpXL25IU1NRbHBpZEJHZ3Q1SEh5TndTUzJ4TDJTTzhFYnR3UHdVRHdibFFM?=
 =?utf-8?B?NkhwTGplZ3dZUCtiL3A0V2V2RnpCOXZuN2cwcFFLTHdXL1ExVmRlRzgzVEhU?=
 =?utf-8?B?end0aUtRcWdXV0EwVEhFdnRoOTJ4NjJwd1RmUXNJQWZUNnFKN2dmcFRPSHhF?=
 =?utf-8?B?UmdUaXE2cDZDWE0vRUQ3M0lPeTdLQW5LSmNTV1hUWDBCZEFJWDRPNjh5QjYz?=
 =?utf-8?B?S0FFb2xyaFN1YW52M1RHYWlhUmJKak9PMEdheXFYRjdleGcyL3RmU3JONFdF?=
 =?utf-8?B?SmY1anI4K1JzZW5HTkdsaExFcTVJYU4vT1lUYTcweTV4dmk5eGthOG8wRDJN?=
 =?utf-8?B?UCs0bFBxMnVsOVE3alRLekpmSW95K3c5YkR4RkxyVFJ6T0pqS0tjWXNqaGRO?=
 =?utf-8?B?KzlvUmRtNmZoMjluWnh3eUZSK21iUElGN2FBMWMrQ1dzaFFoNXZBNG4xQ1Zz?=
 =?utf-8?B?V0ZsaGQwY09yV1ZzeXBrRXpxVmJuS1NLQ1lRWVRaWms0VXF6MldTSDhXRHBJ?=
 =?utf-8?B?VEZ5Q1d2OVV6MXRjNVNwc2EyenVtSE40QTl3Vm9kZUhrbk1Wa2ZnMElzNndJ?=
 =?utf-8?B?ZGF6ZTg4WGdRLzBuVkdhRWhJcUpudkxQRDNMcFU1d0I2Z0QwR0NMVWd6cHBz?=
 =?utf-8?B?bGF2RTMvQmxlRjNJL1R3a0k4TmVlSlV4aTUxQUU1am5wQWttbW5xK3dHUGdq?=
 =?utf-8?B?M2hISlJZVmpRblQ4eWlsMXlncDVKbDhqUzRzT2VRYlhNY2dTVWJLNFFtbzdr?=
 =?utf-8?B?am1Ed1ZWZGZvL3hrdDZBWFNFVldqSTRadkpLeDhzdTdlWmZIaXFBa282Ym0x?=
 =?utf-8?Q?pBs0fZb9aptdR8y+uVCi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5cbb62-6add-4762-3c11-08dd3cc8b9f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 22:44:58.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6927

On 2025/1/24 04:52, Alexei Starovoitov wrote:
> On Thu, Jan 16, 2025 at 11:47 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch modifies SCX to use BPF capabilities.
>>
>> Make all SCX kfuncs register to BPF capabilities instead of
>> BPF_PROG_TYPE_STRUCT_OPS.
>>
>> Add bpf_scx_bpf_capabilities_adjust as bpf_capabilities_adjust
>> callback function.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/sched/ext.c | 74 ++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 62 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 7fff1d045477..53cc7c3ed80b 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -5765,10 +5765,66 @@ bpf_scx_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>          }
>>   }
> 
> 'capabilities' name doesn't fit.
> The word already has its meaning in the kernel.
> It cannot be reused for a different purpose.
> 
>> +static int bpf_scx_bpf_capabilities_adjust(unsigned long *bpf_capabilities,
>> +                                          u32 context_info, bool enter)
>> +{
>> +       if (enter) {
>> +               switch (context_info) {
>> +               case offsetof(struct sched_ext_ops, select_cpu):
>> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
>> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, enqueue):
>> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, dispatch):
>> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_DISPATCH);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, running):
>> +               case offsetof(struct sched_ext_ops, stopping):
>> +               case offsetof(struct sched_ext_ops, enable):
>> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_REST);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, init):
>> +               case offsetof(struct sched_ext_ops, exit):
>> +                       ENABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_UNLOCKED);
>> +                       break;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       } else {
>> +               switch (context_info) {
>> +               case offsetof(struct sched_ext_ops, select_cpu):
>> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_SELECT_CPU);
>> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, enqueue):
>> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_ENQUEUE);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, dispatch):
>> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_DISPATCH);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, running):
>> +               case offsetof(struct sched_ext_ops, stopping):
>> +               case offsetof(struct sched_ext_ops, enable):
>> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_REST);
>> +                       break;
>> +               case offsetof(struct sched_ext_ops, init):
>> +               case offsetof(struct sched_ext_ops, exit):
>> +                       DISABLE_BPF_CAPABILITY(bpf_capabilities, BPF_CAP_SCX_KF_UNLOCKED);
>> +                       break;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +       return 0;
>> +}
> 
> and this callback defeats the whole point of u32 bitmask.
> 

Yes, you are right, I agree that procedural callbacks defeat the purpose
of BPF capabilities.

> In earlier patch
> env->context_info = __btf_member_bit_offset(t, member) / 8; // moff
> 
> is also wrong.
> The context_info name is too generic and misleading.
> and 'env' isn't a right place to save moff.
> 
> Let's try to implement what was discussed earlier:
> 
> 1
> After successful check_struct_ops_btf_id() save moff in
> prog->aux->attach_st_ops_member_off.
> 
> 2
> Add .filter callback to sched-ext kfunc registration path and
> let it allow/deny kfuncs based on st_ops attach point.
> 
> 3
> Remove scx_kf_allow() and current->scx.kf_mask.
> 
> That will be a nice perf win and will prove that
> this approach works end-to-end.

I am trying, but I found a problem (bug?) when I added test cases
to bpf_testmod.c.

Filters currently do not work with kernel modules.

Filters rely heavily on (bpf_fs_kfunc_set_ids as an example)

if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id)

exclude kfuncs that are not part of its own set
(__btf_kfunc_id_set_contains performs all the filters for each kfunc),
otherwise it will result in false rejects.

But this method cannot be used in kernel modules because the BTF ids of
all kfuncs are relocated.

The BTF ids of all kfuncs in the kernel module will be relocated by
btf_relocate_id in btf_populate_kfunc_set.

This results in the kfunc_id passed into the filter being different from
the BTF id in set_ids.

One possible solution is to export btf_relocate_id and
btf_get_module_btf, and let the kernel module do the relocation itself.

But I am not sure exporting them is a good idea.

Do you have any suggestions?


In addition, BTF_KFUNC_FILTER_MAX_CNT is currently 16, which is not a
large enough size.

If we use filters to enforce restrictions on struct_ops for different
contexts, then each different context needs a filter.

All filters for scenarios using struct_ops (SCX, HID, TCP congestion,
etc.) are placed in the same struct btf_kfunc_hook_filter
(filters array).

It is foreseeable that the 16 slots will be exhausted soon.

Should we change it to a linked list?

