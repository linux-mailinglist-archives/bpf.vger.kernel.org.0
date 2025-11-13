Return-Path: <bpf+bounces-74355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32764C561E2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C29A3A5BEB
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11732ED5A;
	Thu, 13 Nov 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4a7/pke"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F308329382
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020270; cv=none; b=sdr7su4IT5UrlMOnYp8A+vRhMcRDmD1EAkHRc8eOUuURELbTXQCoksFkq1aIOL7WSeEFMoC/HLdn4dEhOAgUpf6g6PxNJcCUf1NfLg72KgKtggFvLoEGek0wiFCMk/mur2GIGnmR3ODxuoCKdZ6KEBhA7sbCL+MsRLOwEzSq37E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020270; c=relaxed/simple;
	bh=9cETCkpZu+73CbYMxqUO2XKUMgco4Nbh9FZ9O75Z47M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCsi/2hZ3jWUDpOjWVaqTkYd/f85KmdgObb7KaWkcjBt6aHK37iVOoJadznFmaWPdrzoSxQnByEUcT/Xza9T21DYImD9WULEbKcAmFZjIkabADMVTRmHFVpMjlRiZ/hoDtjs+TKzrhNbcLh6+9DyTJfek2DwU0/Y3DLL8no/0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4a7/pke; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so957142a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763020266; x=1763625066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4ie9nWkncZ3cv8xdi5OzMmGRGX86lWEjgjZYnVw6xo=;
        b=V4a7/pketx4PI1pk3qXO7rHoShCutUZFeGIPk34JACA3z5JKMz2SNcBP2sw9SxSAlq
         Er00k7/k7x+X44VB+r3tIA2Xftd1jafD77H8vqJbFLTC31Gu+vZTcI8qMylcJjXg8AdY
         2fEBA3gW17qlSLqbmATSpceBocin6eRZ+5ObhzcPEeW6fOoQBy16BkLlGj65ckQp49tt
         AB1sB3wqPUeHhQfqG4yjvroXdVzIWXgRwT7qZUR9EzXnxxNrGGNbf5tJ2tLaP2C6Pn61
         AvZU5ju9/drUNr+5tQzQz8HD5obsA0w+fLx8dgzQ/jBETMuIbhpuP4q43gTBG/zmMIIu
         uJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020266; x=1763625066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4ie9nWkncZ3cv8xdi5OzMmGRGX86lWEjgjZYnVw6xo=;
        b=AXneqpFXeuWntzPG3WEiO/6ae7zY4Kq79/YegCxpHGsfRi6AKRzFVxH6AxJggFE6yc
         kCog71mcHx5nASav6Y7WppsMIDQk8hGFp19+hlAHhNa1GPjHkOaVyqNbkb/Yx4Ev7+Wh
         7zR0f48qXd3q+l5QIHZdZrnhg5gySl1JIzszQwZOw1FmKt9jS29XBme+l5Esg8coXwR6
         hbEBv9+AtS1GWws+I1W9kk3csisl4vgJAC3ms639dnZOAhjMhETnstW4W04mo47vSO3o
         OiDB2yIG4tZExvrONM5YrAc0EAiE0RT2Uyc+780Bw5lV9n1O0NChd+rpiQLlUo6GaiCn
         VYGw==
X-Forwarded-Encrypted: i=1; AJvYcCUJombLQV4ga7m5MuNRY1EhMpFE/YOGR2RHBh41tfAeLngoOv9RJYMKwFFi+JZHEKTgUgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkLwcO7n1Bs1c9QyJ25Sb1wOsyDhGXBp/dYCH8NzdKrO4la7A
	sv90KZia37Qsz6cMLwzmE4/gIvhWCzKwL6pika2bMoksKIfl5H5a7m7I
X-Gm-Gg: ASbGncusMYKyBSbHtr53IQPtun0x8+ibOtfIm2FW5+ZtL3AhJ7NPEsZvBDOoXlLC5Us
	euK9mmXM1GtpbC58ftRreEadUSQNke+UCaUhoeh+dt9p/kt0ySlOVxeR5KJdCiNyrNng43NZh76
	LLMzLR0zeRZJLId2Z1BU7kLN9CiuprNdoO7kxY+3PKLpDI/6TNUyw1IQJtUY0FTMIsO/iF2Z01p
	3ooMPPFadchABaMdRmoMhX2ipd2j42T7S/Rxd4eXld9VUCTEBKhpEdj7bggl9zOD/xTLC0pvAyY
	6qkfp9t+x55kBnaER7v2Bz41oQJIaRRDP37R1uChEgu/ERuXumhK8zAGLvu0Q+kc3C4H6LYoPo9
	2O/gUpEw0N3mv1I92XWwwhk8ijubuAg7iwUyvDYd3S1QhbpNCsY7OVHJJNUINe8dAaPZuMxYzGN
	Zoxu/XP6BnfV7y9n3NsVfJwBQ=
X-Google-Smtp-Source: AGHT+IHVrkl5ftPUCc2idnw2qC4J8BRUimnWx6JJY1s/gQB+ln/cURHHPYk7pTtS8ycN6UhNj5km9g==
X-Received: by 2002:a17:906:794e:b0:b3d:98fa:b3fe with SMTP id a640c23a62f3a-b7331b307e2mr650559466b.63.1763020266209;
        Wed, 12 Nov 2025 23:51:06 -0800 (PST)
Received: from krava (37-188-200-155.red.o2.cz. [37.188.200.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7359bfb238sm13421466b.14.2025.11.12.23.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:51:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Nov 2025 08:51:00 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aRWN5EnjEekA5VE4@krava>
References: <20251105125924.365205-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105125924.365205-1-jolsa@kernel.org>

ping, thanks

jirka

On Wed, Nov 05, 2025 at 01:59:23PM +0100, Jiri Olsa wrote:
> hi,
> Mahe reported issue with bpf_override_return helper not working
> when executed from kprobe.multi bpf program on arm.
> 
> The problem seems to be that on arm we use alternate storage for
> pt_regs object that is passed to bpf_prog_run and if any register
> is changed (which is the case of bpf_override_return) it's not
> propagated back to actual pt_regs object.
> 
> The change below seems to fix the issue, but I have no idea if
> that's proper fix for arm, thoughts?
> 
> I'm attaching selftest to actually test bpf_override_return helper
> functionality, because currently we only test that we are able to
> attach a program with it, but not the override itself.
> 
> thanks,
> jirka
> 
> 
> ---
>  arch/arm64/include/asm/ftrace.h | 11 +++++++++++
>  include/linux/ftrace.h          |  3 +++
>  kernel/trace/bpf_trace.c        |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ba7cf7fec5e9..ad6cf587885c 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -157,6 +157,17 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +static __always_inline void
> +ftrace_partial_regs_fix(const struct ftrace_regs *fregs, struct pt_regs *regs)
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
> index 7ded7df6e9b5..4cb1315522bb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -205,6 +205,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return &arch_ftrace_regs(fregs)->regs;
>  }
>  
> +static __always_inline void
> +ftrace_partial_regs_fix(struct ftrace_regs *fregs, struct pt_regs *regs) { }
> +
>  #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a795f7afbf3d..7b5768ced9b3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>  	err = bpf_prog_run(link->link.prog, regs);
>  	bpf_reset_run_ctx(old_run_ctx);
> +	ftrace_partial_regs_fix(fregs, bpf_kprobe_multi_pt_regs_ptr());
>  	rcu_read_unlock();
>  
>   out:
> -- 
> 2.51.1
> 

