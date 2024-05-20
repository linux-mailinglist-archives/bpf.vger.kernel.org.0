Return-Path: <bpf+bounces-30030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5780A8C9F82
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C732D1F21B9A
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68421136E2A;
	Mon, 20 May 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTkT68+P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A63135A7D;
	Mon, 20 May 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218456; cv=none; b=VO095OT3e4RjRZw3CZweFz3FjnOp0OipLPhNX6hADO+CQkxT9FNVdvQpZpexkQqs0tHw5p2NlI9xG573CYTQEQiynAI2A1jE2N6lyfR3lJGYBJ0z5MTwOnShP7KHC2YjgGouvW0/gVVg8iRLnDKaoL/eLgf3uocOgfWI+RJfLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218456; c=relaxed/simple;
	bh=ccHVmPe9XgTztqN7RxfgpU2taJrOAXSv9yZQHCm5KLo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlwHvjCJNgWZWGX5TgjTpWrD3ed/7fHTP8rOEygyfkyU5ftwoDodqX1vRXsdboWyvZIQeJ3N0nyXMJ1rFKmXkCK3Rdf5ZQrfQaJcUPoMthSuS+09JuT+8sXo6wcPdL5C17vXcmEYIMjnSzyDLoxfbVFXybdUEl0P2El6e4ECoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTkT68+P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4202c0d316cso13434365e9.1;
        Mon, 20 May 2024 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716218453; x=1716823253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUexGFxFSFLEzTKD6IsN+hOyH9PLOa0GPzXgPLrsHh0=;
        b=QTkT68+PXGUSV2TvevQ9LJpUItugngCEL1osSfXV3W/yLz6Ta44PJoEgQKmBRScmYm
         ro+37s0WhMNAoc0NEcZhriQIlGagsGMgc8OlEqyTTxzDK76w1KMoD+TA7VkdobX4xMJ1
         V1LMI6MoThbr8yiAwUxMjfw80qlcof7OInU5sdqg5XfNObeLAdyIP2+Ovppdnr1i7oFM
         ud1TzgzQ+IKcEDYi1xvCcoTjMgHTrYJbCyoIuEuR9stoK7T/JIdmN1LAp138o/L3OCw1
         w+U0KOYmMNCBY65rRq/Tbeu8SnhrJy6M2VXt6T6wJny8SBAsJLjqyI29Vj/tcZVHnsdk
         AqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218453; x=1716823253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUexGFxFSFLEzTKD6IsN+hOyH9PLOa0GPzXgPLrsHh0=;
        b=d4/M2QPh0qdDpcyDIuMTF+EEIirpmGL0CItQtSe+H8C0qU1vOQ1iqcBRu0fQc/LlOW
         2MmzFM7+gQd9IRf3vLTVbwZraZEZRt5BIrFYgkg8qAg5IRlJlBCPvU4q1+LXP/KGGdSq
         q5dEBIq4x4oIQaBumGLKMp0FOmdbW8abCiaNG3bkrIrqDlinGrx1wJA4O7ZJelGggg3T
         Xj6WNuz7l8g376C6yYU5QH9rAFFAx35DEA7dgsgNWyyyADfnOM2ddp08l9XqPSoLCxBh
         nV6XxuZ1xCg+ZqS8xykHLUEHSQ1xcqAs/QKJefwnF/UepNLepvAUxeaXt5hsPjGKp1fc
         qxlg==
X-Forwarded-Encrypted: i=1; AJvYcCWdQVPYnrRg5mp8umuAbT3dc4wyOw+ppckOhh1+4WuJ18tuRSW0SfivE0O+sQX4vLY8GraSnq/FTtEfP3b4fR07pfKz0SRnxau1kCYXnyXr+ljDvLe2hLg0y0UOcCK+6xmhcRdf8Q==
X-Gm-Message-State: AOJu0YwnBsJEORkuiINbdnZlSJS3GOgjSgKDJzQY090SOBFgKXoC++RP
	j8bbw49Op4JQNqejEr94V/Ug5Ohq3UiM0R/uN3Ca949wHmZWEW5G
X-Google-Smtp-Source: AGHT+IG7MPogB0k7COFS1tUiR/sBAETVMcNbWza+1u9DMPmIvR0RnHfe3APJ/NLtQMxZ1BhJm2klGw==
X-Received: by 2002:a7b:ca4e:0:b0:41b:4caa:554c with SMTP id 5b1f17b1804b1-420e19c7f3cmr54181165e9.2.1716218452632;
        Mon, 20 May 2024 08:20:52 -0700 (PDT)
Received: from krava ([2a00:102a:4030:3ad2:f918:d0bd:fbd5:61c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f8asm426039675e9.10.2024.05.20.08.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:20:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 May 2024 17:20:49 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, peterz@infradead.org,
	mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org,
	rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <ZktqUYRM79tYtdO1@krava>
References: <20240508212605.4012172-1-andrii@kernel.org>
 <20240508212605.4012172-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508212605.4012172-4-andrii@kernel.org>

On Wed, May 08, 2024 at 02:26:04PM -0700, Andrii Nakryiko wrote:
> When tracing user functions with uprobe functionality, it's common to
> install the probe (e.g., a BPF program) at the first instruction of the
> function. This is often going to be `push %rbp` instruction in function
> preamble, which means that within that function frame pointer hasn't
> been established yet. This leads to consistently missing an actual
> caller of the traced function, because perf_callchain_user() only
> records current IP (capturing traced function) and then following frame
> pointer chain (which would be caller's frame, containing the address of
> caller's caller).
> 
> So when we have target_1 -> target_2 -> target_3 call chain and we are
> tracing an entry to target_3, captured stack trace will report
> target_1 -> target_3 call chain, which is wrong and confusing.
> 
> This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> instruction being traced. If that's the case, with the assumption that
> applicatoin is compiled with frame pointers, this instruction would be
> a strong indicator that this is the entry to the function. In that case,
> return address is still pointed to by %rsp, so we fetch it and add to
> stack trace before proceeding to unwind the rest using frame
> pointer-based logic.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/core.c  | 20 ++++++++++++++++++++
>  include/linux/uprobes.h |  2 ++
>  kernel/events/uprobes.c |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5b0dd07b1ef1..82d5570b58ff 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2884,6 +2884,26 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
>  		return;
>  
>  	pagefault_disable();
> +
> +#ifdef CONFIG_UPROBES
> +	/*
> +	 * If we are called from uprobe handler, and we are indeed at the very
> +	 * entry to user function (which is normally a `push %rbp` instruction,
> +	 * under assumption of application being compiled with frame pointers),
> +	 * we should read return address from *regs->sp before proceeding
> +	 * to follow frame pointers, otherwise we'll skip immediate caller
> +	 * as %rbp is not yet setup.
> +	 */
> +	if (current->utask) {
> +		struct arch_uprobe *auprobe = current->utask->auprobe;
> +		u64 ret_addr;
> +
> +		if (auprobe && auprobe->insn[0] == 0x55 /* push %rbp */ &&

nice cactch, I was wondering if we should set some auprobe flag in
arch_uprobe_analyze_insn and test it here instead of matching the
instruction opcode directly, but that would probably be just more
complicated.. this is simple and in arch code, no np

jirka

> +		    !__get_user(ret_addr, (const u64 __user *)regs->sp))
> +			perf_callchain_store(entry, ret_addr);
> +	}
> +#endif
> +
>  	while (entry->nr < entry->max_stack) {
>  		if (!valid_user_frame(fp, sizeof(frame)))
>  			break;
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 0c57eec85339..7b785cd30d86 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -76,6 +76,8 @@ struct uprobe_task {
>  	struct uprobe			*active_uprobe;
>  	unsigned long			xol_vaddr;
>  
> +	struct arch_uprobe              *auprobe;
> +
>  	struct return_instance		*return_instances;
>  	unsigned int			depth;
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 1c99380dc89d..504693845187 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2072,6 +2072,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  	bool need_prep = false; /* prepare return uprobe, when needed */
>  
>  	down_read(&uprobe->register_rwsem);
> +	current->utask->auprobe = &uprobe->arch;
>  	for (uc = uprobe->consumers; uc; uc = uc->next) {
>  		int rc = 0;
>  
> @@ -2086,6 +2087,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  
>  		remove &= rc;
>  	}
> +	current->utask->auprobe = NULL;
>  
>  	if (need_prep && !remove)
>  		prepare_uretprobe(uprobe, regs); /* put bp at return */
> -- 
> 2.43.0
> 
> 

