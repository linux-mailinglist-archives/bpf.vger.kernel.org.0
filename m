Return-Path: <bpf+bounces-35249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D84939386
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FEE1F21B6E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08BA16EC1C;
	Mon, 22 Jul 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JEx2Oe6u"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3116E88D
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672198; cv=none; b=PZQVGVk2pa5kKXNMm/OHN8lSc79DvkkdSxfrA4pJt090cWKMyPKWZx1B86Jnfc+xc+y3LBTmDAVOsx2CZyqp1EylMaa9KePAWqHA0lVLUV6KoWZ4AeyDdcjYIsq90uvs4oh/C/gqWnPb2r3WMCgJZ1Rp9BOhLH9b7LBdh9JnSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672198; c=relaxed/simple;
	bh=Y0NWDQzxMq/t74sZpt7+IYIO2QmF4k2tWL5mm+WPLyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH+IZQSriThZVFFG4UN/wgeDV0nYT2cgJye7Y76gb+wRAHva6o5K4iRDn0aDenX+Siiqf+u+1vfYtb+z9hzV7CwGG3ia+oWXV9MDciIjp2v5k77kGTiQKn+ribKXzIWJDEZ/dr3U20FnDC6LgzJ1PPAaLWYL8zWSo+jrEGjYtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JEx2Oe6u; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrii.nakryiko@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721672193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZC1IfR/86EvVVesfI1yRxBn631bShb2t1H9lR9YAaUk=;
	b=JEx2Oe6u1TYwUZ81xTvtd7ew7+1OXwpeYI6LI/T1JsVF4f3U++Sf/S/ZYfgjD6Or4CAmf9
	ipX5PNk0Ca1qEQTd+2qSQtml1bSknRdy/Db6drCnB6y6fP2g2E1UjpS6Ad1i3yG//xX/X3
	KEA/nMyk0J0rCwyoVjomNhPckEGtiKc=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: shung-hsi.yu@suse.com
Message-ID: <17304347-8431-46f3-affe-9da7b9546821@linux.dev>
Date: Mon, 22 Jul 2024 11:16:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240718052821.3753486-1-yonghong.song@linux.dev>
 <CAEf4BzYazgarMJNVqt33grWxYEcNWy_L=OCXwg9tw5wHYc+2iw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYazgarMJNVqt33grWxYEcNWy_L=OCXwg9tw5wHYc+2iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/19/24 3:46 PM, Andrii Nakryiko wrote:
> On Wed, Jul 17, 2024 at 10:28 PM Yonghong Song <yonghong.song@linux.dev> wrote:
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
>> Actually insn #15 R1 smin range can be better. Before insn #15, we have
>>    R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
>> With the above range, we know for R1, upper 32bit can only be 0xffffffff or 0.
>> Otherwise, the value range for R1 could be beyond [smin=0xffffffff80000000,smax=0x7fffffff].
>>
>> After insn #15, for the true patch, we know smin32=0 and smax32=32. With the upper 32bit 0xffffffff,
>> then the corresponding value is [0xffffffff00000000, 0xffffffff00000020]. The range is
>> obviously beyond the original range [smin=0xffffffff80000000,smax=0x7fffffff] and the
>> range is not possible. So the upper 32bit must be 0, which implies smin = smin32 and
>> smax = smax32.
>>
>> This patch fixed the issue by adding additional register deduction after 32-bit compare
> __reg_deduce_mixed_bounds() is called from reg_bounds_sync() pretty
> much after every arithmetic operation or any comparison. Is the above
> logic true universally or only after signed comparison? If the latter,
> then we can't just do it unconditionally inside
> __reg_deduce_mixed_bounds().

It is not just for signed extension. Some other arithmetic operation may
produce such a range as well.

>
>> insn. If the signed 32-bit register range is non-negative then 64-bit smin is
>> in range of [S32_MIN, S32_MAX], then the actual 64-bit smin/smax should be the same
>> as 32-bit smin32/smax32.
>>
>> With this patch, iters/iter_arr_with_actual_elem_count succeeded with better register range:
>>
>> from 15 to 20: R0=rdonly_mem(id=7,ref_obj_id=2,sz=4) R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=31,var_off=(0x0; 0x1f)) R6=scalar(id=1,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=scalar(id=9,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R8=scalar(id=9,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=3) refs=2
>>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8da132a1ef28..46532437c4bb 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2182,6 +2182,42 @@ static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
>>                  reg->smin_value = max_t(s64, reg->smin_value, new_smin);
>>                  reg->smax_value = min_t(s64, reg->smax_value, new_smax);
>>          }
>> +
>> +       /* Here we would like to handle a special case after sign extending load,
>> +        * when upper bits for a 64-bit range are all 1s or all 0s.
>> +        *
>> +        * Upper bits are all 1s when register is in a range:
>> +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
>> +        * Upper bits are all 0s when register is in a range:
>> +        *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
>> +        * Together this forms are continuous range:
>> +        *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
>> +        *
>> +        * Now, suppose that register range is in fact tighter:
>> +        *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
>> +        * Also suppose that it's 32-bit range is positive,
>> +        * meaning that lower 32-bits of the full 64-bit register
>> +        * are in the range:
>> +        *   [0x0000_0000, 0x7fff_ffff] (W)
>> +        *
>> +        * If this happens, then any value in a range:
>> +        *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
>> +        * is smaller than a lowest bound of the range (R):
>> +        *   0xffff_ffff_8000_0000
>> +        * which means that upper bits of the full 64-bit register
>> +        * can't be all 1s, when lower bits are in range (W).
>> +        *
>> +        * Note that:
>> +        *  - 0xffff_ffff_8000_0000 == (s64)S32_MIN
>> +        *  - 0x0000_0000_ffff_ffff == (s64)S32_MAX
> ?? S32_MAX = 0x7fffffff, so should the right part be U32_MAX or the
> left part should be 0x0000_0000_7fff_ffff ?
Will make a change in the next revision.
>
>> +        * These relations are used in the conditions below.
>> +        */
>> +       if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
>> +               reg->smin_value = reg->umin_value = reg->s32_min_value;
>> +               reg->smax_value = reg->umax_value = reg->s32_max_value;
> let's please not mix signed and unsigned 32 -> 64 bit conversions,
> they are confusing and tricky enough in each domain individually,
> there is no point in mixing them
Okay, will do.
>
>> +               reg->var_off = tnum_intersect(reg->var_off,
>> +                                             tnum_range(reg->smin_value, reg->smax_value));
>> +       }
>>   }
>>
>>   static void __reg_deduce_bounds(struct bpf_reg_state *reg)
>> --
>> 2.43.0
>>

