Return-Path: <bpf+bounces-76883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3629CC8F52
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B162F3201C0F
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F083376A2;
	Wed, 17 Dec 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dziriS7F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90113334C3C
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990601; cv=none; b=MLocM/Fh6Qi9e/0Vs0KC5DMQLpJjawnhPJELCaWv/OEIsRN2ssS1Cgj3/vh+2qPiwV4YhcM0sZLc+qh7ZUgg1DT/LJ13mwJzEIa+qnGVlTmSlT34XTTHFAobXOuiweFLqekcRfut0xPSsIS/VL4s5Njj8YeJ1jVi5mqconsceqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990601; c=relaxed/simple;
	bh=SeqW/YfpnWDxPVNYtbqSKl0YWcrno/tyn+o7z5/WSxg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kKBIYqgQBNuRKIogbBar+t9LOxF6/RzciZwR3wmQs33C7RDBK74AAfVMF3c7gay2asVmkGtVs+nKRpZa7uYRqBj5ZOjzAUZ9IBZHnQk+0iYNdmGTC4cUF+AHp/oAR244e8tAAGHUUtaEGQZW4xm9g5Eyd3blJwNIjHY07QFV5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dziriS7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A1CC4CEF5;
	Wed, 17 Dec 2025 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765990601;
	bh=SeqW/YfpnWDxPVNYtbqSKl0YWcrno/tyn+o7z5/WSxg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dziriS7FqYRr6/m+ST0K8exbrQChygstOz747HtpYvSUdHkYP2HAXMLeaY2zO/Y+D
	 CaGU4WkQnd5e5IHRN9SifqLQWVHui3o/K1vdJzbpBsvOUofvD4sIm+7kVpe2xgNMo8
	 ZxZlJdBU3N+7acmF0aqx7gf+dJ00Ab7elUxGXQf9GiHL2tI41MT9VclPeubO6adZvH
	 vztDPI+fVfNB/zBrw84Bf0CyuN7mXzR0TwewI0DgPiR5wwN7mPcBoPp0u8c3fVKfoU
	 4RhbTgfbWwXmiZOX2+bKhDU+HttJiigdcPdxlgceHbuHSKssEPqhmiA/eOjiVSvyGX
	 mUo3UQFG0AN9w==
Content-Type: multipart/mixed; boundary="===============9198593638191686786=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
In-Reply-To: <20251217162830.2597286-3-puranjay@kernel.org>
References: <20251217162830.2597286-3-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by not using atomics
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,catalin.marinas@arm.com,will@kernel.org,mark.rutland@arm.com,linux-arm-kernel@lists.infradead.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Dec 2025 16:56:40 +0000 (UTC)

--===============9198593638191686786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2da986136d26..654fb94bf60c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
>
>  static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
>  {
> +#ifdef CONFIG_ARM64
> +	u8 rctx = interrupt_context_level();
> +	u8 *active = this_cpu_ptr(prog->active);
> +
> +	active[rctx]++;
> +	barrier();
> +	if (get_unaligned_le32(active) != BIT(rctx * 8))
> +		return false;
> +
> +	return true;
> +#else
>  	return this_cpu_inc_return(*(prog->active)) == 1;
> +#endif
>  }

Can preemption between the increment and check cause a counter leak on
CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
(documented at include/linux/rcupdate.h:856).

Consider this scenario on an ARM64 system with PREEMPT_RCU:

1. Thread A increments active[0] to 1
2. Preemption occurs before Thread A reaches the check
3. Thread B on same CPU increments active[0] to 2
4. Thread B checks: sees 2 != BIT(0), returns false
5. Thread A resumes, checks: sees 2 != BIT(0), returns false
6. Both threads return false, neither runs BPF
7. Neither calls bpf_prog_put_recursion_context() (see
   __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
8. Counter permanently stuck at 2, all future BPF on this CPU fails

The old atomic code handled this correctly because this_cpu_inc_return()
completes atomically, ensuring Thread A reads the value 1 before Thread B
can interfere. With non-atomic operations, Thread A increments but hasn't
read the value yet, allowing Thread B to interfere and cause both threads
to see the modified value.

Is there a guarantee that same-context preemption cannot occur in the BPF
execution path on ARM64, or does this need additional synchronization?

> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
>
>  static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
>  {
> +#ifdef CONFIG_ARM64
> +	u8 rctx = interrupt_context_level();
> +	u8 *active = this_cpu_ptr(prog->active);
> +
> +	barrier();
> +	active[rctx]--;
> +#else
>  	this_cpu_dec(*(prog->active));
> +#endif
>  }

The barrier() is placed before the decrement. Does this provide the needed
ordering guarantee, or should there also be a barrier after the decrement
to ensure visibility?

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c66316e32563..b5063acfcf92 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>  		vfree(fp);
>  		return NULL;
>  	}
> -	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
> +	fp->active = __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), 8,
> +					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));

The allocation changes to u8[4] for all architectures, but the non-ARM64
code path still uses *(prog->active) which now dereferences only the first
byte. This changes the counter from int (typically 4 bytes, range ~2^31)
to u8 (1 byte, range 256). While 256 recursion levels is sufficient in
practice, is this intentional for non-ARM64 platforms, or should they
continue using a full int-sized allocation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20310266487

--===============9198593638191686786==--

