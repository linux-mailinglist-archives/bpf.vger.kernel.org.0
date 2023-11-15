Return-Path: <bpf+bounces-15090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CC7EBF90
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 10:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AA41C20B21
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE48F4F;
	Wed, 15 Nov 2023 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiVm/eoY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FA6AD6
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 09:34:31 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CF11C;
	Wed, 15 Nov 2023 01:34:29 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6779fe2b7c6so31610676d6.0;
        Wed, 15 Nov 2023 01:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700040869; x=1700645669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz/93EuDc77oJSQteK39JD/4miHZ2Blpb5SChByfej0=;
        b=HiVm/eoYRPi0IewCpCrIP18fgt47yN8+yaur0tv3Dx46xJ1vO7pdRqGMhcgvwFkXYc
         cyweBsNsx7znXM+5q0FpDmYf7ST42F4sRMoe2SBcHy11EguC1hGrtMCcUc/2AGgL7gBM
         0pQkwODTMwJq2Ra7fgPHP/lhf/C0s5zwzPP2ft4uvQ8DbD/iFGhlAV9bt4ntndkE7V6Z
         yRKLRQKv7gGIMnRPOELokKdAuO/7CigFxJySSYr584NCvdNGGxEi/FJxs1wWo+mkNpIC
         v8zQ364RF+rG+PK5usaMH3+lu7gqn2XjpN3f6M3Jp/OgXLSDhFmQGXmWcXehRx1Uwu6X
         GsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700040869; x=1700645669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz/93EuDc77oJSQteK39JD/4miHZ2Blpb5SChByfej0=;
        b=XgE/cVTVmBFB17WzSol/xxCaGgrzV2uKz0eqZBpCkL9g6hxjEyhbtM1Cy2svda/TW6
         fRmqLrtNuvjjlEIsytw2SAnH3iVM05wvqC3psLfR8GrnayPZLW3ydRpgEGv8d1KJy3EJ
         rTk8wolpA4Bgeus87DQK4ceeNcVs2KeQlJkMx5MykJ/ZPQxSF3cw7xHfmW8NOBU/WRP2
         7D2p+5RXI4x9dc9j+VzIcLQRy8XgATUd3C6fgHyPJUmvB5hskaCQxR6vIuJvH07PCNHx
         DS3NETNYM7jk/o/+CEXgXiPTwEsaAoPMBV+tMyIX5stzJtgQaDl7A/31yr7PtjRPmhfT
         37Zw==
X-Gm-Message-State: AOJu0Yy/0xwb336liioMbG29PhSoqhvMjlYw6Kxh45s1M6AFO3bM/IDn
	Pdg2wyLW/RzBpJL0nVhpMJ7YMkc6pZtb5ySAATB9vVMW8yXlGw==
X-Google-Smtp-Source: AGHT+IEgoiLeRDvfy56C9e6tZWich5bZ11SOLZwSnE5d3+UctNQiQxr9whStX7oOQApMOKxzFg3WnzBP+Uudcf6xPgs=
X-Received: by 2002:a0c:e706:0:b0:66d:299d:e4c with SMTP id
 d6-20020a0ce706000000b0066d299d0e4cmr4639612qvn.20.1700040868969; Wed, 15 Nov
 2023 01:34:28 -0800 (PST)
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
 <ZVSFNzf4QCbpLGyF@tiehlicka>
In-Reply-To: <ZVSFNzf4QCbpLGyF@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 Nov 2023 17:33:51 +0800
Message-ID: <CALOAHbAjHJ_47b15v3d+f3iZZ+vBVsLugKew_t_ZFaJoE2_3uw@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Michal Hocko <mhocko@suse.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 4:45=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 15-11-23 09:52:38, Yafang Shao wrote:
> > On Wed, Nov 15, 2023 at 12:58=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> > >
> > > On 11/14/2023 3:59 AM, Yafang Shao wrote:
> > > > On Tue, Nov 14, 2023 at 6:15=E2=80=AFPM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > >> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> > > >>> On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey@s=
chaufler-ca.com> wrote:
> > > >>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > >>>>> Background
> > > >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >>>>>
> > > >>>>> In our containerized environment, we've identified unexpected O=
OM events
> > > >>>>> where the OOM-killer terminates tasks despite having ample free=
 memory.
> > > >>>>> This anomaly is traced back to tasks within a container using m=
bind(2) to
> > > >>>>> bind memory to a specific NUMA node. When the allocated memory =
on this node
> > > >>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_s=
core,
> > > >>>>> indiscriminately kills tasks. This becomes more critical with g=
uaranteed
> > > >>>>> tasks (oom_score_adj: -998) aggravating the issue.
> > > >>>> Is there some reason why you can't fix the callers of mbind(2)?
> > > >>>> This looks like an user space configuration error rather than a
> > > >>>> system security issue.
> > > >>> It appears my initial description may have caused confusion. In t=
his
> > > >>> scenario, the caller is an unprivileged user lacking any capabili=
ties.
> > > >>> While a privileged user, such as root, experiencing this issue mi=
ght
> > > >>> indicate a user space configuration error, the concerning aspect =
is
> > > >>> the potential for an unprivileged user to disrupt the system easi=
ly.
> > > >>> If this is perceived as a misconfiguration, the question arises: =
What
> > > >>> is the correct configuration to prevent an unprivileged user from
> > > >>> utilizing mbind(2)?"
> > > >> How is this any different than a non NUMA (mbind) situation?
> > > > In a UMA system, each gigabyte of memory carries the same cost.
> > > > Conversely, in a NUMA architecture, opting to confine processes wit=
hin
> > > > a specific NUMA node incurs additional costs. In the worst-case
> > > > scenario, if all containers opt to bind their memory exclusively to
> > > > specific nodes, it will result in significant memory wastage.
> > >
> > > That still sounds like you've misconfigured your containers such
> > > that they expect to get more memory than is available, and that
> > > they have more control over it than they really do.
> >
> > And again: What configuration method is suitable to limit user control
> > over memory policy adjustments, besides the heavyweight seccomp
> > approach?
>
> This really depends on the workloads. What is the reason mbind is used
> in the first place?

It can improve their performance.

> Is it acceptable to partition the system so that
> there is a numa node reserved for NUMA aware workloads?

As highlighted in the commit log, our preference is to configure this
memory policy through kubelet using cpuset.mems in the cpuset
controller, rather than allowing individual users to set it
independently.

> If not, have you
> considered (already proposed numa=3Doff)?

The challenge at hand isn't solely about whether users should bind to
a memory node or the deployment of workloads. What we're genuinely
dealing with is the fact that users can bind to a specific node
without our explicit agreement or authorization.

--=20
Regards
Yafang

