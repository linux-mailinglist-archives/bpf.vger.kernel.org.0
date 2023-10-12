Return-Path: <bpf+bounces-12033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42907C6F7B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7791C21233
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18F2AB4D;
	Thu, 12 Oct 2023 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34126E2D;
	Thu, 12 Oct 2023 13:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A10AC433C7;
	Thu, 12 Oct 2023 13:43:21 +0000 (UTC)
Date: Thu, 12 Oct 2023 09:44:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in
 struct syscall_tp_t
Message-ID: <20231012094444.0967fa79@gandalf.local.home>
In-Reply-To: <20231012114550.152846-1-asavkov@redhat.com>
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
	<20231012114550.152846-1-asavkov@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 13:45:50 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> for lazy preemption")) that adds an extra member to struct trace_entry.
> This causes the offset of args field in struct trace_event_raw_sys_enter
> be different from the one in struct syscall_trace_enter:
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
> 
>   10488         if (is_tracepoint || is_syscall_tp) {
>   10489                 int off = trace_event_get_offsets(event->tp_event);
>   10490
>   10491                 if (prog->aux->max_ctx_offset > off)
>   10492                         return -EACCES;
>   10493         }
> 
> What bpf program is actually getting is a pointer to struct
> syscall_tp_t, defined in kernel/trace/trace_syscalls.c. This patch fixes
> the problem by aligning struct syscall_tp_t with with struct
> syscall_trace_(enter|exit) and changing the tests to use these structs
> to dereference context.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Thanks for doing a proper fix.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

