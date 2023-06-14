Return-Path: <bpf+bounces-2570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA44272F2A9
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 04:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4D51C20A2A
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93F38A;
	Wed, 14 Jun 2023 02:46:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503417E
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 02:46:19 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459271BDA;
	Tue, 13 Jun 2023 19:46:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62dfd7e6f54so6641756d6.0;
        Tue, 13 Jun 2023 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686710777; x=1689302777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im+kxzJ/Bvuphs8OzZJlVaJGx4HnTKQJFj+CmJbpbpY=;
        b=S4+h6TgpwtJDtZxbTOpWj3Omratic9odTNDLBenu2bDdgzP4aNAX+h5wR9oB0YH7EG
         Tq1NqDePvMIZHy+PNKUi9PP5wDGT9N9ux6GtWQ8BFdajzUNiYpFav8X6Oxfw/1Dqlmdc
         q/PW2DqdaKVQh24+xhOi0yyU1gNoBjtCokxxSKSKHRT/3gfxfyQ69KyYzQUveIpWUaDI
         Z/jQQaijg1iXEiTxY0CRFaWKpZuHS5tsiC1EPf42R96yKvaUMb5JCl0kyYrtUTCqPLsL
         QCEIBHdSwHR2wv2uORxz1/lbb3yGktqGo4NrghCkZsAjQjDOP83aO+o7li5sI+4KD/yX
         lB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686710777; x=1689302777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=im+kxzJ/Bvuphs8OzZJlVaJGx4HnTKQJFj+CmJbpbpY=;
        b=l1ST1ywMddlwa7qOx19nfl6DA1o9LkPfufnP+AWgXjJEfjqqT/XMKGvrCpNmOeGrXo
         GGRuLXCVpbx2pmKkecbEMzvZ8bX65BWIp8+RwLPDod5drvvZpouYnVWkZC8lEPaaS17+
         Rkzo7/RpSjYvybo4pVBp+dBn/sAHdg9IIqBVgOlO+VAoZ//fqpB6ZApCHgGjX8WurPGx
         +e6tHgHlcIR+DtJ8kxRI5qYj/xfXu7W5TOpfac44zrcxDb50YTJ/AnPkykHrq8uNKqnZ
         Kx7JNFcgRQIMcjTFSdAsRjJ/+3nJ5Feoihj5EHgc76+lVUoWQoaMC2TZ7miFaSswjEu9
         fZ/A==
X-Gm-Message-State: AC+VfDy0cwZZItj89eenTvurlfcpGVBCiqMT660sxyGjr+qxkgmJ666w
	f+ykQNFDsLEUGnScmzsYHS+f0TdcK0Q+KUrMpWM=
X-Google-Smtp-Source: ACHHUZ6obxkQXvLqCl0yjzOyR3SH99z/DFcm0KTshbGrMVVZnZuf7u/8h75i2YgiSN85c5j9jos26Ji2Tf/rpA2hqLU=
X-Received: by 2002:ad4:5de3:0:b0:626:101a:f8 with SMTP id jn3-20020ad45de3000000b00626101a00f8mr16281233qvb.25.1686710777363;
 Tue, 13 Jun 2023 19:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-9-laoar.shao@gmail.com>
 <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com> <CALOAHbCfEDmkbLeQG1wmBF7q3AaMSyZpxRGyFJ=9VugUdDpCsQ@mail.gmail.com>
 <394cb661-4d19-8d44-d211-526fb80024ec@gmail.com>
In-Reply-To: <394cb661-4d19-8d44-d211-526fb80024ec@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Jun 2023 10:45:41 +0800
Message-ID: <CALOAHbCVJh5ZWDjUb46Y+XG+sD83rPoeoCnyWhA4qgfaZ2jzpw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com, 
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

On Wed, Jun 14, 2023 at 10:34=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 6/12/23 19:47, Yafang Shao wrote:
> > On Tue, Jun 13, 2023 at 1:36=E2=80=AFAM Yonghong Song <yhs@meta.com> wr=
ote:
> >>
> >>
> >>
> >> On 6/12/23 8:16 AM, Yafang Shao wrote:
> >>> By introducing support for ->fill_link_info to the perf_event link, u=
sers
> >>> gain the ability to inspect it using `bpftool link show`. While the c=
urrent
> >>> approach involves accessing this information via `bpftool perf show`,
> >>> consolidating link information for all link types in one place offers
> >>> greater convenience. Additionally, this patch extends support to the
> >>> generic perf event, which is not currently accommodated by
> >>> `bpftool perf show`. While only the perf type and config are exposed =
to
> >>> userspace, other attributes such as sample_period and sample_freq are
> >>> ignored. It's important to note that if kptr_restrict is not permitte=
d, the
> >>> probed address will not be exposed, maintaining security measures.
> >>>
> >>> A new enum bpf_link_perf_event_type is introduced to help the user
> >>> understand which struct is relevant.
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> ---
> >>>    include/uapi/linux/bpf.h       |  32 +++++++++++
> >>>    kernel/bpf/syscall.c           | 124 +++++++++++++++++++++++++++++=
++++++++++++
> >>>    tools/include/uapi/linux/bpf.h |  32 +++++++++++
> >>>    3 files changed, 188 insertions(+)
> >>>
> >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>> index 23691ea..8d4556e 100644
> >>> --- a/include/uapi/linux/bpf.h
> >>> +++ b/include/uapi/linux/bpf.h
> >>> @@ -1056,6 +1056,16 @@ enum bpf_link_type {
> >>>        MAX_BPF_LINK_TYPE,
> >>>    };
> >>>
> >>> +enum bpf_perf_link_type {
> >>> +     BPF_PERF_LINK_UNSPEC =3D 0,
> >>> +     BPF_PERF_LINK_UPROBE =3D 1,
> >>> +     BPF_PERF_LINK_KPROBE =3D 2,
> >>> +     BPF_PERF_LINK_TRACEPOINT =3D 3,
> >>> +     BPF_PERF_LINK_PERF_EVENT =3D 4,
> >>> +
> >>> +     MAX_BPF_LINK_PERF_EVENT_TYPE,
> >>> +};
> >>> +
> >>>    /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> >>>     *
> >>>     * NONE(default): No further bpf programs allowed in the subtree.
> >>> @@ -6443,7 +6453,29 @@ struct bpf_link_info {
> >>>                        __u32 count;
> >>>                        __u32 flags;
> >>>                } kprobe_multi;
> >>> +             struct {
> >>> +                     __u64 config;
> >>> +                     __u32 type;
> >>> +             } perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
> >>> +             struct {
> >>> +                     __aligned_u64 file_name; /* in/out: buff ptr */
> >>> +                     __u32 name_len;
> >>> +                     __u32 offset;            /* offset from name */
> >>> +                     __u32 flags;
> >>> +             } uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
> >>> +             struct {
> >>> +                     __aligned_u64 func_name; /* in/out: buff ptr */
> >>> +                     __u32 name_len;
> >>> +                     __u32 offset;            /* offset from name */
> >>> +                     __u64 addr;
> >>> +                     __u32 flags;
> >>> +             } kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
> >>> +             struct {
> >>> +                     __aligned_u64 tp_name;   /* in/out: buff ptr */
> >>> +                     __u32 name_len;
> >>> +             } tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
> >>>        };
> >>> +     __u32 perf_link_type; /* enum bpf_perf_link_type */
> >>
> >> I think put perf_link_type into each indivual struct is better.
> >> It won't increase the bpf_link_info struct size. It will allow
> >> extensions for all structs in the big union (raw_tracepoint,
> >> tracing, cgroup, iter, ..., kprobe_multi, ...) etc.
> >
> > If we put it into each individual struct, we have to choose one
> > specific struct to get the type before we use the real struct, for
> > example,
> >      if (info.perf_event.type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> >                goto out;
> >      if (info.perf_event.type =3D=3D BPF_PERF_LINK_TRACEPOINT &&
> >                 !info.tracepoint.tp_name) {
> >                 info.tracepoint.tp_name =3D (unsigned long)&buf;
> >                 info.tracepoint.name_len =3D sizeof(buf);
> >                 goto again;
> >        }
> >        ...
> >
> > That doesn't look perfect.
>
> How about adding a common struct?
>
>   struct {
>         __u32 type;
>   } perf_common;
>
> Then you check info.perf_common.type.

I perfer below struct,
                struct {
                        __u32 type; /* enum bpf_perf_link_type */
                        union {
                                struct {
                                        __u64 config;
                                        __u32 type;
                                } perf_event; /* BPF_PERF_LINK_PERF_EVENT *=
/
                                struct {
                                        __aligned_u64 file_name; /* in/out =
*/
                                        __u32 name_len;
                                        __u32 offset;/* offset from file_na=
me */
                                        __u32 flags;
                                } uprobe; /* BPF_PERF_LINK_UPROBE */
                                struct {
                                        __aligned_u64 func_name; /* in/out =
*/
                                        __u32 name_len;
                                        __u32 offset;/* offset from func_na=
me */
                                        __u64 addr;
                                        __u32 flags;
                                } kprobe; /* BPF_PERF_LINK_KPROBE */
                                struct {
                                        __aligned_u64 tp_name;   /* in/out =
*/
                                        __u32 name_len;
                                } tracepoint; /* BPF_PERF_LINK_TRACEPOINT *=
/
                        };
                } perf_link;

I think that would be more clear.

--=20
Regards
Yafang

