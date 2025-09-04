Return-Path: <bpf+bounces-67488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED24B4455B
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6971C86D86
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E48343208;
	Thu,  4 Sep 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdKchDH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A42FABE2;
	Thu,  4 Sep 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010482; cv=none; b=BK+dzvqExUxGEBuNV2qZo/rH55WMla5CIladrYVos+SEu37LxZ4tWvfO1t5/0kO1ha36OlzgogAr1AVYzAG36YtPL/geVIxEAb7BmJ62eYly4zXOFqEKE5JU6/0UViFIBDx2P3zKH9uio7VcdkDKGKj6/Ag+r2lwjjTYucE/A4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010482; c=relaxed/simple;
	bh=ffLIQ3FaiYZNtElI4OJ0F2JYmjc0S5H12kcNdyc3VUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpFt5LTcIXYzZyIq3nPLbUXZDsQs0Dl58sN1bNGc0qh9eCyNbXNP9XRNSBiDPR2tfHa47qTJhwcrtU/HymLiNyLmjD0zhg/D5Cy+5A6c5/NbGbUUuD1kBHpbz3A6BfVxR/SRVf8x5zM0jtrXMW9REZdidREuIshGxttroaWFugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdKchDH5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24884d9e54bso14148555ad.0;
        Thu, 04 Sep 2025 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757010480; x=1757615280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFcf01DXYxJozGudqNMPPaA6uZcECj7e/1HGQreU6Co=;
        b=LdKchDH5Ieo8UHm+OxDkaWV9tHB1S/h0gbwh0SrD6r1Y5MElY60NZSzaKdiwUocLB+
         dOljdj0Zc9fiiGhv5YgeNsOI1YwWi4xdFb39/YMrF1SfiEMvvgIirJR1GY1ytGEO1mBU
         49TZrdBuLq5dDvoWaw1LhKh2oKh6QQ1UvPczVL5UpKq6gdq5Lz61GiweEf1s9f1VRFxT
         dWFujhEXsnEahdez6x+fDTWuQ1luCVumbGdQjd9n6+adhRifd7gF/b3drmMYVYRWEFTq
         Ctow3b1yAY8V0WTWBYNl+LLGtsDu9WO/f5LAVqPIIWOzigrT12kPmiMiblUzgwBeiiVI
         MX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010480; x=1757615280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFcf01DXYxJozGudqNMPPaA6uZcECj7e/1HGQreU6Co=;
        b=XksGs2emezw7bpgVUHYt53FbGUrKlm12U9qz5Uj3waZOMUBzIQk5vcoABtIl/foi8u
         00CP6tRQP8xgw5LPJdSfz2qiQKG3s1RulJg7IIz0pdkpY2TG6HJ+Rx2Z0WK90LnVFE08
         LZvVnnBO4QnCodVIs6WJQM8QVMET4at5pIzZk4mAscH5mxRxwoqyRwz6l1n+70dW+U2y
         8dd7Ox+T1Bj+0tI8fVf9NDQ7utCnQCr5p3I8ggAYxiFk8HHVd7s8K56LLDMi5Jo1CxM5
         VIyCGr/QnVPKCXqc4s9y/u6HOuNX05gXS4kHtAO2c8Lf9l1dYF+mJRhEsdlTzva6sBtC
         zveA==
X-Forwarded-Encrypted: i=1; AJvYcCUSLL0VhbZKz1hx2h8nvSXN2zI6tkLgOGN+Sn6vjpEdYwQUieikmy7pAOIVZ2aMmh++oREvliHoIlQkSNGxxoFBP3Kr@vger.kernel.org, AJvYcCUhLZVoHozY45tpqBpyAbBi6B1Yf2FH+tuuBQlww1wH/pHrlwK68Y8LSPU1vlOpTRjiWqw=@vger.kernel.org, AJvYcCXtczmJvurJTmhLT6xmwUmthAIcC0V1C0tx7loimXwn8dl3+S2vSBS4Bu234YZy9eDdMFHMYXXspstNGu8o@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPTT4dDD47ZQUXSQelKYFmqVWQf7Q9xOj8/YDQ0WHH8q3vD63
	RHvCocHAOhW13W0XHyOz+8P6R1Xmmg7VBVcYEHwARwLcRyLfateb1IAANd42KiBbTVPM7vsgqKX
	CCtn3OhWdV8hU4h+ueIiDHkRJW6woGgI=
X-Gm-Gg: ASbGncugtvj4u06r5kjuLX/U9pG1P0FVmUxeniAt8+pmm8rMA9iJ3dBPqHI4L1IW/nZ
	AkXXcbzvVekSmJzihCBRT4+CC6dLlPjGjjEFqT/LDHWpU5cw5xTFD6/xTF+paYsdiuDajjJHHJu
	VucbSrgzLaV5Cd+a0UBwLJnM60/3eBnzlxe1Xu5YfO0bJ2F31mY7HE9zK7QHb+eM7Y0NtZIS2s9
	FRIh1/lKTZGzjdy0eHlrHU=
X-Google-Smtp-Source: AGHT+IFmjG6A3aSE+CmXab8GXk/ptByCG1d6SNBMRp3QPcCj1+z42ojsmggSYN0fEMSk94BqMVxQdOUBFPWJh+K79Ng=
X-Received: by 2002:a17:903:2309:b0:249:3781:38e3 with SMTP id
 d9443c01a7336-2494486f48fmr245916815ad.10.1757010479749; Thu, 04 Sep 2025
 11:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com> <aLlKJWRs5etuvFuK@krava>
In-Reply-To: <aLlKJWRs5etuvFuK@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 11:27:45 -0700
X-Gm-Features: Ac12FXwZL9LiktKhjwvBuDGzti3AR3z8oS4Qg9Bvtj7egtgdX2ynkU-qrM7BF4U
Message-ID: <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
Subject: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22] uprobes/x86:
 Add uprobe syscall to speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

-- Andrii

On Thu, Sep 4, 2025 at 1:13=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Wed, Sep 03, 2025 at 11:24:31AM -0700, Andrii Nakryiko wrote:
> > On Sun, Jul 20, 2025 at 4:23=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding new uprobe syscall that calls uprobe handlers for given
> > > 'breakpoint' address.
> > >
> > > The idea is that the 'breakpoint' address calls the user space
> > > trampoline which executes the uprobe syscall.
> > >
> > > The syscall handler reads the return address of the initial call
> > > to retrieve the original 'breakpoint' address. With this address
> > > we find the related uprobe object and call its consumers.
> > >
> > > Adding the arch_uprobe_trampoline_mapping function that provides
> > > uprobe trampoline mapping. This mapping is backed with one global
> > > page initialized at __init time and shared by the all the mapping
> > > instances.
> > >
> > > We do not allow to execute uprobe syscall if the caller is not
> > > from uprobe trampoline mapping.
> > >
> > > The uprobe syscall ensures the consumer (bpf program) sees registers
> > > values in the state before the trampoline was called.
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> > >  arch/x86/kernel/uprobes.c              | 139 +++++++++++++++++++++++=
++
> > >  include/linux/syscalls.h               |   2 +
> > >  include/linux/uprobes.h                |   1 +
> > >  kernel/events/uprobes.c                |  17 +++
> > >  kernel/sys_ni.c                        |   1 +
> > >  6 files changed, 161 insertions(+)
> > >
> > > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/=
syscalls/syscall_64.tbl
> > > index cfb5ca41e30d..9fd1291e7bdf 100644
> > > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > > @@ -345,6 +345,7 @@
> > >  333    common  io_pgetevents           sys_io_pgetevents
> > >  334    common  rseq                    sys_rseq
> > >  335    common  uretprobe               sys_uretprobe
> > > +336    common  uprobe                  sys_uprobe
> > >  # don't use numbers 387 through 423, add new calls after the last
> > >  # 'common' entry
> > >  424    common  pidfd_send_signal       sys_pidfd_send_signal
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index 6c4dcbdd0c3c..d18e1ae59901 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -752,6 +752,145 @@ void arch_uprobe_clear_state(struct mm_struct *=
mm)
> > >         hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node=
)
> > >                 destroy_uprobe_trampoline(tramp);
> > >  }
> > > +
> > > +static bool __in_uprobe_trampoline(unsigned long ip)
> > > +{
> > > +       struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
> > > +
> > > +       return vma && vma_is_special_mapping(vma, &tramp_mapping);
> > > +}
> > > +
> > > +static bool in_uprobe_trampoline(unsigned long ip)
> > > +{
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       bool found, retry =3D true;
> > > +       unsigned int seq;
> > > +
> > > +       rcu_read_lock();
> > > +       if (mmap_lock_speculate_try_begin(mm, &seq)) {
> > > +               found =3D __in_uprobe_trampoline(ip);
> > > +               retry =3D mmap_lock_speculate_retry(mm, seq);
> > > +       }
> > > +       rcu_read_unlock();
> > > +
> > > +       if (retry) {
> > > +               mmap_read_lock(mm);
> > > +               found =3D __in_uprobe_trampoline(ip);
> > > +               mmap_read_unlock(mm);
> > > +       }
> > > +       return found;
> > > +}
> > > +
> > > +/*
> > > + * See uprobe syscall trampoline; the call to the trampoline will pu=
sh
> > > + * the return address on the stack, the trampoline itself then pushe=
s
> > > + * cx, r11 and ax.
> > > + */
> > > +struct uprobe_syscall_args {
> > > +       unsigned long ax;
> > > +       unsigned long r11;
> > > +       unsigned long cx;
> > > +       unsigned long retaddr;
> > > +};
> > > +
> > > +SYSCALL_DEFINE0(uprobe)
> > > +{
> > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > +       struct uprobe_syscall_args args;
> > > +       unsigned long ip, sp;
> > > +       int err;
> > > +
> > > +       /* Allow execution only from uprobe trampolines. */
> > > +       if (!in_uprobe_trampoline(regs->ip))
> > > +               goto sigill;
> >
> > Hey Jiri,
> >
> > So I've been thinking what's the simplest and most reliable way to
> > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > whether we should attach at nop5 vs nop1), and clearly that would be
>
> wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,nop5
> and store some info about that in the usdt's elf note, right?
>

Yes.

> libbpf will read usdt record and in case it has both nop1/nop5 and if
> the sys_uprobe is detected, we will adjust usdt address to nop1 or nop5
>

Yes.

> I recall you said you might have an idea where to store this flag
> in elf note.. or are we bumping the usdt's elf note n_type ?
>

Neither. I was contemplating just to look whether there is nop5 after
nop1 from libbpf side, which would probably always work reliably in
practice, but, technically, might be misused if you artificially put
nop5 after USDT() call and then jump into that nop5 from somewhere
else. Then it would trigger USDT where it shouldn't.

But I don't want to change n_type, as I want anyone else doing their
own USDT parsing/attaching to work just as they used to.

So, here's the current idea. USDT lays out three strings one after the
other in ELF note: provider, \0, name, \0, args, \0. We also record
total note data size there, so we know how much contents is there. I
was thinking we can add just one extra \0 at the end (and if necessary
we can treat that as 4th string with extra arguments in the future,
who knows). If libbpf detects that extra \0, then we can be reasonably
confident that nop5 is part of USDT and is safe to be used correctly.

Unless there are some super paranoid USDT parsers out there, it should
be nicely backwards compatible. Libbpf seems to not care right now
about that extra zero, which is a good sign. readelf handles that just
fine as well. So all good signs so far. I haven't tested anything else
(bpftrace is currently broken for me w.r.t. USDT attachment even with
old format, so I can't quickly check, please help, if you can).

> thanks,
> jirka
>
>
> > to try to call uprobe() syscall not from trampoline, and expect some
> > error code.
> >
> > How bad would it be to change this part to return some unique-enough
> > error code (-ENXIO, -EDOM, whatever).
> >
> > Is there any reason not to do this? Security-wise it will be just fine,=
 right?
> >
> > > +
> > > +       err =3D copy_from_user(&args, (void __user *)regs->sp, sizeof=
(args));
> > > +       if (err)
> > > +               goto sigill;
> > > +
> > > +       ip =3D regs->ip;
> > > +
> >
> > [...]

