Return-Path: <bpf+bounces-31107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930758D732A
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 04:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFDBB21250
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DF63B8;
	Sun,  2 Jun 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMastWbO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6329AB;
	Sun,  2 Jun 2024 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717296038; cv=none; b=W4XE3Lv0i7gEjVdKvTVk1km9JDfCijGjZtBLZYXfMSEkWa1nUwk3J29E2rNCCEV7QZh6SLU32qbRVNk6WPnnny40qwR9bu/G0cIDaE3YKcZmp0gBgKVPble4JpMnsQbDbaKmAM9SX0U9MHqj16us2luQx8i2r/4Zjn/asluaiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717296038; c=relaxed/simple;
	bh=HjXslGwuZEP5SHfHzgJFnxRlmo7xENWL4U5sjQfH5QU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XAoaoI+vuv0dSXUfae46RoW4Ckx+gKtL+79tDEdeLXSq8P6FmFDV8fN/7+o6wLIlWWpfVPdJ56zTCoe/0C6GTtf+gqK4K6xGLLFh0gCQmFVYWjF6riqu3lPPsNxHmvpijLXVeA0psHP+p492VsOk/u2isfG9psXMq3dO7WtQpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMastWbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38557C116B1;
	Sun,  2 Jun 2024 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717296038;
	bh=HjXslGwuZEP5SHfHzgJFnxRlmo7xENWL4U5sjQfH5QU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jMastWbORhu1JcTSXlVOWPzVOl4um/E/VS1GKZjzGBPBfaBXJH9DyYUVulcADig52
	 BSoQKU5dojVdVJLVJGTCD8u0GrmCcXsszmqFq3DMAOzydwq6X3UeBDUvPhj+onh2qt
	 R4e+ZsqmYwGfz+P8MIU9/k2p5yyeOfQlTHWhbx5kqsE/KoNcbCxRyoTSGI93xZTKx6
	 G11dH9UPCLERhwk6Yv5QknfyXD0lZ6UzLmGY3LExi8yMIE0Vi3gCHNH8UyOpK1GIu8
	 cthpvELaWbq2wS6VAEZAoRhThwPsdgMI5/1AvgqcWMZKU0kXOEC6L317ftuDekyvif
	 57XP0qjE3yN4g==
Date: Sun, 2 Jun 2024 11:40:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 10/20] function_graph: Have the instances use their own
 ftrace_ops for filtering
Message-Id: <20240602114032.fefbbbfdc8e743b3a148a919@kernel.org>
In-Reply-To: <20240531184910.799635e8@rorschach.local.home>
References: <20240525023652.903909489@goodmis.org>
	<20240525023742.786834257@goodmis.org>
	<20240530223057.21c2a779@rorschach.local.home>
	<20240531121241.c586189caad8d31d597f614d@kernel.org>
	<20240531020346.6c13e2d4@rorschach.local.home>
	<20240531235023.a0b2b207362eba2f8b5c16f7@kernel.org>
	<20240531184910.799635e8@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 18:49:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 31 May 2024 23:50:23 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So is it similar to the fprobe/kprobe, use shared signle ftrace_ops,
> > but keep each fgraph has own hash table?
> 
> Sort of.
> 
> I created helper functions in ftrace that lets you have a "manager
> ftrace_ops" that will be used to assign to ftrace (with the function
> that will demultiplex), and then you can have "subops" that can be
> assigned that is per user. Here's a glimpse of the code:
> 
> /**
>  * ftrace_startup_subops - enable tracing for subops of an ops
>  * @ops: Manager ops (used to pick all the functions of its subops)
>  * @subops: A new ops to add to @ops
>  * @command: Extra commands to use to enable tracing
>  *
>  * The @ops is a manager @ops that has the filter that includes all the functions
>  * that its list of subops are tracing. Adding a new @subops will add the
>  * functions of @subops to @ops.
>  */
> int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
> {
> 	struct ftrace_hash *filter_hash;
> 	struct ftrace_hash *notrace_hash;
> 	struct ftrace_hash *save_filter_hash;
> 	struct ftrace_hash *save_notrace_hash;
> 	int size_bits;
> 	int ret;
> 
> 	if (unlikely(ftrace_disabled))
> 		return -ENODEV;
> 
> 	ftrace_ops_init(ops);
> 	ftrace_ops_init(subops);
> 
> 	/* Make everything canonical (Just in case!) */
> 	if (!ops->func_hash->filter_hash)
> 		ops->func_hash->filter_hash = EMPTY_HASH;
> 	if (!ops->func_hash->notrace_hash)
> 		ops->func_hash->notrace_hash = EMPTY_HASH;
> 	if (!subops->func_hash->filter_hash)
> 		subops->func_hash->filter_hash = EMPTY_HASH;
> 	if (!subops->func_hash->notrace_hash)
> 		subops->func_hash->notrace_hash = EMPTY_HASH;
> 
> 	/* For the first subops to ops just enable it normally */
> 	if (list_empty(&ops->subop_list)) {

May above ftrace_ops_init() clear this list up always?

> 		/* Just use the subops hashes */
> 		filter_hash = copy_hash(subops->func_hash->filter_hash);
> 		notrace_hash = copy_hash(subops->func_hash->notrace_hash);
> 		if (!filter_hash || !notrace_hash) {
> 			free_ftrace_hash(filter_hash);
> 			free_ftrace_hash(notrace_hash);
> 			return -ENOMEM;
> 		}
> 
> 		save_filter_hash = ops->func_hash->filter_hash;
> 		save_notrace_hash = ops->func_hash->notrace_hash;
> 
> 		ops->func_hash->filter_hash = filter_hash;
> 		ops->func_hash->notrace_hash = notrace_hash;
> 		list_add(&subops->list, &ops->subop_list);
> 		ret = ftrace_startup(ops, command);
> 		if (ret < 0) {
> 			list_del(&subops->list);
> 			ops->func_hash->filter_hash = save_filter_hash;
> 			ops->func_hash->notrace_hash = save_notrace_hash;
> 			free_ftrace_hash(filter_hash);
> 			free_ftrace_hash(notrace_hash);
> 		} else {
> 			free_ftrace_hash(save_filter_hash);
> 			free_ftrace_hash(save_notrace_hash);
> 			subops->flags |= FTRACE_OPS_FL_ENABLED;
> 		}
> 		return ret;
> 	}
> 
> 	/*
> 	 * Here there's already something attached. Here are the rules:
> 	 *   o If either filter_hash is empty then the final stays empty
> 	 *      o Otherwise, the final is a superset of both hashes
> 	 *   o If either notrace_hash is empty then the final stays empty
> 	 *      o Otherwise, the final is an intersection between the hashes

Yeah, filter_hash |= subops_filter_hash and notrace_hash &= subops_notrace_hash.
The complicated point is filter's EMPTY_HASH means FULLSET_HASH. :)

> 	 */
> 	if (ops->func_hash->filter_hash == EMPTY_HASH ||
> 	    subops->func_hash->filter_hash == EMPTY_HASH) {
> 		filter_hash = EMPTY_HASH;
> 	} else {
> 		size_bits = max(ops->func_hash->filter_hash->size_bits,
> 				subops->func_hash->filter_hash->size_bits);

Don't we need to expand the size_bits? In the worst case, both hash does not
share any entry, then it should be expanded.

> 		filter_hash = alloc_and_copy_ftrace_hash(size_bits, ops->func_hash->filter_hash);
> 		if (!filter_hash)
> 			return -ENOMEM;
> 		ret = append_hash(&filter_hash, subops->func_hash->filter_hash);
> 		if (ret < 0) {
> 			free_ftrace_hash(filter_hash);
> 			return ret;
> 		}
> 	}
> 
> 	if (ops->func_hash->notrace_hash == EMPTY_HASH ||
> 	    subops->func_hash->notrace_hash == EMPTY_HASH) {
> 		notrace_hash = EMPTY_HASH;
> 	} else {
> 		size_bits = max(ops->func_hash->filter_hash->size_bits,
> 				subops->func_hash->filter_hash->size_bits);
> 		notrace_hash = alloc_ftrace_hash(size_bits);
> 		if (!notrace_hash) {
> 			free_ftrace_hash(filter_hash);
> 			return -ENOMEM;
> 		}
> 
> 		ret = intersect_hash(&notrace_hash, ops->func_hash->filter_hash,
> 				     subops->func_hash->filter_hash);
> 		if (ret < 0) {
> 			free_ftrace_hash(filter_hash);
> 			free_ftrace_hash(notrace_hash);
> 			return ret;
> 		}
> 	}
> 
> 	list_add(&subops->list, &ops->subop_list);
> 
> 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
> 	free_ftrace_hash(filter_hash);
> 	free_ftrace_hash(notrace_hash);
> 	if (ret < 0)
> 		list_del(&subops->list);
> 	return ret;
> }
> 
> /**
>  * ftrace_shutdown_subops - Remove a subops from a manager ops
>  * @ops: A manager ops to remove @subops from
>  * @subops: The subops to remove from @ops
>  * @command: Any extra command flags to add to modifying the text
>  *
>  * Removes the functions being traced by the @subops from @ops. Note, it
>  * will not affect functions that are being traced by other subops that
>  * still exist in @ops.
>  *
>  * If the last subops is removed from @ops, then @ops is shutdown normally.
>  */
> int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
> {
> 	struct ftrace_hash *filter_hash;
> 	struct ftrace_hash *notrace_hash;
> 	int ret;
> 
> 	if (unlikely(ftrace_disabled))
> 		return -ENODEV;
> 
> 	list_del(&subops->list);
> 
> 	if (list_empty(&ops->subop_list)) {
> 		/* Last one, just disable the current ops */
> 
> 		ret = ftrace_shutdown(ops, command);
> 		if (ret < 0) {
> 			list_add(&subops->list, &ops->subop_list);
> 			return ret;
> 		}
> 
> 		subops->flags &= ~FTRACE_OPS_FL_ENABLED;
> 
> 		free_ftrace_hash(ops->func_hash->filter_hash);
> 		free_ftrace_hash(ops->func_hash->notrace_hash);
> 		ops->func_hash->filter_hash = EMPTY_HASH;
> 		ops->func_hash->notrace_hash = EMPTY_HASH;
> 
> 		return 0;
> 	}
> 
> 	/* Rebuild the hashes without subops */
> 	filter_hash = append_hashes(ops);
> 	notrace_hash = intersect_hashes(ops);
> 	if (!filter_hash || !notrace_hash) {
> 		free_ftrace_hash(filter_hash);
> 		free_ftrace_hash(notrace_hash);
> 		list_add(&subops->list, &ops->subop_list);
> 		return -ENOMEM;
> 	}
> 
> 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
> 	if (ret < 0)
> 		list_add(&subops->list, &ops->subop_list);
> 	free_ftrace_hash(filter_hash);
> 	free_ftrace_hash(notrace_hash);
> 	return ret;
> }

OK, so if the list_is_singlar(ops->subop_list), ftrace_graph_enter_ops() is
called and if not, ftrace_graph_enter() is called, right?

Thank you,

> 
> 
> > 
> > > This removes the need to touch the architecture code. It can also be
> > > used by fprobes to handle the attachments to functions for several
> > > different sets of callbacks.
> > > 
> > > I'll send out patches soon.  
> > 
> > OK, I'll wait for that.
> 
> I'm just cleaning it up. I'll post it tomorrow (your today).
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

