Return-Path: <bpf+bounces-31699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B6901B93
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 09:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71113282EF3
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2C1CFBE;
	Mon, 10 Jun 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmog98gL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4B28DBC
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003565; cv=none; b=O86EPv6zhhEZphBHaPnUEeQVnVx6K4DMWA0DFpHDzb/E1VCgc4DpKpJQcXTE2cPXWrvxv/yCo7KXM++8C9KTJ+LHCd5jdBlC8yS+NV9Sv8vAGNapM8b/Mohe7TQA+cMpCDIqdjL8eV1opFLRcFhHxo4AHqvlTeLAH30rlpZsCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003565; c=relaxed/simple;
	bh=5RFEgSxeGPheaUu0XR9OMvfPlSNHuJxyrdGVdk2P7OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGBkoGS/G+NoxGiTar9R4XsTgUtke2TfJh8fn4bvpggDDxbSzaQiSw6XzN5/23ED90e5J/h/oyt8cn6KEaOCxNsM0Q/DxfIbJ2FyJWw/bVTNCGu43TE3seqse0C+67cQS4Q2Db5uvPoMFKh56PJJ2se8MmmwIP4gqUuydUBD5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmog98gL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c31144881eso327277a91.1
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718003563; x=1718608363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tYRK0IeE6i/o9Alix3l+cqIm5e0X/CW2FCTJi3bbqM=;
        b=Nmog98gLn+wBpg3RdoEfuxvwBSdLWTuh/WlX63z9RZWIdKLubbsP+V2GAfy/t6vo04
         pPzsHnzpGKHKjURD8Mcts3XekkNEQ9DR5kc2xu4e0C3kHK/dZ0JTV2R8x3boB586F7ME
         RCRm74vl/C12sM4iQFUFnMQNTm/Q2SyMwvy7UVH9h62LeBDWSqsuPbjBYh6oUsusDehl
         jhC9221snKsS6hNjBHNn9x5LNG5llZovYrAMUGmT/loFgw+3X21oaFh8AyKk8W+7tK64
         E87s/tYqrks0tcvv0nzAPb+TOOv8m0svPLutFsFYbQJpbr+Mi2pWChSoXiSopfowIf1Y
         yPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718003563; x=1718608363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tYRK0IeE6i/o9Alix3l+cqIm5e0X/CW2FCTJi3bbqM=;
        b=w3dI6Mih3ryC1bghJUa/i4gC9mEn02XOvkNdYWs0OB6liHcmm2q/Mf+ftOnw8zr/6n
         KYtpUOfBxKub/weKXbyFal43vyWqLB2KbZ/qm+N9zMnZuo/8IScFMB6q31hIdpOnhbyr
         /nGruUslNDF+CYTybUXF0W5oyMfzCQg5PVVCTsoQ/qqX/noncC0uw5C51Q7IYxF4p2g9
         UhelYK8MY87hEGc+WAb7ze3gendvv3USVSlFlq6RMB/qFBwB2irTTe5rrlzoUxsvHQeV
         J0DUdhqPhQUqax83cQeVVK/4KOGKmEZ7YcKvAzDebDcmf3uAVyErOWdMI+05Moityakv
         IKUA==
X-Forwarded-Encrypted: i=1; AJvYcCUOse7uwjpPcfqqMIQBxxjpUNN+ALSX/Kom/EMiDrbCFRTGMs3p+KhvtQDe9Vse83LUo46fYb0Sfg8I2ACD9/0KFR7l
X-Gm-Message-State: AOJu0Yzs6ix9MrURUHh38eGmO5+FAiI6B339jh4LXvM0REBP2TdNxpjE
	ztAQwdGXo1NXQxaB+eAW7gi1bgIbDm8Bsflf4V35cQOnlrhtCAfC
X-Google-Smtp-Source: AGHT+IFlLC7DjqBsig0iRVtWN6a3nDSBUmR661HRR2nFYym5wj4KaRP52/EgYs1pkI/ZpeElt26U/g==
X-Received: by 2002:a17:90b:e86:b0:2c1:e54a:19b9 with SMTP id 98e67ed59e1d1-2c2bcc09816mr7665210a91.21.1718003563002;
        Mon, 10 Jun 2024 00:12:43 -0700 (PDT)
Received: from [10.22.68.7] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2a2430365sm7479454a91.54.2024.06.10.00.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:12:42 -0700 (PDT)
Message-ID: <5fd25602-5cbb-4bb7-89ab-6617f89b177c@gmail.com>
Date: Mon, 10 Jun 2024 15:12:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, verifier: Correct tail_call_reachable for
 bpf prog
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, kernel-patches-bot@fb.com
References: <20240609073100.42925-1-hffilwlqm@gmail.com>
 <37e6a405-9a8f-4406-9238-b22c4a8b5e6c@linux.dev>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <37e6a405-9a8f-4406-9238-b22c4a8b5e6c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/6/24 13:26, Yonghong Song wrote:
> 
> On 6/9/24 12:31 AM, Leon Hwang wrote:
>> It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
>> when bpf prog has tail call but 'tail_call_reachable' is false.
>>
>> This patch corrects 'tail_call_reachable' when bpf prog has tail call.
>>
>> [0] https://github.com/osandov/drgn
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>   kernel/bpf/verifier.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 81a3d2ced78d5..d7045676246a7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2982,8 +2982,10 @@ static int check_subprogs(struct
>> bpf_verifier_env *env)
>>             if (code == (BPF_JMP | BPF_CALL) &&
>>               insn[i].src_reg == 0 &&
>> -            insn[i].imm == BPF_FUNC_tail_call)
>> +            insn[i].imm == BPF_FUNC_tail_call) {
>>               subprog[cur_subprog].has_tail_call = true;
>> +            subprog[cur_subprog].tail_call_reachable = true;
> 
> This tail_call_reachable is handled in jit. For example, in
> arch/x86/net/bpf_jit_comp.c:
> 
> static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
>                              bool *regs_used, bool *tail_call_seen)
> {
>         int i;
> 
>         for (i = 1; i <= insn_cnt; i++, insn++) {
>                 if (insn->code == (BPF_JMP | BPF_TAIL_CALL))
>                         *tail_call_seen = true;
>                 if (insn->dst_reg == BPF_REG_6 || insn->src_reg ==
> BPF_REG_6)
>                         regs_used[0] = true;
>                 if (insn->dst_reg == BPF_REG_7 || insn->src_reg ==
> BPF_REG_7)
>                         regs_used[1] = true;
>                 if (insn->dst_reg == BPF_REG_8 || insn->src_reg ==
> BPF_REG_8)
>                         regs_used[2] = true;
>                 if (insn->dst_reg == BPF_REG_9 || insn->src_reg ==
> BPF_REG_9)
>                         regs_used[3] = true;
>         }
> }
> 
> and
> 
>         detect_reg_usage(insn, insn_cnt, callee_regs_used,
>                          &tail_call_seen);
>                 /* tail call's presence in current prog implies it is
> reachable */
>         tail_call_reachable |= tail_call_seen;
> 
> I didn't check other architectures. If other arch is similar to x86 w.r.t.
> tail_call_reachable marking, your change looks good. But you should also
> make changes in jit to remove those redundent checking.
> 

By searching tail_call_reachable in arch directory, excluding x86, other
architectures do not check 'prog->aux->tail_call_reachable'.

By checking jit of arm64/loongarch/riscv/s390, they have their own way
to handle tail call, unlike x86's way to detect tail_call_reachable.

I'll send PATCH v2 to remove the redundant detecting in x86 jit.

Thanks,
Leon

