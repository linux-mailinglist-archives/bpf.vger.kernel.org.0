Return-Path: <bpf+bounces-73987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA369C41CFE
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 23:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFFC1899BD7
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 22:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B831327C;
	Fri,  7 Nov 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM49bU8m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082A24BBE4
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554167; cv=none; b=AICFRjsiHr/dyQnL9oBCXufKg16ODM0MEPZzYjJygw87chRRCBt5iWnTNoKT3pTlc7LhbRgfbmGXUXpPCQm/w1ifXAL8fsqR1eOBm0RQwmT9/sEDp/yRaETDe9yeuU/2UUO9qvu8gtOEEQE8VZ3KKyYcOOgQFUfshx0FiAMdUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554167; c=relaxed/simple;
	bh=y8uhpjkxV6O3jTV8knGvmjId3RI8Ya4dmQ4gE7UDYcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoT3NBYKuEksP7IDvqwCxaWBn5j+cKjWPz4hPVOU3AYxqyPLDiV/1nIzLtxx8fbKO/px1pMbwI3qv52j3cTTjqSefVSFLjVc5L9qVurhV+Ga8j4rxxEWFmT8IcKTofUSHq1YbOyyJf58l1RcnxZMKqFNWGgohQU7inGtw36lojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM49bU8m; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso713306f8f.0
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762554164; x=1763158964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClVfh35II8EwPLPZ8XkRs6NnkYIrVTBNZcu1Jla1/Ig=;
        b=mM49bU8mP1kqgeTq66mmVxRF24ZLwKc6ynSRveiiJHKV0c/3664wVTWl7DX5O7lcFN
         dACscqQO3Zxmaz8pcbkPnEhJBylpjXong8ljNDN4e0PAv56JEWYajdsWSvE5y5qn/q8t
         uR4EupgABkoKRi7AUyNQ4sWeq2kE9xMLSssUuMQihFRfJqLSTf/1yz/lAIEXVLDX7MLs
         25OE4AxRMoL0QcM+u6pOlsB1sBcX14KUTrAOUgxn7sQCBJ+polDqRZYoGsEuTCIZuJuG
         ENfac/cSMGM30PcZj8hNC1dlsd5hV762+Keo5u0hr3Neu8Zr9U2avGUgX6qXvUhD4NMo
         Cufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762554164; x=1763158964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClVfh35II8EwPLPZ8XkRs6NnkYIrVTBNZcu1Jla1/Ig=;
        b=Exurt08JQvIMIbzQltH4v+UuAbhOM9s+rwOShHQpyYJQdkGs2u7cOKoI2lG6xNehVw
         CKdIVVFYR/ILfYoJn29cVYiGv0wUNt7/vsPqyVjt7KU5ARoZUTg6pEIf3gLNy6In6uFV
         tZZoNpNfcbF4kmdeXJYAeeBWZF+aEVrJG6sjKR4H+o9aGSjWW1VONj9z/tDypRX7QHs/
         by/NLePC3jxiIh/BMQqP2g3pkLYR+A46nMTW0IWFLOA9Kq45wfgmb85IQ/xlPFHLpvNq
         cuzyrAJXhDe6T/5YM2vbbgO3J7h6wRR0keh/DARpz0gwac85bQ17q1mF74rUrpS8gjP+
         +3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXkLNFou+rPUWVdh4kTGR6gwyfg6+0QOVvBqummToAOUuomcWVvGzq/kyDeLkYp02aPggY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxE8QiBhAQBlAxb4HRsoli86tkRvTUeymwX43oU+w+HLwthxX
	cYvkt2aop1r9ZnrJHd+9legAOJ6vHTZQkpkgtaUxmaEXDCC7shzI/cveVX+N3lBLZrdsttMQi0y
	wTbcubF8F6RRFCL4tx++u528CbGuqQFc=
X-Gm-Gg: ASbGncu46h2S3LMIsOTzurxcfUWKCNn8jjZWVRubWvXyLIVIDVkgqBmGeFB+5Bhvr+b
	K53nZqk5aw8L5uyiPtl03OePgawLMei1taQQdVOBZPhMmsOOvVjaXPJ4enivDpnNLqYP/JedY+R
	seSC5d+byYgze/F5xuyo78SN5Kr8F7rZo8bDA2kU2rSH9ntS6ZVkWVQfWAh278mn+qE7eoms5zK
	/tsPMjV13luxzPchOOIuR1fBjcKsLR3mFoAKG0yt+f4Y9R6vBnewY+RoprtcItIJkhhebMEctSt
	+z9ziv+8EvCHDQ6Vxma+t6qxYcwb
X-Google-Smtp-Source: AGHT+IGxAUJT/GLmqVu4lOqIuCrVGdAtTg/dxl8EDFRUH5YzZ9uMW7PMfRv/gxUEOOze+7cZi4CjPSlM2txLSRHYuSE=
X-Received: by 2002:a05:6000:2f86:b0:427:6c7:66f8 with SMTP id
 ffacd0b85a97d-42b2dca5806mr394007f8f.52.1762554164415; Fri, 07 Nov 2025
 14:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103220924.36371-1-jolsa@kernel.org> <20251103220924.36371-3-jolsa@kernel.org>
 <20251106122933.GW4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251106122933.GW4067720@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 14:22:33 -0800
X-Gm-Features: AWmQ_bknLIgNOXihgshZMWntmp4oVwS8b5dTWL0YhVw1nt_QkyUjWgG10WSdRW0
Message-ID: <CAADnVQJ_4bwVnem-cBPz_5ULLgQpm0LXWUzveT9NEH6O_W0P5A@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] x86/fgraph,bpf: Fix stack ORC unwind from
 kprobe_multi return probe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Nov 03, 2025 at 11:09:22PM +0100, Jiri Olsa wrote:
> > Currently we don't get stack trace via ORC unwinder on top of fgraph ex=
it
> > handler. We can see that when generating stacktrace from kretprobe_mult=
i
> > bpf program which is based on fprobe/fgraph.
> >
> > The reason is that the ORC unwind code won't get pass the return_to_han=
dler
> > callback installed by fgraph return probe machinery.
> >
> > Solving this by creating stack frame in return_to_handler expected by
> > ftrace_graph_ret_addr function to recover original return address and
> > continue with the unwind.
> >
> > Also updating the pt_regs data with cs/flags/rsp which are needed for
> > successful stack retrieval from ebpf bpf_get_stackid helper.
> >  - in get_perf_callchain we check user_mode(regs) so CS has to be set
> >  - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS/FIXED
> >     has to be unset
> >
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/include/asm/ftrace.h |  5 +++++
> >  arch/x86/kernel/ftrace_64.S   |  8 +++++++-
> >  include/linux/ftrace.h        | 10 +++++++++-
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrac=
e.h
> > index 93156ac4ffe0..b08c95872eed 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -56,6 +56,11 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
> >       return &arch_ftrace_regs(fregs)->regs;
> >  }
> >
> > +#define arch_ftrace_partial_regs(regs) do {  \
> > +     regs->flags &=3D ~X86_EFLAGS_FIXED;       \
> > +     regs->cs =3D __KERNEL_CS;                 \
> > +} while (0)
>
> I lost the plot. Why here and not in asm below?

It was discussed during v1/v2:

Jiri:
"Note I feel like it'd be better to set those directly in return_to_handler=
,
 but Steven suggested setting them later in kprobe_multi code path.
"

Masami:
"Yeah, stacktrace is not always used from the return handler."

If there are any improvements possible it can be a follow up.

