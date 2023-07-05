Return-Path: <bpf+bounces-4037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D174819C
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1F41C20AFC
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E04C95;
	Wed,  5 Jul 2023 10:01:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C20F4
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:01:32 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080BE41;
	Wed,  5 Jul 2023 03:01:30 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-78f554d4949so1751835241.3;
        Wed, 05 Jul 2023 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688551290; x=1691143290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77w+GstacrRpt0gnElgL96gZng9xBEsTXAE91ZKpKYA=;
        b=VcWkQn/Zv5OCW8CTamSqs6gp6sT2VXbPkLlWZf6rWIFERSaVMT5zeEppzYccw5dC1U
         N8R8W0tj+DsBIX+fRqCXR2q/V+eOKpeTRkXcyGCLfaFQd8tFDiJTRA/tvIzbD7YyZ7lf
         2CvfwAuydrniymkPIWUgq6ojC0kPWILOer+jlVMDDEUlBvYWp0VakXsyCwGBUJd0pntJ
         lQ59IXDhrYIVSE15KQUFQLmSvBTFoM8zmy96SwErj9krcoNnOWXF10FiPzh9DVUIa2LU
         +OU1VpeaC9WAaKiSsFwgvCJiLYTTJwC10OmghQClvJQA+0ctoe/gL5FN1B6/bjbFD8SV
         mbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688551290; x=1691143290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77w+GstacrRpt0gnElgL96gZng9xBEsTXAE91ZKpKYA=;
        b=hJesDfNn5d80G6mTg49rmQP6aAOjugLeZgx4awoUPm0idZeV5D5NWgASaTO1T+O+V2
         fJFuZNjictJkaffDJU2ttDtGLqRXUGpdbtrk5MZnR9MuuHvDivhd9rIgdhO+jhtgrQGn
         UgKAK45aeLWjfIvog9n4oteky1ptpVZrNybAmJS/wgzc4DCtfx2hA3KVnFV+TbPYalOI
         O9qZ/60+Ks6Ka+yqI4ZJgCkL9Bqyu/pV2atwLoQ3mX2gjttgXJzLzLNEIRicwEFoZqTw
         KXi2r3B3lsOUH74InXlhUYcVBUg2k1Ga6YnLatVWJ2WOZZqj72t3kL6tRckq8FbGXDiE
         Wv4g==
X-Gm-Message-State: ABy/qLZNAQ9xfvEqm6A2eQj8SkOE0sZGiQCU1eyBNNmEVUDvv02YNCqE
	sknJBk6QdcpMWMQAVxee2GwiKa8lD1GRNDn7uGo=
X-Google-Smtp-Source: APBJJlFdb5QHn9Aj2UslHduRSrFZEvXygdxeFnpB3ZxpjThITjgPodUO4CL0V88QomTZftVX1ZBeN9TKAd+SkeHHi8A=
X-Received: by 2002:a67:fc19:0:b0:443:5927:d41b with SMTP id
 o25-20020a67fc19000000b004435927d41bmr6891639vsq.31.1688551289918; Wed, 05
 Jul 2023 03:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-6-laoar.shao@gmail.com>
 <5ed6bc64-ab80-486b-fb13-207174d9ff2d@iogearbox.net>
In-Reply-To: <5ed6bc64-ab80-486b-fb13-207174d9ff2d@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jul 2023 18:00:54 +0800
Message-ID: <CALOAHbDs1L4Pot4-M0g4b9uSCwZgQYb1SQZ-QqAdxvZGLdW0uw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
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

On Wed, Jul 5, 2023 at 4:19=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 6/28/23 1:53 PM, Yafang Shao wrote:
> > To avoid returning uninitialized or random values when querying the fil=
e
> > descriptor (fd) and accessing probe_addr, it is necessary to clear the
> > variable prior to its use.
> >
> > Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >   kernel/trace/bpf_trace.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 1f9f78e1992f..ac9958907a7c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2382,10 +2382,12 @@ int bpf_get_perf_event_info(const struct perf_e=
vent *event, u32 *prog_id,
> >                                                 event->attr.type =3D=3D=
 PERF_TYPE_TRACEPOINT);
> >   #endif
> >   #ifdef CONFIG_UPROBE_EVENTS
> > -             if (flags & TRACE_EVENT_FL_UPROBE)
> > +             if (flags & TRACE_EVENT_FL_UPROBE) {
> >                       err =3D bpf_get_uprobe_info(event, fd_type, buf,
> >                                                 probe_offset,
> >                                                 event->attr.type =3D=3D=
 PERF_TYPE_TRACEPOINT);
> > +                     *probe_addr =3D 0x0;
> > +             }
>
> Could we make this a bit more robust by just moving the zero'ing into the=
 common path?

Agree. Will change it.

>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 03b7f6b8e4f0..795e16d5d2f7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2362,6 +2362,9 @@ int bpf_get_perf_event_info(const struct perf_event=
 *event, u32 *prog_id,
>                  return -EOPNOTSUPP;
>
>          *prog_id =3D prog->aux->id;
> +       *probe_offset =3D 0x0;
> +       *probe_addr =3D 0x0;
> +
>          flags =3D event->tp_event->flags;
>          is_tracepoint =3D flags & TRACE_EVENT_FL_TRACEPOINT;
>          is_syscall_tp =3D is_syscall_trace_event(event->tp_event);
> @@ -2370,8 +2373,6 @@ int bpf_get_perf_event_info(const struct perf_event=
 *event, u32 *prog_id,
>                  *buf =3D is_tracepoint ? event->tp_event->tp->name
>                                       : event->tp_event->name;
>                  *fd_type =3D BPF_FD_TYPE_TRACEPOINT;
> -               *probe_offset =3D 0x0;
> -               *probe_addr =3D 0x0;
>          } else {
>                  /* kprobe/uprobe */
>                  err =3D -EOPNOTSUPP;



--=20
Regards
Yafang

