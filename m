Return-Path: <bpf+bounces-59772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880BACF48F
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56A27AB1E9
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587223E33A;
	Thu,  5 Jun 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZxHdXRe"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32C205ABB
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141753; cv=none; b=e2XgS9UugRavy467yBXE/kXvlKcMPzwlFxR7jWIASQAKJ8/n5zdb1cm7h1TdX751JZZxIks646448BeFE9AibalfATJAZZOUddWNgQaXCCFHV5FXhS2AM/FeJ/SvFdVoZXGtSRTejlH9JGmxwCb217PeZOs82WtRjq46Zh4vXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141753; c=relaxed/simple;
	bh=3p4NDD4qsdHm77iMEAyMcpa19nQiSpr49sqQb1zGcv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdB8kAQi4Cek+O4aStRjyLkjZBTaJ1YIFKegGjiMvPWYzruruGP66lWnICR0Yy1GSjX/18uE410zs+5AfDVML9NreN257n1ZKcESZStdYgHugGbvhJoQbUircfL++0Dq92oSmZ9SXw75x94Jsn1hX1dLExkxXo/uqRFtGdr8iDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZxHdXRe; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8df5f5d4-cafe-477b-b0cf-7c86117f21cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749141748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIHT7f3QF62q2s4ACYZC273GDztXH+8QEQ7IIbnvj7k=;
	b=MZxHdXReRCzm49ucYAWlUKObK5qgEGKskgWlJ0L++4H8zYz3bXQ6UGL+wSCjDOWKHPN7Tx
	ROYO1v1Cjmbax9OP8oe+rkROGsN1LZgwVMpAL380XITczN9HSl7q/1+vQRgS1ETlLKPIxl
	JaEUZENelaGUQfqZZGAEL9AEKcTIiw4=
Date: Thu, 5 Jun 2025 09:42:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases with
 CONST_PTR_TO_MAP null checks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 yonghong.song@linux.dev, kernel-team@meta.com
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-3-isolodrai@meta.com>
 <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bzae53DDPQYUwOC2w=LO1yxPMU2=vDoS7=rCSv1BkcsJ5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/5/25 9:24 AM, Andrii Nakryiko wrote:
> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>
>> A test requires the following to happen:
>>    * CONST_PTR_TO_MAP value is put on the stack
>>    * then this value is checked for null
>>    * the code in the null branch fails verification
>>
>> I was able to achieve this by using a stack allocated array of maps,
>> populated with values from a global map. This is the first test case:
>> map_ptr_is_never_null.
>>
>> The second test case (map_ptr_is_never_null_rb) involves an array of
>> ringbufs and attempts to recreate a common coding pattern [1].
>>
>> [1] https://lore.kernel.org/bpf/CAEf4BzZNU0gX_sQ8k8JaLe1e+Veth3Rk=4x7MDhv=hQxvO8EDw@mail.gmail.com/
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   .../selftests/bpf/progs/verifier_map_in_map.c | 77 +++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
> 
> LGTM overall
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
>> index 7d088ba99ea5..1dd5c6902c53 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
>> @@ -139,4 +139,81 @@ __naked void on_the_inner_map_pointer(void)
>>          : __clobber_all);
>>   }
>>
>> +SEC("socket")
>> +int map_ptr_is_never_null(void *ctx)
>> +{
>> +       struct bpf_map *maps[2] = { 0 };
>> +       struct bpf_map *map = NULL;
>> +       int __attribute__((aligned(8))) key = 0;
> 
> aligned(8) makes any difference?

Yes. If not aligned (explicitly or by accident), verification fails
with "math between fp pointer and register with unbounded min value is
not allowed" at maps[key]. See the log below.


VERIFIER LOG:
=============
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
0: R1=ctx() R10=fp0
; int map_ptr_is_never_null(void *ctx) @ verifier_map_in_map.c:143
0: (b7) r1 = 0                        ; R1_w=0
; struct bpf_map *maps[2] = { 0 }; @ verifier_map_in_map.c:145
1: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=0 R10=fp0 fp-8_w=0
2: (7b) *(u64 *)(r10 -16) = r1        ; R1_w=0 R10=fp0 fp-16_w=0
3: (b4) w1 = 0                        ; R1_w=0
; for (key = 0; key < 2; key++) { @ verifier_map_in_map.c:150
4: (63) *(u32 *)(r10 -20) = r1        ; R1_w=0 R10=fp0 fp-24=0000????
5: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
6: (07) r2 += -20                     ; R2_w=fp-20
; map = bpf_map_lookup_elem(&map_in_map, &key); @ verifier_map_in_map.c:151
7: (18) r1 = 0xff48115640934800       ; 
R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
9: (85) call bpf_map_lookup_elem#1    ; 
R0_w=map_value_or_null(id=1,map=map_in_map,ks=4,vs=4)
; if (map) @ verifier_map_in_map.c:152
10: (15) if r0 == 0x0 goto pc+16      ; R0_w=map_ptr(ks=4,vs=4)
; maps[key] = map; @ verifier_map_in_map.c:153
11: (61) r1 = *(u32 *)(r10 -20)       ; R1_w=0 R10=fp0 fp-24=0000????
12: (67) r1 <<= 32                    ; R1_w=0
13: (c7) r1 s>>= 32                   ; R1_w=0
14: (bf) r2 = r1                      ; R1_w=0 R2_w=0
15: (67) r2 <<= 3                     ; R2_w=0
16: (bf) r3 = r10                     ; R3_w=fp0 R10=fp0
17: (07) r3 += -16                    ; R3_w=fp-16
18: (0f) r3 += r2                     ; R2_w=0 R3_w=fp-16
19: (7b) *(u64 *)(r3 +0) = r0         ; R0_w=map_ptr(ks=4,vs=4) 
R3_w=fp-16 fp-16_w=map_ptr(ks=4,vs=4)
; for (key = 0; key < 2; key++) { @ verifier_map_in_map.c:150
20: (bc) w2 = w1                      ; R1_w=0 R2_w=0
21: (04) w2 += 1                      ; R2_w=1
22: (63) *(u32 *)(r10 -20) = r2       ; R2=1 R10=fp0 fp-24=mmmm????
23: (c6) if w1 s< 0x1 goto pc-19      ; R1=0
5: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
6: (07) r2 += -20                     ; R2_w=fp-20
; map = bpf_map_lookup_elem(&map_in_map, &key); @ verifier_map_in_map.c:151
7: (18) r1 = 0xff48115640934800       ; 
R1_w=map_ptr(map=map_in_map,ks=4,vs=4)
9: (85) call bpf_map_lookup_elem#1    ; 
R0_w=map_value_or_null(id=2,map=map_in_map,ks=4,vs=4)
; if (map) @ verifier_map_in_map.c:152
10: (15) if r0 == 0x0 goto pc+16      ; R0_w=map_ptr(ks=4,vs=4)
; maps[key] = map; @ verifier_map_in_map.c:153
11: (61) r1 = *(u32 *)(r10 -20)       ; 
R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) 
R10=fp0 fp-24=mmmm????
12: (67) r1 <<= 32                    ; 
R1_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 
0xffffffff00000000))
13: (c7) r1 s>>= 32                   ; 
R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
14: (bf) r2 = r1                      ; 
R1_w=scalar(id=3,smin=0xffffffff80000000,smax=0x7fffffff) 
R2_w=scalar(id=3,smin=0xffffffff80000000,smax=0x7fffffff)
15: (67) r2 <<= 3                     ; 
R2_w=scalar(smax=0x7ffffffffffffff8,umax=0xfffffffffffffff8,smax32=0x7ffffff8,umax32=0xfffffff8,var_off=(0x0; 
0xfffffffffffffff8))
16: (bf) r3 = r10                     ; R3_w=fp0 R10=fp0
17: (07) r3 += -16                    ; R3_w=fp-16
18: (0f) r3 += r2
math between fp pointer and register with unbounded min value is not allowed
processed 36 insns (limit 1000000) max_states_per_insn 0 total_states 1 
peak_states 1 mark_read 1
=============


> 
>> +
>> +       for (key = 0; key < 2; key++) {
>> +               map = bpf_map_lookup_elem(&map_in_map, &key);
>> +               if (map)
>> +                       maps[key] = map;
>> +               else
>> +                       return 0;
>> +       }
>> +
>> +       /* After the loop every element of maps is CONST_PTR_TO_MAP so
>> +        * the invalid branch should not be explored by the verifier.
>> +        */
>> +       if (!maps[0])
>> +               asm volatile ("r10 = 0;");
>> +
>> +       return 0;
>> +}
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __uint(max_entries, 1);
>> +       __type(key, int);
>> +       __type(value, int);
>> +       __array(values, struct {
>> +               __uint(type, BPF_MAP_TYPE_RINGBUF);
>> +               __uint(max_entries, 4096);
> 
> nit: use 64 * 1024 just in case, for arches where page size is 64KB

ok

> 
>> +       });
>> +} rb_in_map SEC(".maps");
>> +
>> +struct rb_ctx {
>> +       void *rb;
>> +       struct bpf_dynptr dptr;
>> +};
>> +
>> +static __always_inline struct rb_ctx __rb_event_reserve(__u32 sz)
>> +{
>> +       struct rb_ctx rb_ctx = {};
>> +       void *rb;
>> +       __u32 cpu = bpf_get_smp_processor_id();
>> +       __u32 rb_slot = cpu & 1;
>> +
>> +       rb = bpf_map_lookup_elem(&rb_in_map, &rb_slot);
>> +       if (!rb)
>> +               return rb_ctx;
>> +
>> +       rb_ctx.rb = rb;
>> +       bpf_ringbuf_reserve_dynptr(rb, sz, 0, &rb_ctx.dptr);
>> +
>> +       return rb_ctx;
>> +}
>> +
>> +static __noinline void __rb_event_submit(struct rb_ctx *ctx)
>> +{
>> +       if (!ctx->rb)
>> +               return;
>> +
>> +       /* If the verifier (incorrectly) concludes that ctx->rb can be
>> +        * NULL at this point, we'll get "BPF_EXIT instruction in main
>> +        * prog would lead to reference leak" error
>> +        */
>> +       bpf_ringbuf_submit_dynptr(&ctx->dptr, 0);
>> +}
>> +
>> +SEC("socket")
>> +int map_ptr_is_never_null_rb(void *ctx)
>> +{
>> +       struct rb_ctx event_ctx = __rb_event_reserve(256);
>> +       __rb_event_submit(&event_ctx);
>> +       return 0;
>> +}
>> +
>>   char _license[] SEC("license") = "GPL";
>> --
>> 2.47.1
>>


