Return-Path: <bpf+bounces-19113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4FA824F10
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 08:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9310285EB4
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97171CA85;
	Fri,  5 Jan 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQD25/vj"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68691DDE9
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ddc70b06-9fde-412f-88c0-3097e967dc6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704438858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsdSmGipa4+YPIt4vauko05iXOhOMGxP1inPInaS8uw=;
	b=wQD25/vjXAejbWlq3r/6f9Dy1gtSXLcxp7Tx7Kpleu4gbBH241nMiZHhfOaV+/gETIPJ1Q
	1cp4asF2ORe3elzLCzqAmraWMcVsGtFkVHqsUjZUjxrtc2iWSlENLcI+j/35GDACljTXpm
	AaM6yidJQMKbhx2SZiUM13sRpoLh3Ug=
Date: Thu, 4 Jan 2024 23:14:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/4/24 5:05 PM, Andrii Nakryiko wrote:
> On Thu, Jan 4, 2024 at 3:29 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Thu, 2024-01-04 at 15:09 -0800, Andrii Nakryiko wrote:
>> [...]
>>>> This seemed logical at the time of discussion, however, I can't figure
>>>> a counter example at the moment. It appears that whatever are
>>>> assumptions in check_stack_write_var_off() if spill is used in the
>>>> precise context it would be marked eventually.
>>>> E.g. the following is correctly rejected:
>>>>
>>>> SEC("raw_tp")
>>>> __log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
>>>> __failure
>>>> __naked void var_stack_1(void)
>>>> {
>>>>          asm volatile (
>>>>                  "call %[bpf_get_prandom_u32];"
>>>>                  "r9 = 100500;"
>>>>                  "if r0 > 42 goto +1;"
>>>>                  "r9 = 0;"
>>>>                  "*(u64 *)(r10 - 16) = r9;"
>>>>                  "call %[bpf_get_prandom_u32];"
>>>>                  "r0 &= 0xf;"
>>>>                  "r1 = -1;"
>>>>                  "r1 -= r0;"
>>>>                  "r2 = r10;"
>>>>                  "r2 += r1;"
>>>>                  "r0 = 0;"
>>>>                  "*(u8 *)(r2 + 0) = r0;"
>>>>                  "r1 = %[two_byte_buf];"
>>>>                  "r2 = *(u32 *)(r10 -16);"
>>>>                  "r1 += r2;"
>>>>                  "*(u8 *)(r1 + 0) = r2;" /* this should not be fine */
>>>>                  "exit;"
>>>>          :
>>>>          : __imm_ptr(two_byte_buf),
>>>>            __imm(bpf_get_prandom_u32)
>>>>          : __clobber_common);
>>>> }
>>>>
>>>> So now I'm not sure :(
>>>> Sorry for too much noise.
>>>
>>> hm... does that test have to do so many things and do all these u64 vs
>>> u32 vs u8 conversions?
>> The test is actually quite minimal, the longest part is conjuring of
>> varying offset pointer in r2, here it is with additional comments:
>>
>>      /* Write 0 or 100500 to fp-16, 0 is on the first verification pass */
>>      "call %[bpf_get_prandom_u32];"
>>      "r9 = 100500;"
>>      "if r0 > 42 goto +1;"
>>      "r9 = 0;"
>>      "*(u64 *)(r10 - 16) = r9;"
>>      /* prepare a variable length access */
>>      "call %[bpf_get_prandom_u32];"
>>      "r0 &= 0xf;" /* r0 range is [0; 15] */
>>      "r1 = -1;"
>>      "r1 -= r0;"  /* r1 range is [-16; -1] */
>>      "r2 = r10;"
>>      "r2 += r1;"  /* r2 range is [fp-16; fp-1] */
>>      /* do a variable length write of constant 0 */
>>      "r0 = 0;"
>>      "*(u8 *)(r2 + 0) = r0;"
> I meant this u8
>
>>      /* use fp-16 to access an array of length 2 */
>>      "r1 = %[two_byte_buf];"
>>      "r2 = *(u32 *)(r10 -16);"
> and this u32. I'm not saying it's anything wrong, but it's simpler to
> deal with u64 consistently. There is nothing wrong with the test per
> se, I'm just saying we should try eliminate unnecessary cross-plays
> with narrowing/widening stores/loads.
>
> But that's offtopic, sorry.
>
>>      "r1 += r2;"
>>      "*(u8 *)(r1 + 0) = r2;" /* this should not be fine */
>>      "exit;"
>>
>>> Can we try a simple test were we spill u64
>>> SCALAR (imprecise) zero register to fp-8 or fp-16, and then use those
>>> fp-8|fp-16 slot as an index into an array in precise context. Then
>>> have a separate delayed branch that will write non-zero to fp-8|fp-16.
>>> States shouldn't converge and this should be rejected.
>> That is what test above does but it also includes varying offset access.
>>
> Yes, and the test fails, but if you read the log, you'll see that fp-8
> is never marked precise, but it should. So we need more elaborate test
> that would somehow exploit fp-8 imprecision.
>
> I ran out of time. But what I tried was replacing
>
>
> "r2 = *(u32 *)(r10 -16);"
>
> with
>
> "r2 = *(u8 *)(r2 +0);"
>
> So keep both read and write as variable offset. And we are saved by
> some missing logic in read_var_off that would set r2 as known zero
> (because it should be for the branch where both fp-8 and fp-16 are
> zero). But that fails in the branch that should succeed, and if that
> branch actually succeeds, I suspect the branch where we initialize
> with non-zero r9 will erroneously succeed.

I did some experiments but still confused.
With the current patch set and the above Andrii's suggested changes, we have
...
13: R1_w=scalar(smin=smin32=-16,smax=smax32=-1,umin=0xfffffffffffffff0,umin32=0xfffffff0,var_off=(0xfffffffffffffff0; 0xf)) R2_w=fp(smin=smin32=-16,smax=smax32=-1,umin=0xfffffffffffffff0,umin32=0xfffffff0,var_off=(0xfffffffffffffff0; 0xf))
13: (b7) r0 = 0                       ; R0_w=0
14: (73) *(u8 *)(r2 +0) = r0          ; R0_w=0 R2_w=fp(smin=smin32=-16,smax=smax32=-1,umin=0xfffffffffffffff0,umin32=0xfffffff0,var_off=(0xfffffffffffffff0; 0xf)) fp-8=mmmmmmmm fp-16=0
15: (bf) r1 = r6                      ; R1_w=map_value(map=.data.two_byte_,ks=4,vs=2) R6=map_value(map=.data.two_byte_,ks=4,vs=2)
16: (71) r2 = *(u8 *)(r2 +0)          ; R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) fp-16=0
17: (0f) r1 += r2
mark_precise: frame0: last_idx 17 first_idx 8 subseq_idx -1
mark_precise: frame0: regs=r2 stack= before 16: (71) r2 = *(u8 *)(r2 +0)
18: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
18: (73) *(u8 *)(r1 +0) = r2
invalid access to map value, value_size=2 off=255 size=1
R1 max value is outside of the allowed memory range

Now, let us add the precision marking,
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4619,11 +4619,18 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
  
                 slot = -i - 1;
                 spi = slot / BPF_REG_SIZE;
+               mark_stack_slot_scratched(env, spi);
  
                 /* If writing_zero and the the spi slot contains a spill of value 0,
                  * maintain the spill type.
                  */
                 if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_scalar_reg(&state->stack[spi])) {
+                       if (value_regno >= 0) {
+                               err = mark_chain_precision(env, value_regno);
+                               if (err)
+                                       return err;
+                       }
+
                         spill_reg = &state->stack[spi].spilled_ptr;
                         if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
                                 for (j = BPF_REG_SIZE; j > 0; j--) {
@@ -4636,7 +4643,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
                 }
  
                 stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
-               mark_stack_slot_scratched(env, spi);
  
                 if (!env->allow_ptr_leaks && *stype != STACK_MISC && *stype != STACK_ZERO) {
                         /* Reject the write if range we may write to has not


With the above change, the verifier output:
...
13: R1_w=scalar(smin=smin32=-16,smax=smax32=-1,umin=0xfffffffffffffff0,umin32=0xfffffff0,var_off=(0xfffffffffffffff0; 0xf)) R2_w=fp(smin=smin32=-16,smax=smax32=-1,umin=0xfffffffffffffff0,umin32=0xfffffff0,var_off=(0xfffffffffffffff0; 0xf))
13: (b7) r0 = 0                       ; R0_w=0
14: (73) *(u8 *)(r2 +0) = r0
mark_precise: frame0: last_idx 14 first_idx 8 subseq_idx -1
mark_precise: frame0: regs=r0 stack= before 13: (b7) r0 = 0
     <==== added precision marking for the value register
15: R0_w=0 R2_w=fp(smin=smin32=-16,smax=smax32=-1,umin=0xfffffffffffffff0,umin32=0xfffffff0,var_off=(0xfffffffffffffff0; 0xf)) fp-8=mmmmmmmm fp-16=0
15: (bf) r1 = r6                      ; R1_w=map_value(map=.data.two_byte_,ks=4,vs=2) R6=map_value(map=.data.two_byte_,ks=4,vs=2)
16: (71) r2 = *(u8 *)(r2 +0)          ; R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) fp-16=0
17: (0f) r1 += r2
mark_precise: frame0: last_idx 17 first_idx 8 subseq_idx -1
mark_precise: frame0: regs=r2 stack= before 16: (71) r2 = *(u8 *)(r2 +0)
18: R1_w=map_value(map=.data.two_byte_,ks=4,vs=2,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
18: (73) *(u8 *)(r1 +0) = r2
invalid access to map value, value_size=2 off=255 size=1
R1 max value is outside of the allowed memory range

Note that we do have precision marking for register r0 at insn 14.
But backtracking at insn 17 stops at insn 16 and it did not reach back
to insn 14, so precision marking is not really needed in this particular
case. Maybe I missed something here.

There is an alternative implementation in check_stack_write_var_off().
For a spill of value/reg 0, we can convert it to STACK_ZERO instead
of trying to maintain STACK_SPILL. If we convert it to STACK_ZERO,
then we can reuse the rest of logic in check_stack_write_var_off()
and at the end we have

         if (zero_used) {
                 /* backtracking doesn't work for STACK_ZERO yet. */
                 err = mark_chain_precision(env, value_regno);
                 if (err)
                         return err;
         }

although I do not fully understand the above either. Need to go back to
git history to find why.


>
> Anyways, I still claim that we are mishandling a precision of spilled
> register when doing zero var_off writes.
>
>
>
>> [...]

