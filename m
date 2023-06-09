Return-Path: <bpf+bounces-2247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD372A222
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46F22818A0
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E72F2107A;
	Fri,  9 Jun 2023 18:26:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE501993B
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 18:26:59 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E135B3
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 11:26:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9745baf7c13so309724666b.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686335216; x=1688927216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf3mFq1YqYEkwhBsPKIymUOtSh6bqrUAcVyyogMAAaA=;
        b=qODPlQMZaU+QAoswcQ0FsfuVqO1tMUyY01b3F9TIKPKFahQ5MmYyGBIbV4e+tVtKzd
         ETxi0gECnfdwULvSPmynOR8E9CqNAk9pXFso/L6dKJMsxEmdxND/RgArokUYPpSt6lz+
         WcFe83AwEr62BvDNwzioS9hCvRU/uMR6xSm+BsWqVY12SL00hYRiwcA9IrWmfRB+LTrU
         9JvX2coR5wN5pU5UN2m3n+KwzfvDgBDX5chzZSpAe00qy8ypq0MQW/Zyi9ZjkpM1/c9T
         gRaIWzt+hnkTjeSbQb3S/Gu2ZRFt42/oIdH1JX4IEJ5JSrMLfEqCjWsKFPGxBLt/F8C2
         bG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335216; x=1688927216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf3mFq1YqYEkwhBsPKIymUOtSh6bqrUAcVyyogMAAaA=;
        b=h/nuai5tANGPDiYBEBdAVnhBm5/FRirF9lJ2xRXgrGJL5BLxZMXoqXmhiOeJrdViAT
         uNCJtLYp1rD1yhf5MGrCwZ9A26QblHs8n8neXh7KOhS5mOn2wL8UWFqKHyRW6Vilm5rM
         VAC3SEGvorALYTkx3ni25tVllFKvG59KWZlEVKYOINyQV52/Htc2nqK6uH1yK75E9Yz3
         hOHJOxj5Awm9TjIVqIrFy7xWk3PGriVzljuoNIsC9Y6fHc7Iv2NfP5yHsBFIqajjB/kW
         jIpWG33uxNr+rLo1UFSgRlbv4uuAsyThHPFGAp503jjfH6t+2GXbfmXhSX/Q1Ey+hOS8
         XqIQ==
X-Gm-Message-State: AC+VfDyN1ANgZLjrjcLTZbB2+8Pe02SyvNt+ZWP3prCGFerfKGJ7xo6G
	MZJpxmXfvuf/GD4+K73RuXMIxsH9xqiKQPLcR8U=
X-Google-Smtp-Source: ACHHUZ4View6oZgdrhwRQwZbpemHYnb81G16Izcplbbk246CuM6ZXx4lE+1sVhIvyE8jVfI7AYAx0lr+PIsnVy4K5ag=
X-Received: by 2002:a17:907:3e1c:b0:970:1b2d:45cc with SMTP id
 hp28-20020a1709073e1c00b009701b2d45ccmr2361750ejc.57.1686335215882; Fri, 09
 Jun 2023 11:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-9-laoar.shao@gmail.com>
 <CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com>
 <CALOAHbCrRQ2f9y5AKa9hgMLLzqB+yBEZMxLP-FevK+q=YuMS=w@mail.gmail.com> <CALOAHbBibBh2W8_68oHrwPBygb6GXD7QP=ngPue08x0XFufAWg@mail.gmail.com>
In-Reply-To: <CALOAHbBibBh2W8_68oHrwPBygb6GXD7QP=ngPue08x0XFufAWg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 11:26:44 -0700
Message-ID: <CAEf4BzYJWQA4z4PVbWk_jzPKbf76wJJrcoOD-zN0___qKK4-BQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/11] bpf: Support ->fill_link_info for perf_event
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 2:57=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Fri, Jun 9, 2023 at 5:53=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Fri, Jun 9, 2023 at 7:12=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > By introducing support for ->fill_link_info to the perf_event link,=
 users
> > > > gain the ability to inspect it using `bpftool link show`. While the=
 current
> > > > approach involves accessing this information via `bpftool perf show=
`,
> > > > consolidating link information for all link types in one place offe=
rs
> > > > greater convenience. Additionally, this patch extends support to th=
e
> > > > generic perf event, which is not currently accommodated by
> > > > `bpftool perf show`. While only the perf type and config are expose=
d to
> > > > userspace, other attributes such as sample_period and sample_freq a=
re
> > > > ignored. It's important to note that if kptr_restrict is set to 2, =
the
> > > > probed address will not be exposed, maintaining security measures.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       | 22 ++++++++++
> > > >  kernel/bpf/syscall.c           | 98 ++++++++++++++++++++++++++++++=
++++++++++++
> > > >  tools/include/uapi/linux/bpf.h | 22 ++++++++++
> > > >  3 files changed, 142 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index d99cc16..c3b821d 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -6443,6 +6443,28 @@ struct bpf_link_info {
> > > >                         __u32 count;
> > > >                         __u8  retprobe;
> > > >                 } kprobe_multi;
> > > > +               union {
> > > > +                       struct {
> > > > +                               /* The name is:
> > > > +                                * a) uprobe: file name
> > > > +                                * b) kprobe: kernel function
> > > > +                                */
> > > > +                               __aligned_u64 name; /* in/out: name=
 buffer ptr */
> > > > +                               __u32 name_len;
> > > > +                               __u32 offset;   /* offset from the =
name */
> > > > +                               __u64 addr;
> > > > +                               __u8 retprobe;
> > > > +                       } probe; /* uprobe, kprobe */
> > > > +                       struct {
> > > > +                               /* in/out: tracepoint name buffer p=
tr */
> > > > +                               __aligned_u64 tp_name;
> > > > +                               __u32 name_len;
> > > > +                       } tp; /* tracepoint */
> > > > +                       struct {
> > > > +                               __u64 config;
> > > > +                               __u32 type;
> > > > +                       } event; /* generic perf event */
> > >
> > > how should the user know which of those structs are relevant? we need
> > > some enum to specify what kind of perf_event link it is?
> > >
> >
> > Do you mean that we add a new field 'type' into the union perf_event,
> > as follows ?
> >     union {
> >         __u32 type;
> >         struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
> >         struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
> >         struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
> >     };
> >
>
> Correct it:
>
> struct {
>     __u32 type;
>     union {
>          struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
>          struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
>          struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
>      };
> } perf_event;

yes, something like this. Unless we want to leave  perf_event {} to
mean really perf event only, while kprobe/uprobe/tracepoint should be
their own separate sections at the same level of nestedness as
perf_Event and other cases. Not sure.

>
> --
> Regards
> Yafang

