Return-Path: <bpf+bounces-31453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF698FD313
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741B0B217A6
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF005188CBA;
	Wed,  5 Jun 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK/QLyg6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC42837A;
	Wed,  5 Jun 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605781; cv=none; b=TnuCBLdxCuKGLJwiPFp5h29wEPJ9TtTR8TxHD/KF2yWxRncfzb1SFbFE3yENFgMFMm3NdNUMTuv58Z/EoOfaadr3koSiB6MZlwyWA5295ftN3RRdyXMpeO0Ha/pY3LoZE57DEjR8/1zWW1PA7/yd1gvjio8zooGrib5iuRw5ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605781; c=relaxed/simple;
	bh=n3WvltwLnclYvUXilHbYaDwJDs8ZnJvI1qdN4d0TDTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFwWFzovHQ9XNCyMmmzjTUPCcLSmKW+SIz/4dlHZpSTUdC/geeDUQ6WhnzsDrg2p4D35vWIPrZfomPyo3J2QZBjMGPVczBmPwuDESJ3ZrgJjt5ZdAR6RLVjbQHJNp6f34QNkgJ1EnYOWMbMjrdFae8Ya+4wCsjbO05vgixaC5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK/QLyg6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-703ed15b273so156444b3a.1;
        Wed, 05 Jun 2024 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717605779; x=1718210579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf1Le7+qoXUovnxU+G8c1hBksMjj4DWz0B1IPDGyA0c=;
        b=eK/QLyg6JunRNuj8dRiXMIp5kc1N/0gNWDSF4dudoQFl+gCCIFALZ+uRybrUFmL0Jz
         9B5Z8EKHwogRYMI6ZljJXD7y/Ts/alArUZLL5BKjxEVBqsCHwgXP5gEJMDgfgkFbwBkV
         LTG/fftX6ZhgVA95OJ5HmmsgIy6vTMxbIBUpP9PlkcuH8DSJW48okgv8T2YdpcxU3NOJ
         um06wUfcGLsg+gQqQGzbEq/1Nn3RZH5LqxDYoNkzFMms8VOqJhV4p4aL1x8OgDPEVtBb
         5aC8Bqnmj7nZrVuk79hqbD+nSlg3XZxDwBnnNTJdYeAqlhvSragTvdjRRRroGdeNcIP5
         rC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717605779; x=1718210579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf1Le7+qoXUovnxU+G8c1hBksMjj4DWz0B1IPDGyA0c=;
        b=qBCLnqqJqJVwN2mRP2ixeKE+JFDPfVqbEuocuJ9OXCa53k+ybWnNqg5g36CLlRg1ik
         97JE8aRPVyJTPEPh08L7FJ3IpuPNmU6kuen9PoseEnclpjvHH4M+ayScJAO5KFWrPW/R
         yVU5RlTsoTIQExMWarbvwx9gkQpKGa8vZeYsfXq0irloUGjsP5V7tH9/3Cim13ON+nvj
         G208wptZARlx4mE/OOlgGHdFUAQYtC1YWBgLLLm2VuZfgip0B87KCE25w/cOqeeS6HoM
         GGRAqZP6VR3Up3pQ1+j9Lwv0c8AB9Xd/TzOfJkK0lLleSeMEMy6bdRA8Mji6FltBuNeX
         FSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLmGy5Kj4n013beXvMAV+oE2gO8UByr0zCXka3xyIURVWEi9j0jGt8euTOhzj32M3+QOYlRNQREpOwPepkuCG1l448+1nirMnag0sBlTWwEW3PDbBXQmE4ilhmSmX2CwBPOR/V5jbv+jo9/NHjT3IMHnI/EiojZ2M8PVa224v5x51Ajt0A94wHjvRlQ8Ln6cpyGQkfK166fPnmAYB7gq5nRiO8WS6CQ3J4pva82+G3kpIGCRyy0aHAgU+P
X-Gm-Message-State: AOJu0Yx25Fepi1r6BR/m7YC0WVcynzFmaO+EVPOPi3sZdSd/8hrtnwj9
	4IWECmNR0b+uHl+9KrdBDSXcpZ2V/UV36PGWrou7kZhhwbIT4Jfbo8dmNxm27oHe1IjrjYOotkS
	jdtlmV1FyUxpXfgzt7A23al2qjho=
X-Google-Smtp-Source: AGHT+IG5n0s2oEhfAO6XUF/dV0EPCSSfbE2zPMWSDNTH3B1k6Tte7LW9IdlSFU8scsFdk2MB4v56+E07umaPuXl1qWE=
X-Received: by 2002:a17:90b:33ca:b0:2bf:ea42:d0c3 with SMTP id
 98e67ed59e1d1-2c27db1652bmr2817571a91.16.1717605778997; Wed, 05 Jun 2024
 09:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523121149.575616-1-jolsa@kernel.org> <CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
In-Reply-To: <CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jun 2024 09:42:45 -0700
Message-ID: <CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com>
Subject: Re: [PATCHv7 bpf-next 0/9] uprobe: uretprobe speed up
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
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

On Fri, May 31, 2024 at 10:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 23, 2024 at 5:11=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > hi,
> > as part of the effort on speeding up the uprobes [0] coming with
> > return uprobe optimization by using syscall instead of the trap
> > on the uretprobe trampoline.
> >
> > The speed up depends on instruction type that uprobe is installed
> > and depends on specific HW type, please check patch 1 for details.
> >
> > Patches 1-8 are based on bpf-next/master, but patch 2 and 3 are
> > apply-able on linux-trace.git tree probes/for-next branch.
> > Patch 9 is based on man-pages master.
> >
> > v7 changes:
> > - fixes in man page [Alejandro Colomar]
> > - fixed patch #1 fixes tag [Oleg]
> >
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   uretprobe_syscall
> >
> > thanks,
> > jirka
> >
> >
> > Notes to check list items in Documentation/process/adding-syscalls.rst:
> >
> > - System Call Alternatives
> >   New syscall seems like the best way in here, because we need
> >   just to quickly enter kernel with no extra arguments processing,
> >   which we'd need to do if we decided to use another syscall.
> >
> > - Designing the API: Planning for Extension
> >   The uretprobe syscall is very specific and most likely won't be
> >   extended in the future.
> >
> >   At the moment it does not take any arguments and even if it does
> >   in future, it's allowed to be called only from trampoline prepared
> >   by kernel, so there'll be no broken user.
> >
> > - Designing the API: Other Considerations
> >   N/A because uretprobe syscall does not return reference to kernel
> >   object.
> >
> > - Proposing the API
> >   Wiring up of the uretprobe system call is in separate change,
> >   selftests and man page changes are part of the patchset.
> >
> > - Generic System Call Implementation
> >   There's no CONFIG option for the new functionality because it
> >   keeps the same behaviour from the user POV.
> >
> > - x86 System Call Implementation
> >   It's 64-bit syscall only.
> >
> > - Compatibility System Calls (Generic)
> >   N/A uretprobe syscall has no arguments and is not supported
> >   for compat processes.
> >
> > - Compatibility System Calls (x86)
> >   N/A uretprobe syscall is not supported for compat processes.
> >
> > - System Calls Returning Elsewhere
> >   N/A.
> >
> > - Other Details
> >   N/A.
> >
> > - Testing
> >   Adding new bpf selftests and ran ltp on top of this change.
> >
> > - Man Page
> >   Attached.
> >
> > - Do not call System Calls in the Kernel
> >   N/A.
> >
> >
> > [0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
> > ---
> > Jiri Olsa (8):
> >       x86/shstk: Make return uprobe work with shadow stack
> >       uprobe: Wire up uretprobe system call
> >       uprobe: Add uretprobe syscall to speed up return probe
> >       selftests/x86: Add return uprobe shadow stack test
> >       selftests/bpf: Add uretprobe syscall test for regs integrity
> >       selftests/bpf: Add uretprobe syscall test for regs changes
> >       selftests/bpf: Add uretprobe syscall call from user space test
> >       selftests/bpf: Add uretprobe shadow stack test
> >
>
> Masami, Steven,
>
> It seems like the series is ready to go in. Are you planning to take
> the first 4 patches through your linux-trace tree?

Another ping. It's been two weeks since Jiri posted the last revision
that got no more feedback to be addressed and everyone seems to be
happy with it.

This is an important speed up improvement for uprobe infrastructure in
general and for BPF ecosystem in particular. "Uprobes are slow" is one
of the top complaints from production BPF users, and sys_uretprobe
approach is significantly improving the situation for return uprobes
(aka uretprobes), potentially enabling new use cases that previously
could have been too expensive to trace in practice and reducing the
overhead of the existing ones.

I'd appreciate the engagement from linux-trace maintainers on this
patch set. Given it's important for BPF and that a big part of the
patch set is BPF-based selftests, we'd also be happy to route all this
through the bpf-next tree (which would actually make logistics for us
much easier, but that's not the main concern). But regardless of the
tree, it would be nice to make a decision and go forward with it.

Thank you!

>
> >  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
> >  arch/x86/include/asm/shstk.h                                |   4 +
> >  arch/x86/kernel/shstk.c                                     |  16 ++++
> >  arch/x86/kernel/uprobes.c                                   | 124 ++++=
++++++++++++++++++++++++-
> >  include/linux/syscalls.h                                    |   2 +
> >  include/linux/uprobes.h                                     |   3 +
> >  include/uapi/asm-generic/unistd.h                           |   5 +-
> >  kernel/events/uprobes.c                                     |  24 ++++=
--
> >  kernel/sys_ni.c                                             |   2 +
> >  tools/include/linux/compiler.h                              |   4 +
> >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++=
++++++++++++++++++++++++-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 385 ++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
> >  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 ++++
> >  tools/testing/selftests/x86/test_shadow_stack.c             | 145 ++++=
++++++++++++++++++++++++++++++
> >  15 files changed, 860 insertions(+), 10 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_sysca=
ll.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_ex=
ecuted.c
> >
> > Jiri Olsa (1):
> >       man2: Add uretprobe syscall page
> >
> >  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 man/man2/uretprobe.2

