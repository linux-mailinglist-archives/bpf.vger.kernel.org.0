Return-Path: <bpf+bounces-31059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337C8D6884
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8791EB25D57
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A08517C7CD;
	Fri, 31 May 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1KgAiDv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19F17CA1D;
	Fri, 31 May 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177990; cv=none; b=enHenzLIfglV6oZQN2GLZYVkgul0y8+BOMdqRGK7fEuMdOTVPOTZtWV7wOXoJrcjJS4IuMl07hU64dDn3FACXTbniAECqNmkSAtWtE5JqfhjFCE+VeXmN7hkuauHbiOVSnIz6tQTxOhlDuarP9Fw+GR4617zzQPtbAJvG/VOZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177990; c=relaxed/simple;
	bh=waSx+8OBB0cB30k7vFW7e2Z+l+E4WLh3misPPpnZH8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC35jI7zXzM/oi7cZ582EdBcmROz3tlKFrhD4ZHi3eX85hxI5O/rCTzJgk1xSU7Jb3oB0EDKGi58jffCzOQ6mTzvUK12Gkh1g1T682vP0O/sAAxSiAyGCN9bXs+CStuXPaR2kqu7CIFAv0Vgjj1GjllECdhaozNJJYtaPKq3fA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1KgAiDv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c1e7708cfdso595217a91.2;
        Fri, 31 May 2024 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717177988; x=1717782788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok+HgwHbOJUwlMQ8Je/jHasD4pYJWwujaLu9FwWJ6kM=;
        b=J1KgAiDvWVK39S4J5+KUGqjFWlKGZJ51brcWQ8fr+Dv0tTo9xAfFXz0KZgCpkD6Tr9
         lN7mlo2V5ZqDMtKgJa6qUsuDvnaP4V+a2SKp+03PJG6I/RsFAEoD36PFbIeM38aCNFIh
         REWCI6NsP+bUi6GTWATSKPK71gzip87LxFKH0QjlDLgmkWwlkltNNzChwM6+L81YGuSm
         TAkrsPKG88i7oGSyhm41uy/ETGZKwD5mzciR8WHBOMRctjcb1z7VfrCF8bUMHK+aDmM3
         suL6lRM1YqX/vRiJK1MCTJXmhJ6KbSakiNFXzJK8kWXg/FEsGlwDwQfmb1wijzpGaYTt
         dJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717177988; x=1717782788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok+HgwHbOJUwlMQ8Je/jHasD4pYJWwujaLu9FwWJ6kM=;
        b=qxmqKXk1efl/1joPXHQ4ao67q6RhAklF2n8goZOO40ao9iyQyZn7qsMIx49xKOCMXA
         P7TwE60f3yUVUJ0axlL5rkwpgsrZ18CX8c8pf0wFv4OmXqg5xnfHVWnie+Bjq/hLUMMm
         Au6dsj9z1v+vQUruvpPpYlktjNUlUE+xt60XB935TnSnDoJB0+u0scgtXsvDrsbsG6ET
         P6yNTXRl323ysbOzQmqiet7gIPNMranhq38yuYuRmfN0cA015z1Ir50ioG4bi9RWuy+G
         p1rd3QPh7WX3lJSrHvD24Uk8VWziD1I4CDVA6jtCcnAeHRKgep8B8pkUASNedDF3nwtV
         9puQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBvtO6R+pJMoF+oVx0IobNCT2ssc2sq2lqxECC0+MARCwqtVtopcOn0fcfe+9mN4VNB9LwMibNjefKG43Yl4gI+3UErssWsqShcNxDxnH1Liyd79JClY86Ex8mwI/oKtfGJkm/T+v6yy6+glLaYho5rCddVtKrf2Pohihc855kXTtYGXP6hnrU5KNGoFeKp3hd7Gg5erPViHx6hBg3wdQMIStThujo6aA9ULuG6l4pthpgan7OEqu3BBXL
X-Gm-Message-State: AOJu0YyOd97Kh127rakt/9szjD6F6k88D+12OyFXF3yKhB9/XKCRExge
	soJc5ghQ96U2+JgJfFcIZvuAVBXZHU2yo0tFbSl+S5WPMov+MFSeUiAUG7WHztidu8BjkaK92Id
	xgXAUeQZ9+605sxbe+IrT/o/VeIA=
X-Google-Smtp-Source: AGHT+IHOKpRQLQbhFE4qcc0Y4SOtlKCHPI3lY+kJC3zbGnA8+2fx1XzMDbqjQJvxUvAYRXhX1GIY0qB6MZv/GCX4G8o=
X-Received: by 2002:a17:90a:5296:b0:2c1:9048:4d95 with SMTP id
 98e67ed59e1d1-2c1dc58edd9mr2447955a91.20.1717177987636; Fri, 31 May 2024
 10:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523121149.575616-1-jolsa@kernel.org>
In-Reply-To: <20240523121149.575616-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 10:52:54 -0700
Message-ID: <CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
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
	Deepak Gupta <debug@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 5:11=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> as part of the effort on speeding up the uprobes [0] coming with
> return uprobe optimization by using syscall instead of the trap
> on the uretprobe trampoline.
>
> The speed up depends on instruction type that uprobe is installed
> and depends on specific HW type, please check patch 1 for details.
>
> Patches 1-8 are based on bpf-next/master, but patch 2 and 3 are
> apply-able on linux-trace.git tree probes/for-next branch.
> Patch 9 is based on man-pages master.
>
> v7 changes:
> - fixes in man page [Alejandro Colomar]
> - fixed patch #1 fixes tag [Oleg]
>
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   uretprobe_syscall
>
> thanks,
> jirka
>
>
> Notes to check list items in Documentation/process/adding-syscalls.rst:
>
> - System Call Alternatives
>   New syscall seems like the best way in here, because we need
>   just to quickly enter kernel with no extra arguments processing,
>   which we'd need to do if we decided to use another syscall.
>
> - Designing the API: Planning for Extension
>   The uretprobe syscall is very specific and most likely won't be
>   extended in the future.
>
>   At the moment it does not take any arguments and even if it does
>   in future, it's allowed to be called only from trampoline prepared
>   by kernel, so there'll be no broken user.
>
> - Designing the API: Other Considerations
>   N/A because uretprobe syscall does not return reference to kernel
>   object.
>
> - Proposing the API
>   Wiring up of the uretprobe system call is in separate change,
>   selftests and man page changes are part of the patchset.
>
> - Generic System Call Implementation
>   There's no CONFIG option for the new functionality because it
>   keeps the same behaviour from the user POV.
>
> - x86 System Call Implementation
>   It's 64-bit syscall only.
>
> - Compatibility System Calls (Generic)
>   N/A uretprobe syscall has no arguments and is not supported
>   for compat processes.
>
> - Compatibility System Calls (x86)
>   N/A uretprobe syscall is not supported for compat processes.
>
> - System Calls Returning Elsewhere
>   N/A.
>
> - Other Details
>   N/A.
>
> - Testing
>   Adding new bpf selftests and ran ltp on top of this change.
>
> - Man Page
>   Attached.
>
> - Do not call System Calls in the Kernel
>   N/A.
>
>
> [0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
> ---
> Jiri Olsa (8):
>       x86/shstk: Make return uprobe work with shadow stack
>       uprobe: Wire up uretprobe system call
>       uprobe: Add uretprobe syscall to speed up return probe
>       selftests/x86: Add return uprobe shadow stack test
>       selftests/bpf: Add uretprobe syscall test for regs integrity
>       selftests/bpf: Add uretprobe syscall test for regs changes
>       selftests/bpf: Add uretprobe syscall call from user space test
>       selftests/bpf: Add uretprobe shadow stack test
>

Masami, Steven,

It seems like the series is ready to go in. Are you planning to take
the first 4 patches through your linux-trace tree?

>  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
>  arch/x86/include/asm/shstk.h                                |   4 +
>  arch/x86/kernel/shstk.c                                     |  16 ++++
>  arch/x86/kernel/uprobes.c                                   | 124 ++++++=
++++++++++++++++++++++-
>  include/linux/syscalls.h                                    |   2 +
>  include/linux/uprobes.h                                     |   3 +
>  include/uapi/asm-generic/unistd.h                           |   5 +-
>  kernel/events/uprobes.c                                     |  24 ++++--
>  kernel/sys_ni.c                                             |   2 +
>  tools/include/linux/compiler.h                              |   4 +
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++++=
++++++++++++++++++++++-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 385 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 ++++
>  tools/testing/selftests/x86/test_shadow_stack.c             | 145 ++++++=
++++++++++++++++++++++++++++
>  15 files changed, 860 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_exec=
uted.c
>
> Jiri Olsa (1):
>       man2: Add uretprobe syscall page
>
>  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 man/man2/uretprobe.2

