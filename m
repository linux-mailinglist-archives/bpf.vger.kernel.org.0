Return-Path: <bpf+bounces-15135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BCC7ED8F0
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516FC1F22C0E
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94C10F0;
	Thu, 16 Nov 2023 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwbe5ImA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC798;
	Wed, 15 Nov 2023 17:41:49 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6779f5e9410so1696406d6.1;
        Wed, 15 Nov 2023 17:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700098908; x=1700703708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqoDEMqUC1HhkGXWjIU1Ow81RM3RUo27P1s8rtquI7c=;
        b=Fwbe5ImAg7QwDUxNuz0/KEEkElba0G7zDP5LYiQIBh08uTHGDv+Efdrpb61doxxH3h
         uSCkwiKs4wNYlEMopjvBPfJtITw12YMa2+ELMVSAsb43aXFG8RdgqWh6tvAIqLbIllkS
         mU9fJY0uB3ZhqgMX+4vGdtDIvgo41UzOEt5i6FCNNdq7yN16957R9YmXGqjUtxZBOXOE
         1YHlVT8OYKiA3rOE/HTEE1qZ0r/82G9srQAvktuRzS4zCTrumVkgB93n/dxPYeTczn62
         i3QpVYh9UtXgtTuMfJVUR8l2D004+FGIVdoyGEc+sNYV8rJucMRDdPzFNMLqOuNdxaR2
         ikaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098908; x=1700703708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqoDEMqUC1HhkGXWjIU1Ow81RM3RUo27P1s8rtquI7c=;
        b=H/TvvJ7FRjvS4yVMqFED1OUYTGIe8LAChcUnUakxeunNFolhnc6hg9tcwqEGc2oYPy
         Lq/MGrOaxRSxPedZp4a5YKNugg0wnmVixKtx6HfKMruQIj/lqABHZIubKQEWqKom1+Td
         lfQNWzdif4UbI4tVpvklySGS3mN4JTnToUocXqqVhFMHtpz+I2QkJd12S6G8pIjXiihw
         /UqfUOkgEkgRo1RBC4i609Ram9YH1sTN413vHtCQ0zxGOCJApzOmg6MuMN51QOmLSA4m
         VzWGL8hO15XSZHdbyUS842UoEb2Sc9ICq+TVGxVZqeGJBXisOHfHqzb1LZ54C6eaEWBy
         GVQg==
X-Gm-Message-State: AOJu0Yw7w/jky1XNgGix+/k26MhiBvaJ6F3Grt140Wp9Ok8DpvfW7hcN
	hTLHOCG1ZmMwVvvJMDPZwCYoOLxHbsEYr6k9gvM=
X-Google-Smtp-Source: AGHT+IHu7uq5rUpxzoyeqwZeAScz1klj4YjnR2LARo7SvHvIiQmm6l3m3tK46Pw34TCk+NfVO88+9Q4WJbchjYYWg54=
X-Received: by 2002:a05:6214:1c85:b0:66d:5c10:cab7 with SMTP id
 ib5-20020a0562141c8500b0066d5c10cab7mr8678469qvb.46.1700098908290; Wed, 15
 Nov 2023 17:41:48 -0800 (PST)
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
 <CALOAHbDK0hzvxw84brfV2tZnyVp9Ry22gp3Jj8EmQySUbdqmiw@mail.gmail.com> <22994ba0-18eb-4f9d-a399-abde52ffdc38@schaufler-ca.com>
In-Reply-To: <22994ba0-18eb-4f9d-a399-abde52ffdc38@schaufler-ca.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Nov 2023 09:41:11 +0800
Message-ID: <CALOAHbBOh8JDwK0VeqOHVonen4TxmaEbdtry8jeMhQfJnvGNQA@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 1:09=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 11/15/2023 6:26 AM, Yafang Shao wrote:
> > On Wed, Nov 15, 2023 at 5:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> >> On Wed, Nov 15, 2023 at 4:45=E2=80=AFPM Michal Hocko <mhocko@suse.com>=
 wrote:
> >>> On Wed 15-11-23 09:52:38, Yafang Shao wrote:
> >>>> On Wed, Nov 15, 2023 at 12:58=E2=80=AFAM Casey Schaufler <casey@scha=
ufler-ca.com> wrote:
> >>>>> On 11/14/2023 3:59 AM, Yafang Shao wrote:
> >>>>>> On Tue, Nov 14, 2023 at 6:15=E2=80=AFPM Michal Hocko <mhocko@suse.=
com> wrote:
> >>>>>>> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> >>>>>>>> On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey@=
schaufler-ca.com> wrote:
> >>>>>>>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> >>>>>>>>>> Background
> >>>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>>>
> >>>>>>>>>> In our containerized environment, we've identified unexpected =
OOM events
> >>>>>>>>>> where the OOM-killer terminates tasks despite having ample fre=
e memory.
> >>>>>>>>>> This anomaly is traced back to tasks within a container using =
mbind(2) to
> >>>>>>>>>> bind memory to a specific NUMA node. When the allocated memory=
 on this node
> >>>>>>>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_=
score,
> >>>>>>>>>> indiscriminately kills tasks. This becomes more critical with =
guaranteed
> >>>>>>>>>> tasks (oom_score_adj: -998) aggravating the issue.
> >>>>>>>>> Is there some reason why you can't fix the callers of mbind(2)?
> >>>>>>>>> This looks like an user space configuration error rather than a
> >>>>>>>>> system security issue.
> >>>>>>>> It appears my initial description may have caused confusion. In =
this
> >>>>>>>> scenario, the caller is an unprivileged user lacking any capabil=
ities.
> >>>>>>>> While a privileged user, such as root, experiencing this issue m=
ight
> >>>>>>>> indicate a user space configuration error, the concerning aspect=
 is
> >>>>>>>> the potential for an unprivileged user to disrupt the system eas=
ily.
> >>>>>>>> If this is perceived as a misconfiguration, the question arises:=
 What
> >>>>>>>> is the correct configuration to prevent an unprivileged user fro=
m
> >>>>>>>> utilizing mbind(2)?"
> >>>>>>> How is this any different than a non NUMA (mbind) situation?
> >>>>>> In a UMA system, each gigabyte of memory carries the same cost.
> >>>>>> Conversely, in a NUMA architecture, opting to confine processes wi=
thin
> >>>>>> a specific NUMA node incurs additional costs. In the worst-case
> >>>>>> scenario, if all containers opt to bind their memory exclusively t=
o
> >>>>>> specific nodes, it will result in significant memory wastage.
> >>>>> That still sounds like you've misconfigured your containers such
> >>>>> that they expect to get more memory than is available, and that
> >>>>> they have more control over it than they really do.
> >>>> And again: What configuration method is suitable to limit user contr=
ol
> >>>> over memory policy adjustments, besides the heavyweight seccomp
> >>>> approach?
>
> What makes seccomp "heavyweight"? The overhead? The infrastructure requir=
ed?
>
> >>> This really depends on the workloads. What is the reason mbind is use=
d
> >>> in the first place?
> >> It can improve their performance.
>
> How much? You've already demonstrated that using mbind can degrade their =
performance.

Pls. calm down and read the whole discussion carefully. It is not easy
to understand.

--=20
Regards
Yafang

