Return-Path: <bpf+bounces-2346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384CD72B2A5
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B93D1C20A01
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4101C2C4;
	Sun, 11 Jun 2023 15:53:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E990BA57
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 15:53:43 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E41BE8
	for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 08:53:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62de0e82a07so6326236d6.1
        for <bpf@vger.kernel.org>; Sun, 11 Jun 2023 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686498791; x=1689090791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWwveheYAtzxZTw8cKpLiEnsqdm0LnDMlr6OOmUN3uE=;
        b=XCwZ1rBJPYx6oSsAInceO7SuVo4HarFKZEnJbDb6AwLk3U7xN5dwbHhkK90BmwAyTV
         FfW8gY/iP+5t8Uuc0QJQ8raWUYVb4tN75GFQxVVgMTfTm+rS48mZiyu6zdB0KVvuPvtq
         UmKMceIvNhUZ6Gfn0E412qMkxmNSfU3o66EQNyn7O1We1yv/HX8GzFtKz7R4WtGSwRkR
         0n+xk25YoDIbjWGLgWpDQGxqdxwx2QCA0IGNRx7obIyCP9VIJ1mgiZy7Ow4D9nsAsh9Q
         8MhZj9QPQEW9uKJuk5AZAq7h7H39uts4wOgSpd+nkszKkzqaxxomRbLjuSoThovwptJX
         bR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686498791; x=1689090791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWwveheYAtzxZTw8cKpLiEnsqdm0LnDMlr6OOmUN3uE=;
        b=MIuWUA4eZM9sbLpReDF0HiDM6jadKUALUZiQUE27IfS6LFmvuLAVtFDLtCcxOholTo
         75OEQHwpt/XlLbS0qa/Shw+WUu+b6MhOMkcBWIEGeFgg/BhOvvCoztliJcZPLfXl2WmG
         gV+Dj4TkZhEAE6sH2okWuqQ9Ot4Z05Y9k8K+kQfbikxNLeN5Mn9/d06AAaMDnqFZ9Rd0
         YwzoTVaDKQxdaMxysOrOrG20fEpq1edgZ68iCA3n0f0RErlh2wym7mf4ssjj3EiFfS/H
         QM6jrXg6cG3Dn/yF2hR80hWhBn+n5JCHAdz9bxdRaet7jX9+J+WCuAXlV4Tv8Ko6UWwI
         P/yQ==
X-Gm-Message-State: AC+VfDzQg0Kkn6diosSY0znj9TsxXC4omNkB7VoanAXTzSeqz2OU8v9i
	7QNRgKrp5RNwglu20RKfkpSdfMuo7An+iMRbKPKp0IAzuDn6DA==
X-Google-Smtp-Source: ACHHUZ6F2BAA44U4WP6C9VnXrM3LWmFDfVpKYxbGCcgAeotTDYaKzuVlMMlty5x2e5eq4Cq8522SYjp1aI2EABFoRc0=
X-Received: by 2002:ad4:5caf:0:b0:626:1be5:177b with SMTP id
 q15-20020ad45caf000000b006261be5177bmr6872433qvh.65.1686498791680; Sun, 11
 Jun 2023 08:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-10-laoar.shao@gmail.com>
 <CAEf4BzZtc+yfg7NgK5KG_sSLGSmBMW-ZBF2=qh32D_AW++FzOw@mail.gmail.com>
 <CAPhsuW6j=ebCqRhQ7KQ-1qLze1nkFFPOt9JnOB=yXfjPctd+qg@mail.gmail.com>
 <CALOAHbCeP3bf=Y1NuJh9MYXoinbi0+fRDANaTdBmOXi1DXz0vw@mail.gmail.com> <CACdoK4L+pPFN=f6Q-KrZNVo5fwqxDBr51cuu_yz5W-GGumsmTQ@mail.gmail.com>
In-Reply-To: <CACdoK4L+pPFN=f6Q-KrZNVo5fwqxDBr51cuu_yz5W-GGumsmTQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 11 Jun 2023 23:52:35 +0800
Message-ID: <CALOAHbDBNhn1AR-HnnQpiQWrxD1B1FNZWbxizZwbXJGCRMwZXg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
To: Quentin Monnet <quentin@isovalent.com>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 11, 2023 at 4:35=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> On Sat, 10 Jun 2023 at 03:22, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 12:36=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Thu, Jun 8, 2023 at 4:14=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > > >
> > > > > Add libbpf API to get generic perf event name.
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > >
> > > > I don't think this belongs in libbpf and shouldn't be exposed as
> > > > public API. Please move it into bpftool and make it internal (if
> > > > Quentin is fine with this in the first place).
>
> Fine by me

I will move them into bpftool.

>
> > >
> > > Or maybe it belongs to libperf?
> >
> > I prefer to move it into libperf.  Then it may be reused by other tools=
.
>
> Libperf sounds like a good place to have it, and I'm all in favour of
> having the names available to other tools, too.
>
> This being said, this would add a new dependency to bpftool. I'm not
> sure it's worth building libperf from bpftool's Makefile like we do
> for libbpf, just for getting the names: it would add to build time,
> and I don't see an easy way to replicate it on the GitHub mirror
> anyway. So the remaining option would be to use the library installed
> on the system if available, and to have a new feature detection in
> bpftool to figure out if the functions are available; but this also
> means most users compiling locally wouldn't get the names by default.

Agree with you that dependency is a problem.

>
> Looking at the list in the UAPI header, it seems to be relatively
> stable, so I'm fine with having it in bpftool, it shouldn't be too
> much overhead to keep up-to-date.
>
> Too bad these are enums and not macros in the UAPI, or we'd be able to
> derive the name without these arrays, given that it's just trimming
> the prefix and turning to lowercase. But maybe an alternative solution
> would be to get the name of the enum members with BTF, and derive the
> names from there? We already (optionally) rely on vmlinux.h at build
> time, maybe we can just reuse it?
>

As Jiri suggested, I think we can just put these code into bpftool,
and then try to improve it in the future.

--=20
Regards
Yafang

