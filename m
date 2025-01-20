Return-Path: <bpf+bounces-49307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC8A17449
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 22:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E616AC03
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8161EF0BE;
	Mon, 20 Jan 2025 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JyFNSfW4"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2071.outbound.protection.outlook.com [40.92.90.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879523A9;
	Mon, 20 Jan 2025 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737409808; cv=fail; b=rqgTQM7kq1vxIe5TuNMn6vEc+4JtXnXePiTOpHqy+3N6CgKak3DUd9AGin4xoNrv6mN1bVXqn3WJVmnKfBebZkLT/4k6RLdQGYVJVIr4E9CjjvAKJkXsh1cjGGvibEepjCspyu5/gOx84U/ogI0ITaeHP1LLzWQ2Af26iz/lqGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737409808; c=relaxed/simple;
	bh=FUoXZcZ6WOl04sqofSyMQ1llKf2gOeULZIyyZ55PCoo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e70TZ6O0bjmMaRDO2uWRkxUlM/NkTk5T8IwtE7MA0FN5XJXz3PccaaLcLEozNxfgw2bWbuh2Kaz0TmWQrxTkKyWEw0kq/0IgEdu06z4jNqU/DDBdXRWL8jED1W4C2sHOObiJiiRYIFgobAzA18F4X4TIYsOy3Ldb2Yf5QmmTFp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JyFNSfW4; arc=fail smtp.client-ip=40.92.90.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppsb2kX7gMUWlGzhMBYTMx5Me/yQj9ZzsTT2DJavtReEpWnEb+tVYVEXq+UizjSPRRqOeIHsWqXAT9gbqw/5MbrNGtv0awWkEl7eaxLjtw+wxq3iVhPWCu/1n2BocRIL1YIPpZKfqtWWb1UAHCxLXdTpNySHxN7mvOuQvs8ErSqkof3eSR7N6QJBXxlqpeFQieknMWI4Rhhanub34zREDKQKh/P3yBJKkoxVy+fGQYm+5LNfuWwN9qX3yfapCfJMEZy1utbLxq7MMPcIBi1FAePRPIdbYDPx6jTuaLUZur55lv4Flx6WE5eKoabXg1A8IjKKWekZtWHlezN+zsIB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UNZZ2RZrl6y4MjRUM6jSiIFqoMclf0OufscT6O7azY=;
 b=qHdlxjw1+JqnfCjjmRWYsDWVyq9JiHe5E8EpuwDSX63bXZT3jDhm9qHxUce4AnMv2a7qN4xxVCaqvqDa1gQxqwQs9Pap8MT6kyQp5wPdiJ5hIubZbsfUDsBZ/1FO3CZKI6TSPAOKFIMAmLtFwinRh9dWFismBM0Wy1WQHzSHCIXVhc7hcoW10unA7b4qIh2ftRCYrErvOyOcD5W1VZniMlDRFL4JALHYT+5sLfys30/2Doc8NKrILjCUFLMnnw90CZTcBqxfk8kjR/35AlauA7SbSkvpUWYifntOlSvh7z4GJcbnjkUkLDYINCcHWo5/4LTpsTI4On2DqBSL7Taetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UNZZ2RZrl6y4MjRUM6jSiIFqoMclf0OufscT6O7azY=;
 b=JyFNSfW4b3J/zCVef0W7+sBlz6+T56rDi0cTVR8+a/FhExju/ZlJuFWgenybuCSedUxsM8EzFp9jPC1JpHItcMkIeWPOZlDUc7H/1aMhCnCz7L2ZJNXU8/C+ISxb9btmGrWA8atFokMIFSiKePMBU9uYtU96gdMzpxqsiIXW5QpfnFwkIokrhtkt5/D3dId3nZ64XcW4+2rRbjMDY6GCHlfpvvyrw3jvGM6DOh4U9tgve3h12BCJbw9Jw6uDBMtuvIfGjOb7HdZj/UshRtNGZPD+dwBOMd6JXnDEDPFTeJEeR7WeIOT1BxDmp+qFV7h8hPnAFDq25qgeUVeZzhQrgA==
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com (2603:10a6:208:101::17)
 by PAXPR03MB7933.eurprd03.prod.outlook.com (2603:10a6:102:218::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 21:50:02 +0000
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::81c9:b053:75a2:2590]) by AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::81c9:b053:75a2:2590%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 21:50:02 +0000
Message-ID:
 <AM0PR03MB507665DA7BA404C64EB016F099E72@AM0PR03MB5076.eurprd03.prod.outlook.com>
Date: Mon, 20 Jan 2025 21:49:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add enum bpf_capability
To: Song Liu <song@kernel.org>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, tj@kernel.org, void@manifault.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com>
 <AM6PR03MB508002DCA7DBE7C7712ECC30991B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW4sd5LgmPjceFqaLGu20N4EVxRB_-FWOm5vcCGcRPa3ZA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAPhsuW4sd5LgmPjceFqaLGu20N4EVxRB_-FWOm5vcCGcRPa3ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::19) To AM0PR03MB5076.eurprd03.prod.outlook.com
 (2603:10a6:208:101::17)
X-Microsoft-Original-Message-ID:
 <f2b6bf47-960a-4ff1-aa5d-7394bb95c3f7@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR03MB5076:EE_|PAXPR03MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 093f1b6d-3d4f-4581-213b-08dd399c64ae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|8060799006|6090799003|15080799006|10035399004|440099028|3412199025|41001999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDVoNDNMOUQzalRvWlYrbVM0RDZSK25wcFA5REhXSm9rVGtGeXViTmpXTFZB?=
 =?utf-8?B?N0luMnB4Z2NHMStZc3RQaDJrUkE2VFBNeUYrTWFGZURPN2oreGtad2FyVXdl?=
 =?utf-8?B?ZG11L2tyWE1YRkFXUklIbFBOMUhFNWtnU2t5TlZGTnZZNnhXbmpqRHJzYm5t?=
 =?utf-8?B?QnBlMVR0bDVQaHFWdW1lTXFTSlY1YW9hc29ldDhtUzJYM080eVhzV2hpS1dJ?=
 =?utf-8?B?NzA4YXJJbTE1dElWOUIvc01reFZXNXVJRE56RUllZWNLZEhNcVZqRjRrTW5a?=
 =?utf-8?B?SHV5Ymsyd2pUU0k4bzE2L3BPR1gvU2FWRndDREoxa0VmTDRpdTNPb2hlU002?=
 =?utf-8?B?MGFqUmV1VXRMWWVVUkZSeVU0TG5MZXJyL0o5U1ovNUVPSzhaai9UWGlDNFpJ?=
 =?utf-8?B?VW9EOUljT2pHQmp3Q0NnelVpR2N5RzNkakh2bXdoa3cwT2YzeXpzK2JsakdU?=
 =?utf-8?B?c1g5YXlHbkIvYUZnSUVFeXUxMUpDQUhaQVB2QXJrNlJVYzRUbDZvNGZoMTg0?=
 =?utf-8?B?OWVUcE1ReDIwQVBqYnJ4OXBUV2lDbHNnWjdsOW9nSGF6TVhBSm56MHV5L2xa?=
 =?utf-8?B?NVdmQmZ5cDYxSW80R1V2S202dFdBOEVuS25STmZDYXBnQll3NjJaalZNdE5z?=
 =?utf-8?B?WnlTQkVwOHJJdWRDVElQdDVVQkhlODlHdVdMQzR5NUdpSFhrUzU5N3g3cUF1?=
 =?utf-8?B?SjlOKzAxSUd2d0FibjFqMlJjK2lSdmU2cktHdDJvTVZjM3RWdUFUajlEcktN?=
 =?utf-8?B?dVFLSi9ZMGx5V0ZVTXMrVEtsSldGbms3eko3YTB1OVU2R2dYSWtPR1FOZmVv?=
 =?utf-8?B?cnNlMGVaZlluWnFZVEVqWVd4QkRZMUZqUGtZbFNGTm1rU0dGbE5tSnl0b3p5?=
 =?utf-8?B?ZXROQzc4MC9tWnZOa3FWaXc2dHV1cGYxUHVDVlliUkJmZGRnazlOT0RTSGxh?=
 =?utf-8?B?V1FMUWpEbWZJZFFWK2JyMzhDek4zWko4SUJraEJiSzBnK3MwcXBNaXlHd0x4?=
 =?utf-8?B?WjhYNDN6NWU2UElDVG9VL0loZGcxN1lDeWNuMS96QUtnSHRsRnRkZWYvS2po?=
 =?utf-8?B?NXM0Vkc1NkFHVkFJREhldVp1ZnlxSkc1Z2p4U2RtK1dWYzNRbEM2QzNaMVFu?=
 =?utf-8?B?dTNDT0dlQTJPVGk3bWlQY0tSTDRsaG1FOStuU3Avd1A3aW9PZDFFMW1nRnA2?=
 =?utf-8?B?ODZDWmkvbDdDN0xwVDN3eEdkdzhEMU9zZGJFcU5WcW9yWnNzS2VHSk9NNUlM?=
 =?utf-8?B?eTRsTkxwMDNjVVVZMVM2SDRQTWxEWlVCNS9kSUJMVGM2MlNDS3RoSFhvNzJu?=
 =?utf-8?B?NE01MGsrTmZiQVF0UjRFa0wzTFdiL0JiK1QrYzZrTXBpV1c4d1hTMVR6cWFY?=
 =?utf-8?B?aFVLWlE3bCtONHBkenNFQ0Jqc05uR2JZZmZrS1gwUS9RUEtHRzNNTVlkK2JI?=
 =?utf-8?B?NTErNG80dHFXZGtVdjZmeXJoVG5pVGxJTUpONUpsbzJuODg5YjBUMGI3UWtB?=
 =?utf-8?B?L09MQ2d6ZSt5Q29lb3FablZqclQ4QlI2eC9KTEdxSkM5dnhzbjFualprOW1R?=
 =?utf-8?Q?WVbWgV8coycg1jf48PDDwmafzk5V/tRhKhVc/zSZCptTDt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGNTL2o3WFZhZ0dyZjR6blVYbWdiUXV2a2QwTjFsamk4WUdRUVpDV09SUWxE?=
 =?utf-8?B?a016WmkyUTJlS0hjWFlla0JNZ1NuY3gxVVBJZEY4eUZzcGx1M1JzdTVOckxB?=
 =?utf-8?B?bUgza2VkUmRXeGlLSkwrUWNLZHFVMHZSOUhZR21GRjAvMEIwNzlhWEs1YjBU?=
 =?utf-8?B?eWxYUUgxMXlwRjZzU0VyZU8rRzhpRzYvYlNWY3Zob2lhQTBvV0pKSFpMbHNt?=
 =?utf-8?B?Y3FYZEJTSnozVUs4Ny9tQnFDc0M5TzZQSGd2c3JySEU0OTY4VkFLN0ZFNTlO?=
 =?utf-8?B?QnQvUkMrTXc0akYyVzd1aUNXSTl6RU9DNVM4Vit1aGtBcUFBT0htYjYrbHUz?=
 =?utf-8?B?MS9mdTBEVU1kUHFtNXJ0YUlJSGJvcXpVQkZiZjFBaDVhNitQQzYxc0xLdFhi?=
 =?utf-8?B?V24ybHNaZU9BSUtkWldlS1lTTS9UajlJalZPc0JoelNPU1hnaDgraXNEa3Bo?=
 =?utf-8?B?NmtNdlBwcUE2cThDalFWbzBQOUZuT0ZRcHAvUzJWMTkwVFlzb2l2cFc5SGVz?=
 =?utf-8?B?T1Q0S3JPazFhczZaV09iczA4b1VVaUZENzBOOW50OWp0V1VaVHVHMWZmTnhK?=
 =?utf-8?B?a0dQM3dHcWdZTHd1WnQrU24zTmtTMzNEdHduUjFXNFY1UDVvd3JwZ2VRZ0lX?=
 =?utf-8?B?OUZNN2VjcXc5NG9YNkVla3RmaDBsek8yQmw2dFFCZThZR1d4RDhseUxZTkNp?=
 =?utf-8?B?bk5aR1RzZkJLbzRuRDNkTzNEUFA0T1VYMTdZenZiUFJuSkpQZzBaNTZVaFBH?=
 =?utf-8?B?RjJuZmNiZ0VzN0FpQk14d2dyckl2Q3VHb2htMlNNdW0yVmdFOW5KcE9YdWd6?=
 =?utf-8?B?NmVsQWFTYUFlRC9JK2k5aGNLS3Vqcmh0RUFheldjR21hSVoyTHdOREhHUEtJ?=
 =?utf-8?B?SEF2SUJIRkkrWDdzR2xYVGNKejNTWS90YjNDM0p3WDZzaXRWYklpTmowRVE3?=
 =?utf-8?B?QmFiM1A0N2ZsNjJmTGJNU2NDdjFlMitGVUxNN05Jb0gyNFY1TnByMU1oS2RP?=
 =?utf-8?B?cjBReGNmVXRjOWJpa3Vkb2VIOVF5ZE1ENjJxZ0xDQUtSUEZDT1dHckhIL3N3?=
 =?utf-8?B?bEREUlEvMEZxMnN2YTBrbW1laWNTK1Nsb3FuSmc1VkpNVWFFTnlZdWczZnFa?=
 =?utf-8?B?SVlYdTd5ZWV1bzNWVW0wL1QveUlzdTdHR1J3TUdoZ1NOcFlTYmFTYUttM0p3?=
 =?utf-8?B?aXNwcU1zNHAvanNBZFR5WTBlS09ZV1pJN1pIazE4YzBTQ3FibVFEcnRwdEM2?=
 =?utf-8?B?WERFRDg3WDB2UXY4UlE2WUxhY0tjWTlRblVoM3V3a2laWEZ2Sk5ibVdoeGZQ?=
 =?utf-8?B?U0daUDJnL21iL0NrSGgrT2Z6aHRvbk5hY3RCL0tSdktLV3ZCaTZKa1kxVEt2?=
 =?utf-8?B?cjEwSU9WTkJiREw3RWdnNGU2QVhSWHNVbEZreWltd2pzTERvb2F0eDNPZG5p?=
 =?utf-8?B?STZRdHFVRGVZd3BTSFFWY3pheWhDRTlEVmsvLzIvdDZBUEYyODVrVXhSNXpS?=
 =?utf-8?B?RWh1bExkU0tENXFhYlVYU2gvU1llNTM1M2hyL3RJTE9kbnpZU0p4YlBhaFY0?=
 =?utf-8?B?Tlc0b0xVUFkxenMyQWFSZ1NRUk8xbkh5NUVKbDRwdmNERlkvdGRqRGZCSWt4?=
 =?utf-8?B?K3ozanBQcjBma09LWTRvYk50M3JKcjBBeWdFRSsxU2JvMUZPS2tHT3IyTnVO?=
 =?utf-8?Q?yHu2GD+GMAiJdynHOhy3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093f1b6d-3d4f-4581-213b-08dd399c64ae
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5076.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:50:02.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7933

On 2025/1/17 21:40, Song Liu wrote:
> On Fri, Jan 17, 2025 at 11:37 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
> [...]
>>
>> Thanks for your reply.
>>
>> I am not sure if BPF capabilities is a good approach.
>>
>> But we currently need filters because we register all kfuncs to program
>> types, which are too coarse-grained, so we need additional filters for
>> further filtering (make the granularity finer).
>>
>> We added struct btf_kfunc_hook_filter and added filter logic in
>> btf_populate_kfunc_set, __btf_kfunc_id_set_contains, essentially to
>> mitigate the problem of coarse-grained permissions management.
>>
>> If we register all kfuncs to BPF capabilities, then we will no longer
>> need additional filters for further filtering because BPF capabilities
>> is already fine-grained.
> 
> bpf_capabilities_adjust is the filter function with a different name.
> So the extra capability concept doesn't give us much benefit.
> 

Yes, you are right, I realized this too.

Especially since bpf_capabilities_adjust is procedural, adjusting
capabilities based on different contexts is essentially no different
from filters.

Although we can use BTF_LIST to store the capabilities of different
contexts in BTF sections, making the BPF capabilities corresponding
to different contexts declarative.

But it seems not worth it, because the filter is more straightforward.

I totally agree that BPF capabilities will not give us much benefit in
solving the SCX context problem.

>>
>> Would it be a better idea for us to let each kfunc have its own
>> capability attribute?
> 
> This is no different to the BPF helper function ID, which turned
> out to be not scalable.
> 

There still seems to be a difference? BPF capabilities are not
one-to-one with kfuncs, and multiple kfuncs can be bound to one
BPF capability.

BPF capabilities are more like fine-grained versions of program types.

>>
>> In addition, BPF capabilities seem like a extensible idea. Would it be
>> valuable if we make other features of BPF (BPF helpers, BPF maps, even
>> attach targets) have their own capability attributes and can be managed
>> uniformly through BPF capabilities?
>>
>> For example, if a bpf program has BPF_CAP_TRACING, then it will be able
>> to use kprobes and can use tracing related kfuncs and helpers. If a bpf
>> program has BPF_CAP_SOCK then it will be able to use
>> BPF_MAP_TYPE_SOCKMAP and use socket related kfuncs and helpers.
>>
>> In other words, if we add a general internal permissions management
>> system to the BPF subsystem, would it be valuable?
>>
>> BPF is general, and it is foreseeable that BPF will be applied to more
>> and more subsystems and scenarios, so maybe a general fine-grained
>> permissions management would be better?
>>
>> Fine-grained permissions management will bring potential flexibility
>> in configurability.
>>
>> For example, if a system administrator wants to open the features of the
>> HID-BPF driver to users, but the system administrator does not want to
>> open other BPF features to users, such as sched_ext.
> 
> This appears to be a totally separate topic.
> 

Although I am not sure, I guess general fine-grained permissions
management might still be valuable (not necessarily BPF capabilities).

I found that Andrii Nakryiko implemented something similar in
BPF Token[0].

Similar to SCX, BPF features are fine-grained through masks to restrict
only part of the BPF features to be opened.

This seems to indicate that the demand for making BPF permissions
management fine-grained has always existed, and the demand for opening
only part of the BPF features will reappear in different forms.

Maybe we do need a general fine-grained permissions management solution?

If Andrii saw this email, could you please join the discussion?

[0]: https://lwn.net/Articles/947173/

> [...]
> 
>> Maybe we can have more discussion?
> 
> We sure need more discussion before shipping any changes for this
> topic.
> 
> Thanks,
> Song


