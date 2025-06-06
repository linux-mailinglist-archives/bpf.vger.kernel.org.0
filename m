Return-Path: <bpf+bounces-59977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93BAD0A57
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75271892143
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625323E35E;
	Fri,  6 Jun 2025 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JnhmONAc"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F423C8D6
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253080; cv=none; b=b98P0N7Gucbggfq/yczzSqHsRajzEBDTgcXeSytpPJrFx4uW9yMuYquNYJE58bQ2FesQ1uMH2JQFaYvzVCigM40gtKYMh/ZrJSqIPb/vHYQ8ktzqKkSR/bpVPFr5rhuJrBKpOX7eFLTQuy6QRNIzTHBw/tTg/D8EFMFUMlRmN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253080; c=relaxed/simple;
	bh=psVyqdZcdadUDeXo2L2vf8zhz5m0Q4rIvhNc0QlEOis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrCvaVSdix6Ex2Fq1uPDrjkusmS5qqbuX2MRyXyIcEUgaNOjh3FV0zscFbYne2Ee3q1Sd2BbRP/V2r4hvjSKCxMgEqmR7mMM9xEtPrrKI5RzKgJgAMxFQRtjBW5Zex+qC8Jh56ee4l0MtlrrBkkECzTEBVWtvM41OA4DnRMGi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JnhmONAc; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e0d243a-f769-464c-ab58-49e94e52611d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749253076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaOIc/GXR8yX/lgFfWAQeH1yEQC0VKE5Ux2tGZZ9k2w=;
	b=JnhmONAc9rfKb8cxLPAxjRww2GmQGjTYz2OZhTu/FXMUzSnEPVKdL4G0QP4g14g12dTTXX
	cEGYXqjLkP4Z7ONOwZjFhMSxI7LdpQjdgeD0RLRpHMqD7KjIWIaOcXTKF7CMzNfNB/BOqr
	ZWUHTJ4cTCsPmUjCDv4C2dNJWYR3Tic=
Date: Fri, 6 Jun 2025 16:37:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with
 CONST_PTR_TO_MAP null checks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kernel Team <kernel-team@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-3-isolodrai@meta.com>
 <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
 <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev>
 <CAADnVQJ-sxOEdzy7OktZrTUDxk7Rw7H3zCt_u+iM987zTTDksw@mail.gmail.com>
 <8c24eae8-a932-4c1d-87ec-c5f8ef8fdf79@linux.dev>
 <CAADnVQKwekQ61umAokC09OB+ao5T4E_yg_cLgzVEUtCtFwo=0Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKwekQ61umAokC09OB+ao5T4E_yg_cLgzVEUtCtFwo=0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/5/25 5:25 PM, Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 4:40 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 6/5/25 10:00 AM, Alexei Starovoitov wrote:
>>> On Thu, Jun 5, 2025 at 9:42 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
>>>>> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> +SEC("socket")
>>>>>> +int map_ptr_is_never_null(void *ctx)
>>>>>> +{
>>>>>> +       struct bpf_map *maps[2] = { 0 };
>>>>>> +       struct bpf_map *map = NULL;
>>>>>> +       int __attribute__((aligned(8))) key = 0;
>>>>>
>>>>> aligned(8) makes any difference?
>>>>
>>>> Yes. If not aligned (explicitly or by accident), verification fails
>>>> with "math between fp pointer and register with unbounded min value is
>>>> not allowed" at maps[key]. See the log below.
>>>
>>> It's not clear to me why "aligned" changes code gen,
>>> but let's not rely on it.
>>> Try 'unsigned int key' instead.
>>> Also note that &key part pessimizes the code.
>>> Do for (...; i < 2; i++) {u32 key = i; &key }
>>> instead.
>>
>> I've tried changing the test like this:
>>
>> @@ -144,12 +144,12 @@ int map_ptr_is_never_null(void *ctx)
>>    {
>>           struct bpf_map *maps[2] = { 0 };
>>           struct bpf_map *map = NULL;
>> -       int __attribute__((aligned(8))) key = 0;
>>
>> -       for (key = 0; key < 2; key++) {
>> +       for (int i = 0; i < 2; i++) {
>> +               __u32 key = i;
>>                   map = bpf_map_lookup_elem(&map_in_map, &key);
>>                   if (map)
>> -                       maps[key] = map;
>> +                       maps[i] = map;
>>                   else
>>                           return 0;
>>           }
>>
>> This version passes verification independent of the first patch being
>> applied, which kinda defeats the purpose of the test. Verifier log
>> below:
>>
>>       0: R1=ctx() R10=fp0
>>       ; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c:143
>>       0: (b4) w1 = 0                        ; R1_w=0
>>       ; __u32 key = i; @ verifier_map_in_map.c:149
>>       1: (63) *(u32 *)(r10 -4) = r1
>>       mark_precise: frame0: last_idx 1 first_idx 0 subseq_idx -1
>>       mark_precise: frame0: regs=r1 stack= before 0: (b4) w1 = 0
>>       2: R1_w=0 R10=fp0 fp-8=0000????
>>       2: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
>>       3: (07) r2 += -4                      ; R2_w=fp-4
>>       ; map = bpf_map_lookup_elem(&map_in_map, &key); @
>> verifier_map_in_map.c:150
>>       4: (18) r1 = 0xff302cd6802e0a00       ;
>> R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
>>       6: (85) call bpf_map_lookup_elem#1    ;
>> R0_w=map_value_or_null(id=1,map=map_in_map,ks=4,vs=4)
>>       ; if (map) @ verifier_map_in_map.c:151
>>       7: (15) if r0 == 0x0 goto pc+7        ; R0_w=map_ptr(ks=4,vs=4)
>>       8: (b4) w1 = 1                        ; R1_w=1
>>       ; __u32 key = i; @ verifier_map_in_map.c:149
>>       9: (63) *(u32 *)(r10 -4) = r1         ; R1_w=1 R10=fp0 fp-8=mmmm????
>>       10: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
>>       11: (07) r2 += -4                     ; R2_w=fp-4
>>       ; map = bpf_map_lookup_elem(&map_in_map, &key); @
>> verifier_map_in_map.c:150
>>       12: (18) r1 = 0xff302cd6802e0a00      ;
>> R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
>>       14: (85) call bpf_map_lookup_elem#1   ;
>> R0=map_value_or_null(id=2,map=map_in_map,ks=4,vs=4)
>>       ; } @ verifier_map_in_map.c:164
>>       15: (b4) w0 = 0                       ; R0_w=0
>>       16: (95) exit
> 
> because the compiler removed 'if (!maps[0])' check?
> Make maps volatile then.

Making maps and/or map volatile didn't help.

> 
> It's not clear to me what the point of the 'for' loop is.
> Just one bpf_map_lookup_elem() from map_in_map should do ?

No. Using an array and loop was my attempt to put map_ptr on the
stack. But apparently this was not the reason it happened in the v1 of
the test.

> 
>>
>> If map[i] is changed back to map[key] like this:
>>
>>          for (int i = 0; i < 2; i++) {
>>                  __u32 key = i;
>>                  map = bpf_map_lookup_elem(&map_in_map, &key);
>>                  if (map)
>>                          maps[key] = map; /* change here */
>>                  else
>>                          return 0;
>>          }
>>
>> Verification fails with "invalid unbounded variable-offset write to
>> stack R2"
> 
> as it should, because both the compiler and the verifier
> see that 'key' is unbounded in maps[key] access.
> 
>>       __u32 __attribute__((aligned(8))) key = i;
>>
>> but that puts us back to square one.
>>
>> It appears that alignment becomes a problem if the variable is used as
>> array index and also it's address is passed to a helper.
> 
> I bet this alignment "workaround" is fragile.
> A different version of clang or gcc-bpf will change layout.

I agree, it's fragile.

After I fought compiler/verifier for a while I gave up and wrote a
test in asm:

     SEC("socket")
     __description("map_ptr is never null")
     __success
     __naked void map_ptr_is_never_null(void)
     {
     	asm volatile ("					\
     	r1 = 0;						\
     	*(u32*)(r10 - 4) = r1;				\
     	r2 = r10;					\
     	r2 += -4;					\
     	r1 = %[map_in_map] ll;				\
     	call %[bpf_map_lookup_elem];			\
     	if r0 != 0 goto l0_%=;				\
     	exit;						\
     l0_%=:	*(u64 *)(r10 -16) = r0;				\
     	r1 = *(u64 *)(r10 -16);				\
     	if r1 == 0 goto l1_%=;				\
     	exit;						\
     l1_%=:	r10 = 42;					\
     	exit;						\
     "	:
     	: __imm(bpf_map_lookup_elem),
     	  __imm_addr(map_in_map)
     	: __clobber_all);
     }

What must happen to reproduce the situation is: map_ptr gets on a
stack, and then loaded and compared to 0.

It looks like I accidentally forced map_ptr on the stack by using
`key` both for map lookup and array access, which triggers those
alignment problems. Without that I wasn't able to figure out simple C
code that would produce bpf with map_ptr on the stack (besides the
other test, with rbs).

I guess I should've written an asm test right away.


