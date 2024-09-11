Return-Path: <bpf+bounces-39642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AE975975
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD14D282542
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0D1B1D5E;
	Wed, 11 Sep 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDPV4Fd8"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918BF1B29A3
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075981; cv=none; b=T5kFuPaQUUtM5WNTEcU/Rxhe6Lxb2K015rvAvaytwseMMky1pZUtaMUU5OLOw/IOwoKjJHN6SdMN4RatXofKCZFHptS711e9fYdu+QGIAxz2ftbQUJbcTDa2yqfOk1VxEpQxvFhYojIAMpRakq7M+3BerQJUnUH6p/a5e0OxR1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075981; c=relaxed/simple;
	bh=56D9C4W/82Vl3+4H89O/gBwf1O6YdX34X3FTlWqBjIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSxv4SCLLdIbqamtOMoYT0plllQXwXIcYknZiTFUnv15nc0gjlhfwj7s9/uAYv/+CI/9eeb3ozau3wtvCfNNVst7rJCBF0V7hIWx7vXw3+yNbGH1W7fiMxCmRkXxK4jHF/Ljgtbljlk9hq1qtx4USAkplhoIB4c8It7PEeV1tR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDPV4Fd8; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <505da3cf-4dbf-4cbf-8881-62dcca76b878@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726075977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IYjlp/o3wEWCHx6azoDNE5McKpzo2fw+LXGObwXJDw=;
	b=UDPV4Fd80wqhHiHPqayWH6WOzDjs9tMY18rB9o8diRE8q6OTkqEdA0yVxv0ho1ZAjx5DcX
	49cyQxLeec1AXwQQ79VvfkBL640E36tyQ6QIzONIQc8Qq5RfPz2H9O52JsamE9UvIHbAG/
	0diXJKCSsb6pifTBSp/IlzwCk+X8KXQ=
Date: Wed, 11 Sep 2024 10:32:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix a sdiv overflow issue
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Zac Ecob <zacecob@protonmail.com>
References: <20240911044017.2261738-1-yonghong.song@linux.dev>
 <CAEf4Bzb26NF9=+k_+=pC8wwojsK_Y5kBwLMFVGC34oGQRXy25w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzb26NF9=+k_+=pC8wwojsK_Y5kBwLMFVGC34oGQRXy25w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/11/24 10:17 AM, Andrii Nakryiko wrote:
> On Tue, Sep 10, 2024 at 9:40 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Zac Ecob reported a problem where a bpf program may cause kernel crash due
>> to the following error:
>>    Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
>>
>> The failure is due to the below signed divide:
>>    LLONG_MIN/-1 where LLONG_MIN equals to -9,223,372,036,854,775,808.
>> LLONG_MIN/-1 is supposed to give a positive number 9,223,372,036,854,775,808,
>> but it is impossible since for 64-bit system, the maximum positive
>> number is 9,223,372,036,854,775,807. On x86_64, LLONG_MIN/-1 will
>> cause a kernel exception. On arm64, the result for LLONG_MIN/-1 is
>> LLONG_MIN.
>>
>> So for 64-bit signed divide (sdiv), some additional insns are patched
>> to check LLONG_MIN/-1 pattern. If such a pattern does exist, the result
>> will be LLONG_MIN. Otherwise, it follows normal sdiv operation.
>>
>>    [1] https://lore.kernel.org/bpf/tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com/
>>
>> Reported-by: Zac Ecob <zacecob@protonmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f35b80c16cda..d77f1a05a065 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20506,6 +20506,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                      insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
>>                          bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
>>                          bool isdiv = BPF_OP(insn->code) == BPF_DIV;
>> +                       bool is_sdiv64 = is64 && isdiv && insn->off == 1;
>>                          struct bpf_insn *patchlet;
>>                          struct bpf_insn chk_and_div[] = {
>>                                  /* [R,W]x div 0 -> 0 */
>> @@ -20525,10 +20526,32 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                                  BPF_JMP_IMM(BPF_JA, 0, 0, 1),
>>                                  BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
>>                          };
>> +                       struct bpf_insn chk_and_sdiv64[] = {
>> +                               /* Rx sdiv 0 -> 0 */
>> +                               BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
>> +                                            0, 2, 0),
>> +                               BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
>> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 8),
>> +                               /* LLONG_MIN sdiv -1 -> LLONG_MIN */
>> +                               BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_K, insn->src_reg,
>> +                                            0, 6, -1),
>> +                               BPF_LD_IMM64(insn->src_reg, LLONG_MIN),
> wouldn't it be simpler and faster to just check if insn->dst_reg ==
> -1, and if yes, just negate src_reg? Regardless of src_reg value this
> should be correct because by definition division by -1 is a negation.
> WDYT?

Yes. This should work! It utilized special property that -INT_MIN == INT_MIN and
-LLONG_MIN == LLONG_MIN.

For module like Reg%(-1), the result will be always 0 for both 32- or 64-bit operation.

>
>> +                               BPF_RAW_INSN(BPF_JMP | BPF_JNE | BPF_X, insn->dst_reg,
>> +                                            insn->src_reg, 2, 0),
>> +                               BPF_MOV64_IMM(insn->src_reg, -1),
>> +                               BPF_JMP_IMM(BPF_JA, 0, 0, 2),
>> +                               BPF_MOV64_IMM(insn->src_reg, -1),
>> +                               *insn,
>> +                       };
>>
>> -                       patchlet = isdiv ? chk_and_div : chk_and_mod;
>> -                       cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> -                                     ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +                       if (is_sdiv64) {
>> +                               patchlet = chk_and_sdiv64;
>> +                               cnt = ARRAY_SIZE(chk_and_sdiv64);
>> +                       } else {
>> +                               patchlet = isdiv ? chk_and_div : chk_and_mod;
>> +                               cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
>> +                                             ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
>> +                       }
>>
>>                          new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
>>                          if (!new_prog)
>> --
>> 2.43.5
>>

