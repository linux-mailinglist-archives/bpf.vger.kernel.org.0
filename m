Return-Path: <bpf+bounces-30041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F198CA345
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775211C21598
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339E1386D6;
	Mon, 20 May 2024 20:27:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F810D27A;
	Mon, 20 May 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236843; cv=none; b=sH0XDhRLEKeWhyrqSyt4FWbt3L92MgJTMZd0fcv8AN9kmJqBDmCTxJuzByq2+qJ94GUZiORp3o5LRfBD1FXiX+9hhe5oWbUd1PVkJepWUV0N7frhN3Uhz0V3pmThv466UeTaxOFnGJcpMlKtIHX0DlKm/9FGRwRH8sC9h2aF8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236843; c=relaxed/simple;
	bh=DPNMR0dai6CsnVakgvW2Fd/A5c8P+Rm2HMfKXqeK+vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml+O5PtJwINxAyU2AwUnFb1hn/ZN6dxZKXWdqA+kNkdYxSLnVfGE8VSTtptphjQerjFXp7EEkznFubpeRu0ewKsXxDUBdg++vYBzE/fzyVt7Cy1sVhIEOgHmGI1j5s+9sRcKI76b/8Jb3Pl14WOljahk+V8soU7AIbbeF7rv5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eeabda8590so82073645ad.0;
        Mon, 20 May 2024 13:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236841; x=1716841641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBBDVdk3mUf9czCJHGBFp0f/PIa7dl2k3ghnmPWelu4=;
        b=cqNOujb/C6P/uLb/O5Pi0zBCwKQShb03EEyyccBxO925f6W7IfpbMWsPIjPa+vdefx
         pXE2fxoF6cMvXnTrqWf4+krQM0Ua65h7Jbljf30se5D9lz9mc84BkxSdUrm3t7UKaavl
         /ujZ+zmuePPylRx5LmEln1PrFy169ZAt4E8LbI42G/gF7rDWe+Wg0xYX5LyaYTwsDUy/
         otYBEJE4R2ZU5O6of2I0z1ludtZNHsJ8gtLx9JxdNdFayzOeXO3l9CJqgC3l3VIupRcI
         65a9OyPsnGC445CNZA6nOBtbfSCtdtaoykI6dSf4JhB11G++wxcj/bjM+84zatga4u62
         HQzw==
X-Forwarded-Encrypted: i=1; AJvYcCWRC9b8rJJJ3nh+n1WuddXtCPehZAAUJnoOPh46tWIFD9ivdnKBXaOjuxBVL69+sqKb5DNXWMTHzPaJ13mIpnMJf9ezjQrp+0HatRddysCb8SRELFd4scadkajzsy5jsf/1TbQ0LhpP4VbGneOrW2/S4330LqtzR/lDupGnOAFzjU5hdw==
X-Gm-Message-State: AOJu0Yye1bCZQpvQSDNvatQTb/bfbZI/F4Gamlgn4pK2gMiXfjGVbvpf
	+jRXVKosvoe8svAGk9U+wpNkJBGjEBASpQjO3xh/BDGsyl4r2onctjXaSHeg/0+rkA2cYjgn7xk
	dhPIrLcqmAOzG2eD4c5ZvlZ+AuR4=
X-Google-Smtp-Source: AGHT+IGNnQWAhn/RHc22IBMOv2bxhlwMzwavLARkBxkn2TShIAhlwUJLGDusFMTrK/I/hcs/NJUQQI/tIoIHurH0IYY=
X-Received: by 2002:a05:6a20:101a:b0:1af:a4bc:1f71 with SMTP id
 adf61e73a8af0-1afde10de4amr25390712637.26.1716236841435; Mon, 20 May 2024
 13:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <20240516041948.3546553-2-irogers@google.com>
 <CAM9d7ch51JK8Xu+kOYUdxgM10_gS2=vjfW5sqFwrRS2eC8cYXA@mail.gmail.com> <CAP-5=fXNQ0=8mKKkBrmA9JpNLZEoQxb=AEYjBT-_brFt3Qom-A@mail.gmail.com>
In-Reply-To: <CAP-5=fXNQ0=8mKKkBrmA9JpNLZEoQxb=AEYjBT-_brFt3Qom-A@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 20 May 2024 13:27:09 -0700
Message-ID: <CAM9d7cj4c-twjH5TgLiJ-9qoxkdh0v5mmU_dA87BrjsO5q7brA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf bpf filter: Give terms their own enum
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

On Fri, May 17, 2024 at 8:30=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, May 17, 2024 at 6:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Give the term types their own enum so that additional terms can be
> > > added that don't correspond to a PERF_SAMPLE_xx flag. The term values
> > > are numerically ascending rather than bit field positions, this means
> > > they need translating to a PERF_SAMPLE_xx bit field in certain places
> > > and they are more densely encoded.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > [SNIP]
> > > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/per=
f/util/bpf_skel/sample_filter.bpf.c
> > > index fb94f5280626..8666c85e9333 100644
> > > --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > > @@ -48,31 +48,50 @@ static inline __u64 perf_get_sample(struct bpf_pe=
rf_event_data_kern *kctx,
> > >  {
> > >         struct perf_sample_data___new *data =3D (void *)kctx->data;
> > >
> > > -       if (!bpf_core_field_exists(data->sample_flags) ||
> > > -           (data->sample_flags & entry->flags) =3D=3D 0)
> > > +       if (!bpf_core_field_exists(data->sample_flags))
> > >                 return 0;
> > >
> > > -       switch (entry->flags) {
> > > -       case PERF_SAMPLE_IP:
> > > +       switch (entry->term) {
> > > +       case PBF_TERM_NONE:
> > > +               return 0;
> > > +       case PBF_TERM_IP:
> > > +               if ((data->sample_flags & PERF_SAMPLE_IP) =3D=3D 0)
> > > +                       return 0;
> >
> > Can we check this in a single place like in the original code
> > instead of doing it in every case?  I think we can keep the
> > entry->flags and check it only if it's non zero.  Then uid and
> > gid will have 0 to skip.
>
> I found the old way confusing. As the flags are a bitmap it looks like
> more than one can be set, if that were the case then the switch
> statement would be broken as the case wouldn't exist. Using an enum

The entry->flags is set by the bpf-filter code and it's guaranteed
to have a single bit.

> like this allows warnings to occur when a term is missing in the
> switch statement - which is good when you are adding new terms. I
> think it more obviously matches the man page. We could arrange for the
> enum values to encode the shift position of the flag. Something like:
>
> if ((entry->term > PBF_TERM_NONE && entry->term <=3D PBF_TERM_DATA_SRC) &=
&
>     (data->sample_flags & (1 << entry->term)) =3D=3D 0)
>    return 0;

Actually I'm ok with enum (and bit shift if needed).  I'm just thinking
if it'd be nicer if we can have a check in a single place.

>
> But the problem there is that not every sample type has an enum value,
> and I'm not sure it makes sense for things like STREAM_ID. We could do
> some macro magic to reduce the verbosity like:
>
> #define SAMPLE_CASE(x) \
>     case PBF_TERM_##x: \
>         if ((data->sample_flags & PERF_SAMPLE_x) =3D=3D 0) \
>             return 0
>
> But I thought that made the code harder to read given the relatively
> small number of sample cases.

I also want to avoid the macro if possible.

Thanks,
Namhyung


> >
> > >                 return kctx->data->ip;
> > > -       case PERF_SAMPLE_ID:
> > > +       case PBF_TERM_ID:
> > > +               if ((data->sample_flags & PERF_SAMPLE_ID) =3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->id;
> > > -       case PERF_SAMPLE_TID:
> > > +       case PBF_TERM_TID:
> > > +               if ((data->sample_flags & PERF_SAMPLE_TID) =3D=3D 0)
> > > +                       return 0;
> > >                 if (entry->part)
> > >                         return kctx->data->tid_entry.pid;
> > >                 else
> > >                         return kctx->data->tid_entry.tid;
> > > -       case PERF_SAMPLE_CPU:
> > > +       case PBF_TERM_CPU:
> > > +               if ((data->sample_flags & PERF_SAMPLE_CPU) =3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->cpu_entry.cpu;
> > > -       case PERF_SAMPLE_TIME:
> > > +       case PBF_TERM_TIME:
> > > +               if ((data->sample_flags & PERF_SAMPLE_TIME) =3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->time;
> > > -       case PERF_SAMPLE_ADDR:
> > > +       case PBF_TERM_ADDR:
> > > +               if ((data->sample_flags & PERF_SAMPLE_ADDR) =3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->addr;
> > > -       case PERF_SAMPLE_PERIOD:
> > > +       case PBF_TERM_PERIOD:
> > > +               if ((data->sample_flags & PERF_SAMPLE_PERIOD) =3D=3D =
0)
> > > +                       return 0;
> > >                 return kctx->data->period;
> > > -       case PERF_SAMPLE_TRANSACTION:
> > > +       case PBF_TERM_TRANSACTION:
> > > +               if ((data->sample_flags & PERF_SAMPLE_TRANSACTION) =
=3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->txn;
> > > -       case PERF_SAMPLE_WEIGHT_STRUCT:
> > > +       case PBF_TERM_WEIGHT_STRUCT:
> > > +               if ((data->sample_flags & PERF_SAMPLE_WEIGHT_STRUCT) =
=3D=3D 0)
> > > +                       return 0;
> > >                 if (entry->part =3D=3D 1)
> > >                         return kctx->data->weight.var1_dw;
> > >                 if (entry->part =3D=3D 2)
> > > @@ -80,15 +99,25 @@ static inline __u64 perf_get_sample(struct bpf_pe=
rf_event_data_kern *kctx,
> > >                 if (entry->part =3D=3D 3)
> > >                         return kctx->data->weight.var3_w;
> > >                 /* fall through */
> > > -       case PERF_SAMPLE_WEIGHT:
> > > +       case PBF_TERM_WEIGHT:
> > > +               if ((data->sample_flags & PERF_SAMPLE_WEIGHT) =3D=3D =
0)
> > > +                       return 0;
> > >                 return kctx->data->weight.full;
> > > -       case PERF_SAMPLE_PHYS_ADDR:
> > > +       case PBF_TERM_PHYS_ADDR:
> > > +               if ((data->sample_flags & PERF_SAMPLE_PHYS_ADDR) =3D=
=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->phys_addr;
> > > -       case PERF_SAMPLE_CODE_PAGE_SIZE:
> > > +       case PBF_TERM_CODE_PAGE_SIZE:
> > > +               if ((data->sample_flags & PERF_SAMPLE_CODE_PAGE_SIZE)=
 =3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->code_page_size;
> > > -       case PERF_SAMPLE_DATA_PAGE_SIZE:
> > > +       case PBF_TERM_DATA_PAGE_SIZE:
> > > +               if ((data->sample_flags & PERF_SAMPLE_DATA_PAGE_SIZE)=
 =3D=3D 0)
> > > +                       return 0;
> > >                 return kctx->data->data_page_size;
> > > -       case PERF_SAMPLE_DATA_SRC:
> > > +       case PBF_TERM_DATA_SRC:
> > > +               if ((data->sample_flags & PERF_SAMPLE_DATA_SRC) =3D=
=3D 0)
> > > +                       return 0;
> > >                 if (entry->part =3D=3D 1)
> > >                         return kctx->data->data_src.mem_op;
> > >                 if (entry->part =3D=3D 2)
> > > --
> > > 2.45.0.rc1.225.g2a3ae87e7f-goog
> > >

