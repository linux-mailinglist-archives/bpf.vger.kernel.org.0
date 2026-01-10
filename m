Return-Path: <bpf+bounces-78477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F7D0D96E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 18:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E3C3011403
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D4288C20;
	Sat, 10 Jan 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCWbzOE+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB328688E
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768064777; cv=none; b=cw0ZuAEFau7olMr9rMP6HT46zb6Fh1r+VJPMfFmiU6SpNrT1gbZOMkI1iRnTssmiuhh9SZfGNeNQSlRs167VJZy2mu8eFXrB4c1J5N/lDgxCrrtCe8A3kLUkOHdZVgTtmJqoLLJMNJ/05XtPhy4fleK8Dv6mFTpu6jHL4FOJ6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768064777; c=relaxed/simple;
	bh=ZgKkQQhJVH4KoUyUYAU4gBvTjAsrFKRPpfGehHQikOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyALdzY5Ti1tdDzsTp9Hy4fLGp3JrCq21+Bbop7RF+eflyNZtZu1vypA3VAuh3pgXqgi0wCAaOvOlNLAZzd9mTJTTEHyl0EBZrpb0d4owVaFX7z59FpF4DW6287mnPb5ve9h/12TKX3KdxD/sLoTfWQpGpQnAvLbIiDiLvpaGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCWbzOE+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d256c2e6so2014296f8f.3
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 09:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768064773; x=1768669573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32edYZCX+nxG87B8UKMbk1Tq/DYM0xHuea3J9HZlJwM=;
        b=lCWbzOE+hij2VN9DnMh7bvgmeob/xG8YRqLP61arYkoIkpZo7oTxzg9l1hu5ca2GY5
         bYDWeuRD2ljw0oe9E/JUT865B83h3rZSfhhlwFFUXhKdHdsFe8HRuqlRPYfLOzlJsQL5
         FX85mJjElf3u2umhRp/TJNqJfBgrfrrwGr5BEj/vuSZCxHAMFJNjcZ0bQ8izihgsIFTV
         lajzKXwTrC+FtimqvUV75uUNfQfZocDXDLpzDWzW89wy3L59k/vGsfScBvzLpdKGKPzB
         NLYr+nPfjxmglErHB6X7vbUv01SR+JbF77FTPcUmhjjjseNe8JpOL4NSwykBle5F1oXO
         lPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768064773; x=1768669573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32edYZCX+nxG87B8UKMbk1Tq/DYM0xHuea3J9HZlJwM=;
        b=uHIJqlgDlA/Q8SFt1slQrTrUM9IOfKoaU6d6McaShkadUX3gSfz2vBtJB0lvBc7H2S
         LCyPIhmLQc3d5QpmxhM+HF18I9nSkGyaNfqRDqfdVoagS1tIiTS/4i2XaR/tlW0KlDTM
         fTY53Jmx5lskJfDL5Mgb2taxVJe/gbX8VX5gu50lMldaP961c6ueGDPpFUPwvPetlhn9
         rOoXUvalY0hho5gYsP/IhYcA2hVWZsGCCTjFVMT1VORw9Zj0molKehgyrkhFICY8kzlH
         gILsKT4tYM9vG6kHWC6TgcgUrK2ddTR8x//rMwD2sLe050TTOoFTXHYodkqOw0wU14rk
         DceA==
X-Forwarded-Encrypted: i=1; AJvYcCUmH2hJ6yd206G1Q5JWUr+wlX5sd7dn25J4vGY/GiixKj6EU0Axtkv6IQemIZPsFLqaBs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BrXtQJjvuCwu5bidfz6kusYparPQKeLRREr4Z33cmjYXz3/a
	/PgknIISxsb/HfXqDxk83moWpb+xeWWIIDsYzqMf14Fg8yn2wZ1s+FQt
X-Gm-Gg: AY/fxX6t+lgc8KLhbfCNGBgzEW0dYCv97suWgFD36b878GFiMGTcjBErdKpgrEZ5meY
	+YMyWa4wVrjLjMEL8TWr2KPQnge2LxeYW+zWTlT39z3M72X4hy5RJdz/HdbMWn1mg/lSEYx5RII
	5k9AGH++bnX7wEKLLZHI4SfJ/KCwxGlYsfoMcF+a8IeK6iv0SpvA8rQgbi03Ee3ifofDtqd5U7m
	076KW4XH/1TRO0/N2KrRzDJHvSIIQb7HFytKTLoS2+mOk24EQI5hAAEOFmp1DzWwFWyfkB45zPH
	ZPMIzTlMUoJo2N5e3pUA1XLcaRspc7w2cWRPgqu0Id/H70rmSOpmql1dXXT6zZv46umKTkSncwK
	bE+cgcQcjhkyFempUn626ARRYa0YGgLPoc4tWkM1QcB3TJJWzpP0DuZknK45T6q6M1+inSU3ivW
	s=
X-Google-Smtp-Source: AGHT+IG0Ti6DzshFViKpEmON8fAI3DAmGgT0yWSR0PX1XYk1V7FQ0GIt3qDuCMNIYEkaE/4289eXjA==
X-Received: by 2002:a05:6000:2084:b0:430:f742:fbb8 with SMTP id ffacd0b85a97d-432c3775ad0mr16027947f8f.21.1768064772988;
        Sat, 10 Jan 2026 09:06:12 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm29753038f8f.13.2026.01.10.09.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 09:06:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 10 Jan 2026 18:06:11 +0100
To: Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aWKHA2bldOSZ0lMB@krava>
References: <20260109093454.389295-1-jolsa@kernel.org>
 <aWEG685zlaV0o7M7@willie-the-truck>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWEG685zlaV0o7M7@willie-the-truck>

On Fri, Jan 09, 2026 at 01:47:23PM +0000, Will Deacon wrote:
> On Fri, Jan 09, 2026 at 10:34:53AM +0100, Jiri Olsa wrote:
> > Mahe reported issue with bpf_override_return helper not working when
> > executed from kprobe.multi bpf program on arm.
> > 
> > The problem is that on arm we use alternate storage for pt_regs object
> > that is passed to bpf_prog_run and if any register is changed (which
> > is the case of bpf_override_return) it's not propagated back to actual
> > pt_regs object.
> > 
> > Fixing this by introducing and calling ftrace_partial_regs_update function
> > to propagate the values of changed registers (ip and stack).
> > 
> > Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > v2 changes:
> > - moved ftrace_partial_regs_update to generic code [Will]
> > 
> >  include/linux/ftrace_regs.h | 25 +++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c    |  1 +
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> > index 15627ceea9bc..f9a7c009cdae 100644
> > --- a/include/linux/ftrace_regs.h
> > +++ b/include/linux/ftrace_regs.h
> > @@ -33,6 +33,31 @@ struct ftrace_regs;
> >  #define ftrace_regs_get_frame_pointer(fregs) \
> >  	frame_pointer(&arch_ftrace_regs(fregs)->regs)
> >  
> > +static __always_inline void
> > +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) { }
> > +
> > +#else
> > +
> > +/*
> > + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> > + * @fregs: The ftrace_regs to update from @regs
> > + * @regs: The partial regs from ftrace_partial_regs() that was updated
> > + *
> > + * Some architectures have the partial regs living in the ftrace_regs
> > + * structure, whereas other architectures need to make a different copy
> > + * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
> > + * if the code using @regs updates a field (like the instruction pointer or
> > + * stack pointer) it may need to propagate that change to the original @fregs
> > + * it retrieved the partial @regs from. Use this function to guarantee that
> > + * update happens.
> > + */
> > +static __always_inline void
> > +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
> > +	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
> > +}
> 
> I think the AI thingy is right about dropping the const qualifier here

yes, will resend, thanks

jirka

> but overall I prefer this to the previous revisions. Thanks for sticking
> with it!
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will

