Return-Path: <bpf+bounces-52483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED100A43354
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 03:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD63AB3E3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FDE14BFA2;
	Tue, 25 Feb 2025 02:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC/BliB7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C2BE49;
	Tue, 25 Feb 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452199; cv=none; b=ISqqHbPiXnsHHrnbAuI9c2uqf40aXQM/a+eZIeQWYeD89cnvaMcQU8w6qGpeu1O/PiAevjrd4tv5M137eN7IKaTZdgctxq1OsMGnTq3zyzXKbFHqDRDSBAEXe0/PcvAmTkLrfZovfLstsf0JSlcyGlcAfPdOelALDsGwLTIy6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452199; c=relaxed/simple;
	bh=VK4WmVHX7BHxAZHr/+vF6RlSlg/plxjr5UlLkHfn4DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krqrP5IsA4Y3nAOHJwfdfMjbXCVYCkod03G7P2aKLMV6HBsf4s30QukSU3NfOozXwsIex9WVSXto7F3NbWAwzfwyp9TV7Bdqv6ibWVni3l3fR+ZC02ij8mZEwSI6liDwJXH3kQF6xcNKIZfE7df7DwvkugLtYPtp5dxD/0Gf05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC/BliB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE2FC4CED6;
	Tue, 25 Feb 2025 02:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740452198;
	bh=VK4WmVHX7BHxAZHr/+vF6RlSlg/plxjr5UlLkHfn4DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CC/BliB70XWSH5Zrk4s1FcqYdbrSqYNzU15J3bu/Qlq9LW+1USAPToymtrhwEfg7C
	 M67wYo3JjVCtqgFeVK1HDH37glwjHe1E2S+dK418jYUs3do16C8jj29twjrnWUOqZF
	 T/Hhyz3UCEJKGhMLfGjUuOtDUg/5b/svVDiv/q7QvEBMSRlxwCcgrIq20xNngD8Mli
	 fepNSN/yqJRPoQPbYF5SB+QygPgtpiqFX9GHVlAoGOwB//DD59kuh5OVHdiRwT+7wm
	 GvOdgozZttE0Vjug5zviePH/MohMKpxtOO07EXVsXkvF+NPhMB5/DUacg2BytkMpUl
	 4/loQ5yJgun6Q==
Date: Mon, 24 Feb 2025 18:56:31 -0800
From: Nathan Chancellor <nathan@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [for-next][PATCH 4/6] scripts/sorttable: Zero out weak functions
 in mcount_loc table
Message-ID: <20250225025631.GA271248@ax162>
References: <20250219151815.734900568@goodmis.org>
 <20250219151904.476350486@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219151904.476350486@goodmis.org>

Hi Steve,

On Wed, Feb 19, 2025 at 10:18:19AM -0500, Steven Rostedt wrote:
> When a function is annotated as "weak" and is overridden, the code is not
> removed. If it is traced, the fentry/mcount location in the weak function
> will be referenced by the "__mcount_loc" section. This will then be added
> to the available_filter_functions list. Since only the address of the
> functions are listed, to find the name to show, a search of kallsyms is
> used.
> 
> Since kallsyms will return the function by simply finding the function
> that the address is after but before the next function, an address of a
> weak function will show up as the function before it. This is because
> kallsyms does not save names of weak functions. This has caused issues in
> the past, as now the traced weak function will be listed in
> available_filter_functions with the name of the function before it.
> 
> At best, this will cause the previous function's name to be listed twice.
> At worse, if the previous function was marked notrace, it will now show up
> as a function that can be traced. Note that it only shows up that it can
> be traced but will not be if enabled, which causes confusion.
> 
>  https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/
> 
> The commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
> adding weak function") was a workaround to this by checking the function
> address before printing its name. If the address was too far from the
> function given by the name then instead of printing the name it would
> print: __ftrace_invalid_address___<invalid-offset>
> 
> The real issue is that these invalid addresses are listed in the ftrace
> table look up which available_filter_functions is derived from. A place
> holder must be listed in that file because set_ftrace_filter may take a
> series of indexes into that file instead of names to be able to do O(1)
> lookups to enable filtering (many tools use this method).
> 
> Even if kallsyms saved the size of the function, it does not remove the
> need of having these place holders. The real solution is to not add a weak
> function into the ftrace table in the first place.
> 
> To solve this, the sorttable.c code that sorts the mcount regions during
> the build is modified to take a "nm -S vmlinux" input, sort it, and any
> function listed in the mcount_loc section that is not within a boundary of
> the function list given by nm is considered a weak function and is zeroed
> out.
> 
> Note, this does not mean they will remain zero when booting as KASLR
> will still shift those addresses. To handle this, the entries in the
> mcount_loc section will be ignored if they are zero or match the
> kaslr_offset() value.
> 
> Before:
> 
>  ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
>  551
> 
> After:
> 
>  ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
>  0

I am also seeing a crash when booting arm64 with certain configurations
that I don't see at the parent change.

  $ printf 'CONFIG_%s=y\n' FTRACE FUNCTION_TRACER >kernel/configs/repro.config

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- mrproper virtconfig repro.config Image.gz

  $ qemu-system-aarch64 \
      -display none \
      -nodefaults \
      -cpu max,pauth-impdef=true \
      -machine virt,gic-version=max,virtualization=true \
      -append 'console=ttyAMA0 earlycon' \
      -kernel arch/arm64/boot/Image.gz \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
  [    0.000000] Linux version 6.14.0-rc4-next-20250224-dirty (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT Mon Feb 24 18:47:59 PST 2025
  ...
  [    0.000000] ------------[ cut here ]------------
  [    0.000000] kernel BUG at arch/arm64/kernel/patching.c:39!
  [    0.000000] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  [    0.000000] Modules linked in:
  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc4-next-20250224-dirty #1
  [    0.000000] Hardware name: linux,dummy-virt (DT)
  [    0.000000] pstate: 000000c9 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [    0.000000] pc : patch_map.constprop.0+0xfc/0x108
  [    0.000000] lr : patch_map.constprop.0+0x3c/0x108
  [    0.000000] sp : ffff96c0b6fa3ce0
  [    0.000000] x29: ffff96c0b6fa3ce0 x28: ffff96c0b6faafd0 x27: 00000000000000ff
  [    0.000000] x26: fff9f3a0c2408080 x25: 0000000000000001 x24: fff9f3a0c2408000
  [    0.000000] x23: 0000000000000000 x22: ffff96c0b72391d8 x21: 00000000000000c0
  [    0.000000] x20: 000016c035400000 x19: 000016c035400000 x18: 00000000f0000000
  [    0.000000] x17: 0000000000000068 x16: 0000000000000100 x15: ffff96c0b6fa39c4
  [    0.000000] x14: 0000000000000008 x13: 0000000000000000 x12: ffffe9ce43090280
  [    0.000000] x11: fff9f3a0dfef80c8 x10: ffffe9ce43090288 x9 : 0000000000000000
  [    0.000000] x8 : fff9f3a0dfef80b8 x7 : fffa5ce02929a000 x6 : ffff96c0b6fa39d0
  [    0.000000] x5 : 0000000000000030 x4 : 0000000000000000 x3 : ffff96c0b69b4000
  [    0.000000] x2 : ffff96c0b69b4000 x1 : 0000000000000000 x0 : 0000000000000000
  [    0.000000] Call trace:
  [    0.000000]  patch_map.constprop.0+0xfc/0x108 (P)
  [    0.000000]  aarch64_insn_write_literal_u64+0x38/0x80
  [    0.000000]  ftrace_init_nop+0x40/0xe0
  [    0.000000]  ftrace_process_locs+0x2a8/0x530
  [    0.000000]  ftrace_init+0x60/0x130
  [    0.000000]  start_kernel+0x4ac/0x708
  [    0.000000]  __primary_switched+0x88/0x98
  [    0.000000] Code: d1681000 a8c27bfd d50323bf d65f03c0 (d4210000)
  [    0.000000] ---[ end trace 0000000000000000 ]---
  [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
  [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

I see the same crash with clang (after applying your suggested fix for
the issue that Arnd brought up).

  [    0.000000] Unable to handle kernel paging request at virtual address 00001cb7f7800008
  [    0.000000] Mem abort info:
  [    0.000000]   ESR = 0x000000009600002b
  [    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
  [    0.000000]   SET = 0, FnV = 0
  [    0.000000]   EA = 0, S1PTW = 0
  [    0.000000]   FSC = 0x2b: level -1 translation fault
  [    0.000000] Data abort info:
  [    0.000000]   ISV = 0, ISS = 0x0000002b, ISS2 = 0x00000000
  [    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  [    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  [    0.000000] [00001cb7f7800008] user address but active_mm is swapper
  [    0.000000] Internal error: Oops: 000000009600002b [#1] PREEMPT SMP
  [    0.000000] Modules linked in:
  [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc4-next-20250224-dirty #1
  [    0.000000] Hardware name: linux,dummy-virt (DT)
  [    0.000000] pstate: 400000c9 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [    0.000000] pc : ftrace_call_adjust+0x44/0xd0
  [    0.000000] lr : ftrace_process_locs+0x1e0/0x560
  [    0.000000] sp : ffff9cb878f93da0
  [    0.000000] x29: ffff9cb878f93da0 x28: ffff9cb879234000 x27: ffff9cb879234000
  [    0.000000] x26: 00001cb7f7800000 x25: ffff9cb878ed8578 x24: fffac24642008000
  [    0.000000] x23: ffff9cb878f3cf90 x22: fffac24642008000 x21: 0000000000000000
  [    0.000000] x20: 0000000000001000 x19: 00001cb7f7800000 x18: 0000000000000068
  [    0.000000] x17: 0000000000000002 x16: 00000000fffffffe x15: ffff9cb878fa58c0
  [    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
  [    0.000000] x11: 0000000000000000 x10: 0000000000000000 x9 : 00007fff80000000
  [    0.000000] x8 : 000000000000201f x7 : 0000000000000000 x6 : 6d6067666871ff73
  [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000001
  [    0.000000] x2 : 0000000000000004 x1 : 0000000000000040 x0 : 00001cb7f7800000
  [    0.000000] Call trace:
  [    0.000000]  ftrace_call_adjust+0x44/0xd0 (P)
  [    0.000000]  ftrace_process_locs+0x1e0/0x560
  [    0.000000]  ftrace_init+0x7c/0xc8
  [    0.000000]  start_kernel+0x160/0x3b8
  [    0.000000]  __primary_switched+0x88/0x98
  [    0.000000] Code: aa1f03e0 14000014 aa0003f3 528403e8 (b8408e74)

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

