Return-Path: <bpf+bounces-60812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5058ADCCC9
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D85169ECE
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988D2E92B0;
	Tue, 17 Jun 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoJWDEsn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E152E3B0E;
	Tue, 17 Jun 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165695; cv=none; b=bcTm5iTtrNAyvJxxSqtSA605dHlQODJG4l75aPF2/npwFvN0CDMbeBNzaKmE1bMyUGQQ9dmaRrPNsfTXLPe8+VLrCCu73lNBr3WTTwNwo+tyZSuyeGi7F6SslyOELr6RgWAq4QtC6LRU9yqy3iQaDevjYBi8U/6Ew3p547ItCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165695; c=relaxed/simple;
	bh=tKUcRAUa4/4F+7HMJkJTRkfA+kedRCQZNLfw9CsquJ4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9yqqIxpIjxDrDROx5decMW6GXy+gEhvgbVNhpmUpBadUFoUpMhWGFHQfyANR6eptfIDq6J/EOkFKDogd/bL2g7EXmqvzjrZV6Qr0kbdafRvBrOnYUw/nAdYl88Z1REagyiA2UkvMFWn192hRQXI/mhPzGSPym7Nggn7JNGGT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoJWDEsn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607c2b96b29so11242029a12.1;
        Tue, 17 Jun 2025 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165692; x=1750770492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dnz08p988HEhiwUnhwSo07SVzEbufhKq0dtElGX9NSg=;
        b=MoJWDEsn4mPh6Rc6rLvVagmN+OuIGOYiBNucT2N64Ar4shr5Q/QilBlRWaL4PhJ1Rs
         rD4Aqy9aCmpri9XHLsQZLl/enQbT9IKdEpwRUBg1RhIhhPJ8MmlZhM3HXVotjARbJXmw
         kjqH+tN8rnXViSmHZ3FCWXwOcl//ICgsqGTau/QsmHXkOtyLlk7CVukgsbww/f7EWiEo
         TBM8H8A/b3Rv/8eKSFE6RTdkaYwgEiXT153hA006lac0zuftX5oeptM19LPeBZHSAzoS
         /p+Z3pFSevRSw0tgLh0bYKPx9/VtH+v5x6Nk5VXmMFFqXJ3foeSq2AgOAauL92QVxMhs
         whKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165692; x=1750770492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnz08p988HEhiwUnhwSo07SVzEbufhKq0dtElGX9NSg=;
        b=JtJhGLUPOas/l/sII7415GcOKU15qJglTjDu5zwK+FR/QCKdBOoEgXyCGv4Qp0Dhh3
         n4ZaG4mvfpQIPPIKNkj+yqW/aKraAM4oYKTZzfzyXG5+2hU2F0CgABm7sn7UgPalsDCu
         tUrdS380K6xD/Zvmop0rQyo1tuQjl0p78kgt8GhimqrACK39p1GUXniB3I7v4mLFESHX
         gg5cTE4/AT3Bz2MlABsaRz+LV1zyk3MgqQuyoHTqf77f/VN6Wluw/6RyEonEG8yHur78
         QXUGybypfOF+niaMcN8bKtUhLtoyfIpUjX5bnllwVxN2udBSaQiXawaqFsnK1ogWJtva
         wUnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKMtjckTmg3twQFHWhYMOdWBS21ZXBxEW0/xc4y/20QkN6VpG9ng+IshAqoynurMnJy4=@vger.kernel.org, AJvYcCVsxZB73rS37acXQ1Xj/+xsnBAPURXOWOEVykY1FwhHsQqgu4EmAOXwt4DiY86AXJjgv3TNl9Yaxh5AskDL@vger.kernel.org, AJvYcCXf4ZHdgF0Y6hVR/NxT4mE6HMLoqH9E7Gi37bpUwab8HSDfLBibMdAr8KEQfCYmJoG+IVF3onfPizbYWatUWqZxhnTG@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+N6svQWXRqmeszUjGrPPwevAzsDO8f6NbzTKtcEOSadER5g2
	KADTR7mxwrd6AdwNhc9bqHyRJQSuvfeV9gJSUs27MonNR5B2S0pAJb3H
X-Gm-Gg: ASbGncuFWacPm6F0oAlGSU/SWbVKIqNKnim89PYTdE18wbJPpVLmK05kPh7IMbEmg/q
	baZokjBf7GNQIzrESW3qMzB3woEsh34W9MCPvhbDnMAvk646vNhdk9AjuApkYTcA5WsI252Kf1h
	hbwjvwMf2dRaOk8ddRHksLNTkNZG6ETygHj8jfGujmdcHsDmtQyN2SzOSZvzRIxiNQnkHzj4FBZ
	UXUCNyNriJu5/HzO8+dSOldyIXV+ob/pqA7X6lr83NVkoph6T4biWZxe7vimNG89BwhaXoR0oxR
	TgWBRE2dVHLAD6QubueQeCGNdQAzwRMrSWX7lENEpRYeyi2E
X-Google-Smtp-Source: AGHT+IFj/1/M+erYP3dBSQh+vvUSk5j4l8HmqfK59hXQC9smnlCJwhLmHVL66MbkH9HFrbnTTDCnoA==
X-Received: by 2002:a05:6402:1ed0:b0:607:ec38:4033 with SMTP id 4fb4d7f45d1cf-608d083813fmr12255562a12.7.1750165691410;
        Tue, 17 Jun 2025 06:08:11 -0700 (PDT)
Received: from krava ([173.38.220.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4aefd21sm7924821a12.81.2025.06.17.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:08:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Jun 2025 15:08:08 +0200
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aFFouFEKLFsYhVOe@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605132350.1488129-1-jolsa@kernel.org>

hi, ping

thanks,
jirka

On Thu, Jun 05, 2025 at 03:23:27PM +0200, Jiri Olsa wrote:
> hi,
> this patchset adds support to optimize usdt probes on top of 5-byte
> nop instruction.
> 
> The generic approach (optimize all uprobes) is hard due to emulating
> possible multiple original instructions and its related issues. The
> usdt case, which stores 5-byte nop seems much easier, so starting
> with that.
> 
> The basic idea is to replace breakpoint exception with syscall which
> is faster on x86_64. For more details please see changelog of patch 8.
> 
> The run_bench_uprobes.sh benchmark triggers uprobe (on top of different
> original instructions) in a loop and counts how many of those happened
> per second (the unit below is million loops).
> 
> There's big speed up if you consider current usdt implementation
> (uprobe-nop) compared to proposed usdt (uprobe-nop5):
> 
> current:
>         usermode-count :  152.501 ± 0.012M/s
>         syscall-count  :   14.463 ± 0.062M/s
> -->     uprobe-nop     :    3.160 ± 0.005M/s
>         uprobe-push    :    3.003 ± 0.003M/s
>         uprobe-ret     :    1.100 ± 0.003M/s
>         uprobe-nop5    :    3.132 ± 0.012M/s
>         uretprobe-nop  :    2.103 ± 0.002M/s
>         uretprobe-push :    2.027 ± 0.004M/s
>         uretprobe-ret  :    0.914 ± 0.002M/s
>         uretprobe-nop5 :    2.115 ± 0.002M/s
> 
> after the change:
>         usermode-count :  152.343 ± 0.400M/s
>         syscall-count  :   14.851 ± 0.033M/s
>         uprobe-nop     :    3.204 ± 0.005M/s
>         uprobe-push    :    3.040 ± 0.005M/s
>         uprobe-ret     :    1.098 ± 0.003M/s
> -->     uprobe-nop5    :    7.286 ± 0.017M/s
>         uretprobe-nop  :    2.144 ± 0.001M/s
>         uretprobe-push :    2.069 ± 0.002M/s
>         uretprobe-ret  :    0.922 ± 0.000M/s
>         uretprobe-nop5 :    3.487 ± 0.001M/s
> 
> I see bit more speed up on Intel (above) compared to AMD. The big nop5
> speed up is partly due to emulating nop5 and partly due to optimization.
> 
> The key speed up we do this for is the USDT switch from nop to nop5:
> 	uprobe-nop     :    3.160 ± 0.005M/s
> 	uprobe-nop5    :    7.286 ± 0.017M/s
> 
> 
> Changes from v2:
> - rebased on top of tip/master + mm/mm-stable + 1 extra change [1]
> - added acks [Oleg,Andrii]
> - more details changelog for patch 1 [Masami]
> - several tests changes [Andrii]
> - add explicit PAGE_SIZE low limit to vm_unmapped_area call [Andrii]
> 
> 
> This patchset is adding new syscall, here are notes to check list items
> in Documentation/process/adding-syscalls.rst:
> 
> - System Call Alternatives
>   New syscall seems like the best way in here, because we need
>   just to quickly enter kernel with no extra arguments processing,
>   which we'd need to do if we decided to use another syscall.
> 
> - Designing the API: Planning for Extension
>   The uprobe syscall is very specific and most likely won't be
>   extended in the future.
> 
> - Designing the API: Other Considerations
>   N/A because uprobe syscall does not return reference to kernel
>   object.
> 
> - Proposing the API
>   Wiring up of the uprobe system call is in separate change,
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
>   N/A uprobe syscall has no arguments and is not supported
>   for compat processes.
> 
> - Compatibility System Calls (x86)
>   N/A uprobe syscall is not supported for compat processes.
> 
> - System Calls Returning Elsewhere
>   N/A.
> 
> - Other Details
>   N/A.
> 
> - Testing
>   Adding new bpf selftests.
> 
> - Man Page
>   Attached.
> 
> - Do not call System Calls in the Kernel
>   N/A
> 
> pending todo (or follow ups):
> - use PROCMAP_QUERY in tests
> - alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]
> - use mm_cpumask(vma->vm_mm) in text_poke_sync
> 
> thanks,
> jirka
> 
> 
> Cc: Alejandro Colomar <alx@kernel.org>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Cc: kees@kernel.org
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250514101809.2010193-1-jolsa@kernel.org/T/#u
> ---
> Jiri Olsa (21):
>       uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
>       uprobes: Rename arch_uretprobe_trampoline function
>       uprobes: Make copy_from_page global
>       uprobes: Add uprobe_write function
>       uprobes: Add nbytes argument to uprobe_write
>       uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode
>       uprobes: Add do_ref_ctr argument to uprobe_write function
>       uprobes/x86: Add mapping for optimized uprobe trampolines
>       uprobes/x86: Add uprobe syscall to speed up uprobe
>       uprobes/x86: Add support to optimize uprobes
>       selftests/bpf: Import usdt.h from libbpf/usdt project
>       selftests/bpf: Reorg the uprobe_syscall test function
>       selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
>       selftests/bpf: Add uprobe/usdt syscall tests
>       selftests/bpf: Add hit/attach/detach race optimized uprobe test
>       selftests/bpf: Add uprobe syscall sigill signal test
>       selftests/bpf: Add optimized usdt variant for basic usdt test
>       selftests/bpf: Add uprobe_regs_equal test
>       selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
>       seccomp: passthrough uprobe systemcall without filtering
>       selftests/seccomp: validate uprobe syscall passes through seccomp
> 
>  arch/arm/probes/uprobes/core.c                              |   2 +-
>  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
>  arch/x86/include/asm/uprobes.h                              |   7 ++
>  arch/x86/kernel/uprobes.c                                   | 525 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/syscalls.h                                    |   2 +
>  include/linux/uprobes.h                                     |  20 +++-
>  kernel/events/uprobes.c                                     | 100 ++++++++++++-----
>  kernel/fork.c                                               |   1 +
>  kernel/seccomp.c                                            |  32 ++++--
>  kernel/sys_ni.c                                             |   1 +
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 523 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  tools/testing/selftests/bpf/prog_tests/usdt.c               |  38 ++++---
>  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |   4 +-
>  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  60 +++++++++-
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c        |  11 +-
>  tools/testing/selftests/bpf/usdt.h                          | 545 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/seccomp/seccomp_bpf.c               | 107 ++++++++++++++----
>  17 files changed, 1867 insertions(+), 112 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/usdt.h
> 
> 
> Jiri Olsa (1):
>       man2: Add uprobe syscall page
> 
>  man/man2/uprobe.2    |  1 +
>  man/man2/uretprobe.2 | 36 ++++++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 12 deletions(-)
>  create mode 100644 man/man2/uprobe.2

