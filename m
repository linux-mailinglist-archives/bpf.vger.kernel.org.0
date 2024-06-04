Return-Path: <bpf+bounces-31294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBD8FAEAE
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E4B1C21164
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A2143C42;
	Tue,  4 Jun 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2cYvu75"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A714372F;
	Tue,  4 Jun 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493071; cv=none; b=AG2NBc6/NoRYWPj/XhLDAa9Gx11BIeG952jx7NeA8gaWq2M4SxgLV9FokFhTegixWpVVPuWKUwst1TQtyC1KWpr3AQPVvh98ZYBQQbp/2EmmHIoorj5aVM8Gz7LDQL0bZihmLbD58/4OlpMdrEcvLFg9WYc9oqOy6D1mDVetvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493071; c=relaxed/simple;
	bh=gqPxLLFIvFNLGKkbGgnZi05F9Rbkh8sVZJXJ/mU6COA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDWpgnZuXMUjExEHC/aHCeG3/P3DbY+MSAoH5mJtiGiecc3Kih2zFbtGG2wa3nm0RBr0kVxE9mJWR8OrsN+uOdnkvJYJfQaO5te0TWbDjBOl1TZPvKB3fLNWbi8hMGmgj/o9vPivyzrLJgw5Nkw39X7ENZ3YcH1Saxiy5rQubgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2cYvu75; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso861485a12.2;
        Tue, 04 Jun 2024 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717493068; x=1718097868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ltAuQjMAH++f3qOCnPQRFmbVr9HCwuJEgMaJN+DdMU=;
        b=l2cYvu75u228DVoSdr60XKmmG0kVXFMwAsh5DANUPOVsrD31YvmNbX+pR/yBTDS69B
         tCf/47C3PW8R2nI+dEav60jyD8mBtKr5MPCZBKL5JhNmiE5Zfa289s+J4oYIVyJSayzt
         QY1UFw2JbpYixC96i5kTJ3clc3pMs31RAxlxlhlubpL/nQaAoGaPIxgVIpzhqp7jaFM9
         +PfXzXrYolfqbffdHrgCcRt8iOOfd6DrnKMGd+d7TlCkR9SDvekWwTtWw/C1fupy6LO5
         QmvRyS28YmlvpjRPTg4iWrp67gU31XM0qms5XPR8a6AgPbTqkiqkdQDL69+ooc1OfHtQ
         5JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717493068; x=1718097868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ltAuQjMAH++f3qOCnPQRFmbVr9HCwuJEgMaJN+DdMU=;
        b=fWagiOwk+eJCYFL5QTILRDZhTcC+63YqtwDp+6RKC/DfkhNoBFKR5cFHvyz4Ve1hhf
         Awf4kck3JIcHYIRjly6c3pX9Tf3o/W1LhdFS6dRNuIqzso7P9+5xd3KReRIBjq+/7z+y
         6AjgK0o2IeZyVGt/9GCWIu7ffjS/Udofrf6YFrcS/kMUFQAD5q/FGt8ViGhSOR5UkbEI
         cmFuKyoR8RAsnV9D3Z+48sig1QQzPehc7TViiZZv2C9SZuZBvL1bBKNCsNn/lVlRCp49
         mGZKToQhlF1HNBzDIRdVtXuBQhUiZg7koEWI4+Zk1RoV28c2BSmZWT3KFOTjje2wx9O0
         ulZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDEysbYKkH5q0T0svuqDUqZVtMjVzrLoyAkXMtiJyzRi53As6FvvjUAvvYGfsNTVLk2LMAdYnnGEcVgcLG0Nv7tmX/Vi0W5NkJDCwT9FuSSoqXxtJ2CTio/nhAB0WJWX4Z/vA/tQ==
X-Gm-Message-State: AOJu0YxPrHB7ruv0BvUCed/8jurkYJpmyXOEeKT6Oqkdkli6m+n2E49I
	C2FTvVd1tuVdey1oWE+dBdUn+qEw8X4MMAoHJtERzSHUtEquv7UL
X-Google-Smtp-Source: AGHT+IFXekwlYI8XtQwqY8vp2QT4uKTurhfHxbmDUvJeUBfCX5UXw4Mr71KpZ21FPYcf5fCzxUVOyw==
X-Received: by 2002:a17:907:7241:b0:a62:415b:b5c with SMTP id a640c23a62f3a-a681fc5bffemr914784766b.5.1717493067173;
        Tue, 04 Jun 2024 02:24:27 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ee715f45sm363047066b.94.2024.06.04.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:24:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jun 2024 11:24:24 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, peterz@infradead.org,
	mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org,
	rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <Zl7dSEnFWCb-4jXR@krava>
References: <20240522013845.1631305-1-andrii@kernel.org>
 <20240522013845.1631305-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522013845.1631305-4-andrii@kernel.org>

On Tue, May 21, 2024 at 06:38:44PM -0700, Andrii Nakryiko wrote:
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

I wonder we could use active_uprobe for this?

jirka

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

