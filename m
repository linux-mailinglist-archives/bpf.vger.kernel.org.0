Return-Path: <bpf+bounces-36147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1C9430D3
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB901F248A0
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666AD1B29C8;
	Wed, 31 Jul 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A1UDS5D/"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012028.outbound.protection.outlook.com [52.103.32.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32401A8BEB;
	Wed, 31 Jul 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432540; cv=fail; b=oIMvST/qeDdyyAprr/weM3F5INkckIx9DpsLamg0/gQ6JFMhQOr0xPemWkNUfQBtPGVG0hywW7Uhqe+tixz0aimWi1KETMR0za7Scy8jI7uSFjBzedavAgU9F77iYh/jKmLYFMtLk2dpNqEIi5rKtjSNT9/Nesxkit8oAwXke/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432540; c=relaxed/simple;
	bh=Z9EqFvXSnb8Li3NMnl1QiMoVZcQPzvsGrbvUzHDVLno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JfF/uJiDCWyih7FcI4pIgsBSUOPWGZusQkf9r/gvowdYbYg42+VVmjCGS7eDhqWbMHTcofjFTqtENFKwb54nOz7qOmSktrM+j/GwiyttduINow0PtyCBTFSG2s5V4Cn2y5JikKd6GLa397timc6oRg1GAi6aq8cmHDxmgiYTLoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A1UDS5D/; arc=fail smtp.client-ip=52.103.32.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IppJ9p2NNWedwjIDY47XVii8zyL+KiG+qEi8V813PGQsyi2MTYcbICV9RGP8ZCj2Rhj4f6zvgJ4emqQdfzoeiM1XGOh45whIyMPNNGLv1x0dajbBvfeNHb6RRzch3l/7vap+ADIHDt+BtDA7xHFAAEGHLGzEAytjGehbsyip/u/aOeaNrEUW97eFUqgv1go3Y775ELOiB5D5fssc3tOQKFz77ZSXW4j3rTnnLkAMamBzkun6mysz9j/XArmzj8edgt2/xMC04w6bRH4LRAjBarcZFYwzO25wcMcd/eyVfv1DtzjBUsrTweqYeSNmgAYRFvC0z7FPLbkIqR8SleziqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qc37iZ5CFCDL+1QuPVQyoQDuZvLmBspHot7hCDbpS0=;
 b=w9JFuJvOy4hkk0pEW18ce4in55GPbyMJahlpxgH1Fs8rz+RYGWcn9IB7uiUi0s58NACpi2Ps9qtaCS7l1pqMXgZwoMkU3bLMXtkWyt7i9S0TN72eHT283OMQI9LNS7NzJELb5Hmqb/NlN0cjGRncWBvEUizb98tLlVQj3fHXsbNrEDB808V/ohDdPh3maTpAQgzM2HyxW4Ef7aMW4kmnRhubEseqGWCaxRtdd5Tk2QGzpKD5smjpqfAdsFDhBFfkgCJi42sEhqq/KGlp/9bn7bfGEWrJl1KKLfUoMO4vvS1YkX4f+r50ycRv1hO2KBrnuNFJBnyfC0Ui5LKkOIDjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qc37iZ5CFCDL+1QuPVQyoQDuZvLmBspHot7hCDbpS0=;
 b=A1UDS5D/DuID9ez87BZjcs//JJRDXnVZujbU+hgy5O0dS1VcDbfESo/6p89SlVG8ENUMpn2VCFvU+mv3OXF0uP8bDbEue2dh8HRpOR6eoOCSHdF41ZumC0ZyBIRyl4GmVWMXKfiiZolHI8KmfHapx8uVw8J3uGOGadW8KFiiYiUy1HwQsgriEM5f8Y45+2A9vKam60NeS0jjHshXgo6aBUbxAAzpbB4jprBxjYdK2g88B8xn2ynHPY+qKm0dVxEbz9/cYr0K0sWOSRvGZNgwEKy1Cs4qwjwFj7PE872YQ+zNQYVnetSRuMOYYJQwOc3YWmWOnG+I28A8HNWRj/1J/A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM9PR03MB6980.eurprd03.prod.outlook.com (2603:10a6:20b:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:28:56 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:28:56 +0000
Message-ID:
 <AM6PR03MB5848CA39CB4B7A4397D380B099B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 31 Jul 2024 14:28:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next RESEND 03/16] bpf: Improve bpf kfuncs pointer
 arguments chain of trust
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com,
 snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB58488FA2AC1D67328C26167399A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAP01T74pq7pozpMi_LJUA8wehjpATMR3oM4vj7HHxohBPb0LbA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAP01T74pq7pozpMi_LJUA8wehjpATMR3oM4vj7HHxohBPb0LbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [KAi4D+1FdzRB6aqZINqFD4Xdq64djK49]
X-ClientProxiedBy: CYZPR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:930:8d::18) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <329e4d58-b4f1-41af-81bd-211f695045fe@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM9PR03MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1917b4cc-0083-477e-c4ba-08dcb164ba44
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	ME+j/Z8qDFaYEEwEfVfa5pUGJyNX+MgU85PsMOPCSIBmQQoOTR77VSuG/6eERB9VL0tqdYCaFuoX0exVFjWT2K5fIU0M8OsMiN2hWeQ7ErDGz05s38AYNHrXdZXw0/kGEbIvzKJmC6SqEu6pApxMPhQyFRFWRko/Vra70AGp6wY0VDhTF+HWM7RVHYbfQHACy6YgDockjdF7ekBaVp9wEu6REQgvRcOy38Fpvl/eK2gIADbACp7F2+A/KazQ+ADp7swwFAdgAzTyHTuYyK16qi1yXzFb8oMk85dk7ex0JNlWSigpHYHryagFpIi3OFiol8F6DY3A2khFXsbjNi+wvz8L5N5cpZKdIUPbNuDFtvlAbimOxDUxpAZkSjmNpXU9Jz5AY5yXIEk4MgewTCzjwR+3UlErHwXcNolaX7ODZ0RDgGCXQZ4gJFzGHvdVZZ+ZvQG8BX1zvb7VnWwEzbCRRc8fdVQ5/fbWtZphK9kGIHtZUnindcbz3VK8o1y6HChZSrq3T3BVkLND7g9IpbEXILNC6+vj5PFM61wxrrD2w6XHDlf76EXpCbtkMv3jnNIwik3YyI8KlcElK9G1yenGZQY+T0RXhIu1xn/NMOxZV3AURjtX066DUX4WpMAKae4Iv0X2Y7sosjtEUBbAGpuyra51ufJ4ZjaJs+HNcja4d0JU3Ev/jbnSnSqtOEJ95jtm9gwc4p2tsHEa/arJFkiIxlyEXl+u6Jz+MTRrC+swp4gqDWDeHk+kT+icxZSDBIZRy5E8v5pDOsFVK3eAWHf/s7B4rKFj/YySmO/VCfmt/zA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDNmbnRyK3dyWHhIRDZsc05IUkRIWU8wdmM5eG01cnBINXlueTV4MVBzZDJI?=
 =?utf-8?B?bGk3Z1Q4TzNqa0NBdTBoaXF5a1ZKb3FvSlJ5S28wWi9aVEJ4STFUZlQ3UW96?=
 =?utf-8?B?Q0hWcGRxbGhBKzNGTFVxNk9lUkJsbStsRStJMVBzZlppQ2ZTbTQwWWRiUGVY?=
 =?utf-8?B?cmJiSlZjUlBpejRna0NUbGYweUYvbHBEeWhIUXR3Q1BDcTc5UkdsSEh2d1VJ?=
 =?utf-8?B?OW1WSEwzbE1Zb2hpWnpGTGY1WVdiVDVZT3JXa3FsUVRHbDRoclFENnBFN2JZ?=
 =?utf-8?B?UFZlRm9JZVJLUk8yTGlLdUVlVFJCU0R6WGljNXAxN1Bwa0puaEYzZ250Y09B?=
 =?utf-8?B?cS91YWdoNVQ2RERUcU1iVDY3Mzc0T3JhNXNJakZaRGJHeWMrVmFsSjhwdzZY?=
 =?utf-8?B?c0JWZER0aVdkZlh1WGJrMGVBLzhhSk5pZkIzNUlRRmZZWnZUZXUvcWM2QkU1?=
 =?utf-8?B?SENKT243SEx0RXB0YXh3VFQ5RkdPWFQ2V2t3aHh4aE1WN2wxL0M5V2IwQWZJ?=
 =?utf-8?B?SjVoSUVzdm9RM2UrUTR4Umo0TmRYL0tWTStIOXpJckd3ZzlUKzU4KzBwdHAz?=
 =?utf-8?B?OG5UZVNxdGN5R216ZE5wTnJqVit6ODRhYUVnMHBnYkpFZDlPd1E0K3RnRk9k?=
 =?utf-8?B?YTlLRUovcVlxaEFVWUljcldjRW9tQ3loVmhkeDRHZVByb292Tmd5SnF3bnVR?=
 =?utf-8?B?Y0sxR253enRxYnliaDFqVFZWaXRobll5ck1rUGs4MUpYZU5YcWh6ME50RUNV?=
 =?utf-8?B?UkVyMjcwNDdmODRuR1Z4UlhiQ2NRbTV6bU4vSXJGM0w4QWtyTzdTemNxSnNt?=
 =?utf-8?B?bjhmVC92Tmx5WDFKRDZ2VFBpRVNyTUplNXR1ekVkTUNLQkYwQ1c5SzNMTDFJ?=
 =?utf-8?B?VUQ1QjhQTFlEUWlZUTNQZTc0U3ZSOWM4c2tXRjRzZVcxOXlHMm5vN09zT3NL?=
 =?utf-8?B?NHAxQVRNc3psNUlvbVFjSll1d0xSRzhFV0Y5cCsrR1FkSUc4Z044WGpSdUJj?=
 =?utf-8?B?YkdmdXE2Vy9NVXJtR2lPM2pURUd0M3k2U0I3ejVWRVJ1UWVaVjZCZGgzSjBt?=
 =?utf-8?B?dE9xb0JpUkRtREthckc3TGd4TzdtOTNEUDYzSC9LSktFdWJmZjBWbG9CQmhs?=
 =?utf-8?B?U0xxTkh6MHoyQkw0SXk5OVE5MGZTR0xBV1VrajNqOUJVbnRia3lYUk5kdkYw?=
 =?utf-8?B?Q0x1TEh3RjhyR2NubDBmZTRMRFd0QkViVllxOEtpVTZZMEJ6aVR2ZVZKQzZ6?=
 =?utf-8?B?UytWbWFUdTRBM1BTc3VqUWlJd3JBNXlGSVVPRU1JRG00QzlKd1VFaHdGcWpN?=
 =?utf-8?B?bmxhS1BiY0RadkFpME5NL0ZPdlNlcHFVU29ieFh1WGRrdDA3RDFYd2pDT292?=
 =?utf-8?B?SkRLVkJZUlBsZmFyS09iWFJ1Vm1XUnVRTjVZQ0lOR1VGaGNZQ1JDRUR2c1Ru?=
 =?utf-8?B?TEZuN1A1bnIxb0J2Mi8wVjNqeU9NN1VHY3hYR0pGZEkvdjNHT0hyWlh6WkxO?=
 =?utf-8?B?K2tHSHV0ai9ueDEwUjBCQXZoOEhFaWRXWVFYdkUwTFQrNTRRNm94MGVzenJa?=
 =?utf-8?B?RW1LbGsyTGFjcEd0UitDR21LeXlkelMvY1NjWlkwVlBtbGxORlZuWVFmSjBj?=
 =?utf-8?B?UXI0SnJSQTdheVgza2NZZ2szN0czb3lLYlhOSG1hV25uc3U3S2xjY3dwT1N2?=
 =?utf-8?Q?+hTmFL0JJLPM2My3GQKe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1917b4cc-0083-477e-c4ba-08dcb164ba44
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:28:56.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6980

On 7/23/24 01:20, Kumar Kartikeya Dwivedi wrote:
> On Thu, 11 Jul 2024 at 13:26, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently we have only three ways to get valid pointers:
>>
>> 1. Pointers which are passed as tracepoint or struct_ops
>> callback arguments.
>>
>> 2. Pointers which were returned from a KF_ACQUIRE kfunc.
>>
>> 3. Guaranteed valid nested pointers (e.g. using the
>> BTF_TYPE_SAFE_TRUSTED macro)
>>
>> But this does not cover all cases and we cannot get valid
>> pointers to some objects, causing the chain of trust to be
>> broken (we cannot get a valid object pointer from another
>> valid object pointer).
>>
>> The following are some examples of cases that are not covered:
>>
>> 1. struct socket
>> There is no reference counting in a struct socket, the reference
>> counting is actually in the struct file, so it does not make sense
>> to use a combination of KF_ACQUIRE and KF_RELEASE to trick the
>> verifier to make the pointer to struct socket valid.
> 
> Yes, but the KF_OBTAIN like flag also needs to ensure that lifetime
> relationships are reflected in the verifier state.
> If we return a trusted pointer A using bpf_sock_from_file, but
> argument B it takes is later released, the verifier needs to ensure
> that the pointer A whose lifetime belongs to that pointer B also gets
> scrubbed.
> 

Thanks for your review!

You are right, I will fix this problem in the next version of the patch.

>>
>> 2. sk_write_queue in struct sock
>> sk_write_queue is a struct member in struct sock, not a pointer
>> member, so we cannot use the guaranteed valid nested pointer method
>> to get a valid pointer to sk_write_queue.
> 
> I think Matt recently had a patch addressing this issue:
> https://lore.kernel.org/bpf/20240709210939.1544011-1-mattbobrowski@google.com/
> I believe that should resolve this one (as far as passing them into
> KF_TRUSTED_ARGS kfuncs is concerned atleast).
> 

Thanks for letting me know.

I tested it and it works well in most cases, but there are a few cases
that are not fully resolved.

Yes, the verifier has relaxed the constraint on non-zero offset
pointers, but the type of the pointer does not change.

This means that passing non-zero offset pointers as arguments to kfuncs
with KF_ACQUIRE will be rejected by the verifier because KF_ACQUIRE
requires strict type match and casting cannot be used.

An example, bpf_skb_peek_tail:

# ; struct sk_buff *skb = bpf_skb_peek_tail(head);
@ test_restore_udp_socket.bpf.c:209

# 75: (bf) r1 = r2                      ;
frame2: R1_w=ptr_sock(ref_obj_id=6,off=168)
R2=ptr_sock(ref_obj_id=6,off=168) refs=4,6

# 76: (85) call bpf_skb_peek_tail#101113
# kernel function bpf_skb_peek_tail args#0 expected pointer to
STRUCT sk_buff_head but R1 has a pointer to STRUCT sock

Should we relax the strict type-matching constraint on non-zero offset
pointers when used as arguments to kfuncs with KF_ACQUIRE?


In addition, this method is not portable (such as &task->cpus_mask),
and the offset of the member will change once a new structure member
is added, or an old structure member is removed.

Now that we have relaxed the constraints on non-zero offset pointers,
this method will probably be used a lot, maybe we could add a
BPF_CORE_POINTER macro to get a pointer to a struct member?
(Different from BPF_CORE_READ, which is reading member contents)

For example, BPF_CORE_POINTER(task, cpus_mask), which is a simple
user-friendly wrapper for __builtin_preserve_access_index.

>>
>> 3. The pointer returned by iterator next method
>> Currently we cannot pass the pointer returned by the iterator next
>> method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
>> returned by the iterator next method is not "valid".
> 
> This does sound ok though.
> 
>>
>> This patch adds the KF_OBTAIN flag to solve examples 1 and 2, for cases
>> where a valid pointer can be obtained without manipulating the reference
>> count. For KF_OBTAIN kfuncs, the arguments must be valid pointers.
>> KF_OBTAIN kfuncs guarantees that if the passed pointer argument is valid,
>> then the pointer returned by KF_OBTAIN kfuncs is also valid.
>>
>> For example, bpf_socket_from_file() is KF_OBTAIN, and if the struct file
>> pointer passed in is valid (KF_ACQUIRE), then the struct socket pointer
>> returned is also valid. Another example, bpf_receive_queue_from_sock() is
>> KF_OBTAIN, and if the struct sock pointer passed in is valid, then the
>> sk_receive_queue pointer returned is also valid.
>>
>> In addition, this patch sets the pointer returned by the iterator next
>> method to be valid. This is based on the fact that if the iterator is
>> implemented correctly, then the pointer returned from the iterator next
>> method should be valid. This does not make the NULL pointer valid.
>> If the iterator next method has the KF_RET_NULL flag, then the verifier
>> will ask the ebpf program to check the NULL pointer.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
> 
> I think you should look at bpf_tcp_sock helper (and others), which
> converts struct bpf_sock to bpf_tcp_sock. It also transfers the
> ref_obj_id into the return value to ensure ownership is reflected
> correctly regardless of the type. That pattern has a specific name
> (is_ptr_cast_function), but idk what to call this.

Thanks for mentioning this part of the code!

I tried it, it was very helpful.

After setting ref_obj_id, once pointer A (passed into KF_OBTAIN kfuncs)
is released, then pointer B (returned from KF_OBTAIN kfuncs)
becomes invalid.

I will include this fix in the next version of the patch.

