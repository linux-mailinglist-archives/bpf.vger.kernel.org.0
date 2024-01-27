Return-Path: <bpf+bounces-20447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C565783E8C7
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABDD1C22E62
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A4D3C13;
	Sat, 27 Jan 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUfcflz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733A257B;
	Sat, 27 Jan 2024 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317003; cv=none; b=LOCCX0vUqqHblL3JieHrYNJVxl+P9QMUY8OBrjnWMCeCEEUHHk9HxBjD+30hutqDoh0s/730ejRTvADK3vCdeH13j4G+3MHQHJyn8SIIfWqub+PdShtFvzT3Oozgtdu61l7X1nbq3d6V/ofC4vst2DuOupZvH9b4NjtKNKy8KAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317003; c=relaxed/simple;
	bh=c8COHrW/vXgxaIDibQy9jnNeGBSz5ywxyxsaGcsZXH4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O060fS7Zm8qPaz93SpvZ/I56xtoLNOczGW2ISjIzWoeSKik3Ao69gj6uj6iWTjjkzdL45DsvVfA14AFJkBSsjUwgrcmJ2BwFQN10Ddj+ln/tFVwnRfOvSL6XowCkZ2h5goPZ7mK74y7237br0Pvl1t808Dm7cSZ+CwvwenopyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUfcflz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F9C433C7;
	Sat, 27 Jan 2024 00:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706317003;
	bh=c8COHrW/vXgxaIDibQy9jnNeGBSz5ywxyxsaGcsZXH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aUfcflz8s6HlzTH9lrclPKX5TkUrW0Ou8ZMsMOsvFzUGlHZK49t759f3XYHS3nF/o
	 8csEAcfZDw65zBLcdZ0HUBOXxJ2+IL3x3J5IEoJDZ/gEnPhXfA4/H16MImUkQEi7b0
	 N4RmA3Q7YcLr5+Ex/koP7BA5qdVMnshYGNM3MYiRXSV+uJrJyMM7PMDWfax4LsIS75
	 bcE31tJ03K8R9/OSCzdOj8mi3j0Ce0Bz8CMbu3sSfqiJnHFhtdNHuKrcK5WXN3p2ns
	 hdYMlHUCx6xd/v/faUxJA/4yT7sJa0nota5Lpn6Zdk3XZPcJGioTfGpsEObrk94ycj
	 5Y3XfZ1iTWReA==
Date: Sat, 27 Jan 2024 09:56:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v6 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240127095636.b248dbd64b2a9722457e6fcc@kernel.org>
In-Reply-To: <20240127001405.c031ad1d7ab37089b563371b@kernel.org>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
	<ZbJ2PfSt3RM3pm43@krava>
	<20240127001405.c031ad1d7ab37089b563371b@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 00:14:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

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

I also got the same KASAN error from intel's test bot:

https://lore.kernel.org/all/202401172217.36e37075-oliver.sang@intel.com/

And another one (it should be different one)

https://lore.kernel.org/all/202401172200.c8731564-oliver.sang@intel.com/

This is a selftest failure on i386. I might break something on 32bit.
Let me check.

Thank you,


> 
> Thank you,
> 
> > 
> > jirka
> > 
> > 
> > ---
> > [  507.585913][  T697] BUG: KASAN: slab-out-of-bounds in ftrace_push_return_trace.isra.0+0x346/0x370
> > [  507.586747][  T697] Write of size 8 at addr ffff888148193ff8 by task test_progs/697
> > [  507.587460][  T697] 
> > [  507.587713][  T697] CPU: 2 PID: 697 Comm: test_progs Tainted: G           OE      6.7.0+ #309 d8e2cbcdc10865c6eb2d28ed0cbf958842aa75a8
> > [  507.588821][  T697] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> > [  507.589681][  T697] Call Trace:
> > [  507.590044][  T697]  <TASK>
> > [  507.590357][  T697]  dump_stack_lvl+0xf6/0x180
> > [  507.590807][  T697]  print_report+0xc4/0x610
> > [  507.591259][  T697]  ? fixup_red_left+0x5/0x20
> > [  507.591781][  T697]  kasan_report+0xbe/0xf0
> > [  507.592241][  T697]  ? ftrace_push_return_trace.isra.0+0x346/0x370
> > [  507.592928][  T697]  ? ftrace_push_return_trace.isra.0+0x346/0x370
> > [  507.593535][  T697]  ? __pfx_text_poke_loc_init+0x10/0x10
> > [  507.594076][  T697]  ? ftrace_replace_code+0x17a/0x230
> > [  507.594586][  T697]  ftrace_push_return_trace.isra.0+0x346/0x370
> > [  507.595192][  T697]  ? __pfx_text_poke_loc_init+0x10/0x10
> > [  507.595747][  T697]  function_graph_enter_ops+0xbb/0x2d0
> > [  507.596271][  T697]  ? ftrace_replace_code+0x17a/0x230
> > [  507.596784][  T697]  ? __pfx_function_graph_enter_ops+0x10/0x10
> > [  507.597353][  T697]  ? preempt_count_sub+0x14/0xc0
> > [  507.598576][  T697]  ? __pfx_text_poke_loc_init+0x10/0x10
> > [  507.599145][  T697]  ? __pfx_fuse_sync_fs+0x10/0x10
> > [  507.599718][  T697]  ftrace_graph_func+0x142/0x270
> > [  507.600293][  T697]  ? __pfx_text_poke_loc_init+0x10/0x10
> > [  507.600892][  T697]  ? __pfx_fuse_conn_put.part.0+0x10/0x10
> > [  507.601484][  T697]  0xffffffffa0560097
> > [  507.602067][  T697]  ? __pfx_fuse_conn_put.part.0+0x10/0x10
> > [  507.602715][  T697]  ? text_poke_loc_init+0x5/0x2e0
> > [  507.603288][  T697]  ? __pfx_fuse_conn_put.part.0+0x10/0x10
> > [  507.603923][  T697]  text_poke_loc_init+0x5/0x2e0
> > [  507.604468][  T697]  ftrace_replace_code+0x17a/0x230
> > [  507.605071][  T697]  ftrace_modify_all_code+0x131/0x1a0
> > [  507.605663][  T697]  ftrace_startup+0x10b/0x210
> > [  507.606200][  T697]  register_ftrace_graph+0x313/0x8a0
> > [  507.606805][  T697]  ? register_ftrace_graph+0x3fe/0x8a0
> > [  507.607427][  T697]  register_fprobe_ips.part.0+0x25a/0x3f0
> > [  507.608090][  T697]  bpf_kprobe_multi_link_attach+0x49e/0x850
> > [  507.608781][  T697]  ? __pfx_bpf_kprobe_multi_link_attach+0x10/0x10
> > [  507.609500][  T697]  ? __debug_check_no_obj_freed+0x1d8/0x3a0
> > [  507.610194][  T697]  ? __fget_light+0x96/0xe0
> > [  507.610741][  T697]  __sys_bpf+0x307a/0x3180
> > [  507.611286][  T697]  ? __pfx___sys_bpf+0x10/0x10
> > [  507.611838][  T697]  ? __kasan_slab_free+0x12d/0x1c0
> > [  507.612434][  T697]  ? audit_log_exit+0x8e0/0x1960
> > [  507.613003][  T697]  ? kmem_cache_free+0x19d/0x460
> > [  507.613644][  T697]  ? rcu_is_watching+0x34/0x60
> > [  507.614202][  T697]  ? lockdep_hardirqs_on_prepare+0xe/0x250
> > [  507.614865][  T697]  ? seqcount_lockdep_reader_access.constprop.0+0x105/0x120
> > [  507.615662][  T697]  ? seqcount_lockdep_reader_access.constprop.0+0xb2/0x120
> > [  507.616431][  T697]  __x64_sys_bpf+0x44/0x60
> > [  507.616940][  T697]  do_syscall_64+0x87/0x1b0
> > [  507.617495][  T697]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [  507.618179][  T697] RIP: 0033:0x7ff2edca6b4d
> > [  507.618745][  T697] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 92 0c 00 f7 d8 64 89 01 48
> > [  507.620863][  T697] RSP: 002b:00007ffe2e58a8f8 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
> > [  507.621749][  T697] RAX: ffffffffffffffda RBX: 00007ffe2e58b018 RCX: 00007ff2edca6b4d
> > [  507.622580][  T697] RDX: 0000000000000040 RSI: 00007ffe2e58a970 RDI: 000000000000001c
> > [  507.623395][  T697] RBP: 00007ffe2e58a910 R08: 0000000000000001 R09: 00007ffe2e58a970
> > [  507.624198][  T697] R10: 0000000000000007 R11: 0000000000000206 R12: 0000000000000001
> > [  507.625029][  T697] R13: 0000000000000000 R14: 00007ff2eddee000 R15: 0000000000edcdb0
> > [  507.625989][  T697]  </TASK>
> > [  507.626377][  T697] 
> > [  507.626678][  T697] Allocated by task 697:
> > [  507.627175][  T697]  kasan_save_stack+0x1c/0x40
> > [  507.627757][  T697]  kasan_save_track+0x10/0x30
> > [  507.628992][  T697]  __kasan_kmalloc+0xa6/0xb0
> > [  507.629502][  T697]  register_ftrace_graph+0x42b/0x8a0
> > [  507.630071][  T697]  register_fprobe_ips.part.0+0x25a/0x3f0
> > [  507.630649][  T697]  bpf_kprobe_multi_link_attach+0x49e/0x850
> > [  507.631218][  T697]  __sys_bpf+0x307a/0x3180
> > [  507.631662][  T697]  __x64_sys_bpf+0x44/0x60
> > [  507.632128][  T697]  do_syscall_64+0x87/0x1b0
> > [  507.632577][  T697]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [  507.633136][  T697] 
> > [  507.633399][  T697] The buggy address belongs to the object at ffff888148194000
> > [  507.633399][  T697]  which belongs to the cache kmalloc-4k of size 4096
> > [  507.634667][  T697] The buggy address is located 8 bytes to the left of
> > [  507.634667][  T697]  allocated 4096-byte region [ffff888148194000, ffff888148195000)
> > [  507.636028][  T697] 
> > [  507.636392][  T697] The buggy address belongs to the physical page:
> > [  507.637106][  T697] page:ffffea0005206400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x148190
> > [  507.638206][  T697] head:ffffea0005206400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > [  507.639082][  T697] flags: 0x17ffe000000840(slab|head|node=0|zone=2|lastcpupid=0x3fff)
> > [  507.639858][  T697] page_type: 0xffffffff()
> > [  507.640306][  T697] raw: 0017ffe000000840 ffff888100043a40 ffffea0005a89610 ffffea0005d0de10
> > [  507.641244][  T697] raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
> > [  507.642184][  T697] page dumped because: kasan: bad access detected
> > [  507.642853][  T697] 
> > [  507.643152][  T697] Memory state around the buggy address:
> > [  507.643773][  T697]  ffff888148193e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  507.644661][  T697]  ffff888148193f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  507.645490][  T697] >ffff888148193f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  507.646263][  T697]                                                                 ^
> > [  507.647025][  T697]  ffff888148194000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [  507.647821][  T697]  ffff888148194080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [  507.648588][  T697] ==================================================================
> > 
> > ---
> > 
> > [  367.302586][  T973] BUG: KASAN: slab-out-of-bounds in ftrace_push_return_trace.isra.0+0x346/0x370
> > [  367.303380][  T973] Write of size 8 at addr ffff888174e58ff8 by task kworker/u12:10/973
> > [  367.304243][  T973] 
> > [  367.304599][  T973] CPU: 3 PID: 973 Comm: kworker/u12:10 Tainted: G           OE      6.7.0+ #312 a13024221ef8bb3aaeade334af809d35027f09e3
> > [  367.305894][  T973] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> > [  367.306834][  T973] Workqueue: writeback wb_workfn (flush-253:0)
> > [  367.307415][  T973] Call Trace:
> > [  367.307786][  T973]  <TASK>
> > [  367.308130][  T973]  dump_stack_lvl+0xf6/0x180
> > [  367.308610][  T973]  print_report+0xc4/0x610
> > [  367.309090][  T973]  ? fixup_red_left+0x5/0x20
> > [  367.309557][  T973]  kasan_report+0xbe/0xf0
> > [  367.309926][  T973]  ? ftrace_push_return_trace.isra.0+0x346/0x370
> > [  367.310404][  T973]  ? ftrace_push_return_trace.isra.0+0x346/0x370
> > [  367.310932][  T973]  ? __pfx_unwind_get_return_address+0x10/0x10
> > [  367.311529][  T973]  ? arch_stack_walk+0x9e/0xf0
> > [  367.312092][  T973]  ftrace_push_return_trace.isra.0+0x346/0x370
> > [  367.312769][  T973]  ? __pfx_function_graph_enter_ops+0x10/0x10
> > [  367.313414][  T973]  ? __pfx_unwind_get_return_address+0x10/0x10
> > [  367.313946][  T973]  function_graph_enter_ops+0xbb/0x2d0
> > [  367.314518][  T973]  ? arch_stack_walk+0x9e/0xf0
> > [  367.315016][  T973]  ? __pfx_function_graph_enter_ops+0x10/0x10
> > [  367.315540][  T973]  ? ftrace_graph_func+0x173/0x270
> > [  367.316084][  T973]  ? __pfx_preempt_count_sub+0x10/0x10
> > [  367.317791][  T973]  ftrace_graph_func+0x142/0x270
> > [  367.318231][  T973]  ? __pfx_unwind_get_return_address+0x10/0x10
> > [  367.318690][  T973]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> > [  367.319159][  T973]  0xffffffffa0568097
> > [  367.319542][  T973]  ? preempt_count_sub+0x5/0xc0
> > [  367.320073][  T973]  ? preempt_count_sub+0x14/0xc0
> > [  367.320610][  T973]  ? preempt_count_sub+0x14/0xc0
> > [  367.321226][  T973]  ? unwind_get_return_address+0x5/0x50
> > [  367.321862][  T973]  unwind_get_return_address+0x5/0x50
> > [  367.322449][  T973]  arch_stack_walk+0x9e/0xf0
> > [  367.322997][  T973]  ? worker_thread+0x393/0x680
> > [  367.323553][  T973]  stack_trace_save+0x91/0xd0
> > [  367.324087][  T973]  ? __pfx_stack_trace_save+0x10/0x10
> > [  367.324708][  T973]  ? stack_trace_save+0x5/0xd0
> > [  367.325244][  T973]  ? kvm_sched_clock_read+0xd/0x20
> > [  367.325822][  T973]  kasan_save_stack+0x1c/0x40
> > [  367.326326][  T973]  ? kasan_save_stack+0x1c/0x40
> > [  367.326828][  T973]  ? kasan_save_track+0x10/0x30
> > [  367.327298][  T973]  ? __kasan_slab_alloc+0x85/0x90
> > [  367.327803][  T973]  ? kmem_cache_alloc+0x159/0x460
> > [  367.328383][  T973]  ? mempool_alloc+0xe1/0x270
> > [  367.328925][  T973]  ? bio_alloc_bioset+0x2c6/0x440
> > [  367.329435][  T973]  ? iomap_do_writepage+0x784/0x1090
> > [  367.329993][  T973]  ? write_cache_pages+0x2be/0x720
> > [  367.330506][  T973]  ? iomap_writepages+0x39/0x70
> > [  367.331015][  T973]  ? xfs_vm_writepages+0xf6/0x150
> > [  367.331583][  T973]  ? do_writepages+0x104/0x320
> > [  367.332163][  T973]  ? __writeback_single_inode+0x9e/0x6e0
> > [  367.332754][  T973]  ? writeback_sb_inodes+0x384/0x830
> > [  367.333329][  T973]  ? __writeback_inodes_wb+0x70/0x130
> > [  367.333915][  T973]  ? wb_writeback+0x486/0x5b0
> > [  367.334437][  T973]  ? wb_workfn+0x68b/0x8c0
> > [  367.334942][  T973]  ? process_one_work+0x48c/0x970
> > [  367.335574][  T973]  ? __pfx_function_graph_enter_ops+0x10/0x10
> > [  367.336257][  T973]  ? kmem_cache_alloc+0x415/0x460
> > [  367.336818][  T973]  ? __pfx_preempt_count_sub+0x10/0x10
> > [  367.337426][  T973]  ? iomap_do_writepage+0x784/0x1090
> > [  367.337947][  T973]  ? write_cache_pages+0x2be/0x720
> > [  367.338475][  T973]  ? iomap_writepages+0x39/0x70
> > [  367.338981][  T973]  ? xfs_vm_writepages+0xf6/0x150
> > [  367.339514][  T973]  ? do_writepages+0x104/0x320
> > [  367.340065][  T973]  ? ftrace_graph_func+0x173/0x270
> > [  367.340658][  T973]  ? __pfx_preempt_count_sub+0x10/0x10
> > [  367.341225][  T973]  ? mempool_alloc+0xe1/0x270
> > [  367.341729][  T973]  ? 0xffffffffa0568097
> > [  367.342155][  T973]  ? 0xffffffffa0568097
> > [  367.342598][  T973]  ? preempt_count_sub+0x5/0xc0
> > [  367.343109][  T973]  ? mempool_alloc+0xe1/0x270
> > [  367.343590][  T973]  kasan_save_track+0x10/0x30
> > [  367.344040][  T973]  __kasan_slab_alloc+0x85/0x90
> > [  367.344542][  T973]  kmem_cache_alloc+0x159/0x460
> > [  367.345024][  T973]  ? __pfx_mempool_alloc_slab+0x10/0x10
> > [  367.345518][  T973]  mempool_alloc+0xe1/0x270
> > [  367.345997][  T973]  ? __pfx_mempool_alloc+0x10/0x10
> > [  367.346526][  T973]  ? 0xffffffffa0568097
> > [  367.346973][  T973]  ? ftrace_push_return_trace.isra.0+0x17c/0x370
> > [  367.348141][  T973]  bio_alloc_bioset+0x2c6/0x440
> > [  367.348653][  T973]  ? __pfx_bio_alloc_bioset+0x10/0x10
> > [  367.349221][  T973]  iomap_do_writepage+0x784/0x1090
> > [  367.349763][  T973]  ? __pfx_iomap_do_writepage+0x10/0x10
> > [  367.350306][  T973]  ? __pfx_iomap_do_writepage+0x10/0x10
> > [  367.350860][  T973]  write_cache_pages+0x2be/0x720
> > [  367.351366][  T973]  ? __pfx_iomap_do_writepage+0x10/0x10
> > [  367.351921][  T973]  ? __pfx_write_cache_pages+0x10/0x10
> > [  367.352468][  T973]  ? ftrace_graph_func+0x173/0x270
> > [  367.352967][  T973]  ? ksys_fadvise64_64+0x8c/0xc0
> > [  367.357367][  T973]  ? __pfx_lock_release+0x10/0x10
> > [  367.357872][  T973]  ? __pfx_iomap_do_writepage+0x10/0x10
> > [  367.358440][  T973]  iomap_writepages+0x39/0x70
> > [  367.358953][  T973]  xfs_vm_writepages+0xf6/0x150
> > [  367.359505][  T973]  ? __pfx_xfs_vm_writepages+0x10/0x10
> > [  367.360108][  T973]  ? __pfx_xfs_vm_writepages+0x10/0x10
> > [  367.360740][  T973]  ? __pfx_xfs_vm_writepages+0x10/0x10
> > [  367.361343][  T973]  ? do_writepages+0x164/0x320
> > [  367.361893][  T973]  do_writepages+0x104/0x320
> > [  367.362414][  T973]  ? __pfx_do_writepages+0x10/0x10
> > [  367.362957][  T973]  ? 0xffffffffa0568097
> > [  367.363449][  T973]  ? __pfx___writeback_single_inode+0x10/0x10
> > [  367.364114][  T973]  __writeback_single_inode+0x9e/0x6e0
> > [  367.364705][  T973]  writeback_sb_inodes+0x384/0x830
> > [  367.365295][  T973]  ? __pfx_writeback_sb_inodes+0x10/0x10
> > [  367.365857][  T973]  ? __pfx_writeback_sb_inodes+0x10/0x10
> > [  367.366505][  T973]  ? super_trylock_shared+0x46/0x70
> > [  367.367085][  T973]  __writeback_inodes_wb+0x70/0x130
> > [  367.367764][  T973]  wb_writeback+0x486/0x5b0
> > [  367.368300][  T973]  ? __pfx_wb_writeback+0x10/0x10
> > [  367.368860][  T973]  ? 0xffffffffa0568097
> > [  367.369339][  T973]  ? __pfx_lock_release+0x10/0x10
> > [  367.369940][  T973]  wb_workfn+0x68b/0x8c0
> > [  367.370473][  T973]  ? _raw_spin_unlock_irqrestore+0x37/0xb0
> > [  367.371131][  T973]  ? __pfx_wb_workfn+0x10/0x10
> > [  367.371600][  T973]  ? ftrace_graph_func+0x173/0x270
> > [  367.372110][  T973]  ? __pfx_wb_workfn+0x10/0x10
> > [  367.372609][  T973]  ? 0xffffffffa0568097
> > [  367.373044][  T973]  ? __pfx_wb_workfn+0x10/0x10
> > [  367.373507][  T973]  ? process_one_work+0x483/0x970
> > [  367.373990][  T973]  ? rcu_is_watching+0x34/0x60
> > [  367.374474][  T973]  process_one_work+0x48c/0x970
> > [  367.374956][  T973]  ? __pfx_process_one_work+0x10/0x10
> > [  367.375474][  T973]  ? 0xffffffffa0568097
> > [  367.375903][  T973]  ? __list_add_valid_or_report+0x33/0xc0
> > [  367.376518][  T973]  ? worker_thread+0x375/0x680
> > [  367.377065][  T973]  worker_thread+0x393/0x680
> > [  367.378058][  T973]  ? __pfx_worker_thread+0x10/0x10
> > [  367.378649][  T973]  kthread+0x1ad/0x1f0
> > [  367.379076][  T973]  ? kthread+0xf2/0x1f0
> > [  367.379513][  T973]  ? __pfx_kthread+0x10/0x10
> > [  367.380003][  T973]  ret_from_fork+0x2d/0x50
> > [  367.380483][  T973]  ? __pfx_kthread+0x10/0x10
> > [  367.380993][  T973]  ret_from_fork_asm+0x1b/0x30
> > [  367.381486][  T973]  </TASK>
> > [  367.381815][  T973] 
> > [  367.382070][  T973] Allocated by task 719:
> > [  367.382508][  T973]  kasan_save_stack+0x1c/0x40
> > [  367.382988][  T973]  kasan_save_track+0x10/0x30
> > [  367.383477][  T973]  __kasan_kmalloc+0xa6/0xb0
> > [  367.383960][  T973]  register_ftrace_graph+0x42b/0x8a0
> > [  367.384454][  T973]  register_fprobe_ips.part.0+0x25a/0x3f0
> > [  367.385075][  T973]  bpf_kprobe_multi_link_attach+0x49e/0x850
> > [  367.385713][  T973]  __sys_bpf+0x307a/0x3180
> > [  367.386217][  T973]  __x64_sys_bpf+0x44/0x60
> > [  367.386716][  T973]  do_syscall_64+0x87/0x1b0
> > [  367.387220][  T973]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [  367.387878][  T973] 
> > [  367.388193][  T973] The buggy address belongs to the object at ffff888174e59000
> > [  367.388193][  T973]  which belongs to the cache kmalloc-4k of size 4096
> > [  367.389731][  T973] The buggy address is located 8 bytes to the left of
> > [  367.389731][  T973]  allocated 4096-byte region [ffff888174e59000, ffff888174e5a000)
> > [  367.391266][  T973] 
> > [  367.391580][  T973] The buggy address belongs to the physical page:
> > [  367.392285][  T973] page:ffffea0005d39600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x174e58
> > [  367.393398][  T973] head:ffffea0005d39600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > [  367.394437][  T973] flags: 0x17ffe000000840(slab|head|node=0|zone=2|lastcpupid=0x3fff)
> > [  367.395335][  T973] page_type: 0xffffffff()
> > [  367.395837][  T973] raw: 0017ffe000000840 ffff888100043a40 ffffea000674d010 ffffea0004bc8c10
> > [  367.396786][  T973] raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
> > [  367.397728][  T973] page dumped because: kasan: bad access detected
> > [  367.398458][  T973] 
> > [  367.398766][  T973] Memory state around the buggy address:
> > [  367.399411][  T973]  ffff888174e58e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  367.400296][  T973]  ffff888174e58f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  367.401189][  T973] >ffff888174e58f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [  367.402093][  T973]                                                                 ^
> > [  367.402983][  T973]  ffff888174e59000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [  367.403879][  T973]  ffff888174e59080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [  367.404769][  T973] ==================================================================
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

