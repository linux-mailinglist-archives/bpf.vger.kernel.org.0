Return-Path: <bpf+bounces-2779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE6733DBD
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 05:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453FE28191A
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9169A48;
	Sat, 17 Jun 2023 03:14:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE83A28
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 03:14:13 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBA3AA8;
	Fri, 16 Jun 2023 20:14:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62ffdbd6787so9975906d6.0;
        Fri, 16 Jun 2023 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686971651; x=1689563651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhAFan/4AMOtXr6GMXSn3VIzi1xye6SvBT4rMGISynU=;
        b=P9ON0um/pkbOHVCT0lvWKmcUiBZZQ9gL5cioM6Vwto+z2CoTgThUPxTKvwFfrSWpcB
         CNT5CTQV6x4TI69wRq007gwjiHezI5neea0f+S4hEZzRe+q6D9pi20oicXAV73R6THWu
         gBzC1TSjK3bjHvD+qUny6RYxzkjkxQx8npITzzbeWyZ0D9aJNUb/bz1uSIYd/im0j21g
         DGTN8BuGubQlDMDGS0LI68csViSaTYMmYgekssap1FcgEM00oDFJbl2qQKcoAd/5IbUm
         UxqRTKcWao0s9ID/pJpE0Nk7QrVgRzN3BBicN+d2FN3xrCZPuteqcWQyXPyJAdvqj7Zc
         k9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686971651; x=1689563651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhAFan/4AMOtXr6GMXSn3VIzi1xye6SvBT4rMGISynU=;
        b=TdGjso7JgrnLKgXXTEBo6KRvFXYhOHkTHW853kTyHhfiJdzK8sJmTkA9dcg9agP94N
         YCQP2l9DgcnIR1yC9TJ/qy87YeqdlmGVj7GgeusYzN6VjcnZgDWrePb/3GYtqnd3UzOi
         hj46GtBE0vGre9jAIh5gCqvxQZ5r+/N7sy1P6diz/kEbhf+33WCYMYNRgUJjo/SaxQQk
         6X2myqXZhv21kJft0pPZMQJ6/Cs+owXdc5QlEkcXNzcPsD6lduB+tW9F2pwvaJ+0l040
         Se6INfUF3VQOVX78LEcTeACpbMVUs5MZ4x7eLs2XpMK7zg4VraWHh3MhFwLlwzpiU0oA
         Q+8Q==
X-Gm-Message-State: AC+VfDxRrtVWYPEynXR9amwqrrtvjCdG3R+Ud6wNGD27akQ3vYljFTAq
	UFSXIaJ7a9Fz1gES+NvkmV7bw6OrLaxE8umWjMw=
X-Google-Smtp-Source: ACHHUZ7NctXUVPLJQFpKsxPm7GqMSw5eyT02GS+Q85lSfnZK1d3iwL3Voi4/Ds5ZfrwJ0FOCxlNGCsvfrD3p6Exmjf8=
X-Received: by 2002:a05:6214:b68:b0:62d:d4a2:ef0e with SMTP id
 ey8-20020a0562140b6800b0062dd4a2ef0emr5100209qvb.4.1686971650729; Fri, 16 Jun
 2023 20:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-9-laoar.shao@gmail.com>
 <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com> <CALOAHbCfEDmkbLeQG1wmBF7q3AaMSyZpxRGyFJ=9VugUdDpCsQ@mail.gmail.com>
 <394cb661-4d19-8d44-d211-526fb80024ec@gmail.com> <CALOAHbCVJh5ZWDjUb46Y+XG+sD83rPoeoCnyWhA4qgfaZ2jzpw@mail.gmail.com>
 <CAEf4BzaUjbh393EsyRByRVLgVZcWfFh7g1BDVrPeptmkeBppAg@mail.gmail.com>
In-Reply-To: <CAEf4BzaUjbh393EsyRByRVLgVZcWfFh7g1BDVrPeptmkeBppAg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 17 Jun 2023 11:13:34 +0800
Message-ID: <CALOAHbD_LLTJwtRxVhD2oTyGFdF2EPgRRUL1uNtAUteDWOxUcg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Yonghong Song <yhs@meta.com>, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
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

On Sat, Jun 17, 2023 at 4:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 13, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Jun 14, 2023 at 10:34=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.=
com> wrote:
> > >
> > >
> > >
> > > On 6/12/23 19:47, Yafang Shao wrote:
> > > > On Tue, Jun 13, 2023 at 1:36=E2=80=AFAM Yonghong Song <yhs@meta.com=
> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 6/12/23 8:16 AM, Yafang Shao wrote:
> > > >>> By introducing support for ->fill_link_info to the perf_event lin=
k, users
> > > >>> gain the ability to inspect it using `bpftool link show`. While t=
he current
> > > >>> approach involves accessing this information via `bpftool perf sh=
ow`,
> > > >>> consolidating link information for all link types in one place of=
fers
> > > >>> greater convenience. Additionally, this patch extends support to =
the
> > > >>> generic perf event, which is not currently accommodated by
> > > >>> `bpftool perf show`. While only the perf type and config are expo=
sed to
> > > >>> userspace, other attributes such as sample_period and sample_freq=
 are
> > > >>> ignored. It's important to note that if kptr_restrict is not perm=
itted, the
> > > >>> probed address will not be exposed, maintaining security measures=
.
> > > >>>
> > > >>> A new enum bpf_link_perf_event_type is introduced to help the use=
r
> > > >>> understand which struct is relevant.
> > > >>>
> > > >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > >>> ---
> > > >>>    include/uapi/linux/bpf.h       |  32 +++++++++++
> > > >>>    kernel/bpf/syscall.c           | 124 +++++++++++++++++++++++++=
++++++++++++++++
> > > >>>    tools/include/uapi/linux/bpf.h |  32 +++++++++++
> > > >>>    3 files changed, 188 insertions(+)
> > > >>>
> > > >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > >>> index 23691ea..8d4556e 100644
> > > >>> --- a/include/uapi/linux/bpf.h
> > > >>> +++ b/include/uapi/linux/bpf.h
> > > >>> @@ -1056,6 +1056,16 @@ enum bpf_link_type {
> > > >>>        MAX_BPF_LINK_TYPE,
> > > >>>    };
> > > >>>
> > > >>> +enum bpf_perf_link_type {
> > > >>> +     BPF_PERF_LINK_UNSPEC =3D 0,
> > > >>> +     BPF_PERF_LINK_UPROBE =3D 1,
> > > >>> +     BPF_PERF_LINK_KPROBE =3D 2,
> > > >>> +     BPF_PERF_LINK_TRACEPOINT =3D 3,
> > > >>> +     BPF_PERF_LINK_PERF_EVENT =3D 4,
> > > >>> +
> > > >>> +     MAX_BPF_LINK_PERF_EVENT_TYPE,
> > > >>> +};
> > > >>> +
> > > >>>    /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> > > >>>     *
> > > >>>     * NONE(default): No further bpf programs allowed in the subtr=
ee.
> > > >>> @@ -6443,7 +6453,29 @@ struct bpf_link_info {
> > > >>>                        __u32 count;
> > > >>>                        __u32 flags;
> > > >>>                } kprobe_multi;
> > > >>> +             struct {
> > > >>> +                     __u64 config;
> > > >>> +                     __u32 type;
> > > >>> +             } perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
> > > >>> +             struct {
> > > >>> +                     __aligned_u64 file_name; /* in/out: buff pt=
r */
> > > >>> +                     __u32 name_len;
> > > >>> +                     __u32 offset;            /* offset from nam=
e */
> > > >>> +                     __u32 flags;
> > > >>> +             } uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
> > > >>> +             struct {
> > > >>> +                     __aligned_u64 func_name; /* in/out: buff pt=
r */
> > > >>> +                     __u32 name_len;
> > > >>> +                     __u32 offset;            /* offset from nam=
e */
> > > >>> +                     __u64 addr;
> > > >>> +                     __u32 flags;
> > > >>> +             } kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
> > > >>> +             struct {
> > > >>> +                     __aligned_u64 tp_name;   /* in/out: buff pt=
r */
> > > >>> +                     __u32 name_len;
> > > >>> +             } tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
> > > >>>        };
> > > >>> +     __u32 perf_link_type; /* enum bpf_perf_link_type */
> > > >>
> > > >> I think put perf_link_type into each indivual struct is better.
> > > >> It won't increase the bpf_link_info struct size. It will allow
> > > >> extensions for all structs in the big union (raw_tracepoint,
> > > >> tracing, cgroup, iter, ..., kprobe_multi, ...) etc.
> > > >
> > > > If we put it into each individual struct, we have to choose one
> > > > specific struct to get the type before we use the real struct, for
> > > > example,
> > > >      if (info.perf_event.type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> > > >                goto out;
> > > >      if (info.perf_event.type =3D=3D BPF_PERF_LINK_TRACEPOINT &&
> > > >                 !info.tracepoint.tp_name) {
> > > >                 info.tracepoint.tp_name =3D (unsigned long)&buf;
> > > >                 info.tracepoint.name_len =3D sizeof(buf);
> > > >                 goto again;
> > > >        }
> > > >        ...
> > > >
> > > > That doesn't look perfect.
> > >
> > > How about adding a common struct?
> > >
> > >   struct {
> > >         __u32 type;
> > >   } perf_common;
> > >
> > > Then you check info.perf_common.type.
> >
> > I perfer below struct,
>
> +1, we should do it this way
>
> >                 struct {
> >                         __u32 type; /* enum bpf_perf_link_type */
> >                         union {
> >                                 struct {
> >                                         __u64 config;
> >                                         __u32 type;
> >                                 } perf_event; /* BPF_PERF_LINK_PERF_EVE=
NT */
> >                                 struct {
> >                                         __aligned_u64 file_name; /* in/=
out */
> >                                         __u32 name_len;
> >                                         __u32 offset;/* offset from fil=
e_name */
> >                                         __u32 flags;
> >                                 } uprobe; /* BPF_PERF_LINK_UPROBE */
> >                                 struct {
> >                                         __aligned_u64 func_name; /* in/=
out */
> >                                         __u32 name_len;
> >                                         __u32 offset;/* offset from fun=
c_name */
> >                                         __u64 addr;
> >                                         __u32 flags;
> >                                 } kprobe; /* BPF_PERF_LINK_KPROBE */
> >                                 struct {
> >                                         __aligned_u64 tp_name;   /* in/=
out */
> >                                         __u32 name_len;
> >                                 } tracepoint; /* BPF_PERF_LINK_TRACEPOI=
NT */
> >                         };
> >                 } perf_link;
>
> this should be named "perf_event" to match BPF_LINK_TYPE_PERF_EVENT
>
> and "perf_event" above probably could be just "event" then? Similarly
> we can s/BPF_PERF_LINK_PERF_EVENT/BPF_PERF_LINK_EVENT/?

Agree. Will change it.

--=20
Regards
Yafang

