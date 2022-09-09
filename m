Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA435B3600
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIILFW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIILFV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F241D3E;
        Fri,  9 Sep 2022 04:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8238261CBE;
        Fri,  9 Sep 2022 11:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF05BC433C1;
        Fri,  9 Sep 2022 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662721518;
        bh=oG8hSgIGfbe54NnptnsKy7utblT30bTgUXBgdYfTVVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lreBTcqC42PJjKaWOHUmgwFsELIOQMW0Ocfscm/65Iz1U+FGM84VHa1jfMFrwzeU9
         qYuDOvfzfI3ufgWrXn6sCy+6jrcvZ2pjkz1iwvgS1drjGCGcZcD84kM6r0ziK19jh7
         jk3UzvrNGgEfwIAFQ+Ro0chCHNBp5kSF4UQW01wFAdgab08p1Ez0cbPpTJzbNuD18S
         dgtaPnCimww3jydVUlmNeM9+DPXQ185T6PDt8EPobJGnrvY2SwE3FPQ29d30ZdtFji
         mMU5jn6qK2k5vhFqHsA15SMUqUNWWARNhJYGf0QYuJMlXMZNuBs7O9o4rP0Pz9cfaY
         8MDvOqpyEUc8g==
Date:   Fri, 9 Sep 2022 20:05:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, corbet@lwn.net,
        mingo@redhat.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] tracing/kprobes: Add method to display private
 kprobes in tracefs
Message-Id: <20220909200514.31bd313c8a6fbd0b5150c2d1@kernel.org>
In-Reply-To: <CAFA-uR_u8Hvh1-pF_hxmsfMcZSoRvpKM-9P+24FY=74EoM_EUg@mail.gmail.com>
References: <20220725062334.1778-1-iecedge@gmail.com>
        <20220906111214.0dd113cd@gandalf.local.home>
        <20220907175136.96b05b241e650de21eb661e6@kernel.org>
        <CAFA-uR_u8Hvh1-pF_hxmsfMcZSoRvpKM-9P+24FY=74EoM_EUg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 9 Sep 2022 09:26:23 +0800
Jianlin Lv <iecedge@gmail.com> wrote:

> On Wed, Sep 7, 2022 at 4:51 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > [Adding bpf ML]
> >
> > On Tue, 6 Sep 2022 11:12:14 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > >
> > > [ Adding Masami and Tom ]
> > >
> > > On Mon, 25 Jul 2022 06:23:34 +0000
> > > Jianlin Lv <iecedge@gmail.com> wrote:
> > >
> > > > The private kprobes are not added to the global list dyn_event_list,
> > > > so there is a missing interface to show probe hit and probe miss.
> > > > This patch adds a profiling interface to check the number of hits or
> > > > misses for private kprobes.
> > >
> > > Masami, what do you think of this patch?
> >
> > I discussed it with BPF people when it was introduced and they didn't
> > want to show up it on tracefs because it is a private one. I agreed that.
> >
> > So I think this kind of interface must be managed by BPF subsystem.
> > Is there any API to manage the BPF probe points in BPF subsystem?
> >
> > Thank you,
> 
> As far as I know, there is no API to manage private kprobes in the BPF
> subsystem, so I added a tracefs interface to display private info.
> 
> Could you give me some hints about how to implement the current
> functionality in the BPF subsystem?

There is tools/bpf/bpftool, I think that is the best tool to implement
such feature. If hitcount is shown with the BPF program, it should be
more useful.

Thank you,

> 
> Regards,
> Jianlin
> 
> >
> > >
> > > -- Steve
> > >
> > > >
> > > > Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> > > > ---
> > > > v2: update commit message
> > > > ---
> > > >  Documentation/trace/kprobetrace.rst |  6 +++-
> > > >  kernel/trace/trace_dynevent.c       | 20 +++++++++++
> > > >  kernel/trace/trace_dynevent.h       | 37 ++++++++++++++++++++
> > > >  kernel/trace/trace_kprobe.c         | 54 +++++++++++++++++++++++++++++
> > > >  4 files changed, 116 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > > > index b175d88f31eb..8815d64dd8a6 100644
> > > > --- a/Documentation/trace/kprobetrace.rst
> > > > +++ b/Documentation/trace/kprobetrace.rst
> > > > @@ -146,7 +146,11 @@ trigger:
> > > >  Event Profiling
> > > >  ---------------
> > > >  You can check the total number of probe hits and probe miss-hits via
> > > > -/sys/kernel/debug/tracing/kprobe_profile.
> > > > +/sys/kernel/debug/tracing/kprobe_profile or
> > > > +/sys/kernel/debug/tracing/kprobe_local_profile.
> > > > +All kprobe events created by kprobe_events will be added to the global
> > > > +list, you can get their profiling via kprobe_profile; kprobe_local_profile
> > > > +shows profiling for private kprobe events created by perf_kprobe pmu.
> > > >  The first column is event name, the second is the number of probe hits,
> > > >  the third is the number of probe miss-hits.
> > > >
> > > > diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> > > > index 076b447a1b88..70ec99cd9c53 100644
> > > > --- a/kernel/trace/trace_dynevent.c
> > > > +++ b/kernel/trace/trace_dynevent.c
> > > > @@ -181,6 +181,26 @@ static const struct seq_operations dyn_event_seq_op = {
> > > >     .show   = dyn_event_seq_show
> > > >  };
> > > >
> > > > +#ifdef CONFIG_KPROBE_EVENTS
> > > > +LIST_HEAD(local_event_list);
> > > > +
> > > > +void *local_event_seq_start(struct seq_file *m, loff_t *pos)
> > > > +{
> > > > +   mutex_lock(&event_mutex);
> > > > +   return seq_list_start(&local_event_list, *pos);
> > > > +}
> > > > +
> > > > +void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
> > > > +{
> > > > +   return seq_list_next(v, &local_event_list, pos);
> > > > +}
> > > > +
> > > > +void local_event_seq_stop(struct seq_file *m, void *v)
> > > > +{
> > > > +   mutex_unlock(&event_mutex);
> > > > +}
> > > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > > +
> > > >  /*
> > > >   * dyn_events_release_all - Release all specific events
> > > >   * @type:  the dyn_event_operations * which filters releasing events
> > > > diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
> > > > index 936477a111d3..e30193470295 100644
> > > > --- a/kernel/trace/trace_dynevent.h
> > > > +++ b/kernel/trace/trace_dynevent.h
> > > > @@ -101,6 +101,43 @@ void dyn_event_seq_stop(struct seq_file *m, void *v);
> > > >  int dyn_events_release_all(struct dyn_event_operations *type);
> > > >  int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
> > > >
> > > > +#ifdef CONFIG_KPROBE_EVENTS
> > > > +extern struct list_head local_event_list;
> > > > +
> > > > +static inline
> > > > +int local_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
> > > > +{
> > > > +   if (!ev || !ops)
> > > > +           return -EINVAL;
> > > > +
> > > > +   INIT_LIST_HEAD(&ev->list);
> > > > +   ev->ops = ops;
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static inline int local_event_add(struct dyn_event *ev)
> > > > +{
> > > > +   lockdep_assert_held(&event_mutex);
> > > > +
> > > > +   if (!ev || !ev->ops)
> > > > +           return -EINVAL;
> > > > +
> > > > +   list_add_tail(&ev->list, &local_event_list);
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static inline void local_event_remove(struct dyn_event *ev)
> > > > +{
> > > > +   lockdep_assert_held(&event_mutex);
> > > > +   list_del_init(&ev->list);
> > > > +}
> > > > +
> > > > +void *local_event_seq_start(struct seq_file *m, loff_t *pos);
> > > > +void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
> > > > +void local_event_seq_stop(struct seq_file *m, void *v);
> > > > +
> > > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > > +
> > > >  /*
> > > >   * for_each_dyn_event      -       iterate over the dyn_event list
> > > >   * @pos:   the struct dyn_event * to use as a loop cursor
> > > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > > index a245ea673715..76f500b17b46 100644
> > > > --- a/kernel/trace/trace_kprobe.c
> > > > +++ b/kernel/trace/trace_kprobe.c
> > > > @@ -1213,6 +1213,52 @@ static const struct file_operations kprobe_profile_ops = {
> > > >     .release        = seq_release,
> > > >  };
> > > >
> > > > +#ifdef CONFIG_KPROBE_EVENTS
> > > > +/* kprobe Local profile  */
> > > > +static int local_probes_profile_seq_show(struct seq_file *m, void *v)
> > > > +{
> > > > +   struct dyn_event *ev = v;
> > > > +   struct trace_kprobe *tk;
> > > > +
> > > > +   if (!is_trace_kprobe(ev))
> > > > +           return 0;
> > > > +
> > > > +   tk = to_trace_kprobe(ev);
> > > > +   seq_printf(m, "  %-44s %15lu %15lu\n",
> > > > +           trace_probe_name(&tk->tp),
> > > > +           trace_kprobe_nhit(tk),
> > > > +           tk->rp.kp.nmissed);
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static const struct seq_operations local_profile_seq_op = {
> > > > +   .start  = local_event_seq_start,
> > > > +   .next   = local_event_seq_next,
> > > > +   .stop   = local_event_seq_stop,
> > > > +   .show   = local_probes_profile_seq_show
> > > > +};
> > > > +
> > > > +static int local_profile_open(struct inode *inode, struct file *file)
> > > > +{
> > > > +   int ret;
> > > > +
> > > > +   ret = security_locked_down(LOCKDOWN_TRACEFS);
> > > > +   if (ret)
> > > > +           return ret;
> > > > +
> > > > +   return seq_open(file, &local_profile_seq_op);
> > > > +}
> > > > +
> > > > +static const struct file_operations kprobe_local_profile_ops = {
> > > > +   .owner          = THIS_MODULE,
> > > > +   .open           = local_profile_open,
> > > > +   .read           = seq_read,
> > > > +   .llseek         = seq_lseek,
> > > > +   .release        = seq_release,
> > > > +};
> > > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > > +
> > > >  /* Kprobe specific fetch functions */
> > > >
> > > >  /* Return the length of string -- including null terminal byte */
> > > > @@ -1830,6 +1876,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > > >     if (ret < 0)
> > > >             goto error;
> > > >
> > > > +   local_event_add(&tk->devent);
> > > >     return trace_probe_event_call(&tk->tp);
> > > >  error:
> > > >     free_trace_kprobe(tk);
> > > > @@ -1849,6 +1896,7 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
> > > >             return;
> > > >     }
> > > >
> > > > +   local_event_remove(&tk->devent);
> > > >     __unregister_trace_kprobe(tk);
> > > >
> > > >     free_trace_kprobe(tk);
> > > > @@ -1929,6 +1977,12 @@ static __init int init_kprobe_trace(void)
> > > >     trace_create_file("kprobe_profile", TRACE_MODE_READ,
> > > >                       NULL, NULL, &kprobe_profile_ops);
> > > >
> > > > +#ifdef CONFIG_KPROBE_EVENTS
> > > > +   /* kprobe Local profile */
> > > > +   tracefs_create_file("kprobe_local_profile", TRACE_MODE_READ,
> > > > +                     NULL, NULL, &kprobe_local_profile_ops);
> > > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > > +
> > > >     setup_boot_kprobe_events();
> > > >
> > > >     return 0;
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
