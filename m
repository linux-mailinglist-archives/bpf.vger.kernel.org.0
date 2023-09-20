Return-Path: <bpf+bounces-10428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D867A7170
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 06:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1331C20A97
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786023CD;
	Wed, 20 Sep 2023 04:12:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070523AF
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 04:11:59 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845ACE;
	Tue, 19 Sep 2023 21:11:56 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7927611c54bso254941739f.2;
        Tue, 19 Sep 2023 21:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695183116; x=1695787916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kQQlbHlUxfvLP9JSHJJYqYxl0q48pw7jR99N+jK2zs=;
        b=V5z09hhD1CTGAvIF/v+7P3D35K0D6v01R1PaKG95T/SvtLBmo4taqvPvvxcEspvurV
         Qh2Kd2wT39f0+2upYDelW0SrH4a3iy4Ibl0pMifk7u1z6CCfG/2R1mht8oXSPorue2/+
         dw7sZCGIgLeEN35FKvdczwIAr8GtE8UAztSgnoRXwO7oJ9VJ8Cn9TJFtARC09xb4JSvR
         wB4fGYBNSPBF1kkk7/bLKdAq6xGo5EtQysR20Ms1Y5fNKxgCGK+5g8Ea03Sjooy3nzHn
         lITZ2qivVoIJcheBqYPcHpOzDpzxD8En0B8Qw7Hi+iZ96z9u88lo4bqAIf9ro3n/6xcM
         GL0w==
X-Gm-Message-State: AOJu0Yz3+Db+/mlbh3pHMEKSQySAjAu6E1I1Y7MPPJ4E4u+bpg2GFAzy
	Acf53mF6bXrt3pCceaCnov+/CU8TWnGgdrDcALSpUwIb
X-Google-Smtp-Source: AGHT+IEpMvZa4NkKWo18Kgj65yVW8DYWPW8hqDW98NyY095dxfD7Q0TysgmIaqYcrl+hWzzHImFiUB0bFJZPYFtkKkw=
X-Received: by 2002:a5d:9e0f:0:b0:792:6963:df30 with SMTP id
 h15-20020a5d9e0f000000b007926963df30mr1606515ioh.0.1695183115828; Tue, 19 Sep
 2023 21:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com> <CAM9d7cgNbRs3LJh_AjqAnRkJzsTxrGr_yqVK-urtoS-B2k1S=w@mail.gmail.com>
 <ZQmfOO0tt9FuIkrj@kernel.org> <CAP-5=fXn=5SXqHKxaSAxs3bwQifUTVQWnrQb5A6D=3CHygfHLg@mail.gmail.com>
In-Reply-To: <CAP-5=fXn=5SXqHKxaSAxs3bwQifUTVQWnrQb5A6D=3CHygfHLg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Sep 2023 21:11:44 -0700
Message-ID: <CAM9d7cgTAQ9pQfC7pNHPy1UdZr+5zD0T76EYkosV72-P7HPQjg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable BPF skeletons by default
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Patrice Duroux <patrice.duroux@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 8:40=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Sep 19, 2023 at 6:16=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Sep 18, 2023 at 04:40:15PM -0700, Namhyung Kim escreveu:
> > > On Thu, Sep 14, 2023 at 2:20=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Enable BPF skeletons by default but warn don't fail if they can't b=
e
> > > > supported. This was the intended behavior for Linux 6.4 but it caus=
ed
> > > > an issue captured in this thread:
> > > > https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.or=
g/
> > > >
> > > > This issue isn't repeated here as the previous issue related to
> > > > generating vmlinux.h, which is no longer performed by default as a
> > > > checked-in vmlinux.h is used instead.
> > > >
> > > > Unlike with those changes, the BUILD_BPF_SKEL is kept and setting i=
t
> > > > to 0 disables BPF skeletons. Also, rather than fail the build due t=
o a
> > > > missed dependency, dependencies are checked and BPF skeletons disab=
led
> > > > if they aren't present.
> > > >
> > > > Some related commits:
> > > > b7a2d774c9c5 perf build: Add ability to build with a generated vmli=
nux.h
> > > > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BT=
F, use subset of used structs + CO-RE
> > > > a2af0f6b8ef7 perf build: Add system include paths to BPF builds
> > > > 5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_even=
t.h in source directory
> > > > 9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, renam=
e to NO_BPF_SKEL"
> > > > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BT=
F, use subset of used structs + CO-RE
> > > > 1d7966547e11 perf build: Add warning for when vmlinux.h generation =
fails
> > > > a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_=
BPF_SKEL
> > > >
> > > > Ian Rogers (5):
> > > >   perf version: Add status of bpf skeletons
> > > >   perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> > > >   perf test: Update build test for changed BPF skeleton defaults
> > > >   perf test: Ensure EXTRA_TESTS is covered in build test
> > > >   perf test: Detect off-cpu support from build options
> > >
> > > Tested-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Is this verbose by default now? Maybe its something on my side, but I
> > noticed a higher level of verbosity, can you check?
>
> I don't see more verbosity. Logs below.

I don't see it either.

Thanks,
Namhyung

