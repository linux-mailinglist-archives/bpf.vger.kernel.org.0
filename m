Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892C919D769
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDCNQr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Apr 2020 09:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgDCNQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Apr 2020 09:16:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B8620721;
        Fri,  3 Apr 2020 13:16:44 +0000 (UTC)
Date:   Fri, 3 Apr 2020 09:16:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20200403091642.5ce182f1@gandalf.local.home>
In-Reply-To: <20200403154702.bc3478c84d70fb48b07d9985@kernel.org>
References: <20200319232731.799117803@goodmis.org>
        <20200326091256.GR11705@shao2-debian>
        <20200401230700.d9ddb42b3459dca98144b55c@kernel.org>
        <20200401102112.35036490@gandalf.local.home>
        <20200401110401.23cda3b3@gandalf.local.home>
        <20200402161920.3b3649cac4cc47a52679d69b@kernel.org>
        <20200402141440.7868465a@gandalf.local.home>
        <20200403154702.bc3478c84d70fb48b07d9985@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 3 Apr 2020 15:47:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +#define STATIC_TEMP_BUF_SIZE	128
> > +static char static_temp_buf[STATIC_TEMP_BUF_SIZE];
> > +
> >  /* Find the next real entry, without updating the iterator itself */
> >  struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
> >  					  int *ent_cpu, u64 *ent_ts)
> > @@ -3480,13 +3483,26 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
> >  	int ent_size = iter->ent_size;
> >  	struct trace_entry *entry;
> >  
> > +	/*
> > +	 * If called from ftrace_dump(), then the iter->temp buffer
> > +	 * will be the static_temp_buf and not created from kmalloc.
> > +	 * If the entry size is greater than the buffer, we can
> > +	 * not save it. Just return NULL in that case. This is only
> > +	 * used to add markers when two consecutive events' time
> > +	 * stamps have a large delta. See trace_print_lat_context()
> > +	 */
> > +	if (iter->temp == static_temp_buf &&
> > +	    STATIC_TEMP_BUF_SIZE < ent_size)
> > +		return NULL;
> > +
> >  	/*
> >  	 * The __find_next_entry() may call peek_next_entry(), which may
> >  	 * call ring_buffer_peek() that may make the contents of iter->ent
> >  	 * undefined. Need to copy iter->ent now.
> >  	 */
> >  	if (iter->ent && iter->ent != iter->temp) {
> > -		if (!iter->temp || iter->temp_size < iter->ent_size) {
> > +		if ((!iter->temp || iter->temp_size < iter->ent_size) &&
> > +		    !WARN_ON_ONCE(iter->temp == static_temp_buf)) {  
> 
> This must not happen because ent_size == iter->ent_size.
> If it happens, it should return NULL without any trial of kfree() and
> kmalloc(), becuase it will cause illegal freeing memory and memory leak.
> (Note that the iter->temp never be freed in ftrace_dump() path)

Correct, which is why there's a ! in there. It's a paranoid check which
should never trigger, which is why there's a WARN_ON_ONCE() there. But as
the "!" is not easy to see, the above is the same logic as:

	if ((!iter->temp || iter->temp_size < iter->ent_size) &&
	    (iter->temp != static_temp_buf)) {

Thus, if we get to that test against static_temp_buf, and it's true, then
we will trigger the WARN_ON, but it wont call the kfree().

> 
> Anyway, this condition is completery same as above return code.
> 
> >  			kfree(iter->temp);
> >  			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
> >  			if (!iter->temp)
> > @@ -9203,6 +9219,8 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
> >  
> >  	/* Simulate the iterator */
> >  	trace_init_global_iter(&iter);
> > +	/* Can not use kmalloc for iter.temp */
> > +	iter.temp = static_temp_buf;
> >    
> 
> You may miss initializing temp_size here.
> 
> 	iter.temp_size = STATIC_TEMP_BUF_SIZE;

Oh, damn! You're right.

> 
> BTW, as I pointed, if the iter->temp is for avoiding the data overwritten
> by ringbuffer writer, would we need to use it for ftrace_dump() too?
> It seems that ftrace_dump() stops tracing.

Yes, it is still needed. That's because the old way use to just leave the
iter->ent pointing into the ring buffer itself. The new way, the ring
buffer makes a copy of the event, and passes that back. When you do another
read, it overwrites the copy. It doesn't matter if the ring buffer is
stopped or not.

-- Steve
