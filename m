Return-Path: <bpf+bounces-38730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C1968DDD
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6B21C21DAF
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A771A3AB2;
	Mon,  2 Sep 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fA6Y7uNm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A581A3A8B
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302833; cv=none; b=lGaC3tWwJwd/X/2oc9ODs+QhlTYP7uDRl40HJfdqIN2kXPdEs8BEQ+nBmUhRWctkklURT7rIXvksj354xfiLqppna2IXSGeBX8J3sKPu1oSqIsfu8Ygw01JvrPUNT/rU+YZHIKMr4JSs846aqm2XlcY/lzA0ZRaSlxu9ioouQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302833; c=relaxed/simple;
	bh=LI900uzgGCQElfJqtf01iHNZkLmSZEe/42LMd0+O44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yla6OPom6kq6PSk3TfNIv+e8c3W6hJPJ6LoRAd5CtZ/NCAOIiomSDMqFhpkmT2WjlVR8oBrTZHFvjMjDidDvPwcMIkmPf1/PI6du0Ppz/EGLO9cu/mopT/XHu8VPqCW/hTr9e0BXHvCyvwWwK0MRNmCvxSKf8E1+IkTvBapfpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fA6Y7uNm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-534366c194fso4117680e87.0
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725302829; x=1725907629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NCSu3cKIwSHt25rKzyc3TLGkgrpQltQSLr6RUpbw+m8=;
        b=fA6Y7uNmbZiF+j5NZnnjA6qUmiMpsceMQWQzFk6ssH5bMcWKGpxR1l7e38MmLJiQy0
         9RNwNGSwavhQCnWaa/Lii/juRmEJW9CjH29TGM2F9ddCB0j/KmhSNbeFOsxTXaPQEJpW
         XFyztRIEE6/m60saEeaRue9sPU/TkK6TQ3OGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302829; x=1725907629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCSu3cKIwSHt25rKzyc3TLGkgrpQltQSLr6RUpbw+m8=;
        b=MT/xQvHznR3mlANk2ZMGNnmbgPJ/GZZuE3ueHeCjivt58EZwUG6w22wQ5AuyX/xktJ
         mXZRxC+BfbMPsO1c6NIPaU329rqz4XvZD0LWqSuyDqDLvbmj9f959fDdJwdnfmutyAOE
         PGgVTOLlZ6p0KZ7VCwO6ui29jYl+II4J5+mwYJWomw9r4KlRPmDPH8EpE3BSCe2pdukF
         3w1v0bGzGiMR/HJiUw22pCBBSyKoBtI1L6eWz8XO5XDtHKwHp94PRYL5SaaNTSctCWr1
         QIUEo6F9084G3s+f+WR3/dXFaYUNISmAeaYORIjCMUAjzG4Hak97a3rRkKzJrap1sxSe
         3dvw==
X-Forwarded-Encrypted: i=1; AJvYcCUz3sLMqq0rIuUUerVLlNwxx4Kdm/PiQeRhwszmljW+WGaMB5XkF+DAR18BN0DYCCbzzzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLOUSGYvXTH5MM5rxy+UirqW0H/5XduHtz8T22f20+sbxgczz
	0wKLSaYdOpeKiYsJS7BwUkJJ7zpAQIwsWV1RBLEDZLw2ZfRZGFt3jG2hdlz6MQwRzdn6QTtJDve
	7a5E=
X-Google-Smtp-Source: AGHT+IHqqe9koL+FbrBBLaPTP3OLor6IyrPtmNay3KeRVgYQL9MoLF94I8hnPrhuXrsoGvRSIdzHQA==
X-Received: by 2002:a05:6512:12d6:b0:52c:deba:7e6e with SMTP id 2adb3069b0e04-53546b4a1damr8814328e87.29.1725302828908;
        Mon, 02 Sep 2024 11:47:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bb6asm1717129e87.12.2024.09.02.11.47.06
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:47:08 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f4f8742138so50743131fa.0
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 11:47:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPpUAvYHlF9PIiTc+QFC2sMqrZbxoqIX9JDBWG2zIoqFveXiexfm7UPXqisLZ+RVMVJvU=@vger.kernel.org
X-Received: by 2002:a2e:bc0e:0:b0:2f1:6cd6:c880 with SMTP id
 38308e7fff4ca-2f610890881mr116441241fa.37.1725302826121; Mon, 02 Sep 2024
 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
In-Reply-To: <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:46:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Message-ID: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 11:08, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If Linus' objections were mainly about naming, perhaps what I am
> suggestion here may be more to his liking ?

Most of my objections were about having subtle features that then had
very subtle syntax and weren't that clear.

And yes, a small part of it was naming (I absolutely hated the initial
"everything is a guard" thing, when one of the main uses were about
automatic freeing of variables).

But a much larger part was about making the new use greppable and have
really simple syntax.

And the conditional case was never that simple syntax, and I feel it
really violates the whole "this scope is protected".

And no, I do not like Peter's "if_guard()" either.

Honestly, I get the feeling that this is all wrong.

For example, I searched for a few of the places where you wanted to
use this, and see code like this:

    #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)            \
    static notrace void                                                 \
    __bpf_trace_##call(void *__data, proto)                             \
    {                                                                   \
        DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);        \
                                                                        \
        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
                might_fault();                                          \
                activate_guard(preempt_notrace, bpf_trace_guard)();     \
        }                                                               \
                                                                        \
        CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data,
CAST_TO_U64(args)); \
    }

and it makes me just go "that's just *WRONG*".

That code should never EVER use a conditional guard.

I find *two* uses of this in your patches, and both of them look
com,pletely wrong to me, because you could have written the code
*without* that conditional activation, and it would have been *better*
that way.

IOW, that code should just have been something like this:

    #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)    \
    static notrace void                                         \
    __bpf_trace_##call(void *__data, proto)                     \
    {                                                           \
                                                                \
        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                \
                might_fault();                                  \
                guard(preempt_notrace)();                       \
                CONCATENATE(bpf_trace_run, ...                  \
                return;                                         \
        }                                                       \
        CONCATENATE(bpf_trace_run, ...                          \
    }

instead.

Sure, it duplicates the code inside the guard, but what's the
downside? In both of the cases I saw, the "duplicated" code was
trivial.

And the *upside* is that you don't have any conditional locking or
guarding, and you don't have to make up ridiculous and meaningless
temporary names for the guard etc. So you get to use the *LEGIBLE*
code.

And you don't have a patch that just renames all our existing uses.
Which was also wrong.

So no, I don't like Peter's "if_guard()",  but I find your conditional
activation to be absolutely wrogn and horrible too.

                 Linus

