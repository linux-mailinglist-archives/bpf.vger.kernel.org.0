Return-Path: <bpf+bounces-47407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A89F8E78
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 10:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501E51608B5
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198E11A83FC;
	Fri, 20 Dec 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EPmOA4S4"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2050.outbound.protection.outlook.com [40.92.63.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958C197A8F;
	Fri, 20 Dec 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685273; cv=fail; b=uE8LOufLQ0kTryYBvn2K1hiTrcnC4PYmrC4kf34KmEXNsMU43VwXq/aX7OiW1PykuarnfniBYMo6eBMygVmFcQOml7HlilcCZp7HQAgP9flwUj4vHQvL2MQGrbcCRFfprW36CyhaLlsElMTQPmGAWCalJ2BSxolebqw8Iz3R45c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685273; c=relaxed/simple;
	bh=+FnwMvarBA0Fg9ofFwqz1m/NeaV3DnR59BqbRSw6JVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLYnsXDhOE/K8K5Xe6JXPozrSwNmAX+MvxByWEYBolxqb0E5AYSzRo8gxyQWVIONH7IXjBFSfgSU8CugfoMXYsCSJU8/OsuagVdYYSUo4Q2Kfol50XGf+qBuJR3+dLVWAUZrGwlYcR8Rzjn+zNSaRJrLmLuq8wKIH952/K6iv4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EPmOA4S4; arc=fail smtp.client-ip=40.92.63.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnFYaasfdsNJbol7VHleSq3zkaTrjHzCelALWvzfjPpj8+Chuln/LRbepjpQYG0eUggyhweeRdvQYIJgBAmE14aoK4nNvVPAc3oyBM08rm/72yfUMS3rgeCXPVO6YQsHpDYEM5HIyVJuGkNeC2tWGVNn3ygSJI8DfSRN8TIZZizvQu9EHptnUylTtodex0/V7GrADbuJT/UVKUkbZJBg70jaX7Axhrmvbh3FZMi/bD5jNqf63lhdP2y7BaagC1Wv0LhM54Z6k4fB7V1X3yLeoXcsIJfQ2e4cCn4W4fToRnWC7VHfPoArIYYjzkraGdkbQ0fYv7G7IRLx4sQhZuW+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok2IbKkqUU8+V6o992GePe3VmliNcmSnCbfSHQqKpH8=;
 b=UGjBYS3M6l6+iqAJ7CMhN222t/oe+GqRiWigXKILWeUgKbRAQ2lspM0OuGmYydwUmKsPd4hIO3cg5DRKlRsHdgsH9dQWL7+62tuKbhlLYRBRJu4/YN0G+DJwWBp4tsn5SYfMAMYEf24hK4/oV3TlmdFjA9z+i+G4UEUZGamRmTlJuoJFPN3Q5t2Jc6bUjMiNllwgz1zz8wP0iHOz2D5GLL3zbIVJmBjDymc5EwTGkybU/K2hn7qVElJEtz61RQZnpc3/vLkiQ0Q2Icj+llMe8ekidm8rT/TBe97PdMg1KlIsfFdCwOmTwISBr5pfM8zjL43cD7do1vjSgnookKWCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok2IbKkqUU8+V6o992GePe3VmliNcmSnCbfSHQqKpH8=;
 b=EPmOA4S4TKsTSmGUi50UPF4T38ZqdUBs3HIBm+vf1Nlh26PjxJV/XzjRPiudh9Vd4TthIHavtu67kMyfVusOyxH3/zolxGdp3KZCQscjZwS+1Wnl7Yxv70K7V9T1zS8dSkcHhON//KmlgZtOCMGFXUASKk0xILAJq7Pf8DTZnu6FmvYXKmiWBcGYHIM1pQ/CYcF5cmyOWK8wLwwzaZeb0DJz2UpoiPt6VVozvbcG0hNnf6FlT0aDdeJIAYzjdM5LiC9ky73x5Ohe2vWECMg3MDQXqEFSeTBlhgvYaZLXCcE/qXt3lM6gzo+IOIaLcb+rqUXFvhGWcy5HhEWTsl9adw==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY8P282MB4561.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:256::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.9; Fri, 20 Dec 2024 09:01:06 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%6]) with mapi id 15.20.8293.000; Fri, 20 Dec 2024
 09:01:06 +0000
Message-ID:
 <MEYP282MB2312A1362E60100C677C08ACC6072@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Fri, 20 Dec 2024 17:00:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
To: John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?Q?l?= <bjorn@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
 <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <87y10e1fij.fsf@all.your.base.are.belong.to.us>
 <87msgs9gmp.fsf@all.your.base.are.belong.to.us>
 <6765231ce87bd_4e17208be@john.notmuch>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <6765231ce87bd_4e17208be@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <45fb7941-e6c9-47db-acb0-ce047d4f2b5c@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY8P282MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 197f8683-5ea2-499c-5f6e-08dd20d4d66e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|7092599003|19110799003|8060799006|15080799006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDMyM05ITHpRM3NGSUUvYmhoc1ordk9TakJXK2x5RGd0bWFiUTV4Vm9WaXdj?=
 =?utf-8?B?em83SUowZzkxaUlMQWZIaTFlSzR4NG16Z1Uwdi9OUzdPNTQ4KzhNcmNXU3c3?=
 =?utf-8?B?UFFrZ0U1NVFHUGNXUmNocFY5VDVJclpCSC8rV0RDTVpJUEhzSmFPS3czV3Y1?=
 =?utf-8?B?bmQvTG94QnRodytQR3FIclhMbG1CYnlUaWt0bzRwbjZjM1JqVXhMaGYxNENr?=
 =?utf-8?B?YVNKUEdmV2dvM1pVSGluaFVCcTNJeDhlakNidGxDT0tKT1Q2VmJyMXhWTFQw?=
 =?utf-8?B?ckRLalBhWHlhMjZHWkVvenpSNVFYYlMxTnlSNXZGR1poMnBOZmZrdDVZV285?=
 =?utf-8?B?aC8wOXk3ZlpIOHcvc1duT05CbkRCWG1GcFdqVDZ4V2M5Q0dVeWRoM09qSDU4?=
 =?utf-8?B?N1JiZU1OZ1AwUlorV1ZSOTQraFdFZlY2aUdBWmZCVWtYNVhFVFJEanlDaWF3?=
 =?utf-8?B?V2tWb3lYeDdvRklXRjhUdDlHcG1lU1VDMnFxT1JwTGVYcmNsSXkwK2xaK09y?=
 =?utf-8?B?QkQzd1hSVUdKRjJwejhzS3NKOW1mcUtheFoyeDN4cHk1Q3VZaXRNZTdUMXRF?=
 =?utf-8?B?TlNrZkhsb0ljMUJXOXhETGxXYUNsb1VQa3V4LzZJRnlFOFplKzFKdkFDS2pz?=
 =?utf-8?B?Z1IxRExnRHZSUzA1QnJadkk2cGJLSlRlMjFuMC9GYVVHRzNSaklUT0hLWVZi?=
 =?utf-8?B?ODc0bXdSUEp1KzJVamFzUjAvbVFEN3BOMk5KSUtzZG9DN2F1ck9GczRRY1Zj?=
 =?utf-8?B?ajIraDhrNys5R2MweFg3NkR1Tjl0Q2pLd1hNNXB5SnNuaVVwT3AwTi9nc3Fu?=
 =?utf-8?B?RjN2dkJBR3pabGhyQzlTeEdYYXplL0g1aGwyaVdrSjdCUlhrMWFHNFUrcnJp?=
 =?utf-8?B?endTc0RjdG9kajZTakhjcU11dWRwb2l4Y3NFdHA0dnJEVVI4MS9VMTVzTTRW?=
 =?utf-8?B?enhHeVJpSDRKc1ZxUlh3WTduZysvWnNpVnNhcXVaOXgrVWhZQVZYZTNVTXhG?=
 =?utf-8?B?RzNubXBBTGdRMkI3dmtJS295amdIL3d4bW1GRStoUnB3MTYzQ3pCYU1CdXZy?=
 =?utf-8?B?eXA4dDZLVUJxcjhqYS9uUU5ESzJLeWNpMDlpK2pLcFlxR2J5U28rbmVtQzdN?=
 =?utf-8?B?NVlTcHM5MXAzMU01NVh5L3diTzVGRkt1TGowd2ZPbWxIWVhhdmVpS2c2aGFI?=
 =?utf-8?B?aE1EM2l4WXpGeGJWdit4VzRjOC81cHMyclpyYVFjUUhHR0QxaUtkNU5Dc2Nk?=
 =?utf-8?B?a09ZTEtPZkI1d1NBazN5dEZWRkdCV2hvMjcyaENPblo2eiswSE04bXpUcnll?=
 =?utf-8?B?ZUo3dHZwZUY1SFNDbTRoZWxKU1p5SzBTR25qeElDTUdEcGFxQW9OOFRaZUxE?=
 =?utf-8?B?b2hXU3pnS3RnM2x0SWljdUY2SDRaRTlYdkcyNEk4TXBNZXhwbERwOHVvdWZr?=
 =?utf-8?Q?F8zx3c9w?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBJS1Z3dXRDb2tpTzNBdWxDRGRsWE9JNS8vMFdCZ2VQdWozTERxMnVlb1BT?=
 =?utf-8?B?OFdmemluUzRRYlZ5Q2NYQWhEVGptNlphMWprMUZmaHhHQkZtbk05cjlsRFNF?=
 =?utf-8?B?S3gzYXVkMGxib3Mwd3ZPbVEvR2ZwS2hmNHJOQ3ZhRlArQ2I4VlhpMzhXYUMw?=
 =?utf-8?B?Tk1WNzc1NHFlSzY4ZWQzSnZnUjM3MC9mVElZcUV5UThxdlVMWDZKNlJwdm1S?=
 =?utf-8?B?am9VNUdTcGs4emZZcU01L2grNEhxVHZrM29lQ3V5VEduWmZnMlFOc0RaMEJW?=
 =?utf-8?B?a3lDWTlRSlFlVk1HWG51UjZBMmZWbE9pM1BzUld0T0ZwakpHTWdNMkIwSTBq?=
 =?utf-8?B?ZmM2bHE2K3prTno4R1FTVU0vL2N1Ym9BalMvbmNBRldGL1R6dVpGdHdaNEpi?=
 =?utf-8?B?NldqZi94SkEycGNoalRJNUVEb3FybFB6L1RtSDJTRXR2WG1tbElzTjkvL2d5?=
 =?utf-8?B?L1FHNEJsZTZqdmdwSnphRDFwNkFpR2N1b1FNaE55MWp2SzdkWFdDdkRLTzhx?=
 =?utf-8?B?U0hMcjZ0bEdOQXVxVkdpRENHWmh5L1dpWVRtZlRwWmdkV2NwOHlaQ25YN3g5?=
 =?utf-8?B?VE41OWNsbkhsNUtlcG51UndneUROZVBMUVYySnJYcVhYSG5xWVl2c1V1T0dv?=
 =?utf-8?B?S2JxMmxTTHpnUDUrYm55WjNnR2gvR3Erc3NVOVR1SGVoTVlkaDFsakhEMnph?=
 =?utf-8?B?NHF0NGVsM1JMdGdGVTVQWWdaeGlqT1pNWmxKU3FLNXZDd1g4V25OUTZucTZO?=
 =?utf-8?B?VFdOTnVScklYTHNsTC9DVzhKcjNYdE40cWpNUDJSZDFnRjJ3TzgwNi9scm9C?=
 =?utf-8?B?cllrVTg0NEZzQmlQM29OSmRRbHYzVjd1dWNsVlpvRlltVGNJNTkxZ3l6L0JQ?=
 =?utf-8?B?TkZTeER4OXRUK1FoZEZtKzBRcStNOUZvRmpQcWQ4NVBab2dWQ0NoT1NNazkr?=
 =?utf-8?B?QXdGbkZBZ1g3VDFKcE95RThhMTRzS3p5S2NKdDhjeHZjelk2Nk5veTlMME1t?=
 =?utf-8?B?VUExQ1pKbUNjREpGMFpNcFlqUnNoVDN6YTArSW41OTRlWHR0K1prZnkzbVB5?=
 =?utf-8?B?dHVGd0NzTHYxZWtjQzF0MHlKNThkanJIR0JzWjlweEpTRnZsMUtXazhzSlhU?=
 =?utf-8?B?ak5ObHdyQzltWmo4MWU0bUVPZXBYM1BoRytvdXRSNWdqRmNUWU9ib0JORHpQ?=
 =?utf-8?B?YVlQQlpyeGp2Y2VLZDVMeUFxUkVJczIrZk0vckNQWG9iY0hzYzZmL05OWGtm?=
 =?utf-8?B?RkpXME1WQjFwVGM2RlVoeFhyeFBaQUtYWHNnRjdQRzFvNDNMN01JWHQ2TWR4?=
 =?utf-8?B?NEJaTDc1blZPVWM1L0dsMGFEODdrTFhLWEhTYk9iL2gvODNTOW5LSlRlVUZG?=
 =?utf-8?B?L054M2tRRXV5SHBocmw3WFE3d0N2WWdRQlM3Skl1YlloM0RkM2NFSUZGdVZW?=
 =?utf-8?B?a2dtWWw0MFB3OUhaYUtwUDRDY2g3alZ0eDc2TGx0RzhPYzJoMHhWY081ek1K?=
 =?utf-8?B?OHJSL0ZFTitSYlRwLzU5Ri8wTFBpem5iRXdXL09jMkVXUnJxNVNRcWdUOFRH?=
 =?utf-8?B?QjdMbTVJaXlPamV5N3p3bklrMmZBWnZjUjIvYnI3Z2loT0N2SEQ5bERqOFo5?=
 =?utf-8?B?VXhabjRFVE9ORllTV09lZTYvNVNvcVM5bkNnVGVoQVZDNGkwVkJTUzdWb0cv?=
 =?utf-8?B?VHVyenBzNW1ENGw1ZzR0L0c1dW11b2Erd1p0cG9vRlpPNTRSeFJyMXJMcERR?=
 =?utf-8?Q?AlATaRDYE2w+3jlK7AZP/Zg5CDXu0a/0mCFbfrD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197f8683-5ea2-499c-5f6e-08dd20d4d66e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 09:01:06.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB4561

On 2024-12-20 15:56, John Fastabend wrote:

> Björn Töpel wrote:
>> Björn Töpel <bjorn@kernel.org> writes:
>>
>>> Levi Zim <rsworktech@outlook.com> writes:
>>>
>>>> On 2024-12-04 09:01, Cong Wang wrote:
>>>>> On Sun, Dec 01, 2024 at 09:42:08AM +0800, Levi Zim wrote:
>>>>>> On 2024-11-30 21:38, Levi Zim via B4 Relay wrote:
>>>>>>> I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
>>>>>>> test_sockmap.c triggers a kernel NULL pointer dereference:
>>>>> Interesting, I also ran this test recently and I didn't see such a
>>>>> crash.
>>>> I am also curious about why other people or the CI didn't hit such crash.
>>> FWIW, I'm hitting it on RISC-V:
>>>
>>>    |  Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000008
>>>    |  Oops [#1]
>>>    |  Modules linked in: sch_fq_codel drm fuse drm_panel_orientation_quirks backlight
>>>    |  CPU: 7 UID: 0 PID: 732 Comm: test_sockmap Not tainted 6.13.0-rc3-00017-gf44d154d6e3d #1
>>>    |  Hardware name: riscv-virtio qemu/qemu, BIOS 2025.01-rc3-00042-gacab6e78aca7 01/01/2025
>>>    |  epc : splice_to_socket+0x376/0x49a
>>>    |   ra : splice_to_socket+0x37c/0x49a
>>>    |  epc : ffffffff803d9ffc ra : ffffffff803da002 sp : ff20000001c3b8b0
>>>    |   gp : ffffffff827aefa8 tp : ff60000083450040 t0 : ff6000008a12d001
>>>    |   t1 : 0000100100001001 t2 : 0000000000000000 s0 : ff20000001c3bae0
>>>    |   s1 : ffffffffffffefff a0 : ff6000008245e200 a1 : ff60000087dd0450
>>>    |   a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
>>>    |   a5 : 0000000000000000 a6 : ff20000001c3b450 a7 : ff6000008a12c004
>>>    |   s2 : 000000000000000f s3 : ff6000008245e2d0 s4 : ff6000008245e280
>>>    |   s5 : 0000000000000000 s6 : 0000000000000002 s7 : 0000000000001001
>>>    |   s8 : 0000000000003001 s9 : 0000000000000002 s10: 0000000000000002
>>>    |   s11: ff6000008245e200 t3 : ffffffff8001e78c t4 : 0000000000000000
>>>    |   t5 : 0000000000000000 t6 : ff6000008869f230
>>>    |  status: 0000000200000120 badaddr: 0000000000000008 cause: 000000000000000d
>>>    |  [<ffffffff803d9ffc>] splice_to_socket+0x376/0x49a
>>>    |  [<ffffffff803d8bc0>] direct_splice_actor+0x44/0x216
>>>    |  [<ffffffff803d8532>] splice_direct_to_actor+0xb6/0x1e8
>>>    |  [<ffffffff803d8780>] do_splice_direct+0x70/0xa2
>>>    |  [<ffffffff80392e40>] do_sendfile+0x26e/0x2d4
>>>    |  [<ffffffff803939d4>] __riscv_sys_sendfile64+0xf2/0x10e
>>>    |  [<ffffffff80fdfb64>] do_trap_ecall_u+0x1f8/0x26c
>>>    |  [<ffffffff80fedaee>] _new_vmalloc_restore_context_a0+0xc6/0xd2
>>>    |  Code: c5d8 9e35 c590 8bb3 40db eb01 6998 b823 0005 856e (6718) 2d05
>>>    |  ---[ end trace 0000000000000000 ]---
>>>    |  Kernel panic - not syncing: Fatal exception
>>>    |  SMP: stopping secondary CPUs
>>>    |  ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>
>>> This is commit f44d154d6e3d ("Merge tag 'soc-fixes-6.13' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc").
>>>
>>> (Yet to bisect!)
>> Took the series for a run, and it does solve crash, but I'm getting
>> additional failures:
> Hi Bjorn,
>
> Thanks! I'm guessing those tests were failing even without the patch
> though right?

IIRC those kTLS tests were failing when I manually commented out the 
cork hangs test that crashes the kernel.

>
> Thanks,
> John
>
>>    |  [TEST 298]: (512, 1, 3, sendpage, pass,pop (1,3),ktls,): socket(peer2) kTLS enabled
>>    | socket(client1) kTLS enabled
>>    | recv failed(): Invalid argument
>>    | rx thread exited with err 1.
>>    |  FAILED
>>    |  [TEST 299]: (100, 1, 5, sendpage, pass,pop (1,3),ktls,): socket(peer2) kTLS enabled
>>    | socket(client1) kTLS enabled
>>    | recv failed(): Invalid argument
>>    | rx thread exited with err 1.
>>    |  FAILED
>>    |  [TEST 300]: (2, 32, 8192, sendpage, pass,pop (4096,8192),ktls,): socket(peer2) kTLS enabled
>>    | socket(client1) kTLS enabled
>>    | recv failed(): Bad message
>>    | rx thread exited with err 1.
>>    |  FAILED
>>    |  ...
>>    | #42/ 9 sockhash:ktls:txmsg test pop-data:FAIL
>>    | ...
>>    |  [TEST 308]: (2, 32, 8192, sendpage, pass,pop (5,21),ktls,): socket(peer2) kTLS enabled
>>    | socket(client1) kTLS enabled
>>    | recv failed(): Bad message
>>    | rx thread exited with err 1.
>>    |  FAILED
>>    |  [TEST 309]: (2, 32, 8192, sendpage, pass,pop (1,11),ktls,): socket(peer2) kTLS enabled
>>    | socket(client1) kTLS enabled
>>    | recv failed(): Bad message
>>    | rx thread exited with err 1.
>>    |  FAILED
>>    | ...
>>    | #43/ 6 sockhash:ktls:txmsg test push/pop data:FAIL
>>
>

