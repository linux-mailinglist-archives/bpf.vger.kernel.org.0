Return-Path: <bpf+bounces-46793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C459F0138
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF39161E07
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53A17BA9;
	Fri, 13 Dec 2024 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE6rX4Gk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A08DBE40;
	Fri, 13 Dec 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050596; cv=none; b=VqRO6cadIkuOToJ1byWAEvyt/ojzc/Mw87lVLavJ8dYsEI1EY86m0tmHRp4GTjyYlWiyd4WoDQwF5lF2Bjv2PA+wFFfrynz59u6//EbCtG6HzLbRiNN7AEejekaYlCf3Lulzv1XWo5Uer5Aou/5xw7l3Qt/n2QGsNcZ2NrHiu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050596; c=relaxed/simple;
	bh=R9HFLUKIYv6P29yDILuNSyl60x0OUXENZJA3KLanVjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvEKCACX+SEVjknvOGJp3nvxHv5Ocmzc+yoEQ270OKF1K+BOVhLxF/59Gwy43S0MikRdW5tGlLoB8VYsRlxF2GljQISrWo5LgoEQb8X1wpyja0dwjqTTO2a9iezmSEEmHI2pywlWyIxzOF35/x2X8Ra84rMiVTmroEyap3M+We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE6rX4Gk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so1031911a91.0;
        Thu, 12 Dec 2024 16:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734050594; x=1734655394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37uTfzdQ7bSoBbgkpKKgQpyEPhRd4iFhnnS+tLD4cqs=;
        b=ZE6rX4GkpmaXKWP9qMrDNtIU5h6sbZ7NLTFvR4RuvVYy+GUWlTVRdKR4PuaZMeSjUZ
         fqYQ8aEIumPPOiPzqQh6LGcBvSTiA7lwYVMO91vrtdqAybCZ6g2ryvI55dr11bOO57ae
         g5OxJL8oCEwwhNTvXpg249/FRbxL4YPFpxeesyehYaxovqUAM0B9aoSQizk2FQIntaTH
         7vfONOFHsJD9/ZYjBDqeNWlc3dozn4FVpkjZ9skxVRfLgu07AXpBgXGfz7JbKU1TKldx
         2InuMZO1J5Ay/ZZg6YPIxYX8GRwI/dqjYUFr0/VVAk8lm0sQ5AXECLfQN4k5d1FV2bEj
         vwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050594; x=1734655394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37uTfzdQ7bSoBbgkpKKgQpyEPhRd4iFhnnS+tLD4cqs=;
        b=LlHTvFDcqqssTGgYXqoyfZpzqAfA9nbTGLiLU8IWTT6gTR7fapHj38N/rwHwW2jGqI
         nQU9JtEDNoc3YaUYWZdXZxIRw9igvFsJclzkDa672qbiq/IOLedhMsiYizREbvSG0lhV
         d8fbWTr2GfYi+rNUQNgPKXkg+i/nYi93kOUkfPMOoaNpmAiJYTjdwzyrj0fiwYrJwNdQ
         eAxTBW6yaNiCY1IolpgeXCqAGfMaBTfRz2NnZiwTJD1ekskoynI6bxoM1BSaaXFZY2z4
         OZE6IUffzHZX7USCcW8t3pRyyJVHTXQjENV/lmiOikWjwTeHItwnt7W2CauBpUeKhHmX
         5r9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY0q6hzDL1OObFNrCwPZKYbvT2UmXCtc3aEaLCK9pEDm5ewD3HXvJbVLOwDgqi7r/Reqj6p/wSsvTLYd5R@vger.kernel.org, AJvYcCVkkblJhKpOUBauhQbEF5JdCjycVi/7bWzLfYewaBlk2/2DfDX630OwoedmVM6FOd4wUy0CJDHcJ172sruZRbFQUvAT@vger.kernel.org, AJvYcCWGf62dwBegu1zzCIl/ObqJbS1/tgb69s2pXSJQirFWG9TLJSEY6UAmG7xDE/echr1BotI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZE0HOy9qR3aIj736FUKHhqo+wOku946FoDgTMsDz81mmcqcr3
	yy+2toqRnQL2o5AYsF22clYQx7l4Kk6Jz2MEfatrx3nJ767o0AVK9vJLDGRfMLGqF4yYOCU6trM
	CzlKrYLImd3l7AJ3OtJ5TsGztijI=
X-Gm-Gg: ASbGncv4ppGjQh3akZ6foXF7h01k/nmHuZmhSWae/N4bJp//lNeNdK33oAnY4uih+e1
	b9F2OdThtklyPNrJPFOTiqZjpakv0zWiOsUsxZnkvT58RqSgeTi6RqA==
X-Google-Smtp-Source: AGHT+IHfTsTABRvgb8X+xiZ/VVv3zGTxF67Y6nbV1djG/EiP9PeroLoptBjpaK62ZL9LjITpf9oEJJPmPllAAt+5vzE=
X-Received: by 2002:a17:90b:1d51:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2f28fd6cd00mr1021175a91.21.1734050594025; Thu, 12 Dec 2024
 16:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 16:43:02 -0800
Message-ID: <CAEf4BzaqFJw5wR5V7HCOf_31k+BXY7_hovNB=S7nurYez2ckcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] uprobes: Add support to optimize usdt
 probes on x86_64
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
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
>   # ./benchs/run_bench_uprobes.sh
>
>       usermode-count :  233.831 =C2=B1 0.257M/s
>       syscall-count  :   12.107 =C2=B1 0.038M/s
>   --> uprobe-nop     :    3.246 =C2=B1 0.004M/s
>       uprobe-push    :    3.057 =C2=B1 0.000M/s
>       uprobe-ret     :    1.113 =C2=B1 0.003M/s
>   --> uprobe-nop5    :    6.751 =C2=B1 0.037M/s
>       uretprobe-nop  :    1.740 =C2=B1 0.015M/s
>       uretprobe-push :    1.677 =C2=B1 0.018M/s
>       uretprobe-ret  :    0.852 =C2=B1 0.005M/s
>       uretprobe-nop5 :    6.769 =C2=B1 0.040M/s

uretprobe-nop5 throughput is the same as uprobe-nop5?..


>
>
> v1 changes:
> - rebased on top of bpf-next/master
> - couple of function/variable renames [Andrii]
> - added nop5 emulation [Andrii]
> - added checks to arch_uprobe_verify_opcode [Andrii]
> - fixed arch_uprobe_is_callable/find_nearest_page [Andrii]
> - used CALL_INSN_OPCODE [Masami]
> - added uprobe-nop5 benchmark [Andrii]
> - using atomic64_t in tramp_area [Andri]
> - using single page for all uprobe trampoline mappings
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (13):
>       uprobes: Rename arch_uretprobe_trampoline function
>       uprobes: Make copy_from_page global
>       uprobes: Add nbytes argument to uprobe_write_opcode
>       uprobes: Add arch_uprobe_verify_opcode function
>       uprobes: Add mapping for optimized uprobe trampolines
>       uprobes/x86: Add uprobe syscall to speed up uprobe
>       uprobes/x86: Add support to emulate nop5 instruction
>       uprobes/x86: Add support to optimize uprobes
>       selftests/bpf: Use 5-byte nop for x86 usdt probes
>       selftests/bpf: Add uprobe/usdt optimized test
>       selftests/bpf: Add hit/attach/detach race optimized uprobe test
>       selftests/bpf: Add uprobe syscall sigill signal test
>       selftests/bpf: Add 5-byte nop uprobe trigger bench
>
>  arch/x86/entry/syscalls/syscall_64.tbl                  |   1 +
>  arch/x86/include/asm/uprobes.h                          |   7 +++
>  arch/x86/kernel/uprobes.c                               | 255 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/syscalls.h                                |   2 +
>  include/linux/uprobes.h                                 |  25 +++++++-
>  kernel/events/uprobes.c                                 | 191 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++-----
>  kernel/fork.c                                           |   1 +
>  kernel/sys_ni.c                                         |   1 +
>  tools/testing/selftests/bpf/bench.c                     |  12 ++++
>  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  42 ++++++++++=
+++
>  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 326 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  tools/testing/selftests/bpf/progs/uprobe_optimized.c    |  29 +++++++++
>  tools/testing/selftests/bpf/sdt.h                       |   9 ++-
>  14 files changed, 880 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c

