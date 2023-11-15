Return-Path: <bpf+bounces-15094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2007EC51F
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4B828142B
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CA2D03D;
	Wed, 15 Nov 2023 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZWQ+PHh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5A1EB41
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 14:27:14 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A85101;
	Wed, 15 Nov 2023 06:27:13 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db057de2b77so190174276.3;
        Wed, 15 Nov 2023 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058432; x=1700663232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpawJywioUM9HI5TCTr/j3hJWHRVbm+8zihbFeHeUpg=;
        b=BZWQ+PHh1YAJS/nHlYzKd7rOkdwVnvXXcIBRAL6pCSA77AGAXx4P75DxQJyswDCwVj
         fvrrTuPbhzP4EKmxEM0LFMKpZTiuY55yhg93RlCBOGBvO8nHmcd1oUsDNMPZpRpviWBj
         /jCk+AXACOxCD7KkD5snrB4LXQJiqtdCs2kwNX5m6bS/cvfRY0y84FhY6bn9Bet5fCsR
         cCFxB8sWcGYujIrFJT//Ls2osOCAc/tmkV3bU03TWSMNe2ND5iwSBZpkvyjl9tIwkh6M
         8iLXpPlouWpYpRjml1iwln1mLi/iy+yheJmXloNo/WhSZ9qPxxS1P6JwdkahnUZlAnJ8
         rECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058432; x=1700663232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpawJywioUM9HI5TCTr/j3hJWHRVbm+8zihbFeHeUpg=;
        b=n4VP+EETLWKHq+wJ/dFKR5ClSxUbQSa/JOmB2xnUIA0vLeLBF0NXffvWdf0n/as1CF
         yrSeR/AyvN1PrFkFUIQCiXLU02DZgqJiUaczGEPf8Y60S0Lbwg1Yez3t2hcXFM7kJ3Sl
         UAZT9ruC3YFrdbOCz6dI9+Dlqko09H/rV54h4ZkF1gtMgwAQGctCHGg9HEEWG+ucjMq+
         RCkM2NYlA1sdhCRBChk03EMMhYzVn3eX3JtAA29HklDpciS69z60oW/fJYmoRhAvfqVe
         CGut61siLgBVLgbrGno53PZgHhu0WYxN4BrBt7QeRnTHkqIYtrsyWTsnTLdIltBTv2lM
         AJug==
X-Gm-Message-State: AOJu0YyA2+SCaIoeO8cYC7KNThilweMRMKqaC5GPU0jSjriqFvUl7wG0
	1L3cgQ+8AhSDja/pKq7/g/IrBDyvlxCDYwQJiPc=
X-Google-Smtp-Source: AGHT+IF/oZl/Viuy/5cek7/QuWtWGBxcNWt9HIJpVyZUKi90aRDc580fBwNEbhZb+GcGV8pnPxE+soPsnEd9fIswogA=
X-Received: by 2002:a25:aea1:0:b0:daf:ed94:c038 with SMTP id
 b33-20020a25aea1000000b00dafed94c038mr6391085ybj.8.1700058432457; Wed, 15 Nov
 2023 06:27:12 -0800 (PST)
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
In-Reply-To: <CALOAHbAjHJ_47b15v3d+f3iZZ+vBVsLugKew_t_ZFaJoE2_3uw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 Nov 2023 22:26:36 +0800
Message-ID: <CALOAHbDK0hzvxw84brfV2tZnyVp9Ry22gp3Jj8EmQySUbdqmiw@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Michal Hocko <mhocko@suse.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 5:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Nov 15, 2023 at 4:45=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Wed 15-11-23 09:52:38, Yafang Shao wrote:
> > > On Wed, Nov 15, 2023 at 12:58=E2=80=AFAM Casey Schaufler <casey@schau=
fler-ca.com> wrote:
> > > >
> > > > On 11/14/2023 3:59 AM, Yafang Shao wrote:
> > > > > On Tue, Nov 14, 2023 at 6:15=E2=80=AFPM Michal Hocko <mhocko@suse=
.com> wrote:
> > > > >> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> > > > >>> On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey=
@schaufler-ca.com> wrote:
> > > > >>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > > >>>>> Background
> > > > >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >>>>>
> > > > >>>>> In our containerized environment, we've identified unexpected=
 OOM events
> > > > >>>>> where the OOM-killer terminates tasks despite having ample fr=
ee memory.
> > > > >>>>> This anomaly is traced back to tasks within a container using=
 mbind(2) to
> > > > >>>>> bind memory to a specific NUMA node. When the allocated memor=
y on this node
> > > > >>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom=
_score,
> > > > >>>>> indiscriminately kills tasks. This becomes more critical with=
 guaranteed
> > > > >>>>> tasks (oom_score_adj: -998) aggravating the issue.
> > > > >>>> Is there some reason why you can't fix the callers of mbind(2)=
?
> > > > >>>> This looks like an user space configuration error rather than =
a
> > > > >>>> system security issue.
> > > > >>> It appears my initial description may have caused confusion. In=
 this
> > > > >>> scenario, the caller is an unprivileged user lacking any capabi=
lities.
> > > > >>> While a privileged user, such as root, experiencing this issue =
might
> > > > >>> indicate a user space configuration error, the concerning aspec=
t is
> > > > >>> the potential for an unprivileged user to disrupt the system ea=
sily.
> > > > >>> If this is perceived as a misconfiguration, the question arises=
: What
> > > > >>> is the correct configuration to prevent an unprivileged user fr=
om
> > > > >>> utilizing mbind(2)?"
> > > > >> How is this any different than a non NUMA (mbind) situation?
> > > > > In a UMA system, each gigabyte of memory carries the same cost.
> > > > > Conversely, in a NUMA architecture, opting to confine processes w=
ithin
> > > > > a specific NUMA node incurs additional costs. In the worst-case
> > > > > scenario, if all containers opt to bind their memory exclusively =
to
> > > > > specific nodes, it will result in significant memory wastage.
> > > >
> > > > That still sounds like you've misconfigured your containers such
> > > > that they expect to get more memory than is available, and that
> > > > they have more control over it than they really do.
> > >
> > > And again: What configuration method is suitable to limit user contro=
l
> > > over memory policy adjustments, besides the heavyweight seccomp
> > > approach?
> >
> > This really depends on the workloads. What is the reason mbind is used
> > in the first place?
>
> It can improve their performance.
>
> > Is it acceptable to partition the system so that
> > there is a numa node reserved for NUMA aware workloads?
>
> As highlighted in the commit log, our preference is to configure this
> memory policy through kubelet using cpuset.mems in the cpuset
> controller, rather than allowing individual users to set it
> independently.
>
> > If not, have you
> > considered (already proposed numa=3Doff)?
>
> The challenge at hand isn't solely about whether users should bind to
> a memory node or the deployment of workloads. What we're genuinely
> dealing with is the fact that users can bind to a specific node
> without our explicit agreement or authorization.

BYW, the same principle should also apply to sched_setaffinity(2).
While there's already a security_task_setscheduler() in place, it's
undeniable that we should also consider adding a
security_set_mempolicy() for consistency.

--=20
Regards
Yafang

