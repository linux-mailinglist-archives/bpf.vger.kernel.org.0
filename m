Return-Path: <bpf+bounces-2222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1F729613
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80431C20F52
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD714A9C;
	Fri,  9 Jun 2023 09:57:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5113AE9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:57:33 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AFB6196
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 02:57:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9c7665317so13661651cf.3
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304642; x=1688896642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT6KgDR0dz1lsuyKkdxYIc9N1W0KxLO34DSdWueOOy8=;
        b=Cc6jobO9HVcpigptWLzGC97ahzKJvEELEURiM3qNiVVXKo1wx+WYWWTGWzGf22bsMT
         gMSQr9swaU2sp3oGkzQ7Qmd4TnkzjhTu027ppg+thRBtt7+c6JQ9bl53YbicztVNvrlw
         LQ76ETFEUvtAQo/Hg+PsqofHn5yvxkSpQfgdDscwla3cN+Jgo+3U0VP7BU5zIaNdjtE3
         HUnAEWQjYgEBdB8Iu/ExxD4bT/R0GC9rijAadzWIBEsIKuCOBpVI4rxpejdZvRIQQxQN
         XnwTUdf+SKOqbdK3vfjH2qMnQYHOrIYMO48aTVEBoYlHCxt2Jml88yKJiox7Nxnmx//f
         qYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304642; x=1688896642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT6KgDR0dz1lsuyKkdxYIc9N1W0KxLO34DSdWueOOy8=;
        b=NWFWRKSOhN1m66ZpyDZ7kbeo6nMpskaWmp/9FXP7D9MokC3gBFsy4FslDiIvwgtMDA
         UrmyCCs14RO17S8xRLhyjAC11kPSHmZ6lE53tV5z6FFRv310MNM6HI2muJjx+cgMVbwA
         P4cRW5Z/O9XvRBIh5K6XD/XWL03xKUBHFpGGVSyNfbNmaBgWXzcjYQKsvUwqMm3hITR7
         vcJLfMibTaCEsqZh4WVVaHMJL9bwXBgE0YpmSVXMVy8xcMHyX1iRURcBDbbR9nttA7kW
         EP66FCcfttc9PC0ypKumCtO2QvO2mQfeyYPxdzfIh7XpkQIY/3LmGw+V3Nx7KlvVl7oe
         D8AQ==
X-Gm-Message-State: AC+VfDzlDitXg6DX0pt5IyS2FT0EC9V905tQ7oA8o1KP7yl/WtxFWk5i
	ERrHjtfC30m32r+pG3t8/YeRxsl/dCCLxCUswiU=
X-Google-Smtp-Source: ACHHUZ5B8cmh/oYLAmz733hN/1ztwQf49vaP3DPAOucd8qCi/2UEtn+5eRhgSsPKsOD9xIrsLj3NTnG3WJnRoYDsWg8=
X-Received: by 2002:a05:6214:27c7:b0:5f1:62d9:3368 with SMTP id
 ge7-20020a05621427c700b005f162d93368mr919646qvb.30.1686304642413; Fri, 09 Jun
 2023 02:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-9-laoar.shao@gmail.com>
 <CAEf4BzYEwCZ3J51pFnUfGykEAHtdLwB8Kxi0utvUTVvewz4UCg@mail.gmail.com> <CALOAHbCrRQ2f9y5AKa9hgMLLzqB+yBEZMxLP-FevK+q=YuMS=w@mail.gmail.com>
In-Reply-To: <CALOAHbCrRQ2f9y5AKa9hgMLLzqB+yBEZMxLP-FevK+q=YuMS=w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 9 Jun 2023 17:56:46 +0800
Message-ID: <CALOAHbBibBh2W8_68oHrwPBygb6GXD7QP=ngPue08x0XFufAWg@mail.gmail.com>
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

On Fri, Jun 9, 2023 at 5:53=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Fri, Jun 9, 2023 at 7:12=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > By introducing support for ->fill_link_info to the perf_event link, u=
sers
> > > gain the ability to inspect it using `bpftool link show`. While the c=
urrent
> > > approach involves accessing this information via `bpftool perf show`,
> > > consolidating link information for all link types in one place offers
> > > greater convenience. Additionally, this patch extends support to the
> > > generic perf event, which is not currently accommodated by
> > > `bpftool perf show`. While only the perf type and config are exposed =
to
> > > userspace, other attributes such as sample_period and sample_freq are
> > > ignored. It's important to note that if kptr_restrict is set to 2, th=
e
> > > probed address will not be exposed, maintaining security measures.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  include/uapi/linux/bpf.h       | 22 ++++++++++
> > >  kernel/bpf/syscall.c           | 98 ++++++++++++++++++++++++++++++++=
++++++++++
> > >  tools/include/uapi/linux/bpf.h | 22 ++++++++++
> > >  3 files changed, 142 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index d99cc16..c3b821d 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6443,6 +6443,28 @@ struct bpf_link_info {
> > >                         __u32 count;
> > >                         __u8  retprobe;
> > >                 } kprobe_multi;
> > > +               union {
> > > +                       struct {
> > > +                               /* The name is:
> > > +                                * a) uprobe: file name
> > > +                                * b) kprobe: kernel function
> > > +                                */
> > > +                               __aligned_u64 name; /* in/out: name b=
uffer ptr */
> > > +                               __u32 name_len;
> > > +                               __u32 offset;   /* offset from the na=
me */
> > > +                               __u64 addr;
> > > +                               __u8 retprobe;
> > > +                       } probe; /* uprobe, kprobe */
> > > +                       struct {
> > > +                               /* in/out: tracepoint name buffer ptr=
 */
> > > +                               __aligned_u64 tp_name;
> > > +                               __u32 name_len;
> > > +                       } tp; /* tracepoint */
> > > +                       struct {
> > > +                               __u64 config;
> > > +                               __u32 type;
> > > +                       } event; /* generic perf event */
> >
> > how should the user know which of those structs are relevant? we need
> > some enum to specify what kind of perf_event link it is?
> >
>
> Do you mean that we add a new field 'type' into the union perf_event,
> as follows ?
>     union {
>         __u32 type;
>         struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
>         struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
>         struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
>     };
>

Correct it:

struct {
    __u32 type;
    union {
         struct {} probe;  /* BPF_LINK_TYPE_PERF_EVENT_PROBE */
         struct {} tp; /* BPF_LINK_TYPE_PERF_EVENT_TP */
         struct {} event; /* BPF_LINK_TYPE_PERF_EVENT_EVENT */
     };
} perf_event;

--=20
Regards
Yafang

