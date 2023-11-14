Return-Path: <bpf+bounces-15057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7ED7EAF96
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DE81C20A63
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A73D984;
	Tue, 14 Nov 2023 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afyBfB4K"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503C2420C
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:00:33 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF196193;
	Tue, 14 Nov 2023 04:00:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66cfd874520so30901626d6.2;
        Tue, 14 Nov 2023 04:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699963230; x=1700568030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT89VrUM4OJhyd4A4Cn9ZU5tdEguZqAnwhZWFOOT8fs=;
        b=afyBfB4KkIMvTEXe+bswHlpvNkc2e/yell4pxoGdVsdwZ8NkVFr2XAZJ5T3dKhcO3n
         BYRAR7ZMp4rnyRwxPCv/Y/19zG64DhyFqPCUbPOJW5/9AtRm/oWmUQp/QjWaUoIWl0oH
         0hxJcbgqjsc/bOEaFcQZVnBP9OlPY2KQQHx7D0SU6p1sXQx9OmYp54H+g1cICOhpshVS
         Bv28CfPuo7RvXWKfzNNJ8FHLSxsNDjXE5MjGoxWJJzoOrSRIl5AEq/cwQlZP52bAmeud
         zcz4LBNVLj0uQv08TifsFvCtpGP7Zhsrle5xGmRlyh5bRpGlfrVrtCbP4Qpim3xaJJZ8
         2TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699963230; x=1700568030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT89VrUM4OJhyd4A4Cn9ZU5tdEguZqAnwhZWFOOT8fs=;
        b=Q8gXEzpD6KZxKxFL67YqaLm2nN76t+v/LYzxMdyPK6G8X7q9xZKZy50pClDHjUiemk
         +XOveHikh8BXx+OaULFx5Ue01Y2f11hHg2/zcLraX6SgxESNrcdL1e/9ne+qUCQ3TRqE
         9iQShBs0BMIhvEMfNEyfmGMF3VI8FTGz3U1giPmg7FZiNuzyArwCP8jMgiGz3VO5kyy3
         iQR61ob3Sh285EuAfpOEOk+RL9KvsmY7dXRBp4YaNLho/wfn85vub3Jg/kBueVr+ZtsE
         FjrLk8c0GB8lHhbsxfIGMo9Q036bNPfCIHokeXkfO8gGDfdM7jPnW7GewdbaqIvLQJxm
         qDEw==
X-Gm-Message-State: AOJu0YxLeLvQFV+UeJovhkv5GtK3rjzUhFaRR9vf0Z+fCGuPRs8u5yb0
	kmGXh4dFBoJyWHb6FEz9gHeJKCWa89jZvADKc9oXxOQfdKTMgm/v
X-Google-Smtp-Source: AGHT+IELivM7PdGAPOr5HMY5T+cLa3aYp631h40RVkoxQiFV0TnNHl9sZdX2KAviztPvfo3EUpARMpWi2B+gK/slfBE=
X-Received: by 2002:ad4:4592:0:b0:66f:e3d4:2145 with SMTP id
 x18-20020ad44592000000b0066fe3d42145mr2413827qvu.46.1699963230533; Tue, 14
 Nov 2023 04:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com> <ZVNIprbQU3NqwPi_@tiehlicka>
In-Reply-To: <ZVNIprbQU3NqwPi_@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 14 Nov 2023 19:59:53 +0800
Message-ID: <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Michal Hocko <mhocko@suse.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 6:15=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
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
>
> How is this any different than a non NUMA (mbind) situation?

In a UMA system, each gigabyte of memory carries the same cost.
Conversely, in a NUMA architecture, opting to confine processes within
a specific NUMA node incurs additional costs. In the worst-case
scenario, if all containers opt to bind their memory exclusively to
specific nodes, it will result in significant memory wastage.

> You can
> still have an unprivileged user to allocate just until the OOM triggers
> and disrupt other workload consuming more memory. Sure the mempolicy
> based OOM is less precise and it might select a victim with only a small
> consumption on a target NUMA node but fundamentally the situation is
> very similar. I do not think disallowing mbind specifically is solving a
> real problem.

How would you recommend addressing this more effectively?

--=20
Regards
Yafang

