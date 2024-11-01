Return-Path: <bpf+bounces-43785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8E9B995B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E461C21663
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39CA1D4340;
	Fri,  1 Nov 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ojeWq+MX"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011073.outbound.protection.outlook.com [52.103.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A421D0E15;
	Fri,  1 Nov 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492570; cv=fail; b=Bvi7wl0F5pnKyKec0ESCLTmQlHO5gsysERoELAj7VVu0bUhKyvVa9femqRtOJXQvS9tFWnYEQQP91yIa2LS/qqYh3Y4nIM87iIPyYMbZWmRauXfoX2mqXA/XOdsJB2qtBGS8JADDFScLNq1g+DKkBsuap6KM0E8m3pXOrTjmPEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492570; c=relaxed/simple;
	bh=d3BIiTf5Yx+WzPbd8dp9W23Rd65dKiq6teu60gRXHis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bYIkF+FLh58/dQ1UOIg/x/sJjxVsKfgQIylKsaV+Td/j8s0vmlNPr5ugi0wkbMr6Bi6eu2MvwCpKDqQXOclJoXsrhvHW3dI+VOIZLdkuYHi7J15XyTk3lHbqW9dfBfieys2xfPwhvGavyRMo4O73T8VB9AV3PUPh7fUMVVFKxqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ojeWq+MX; arc=fail smtp.client-ip=52.103.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zij6Yb8eYGPv3AiBpNgLXHqmsc6VyPAVsB7m2LFwGMXkMkgYaGlbxf0L0JecnBIQJacdTfgE8Jvla8QvBTwAzbLGu8WL71k7cRgtQ5WrvTtsxKpXfjaB1m5qeN4ySbJLqdNV2yQTJV3QXzAXAGMRem9Ojod6dl973xVlSV88d7u+aoi4e9/SVmW0bnGTUoQkloc4t/0HaC4O7lqdLMsvjrsub6Eej2JdXrMSgbTebzG0gFhOOO3fcLPoD54KuS3lwT+umk8VRhQ7zXHQ3RJ8VouqX4N71gk2P99Oq4ylm55/0Kdi1P5wZ0EBh+IpvNw3iH7BAjcFzvLUirvZm2fE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgl7AIbIPah2zEJEVCp3Rxant97yadlQBJQ0+3yFHnU=;
 b=YCH/GDUGqX1yYBObzy+mFILsl2E0CbHlm9qP0E0n6zYHSay0dNKzQWVXqXFwHllbj8QbqdYvkSOUHFYu2Ku5eUj1wkmHotnJ+eVl/1vD/RINLHoNrYE1Y8J4givRP7tzyobXVbIEninGE3FjJg0ITGAiV3SAvZVYIB3FaRxz/D0DcyLOOxl4iRxR4DiPsPnqLVFaKOwJeH4GAjRVPAjmNzNeFnzoe7kmeGGRFGQIIiU66nKDVBaLKYiAnqVqkJMsa2Q8kCSp7zEdfwcB5GBi7xA6g3C0d1Ba3RhLS/36ugfhKnjtvJ58i6i0f4NZ4OBYNd800TZQ39dOwOhGg/rpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgl7AIbIPah2zEJEVCp3Rxant97yadlQBJQ0+3yFHnU=;
 b=ojeWq+MX0b2xWL3tgmgHDBSVeCwkY0v8jcx/0v+f0gsMoLqMHI+WpZGFp9k01UxhoyyphnKN6rtk7uXuRX/cG5mr1mtlSCiToGSoNneoz+zRwHSoP6vyl6UN5n9+udslJmtM6mNfNmWQNwGuJa8tmlcgcAKcAaJbfTQuaV3d6prcckaLLONd9f/OnB64vO9rcpPmB6lgoNFryKpyVSIddHVAzAnS5dJawvk24TJJvRf4xn8UIYSGEztQO8qjv5HTKK/8V+BHNRIg1eg9FIlj+jURe8gic1RbV8uIFVnRZu5IeId1FsImxALoCMuped/VdJxQWRKowS0YDRXBfPVw7A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAWPR03MB9059.eurprd03.prod.outlook.com (2603:10a6:102:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 20:22:44 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 20:22:43 +0000
Message-ID:
 <AM6PR03MB584814D93FE3680635DE61A199562@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Fri, 1 Nov 2024 20:22:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584846B635B10C59EFAF596099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <4e993f40-4cb0-4c1e-a89a-44a6816a6d26@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAWPR03MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bc7f91-90cb-4f00-ff37-08dcfab2f0e0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|6090799003|19110799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlcwQWU1L3RPd3B3cWxmcFJNRVBoZ1NJNWYvcHdKaGozWWZzYUExbjFPVzJH?=
 =?utf-8?B?R05QcjhZYXF2MjdUYjQ3U0M3c3d1QUgrUFd5TzBYTlBqemhpeTdtZFJ6LzV1?=
 =?utf-8?B?UnZaeGdhR1ZDQ2J2UURVdVJVZXJ1ekY2ZThzbFNtYkExbmY3dnZYNGx3SXVX?=
 =?utf-8?B?UGw5b1Z5RkQvQUtXa291VUk2YmlabjVTT25Za1JhRWc1eC9CWXRmOU05RlhZ?=
 =?utf-8?B?ZjhZcEdUOGhZRWVzKytWam90d1MwN0ZKQ1NnazZiNWZ5Y2ZQR2EzeXE2WTIv?=
 =?utf-8?B?R2l3akROMlpOMzFiVFg4emVhOHVQbGdDSHZCZm9HVXkzbjZHRkhoRExkZita?=
 =?utf-8?B?aU5VR3hjSXJyL0dMelgyZFNLVVlUQllDSFM3aUdKL0p3K3l1MnNNSUFibzYx?=
 =?utf-8?B?OVBmb3lJNWxzRFlLWnppNGNkRkhSZDV3cXMwTmxLUVhwdFhhSk9mb0QzNHVI?=
 =?utf-8?B?cDYyQTAwcUFLVEdIRG5uRXJlVUZWTEVueWl1ODY5YWpCamNmb0Y5RG5OYXNW?=
 =?utf-8?B?ejgyMW53M2pDaGRLOElCcExLcDJjeDVDTEhSS2U2M25Od2k4ZHFTbk1pK0I0?=
 =?utf-8?B?VU5lN3BrS2JTY0xobVhhbjBJVm10bUJLWFBpSHhNUXZ6R3pUWkhQdS93RHBi?=
 =?utf-8?B?d2Z6dDBCYzlpYVpaNHdqaGowV0FLTVY4YWZPNjg5MDJMMGQ5bU8xaGtpVTAy?=
 =?utf-8?B?ZHR2S0NvQUVJYUdyNGR6NW1GbXdwTXM4QlN4QWpUb1NmeEVTYUxVQU5DSnRj?=
 =?utf-8?B?T2xwcWJtMzBBSXF3V2NrUFRTTVkzYjU4LzcrTWh6cm9ocCtMbEx6ZUZJWFFJ?=
 =?utf-8?B?MkpXUFZCbjY5bXY0STluZ2pMMjM0b3oyVHE4QXpnaXgwV2ppNXpzWERuTWRY?=
 =?utf-8?B?SkVSYlFuRzQ0aGpBeUdwd1VtZWxCc2IwTWZ2SzN5MDNiR0RPaU1YSUMwQ1I5?=
 =?utf-8?B?RDQ5VHEyckxhcExheVdoWmE4M09QVkpCR3lnMmxKYXhuRjFXQlJsYmRNYXcz?=
 =?utf-8?B?ZFlhT3EyVXd6VlNMM0lleXZXN09WVkRLOFpNUFQyWHpDUmNtUWlocjVuc08r?=
 =?utf-8?B?Z1JmeDMrWGhqSVpmOVpxUFdreGFMcWU4amRDWFdKQTM4bHR5ZGZqTjZuOXpi?=
 =?utf-8?B?YnM4QVB6bnhmMnpETmNBUVFXSUQ3Y1FnTGoxUXlaK09NbVJIREovQTMrUUtJ?=
 =?utf-8?B?ZjBiM1FFbVlZS2orcUNWVURabkkxcm05a05sMm0vdEF0dWVDQ1VZMXhLQTVj?=
 =?utf-8?B?K3l1MWZiKzU0d2dDaFltWGorM2NueDkzYkx1ZmdZYzg4ck9JbitpY24ycWVS?=
 =?utf-8?B?U0pOYVM2am5xc3VYTm9iZXJtZHR0YUpBazRsSlhIQ3F5VXFybFYxTVl0L3kv?=
 =?utf-8?Q?LLq594pUcDPVJMBDIF4LiZYa6WWKSdiQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZDZGZFR2pTZzJNK0xQU3ZOckprc2VlUVFqSnp0SGlHcmcvWXVqOVZMOTVl?=
 =?utf-8?B?ZENSR2lpWHNpcVB3YzJ3SU1pTW85MDlEK2VvaE5BVmplUlBNVjUvQzE3MGdI?=
 =?utf-8?B?Y1Uyelpya0dPcEtXbW1GbGhiUnR1OGN5cHhjZXIyYWliM2hiWjMrQU5QNDZM?=
 =?utf-8?B?QWx6WUpOZ21sWjVtWVU3bUFCeC9QR3dXVk5JREhvQXVqT1pNczRROTltQVcr?=
 =?utf-8?B?dit1M0hWclVJbllRcllWMnNuYkZldk9Ob1g2YitGNm5sOXNOZVBiSzRMVGE3?=
 =?utf-8?B?ZjQ5Q3JrSXBLem5HbGNwZkdyL1l5OUs4TktwbE9kQWpsSk5qNlBpVnQ5UzMr?=
 =?utf-8?B?MHFEZkF3d1lvSW5KUDlscm5UQWxRQ1h6cGd2SzI1U3NxNGJNbCt3KzBhbEFC?=
 =?utf-8?B?QXhmTnY1Zm5ibGIvM1dYb2NWbTVmbzd6bVF6dFpEcjRabDN2bHY0dEEvM1lp?=
 =?utf-8?B?c3V0eHlVWGdoZkpRRVFHUGVVZWRRSmJwN09LM0laVWs4a2ZOb3lKa1RjZTZ3?=
 =?utf-8?B?UzZGWTJwalNBRGM5WjVadngvT3J5L0J3OHd1ZXQza3p1aERBcTNJTk13VXUz?=
 =?utf-8?B?OTgzcTRpL0tpaUJQTVR2TFROVjBmYkdjOFN3OS9LbGxDbjFCbVlMN1BTckFY?=
 =?utf-8?B?d1lzOUNoMUtiODdHTCt1MSttSEJSdk9KamQ4bFptcGVwYk1nUzRxVlNxYTFH?=
 =?utf-8?B?SlhJbTREeWM5T1B3bUl2QWpnZG4vT3lVTDdtNGZpclRJWHM5elNYanovK3Vn?=
 =?utf-8?B?WW5rZmEySlEwMnBpM3p2Wm84NEpKQTRoc01HUFh0eE5DdjRZUEpLZkl2WVFF?=
 =?utf-8?B?Tlo2VVJDVWk4T2NWZ09CY21vNElhVEtWZkpLNkY0QkhMaHlVWDdMamQzQ3hl?=
 =?utf-8?B?VlIrRzBmdVE1Tkh0MFR4OVk3MWVGUHFReVFJdlRsTy96cFlxRHBiN21CMHY0?=
 =?utf-8?B?YUptQkVLNk94RjVrYXVvSWxoaE9VYzNrWWxVOWxjZ09QWXdZTlk4Zjc3bytr?=
 =?utf-8?B?UE1LVGErZ0JYbTJsTTFBSWVlYlJrbWZraEtxWmdURlV6NHRaTUlQRGY0WE55?=
 =?utf-8?B?NDUrTU15ZGx1SHJyMkZOWVkxSUZhc2x5RTA0eXp4ZDh1LzkwQldmRnJacXkx?=
 =?utf-8?B?SEhpRy83UXZtNFhoUGR3K29SMC9oSDhXK0IwOUMrRjRMWFp6QWNZSWZSNUVr?=
 =?utf-8?B?ZVVOcWR4TXFZNldXZTZzY1dYc3l2SHYvSXIyK0NWUE5TQ3NRY0phaDFMcXFq?=
 =?utf-8?B?VGs1Q21Pd3g4d0FQYnJ2ZGxraTRSQUkxOEN3YitRTFFSRy9CZjNrK1dyUzdi?=
 =?utf-8?B?M1lmajYwVWJqWk0vQVppK2hoR2h0VTVXZEhPdlJ6dVRXdkN4WEJXc0Nyelc1?=
 =?utf-8?B?OERhLzV1TzNXbU5IUEI3ay83WFhad3JFYU00YTkzeVpubEN4WFcrc0F3RkV2?=
 =?utf-8?B?UVZkd0FISW5DOVZIQXQ5SEN4cGJaTG1kRGo4eURZWTliUkNrbG5mY20wTDRC?=
 =?utf-8?B?UlozUExmWU9vUjFQTElaQ05iR3IrZ1NXVVZWN1dqdHI1Ky9lRUpHeDgxZjZz?=
 =?utf-8?B?WGxXWmRyTDBIVW96QWF5VTA1UVhRc3l5a3dqOFdLY1NpMzBlWWlDQnBYdXFZ?=
 =?utf-8?B?b3Q3ZXBjbCtjV0lCUGV2V1ZiUUF2blNqKzNUVjhpVFRxVnk0UzBjclo0S0RD?=
 =?utf-8?Q?RSuNXwSimW+pdoGjk+op?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bc7f91-90cb-4f00-ff37-08dcfab2f0e0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 20:22:43.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9059

On 2024/11/1 19:06, Andrii Nakryiko wrote:
> On Tue, Oct 29, 2024 at 5:15 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This patch adds the open-coded iterator style process file iterator
>> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
>> files opened by the specified process.
>>
>> In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
>> the file descriptor corresponding to the file in the current iteration.
>>
>> The reference to struct file acquired by the previous
>> bpf_iter_task_file_next() is released in the next
>> bpf_iter_task_file_next(), and the last reference is released in the
>> last bpf_iter_task_file_next() that returns NULL.
>>
>> In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
>> the end, then the last struct file reference is released at this time.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   kernel/bpf/Makefile      |   1 +
>>   kernel/bpf/crib/Makefile |   3 ++
>>   kernel/bpf/crib/crib.c   |  29 +++++++++++
>>   kernel/bpf/crib/files.c  | 105 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 138 insertions(+)
>>   create mode 100644 kernel/bpf/crib/Makefile
>>   create mode 100644 kernel/bpf/crib/crib.c
>>   create mode 100644 kernel/bpf/crib/files.c
>>
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 105328f0b9c0..933d36264e5e 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -53,3 +53,4 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>>   obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
>>   obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
>>   obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
>> +obj-$(CONFIG_BPF_SYSCALL) += crib/
>> diff --git a/kernel/bpf/crib/Makefile b/kernel/bpf/crib/Makefile
>> new file mode 100644
>> index 000000000000..4e1bae1972dd
>> --- /dev/null
>> +++ b/kernel/bpf/crib/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_BPF_SYSCALL) += crib.o files.o
>> diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
>> new file mode 100644
>> index 000000000000..e6536ee9a845
>> --- /dev/null
>> +++ b/kernel/bpf/crib/crib.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Checkpoint/Restore In eBPF (CRIB)
>> + */
>> +
>> +#include <linux/bpf.h>
>> +#include <linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +
>> +BTF_KFUNCS_START(bpf_crib_kfuncs)
>> +
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
>> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
> 
> This is in no way CRIB-specific, right? So I'd drop the CRIB reference
> and move code next to task_file BPF iterator program type
> implementation, this is a generic functionality.
> 
> Even more so, given Namhyung's recent work on adding kmem_cache
> iterator (both program type and open-coded iterator), it seems like it
> should be possible to cut down on code duplication by using open-coded
> iterator logic inside the BPF iterator program. Now that you are
> adding task_file open-coded iterator, can you please check if it can
> be reused. See kernel/bpf/task_iter.c (and I think that's where your
> code should live as well, btw).
> 
> pw-bot: cr
> 

Thanks for your reply!

Yes, I agree that it would be better to put the task_file open-coded
iterator together with the traditional task_file iterator (in the
same file).

I will move it in the next patch series.

>> +
>> +BTF_KFUNCS_END(bpf_crib_kfuncs)
>> +
>> +static const struct btf_kfunc_id_set bpf_crib_kfunc_set = {
>> +       .owner = THIS_MODULE,
>> +       .set   = &bpf_crib_kfuncs,
>> +};
>> +
>> +static int __init bpf_crib_init(void)
>> +{
>> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_crib_kfunc_set);
>> +}
>> +
>> +late_initcall(bpf_crib_init);
>> diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
>> new file mode 100644
>> index 000000000000..ececf150303f
>> --- /dev/null
>> +++ b/kernel/bpf/crib/files.c
>> @@ -0,0 +1,105 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/btf.h>
>> +#include <linux/file.h>
>> +#include <linux/fdtable.h>
>> +#include <linux/net.h>
>> +
>> +struct bpf_iter_task_file {
>> +       __u64 __opaque[3];
>> +} __aligned(8);
>> +
>> +struct bpf_iter_task_file_kern {
>> +       struct task_struct *task;
>> +       struct file *file;
>> +       int fd;
>> +} __aligned(8);
>> +
>> +__bpf_kfunc_start_defs();
>> +
>> +/**
>> + * bpf_iter_task_file_new() - Initialize a new task file iterator for a task,
>> + * used to iterate over all files opened by a specified task
>> + *
>> + * @it: the new bpf_iter_task_file to be created
>> + * @task: a pointer pointing to a task to be iterated over
>> + */
>> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
>> +               struct task_struct *task)
>> +{
>> +       struct bpf_iter_task_file_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(struct bpf_iter_task_file));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=
>> +                    __alignof__(struct bpf_iter_task_file));
>> +
>> +       kit->task = task;
>> +       kit->fd = -1;
>> +       kit->file = NULL;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * bpf_iter_task_file_next() - Get the next file in bpf_iter_task_file
>> + *
>> + * bpf_iter_task_file_next acquires a reference to the returned struct file.
>> + *
>> + * The reference to struct file acquired by the previous
>> + * bpf_iter_task_file_next() is released in the next bpf_iter_task_file_next(),
>> + * and the last reference is released in the last bpf_iter_task_file_next()
>> + * that returns NULL.
>> + *
>> + * @it: the bpf_iter_task_file to be checked
>> + *
>> + * @returns a pointer to the struct file of the next file if further files
>> + * are available, otherwise returns NULL
>> + */
>> +__bpf_kfunc struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it)
>> +{
>> +       struct bpf_iter_task_file_kern *kit = (void *)it;
>> +
>> +       if (kit->file)
>> +               fput(kit->file);
>> +
>> +       kit->fd++;
>> +
>> +       rcu_read_lock();
>> +       kit->file = task_lookup_next_fdget_rcu(kit->task, &kit->fd);
>> +       rcu_read_unlock();
>> +
>> +       return kit->file;
>> +}
>> +
>> +/**
>> + * bpf_iter_task_file_get_fd() - Get the file descriptor corresponding to
>> + * the file in the current iteration
>> + *
>> + * @it: the bpf_iter_task_file to be checked
>> + *
>> + * @returns the file descriptor
>> + */
>> +__bpf_kfunc int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter)
>> +{
>> +       struct bpf_iter_task_file_kern *kit = (void *)it__iter;
>> +
>> +       return kit->fd;
>> +}
>> +
> 
> I don't think we need this. It's probably better to return a pointer
> to a small struct representing "item" returned from this iterator.
> Something like
> 
> struct bpf_iter_task_file_item {
>      struct task_struct *task;
>      struct file *file;
>      int fd;
> };
> 
> You can then embed this struct into struct bpf_iter_task_file and
> return a pointer to it on each next() call (avoiding memory
> allocation)
> 
> 
> (naming just for illustrative purposes, I spent 0 seconds thinking about it)
> 

Yes, I agree that it is feasible.

But there is a question here, should we expose the internal state
structure of the iterator (If we want to embed) ?

I guess that we need two versions of data structures struct bpf_iter_xxx
and struct bpf_iter_xxx_kern is for the purpose of encapsulation?

With two versions of the data structure, users can only manipulate
the iterator using the iterator kfuncs, avoiding users from directly
accessing the internal state.

After we decide to return struct bpf_iter_task_file_item, these members
will not be able to change and users can directly access/change the
internal state of the iterator.

>> +/**
>> + * bpf_iter_task_file_destroy() - Destroy a bpf_iter_task_file
>> + *
>> + * If the iterator does not iterate to the end, then the last
>> + * struct file reference is released at this time.
>> + *
>> + * @it: the bpf_iter_task_file to be destroyed
>> + */
>> +__bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
>> +{
>> +       struct bpf_iter_task_file_kern *kit = (void *)it;
>> +
>> +       if (kit->file)
>> +               fput(kit->file);
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> --
>> 2.39.5
>>


