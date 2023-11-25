Return-Path: <bpf+bounces-15853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D07F8EF3
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 21:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DA1B21045
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D512F85A;
	Sat, 25 Nov 2023 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2jtaJo/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606A2DF62
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEDDC433C9
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 20:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700944866;
	bh=btwBNyz95yrZpEEQcF4eF44UB7hZtCQ3DkhRHA4fprk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D2jtaJo/wsDHQ5AawkVTKKb+humTfbU2ddH43Y+lS8q34C9mfZNQPHknAwkGthoj9
	 ZT5fSaIwJXOrtDqpgzXdB0mMiffWQN3Uj+5GRMuP8rRd5paZdSvQmn1Vm40hdtpHNM
	 SYeNDm0GAKgkOtJYZVfLA0/2uuu/f2vf2RTluFqwEiqXDAkQ9KmgEkhH3AKeCJzWev
	 3pM0NByEEgll43Ovu3v/AJsvSL0u/RRJ34IDnpsGtUot4zmWGV0RI7lQ8QOxzxDEMF
	 sbreG88TIoFJ0dQ9ppCWVfnjYdHxjG59KmAlH6BBs1qDcFwb7vouTy2eYYmCZyja8N
	 kZm43iPHl2CcQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c997467747so6868011fa.1
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 12:41:06 -0800 (PST)
X-Gm-Message-State: AOJu0Ywbs2cYrT2WUE/lCpsYquv0fv+r7orfqUtNLLTWmRvoVwRgB3g0
	YOiQ8T5zjW2BOKDG/UZSvTTWclZV+FjrUDKbwWU=
X-Google-Smtp-Source: AGHT+IEuPfxOI+Q1y5yLSC0XSKahq2VPO72UtvmdUTuDp4HaLK/URJRRZ+r3Lc7aIXHMQfr0M1YbJXBvQJeUH9JVTqw=
X-Received: by 2002:a2e:b285:0:b0:2c7:8911:76da with SMTP id
 5-20020a2eb285000000b002c7891176damr5286150ljx.39.1700944864954; Sat, 25 Nov
 2023 12:41:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122191816.5572-1-9erthalion6@gmail.com> <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
 <20231124211631.ktwsigoafnnbhpyt@erthalion.local> <f1fde0d0-dba6-481d-8b2d-d0c3d63620cc@linux.dev>
In-Reply-To: <f1fde0d0-dba6-481d-8b2d-d0c3d63620cc@linux.dev>
From: Song Liu <song@kernel.org>
Date: Sat, 25 Nov 2023 12:40:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7K37n+5XWc2eKVhVA-V+Pd=NmLBN7hnowOpC0hNaCzgg@mail.gmail.com>
Message-ID: <CAPhsuW7K37n+5XWc2eKVhVA-V+Pd=NmLBN7hnowOpC0hNaCzgg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach rules
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Dmitry Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 11:55=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 11/24/23 4:16 PM, Dmitry Dolgov wrote:
> >> On Thu, Nov 23, 2023 at 11:24:34PM -0800, Song Liu wrote:
> >>> Following the corresponding discussion [1], the reason for that is to
> >>> avoid tracing progs call cycles without introducing more complex
> >>> solutions. Relax "no same type" requirement to "no progs that are
> >>> already an attach target themselves" for the tracing type. In this wa=
y
> >>> only a standalone tracing program (without any other progs attached t=
o
> >>> it) could be attached to another one, and no cycle could be formed. T=
o
> >> If prog B attached to prog A, and prog C attached to prog B, then we
> >> detach B. At this point, can we re-attach B to A?
> > Nope, with the proposed changes it still wouldn't be possible to
> > reattach B to A (if we're talking about tracing progs of course),
> > because this time B is an attachment target on its own.
>
> IIUC, the 'prog B attached to prog A, and prog C attached to prog B'
> not really possible.
>     After prog B attached to prog A, we have
>       prog B follower_cnt =3D 1
>       prog A attach_depth =3D 1

I think prog A has follower_cnt=3D1, while prog B has follow_cnt=3D0, no?

Thanks,
Song

>     Then prog C wants to attach to prog B,
>       since we have prog B follower_cnt =3D 1, then attaching will fail.
>
> If we do have A <- B <- C chain by
>     first prog C attached to prog B, and then prog B attached to A
>     now we have
>      prog B/C follower_cnt =3D 1
>      prog A/B attach_depth =3D 1
> after detaching B from A, we have
>      prog B follower_cnt =3D 0
>      prog A attach_depth =3D 0
>
> In this particular case, prog B attaching to prog A should succeed
> since prog B follower_cnt =3D 0.
>
> Did I miss anything?
>
> In the commit message, 'falcosecurity libs project' is mentioned as a use
> case for chained fentry/fexit bpf programs. I think you should expand the
> use case in more details. It is possible with use case description, peopl=
e
> might find better/alternative solutions for your use case.
>
> Also, if you can have a test case to exercise your commit logic,
> it will be even better.
>
> >
> >>> +       if (tgt_prog) {
> >>> +               /* Bookkeeping for managing the prog attachment chain=
. */
> >>> +               tgt_prog->aux->follower_cnt++;
> >>> +               prog->aux->attach_depth =3D tgt_prog->aux->attach_dep=
th + 1;
> >>> +       }
> >>> +
> >> attach_depth is calculated at attach time, so...
> >>
> >>>                  struct bpf_prog_aux *aux =3D tgt_prog->aux;
> >>>
> >>> +               if (aux->attach_depth >=3D 32) {
> >>> +                       bpf_log(log, "Target program attach depth is =
%d. Too large\n",
> >>> +                                       aux->attach_depth);
> >>> +                       return -EINVAL;
> >>> +               }
> >>> +
> >> (continue from above) attach_depth is always 0 at program load time, n=
o?
> > Right, it's going to be always 0 for the just loaded program -- but her=
e
> > in verifier we check attach_depth of the target program, which is
> > calculated at some point before. Or were you asking about something els=
e?

