Return-Path: <bpf+bounces-74253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72211C4F768
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E80984E8A29
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C956F283FFB;
	Tue, 11 Nov 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0o+v9Ft"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3240280A56
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886292; cv=none; b=FcaS2HIMXB3Wv2cGrzCQ35G475ibkEVbKhGsdvvILKQTeBQsL4SwE3TC5HB4kkpi7dSAPn8IVdjNu269PDxE06jof5OMqx8wL4q/y4dBCMcACU4fQK/aZ3XTjOSW0EfM1WIP1sAVAmFDz2uyMz0sTV5k77Bi7dpBG+o6ERemnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886292; c=relaxed/simple;
	bh=vaTOrvk5AqUtkNObVdLIbj0ct6a6zxJ4sj6hl2nt5yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLJ8d/TuTQBOtPPnbc5AL/fonnw5xynKT5DWvXiMklPwpjhhMVvw3jhnG9eUlZMIiWHIcr6ORJurLVMvXLKA8HxZgPQo3cveCEZGGxgW6jBPpMj4Qsd2guNg0ruI5AuxQ3OxqkqdRXPJIcFtLh+fISZtQaa3VIw50fLFIdFf42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0o+v9Ft; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7e438a8so3965998f8f.2
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762886289; x=1763491089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4vGREZnTP+Em7qncpM2G9zE3MjBBi4hh66wqaHHu/0=;
        b=O0o+v9Ftq1UPRnykEknnA6ZOVZU220KoyyY7nDsMHd9NWpHn6E7S9NzxAlsOiUctt/
         Z5hFcJKc43hJ2Db4ZN9nppbLcquASTqWQEma9GG5O8hL5w4Mv/7U58cYLVazjdiZJLnE
         wDzwZbiJ+qHo1V/opqPA4xgg2l/N/5s49QsuOaRBdVqYbjl16jppXMt/3imn84+w72dC
         v3C3Ci31X67Hc9qXEnHIwUmPwfKQiSgSgNyaB6VEHfsmQa8Phzki4kufOTGEJBhbL3Yn
         nJic5RdX4q+LCmN7jFpygE9ukVYGZZWXqT+iTeW1Yglb1VAF2k45xMgxdqBsJP3fWlRT
         ZebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886289; x=1763491089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4vGREZnTP+Em7qncpM2G9zE3MjBBi4hh66wqaHHu/0=;
        b=S7Fe0P/V1XVYTVUrLMDdV/9d9rw++DufTR2EdHA642xkLVzBXpqrx4XTWsXBwZtm8e
         xCrLvOmQxQ5NLuDlWTKXpfF6eFzBTY0uD/KJlo8hXXGtsWNZ3tWdMOOPxfNJ3Cpto368
         c8GSP08Au85hU68bUgLRbWNWZCc7Nvq2f6wV8T7Bg44bRa1rDwjrJeeU/b1Azg51CK0j
         Qi5lpTzmFEU7o44q+gyWsj8YiCJHUNfrLi0USpWy5/5MpVFv2zZ6PtpLUZXpC/PC5NuL
         mBz6AQeM+9+XJgSX/J9lpJwNUgZH8yzN/r+I49/HG9+VTP9erebMbDakgOTXYtBB6UGp
         K7hg==
X-Forwarded-Encrypted: i=1; AJvYcCVZOvFRQ1SUlF9Ws+MaSiT6Y448VlvYCjXld74a00/4icdo2rhzmHBxIwQKVA9CwVLk45c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qG07EvpOHU2E9ePNEjAOf82KeKh+85evd7jNpPF7JnBvf4At
	9Z77rrKSKqzv+XIXrp8ivG9wXP+NhzJveMz4WQraK+q7wVDJf5o3ePnu
X-Gm-Gg: ASbGnctdfxs2akZLOgw46dN0IFHqfoWbt4DQNpb4z1QKHCK8B+85YHgGamKPUqh2Cy8
	OIs8sxFrsh3IbtytsdVsXEhbXjaXuHQTVOxJvibjHYBvTzhDFH9ET3Wxj010eCk2Xbi+YRKDken
	pOt4hLSt1317mN+OMffYAJji4Fj8Bn8P0XFR5lzuSgJ1TGpDs/iqZH+Q8wuj5tpruWU5eV+QTUj
	DKu/cm4MEJvHCkOTM1X+cTvsHTJigMa7mw6m0dBbtPnyo2SVQIrk7BdquFYzrAJ365refIs5Ca5
	IOQg2AmsE0Hu+BNlPUPi7yVp4XfsK9acL/kUPf2G0XEciVOMR+dvpHEzqEcLpELDZcBWasq2L/O
	FOm1T0aZnzUBqrjv7hEvw/z9AXWIFUm+o/BKTJB5+KIUwH/ByqXn3LXoPxh3v/JCG5lmGjE0+bP
	sv8uZVqTtWQzfGr4YQXHWfJPQkTCysFynrYTO+JhweF99j5ZTi
X-Google-Smtp-Source: AGHT+IELd7PDG/uCIlEFIbRG8EVrMw05zY507MkqQ7L+baqw30fe7wMlWxnMNP2nLMf9PlPz9nb9ww==
X-Received: by 2002:a5d:5848:0:b0:429:d290:22f2 with SMTP id ffacd0b85a97d-42b4bdafedamr204301f8f.38.1762886288670;
        Tue, 11 Nov 2025 10:38:08 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:f58c:f027:1ceb:6a54? ([2620:10d:c092:500::4:aade])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679e06csm29232868f8f.47.2025.11.11.10.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:38:08 -0800 (PST)
Message-ID: <052b04eb-9b97-40be-965c-bb5aa8c88a49@gmail.com>
Date: Tue, 11 Nov 2025 18:38:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: verifier: initialize imm in kfunc_tab in
 add_kfunc_call()
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
References: <20251111160949.45623-1-puranjay@kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251111160949.45623-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 16:09, Puranjay Mohan wrote:
> Metadata about a kfunc call is added to the kfunc_tab in
> add_kfunc_call() but the call instruction itself could get removed by
> opt_remove_dead_code() later if it is not reachable.
>
> If the call instruction is removed, specialize_kfunc() is never called
> for it and the desc->imm in the kfunc_tab is never initialized for this
> kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
> do_misc_fixups() doesn't sort the table correctly.
> This is a problem from s390 as its JIT uses this table to find the
> addresses for kfuncs, and if this table is not sorted properly, JIT can
> fail to find addresses for valid kfunc calls.
>
> This was exposed by:
>
> commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
>
> as before this commit, desc->imm was initialised in add_kfunc_call().
>
> Initialize desc->imm to func_id, it will be overwritten in
> specialize_kfunc() if the instruction is not removed.
>
> Fixes: d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>
> This bug is not triggered by the CI currently, I am working on another
> set for non-sleepbale arena allocations and as part of that I am adding
> a new selftest that triggers this bug.
>
> Selftest: https://github.com/kernel-patches/bpf/pull/10242/commits/1f681f022c6d685fd76695e5eafbe9d9ab4c0002
> CI run: https://github.com/kernel-patches/bpf/actions/runs/19238699806/job/54996376908
>
> ---
>   kernel/bpf/verifier.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1268fa075d4c..a667f761173c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3371,6 +3371,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>   
>   	desc = &tab->descs[tab->nr_descs++];
>   	desc->func_id = func_id;
> +	desc->imm = func_id;
>   	desc->offset = offset;
>   	desc->addr = addr;
>   	desc->func_model = func_model;
Thanks for sending the fix.
I'm not sure if this is enough, though. Don't you need to run entire 
calculation
for the desc->imm, like in the original, before
d869d56ca848 ("bpf: verifier: refactor kfunc specialization")?

     if (bpf_jit_supports_far_kfunc_call()) {
         call_imm = func_id;
     } else {
         call_imm = BPF_CALL_IMM(addr);
         /* Check whether the relative offset overflows desc->imm */
         if ((unsigned long)(s32)call_imm != call_imm) {
             verbose(env, "address of kernel func_id %u is out of 
range\n", func_id);
             return -EINVAL;
         }
     }
     desc->imm = call_imm;

I think it would be right to reuse that hunk in both places:
  add_kfunc_call() and specialize_kfunc().

