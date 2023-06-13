Return-Path: <bpf+bounces-2473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B172D76E
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 04:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6E22811C5
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FFF17F9;
	Tue, 13 Jun 2023 02:48:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DA7F
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 02:48:22 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8A172A;
	Mon, 12 Jun 2023 19:48:19 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62df84f9f04so272836d6.1;
        Mon, 12 Jun 2023 19:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686624498; x=1689216498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGeVBDo3uxTOQQplex0LojqeCty18uS8RH/dZxN0aPM=;
        b=W7L93dgiqY8CjhRZ7U0UzIWK1d+e3xJKlKwMbSLzzY3Gzvd3Qr6xRcUUpWVRlGyCBP
         6Y5HY4sZFSxKWVMN4nMBBFBVzsF3ZNHwm8ToeB+/L/kbtPnUGbnrkYJitgal2PqZ3QRh
         JDtyd0yO6cXM3L/d5uOPYnOUEeEbP5PhBEvp4+VF3deb4IdV7/7zBJ6rgLwRQzTHX5gw
         5quJk+phdeFS4aUdY0z4PvU+eR4q3FQGysj62oOU4rYopzQEd2OoXeJU+ljul2fNGJUA
         Sd2bs8j35+l68Eeo3lXWmHDEV4Q2P4CoJK8c7a3lhsgWJUUBUFXyX5D8C9NttN7Fqrco
         zA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686624498; x=1689216498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGeVBDo3uxTOQQplex0LojqeCty18uS8RH/dZxN0aPM=;
        b=G275FmA4/Tcnv1+lpDXBoNZJZj/Sf9QMrmPHVMoJfuax6bBQOD8jVcEHyeNd8rbO+Z
         fmMPXowceL91M3R789OqRJjUpl+SKyBcdpFMatYyms4aOqnQzjeNZuhUjfYci0MnQ2Am
         21RMrlNmAqdAqBRV48BuBLErfoX5nReIGSqI20VeKkgG/IGzcrCRGz6yQxV4X4zUsq06
         tLpSm4Sf77Taelw67KLJ0/D3EXDKCuzkjZ/UGi6kKF5Bl8mzCxbgXqjcfiw8cOWuyAPP
         0LiokPrLSUG/3dVrGShMpPmm3nnc3VQgzmCUcPDmR2RjcQCZ2BBUqWHYDpnbE2AXeBJF
         n9TA==
X-Gm-Message-State: AC+VfDwXN/qG6ambZLKjfCbPj2HCduPxdHCJexwcpiXM234iEH7ycuAd
	CeZdwPkZqqf2nT/MbcEQcHFP1eKPcxqLJsMfMQgjsIynp4FUtkgP
X-Google-Smtp-Source: ACHHUZ7GV/j0q8FzJ04Ypt3Rk0HgoiYDeBaDqgTHg14Ua2dxpYQyt7Izeh9ehn7aLwYpTtNwI3gb4hRREQCfceD5v9c=
X-Received: by 2002:a05:6214:27e1:b0:62d:d809:1f7 with SMTP id
 jt1-20020a05621427e100b0062dd80901f7mr8450303qvb.21.1686624498642; Mon, 12
 Jun 2023 19:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-9-laoar.shao@gmail.com>
 <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com>
In-Reply-To: <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 13 Jun 2023 10:47:42 +0800
Message-ID: <CALOAHbCfEDmkbLeQG1wmBF7q3AaMSyZpxRGyFJ=9VugUdDpCsQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
To: Yonghong Song <yhs@meta.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 13, 2023 at 1:36=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/12/23 8:16 AM, Yafang Shao wrote:
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
> > A new enum bpf_link_perf_event_type is introduced to help the user
> > understand which struct is relevant.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >   include/uapi/linux/bpf.h       |  32 +++++++++++
> >   kernel/bpf/syscall.c           | 124 ++++++++++++++++++++++++++++++++=
+++++++++
> >   tools/include/uapi/linux/bpf.h |  32 +++++++++++
> >   3 files changed, 188 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 23691ea..8d4556e 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1056,6 +1056,16 @@ enum bpf_link_type {
> >       MAX_BPF_LINK_TYPE,
> >   };
> >
> > +enum bpf_perf_link_type {
> > +     BPF_PERF_LINK_UNSPEC =3D 0,
> > +     BPF_PERF_LINK_UPROBE =3D 1,
> > +     BPF_PERF_LINK_KPROBE =3D 2,
> > +     BPF_PERF_LINK_TRACEPOINT =3D 3,
> > +     BPF_PERF_LINK_PERF_EVENT =3D 4,
> > +
> > +     MAX_BPF_LINK_PERF_EVENT_TYPE,
> > +};
> > +
> >   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> >    *
> >    * NONE(default): No further bpf programs allowed in the subtree.
> > @@ -6443,7 +6453,29 @@ struct bpf_link_info {
> >                       __u32 count;
> >                       __u32 flags;
> >               } kprobe_multi;
> > +             struct {
> > +                     __u64 config;
> > +                     __u32 type;
> > +             } perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
> > +             struct {
> > +                     __aligned_u64 file_name; /* in/out: buff ptr */
> > +                     __u32 name_len;
> > +                     __u32 offset;            /* offset from name */
> > +                     __u32 flags;
> > +             } uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
> > +             struct {
> > +                     __aligned_u64 func_name; /* in/out: buff ptr */
> > +                     __u32 name_len;
> > +                     __u32 offset;            /* offset from name */
> > +                     __u64 addr;
> > +                     __u32 flags;
> > +             } kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
> > +             struct {
> > +                     __aligned_u64 tp_name;   /* in/out: buff ptr */
> > +                     __u32 name_len;
> > +             } tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
> >       };
> > +     __u32 perf_link_type; /* enum bpf_perf_link_type */
>
> I think put perf_link_type into each indivual struct is better.
> It won't increase the bpf_link_info struct size. It will allow
> extensions for all structs in the big union (raw_tracepoint,
> tracing, cgroup, iter, ..., kprobe_multi, ...) etc.

If we put it into each individual struct, we have to choose one
specific struct to get the type before we use the real struct, for
example,
    if (info.perf_event.type =3D=3D BPF_PERF_LINK_PERF_EVENT)
              goto out;
    if (info.perf_event.type =3D=3D BPF_PERF_LINK_TRACEPOINT &&
               !info.tracepoint.tp_name) {
               info.tracepoint.tp_name =3D (unsigned long)&buf;
               info.tracepoint.name_len =3D sizeof(buf);
               goto again;
      }
      ...

That doesn't look perfect.

However I agree with you that the perf_link_type may disallow the
extensions for the big union.  I will think about it.

--=20
Regards
Yafang

