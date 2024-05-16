Return-Path: <bpf+bounces-29875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEEF8C7E1E
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F1FB21A59
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE21586C3;
	Thu, 16 May 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNi+44bU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01C3219F
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715896067; cv=none; b=Uiwo2Va9nqiDxHQn1V5J9xIxGI2rbchEv381D+V0QduwY4mJkKz2Z5CG/jjFV1ou/7FyhEyyfu2Mxyq1UB+DKIGHEurWXBI2Z2xivAuHJAUh6nDOz6a9qM0HRVumrdfAxrILnWMifjfzJj32sa7zRv46oHCYH+5W7LUzKE36uec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715896067; c=relaxed/simple;
	bh=Ik3s0QLEXOEOiIZxz0puFyUkL4LHRBNiHbWr/YLRhRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NCXCbgHD/U7rOW6SEj+9+pXfvvue2O0W33YL+OOVCkhUDu4EVXa0qcW3gcqcSD1/YPuLNzPP0UHOJFu+aMNCLkbTGoXCVQZ55ojMTDZk0g+ZNPKb9SCXWg7lH9w02WXQl7kulnG/xyDnR+Dn8PS+tjx1dTgM3uBkv8uT3iXRwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNi+44bU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43df9ac3ebcso12651cf.0
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715896065; x=1716500865; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+LTJasaamsJYF6JqhtXSMHdgg8g7mtflmrbwlVkiUs=;
        b=cNi+44bU6T5Ut5O4/zLtmHuA37wYQRHWmrgMLPuNSZypiQJurkeS2mtHbqWmfxIyii
         +ZSC0iI00P2wmsZK44bdkkyfcYbJakFu+j0G5Qa5Tiqmiw43Qm9S/Hvd40/BU/8HvHM+
         jlNQWAsky05s0qYKHbqVJn/5jQHPQHQMT/KJopLYj0WymbmkHdFZuivxGjJyx2ZdUopJ
         mM5IDM63KvqCVMEO+KQBw+ijqkJJYuf/x1InLtVJsCZUZ2lWUPDhQ3Lti3zZR+l+1Qxj
         WcsqeM0Wt6rDnVb8w6Ho4E90hGQcmE7qnxNAbcDwPI+iXislGNSqqyNz7n4eNCt7h8N0
         ZD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715896065; x=1716500865;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+LTJasaamsJYF6JqhtXSMHdgg8g7mtflmrbwlVkiUs=;
        b=pqGKwkVg5bu22XXANn68WEgAZWgj1T3Wa0iWDkWFFGS2zaMX1Mim0DFC3Bd8jZP8XC
         ITJC6z3ow3NDVqYBcKRbkBNmiA24svoakZc73uWdz6BcOi1Sk4PaeG0KJb9rGS2RCnv3
         7C+VqNAJe9iqaQy00CTyfH+ouHYhbecREBaoxxooOdaGX8gpejTRsohjknNUTJ3XEmUF
         YuHjtXEFpkMb3XgG439MwK3RZ82PBeuor0jFDLDH2lkDucaxuQScwWK2JpjjfMW28X4M
         CbX05a7DiVPWbmZQhNsLpN0sXHzYueZsTtSs5/NpBUrtVFuyZFJ0c0y7sww3O8WNkRw3
         dDyg==
X-Forwarded-Encrypted: i=1; AJvYcCWi5kwz7THvqXwe5m3DsF4cp0IuvrahCYwpTmmYoiOknKZWmYcLMtXBsQU7PEgD1wEZNyyt8HQNefyAPUTka7/0s/ye
X-Gm-Message-State: AOJu0YwCCdC/ZADnzf2oTD8b4kDsuqITvwcf5a0SJm4C5giLKFLhvGwb
	AFwX6+bNJ5GPux/UymXxNcr0VPJ2TDkqF3brjTDd20bObQQWF4gU6efFI3ZnJFvj1LVBN6lrkim
	p5m80zee8MC5jlP/LUxshfOMpfoi9U8qNWhUM
X-Google-Smtp-Source: AGHT+IEpoh5SflmwhsKZRGb3uWj2PRx5Ka0tqoJkAt6PPLPWsRA8EGE0KrjbIGmbq+C71K3g+J62d+JbvN7hamNw4tg=
X-Received: by 2002:a05:622a:7e4e:b0:43e:473e:fcf7 with SMTP id
 d75a77b69052e-43e473efd46mr122311cf.6.1715896064428; Thu, 16 May 2024
 14:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
In-Reply-To: <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 14:47:32 -0700
Message-ID: <CAP-5=fVzxAMrFFC9bsgUV73WLcywYgNW_1A+x47-N68FaBFrKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:04=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Allow uid and gid to be terms in BPF filters by first breaking the
> > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > from a value in the sample. Allow filters to be passed to perf top, thi=
s allows:
> >
> > $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
> >
> > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > due to processes/threads terminating between the /proc scan and the
> > perf_event_open.
>
> Fwiw, something I noticed playing around with this (my workload was
> `perf test -w noploop 100000` as different users) is that old samples
> appeared to linger around making terminated processes still appear in
> the top list. My guess is that there aren't other samples showing up
> and pushing the old sample events out of the ring buffers due to the
> filter. This can look quite odd and I don't know if we have a way to
> improve upon it, flush the ring buffers, histograms, etc. It appears
> to be a latent `perf top` issue that you could encounter on other low
> frequency events, but I thought I'd mention it anyway.

Oh, this is expected "perf top" behavior and "-z" fixes it:
```
$ man perf-top
...
       -z, --zero
          Zero history across display updates.
....
```
Why isn't "-z" the default? It would more naturally align with the
behavior of "top". I'll send a patch.

Thanks,
Ian

> Thanks,
> Ian
>
> > Ian Rogers (3):
> >   perf bpf filter: Give terms their own enum
> >   perf bpf filter: Add uid and gid terms
> >   perf top: Allow filters on events
> >
> >  tools/perf/Documentation/perf-record.txt     |  2 +-
> >  tools/perf/Documentation/perf-top.txt        |  4 ++
> >  tools/perf/builtin-top.c                     |  9 +++
> >  tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
> >  tools/perf/util/bpf-filter.h                 |  5 +-
> >  tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
> >  tools/perf/util/bpf-filter.y                 |  7 +-
> >  tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
> >  9 files changed, 172 insertions(+), 70 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >

