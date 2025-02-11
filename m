Return-Path: <bpf+bounces-51159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA249A310F5
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63604188DD11
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4948254B11;
	Tue, 11 Feb 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abFg71GL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B58253F1E
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290285; cv=none; b=pxEDrbFthIHY78SVgCiOnvSMZJUSl7dDWlRhfySoMpZWLVh+Wl0gKxyo2UW6lZ0nfKhy7+jqE2cPX4og/m558+K3+1U56QaAbpuHgAVuQwCr9bsGb7FsbdvW0DNBfLgtjT+LQkNY/W8+FBi6JKiHs8OvKyvi5pJK0HkkLQaQ5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290285; c=relaxed/simple;
	bh=yalzx7hh8Kw3vSoctTUNpSPM00FOFb+tgKtdEBrplbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvXDk2d+JM388Y2gLQHdNKVrNJGDiPY4ZJHLID+P/PIycNU6MOTS7yu/RjpvSkFvCnvNbpQjB0DZslwaToADD+TAXcuTW85pLxQhBucMinHvIIc+hni7STFllvK2vCSp4oqL7mO3Q6PWWFJ47CdWNYoKiXbj/1NcSwyoJczx4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abFg71GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5046C4CEDD;
	Tue, 11 Feb 2025 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739290284;
	bh=yalzx7hh8Kw3vSoctTUNpSPM00FOFb+tgKtdEBrplbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abFg71GL0YIi0UNETVS/HCRZIPgmfoMHesu0DU/+/qDej3tZT0b0fhBbtYzuqpEHE
	 CjBe3SvR6wdJHgnrDxy0Q0Y2rBhKbV8UGECMqWQCRN0n4DqMGTF8HiX730ZcylgIXk
	 Td+4pg/IVXk1WHIQMZr4b11gZjILrHEv9+8OyoXhbu8nGJdK5qQvHle8PDocZVppdB
	 Gjf9WBItR5Kyo4rsQ99nWReN434JM+TdhsR7cXkUqTcvaviyKoMzyR9ng4hRq1UYKC
	 soWXE7QjKbddaoH27EpITRlIh7gc9pejXcSeyv80qPstaDRdgiEDABjl4LbxXuL4Xi
	 MTEO3TVvo/oAQ==
Date: Tue, 11 Feb 2025 08:11:22 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, peterz@infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common
 location
Message-ID: <20250211161122.ncnrwinacslvyn6k@jpoimboe>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
 <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>

On Mon, Feb 10, 2025 at 08:12:32PM -0800, Eduard Zingerman wrote:
> I'm probably out of context for this discussion, sorry if I'm raising
> points already discussed.
> 
> The DW_AT_noreturn attribute is defined for DWARF. A simple script
> like [1] could be used to find all functions with this attribute known
> to DWARF. Using this script I see several functions present in my
> kernel but not present in the NORETURN list from this patch:
> - abort
> - devtmpfs_work_loop
> - play_dead
> - rcu_gp_kthread
> - rcu_tasks_kthread
> 
> All these are marked as FUNC symbols when doing 'readelf --symbols vmlinux'.
> 
> 'pahole' could be modified to look for DW_AT_noreturn attributes and
> add this information in BTF. E.g. by adding special btf_decl_tag to
> corresponding FUNC definitions. This won't work if kernel is compiled
> w/o BTF, of-course.
> 
> [1] https://gist.github.com/eddyz87/d8513a731dfe7e2be52b346aef1de353

I also suggested this, I agree this is a much better way to go.
noreturns.h is manually maintained based on objtool warnings and
I'm not surprised it has missing entries.

Alexei mentioned 30k+ noreturns, but when I eliminate dups and
__compiletime_assert_* it's a much smaller list:

$ ./noreturn_printer vmlinux |sort |uniq |grep -v compiletime_assert
arch_cpu_idle_dead               external idle.c
arch_cpu_idle_dead               external process.c
cpu_startup_entry                external cpu.h
cpu_startup_entry                external idle.c
do_exit                          external exit.c
do_exit                          external kernel.h
do_group_exit                    external exit.c
do_group_exit                    external task.h
do_task_dead                     external core.c
do_task_dead                     external task.h
doublefault_shim                 external doublefault_32.c
ex_handler_msr_mce               external core.c
ex_handler_msr_mce               external extable.h
__fortify_panic                  external fortify-string.h
__fortify_panic                  external string_helpers.c
i386_start_kernel                external head32.c
__ia32_sys_exit                  external syscalls_32.h
__ia32_sys_exit_group            external syscalls_32.h
kthread_complete_and_exit        external kthread.c
kthread_exit                     external kthread.c
kthread_exit                     external kthread.h
machine_real_restart             external reboot.c
make_task_dead                   external exit.c
__module_put_and_kthread_exit    external main.c
__module_put_and_kthread_exit    external module.h
nmi_panic_self_stop              external panic.c
panic                            external panic.c
panic                            external panic.h
panic_smp_self_stop              external panic.c
play_dead                                 process.c
rcu_gp_kthread                            tree.c
rcu_tasks_kthread                         tasks.h
rest_init                                 main.c
rewind_stack_and_make_dead       external dumpstack.c
start_kernel                     external main.c
start_kernel                     external start_kernel.h
stop_this_cpu                    external process.c
stop_this_cpu                    external processor.h

Also, for objtool we could use something based on your program to
autogenerate noreturns.h.  Only problem is, objtool doesn't currently
have a dependency on CONFIG_DEBUG_INFO.  Another option we've considered
is compiler annotations (or compiler plugins).

-- 
Josh

