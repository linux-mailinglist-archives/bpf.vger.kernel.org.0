Return-Path: <bpf+bounces-6090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7FD76581B
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D05C1C20FDE
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86F18029;
	Thu, 27 Jul 2023 15:57:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4991FA8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 15:57:17 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A1BC;
	Thu, 27 Jul 2023 08:57:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so18018321fa.2;
        Thu, 27 Jul 2023 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690473434; x=1691078234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vCICIct8K3+YgunPDpZmpu6xpQGPQVUOsCGBeoDwb0=;
        b=OJ+5JYa4jSCXYpoEa2HkyFE5XEpQhdQbMCvYdD2OMcq8h2zaKE+DsuyNLbwpzxTuhK
         m9Ppypg+dkl4PKaZ4/4en+f3cxe3UKwgaRaeqt2XeYCkc63wdlK862yTdDvdW9j3uyyO
         YFPkOTd2HEGdGIvQ5LjqaOcw4L2WqhTiuP/07KutfF8K+6MAYAM9t3usT/YkNwn9Qgv2
         ZDjj8xYjBmboY62Utm/4AUcbXqra3I1/uB+Uxg28SUZlz/oXof4+O0pOcmrCma/Z10Qr
         z8Vj0p9UdiX42w8qAzJefaPQe+tLMn/OUZM2Cx5LYVzEUMBxNpC4Lw51/R/uAI5BcSdY
         ErDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473434; x=1691078234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vCICIct8K3+YgunPDpZmpu6xpQGPQVUOsCGBeoDwb0=;
        b=INZcFVFr89X7KyhlWHCEIqMwUtH6PCUon4ZSohZ43pfbR9/JjsS7PRxXko6J3zFKZI
         Gb4ybUoJeYYbXplMZeJJ3JBt3KrqMLPHps3P8TjE8TKAfECinBmPIU43ayMDQ0o+fd6i
         WPxfn4DdcsEa4kyhW6tOwbjkyhC+6R0eQPGj1uAEId6AelTOkJs3NurWaZ+XlBU5ZUmj
         BBelt6ssjQ0qJvoCb40z/RGf0TbZMp99THYca8pM8mWchCQW4JnThbpQ8QCqieM5VXRB
         FFvXfd3LjgpJAYpoTD1PxMPlWbVQoMaXAzAsqOpCBYkYBG769OfxrGGFrwltWh2oJ05P
         kEYA==
X-Gm-Message-State: ABy/qLa8oTI/pPxgi4l6w8w8KSb0MRzeKcz1zX5EjO0qAu6D9+2YiUP4
	L5jKy1ydgwnpIo5Dq0HJ2cqBCSLBDQ3kVyZ8PiI=
X-Google-Smtp-Source: APBJJlHcMipd8RMktB74Ux8FwWPaimgHQp+yZF0ROaw8GYTovX5qbUn4dFv6d/MIl4/7vPjoXRZWF2a9cDU5CJ5rTCA=
X-Received: by 2002:a05:651c:8c:b0:2b6:e2e4:7d9a with SMTP id
 12-20020a05651c008c00b002b6e2e47d9amr2047420ljq.38.1690473434364; Thu, 27 Jul
 2023 08:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727073632.44983-1-zhouchuyi@bytedance.com> <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
In-Reply-To: <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 08:57:03 -0700
Message-ID: <CAADnVQLdu_6aJH+0wwpKB146HvxkhvL-uRGAqSPZ8jDMAMqX=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com, 
	robin.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 4:45=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 27/07/2023 08:36, Chuyi Zhou wrote:
> > This patchset tries to add a new bpf prog type and use it to select
> > a victim memcg when global OOM is invoked. The mainly motivation is
> > the need to customizable OOM victim selection functionality so that
> > we can protect more important app from OOM killer.
> >
>
> It's a nice use case, but at a high level, the approach pursued here
> is, as I understand it, discouraged for new BPF program development.
> Specifically, adding a new BPF program type with semantics like this
> is not preferred. Instead, can you look at using something like
>
> - using "fmod_ret" instead of a new program type
> - use BPF kfuncs instead of helpers.
> - add selftests in tools/testing/selftests/bpf not samples.

+1 to what Alan said above and below.

Also as Michal said there needs to be a design doc with pros and cons.
We see far too often that people attempt to use BPF in places where it
shouldn't be.
If programmability is not strictly necessary then BPF is not a good fit.

> There's some examples of how solutions have evolved from the traditional
> approach (adding a new program type, helpers etc) to using kfuncs etc on
> this list - for example HID-BPF and the BPF scheduler series - which
> should help orient you. There are presentations from Linux Plumbers 2022
> that walk through some of this too.
>
> Judging by the sample program example, all you should need here is a way
> to override the return value of bpf_oom_set_policy() - a noinline
> function that by default returns a no-op. It can then be overridden by
> an "fmod_ret" BPF program.
>
> One thing you lose is cgroup specificity at BPF attach time, but you can
> always add predicates based on the cgroup to your BPF program if needed.
>
> Alan
>
> > Chuyi Zhou (5):
> >   bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
> >   mm: Select victim memcg using bpf prog
> >   libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
> >   bpf: Add a new bpf helper to get cgroup ino
> >   bpf: Sample BPF program to set oom policy
> >
> >  include/linux/bpf_oom.h        |  22 ++++
> >  include/linux/bpf_types.h      |   2 +
> >  include/linux/memcontrol.h     |   6 ++
> >  include/uapi/linux/bpf.h       |  21 ++++
> >  kernel/bpf/core.c              |   1 +
> >  kernel/bpf/helpers.c           |  17 +++
> >  kernel/bpf/syscall.c           |  10 ++
> >  mm/memcontrol.c                |  50 +++++++++
> >  mm/oom_kill.c                  | 185 +++++++++++++++++++++++++++++++++
> >  samples/bpf/Makefile           |   3 +
> >  samples/bpf/oom_kern.c         |  42 ++++++++
> >  samples/bpf/oom_user.c         | 128 +++++++++++++++++++++++
> >  tools/bpf/bpftool/common.c     |   1 +
> >  tools/include/uapi/linux/bpf.h |  21 ++++
> >  tools/lib/bpf/libbpf.c         |   3 +
> >  tools/lib/bpf/libbpf_probes.c  |   2 +
> >  16 files changed, 514 insertions(+)
> >  create mode 100644 include/linux/bpf_oom.h
> >  create mode 100644 samples/bpf/oom_kern.c
> >  create mode 100644 samples/bpf/oom_user.c
> >

