Return-Path: <bpf+bounces-34122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C745192A900
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24B51C21270
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACFE14A4F0;
	Mon,  8 Jul 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPUmrz1I"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3492149C60
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463659; cv=none; b=VcC4UtEP0y8ZQLvPM8R7i0SwQBU5V+R1hEuR6iw+xlS2OZhrz4Qaga03GVaNBimOEhRiSgtZf3AFCAL2LHQPjvItUBocpPJFdlsz6ue2ZhS4U5c8WXbMFXAhKdWm7fdKgsVlVrNuqG3+Jbnm/oHhhpyFNBbFSNZbleX3ohy8z9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463659; c=relaxed/simple;
	bh=UhkLEaHmT6e6PB6/0mH3oO+OUbyi5MbULUAP+2d4xRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA78H51rE4UD72BxY9DiQgmXYnJWf5DCg8//mmfgtRbm3vY3Ym9Ma4ghxVDQ7dFf+M/CUd8M6JQz8hY54gj4FN977WOBJs0VPGjxleB6ud05wHx9uLTHtDJnXeH/HYJnfqY9+wmxd2QVqZFfkjCaM2Eb4R9R+bWHsIkHmQQIe6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPUmrz1I; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720463653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKMTfBlsbywCDoQfQSF7/0POEuJG+8fHnXp8Si/+BSg=;
	b=RPUmrz1I6WtVv4EadJTUKQnHDw6nxbKj53d0YgO7c1h6d68YPav7uDeElZVVVcH7+bO5rh
	wKK8g8REe9lMyIUY9yY5lwhRKFStjP2/qSTivetP6mfcp8YgUfAWpYSDq/i3FAk/imb3YQ
	vvw+9Bvieo9MRxq6/TriUThH+80LKuw=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev>
Date: Mon, 8 Jul 2024 11:34:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround
 iters/iter_arr_with_actual_elem_count failure when -mcpu=cpuv4
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/8/24 9:27 AM, Alexei Starovoitov wrote:
> On Mon, Jul 8, 2024 at 8:46 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest llvm19, the selftest iters/iter_arr_with_actual_elem_count
>> failed with -mcpu=v4.
>>
>> The following are the details:
>>    0: R1=ctx() R10=fp0
>>    ; int iter_arr_with_actual_elem_count(const void *ctx) @ iters.c:1420
>>    0: (b4) w7 = 0                        ; R7_w=0
>>    ; int i, n = loop_data.n, sum = 0; @ iters.c:1422
>>    1: (18) r1 = 0xffffc90000191478       ; R1_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144)
>>    3: (61) r6 = *(u32 *)(r1 +128)        ; R1_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) R6_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
>>    ; if (n > ARRAY_SIZE(loop_data.data)) @ iters.c:1424
>>    4: (26) if w6 > 0x20 goto pc+27       ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f))
>>    5: (bf) r8 = r10                      ; R8_w=fp0 R10=fp0
>>    6: (07) r8 += -8                      ; R8_w=fp-8
>>    ; bpf_for(i, 0, n) { @ iters.c:1427
>>    7: (bf) r1 = r8                       ; R1_w=fp-8 R8_w=fp-8
>>    8: (b4) w2 = 0                        ; R2_w=0
>>    9: (bc) w3 = w6                       ; R3_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R6_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f))
>>    10: (85) call bpf_iter_num_new#45179          ; R0=scalar() fp-8=iter_num(ref_id=2,state=active,depth=0) refs=2
>>    11: (bf) r1 = r8                      ; R1=fp-8 R8=fp-8 refs=2
>>    12: (85) call bpf_iter_num_next#45181 13: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R6=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
>>    ; bpf_for(i, 0, n) { @ iters.c:1427
>>    13: (15) if r0 == 0x0 goto pc+2       ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) refs=2
>>    14: (81) r1 = *(s32 *)(r0 +0)         ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff) refs=2
>>    15: (ae) if w1 < w6 goto pc+4 20: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1=scalar(smin=0xffffffff80000000,smax=smax32=umax32=31,umax=0xffffffff0000001f,smin32=0,var_off=(0x0; 0xffffffff0000001f)) R6=scalar(id=1,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
>>    ; sum += loop_data.data[i]; @ iters.c:1429
>>    20: (67) r1 <<= 2                     ; R1_w=scalar(smax=0x7ffffffc0000007c,umax=0xfffffffc0000007c,smin32=0,smax32=umax32=124,var_off=(0x0; 0xfffffffc0000007c)) refs=2
>>    21: (18) r2 = 0xffffc90000191478      ; R2_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) refs=2
>>    23: (0f) r2 += r1
>>    math between map_value pointer and register with unbounded min value is not allowed
>>
>> The source code:
>>    int iter_arr_with_actual_elem_count(const void *ctx)
>>    {
>>          int i, n = loop_data.n, sum = 0;
>>
>>          if (n > ARRAY_SIZE(loop_data.data))
>>                  return 0;
>>
>>          bpf_for(i, 0, n) {
>>                  /* no rechecking of i against ARRAY_SIZE(loop_data.n) */
>>                  sum += loop_data.data[i];
>>          }
>>
>>          return sum;
>>    }
>>
>> The insn #14 is a sign-extenstion load which is related to 'int i'.
>> The insn #15 did a subreg comparision. Note that smin=0xffffffff80000000 and this caused later
>> insn #23 failed verification due to unbounded min value.
>>
>> Actually insn #15 smin range can be better. Since after comparison, we know smin32=0 and smax32=32.
>> With insn #14 being a sign-extension load. We will know top 32bits should be 0 as well.
>> Current verifier is not able to handle this, and this patch is a workaround to fix
>> test failure by changing variable 'i' type from 'int' to 'unsigned' which will give
>> proper range during comparison.
>>
>>    ; bpf_for(i, 0, n) { @ iters.c:1428
>>    13: (15) if r0 == 0x0 goto pc+2       ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) refs=2
>>    14: (61) r1 = *(u32 *)(r0 +0)         ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) refs=2
>>    ...
>>    from 15 to 20: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=31,var_off=(0x0; 0x1f)) R6=scalar(id=1,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
>>    20: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=31,var_off=(0x0; 0x1f)) R6=scalar(id=1,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
>>    ; sum += loop_data.data[i]; @ iters.c:1430
>>    20: (67) r1 <<= 2                     ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=124,var_off=(0x0; 0x7c)) refs=2
>>    21: (18) r2 = 0xffffc90000185478      ; R2_w=map_value(map=iters.bss,ks=4,vs=1280,off=1144) refs=2
>>    23: (0f) r2 += r1
>>    mark_precise: frame0: last_idx 23 first_idx 20 subseq_idx -1
>>    ...
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/progs/iters.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
>> index 16bdc3e25591..d1801d151a12 100644
>> --- a/tools/testing/selftests/bpf/progs/iters.c
>> +++ b/tools/testing/selftests/bpf/progs/iters.c
>> @@ -1419,7 +1419,8 @@ SEC("raw_tp")
>>   __success
>>   int iter_arr_with_actual_elem_count(const void *ctx)
>>   {
>> -       int i, n = loop_data.n, sum = 0;
>> +       unsigned i;
>> +       int n = loop_data.n, sum = 0;
>>
>>          if (n > ARRAY_SIZE(loop_data.data))
>>                  return 0;
> I think we only have one realistic test that
> checks 'range vs range' verifier logic.
> Since "int i; bpf_for(i"
> is a very common pattern in all other bpf_for tests it feels
> wrong to workaround like this.

Agree. We should fix this in verifier to be user friendly.

>
> What exactly needs to be improved in 'range vs range' logic to
> handle this case?

We can add a bit in struct bpf_reg_state like below
	struct bpf_reg_state {
		...
		enum bpf_reg_liveness live;
		bool precise;
	}
to
	struct bpf_reg_state {
		...
		enum bpf_reg_liveness live;
		unsigned precise:1;
		unsigned 32bit_sign_ext:1;  /* for *(s32 *)(...) */
	}
When the insn 15 is processed with 'true' branch
   14: (81) r1 = *(s32 *)(r0 +0)         ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff) refs=2
   15: (ae) if w1 < w6 goto pc+4

the 32bit_sign_ext will indicate the register r1 is from 32bit sign extension, so once w1 range is refined, the upper 32bit can be recalculated.

Can we avoid 32bit_sign_exit in the above? Let us say we have
   r1 = ...;  R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff), R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f))
   if w1 < w6 goto pc+4
where r1 achieves is trange through other means than 32bit sign extension e.g.
   call bpf_get_prandom_u32;
   r1 = r0;
   r1 <<= 32;
   call bpf_get_prandom_u32;
   r1 |= r0;  /* r1 is 64bit random number */
   r2 = 0xffffffff80000000 ll;
   if r1 s< r2 goto end;
   if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=0xffffffff80000000,smax=0x7fffffff) */
   if w1 < w6 goto end;
   ...  <=== w1 range [0,31]
        <=== but if we have upper bit as 0xffffffff........, then the range will be
        <=== [0xffffffff0000001f, 0xffffffff00000000] and this range is not possible compared to original r1 range.
        <=== so the only possible way for upper 32bit range is 0.
end:

Therefore, looks like we do not need 32bit_sign_exit. Just from
R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
with refined range in true path of 'if w1 < w6 goto ...',
we can further refine w1 range properly.


