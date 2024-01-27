Return-Path: <bpf+bounces-20490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32983EF87
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F942858B4
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452F2CCBA;
	Sat, 27 Jan 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLXKykLi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3A208AF;
	Sat, 27 Jan 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381053; cv=none; b=iWjZUgaoRMlUSShXl4eRw54puSuXBbfNyzdFHGcOWG88V+h41PB4YH5EWfbqzpvyuoYo5RCvJvNdfub7eq4t7Nbs4PnfHLwo8eOT9L+w2KVM1UTtkn7Kvojz59KXhXKk7ujIpJk9//4nSNrh6YEoIAgJX7VG2pa9HbDutOOZFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381053; c=relaxed/simple;
	bh=GElK1AZbMR4Pgp/q2KRnIcjOZnb3fuvbBre+H/w+UnM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbhKr050OlW6hxvFVWNzXB72VOGKCu63+bRZeZGVxMxtIAAYGJwsCu9dxyXDjclg8kEiVfZjxCehnn31dSKoDqJ2zyMqEQvLVXz1/vkMaGCLQtgl7ktRCH8i3U3fP+e/6VJ7Vg9VZgjkRHMuT3RqhnHVpD29td5qGlhiisXyj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLXKykLi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5100cb238bcso2502436e87.3;
        Sat, 27 Jan 2024 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706381049; x=1706985849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hg0lvZospejk9tHUjx9ZrHRaZCQpEj84IVdOdBRIV3s=;
        b=HLXKykLixkh6zHBUGLV3HOKgPFNqzZrOyZ1SPJ8xeq7AUgqFKmJNb1OLBPP8XidFMw
         0y4tP8MlI/yRWldwRRjpblvdx45gxDIJlxy7hqg7DfO8jLepaD8oAJKWb5kBSrYKXz+3
         uqB4E/dnECO8FKPjQbWd81L/LcEHJRC0pxaxWyjBB+AOyC8+rTCwBfTn+FlWfoKrz9fQ
         1N9vAy840oH10TMamsn8FdEk3Sx0kc1qoYSm7rA3AH1+cMxYPqbJ894uTy2RMMj8NWQY
         wOgyctJ+8J0qvgEPZ0qbD3jWJ5icQVO5FjTQO2iB1XmJaYsLkF3z1s8DOvW+E63HpiTN
         3iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706381049; x=1706985849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg0lvZospejk9tHUjx9ZrHRaZCQpEj84IVdOdBRIV3s=;
        b=mmMSH4ZJwxVwS2/E6LbwYWqW78TyJAdWskZmhhVQF6iroPvTByBiL7zGz9TSgsnWMO
         u8ViBv/QDuSV35za5rGvnxzdMcw1c9R2UhBdODfYctUZhLE5tnYfPYNljUfG0J+XhPBS
         NwermKW/JQBFIoN8ZfHXLmjn8EKOskTB2j76c0jVT4Ug6IcrNz/y7uWiu+u+9/cESElf
         sbZsia9OCJIWPgyl9GiSirXBetN2bsAmRSn2RcZQAjVYUxvuDJLChJfFSQKLzXGfQVOr
         dNNfUeeTXq/Q8mm+q5bDgX/CbDdge3Rb7c+d8g0I8J1IRrCdOQf0qd5VWbjJL7dD8oTH
         AxVQ==
X-Gm-Message-State: AOJu0YxJyQ+IFIXaMTtK2puaFZTBEhWjA9o6peLMvE6hJXfl8YIvuYuK
	957RRc1mAv9OrtqUI3d5vx6/sPxIpvhvz2DsHOkRl5wuLqFSXfyF
X-Google-Smtp-Source: AGHT+IEGDm1explkpK9ffHmdvNrlMIOKNEv/wnCROktaLRIE9/uf9Vnx72FGTNFylnIQ3V+JA+1sXg==
X-Received: by 2002:a05:6512:10c2:b0:510:1487:bcb with SMTP id k2-20020a05651210c200b0051014870bcbmr1353149lfg.64.1706381049145;
        Sat, 27 Jan 2024 10:44:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id wn9-20020a170907068900b00a2c869c2fe8sm1974390ejb.161.2024.01.27.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 10:44:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 27 Jan 2024 19:44:06 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [PATCH v6 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
Message-ID: <ZbVO9oKa7Ti-EvAa@krava>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
 <ZbJ2PfSt3RM3pm43@krava>
 <20240127001405.c031ad1d7ab37089b563371b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127001405.c031ad1d7ab37089b563371b@kernel.org>

On Sat, Jan 27, 2024 at 12:14:05AM +0900, Masami Hiramatsu wrote:
> On Thu, 25 Jan 2024 15:54:53 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Fri, Jan 12, 2024 at 07:10:50PM +0900, Masami Hiramatsu (Google) wrote:
> > > Hi,
> > > 
> > > Here is the 6th version of the series to re-implement the fprobe on
> > > function-graph tracer. The previous version is;
> > > 
> > > https://lore.kernel.org/all/170290509018.220107.1347127510564358608.stgit@devnote2/
> > > 
> > > This version fixes use-after-unregister bug and arm64 stack unwinding
> > > bug [13/36], add an improvement for multiple interrupts during push
> > > operation[20/36], keep SAVE_REGS until BPF and fprobe_event using
> > > ftrace_regs[26/36], also reorder the patches[30/36][31/36] so that new
> > > fprobe can switch to SAVE_ARGS[32/36] safely.
> > > This series also temporarily adds a DIRECT_CALLS bugfix[1/36], which
> > > should be pushed separatedly as a stable bugfix.
> > > 
> > > There are some TODOs:
> > >  - Add s390x and loongarch support to fprobe (multiple fgraph).
> > >  - Fix to get the symbol address from ftrace entry address on arm64.
> > >    (This should be done in BPF trace event)
> > >  - Cleanup code, rename some terms(offset/index) and FGRAPH_TYPE_BITMAP
> > >    part should be merged to FGRAPH_TYPE_ARRAY patch.
> > 
> > hi,
> > I'm getting kasan bugs below when running bpf selftests on top of this
> > patchset.. I think it's probably the reason I see failures in some bpf
> > kprobe_multi/fprobe tests
> > 
> > so far I couldn't find the reason.. still checking ;-)
> 
> Thanks for reporting! Have you built the kernel with debuginfo? In that
> case, can you decode the line from the address?
> 
> $ eu-addr2line -fi -e vmlinux ftrace_push_return_trace.isra.0+0x346
> 
> This helps me a lot.

I had to recompile/regenerate the fault, it points in here:

        ffffffff8149b390 <ftrace_push_return_trace.isra.0>:    
        ...

                        current->ret_stack[rindex - 1] = val;  
        ffffffff8149b6b1:       48 8d bd 78 28 00 00    lea    0x2878(%rbp),%rdi
        ffffffff8149b6b8:       e8 63 e4 28 00          call   ffffffff81729b20 <__asan_load8>
        ffffffff8149b6bd:       48 8b 95 78 28 00 00    mov    0x2878(%rbp),%rdx
        ffffffff8149b6c4:       41 8d 47 ff             lea    -0x1(%r15),%eax
        ffffffff8149b6c8:       48 98                   cltq
        ffffffff8149b6ca:       4c 8d 24 c2             lea    (%rdx,%rax,8),%r12
        ffffffff8149b6ce:       4c 89 e7                mov    %r12,%rdi
        ffffffff8149b6d1:       e8 ea e4 28 00          call   ffffffff81729bc0 <__asan_store8>
--->    ffffffff8149b6d6:       49 89 1c 24             mov    %rbx,(%r12)
                        current->curr_ret_stack = index = rindex;
        ffffffff8149b6da:       48 8d bd 6c 28 00 00    lea    0x286c(%rbp),%rdi
        ffffffff8149b6e1:       e8 9a e3 28 00          call   ffffffff81729a80 <__asan_store4>
        ffffffff8149b6e6:       44 89 bd 6c 28 00 00    mov    %r15d,0x286c(%rbp)
        ffffffff8149b6ed:       e9 8d fd ff ff          jmp    ffffffff8149b47f <ftrace_push_return_trace.isra.0+0xef>
                if (WARN_ON_ONCE(idx <= 0))      


the dump is attached below (same address as in previous email)

jirka


---
[  360.152200][    C3] BUG: KASAN: slab-out-of-bounds in ftrace_push_return_trace.isra.0+0x346/0x370
[  360.153195][    C3] Write of size 8 at addr ffff8881a0e10ff8 by task kworker/3:4/728
[  360.154101][    C3] 
[  360.154414][    C3] CPU: 3 PID: 728 Comm: kworker/3:4 Tainted: G           OE      6.7.0+ #316 c9b0d53b3491b547d06b6b50629b74711600ddc9
[  360.155679][    C3] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  360.156611][    C3] Workqueue: events free_obj_work
[  360.157175][    C3] Call Trace:
[  360.157561][    C3]  <IRQ>
[  360.157904][    C3]  dump_stack_lvl+0xf6/0x180
[  360.158404][    C3]  print_report+0xc4/0x610
[  360.158853][    C3]  ? lock_release+0xba/0x760
[  360.159375][    C3]  ? __phys_addr+0x5/0x80
[  360.159872][    C3]  ? __phys_addr+0x33/0x80
[  360.161309][    C3]  kasan_report+0xbe/0xf0
[  360.161940][    C3]  ? ftrace_push_return_trace.isra.0+0x346/0x370
[  360.162817][    C3]  ? ftrace_push_return_trace.isra.0+0x346/0x370
[  360.163518][    C3]  ? __pfx_kernel_text_address+0x10/0x10
[  360.164152][    C3]  ? __kernel_text_address+0xe/0x40
[  360.164715][    C3]  ftrace_push_return_trace.isra.0+0x346/0x370
[  360.165324][    C3]  ? __pfx_kernel_text_address+0x10/0x10
[  360.165940][    C3]  function_graph_enter_ops+0xbb/0x2d0
[  360.166555][    C3]  ? __kernel_text_address+0xe/0x40
[  360.167134][    C3]  ? __pfx_function_graph_enter_ops+0x10/0x10
[  360.167801][    C3]  ? __pfx_function_graph_enter_ops+0x10/0x10
[  360.168454][    C3]  ? __pfx___kernel_text_address+0x10/0x10
[  360.169086][    C3]  ? __pfx_unwind_get_return_address+0x10/0x10
[  360.169781][    C3]  ftrace_graph_func+0x142/0x270
[  360.170341][    C3]  ? __pfx_kernel_text_address+0x10/0x10
[  360.170960][    C3]  ? orc_find.part.0+0x5/0x250
[  360.171514][    C3]  0xffffffffa0568097
[  360.171990][    C3]  ? 0xffffffffa0568097
[  360.172463][    C3]  ? preempt_count_sub+0x5/0xc0
[  360.172948][    C3]  ? unwind_get_return_address+0x2a/0x50
[  360.173512][    C3]  ? unwind_get_return_address+0xf/0x50
[  360.174068][    C3]  ? orc_find.part.0+0x5/0x250
[  360.174535][    C3]  ? kernel_text_address+0x5/0x130
[  360.175094][    C3]  ? __kernel_text_address+0x5/0x40
[  360.175623][    C3]  kernel_text_address+0x5/0x130
[  360.176118][    C3]  __kernel_text_address+0xe/0x40
[  360.176625][    C3]  unwind_get_return_address+0x33/0x50
[  360.177160][    C3]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  360.177805][    C3]  arch_stack_walk+0x9e/0xf0
[  360.178319][    C3]  ? orc_find.part.0+0x5/0x250
[  360.178821][    C3]  ? rcu_do_batch+0x396/0xb10
[  360.179305][    C3]  stack_trace_save+0x91/0xd0
[  360.179807][    C3]  ? __pfx_stack_trace_save+0x10/0x10
[  360.180389][    C3]  ? stack_trace_save+0x5/0xd0
[  360.180908][    C3]  kasan_save_stack+0x1c/0x40
[  360.181419][    C3]  ? kasan_save_stack+0x1c/0x40
[  360.181948][    C3]  ? kasan_save_track+0x10/0x30
[  360.182531][    C3]  ? kasan_save_free_info+0x3b/0x60
[  360.183157][    C3]  ? __kasan_slab_free+0x122/0x1c0
[  360.183713][    C3]  ? kmem_cache_free+0x19d/0x460
[  360.184241][    C3]  ? rcu_do_batch+0x396/0xb10
[  360.184781][    C3]  ? rcu_core+0x3b2/0x5f0
[  360.185289][    C3]  ? __do_softirq+0x13b/0x64d
[  360.185814][    C3]  ? __irq_exit_rcu+0xe4/0x190
[  360.186366][    C3]  ? irq_exit_rcu+0xa/0x30
[  360.186869][    C3]  ? sysvec_call_function+0x8f/0xb0
[  360.187479][    C3]  ? asm_sysvec_call_function+0x16/0x20
[  360.188098][    C3]  ? ftrace_push_return_trace.isra.0+0x12c/0x370
[  360.188784][    C3]  ? function_graph_enter_ops+0xbb/0x2d0
[  360.189413][    C3]  ? ftrace_graph_func+0x142/0x270
[  360.189985][    C3]  ? 0xffffffffa0568097
[  360.191352][    C3]  ? function_graph_enter_ops+0x2b9/0x2d0
[  360.192148][    C3]  ? __kasan_slab_free+0x3b/0x1c0
[  360.192852][    C3]  ? __pfx_function_graph_enter_ops+0x10/0x10
[  360.193545][    C3]  ? __pfx___phys_addr+0x10/0x10
[  360.194115][    C3]  ? lockdep_hardirqs_on_prepare+0xe/0x250
[  360.194778][    C3]  ? preempt_count_sub+0x5/0xc0
[  360.195373][    C3]  ? ftrace_graph_func+0x173/0x270
[  360.195937][    C3]  ? __pfx___phys_addr+0x10/0x10
[  360.196461][    C3]  ? rcu_do_batch+0x396/0xb10
[  360.196972][    C3]  ? 0xffffffffa0568097
[  360.197481][    C3]  ? __pfx___debug_check_no_obj_freed+0x10/0x10
[  360.198175][    C3]  ? 0xffffffffa0568097
[  360.198675][    C3]  ? lock_acquire+0xc6/0x490
[  360.199247][    C3]  kasan_save_track+0x10/0x30
[  360.199803][    C3]  kasan_save_free_info+0x3b/0x60
[  360.200474][    C3]  __kasan_slab_free+0x122/0x1c0
[  360.201078][    C3]  ? rcu_do_batch+0x396/0xb10
[  360.201567][    C3]  kmem_cache_free+0x19d/0x460
[  360.202093][    C3]  ? __pfx_free_object_rcu+0x10/0x10
[  360.202658][    C3]  rcu_do_batch+0x396/0xb10
[  360.203193][    C3]  ? __pfx_rcu_do_batch+0x10/0x10
[  360.203765][    C3]  ? sched_clock+0xc/0x30
[  360.204250][    C3]  ? rcu_is_watching+0x34/0x60
[  360.204758][    C3]  rcu_core+0x3b2/0x5f0
[  360.205245][    C3]  ? rcu_is_watching+0x34/0x60
[  360.205745][    C3]  __do_softirq+0x13b/0x64d
[  360.206260][    C3]  __irq_exit_rcu+0xe4/0x190
[  360.206802][    C3]  irq_exit_rcu+0xa/0x30
[  360.207334][    C3]  sysvec_call_function+0x8f/0xb0
[  360.207929][    C3]  </IRQ>
[  360.208330][    C3]  <TASK>
[  360.208687][    C3]  asm_sysvec_call_function+0x16/0x20

