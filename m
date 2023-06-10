Return-Path: <bpf+bounces-2292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9AE72A851
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 04:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5401C21188
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 02:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCED23CA;
	Sat, 10 Jun 2023 02:21:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2A15A1
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 02:21:45 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BB1B9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 19:21:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6237faa8677so15874566d6.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 19:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686363703; x=1688955703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heIoPEPtBQPGndYNtchaJ14gbeicPIM2tg31ynEPVy8=;
        b=IF4EbFfXJygaMu2cwa/0Gi24U4/JkdrQHXYHCVcoKG8EA5osDwmGffgksok9f7LTBC
         627kmqax6HrLa3J8I/16uIn0N9unLSG6RVkq31Mw8f5WGhaIejdfLCJoQqUuROFf5Z5u
         gWO1jIP5ncW1OgG72Iff90n35Dcx4Sed2Q+VKo/7Yy3sIio/iiFLIK+g5dwiGMMhknF3
         YnyxYLKqfj32vxRU2R02MULdf/xuOyvN/upWaFtdZZCd4JM3xV5ZgkXh2yXhl+aNh1du
         teGIm4Q6kqlt39tX1/B31eWrBfgqid7GNkPERE+0oHi5v+5XGjsZqTb4WZUrGrtT2SNl
         tGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686363703; x=1688955703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heIoPEPtBQPGndYNtchaJ14gbeicPIM2tg31ynEPVy8=;
        b=NiYig+Gl9k44Jmqwcbe0xiAnxIycrxTzHe0Otw4Aj8bAJQgMUos9zJS3sojydXNmEb
         qOoS7zQC3jV7/JjmHIURO/O0DBkFzRYovWCeJmW6wCwGwKnCSyyY7SjTIExCjXFObpxl
         HMXzMGiTlO/dwD7BDEhpnbODRW7tqkLdOsolrHxgGLk273rSEC65jjaUpoRksvkP0C0y
         dfEVxYt++tJN2RHKDcOoahadB8ukjq4XwTvgSdVCXMVIirnBahRi6jNTYVYBuVDe/WZk
         1bdzvI1AjHRr6d+uGacI88NQ3WE1ik5oEHrW2VzbHRnw7VlOurq4rgfEuy6aB1gBZFdf
         L0HA==
X-Gm-Message-State: AC+VfDxZZwPBxFPvom09lXI6kZCzwOux5P0ReV9HZvgbMZqquCxGQB7Z
	L9Bdd4CHG5DcVaeJlLjAVsq/K42lnE/p4ifjAr0=
X-Google-Smtp-Source: ACHHUZ6Tc0qP9shdZTnRS6cBUA3D53y2zDQJfO7z0bhVSiQRat4Kf504pu/xqojM1BGaNQXN5MjNR4f4wftcR940yzE=
X-Received: by 2002:a05:6214:27e2:b0:628:3e37:e160 with SMTP id
 jt2-20020a05621427e200b006283e37e160mr3206711qvb.30.1686363703087; Fri, 09
 Jun 2023 19:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-9-laoar.shao@gmail.com>
 <CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com>
 <CALOAHbCrRQ2f9y5AKa9hgMLLzqB+yBEZMxLP-FevK+q=YuMS=w@mail.gmail.com>
 <CALOAHbBibBh2W8_68oHrwPBygb6GXD7QP=ngPue08x0XFufAWg@mail.gmail.com> <CAEf4BzYJWQA4z4PVbWk_jzPKbf76wJJrcoOD-zN0___qKK4-BQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYJWQA4z4PVbWk_jzPKbf76wJJrcoOD-zN0___qKK4-BQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 10 Jun 2023 10:21:06 +0800
Message-ID: <CALOAHbBb5p92oBe5HKPu_5ADXkNErAKz2hu-wMxjLje80kymKA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/11] bpf: Support ->fill_link_info for perf_event
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Sat, Jun 10, 2023 at 2:26=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 9, 2023 at 2:57=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Fri, Jun 9, 2023 at 5:53=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 7:12=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > By introducing support for ->fill_link_info to the perf_event lin=
k, users
> > > > > gain the ability to inspect it using `bpftool link show`. While t=
he current
> > > > > approach involves accessing this information via `bpftool perf sh=
ow`,
> > > > > consolidating link information for all link types in one place of=
fers
> > > > > greater convenience. Additionally, this patch extends support to =
the
> > > > > generic perf event, which is not currently accommodated by
> > > > > `bpftool perf show`. While only the perf type and config are expo=
sed to
> > > > > userspace, other attributes such as sample_period and sample_freq=
 are
> > > > > ignored. It's important to note that if kptr_restrict is set to 2=
, the
> > > > > probed address will not be exposed, maintaining security measures=
.
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > > >  include/uapi/linux/bpf.h       | 22 ++++++++++
> > > > >  kernel/bpf/syscall.c           | 98 ++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  tools/include/uapi/linux/bpf.h | 22 ++++++++++
> > > > >  3 files changed, 142 insertions(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index d99cc16..c3b821d 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -6443,6 +6443,28 @@ struct bpf_link_info {
> > > > >                         __u32 count;
> > > > >                         __u8  retprobe;
> > > > >                 } kprobe_multi;
> > > > > +               union {
> > > > > +                       struct {
> > > > > +                               /* The name is:
> > > > > +                                * a) uprobe: file name
> > > > > +                                * b) kprobe: kernel function
> > > > > +                                */
> > > > > +                               __aligned_u64 name; /* in/out: na=
me buffer ptr */
> > > > > +                               __u32 name_len;
> > > > > +                               __u32 offset;   /* offset from th=
e name */
> > > > > +                               __u64 addr;
> > > > > +                               __u8 retprobe;
> > > > > +                       } probe; /* uprobe, kprobe */
> > > > > +                       struct {
> > > > > +                               /* in/out: tracepoint name buffer=
 ptr */
> > > > > +                               __aligned_u64 tp_name;
> > > > > +                               __u32 name_len;
> > > > > +                       } tp; /* tracepoint */
> > > > > +                       struct {
> > > > > +                               __u64 config;
> > > > > +                               __u32 type;
> > > > > +                       } event; /* generic perf event */
> > > >
> > > > how should the user know which of those structs are relevant? we ne=
ed
> > > > some enum to specify what kind of perf_event link it is?
> > > >
> > >
> > > Do you mean that we add a new field 'type' into the union perf_event,
> > > as follows ?
> > >     union {
> > >         __u32 type;
> > >         struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
> > >         struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
> > >         struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
> > >     };
> > >
> >
> > Correct it:
> >
> > struct {
> >     __u32 type;
> >     union {
> >          struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
> >          struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
> >          struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
> >      };
> > } perf_event;
>
> yes, something like this. Unless we want to leave  perf_event {} to
> mean really perf event only, while kprobe/uprobe/tracepoint should be
> their own separate sections at the same level of nestedness as
> perf_Event and other cases. Not sure.
>

Thanks for your explanation. I will think about it.

--=20
Regards
Yafang

