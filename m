Return-Path: <bpf+bounces-15083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B365D7EBB07
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 02:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CD9B20B65
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 01:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB63644;
	Wed, 15 Nov 2023 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZejKxta"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57639F
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 01:53:16 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61343D5;
	Tue, 14 Nov 2023 17:53:15 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d0169cf43so37896516d6.3;
        Tue, 14 Nov 2023 17:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700013194; x=1700617994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/BHt234WbDp4zYK97AdGPPmMkFTqbDy1Led9ubCTnY=;
        b=PZejKxtao+Dtk8ewxGyxJ/luUJPKBPAG76ORXeC3slBBHUbvtyvMUJO17MOACb4Kpb
         dQuUQDRNa0PHjKvhoVpIdmF1HcMpnphFe7N4FGgUePTAboR87l237v1D6sQfkZ18a4Vb
         83CZhX9GqQpXH8wRip+5baW5GPwiOs1FN6u/rx7Bp985KQcJ9IcQnL9JgR78lqZSgAQX
         pMFJ1u+Mba3Ga2VxU6pdXFalJJA9faV1MQcbh23ZHVVy+AktMnkD6Ao0Wygcbu9Lduo6
         pm2ZWOqlwAouL8DkjJmTafyJ9VGBTeKCMNzXbbZVBbFU/ehsaWAkVs8BfZP7jigNNJA2
         kvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700013194; x=1700617994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/BHt234WbDp4zYK97AdGPPmMkFTqbDy1Led9ubCTnY=;
        b=v07wvIn91Sg+SItkh+gchmm41mahawh5m8Q9CLAs6tCbrm6RQrgiFcs3pGw7kRQqZW
         VJvIjRafdeiYHWQ+SN6MNQ65sslEvl5YPMh1oYYJLiUixxM1SMlQXS8+d4FIwhxNza70
         frJJVwPzygspRGOcFm+MgMxuZAFT8e6aMNYSzQ2vgeDa9ohZ9Fr2ypkirZxk1vHUQ6Q/
         G+MB1xy4wfk9vPUTbfjgYt71ssV8ylvmymtMd894YPSOLKHN7yYsK/BiiM71WJi5E8Do
         LCB+UImuNMbk0nlGRaZ3Px69Bi2lv5NHFTOb8L5bAOd0a1b6Ecdu4pXfV5jtnYQZq7Qb
         Ksrg==
X-Gm-Message-State: AOJu0YwDIsxuCuNXwGPulEuGc8BgRUp3wfpjuZQhpA2LiZ08qaeGWbBf
	U2s7EiiBoAdxm1XNc91BeSQdR2/SNRViMN8xjqE=
X-Google-Smtp-Source: AGHT+IHo6AZNYLQHGcQHISaJgPr0SREQoncKiE8nFZNQmSoDAPfIMW7+pbh+OvB7/bygy6+qHwvEe1SBIBqyLvMWnuU=
X-Received: by 2002:a05:6214:f02:b0:670:63cc:210c with SMTP id
 gw2-20020a0562140f0200b0067063cc210cmr6230026qvb.39.1700013194432; Tue, 14
 Nov 2023 17:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <ZVNIprbQU3NqwPi_@tiehlicka> <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
 <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com>
In-Reply-To: <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 Nov 2023 09:52:38 +0800
Message-ID: <CALOAHbBKCsdmko_ugHZ_z6Zpgo-xJ8j46oPHkHj+gBGsRCR=eA@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:58=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 11/14/2023 3:59 AM, Yafang Shao wrote:
> > On Tue, Nov 14, 2023 at 6:15=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> >> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> >>> On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey@schau=
fler-ca.com> wrote:
> >>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> >>>>> Background
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>> In our containerized environment, we've identified unexpected OOM e=
vents
> >>>>> where the OOM-killer terminates tasks despite having ample free mem=
ory.
> >>>>> This anomaly is traced back to tasks within a container using mbind=
(2) to
> >>>>> bind memory to a specific NUMA node. When the allocated memory on t=
his node
> >>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_score=
,
> >>>>> indiscriminately kills tasks. This becomes more critical with guara=
nteed
> >>>>> tasks (oom_score_adj: -998) aggravating the issue.
> >>>> Is there some reason why you can't fix the callers of mbind(2)?
> >>>> This looks like an user space configuration error rather than a
> >>>> system security issue.
> >>> It appears my initial description may have caused confusion. In this
> >>> scenario, the caller is an unprivileged user lacking any capabilities=
.
> >>> While a privileged user, such as root, experiencing this issue might
> >>> indicate a user space configuration error, the concerning aspect is
> >>> the potential for an unprivileged user to disrupt the system easily.
> >>> If this is perceived as a misconfiguration, the question arises: What
> >>> is the correct configuration to prevent an unprivileged user from
> >>> utilizing mbind(2)?"
> >> How is this any different than a non NUMA (mbind) situation?
> > In a UMA system, each gigabyte of memory carries the same cost.
> > Conversely, in a NUMA architecture, opting to confine processes within
> > a specific NUMA node incurs additional costs. In the worst-case
> > scenario, if all containers opt to bind their memory exclusively to
> > specific nodes, it will result in significant memory wastage.
>
> That still sounds like you've misconfigured your containers such
> that they expect to get more memory than is available, and that
> they have more control over it than they really do.

And again: What configuration method is suitable to limit user control
over memory policy adjustments, besides the heavyweight seccomp
approach?

--
Regards
Yafang

