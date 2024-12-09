Return-Path: <bpf+bounces-46385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1A9E930B
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 12:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346F5188611B
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CF2248BE;
	Mon,  9 Dec 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NDIwfGyn"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2086.outbound.protection.outlook.com [40.92.63.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7C221462;
	Mon,  9 Dec 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745395; cv=fail; b=EPPOrRKzPwyHtJWwjqs2iLuPF6ra7KD0Q6Z3xKdSLG/3b7bMJCTQ/UkNGOBcANl3GhgzZjZZt0/vk7+apRhRaGFnhQtRfa8ZPt7ioEUHEgpZ1hzb75mBiXw45H1dgU4kX/TClB+frXwZagLGqjxmR2j439erNP6e4NwsWeLXlU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745395; c=relaxed/simple;
	bh=CaqcchIS7vWPuyiRUVvrGCBHAeNftVlN1fMH/Wy3yl8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZHHpAGhYKDipLqQ8eOvCcfkOPrGmCnN8mnSr3+pON9L23sO8J8bN3Oi3tXNk4+3x42s6OCO9vOe485tISPp8eCJsKDK2waK9Xq2nKFZuntQaXkQf4MsKtUdjdYEZd/ojDrFqUNIBNuOwcyYaWmpM7ZYGBM7uZw/c2rjYZ8XG+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NDIwfGyn; arc=fail smtp.client-ip=40.92.63.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5+dlNaxMIFjVLq1B+OXvvHDZJERLBBU+x5fXhlsKFY8qR4AI0PvU1A/xJ5O3Adx32F+bG0CkDHLGva13C+kVl6BM8CtHO5erxRFUyB5+J2oRhlVO8MB8ea84V/+XapJeBFLnt1EawIwbKdlR0fOwAJvIc20K1XML553KOePztxt/iI+Eq6Hc32Myfcq9EfcEXqaiEC1sS4YATVScZlCtXeeD49ha2ryxmwmv0Q4InPmp4AcxsOYhK4izAVdbbW/jO7zJirtRw9cwFIIvzFlxTHzk1eVbSG3bQKjq5/5lCYvMEopsMDUwYdjjlYGUUkrygdO1UGMu4jRuDmLiEsw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6/dYAXa14MO+Jo44qkQhIwcjCOUfu8aDJ+75bcKS/w=;
 b=n1BCnTrAG2FXLNYZH1SnaeeyoTkcGlFFf7BmmxnbaBm65nx3hhhTQwG1ovBD9qvLn66YuPiJsXTC6dssQFXZo5dniHyC0ACNCWlYYc7LvW/tU8ZuEKk4tV2sCuTnMmGqMZY+/gSuq5dcU+tXJMFd4utcwDaklzBjO7Fftsq9Ii8TH1RIuRNGxzQWd9MTlJXJW9SwpEa9ASlfow/EHeFILmOS7HgjXLZJWAKk8vvWV5yMXr/gIClxVgTuBGBO9LI/viwMXdQUjOmyFybL5oGdVC+BV6RdCloNiNYTT08fHzI1YqIOipq3bufkYT5XLYT9l+NV3+FI2xXwWWsOey4iLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6/dYAXa14MO+Jo44qkQhIwcjCOUfu8aDJ+75bcKS/w=;
 b=NDIwfGyndftoY7smcVboFzwAocnj0f3NkqTOy+RDo+I2aaSUCWhLmng8WRV6yVQdhonRkFdZJftVnqDZhq4xEgiZt5c1OPdOGBzil/9xtMptIVCPC+FYTNVAaeKNAAhYQHrQOqT6GQMHQsT362kXo1VdlBHurn8C8iJGsET1LfHy2ubtfDPliNXpAEZfz6fcSNj7ris+0u02cypMNvPbfAmyXcYHisea3JPBgqhMt9OWqGrYOxtiq9FeZW8qFifD0tjdaf888jB2eE7i35q22RNJNDZef1RyWaaQ/ZPvdNADRH1L5JJxl8RbrMFpEiwipvFBDrXVKsja8LrvPaA4+Q==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY8P282MB4885.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:25c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.11; Mon, 9 Dec 2024 11:56:28 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.8251.008; Mon, 9 Dec 2024
 11:56:28 +0000
Message-ID:
 <MEYP282MB23125E657B3605921535987AC63C2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Mon, 9 Dec 2024 19:56:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] tcp_bpf: fix copied value in tcp_bpf_sendmsg
To: John Fastabend <john.fastabend@gmail.com>,
 Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <20241130-tcp-bpf-sendmsg-v1-2-bae583d014f3@outlook.com>
 <675695f1265b2_1abf20862@john.notmuch>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <675695f1265b2_1abf20862@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <d36f35aa-8223-4b82-af72-3ab7ed41a28a@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY8P282MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8977af11-9ec2-42ff-064b-08dd18488388
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|19110799003|7092599003|6090799003|8060799006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTNQazcwSktxelNwWjJPMEVaUjU3QmdvWWVBbUVvQW9XcXBUeU9nQlhZOEtM?=
 =?utf-8?B?d3pCek5HaUZtUWVDSDVZcGUxSXJIRUo3K0Rac2RSYTR4bW01T25TT25pcFM1?=
 =?utf-8?B?NDI5OURNWFFDTkhiZDI1MFR3ZTJrK2VNRDBqanBIMStkTHRVZStqeGlKMTFN?=
 =?utf-8?B?eG5Ma2hnMFpoUEtBOXJrTEV6UGJrUmY2R1pJQmVLNWJQcjB1cEYvcmtXVDIw?=
 =?utf-8?B?bHNBNzBiWmtQNEx4bnRsV2lZK3E3ZEVTYkVSL1UwNHNpbXM3aDBsOGJIVGRp?=
 =?utf-8?B?eExiMDdZaFprRklFQnlueGlZcjR1L2x2cGRINjN0bjNjSmpucWZsblpmNEUr?=
 =?utf-8?B?QUt3SU52TTRDTXpWSUh2RFh0KzQ0L1Zyc0N0MUM0ZWxMZW5EY0M1MS81a3Jv?=
 =?utf-8?B?YVZjNmFMdDZuTjVubzVweVFUYXFRKzJ5bE80T2JyUE1ZSE9IbVlFUEtvZlZa?=
 =?utf-8?B?MDZ6QXpXLzJhRzExL05GMVUxc3RvVDJWNUx4SUVvN0JpWW1EQm5QVWNobmZa?=
 =?utf-8?B?VzVUUkpOMVJsV01wMWZZK0lEK3RMYUZ3THhZSjZUaXpSdTc0aGptUUp2OFk2?=
 =?utf-8?B?U2EyZWpKMmhoTEFFdi92VFhKNkNjbGtTM3AzR2pIZG5oSG5DVnFaVkIwbWFM?=
 =?utf-8?B?TDRSdEJmSXJSQnpadVU2N2I3YjdWNVNPS3c1RS9memtvL21rOTg1UmI4dE12?=
 =?utf-8?B?NEtmNzdLTXJMVUNYNXFRZnhENVlRQnZWNGJlc0VrOGF6d0tTbUhFZFRucFVw?=
 =?utf-8?B?akxNOGV3T2RUbkVxcHFxbENvNFQxUVNJTHV2NEtRTjgyQjBEY3FOTHNIakVN?=
 =?utf-8?B?aXF3aERRL0ZFQVJSY0dHTWM4YWZacmZoOUkwaU5COVRTOXJ6TGpLOXJ6QXdO?=
 =?utf-8?B?bUJtRUVzMk1HamtrUGdTc28wdlo5OHVWNEs5UlRiOXh6Vkx6S1dnYkNwNnZ3?=
 =?utf-8?B?L2Q3WUlFUFN0Z2JxRy9uWlZtZk1NZWtSeHd5ZkNuWWZXUjZsSTM5aiswNWJs?=
 =?utf-8?B?b2p0NW1OT0VvWTg5ckF2VmgxdFFTQy9yNnRydDNHMzVrcUo3VFFKVXdCT2lX?=
 =?utf-8?B?WWF1bTJ4elhEenRrc0x1YTVGclZyYlY5TlVWcEs5aFNVUFd5ekxDaDYrdyth?=
 =?utf-8?B?S0ZYeU45V0JHSWlkQW9PUlIzR1JPNGtjcEdZUWhpdTNieHlXN1daby9JRWx2?=
 =?utf-8?B?SWN3b0RISGxVcGJXdkpSR1plWnV0ZTJFVFJ6ZExIZzV0enBwdFVUci9QWEJ3?=
 =?utf-8?B?WVJCQ3JEOFBmdTBwYmgyNkJWTmRHT25uTzB6OFlGL1RXOFFWV0lFQXUrTjZU?=
 =?utf-8?B?aGJ4T1UvREUraXVIVUFtWVZKVzVHOEhVU3FUNzJTeTRHcFZHemhudmxmNTFp?=
 =?utf-8?B?T25uNHBQNklBODJFbGFJMVRvb2RhcWdlYkdER1duclpwMkowL0Ura2FSRE5i?=
 =?utf-8?Q?HzJHfImg?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3JwUThtQ3h4SitaRWNqTXErY3FtejducXp1Ui8rQXpiVC9QTUp4MUV2OHlp?=
 =?utf-8?B?cFJ1UitLR2VobmxVMEFFLzF4b0NKVWxsbDBoaUZzN3g2RzBTZDhFekhtaXVk?=
 =?utf-8?B?cTduSFBKMkNoMGo2RDBqcy95MlFRbUVnSlVNTnhyN2xqTkFJamVuR0NsTFoy?=
 =?utf-8?B?azk3dUZnLzV6SmpiU1VWT2VjM3h0V3ZUWnRaY0VzalFjSEttR1Nkb3d4VDZa?=
 =?utf-8?B?U01ta2dnNkJMZVJWZkw4N1FBdW03d3p6Y0t4NFZza0kvSzEySG1rSi9RbHVO?=
 =?utf-8?B?QjBjdWhGRDFLS0d0UzcxK3Q4dksrNTBlUzVFV0NranhOVXY3aHJHMFFuejRo?=
 =?utf-8?B?Rk9oZ3hUYVJIOWFRSC8wcGltZ0NWeGtqalZiK25EaExEWEdKeGQ4cWhBOG9U?=
 =?utf-8?B?cHFCMUtkS0JvcWRQV0xudk90SUgrYTlIWURzNDdWdWowdngyQWRWbE15RHFG?=
 =?utf-8?B?enJSeXJQeVJlSStZWmFOT25NV0lmbkdCc29EVXRQdlNkYi9PZGcxcnpKY0I4?=
 =?utf-8?B?Y2pxRHJLUTlCWWZlaGd1Z01CWk1nb3hCdDE2dEM5MW5GWTZWMTlRd0ptcVps?=
 =?utf-8?B?SE1CWittTVhwTWRnYjdDbmRuVXJnNks0Z2QvMmdyMExmK2RyZEFIa1B5amdL?=
 =?utf-8?B?b3g4Q2F2cFVzeVRsZVNKOGp2b3diMzdmMzhyemEwb25rd09XSkkyWUd1eUMz?=
 =?utf-8?B?NVZUaWUwalp1bTdHNE50RXpyby8xNmhPanBQRjZGMEJRL2RBV1lnVzE4RDRr?=
 =?utf-8?B?VS92bVlpbkxxcEVqTmZPelZZQnBZNnFhZkNVMXNaaWphcjFkY29UVVBEL0xF?=
 =?utf-8?B?cnlmQi8xdDZ0d1owaGtYNXNYQjMrSG1aRGc1RG04VFk3ZFBBdDZoaXZNNi9s?=
 =?utf-8?B?N0ZIc1lLU2pGVlBOelpaSGZ1eDVDdE9zeDJWV201WU0zV3BSSndtV1o1WUxo?=
 =?utf-8?B?dUt3RkpRQm85eXlRcVkxTU9GL0Y1WHdWK3J5QUxCdWx1Y29uVE1IL0J2SzdB?=
 =?utf-8?B?R3FaR3RKdHlha2tlZ3p6K1JXREhoL0MxV2JubzlCVHNrVHQvd3pXNEdjNllO?=
 =?utf-8?B?MjhsajhOQWtmYkJaK2ZLd1lhK1lCbTdWaWc3MFlTVGxOWTFidWtqRHRodmJH?=
 =?utf-8?B?bTlQZExPM1ZvR3Fla1NGVkM2TWQyVjhCOWNTUVMvUytqVEc5S29CN1VQMGpP?=
 =?utf-8?B?cit3TzBHNnVJbUFEbzJXMER2L3pDbzk2ZVJOei9QejdyR2pkUWFTaG9xR01T?=
 =?utf-8?B?ZWx0MVlGZExyaDN4M0taaURaZE5XREFyaGl6TTVwa1lBK2FFeVVJQVdlTTVy?=
 =?utf-8?B?K2JxOXVyZTBLWWVkUUdVNWFmakZ3QlFKQndkK3ljY1FzTUlweDREbmtPOGZC?=
 =?utf-8?B?QnRscmx6Tk9vMVNKbExHcTZwaklaVndzZURESUVCajlDclBBYTVDOEd3bUNr?=
 =?utf-8?B?L21IdzU4VlY3RFBvTWgvMTJ3OEhyQUVFNkRpbkUxaTh1UWhMSGNuNWNDbzhu?=
 =?utf-8?B?L1hQdHdFVUtybzUvWjJhS3NMdkdPZFZheGg1SFJtb2ZSLzdlU3FuWkcyaG9r?=
 =?utf-8?B?dDlNOFdIODRHUi9XTkx2T1hTeDdjREMwVHhoZ2tpZllQeWFEQzhRZ0NFSkRl?=
 =?utf-8?Q?kU6ZOFIXLF+Is9FWS4ehykPVhBVB92H8h+s/lZut+XXo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8977af11-9ec2-42ff-064b-08dd18488388
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:56:28.4005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB4885

On 2024-12-09 15:02, John Fastabend wrote:
> Levi Zim via B4 Relay wrote:
>> From: Levi Zim <rsworktech@outlook.com>
>>
>> bpf kselftest sockhash::test_txmsg_cork_hangs in test_sockmap.c triggers a
>> kernel NULL pointer dereference:
> Is it just the cork test that causes issue?
Yes. More specifically only "sockhash::test_txmsg_cork_hangs" but not 
"sockmap::test_txmsg_cork_hangs"
>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>>   ? __die_body+0x6e/0xb0
>>   ? __die+0x8b/0xa0
>>   ? page_fault_oops+0x358/0x3c0
>>   ? local_clock+0x19/0x30
>>   ? lock_release+0x11b/0x440
>>   ? kernelmode_fixup_or_oops+0x54/0x60
>>   ? __bad_area_nosemaphore+0x4f/0x210
>>   ? mmap_read_unlock+0x13/0x30
>>   ? bad_area_nosemaphore+0x16/0x20
>>   ? do_user_addr_fault+0x6fd/0x740
>>   ? prb_read_valid+0x1d/0x30
>>   ? exc_page_fault+0x55/0xd0
>>   ? asm_exc_page_fault+0x2b/0x30
>>   ? splice_to_socket+0x52e/0x630
>>   ? shmem_file_splice_read+0x2b1/0x310
>>   direct_splice_actor+0x47/0x70
>>   splice_direct_to_actor+0x133/0x300
>>   ? do_splice_direct+0x90/0x90
>>   do_splice_direct+0x64/0x90
>>   ? __ia32_sys_tee+0x30/0x30
>>   do_sendfile+0x214/0x300
>>   __se_sys_sendfile64+0x8e/0xb0
>>   __x64_sys_sendfile64+0x25/0x30
>>   x64_sys_call+0xb82/0x2840
>>   do_syscall_64+0x75/0x110
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
>> size (8192), which causes the while loop in splice_to_socket() to release
>> an uninitialized pipe buf.
>>
>> The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
>> will copy all bytes upon success but it actually might only copy part of
>> it.
> The intent was to ensure we allocate a buffer large enough to fit the
> data. I guess the cork + send here is not allocating enough bytes?
I am not familiar enough with neither this part of code nor tcp with bpf 
in general and just
hit this bug when trying to run the bpf kselftests. Then I decided to 
debug it.

In my perspective the buffer(8192) is large enough to hold the data(8192),
but tcp_bpf_sendmsg returns 12289 which is a little surprising for me.

Could you further elaborate why 8192 bytes are not enough? Thanks!

>> This commit changes it to use the real copied bytes.
>>
>> Signed-off-by: Levi Zim <rsworktech@outlook.com>
>> ---
>>   net/ipv4/tcp_bpf.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index 370993c03d31363c0f82a003d9e5b0ca3bbed721..8e46c4d618cbbff0d120fe4cd917624e5d5cae15 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -496,7 +496,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>>   static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>>   {
>>   	struct sk_msg tmp, *msg_tx = NULL;
>> -	int copied = 0, err = 0;
>> +	int copied = 0, err = 0, ret = 0;
>>   	struct sk_psock *psock;
>>   	long timeo;
>>   	int flags;
>> @@ -539,14 +539,14 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>>   			copy = msg_tx->sg.size - osize;
>>   		}
>>   
>> -		err = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
>> +		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
>>   					       copy);
>> -		if (err < 0) {
>> +		if (ret < 0) {
>>   			sk_msg_trim(sk, msg_tx, osize);
>>   			goto out_err;
>>   		}
>>   
>> -		copied += copy;
>> +		copied += ret;
>>   		if (psock->cork_bytes) {
>>   			if (size > psock->cork_bytes)
>>   				psock->cork_bytes = 0;
>>
>> -- 
>> 2.47.1
>>
>>
>

