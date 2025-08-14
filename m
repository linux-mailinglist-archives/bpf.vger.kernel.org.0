Return-Path: <bpf+bounces-65673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16524B26D3F
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 19:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161157B285F
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181B1F09A3;
	Thu, 14 Aug 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePjbseTs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65FD1E4BE;
	Thu, 14 Aug 2025 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191138; cv=none; b=q6uWBIzSMDnC0M3Sgf2dioFlvpX4pgXwR1r1uIYy+4VH9EdaVzOokCFyAjNg0L6OQfIEI8kSpSKDtcMspRqPp2cxk4jo2SKF4SgKJ0v1p4eUpuuFDj/mTw7xgDNxaEwui+6d5EqBanHrV+9MGX8gDfyg7Z/Gjbq4kMm/0GmShwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191138; c=relaxed/simple;
	bh=AYnNiEQMKz9u/0mNhTpLE4pbq6s6pA2e+OWKRcUhmwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox/JPztcVkItEdpN+uW6z+jzTv1EAvO9ku0qCtgkyLmpgx5ntFvWoCZtB9J/CalsEHlVTcOLHngRcw6J80KDL4KA+LZ7ZU71NHRIwu1pY32G37Ql1Qlg2UoDuy5jMUTAhLCh7lsKTuwji4gk7ycURQ4AWJAv0/xYboQs6JjSKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePjbseTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F44C4CEED;
	Thu, 14 Aug 2025 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755191137;
	bh=AYnNiEQMKz9u/0mNhTpLE4pbq6s6pA2e+OWKRcUhmwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePjbseTsgvCnf9MSlpDAb+6BEbd6dK/lVlA/wjBfgMXT46/7H/Waayyd0GwI6J90b
	 ersGSKiW6YTvXYiQrNuqg0jeY0JdfZasId02q/hHNZdhk3NgBfXTX7syrKyfd0E0UH
	 qh9wH21uZs0r74ztgnYfWt2UQ0pXRBwpa+vbf9f5v3TndYMpggLC0UichYEMIFh4ea
	 /RWLeBs6Hsfh+V00lG2P6lLAW/Q6H/WChQrlXcx7ilhPHKKPWZ0HVjsF0PIFIKg0SX
	 cwS5LCE17ZvjSy5WRTT3MScr4846WdT8YSNVrlmx+vASvBZdlFwT2PeSFWgtphkn0c
	 D7vs6qbT5ukiA==
Date: Thu, 14 Aug 2025 13:05:35 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <aJ4XX4qvHUZRAFxF@lappy>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
 <aJaxRVKverIjF4a6@lappy>
 <20250813195317.508a29aa@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813195317.508a29aa@batman.local.home>

On Wed, Aug 13, 2025 at 07:53:17PM -0400, Steven Rostedt wrote:
>On Fri, 8 Aug 2025 22:24:05 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> So we've added a dynamically sized array to the end of
>> ftrace_graph_ent_entry, but in struct fgraph_data, the saved entry is
>> defined as:
>>
>>    struct fgraph_data {
>>        ...
>>        union {
>>            struct ftrace_graph_ent_entry ent;
>>            struct fgraph_retaddr_ent_entry rent;
>>        } ent;
>>        ...
>>    }
>>
>> Which doesn't seem to have room for args?
>
>No it doesn't :-p
>
>>
>> The code in get_return_for_leaf() does:
>>
>>    data->ent.ent = *curr;
>>
>> This copies the struct, but curr points to a larger entry with args
>> data. The copy operation only copies sizeof(struct
>> ftrace_graph_ent_entry) bytes, which doesn't include the dynamic args
>> array.
>>
>> And then later functions (like print_graph_entry()) would go ahead and
>> assume that iter->ent_size is sane and make a mess out of everything.
>>
>> I can't test right now whether this actually fixes the issues or not,
>> but I wanted to bring this up as this looks somewhat odd and I'm not too
>> familiar with this code.
>
>Thanks for the detail analysis, can you test this patch?
>
>-- Steve
>
>diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
>index 66e1a527cf1a..25ea71edb8da 100644
>--- a/kernel/trace/trace_functions_graph.c
>+++ b/kernel/trace/trace_functions_graph.c
>@@ -35,6 +35,11 @@ struct fgraph_data {
> 		struct ftrace_graph_ent_entry	ent;
> 		struct fgraph_retaddr_ent_entry	rent;
> 	} ent;
>+	/*
>+	 * The @args must be right after @ent, as it is where they
>+	 * are stored in case the function graph tracer has arguments.
>+	 */
>+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
> 	struct ftrace_graph_ret_entry	ret;
> 	int				failed;
> 	int				cpu;
>@@ -623,14 +628,29 @@ get_return_for_leaf(struct trace_iterator *iter,
> 		next = ring_buffer_event_data(event);
>
> 		if (data) {
>+			int args_size;
>+			int size;
>+
> 			/*
> 			 * Save current and next entries for later reference
> 			 * if the output fails.
> 			 */
>-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT))
>+			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
> 				data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
>-			else
>+				size = offsetof(struct fgraph_retaddr_ent_entry, args);
>+			} else {
> 				data->ent.ent = *curr;
>+				size = offsetof(struct ftrace_graph_ent_entry, args);
>+			}
>+
>+			/* If this has args, then append them to after the ent. */
>+			args_size = iter->ent_size - size;
>+			if (args_size > sizeof(long) * FTRACE_REGS_MAX_ARGS)
>+				args_size = sizeof(long) * FTRACE_REGS_MAX_ARGS;
>+
>+			if (args_size >= sizeof(long))
>+				memcpy((void *)&data->ent.ent + size,
>+				       (void*)curr + size, args_size);
> 			/*
> 			 * If the next event is not a return type, then
> 			 * we only care about what type it is. Otherwise we can

Got a small build error:

kernel/trace/trace_functions_graph.c: In function ‘get_return_for_leaf’:
./include/linux/stddef.h:16:33: error: ‘struct fgraph_retaddr_ent_entry’ has no member named ‘args’
    16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
       |                                 ^~~~~~~~~~~~~~~~~~
kernel/trace/trace_functions_graph.c:640:40: note: in expansion of macro ‘offsetof’
   640 |                                 size = offsetof(struct fgraph_retaddr_ent_entry, args);
       |                                        ^~~~~~~~

Does this look right on top of your patch:

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 25ea71edb8da..f0f37356ef29 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -637,20 +637,21 @@ get_return_for_leaf(struct trace_iterator *iter,
                          */
                         if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
                                 data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
-                               size = offsetof(struct fgraph_retaddr_ent_entry, args);
+                               /* fgraph_retaddr_ent_entry doesn't have args field */
+                               size = sizeof(struct fgraph_retaddr_ent_entry);
+                               args_size = 0;
                         } else {
                                 data->ent.ent = *curr;
                                 size = offsetof(struct ftrace_graph_ent_entry, args);
+                               /* If this has args, then append them to after the ent. */
+                               args_size = iter->ent_size - size;
+                               if (args_size > sizeof(long) * FTRACE_REGS_MAX_ARGS)
+                                       args_size = sizeof(long) * FTRACE_REGS_MAX_ARGS;
+
+                               if (args_size >= sizeof(long))
+                                       memcpy((void *)&data->ent.ent + size,
+                                              (void*)curr + size, args_size);
                         }
-
-                       /* If this has args, then append them to after the ent. */
-                       args_size = iter->ent_size - size;
-                       if (args_size > sizeof(long) * FTRACE_REGS_MAX_ARGS)
-                               args_size = sizeof(long) * FTRACE_REGS_MAX_ARGS;
-
-                       if (args_size >= sizeof(long))
-                               memcpy((void *)&data->ent.ent + size,
-                                      (void*)curr + size, args_size);
                         /*
                          * If the next event is not a return type, then
                          * we only care about what type it is. Otherwise we can

-- 
Thanks,
Sasha

