Return-Path: <bpf+bounces-31909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4419904C45
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 09:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106A0B2460A
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3D816B748;
	Wed, 12 Jun 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALyBJWp4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079B156222;
	Wed, 12 Jun 2024 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175759; cv=none; b=I4iluAm733Xk24OZr04b6i1PCYbttF7W6RIMePzBXNADJNp+TBelhdiKJwwoQ+qELK48+OXWjRmh20WizdWdrvXRUnfT7k8kUEkGp0DUFoAete9ykPGe6iWs3STNLqiTqwqeoLKQZu26IOqIpEzJVWejt42vO37XRbciArOgRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175759; c=relaxed/simple;
	bh=J/yVHwlCx0SSNOA13os1gLLRefppTZlosqIv5gqL8Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEj5DtRQRflKkJmN9A9EGkahR+WgEIJJqjiFtAWppTXr2DWgIVW7q31jXb2obXbjUcpPGisA7r95Ds3WckzPOQAsqTtW6mYYHJQoJ2u9MrbzRm7Zi6SB1ay18hDn+q9QWc6DA3x0yCjZZaumWIw5rkndsj0I7v5vjE+I4emvxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALyBJWp4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so3908434a12.0;
        Wed, 12 Jun 2024 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718175757; x=1718780557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11lKSsj1AVPuJZdBE+6Cqq9/3ElM9E/sLmElaFQuHPY=;
        b=ALyBJWp48LQR/ibW2Qn5nr9XAnZn8SvvEiCzzruEc00+xVmrxjfPjjfOavfUr7Q7cX
         LvTAbSiv2n74ip3Ohh66lXvM2oxBz3vgCo/nO+yv8ZWwxRAT2NGcBiWVn+wC1oG+7ory
         MExjBTDuO/VGIRPMUe89sfcB7zOfHuDzvZkZthqgLa4OCn05dRX39pDmdRRwie2cTot3
         srgOL31NezZnfMSAuHw6k+q78OpIl/8EIotBQ5JYjNRPmopoM8UgZSpukTbvmYgeOySH
         Sicom1Z4dwMyytBgoTCRAY7qAefQcEa8phHE4bouo4ipaMAeAhJM/cMYXVALD/uwzcjL
         U3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175757; x=1718780557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11lKSsj1AVPuJZdBE+6Cqq9/3ElM9E/sLmElaFQuHPY=;
        b=g4yLHxeL6axjk8vj9/z5hDQyDuuLelLOw2iG1SPLEKhAfXefBoTdMT/95YKhxVBSSU
         ro8ZdEHIVBAZygd5D/eJi024pj18r5IfzuYnWDbcT6nW+ktx4IDUzY1ATDvCk83r8X/f
         Lsr4WvNyck2LPVnGgxKM+j5MLo42dye637+vCyXGu2nDZT7/aryQmXU25QSAwpPq6lwu
         UsX4xZ30P0VY0IOj52jleZSK95exDF0IYiG1RKMzWXGJj4YOygw/5Qa1yIKNyC1BvPw8
         0CYX5rrLcEBEA3YxhDK1sZPzt6UAOUvZq2o7A159YY/XZ9SvQvTwFbGY0+KMtnHj/5p2
         FStw==
X-Forwarded-Encrypted: i=1; AJvYcCWuQ/1mbPRtJ3uBBgoEBNc11QzhqbEuwKi1xwQtaJJ6HJdpLzys5jKpO6J4vqoqa33kGVnHxlVEAidohkCQwxHrXTQg0H65K9XAEE7+r5KhHPf3mq6UhWgLXY5bzL6vPvYM1fIPb71fshqV0tUpZGsSa3mZCCN+xP3H86D3sqWT1KOj3oDQB/DC9vOkVbbjg4O4BFD5wgKRo9LfdqF+tRycNgnPo5ajpIs/SJ4Jmy+E7TtDX0mwJb6+om4H
X-Gm-Message-State: AOJu0YwefpuKJ8Yu6yv5J9hnhtyS/7+lAPlKfOBgHpNRFWKD5yRHQp4h
	KCI1zDeieIVLStu0fmOS9cizQktLNMGopMnfryBqvR3PTDK2C6vgSYr4TycqCx/z9cbpGRRNfxM
	5oN7Z3X+6uOi6U2MSJ6ZsQR8mpdU=
X-Google-Smtp-Source: AGHT+IFd7aScjoB1o5nbbLRHp/KbqDDY5CR5RTuqnjrw9jR8jB5FFSGCGSERy0hRoO0KfOZjYySRww0bR/A2dhWSgUM=
X-Received: by 2002:a17:90a:a082:b0:2c2:c662:ca5 with SMTP id
 98e67ed59e1d1-2c4a76d4e35mr948305a91.30.1718175757398; Wed, 12 Jun 2024
 00:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611112158.40795-1-jolsa@kernel.org> <20240611235228.f70de698f8e43a3c177a15b8@kernel.org>
In-Reply-To: <20240611235228.f70de698f8e43a3c177a15b8@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Jun 2024 08:02:25 +0100
Message-ID: <CAEf4BzZzE94QUdhWPmrMzRBRLa=nm86Mdm5vow688jKq3HzJeA@mail.gmail.com>
Subject: Re: [PATCHv8 bpf-next 0/9] uprobe: uretprobe speed up
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
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

On Tue, Jun 11, 2024 at 3:52=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 11 Jun 2024 13:21:49 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>
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
> > v8 changes:
> > - rebased (another new syscall got merged)
> > - added acks
> >
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   uretprobe_syscall
>
> Applied patch [1/9] - [8/9] on probes/for-next in
>  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>

Thanks, Masami, looks good! I also confirmed that probes/for-next and
bpf-next/master can be merged with no conflicts (hopefully it stays
this way till the next merge window).

> Thank you!
>
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
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

