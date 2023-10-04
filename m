Return-Path: <bpf+bounces-11343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA627B7652
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 844FAB20992
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94450A47;
	Wed,  4 Oct 2023 01:37:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33020807;
	Wed,  4 Oct 2023 01:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBC9C433C7;
	Wed,  4 Oct 2023 01:37:39 +0000 (UTC)
Date: Tue, 3 Oct 2023 21:38:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Artem Savkov <asavkov@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, linux-rt-users@vger.kernel.org, Jiri Olsa
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH] tracing: change syscall number type in struct
 syscall_trace_*
Message-ID: <20231003213844.1de0c138@gandalf.local.home>
In-Reply-To: <20231002135242.247536-1-asavkov@redhat.com>
References: <20231002135242.247536-1-asavkov@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Oct 2023 15:52:42 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> linux-rt-devel tree contains a patch that adds an extra member to struct
> trace_entry. This causes the offset of args field in struct
> trace_event_raw_sys_enter be different from the one in struct
> syscall_trace_enter:

This patch looks like it's fixing the symptom and not the issue. No code
should rely on the two event structures to be related. That's an unwanted
coupling, that will likely cause issues down the road (like the RT patch
you mentioned).


> 
> struct trace_event_raw_sys_enter {
>         struct trace_entry         ent;                  /*     0    12 */
> 
>         /* XXX last struct has 3 bytes of padding */
>         /* XXX 4 bytes hole, try to pack */
> 
>         long int                   id;                   /*    16     8 */
>         long unsigned int          args[6];              /*    24    48 */
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         char                       __data[];             /*    72     0 */
> 
>         /* size: 72, cachelines: 2, members: 4 */
>         /* sum members: 68, holes: 1, sum holes: 4 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 8 bytes */
> };
> 
> struct syscall_trace_enter {
>         struct trace_entry         ent;                  /*     0    12 */
> 
>         /* XXX last struct has 3 bytes of padding */
> 
>         int                        nr;                   /*    12     4 */
>         long unsigned int          args[];               /*    16     0 */
> 
>         /* size: 16, cachelines: 1, members: 3 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 16 bytes */
> };
> 
> This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> test_profiler testcase because max_ctx_offset is calculated based on the
> former struct, while off on the latter:

The above appears to be pointing to the real bug. The "is calculated based
on the former struct while off on the latter" Why are the two being used
together? They are supposed to be *unrelated*!


> 
>   10488         if (is_tracepoint || is_syscall_tp) {
>   10489                 int off = trace_event_get_offsets(event->tp_event);

So basically this is clumping together the raw_syscalls with the syscalls
events as if they are the same. But the are not. They are created
differently. It's basically like using one structure to get the offsets of
another structure. That would be a bug anyplace else in the kernel. Sounds
like it's a bug here too.

I think the issue is with this code, not the tracing code.

We could expose the struct syscall_trace_enter and syscall_trace_exit if
the offsets to those are needed.

-- Steve


>   10490
>   10491                 if (prog->aux->max_ctx_offset > off)
>   10492                         return -EACCES;
>   10493         }
> 
> This patch changes the type of nr member in syscall_trace_* structs to
> be long so that "args" offset is equal to that in struct
> trace_event_raw_sys_enter.
> 


