Return-Path: <bpf+bounces-21422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98BD84D02A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 18:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8406228B835
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D506182C9B;
	Wed,  7 Feb 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ali7moD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811E82C6C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328206; cv=none; b=R8085TPJk4+Og03YQdEzXlpTKHeCbHDabTDUJfaLnkU3HMRR3JzCmHkd80QDuDZxIRE0aWty1/8L9UMgBIJ5K8e0htnPUAUCxMpge35/f7xgVPFr6S61NFSUqaQAZMrpg4up9EfA1X/ugPBGeNOTNbwcy8bAC+iJJtCoBCgQOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328206; c=relaxed/simple;
	bh=gzheGeRgJpdEmjF0y1iCnKTVixvbMxJHhKeLRu8Eeoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8NzSqFrAnqiREfRVqeBn+rgLdPZAO73C5TdQzvq0VcDTlxvDuicWR+2qIDo83ZvXzRO4mBkYs1Fbt5M5fZRxULkslYIsU505JRMhKhfBUDy7DPSod0g3fC1YP5Rqs/ft8qwGjWyjxgHRzViVFeGqG9NZYhVq3ZeVeS04/f1rJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ali7moD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d5ce88b51cso7455ad.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707328204; x=1707933004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ApJBLk0fzWjTjN9CjafHsAuqVY2V9TgoIiQdE4PdVI=;
        b=0ali7moDRReq17WKJOhgSumgxr3h2BSWR/NRLXd3DWWzPMh8zETpyGlxpwh3hu3ALu
         07R1UK9cohzWFaYkUJhhu0kslIvjEROVaOSHNnUMRNcGmyZO5TBygSOI6ihcgOb+FD8M
         L72zgFtoagDCkzxyMMTjS7j2i3brYgPjbW+9p/E8M4CgCj0cto0Xiclo/cjVVcEcX2TH
         g1hP05XL3QY2L9nYYhGIGpjAiXwvx1ObaiWs2KWNdInFbPvHuExliNXAildIQXqXGhcU
         ovhyUhEksbM9jCVdGHGqntOw42H67CHuWhypNM01RE1oRRpE+hQ7SMlL59MiEPsLw+ur
         3MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328204; x=1707933004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ApJBLk0fzWjTjN9CjafHsAuqVY2V9TgoIiQdE4PdVI=;
        b=Iya+mFJgtz9p2jV+vTcmcJyvb/gwzaLeHvqocAGFmX6KUis96ksqMXOtLBKGlMgRvY
         LJxq/GAwkIsyA0WAjHFg1pHVevKI7S9dkO2XXNk4AWJuUnwy+qs3LT7z96IfZSR8N4aX
         8RSqlhU5pjgwTVe05HLtF1sQ8Ua7StR+V/8DC/UMvuHr3CCpCDHWJBxdxng1PggTHJPD
         YNpImE9yLe+6yD6KyqyU9nahkBh4beJcNyhUf9nxmo1QgdnEnLtGZmZUg5rbCgwBEmKj
         OFcqtVIjRNFWFQtjFVnlMeg4N6oqh5uwEzf9uOs1vhQnFgtJtj1D/p9L5vkR/iT0RQLW
         8jQA==
X-Gm-Message-State: AOJu0YwLaOdfppuqHfPy1M8QGtDOCXJn+SBEtu7FaGP/tKK1fxZYHypB
	DNqUraCRrRNEJ7ynkYYXpKRHMsqdUU6gTO0l7almNzOwd8c4cM8Z97hYgVuGBeYm9v+MFLQMc8D
	5qOF6f5rC/CXv5H/aiuFikKiy7BLYDSA42ygf
X-Google-Smtp-Source: AGHT+IFD1vLDNFF/cCZ7adDUY0uwWEN2An7CaNY14D8q8VeBURggPss2bO/ZCNEKEjhVl1WfgQsp+dUvylZ5EgY4+NQ=
X-Received: by 2002:a17:902:d2c6:b0:1d9:cf65:157b with SMTP id
 n6-20020a170902d2c600b001d9cf65157bmr168429plc.25.1707328203698; Wed, 07 Feb
 2024 09:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206033320.2657716-1-irogers@google.com> <CAM9d7cix-TuMov+hsqVvvkeSRA2snhuddcY0zypR1F9yY4G2Wg@mail.gmail.com>
In-Reply-To: <CAM9d7cix-TuMov+hsqVvvkeSRA2snhuddcY0zypR1F9yY4G2Wg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 Feb 2024 09:49:52 -0800
Message-ID: <CAP-5=fUD7q3Cr_rXijBy1cWnUHUmNwQtRdVdHV1D16iup8tVig@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] maps memory improvements and fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Mon, Feb 5, 2024 at 7:33=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > First 6 patches from:
> > https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.co=
m/
> >
> > Ian Rogers (6):
> >   perf maps: Switch from rbtree to lazily sorted array for addresses
> >   perf maps: Get map before returning in maps__find
> >   perf maps: Get map before returning in maps__find_by_name
> >   perf maps: Get map before returning in maps__find_next_entry
> >   perf maps: Hide maps internals
> >   perf maps: Locking tidy up of nr_maps
>
> This fails to build with NO_LIBUNWIND=3D1
>
> util/unwind-libdw.c: In function =E2=80=98unwind__get_entries=E2=80=99:
> util/unwind-libdw.c:266:70: error: invalid use of undefined type =E2=80=
=98struct maps=E2=80=99
>   266 |                 .machine        =3D
> RC_CHK_ACCESS(thread__maps(thread))->machine,

Thanks Namhyung, will fix in v2.

Ian

> Thanks,
> Namhyung
>
>
> >
> >  tools/perf/arch/x86/tests/dwarf-unwind.c |    1 +
> >  tools/perf/tests/maps.c                  |    3 +
> >  tools/perf/tests/thread-maps-share.c     |    8 +-
> >  tools/perf/tests/vmlinux-kallsyms.c      |   10 +-
> >  tools/perf/util/bpf-event.c              |    1 +
> >  tools/perf/util/callchain.c              |    2 +-
> >  tools/perf/util/event.c                  |    4 +-
> >  tools/perf/util/machine.c                |   34 +-
> >  tools/perf/util/map.c                    |    1 +
> >  tools/perf/util/maps.c                   | 1296 ++++++++++++++--------
> >  tools/perf/util/maps.h                   |   65 +-
> >  tools/perf/util/probe-event.c            |    1 +
> >  tools/perf/util/symbol-elf.c             |    4 +-
> >  tools/perf/util/symbol.c                 |   31 +-
> >  tools/perf/util/thread.c                 |    2 +-
> >  tools/perf/util/unwind-libunwind-local.c |    2 +-
> >  tools/perf/util/unwind-libunwind.c       |    7 +-
> >  17 files changed, 899 insertions(+), 573 deletions(-)
> >
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

