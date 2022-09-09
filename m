Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA35A5B2B93
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 03:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIIB0i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 21:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiIIB0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 21:26:37 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6448D10D704;
        Thu,  8 Sep 2022 18:26:36 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id bi53so84538vkb.12;
        Thu, 08 Sep 2022 18:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JspRybSZ+8YgidPZ8+JQ4MVCJPSqNBw1fSz6Hyxccjk=;
        b=cpPtT2YF5Rb+SAC1afqgw9CloaNYIxi+XoJ6hgUE4J78uP/e5ENBMnMH44lyshS5rX
         UC8qOhufFJ4t+3MmZVr5vf4yFpqyxB/853pfhYsuQ0jaCsMAasxs+HC/PlNEO9UU2hri
         asWU+vF2sL6I/v4gP11GdnF+jHUhIn+nKPPnAy7FPFFDlt2fm8fIZ3d5SpPjqxYpQZG8
         7KuDzbCZhdEP9CBTY2oLAK8Drvtle+5jWwe3yaWxVET0bXkNVVCxpP6Ed7wh62/CFgKG
         D7HiOt7tbINxdcVUlKf4wA4ZSeqZRgEAtvRutEKhKBKEW97p20g9NTMQtEkuhMclHNH0
         Tz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JspRybSZ+8YgidPZ8+JQ4MVCJPSqNBw1fSz6Hyxccjk=;
        b=fP4F2dA4cMqzUYae7rTMyitFM++sJ5m6kaAnV1ivTFYgAEYP7mCP+dP+BNFNfVs/Zu
         9zaUa5rZGkBiR24MChpd6qn8JFHLgnsggkhltjF0z/qsu5cURm9/kJHhwP1R4erSALz6
         Shh4Z/a6oBR4zC1uWwPD4cUVYq4Cc5sBQvvMz5ungzisf0ZhriyT0OZp4/XnsA4XK9OM
         vJf/EZpdEKI3HKvlntJMwbYeavBcj8ysg9hSWXbup+js7ep92uUAbQdlTfBmF2O1gZg9
         /lhvKBqgEWvKlWZM4lqJwb/E0iDm5t4PXm78fISfvKbc7AL3qw6bfumAUni736O4Q6FQ
         cjuA==
X-Gm-Message-State: ACgBeo2IW5fjctcVxcMS5VnFOiMPEdnxLSsKhYwVqfmS6JyP2ahxQgEd
        /w6yV6aAVEa/6aAcCxDiZrWXNqC+4mOPl5yTKzQ=
X-Google-Smtp-Source: AA6agR62bzjp3tS0TfeKa8yCmPrW0FslPWvshgi6UW0ZB35eL9sKn21T7VWKYfXpBQSOyPPnFsu9Awx64XqVPWx25Z4=
X-Received: by 2002:a1f:a0c6:0:b0:381:373d:c61d with SMTP id
 j189-20020a1fa0c6000000b00381373dc61dmr4168591vke.1.1662686795295; Thu, 08
 Sep 2022 18:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220725062334.1778-1-iecedge@gmail.com> <20220906111214.0dd113cd@gandalf.local.home>
 <20220907175136.96b05b241e650de21eb661e6@kernel.org>
In-Reply-To: <20220907175136.96b05b241e650de21eb661e6@kernel.org>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Fri, 9 Sep 2022 09:26:23 +0800
Message-ID: <CAFA-uR_u8Hvh1-pF_hxmsfMcZSoRvpKM-9P+24FY=74EoM_EUg@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/kprobes: Add method to display private kprobes
 in tracefs
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, corbet@lwn.net,
        mingo@redhat.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 4:51 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> [Adding bpf ML]
>
> On Tue, 6 Sep 2022 11:12:14 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> >
> > [ Adding Masami and Tom ]
> >
> > On Mon, 25 Jul 2022 06:23:34 +0000
> > Jianlin Lv <iecedge@gmail.com> wrote:
> >
> > > The private kprobes are not added to the global list dyn_event_list,
> > > so there is a missing interface to show probe hit and probe miss.
> > > This patch adds a profiling interface to check the number of hits or
> > > misses for private kprobes.
> >
> > Masami, what do you think of this patch?
>
> I discussed it with BPF people when it was introduced and they didn't
> want to show up it on tracefs because it is a private one. I agreed that.
>
> So I think this kind of interface must be managed by BPF subsystem.
> Is there any API to manage the BPF probe points in BPF subsystem?
>
> Thank you,

As far as I know, there is no API to manage private kprobes in the BPF
subsystem, so I added a tracefs interface to display private info.

Could you give me some hints about how to implement the current
functionality in the BPF subsystem?

Regards,
Jianlin

>
> >
> > -- Steve
> >
> > >
> > > Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> > > ---
> > > v2: update commit message
> > > ---
> > >  Documentation/trace/kprobetrace.rst |  6 +++-
> > >  kernel/trace/trace_dynevent.c       | 20 +++++++++++
> > >  kernel/trace/trace_dynevent.h       | 37 ++++++++++++++++++++
> > >  kernel/trace/trace_kprobe.c         | 54 +++++++++++++++++++++++++++++
> > >  4 files changed, 116 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > > index b175d88f31eb..8815d64dd8a6 100644
> > > --- a/Documentation/trace/kprobetrace.rst
> > > +++ b/Documentation/trace/kprobetrace.rst
> > > @@ -146,7 +146,11 @@ trigger:
> > >  Event Profiling
> > >  ---------------
> > >  You can check the total number of probe hits and probe miss-hits via
> > > -/sys/kernel/debug/tracing/kprobe_profile.
> > > +/sys/kernel/debug/tracing/kprobe_profile or
> > > +/sys/kernel/debug/tracing/kprobe_local_profile.
> > > +All kprobe events created by kprobe_events will be added to the global
> > > +list, you can get their profiling via kprobe_profile; kprobe_local_profile
> > > +shows profiling for private kprobe events created by perf_kprobe pmu.
> > >  The first column is event name, the second is the number of probe hits,
> > >  the third is the number of probe miss-hits.
> > >
> > > diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> > > index 076b447a1b88..70ec99cd9c53 100644
> > > --- a/kernel/trace/trace_dynevent.c
> > > +++ b/kernel/trace/trace_dynevent.c
> > > @@ -181,6 +181,26 @@ static const struct seq_operations dyn_event_seq_op = {
> > >     .show   = dyn_event_seq_show
> > >  };
> > >
> > > +#ifdef CONFIG_KPROBE_EVENTS
> > > +LIST_HEAD(local_event_list);
> > > +
> > > +void *local_event_seq_start(struct seq_file *m, loff_t *pos)
> > > +{
> > > +   mutex_lock(&event_mutex);
> > > +   return seq_list_start(&local_event_list, *pos);
> > > +}
> > > +
> > > +void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos)
> > > +{
> > > +   return seq_list_next(v, &local_event_list, pos);
> > > +}
> > > +
> > > +void local_event_seq_stop(struct seq_file *m, void *v)
> > > +{
> > > +   mutex_unlock(&event_mutex);
> > > +}
> > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > +
> > >  /*
> > >   * dyn_events_release_all - Release all specific events
> > >   * @type:  the dyn_event_operations * which filters releasing events
> > > diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
> > > index 936477a111d3..e30193470295 100644
> > > --- a/kernel/trace/trace_dynevent.h
> > > +++ b/kernel/trace/trace_dynevent.h
> > > @@ -101,6 +101,43 @@ void dyn_event_seq_stop(struct seq_file *m, void *v);
> > >  int dyn_events_release_all(struct dyn_event_operations *type);
> > >  int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
> > >
> > > +#ifdef CONFIG_KPROBE_EVENTS
> > > +extern struct list_head local_event_list;
> > > +
> > > +static inline
> > > +int local_event_init(struct dyn_event *ev, struct dyn_event_operations *ops)
> > > +{
> > > +   if (!ev || !ops)
> > > +           return -EINVAL;
> > > +
> > > +   INIT_LIST_HEAD(&ev->list);
> > > +   ev->ops = ops;
> > > +   return 0;
> > > +}
> > > +
> > > +static inline int local_event_add(struct dyn_event *ev)
> > > +{
> > > +   lockdep_assert_held(&event_mutex);
> > > +
> > > +   if (!ev || !ev->ops)
> > > +           return -EINVAL;
> > > +
> > > +   list_add_tail(&ev->list, &local_event_list);
> > > +   return 0;
> > > +}
> > > +
> > > +static inline void local_event_remove(struct dyn_event *ev)
> > > +{
> > > +   lockdep_assert_held(&event_mutex);
> > > +   list_del_init(&ev->list);
> > > +}
> > > +
> > > +void *local_event_seq_start(struct seq_file *m, loff_t *pos);
> > > +void *local_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
> > > +void local_event_seq_stop(struct seq_file *m, void *v);
> > > +
> > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > +
> > >  /*
> > >   * for_each_dyn_event      -       iterate over the dyn_event list
> > >   * @pos:   the struct dyn_event * to use as a loop cursor
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index a245ea673715..76f500b17b46 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -1213,6 +1213,52 @@ static const struct file_operations kprobe_profile_ops = {
> > >     .release        = seq_release,
> > >  };
> > >
> > > +#ifdef CONFIG_KPROBE_EVENTS
> > > +/* kprobe Local profile  */
> > > +static int local_probes_profile_seq_show(struct seq_file *m, void *v)
> > > +{
> > > +   struct dyn_event *ev = v;
> > > +   struct trace_kprobe *tk;
> > > +
> > > +   if (!is_trace_kprobe(ev))
> > > +           return 0;
> > > +
> > > +   tk = to_trace_kprobe(ev);
> > > +   seq_printf(m, "  %-44s %15lu %15lu\n",
> > > +           trace_probe_name(&tk->tp),
> > > +           trace_kprobe_nhit(tk),
> > > +           tk->rp.kp.nmissed);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static const struct seq_operations local_profile_seq_op = {
> > > +   .start  = local_event_seq_start,
> > > +   .next   = local_event_seq_next,
> > > +   .stop   = local_event_seq_stop,
> > > +   .show   = local_probes_profile_seq_show
> > > +};
> > > +
> > > +static int local_profile_open(struct inode *inode, struct file *file)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret = security_locked_down(LOCKDOWN_TRACEFS);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   return seq_open(file, &local_profile_seq_op);
> > > +}
> > > +
> > > +static const struct file_operations kprobe_local_profile_ops = {
> > > +   .owner          = THIS_MODULE,
> > > +   .open           = local_profile_open,
> > > +   .read           = seq_read,
> > > +   .llseek         = seq_lseek,
> > > +   .release        = seq_release,
> > > +};
> > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > +
> > >  /* Kprobe specific fetch functions */
> > >
> > >  /* Return the length of string -- including null terminal byte */
> > > @@ -1830,6 +1876,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > >     if (ret < 0)
> > >             goto error;
> > >
> > > +   local_event_add(&tk->devent);
> > >     return trace_probe_event_call(&tk->tp);
> > >  error:
> > >     free_trace_kprobe(tk);
> > > @@ -1849,6 +1896,7 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
> > >             return;
> > >     }
> > >
> > > +   local_event_remove(&tk->devent);
> > >     __unregister_trace_kprobe(tk);
> > >
> > >     free_trace_kprobe(tk);
> > > @@ -1929,6 +1977,12 @@ static __init int init_kprobe_trace(void)
> > >     trace_create_file("kprobe_profile", TRACE_MODE_READ,
> > >                       NULL, NULL, &kprobe_profile_ops);
> > >
> > > +#ifdef CONFIG_KPROBE_EVENTS
> > > +   /* kprobe Local profile */
> > > +   tracefs_create_file("kprobe_local_profile", TRACE_MODE_READ,
> > > +                     NULL, NULL, &kprobe_local_profile_ops);
> > > +#endif /* CONFIG_KPROBE_EVENTS */
> > > +
> > >     setup_boot_kprobe_events();
> > >
> > >     return 0;
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
