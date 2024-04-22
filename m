Return-Path: <bpf+bounces-27435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76C8AD051
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0538DB25B8D
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6CB152DED;
	Mon, 22 Apr 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fllOCsPj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2F15250F;
	Mon, 22 Apr 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798590; cv=none; b=l9vs4VMba266LMJBGGgdsYTgLZgLvNeXqRHznCMmTfmXDhweIHc3pvJAckzcVJhn4gXOdKMzk9dZ1Cj23BGz6OZn0puDpIYCTh9vfC9evcSCRlegs9p7Co3xibryGexqjojLlkUf6LSVVj8EmHUjGMV9GPwyea6nA2VZ6EyqA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798590; c=relaxed/simple;
	bh=dD+RaCJlFAvcn/MSlipnM9iqz2i1DunU7FHyskt1hFw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fyev5rE+Vf9EpFFmmXoG1F2eRmNPbDF9muKqlWjCykIy7qYJ3Os4uVUP7NscZShq/FuDTP/ceNrU95Au0BPhcldIY+Q1t8iQEMVIQV9Q4nodGiAY2mTcJuzqRUlVtg7Ntv9FftX/1lEOQA0xQe8urDsq1JoArBE++rulhdN2DKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fllOCsPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CB0C113CC;
	Mon, 22 Apr 2024 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713798590;
	bh=dD+RaCJlFAvcn/MSlipnM9iqz2i1DunU7FHyskt1hFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fllOCsPjlq5CBY03FDusf6h5mfLNopP+yd2Q32x3xjIWfF7OldDHBM3nTftFfgmQ5
	 Hy1iejIsX7Cotw4BPlMqsolhcxmfkcGJaC6EZzuNDabRPisdTRcf7ykNNkefccpiZg
	 PTLuRqDzGTBJGapvQp5t5Dnop9VEl+FkIMnul1fkBa0bN5aAzz5qd/PvdecP/9VCQA
	 QIiir5gLkO6n4ux1St+D5N2ZQoNfWI1e4nJoB0gn10z3hhOE590dpRJ9x8nepZ8PW2
	 4KZjMFU2C0dVy1tMXbOW2xJp6UXfubdlGXtMgBjV7r2bK3F8Y2ezp7lD06ieIgIdN4
	 ExQvHsQBFxWMA==
Date: Tue, 23 Apr 2024 00:09:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo
 Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv3 bpf-next 0/7] uprobe: uretprobe speed up
Message-Id: <20240423000943.478ccf1e735a63c6c1b4c66b@kernel.org>
In-Reply-To: <20240421194206.1010934-1-jolsa@kernel.org>
References: <20240421194206.1010934-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jiri,

On Sun, 21 Apr 2024 21:41:59 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> hi,
> as part of the effort on speeding up the uprobes [0] coming with
> return uprobe optimization by using syscall instead of the trap
> on the uretprobe trampoline.
> 
> The speed up depends on instruction type that uprobe is installed
> and depends on specific HW type, please check patch 1 for details.
> 
> Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
> apply-able on linux-trace.git tree probes/for-next branch.
> Patch 7 is based on man-pages master.

Thanks for updated! I reviewed the series and just except for the
manpage, it looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for the series.
If Linux API maintainers are OK, I can pick this in probes/for-next.
(BTW, who will pick the manpage patch?)

Thank you,

> 
> v3 changes:
>   - added source ip check if the uretprobe syscall is called from
>     trampoline and sending SIGILL to process if it's not
>   - keep x86 compat process to use standard breakpoint
>   - split syscall wiring into separate change
>   - ran ltp and syzkaller locally, no issues found [Masami]
>   - building uprobe_compat binary in selftests which breaks
>     CI atm because of missing 32-bit delve packages, I will
>     need to fix that in separate changes once this is acked
>   - added man page change
>   - there were several changes so I removed acks [Oleg Andrii]
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
>   New syscall seems like the best way in here, becase we need
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
>   Wiring up of the uretprobe system call si in separate change,
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
> Jiri Olsa (6):
>       uprobe: Wire up uretprobe system call
>       uprobe: Add uretprobe syscall to speed up return probe
>       selftests/bpf: Add uretprobe syscall test for regs integrity
>       selftests/bpf: Add uretprobe syscall test for regs changes
>       selftests/bpf: Add uretprobe syscall call from user space test
>       selftests/bpf: Add uretprobe compat test
> 
>  arch/x86/entry/syscalls/syscall_64.tbl                    |   1 +
>  arch/x86/kernel/uprobes.c                                 | 115 ++++++++++++++++++++++++++++++
>  include/linux/syscalls.h                                  |   2 +
>  include/linux/uprobes.h                                   |   3 +
>  include/uapi/asm-generic/unistd.h                         |   5 +-
>  kernel/events/uprobes.c                                   |  24 +++++--
>  kernel/sys_ni.c                                           |   2 +
>  tools/include/linux/compiler.h                            |   4 ++
>  tools/testing/selftests/bpf/.gitignore                    |   1 +
>  tools/testing/selftests/bpf/Makefile                      |   6 +-
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c     | 123 +++++++++++++++++++++++++++++++-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 362 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall.c        |  15 ++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall_call.c   |  15 ++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c |  13 ++++
>  15 files changed, 681 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
> 
> 
> Jiri Olsa (1):
>       man2: Add uretprobe syscall page
> 
>  man2/uretprobe.2 | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 man2/uretprobe.2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

