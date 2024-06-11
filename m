Return-Path: <bpf+bounces-31843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1172903F3E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2991C232DA
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F912E61;
	Tue, 11 Jun 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2qn/9SC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD96C8FB;
	Tue, 11 Jun 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117555; cv=none; b=bcbWtq8HQUHLW3PL9DO0abhISoEkxhbIuzjtvHWgTYyiSqdOqz4WLRNHRFw3NTSd5zddfklDmf0i/HEk5PykDSuu22tOYzGdOLJ7qdT4mJvhaN3YaSjnMhg5MzhJMjZOgSTCyhRNhYVaqgrj9eu5FvpHTwD2JbRgVknAiqILIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117555; c=relaxed/simple;
	bh=eNbDNNAuqp/CblfbjmFVWsYldsOh15uvWduPZlV6ox8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T1mu/eaWsxM203A6Wq83YlP1ZcTDtMr86Dn6JDYDXfLjWtOiUuJveaqs16qEZqhedWfVFq9Hp6eu35nHv+IvwYPUIxcNrYdqf6R8gDNn9iaY332lDpEK4FwxwFsGcimGOsAZgHAge/9q9wdzgwb+WPLkseiDWFn8V6m39ccdzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2qn/9SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B910AC2BD10;
	Tue, 11 Jun 2024 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718117555;
	bh=eNbDNNAuqp/CblfbjmFVWsYldsOh15uvWduPZlV6ox8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l2qn/9SCNKz5QiFJF3cuiRWVAiq7wohguBn/+HKH9qTEJM9mcCyryzZbX1TWn4ueL
	 JQrONN4x9Y4FJsXo+jBueCQ24Ue+hUAnsvMQ/s0EAreatREGoa+8ULUUC1gwHNlrpR
	 APlERx/0NXqxllIYB9JHmrqNeyvn20Bm2Tw6ttKEq5wObrqrVPj3i2Cl+ooPDw1nJl
	 bVnDYobae5KjehxTsG+HHK2eMDl9nnmYze3I9XyBGFZ6VoMt7lMoi1yAWvx68UCmMh
	 iU/vdfvuT5HPxLeVJfP2qa6XtzapOiNg0Xwar4kZvQMkgXxV3CNowj7YCZy1pbIAnV
	 h+iyFGMwJx7Mw==
Date: Tue, 11 Jun 2024 23:52:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv8 bpf-next 0/9] uprobe: uretprobe speed up
Message-Id: <20240611235228.f70de698f8e43a3c177a15b8@kernel.org>
In-Reply-To: <20240611112158.40795-1-jolsa@kernel.org>
References: <20240611112158.40795-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:21:49 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

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
> v8 changes:
> - rebased (another new syscall got merged)
> - added acks
> 
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   uretprobe_syscall

Applied patch [1/9] - [8/9] on probes/for-next in 
 git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

Thank you!

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
>  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
>  arch/x86/include/asm/shstk.h                                |   4 +
>  arch/x86/kernel/shstk.c                                     |  16 ++++
>  arch/x86/kernel/uprobes.c                                   | 124 ++++++++++++++++++++++++++++-
>  include/linux/syscalls.h                                    |   2 +
>  include/linux/uprobes.h                                     |   3 +
>  include/uapi/asm-generic/unistd.h                           |   5 +-
>  kernel/events/uprobes.c                                     |  24 ++++--
>  kernel/sys_ni.c                                             |   2 +
>  tools/include/linux/compiler.h                              |   4 +
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++++++++++++++++++++++++++-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 ++++
>  tools/testing/selftests/x86/test_shadow_stack.c             | 145 ++++++++++++++++++++++++++++++++++
>  15 files changed, 860 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> 
> Jiri Olsa (1):
>       man2: Add uretprobe syscall page
> 
>  man/man2/uretprobe.2 | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 man/man2/uretprobe.2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

