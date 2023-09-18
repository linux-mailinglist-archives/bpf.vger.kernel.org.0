Return-Path: <bpf+bounces-10336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE1C7A5642
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 01:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4A21C20AAE
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F6328BC;
	Mon, 18 Sep 2023 23:40:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2228E00
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 23:40:28 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17E90;
	Mon, 18 Sep 2023 16:40:27 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-79d1fbeeb41so87979439f.3;
        Mon, 18 Sep 2023 16:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695080426; x=1695685226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ/RPYyapJuuQ9GCqYoGVr20X0i1V2UFAqZEu2P6bY4=;
        b=fLYQNV7qHLKkeCrDejvJhZesYXfN8qvKlJlO6id8ZA9heQ3ykSSXtjQPqOV0ug3VV/
         7Z5ip3HfLx7ODq614zavHfEBUYLsUbAew2RIxwZGVoYo9DraPsMDHeqei1z6/TF7Y42y
         GHDSIa2ztkdR5koNB2XaSNDYvy0EjGqXwuJiZXqx2ZLQxUjWrI6jC9/A4dCfMxyUwDDB
         BeaYlCu/g9gQarG6MAZj4EUGFrVExe0fjh02E4aa5zQpLZvDju/BToDiDP6kPXBoYXf6
         gEGygeUAnEjHq4RIETCr+fBu7LT58nUNc+MP8QbFpcp0MV9Ga1mM4iFmX+Um4mcsv+ZR
         FJ7Q==
X-Gm-Message-State: AOJu0YxwO9r7Uyz1I3ikTQOMG3cDSH6NU64CeWyhIlajlKSLywKTVSjI
	T8OeIzlTQz3qZsY/fQ0xgeclEzC1XDlhXjcuOjo=
X-Google-Smtp-Source: AGHT+IGWclqCh9ZmDcU1GiQ442QtJu1ys6VVVPyRA/xjNjW/yMbel8ox/Zdv0SOIlOjbXMCnv8eyOawnEb7CLaMcQCE=
X-Received: by 2002:a5e:cb43:0:b0:787:4f3c:730d with SMTP id
 h3-20020a5ecb43000000b007874f3c730dmr11508999iok.18.1695080426492; Mon, 18
 Sep 2023 16:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Sep 2023 16:40:15 -0700
Message-ID: <CAM9d7cgNbRs3LJh_AjqAnRkJzsTxrGr_yqVK-urtoS-B2k1S=w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable BPF skeletons by default
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 2:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Enable BPF skeletons by default but warn don't fail if they can't be
> supported. This was the intended behavior for Linux 6.4 but it caused
> an issue captured in this thread:
> https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/
>
> This issue isn't repeated here as the previous issue related to
> generating vmlinux.h, which is no longer performed by default as a
> checked-in vmlinux.h is used instead.
>
> Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
> to 0 disables BPF skeletons. Also, rather than fail the build due to a
> missed dependency, dependencies are checked and BPF skeletons disabled
> if they aren't present.
>
> Some related commits:
> b7a2d774c9c5 perf build: Add ability to build with a generated vmlinux.h
> a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use=
 subset of used structs + CO-RE
> a2af0f6b8ef7 perf build: Add system include paths to BPF builds
> 5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in=
 source directory
> 9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename to N=
O_BPF_SKEL"
> a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use=
 subset of used structs + CO-RE
> 1d7966547e11 perf build: Add warning for when vmlinux.h generation fails
> a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SK=
EL
>
> Ian Rogers (5):
>   perf version: Add status of bpf skeletons
>   perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
>   perf test: Update build test for changed BPF skeleton defaults
>   perf test: Ensure EXTRA_TESTS is covered in build test
>   perf test: Detect off-cpu support from build options

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/Makefile.config              | 78 ++++++++++++++++---------
>  tools/perf/Makefile.perf                |  8 +--
>  tools/perf/builtin-version.c            |  1 +
>  tools/perf/tests/make                   |  7 ++-
>  tools/perf/tests/shell/record_offcpu.sh |  2 +-
>  5 files changed, 59 insertions(+), 37 deletions(-)
>
> --
> 2.42.0.459.ge4e396fd5e-goog
>

