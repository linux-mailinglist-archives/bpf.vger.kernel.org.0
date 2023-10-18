Return-Path: <bpf+bounces-12612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DED7CEB46
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C264281230
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695C450E9;
	Wed, 18 Oct 2023 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3137143;
	Wed, 18 Oct 2023 22:29:36 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B781118;
	Wed, 18 Oct 2023 15:29:35 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6be840283ceso1882446b3a.3;
        Wed, 18 Oct 2023 15:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668174; x=1698272974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPN5Szaku0fAcpX6+m9F3J03s9I69W40Wqf+QRGeb0M=;
        b=eSnZ7S3QyRdmXF3XpXdZUK3iJ2gnmHf5gyMkjHk+3cpWuMHqnGtnSwORRg8KvzzWWJ
         xzXFgCS2WS6YCSWgVhR+FPNkNHy988uOPCCPJ1DPw0hStI48b/Zcd41/fMbfw71+XuKt
         NwriVzPK+Dmq0ZctdKDv1aqTvinb6WMhkJ98W4aE/R62kpAjzD6PSfT3TLYW/5K7n1Tv
         mcs0fHesVCA3nJiV75dxSqKSQcLgVjUuLnw4Qz6D0/liKHXIyqNx6vbjDD8kpYicQ/bZ
         lvWCCP+daQUO2P+Sy/mRNWepv1MYL4ewIMdbIL5fdwBazjcu8FWQi7G5NT3A2tQU712g
         ng8Q==
X-Gm-Message-State: AOJu0YyKuqG/1hfmukWU3X5dsvgI0qPh8L66oTDEkd0N1yrEb4zkzQrl
	0NB3nkBFeo87eRqRywy/iNNMcEreHNFoXUo6CdY=
X-Google-Smtp-Source: AGHT+IHDeXhculuLAF4lqOCMfOoqWHDPPErUcncs5XN4kIwLgMauKrkapEzKYnZdeep0yVWsD8p0urbYxogC6JidM2o=
X-Received: by 2002:a05:6a21:3281:b0:15c:b7ba:ea44 with SMTP id
 yt1-20020a056a21328100b0015cb7baea44mr501156pzb.60.1697668174177; Wed, 18 Oct
 2023 15:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008212251.236023-1-jolsa@kernel.org> <20231008212251.236023-2-jolsa@kernel.org>
 <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
 <ZSjlk99UOV2tTMWO@krava> <CAM9d7cjqvEs6262GfuF18mtFsWEznqNOWP_NqZN99Ys3MxCXqg@mail.gmail.com>
 <ZS5JHuwxL200M09H@krava> <CAM9d7chq125TOtnWFVKUC6PwRJqmXwNbfs7Dhm_04B3ZbA4jdw@mail.gmail.com>
 <ZS+Hj3aDWoCV/ckr@krava>
In-Reply-To: <ZS+Hj3aDWoCV/ckr@krava>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 18 Oct 2023 15:29:23 -0700
Message-ID: <CAM9d7cjtEfuBopVfn2+rpug8-tMjw-HbhHcD9gDmFhfqD_iySQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] tools/build: Fix -s detection code in tools/build/Makefile.build
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Dmitry Goncharov <dgoncharov@users.sf.net>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Ian Rogers <irogers@google.com>, 
	KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 12:21=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Tue, Oct 17, 2023 at 01:16:28PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 17, 2023 at 1:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Oct 16, 2023 at 06:36:10PM -0700, Namhyung Kim wrote:
> > > > On Thu, Oct 12, 2023 at 11:37=E2=80=AFPM Jiri Olsa <olsajiri@gmail.=
com> wrote:
> > > > >
> > > > > On Thu, Oct 12, 2023 at 08:57:33PM -0700, Namhyung Kim wrote:
> > > > > > Hi Jiri,
> > > > > >
> > > > > > On Sun, Oct 8, 2023 at 2:23=E2=80=AFPM Jiri Olsa <jolsa@kernel.=
org> wrote:
> > > > > > >
> > > > > > > As Dmitry described in [1] changelog the current way of detec=
ting
> > > > > > > -s option is broken for new make.
> > > > > >
> > > > > > I'm not sure what -s option does for perf (at least).
> > > > > > It doesn't seem much different whether I give it or not.
> > > > > > Am I missing something?
> > > > >
> > > > > what's your make version? the wrong output is visible when runnin=
g
> > > > > with make version > 4.4 .. basicaly the -s is wrongly detected an=
d
> > > > > you either get no output at all from some builds or overly verbos=
e
> > > > > output
> > > > >
> > > > > it's mentioned in the [1] commit changelog, I can put it to the
> > > > > changelog in new version
> > > >
> > > > IIUC it's about detecting `make -s` properly and not being confused
> > > > by `make a=3Ds` or something.  I'm not objecting on it but I don't =
see
> > > > what `make -s` does actually.
> > >
> > > so the tools/build/Makefile.build and tools/scripts/Makefile.include =
detect
> > > make -s option, which puts make into silent mode, so both makefiles s=
witch
> > > off the output by setting quiet=3Dsilent_ or silent=3D1
> > >
> > > the problem is that the detection of make -s option changed in make >=
 4.4
> > > and current code could be tricked to switch to silent mode just by ha=
ving
> > > 's' persent on the command line, like with 'a=3Ds'
> >
> > I think our talk is circulating :-).  Anyway I'm ok with the change, so
>
> :) ok, thanks
>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Which tree do you want to route it?
>
> I think perf tree is the best one to route it

Ok, I'll add it.

Thanks,
Namhyung

