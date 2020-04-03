Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F2819D065
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbgDCGrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Apr 2020 02:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgDCGrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Apr 2020 02:47:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40AF20757;
        Fri,  3 Apr 2020 06:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585896428;
        bh=pH88KhBdvERtHIQrXwfteh4qDqoIqDikijEQK88Iyg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=moHgyHc043Z2sssks/XsHG5eYn3t0lziLooFnsnaPUJjfhcUi92SlTMIXQPgIRIy/
         t9PXMCU4/hLyfu0QRjbNf1MCeFoaIktNUiTsYkC9ABsua0i9isc1aFsV80euPMGKd/
         YV1o/bOLb5Jl5VJ802N73brn2TiRJ5N0YxtblDr0=
Date:   Fri, 3 Apr 2020 15:47:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [tracing] cd8f62b481:
 BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
Message-Id: <20200403154702.bc3478c84d70fb48b07d9985@kernel.org>
In-Reply-To: <20200402141440.7868465a@gandalf.local.home>
References: <20200319232731.799117803@goodmis.org>
        <20200326091256.GR11705@shao2-debian>
        <20200401230700.d9ddb42b3459dca98144b55c@kernel.org>
        <20200401102112.35036490@gandalf.local.home>
        <20200401110401.23cda3b3@gandalf.local.home>
        <20200402161920.3b3649cac4cc47a52679d69b@kernel.org>
        <20200402141440.7868465a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 Apr 2020 14:14:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 2 Apr 2020 16:19:20 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Wed, 1 Apr 2020 11:04:01 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Wed, 1 Apr 2020 10:21:12 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >   
> > > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > > index 6519b7afc499..7f1466253ca8 100644
> > > > --- a/kernel/trace/trace.c
> > > > +++ b/kernel/trace/trace.c
> > > > @@ -3487,6 +3487,14 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
> > > >  	 */
> > > >  	if (iter->ent && iter->ent != iter->temp) {
> > > >  		if (!iter->temp || iter->temp_size < iter->ent_size) {
> > > > +			/*
> > > > +			 * This function is only used to add markers between
> > > > +			 * events that are far apart (see trace_print_lat_context()),
> > > > +			 * but if this is called in an atomic context (like NMIs)
> > > > +			 * we can't call kmalloc(), thus just return NULL.
> > > > +			 */
> > > > +			if (in_atomic() || irqs_disabled())
> > > > +				return NULL;
> > > >  			kfree(iter->temp);
> > > >  			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
> > > >  			if (!iter->temp)  
> > > 
> > > Peter informed me on IRC not to use in_atomic() as it doesn't catch
> > > spin_locks when CONFIG_PREEMPT is not defined.
> > > 
> > > As the issue is just with ftrace_dump(), I'll have it use a static buffer
> > > instead of 128 bytes. Which should be big enough for most events, and if
> > > not, then it will just miss the markers.  
> > 
> > 
> > That sounds good, but the below patch seems to do different thing.
> > Does it just makes trace_find_next_entry() always fail if it is
> > called from ftrace_dump()?
> 
> Bah! I send my emails on a different machine than I create the patches on.
> Below was my first iteration, then I decided to at least try to print some,
> changed it, but never copied the new version over, and ended up sending the
> last one.
> 

Ah, got it :)

> Here's the actual patch!
> 
> -- Steve
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Subject: [PATCH] tracing: Do not allocate buffer in trace_find_next_entry() in
>  atomic
> 
> When dumping out the trace data in latency format, a check is made to peek
> at the next event to compare its timestamp to the current one, and if the
> delta is of a greater size, it will add a marker showing so. But to do this,
> it needs to save the current event otherwise peeking at the next event will
> remove the current event. To save the event, a temp buffer is used, and if
> the event is bigger than the temp buffer, the temp buffer is freed and a
> bigger buffer is allocated.
> 
> This allocation is a problem when called in atomic context. The only way
> this gets called via atomic context is via ftrace_dump(). Thus, use a static
> buffer of 128 bytes (which covers most events), and if the event is bigger
> than that, simply return NULL. The callers of trace_find_next_entry() need
> to handle a NULL case, as that's what would happen if the allocation failed.
> 
> Link: https://lore.kernel.org/r/20200326091256.GR11705@shao2-debian
> 
> Fixes: ff895103a84ab ("tracing: Save off entry when peeking at next entry")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6519b7afc499..4b7bbfe7f809 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3472,6 +3472,9 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
>  	return next;
>  }
>  
> +#define STATIC_TEMP_BUF_SIZE	128
> +static char static_temp_buf[STATIC_TEMP_BUF_SIZE];
> +
>  /* Find the next real entry, without updating the iterator itself */
>  struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
>  					  int *ent_cpu, u64 *ent_ts)
> @@ -3480,13 +3483,26 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
>  	int ent_size = iter->ent_size;
>  	struct trace_entry *entry;
>  
> +	/*
> +	 * If called from ftrace_dump(), then the iter->temp buffer
> +	 * will be the static_temp_buf and not created from kmalloc.
> +	 * If the entry size is greater than the buffer, we can
> +	 * not save it. Just return NULL in that case. This is only
> +	 * used to add markers when two consecutive events' time
> +	 * stamps have a large delta. See trace_print_lat_context()
> +	 */
> +	if (iter->temp == static_temp_buf &&
> +	    STATIC_TEMP_BUF_SIZE < ent_size)
> +		return NULL;
> +
>  	/*
>  	 * The __find_next_entry() may call peek_next_entry(), which may
>  	 * call ring_buffer_peek() that may make the contents of iter->ent
>  	 * undefined. Need to copy iter->ent now.
>  	 */
>  	if (iter->ent && iter->ent != iter->temp) {
> -		if (!iter->temp || iter->temp_size < iter->ent_size) {
> +		if ((!iter->temp || iter->temp_size < iter->ent_size) &&
> +		    !WARN_ON_ONCE(iter->temp == static_temp_buf)) {

This must not happen because ent_size == iter->ent_size.
If it happens, it should return NULL without any trial of kfree() and
kmalloc(), becuase it will cause illegal freeing memory and memory leak.
(Note that the iter->temp never be freed in ftrace_dump() path)

Anyway, this condition is completery same as above return code.

>  			kfree(iter->temp);
>  			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
>  			if (!iter->temp)
> @@ -9203,6 +9219,8 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  
>  	/* Simulate the iterator */
>  	trace_init_global_iter(&iter);
> +	/* Can not use kmalloc for iter.temp */
> +	iter.temp = static_temp_buf;
>  

You may miss initializing temp_size here.

	iter.temp_size = STATIC_TEMP_BUF_SIZE;

BTW, as I pointed, if the iter->temp is for avoiding the data overwritten
by ringbuffer writer, would we need to use it for ftrace_dump() too?
It seems that ftrace_dump() stops tracing.

void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
{
[...]
        /* Only allow one dump user at a time. */
        if (atomic_inc_return(&dump_running) != 1) {
                atomic_dec(&dump_running);
                return;
        }

        /*
         * Always turn off tracing when we dump.
         * We don't need to show trace output of what happens
         * between multiple crashes.
         *
         * If the user does a sysrq-z, then they can re-enable
         * tracing with echo 1 > tracing_on.
         */
        tracing_off();



Thank you,


>  	for_each_tracing_cpu(cpu) {
>  		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
