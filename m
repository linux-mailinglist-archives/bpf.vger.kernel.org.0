Return-Path: <bpf+bounces-19307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100B829302
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 05:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11004B248AA
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 04:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39041368;
	Wed, 10 Jan 2024 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWVEn16r"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876C613D
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 04:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ab86191-90f0-4957-a5ce-8a08469aff3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704861000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ75bgyXwh/QDfw/eSFDPLgk2QxjBifY0HYPZ3dPgCE=;
	b=FWVEn16rAUoywHTmVhUft9O+J4XhGwZVbcDMDSSBlSS/js5DiMZRqi9F13gU/4Whv3saWv
	xQU9u3juVJO1/S0CqtO72lu6U+jUm3pG5B+AWPaBZMjujda2HL1bGfwgYJfCUvYaVdV8EK
	nsMLIOjQQeM2pxvYj9ItfU5+m/Nfats=
Date: Tue, 9 Jan 2024 20:29:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add a selftest with
 not-8-byte aligned BPF_ST
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240109040524.2313448-1-yonghong.song@linux.dev>
 <20240109040529.2314115-1-yonghong.song@linux.dev>
 <CAEf4Bzb1xyfBNnSKVbUOdfSA_xWD965BWSKHVfwn7Q1D3UkbXw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb1xyfBNnSKVbUOdfSA_xWD965BWSKHVfwn7Q1D3UkbXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/9/24 2:47 PM, Andrii Nakryiko wrote:
> On Mon, Jan 8, 2024 at 8:05 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add a selftest with a 4 bytes BPF_ST of 0 where the store is not
>> 8-byte aligned. The goal is to ensure that STACK_ZERO is properly
>> marked for the spill and the STACK_ZERO value can propagate
>> properly during the load.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/progs/verifier_spill_fill.c | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
>> index d4b3188afe07..6017b26d957d 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
>> @@ -583,6 +583,50 @@ __naked void partial_stack_load_preserves_zeros(void)
>>          : __clobber_common);
>>   }
>>
>> +SEC("raw_tp")
>> +__log_level(2)
>> +__success
>> +/* fp-4 is STACK_ZERO */
>> +__msg("2: (62) *(u32 *)(r10 -4) = 0          ; R10=fp0 fp-8=0000????")
>> +/* validate that assigning R2 from STACK_ZERO with zero value doesn't mark register
>> + * precise immediately; if necessary, it will be marked precise later
>> + */
> this comment is not accurate in this test, this unaligned write
> doesn't preserve register and writes STACK_ZERO, so there is no
> precision going on here, right?

I checked the source code again in check_stack_write_fixed_off() and
backtrack_insn(). Indeed, check_stack_write_fixed_off() assigned
STACK_ZERO to the stack slot and with imm = 0 and value_regno = -1
mark_chain_precision() will be an nop. Also, in backtrack_insn()
load with STACK_ZERO will stop the backtracking.

Will remove the above comments.

>
> Other than that LGTM
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>> +__msg("4: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8=0000????")
>> +__msg("5: (0f) r1 += r2")
>> +__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
>> +__msg("mark_precise: frame0: regs=r2 stack= before 4: (71) r2 = *(u8 *)(r10 -1)")
>> +__naked void partial_stack_load_preserves_partial_zeros(void)
>> +{
>> +       asm volatile (
>> +               /* fp-4 is value zero */
>> +               ".8byte %[fp4_st_zero];" /* LLVM-18+: *(u32 *)(r10 -4) = 0; */
>> +
>> +               /* load single U8 from non-aligned stack zero slot */
>> +               "r1 = %[single_byte_buf];"
>> +               "r2 = *(u8 *)(r10 -1);"
>> +               "r1 += r2;"
>> +               "*(u8 *)(r1 + 0) = r2;" /* this should be fine */
>> +
>> +               /* load single U16 from non-aligned stack zero slot */
>> +               "r1 = %[single_byte_buf];"
>> +               "r2 = *(u16 *)(r10 -2);"
>> +               "r1 += r2;"
>> +               "*(u8 *)(r1 + 0) = r2;" /* this should be fine */
>> +
>> +               /* load single U32 from non-aligned stack zero slot */
>> +               "r1 = %[single_byte_buf];"
>> +               "r2 = *(u32 *)(r10 -4);"
>> +               "r1 += r2;"
>> +               "*(u8 *)(r1 + 0) = r2;" /* this should be fine */
>> +
>> +               "r0 = 0;"
>> +               "exit;"
>> +       :
>> +       : __imm_ptr(single_byte_buf),
>> +         __imm_insn(fp4_st_zero, BPF_ST_MEM(BPF_W, BPF_REG_FP, -4, 0))
>> +       : __clobber_common);
>> +}
>> +
>>   char two_byte_buf[2] SEC(".data.two_byte_buf");
>>
>>   SEC("raw_tp")
>> --
>> 2.34.1
>>

