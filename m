Return-Path: <bpf+bounces-31751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA8902AD0
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 23:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232861C2140A
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15114757F3;
	Mon, 10 Jun 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBcfXOCN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265D6AB6;
	Mon, 10 Jun 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056009; cv=none; b=tNSGxUWQG81EUWqxlOtzAX48vh8/BmAtCG7ERX4SNj+jfgAZu0TtbuHmq8qPnA/N1JBc1WWi/8m7a8IM3TKE0gyss9ojTOj5+ICsnnNCwwQMXCuYePSr9kb604YcYoTfom2k1NhyR+B+tDyOJFKSRlJdm6sG4+gdIJekCvp8JkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056009; c=relaxed/simple;
	bh=7OBszLOSVa3SJfz0oOSikJ/3PkDA/j9tpVJwjUuZJ0A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rh3L+XGkEB2suvyMvj1f+1IvbVkCxx+tMmAi4tcNBQgjj+LRymqR6UlcNcok2kSAp9zDANQFr7NE3oipOAsFcyelbpCwQViWil+ByWGTQSTNCY5qOvBNX+s2HxFYvqePiVHIvDQL00LNvu/Vwz8QDCYNPDDZQOoo3JbSz2E0Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBcfXOCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D7AC2BBFC;
	Mon, 10 Jun 2024 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056009;
	bh=7OBszLOSVa3SJfz0oOSikJ/3PkDA/j9tpVJwjUuZJ0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WBcfXOCNRjJNH0sAOgsdbMUHjfuTr2hvUI7/L/gqO6jMxMuMeDGQqnSUI+HvIRiOL
	 t1rmbSCDelYJKxDpXwfxqkDipUaJJzm4XJorWD75OYdnbfjCP0Vi+ygdzINAs83dLs
	 ObMnZ57MaxLTp2iX9CgyKAXpsUuEBiHuNVdtz6q3/zuEkmLe/WA/MRh+I0jzaqXxNE
	 WSp5X74zRBORhkVL/x8Qqha2lLuOnoKLd3E+KRlzeYIgsnpJAo5NS+jeftgs6mnsga
	 os8Vwy7HqZRb4Ffi2bbams5WeVi0OHEbHW/SCUcr7AwG2LSpEnGFVp9Ufizt5RiZN5
	 d0BbvfQZvlvbw==
Date: Tue, 11 Jun 2024 06:46:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv7 bpf-next 0/9] uprobe: uretprobe speed up
Message-Id: <20240611064641.9021829459211782902e4fb2@kernel.org>
In-Reply-To: <CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com>
References: <20240523121149.575616-1-jolsa@kernel.org>
	<CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
	<CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 5 Jun 2024 09:42:45 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Fri, May 31, 2024 at 10:52 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, May 23, 2024 at 5:11 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > hi,
> > > as part of the effort on speeding up the uprobes [0] coming with
> > > return uprobe optimization by using syscall instead of the trap
> > > on the uretprobe trampoline.
> > >
> > > The speed up depends on instruction type that uprobe is installed
> > > and depends on specific HW type, please check patch 1 for details.
> > >
> > > Patches 1-8 are based on bpf-next/master, but patch 2 and 3 are
> > > apply-able on linux-trace.git tree probes/for-next branch.
> > > Patch 9 is based on man-pages master.
> > >
> > > v7 changes:
> > > - fixes in man page [Alejandro Colomar]
> > > - fixed patch #1 fixes tag [Oleg]
> > >
> > > Also available at:
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   uretprobe_syscall
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > Notes to check list items in Documentation/process/adding-syscalls.rst:
> > >
> > > - System Call Alternatives
> > >   New syscall seems like the best way in here, because we need
> > >   just to quickly enter kernel with no extra arguments processing,
> > >   which we'd need to do if we decided to use another syscall.
> > >
> > > - Designing the API: Planning for Extension
> > >   The uretprobe syscall is very specific and most likely won't be
> > >   extended in the future.
> > >
> > >   At the moment it does not take any arguments and even if it does
> > >   in future, it's allowed to be called only from trampoline prepared
> > >   by kernel, so there'll be no broken user.
> > >
> > > - Designing the API: Other Considerations
> > >   N/A because uretprobe syscall does not return reference to kernel
> > >   object.
> > >
> > > - Proposing the API
> > >   Wiring up of the uretprobe system call is in separate change,
> > >   selftests and man page changes are part of the patchset.
> > >
> > > - Generic System Call Implementation
> > >   There's no CONFIG option for the new functionality because it
> > >   keeps the same behaviour from the user POV.
> > >
> > > - x86 System Call Implementation
> > >   It's 64-bit syscall only.
> > >
> > > - Compatibility System Calls (Generic)
> > >   N/A uretprobe syscall has no arguments and is not supported
> > >   for compat processes.
> > >
> > > - Compatibility System Calls (x86)
> > >   N/A uretprobe syscall is not supported for compat processes.
> > >
> > > - System Calls Returning Elsewhere
> > >   N/A.
> > >
> > > - Other Details
> > >   N/A.
> > >
> > > - Testing
> > >   Adding new bpf selftests and ran ltp on top of this change.
> > >
> > > - Man Page
> > >   Attached.
> > >
> > > - Do not call System Calls in the Kernel
> > >   N/A.
> > >
> > >
> > > [0] https://lore.kernel.org/bpf/ZeCXHKJ--iYYbmLj@krava/
> > > ---
> > > Jiri Olsa (8):
> > >       x86/shstk: Make return uprobe work with shadow stack
> > >       uprobe: Wire up uretprobe system call
> > >       uprobe: Add uretprobe syscall to speed up return probe
> > >       selftests/x86: Add return uprobe shadow stack test
> > >       selftests/bpf: Add uretprobe syscall test for regs integrity
> > >       selftests/bpf: Add uretprobe syscall test for regs changes
> > >       selftests/bpf: Add uretprobe syscall call from user space test
> > >       selftests/bpf: Add uretprobe shadow stack test
> > >
> >
> > Masami, Steven,
> >
> > It seems like the series is ready to go in. Are you planning to take
> > the first 4 patches through your linux-trace tree?
> 
> Another ping. It's been two weeks since Jiri posted the last revision
> that got no more feedback to be addressed and everyone seems to be
> happy with it.

Sorry about late reply. I agree that this is OK to go, since no other
comments. Let me pick this up to probes/for-next branch.

> 
> This is an important speed up improvement for uprobe infrastructure in
> general and for BPF ecosystem in particular. "Uprobes are slow" is one
> of the top complaints from production BPF users, and sys_uretprobe
> approach is significantly improving the situation for return uprobes
> (aka uretprobes), potentially enabling new use cases that previously
> could have been too expensive to trace in practice and reducing the
> overhead of the existing ones.
> 
> I'd appreciate the engagement from linux-trace maintainers on this
> patch set. Given it's important for BPF and that a big part of the
> patch set is BPF-based selftests, we'd also be happy to route all this
> through the bpf-next tree (which would actually make logistics for us
> much easier, but that's not the main concern). But regardless of the
> tree, it would be nice to make a decision and go forward with it.

I think it would be better to include those patches together in 
linux-tree. Can you review and ack to the last patch ? ([9/9])

Thank you,

> 
> Thank you!
> 
> >
> > >  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
> > >  arch/x86/include/asm/shstk.h                                |   4 +
> > >  arch/x86/kernel/shstk.c                                     |  16 ++++
> > >  arch/x86/kernel/uprobes.c                                   | 124 ++++++++++++++++++++++++++++-
> > >  include/linux/syscalls.h                                    |   2 +
> > >  include/linux/uprobes.h                                     |   3 +
> > >  include/uapi/asm-generic/unistd.h                           |   5 +-
> > >  kernel/events/uprobes.c                                     |  24 ++++--
> > >  kernel/sys_ni.c                                             |   2 +
> > >  tools/include/linux/compiler.h                              |   4 +
> > >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++++++++++++++++++++++++++-
> > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
> > >  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 ++++
> > >  tools/testing/selftests/x86/test_shadow_stack.c             | 145 ++++++++++++++++++++++++++++++++++
> > >  15 files changed, 860 insertions(+), 10 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > >
> > > Jiri Olsa (1):
> > >       man2: Add uretprobe syscall page
> > >
> > >  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644 man/man2/uretprobe.2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

