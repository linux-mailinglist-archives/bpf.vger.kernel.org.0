Return-Path: <bpf+bounces-19306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A78292FE
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 05:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21CEB2154F
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 04:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA076117;
	Wed, 10 Jan 2024 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXhDxsFj"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253863A0
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af6a41e6-69ef-423d-9a7d-5f370e90efda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704860353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT4PkL01tv83LaX02flab2tgjc3bD9V36Fy1Z25AGpk=;
	b=xXhDxsFjQP6GEAEQcqWdYUyjQCtqlPIctspan/qa6TwPZ/2OFshvfWDORhh3tHKKlQ57Iv
	bTfgpwJu80c4qbg6ShvxUgxW8jeFb3kne2h5m4O7IJbhIIrm1cn5PXidwZSz/BlXj+9pYF
	hDxIn1h/y9sNaGb/8CthCoEqMjYYrX0=
Date: Tue, 9 Jan 2024 20:19:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240109040524.2313448-1-yonghong.song@linux.dev>
 <CAEf4BzZgKWA6h4cEyxrFri4r+u976cNcm4vzFgKvJ0j=+uT+Jw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZgKWA6h4cEyxrFri4r+u976cNcm4vzFgKvJ0j=+uT+Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/9/24 2:38 PM, Andrii Nakryiko wrote:
> On Mon, Jan 8, 2024 at 8:05 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>> The change is in function check_stack_write_fixed_off().
>>
>> Before this patch, spilled zero will be marked as STACK_ZERO
>> which can provide precise values. In check_stack_write_var_off(),
>> STACK_ZERO will be maintained if writing a const zero
>> so later it can provide precise values if needed.
>>
>> The above handling of '*(u64 *)(r10 - 8) = 0' as a spill
>> will have issues in check_stack_write_var_off() as the spill
>> will be converted to STACK_MISC and the precise value 0
>> is lost. To fix this issue, if the spill slots with const
>> zero and the BPF_ST write also with const zero, the spill slots
>> are preserved, which can later provide precise values
>> if needed. Without the change in check_stack_write_var_off(),
>> the test_verifier subtest 'BPF_ST_MEM stack imm zero, variable offset'
>> will fail.
>>
>> I checked cpuv3 and cpuv4 with and without this patch with veristat.
>> There is no state change for cpuv3 since '*(u64 *)(r10 - 8) = 0'
>> is only generated with cpuv4.
>>
>> For cpuv4:
>> $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -f 'insns_diff!=0'
>> File                                        Program              Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
>> ------------------------------------------  -------------------  ---------  ---------  ---------------  ----------  ----------  -------------
>> local_storage_bench.bpf.linked3.o           get_local                  228        168    -60 (-26.32%)          17          14   -3 (-17.65%)
>> pyperf600_bpf_loop.bpf.linked3.o            on_event                  6066       4889  -1177 (-19.40%)         403         321  -82 (-20.35%)
>> test_cls_redirect.bpf.linked3.o             cls_redirect             35483      35387     -96 (-0.27%)        2179        2177    -2 (-0.09%)
>> test_l4lb_noinline.bpf.linked3.o            balancer_ingress          4494       4522     +28 (+0.62%)         217         219    +2 (+0.92%)
>> test_l4lb_noinline_dynptr.bpf.linked3.o     balancer_ingress          1432       1455     +23 (+1.61%)          92          94    +2 (+2.17%)
>> test_xdp_noinline.bpf.linked3.o             balancer_ingress_v6       3462       3458      -4 (-0.12%)         216         216    +0 (+0.00%)
>> verifier_iterating_callbacks.bpf.linked3.o  widening                    52         41    -11 (-21.15%)           4           3   -1 (-25.00%)
>> xdp_synproxy_kern.bpf.linked3.o             syncookie_tc             12412      11719    -693 (-5.58%)         345         330   -15 (-4.35%)
>> xdp_synproxy_kern.bpf.linked3.o             syncookie_xdp            12478      11794    -684 (-5.48%)         346         331   -15 (-4.34%)
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
>>   kernel/bpf/verifier.c                            | 16 ++++++++++++++--
>>   .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++--------
>>   2 files changed, 22 insertions(+), 10 deletions(-)
>>
>> Changelogs:
>>    v2 -> v3:
>>      - add precision checking to the spilled zero value register in
>>        check_stack_write_var_off().
>>      - check spill slot-by-slot instead of in a bunch within a spi.
>>    v1 -> v2:
>>      - Preserve with-const-zero spill if writing is also zero
>>        in check_stack_write_var_off().
>>      - Add a test with not-8-byte-aligned BPF_ST store.
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index adbf330d364b..54da1045e078 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4493,7 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>                  if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>>                          state->stack[spi].spilled_ptr.id = 0;
>>          } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>> -                  insn->imm != 0 && env->bpf_capable) {
>> +                  env->bpf_capable) {
>>                  struct bpf_reg_state fake_reg = {};
>>
>>                  __mark_reg_known(&fake_reg, insn->imm);
>> @@ -4615,6 +4615,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>
>>          /* Variable offset writes destroy any spilled pointers in range. */
>>          for (i = min_off; i < max_off; i++) {
>> +               struct bpf_reg_state *spill_reg;
>>                  u8 new_type, *stype;
>>                  int slot, spi;
>>
>> @@ -4640,7 +4641,18 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>                          return -EINVAL;
>>                  }
>>
>> -               /* Erase all spilled pointers. */
>> +               /* If writing_zero and the the spi slot contains a spill of value 0,
>> +                * maintain the spill type.
>> +                */
>> +               if (writing_zero && is_spilled_scalar_reg(&state->stack[spi])) {
> nit: I'd probably move `struct bpf_reg_state *spill_reg;` here to keep it local
>
> other than the missing `*stype == STACK_SPILL` check that Eduard
> already called out, looks good to me!

Make sense. Will do!

>
>> +                       spill_reg = &state->stack[spi].spilled_ptr;
>> +                       if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
>> +                               zero_used = true;
>> +                               continue;
>> +                       }
>> +               }
>> +
>> +               /* Erase all other spilled pointers. */
>>                  state->stack[spi].spilled_ptr.type = NOT_INIT;
>>
>>                  /* Update the slot type. */
> [...]

