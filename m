Return-Path: <bpf+bounces-76830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0BCC64FC
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B55304EF45
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496B335090;
	Wed, 17 Dec 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP/rph8l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E160334C28;
	Wed, 17 Dec 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954501; cv=none; b=ei8wAQZ2efbjTZUVWd7WxpYFU7NjdjnM7IayLoOdSCg3kRK862Sd3m27ky+n/4szTpVKUMN8XxMNgUfSqIU7CtIYQQC9rwTmXdbi9lg8gxx5dkmY/Q3sk8koGp/gkynd4FMowx+sVbRlZ6dE5j1wG9Md11b8uIY+MIeMiopBV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954501; c=relaxed/simple;
	bh=6PJWOtpDQ9cOYWOwCsHXA2TRbpy+sm5mjMROo8KKx34=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P2Y2kOIKeHwTlYwA03RsIsxOCfRKRFmKN2pInF3p5qbRjq+K96PKFXmRy4sTKH0KNhRsGcf9qxMvn5zMip/hkYbrJzFGrNdZ6vMPvVW6Xp+WbDtjP9LwqOAxD1fNLWZJ2pt0ZfM+a4K3JvASM2OyXl2bz1StaOeC1EYtzUak+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP/rph8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F37C4CEF5;
	Wed, 17 Dec 2025 06:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765954500;
	bh=6PJWOtpDQ9cOYWOwCsHXA2TRbpy+sm5mjMROo8KKx34=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mP/rph8lOarV44aMA3FHfqZYEW7xW5YBS+TzAi1/qXDU1s8I0VdJfBfhFQ+3BpkBh
	 5nLpYE/dG8v1sxrIDKNY0qPUY/2NEmfNbO19ACq/ME9D+BC2+VhHhcqV6etD1rDpy9
	 NPZtw2YPx9SkVUTtj1J4EdI1/cbsEmBHW1xswNbHXJTTTASzDEMA0xceB8c0OGz3aO
	 8W5WU4vKmZ98rs97qRfc2FcmCo4wAj96U1+Sd5k6vd2CeSwfxHg4E3+AeezwGcNYvl
	 OHW1MHKGbStKNgNncacAxZLvm7ebWNSi/apCQXWbh9I9p3zwqaDBsUNUuFOiewbMQv
	 I3JqaRXf6r0vA==
Content-Type: multipart/mixed; boundary="===============1386342668638731083=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c7c7239a6f89e685f69093ff84fe686c75cf6b9b051dcbf812841f00ab3bc31@mail.kernel.org>
In-Reply-To: <20251217061435.802204-2-duanchenghao@kylinos.cn>
References: <20251217061435.802204-2-duanchenghao@kylinos.cn>
Subject: Re: [PATCH v4 1/7] LoongArch: ftrace: Refactor register restoration in ftrace_common_return
From: bot+bpf-ci@kernel.org
To: duanchenghao@kylinos.cn,yangtiezhu@loongson.cn,rostedt@goodmis.org,mhiramat@kernel.org,mark.rutland@arm.com,hengqi.chen@gmail.com,chenhuacai@kernel.org
Cc: kernel@xen0n.name,zhangtianyang@loongson.cn,masahiroy@kernel.org,linux-kernel@vger.kernel.org,loongarch@lists.linux.dev,bpf@vger.kernel.org,duanchenghao@kylinos.cn,youling.tang@linux.dev,jianghaoran@kylinos.cn,vincent.mc.li@gmail.com,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Dec 2025 06:55:00 +0000 (UTC)

--===============1386342668638731083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
> index d6b474ad1d5e..5729c20e5b8b 100644
> --- a/arch/loongarch/kernel/mcount_dyn.S
> +++ b/arch/loongarch/kernel/mcount_dyn.S
> @@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
>   * at the callsite, so there is no need to restore the T series regs.
>   */
>  ftrace_common_return:
> -	PTR_L		ra, sp, PT_R1
>  	PTR_L		a0, sp, PT_R4
>  	PTR_L		a1, sp, PT_R5
>  	PTR_L		a2, sp, PT_R6
> @@ -104,12 +103,17 @@ ftrace_common_return:
>  	PTR_L		a6, sp, PT_R10
>  	PTR_L		a7, sp, PT_R11
>  	PTR_L		fp, sp, PT_R22
> -	PTR_L		t0, sp, PT_ERA
>  	PTR_L		t1, sp, PT_R13
> -	PTR_ADDI	sp, sp, PT_SIZE
>  	bnez		t1, .Ldirect
> +
> +	PTR_L		ra, sp, PT_R1
> +	PTR_L		t0, sp, PT_ERA
> +	PTR_ADDI	sp, sp, PT_SIZE
>  	jr		t0
>  .Ldirect:
> +	PTR_L		t0, sp, PT_R1
> +	PTR_L		ra, sp, PT_ERA
                     ^^^^^^^^^^^^^^^^^^^
Does this break existing ftrace direct trampolines?

Before this change, direct trampolines received:
  ra = parent return address (from PT_R1)
  t0 = traced function address (from PT_ERA)

After this change, direct trampolines receive:
  t0 = parent return address (from PT_R1)
  ra = traced function address (from PT_ERA)

The sample trampolines in samples/ftrace/ were written for the old
convention. For example, samples/ftrace/ftrace-direct.c does:

  my_tramp:
    st.d  $t0, $sp, 8    # Save what it thinks is traced func addr
    st.d  $ra, $sp, 16   # Save what it thinks is parent addr
    bl    my_direct_func
    ld.d  $t0, $sp, 8    # Restore
    ld.d  $ra, $sp, 16   # Restore
    jr    $t0            # Jump to what it thinks is traced function

With the new convention, the sample would save parent address in the
t0 slot, restore it to t0, and then jump to the parent instead of the
traced function, skipping the traced function entirely.

This was fixed later in commit 055e392f3be7 "LoongArch: ftrace: Adjust
register stack restore order in direct call trampolines" which updated
all the samples to match the new convention. However, any out-of-tree
direct trampolines written before this commit would be broken by this
change.

Was this ABI break intentional? The commit message mentions matching
"the state when ftrace was entered" but doesn't explain why breaking
compatibility was necessary. RISC-V uses the opposite convention
(t0 = traced func, ra = parent), which the original LoongArch code
matched.

> +	PTR_ADDI	sp, sp, PT_SIZE
>  	jr		t1
>  SYM_CODE_END(ftrace_common)

[ ... ]

> @@ -161,6 +165,8 @@ SYM_CODE_END(return_to_handler)
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  SYM_CODE_START(ftrace_stub_direct_tramp)
>  	UNWIND_HINT_UNDEFINED
> -	jr		t0
> +	move		t1, ra
> +	move		ra, t0
> +	jr		t1
>  SYM_CODE_END(ftrace_stub_direct_tramp)
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20293821855

--===============1386342668638731083==--

