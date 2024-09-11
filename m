Return-Path: <bpf+bounces-39646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E624E975A5E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5071F27717
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B71B78E3;
	Wed, 11 Sep 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKPYh8ze"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A37AE5D;
	Wed, 11 Sep 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079257; cv=none; b=fhkIcJxm/USxNi0ZdxfCu/G7lvjX4JlsIsfOmBBihUxOMoTG3ICBF2lyfsV1ldKc6cRGffMSuAZhCsBwQkhMi+jR0SDegzqhvC7MKKdS6a9vnEXA1mR5gGDnLFogx6h52dGWd19Vu/G5lQvWqQuylHmAhvl9sQ8c/OZd78yZfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079257; c=relaxed/simple;
	bh=KYGSee9etnBiRuotq8iO7Ev+Gigy3m9sqd1VayvtxYg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgoBKh718SFbe78gFNZIAKPRgxkgl0IiHrNUyd4MJF0kE3J8ShfirapVEzGZeoHbxOU53gPMeWeU8ljYzNiYgA1XN0pop4X/s3x7I52AreyrM0M9NmoVIWsnStjcX0PiQ/Pn6aOF8tTtESCmhdQq4Q7/uFM3TAydUDi7aBf0E3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKPYh8ze; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a843bef98so19158366b.2;
        Wed, 11 Sep 2024 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726079252; x=1726684052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Ka+rp42K8RHOWuCAEkNoyauBHNaOPpdLfkZsvoEyKI=;
        b=EKPYh8zebBLZ3L0p+b0InL+yMrExPg8K0X5mCmDkZAIHaHm6ppICrkEehwlk7dFKWR
         4/Kh/80UhmcxPWxJv4Np5ZWO4dmcbCao8XIdpJuqqEnhiZ+ja+Lxvrmq2EKnQqDpvjuE
         5oR7+tHiH/9YG6xaD30NQrCPQ3+HmRjgOSUnEVz1n1FrXPYfQfXWiZ+L3PHq2xcJcjnC
         QfZb/nmXQH/QOGgmKedDTHtN5vr4Zng2eMl3SP/uqvVZJRgb7wQXfT236F3yg3nCG7p+
         4zR5LsOBtHJrnTnheQUy08XkV61KjtQQff4NNQik5xfsZCf7jfR1QVspAzD5ctc9+xaK
         alhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726079252; x=1726684052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ka+rp42K8RHOWuCAEkNoyauBHNaOPpdLfkZsvoEyKI=;
        b=MqxhQATfgaU98WtPb18FcOf/oTSi32nlIuEcjOzLTnhsUaL2ROpQq8yC3fo8OA5TF1
         /kurzCZskQYgDi6aKtWZbDC1ALfLQMjsO0ECrbZxqrwtH7oM9VPXPO4Cr8tJfRAQ4ZoP
         J+sEP6aMX8FkzelQ26/LCfE6EJFEohCLSz7FQuvMDcGwp9E4yXFPB8dwmkpNdWQQt0LJ
         /llHyu40jB/0FiXIWsplSx+yVjTx5FqqVV3EH7SG111Jf1pQByxTtjMutG6HfSDyYUER
         8VwEeZktH2eJ4FkkyjjMZemwNWHM4t6RuoU1Y/BFq66pBOPiGh1Ssq3y2dw6E49VXtNY
         HU4w==
X-Forwarded-Encrypted: i=1; AJvYcCW8jPADRRkKIoMfCb0XZFNFozUZHTxS1b5QawPoD+vMM6mVKTMTxbZljTRotNhQOltLApKFNyx6xrnTNlCZ6RmG/WFO@vger.kernel.org, AJvYcCWLJ9X5ZC7DAxroMkD93Gr9SzXL2+SQW5XIGY2mgKmJkjpFd5cAC1tooVcK+A9mc8NZGBVGGG1HIiUbC4KD@vger.kernel.org, AJvYcCXeqQeLbbAVbOa+hYr3wG8BMlOGQaZEotKPWCKTsEKEAuQomwnzw7FZtCbTOr56tBwWu+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygIkf13u3p7ElVE1ip2tFxDhagEBzsrwQNftsLiXoNDdQOnhta
	CSxA91WpofXdszyeEpw9pog0ySnQtl/EM8e3Eg2J6h2BevQ73DY6
X-Google-Smtp-Source: AGHT+IGyU53EfbUXjg8MJMX6g3wIeIY1LoiIjYdEps7vPADau4x6cAciFQXHKx6uX5dIL9B8x1E/Vw==
X-Received: by 2002:a17:907:f794:b0:a80:f840:9004 with SMTP id a640c23a62f3a-a9029407febmr36581966b.12.1726079251224;
        Wed, 11 Sep 2024 11:27:31 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61279sm640168966b.108.2024.09.11.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 11:27:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Sep 2024 20:27:27 +0200
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <ZuHhD35xHpw2kCC-@krava>
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172398527264.293426.2050093948411376857.stgit@devnote2>

On Sun, Aug 18, 2024 at 09:47:53PM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 13th version of the series to re-implement the fprobe on
> function-graph tracer. The previous version is;
> 
> https://lore.kernel.org/all/172000134410.63468.13742222887213469474.stgit@devnote2/
> 
> This version is based on v6.11-rc3.
> In this version, I added a bugfix as [1/20], which should go to urgent
> branch, and dropped the performance improvement patch which was introduced
> in v12 because I found that does not work with new kernel.
> 
> Overview
> --------
> This series rewrites the fprobe on this function-graph.
> The purposes of this change are;
> 
>  1) Remove dependency of the rethook from fprobe so that we can reduce
>    the return hook code and shadow stack.
> 
>  2) Make 'ftrace_regs' the common trace interface for the function
>    boundary.
> 
> 1) Currently we have 2(or 3) different function return hook codes,
>  the function-graph tracer and rethook (and legacy kretprobe).
>  But since this  is redundant and needs double maintenance cost,
>  I would like to unify those. From the user's viewpoint, function-
>  graph tracer is very useful to grasp the execution path. For this
>  purpose, it is hard to use the rethook in the function-graph
>  tracer, but the opposite is possible. (Strictly speaking, kretprobe
>  can not use it because it requires 'pt_regs' for historical reasons.)
> 
> 2) Now the fprobe provides the 'pt_regs' for its handler, but that is
>  wrong for the function entry and exit. Moreover, depending on the
>  architecture, there is no way to accurately reproduce 'pt_regs'
>  outside of interrupt or exception handlers. This means fprobe should
>  not use 'pt_regs' because it does not use such exceptions.
>  (Conversely, kprobe should use 'pt_regs' because it is an abstract
>   interface of the software breakpoint exception.)
> 
> This series changes fprobe to use function-graph tracer for tracing
> function entry and exit, instead of mixture of ftrace and rethook.
> Unlike the rethook which is a per-task list of system-wide allocated
> nodes, the function graph's ret_stack is a per-task shadow stack.
> Thus it does not need to set 'nr_maxactive' (which is the number of
> pre-allocated nodes).
> Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
> Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
> their register interface, this changes it to convert 'ftrace_regs' to
> 'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
> so users must access only registers for function parameters or
> return value. 
> 
> Design
> ------
> Instead of using ftrace's function entry hook directly, the new fprobe
> is built on top of the function-graph's entry and return callbacks
> with 'ftrace_regs'.
> 
> Since the fprobe requires access to 'ftrace_regs', the architecture
> must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
> CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
> entry callback with 'ftrace_regs', and also
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
> return_to_handler.
> 
> All fprobes share a single function-graph ops (means shares a common
> ftrace filter) similar to the kprobe-on-ftrace. This needs another
> layer to find corresponding fprobe in the common function-graph
> callbacks, but has much better scalability, since the number of
> registered function-graph ops is limited.
> 
> In the entry callback, the fprobe runs its entry_handler and saves the
> address of 'fprobe' on the function-graph's shadow stack as data. The
> return callback decodes the data to get the 'fprobe' address, and runs
> the exit_handler.
> 
> The fprobe introduces two hash-tables, one is for entry callback which
> searches fprobes related to the given function address passed by entry
> callback. The other is for a return callback which checks if the given
> 'fprobe' data structure pointer is still valid. Note that it is
> possible to unregister fprobe before the return callback runs. Thus
> the address validation must be done before using it in the return
> callback.
> 
> Download
> --------
> This series can be applied against the ftrace/for-next branch in
> linux-trace tree.
> 
> This series can also be found below branch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph
> 
> Thank you,
> 
> ---

hi,
I ran the kprobe_multi bench and I'm seeing lower throughput numbers
with new fprobe implementation

base (bpf-next/master)

        root@amd:/home/jolsa/bpf-next/tools/testing/selftests/bpf# ./bench -w2 -d5 -a trig-kprobe-multi
        Setting up benchmark 'trig-kprobe-multi'...
        Benchmark 'trig-kprobe-multi' started.
        Iter   0 ( 70.969us): hits    8.530M/s (  8.530M/prod), drops    0.000M/s, total operations    8.530M/s
        Iter   1 (-24.985us): hits    8.541M/s (  8.541M/prod), drops    0.000M/s, total operations    8.541M/s
        Iter   2 ( -2.976us): hits    8.537M/s (  8.537M/prod), drops    0.000M/s, total operations    8.537M/s
        Iter   3 ( -1.502us): hits    8.540M/s (  8.540M/prod), drops    0.000M/s, total operations    8.540M/s
        Iter   4 (  0.392us): hits    8.540M/s (  8.540M/prod), drops    0.000M/s, total operations    8.540M/s
        Iter   5 (  1.308us): hits    8.545M/s (  8.545M/prod), drops    0.000M/s, total operations    8.545M/s
        Iter   6 (  2.783us): hits    8.530M/s (  8.530M/prod), drops    0.000M/s, total operations    8.530M/s
        Iter   7 ( -3.775us): hits    8.535M/s (  8.535M/prod), drops    0.000M/s, total operations    8.535M/s
        Summary: hits    8.538 ± 0.005M/s (  8.538M/prod), drops    0.000 ± 0.000M/s, total operations    8.538 ± 0.005M/s

your patchset on top of bpf-next/master

        root@amd:/home/jolsa/bpf-next/tools/testing/selftests/bpf# ./bench -w2 -d5 -a trig-kprobe-multi
        Setting up benchmark 'trig-kprobe-multi'...
        Benchmark 'trig-kprobe-multi' started.
        Iter   0 ( 55.712us): hits    7.224M/s (  7.224M/prod), drops    0.000M/s, total operations    7.224M/s
        Iter   1 ( 15.226us): hits    7.222M/s (  7.222M/prod), drops    0.000M/s, total operations    7.222M/s
        Iter   2 ( -1.353us): hits    7.221M/s (  7.221M/prod), drops    0.000M/s, total operations    7.221M/s
        Iter   3 (-13.029us): hits    7.223M/s (  7.223M/prod), drops    0.000M/s, total operations    7.223M/s
        Iter   4 (  9.111us): hits    7.222M/s (  7.222M/prod), drops    0.000M/s, total operations    7.222M/s
        Iter   5 ( -0.106us): hits    7.222M/s (  7.222M/prod), drops    0.000M/s, total operations    7.222M/s
        Iter   6 (  0.734us): hits    7.221M/s (  7.221M/prod), drops    0.000M/s, total operations    7.221M/s
        Iter   7 (-10.233us): hits    7.220M/s (  7.220M/prod), drops    0.000M/s, total operations    7.220M/s
        Summary: hits    7.221 ± 0.001M/s (  7.221M/prod), drops    0.000 ± 0.000M/s, total operations    7.221 ± 0.001M/s


I did perf profile (attached), but nothing stands out on the first look,
I'll try to check on that later this week

jirka


---
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 42K of event 'cycles:k'
# Event count (approx.): 44580427937
#
# Overhead  Command          Shared Object                                         Symbol                                                  
# ........  ...............  ....................................................  ........................................................
#
    17.47%  bench            [kernel.vmlinux]                                      [k] find_kallsyms_symbol
            |
            ---find_kallsyms_symbol
               module_address_lookup
               kallsyms_lookup_buildid
               kallsyms_lookup
               print_rec
               t_show
               seq_read_iter
               seq_read
               vfs_read
               ksys_read
               __x64_sys_read
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               read
               0

    11.71%  bench            [kernel.vmlinux]                                      [k] kprobe_multi_link_prog_run
            |
            ---kprobe_multi_link_prog_run
               |          
                --11.56%--kprobe_multi_link_handler
                          fprobe_entry
                          function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     7.65%  bench            [kernel.vmlinux]                                      [k] function_graph_enter_regs
            |
            ---function_graph_enter_regs
               |          
                --7.65%--ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     7.55%  bench            [kernel.vmlinux]                                      [k] kprobe_multi_link_handler
            |
            ---kprobe_multi_link_handler
               |          
               |--4.35%--function_graph_enter_regs
               |          ftrace_graph_func
               |          0xffffffffc29850ab
               |          bpf_get_numa_node_id
               |          bpf_prog_d9703036495d54b0_trigger_driver
               |          __bpf_prog_test_run_raw_tp
               |          bpf_prog_test_run_raw_tp
               |          __sys_bpf
               |          __x64_sys_bpf
               |          x64_sys_call
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          syscall
               |          bpf_prog_test_run_opts
               |          trigger_producer_batch
               |          0x7a2a73a94ac3
               |          
                --3.20%--fprobe_entry
                          function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     7.50%  bench            [kernel.vmlinux]                                      [k] fprobe_entry
            |
            ---fprobe_entry
               |          
                --7.50%--function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     7.08%  bench            bpf_prog_7790468e40a289ea_bench_trigger_kprobe_multi  [k] bpf_prog_7790468e40a289ea_bench_trigger_kprobe_multi
            |
            ---bpf_prog_7790468e40a289ea_bench_trigger_kprobe_multi
               |          
               |--4.10%--kprobe_multi_link_handler
               |          fprobe_entry
               |          function_graph_enter_regs
               |          ftrace_graph_func
               |          0xffffffffc29850ab
               |          bpf_get_numa_node_id
               |          bpf_prog_d9703036495d54b0_trigger_driver
               |          __bpf_prog_test_run_raw_tp
               |          bpf_prog_test_run_raw_tp
               |          __sys_bpf
               |          __x64_sys_bpf
               |          x64_sys_call
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          syscall
               |          bpf_prog_test_run_opts
               |          trigger_producer_batch
               |          0x7a2a73a94ac3
               |          
                --2.97%--kprobe_multi_link_prog_run
                          kprobe_multi_link_handler
                          fprobe_entry
                          function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     6.11%  bench            [kernel.vmlinux]                                      [k] migrate_enable
            |
            ---migrate_enable
               |          
               |--3.37%--kprobe_multi_link_handler
               |          fprobe_entry
               |          function_graph_enter_regs
               |          ftrace_graph_func
               |          0xffffffffc29850ab
               |          bpf_get_numa_node_id
               |          bpf_prog_d9703036495d54b0_trigger_driver
               |          __bpf_prog_test_run_raw_tp
               |          bpf_prog_test_run_raw_tp
               |          __sys_bpf
               |          __x64_sys_bpf
               |          x64_sys_call
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          syscall
               |          bpf_prog_test_run_opts
               |          trigger_producer_batch
               |          0x7a2a73a94ac3
               |          
                --2.73%--kprobe_multi_link_prog_run
                          kprobe_multi_link_handler
                          fprobe_entry
                          function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     5.90%  bench            [kernel.vmlinux]                                      [k] ftrace_graph_func
            |
            ---ftrace_graph_func
               |          
                --5.75%--0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     4.03%  bench            [kernel.vmlinux]                                      [k] __rcu_read_lock
            |
            ---__rcu_read_lock
               |          
                --4.00%--kprobe_multi_link_handler
                          fprobe_entry
                          function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     3.61%  bench            [kernel.vmlinux]                                      [k] bpf_get_numa_node_id
            |
            ---bpf_get_numa_node_id
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               syscall
               bpf_prog_test_run_opts
               trigger_producer_batch
               0x7a2a73a94ac3

     2.99%  bench            [nf_conntrack]                                        [k] 0x000000000002c0b3
            |
            ---0xffffffffc29850b3
               bpf_get_numa_node_id
               bpf_prog_d9703036495d54b0_trigger_driver
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               syscall
               bpf_prog_test_run_opts
               trigger_producer_batch
               0x7a2a73a94ac3

     2.69%  bench            bpf_prog_d9703036495d54b0_trigger_driver              [k] bpf_prog_d9703036495d54b0_trigger_driver
            |
            ---bpf_prog_d9703036495d54b0_trigger_driver
               |          
                --2.68%--__bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     2.04%  bench            [kernel.vmlinux]                                      [k] t_start
            |
            ---t_start
               seq_read_iter
               seq_read
               vfs_read
               ksys_read
               __x64_sys_read
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               read
               0

     1.90%  bench            [kernel.vmlinux]                                      [k] srso_untrain_ret
            |
            ---srso_untrain_ret
               |          
               |--0.68%--fprobe_entry
               |          function_graph_enter_regs
               |          ftrace_graph_func
               |          0xffffffffc29850ab
               |          bpf_get_numa_node_id
               |          bpf_prog_d9703036495d54b0_trigger_driver
               |          __bpf_prog_test_run_raw_tp
               |          bpf_prog_test_run_raw_tp
               |          __sys_bpf
               |          __x64_sys_bpf
               |          x64_sys_call
               |          do_syscall_64
               |          entry_SYSCALL_64
               |          syscall
               |          bpf_prog_test_run_opts
               |          trigger_producer_batch
               |          0x7a2a73a94ac3
               |          
                --0.54%--seq_read_iter
                          seq_read
                          vfs_read
                          ksys_read
                          __x64_sys_read
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          read
                          0

     1.14%  bench            [kernel.vmlinux]                                      [k] __rcu_read_unlock
            |
            ---__rcu_read_unlock
               |          
                --1.12%--kprobe_multi_link_handler
                          fprobe_entry
                          function_graph_enter_regs
                          ftrace_graph_func
                          0xffffffffc29850ab
                          bpf_get_numa_node_id
                          bpf_prog_d9703036495d54b0_trigger_driver
                          __bpf_prog_test_run_raw_tp
                          bpf_prog_test_run_raw_tp
                          __sys_bpf
                          __x64_sys_bpf
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          0x7a2a73a94ac3

     1.02%  bench            [kernel.vmlinux]                                      [k] migrate_disable
            |
            ---migrate_disable
               kprobe_multi_link_handler
               fprobe_entry
               function_graph_enter_regs
               ftrace_graph_func
               0xffffffffc29850ab
               bpf_get_numa_node_id
               bpf_prog_d9703036495d54b0_trigger_driver
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               syscall
               bpf_prog_test_run_opts
               trigger_producer_batch
               0x7a2a73a94ac3

     0.99%  bench            [kernel.vmlinux]                                      [k] t_func_next.isra.0
            |
            ---t_func_next.isra.0
               |          
                --0.83%--t_start
                          seq_read_iter
                          seq_read
                          vfs_read
                          ksys_read
                          __x64_sys_read
                          x64_sys_call
                          do_syscall_64
                          entry_SYSCALL_64
                          read
                          0

     0.78%  bench            [nf_conntrack]                                        [k] 0x000000000002c0d4
            |
            ---0xffffffffc29850d4
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               syscall
               bpf_prog_test_run_opts
               trigger_producer_batch
               0x7a2a73a94ac3

     0.75%  bench            [nf_conntrack]                                        [k] 0x000000000002c0ab
            |
            ---0xffffffffc29850ab
               bpf_get_numa_node_id
               bpf_prog_d9703036495d54b0_trigger_driver
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               syscall
               bpf_prog_test_run_opts
               trigger_producer_batch
               0x7a2a73a94ac3

     0.68%  bench            [nf_conntrack]                                        [k] 0x000000000002c00d
            |
            ---0xffffffffc298500d
               bpf_prog_d9703036495d54b0_trigger_driver
               __bpf_prog_test_run_raw_tp
               bpf_prog_test_run_raw_tp
               __sys_bpf
               __x64_sys_bpf
               x64_sys_call
               do_syscall_64
               entry_SYSCALL_64
               syscall
               bpf_prog_test_run_opts
               trigger_producer_batch
               0x7a2a73a94ac3

     0.52%  bench            [kernel.vmlinux]                                      [k] __x86_indirect_thunk_array
            |
            ---__x86_indirect_thunk_array

     0.42%  bench            [nf_conntrack]                                        [k] 0x000000000002c005
     0.38%  bench            [kernel.vmlinux]                                      [k] __sys_bpf
     0.37%  bench            [kernel.vmlinux]                                      [k] srso_return_thunk
     0.24%  bench            [nf_conntrack]                                        [k] 0x000000000002c001
     0.23%  bench            [kernel.vmlinux]                                      [k] read_hpet
     0.21%  bench            [kernel.vmlinux]                                      [k] entry_SYSCALL_64
     0.19%  bench            [kernel.vmlinux]                                      [k] bpf_prog_test_run_raw_tp
     0.17%  bench            [nf_conntrack]                                        [k] 0x000000000002c000
     0.15%  bench            [kernel.vmlinux]                                      [k] _copy_from_user
     0.15%  bench            [kernel.vmlinux]                                      [k] syscall_exit_to_user_mode
     0.14%  bench            [nf_conntrack]                                        [k] 0x000000000002c027
     0.14%  bench            [nf_conntrack]                                        [k] 0x000000000002c0ca
     0.13%  swapper          [kernel.vmlinux]                                      [k] read_hpet
     0.12%  bench            [kernel.vmlinux]                                      [k] _copy_to_user
     0.12%  bench            [nf_conntrack]                                        [k] 0x000000000002c086
     0.11%  bench            [nf_conntrack]                                        [k] 0x000000000002c0c0
     0.11%  bench            [kernel.vmlinux]                                      [k] __fdget
     0.11%  bench            bench                                                 [.] bpf_prog_test_run_opts
     0.11%  bench            [kernel.vmlinux]                                      [k] __bpf_prog_test_run_raw_tp
     0.10%  bench            [nf_conntrack]                                        [k] 0x000000000002c059
     0.09%  bench            [kernel.vmlinux]                                      [k] get_symbol_offset
     0.09%  bench            [kernel.vmlinux]                                      [k] do_syscall_64
     0.08%  bench            [kernel.vmlinux]                                      [k] __bpf_prog_get
     0.08%  bench            [kernel.vmlinux]                                      [k] memchr_inv
     0.07%  bench            [kernel.vmlinux]                                      [k] syscall_return_via_sysret
     0.06%  bench            [kernel.vmlinux]                                      [k] x64_sys_call
     0.06%  bench            [kernel.vmlinux]                                      [k] rep_movs_alternative
     0.06%  bench            [kernel.vmlinux]                                      [k] ftrace_replace_code
     0.04%  bench            [kernel.vmlinux]                                      [k] __x64_sys_bpf
     0.04%  bench            [kernel.vmlinux]                                      [k] get_symbol_pos
     0.04%  bench            bench                                                 [.] sys_bpf
     0.04%  bench            [kernel.vmlinux]                                      [k] vsnprintf
     0.04%  bench            [kernel.vmlinux]                                      [k] number
     0.04%  bench            bench                                                 [.] ptr_to_u64
     0.04%  bench            [kernel.vmlinux]                                      [k] kfree
     0.03%  bench            [kernel.vmlinux]                                      [k] seq_read_iter
     0.03%  bench            [kernel.vmlinux]                                      [k] security_bpf
     0.03%  bench            libc.so.6                                             [.] syscall
     0.03%  bench            [kernel.vmlinux]                                      [k] kallsyms_expand_symbol.constprop.0
     0.03%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] memcpy_orig
     0.03%  swapper          [amdgpu]                                              [k] 0x0000000000002f75
     0.03%  bench            bench                                                 [.] trigger_producer_batch
     0.03%  bench            [kernel.vmlinux]                                      [k] __bpf_prog_put
     0.02%  bench            [kernel.vmlinux]                                      [k] seq_printf
     0.02%  bench            [kernel.vmlinux]                                      [k] smp_call_function_many_cond
     0.02%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000002f75
     0.02%  bench            [kernel.vmlinux]                                      [k] __check_object_size
     0.02%  bench            [kernel.vmlinux]                                      [k] ftrace_test_record
     0.02%  bench            [kernel.vmlinux]                                      [k] seq_write
     0.02%  bench            [kernel.vmlinux]                                      [k] ftrace_lookup_ip
     0.02%  bench            [kernel.vmlinux]                                      [k] t_show
     0.02%  bench            [kernel.vmlinux]                                      [k] print_rec
     0.02%  swapper          [kernel.vmlinux]                                      [k] io_idle
     0.01%  bench            [amdgpu]                                              [k] 0x0000000000002f75
     0.01%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] memcmp
     0.01%  bench            [kernel.vmlinux]                                      [k] format_decode
     0.01%  bench            [kernel.vmlinux]                                      [k] memcpy_orig
     0.01%  bench            [kernel.vmlinux]                                      [k] __ftrace_hash_rec_update.part.0
     0.01%  bench            [kernel.vmlinux]                                      [k] mod_find
     0.01%  swapper          [kernel.vmlinux]                                      [k] srso_untrain_ret
     0.01%  bench            [kernel.vmlinux]                                      [k] kallsyms_lookup_buildid
     0.01%  bench            [kernel.vmlinux]                                      [k] __seq_puts
     0.01%  bench            [kernel.vmlinux]                                      [k] native_read_msr
     0.01%  bench            [kernel.vmlinux]                                      [k] check_stack_object
     0.01%  bench            [kernel.vmlinux]                                      [k] fput
     0.01%  bench            bench                                                 [.] libbpf_err_errno
     0.01%  bench            [kernel.vmlinux]                                      [k] fpregs_assert_state_consistent
     0.01%  bench            [kernel.vmlinux]                                      [k] ftrace_check_record
     0.01%  bench            [kernel.vmlinux]                                      [k] t_next
     0.01%  bench            [kernel.vmlinux]                                      [k] strlen
     0.01%  swapper          [kernel.vmlinux]                                      [k] native_sched_clock
     0.01%  bench            [kernel.vmlinux]                                      [k] __sysvec_apic_timer_interrupt
     0.01%  bench            libc.so.6                                             [.] 0x00000000001a0f10
     0.01%  bench            [kernel.vmlinux]                                      [k] native_write_msr
     0.01%  bench            [kernel.vmlinux]                                      [k] __update_load_avg_se
     0.01%  bench            [kernel.vmlinux]                                      [k] amd_pmu_addr_offset
     0.01%  bench            [kernel.vmlinux]                                      [k] module_address_lookup
     0.01%  bench            [kernel.vmlinux]                                      [k] ftrace_rec_iter_next
     0.01%  bench            [kernel.vmlinux]                                      [k] string
     0.01%  bench            [kernel.vmlinux]                                      [k] asm_exc_page_fault
     0.01%  swapper          [kernel.vmlinux]                                      [k] __get_next_timer_interrupt
     0.01%  bench            [kernel.vmlinux]                                      [k] clear_page_rep
     0.01%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] delay_halt_mwaitx
     0.01%  bench            [kernel.vmlinux]                                      [k] __handle_mm_fault
     0.01%  swapper          [kernel.vmlinux]                                      [k] ktime_get
     0.01%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] clear_page_rep
     0.01%  swapper          [kernel.vmlinux]                                      [k] menu_select
     0.00%  perf             [kernel.vmlinux]                                      [k] clear_page_rep
     0.00%  bench            [kernel.vmlinux]                                      [k] ftrace_rec_iter_record
     0.00%  bench            [kernel.vmlinux]                                      [k] account_process_tick
     0.00%  bench            [kernel.vmlinux]                                      [k] __update_load_avg_cfs_rq
     0.00%  bench            [kernel.vmlinux]                                      [k] update_curr
     0.00%  bench            [kernel.vmlinux]                                      [k] do_sync_core
     0.00%  bench            [kernel.vmlinux]                                      [k] kallsyms_lookup
     0.00%  bench            [kernel.vmlinux]                                      [k] memset_orig
     0.00%  kworker/6:1-eve  [kernel.vmlinux]                                      [k] memcpy_orig
     0.00%  perf             [kernel.vmlinux]                                      [k] rep_movs_alternative
     0.00%  sshd             [kernel.vmlinux]                                      [k] p4d_offset
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x0000000000002f75
     0.00%  bench            [kernel.vmlinux]                                      [k] __mod_memcg_lruvec_state
     0.00%  swapper          [kernel.vmlinux]                                      [k] _raw_spin_unlock
     0.00%  swapper          [kernel.vmlinux]                                      [k] cpuidle_enter_state
     0.00%  swapper          [kernel.vmlinux]                                      [k] rb_erase
     0.00%  containerd       [kernel.vmlinux]                                      [k] read_hpet
     0.00%  kworker/6:1-eve  [kernel.vmlinux]                                      [k] memcmp
     0.00%  swapper          [kernel.vmlinux]                                      [k] irq_entries_start
     0.00%  swapper          [kernel.vmlinux]                                      [k] do_idle
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] read_hpet
     0.00%  swapper          [kernel.vmlinux]                                      [k] update_rq_clock
     0.00%  swapper          [kernel.vmlinux]                                      [k] psi_group_change
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_clock_cpu
     0.00%  swapper          [kernel.vmlinux]                                      [k] do_sync_core
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000064ec11
     0.00%  swapper          [kernel.vmlinux]                                      [k] _raw_spin_lock_irqsave
     0.00%  swapper          [kernel.vmlinux]                                      [k] asm_sysvec_call_function_single
     0.00%  swapper          [kernel.vmlinux]                                      [k] update_sd_lb_stats.constprop.0
     0.00%  perf             [kernel.vmlinux]                                      [k] __filemap_get_folio
     0.00%  swapper          [kernel.vmlinux]                                      [k] irqentry_enter
     0.00%  bench            [kernel.vmlinux]                                      [k] amd_pmu_test_overflow_topbit
     0.00%  bench            [amdgpu]                                              [k] 0x0000000000124f4c
     0.00%  bench            [kernel.vmlinux]                                      [k] update_rq_clock
     0.00%  bench            [kernel.vmlinux]                                      [k] perf_event_task_tick
     0.00%  bench            [amdgpu]                                              [k] 0x0000000000126f3a
     0.00%  bench            [kernel.vmlinux]                                      [k] sched_balance_update_blocked_averages
     0.00%  bench            [kernel.vmlinux]                                      [k] hrtimer_active
     0.00%  bench            [kernel.vmlinux]                                      [k] _copy_to_iter
     0.00%  bench            [kernel.vmlinux]                                      [k] _raw_spin_lock_irqsave
     0.00%  bench            [kernel.vmlinux]                                      [k] calc_global_load_tick
     0.00%  bench            [kernel.vmlinux]                                      [k] ftrace_shutdown.part.0
     0.00%  bench            libc.so.6                                             [.] 0x00000000001a0fb5
     0.00%  bench            [kernel.vmlinux]                                      [k] task_tick_mm_cid
     0.00%  bench            libc.so.6                                             [.] 0x00000000001a0fba
     0.00%  bench            [kernel.vmlinux]                                      [k] sched_clock_cpu
     0.00%  bench            [kernel.vmlinux]                                      [k] update_cfs_group
     0.00%  bench            [kernel.vmlinux]                                      [k] irq_exit_rcu
     0.00%  bench            [kernel.vmlinux]                                      [k] native_sched_clock
     0.00%  bench            [kernel.vmlinux]                                      [k] sched_tick
     0.00%  bench            [kernel.vmlinux]                                      [k] sized_strscpy
     0.00%  bench            [kernel.vmlinux]                                      [k] task_tick_fair
     0.00%  bench            [nf_conntrack]                                        [k] 0x000000000002c036
     0.00%  bench            [kernel.vmlinux]                                      [k] perf_adjust_freq_unthr_context
     0.00%  bench            [kernel.vmlinux]                                      [k] idle_cpu
     0.00%  bench            [kernel.vmlinux]                                      [k] bpf_check_uarg_tail_zero
     0.00%  swapper          [kernel.vmlinux]                                      [k] __hrtimer_next_event_base
     0.00%  swapper          [kernel.vmlinux]                                      [k] native_write_msr
     0.00%  bench            [kernel.vmlinux]                                      [k] __module_address.part.0
     0.00%  bench            [kernel.vmlinux]                                      [k] lru_gen_add_folio
     0.00%  bench            [kernel.vmlinux]                                      [k] set_pte_range
     0.00%  bench            [kernel.vmlinux]                                      [k] pfn_pte
     0.00%  swapper          [kernel.vmlinux]                                      [k] error_entry
     0.00%  swapper          [kernel.vmlinux]                                      [k] idle_cpu
     0.00%  bench            [kernel.vmlinux]                                      [k] unmap_page_range
     0.00%  bench            [kernel.vmlinux]                                      [k] __count_memcg_events
     0.00%  bench            [kernel.vmlinux]                                      [k] __irq_exit_rcu
     0.00%  perf             [kernel.vmlinux]                                      [k] __perf_event_enable
     0.00%  bench            [kernel.vmlinux]                                      [k] seq_putc
     0.00%  perf             [kernel.vmlinux]                                      [k] srso_untrain_ret
     0.00%  swapper          [kernel.vmlinux]                                      [k] __irq_exit_rcu
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] __kmalloc_cache_noprof
     0.00%  bench            libc.so.6                                             [.] 0x00000000001a0bd7
     0.00%  perf             [kernel.vmlinux]                                      [k] _raw_spin_lock
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] __bio_split_to_limits
     0.00%  bench            [kernel.vmlinux]                                      [k] do_anonymous_page
     0.00%  perf             [kernel.vmlinux]                                      [k] __es_insert_extent
     0.00%  bench            [kernel.vmlinux]                                      [k] __mem_cgroup_charge
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] __wait_for_common
     0.00%  bench            [kernel.vmlinux]                                      [k] __folio_throttle_swaprate
     0.00%  swapper          [kernel.vmlinux]                                      [k] __switch_to_asm
     0.00%  swapper          [kernel.vmlinux]                                      [k] add_interrupt_randomness
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] srso_untrain_ret
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] memset_orig
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] percpu_counter_add_batch
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_irq_enter
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_check_broadcast_expired
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000045d28e
     0.00%  perf             [kernel.vmlinux]                                      [k] __lruvec_stat_mod_folio
     0.00%  bench            [kernel.vmlinux]                                      [k] kernfs_fop_read_iter
     0.00%  bench            [kernel.vmlinux]                                      [k] __mod_zone_page_state
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] delay_halt
     0.00%  perf             [kernel.vmlinux]                                      [k] __mod_memcg_lruvec_state
     0.00%  perf             [kernel.vmlinux]                                      [k] xas_load
     0.00%  perf             [kernel.vmlinux]                                      [k] workingset_update_node
     0.00%  perf             [kernel.vmlinux]                                      [k] _raw_spin_unlock
     0.00%  swapper          [kernel.vmlinux]                                      [k] __handle_irq_event_percpu
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] post_alloc_hook
     0.00%  bench            [kernel.vmlinux]                                      [k] refill_obj_stock
     0.00%  perf             [kernel.vmlinux]                                      [k] __alloc_pages_noprof
     0.00%  swapper          [kernel.vmlinux]                                      [k] cpuidle_enter
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_balance_domains
     0.00%  perf             [kernel.vmlinux]                                      [k] __handle_mm_fault
     0.00%  swapper          [kernel.vmlinux]                                      [k] ct_kernel_enter.constprop.0
     0.00%  bench            [kernel.vmlinux]                                      [k] mab_mas_cp
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000004619a7
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_nohz_irq_exit
     0.00%  perf             [kernel.vmlinux]                                      [k] __memcg_slab_post_alloc_hook
     0.00%  bench            [kernel.vmlinux]                                      [k] __alloc_pages_noprof
     0.00%  swapper          [kernel.vmlinux]                                      [k] irq_exit_rcu
     0.00%  bench            [kernel.vmlinux]                                      [k] memcmp
     0.00%  swapper          [kernel.vmlinux]                                      [k] asm_sysvec_call_function
     0.00%  perf             [kernel.vmlinux]                                      [k] perf_poll
     0.00%  swapper          [kernel.vmlinux]                                      [k] enqueue_task_fair
     0.00%  bench            [kernel.vmlinux]                                      [k] __rmqueue_pcplist
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] __iommu_map
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x0000000000992cd2
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x00000000004b2ade
     0.00%  swapper          [kernel.vmlinux]                                      [k] wakeup_preempt
     0.00%  migration/11     [kernel.vmlinux]                                      [k] enqueue_task
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_update_next_event
     0.00%  swapper          [kernel.vmlinux]                                      [k] native_apic_mem_eoi
     0.00%  bench            [kernel.vmlinux]                                      [k] is_sync_callback_calling_insn
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x0000000000992cb3
     0.00%  systemd-network  libc.so.6                                             [.] clock_gettime
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] filemap_get_folios_tag
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] fscrypt_mergeable_bio_bh
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_start_range_ns
     0.00%  multipathd       [kernel.vmlinux]                                      [k] cpuacct_charge
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_get_next_event
     0.00%  kworker/12:1-ev  [amdgpu]                                              [k] 0x00000000004b09fc
     0.00%  kworker/12:1-ev  [kernel.vmlinux]                                      [k] memcpy_orig
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] wbt_track
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] __lruvec_stat_mod_folio
     0.00%  kworker/12:1-ev  [amdgpu]                                              [k] 0x0000000000002f75
     0.00%  bench            [kernel.vmlinux]                                      [k] do_jit
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] __folio_start_writeback
     0.00%  bench            [kernel.vmlinux]                                      [k] uncharge_folio
     0.00%  perf             [kernel.vmlinux]                                      [k] do_fault
     0.00%  perf             [kernel.vmlinux]                                      [k] __kmalloc_noprof
     0.00%  containerd       [kernel.vmlinux]                                      [k] blkcg_maybe_throttle_current
     0.00%  kworker/12:1-ev  [amdgpu]                                              [k] 0x0000000000523901
     0.00%  kworker/12:1-ev  [amdgpu]                                              [k] 0x0000000000538414
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000465f98
     0.00%  irqbalance       [kernel.vmlinux]                                      [k] format_decode
     0.00%  swapper          [kernel.vmlinux]                                      [k] handle_edge_irq
     0.00%  kworker/12:1-ev  [kernel.vmlinux]                                      [k] srso_untrain_ret
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] __find_get_block
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] __put_user_nocheck_4
     0.00%  systemd-journal  libsystemd-shared-249.so                              [.] 0x00000000001c9c3e
     0.00%  swapper          [kernel.vmlinux]                                      [k] local_touch_nmi
     0.00%  bench            [kernel.vmlinux]                                      [k] __mem_cgroup_uncharge_folios
     0.00%  swapper          [kernel.vmlinux]                                      [k] _raw_spin_lock
     0.00%  swapper          [kernel.vmlinux]                                      [k] select_task_rq_fair
     0.00%  swapper          [kernel.vmlinux]                                      [k] need_update
     0.00%  bench            [kernel.vmlinux]                                      [k] rcu_segcblist_enqueue
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_nohz_get_sleep_length
     0.00%  containerd       [kernel.vmlinux]                                      [k] _raw_spin_unlock
     0.00%  containerd       [kernel.vmlinux]                                      [k] ep_autoremove_wake_function
     0.00%  kworker/u66:1-e  [kernel.vmlinux]                                      [k] __percpu_counter_sum
     0.00%  swapper          [kernel.vmlinux]                                      [k] ktime_get_mono_fast_ns
     0.00%  swapper          [kernel.vmlinux]                                      [k] sysvec_apic_timer_interrupt
     0.00%  swapper          [kernel.vmlinux]                                      [k] _raw_spin_unlock_irqrestore
     0.00%  migration/10     [kernel.vmlinux]                                      [k] dequeue_entity
     0.00%  swapper          [kernel.vmlinux]                                      [k] handle_irq_event
     0.00%  perf             [kernel.vmlinux]                                      [k] srso_return_thunk
     0.00%  perf             [kernel.vmlinux]                                      [k] xas_find_conflict
     0.00%  perf-exec        [kernel.vmlinux]                                      [k] mas_next_slot
     0.00%  swapper          [kernel.vmlinux]                                      [k] fetch_next_timer_interrupt.constprop.0
     0.00%  bench            [kernel.vmlinux]                                      [k] get_page_from_freelist
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000125079
     0.00%  kworker/u65:4-e  [kernel.vmlinux]                                      [k] sched_balance_newidle
     0.00%  migration/6      [kernel.vmlinux]                                      [k] raw_spin_rq_unlock
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000444a05
     0.00%  swapper          [kernel.vmlinux]                                      [k] fetch_pte
     0.00%  perf             [kernel.vmlinux]                                      [k] __pte_offset_map
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000534985
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000003ac5
     0.00%  bench            [kernel.vmlinux]                                      [k] perf_iterate_sb
     0.00%  swapper          [kernel.vmlinux]                                      [k] get_cpu_device
     0.00%  perf             [kernel.vmlinux]                                      [k] xas_start
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000098fea5
     0.00%  perf             [kernel.vmlinux]                                      [k] mark_buffer_dirty
     0.00%  containerd       containerd                                            [.] runtime.cleantimers
     0.00%  bench            [kernel.vmlinux]                                      [k] __cond_resched
     0.00%  kworker/2:2-eve  [drm_kms_helper]                                      [k] 0x00000000000008eb
     0.00%  kworker/2:2-eve  [raid6_pq]                                            [k] 0x000000000000c24b
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000064ea79
     0.00%  perf             [kernel.vmlinux]                                      [k] cpu_util
     0.00%  swapper          [kernel.vmlinux]                                      [k] asm_common_interrupt
     0.00%  perf             [kernel.vmlinux]                                      [k] __filemap_add_folio
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000007d1eab
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051a45f
     0.00%  perf             [kernel.vmlinux]                                      [k] ext4_es_lookup_extent
     0.00%  swapper          [kernel.vmlinux]                                      [k] __flush_smp_call_function_queue
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000519af6
     0.00%  swapper          [kernel.vmlinux]                                      [k] refresh_cpu_vm_stats
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000477759
     0.00%  perf-exec        [kernel.vmlinux]                                      [k] kmem_cache_free
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000539303
     0.00%  kworker/2:2-eve  [drm]                                                 [k] 0x0000000000020c1c
     0.00%  swapper          [kernel.vmlinux]                                      [k] asm_sysvec_apic_timer_interrupt
     0.00%  bench            [kernel.vmlinux]                                      [k] alloc_pages_mpol_noprof
     0.00%  bench            [kernel.vmlinux]                                      [k] filemap_map_pages
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000477767
     0.00%  swapper          [kernel.vmlinux]                                      [k] update_load_avg
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000045d3d6
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051d905
     0.00%  kworker/2:2-eve  [drm_kms_helper]                                      [k] 0x0000000000004ae8
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] __mod_memcg_lruvec_state
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] bio_associate_blkg
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000004916dd
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000465ecb
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000004b780a
     0.00%  swapper          [kernel.vmlinux]                                      [k] sysvec_call_function
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051e764
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000064ed72
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051c7bf
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000064ebe0
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000523fba
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000832660
     0.00%  swapper          [kernel.vmlinux]                                      [k] acpi_idle_do_entry
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000097ddfc
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000045d334
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] soft_cursor
     0.00%  perf             [kernel.vmlinux]                                      [k] sched_balance_rq
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] __fprop_add_percpu
     0.00%  swapper          [kernel.vmlinux]                                      [k] rb_next
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000977ece
     0.00%  perf             [kernel.vmlinux]                                      [k] __folio_mark_dirty
     0.00%  perf             [kernel.vmlinux]                                      [k] filemap_alloc_folio_noprof
     0.00%  perf             [kernel.vmlinux]                                      [k] get_mem_cgroup_from_mm
     0.00%  perf             [kernel.vmlinux]                                      [k] ext4_da_reserve_space
     0.00%  perf             [kernel.vmlinux]                                      [k] read_hpet
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051cd3e
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000532f0f
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] __mod_node_page_state
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] mod_objcg_state
     0.00%  jbd2/dm-0-8      [kernel.vmlinux]                                      [k] dm_submit_bio
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000517b6d
     0.00%  kcompactd0       [kernel.vmlinux]                                      [k] idle_cpu
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] free_tail_page_prepare
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000002f7f65
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_program_event
     0.00%  containerd       [kernel.vmlinux]                                      [k] psi_group_change
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000053776f
     0.00%  swapper          [kernel.vmlinux]                                      [k] srso_return_thunk
     0.00%  perf             [kernel.vmlinux]                                      [k] ext4_claim_free_clusters
     0.00%  perf             [kernel.vmlinux]                                      [k] generic_perform_write
     0.00%  perf             [kernel.vmlinux]                                      [k] mem_cgroup_commit_charge
     0.00%  perf             [kernel.vmlinux]                                      [k] file_modified
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051e779
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000053974c
     0.00%  perf             [kernel.vmlinux]                                      [k] ext4_da_write_begin
     0.00%  perf             [kernel.vmlinux]                                      [k] filemap_add_folio
     0.00%  perf             libc.so.6                                             [.] write
     0.00%  perf             [kernel.vmlinux]                                      [k] __es_remove_extent
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000052244a
     0.00%  swapper          [kernel.vmlinux]                                      [k] ct_nmi_exit
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000034bee5
     0.00%  kworker/2:2-eve  [kernel.vmlinux]                                      [k] __rcu_read_lock
     0.00%  perf             [kernel.vmlinux]                                      [k] __dquot_alloc_space
     0.00%  swapper          [kernel.vmlinux]                                      [k] native_read_msr
     0.00%  perf             [kernel.vmlinux]                                      [k] folio_unlock
     0.00%  perf             [kernel.vmlinux]                                      [k] radix_tree_node_ctor
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000006c5b82
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000527259
     0.00%  perf             [kernel.vmlinux]                                      [k] __mod_node_page_state
     0.00%  perf             [kernel.vmlinux]                                      [k] __radix_tree_lookup
     0.00%  kworker/u65:2-e  [kernel.vmlinux]                                      [k] __rcu_read_unlock
     0.00%  perf             [kernel.vmlinux]                                      [k] ext4_get_reserved_space
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_cancel
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000004ba8ce
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000126f3a
     0.00%  perf             perf                                                  [.] perf_cpu_map__idx
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_balance_update_blocked_averages
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] do_timerfd_settime
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000097ddc5
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000097e5a4
     0.00%  perf             [kernel.vmlinux]                                      [k] folio_batch_move_lru
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000046f8a5
     0.00%  perf             [kernel.vmlinux]                                      [k] xas_nomem
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051d24c
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000097df7c
     0.00%  tuned            [kernel.vmlinux]                                      [k] psi_task_switch
     0.00%  swapper          [kernel.vmlinux]                                      [k] __dequeue_entity
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000006e7c5d
     0.00%  swapper          [kernel.vmlinux]                                      [k] rcu_preempt_deferred_qs
     0.00%  kworker/7:1-eve  [kernel.vmlinux]                                      [k] __free_one_page
     0.00%  swapper          [kernel.vmlinux]                                      [k] memchr_inv
     0.00%  perf             [kernel.vmlinux]                                      [k] psi_task_switch
     0.00%  swapper          [kernel.vmlinux]                                      [k] _nohz_idle_balance.isra.0
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000009a6fbd
     0.00%  swapper          [kernel.vmlinux]                                      [k] acpi_idle_enter
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000456a9f
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000004ac642
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000477888
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000529a52
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000004b36d2
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000525b33
     0.00%  swapper          [kernel.vmlinux]                                      [k] tmigr_active_up
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000452444
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000046f865
     0.00%  swapper          [kernel.vmlinux]                                      [k] next_timer_interrupt
     0.00%  kworker/6:1-eve  [kernel.vmlinux]                                      [k] __free_pages_ok
     0.00%  perf             [kernel.vmlinux]                                      [k] exc_page_fault
     0.00%  swapper          [kernel.vmlinux]                                      [k] __schedule
     0.00%  irqbalance       [kernel.vmlinux]                                      [k] __kmalloc_cache_noprof
     0.00%  swapper          [kernel.vmlinux]                                      [k] cpuidle_not_available
     0.00%  containerd       [kernel.vmlinux]                                      [k] pick_next_task_fair
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x00000000009a70b7
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_nohz_next_event
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_check_oneshot_broadcast_this_cpu
     0.00%  swapper          [kernel.vmlinux]                                      [k] irq_chip_ack_parent
     0.00%  irqbalance       [kernel.vmlinux]                                      [k] show_stat
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000004b8295
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000045d385
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_nohz_idle_stop_tick
     0.00%  containerd       [kernel.vmlinux]                                      [k] __schedule
     0.00%  swapper          [kernel.vmlinux]                                      [k] switch_mm_irqs_off
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000461a21
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x000000000051d7c2
     0.00%  swapper          [kernel.vmlinux]                                      [k] try_to_wake_up
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000051e7cf
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000064ed4e
     0.00%  perf             [kernel.vmlinux]                                      [k] perf_mmap_to_page
     0.00%  migration/7      [kernel.vmlinux]                                      [k] update_sd_lb_stats.constprop.0
     0.00%  irqbalance       [kernel.vmlinux]                                      [k] __rcu_read_lock
     0.00%  migration/3      [kernel.vmlinux]                                      [k] __update_load_avg_cfs_rq
     0.00%  swapper          [br_netfilter]                                        [k] 0x0000000000000775
     0.00%  bench            [kernel.vmlinux]                                      [k] remove_vma
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_clock_noinstr
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x0000000000529169
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000000df07
     0.00%  swapper          [kernel.vmlinux]                                      [k] __switch_to
     0.00%  swapper          [kernel.vmlinux]                                      [k] place_entity
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x000000000097dd9a
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000006e7c5a
     0.00%  irqbalance       [kernel.vmlinux]                                      [k] __rcu_read_unlock
     0.00%  migration/6      [kernel.vmlinux]                                      [k] enqueue_entity
     0.00%  swapper          [kernel.vmlinux]                                      [k] __update_load_avg_cfs_rq
     0.00%  perf             [kernel.vmlinux]                                      [k] event_function
     0.00%  perf             [kernel.vmlinux]                                      [k] do_user_addr_fault
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x000000000064eaee
     0.00%  migration/4      [kernel.vmlinux]                                      [k] __update_load_avg_cfs_rq
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000006e79ff
     0.00%  containerd       [kernel.vmlinux]                                      [k] schedule_hrtimeout_range_clock
     0.00%  irqbalance       [kernel.vmlinux]                                      [k] security_file_open
     0.00%  perf             [kernel.vmlinux]                                      [k] _find_next_and_bit
     0.00%  multipathd       [kernel.vmlinux]                                      [k] __rseq_handle_notify_resume
     0.00%  swapper          [kernel.vmlinux]                                      [k] __x86_indirect_thunk_r12
     0.00%  swapper          [kernel.vmlinux]                                      [k] rcu_note_context_switch
     0.00%  bench            [kernel.vmlinux]                                      [k] free_unref_folios
     0.00%  migration/0      [kernel.vmlinux]                                      [k] migration_cpu_stop
     0.00%  migration/1      [kernel.vmlinux]                                      [k] rcu_note_context_switch
     0.00%  kworker/u66:1-e  [kernel.vmlinux]                                      [k] n_tty_receive_buf2
     0.00%  swapper          [kernel.vmlinux]                                      [k] __common_interrupt
     0.00%  swapper          [drm]                                                 [k] 0x000000000003d658
     0.00%  migration/5      [kernel.vmlinux]                                      [k] psi_group_change
     0.00%  swapper          [kernel.vmlinux]                                      [k] clockevents_program_event
     0.00%  swapper          [kernel.vmlinux]                                      [k] __x86_indirect_thunk_array
     0.00%  perf             [kernel.vmlinux]                                      [k] set_pte_range
     0.00%  perf             [kernel.vmlinux]                                      [k] __schedule
     0.00%  swapper          [kernel.vmlinux]                                      [k] __update_load_avg_se
     0.00%  swapper          [kernel.vmlinux]                                      [k] asm_sysvec_reschedule_ipi
     0.00%  swapper          [kernel.vmlinux]                                      [k] local_clock_noinstr
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_nohz_stop_idle
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000044a039
     0.00%  kworker/4:1-mm_  [kernel.vmlinux]                                      [k] native_queued_spin_lock_slowpath
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] __update_idle_core
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] pick_next_task_fair
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] prepare_to_swait_event
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] sched_balance_rq
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] update_rq_clock
     0.00%  rs:main Q:Reg    [kernel.vmlinux]                                      [k] ext4_inode_csum
     0.00%  swapper          [kernel.vmlinux]                                      [k] tmigr_inactive_up
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_forward
     0.00%  swapper          [kernel.vmlinux]                                      [k] cpuidle_reflect
     0.00%  perf             [kernel.vmlinux]                                      [k] percpu_counter_add_batch
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000031e745
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_idle_set_state
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x000000000045675c
     0.00%  kworker/6:1-eve  [amdgpu]                                              [k] 0x000000000051cbb1
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000002dce5
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] __ext4_ext_check
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_core_idle_cpu
     0.00%  swapper          [drm]                                                 [k] 0x000000000003de52
     0.00%  swapper          [kernel.vmlinux]                                      [k] __msecs_to_jiffies
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000046f9c4
     0.00%  swapper          [kernel.vmlinux]                                      [k] call_cpuidle
     0.00%  swapper          [kernel.vmlinux]                                      [k] cpuidle_governor_latency_req
     0.00%  kworker/7:1-eve  [kernel.vmlinux]                                      [k] __switch_to_asm
     0.00%  dockerd          [kernel.vmlinux]                                      [k] apparmor_file_permission
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000126f37
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000003218b6
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000006e8d65
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000096f62d
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] __es_tree_search.isra.0
     0.00%  swapper          [kernel.vmlinux]                                      [k] update_group_capacity
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x00000000005225c3
     0.00%  kworker/2:2-eve  [amdgpu]                                              [k] 0x0000000000990c4f
     0.00%  swapper          [kernel.vmlinux]                                      [k] timer_base_try_to_set_idle
     0.00%  swapper          [kernel.vmlinux]                                      [k] ct_idle_exit
     0.00%  swapper          [kernel.vmlinux]                                      [k] __x86_indirect_thunk_rbx
     0.00%  swapper          [kernel.vmlinux]                                      [k] fast_mix
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_clock_idle_sleep_event
     0.00%  swapper          [kernel.vmlinux]                                      [k] touch_softlockup_watchdog_sched
     0.00%  containerd       [kernel.vmlinux]                                      [k] psi_task_switch
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000123820
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_clock
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000002f46a5
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000449ff5
     0.00%  containerd       [kernel.vmlinux]                                      [k] _copy_to_user
     0.00%  swapper          [kernel.vmlinux]                                      [k] enqueue_task
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000096f625
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000006e7c66
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_interrupt
     0.00%  swapper          [kernel.vmlinux]                                      [k] irq_enter_rcu
     0.00%  perf             [kernel.vmlinux]                                      [k] _raw_spin_lock_irqsave
     0.00%  perf             [kernel.vmlinux]                                      [k] poll_freewait
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] __rcu_read_lock
     0.00%  swapper          [kernel.vmlinux]                                      [k] wake_q_add
     0.00%  kworker/7:1H-kb  [kernel.vmlinux]                                      [k] __switch_to_asm
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000002f8058
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_clock_tick
     0.00%  swapper          [kernel.vmlinux]                                      [k] slab_update_freelist.constprop.0.isra.0
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_nohz_get_next_hrtimer
     0.00%  swapper          [kernel.vmlinux]                                      [k] ct_kernel_enter_state
     0.00%  swapper          [kernel.vmlinux]                                      [k] hrtimer_next_event_without
     0.00%  swapper          [kernel.vmlinux]                                      [k] resched_curr
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000003a55
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000045d3df
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000098aeb9
     0.00%  containerd       [kernel.vmlinux]                                      [k] __switch_to
     0.00%  swapper          [kernel.vmlinux]                                      [k] rcu_sched_clock_irq
     0.00%  kworker/9:1-eve  [kernel.vmlinux]                                      [k] sched_clock_cpu
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000124ef5
     0.00%  containerd       [kernel.vmlinux]                                      [k] update_curr
     0.00%  swapper          [drm]                                                 [k] 0x0000000000035f4e
     0.00%  swapper          [kernel.vmlinux]                                      [k] tmigr_update_events
     0.00%  swapper          [kernel.vmlinux]                                      [k] profile_pc
     0.00%  swapper          [nvme]                                                [k] 0x0000000000004315
     0.00%  swapper          [kernel.vmlinux]                                      [k] raw_spin_rq_unlock
     0.00%  containerd       [kernel.vmlinux]                                      [k] posix_get_monotonic_timespec
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000002f4b
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000034bf25
     0.00%  perf             [kernel.vmlinux]                                      [k] get_page_from_freelist
     0.00%  rcu_preempt      [kernel.vmlinux]                                      [k] __mod_timer
     0.00%  perf             [kernel.vmlinux]                                      [k] mutex_unlock
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000460f85
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000977ec5
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000977ed6
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_clock_idle_wakeup_event
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000124016
     0.00%  swapper          [kernel.vmlinux]                                      [k] pick_next_task_fair
     0.00%  swapper          [raid6_pq]                                            [k] 0x000000000001acf5
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000977ec6
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] security_inode_setattr
     0.00%  swapper          [kernel.vmlinux]                                      [k] __sysvec_apic_timer_interrupt
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000461985
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000123825
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000126ee9
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000096f6cd
     0.00%  perf             [kernel.vmlinux]                                      [k] do_syscall_64
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] unmap_mapping_range
     0.00%  systemd-journal  libc.so.6                                             [.] 0x0000000000090a64
     0.00%  containerd       [kernel.vmlinux]                                      [k] dequeue_entity
     0.00%  systemd-journal  [kernel.vmlinux]                                      [k] dax_layout_busy_page
     0.00%  swapper          [kernel.vmlinux]                                      [k] apic_ack_irq
     0.00%  swapper          [drm]                                                 [k] 0x000000000003d83b
     0.00%  containerd       [kernel.vmlinux]                                      [k] __futex_queue
     0.00%  swapper          [kernel.vmlinux]                                      [k] complete_all
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000098b0d6
     0.00%  swapper          [kernel.vmlinux]                                      [k] can_stop_idle_tick
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000000dee5
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000044ecef
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000000dee6
     0.00%  migration/14     [kernel.vmlinux]                                      [k] update_curr_common
     0.00%  rs:main Q:Reg    [kernel.vmlinux]                                      [k] ext4_get_group_desc
     0.00%  swapper          [kernel.vmlinux]                                      [k] tick_do_update_jiffies64
     0.00%  swapper          [kernel.vmlinux]                                      [k] tmigr_cpu_new_timer
     0.00%  kworker/7:1-eve  [kernel.vmlinux]                                      [k] free_pcppages_bulk
     0.00%  dockerd          [kernel.vmlinux]                                      [k] srso_untrain_ret
     0.00%  dockerd          [kernel.vmlinux]                                      [k] update_curr
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000124f0c
     0.00%  swapper          [drm]                                                 [k] 0x000000000003f455
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000003218b5
     0.00%  swapper          [kernel.vmlinux]                                      [k] ct_irq_enter
     0.00%  swapper          [kernel.vmlinux]                                      [k] ct_irq_exit
     0.00%  swapper          [kernel.vmlinux]                                      [k] blk_stat_add
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000006e8dd0
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000124f4c
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000098aef6
     0.00%  swapper          [drm]                                                 [k] 0x000000000003f468
     0.00%  swapper          [kernel.vmlinux]                                      [k] nohz_balance_enter_idle
     0.00%  swapper          [kernel.vmlinux]                                      [k] __wake_up_common
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000001240ea
     0.00%  swapper          [kernel.vmlinux]                                      [k] __wake_up
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000002f7f81
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000046f97f
     0.00%  swapper          [drm]                                                 [k] 0x000000000003f45c
     0.00%  swapper          [kernel.vmlinux]                                      [k] __mod_memcg_lruvec_state
     0.00%  swapper          [kernel.vmlinux]                                      [k] mempool_free_slab
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000977ef0
     0.00%  swapper          [kernel.vmlinux]                                      [k] x86_pmu_disable_all
     0.00%  swapper          [amdgpu]                                              [k] 0x00000000002f7f71
     0.00%  kworker/3:1H-kb  [kernel.vmlinux]                                      [k] read_hpet
     0.00%  swapper          [kernel.vmlinux]                                      [k] psi_task_change
     0.00%  swapper          [kernel.vmlinux]                                      [k] perf_adjust_freq_unthr_context
     0.00%  swapper          [kernel.vmlinux]                                      [k] account_idle_ticks
     0.00%  swapper          [amdgpu]                                              [k] 0x000000000045d365
     0.00%  swapper          [kernel.vmlinux]                                      [k] ttwu_do_activate
     0.00%  swapper          [raid6_pq]                                            [k] 0x000000000001acc5
     0.00%  swapper          [kernel.vmlinux]                                      [k] enqueue_entity
     0.00%  wpa_supplicant   [kernel.vmlinux]                                      [k] read_hpet
     0.00%  swapper          [amdgpu]                                              [k] 0x0000000000012205
     0.00%  swapper          [drm]                                                 [k] 0x000000000003d649
     0.00%  containerd       [kernel.vmlinux]                                      [k] __update_load_avg_se
     0.00%  rs:main Q:Reg    [kernel.vmlinux]                                      [k] futex_wake
     0.00%  swapper          [kernel.vmlinux]                                      [k] __x86_indirect_thunk_r13
     0.00%  swapper          [kernel.vmlinux]                                      [k] sched_balance_softirq
     0.00%  swapper          [kernel.vmlinux]                                      [k] timerqueue_del
     0.00%  swapper          [kernel.vmlinux]                                      [k] cpu_util


#
# (Tip: Limit to show entries above 5% only: perf report --percent-limit 5)
#

