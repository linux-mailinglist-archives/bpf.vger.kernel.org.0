Return-Path: <bpf+bounces-15027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2297EA8BF
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 03:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0A01C20A33
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 02:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5498487;
	Tue, 14 Nov 2023 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llsIkD4/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248898F45
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 02:31:33 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154419B;
	Mon, 13 Nov 2023 18:31:31 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7eef0b931so59524537b3.0;
        Mon, 13 Nov 2023 18:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699929090; x=1700533890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhq3BMji2JsqBVPjJVodYR9QqxfNwbcn8XENMmyckWg=;
        b=llsIkD4/WcijM2rIahbYP65JzQ4ifD2cg9MeJomHhXt8DUeAztsqjFMzUpSLXz20xv
         gGZFy6Xj1WqabQgNguxU4bX4duwJd3R5Bz8jEpyyNocq5u3YxFZZVdeO//j2RknjqeBw
         QpclwL4bqofeg6wdYQEn2NW+mnv0QrouerJ7C0kp/ot0h+i2E46RMhIDs4QF3wlHgu2D
         I9iEVHNdTkzfIt9R7M4MKbCZNDG/UpodyHMG5gclm3cZ6vs2ynNJSa/uTnmeBRKssjB0
         hoSjebODO4ZvIFOqPzGZQeB+/IY01jYxJXzJsvI82jBlpcGO588SjXiLFGOYe7eSp+n2
         eygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699929090; x=1700533890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lhq3BMji2JsqBVPjJVodYR9QqxfNwbcn8XENMmyckWg=;
        b=eh4hXNvJ4975ZGVZ9JLlUtapoH9zhEg2iLDGM+TSfFrR6GrkykifujfEtrPG3PuvTF
         SgEY0vmLXTfeSP35kXs6z3PCKcGukJ+kBLPpqBaZUSbnnWcNRvOxxBgrLQZozwLEOjg4
         VqhMdJcXdGEJCl8kWyge9zN6KE21RmUS48SOYjLl3w30e90b221YSqPjhZXcZ/nl1mNe
         6UiwAl+SaIYEsk4WdsrmU0fGQqLpt8AiGRcUVWa9XnsxXt0dFtfezUC4kTKWv0kZUhGB
         TrM36TCxQJ49GFl8+YutpraE2wgq7Sa01wfCy7QM6WTZfcG9hxseSDdfQ38FsxUtaQlx
         mtlw==
X-Gm-Message-State: AOJu0Yx3exFB/bWnzF6AKe8OA37XpTU/fV1VQJ1tRJeq4DYyL0OCKMSK
	5T7PmW8wvaYZ8Z1/ZC3V0EeLYkvVBlj1sWt41q/eTGVOto4M1eG/
X-Google-Smtp-Source: AGHT+IG0Oepn9YXd0wpWq7Ya4tLQsUeBzaZNVuDytpS8Kamf68LKdJwLqFvSd8jhxMfzrfMTAsMoA6ezj34r9ScFqlc=
X-Received: by 2002:a81:8306:0:b0:5b3:22f1:e42f with SMTP id
 t6-20020a818306000000b005b322f1e42fmr9085333ywf.26.1699929090431; Mon, 13 Nov
 2023 18:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com> <CAFqZXNsd5QCPQmOprf_iCCDNj8JKLjZWu3yA2=HtCYE+78F75A@mail.gmail.com>
In-Reply-To: <CAFqZXNsd5QCPQmOprf_iCCDNj8JKLjZWu3yA2=HtCYE+78F75A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 14 Nov 2023 10:30:53 +0800
Message-ID: <CALOAHbDdh+pPExJO391vn+WL+6C65Y4b5M7b0eLGyriACS_VWA@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 4:50=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Mon, Nov 13, 2023 at 4:17=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> > >
> > > On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > > Background
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > In our containerized environment, we've identified unexpected OOM e=
vents
> > > > where the OOM-killer terminates tasks despite having ample free mem=
ory.
> > > > This anomaly is traced back to tasks within a container using mbind=
(2) to
> > > > bind memory to a specific NUMA node. When the allocated memory on t=
his node
> > > > is exhausted, the OOM-killer, prioritizing tasks based on oom_score=
,
> > > > indiscriminately kills tasks. This becomes more critical with guara=
nteed
> > > > tasks (oom_score_adj: -998) aggravating the issue.
> > >
> > > Is there some reason why you can't fix the callers of mbind(2)?
> > > This looks like an user space configuration error rather than a
> > > system security issue.
> >
> > It appears my initial description may have caused confusion. In this
> > scenario, the caller is an unprivileged user lacking any capabilities.
> > While a privileged user, such as root, experiencing this issue might
> > indicate a user space configuration error, the concerning aspect is
> > the potential for an unprivileged user to disrupt the system easily.
> > If this is perceived as a misconfiguration, the question arises: What
> > is the correct configuration to prevent an unprivileged user from
> > utilizing mbind(2)?"
> >
> > >
> > > >
> > > > The selected victim might not have allocated memory on the same NUM=
A node,
> > > > rendering the killing ineffective. This patch aims to address this =
by
> > > > disabling MPOL_BIND in container environments.
> > > >
> > > > In the container environment, our aim is to consolidate memory reso=
urce
> > > > control under the management of kubelet. If users express a prefere=
nce for
> > > > binding their memory to a specific NUMA node, we encourage the adop=
tion of
> > > > a standardized approach. Specifically, we recommend configuring thi=
s memory
> > > > policy through kubelet using cpuset.mems in the cpuset controller, =
rather
> > > > than individual users setting it autonomously. This centralized app=
roach
> > > > ensures that NUMA nodes are globally managed through kubelet, promo=
ting
> > > > consistency and facilitating streamlined administration of memory r=
esources
> > > > across the entire containerized environment.
> > >
> > > Changing system behavior for a single use case doesn't seem prudent.
> > > You're introducing a bunch of kernel code to avoid fixing a broken
> > > user space configuration.
> >
> > Currently, there is no mechanism in place to proactively prevent an
> > unprivileged user from utilizing mbind(2). The approach adopted is to
> > monitor mbind(2) through a BPF program and trigger an alert if its
> > usage is detected. However, beyond this monitoring, the only recourse
> > is to verbally communicate with the user, advising against the use of
> > mbind(2). As a result, users will question why mbind(2) isn't outright
> > prohibited in the first place.
>
> Is there a reason why you can't use syscall filtering via seccomp(2)?
> AFAIK, all the mainstream container tooling already has support for
> specifying seccomp filters for containers.

seccomp is relatively heavyweight, making it less suitable for
enabling in our production environment. In contrast, LSM offer a more
lightweight and flexible alternative. Moreover, the act of binding to
a specific NUMA node appears akin to a privileged operation,
warranting the consideration of a dedicated LSM hook.

--=20
Regards
Yafang

