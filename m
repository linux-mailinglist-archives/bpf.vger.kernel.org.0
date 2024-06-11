Return-Path: <bpf+bounces-31789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D71903682
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53B81F21734
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D37174EF3;
	Tue, 11 Jun 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmj55ms/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6014D70A;
	Tue, 11 Jun 2024 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094668; cv=none; b=YNJfxlMJDiLv0HzmiszqSXE63s3w7bq61B2HPkL3wdcTzmDREovvAe8MZSqcNCQ/P4/WJ4JszrFEAFX0AquTCpXOVHeg8L1AgUC4RroEPdh9EYhKXLJJrMAa2lq642keoNUdSwKDg+xBCdAiAplr75eSCc2yLyvN0ncFCCzAYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094668; c=relaxed/simple;
	bh=tt71vPxmPIHlkgLbj7cMrF+1QLZVg430BiNP8a4Qypc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT4tFpqlAOPwb4c3ROlnruufT6Qzpcho5ZT6ebo5q24wn/jymbGnzK57IxPDRqE8TKI3DmWbdbdqh6jD5eVfzpeUPQ7ueQcNGStkQnNd6ZacCuCwppt62PCKna8knaYMWyJLa0cXWRbBXMymPHfFOmOWLTL7huYFvuPkmVBeJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmj55ms/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2eb98a64fso2140757a91.2;
        Tue, 11 Jun 2024 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718094666; x=1718699466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqXL6oQaRNaVKhta8paErN6ux3IRrcLD+yfLg4MWLtY=;
        b=Jmj55ms/c82SgV3hHQduzr3B5Fsm1jP/BbxO5YQ8XYB4p4NMKCt6/wAhrbw+pmcsKp
         eiVBUaSYTdRABg1z9VBveYyAijE/xEInqqLYXy3L8MEi2PPfbP4gbSeH3xkhGnIAj1FV
         H87AwwXiPecwb8wbEQph2TVNtCPUpJT4ZRnxZwO64lkevlJqLtmh3y/zGc95BtyCbn8u
         wpsrenFiGFlm3G4PM/hdsiEC1dyr4hM6WkDwRLN6LVzH4LMjrEjEscPJEmKXZVtMGQUy
         j/oQjgvSfiDJuS4phbkSI4NmqfnfSUFkc+fVNFmb+hNZZtmazM5LO4zjtSLfY/ew4JOw
         QFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094666; x=1718699466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqXL6oQaRNaVKhta8paErN6ux3IRrcLD+yfLg4MWLtY=;
        b=dxQ/IxeyTRsF5m63+e10N8O401yn9Wm+PYRy7sDwNKBNR8CI6UWSQzNjRm8tBe+zAl
         FZs+N8QvHPxq5vM+FWxCH7hUGcTJvxwO0/ufL0fR5AhWlHebJT3Fam2UVDwJeEU68qCH
         ffV/OekvBJjRETYlkle2umDhxm54t56yb3v6f5zwmsVCHtsAUT0A7fd0rO5NWTEIQDp2
         7U6CNFxAngInclszYn6ZEfDz92ltCMX1BBsYqmo/09RLYMnsqek7V8El/WH0yVjraq/p
         2pIfBB24yiNo9taghANGG+FbnSx8TOgB8yRUu0UUSLwbFgxZAEyITd4eDT1HJ9kRUOW/
         5A/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9+OrBUMZ9/fRQxCzsexJT4GgQAw4znktDO59X/HSMMOzQdaLXBEUrmPsJsy185qaHj8hWNxAJ1BWHqS2V4sAkoc4ijbYH8FhTL5FKPkbYycnRlUo7yLwaxXDM4yTgiplEj4cwK4a75/mFIwS3itS12quqEDj2xm7CqVbG4qsWpKvYwUm/FDii63ECq41GCu7mh8Xet2cp28XaJrUUPeV6H3iYFRaASzjO0Ev46hj3098ILlnsNaBV3gET
X-Gm-Message-State: AOJu0YzoVEnECOJqEyaLyFqGs5uo7h3FuVVVFnVBgDs1r/dvLXbD/6If
	JhdO/NvPsjd/eaDPrEtD8d8uJUUa+3HW5TmMUaEl5gK8HZZ7pxJD+EqZ1Zatli+5S180iUqz8Gx
	WCP8YnbwFaMSGm5DElE8FKRA/9iU=
X-Google-Smtp-Source: AGHT+IE42+xyH4NrIpeXahdIzqcAlL5FxXFQjAZ0eZL1zfwLNaD0SsQrE0K0hILKvssQPbYd96k0zQYDshOdATSrz+s=
X-Received: by 2002:a17:90b:1049:b0:2c2:cce9:2578 with SMTP id
 98e67ed59e1d1-2c2cce92bd7mr8884521a91.17.1718094665746; Tue, 11 Jun 2024
 01:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523121149.575616-1-jolsa@kernel.org> <CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
 <CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com> <20240611064641.9021829459211782902e4fb2@kernel.org>
In-Reply-To: <20240611064641.9021829459211782902e4fb2@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jun 2024 09:30:52 +0100
Message-ID: <CAEf4BzYcwUS=7KFX5fUibS9eLT8yQxYqaWF_+sVM0YZJzBD=Sg@mail.gmail.com>
Subject: Re: [PATCHv7 bpf-next 0/9] uprobe: uretprobe speed up
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Deepak Gupta <debug@rivosinc.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:46=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Wed, 5 Jun 2024 09:42:45 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Fri, May 31, 2024 at 10:52=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, May 23, 2024 at 5:11=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> =
wrote:
> > > >
> > > > hi,
> > > > as part of the effort on speeding up the uprobes [0] coming with
> > > > return uprobe optimization by using syscall instead of the trap
> > > > on the uretprobe trampoline.
> > > >
> > > > The speed up depends on instruction type that uprobe is installed
> > > > and depends on specific HW type, please check patch 1 for details.
> > > >
> > > > Patches 1-8 are based on bpf-next/master, but patch 2 and 3 are
> > > > apply-able on linux-trace.git tree probes/for-next branch.
> > > > Patch 9 is based on man-pages master.
> > > >
> > > > v7 changes:
> > > > - fixes in man page [Alejandro Colomar]
> > > > - fixed patch #1 fixes tag [Oleg]
> > > >
> > > > Also available at:
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > >   uretprobe_syscall
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > Notes to check list items in Documentation/process/adding-syscalls.=
rst:
> > > >
> > > > - System Call Alternatives
> > > >   New syscall seems like the best way in here, because we need
> > > >   just to quickly enter kernel with no extra arguments processing,
> > > >   which we'd need to do if we decided to use another syscall.
> > > >
> > > > - Designing the API: Planning for Extension
> > > >   The uretprobe syscall is very specific and most likely won't be
> > > >   extended in the future.
> > > >
> > > >   At the moment it does not take any arguments and even if it does
> > > >   in future, it's allowed to be called only from trampoline prepare=
d
> > > >   by kernel, so there'll be no broken user.
> > > >
> > > > - Designing the API: Other Considerations
> > > >   N/A because uretprobe syscall does not return reference to kernel
> > > >   object.
> > > >
> > > > - Proposing the API
> > > >   Wiring up of the uretprobe system call is in separate change,
> > > >   selftests and man page changes are part of the patchset.
> > > >
> > > > - Generic System Call Implementation
> > > >   There's no CONFIG option for the new functionality because it
> > > >   keeps the same behaviour from the user POV.
> > > >
> > > > - x86 System Call Implementation
> > > >   It's 64-bit syscall only.
> > > >
> > > > - Compatibility System Calls (Generic)
> > > >   N/A uretprobe syscall has no arguments and is not supported
> > > >   for compat processes.
> > > >
> > > > - Compatibility System Calls (x86)
> > > >   N/A uretprobe syscall is not supported for compat processes.
> > > >
> > > > - System Calls Returning Elsewhere
> > > >   N/A.
> > > >
> > > > - Other Details
> > > >   N/A.
> > > >
> > > > - Testing
> > > >   Adding new bpf selftests and ran ltp on top of this change.
> > > >
> > > > - Man Page
> > > >   Attached.
> > > >
> > > > - Do not call System Calls in the Kernel
> > > >   N/A.
> > > >
> > > >
> > > > [0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
> > > > ---
> > > > Jiri Olsa (8):
> > > >       x86/shstk: Make return uprobe work with shadow stack
> > > >       uprobe: Wire up uretprobe system call
> > > >       uprobe: Add uretprobe syscall to speed up return probe
> > > >       selftests/x86: Add return uprobe shadow stack test
> > > >       selftests/bpf: Add uretprobe syscall test for regs integrity
> > > >       selftests/bpf: Add uretprobe syscall test for regs changes
> > > >       selftests/bpf: Add uretprobe syscall call from user space tes=
t
> > > >       selftests/bpf: Add uretprobe shadow stack test
> > > >
> > >
> > > Masami, Steven,
> > >
> > > It seems like the series is ready to go in. Are you planning to take
> > > the first 4 patches through your linux-trace tree?
> >
> > Another ping. It's been two weeks since Jiri posted the last revision
> > that got no more feedback to be addressed and everyone seems to be
> > happy with it.
>
> Sorry about late reply. I agree that this is OK to go, since no other
> comments. Let me pick this up to probes/for-next branch.
>
> >
> > This is an important speed up improvement for uprobe infrastructure in
> > general and for BPF ecosystem in particular. "Uprobes are slow" is one
> > of the top complaints from production BPF users, and sys_uretprobe
> > approach is significantly improving the situation for return uprobes
> > (aka uretprobes), potentially enabling new use cases that previously
> > could have been too expensive to trace in practice and reducing the
> > overhead of the existing ones.
> >
> > I'd appreciate the engagement from linux-trace maintainers on this
> > patch set. Given it's important for BPF and that a big part of the
> > patch set is BPF-based selftests, we'd also be happy to route all this
> > through the bpf-next tree (which would actually make logistics for us
> > much easier, but that's not the main concern). But regardless of the
> > tree, it would be nice to make a decision and go forward with it.
>
> I think it would be better to include those patches together in
> linux-tree. Can you review and ack to the last patch ? ([9/9])

Sure. Jiri, please add my ack for the entire series in the next revision:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Thank you,
>
> >
> > Thank you!
> >
> > >
> > > >  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 =
+
> > > >  arch/x86/include/asm/shstk.h                                |   4 =
+
> > > >  arch/x86/kernel/shstk.c                                     |  16 =
++++
> > > >  arch/x86/kernel/uprobes.c                                   | 124 =
++++++++++++++++++++++++++++-
> > > >  include/linux/syscalls.h                                    |   2 =
+
> > > >  include/linux/uprobes.h                                     |   3 =
+
> > > >  include/uapi/asm-generic/unistd.h                           |   5 =
+-
> > > >  kernel/events/uprobes.c                                     |  24 =
++++--
> > > >  kernel/sys_ni.c                                             |   2 =
+
> > > >  tools/include/linux/compiler.h                              |   4 =
+
> > > >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 =
++++++++++++++++++++++++++++-
> > > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 385 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > >  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 =
++++
> > > >  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 =
++++
> > > >  tools/testing/selftests/x86/test_shadow_stack.c             | 145 =
++++++++++++++++++++++++++++++++++
> > > >  15 files changed, 860 insertions(+), 10 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_s=
yscall.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscal=
l.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscal=
l_executed.c
> > > >
> > > > Jiri Olsa (1):
> > > >       man2: Add uretprobe syscall page
> > > >
> > > >  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > >  1 file changed, 56 insertions(+)
> > > >  create mode 100644 man/man2/uretprobe.2
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

