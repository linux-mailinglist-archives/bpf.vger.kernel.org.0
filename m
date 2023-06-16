Return-Path: <bpf+bounces-2769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269A733AF1
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 22:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683B41C210D5
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C672109;
	Fri, 16 Jun 2023 20:36:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D9ECB
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 20:36:34 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF23A92;
	Fri, 16 Jun 2023 13:36:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a270e4d57so1483267a12.3;
        Fri, 16 Jun 2023 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686947791; x=1689539791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH0UuJMFS+i12GjY0PYabazRKVeFbjeGp2RODQp6LbM=;
        b=a9+YYV10/nmIA/uFd9BzykiXJHyb36oxBBT/dBHHEtJ6axWc5vfYCxvUjCCXPZ0oR9
         QO2c9GhLvL6tYycJ348pUCluPiYEulgzYiYhgvjoAsOkgdaGcW/oSVSAiQpSJp2hIU56
         BI1kmO0BfqrS28Q4lp1DaZYkrzCOqdr1BBdI+bnp0lQfdFiopbQSRG6N5MdonFjf7mYt
         AECoM8VkKRnXAZbJhiErmGs1viDtqQZpv3Kxcr95bsFF1/cWItPSWVsx/iM47xQ7aOPS
         DV4EB9rSOksNMd14ONK6w7Y6kg0HVeb8GENM+92CJV7hwMXOvCinJqV4/zAjK+eHR71I
         zvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686947791; x=1689539791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH0UuJMFS+i12GjY0PYabazRKVeFbjeGp2RODQp6LbM=;
        b=Hc0+saY1WOI1qEXE5oGBpxZ4AhN9OZtIR0jXEZMQDi7vTEw31SS1qtdye+kKqgpjzC
         FTxBl9hUZoDzJNC2bW3mxkSSBfBAm8wQbuBeUFdtxbvxSbYNRxVppDOjPffgyjwn4Qif
         uOrXUbTpH2mYabFucmWVFoFaEa1QWxJ8xuaws3rZf9ugLBISt6rCHGbK5Em/fLCr2YD5
         X9Z7NZiiIeiw7HWLx4cCzo7lsvDA3iFddSchsPlvP1DbYl/UnvSQgaGzb7IIj6Zv/FHP
         ceOSmTr+KX9P+P6qUL4ijV11BRULJd5DXc2PkaHA80ZUOzexEj4f7LQn//vPMYosQrH7
         UOVw==
X-Gm-Message-State: AC+VfDx5B6X/c7vqejbZgSGAynvrKuR2jretAuzgBFwzgaNej8WHiLhq
	c3tGRQKc82i4NSOcdlUWamk9NI6+ALVEG/LVd0AXGwbQZlIy2Q==
X-Google-Smtp-Source: ACHHUZ6qP50aO+8laZSNDmL+0CUcZ3fiUAf+QI1yjBV62cazmipVbHjHgqErdzHE1817WxzRsUx/CT5OHhsXozLYR/8=
X-Received: by 2002:aa7:d7d4:0:b0:518:92ad:bb04 with SMTP id
 e20-20020aa7d7d4000000b0051892adbb04mr2113537eds.14.1686947791236; Fri, 16
 Jun 2023 13:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-9-laoar.shao@gmail.com>
 <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com> <CALOAHbCfEDmkbLeQG1wmBF7q3AaMSyZpxRGyFJ=9VugUdDpCsQ@mail.gmail.com>
 <394cb661-4d19-8d44-d211-526fb80024ec@gmail.com> <CALOAHbCVJh5ZWDjUb46Y+XG+sD83rPoeoCnyWhA4qgfaZ2jzpw@mail.gmail.com>
In-Reply-To: <CALOAHbCVJh5ZWDjUb46Y+XG+sD83rPoeoCnyWhA4qgfaZ2jzpw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jun 2023 13:36:19 -0700
Message-ID: <CAEf4BzaUjbh393EsyRByRVLgVZcWfFh7g1BDVrPeptmkeBppAg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
To: Yafang Shao <laoar.shao@gmail.com>
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

On Tue, Jun 13, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Jun 14, 2023 at 10:34=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.co=
m> wrote:
> >
> >
> >
> > On 6/12/23 19:47, Yafang Shao wrote:
> > > On Tue, Jun 13, 2023 at 1:36=E2=80=AFAM Yonghong Song <yhs@meta.com> =
wrote:
> > >>
> > >>
> > >>
> > >> On 6/12/23 8:16 AM, Yafang Shao wrote:
> > >>> By introducing support for ->fill_link_info to the perf_event link,=
 users
> > >>> gain the ability to inspect it using `bpftool link show`. While the=
 current
> > >>> approach involves accessing this information via `bpftool perf show=
`,
> > >>> consolidating link information for all link types in one place offe=
rs
> > >>> greater convenience. Additionally, this patch extends support to th=
e
> > >>> generic perf event, which is not currently accommodated by
> > >>> `bpftool perf show`. While only the perf type and config are expose=
d to
> > >>> userspace, other attributes such as sample_period and sample_freq a=
re
> > >>> ignored. It's important to note that if kptr_restrict is not permit=
ted, the
> > >>> probed address will not be exposed, maintaining security measures.
> > >>>
> > >>> A new enum bpf_link_perf_event_type is introduced to help the user
> > >>> understand which struct is relevant.
> > >>>
> > >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > >>> ---
> > >>>    include/uapi/linux/bpf.h       |  32 +++++++++++
> > >>>    kernel/bpf/syscall.c           | 124 +++++++++++++++++++++++++++=
++++++++++++++
> > >>>    tools/include/uapi/linux/bpf.h |  32 +++++++++++
> > >>>    3 files changed, 188 insertions(+)
> > >>>
> > >>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >>> index 23691ea..8d4556e 100644
> > >>> --- a/include/uapi/linux/bpf.h
> > >>> +++ b/include/uapi/linux/bpf.h
> > >>> @@ -1056,6 +1056,16 @@ enum bpf_link_type {
> > >>>        MAX_BPF_LINK_TYPE,
> > >>>    };
> > >>>
> > >>> +enum bpf_perf_link_type {
> > >>> +     BPF_PERF_LINK_UNSPEC =3D 0,
> > >>> +     BPF_PERF_LINK_UPROBE =3D 1,
> > >>> +     BPF_PERF_LINK_KPROBE =3D 2,
> > >>> +     BPF_PERF_LINK_TRACEPOINT =3D 3,
> > >>> +     BPF_PERF_LINK_PERF_EVENT =3D 4,
> > >>> +
> > >>> +     MAX_BPF_LINK_PERF_EVENT_TYPE,
> > >>> +};
> > >>> +
> > >>>    /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> > >>>     *
> > >>>     * NONE(default): No further bpf programs allowed in the subtree=
.
> > >>> @@ -6443,7 +6453,29 @@ struct bpf_link_info {
> > >>>                        __u32 count;
> > >>>                        __u32 flags;
> > >>>                } kprobe_multi;
> > >>> +             struct {
> > >>> +                     __u64 config;
> > >>> +                     __u32 type;
> > >>> +             } perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
> > >>> +             struct {
> > >>> +                     __aligned_u64 file_name; /* in/out: buff ptr =
*/
> > >>> +                     __u32 name_len;
> > >>> +                     __u32 offset;            /* offset from name =
*/
> > >>> +                     __u32 flags;
> > >>> +             } uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
> > >>> +             struct {
> > >>> +                     __aligned_u64 func_name; /* in/out: buff ptr =
*/
> > >>> +                     __u32 name_len;
> > >>> +                     __u32 offset;            /* offset from name =
*/
> > >>> +                     __u64 addr;
> > >>> +                     __u32 flags;
> > >>> +             } kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
> > >>> +             struct {
> > >>> +                     __aligned_u64 tp_name;   /* in/out: buff ptr =
*/
> > >>> +                     __u32 name_len;
> > >>> +             } tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
> > >>>        };
> > >>> +     __u32 perf_link_type; /* enum bpf_perf_link_type */
> > >>
> > >> I think put perf_link_type into each indivual struct is better.
> > >> It won't increase the bpf_link_info struct size. It will allow
> > >> extensions for all structs in the big union (raw_tracepoint,
> > >> tracing, cgroup, iter, ..., kprobe_multi, ...) etc.
> > >
> > > If we put it into each individual struct, we have to choose one
> > > specific struct to get the type before we use the real struct, for
> > > example,
> > >      if (info.perf_event.type =3D=3D BPF_PERF_LINK_PERF_EVENT)
> > >                goto out;
> > >      if (info.perf_event.type =3D=3D BPF_PERF_LINK_TRACEPOINT &&
> > >                 !info.tracepoint.tp_name) {
> > >                 info.tracepoint.tp_name =3D (unsigned long)&buf;
> > >                 info.tracepoint.name_len =3D sizeof(buf);
> > >                 goto again;
> > >        }
> > >        ...
> > >
> > > That doesn't look perfect.
> >
> > How about adding a common struct?
> >
> >   struct {
> >         __u32 type;
> >   } perf_common;
> >
> > Then you check info.perf_common.type.
>
> I perfer below struct,

+1, we should do it this way

>                 struct {
>                         __u32 type; /* enum bpf_perf_link_type */
>                         union {
>                                 struct {
>                                         __u64 config;
>                                         __u32 type;
>                                 } perf_event; /* BPF_PERF_LINK_PERF_EVENT=
 */
>                                 struct {
>                                         __aligned_u64 file_name; /* in/ou=
t */
>                                         __u32 name_len;
>                                         __u32 offset;/* offset from file_=
name */
>                                         __u32 flags;
>                                 } uprobe; /* BPF_PERF_LINK_UPROBE */
>                                 struct {
>                                         __aligned_u64 func_name; /* in/ou=
t */
>                                         __u32 name_len;
>                                         __u32 offset;/* offset from func_=
name */
>                                         __u64 addr;
>                                         __u32 flags;
>                                 } kprobe; /* BPF_PERF_LINK_KPROBE */
>                                 struct {
>                                         __aligned_u64 tp_name;   /* in/ou=
t */
>                                         __u32 name_len;
>                                 } tracepoint; /* BPF_PERF_LINK_TRACEPOINT=
 */
>                         };
>                 } perf_link;

this should be named "perf_event" to match BPF_LINK_TYPE_PERF_EVENT

and "perf_event" above probably could be just "event" then? Similarly
we can s/BPF_PERF_LINK_PERF_EVENT/BPF_PERF_LINK_EVENT/?

>
> I think that would be more clear.
>
> --
> Regards
> Yafang
>

