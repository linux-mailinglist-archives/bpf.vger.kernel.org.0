Return-Path: <bpf+bounces-1849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66D5722D7D
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E622B1C20CBA
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B90156F3;
	Mon,  5 Jun 2023 17:19:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E816FC3
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 17:19:04 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28252A6
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 10:19:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33d928a268eso11425ab.0
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685985542; x=1688577542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxEXC71EvIBIyrKJkGLhD82I8t0W90h4l0Ayz0o/Zuk=;
        b=E4z+OtE2bX/yCcT11XrY69kLEAdDfz8lyFnka1MGrcDLwOe8Zc/Nb0mpY4WBcxg85n
         scSbvoLxQn9L72GYXgySm/QNrAqXk2QF++Hzl8IMDcMsi9h4DrltRmmdRv+ia8hvyhKR
         F/hxReUxd60B94T1dYjNmaJONz8f5UuJJM9++Nwoyh5NuRJYSnOxs8Xmsjif6ticCaLa
         VuZ7ZvT6VVhJrVEUV12OdRiVx3R89skZso8eBtU7BQNOmRx30UzNbx61LCMDS11zg36G
         CWhgIKdMtWHe7jHfWhMxyi7KMzqs6SDQkeAlQK2Xsq4uVgh13dLRzLhRuUS27sdWn8ep
         oaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985542; x=1688577542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxEXC71EvIBIyrKJkGLhD82I8t0W90h4l0Ayz0o/Zuk=;
        b=G2Y61ZaOztXnmzW38mEK4bB3rR5+zBpMPPLaJwobDctwiZqOx4noDAhFf3zItOdL6k
         /A/srhk5TLux4HaujMMGiOBhP9RwlKbLdodqTTf1NRWk8fv1CIpwjGy3qutZNKHdjVw2
         BmoqpzM63rxUAB20zJlbfz31UdMESN8JQbplF6DNjtcUOmqgLCzU2sv/JFfNi7ee6DkN
         szdlh1u7F3h3KXbPc3ORYlaVX6/zYMdkKHPHMwi7QX2c/WfH1ckVR4xNiVC4hnVDaNk1
         GfMp9cnwnEdv7le2NmQawGNiUH7ZC/dt0LAMOIgQXZwvlAmGldYhJRVlMAY+pS3FwjOO
         2kMg==
X-Gm-Message-State: AC+VfDxLwncglLYlRMS/vG+G/VIWzBd9GLuKkQybG4lURFcFnqJS40Z3
	SJHa/+sxuCsA5xXGHklMaJbqmLK67x52obYDltOLMA==
X-Google-Smtp-Source: ACHHUZ5yCtTMWiv5JDmds12pvo/vlZ5+DYKz0ecdht2+KB6rBnQ5vhTqoa7+N3iMfOBk8KooPf3yokzgPcfpb92Abos=
X-Received: by 2002:a05:6e02:1e07:b0:33d:c057:f811 with SMTP id
 g7-20020a056e021e0700b0033dc057f811mr10502ila.1.1685985542393; Mon, 05 Jun
 2023 10:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com> <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Jun 2023 10:18:51 -0700
Message-ID: <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com>
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

On Mon, May 22, 2023 at 4:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 22, 2023 at 1:41=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> > satisfy libbpf 'runqueue' type verification") inadvertently created a
> > declaration of 'struct rq' that conflicted with a generated
> > vmlinux.h's:
> >
> > ```
> > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> > struct rq {};
> >        ^
> > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous defin=
ition is here
> > struct rq {
> >        ^
> > 1 error generated.
> > ```
> >
> > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > happen again, bring back build support for generating vmlinux.h then
> > add build tests.
> >
> > Ian Rogers (3):
> >   perf build: Add ability to build with a generated vmlinux.h
> >   perf bpf: Move the declaration of struct rq
> >   perf test: Add build tests for BUILD_BPF_SKEL
> >
> >  tools/perf/Makefile.config                       |  4 ++++
> >  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
> >  tools/perf/tests/make                            |  4 ++++
> >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h | 10 ++++++++++
> >  6 files changed, 34 insertions(+), 3 deletions(-)
> >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (90%)
> >
> > --
> > 2.40.1.698.g37aff9b760-goog
> >
> >
>
> LGTM, for the series:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Arnaldo, could we take this set?

Thanks,
Ian

