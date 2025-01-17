Return-Path: <bpf+bounces-49193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBCA1509F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B519316499F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB28B200BA2;
	Fri, 17 Jan 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxINPgMm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A6200100;
	Fri, 17 Jan 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121008; cv=none; b=OpZofyoJXxuG1FDa2B8TLpCjzQ4LvyBo8l68TH0aEdk77rszjTT5uWgdzCNpaTqAzsqElpW786oqphf+cUySF6GkYTuJvoJlhZrK/k8mTRorfuB2LxBKaOkTeVivGk1FUwOqY89XFCdcITY68wbi0wYiBXwsEIFPX7Jez8Y9elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121008; c=relaxed/simple;
	bh=ykoOYP5A9GqLIO8ujgXlxd/k2bw6vl/rJwrKvkpumwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnAqrEWBLnDbWnS1w4ozJHkkkJX9gBR4qivHqdiCdCdpMnF3pR7AbDC9c/Dh3+JBKKeqtiw98ufkEGKIlI9UCP7kqF7k+PdBOvNEXZXF76X0X4vAmCdlmdNABiTc+cR+1eUechYYYRbv4ykjyPlilSqSX+S38HQYUR5lyWzroHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxINPgMm; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f321876499so1141403eaf.1;
        Fri, 17 Jan 2025 05:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737121006; x=1737725806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT6JakgGMnf6JWUAg95lo0Hdan+g6MjCBqiydljWY8k=;
        b=SxINPgMmG7YLCk24d+zUggLplNQry9HoTOwKAbMbWrbQakYgGtnR7uSik0j9NXfqjB
         4PpXdCHXbbeeVQq+VaNbSCBvKOlic3OG1TvNlgyct+5wwi25Tdk9oWGkvZYTWu7rkMBH
         RnWTkHdT27B1c9uRKSRtXRyJvc8YP4ORYCyiovF/VnZNW+ISnIkWxlmJJG8fugsj/+8i
         wW+p6vJsBNQB/7e/hYjRCOOGmXRjcrjlZ+CKlMcfQBTS7sbp6z2gw8PysCQ3i5f6K5zP
         BGnlwuUxCJuTiHdXdrvQmr2/19nV1YrS8nIO/1Fb7DSfgt6BwB63+eGc3rJeD2YyWgBu
         Fh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121006; x=1737725806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT6JakgGMnf6JWUAg95lo0Hdan+g6MjCBqiydljWY8k=;
        b=RuV7Ojr9pk6KGdHm0aavXEttmH8H/Q9qywJZyHB8IYm0x/udCgqw9kd4Yhv5O8MqyU
         p9Mh67Dp9IicpWUDXBZ5VDeX2EGw4G7VIYGXloYwhdYygqyqJ6fDb0+yz5sG8xrLeh1s
         0uVoS1/YWCPpiQYuvpyPuBfpvx6b+gakuvqe91PuA3L0vCV6e6GPFvBxm4lQD1AWwvuW
         0WH6l9u0vQWvplz0y0zeHhl3vXOtiMhlxMtdE1Uq9ifLcRal1ppC8H+yXxcY6n1MfHSC
         lVf+t4rMxkz+QL+mpkNAOXc0vlI7jTNsKfsZTxRdGTBBwNg4hT7GvexzMDuB/TF5TTAh
         A8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVnzmOWxpuf/kddiuJ2uv+oQPH2GH5aUTYvs9NoTIwVb73iS7bLTYL1PIdhk4sNqi1tIxyTcIkfroOt@vger.kernel.org, AJvYcCVxaVA6nP7I0AqasCekxYk317OinA2+mLLzZpBMTUs3ryI2z043eE4ux30F1a2rFcPCQ+o=@vger.kernel.org, AJvYcCWdOgmuke28C4AVsOEGY5y6n6IEsMfoloAZH+lvZ5DGLjg6WfhjrDCRqEHvsPuu6R1B9GNfBfm0so0PDmt9@vger.kernel.org, AJvYcCWq+QAc/o4J5Vx1mVJUo9q32Sflwtuhz7XWeoFduZNdjWK4WWtbDPl4I0QzDXp7AP4TedGlRylo@vger.kernel.org, AJvYcCXQM2icEZZHVgl3/4DmzFtowqNHNfZpOe8xbO29IiW8kxEAqi5Qh/aI9f/X0+5jdU55E604yV5nuifi9go6koFgAn7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyAatkwXzX1YSjvR6hTy7+PZdFByykqGIkYzt60SJoRFcyWoX7b
	45T2evYrmb7Tl9vPzM+TPaPqeG2AiNOqKWTWvy8s/r/iPBo68pLc3799+6+yasfPAlEHa8RFedz
	JZeG8XQ7IdEhYUTSCJa6s/iQQU30=
X-Gm-Gg: ASbGncvReyTe/rvHytM9qDMJvgjPm7g/GEWha2ZKD9FIEWaYfu/CB0IbLPX4C/xI4m8
	jTFfCdMM1EI67z7zf+3coLmj5IjnVzRJhZU2DAg==
X-Google-Smtp-Source: AGHT+IFvad+ZXGCoxHtM0gw/gElj7za0zj2PpUGCXThzkgXaHc8LVmM4fMDPZpqOAat3utTHabdLcbeS11L77l1I0c0=
X-Received: by 2002:a05:6870:2a47:b0:29f:a6e2:4108 with SMTP id
 586e51a60fabf-2b1869b0fa6mr6727343fac.2.1737121005718; Fri, 17 Jan 2025
 05:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com> <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
In-Reply-To: <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 17 Jan 2025 05:36:34 -0800
X-Gm-Features: AbW1kvbmNpeFCohqRZCOjNCkMbLk4tbkvbKDcf6UHeDZf44yJqqbEtRACKxLRMY
Message-ID: <CAHsH6Gtbo39pVjVWbPfSjePPyFYVLWJq9m3HLWgDGp1orvD+GA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, kees@kernel.org, luto@amacapital.net, wad@chromium.org, 
	andrii@kernel.org, jolsa@kernel.org, alexei.starovoitov@gmail.com, 
	olsajiri@gmail.com, cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com, 
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com, 
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 12:02=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Fri, 17 Jan 2025 02:39:28 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 01/16, Eyal Birger wrote:
> > >
> > > Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up retur=
n probe")
> > > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> > > Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z45=
6J7BidmcVY2AqOnHQ@mail.gmail.com/
> > > Cc: stable@vger.kernel.org
> > ...
> > > @@ -1359,6 +1359,11 @@ int __secure_computing(const struct seccomp_da=
ta *sd)
> > >     this_syscall =3D sd ? sd->nr :
> > >             syscall_get_nr(current, current_pt_regs());
> > >
> > > +#ifdef CONFIG_X86_64
> > > +   if (unlikely(this_syscall =3D=3D __NR_uretprobe) && !in_ia32_sysc=
all())
> > > +           return 0;
> > > +#endif
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> >
> > A note for the seccomp maintainers...
> >
> > I don't know what do you think, but I agree in advance that the very fa=
ct this
> > patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn't loo=
k nice.
> >
>
> Indeed. in_ia32_syscall() depends arch/x86 too.
> We can add an inline function like;
>
> ``` uprobes.h
> static inline bool is_uprobe_syscall(int syscall)
> {
>         // arch_is_uprobe_syscall check can be replaced by Kconfig,
>         // something like CONFIG_ARCH_URETPROBE_SYSCALL.
> #ifdef arch_is_uprobe_syscall
>         return arch_is_uprobe_syscall(syscall)
> #else
>         return false;
> #endif
> }
> ```
> and
> ``` arch/x86/include/asm/uprobes.h
> #define arch_is_uprobe_syscall(syscall) \
>         (IS_ENABLED(CONFIG_X86_64) && syscall =3D=3D __NR_uretprobe && !i=
n_ia32_syscall())
> ```

Notice it'll need to be enclosed in ifdef CONFIG_X86_64 as __NR_uretprobe
isn't defined otherwise so the IS_ENABLED isn't needed.

>
> > The problem is that we need a simple patch for -stable which fixes the =
real
> > problem. We can cleanup this logic later, I think.
>
> Hmm, at least we should make it is_uprobe_syscall() in uprobes.h so that
> do not pollute the seccomp subsystem with #ifdef.

I like this approach.

Notice it does add a couple of includes that weren't there before:
- arch/x86/include/asm/uprobes.h would include asm/unistd.h
- seccomp.c would include linux/uprobes.h

So it's a less "trivial" patch... If that's ok I can repost with these
changes.

Eyal.

