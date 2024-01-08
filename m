Return-Path: <bpf+bounces-19236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF18827BA7
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB721F2412C
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EEE5646E;
	Mon,  8 Jan 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JVTlQzjC"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593356741
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd15fbaa-93cc-4197-a800-cc836fe641a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704757150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCrOA9OgMY610EVfkW+bcVE8uf71gWqyNCbGNlUj6dg=;
	b=JVTlQzjCL67yNv7jzOLxH+jQnP0Kdl1kwMeirlVSoAHG1vtAoFWBATmpQiHKEMme5YHJoN
	PDbnQEK/+9K+d4iv2kULuJAYm3PTbbXFfet1FV/ULZjc4ceOAdZKewqhd7xn9mzTAZoZtz
	EvfRwVnjYE/I4J8r/EF7FEU0vBrLMus=
Date: Mon, 8 Jan 2024 15:39:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <CAEf4BzYXm-2qkM3Gx5Did9nuLAkA+SvfK75Aj5pjeDWmBMQTSg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYXm-2qkM3Gx5Did9nuLAkA+SvfK75Aj5pjeDWmBMQTSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/8/24 3:23 PM, Andrii Nakryiko wrote:
> On Wed, Jan 3, 2024 at 3:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>>   kernel/bpf/verifier.c                         | 21 +++++++++++++++++--
>>   .../selftests/bpf/progs/verifier_spill_fill.c | 16 +++++++-------
>>   2 files changed, 27 insertions(+), 10 deletions(-)
>>
>> Changelogs:
>>    v1 -> v2:
>>      - Preserve with-const-zero spill if writing is also zero
>>        in check_stack_write_var_off().
>>      - Add a test with not-8-byte-aligned BPF_ST store.
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d4e31f61de0e..cfe7a68d90a5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>                  if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>>                          state->stack[spi].spilled_ptr.id = 0;
>>          } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>> -                  insn->imm != 0 && env->bpf_capable) {
>> +                  env->bpf_capable) {
>>                  struct bpf_reg_state fake_reg = {};
>>
>>                  __mark_reg_known(&fake_reg, insn->imm);
>> @@ -4613,11 +4613,28 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>
>>          /* Variable offset writes destroy any spilled pointers in range. */
>>          for (i = min_off; i < max_off; i++) {
>> +               struct bpf_reg_state *spill_reg;
>>                  u8 new_type, *stype;
>> -               int slot, spi;
>> +               int slot, spi, j;
>>
>>                  slot = -i - 1;
>>                  spi = slot / BPF_REG_SIZE;
>> +
>> +               /* If writing_zero and the the spi slot contains a spill of value 0,
>> +                * maintain the spill type.
>> +                */
>> +               if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_scalar_reg(&state->stack[spi])) {
>> +                       spill_reg = &state->stack[spi].spilled_ptr;
>> +                       if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
>> +                               for (j = BPF_REG_SIZE; j > 0; j--) {
>> +                                       if (state->stack[spi].slot_type[j - 1] != STACK_SPILL)
>> +                                               break;
>> +                               }
>> +                               i += BPF_REG_SIZE - j - 1;
>> +                               continue;
>> +                       }
>> +               }
>> +
> Yonghong, I just replied to one of Eduard's email. I think the overall
> approach will be correct.
>
> But two small things. Above, if you detect tnum_is_conxt() and value
> is zero, it seems like you'd need to set zero_used=true.

Yes, my planned change is to add mark_chain_precision() explicitly after
    if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_scalar_reg(&state->stack[spi])) {

But yes, setting zero_used=true much simpler.

>
> But I actually want to propose to implement this slightly differently.
> Instead of skipping multiple bytes, I think it would be better to just
> check one byte at a time. Just like we have
>
>
> if (writing_zero && *stype == STACK_ZERO) {
>      new_type = STACK_ZERO;
>      zero_used = true;
> }
>
> we can insert
>
> if (writing_zero && *stype == STACK_SPILL && tnum_is_const(..) &&
> var_off.value == 0) {
>      zero_used = true;
>      continue;
> }
>
> It will be very similar to STACK_ZERO handling, but we won't be
> overwriting slot type. But handling one byte at a time is more in line
> with the rest of the logic.
>
> WDYT?

Thanks for suggestion. Sounds good. Will do.

>
>>                  stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
>>                  mark_stack_slot_scratched(env, spi);
>>
> [...]

