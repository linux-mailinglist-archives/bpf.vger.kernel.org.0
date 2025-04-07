Return-Path: <bpf+bounces-55393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24376A7DC10
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E928E171880
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DF23A560;
	Mon,  7 Apr 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+u1B4+d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4E14A4C6;
	Mon,  7 Apr 2025 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024689; cv=none; b=gji2GxkvAPQXmXpGMOT865ngHNv/tC7Gk9Iqr0SRnkFJvIBS5dmbBNvZizPa4bTh8uw3IbVCC7gV2wEpI2i/dvcg6iLn5lR3M4TUCcEfqOjn732Kd4pS399o8qstqJSHObO8ncPOK8b+8Mh9KqqzX8OXLjh3XbhEgH4TExjgMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024689; c=relaxed/simple;
	bh=UCEmJY7Zjz4J2QoCKJBUp4D4kTm6iW9Va93AWo2Fc+A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEnwyUgKvmyu18nFLkmS7Pozzm/y1LfaM5F46hGqiVIfGLLA93OWzOavwn2yq25sSD+xx/az5RrlTrqkN0UoUuh5OJqDlG29uDqe+cfM3QmMkemkK10ZhTZwCcMomHPorCJYtjzZwfubh9KnbxgQaQUIUuA5SCQ8rjd9+dGF+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+u1B4+d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac56756f6so3597839f8f.2;
        Mon, 07 Apr 2025 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744024685; x=1744629485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=774VQpLsZnSdE97pQVpnDZjYZ2xUJioVrWYHdhSNOTw=;
        b=i+u1B4+dSionnXf6lu1sHh6ZJFXg9VWju8yshIlk2VD8t9gUf1rhcdBDsnr+8lzWjh
         tBQ3Ooby/jB505AByqFCbCZUoope7Se8KFNuAQAoma1qLKXonKncLQL8t9mPVsCwEw1k
         kYMwN6C258gtfa5GV5A66umeizQr9O82hvlNReV1bSJpHOYQtY6i9ja4ktCtsiAAcSED
         HQFR52ETV6mnj5fYZuJfBAcU+ikU+JsW3zH5Uk5CpCoGX82xs8DyrPYokWsIcneWOC+e
         pCxjsvC7yJnI54j87BtJFC4MduodxkntoAhXCcYbIzF4A1eDTpxlxFd1DHOqzC4HB9q6
         LOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024685; x=1744629485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=774VQpLsZnSdE97pQVpnDZjYZ2xUJioVrWYHdhSNOTw=;
        b=OjobNwiWSMLnwuqUM6iK6JMpNUQicrCuzxZmco6uGWELZ3VQXAiDe/StDbwhR0Eo4B
         FWRoI2JgOwzET5tNUVvFuk1aOXACXbQbEd3S4emDNyxWAUIkY6phkHijqe0XuYQ/n0BN
         4593wyQcb9+98vY39b0L6NN70pTjdAnSnHDE1+RM7S+vpFHcPIXo9ZHipC3/sVl5JqSq
         8i139A7fW/Cg4pq5hQD2gS5cs5KXeonVUzzSbPntQTiJrbSl//0CdygU+BgeJxzf0QRl
         MZ/iS/liuz2zf/JmaXu+QEEUSMNgmxK5wl/SmJ1u8Lju2U/VYvxHadmanS6WX9vTaSRk
         nM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9RMFL0CP2dKz9o51iqQ32Sdn5fQPISp1Cmf6QtYzRzrPU/jU3PHInXYQSWm2bje0fwO8tJkq7ITx09JQ3DF0LxuoR@vger.kernel.org, AJvYcCWL9pH2fGONLOsHSsRm6Uj3mC5SosdAz6fA11mBJ3eTNa4JQOE5O9ddAVvfFF6sX8Ncz1w=@vger.kernel.org, AJvYcCWir/LTypVg89XfUve1OwIkh0PT3mt++eoUZiRxCkvcsqQSzuxO90qH9aLJNpEQVsNLjsMN4fwpoNAJaLKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwejbqyTmMzsvIzRPo8E14t3cWByrSAPNuMIrL363q4mLpomEJ
	DS8z6LsYaEOAxHF6/9wDeV/rUrIFSKUDJ9tQ6lhQcngxhA7FASTB
X-Gm-Gg: ASbGncvNwe+5Ba/pYsGCMDAHZHqTqysjJL4xoAF1Zg93WNA0KyGx0xSFRzJ83vJzmkE
	KcaFmeK8caq1ZuFMAPlSW0qkbrxciQSbcJTpkID1anSwJKOb3prPHgDHwDy0UNSeSM8rl/dlpeb
	gZuDzMDSo8e1PVyOC+YYxfr4Cu5r3hVXYpXQcHtGRB04nFk63iz04RIPW6aBljo4ekn5Gn1bXdD
	AzTmE4svzmPvT+O+6BeJCXLUxgEo5rgBNWsotiKPWrtwYU36gkeVyNvwNujB0bllIYiuIEc/AVv
	neYcknKqgaeRAsPPugpQ9ZuIqtvCQoU=
X-Google-Smtp-Source: AGHT+IEaFLh3EOIY/E+PfZ/MhrnUJEv38IcKnti2qpn2wYNALBkUBvazUymb10VNKcFYQGE3DIw7pA==
X-Received: by 2002:a05:6000:4022:b0:39c:140b:feec with SMTP id ffacd0b85a97d-39cb36b28b5mr10122375f8f.7.1744024685417;
        Mon, 07 Apr 2025 04:18:05 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c302269a2sm11862603f8f.91.2025.04.07.04.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:18:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Apr 2025 13:17:59 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv3 00/23] uprobes: Add support to optimize usdt probes
 on x86_64
Message-ID: <Z_O0Z1ON1YlRqyny@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <CAEf4BzY2zKPM9JHgn_wa8yCr8q5KntE5w8g=AoT2MnrD2Dx6gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY2zKPM9JHgn_wa8yCr8q5KntE5w8g=AoT2MnrD2Dx6gA@mail.gmail.com>

On Fri, Apr 04, 2025 at 01:36:13PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 20, 2025 at 4:42 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
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
> >         usermode-count :  152.604 ± 0.044M/s
> >         syscall-count  :   13.359 ± 0.042M/s
> > -->     uprobe-nop     :    3.229 ± 0.002M/s
> >         uprobe-push    :    3.086 ± 0.004M/s
> >         uprobe-ret     :    1.114 ± 0.004M/s
> >         uprobe-nop5    :    1.121 ± 0.005M/s
> >         uretprobe-nop  :    2.145 ± 0.002M/s
> >         uretprobe-push :    2.070 ± 0.001M/s
> >         uretprobe-ret  :    0.931 ± 0.001M/s
> >         uretprobe-nop5 :    0.957 ± 0.001M/s
> >
> > after the change:
> >         usermode-count :  152.448 ± 0.244M/s
> >         syscall-count  :   14.321 ± 0.059M/s
> >         uprobe-nop     :    3.148 ± 0.007M/s
> >         uprobe-push    :    2.976 ± 0.004M/s
> >         uprobe-ret     :    1.068 ± 0.003M/s
> > -->     uprobe-nop5    :    7.038 ± 0.007M/s
> >         uretprobe-nop  :    2.109 ± 0.004M/s
> >         uretprobe-push :    2.035 ± 0.001M/s
> >         uretprobe-ret  :    0.908 ± 0.001M/s
> >         uretprobe-nop5 :    3.377 ± 0.009M/s
> >
> > I see bit more speed up on Intel (above) compared to AMD. The big nop5
> > speed up is partly due to emulating nop5 and partly due to optimization.
> >
> > The key speed up we do this for is the USDT switch from nop to nop5:
> >         uprobe-nop     :    3.148 ± 0.007M/s
> >         uprobe-nop5    :    7.038 ± 0.007M/s
> >
> >
> > rfc v3 changes:
> > - I tried to have just single syscall for both entry and return uprobe,
> >   but it turned out to be slower than having two separated syscalls,
> >   probably due to extra save/restore processing we have to do for
> >   argument reg, I see differences like:
> >
> >     2 syscalls:      uprobe-nop5    :    7.038 ± 0.007M/s
> >     1 syscall:       uprobe-nop5    :    6.943 ± 0.003M/s
> >
> > - use instructions (nop5/int3/call) to determine the state of the
> >   uprobe update in the process
> > - removed endbr instruction from uprobe trampoline
> > - seccomp changes
> >
> > pending todo (or follow ups):
> > - shadow stack fails for uprobe session setup, will fix it in next version
> > - use PROCMAP_QUERY in tests
> > - alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]
> 
> All the pending TODO stuff seems pretty minor. So is there anything
> else holding your patch set from graduating out of RFC status?
> 
> David's uprobe_write_opcode() patch set landed, so you should be ready
> to rebase and post a proper v1 now, right?
> 
> Performance wins are huge, looking forward to this making it into the
> kernel soon!

I just saw notification that those changes are on the way to mm tree,
I have the rebase ready, want to post it this week, could be v1 ;-)

jirka


> 
> >
> > thanks,
> > jirka
> >
> >
> > Cc: Eyal Birger <eyal.birger@gmail.com>
> > Cc: kees@kernel.org
> > ---
> > Jiri Olsa (23):
> >       uprobes: Rename arch_uretprobe_trampoline function
> >       uprobes: Make copy_from_page global
> >       uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
> >       uprobes: Add uprobe_write function
> >       uprobes: Add nbytes argument to uprobe_write_opcode
> >       uprobes: Add orig argument to uprobe_write and uprobe_write_opcode
> >       uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
> >       uprobes/x86: Add uprobe syscall to speed up uprobe
> >       uprobes/x86: Add mapping for optimized uprobe trampolines
> >       uprobes/x86: Add support to emulate nop5 instruction
> >       uprobes/x86: Add support to optimize uprobes
> >       selftests/bpf: Use 5-byte nop for x86 usdt probes
> >       selftests/bpf: Reorg the uprobe_syscall test function
> >       selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
> >       selftests/bpf: Add uprobe/usdt syscall tests
> >       selftests/bpf: Add hit/attach/detach race optimized uprobe test
> >       selftests/bpf: Add uprobe syscall sigill signal test
> >       selftests/bpf: Add optimized usdt variant for basic usdt test
> >       selftests/bpf: Add uprobe_regs_equal test
> >       selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
> >       selftests/bpf: Add 5-byte nop uprobe trigger bench
> >       seccomp: passthrough uprobe systemcall without filtering
> >       selftests/seccomp: validate uprobe syscall passes through seccomp
> >
> >  arch/arm/probes/uprobes/core.c                              |   2 +-
> >  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
> >  arch/x86/include/asm/uprobes.h                              |   7 ++
> >  arch/x86/kernel/uprobes.c                                   | 540 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/syscalls.h                                    |   2 +
> >  include/linux/uprobes.h                                     |  19 +++-
> >  kernel/events/uprobes.c                                     | 141 +++++++++++++++++-------
> >  kernel/fork.c                                               |   1 +
> >  kernel/seccomp.c                                            |  32 ++++--
> >  kernel/sys_ni.c                                             |   1 +
> >  tools/testing/selftests/bpf/bench.c                         |  12 +++
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c          |  42 ++++++++
> >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh     |   2 +-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 453 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  tools/testing/selftests/bpf/prog_tests/usdt.c               |  38 ++++---
> >  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |   4 +-
> >  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  41 ++++++-
> >  tools/testing/selftests/bpf/sdt.h                           |   9 +-
> >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c        |  11 +-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c               | 107 ++++++++++++++----
> >  20 files changed, 1338 insertions(+), 127 deletions(-)

