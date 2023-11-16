Return-Path: <bpf+bounces-15149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B957ED946
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E72E280EE8
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF61C06;
	Thu, 16 Nov 2023 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvf24Vse"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797FB1A4;
	Wed, 15 Nov 2023 18:22:49 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db029574f13so288400276.1;
        Wed, 15 Nov 2023 18:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101368; x=1700706168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGQ9YKX/G2W66tZSKmmzF1Dhr3FgNuFObNkiMHjizoE=;
        b=Dvf24VseY2EgDwQ959YKKmpdKjwyWyzdg6qlgbJJYUlHuhLY595+cIg4uSLcbwduDP
         OA0kcIicEj4a6LCaUo09EUzrBVySGUZ25YKWkgdc+ohlgqLOimQl9i7Z9GGfAXiQjkIf
         BBaqs2z4vT8ejSFv9erL0ljCey1GnYj9DNZUdvkL0U4YidzZrbHg/1CnuqCiHrOnWMDE
         /3Ok7XnxMEvA/g98Lo7CTFeXow0nbNPRXKj6rGeV9lihvdsOca7sq4W1uIyEFQUmMjAQ
         /kpObj85WVZs30zF7Vu2SdUUWq7Yh8Ls6MvdFscLmWgnEbhZU6YJQajrMMdzkGHTqmbg
         4O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101368; x=1700706168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGQ9YKX/G2W66tZSKmmzF1Dhr3FgNuFObNkiMHjizoE=;
        b=UvmebOqI3eKy7IwosHgJCPU7t9S+65/QV4XK1KdS7Nsw0d6uBsBMsUNNmW4HbqFfEF
         pos8/qUa9xJninAUre0+/c8AaqpfKcQh1lYemIuNtBdTuBwQIldM3ulX3OKD/t+qFocP
         DxRQz9SUPb/qQTML8+DepNZXfwdYzVuAb4hDBjIDDW0hut7CvoomRFu4yezc0QwneiYo
         il2L0QugAMvhWUk/lghyFT6m2/FRO6YwiLHE+DdfuC0pzJuGWxB5zNSpxErZMn8V4L5C
         YLErZGv4A1oXttwWN+AqcOkTYgcOnD7O7Rerlk0oeNeDf0eRBdktGnjwAZEgjcMgCfxH
         fZtg==
X-Gm-Message-State: AOJu0Yytg/1mIGc7Zz+STANEDmXR++STN8mivsQEWY4UvxPQGjH9I9Ot
	gjJb5Xb+kTu2JAYAdlqcY9ySrze/X8DrED8P+KyD/tjcRsc=
X-Google-Smtp-Source: AGHT+IEgGri604YUX0vfvdcXXXL+exWNnifxZT2c9KihxjTFs8lzjW8zgVjGk9cWEoukuySq6viBH50vd8iYtM7GLAk=
X-Received: by 2002:a25:e0d5:0:b0:d9a:e6d6:42f8 with SMTP id
 x204-20020a25e0d5000000b00d9ae6d642f8mr15463351ybg.29.1700101368588; Wed, 15
 Nov 2023 18:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <ZVNIprbQU3NqwPi_@tiehlicka> <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
 <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com> <CALOAHbBKCsdmko_ugHZ_z6Zpgo-xJ8j46oPHkHj+gBGsRCR=eA@mail.gmail.com>
 <ZVSFNzf4QCbpLGyF@tiehlicka> <CALOAHbAjHJ_47b15v3d+f3iZZ+vBVsLugKew_t_ZFaJoE2_3uw@mail.gmail.com>
 <ZVT5JG_osL7yFHHA@tiehlicka>
In-Reply-To: <ZVT5JG_osL7yFHHA@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Nov 2023 10:22:12 +0800
Message-ID: <CALOAHbAihVjj4dnc_o60ZsUMZ5Pg+neavsvS9XPkgYaPx-=8ag@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Michal Hocko <mhocko@suse.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 1:00=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 15-11-23 17:33:51, Yafang Shao wrote:
> > On Wed, Nov 15, 2023 at 4:45=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Wed 15-11-23 09:52:38, Yafang Shao wrote:
> > > > On Wed, Nov 15, 2023 at 12:58=E2=80=AFAM Casey Schaufler <casey@sch=
aufler-ca.com> wrote:
> > > > >
> > > > > On 11/14/2023 3:59 AM, Yafang Shao wrote:
> > > > > > On Tue, Nov 14, 2023 at 6:15=E2=80=AFPM Michal Hocko <mhocko@su=
se.com> wrote:
> > > > > >> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> > > > > >>> On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <cas=
ey@schaufler-ca.com> wrote:
> > > > > >>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > > > >>>>> Background
> > > > > >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >>>>>
> > > > > >>>>> In our containerized environment, we've identified unexpect=
ed OOM events
> > > > > >>>>> where the OOM-killer terminates tasks despite having ample =
free memory.
> > > > > >>>>> This anomaly is traced back to tasks within a container usi=
ng mbind(2) to
> > > > > >>>>> bind memory to a specific NUMA node. When the allocated mem=
ory on this node
> > > > > >>>>> is exhausted, the OOM-killer, prioritizing tasks based on o=
om_score,
> > > > > >>>>> indiscriminately kills tasks. This becomes more critical wi=
th guaranteed
> > > > > >>>>> tasks (oom_score_adj: -998) aggravating the issue.
> > > > > >>>> Is there some reason why you can't fix the callers of mbind(=
2)?
> > > > > >>>> This looks like an user space configuration error rather tha=
n a
> > > > > >>>> system security issue.
> > > > > >>> It appears my initial description may have caused confusion. =
In this
> > > > > >>> scenario, the caller is an unprivileged user lacking any capa=
bilities.
> > > > > >>> While a privileged user, such as root, experiencing this issu=
e might
> > > > > >>> indicate a user space configuration error, the concerning asp=
ect is
> > > > > >>> the potential for an unprivileged user to disrupt the system =
easily.
> > > > > >>> If this is perceived as a misconfiguration, the question aris=
es: What
> > > > > >>> is the correct configuration to prevent an unprivileged user =
from
> > > > > >>> utilizing mbind(2)?"
> > > > > >> How is this any different than a non NUMA (mbind) situation?
> > > > > > In a UMA system, each gigabyte of memory carries the same cost.
> > > > > > Conversely, in a NUMA architecture, opting to confine processes=
 within
> > > > > > a specific NUMA node incurs additional costs. In the worst-case
> > > > > > scenario, if all containers opt to bind their memory exclusivel=
y to
> > > > > > specific nodes, it will result in significant memory wastage.
> > > > >
> > > > > That still sounds like you've misconfigured your containers such
> > > > > that they expect to get more memory than is available, and that
> > > > > they have more control over it than they really do.
> > > >
> > > > And again: What configuration method is suitable to limit user cont=
rol
> > > > over memory policy adjustments, besides the heavyweight seccomp
> > > > approach?
> > >
> > > This really depends on the workloads. What is the reason mbind is use=
d
> > > in the first place?
> >
> > It can improve their performance.
> >
> > > Is it acceptable to partition the system so that
> > > there is a numa node reserved for NUMA aware workloads?
> >
> > As highlighted in the commit log, our preference is to configure this
> > memory policy through kubelet using cpuset.mems in the cpuset
> > controller, rather than allowing individual users to set it
> > independently.
>
> OK, I have missed that part.
>
> > > If not, have you
> > > considered (already proposed numa=3Doff)?
> >
> > The challenge at hand isn't solely about whether users should bind to
> > a memory node or the deployment of workloads. What we're genuinely
> > dealing with is the fact that users can bind to a specific node
> > without our explicit agreement or authorization.
>
> mbind outside of the cpuset shouldn't be possible (policy_nodemask). So
> if you are configuring cpusets already then mbind should add much to a
> problem. I can see how you can have problems when you do not have any
> NUMA partitioning in place because mixing NUMA aware and unaware
> workloads doesn't really work out well when the memory is short on
> supply.

Right, we're trying to move NUMA aware workloads to dedicated servers.

--=20
Regards
Yafang

