Return-Path: <bpf+bounces-51122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B31A305E3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB1C1657BC
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364161F03C5;
	Tue, 11 Feb 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3t3f8oi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA017192B86;
	Tue, 11 Feb 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262909; cv=none; b=PifcJAETL6fcNel/NOBaMMN2hMR2TStx12su5Y5gH6kg3QqWt9blIo+0jll1aEfqBrnRXydopClxV2vwjCaT6qmjPGT8BRp2O0cbHQyiHEXo8TtCUJAtGAMVuH1RR1JT5lBzMxTUX0VyKMRY8Kq+/u1jLorEuCMxFZzy3mamCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262909; c=relaxed/simple;
	bh=OK6F/HpVrCSuxMq+p1p7tMOUXLCHNYzj2Ljkd7ptjpk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qeo9RJIFqyFrMnH/XiflJ09h/y0fkn9bSOHn85hu2bMUiCoPAZgJxxmvx3mQqXuwKzX+A3ttdlrI4l6grSf02slujSTF7P6qJfwMNI+nVHSt/PMx6Hi2KcUXU/FYmj/sWjnc5DHtIzZnjU9G3WuMoOWE9CxvQUoq4dBOe1kYwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3t3f8oi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43618283dedso52401215e9.3;
        Tue, 11 Feb 2025 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739262906; x=1739867706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bwJ01W7//5Ak1H8YG47QHAAd+AKMdSyCszB536sJQvU=;
        b=E3t3f8oizJxrlhvwwggy/a43bgEm1NkOMoPgtRRuVJNUt63+5WNsYiqYxb5KaDmier
         in4EOlSS1WnO+PNOMl0lukDrK1T0sWmf4AJVJvEbiYa0n2EAIgqPf8TC78OSEI8YlSzY
         l+eG2Mevni1zuCrMSZilSVwX9XMzJUFG9Ej5vpioM3CkwWI7xjWPL1+DLQ5mJb2IX2Xh
         IxJ8WwNn/7GCmdRaU6nUvCRZMeCLTuteHhEgS2t1c7T0qXulJ1VKuSpL8iWP7ix4b5pA
         NO92S1opx8MnHard5i2FQZbSTPYg3JGCwz5oHnLD+J7PgPflQ9i82wAkOrV4aawrepX0
         t3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739262906; x=1739867706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwJ01W7//5Ak1H8YG47QHAAd+AKMdSyCszB536sJQvU=;
        b=R+8gHEr6WO330QNq/ETBw9JlUkmQqJcVx/E4Qqky9l1j5DtwBQK3H5v3jni1YQoPoE
         ZquCcPKRuxnZXNBOaewtDf+kNk4qQevBBkUXpC7k72c/1TKdgwD4yqCiknJhltEDKf8u
         M1eGaA9eWp7SSsmtSG2ZO/2kloSh9kMpRaxM5WutR/Gg0IGGuxtlwltoEctqOREAwNF7
         K72pQaQAK+X1bUxt5BgZdMZqemV7hf3LpW7Ajbe8eHlURPH2kYYmXfi2yjaXHiZbFQ7c
         TKJPDFTmSlAKOk4diZGAc+Y6897FYvcV4SSAXGqTVzlJNPMXY4F18Jki5ajOaBw47Up1
         caeg==
X-Forwarded-Encrypted: i=1; AJvYcCU8n3zdcwvvgPiU8SG+f0uFCrYV+hyFamHIazYkD3B4rB+vw+Jk9dotUDvrikbmsyQsUnRc3+U0@vger.kernel.org, AJvYcCW+gtj9qVW5+aj0TDbXKYy67goS638EmfWl1a5tmrOuGVSus1jGyR+DkVDr9kUfx/9IC7aIswN++T/bpVu6F9xZk16D@vger.kernel.org, AJvYcCXIL51a0d1ZQyrIv2WUebIqhIbETY+qz5U67wW8jc716erClgpnhR9KX8o5RXp8UK6pdMHNIdPyOCjO+R4F@vger.kernel.org, AJvYcCXVzlZcPmVxwVG0SgFFuoOPhQE6AwL7ko2iKvjK7A7j13BksTV0LXolDsxAoqfrd7qlKz9D+AbjwmP5@vger.kernel.org, AJvYcCXkNLjf/fpmn9/QHHIwvy8dM2Fc7RH9wWuw4R28CvdpVID+AKje9ayz8SVW4W2FwmZJs38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+cZ9mQ5FE8kNgl4g51Mn3nEyNfjYkYFFu26ADkBJpMw/PY4E
	bPptaQCb2yi8rC/kzUOzXGqYqo7eXzrqG8ABYu4x8iwbSE1XFAqs
X-Gm-Gg: ASbGncvPx1jyK44SQ+hvcgx68gWrDDV6boUgv1h2SUJ+2jC+S2+7Uu7yQ9DCix5OU8Y
	iQNbktAB5r2SlfkPdtEFz+kHR/cJZCt3Hkp0J3ZDyLk7hTdtkyS9CwafknsSAJhUadnRpfbNsXE
	CVdKbq41VA+Sb/4sg41Yi12CT9/5jailmDYdykkI1sWXZl3M7pcCsbYuzwXcqBEbw84ioeF1r8S
	PMERJJUoflwOnLM0wxNuvVTfST/TQySph+2dFLgZ21hWk1e09qav9yAMTV7vEVZagQLikNmZI8E
	uA==
X-Google-Smtp-Source: AGHT+IHqJLfevdgNRazeDfFwqCjxzNygsDkj1WnutgwyUmf3yGls7DVNaIZ/issKMhM6u7+e3HvTmQ==
X-Received: by 2002:a05:600c:4254:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-43930bd7f9fmr85110685e9.9.1739262905439;
        Tue, 11 Feb 2025 00:35:05 -0800 (PST)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc3a10fffsm13362157f8f.12.2025.02.11.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:35:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Feb 2025 09:35:02 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH bpf-next] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <Z6sLthPEqVuGKQSL@krava>
References: <20250209220515.2554058-1-jolsa@kernel.org>
 <CAEf4BzbpKReuNhdH6RnwYOyYxFwgJjjgUB_2xwU=dGkC--K=Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbpKReuNhdH6RnwYOyYxFwgJjjgUB_2xwU=dGkC--K=Kg@mail.gmail.com>

On Mon, Feb 10, 2025 at 09:26:53AM -0800, Andrii Nakryiko wrote:
> On Sun, Feb 9, 2025 at 2:05 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Jann reported [1] possible issue when trampoline_check_ip returns
> > address near the bottom of the address space that is allowed to
> > call into the syscall if uretprobes are not set up.
> >
> > Though the mmap minimum address restrictions will typically prevent
> > creating mappings there, let's make sure uretprobe syscall checks
> > for that.
> >
> > [1] https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d416df341b8fbc11737dacbcd29f0054413cbbf
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Eyal Birger <eyal.birger@gmail.com>
> > Cc: stable@vger.kernel.org
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 5a952c5ea66b..109d6641a1b3 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
> >         return &insn;
> >  }
> >
> > -static unsigned long trampoline_check_ip(void)
> > +static unsigned long trampoline_check_ip(unsigned long tramp)
> >  {
> > -       unsigned long tramp = uprobe_get_trampoline_vaddr();
> > -
> >         return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
> >  }
> >
> >  SYSCALL_DEFINE0(uretprobe)
> >  {
> >         struct pt_regs *regs = task_pt_regs(current);
> > -       unsigned long err, ip, sp, r11_cx_ax[3];
> > +       unsigned long err, ip, sp, r11_cx_ax[3], tramp;
> > +
> > +       /* If there's no trampoline, we are called from wrong place. */
> > +       tramp = uprobe_get_trampoline_vaddr();
> > +       if (tramp == -1)
> 
> slight nit: mixing -1 and unsigned long looks sloppy. Maybe let's add
> something like
> 
> #define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
> 
> and return that from uprobe_get_trampoline_vaddr()?

ok, will add that

thanks,
jirka

> 
> > +               goto sigill;
> >
> > -       if (regs->ip != trampoline_check_ip())
> > +       /* Make sure the ip matches the only allowed sys_uretprobe caller. */
> > +       if (regs->ip != trampoline_check_ip(tramp))
> >                 goto sigill;
> >
> >         err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
> > --
> > 2.48.1
> >

