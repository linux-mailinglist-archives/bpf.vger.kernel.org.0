Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B9852D0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 20:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbfHGSQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 14:16:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46430 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbfHGSQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 14:16:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so86529541ljg.13
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uI9neKW/ACdHGCdzSrV/N6CZuws/G2wzmqdIsK1r6J8=;
        b=tanGbMWjUJjl1tcxj+s0mvxBvTqnyQn897HDnGw2FisGhVI/5C4auJxNnebiJZbUHX
         w2tbEotvS/TFh1/65Cf2yYGAriwYsEbQpcv2tbPmC9f8Wc1GRSAJd6TSMXerTWwCVoxF
         9rW7akMAjB0u1q75nb/Bs/rHVdRchrs7ocE+ny4GHjyvuBinUI5g4QJH0rltBKB/qd2l
         1AIn5zSFbifKLPFnmA4Ao30gPDgdlQ6nE8aP2zuAPC4/nV30iW3e8Nol+4o+NES0VFk3
         AMe7cdcRQq6j7MB5uZU6CqRqSV41G7/A0D8TPrU8zrftvBpO2LEtVtmIT54BDvNMAdjB
         SNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI9neKW/ACdHGCdzSrV/N6CZuws/G2wzmqdIsK1r6J8=;
        b=OufbuV/x5rVT0JqvUP4QC2fI+M5b1AnE/vghhiNfdYBy6G3dFnmwkyX2s1NoP09F+d
         YVaib6St1NGAF4uJn5BNTi9sEfl0gY3LQYCDp/g0ufszD3v79bOwORYoLfmmoZ8lscxH
         udZjAmceTr2oQOi9HzQFeuK3WXSUsyFzjIWoRrPbBVE+Xrta73+O48dRP80ePJ15s/34
         02qU8GGZYex65ytZQlaa6HSUTGSxhCGIyMljkIURwR7OoCBNKw7AH1ceefwYkGsXiAGr
         r1ISB2i8r1IjbWZlFE2prd8iTK/ttQi+mpj2ktD/7qdVfVhQ4k2cARC5M//Ah4U1BbX7
         4BMg==
X-Gm-Message-State: APjAAAWFMibtX/aXOdHdzsIQ7COnitS0VAUps9IFvyWjO01LmEe5PdAX
        9Z5H8xQqbnNhYW53Yxy3hkzpywbgzAw9N8BTid8=
X-Google-Smtp-Source: APXvYqxklywdF7iQJVXSrPmmYs9KQUcy7j2EPyIXQPYZ69xZPojxfq4Dr/KJzdlZTOA9MfD66LVCkf+SMbBYVc3DH9M=
X-Received: by 2002:a2e:8455:: with SMTP id u21mr5469728ljh.20.1565201806163;
 Wed, 07 Aug 2019 11:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190806234131.5655-1-dxu@dxuuu.xyz> <f4a1ca0c-3fa1-5a20-2f41-133dc2ec1445@fb.com>
In-Reply-To: <f4a1ca0c-3fa1-5a20-2f41-133dc2ec1445@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 7 Aug 2019 11:16:34 -0700
Message-ID: <CAPhsuW5Qh7=Hgz=3RHeT623j+VLs1gMrYf8+DseYbR95heTjbw@mail.gmail.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019 at 10:52 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/6/19 4:41 PM, Daniel Xu wrote:
> > It's useful to know kprobe's nmissed and nhit stats. For example with
> > tracing tools, it's important to know when events may have been lost.
> > There is currently no way to get that information from the perf API.
> > This patch adds a new ioctl that lets users query this information.
> > ---
> >   include/linux/trace_events.h    |  6 ++++++
> >   include/uapi/linux/perf_event.h | 23 +++++++++++++++++++++++
> >   kernel/events/core.c            | 11 +++++++++++
> >   kernel/trace/trace_kprobe.c     | 25 +++++++++++++++++++++++++
> >   4 files changed, 65 insertions(+)
> >
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 5150436783e8..28faf115e0b8 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -586,6 +586,12 @@ extern int bpf_get_kprobe_info(const struct perf_event *event,
> >                              u32 *fd_type, const char **symbol,
> >                              u64 *probe_offset, u64 *probe_addr,
> >                              bool perf_type_tracepoint);
> > +extern int perf_event_query_kprobe(struct perf_event *event, void __user *info);
> > +#else
> > +int perf_event_query_kprobe(struct perf_event *event, void __user *info)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> >   #endif
> >   #ifdef CONFIG_UPROBE_EVENTS
> >   extern int  perf_uprobe_init(struct perf_event *event,
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 7198ddd0c6b1..4a5e18606baf 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -447,6 +447,28 @@ struct perf_event_query_bpf {
> >       __u32   ids[0];
> >   };
> >
> > +/*
> > + * Structure used by below PERF_EVENT_IOC_QUERY_KPROE command
>
> typo PERF_EVENT_IOC_QUERY_KPROE => PERF_EVENT_IOC_QUERY_KPROBE
>
> > + * to query information about the kprobe attached to the perf
> > + * event.
> > + */
> > +struct perf_event_query_kprobe {
> > +       /*
> > +        * Size of structure for forward/backward compatibility
> > +        */
> > +       __u32   size;
>
> Since this is perf_event UAPI change, could you cc to
> Peter Zijlstra <peterz@infradead.org> as well?
>
> We have 32 bit hole here. For UAPI, it would be best to remove
> the hole or make it explicit. So in this case, maybe something like
>            __u32   :32;
>
> Also, what is in your mind for potential future extension?
>
> > +       /*
> > +        * Set by the kernel to indicate number of times this kprobe
> > +        * was temporarily disabled
> > +        */
> > +       __u64   nmissed;
> > +       /*
> > +        * Set by the kernel to indicate number of times this kprobe
> > +        * was hit
> > +        */
> > +       __u64   nhit;
> > +};
> > +
> >   /*
> >    * Ioctls that can be done on a perf event fd:
> >    */
> > @@ -462,6 +484,7 @@ struct perf_event_query_bpf {
> >   #define PERF_EVENT_IOC_PAUSE_OUTPUT         _IOW('$', 9, __u32)
> >   #define PERF_EVENT_IOC_QUERY_BPF            _IOWR('$', 10, struct perf_event_query_bpf *)
> >   #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES    _IOW('$', 11, struct perf_event_attr *)
> > +#define PERF_EVENT_IOC_QUERY_KPROBE          _IOWR('$', 12, struct perf_event_query_kprobe *)
> >
> >   enum perf_event_ioc_flags {
> >       PERF_IOC_FLAG_GROUP             = 1U << 0,
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 026a14541a38..d61c3ac5da4f 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -5061,6 +5061,10 @@ static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
> >   static int perf_copy_attr(struct perf_event_attr __user *uattr,
> >                         struct perf_event_attr *attr);
> >
> > +#ifdef CONFIG_KPROBE_EVENTS
> > +static struct pmu perf_kprobe;
> > +#endif /* CONFIG_KPROBE_EVENTS */
> > +
> >   static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
> >   {
> >       void (*func)(struct perf_event *);
> > @@ -5143,6 +5147,13 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
> >
> >               return perf_event_modify_attr(event,  &new_attr);
> >       }
> > +#ifdef CONFIG_KPROBE_EVENTS
> > +        case PERF_EVENT_IOC_QUERY_KPROBE:
> > +             if (event->attr.type != perf_kprobe.type)
> > +                     return -EINVAL;
>
> This will only handle FD based kprobe. If this is the intention, best to
> clearly state it in the cover letter as well.
Agreed, we should highlight this is for fd-based kprobes.

>
> I suspect this should also work for debugfs trace event based kprobe,
> but I did not verify it through codes.
>
This won't work for kprobes created in debugfs. The attr.type will be different.

Thanks,
Song
