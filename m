Return-Path: <bpf+bounces-64485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFE3B135B7
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0641897736
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2622DA0B;
	Mon, 28 Jul 2025 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGYoCt5H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8161F5842;
	Mon, 28 Jul 2025 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687710; cv=none; b=QO1bzoBCCqThe8DfDC9IvtafNfHaBZtM+kI1qPvIUmRTrXJb67OVj/YbCUGg//dJCpc8vV9jR3AV6mBvA2rv3FyCGOaqmYWNm6z3fakXesT9UkWOy4Z1wJwIFqdipf7XicSWuHzl5iubKPLSHskB5uVNsYnIfDC8XVwSYO4b/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687710; c=relaxed/simple;
	bh=NuySEPRxGoYqa915NES8ScXAe1vL+2p1aF5SCXze/HU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=htkGLRAjmXwCGijmBJZPRr5WjQItmDI58DSNr75pXF+yldGce6oovVHQ1dOwrwLW9qZTIMW3TYvO+a0twdxJiitLT4S3NTRBQykN9uduXXKCv+L21YaM89AuthGbuBsN9x92Md3YDLAorcJstPof5dHYn/Tyovv/A4fgIySDzw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGYoCt5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE978C4CEE7;
	Mon, 28 Jul 2025 07:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753687710;
	bh=NuySEPRxGoYqa915NES8ScXAe1vL+2p1aF5SCXze/HU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iGYoCt5HULdz7sWlbKMUNuBGcWmPEJIppW2EmWfKu7kido2FsrCuT79fhGkLazZgh
	 X/DIFoB171oWo1o2KCeIPGn7ermAIHPMTDRmI+72/JKJ6SYQFuCsBfgiiuilGkg3aJ
	 oBZabsdHriznEi5vTBMRWkKcTHz63hcww2cRoAbEZ4eNO903NVUoDEZjfUFi1FyLY4
	 hsZ8D/+t3hyKOqtIPiDQ9kl5owYlQYHsO+yYXjoN4qRHksGMpNPq73pazdzjA32SkR
	 i+TPh2qDcV+oMfBtL8PM+BDteImIEp1ST001Q//txP0sBUOv3tYFKtTBpf2ffMxV73
	 hP1Ydmbm8j/TA==
Date: Mon, 28 Jul 2025 16:28:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] fprobe: use rhashtable for fprobe_ip_table
Message-Id: <20250728162827.09b6c89697bc1ce6a3f33d55@kernel.org>
In-Reply-To: <20250728041252.441040-1-dongml2@chinatelecom.cn>
References: <20250728041252.441040-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 28 Jul 2025 12:12:47 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, the budget of the hash table that is used for fprobe_ip_table is
> fixed, which is 256, and can cause huge overhead when the hooked functions
> is a huge quantity.
> 
> In this series, we use rhashtable for fprobe_ip_table to reduce the
> overhead.
> 
> Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
> will hook all the kernel functions during the testing. Before this series,
> the performance is:
>   usermode-count :  875.380 ± 0.366M/s 
>   kernel-count   :  435.924 ± 0.461M/s 
>   syscall-count  :   31.004 ± 0.017M/s 
>   fentry         :  134.076 ± 1.752M/s 
>   fexit          :   68.319 ± 0.055M/s 
>   fmodret        :   71.530 ± 0.032M/s 
>   rawtp          :  202.751 ± 0.138M/s 
>   tp             :   79.562 ± 0.084M/s 
>   kprobe         :   55.587 ± 0.028M/s 
>   kprobe-multi   :   56.481 ± 0.043M/s 
>   kprobe-multi-all:    6.283 ± 0.005M/s << look this
>   kretprobe      :   22.378 ± 0.028M/s 
>   kretprobe-multi:   28.205 ± 0.025M/s
> 
> With this series, the performance is:
>   usermode-count :  897.083 ± 5.347M/s 
>   kernel-count   :  431.638 ± 1.781M/s 
>   syscall-count  :   30.807 ± 0.057M/s 
>   fentry         :  134.803 ± 1.045M/s 
>   fexit          :   68.763 ± 0.018M/s 
>   fmodret        :   71.444 ± 0.052M/s 
>   rawtp          :  202.344 ± 0.149M/s 
>   tp             :   79.644 ± 0.376M/s 
>   kprobe         :   55.480 ± 0.108M/s 
>   kprobe-multi   :   57.302 ± 0.119M/s 
>   kprobe-multi-all:   57.855 ± 0.144M/s << look this
>   kretprobe      :   22.265 ± 0.023M/s 
>   kretprobe-multi:   27.740 ± 0.023M/s
> 
> The benchmark of "kprobe-multi-all" increase from 6.283M/s to 57.855M/s.

Wow, great improvement. Interesting. Let me review it.

Thanks!!

> 
> Menglong Dong (4):
>   fprobe: use rhashtable
>   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
>   selftests/bpf: add benchmark testing for kprobe-multi-all
>   selftests/bpf: skip recursive functions for kprobe_multi
> 
>  include/linux/fprobe.h                        |   2 +-
>  kernel/trace/fprobe.c                         | 144 ++++++-----
>  tools/testing/selftests/bpf/bench.c           |   2 +
>  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
>  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
>  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
>  8 files changed, 351 insertions(+), 282 deletions(-)
> 
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

