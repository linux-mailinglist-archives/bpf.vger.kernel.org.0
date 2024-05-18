Return-Path: <bpf+bounces-29987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438D8C8F0E
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 03:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD443282F40
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9B4A29;
	Sat, 18 May 2024 01:22:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46E637;
	Sat, 18 May 2024 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715995323; cv=none; b=EF6jDzkyZ65d6VOyupsBqDc7DltoyHqRzb/VOu3v5isqgrq/BMB4xIkfCO4FL0r3YoVaGwqlYxtldq1RXmhxateOTwRKmq/ogbdiwzm5AI4syHFnV5PYGDiHlkHBFkijvp0yOLydSFZo40uLx4pjZpoz2uJdvZ53/v5snzH7gU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715995323; c=relaxed/simple;
	bh=ElhXaKsS1+9DXmfAIxHjuyBWoUf40Xp5dX2TRm/4xnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn+6k4aVI/dYkj9d3lCActjttFv78sCsdfgoHX6XdQ91vNR8KpZ1iJ+p6MTH2+kofyW0BpZlp2raKwp3dw8kUhsZ64HR+DKXZ8a1q/voRoOn+PwsvFws72+6+PeVJkO3U1mD7k7qchpPX69eMhsYMdOI0FSX+EriiybfVWWbgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee954e0aa6so27076885ad.3;
        Fri, 17 May 2024 18:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715995321; x=1716600121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hc0SNlsLadEAwSJsJkJ0F+sA68E81mxz5OGr/0vCeI=;
        b=FV01LO2ToJpau07BPXN4t284mogm69zM5sqvk4dynWByOKOEg+8gQlnmNb0gbraeBM
         HYkTua+429ozIrV4dJcZ4IZSmmnVgeSgvVeKlauVtVWmkar00voVCW8RUmZaVzr/tgUa
         uJUxfiNQmbaARtu9Q5yuvGrZungYW/73HphjqZypkpr+6m2B8AvVGEpOvEu5qH67+KV7
         eXkP+t6OpjU0nwsYSaL7erXPihnIgtjCIic4U6BoM+PlvxbFGkPiCJjZmi6mrxxqqLSn
         r3X66iJZmI5va86zkNdFaloquyKdrdLoDp04gFhfndbk/wc/Fj4jBa0u+O1Fy7oKCFIR
         aVbA==
X-Forwarded-Encrypted: i=1; AJvYcCUJeIRgrVblGgPuHXroxqXCLu2Rf0FKyMIX2w0JzJCcHMEODlE7SH8nPfntSoxON0dZg1iBDdbKCCA4wu64XoKMKWEDVXZtgbDGOKxuzUAdqhcjmgezfgdyCVBRFHYOsbJD/YyTwVCJu5XczCcNJd3C6Da8hOHMs4igAI6lwCBUpC7enw==
X-Gm-Message-State: AOJu0YxKJq8kddk0OCGtBOU/0MRQJPIigx6Ob5p+970n2/mZ6e+PmQ7p
	G3S3KC+7OAXV8JzO3gUT6eQqLJ9M45iDvDWnfPREDzesy9PV8t/ursk2WqGDSOd+8KwLDmii8ey
	N6yeQ3iJoaJsgm9uMrtmx9SNruCI=
X-Google-Smtp-Source: AGHT+IE0d41KlXtAOA3EnUT5tFEzESh1XTS/75pcgKnYzszaKX7EC6DEt/owS960AUGa6kFY7l2W6eyQ5y1LDiIsH90=
X-Received: by 2002:a17:902:d2c4:b0:1e6:40f1:9357 with SMTP id
 d9443c01a7336-1ef43d2e3acmr276615955ad.8.1715995321085; Fri, 17 May 2024
 18:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
 <CAP-5=fUBJOaE3Tp1NP4Urdt-r_kHEaR00aTKxMrvfe_0fyPxYA@mail.gmail.com>
In-Reply-To: <CAP-5=fUBJOaE3Tp1NP4Urdt-r_kHEaR00aTKxMrvfe_0fyPxYA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 17 May 2024 18:21:50 -0700
Message-ID: <CAM9d7cjYcOuZOU_vFf8oFJjbTb62pGqTWSVopNAus6waXqSS+A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, May 16, 2024 at 10:34=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, May 15, 2024 at 10:04=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Allow uid and gid to be terms in BPF filters by first breaking the
> > > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > > from a value in the sample. Allow filters to be passed to perf top, t=
his allows:
> > >
> > > $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
> > >
> > > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > > due to processes/threads terminating between the /proc scan and the
> > > perf_event_open.
> >
> > Fwiw, something I noticed playing around with this (my workload was
> > `perf test -w noploop 100000` as different users) is that old samples
> > appeared to linger around making terminated processes still appear in
> > the top list. My guess is that there aren't other samples showing up
> > and pushing the old sample events out of the ring buffers due to the
> > filter. This can look quite odd and I don't know if we have a way to
> > improve upon it, flush the ring buffers, histograms, etc. It appears
> > to be a latent `perf top` issue that you could encounter on other low
> > frequency events, but I thought I'd mention it anyway.
>
> Some other thoughts:
>
>  - It is kind of annoying with the --filter option (either on top or
> record) that there first needs to be an event to filter on. It'd be
> nice if we could just filter the default event.

Hmm.. right.  It should work with the default event when
no -e option is given.

>
>  - Should "perf top --uid=3D1234" be removed or turned into  an alias
> for '--filter "uid =3D=3D $(id -u)"' given the --uid option generally
> doesn't work?

I think --uid should not fail if it cannot find the task.
I had a similar situation for perf stat --for-each-cgroup
and made it ignore the failures.

>
>  - What should happen to the perf top --pid and --tid options, should
> they be filters? Should they fallback on /proc scanning if there
> aren't sufficient BPF permissions? The plumbing for that is going to
> be messy.

I'm not inclined to do such things.

>
>  - There should probably be a way to filter on cgroups.

+1

>
>  - Does the user care that there are 3 kinds of filter that will work
> differently? Could we break them apart to make it more explicit, I may
> want tracepoint events with a BPF filter. How can we ensure 1 syntax
> for the 3 kinds of filter.
>
>  - Filtering on register values could be potentially interesting, for
> example, sampling on memcpy-s where the length is over a threshold. We
> have a register capture test:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/tests/shell/record.sh#n81
> Perhaps the filter could look something like 'perf record -g -e
> mem:$ADDRESS_OF_MEMCPY:x --filter "reg:rdx > 1024"' -  this makes me
> think we need to make a more convenient way to specify memory
> addresses as symbols.

I've been thinking about a similar idea on uftrace.
It would filter the function based on the value of an
argument or a global variable.

Thanks,
Namhyung


> >
> > > Ian Rogers (3):
> > >   perf bpf filter: Give terms their own enum
> > >   perf bpf filter: Add uid and gid terms
> > >   perf top: Allow filters on events
> > >
> > >  tools/perf/Documentation/perf-record.txt     |  2 +-
> > >  tools/perf/Documentation/perf-top.txt        |  4 ++
> > >  tools/perf/builtin-top.c                     |  9 +++
> > >  tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
> > >  tools/perf/util/bpf-filter.h                 |  5 +-
> > >  tools/perf/util/bpf-filter.l                 | 66 +++++++++---------=
-
> > >  tools/perf/util/bpf-filter.y                 |  7 +-
> > >  tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
> > >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++---=
--
> > >  9 files changed, 172 insertions(+), 70 deletions(-)
> > >
> > > --
> > > 2.45.0.rc1.225.g2a3ae87e7f-goog
> > >

