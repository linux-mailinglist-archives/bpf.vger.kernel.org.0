Return-Path: <bpf+bounces-31337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351018FB626
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B622A1F2771B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE4143C5A;
	Tue,  4 Jun 2024 14:44:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0813A863;
	Tue,  4 Jun 2024 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512289; cv=none; b=p2jlfGKL8KD6cUZA5Vm8/DvvOsK9EGojqblcgOi54uk8kKceiqgQg2QkNQL/07N2itJzSDGlPOEXqmpk2uEWs6/NNTAiNqamErN/eLQw2E2y/pGW6U5mXiBDqcBSbpLIOGBq4VycC2z5+K6VxAvy05u2Wnv0+NhH7Q5YRb02/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512289; c=relaxed/simple;
	bh=Ptj2vnRcn+8Koe3QLVKz3J3lbtlSAOO3krekDH4wPXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJVsxO1TY/eyclOTBfXL3hS4j43QMIGgWCyx/BLgQLJthax0kAo/dXIBK+OiZ5K6AZuwUYQ/NSL70XVoI//ZngiU9Fl0RvygTnBAZcLh63HKP/bNCOPmQBpEV0kPvjtzZANlB8Jwdfp1uyMuCdtxrDMlF7iSd0rESQyiKIB7nnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF03A1042;
	Tue,  4 Jun 2024 07:45:10 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DF283F64C;
	Tue,  4 Jun 2024 07:44:43 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:44:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <Zl8oWNhkEPleJ3B_@J2N7QTR9R3>
References: <20240603190704.663840775@goodmis.org>
 <20240604081850.59267aa9@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604081850.59267aa9@rorschach.local.home>

Hi Steve, Masami,

On Tue, Jun 04, 2024 at 08:18:50AM -0400, Steven Rostedt wrote:
> 
> Masami,
> 
> This series passed all my tests, are you comfortable with me pushing
> them to linux-next?

As a heads-up (and not to block pushing this into next), I just gave
this a spin on arm64 atop v6.10-rc2, and running the selftests I see:

	ftrace - function pid filters
	(instance)  ftrace - function pid filters

... both go from [PASS] to [FAIL].

Everything else looks good -- I'll go dig into why that's happening.

It's possible that's just something odd with the filesystem I'm using
(e.g. the wnership test failed because this lacks 'stat').

Mark.

> 
> -- Steve
> 
> 
> On Mon, 03 Jun 2024 15:07:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This is a continuation of the function graph multi user code.
> > I wrote a proof of concept back in 2019 of this code[1] and
> > Masami started cleaning it up. I started from Masami's work v10
> > that can be found here:
> > 
> >  https://lore.kernel.org/linux-trace-kernel/171509088006.162236.7227326999861366050.stgit@devnote2/
> > 
> > This is *only* the code that allows multiple users of function
> > graph tracing. This is not the fprobe work that Masami is working
> > to add on top of it. As Masami took my proof of concept, there
> > was still several things I disliked about that code. Instead of
> > having Masami clean it up even more, I decided to take over on just
> > my code and change it up a bit.
> > 
> > Changes since v2: https://lore.kernel.org/linux-trace-kernel/20240602033744.563858532@goodmis.org
> > 
> > - Added comments describing which hashes the append and intersect
> >   functions were used for.
> > 
> > - Replaced checks of (NULL or EMPTY_HASH) with ftrace_hash_empty()
> >   helper function.
> > 
> > - Added check at the end of intersect_hash() to convert the hash
> >   to EMPTY hash if it doesn't have any functions.
> > 
> > - Renamed compare_ops() to ops_equal() and return boolean (inversed return
> >   value).
> > 
> > - Broke out __ftrace_hash_move_and_update_ops() to use in both
> >   ftrace_hash_move_and_update_ops() and ftrace_hash_move_and_update_subops().
> > 
> > Diff between last version at end of this email.
> > 
> > Masami Hiramatsu (Google) (3):
> >       function_graph: Handle tail calls for stack unwinding
> >       function_graph: Use a simple LRU for fgraph_array index number
> >       ftrace: Add multiple fgraph storage selftest
> > 
> > Steven Rostedt (Google) (9):
> >       ftrace: Add subops logic to allow one ops to manage many
> >       ftrace: Allow subops filtering to be modified
> >       function_graph: Add pid tracing back to function graph tracer
> >       function_graph: Use for_each_set_bit() in __ftrace_return_to_handler()
> >       function_graph: Use bitmask to loop on fgraph entry
> >       function_graph: Use static_call and branch to optimize entry function
> >       function_graph: Use static_call and branch to optimize return function
> >       selftests/ftrace: Add function_graph tracer to func-filter-pid test
> >       selftests/ftrace: Add fgraph-multi.tc test
> > 
> > Steven Rostedt (VMware) (15):
> >       function_graph: Convert ret_stack to a series of longs
> >       fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
> >       function_graph: Add an array structure that will allow multiple callbacks
> >       function_graph: Allow multiple users to attach to function graph
> >       function_graph: Remove logic around ftrace_graph_entry and return
> >       ftrace/function_graph: Pass fgraph_ops to function graph callbacks
> >       ftrace: Allow function_graph tracer to be enabled in instances
> >       ftrace: Allow ftrace startup flags to exist without dynamic ftrace
> >       function_graph: Have the instances use their own ftrace_ops for filtering
> >       function_graph: Add "task variables" per task for fgraph_ops
> >       function_graph: Move set_graph_function tests to shadow stack global var
> >       function_graph: Move graph depth stored data to shadow stack global var
> >       function_graph: Move graph notrace bit to shadow stack global var
> >       function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
> >       function_graph: Add selftest for passing local variables
> > 
> > ----
> >  include/linux/ftrace.h                             |   43 +-
> >  include/linux/sched.h                              |    2 +-
> >  include/linux/trace_recursion.h                    |   39 -
> >  kernel/trace/fgraph.c                              | 1044 ++++++++++++++++----
> >  kernel/trace/ftrace.c                              |  522 +++++++++-
> >  kernel/trace/ftrace_internal.h                     |    5 +-
> >  kernel/trace/trace.h                               |   94 +-
> >  kernel/trace/trace_functions.c                     |    8 +
> >  kernel/trace/trace_functions_graph.c               |   96 +-
> >  kernel/trace/trace_irqsoff.c                       |   10 +-
> >  kernel/trace/trace_sched_wakeup.c                  |   10 +-
> >  kernel/trace/trace_selftest.c                      |  259 ++++-
> >  .../selftests/ftrace/test.d/ftrace/fgraph-multi.tc |  103 ++
> >  .../ftrace/test.d/ftrace/func-filter-pid.tc        |   27 +-
> >  14 files changed, 1945 insertions(+), 317 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
> > 
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 41fabc6d30e4..da7e6abf48b4 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3170,7 +3170,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
> >  /* Simply make a copy of @src and return it */
> >  static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
> >  {
> > -	if (!src || src == EMPTY_HASH)
> > +	if (ftrace_hash_empty(src))
> >  		return EMPTY_HASH;
> >  
> >  	return alloc_and_copy_ftrace_hash(src->size_bits, src);
> > @@ -3187,6 +3187,9 @@ static struct ftrace_hash *copy_hash(struct ftrace_hash *src)
> >   *
> >   *  Otherwise, go through all of @new_hash and add anything that @hash
> >   *  doesn't already have, to @hash.
> > + *
> > + *  The filter_hash updates uses just the append_hash() function
> > + *  and the notrace_hash does not.
> >   */
> >  static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
> >  {
> > @@ -3195,11 +3198,11 @@ static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
> >  	int i;
> >  
> >  	/* An empty hash does everything */
> > -	if (!*hash || *hash == EMPTY_HASH)
> > +	if (ftrace_hash_empty(*hash))
> >  		return 0;
> >  
> >  	/* If new_hash has everything make hash have everything */
> > -	if (!new_hash || new_hash == EMPTY_HASH) {
> > +	if (ftrace_hash_empty(new_hash)) {
> >  		free_ftrace_hash(*hash);
> >  		*hash = EMPTY_HASH;
> >  		return 0;
> > @@ -3217,7 +3220,12 @@ static int append_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash)
> >  	return 0;
> >  }
> >  
> > -/* Add to @hash only those that are in both @new_hash1 and @new_hash2 */
> > +/*
> > + * Add to @hash only those that are in both @new_hash1 and @new_hash2
> > + *
> > + * The notrace_hash updates uses just the intersect_hash() function
> > + * and the filter_hash does not.
> > + */
> >  static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_hash1,
> >  			  struct ftrace_hash *new_hash2)
> >  {
> > @@ -3229,8 +3237,7 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
> >  	 * If new_hash1 or new_hash2 is the EMPTY_HASH then make the hash
> >  	 * empty as well as empty for notrace means none are notraced.
> >  	 */
> > -	if (!new_hash1 || new_hash1 == EMPTY_HASH ||
> > -	    !new_hash2 || new_hash2 == EMPTY_HASH) {
> > +	if (ftrace_hash_empty(new_hash1) || ftrace_hash_empty(new_hash2)) {
> >  		free_ftrace_hash(*hash);
> >  		*hash = EMPTY_HASH;
> >  		return 0;
> > @@ -3245,6 +3252,11 @@ static int intersect_hash(struct ftrace_hash **hash, struct ftrace_hash *new_has
> >  				return -ENOMEM;
> >  		}
> >  	}
> > +	/* If nothing intersects, make it the empty set */
> > +	if (ftrace_hash_empty(*hash)) {
> > +		free_ftrace_hash(*hash);
> > +		*hash = EMPTY_HASH;
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -3266,7 +3278,7 @@ static struct ftrace_hash *append_hashes(struct ftrace_ops *ops)
> >  			return NULL;
> >  		}
> >  		/* Nothing more to do if new_hash is empty */
> > -		if (new_hash == EMPTY_HASH)
> > +		if (ftrace_hash_empty(new_hash))
> >  			break;
> >  	}
> >  	return new_hash;
> > @@ -3300,59 +3312,76 @@ static struct ftrace_hash *intersect_hashes(struct ftrace_ops *ops)
> >  			return NULL;
> >  		}
> >  		/* Nothing more to do if new_hash is empty */
> > -		if (new_hash == EMPTY_HASH)
> > +		if (ftrace_hash_empty(new_hash))
> >  			break;
> >  	}
> >  	return new_hash;
> >  }
> >  
> > -/* Returns 0 on equal or non-zero on non-equal */
> > -static int compare_ops(struct ftrace_hash *A, struct ftrace_hash *B)
> > +static bool ops_equal(struct ftrace_hash *A, struct ftrace_hash *B)
> >  {
> >  	struct ftrace_func_entry *entry;
> >  	int size;
> >  	int i;
> >  
> > -	if (!A || A == EMPTY_HASH)
> > -		return !(!B || B == EMPTY_HASH);
> > +	if (ftrace_hash_empty(A))
> > +		return ftrace_hash_empty(B);
> >  
> > -	if (!B || B == EMPTY_HASH)
> > -		return !(!A || A == EMPTY_HASH);
> > +	if (ftrace_hash_empty(B))
> > +		return ftrace_hash_empty(A);
> >  
> >  	if (A->count != B->count)
> > -		return 1;
> > +		return false;
> >  
> >  	size = 1 << A->size_bits;
> >  	for (i = 0; i < size; i++) {
> >  		hlist_for_each_entry(entry, &A->buckets[i], hlist) {
> >  			if (!__ftrace_lookup_ip(B, entry->ip))
> > -				return 1;
> > +				return false;
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	return true;
> >  }
> >  
> > -static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
> > -					   struct ftrace_hash **orig_hash,
> > -					   struct ftrace_hash *hash,
> > -					   int enable);
> > +static void ftrace_ops_update_code(struct ftrace_ops *ops,
> > +				   struct ftrace_ops_hash *old_hash);
> > +
> > +static int __ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
> > +					     struct ftrace_hash **orig_hash,
> > +					     struct ftrace_hash *hash,
> > +					     int enable)
> > +{
> > +	struct ftrace_ops_hash old_hash_ops;
> > +	struct ftrace_hash *old_hash;
> > +	int ret;
> > +
> > +	old_hash = *orig_hash;
> > +	old_hash_ops.filter_hash = ops->func_hash->filter_hash;
> > +	old_hash_ops.notrace_hash = ops->func_hash->notrace_hash;
> > +	ret = ftrace_hash_move(ops, enable, orig_hash, hash);
> > +	if (!ret) {
> > +		ftrace_ops_update_code(ops, &old_hash_ops);
> > +		free_ftrace_hash_rcu(old_hash);
> > +	}
> > +	return ret;
> > +}
> >  
> >  static int ftrace_update_ops(struct ftrace_ops *ops, struct ftrace_hash *filter_hash,
> >  			     struct ftrace_hash *notrace_hash)
> >  {
> >  	int ret;
> >  
> > -	if (compare_ops(filter_hash, ops->func_hash->filter_hash)) {
> > -		ret = ftrace_hash_move_and_update_ops(ops, &ops->func_hash->filter_hash,
> > -						      filter_hash, 1);
> > +	if (!ops_equal(filter_hash, ops->func_hash->filter_hash)) {
> > +		ret = __ftrace_hash_move_and_update_ops(ops, &ops->func_hash->filter_hash,
> > +							filter_hash, 1);
> >  		if (ret < 0)
> >  			return ret;
> >  	}
> >  
> > -	if (compare_ops(notrace_hash, ops->func_hash->notrace_hash)) {
> > -		ret = ftrace_hash_move_and_update_ops(ops, &ops->func_hash->notrace_hash,
> > -						      notrace_hash, 0);
> > +	if (!ops_equal(notrace_hash, ops->func_hash->notrace_hash)) {
> > +		ret = __ftrace_hash_move_and_update_ops(ops, &ops->func_hash->notrace_hash,
> > +							notrace_hash, 0);
> >  		if (ret < 0)
> >  			return ret;
> >  	}
> > @@ -3438,8 +3467,8 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
> >  	 *   o If either notrace_hash is empty then the final stays empty
> >  	 *      o Otherwise, the final is an intersection between the hashes
> >  	 */
> > -	if (ops->func_hash->filter_hash == EMPTY_HASH ||
> > -	    subops->func_hash->filter_hash == EMPTY_HASH) {
> > +	if (ftrace_hash_empty(ops->func_hash->filter_hash) ||
> > +	    ftrace_hash_empty(subops->func_hash->filter_hash)) {
> >  		filter_hash = EMPTY_HASH;
> >  	} else {
> >  		size_bits = max(ops->func_hash->filter_hash->size_bits,
> > @@ -3454,8 +3483,8 @@ int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int
> >  		}
> >  	}
> >  
> > -	if (ops->func_hash->notrace_hash == EMPTY_HASH ||
> > -	    subops->func_hash->notrace_hash == EMPTY_HASH) {
> > +	if (ftrace_hash_empty(ops->func_hash->notrace_hash) ||
> > +	    ftrace_hash_empty(subops->func_hash->notrace_hash)) {
> >  		notrace_hash = EMPTY_HASH;
> >  	} else {
> >  		size_bits = max(ops->func_hash->filter_hash->size_bits,
> > @@ -3591,7 +3620,7 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
> >  	}
> >  
> >  	/* Move the hash over to the new hash */
> > -	ret = ftrace_hash_move_and_update_ops(ops, orig_hash, new_hash, enable);
> > +	ret = __ftrace_hash_move_and_update_ops(ops, orig_hash, new_hash, enable);
> >  
> >  	free_ftrace_hash(new_hash);
> >  
> > @@ -4822,11 +4851,6 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
> >  					   struct ftrace_hash *hash,
> >  					   int enable)
> >  {
> > -	struct ftrace_ops_hash old_hash_ops;
> > -	struct ftrace_hash *old_hash;
> > -	struct ftrace_ops *op;
> > -	int ret;
> > -
> >  	if (ops->flags & FTRACE_OPS_FL_SUBOP)
> >  		return ftrace_hash_move_and_update_subops(ops, orig_hash, hash, enable);
> >  
> > @@ -4838,6 +4862,8 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
> >  	 * it will not affect subops that share it.
> >  	 */
> >  	if (!(ops->flags & FTRACE_OPS_FL_ENABLED)) {
> > +		struct ftrace_ops *op;
> > +
> >  		/* Check if any other manager subops maps to this hash */
> >  		do_for_each_ftrace_op(op, ftrace_ops_list) {
> >  			struct ftrace_ops *subops;
> > @@ -4851,15 +4877,7 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
> >  		} while_for_each_ftrace_op(op);
> >  	}
> >  
> > -	old_hash = *orig_hash;
> > -	old_hash_ops.filter_hash = ops->func_hash->filter_hash;
> > -	old_hash_ops.notrace_hash = ops->func_hash->notrace_hash;
> > -	ret = ftrace_hash_move(ops, enable, orig_hash, hash);
> > -	if (!ret) {
> > -		ftrace_ops_update_code(ops, &old_hash_ops);
> > -		free_ftrace_hash_rcu(old_hash);
> > -	}
> > -	return ret;
> > +	return __ftrace_hash_move_and_update_ops(ops, orig_hash, hash, enable);
> >  }
> >  
> >  static bool module_exists(const char *module)
> 

