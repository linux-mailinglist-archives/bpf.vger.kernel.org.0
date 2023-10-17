Return-Path: <bpf+bounces-12362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543007CB80B
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 03:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DE1B20E99
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6931FD5;
	Tue, 17 Oct 2023 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8573D86;
	Tue, 17 Oct 2023 01:36:28 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F5A7;
	Mon, 16 Oct 2023 18:36:23 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-27d3c886671so3113911a91.3;
        Mon, 16 Oct 2023 18:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697506583; x=1698111383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PezLcqUQ4fxqz+zjVSrXD6cIGWHswOFYcRWMtWPL1w=;
        b=G/jLGwHWmU3VET5lXKDZtYO3mp3fo5DINbDxGXJE9dQ/vAUrmYGD2AGNm645csZO1m
         4bqfpdTLaLHkTJqt2rECohQI7ZEdZFtaPGckBAiCRVmmN2OhFC+VNXnY1BbV+g5WmuTo
         /ansXwv1kDUpxe2lFFklhg9qqXMKjtvIH0MsK+6n6p0M0VO2tCwWyw9l2yHSIUSio+Q+
         ueacVd8itho7YyuHsXFMll7V4OHM2h1VzDxdLGRs0Eoegtmy0tfSXzQje4bccIXhGE9N
         fxFxW+Lv3yGVga8mF2JmHuPh+EuEYyfoZfAOSMQwBcouGjHYPK72JqD60K1fq2zk27Cr
         I5/w==
X-Gm-Message-State: AOJu0Yz7xWti928En8X0QjqTIOERkHpqUSu1/TbQ5SuD4dlBNZSTO/ft
	AMDjuwNJO9YS+crFg/7WLgQB5YNiuJhqkMSkSwE=
X-Google-Smtp-Source: AGHT+IE1iJNdrL+EICv5jJ3ofztZ3+ti3g+K+nMjIX5669lckF1VwVEoO56cJCZOf/CoxBMbBRwOd9QZ+W4ewmsI/5Y=
X-Received: by 2002:a17:90a:357:b0:27d:e1c:5345 with SMTP id
 23-20020a17090a035700b0027d0e1c5345mr825669pjf.15.1697506583225; Mon, 16 Oct
 2023 18:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008212251.236023-1-jolsa@kernel.org> <20231008212251.236023-2-jolsa@kernel.org>
 <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com> <ZSjlk99UOV2tTMWO@krava>
In-Reply-To: <ZSjlk99UOV2tTMWO@krava>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 16 Oct 2023 18:36:10 -0700
Message-ID: <CAM9d7cjqvEs6262GfuF18mtFsWEznqNOWP_NqZN99Ys3MxCXqg@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 11:37=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Thu, Oct 12, 2023 at 08:57:33PM -0700, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > On Sun, Oct 8, 2023 at 2:23=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > As Dmitry described in [1] changelog the current way of detecting
> > > -s option is broken for new make.
> >
> > I'm not sure what -s option does for perf (at least).
> > It doesn't seem much different whether I give it or not.
> > Am I missing something?
>
> what's your make version? the wrong output is visible when running
> with make version > 4.4 .. basicaly the -s is wrongly detected and
> you either get no output at all from some builds or overly verbose
> output
>
> it's mentioned in the [1] commit changelog, I can put it to the
> changelog in new version

IIUC it's about detecting `make -s` properly and not being confused
by `make a=3Ds` or something.  I'm not objecting on it but I don't see
what `make -s` does actually.

Anyway, my make version is 4.3.

Thanks,
Namhyung

