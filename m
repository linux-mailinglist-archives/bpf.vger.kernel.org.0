Return-Path: <bpf+bounces-55356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB0A7C503
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 22:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D117C7A68B5
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF32721E094;
	Fri,  4 Apr 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMzpFy+6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6D13B2BB;
	Fri,  4 Apr 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798995; cv=none; b=FzaRGmpMlFEqr5/G8aeLgQqWnhEe0/roQWz0XCSt8B8jygiuIwuXUZ0hqXPOcOOc6UKZXWSBVRl6yHanWGYALncT4ezASQGUnvILppnnEoJWTDxU55lH/pAKgptnfhosCr3mEBaFCFziFPd138pak+ax882CSlaqgrKcg4Zd/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798995; c=relaxed/simple;
	bh=oZ+uHXnN6Eq5MDglk3rZaokAt1rj3Rf2rGiJuTgOaao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYDvYp1IFvw7VfLn/Z41NUsryxFNqKAeFXEtFVV/+++oRlL13PRcOgJ8fopcNyNx/4LBcL9Qw6SWrcAynBAQ8APdM4wVqXmsfXg2xheEsNdpuTfN6EKeFbI5wGYb23EuecnHEvsfk8QLkGpQMHUqLA8AZMKgbkCjIqIM5UQILzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMzpFy+6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac339f53df9so401753166b.1;
        Fri, 04 Apr 2025 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743798992; x=1744403792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22rGuIvOQunhBDK/LM5k3yagn0EKg9yG1SFBFh0NvKk=;
        b=FMzpFy+6hIpx6hAgejGfYtqLZ27P3ngy+8aKIuONaw1bAIPpsOJvVK51pfIqfFy0AI
         UYvmMjRKcLf2cvc1ZDzlwJmEfVzt7eOol7Gs0NCRILgy8FBdF6IwaRgVNoBvotJNMO78
         iFFRt8UvF1NAsoKAZTMeeQ5hEClGRMqm6xItCeWFAUr7wBcgCvKTeUR/1A4n37WFHITM
         nsjGRy8Sh1DHUMW328ivTaQW3ngZhmsduCHLGDYbZUiOHVMC/Q2RdMnGcrKYOvJqErbI
         5OpGPjNyaEMjPPLuqGuyIDODd3eR0Z17Ufzx+zAtiKFc5IjLM/N/+yHFP0WyNRlAfjit
         tEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743798992; x=1744403792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22rGuIvOQunhBDK/LM5k3yagn0EKg9yG1SFBFh0NvKk=;
        b=prwK4JznhFVHAXVcQiMRna1D80DwD2203WcxZ536iQ1rMBf+KcGP7sa8Gz1EQfbjki
         v40GKCKXZhhzuefpjVnvIBMgyeQ1MUC7QUXRtgcrH9KPhyGjEOurJi33OPI+h8dl7uQj
         drYf4HC6+R+GRt6f1MGmN5pzcUMWQgQq8WuajbcfEPq8jA4BAAQTwDO9AHpB8RT4oAbY
         6H3SmNoeOBXRuOuI0BVM9WTnBwC3TFKXjQSh8VhiZXnBb9AdPSwzkU390el5fxZYIncU
         dTi9q27YLj/jetgvG2ghLOiY6tamwTQg3Yjr6l/JHXpfUfdFc03Z7s3kbZlOrSnqFhYt
         yANQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnPWzB78qwa2OejTAicHuZMe/jjcP8cqHC71mZ31H6pRB2QioaPtntOLvb4jJGaCrRpK0=@vger.kernel.org, AJvYcCXPM5JyTlqSejbZWqZ/IB8b307BN76m/joXUFJhvOwYh3RsPzZrzVCPFFz2RX0bodqNvvqQIhUA+1Kk+0fP@vger.kernel.org, AJvYcCXwqTkP3SI/VzyiuLv8KFSix4H74L+ThhRSkaVdB+wowzYHjRCZPaGGX126/UD/9Lu+aT9Qt1EsYPFcvP7jYYYanAyo@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXBrk0v/i45xIjZekPwKMFytwvJsKAaT5Q9VNyYAXWlQpee0V
	UHxpbRD4seGL2dDfjftcnXaGoTFYLgaJDg4trCHtYgf7ExBnp0yJIiABPBNIjrxLlw6K9RD67DT
	JvWtCNhBN43CJDFRO7yvsz3Htl1Q=
X-Gm-Gg: ASbGncsa3BqSKMtxwUYuDHpoAtIcNetS29X4cf8PC5juIavwpXzAimk9iG5xK1X1qTi
	dVNn7q9bx/MRMjqvgLhC2MiQvI6d+wBT7HTUSprH0ARa+FA+Zo2w4Fp6kHSomEW7dcUGjV3UZx0
	FRlCOdSNiCIZHOhG7aCYniPxeM3xlUPfZ3wBp5TYTeJg==
X-Google-Smtp-Source: AGHT+IHjapuNheEE1B5WwLY6Un8SFoG+Z1JYZRyJb1SBIi6ru6JwNIa1EU9Kj2/LMSEjc40/hKKD41tHn/36MzsajHU=
X-Received: by 2002:a17:907:7ea6:b0:ac2:49b1:166f with SMTP id
 a640c23a62f3a-ac7d1b9c1d3mr351905166b.52.1743798991708; Fri, 04 Apr 2025
 13:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320114200.14377-1-jolsa@kernel.org>
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 13:36:13 -0700
X-Gm-Features: ATxdqUEjv_eTLpR4AhUyXDmhZP5NtRr7hFALL9VnOTAuoWp4qBtNPdKFLgL_ky0
Message-ID: <CAEf4BzY2zKPM9JHgn_wa8yCr8q5KntE5w8g=AoT2MnrD2Dx6gA@mail.gmail.com>
Subject: Re: [PATCH RFCv3 00/23] uprobes: Add support to optimize usdt probes
 on x86_64
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:42=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
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
>         usermode-count :  152.604 =C2=B1 0.044M/s
>         syscall-count  :   13.359 =C2=B1 0.042M/s
> -->     uprobe-nop     :    3.229 =C2=B1 0.002M/s
>         uprobe-push    :    3.086 =C2=B1 0.004M/s
>         uprobe-ret     :    1.114 =C2=B1 0.004M/s
>         uprobe-nop5    :    1.121 =C2=B1 0.005M/s
>         uretprobe-nop  :    2.145 =C2=B1 0.002M/s
>         uretprobe-push :    2.070 =C2=B1 0.001M/s
>         uretprobe-ret  :    0.931 =C2=B1 0.001M/s
>         uretprobe-nop5 :    0.957 =C2=B1 0.001M/s
>
> after the change:
>         usermode-count :  152.448 =C2=B1 0.244M/s
>         syscall-count  :   14.321 =C2=B1 0.059M/s
>         uprobe-nop     :    3.148 =C2=B1 0.007M/s
>         uprobe-push    :    2.976 =C2=B1 0.004M/s
>         uprobe-ret     :    1.068 =C2=B1 0.003M/s
> -->     uprobe-nop5    :    7.038 =C2=B1 0.007M/s
>         uretprobe-nop  :    2.109 =C2=B1 0.004M/s
>         uretprobe-push :    2.035 =C2=B1 0.001M/s
>         uretprobe-ret  :    0.908 =C2=B1 0.001M/s
>         uretprobe-nop5 :    3.377 =C2=B1 0.009M/s
>
> I see bit more speed up on Intel (above) compared to AMD. The big nop5
> speed up is partly due to emulating nop5 and partly due to optimization.
>
> The key speed up we do this for is the USDT switch from nop to nop5:
>         uprobe-nop     :    3.148 =C2=B1 0.007M/s
>         uprobe-nop5    :    7.038 =C2=B1 0.007M/s
>
>
> rfc v3 changes:
> - I tried to have just single syscall for both entry and return uprobe,
>   but it turned out to be slower than having two separated syscalls,
>   probably due to extra save/restore processing we have to do for
>   argument reg, I see differences like:
>
>     2 syscalls:      uprobe-nop5    :    7.038 =C2=B1 0.007M/s
>     1 syscall:       uprobe-nop5    :    6.943 =C2=B1 0.003M/s
>
> - use instructions (nop5/int3/call) to determine the state of the
>   uprobe update in the process
> - removed endbr instruction from uprobe trampoline
> - seccomp changes
>
> pending todo (or follow ups):
> - shadow stack fails for uprobe session setup, will fix it in next versio=
n
> - use PROCMAP_QUERY in tests
> - alloc 'struct uprobes_state' for mm_struct only when needed [Andrii]

All the pending TODO stuff seems pretty minor. So is there anything
else holding your patch set from graduating out of RFC status?

David's uprobe_write_opcode() patch set landed, so you should be ready
to rebase and post a proper v1 now, right?

Performance wins are huge, looking forward to this making it into the
kernel soon!

>
> thanks,
> jirka
>
>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Cc: kees@kernel.org
> ---
> Jiri Olsa (23):
>       uprobes: Rename arch_uretprobe_trampoline function
>       uprobes: Make copy_from_page global
>       uprobes: Move ref_ctr_offset update out of uprobe_write_opcode
>       uprobes: Add uprobe_write function
>       uprobes: Add nbytes argument to uprobe_write_opcode
>       uprobes: Add orig argument to uprobe_write and uprobe_write_opcode
>       uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock
>       uprobes/x86: Add uprobe syscall to speed up uprobe
>       uprobes/x86: Add mapping for optimized uprobe trampolines
>       uprobes/x86: Add support to emulate nop5 instruction
>       uprobes/x86: Add support to optimize uprobes
>       selftests/bpf: Use 5-byte nop for x86 usdt probes
>       selftests/bpf: Reorg the uprobe_syscall test function
>       selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprob=
e_multi
>       selftests/bpf: Add uprobe/usdt syscall tests
>       selftests/bpf: Add hit/attach/detach race optimized uprobe test
>       selftests/bpf: Add uprobe syscall sigill signal test
>       selftests/bpf: Add optimized usdt variant for basic usdt test
>       selftests/bpf: Add uprobe_regs_equal test
>       selftests/bpf: Change test_uretprobe_regs_change for uprobe and ure=
tprobe
>       selftests/bpf: Add 5-byte nop uprobe trigger bench
>       seccomp: passthrough uprobe systemcall without filtering
>       selftests/seccomp: validate uprobe syscall passes through seccomp
>
>  arch/arm/probes/uprobes/core.c                              |   2 +-
>  arch/x86/entry/syscalls/syscall_64.tbl                      |   1 +
>  arch/x86/include/asm/uprobes.h                              |   7 ++
>  arch/x86/kernel/uprobes.c                                   | 540 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>  include/linux/syscalls.h                                    |   2 +
>  include/linux/uprobes.h                                     |  19 +++-
>  kernel/events/uprobes.c                                     | 141 ++++++=
+++++++++++-------
>  kernel/fork.c                                               |   1 +
>  kernel/seccomp.c                                            |  32 ++++--
>  kernel/sys_ni.c                                             |   1 +
>  tools/testing/selftests/bpf/bench.c                         |  12 +++
>  tools/testing/selftests/bpf/benchs/bench_trigger.c          |  42 ++++++=
++
>  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh     |   2 +-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c     | 453 ++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  tools/testing/selftests/bpf/prog_tests/usdt.c               |  38 ++++--=
-
>  tools/testing/selftests/bpf/progs/uprobe_syscall.c          |   4 +-
>  tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c |  41 ++++++=
-
>  tools/testing/selftests/bpf/sdt.h                           |   9 +-
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c        |  11 +-
>  tools/testing/selftests/seccomp/seccomp_bpf.c               | 107 ++++++=
++++++++----
>  20 files changed, 1338 insertions(+), 127 deletions(-)

