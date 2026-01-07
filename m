Return-Path: <bpf+bounces-78125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AFCFED41
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 17:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B21413016671
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444339C62D;
	Wed,  7 Jan 2026 15:53:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB91399A54;
	Wed,  7 Jan 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801198; cv=none; b=CI+D9Ba3r+x34eKskEKDcGZd8fqsHSGD1+uA+Va5hVVUqVlo52roWQH3scIJjcRs0yaY0M8n9jbo4OoG7e/URC9BMddY/eMP4fxNT3VxUzYIpAwXALdMZSGSYFEs7/LEJZQC9htItatYZJRaiN2Kqv0UI0QfdNdpYP92/62Hm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801198; c=relaxed/simple;
	bh=Tt2AtrMSewMzULqLE1VhdgEpismAuO+TcOXUIcITff0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfeT2CtMNjEoZM/Wkw3WUTkqP8JLxGrUNnotgKo+gzsLSWhr7NdT+/9dgWa/f3eEnFytUhh6SMAFD2LGtBHlLLET5plt3xMb+q1xy7RJfV7/I/7SNAmymi83M3MiyeAePA9JgTB2PXD/dV0lwwce3MkJ8hhv9tszQCAuRKThu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 5F3D8140441;
	Wed,  7 Jan 2026 15:52:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id A363F20019;
	Wed,  7 Jan 2026 15:52:49 +0000 (UTC)
Date: Wed, 7 Jan 2026 10:53:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Will Deacon
 <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mahe Tardy
 <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <20260107105316.2b70a308@gandalf.local.home>
In-Reply-To: <aV4X5Yx07LomQji4@krava>
References: <20251105125924.365205-1-jolsa@kernel.org>
	<aVfbqYsWdGXu4lh8@willie-the-truck>
	<20260104223415.0a31f423c861c0b651de966b@kernel.org>
	<20260105162220.6ba5129a@gandalf.local.home>
	<aV4X5Yx07LomQji4@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: d78ujc6wjwrs4np7zp9k9df8wcrg8spq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A363F20019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19y53fBfBOjUg/Mlrbjm27/1NrjOMyHETA=
X-HE-Tag: 1767801169-452600
X-HE-Meta: U2FsdGVkX1+hldrlx96Y7+EcduT/AqiVoSH8QmMOWvVLBMrUv1IVv6IO41fhZ4RVAeaEuFfgunBNpxHvG1O1TGLPQ3JiX1a9nfHStvtPjZ+qC6M8Sj4BCMDlqjH//NEprQR2dFXHSO2Q85qKa8ZWd1JmEn8jCjbgD2LzKFFzpxSkbyws8Nw8h5fNGqR9CTdBpatoTRQgXUAqlhWk4gttSADniPTDpYyuvv2n2RwYFSFCyOQdUT8abxn44s6dkRK5JKxdWq5ttP5G1uGsINNp7MeadAIwBGYnyflqKunhECWqX14W7J8qUJy2BT5whAKLzhYH1LrALs1vk1R4DAhVELV+ikzLGxZWFRGjXFouFsoppxNwQBvckPM+gbwdLbSg

On Wed, 7 Jan 2026 09:23:01 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> ---
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1621c84f44b3..177c7bbf3b84 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +/*
> + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> + * @fregs: The ftrace_regs to update from @regs
> + * @regs: The partial regs from ftrace_partial_regs() that was updated
> + *
> + * Some architectures have the partial regs living in the ftrace_regs
> + * structure, whereas other architectures need to make a different copy
> + * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
> + * if the code using @regs updates a field (like the instruction pointer or
> + * stack pointer) it may need to propagate that change to the original @fregs
> + * it retrieved the partial @regs from. Use this function to guarantee that
> + * update happens.
> + */

I think the kernel doc should go into the generic function, and this just say:

  /* See description of this function in the generic header */

or something similar.

Also, should probably have the description in the general function say:

  *
  * For architectures that need to update @fregs from @regs, this function needs to be
  * defined.

Or something similar.

-- Steve

> +static __always_inline void
> +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> +
> +	if (afregs->pc != regs->pc) {
> +		afregs->pc = regs->pc;
> +		afregs->regs[0] = regs->regs[0];
> +	}
> +}
> +
>  #define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
>  		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
>  		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 770f0dc993cc..ae22559b4099 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -213,6 +213,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +static __always_inline void
> +ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs) { }
> +
>  #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6e076485bf70..3a17f79b20c2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>  	err = bpf_prog_run(link->link.prog, regs);
>  	bpf_reset_run_ctx(old_run_ctx);
> +	ftrace_partial_regs_update(fregs, bpf_kprobe_multi_pt_regs_ptr());
>  	rcu_read_unlock();
>  
>   out:
> -- 

