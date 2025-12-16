Return-Path: <bpf+bounces-76648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC51CC0509
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D44E03002E94
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E826824BD;
	Tue, 16 Dec 2025 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4M4hPtj"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF83B8D77
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765843905; cv=none; b=SEu/VA5SBGF7SDSU3v1GMdXXCUhXuFAmTlApfsyis4z8gTaQnXj1Sm5psxqiJ0v4JjEN6qAqacuG6b0F2lR6ZAUDihzNQgExZL1u6xks84CTRMYR6rlsqfbRHGijS3w72kBJQy/gXhrNMEAjFpckSwFz6S1q03XF+Qd4QlJ21Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765843905; c=relaxed/simple;
	bh=Uczbsul62V4/mcjhOSnWUAh8iklR2tmgUDe49wKdxFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQvKQZQNPUTsgVhJKERlBhKbDNM0epioqw2HvX0AuADIkraO1HEQ5tixZzCTn2c2cy4NAPiOM3pKrWij1fajVCAlW49/B2UZ8YPwfzfLMFG9/tJPRSFlRgRAimG1BfXuU8Xz5mSewpDLK8XRaGWg6KgvKxfVYMlMGF8FlPmhtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4M4hPtj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <982ded3a-a973-4c2e-ae7e-af01d346d582@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765843895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G26H2d3zHXzqLLWFCwlCI8cQctVjbXkFNPiSB0mZ1hw=;
	b=S4M4hPtjuzyDunncoAFOQGruuFR6mJ2D6s+v6Yw6brV4DkLzobRlhmpb0Ac5kYNv4cdx/h
	f/VEMV2gRYNumWXtz6mwiCSSUW1Ft0Nva8vlxVYEGQylSYGgG+kFAUjzUfuFnLFvBHqAY1
	iiZryYyp+3QY8XZtvxt84foVbGSkWhA=
Date: Mon, 15 Dec 2025 16:11:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/10/25 5:12 AM, Andy Shevchenko wrote:
> The printing functions in BPF code are using printf() type of format,
> and compiler is not happy about them as is:
> 
> kernel/bpf/helpers.c:1069:9: error: function ‘____bpf_snprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>  1069 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
>       |         ^~~
> 
> kernel/bpf/stream.c:241:9: error: function ‘bpf_stream_vprintk_impl’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>   241 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
>       |         ^~~
> 
> kernel/trace/bpf_trace.c:377:9: error: function ‘____bpf_trace_printk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>   377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
>       |         ^~~
> 
> kernel/trace/bpf_trace.c:433:9: error: function ‘____bpf_trace_vprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>   433 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
>       |         ^~~
> 
> kernel/trace/bpf_trace.c:475:9: error: function ‘____bpf_seq_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>   475 |         seq_bprintf(m, fmt, data.bin_args);
>       |         ^~~~~~~~~~~
> 
> Fix the compilation errors by disabling that warning since the code is
> generated and warning is not so useful in this case — it can't check
> the parameters for now.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061425.x0qTt9ww-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512081321.2h9ThWTg-lkp@intel.com/
> Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
> Fixes: 10aceb629e19 ("bpf: Add bpf_trace_vprintk helper")
> Fixes: 7b15523a989b ("bpf: Add a bpf_snprintf helper")
> Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")
> Fixes: f3694e001238 ("bpf: add BPF_CALL_x macros for declaring helpers")
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/bpf/Makefile   | 11 +++++++++--
>  kernel/trace/Makefile |  6 ++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 232cbc97434d..cf7e8a972f98 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,14 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
>  endif
>  CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
>  
> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o tnum.o log.o token.o liveness.o
> +
> +obj-$(CONFIG_BPF_SYSCALL) += helpers.o stream.o
> +# The ____bpf_snprintf() uses the format string that triggers a compiler warning.
> +CFLAGS_helpers.o += -Wno-suggest-attribute=format
> +# The bpf_stream_vprintk_impl() uses the format string that triggers a compiler warning.
> +CFLAGS_stream.o += -Wno-suggest-attribute=format

Hi Andy,

This flag does not exist in clang:

$ LLVM=1 make -j$(nproc) 
  [...]
$ LLVM=1 make
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      kernel/trace/bpf_trace.o
error: unknown warning option '-Wno-suggest-attribute=format'; did you mean '-Wno-property-attribute-mismatch'? [-Werror,-Wunknown-warning-option]
make[4]: *** [scripts/Makefile.build:287: kernel/trace/bpf_trace.o] Error 1
make[3]: *** [scripts/Makefile.build:556: kernel/trace] Error 2
make[2]: *** [scripts/Makefile.build:556: kernel] Error 2
make[1]: *** [/home/isolodrai/kernels/bpf-next/Makefile:2030: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

We should probably conditionalize the flag addition in the makefile.

Or better yet, address the root cause as suggested in the thread.

BPF CI is red on bpf branch at the moment:
https://github.com/kernel-patches/bpf/actions/runs/20243520506/job/58144348281

> +
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
> @@ -14,7 +21,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
>  obj-$(CONFIG_BPF_JIT) += trampoline.o
> -obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o
> +obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o
>  ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
>  obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
>  endif
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index fc5dcc888e13..1673b395c14c 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -104,7 +104,13 @@ obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
>  obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
>  obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
>  obj-$(CONFIG_USER_EVENTS) += trace_events_user.o
> +
>  obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
> +# The BPF printing functions use the format string that triggers a compiler warning.
> +# Since the code is generated and warning is not so useful in this case (it can't
> +# check the parameters for now) disable the warning.
> +CFLAGS_bpf_trace.o += -Wno-suggest-attribute=format
> +
>  obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
>  obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
>  obj-$(CONFIG_TRACEPOINTS) += power-traces.o


