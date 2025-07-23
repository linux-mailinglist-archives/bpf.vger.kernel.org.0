Return-Path: <bpf+bounces-64127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF363B0E793
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52FA544B93
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6935280;
	Wed, 23 Jul 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvq1NmDn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8478F2B;
	Wed, 23 Jul 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230388; cv=none; b=Bn+iH/vvNfcSFfSoZr6A8lrvDr5R6+toRZYMhqwd6S5omXje1YztTEVjVsqII2q/LVutvanLHohzSQ6I2Y4r10ujRtjiQr0nGvkBofZFLjcXD9h9VXJcg2Wg3KcbqI4ctJQgdiNdzurs2dQ9qnZgU7TskRBE56KCwGu0dCUjiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230388; c=relaxed/simple;
	bh=UlNoQyvXhOVWileRIFBkFfPZZDJqHqVcDoyY8+SRa3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=naxsfGS7IrMYS0B3LvwrGaBrpNWmg/SrQ/Hu8+kWlIQYX8WhFUjTW0lnT/cCASk4BO7WNivbz9CKvkJybMiJZE839MyONz0D8msWjHtx9ZPNiUQwvY6r1YHUdIeWhFtUvWrZJFqEZlGjglOO481FGCtfLkg1NnINGC4WaDDgeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvq1NmDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC49BC4CEEB;
	Wed, 23 Jul 2025 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230388;
	bh=UlNoQyvXhOVWileRIFBkFfPZZDJqHqVcDoyY8+SRa3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zvq1NmDnUh5Ps8NVgMrxOFM26whtFhjKbG5PhMx3zqABQ/2REEXRl8TrMIdkKlrUK
	 Cpk3n+JQ8V7AfyvdflrV/uR3H9ZqC6r2WkAUa8zgRvOSPsY4CA+aaAZzQotDn2FP6f
	 YAj94CefRaIG7ql2UsPvzoT3hTufygvjhKSC9d3UZiNBVNJBWxahXqNg/9BlrlA0ra
	 gKJE4nEXTwbnkIzbOSnS6FDztYXq9yOl62rdE6HD45C3LFUd1zUc5R/TQiR+YLSvTl
	 JAcey+1rm2lZaqCLUuLMA8pXOXh/iha+oHUgDmshXv/GaLYv+qNBFEOkr6pxeewV5Y
	 wlIMDfZp+I+Gw==
Date: Wed, 23 Jul 2025 09:26:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Brian Robbins
 <brianrob@microsoft.com>, Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [RFC] New codectl(2) system call for sframe registration
Message-Id: <20250723092620.c208fc0d3b9d800c47f87556@kernel.org>
In-Reply-To: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mathieu,

On Mon, 21 Jul 2025 11:20:34 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi!
> 
> I've written up an RFC for a new system call to handle sframe registration
> for shared libraries. There has been interest to cover both sframe in
> the short term, but also JIT use-cases in the long term, so I'm
> covering both here in this RFC to provide the full context. Implementation
> wise we could start by only covering the sframe use-case.
> 
> I've called it "codectl(2)" for now, but I'm of course open to feedback.

Nice idea for JIT, but I doubt we need this for ELF.

> 
> For ELF, I'm including the optional pathname, build id, and debug link
> information which are really useful to translate from instruction pointers
> to executable/library name, symbol, offset, source file, line number.

For ELF file, does the kernel already know how to parse the elf header?
I just wonder what happen if user sends different information to the
kernel.

> This is what we are using in LTTng-UST and Babeltrace debug-info filter
> plugin [1], and I think this would be relevant for kernel tracers as well
> so they can make the resulting stack traces meaningful to users.
> 
> sys_codectl(2)
> =================
> 
> * arg0: unsigned int @option:
> 
> /* Additional labels can be added to enum code_opt, for extensibility. */
> 
> enum code_opt {
>      CODE_REGISTER_ELF,
>      CODE_REGISTER_JIT,
>      CODE_UNREGISTER,
> };
> 
> * arg1: void * @info
> 
> /* if (@option == CODE_REGISTER_ELF) */
> 
> /*
>   * text_start, text_end, sframe_start, sframe_end allow unwinding of the
>   * call stack.
>   *
>   * elf_start, elf_end, pathname, and either build_id or debug_link allows
>   * mapping instruction pointers to file, symbol, offset, and source file
>   * location.
>   */
> struct code_elf_info {
> :   __u64 elf_start;
>      __u64 elf_end;
>      __u64 text_start;
>      __u64 text_end;

What happen if there are multiple .text.* sections?
Or, does it used for each text section?

>      __u64 sframe_start;
>      __u64 sframe_end;
>      __u64 pathname;              /* char *, NULL if unavailable. */
> 
>      __u64 build_id;              /* char *, NULL if unavailable. */
>      __u64 debug_link_pathname;   /* char *, NULL if unavailable. */
>      __u32 build_id_len;
>      __u32 debug_link_crc;
> };
> 
> 
> /* if (@option == CODE_REGISTER_JIT) */
> 
> /*
>   * Registration of sorted JIT unwind table: The reserved memory area is
>   * of size reserved_len. Userspace increases used_len as new code is
>   * populated between text_start and text_end. This area is populated in
>   * increasing address order, and its ABI requires to have no overlapping
>   * fre. This fits the common use-case where JITs populate code into
>   * a given memory area by increasing address order. The sorted unwind
>   * tables can be chained with a singly-linked list as they become full.
>   * Consecutive chained tables are also in sorted text address order.
>   *
>   * Note: if there is an eventual use-case for unsorted jit unwind table,
>   * this would be introduced as a new "code option".
>   */
> 
> struct code_jit_info {
>      __u64 text_start;      /* text_start >= addr */
>      __u64 text_end;        /* addr < text_end */
>      __u64 unwind_head;     /* struct code_jit_unwind_table * */
> };
> 
> struct code_jit_unwind_fre {
>      /*
>       * Contains info similar to sframe, allowing unwind for a given

Hmm, why not just the sframe?
(Is there any library to generate sframe online for JIT?)

Thank you,

>       * code address range.
>       */
>      __u32 size;
>      __u32 ip_off;  /* offset from text_start */
>      __s32 cfa_off;
>      __s32 ra_off;
>      __s32 fp_off;
>      __u8 info;
> };
> 
> struct code_jit_unwind_table {
>      __u64 reserved_len;
>      __u64 used_len; /*
>                       * Incremented by userspace (store-release), read by
>                       * the kernel (load-acquire).
>                       */
>      __u64 next;     /* Chain with next struct code_jit_unwind_table. */
>      struct code_jit_unwind_fre fre[];
> };
> 
> /* if (@option == CODE_UNREGISTER) */
> 
> void *info
> 
> * arg2: size_t info_size
> 
> /*
>   * Size of @info structure, allowing extensibility. See
>   * copy_struct_from_user().
>   */
> 
> * arg3: unsigned int flags (0)
> 
> /* Flags for extensibility. */
> 
> Your feedback is welcome,
> 
> Thanks,
> 
> Mathieu
> 
> [1] https://babeltrace.org/docs/v2.0/man7/babeltrace2-filter.lttng-utils.debug-info.7/
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

