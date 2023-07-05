Return-Path: <bpf+bounces-4040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B823B7481BE
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311B6280FDA
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B20539B;
	Wed,  5 Jul 2023 10:09:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B324C8F
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:09:18 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5736E10A;
	Wed,  5 Jul 2023 03:09:15 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635f293884cso39101656d6.3;
        Wed, 05 Jul 2023 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688551754; x=1691143754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUieIrFSQeaCUCCf5YNql2a5kikqQNM5mywYU08iHu8=;
        b=hQTJqKzG0Uvka8W9lk6zkyVvlz3m4d8kh4l1yfRfj8PBVja5wROgDmkj+87MZ1pgcB
         rMCqqF6LyKAefgIfX4ireN3aQDjnM37iC6lZU3q8/FSkq6oJrXKPprRJ+ErYtUARc2Lf
         1wTsxsQZ5k0SJ4Gk/slevtqp5VQFIbQnW4U+GJB1GqbRKqL/29/O2cnQDQlV0WLalYh9
         vsaISYPo0v/5nDGH8zx6smQZ6AvlGp2W0PI/MOzK0f06WJQOhWAKEbRnY3R9CmKaxONR
         Sv9/wt/BuSCsbz37TId68WvbBbwG7+PNxm/fbyTIgR0xhFYrKW0OgYOQKgqWYaL2Ij3m
         4emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688551754; x=1691143754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUieIrFSQeaCUCCf5YNql2a5kikqQNM5mywYU08iHu8=;
        b=Wd16mdOqtZqTvbrLz8RMleNz04lDeDpPDjQo/zKOq+/n+ilbkwJrhSGg1kuA72pSma
         K8hIPn2cjEzApJO4Q8x48oVkGHiDPAAXJIgfZeJTA3hGkOTbt+NS+VjlXQjf9Ca1nVH+
         tpRlGWK3lJuCp30ehgte2rLtOFPSwjv1LegOSQcpQuBNX/8CcNA4lbjblWudX+EXY09d
         j22FxWnEgAwLKzzx76JiZI96J3Sma7n7Wp6VwWMFe5yKMH7H6Q65oL/WL4vPiZtyChlB
         xnjlzOX8URk6jpN9tNdUp8IHjyU9Q/jg8YW/T/voBI5j+/iO0DSKIMPdtuK5HAqACJYc
         Uc6Q==
X-Gm-Message-State: ABy/qLYqUbwEBhCfHpFPuV/C/NOHZ3YDEugnXntKKCipwPFIhr5VQ2Wi
	SX8rgxzUX0etvYY9Qy/ODGp1pQGbyJtk/ABUv2tzZYBE9zz13Q==
X-Google-Smtp-Source: APBJJlGPy8xi05WsISfUyZWYoLyLNFHHUB7DdYGcHlCGwkKHaX8G2y3o0K803DT89gPn7DOY60+WFQMmOfNkfyFyDpk=
X-Received: by 2002:a05:6214:21ab:b0:626:3a5a:f8dc with SMTP id
 t11-20020a05621421ab00b006263a5af8dcmr17653655qvc.57.1688551754342; Wed, 05
 Jul 2023 03:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-10-laoar.shao@gmail.com>
 <e06b149e-2bcc-6a83-ef23-6216c7267632@iogearbox.net>
In-Reply-To: <e06b149e-2bcc-6a83-ef23-6216c7267632@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jul 2023 18:08:38 +0800
Message-ID: <CALOAHbBhxF8S2x8h1b-2otu31u-eg3BuUHyMW3VWBezy6AgMtg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 4:47=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 6/28/23 1:53 PM, Yafang Shao wrote:
> > By introducing support for ->fill_link_info to the perf_event link, use=
rs
> > gain the ability to inspect it using `bpftool link show`. While the cur=
rent
> > approach involves accessing this information via `bpftool perf show`,
> > consolidating link information for all link types in one place offers
> > greater convenience. Additionally, this patch extends support to the
> > generic perf event, which is not currently accommodated by
> > `bpftool perf show`. While only the perf type and config are exposed to
> > userspace, other attributes such as sample_period and sample_freq are
> > ignored. It's important to note that if kptr_restrict is not permitted,=
 the
> > probed address will not be exposed, maintaining security measures.
> >
> > A new enum bpf_perf_event_type is introduced to help the user understan=
d
> > which struct is relevant.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   include/uapi/linux/bpf.h       |  35 ++++++++++
> >   kernel/bpf/syscall.c           | 117 ++++++++++++++++++++++++++++++++=
+
> >   tools/include/uapi/linux/bpf.h |  35 ++++++++++
> >   3 files changed, 187 insertions(+)
>
> For ease of review this should be squashed with the prior one which adds
> bpf_perf_link_fill_common().

Sure. Will do it.

>
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 512ba3ba2ed3..7efe51672c15 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1057,6 +1057,16 @@ enum bpf_link_type {
> >       MAX_BPF_LINK_TYPE,
> >   };
> >
> > +enum bpf_perf_event_type {
> > +     BPF_PERF_EVENT_UNSPEC =3D 0,
> > +     BPF_PERF_EVENT_UPROBE =3D 1,
> > +     BPF_PERF_EVENT_URETPROBE =3D 2,
> > +     BPF_PERF_EVENT_KPROBE =3D 3,
> > +     BPF_PERF_EVENT_KRETPROBE =3D 4,
> > +     BPF_PERF_EVENT_TRACEPOINT =3D 5,
> > +     BPF_PERF_EVENT_EVENT =3D 6,
>
> Why explicitly defining the values of the enum?

With these newly introduced enums, the user can easily identify what
kind of perf_event link it is
See also the discussion:
https://lore.kernel.org/bpf/CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz=
4UCg@mail.gmail.com/

>
> > +};
> > +
> >   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> >    *
> >    * NONE(default): No further bpf programs allowed in the subtree.
> > @@ -6444,6 +6454,31 @@ struct bpf_link_info {
> >                       __u32 count;
> >                       __u32 flags;
> >               } kprobe_multi;
> > +             struct {
> > +                     __u32 type; /* enum bpf_perf_event_type */
> > +                     __u32 :32;
> > +                     union {
> > +                             struct {
> > +                                     __aligned_u64 file_name; /* in/ou=
t */
> > +                                     __u32 name_len;
> > +                                     __u32 offset;/* offset from file_=
name */
>
> nit: spacing wrt comment, also same further below

Will change it.

>
> > +                             } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_P=
ERF_EVENT_URETPROBE */
> > +                             struct {
> > +                                     __aligned_u64 func_name; /* in/ou=
t */
> > +                                     __u32 name_len;
> > +                                     __u32 offset;/* offset from func_=
name */
> > +                                     __u64 addr;
> > +                             } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_P=
ERF_EVENT_KRETPROBE */
> > +                             struct {
> > +                                     __aligned_u64 tp_name;   /* in/ou=
t */
> > +                                     __u32 name_len;
> > +                             } tracepoint; /* BPF_PERF_EVENT_TRACEPOIN=
T */
> > +                             struct {
> > +                                     __u64 config;
> > +                                     __u32 type;
> > +                             } event; /* BPF_PERF_EVENT_EVENT */
> > +                     };
> > +             } perf_event;
> >       };
> >   } __attribute__((aligned(8)));
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 72de91beabbc..05ff0a560f1a 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3398,9 +3398,126 @@ static int bpf_perf_link_fill_common(const stru=
ct perf_event *event,
> >       return 0;
> >   }
> >
> > +#ifdef CONFIG_KPROBE_EVENTS
> > +static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
> > +                                  struct bpf_link_info *info)
> > +{
> > +     char __user *uname;
> > +     u64 addr, offset;
> > +     u32 ulen, type;
> > +     int err;
> > +
> > +     uname =3D u64_to_user_ptr(info->perf_event.kprobe.func_name);
> > +     ulen =3D info->perf_event.kprobe.name_len;
> > +     err =3D bpf_perf_link_fill_common(event, uname, ulen, &offset, &a=
ddr,
> > +                                     &type);
> > +     if (err)
> > +             return err;
> > +     if (type =3D=3D BPF_FD_TYPE_KRETPROBE)
> > +             info->perf_event.type =3D BPF_PERF_EVENT_KRETPROBE;
> > +     else
> > +             info->perf_event.type =3D BPF_PERF_EVENT_KPROBE;
> > +
> > +     info->perf_event.kprobe.offset =3D offset;
> > +     if (!kallsyms_show_value(current_cred()))
> > +             addr =3D 0;
> > +     info->perf_event.kprobe.addr =3D addr;
> > +     return 0;
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_UPROBE_EVENTS
> > +static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
> > +                                  struct bpf_link_info *info)
> > +{
> > +     char __user *uname;
> > +     u64 addr, offset;
> > +     u32 ulen, type;
> > +     int err;
> > +
> > +     uname =3D u64_to_user_ptr(info->perf_event.uprobe.file_name);
> > +     ulen =3D info->perf_event.uprobe.name_len;
> > +     err =3D bpf_perf_link_fill_common(event, uname, ulen, &offset, &a=
ddr,
> > +                                     &type);
> > +     if (err)
> > +             return err;
> > +
> > +     if (type =3D=3D BPF_FD_TYPE_URETPROBE)
> > +             info->perf_event.type =3D BPF_PERF_EVENT_URETPROBE;
> > +     else
> > +             info->perf_event.type =3D BPF_PERF_EVENT_UPROBE;
> > +     info->perf_event.uprobe.offset =3D offset;
> > +     return 0;
> > +}
> > +#endif
> > +
> > +static int bpf_perf_link_fill_probe(const struct perf_event *event,
> > +                                 struct bpf_link_info *info)
> > +{
> > +#ifdef CONFIG_KPROBE_EVENTS
> > +     if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
> > +             return bpf_perf_link_fill_kprobe(event, info);
> > +#endif
> > +#ifdef CONFIG_UPROBE_EVENTS
> > +     if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
> > +             return bpf_perf_link_fill_uprobe(event, info);
> > +#endif
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static int bpf_perf_link_fill_tracepoint(const struct perf_event *even=
t,
> > +                                      struct bpf_link_info *info)
> > +{
> > +     char __user *uname;
> > +     u64 addr, offset;
> > +     u32 ulen, type;
> > +
> > +     uname =3D u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
> > +     ulen =3D info->perf_event.tracepoint.name_len;
> > +     info->perf_event.type =3D BPF_PERF_EVENT_TRACEPOINT;
> > +     return bpf_perf_link_fill_common(event, uname, ulen, &offset, &ad=
dr,
> > +                                      &type);
>
> Perhaps for data we don't care about in these cases, passing NULL would b=
e
> more obvious and letting bpf_perf_link_fill_common() handle NULL inputs.

Agree. That would be better.
We should let bpf_get_perf_event_info() handle NULL inputs.  As the
change in bpf_get_perf_event_info() is small, I will change it in the
same patch.

>
> > +}
> > +
> > +static int bpf_perf_link_fill_perf_event(const struct perf_event *even=
t,
> > +                                      struct bpf_link_info *info)
> > +{
> > +     info->perf_event.event.type =3D event->attr.type;
> > +     info->perf_event.event.config =3D event->attr.config;
> > +     info->perf_event.type =3D BPF_PERF_EVENT_EVENT;
> > +     return 0;
> > +}
> > +
> > +static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
> > +                                     struct bpf_link_info *info)
> > +{
> > +     struct bpf_perf_link *perf_link;
> > +     const struct perf_event *event;
> > +
> > +     perf_link =3D container_of(link, struct bpf_perf_link, link);
> > +     event =3D perf_get_event(perf_link->perf_file);
> > +     if (IS_ERR(event))
> > +             return PTR_ERR(event);
> > +
> > +     if (!event->prog)
> > +             return -EINVAL;
>
> nit: In which situations do we run into this, would ENOENT be better erro=
r code
> here given it's not an invalid arg that user passed to kernel for filling=
 link
> info.

In practice there should be no situations. I think we can remove this
judgement directly.

--=20
Regards
Yafang

