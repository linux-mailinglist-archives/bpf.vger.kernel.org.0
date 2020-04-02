Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F9219BC89
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgDBHT1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 03:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgDBHT1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 03:19:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4138020678;
        Thu,  2 Apr 2020 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585811966;
        bh=u1AoeBtkiI8pGLI1x4tXxgrHRP3Rin/Lv6nGCZDiQIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vlOoIzUOdlCRg7heX0rIUtCnCly75JpAGWEGtamgSu9kRaJKwTlqwy6Kdhmd9cXlY
         wTD44Ag9Snkw9b8N0XxyNWFJxwrDb9v3ETbeXjVBFPk0lI+mQ38pUGh0q6sQFRzwsc
         c42hdxdH9P1VtJygzFCAN8Ar3Q06xRqFgNEQcr7g=
Date:   Thu, 2 Apr 2020 16:19:20 +0900
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
Message-Id: <20200402161920.3b3649cac4cc47a52679d69b@kernel.org>
In-Reply-To: <20200401110401.23cda3b3@gandalf.local.home>
References: <20200319232731.799117803@goodmis.org>
        <20200326091256.GR11705@shao2-debian>
        <20200401230700.d9ddb42b3459dca98144b55c@kernel.org>
        <20200401102112.35036490@gandalf.local.home>
        <20200401110401.23cda3b3@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 1 Apr 2020 11:04:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Apr 2020 10:21:12 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 6519b7afc499..7f1466253ca8 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -3487,6 +3487,14 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
> >  	 */
> >  	if (iter->ent && iter->ent != iter->temp) {
> >  		if (!iter->temp || iter->temp_size < iter->ent_size) {
> > +			/*
> > +			 * This function is only used to add markers between
> > +			 * events that are far apart (see trace_print_lat_context()),
> > +			 * but if this is called in an atomic context (like NMIs)
> > +			 * we can't call kmalloc(), thus just return NULL.
> > +			 */
> > +			if (in_atomic() || irqs_disabled())
> > +				return NULL;
> >  			kfree(iter->temp);
> >  			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
> >  			if (!iter->temp)
> 
> Peter informed me on IRC not to use in_atomic() as it doesn't catch
> spin_locks when CONFIG_PREEMPT is not defined.
> 
> As the issue is just with ftrace_dump(), I'll have it use a static buffer
> instead of 128 bytes. Which should be big enough for most events, and if
> not, then it will just miss the markers.


That sounds good, but the below patch seems to do different thing.
Does it just makes trace_find_next_entry() always fail if it is
called from ftrace_dump()?

Thank you,

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6519b7afc499..8c9d6a75abbf 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3472,6 +3472,8 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
>  	return next;
>  }
>  
> +#define IGNORE_TEMP		((struct trace_iterator *)-1L)
> +
>  /* Find the next real entry, without updating the iterator itself */
>  struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
>  					  int *ent_cpu, u64 *ent_ts)
> @@ -3480,6 +3482,17 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
>  	int ent_size = iter->ent_size;
>  	struct trace_entry *entry;
>  
> +	/*
> +	 * This function is only used to add markers between
> +	 * events that are far apart (see trace_print_lat_context()),
> +	 * but if this is called in an atomic context (like NMIs)
> +	 * kmalloc() can't be called.
> +	 * That happens via ftrace_dump() which will initialize
> +	 * iter->temp to IGNORE_TEMP. In such a case, just return NULL.
> +	 */
> +	if (iter->temp == IGNORE_TEMP)
> +		return NULL;
> +
>  	/*
>  	 * The __find_next_entry() may call peek_next_entry(), which may
>  	 * call ring_buffer_peek() that may make the contents of iter->ent
> @@ -9203,6 +9216,8 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
>  
>  	/* Simulate the iterator */
>  	trace_init_global_iter(&iter);
> +	/* Force not using the temp buffer */
> +	iter.temp = IGNORE_TEMP;
>  
>  	for_each_tracing_cpu(cpu) {
>  		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
