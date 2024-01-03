Return-Path: <bpf+bounces-18832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C248225C2
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 01:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A39B225FD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57125C85;
	Wed,  3 Jan 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QdBoySKS"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024817981
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1da1a0f3-ef8d-4460-85a8-bd43187e1add@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704240017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cBfG/V3C/5B2Z8NbNAXnsVOA6zdCDr0HwRheQSnBp4=;
	b=QdBoySKST20OZGKdEachGMuokHUylQ5rUSckXJcHxt7o4qbPrjAWTaE4OrEhkDUaT3jCW4
	cQkpbWZFLVZYqHDAUXMfJjOILeKXWaQ1moAlJYD1JzZjMVKNTXM05J3PJp62EM1scQfRSK
	m2b7Xbs9FMrJoyN0TrTpsc3ZUX2bkXY=
Date: Tue, 2 Jan 2024 16:00:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Track aligned st store as imprecise spilled
 registers
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240102190726.2017424-1-yonghong.song@linux.dev>
 <CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8jJZmPBWYDA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaWets3fHUGtctwCNWecR9ASRCO2kFagNy8jJZmPBWYDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/2/24 1:42 PM, Andrii Nakryiko wrote:
> On Tue, Jan 2, 2024 at 11:07 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With patch set [1], precision backtracing supports register spill/fill
>> to/from the stack. The patch [2] allows initial imprecise register spill
>> with content 0. This is a common case for cpuv3 and lower for
>> initializing the stack variables with pattern
>>    r1 = 0
>>    *(u64 *)(r10 - 8) = r1
>> and the [2] has demonstrated good verification improvement.
>>
>> For cpuv4, the initialization could be
>>    *(u64 *)(r10 - 8) = 0
>> The current verifier marks the r10-8 contents with STACK_ZERO.
>> Similar to [2], let us permit the above insn to behave like
>> imprecise register spill which can reduce number of verified states.
>>
>> I checked cpuv3 and cpuv4 with and without this patch.
>> There is no change for cpuv3 since '*(u64 *)(r10 - 8) = 0'
>> is only generated with cpuv4.
>>
>> For cpuv4:
>> $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -s '|insns_diff|'
>> File                                                   Program                                               Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
>> -----------------------------------------------------  ----------------------------------------------------  ---------  ---------  ---------------  ----------  ----------  -------------
>> pyperf600_bpf_loop.bpf.linked3.o                       on_event                                                   6066       4889  -1177 (-19.40%)         403         321  -82 (-20.35%)
>> xdp_synproxy_kern.bpf.linked3.o                        syncookie_tc                                              12412      11719    -693 (-5.58%)         345         330   -15 (-4.35%)
>> xdp_synproxy_kern.bpf.linked3.o                        syncookie_xdp                                             12478      11794    -684 (-5.48%)         346         331   -15 (-4.34%)
>> test_cls_redirect.bpf.linked3.o                        cls_redirect                                              35483      35387     -96 (-0.27%)        2179        2177    -2 (-0.09%)
>> local_storage_bench.bpf.linked3.o                      get_local                                                   228        168    -60 (-26.32%)          17          14   -3 (-17.65%)
>> test_l4lb_noinline.bpf.linked3.o                       balancer_ingress                                           4494       4522     +28 (+0.62%)         217         219    +2 (+0.92%)
>> test_l4lb_noinline_dynptr.bpf.linked3.o                balancer_ingress                                           1432       1455     +23 (+1.61%)          92          94    +2 (+2.17%)
>> verifier_iterating_callbacks.bpf.linked3.o             widening                                                     52         41    -11 (-21.15%)           4           3   -1 (-25.00%)
>> test_xdp_noinline.bpf.linked3.o                        balancer_ingress_v6                                        3462       3458      -4 (-0.12%)         216         216    +0 (+0.00%)
>> ...
>>
>> test_l4lb_noinline and test_l4lb_noinline_dynptr has minor regression, but
>> pyperf600_bpf_loop and local_storage_bench gets pretty good improvement.
>>
>>    [1] https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.org/
>>    [2] https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.org/
>>
>> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Cc: Martin KaFai Lau <kafai@fb.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c                                   | 2 +-
>>   tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a376eb609c41..17ad0228270e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>                  if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>>                          state->stack[spi].spilled_ptr.id = 0;
>>          } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>> -                  insn->imm != 0 && env->bpf_capable) {
>> +                  env->bpf_capable) {
> the change makes sense, there is nothing special about insn->imm == 0
> case, so LGTM
>
>>                  struct bpf_reg_state fake_reg = {};
>>
>>                  __mark_reg_known(&fake_reg, insn->imm);
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
>> index 39fe3372e0e0..05de3de56e79 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
>> @@ -496,13 +496,13 @@ SEC("raw_tp")
>>   __log_level(2)
>>   __success
>>   /* make sure fp-8 is all STACK_ZERO */
> but we should update STACK_ZERO comments in this test

Missed this. Will update comments.

>
> and also, STACK_ZERO situation is still possible, right? E.g., when we
> spill register at -4 offset, not -8. So I'd either extend or add
> another test to make sure we still validate that STACK_ZERO slots
> return precise zero. Can you add something like this?

Yes, if offset not 8 byte aligned, e.g., -4, it will be STACK_ZERO.
Will add another test case to capture this.

>
>
>> -__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
>> +__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=0")
>>   /* but fp-16 is spilled IMPRECISE zero const reg */
>>   __msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
>>   /* validate that assigning R2 from STACK_ZERO doesn't mark register
>>    * precise immediately; if necessary, it will be marked precise later
>>    */
>> -__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8_w=00000000")
>> +__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8_w=0")
>>   /* similarly, when R2 is assigned from spilled register, it is initially
>>    * imprecise, but will be marked precise later once it is used in precise context
>>    */
>> --
>> 2.34.1
>>

