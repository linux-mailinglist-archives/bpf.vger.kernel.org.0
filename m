Return-Path: <bpf+bounces-3095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B130C739425
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB1F1C20F32
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3015DA;
	Thu, 22 Jun 2023 00:54:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DE816
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 00:54:53 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D20AC;
	Wed, 21 Jun 2023 17:54:52 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62fe1e6dc65so56730306d6.0;
        Wed, 21 Jun 2023 17:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687395291; x=1689987291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhEbBWHIypMw61JOOPLGvDdxXLPKK9jdyQmx1O7IWlo=;
        b=JVmKYqjrNwCLvgqL9E0hZ2ZF3TbMO53A1GQDXa4UbTlI7b4tQ8AXb2ZPJ9z9V9yiOt
         nxUtqpLoFIQT2GjxPoIrFQJJFxN7XJA+1yNeJmdrQGvDf1OHVl177jJvbhgBJn95KN3k
         6S758I00Ms2k5gOvSgSlriPCdoQS9A2gPf1KVKJFEhNRt5y4NXdE1PgRmHbROh7ReN0b
         Sl7e41CY0odz/qzwlPxuEgmB3iY6Rep9gmmISJz9MMEmyYW4BGNZmG9/8Hrn0MyFNtSg
         ihfAqK+X51UidtYvzZwjH1/DT71LAKpEAWqivPiYeJRmDNxljy89h2PWxnPvdNRA6Tmg
         C0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687395291; x=1689987291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhEbBWHIypMw61JOOPLGvDdxXLPKK9jdyQmx1O7IWlo=;
        b=XJ9XouREQ+PYcf1seMrL8R+bRZShDq1/aGKfm/14XSOJiHs/Y3K6xdGo+zmm3GqGJZ
         4x1oz/xmsZqMAzaylv4nDglpjodtIyp1zjd4wSdOeZJDRhZ0Fj/W8k38QoLl8mE5QFwJ
         Ro4+dMvq9XG/OvBvt3AuKHILRMGstbZdnDCcgeOOwmjTFOg2AluCzCCc480yKAsHyxqu
         GG1L7ZJr60LDcurfC2frq+WaiVpJQwijrxY3ASDq3u9eZVwPqj1MCVRWeJOQeMtJz850
         K1D4d6gRiLyrmOCYSEVjhltzZpheGHr+kP7UhBEEJzyqm8YNCfrB0BCK41jGxeWYNF/5
         LjHQ==
X-Gm-Message-State: AC+VfDw15ema8OJgdcLe2ahTeyZ7gjCFD40oU+kHxTn14xV+IF3oucav
	2alrOqa9D1KTNDYUOu+ra2nsJm+WMb2ueMNw1TM=
X-Google-Smtp-Source: ACHHUZ4TaIVIbBI/Acb0+B/6fagXLWc8nE2mIGvg0bPg0Kd+7E4Ursgl/9aFa/+omdKikkuFKFPFEfEFcbWKHlCg3ts=
X-Received: by 2002:a05:6214:21ec:b0:62f:f276:39fe with SMTP id
 p12-20020a05621421ec00b0062ff27639femr20466604qvj.15.1687395291247; Wed, 21
 Jun 2023 17:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620163008.3718-1-laoar.shao@gmail.com> <20230620163008.3718-10-laoar.shao@gmail.com>
 <e28f69ce-e3c0-37ab-f139-7b6d73814445@meta.com>
In-Reply-To: <e28f69ce-e3c0-37ab-f139-7b6d73814445@meta.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 Jun 2023 08:54:13 +0800
Message-ID: <CALOAHbBB8YvzCfR7CrZpbO4JqTAvBd6Ukjd9ozE750da1DLCUQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/11] bpf: Support ->fill_link_info for perf_event
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

On Thu, Jun 22, 2023 at 7:00=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 6/20/23 9:30 AM, Yafang Shao wrote:
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
> >   include/uapi/linux/bpf.h       |  36 +++++++++++++
> >   kernel/bpf/syscall.c           | 115 ++++++++++++++++++++++++++++++++=
+++++++++
> >   tools/include/uapi/linux/bpf.h |  36 +++++++++++++
> >   3 files changed, 187 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 23691ea..56528dd 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1056,6 +1056,16 @@ enum bpf_link_type {
> >       MAX_BPF_LINK_TYPE,
> >   };
> >
> > +enum bpf_perf_event_type {
> > +     BPF_PERF_EVENT_UNSPEC =3D 0,
> > +     BPF_PERF_EVENT_UPROBE =3D 1,
> > +     BPF_PERF_EVENT_KPROBE =3D 2,
> > +     BPF_PERF_EVENT_TRACEPOINT =3D 3,
> > +     BPF_PERF_EVENT_EVENT =3D 4,
> > +
> > +     MAX_BPF_PERF_EVENT_TYPE,
> > +};
> > +
> >   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
> >    *
> >    * NONE(default): No further bpf programs allowed in the subtree.
> > @@ -6443,6 +6453,32 @@ struct bpf_link_info {
> >                       __u32 count;
> >                       __u32 flags;
> >               } kprobe_multi;
> > +             struct {
> > +                     __u32 type; /* enum bpf_perf_event_type */
>
> Maybe add the following
>                         __u32 :32;
> so later on this field can be reused if another u32 is needed in
> the future?

Good point. Will do it.

--=20
Regards
Yafang

