Return-Path: <bpf+bounces-12481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677427CCDB5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E0B281AA7
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFAD43107;
	Tue, 17 Oct 2023 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA95430FB;
	Tue, 17 Oct 2023 20:16:41 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4292;
	Tue, 17 Oct 2023 13:16:40 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d4372322aso2699665a91.3;
        Tue, 17 Oct 2023 13:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573799; x=1698178599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUW+u1TYc1aiMVSluWq8+lAb+fft9seMdrtiitvSu28=;
        b=Vw4F62MARGmnJRrDmOVjmJvtRpcq6hi+u9GOtsJ1v/gw3u+kAArCTyfM5pd9eJsBG4
         7iXNTTQH1bK8CkJpMEwEUR7z2xFPyKEv0HQBnJ8HZnzRr7rmpYa8SEwEDWV4wGQGZPeE
         cwxOfVeq/eTKMW2+9q8b0edYxFj+X5cYiPd4TU8VoqlM9XSuYoG4bjk9KREikjHOxp4n
         buXCBr/o2J0QQTlLJpsmAzi2rlAl0BSs47rUK5hxW5tZiJCQilWtn91MtCU5BOP98XSk
         1RZPk/DNjDuTwE/vymovIV2KQif+KnDE5psqpWVr91+lzAcjERYulWqTJ11ij18bwatC
         JaGg==
X-Gm-Message-State: AOJu0Yycbd8DoIYzswHo9JjwMKTPznARmu5k/5THq4MYOPcY4Bd0fZoT
	1u9a65tznr+Aq0woSNqsQktmDBkzuaV2DmwePFg=
X-Google-Smtp-Source: AGHT+IG0y+1+8mbKTt/Fu2l9gbpU6L+YaEFfx0ecuo6IvHgLrxF44zcafMnC5tKmDYdPqIsIdH41Qn703Ggx7SzbFX0=
X-Received: by 2002:a17:90b:1e4f:b0:27d:549b:3e6f with SMTP id
 pi15-20020a17090b1e4f00b0027d549b3e6fmr3060045pjb.46.1697573799340; Tue, 17
 Oct 2023 13:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008212251.236023-1-jolsa@kernel.org> <20231008212251.236023-2-jolsa@kernel.org>
 <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
 <ZSjlk99UOV2tTMWO@krava> <CAM9d7cjqvEs6262GfuF18mtFsWEznqNOWP_NqZN99Ys3MxCXqg@mail.gmail.com>
 <ZS5JHuwxL200M09H@krava>
In-Reply-To: <ZS5JHuwxL200M09H@krava>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 17 Oct 2023 13:16:28 -0700
Message-ID: <CAM9d7chq125TOtnWFVKUC6PwRJqmXwNbfs7Dhm_04B3ZbA4jdw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 1:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 16, 2023 at 06:36:10PM -0700, Namhyung Kim wrote:
> > On Thu, Oct 12, 2023 at 11:37=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > >
> > > On Thu, Oct 12, 2023 at 08:57:33PM -0700, Namhyung Kim wrote:
> > > > Hi Jiri,
> > > >
> > > > On Sun, Oct 8, 2023 at 2:23=E2=80=AFPM Jiri Olsa <jolsa@kernel.org>=
 wrote:
> > > > >
> > > > > As Dmitry described in [1] changelog the current way of detecting
> > > > > -s option is broken for new make.
> > > >
> > > > I'm not sure what -s option does for perf (at least).
> > > > It doesn't seem much different whether I give it or not.
> > > > Am I missing something?
> > >
> > > what's your make version? the wrong output is visible when running
> > > with make version > 4.4 .. basicaly the -s is wrongly detected and
> > > you either get no output at all from some builds or overly verbose
> > > output
> > >
> > > it's mentioned in the [1] commit changelog, I can put it to the
> > > changelog in new version
> >
> > IIUC it's about detecting `make -s` properly and not being confused
> > by `make a=3Ds` or something.  I'm not objecting on it but I don't see
> > what `make -s` does actually.
>
> so the tools/build/Makefile.build and tools/scripts/Makefile.include dete=
ct
> make -s option, which puts make into silent mode, so both makefiles switc=
h
> off the output by setting quiet=3Dsilent_ or silent=3D1
>
> the problem is that the detection of make -s option changed in make > 4.4
> and current code could be tricked to switch to silent mode just by having
> 's' persent on the command line, like with 'a=3Ds'

I think our talk is circulating :-).  Anyway I'm ok with the change, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Which tree do you want to route it?

Thanks,
Namhyung

