Return-Path: <bpf+bounces-38298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85B962EBE
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B4281B61
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1F81A7068;
	Wed, 28 Aug 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oeL/GHFF"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE0188013
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867075; cv=none; b=DF8LWckco++z4RXjwrfzwQidl5S+PZs5a41GZQq83M8yext3/N/5VnrxU22b3daY0WwyV6aTTJVLMnNO8rINoZ1Zx9S1piOLOrAczl1ep99gcHZRH4B8JAp/X3UPBFFWw+Fe3uCN+GCBMiNTqSaYXc4y2yBPrPIlZzy+K3LKAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867075; c=relaxed/simple;
	bh=qE544IgORjsuKCgM+1/FNoCEJ6WjIbOm/2/VzeFWJxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzTBbr3AuNrp/U4wBGUDLndhTyvgHiplnDqM4JkLku3Wq88YbvLwQ73jY2pt4H2SmYCsF2Prmqy0HEVzrxieOF+px7OMhmRAGWahXTEOp7ynTv2+KvRx4f/iduvwMcDv/W9OWiPA1gIBLTFIVhYHz6l9Hl8RLgI43XgM74hHwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oeL/GHFF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <669bc1c6-2c8c-483f-8d38-0a705463a25d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724867069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5b44qG8MByrSjeIVGAHIZjnLcR1H2bOYorOvEoA02k=;
	b=oeL/GHFF+sqXIehgTHej7d4ec6mwXujqrrTtjRv+450RkHivLJqObVclYDx6yVqB4H72+m
	8cBQJf/Q0XV3elLZ/xK5rjhcFwluYjz1Sq+ECoAP24UKoJ0pKXEJr6D1hyrD9PO3STdbL9
	DTnXbrRPF+X1/FafldasdmRGaJa/wG8=
Date: Wed, 28 Aug 2024 10:44:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st
 insn of the prologue
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827195208.1435815-1-martin.lau@linux.dev>
 <CAADnVQJbGCB5Hjb8NPU7P0ZOwR_EWcREuxsBOvyo7cRggdioDA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQJbGCB5Hjb8NPU7P0ZOwR_EWcREuxsBOvyo7cRggdioDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 9:48 AM, Alexei Starovoitov wrote:
> On Tue, Aug 27, 2024 at 12:53 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> The next patch will add a ctx ptr saving instruction
>> "(r1 = *(u64 *)(r10 -8)" at the beginning for the main prog
>> when there is an epilogue patch (by the .gen_epilogue() verifier
>> ops added in the next patch).
>>
>> There is one corner case if the bpf prog has a BPF_JMP that jumps
>> to the 1st instruction. It needs an adjustment such that
>> those BPF_JMP instructions won't jump to the newly added
>> ctx saving instruction.
>> The commit 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and jump to the 1st insn.")
>> has the details on this case.
>>
>> Note that the jump back to 1st instruction is not limited to the
>> ctx ptr saving instruction. The same also applies to the prologue.
>> A later test, pro_epilogue_goto_start.c, has a test for the prologue
>> only case.
>>
>> Thus, this patch does one adjustment after gen_prologue and
>> the future ctx ptr saving. It is done by
>> adjust_jmp_off(env->prog, 0, delta) where delta has the total
>> number of instructions in the prologue and
>> the future ctx ptr saving instruction.
>>
>> The adjust_jmp_off(env->prog, 0, delta) assumes that the
>> prologue does not have a goto 1st instruction itself.
>> To accommodate the prologue might have a goto 1st insn itself,
>> adjust_jmp_off() needs to skip the prologue instructions. This patch
>> adds a skip_cnt argument to the adjust_jmp_off(). The skip_cnt is the
>> number of instructions at the beginning that does not need adjustment.
>> adjust_jmp_off(prog, 0, delta, delta) is used in this patch.
>>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
>>   kernel/bpf/verifier.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b408692a12d7..8714b83c5fb8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19277,14 +19277,14 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
>>    * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
>>    * jump offset by 'delta'.
>>    */
>> -static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
>> +static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta, u32 skip_cnt)
>>   {
>> -       struct bpf_insn *insn = prog->insnsi;
>> +       struct bpf_insn *insn = prog->insnsi + skip_cnt;
>>          u32 insn_cnt = prog->len, i;
>>          s32 imm;
>>          s16 off;
>>
>> -       for (i = 0; i < insn_cnt; i++, insn++) {
>> +       for (i = skip_cnt; i < insn_cnt; i++, insn++) {
> 
> Do we really need to add this argument?
> 
>> -               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
>> +               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1, 0));
> 
> We can always do for (i = delta; ...
> 
> The above case of skip_cnt == 0 is lucky to work this way.
> It would be less surprising to skip all insns in the patch.
> Maybe I'm missing something.

For subprog_start case, tgt_idx (where the patch started) may not be 0. How 
about this:

	for (i = 0; i < insn_cnt; i++, insn++) {
		if (tgt_idx <= i && i < tgt_idx + delta)
			continue;

		/* ... */
	}


