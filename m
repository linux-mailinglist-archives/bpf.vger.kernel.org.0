Return-Path: <bpf+bounces-1856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C010F722F71
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 21:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F081C20C20
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167C2413A;
	Mon,  5 Jun 2023 19:14:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DCEDDC0
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 19:14:39 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471A113
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 12:14:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so28735ab.1
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685992473; x=1688584473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyL91Ec69lqQv1cIeAH4Hob9qDym4MqPZUuyevd3R8g=;
        b=jXB+Z7R1bUy16bQtNnF/M7OCBmgsTgJcWjiLkVx5tWQwzvzZKrrREsGFh3FB60Zmc4
         mTKQG1kEgqW1xh9f6Gy81vr7OGZwCA33ZSSa3pziU4SQdXfur+Rn7K8jc9aCtWBsQwVQ
         bOLvWSWpx54SLeXlVgMcYqKiVMpimpSAO3fvop0uW6W79SPgRnGSxiPqtb6Db5HW26ou
         pTAQ7ZSJPgyQTRvrN79IUm83ANOvVmzKtSzBQIDieDH4QWEgFLXn9tNdqotHzF04MGyg
         0wwmeSGDvgZS2qz7plot8Kb+62nWwndGzYH+M2o1qlUjTdwq3sLN8Cc0khlaZ9rUATsl
         z88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992473; x=1688584473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyL91Ec69lqQv1cIeAH4Hob9qDym4MqPZUuyevd3R8g=;
        b=GmxSQThUuIHflcRpgk4v7PqHXqd+kitj2HIAsdrt2uNt13C+jluNDWtR3WtnU6Y4rC
         8r+9WAWvh2f/RwHdV5I9LIfqVxWZBe44cX84AVrfZf7fJwz7ynxs0+AZO2IvEUHaUvqW
         /w9gESJjRvxFfAjbBEm/MW12Dy64bgTCqdD6TpxYREaJRVQK+WPAd9uVIachzHn123tP
         zXwjby2F4hK1IQiFYlxZVisyNQFS36yJ27nZ15/Mxp5dWXWVCGfxuVTqRh+Yef7Yl8gv
         quS2TT5+VzIKzvi3kRvYhvVWiTNZX5ZubSDotdBlGxRSX7BPiYPnObUSN71wl6bxqYID
         Cx6w==
X-Gm-Message-State: AC+VfDztLNW1UoQgHokpPtY/UEZnywAXR5FAlncbAMyoWkiRZfvYXWvi
	F/gYJtNEXS8n9gO0u+i5QNPBnDtokhAHHqKQIuEL1yVoF6EiQwkyUjMakA==
X-Google-Smtp-Source: ACHHUZ6rYSRmEK2A9Buvh4btbinrCfMTRWuZimZRs3lS+f5OxIwk3+ZAurfM7dLslT7TFPLsqza3h46NyyJP9qDqyPw=
X-Received: by 2002:a05:6e02:17cb:b0:33d:6c0e:83c0 with SMTP id
 z11-20020a056e0217cb00b0033d6c0e83c0mr11732ilu.27.1685992473307; Mon, 05 Jun
 2023 12:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com> <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
 <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com> <ZH4vru4zR8UlIdEN@kernel.org>
In-Reply-To: <ZH4vru4zR8UlIdEN@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Jun 2023 12:14:21 -0700
Message-ID: <CAP-5=fVhMSBk0Q0az7O=OdXtfiktqdxg9GaXdjOFCPPSS25GZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Bring back vmlinux.h generation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 5, 2023 at 11:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 05, 2023 at 10:18:51AM -0700, Ian Rogers escreveu:
> > On Mon, May 22, 2023 at 4:35=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' t=
o
> > > > satisfy libbpf 'runqueue' type verification") inadvertently created=
 a
> > > > declaration of 'struct rq' that conflicted with a generated
> > > > vmlinux.h's:
> > > >
> > > > ```
> > > > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of '=
rq'
> > > > struct rq {};
> > > >        ^
> > > > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous d=
efinition is here
> > > > struct rq {
> > > >        ^
> > > > 1 error generated.
> > > > ```
> > > >
> > > > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > > > happen again, bring back build support for generating vmlinux.h the=
n
> > > > add build tests.
> > > >
> > > > Ian Rogers (3):
> > > >   perf build: Add ability to build with a generated vmlinux.h
> > > >   perf bpf: Move the declaration of struct rq
> > > >   perf test: Add build tests for BUILD_BPF_SKEL
> > > >
> > > >  tools/perf/Makefile.config                       |  4 ++++
> > > >  tools/perf/Makefile.perf                         | 16 ++++++++++++=
+++-
> > > >  tools/perf/tests/make                            |  4 ++++
> > > >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> > > >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> > > >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
> > > >  6 files changed, 34 insertions(+), 3 deletions(-)
> > > >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
> > > >
> > > > --
> > > > 2.40.1.698.g37aff9b760-goog
> > > >
> > > >
> > >
> > > LGTM, for the series:
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Arnaldo, could we take this set?
>
> This one isn't applying right now on perf-tools-next.
>
> - Arnaldo

I'll rebase and resend.

Thanks,
Ian

