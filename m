Return-Path: <bpf+bounces-28463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED318B9ECF
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F063C1F22620
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376016F90C;
	Thu,  2 May 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dixGCaLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1516F909;
	Thu,  2 May 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668196; cv=none; b=pwvAwXfOea906HOsjp2WsZszhzb8/fhW9xGC7zEo8bWIiFRvU4BKIyH2fRWsONRk3oBttz4tp6kJZ1OMp8YtVhTzL6E/QsHwvKXetUNiGwzZJg7d8NKE2CJnIyqJYBIWjUmIEOM/x9iO8vZmDTg/ieDCEDo+C+0Y3beOjF5HF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668196; c=relaxed/simple;
	bh=RFy4+j0opYnpeIrI1WfIQZPJ0RGDYHUH2D6UFaD4Q80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euI4UfMlQIDfA9Lse695rvLtXkJwwjomzEMUx2VQdkRrf7nNLMFNv5DA/dtgAEbPrszNAV/cbwRZvvBfk/KmcVAflp4I9MB/NkkzzTOaePxbooa+xBHxCLh1ZAp/E9H1P3JERr/pye9n/NvSXEMqidQZqRltSbrJP+1gDI1X75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dixGCaLt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso5551368a12.3;
        Thu, 02 May 2024 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714668194; x=1715272994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJNrXG9n5/FYva5Fdmu0bq0xk3zaq4EXIV0PX+SkLu8=;
        b=dixGCaLt0BWHPQwWNHyqCADjEvAAyiug0EGVCPF+Z8yLCSpmkW34Pdx+C7vrgLxld9
         BxF8g10jd/JRmMvMtl/Z5HeZhULReDsUjpFC5QzBGQmRAUQu1Mh1ClXuXrg+iHf3l+FA
         EcI9DKUP4sN7IfjaxowMIllZbazQepC9izav/zBEEPBiZ+k7Z/njzhp5HrfGEPiSi4Pe
         n/XbevrcLBKKgE8j3xWMhQF7eH+sapT3m2kL2qR66luWHrbcalFSePzlc+/oEazOdNrb
         87E7yWBJs78y6Qmckh+YnrL8YBXF/RqRiXovpnm1M96Cjrvcm6sBkW68tx9t/Sx86JeA
         h4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714668194; x=1715272994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJNrXG9n5/FYva5Fdmu0bq0xk3zaq4EXIV0PX+SkLu8=;
        b=QvP8vt9sQ1ZX066qpqV60jW2iZec8qUz+Ezr6F8Df4nlGymYd6H19zsPEQgSwF6MkE
         NCZ5gWg2jfkJnxQbVXEpob/+ABejMw4kGl8xrwgxQmJdSrt3ntRoreZL/BEBxGQxwIEY
         Ilg+5ujKml5pG6BCKh+Zb7TeTQ5dRmQvEOfJzy6U77R3i01FkUlrCI+I5q9m7TyGOmxq
         f8hfYtXhw0E0MYHdpy8mpfVMsAL++wI7tFUc09AMdF9o4pIUT9QNbJrxu9dzzXZcuTSk
         Qsj+wH1FLZfKVn04jwT/wBKptSbxzBLbl4ktPWylnxb6EDGtGijcvJhPd8YFOsfq5LZa
         iryA==
X-Forwarded-Encrypted: i=1; AJvYcCUahSnbgdZD+WPgrJAwwEFFLfAE1yEu93OXX85VLUogid4rkJgileEv1wp1gyKLMiBg635VvtFAtMTqxUydO+grSTCYrlTvKsotGmxeoffBDmb0rNOISAF345kw641+aLUg0lNFdNPyaBfoQsALIU2i0+6wsh8zWMnmHDwkm+1P28Pjn7QU91Pq0WmOrq5izfobyixhXnocZqf945TKV/of+Yj640PvNMDMxaPJe6pwsK5nZMsY3bjrIc2W
X-Gm-Message-State: AOJu0Yzd2vdVP1f2mqcwN/1DXF/wXIA09CoplJgf2jVyyrQjp8mHkdG0
	kujIC438hCtFHMV6SjIRF0nJo2VDrAnlOgqjV8kPnzZhLa05RJschoJIxVq7022zqnMh7mEJ8Yr
	Yye0xUEVHf05RZ7jexnmmFhqykQk=
X-Google-Smtp-Source: AGHT+IG+VXyF88qhnWvN+UrqpH4U04K7AdN9AlDvW9mYk55ZGORLKoNy53WfyuOtXzJc5Wgg/HkE6p+zRnqKR5SM08M=
X-Received: by 2002:a17:90b:11d4:b0:2b2:7c53:2601 with SMTP id
 gv20-20020a17090b11d400b002b27c532601mr299072pjb.37.1714668194193; Thu, 02
 May 2024 09:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502122313.1579719-1-jolsa@kernel.org>
In-Reply-To: <20240502122313.1579719-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 09:43:02 -0700
Message-ID: <CAEf4BzYxsRMx9M_AiLavTHFpndSmZqOM8QcYhDTbBviSpv1r+A@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 0/7] uprobe: uretprobe speed up
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:23=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
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
>
> v4 changes:
>   - added acks [Oleg,Andrii,Masami]
>   - reworded the man page and adding more info to NOTE section [Masami]
>   - rewrote bpf tests not to use trace_pipe [Andrii]
>   - cc-ed linux-man list
>
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   uretprobe_syscall
>

It looks great to me, thanks! Unfortunately BPF CI build is broken,
probably due to some of the Makefile additions, please investigate and
fix (or we'll need to fix something on BPF CI side), but it looks like
you'll need another revision, unfortunately.

pw-bot: cr

  [0] https://github.com/kernel-patches/bpf/actions/runs/8923849088/job/245=
09002194



But while we are at it.

Masami, Oleg,

What should be the logistics of landing this? Can/should we route this
through the bpf-next tree, given there are lots of BPF-based
selftests? Or you want to take this through
linux-trace/probes/for-next? In the latter case, it's probably better
to apply only the first two patches to probes/for-next and the rest
should still go through the bpf-next tree (otherwise we are running
into conflicts in BPF selftests). Previously we were handling such
cross-tree dependencies by creating a named branch or tag, and merging
it into bpf-next (so that all SHAs are preserved). It's a bunch of
extra work for everyone involved, so the simplest way would be to just
land through bpf-next, of course. But let me know your preferences.

Thanks!

> thanks,
> jirka
>
>
> Notes to check list items in Documentation/process/adding-syscalls.rst:
>
> - System Call Alternatives
>   New syscall seems like the best way in here, becase we need

typo (thanks, Gmail): because

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

typo: is

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
>  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
>  arch/x86/kernel/uprobes.c                                   | 115 ++++++=
++++++++++++++++++++++
>  include/linux/syscalls.h                                    |   2 +
>  include/linux/uprobes.h                                     |   3 +
>  include/uapi/asm-generic/unistd.h                           |   5 +-
>  kernel/events/uprobes.c                                     |  24 ++++--
>  kernel/sys_ni.c                                             |   2 +
>  tools/include/linux/compiler.h                              |   4 +
>  tools/testing/selftests/bpf/.gitignore                      |   1 +
>  tools/testing/selftests/bpf/Makefile                        |   7 +-
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       | 123 ++++++=
++++++++++++++++++++++-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 382 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |  15 ++++
>  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  17 +++++
>  14 files changed, 691 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_exec=
uted.c
>
> Jiri Olsa (1):
>       man2: Add uretprobe syscall page
>
>  man2/uretprobe.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 man2/uretprobe.2

