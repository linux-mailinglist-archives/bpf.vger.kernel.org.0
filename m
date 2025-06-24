Return-Path: <bpf+bounces-61357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F8AE5F98
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 10:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799C73AD94F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5630253950;
	Tue, 24 Jun 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpf/3loU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D9239072;
	Tue, 24 Jun 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754195; cv=none; b=Y3RSvRaUrquSoAfxQNqUBYhIyhWjhfj3KIF+ITcOMMxfoec0GD6soe7QlsMQY2VOrUeHbAiyXevh+HdvA4Gi/b6K1fIayXMUcLcMmj7Gq8qu/zdpzZIVdJNcSzhsj9wpMeTAPhnU+gJgJPhWBNEYvuD78WmeRWZB+6LnsSj53fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754195; c=relaxed/simple;
	bh=DPJpJN9s6ZA+aVPC7f73tg71gOj4+qsMe1oiivNtvGg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amQvBJlhD4gN0riK4vcKvjZTHJK5GTGdfoeyv7iPOH6c/t8zF/ISj/rNPzMvsfekxYAmrElc4JBdFbUTFpopPGvtKSOVhLmBIuZou8WgfLtXD+RhPcLIA46DMXfSdPLE5DNa9DHnHBrG7uGls6mc6Hc4SooCQr4nCG2sBDk2lVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpf/3loU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so386821a12.1;
        Tue, 24 Jun 2025 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750754191; x=1751358991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NhrJpvC7TgDUrt3uAEiGkoYGZtc78/mqwoJoV1MrgM=;
        b=Wpf/3loUqfKR9uJMTTa0QH5yeyDj2gLmsJTj0DxGlUjsUKTZF3ECuhcWUXW3eMZhgE
         axyhoujd1VAROKtw4P450j8XnXNwWYtdykhw5W8pjREdsirmVF2LsFmcHGpDfELzMf9j
         w8Hja4/uwAnuEPMheEhRsd6W8D75XAJ7+1ICGnvvbLn1I6ExSHAEi2PQ+iYREl+q9ei4
         u/fQYEQ+fLFOQ1tQWStTLyAZmXQplKgR/FkAklwNIcHTnUtd48DXhKs/xSO/tfD6ezC5
         7i4mj531EGWcsYsVXl/X8L/ZI9oT9KSeIBPpquorEzq91xak6nlFsNmfHzJNnSLjRWGi
         XOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754191; x=1751358991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NhrJpvC7TgDUrt3uAEiGkoYGZtc78/mqwoJoV1MrgM=;
        b=sIpmA+rESerjXMU3cXi1582B1p85qDMpETy1/m+WNbeuprFPFz9OxuUHQl0BuOwnju
         gCgEH5mTSvCTbpyx5tK8JgCgmj2MwsQKNlbImeJCuFvFB9N07BWB0QFtdtN5H87G1/oB
         NRa5Vkydei8NRuz17qJWOXtO7T0l8BAc12BiwMqDcC+zg7RNZEqv9B6cBMxI/aqY291H
         ercNqYx0ux/EETANcLrJlqQloXsFX3qfipbrFSeItEsoUEA8uh5/8hPoGHOq2fz+1LXG
         4+BMcGUoRUihf0tCupZRN1Giz4IBJK1n23/4metmvCccKczp4Yxz4rRmYxI9u0wiQepj
         +6MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/T+xSnkrQLtY8GQQ51PCmCCB+jCuBhnQ4T/WTB7jE8m0pdSVGFQWB/cO+so8+Uvw6VbEsexShQSUkJsgi@vger.kernel.org, AJvYcCU4vai5H0cj69n6x1gZQiCrl6SAyPpYjFUWdiQtj+Vsj0YpKEaXnqMDmXstuhBFs38/GWBlvHuebFF/UANhy+q94znP@vger.kernel.org, AJvYcCX35f6Dx4JEbEPg1NVLQk5FlWr/O3VO2ePshs9KEqHvBfT1CQxfwDMigupU6HIQNnfmlP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyipjj2w/xEIVmtSJ/xAaBWPcW3Dz28iwUZXTiNZ3a6DS1Sb7bY
	CJqaeOkjMvhEHtDvNoQWf9YLpSCypCFCBj/KU+4T384ZkNKl+fPvP4hC
X-Gm-Gg: ASbGncsgAq/WP8yO0Qd7EpXnf1D4lKirx3QwZnnQsG7DvbPPkdK698QEVZ1HnfrIPdC
	kq6naVHOYqj6yDWhvakrsgRRYQ0sbCN3w9BT3xYwQWwVSr7HXLMpQk25sh9mpHfwsqa8EASGo6w
	b/PfOgku1et5GqATFi/gEp+XdEpYPN7XuYf1U6Ejrsy6L1EuvgPKbT75GDA0655AILKE7dJ5gjS
	Xae8UGnpWvOYdcOgaSuEuHZxh0+JgM9dXxhmnFHThdwz1KhXVHs1hhJMXhyDPo9ZfWCH9nk17hz
	mJ3lJKA/vWMwxbkSbqwhhIyYN1VCpbjgTOkQYHNX9CRB7IhAc0VNGJWleHqj
X-Google-Smtp-Source: AGHT+IFGOZlBnt/18l1WubHvG2W9Dvn4QHDQNxDaVi5EzzCbgGmlwlSe5ED3ButsJ3gDlExIaYwz3Q==
X-Received: by 2002:a17:907:3d12:b0:ad2:27b1:7214 with SMTP id a640c23a62f3a-ae0a73c8082mr277648766b.17.1750754191180;
        Tue, 24 Jun 2025 01:36:31 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05420a31dsm844848966b.170.2025.06.24.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:36:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Jun 2025 10:36:29 +0200
To: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 00/22] uprobes: Add support to optimize usdt
 probes on x86_64
Message-ID: <aFpjjeYKO5uBuwcl@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <aFFouFEKLFsYhVOe@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFFouFEKLFsYhVOe@krava>

ping

On Tue, Jun 17, 2025 at 03:08:08PM +0200, Jiri Olsa wrote:
> hi, ping
> 
> thanks,
> jirka
> 
> On Thu, Jun 05, 2025 at 03:23:27PM +0200, Jiri Olsa wrote:
> > hi,
> > this patchset adds support to optimize usdt probes on top of 5-byte
> > nop instruction.
> > 
> > The generic approach (optimize all uprobes) is hard due to emulating
> > possible multiple original instructions and its related issues. The
> > usdt case, which stores 5-byte nop seems much easier, so starting
> > with that.
> > 
> > The basic idea is to replace breakpoint exception with syscall which
> > is faster on x86_64. For more details please see changelog of patch 8.
> > 
> > The run_bench_uprobes.sh benchmark triggers uprobe (on top of different
> > original instructions) in a loop and counts how many of those happened
> > per second (the unit below is million loops).
> > 
> > There's big speed up if you consider current usdt implementation
> > (uprobe-nop) compared to proposed usdt (uprobe-nop5):
> > 
> > current:
> >         usermode-count :  152.501 ± 0.012M/s
> >         syscall-count  :   14.463 ± 0.062M/s
> > -->     uprobe-nop     :    3.160 ± 0.005M/s
> >         uprobe-push    :    3.003 ± 0.003M/s
> >         uprobe-ret     :    1.100 ± 0.003M/s
> >         uprobe-nop5    :    3.132 ± 0.012M/s
> >         uretprobe-nop  :    2.103 ± 0.002M/s
> >         uretprobe-push :    2.027 ± 0.004M/s
> >         uretprobe-ret  :    0.914 ± 0.002M/s
> >         uretprobe-nop5 :    2.115 ± 0.002M/s
> > 
> > after the change:
> >         usermode-count :  152.343 ± 0.400M/s
> >         syscall-count  :   14.851 ± 0.033M/s
> >         uprobe-nop     :    3.204 ± 0.005M/s
> >         uprobe-push    :    3.040 ± 0.005M/s
> >         uprobe-ret     :    1.098 ± 0.003M/s
> > -->     uprobe-nop5    :    7.286 ± 0.017M/s
> >         uretprobe-nop  :    2.144 ± 0.001M/s
> >         uretprobe-push :    2.069 ± 0.002M/s
> >         uretprobe-ret  :    0.922 ± 0.000M/s
> >         uretprobe-nop5 :    3.487 ± 0.001M/s
> > 
> > I see bit more speed up on Intel (above) compared to AMD. The big nop5
> > speed up is partly due to emulating nop5 and partly due to optimization.
> > 
> > The key speed up we do this for is the USDT switch from nop to nop5:
> > 	uprobe-nop     :    3.160 ± 0.005M/s
> > 	uprobe-nop5    :    7.286 ± 0.017M/s
> > 
> > 
> > Changes from v2:
> > - rebased on top of tip/master + mm/mm-stable + 1 extra change [1]
> > - added acks [Oleg,Andrii]
> > - more details changelog for patch 1 [Masami]
> > - several tests changes [Andrii]
> > - add explicit PAGE_SIZE low limit to vm_unmapped_area call [Andrii]
> > 
> > 
> > This patchset is adding new syscall, here are notes to check list items
> > in Documentation/process/adding-syscalls.rst:
> > 
> > - System Call Alternatives
> >   New syscall seems like the best way in here, because we need
> >   just to quickly enter kernel with no extra arguments processing,
> >   which we'd need to do if we decided to use another syscall.
> > 
> > - Designing the API: Planning for Extension
> >   The uprobe syscall is very specific and most likely won't be
> >   extended in the future.
> > 
> > - Designing the API: Other Considerations
> >   N/A because uprobe syscall does not return reference to kernel
> >   object.
> > 
> > - Proposing the API
> >   Wiring up of the uprobe system call is in separate change,
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
> >   N/A uprobe syscall has no arguments and is not supported
> >   for compat processes.
> > 
> > - Compatibility System Calls (x86)
> >   N/A uprobe syscall is not supported for compat processes.
> > 
> > - System Calls Returning Elsewhere
> >   N/A.
> > 
> > - Other Details
> >   N/A.
> > 
> > - Testing
> >   Adding new bpf selftests.
> > 
> > - Man Page
> >   Attached.
> > 
> > - Do not call System Calls in the Kernel
> >   N/A
> > 
> > pending todo (or follow ups):
> > - use PROCMAP_QUERY in tests
> > - alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]
> > - use mm_cpumask(vma->vm_mm) in text_poke_sync
> > 
> > thanks,
> > jirka
> > 
> > 
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: Eyal Birger <eyal.birger@gmail.com>
> > Cc: kees@kernel.org
> > 
> > [1] https://lore.kernel.org/linux-trace-kernel/20250514101809.2010193-1-jolsa@kernel.org/T/#u
> > ---
> > Jiri Olsa (21):
> >       uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
> >       uprobes: Rename arch_uretprobe_trampoline function
> >       uprobes: Make copy_from_page global
> >       uprobes: Add uprobe_write function
> >       uprobes: Add nbytes argument to uprobe_write
> >       uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode
> >       uprobes: Add do_ref_ctr argument to uprobe_write function
> >       uprobes/x86: Add mapping for optimized uprobe trampolines
> >       uprobes/x86: Add uprobe syscall to speed up uprobe
> >       uprobes/x86: Add support to optimize uprobes
> >       selftests/bpf: Import usdt.h from libbpf/usdt project
> >       selftests/bpf: Reorg the uprobe_syscall test function
> >       selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
> >       selftests/bpf: Add uprobe/usdt syscall tests
> >       selftests/bpf: Add hit/attach/detach race optimized uprobe test
> >       selftests/bpf: Add uprobe syscall sigill signal test
> >       selftests/bpf: Add optimized usdt variant for basic usdt test
> >       selftests/bpf: Add uprobe_regs_equal test
> >       selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
> >       seccomp: passthrough uprobe systemcall without filtering
> >       selftests/seccomp: validate uprobe syscall passes through seccomp
> > 
> >  arch/arm/probes/uprobes/core.c                              |   2 +-
> >  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
> >  arch/x86/include/asm/uprobes.h                              |   7 ++
> >  arch/x86/kernel/uprobes.c                                   | 525 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/syscalls.h                                    |   2 +
> >  include/linux/uprobes.h                                     |  20 +++-
> >  kernel/events/uprobes.c                                     | 100 ++++++++++++-----
> >  kernel/fork.c                                               |   1 +
> >  kernel/seccomp.c                                            |  32 ++++--
> >  kernel/sys_ni.c                                             |   1 +
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 523 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  tools/testing/selftests/bpf/prog_tests/usdt.c               |  38 ++++---
> >  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |   4 +-
> >  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  60 +++++++++-
> >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c        |  11 +-
> >  tools/testing/selftests/bpf/usdt.h                          | 545 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/seccomp/seccomp_bpf.c               | 107 ++++++++++++++----
> >  17 files changed, 1867 insertions(+), 112 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/usdt.h
> > 
> > 
> > Jiri Olsa (1):
> >       man2: Add uprobe syscall page
> > 
> >  man/man2/uprobe.2    |  1 +
> >  man/man2/uretprobe.2 | 36 ++++++++++++++++++++++++------------
> >  2 files changed, 25 insertions(+), 12 deletions(-)
> >  create mode 100644 man/man2/uprobe.2

