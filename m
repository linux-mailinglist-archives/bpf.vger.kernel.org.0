Return-Path: <bpf+bounces-45073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049E9D0A8D
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2AE1F21C87
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B06F14F9D6;
	Mon, 18 Nov 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXpr+HFu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8200405FB;
	Mon, 18 Nov 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917104; cv=none; b=s9IvyJWkwmhsQ7opYLgB4mEzNyz6PZ1e2EvwgE1UGeKoBBPg+o8cxPcKBWWYbHxRudWN4kxPYEECIjREijegekP017sMqQNlMLFkLRpEoGwWjEkHkChVVNhs+3dN60ra8y4RtBW2OKfoSonm1QPVs2l6oizfqN/6aMqFCPQA8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917104; c=relaxed/simple;
	bh=Se1/3EGyEUGoIHskyijwcLj2gMIA+uBgyClSkko/PjY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CasQF8muIoqRLyZk6Qc9YmHjCK5dZ2DuKZlA+7VNSjProoaSRcS3ozArnt/bnRsgmcCxOCL6cReyDsn22BLe8fM8jt7R8EsY9rdC7GDukoRnoaK5o/R1YpOI9xNOeKbEDXMhXLPFs1SbBdKGdE7de0k/TYG8IuPZmTQfN2gIA/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXpr+HFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21912C4CECC;
	Mon, 18 Nov 2024 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731917104;
	bh=Se1/3EGyEUGoIHskyijwcLj2gMIA+uBgyClSkko/PjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXpr+HFuGZvL/uQqg/vOBP5dEJAbbcCyhKFzlzeKOeqAYepp3DbaoSR24rl6ngFmp
	 L09wY4N0d0jBQdx6bGWp62FWQY+FvJdi5ZmgHgm8tUNfUOVfpwZSGPWfWrvKZ214ei
	 DrYNXhRsFYhi7h/m4GuRSAwiFbFTxkZ+ju+ZqrNpaI5twr+NCI8VSQLugMXGo/borC
	 K+kNmWlJoViCvFtI1G8fzmcl19MfbncnwHbF/qD8t6qC9V4wnIfWVjfBZ0Y67ZQGh0
	 CwJFti2Wr/HKpMI5E7EgB8Xzx02QPSuR2SVLX2ajpDDivv9XjFkK1T9UXRamO/nZtC
	 upS17kZl8XSdg==
Date: Mon, 18 Nov 2024 17:04:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Beau Belgrave
 <beaub@linux.microsoft.com>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on
 x86_64
Message-Id: <20241118170458.c825bf255c2fb93f2e6a3519@kernel.org>
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jiri,

On Tue,  5 Nov 2024 14:33:54 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

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
> is faster on x86_64. For more details please see changelog of patch 7.

This looks like a great idea!

> 
> The first benchmark shows about 68% speed up (see below). The benchmark
> triggers usdt probe in a loop and counts how many of those happened
> per second.

Hmm, interesting result. I'd like to compare it with user-space event,
which is also use "write" syscall to write the pre-defined events
in the ftrace trace buffer.

But if uprobe trampoline can run in the comparable speed, user may
want to use uprobes because it is based on widely used usdt and
avoid accessing tracefs from application. (The user event user
application has to setup their events via tracefs interface)

> 
> It's still rfc state with some loose ends, but I'd be interested in
> any feedback about the direction of this.

So does this change the usdt macro? Or it just reuse the usdt so that
user applications does not need to be recompiled?

Thank you,

> 
> It's based on tip/perf/core with bpf-next/master merged on top of
> that together with uprobe session patchset.
> 
> thanks,
> jirka
> 
> 
> current:
>         # ./bench -w2 -d5 -a  trig-usdt
>         Setting up benchmark 'trig-usdt'...
>         Benchmark 'trig-usdt' started.
>         Iter   0 ( 46.982us): hits    4.893M/s (  4.893M/prod), drops    0.000M/s, total operations    4.893M/s
>         Iter   1 ( -5.967us): hits    4.892M/s (  4.892M/prod), drops    0.000M/s, total operations    4.892M/s
>         Iter   2 ( -2.771us): hits    4.899M/s (  4.899M/prod), drops    0.000M/s, total operations    4.899M/s
>         Iter   3 (  1.286us): hits    4.889M/s (  4.889M/prod), drops    0.000M/s, total operations    4.889M/s
>         Iter   4 ( -2.871us): hits    4.881M/s (  4.881M/prod), drops    0.000M/s, total operations    4.881M/s
>         Iter   5 (  1.005us): hits    4.886M/s (  4.886M/prod), drops    0.000M/s, total operations    4.886M/s
>         Iter   6 ( 11.626us): hits    4.906M/s (  4.906M/prod), drops    0.000M/s, total operations    4.906M/s
>         Iter   7 ( -6.638us): hits    4.896M/s (  4.896M/prod), drops    0.000M/s, total operations    4.896M/s
>         Summary: hits    4.893 +- 0.009M/s (  4.893M/prod), drops    0.000 +- 0.000M/s, total operations    4.893 +- 0.009M/s
> 
> optimized:
>         # ./bench -w2 -d5 -a  trig-usdt
>         Setting up benchmark 'trig-usdt'...
>         Benchmark 'trig-usdt' started.
>         Iter   0 ( 46.073us): hits    8.258M/s (  8.258M/prod), drops    0.000M/s, total operations    8.258M/s
>         Iter   1 ( -5.752us): hits    8.264M/s (  8.264M/prod), drops    0.000M/s, total operations    8.264M/s
>         Iter   2 ( -1.333us): hits    8.263M/s (  8.263M/prod), drops    0.000M/s, total operations    8.263M/s
>         Iter   3 ( -2.996us): hits    8.265M/s (  8.265M/prod), drops    0.000M/s, total operations    8.265M/s
>         Iter   4 ( -0.620us): hits    8.264M/s (  8.264M/prod), drops    0.000M/s, total operations    8.264M/s
>         Iter   5 ( -2.624us): hits    8.236M/s (  8.236M/prod), drops    0.000M/s, total operations    8.236M/s
>         Iter   6 ( -0.840us): hits    8.232M/s (  8.232M/prod), drops    0.000M/s, total operations    8.232M/s
>         Iter   7 ( -1.783us): hits    8.235M/s (  8.235M/prod), drops    0.000M/s, total operations    8.235M/s
>         Summary: hits    8.249 +- 0.016M/s (  8.249M/prod), drops    0.000 +- 0.000M/s, total operations    8.249 +- 0.016M/s
> 
> ---
> Jiri Olsa (11):
>       uprobes: Rename arch_uretprobe_trampoline function
>       uprobes: Make copy_from_page global
>       uprobes: Add len argument to uprobe_write_opcode
>       uprobes: Add data argument to uprobe_write_opcode function
>       uprobes: Add mapping for optimized uprobe trampolines
>       uprobes: Add uprobe syscall to speed up uprobe
>       uprobes/x86: Add support to optimize uprobes
>       selftests/bpf: Use 5-byte nop for x86 usdt probes
>       selftests/bpf: Add usdt trigger bench
>       selftests/bpf: Add uprobe/usdt optimized test
>       selftests/bpf: Add hit/attach/detach race optimized uprobe test
> 
>  arch/x86/entry/syscalls/syscall_64.tbl                    |   1 +
>  arch/x86/include/asm/uprobes.h                            |   7 +++
>  arch/x86/kernel/uprobes.c                                 | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/syscalls.h                                  |   2 +
>  include/linux/uprobes.h                                   |  25 +++++++++-
>  kernel/events/uprobes.c                                   | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  kernel/fork.c                                             |   2 +
>  kernel/sys_ni.c                                           |   1 +
>  tools/testing/selftests/bpf/bench.c                       |   2 +
>  tools/testing/selftests/bpf/benchs/bench_trigger.c        |  45 +++++++++++++++++
>  tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c | 252 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/trigger_bench.c         |  10 +++-
>  tools/testing/selftests/bpf/progs/uprobe_optimized.c      |  29 +++++++++++
>  tools/testing/selftests/bpf/sdt.h                         |   9 +++-
>  14 files changed, 768 insertions(+), 19 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_optimized.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

