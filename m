Return-Path: <bpf+bounces-45992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C49E1375
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 07:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E51606D2
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098A1885B3;
	Tue,  3 Dec 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EuBpPxp2"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2082.outbound.protection.outlook.com [40.92.62.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366E15C144;
	Tue,  3 Dec 2024 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208173; cv=fail; b=gQ4ObuzHIyUkrpklbyoL9CLWr8T4iGAQxoIsBNv0j4lVbyncd9Y9sc98C+FWEXLPcj9wd5hpvV3WtZfM3kTEGAQi94FEMrmehdkmAZtHopxgaoHbqLi3j5K7BHqOCiLgfWFEtnGkk+ORN+dnbjN9rNp5trYbFXwnEDCRuYgbJE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208173; c=relaxed/simple;
	bh=P3n9douKA3lCanymJm4VSq7hqA4hiT7b/PBYZUOm7F4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOpnnL88ClAI7LJ4aG8cvjvvvcXWnmiCKMH5S2nNUWVUDl5U1EKVfaGXRSmux2PTtJtn2j4ESnCj0EU42pgwwS+j9++bogs6gsku+O17U93FklkCw5WsWEmiHz/fvMeUL7rRaUqFIwwuRTjPjPk9JLVqW11xeejbC8rWWF9/OHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EuBpPxp2; arc=fail smtp.client-ip=40.92.62.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuLiEJU9cbxvLIjf9f9qtMa9u/pwujIrIOk+1gfyWRSH7zyCtGVYNAPlavAMNIMh0USLmT/bExpuh2jv/mgYCvnbzhWB6gm0Br25TQV9B9o/fDRBCKTugXK85IhFgzYTL2/Qb6ZslBzZjmTVze+E8mfUzmy6SFNmKLLz33pfK6jjjCcUFWAqPCG9Mnaac8v+QLd/Xd8uLGXKKeBJp+Byof1aSOWgdpIjv4ZoHfhx557KqBxrnh6FciJoj/zJjtiYCr1SgS4lCq02xyp8bTIBm3u6jauc0i3Oq/fs4MKq9fgtqNKFhr4gVcWfcwzLc78lxCNr6UPWJJkJDejnSWBq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZEeaF9pXXIzAQfFpHEVv/JUbGH7LhhwKMBK73NNVrg=;
 b=aXLa9IzNa0i70vr2alkddiYjHnAv081ONJOuk4/ySLJaeG166BzOLqoHr+YzGhxR+wXsL7oKdHq0T6CZ/t7yBI7xN3JKgQYZsrgWNmKTYxAf9eSWjT11qJ6DuT2xlM+/EiBl7XuSj8ts4KCYuEDAVtdOfIihv25cWAN6jBngJVp07OqjRGuTyYCioAx4G8nTHZhgZex10SxcBjj9EohOrioEgxv0uy/A5NA0rW7AdcTgqT4XMWyZ8mG+VI2nwEby4jjA1nwmxWdd02dPwpKr39Zh4LEJXHZNcZy4m/Pn2gIT333CREk1/GZVoa3QaE5H2Znere1EF1BtL/jt/CLQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZEeaF9pXXIzAQfFpHEVv/JUbGH7LhhwKMBK73NNVrg=;
 b=EuBpPxp24mrXAN60Xt7Jm7d2x4qFPEKJ3efpDAs0nL9CqPqZRRIKkDIL9WlEM1SKCCGuDfjAE2li2nKAU/p4VbUcCxBsPYfa3eqe6CjVmq2V2aiSZS2Jq2NfHx8Aan8sm4kh4YFJkseJIodXVFhx1s5sECuTf5ZthpiZ4NZpK7vVndYFFbAxstLQ63jQ3deA+voikITYf50orfaYeLFW/byPI/9eKsKwyeYjammCuyJR07Eh3MhV1xe54wwXLWQgggXrEjCyxJt2LV5T+sdIcdbxs81MIv4Awdw7t6fK4yXol+cSuxKvZNqRxh6MdYFBNZfTYusW6o1bFQRW2d1Vtw==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY8P282MB4654.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:259::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.8; Tue, 3 Dec 2024 06:42:46 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 06:42:46 +0000
Message-ID:
 <MEYP282MB23129F39F3031D956B66E66FC6362@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 3 Dec 2024 14:42:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <20241202150422.013b4767@kernel.org>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <20241202150422.013b4767@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <8216a889-e77a-4745-8419-a1c41f2ebaea@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY8P282MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfbb8cd-3408-4b2d-ed53-08dd1365b221
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799006|6090799003|5072599009|461199028|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzV4RnRCQjJ1RElSVzdBZUtGTVIzZTJpYUJFaGlnRzNWM1Y0Q3I4NWY3OWVw?=
 =?utf-8?B?RjExVHVNdU00SkxOK3p4R0JNQndmbWtMdmxocTlhMGR5REJ2UkVIcDhXSW10?=
 =?utf-8?B?VlFEaUhvNTF3ZGgwK3ZnaWlsQ3Q0aGt4bzJrQjJUUUV1Y3Npbm1ZdFNRMzF0?=
 =?utf-8?B?ZlBYY2o0U0tXVFFEcXRab0NtMUFLTEtzUzMyeVc5V2ZuL1ZGWi9JdU9ZNEpt?=
 =?utf-8?B?d0pBQTRkZkg4c1FnK0FGRFB6bVN4b3ArTkppSnB4TllMWHU1TDQ5ZFFQRGo4?=
 =?utf-8?B?Ui9NSi9MOW04amxSVVdEanVtZW1WQmgvTW9ZN2V6TFNSOW5tb3BqUGhOa1NT?=
 =?utf-8?B?NWY1dE9jREo5WjdZSGZoL0I3ZWU3bG9EVHI5anpsVzllV1k1RFBJYkNWbVJL?=
 =?utf-8?B?T0Z1RlFMTEYxaEFYcWZuR1FHREU4MWJOQWwrR3N1UVJ0bTJ2MW1QVnVveTFn?=
 =?utf-8?B?dEQ2MDJXdVprajdRUU55eXI0b2NoRWhURDRnaElnUjFkZlg5ditPYnVkbDFX?=
 =?utf-8?B?Tnkrd2FNaTlGazZRYk13ejhhTlQ5R0Q0cGpwaVJEVEVzS1ZYUVFPSm4waEJo?=
 =?utf-8?B?aEVIWG5YUjlQVFh5T2RQV2lyQkpEZDRyS1lhdjJhSzlUZk9mWHM2TSttc2Iv?=
 =?utf-8?B?WkZUTmVEMG5uWW94Rm9scmdIVHRsTHhTMlVROVBRSHBXdForaXpET1liQ05p?=
 =?utf-8?B?bEE5OExSR1lVeXBueXphTDZUUDVJZFBHZGtVeU1OejNNd1JSVlZOVWpTK2Vt?=
 =?utf-8?B?SHlCaSsxMUdHTG5VWmQ3R2hObTg0UGY0SE03MVp0QlJMdHh5aGp1bDc0Y25P?=
 =?utf-8?B?ai9vT09UT2Q3OGtkS1Q3eDV4NmJyR0pvQVhaRWlkMjlweVJvTERpV3J4RWVQ?=
 =?utf-8?B?TG9MWGg2S1AzVFV6SURrdzl1cWQ1cnhTT3QwelRCMSt3eC85WW5mV0NKNzlh?=
 =?utf-8?B?Vm5GOGxnZnpPcFljMWNZQjUwdytxNGlWdTd4NWp5RERCbnRWZGtYQWR0MENx?=
 =?utf-8?B?WnhMM3k1Nm5tL1NUbko3SEtaSXJtY1ZOTXlnZ1JaM2JRSzI2ZDRtYW9uTnpH?=
 =?utf-8?B?OFFlQU1GWUhZbDFWKzJRaW9Fb2tkYlltK1BFV2FFUEJMd2RUc3YvZlNqeXFF?=
 =?utf-8?B?dFp1NW82VlYySDZlQ0oydWplU2taWGNXM2xwRGI2OHlOTjVyRW9iL0l1TVNI?=
 =?utf-8?B?eFpqSGJNc2NaRnpyQnc2aDRyVUIyQVQ5RG1yKzhibXA4Y2dwRCt5NUJIejBG?=
 =?utf-8?B?MmM5Nlp2d2xSTTdzdXA4UHd0WmFFQlpwMDRvbTBrQUtZdGpOL01GRXNYaEkz?=
 =?utf-8?B?bGNzbGRRMzdGYlJTay91MEYvbm4vcjJyMHNSbUc2bEM1OUhoTEVJNTh3eUZ1?=
 =?utf-8?B?Mm4rUjQ4dWJIU2NyUFJiVStOT2toVE1kUDZ4K201OHRDV2hDTzBHWCtTV1l5?=
 =?utf-8?Q?CqtPT/JL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0FqMUE5N0VkMmczUnJSSXdKU3hndTVPeEZuS1BhRlJ1bS9TRlYxbmRZYlQw?=
 =?utf-8?B?d2RkOWw4S2ZYdzlSQ3IrUzlrQWVqanA4RXRlZGMydk0wK3VSTW51M09jejZp?=
 =?utf-8?B?SnNmeElmalpQZUxhK0haMUpXa2lFUVBxdng2M2ZzOGN2Ty9jaHgzN1kzanNW?=
 =?utf-8?B?UDFjcFh3c0s4RnhYNG12MHQzc01oTEI2c1JXR2xkdVBoRkVWWkY1eVM0eHBp?=
 =?utf-8?B?dGtSZW0wNE1JbkVGZ0FGMEhQSHVJcHM3YkV1TXRkcVMvbDRwUGordDk1eGhH?=
 =?utf-8?B?V1IwL042OCtWOWxpbGM1Y1RBU01hRTRXY3JmMCtyaGNOUEdDWS9hR0w2VzNC?=
 =?utf-8?B?cjBCSkFvVnZQQmFpdEEveWJ5ai9wL3BZT2ZhK0hJa3Q4SzEvVmw5RWVaUm9x?=
 =?utf-8?B?YlExd2p4M2JySmRJVDRCeG9sVUVRQmdjcU5sZitjTVZHemxqSnRobnppc0xR?=
 =?utf-8?B?YjVZZWNCamFic2pGMHFHcU9jM3l5TG9NVHBvR0o5cE5uMVB3US84ZDFXOW12?=
 =?utf-8?B?N05jQU8xeUdXa0ZMUzgrUkRIQy9mLzVPS21KYkRRZ29FeDR3WCt3SWlDbFBt?=
 =?utf-8?B?NkFwakhCNDUya0FNOWdDWW5hWTMzU09NUWxJa2d0R2kxUHhNMnVzMlNvQi9i?=
 =?utf-8?B?Zm5tbTdzRGhaem5VTEhhTFQyeUdPT05uRlB3SkVPbGFwR2xxYzFIVTB6Smhl?=
 =?utf-8?B?RVBmaURNUDRjMDg1OGVVRFQ3ZlJYVDZ2R1JZbU9Za1JjNlN3OHBSMHBpU0Fa?=
 =?utf-8?B?cklWVVpmWVhzOHBQWW1YamRQQXRTN2hBem9hQ1VMVHY1V283NWVRaVl1TzFw?=
 =?utf-8?B?QzFUYkg3T3ByTzlTdGZCRHdUUmhicVh3NzRrSGhIU0ZBTlY5RzlvRnF2a1hL?=
 =?utf-8?B?MEQ4U3NTWkRtbEQzNDQ5Z09ld1g0MCs3OTVOSE8vTE8vdm1RZmUyYVpDblh6?=
 =?utf-8?B?cUJxajRTbXpiNFRwY3UycUVRRE12VndkVk5IOW1tMVVmcnhJZ0gxREIrWW95?=
 =?utf-8?B?Yk5keENrVUdxb1U0Yi80eHAvWTRwMWF5S21yUnluaE41TlpvUGh4NXJUamlI?=
 =?utf-8?B?V1VSQTYzdHM0bzg3T0x4TndrWVMzb3BJbnFuQWw5dUJFRmE4OEFxamVmMjRu?=
 =?utf-8?B?b3VCWS9YSXpORlRZVDYzSWtPekZlRnhZOHpuNXFQS2lsc3hMR24xYkd2cGhT?=
 =?utf-8?B?aDZ1QUpDNEEzNU5SUG9zSWRxejhkLzJlZXZLNGowRW9HRC8rTm5CSnZ3Wit6?=
 =?utf-8?B?NVpneU9hNHVEcUxCTW5zUEM3a3hjWU9yeGlZV0c5NE1rRTdFMFk2Ylh4WmZl?=
 =?utf-8?B?c1kybjFJSng1dmtYdmprcFBYRWQxeFVlbG9TTmxOTkhqell2VmtkTVZOUm9H?=
 =?utf-8?B?bWZIOEZodkg1cG01M21vMzNnTkd3bDdaY1RSMnl5M3VjRHJ0RmxUMXIzWnpM?=
 =?utf-8?B?U2c2V29LUUpxS3dNMFhaeUUyRWFUTlJLZW95SndVVFdrTHY3cUpwaXJyYnVr?=
 =?utf-8?B?bFVhT0tXTHZPSkJJa1NQdVJOYzdMVS9zT0o5Sk5GSVFnR01xWHFDWUZEUkZz?=
 =?utf-8?B?aEVJZjhLSjZnTy94WDM2L0ZDbTFkcVhEZURqMjFMWkZqd1JFaVZIV0phM0pp?=
 =?utf-8?Q?Fo/5S1NGPcs+vR0n2wHojsOSd3d9RgYQh5TbKGAp/YY0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfbb8cd-3408-4b2d-ed53-08dd1365b221
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 06:42:46.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB4654

On 2024-12-03 07:04, Jakub Kicinski wrote:
> On Sat, 30 Nov 2024 21:38:21 +0800 Levi Zim via B4 Relay wrote:
>>   net/core/skmsg.c   | 5 +++--
>>   net/ipv4/tcp_bpf.c | 8 ++++----
> Haven't looked at the code, but these files are BPF related.
> I'll reassign the patch to BPF maintainers, and please use "PATCH bpf"
> instead of "PATCH net" for next revisions.

Sorry for sending the patch using a wrong prefix. I will use bpf prefix 
for next revisions.

I am getting started with bpf development in the kernel.
Initially I thought about using bpf prefix but I saw all the files I 
touched are under net which
confuses me about what prefix I should use.


