Return-Path: <bpf+bounces-62153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16403AF5F38
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276C2188440E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B872F5301;
	Wed,  2 Jul 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S6EZMjpp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA092E03EB
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475421; cv=none; b=qdN+vdTfIetpjicWsOlKJ01qT4PQtld4BIVashu75KLQqHlR1cGomJ0GlPDGNxGYln1XHqBoXstJTkm9v4iC6VhyC7lRasaKtJ9oFsAW3w7gmM+OwLVerrab/TCBqkXm0rbTLMtGmhfM77W8WzABO2gIUSO5HiQbhnoiBeDcS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475421; c=relaxed/simple;
	bh=7SlooTOK9TfIj1SqgbI4JXV35XGMr7m8t7eSmUpMnIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5eamjgNoXK5DIanqt1zwjJx0euayFg2hRSvnDi0VbYF0dLoYjWlHZgkwqiOWcJ+kIwR4ALfuHdCkq37zfqjGosimaDIjGDR8Zolj450fWyj5ONZC3FvyyIGnpXPzpHCYuRaeRhqVZvHe9bllQKukZbnMEgoCaOJbzTfA8c+0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S6EZMjpp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade5b8aab41so941803666b.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751475417; x=1752080217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8/uvlPqD4CZgTZ4reU0BZKjR48ea3dcbDn19W3W2ng=;
        b=S6EZMjppOx8COb64LjW6kMLFXRYuTr5V+NvoeUQZGHgiOih5r4JUEFdg0P/oST8ID0
         2mkktuLnb0o7x6Gtrawy8HAYzpMlUb6eP5ztp9mBdmIu/oXv4jb9mXd/b5zhYHF0Fdg+
         P6Zl+ijJd0T+kDulS5ujc39Lf7UM75X9073jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475417; x=1752080217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8/uvlPqD4CZgTZ4reU0BZKjR48ea3dcbDn19W3W2ng=;
        b=snka+g+VROquxncjclE3UiMWh6k9einCgSQ9G9+nywm8AygItbkJc90tku6rCRx4uV
         ub3gxKyo9bXhDkis7KU47t5iaY34v0cHD16qQ9fm4pETvx1/nune1BjJt9xLMGji2z4K
         SrRwDsyz/mh7KsrS1v0i4U2CncmrFwX+oy4vXLFmF0iUp5l5nueqrpPRaX4o3s5NZHXr
         BU+IVC/LKgHDbkOJ8UbQbK0nC3386xm8LYkrx7cG86YDKsTx1j2Mv9+jGyKJ3afttBll
         QQy/lKc9/0hW9MCnlxRB4EBpR2G3my8zYIMZCexFx0yZOB3EjeZf7KRB8iGBMKKtY6Yx
         A/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI352eX+Kxi9rL6PSXGt9536S24NFpn4BmycqFWNO5/cjvkMASsGWtm87hIp4U5+oT3PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwMtw+ZKdnQOFNbb750BnK+f7VBBOoJrefutvzBfi2aArxdq5
	Dx14QPBk/lwADshswbuvpl2qE8UeSvH9i3pRTtRzu3MoU5TNjOPrY3savzK3AcD1hplY5s5B1P5
	PxHy+pCg=
X-Gm-Gg: ASbGncsut5rytoggWw+9jj7vGb6lp/Mdy+bXILnmnjQx8RuDZuOfWfGvVZODndZ3j+3
	MtL5Nj7ByWeCHj8ylS0mwVHDKg/UmVxSrikOYMr9sjkA4tKg6RvyyBnj+6H4EwdHaU/eUzFLg9u
	gVAX2nlJDgVfkMCVi5VnzmWGCQ/V+E6Mm1xdnsoJm2hC/EbZhOaPI7O4dPKQOfhQXUAM2o6RGov
	1wsd/dDdedNKjg/8cuqwUR3OSOpgXymw5GkmJVXbJmuGFZDo3wrocPE/xtqrY5CI0oQdOvp9oMX
	TyXANIntgm0acChdmYlCw8Eh4SsIpj8DyRSV43oeoeV6ibr7qF8UvCon2VWwbeO9tRSb/z0+lJ8
	oEhN5EOwEqGDMs835U99bTTtvW2Gndv/zYM2k
X-Google-Smtp-Source: AGHT+IHjjCvQVnO5XsJ/B1v0ot9Ux9LBzX8ccmxqn3Hz1XRSSB8wH8rWxw38ueib0EmuNdIf9EHt1Q==
X-Received: by 2002:a17:907:7eaa:b0:ae0:c729:8646 with SMTP id a640c23a62f3a-ae3c2c4bdd5mr402922566b.30.1751475417126;
        Wed, 02 Jul 2025 09:56:57 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c0198bsm1126806566b.91.2025.07.02.09.56.56
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 09:56:57 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so9532814a12.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 09:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMhfKCNXOV+p0pH/M2f8q+wVp3WM8uVv9Mas3QyAqJStV16lIBYFYnEghNbpHDUxyhWMw=@vger.kernel.org
X-Received: by 2002:a05:6402:3550:b0:609:aa85:8d78 with SMTP id
 4fb4d7f45d1cf-60e52cc4800mr3206129a12.8.1751475416392; Wed, 02 Jul 2025
 09:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org> <20250701005451.571473750@goodmis.org>
 <20250702163609.GR1613200@noisy.programming.kicks-ass.net> <20250702124216.4668826a@batman.local.home>
In-Reply-To: <20250702124216.4668826a@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Jul 2025 09:56:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
X-Gm-Features: Ac12FXw4HRUmsY26ZzTIlgUFVvvKfSBHwdgpc89cjL9awvQELp5EmXGzK0yXAsM
Message-ID: <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding interface
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 09:42, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> As the timestamp is likely not going to be as useful as it is with
> Microsoft as there's no guarantee that the timestamp counter used is
> the same as the timestamp used by the tracer asking for this, the cookie
> approach may indeed be better.

I think having just a percpu counter is probably the safest thing to
do, since the main reason just seems to be "correlate with the user
event". Using some kind of "real time" for correlation purposes seems
like a bad idea from any portability standpoint, considering just how
many broken timers we've seen across pretty much every architecture
out there.

Also, does it actually have to be entirely unique? IOW, a 32-bit
counter (or even less) might be sufficient if there's some guarantee
that processing happens before the counter wraps around? Again - for
correlation purposes, just *how* many outstanding events can you have
that aren't ordered by other things too?

I'm sure people want to also get some kind of rough time idea, but
don't most perf events have them simply because people want time
information for _informatioal_ reasons, rather than to correlate two
events?

               Linus

