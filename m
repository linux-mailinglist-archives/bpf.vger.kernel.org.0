Return-Path: <bpf+bounces-29656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931548C46DC
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C791C20E09
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091439FDA;
	Mon, 13 May 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7elEJH7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E137144
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625110; cv=none; b=URvAckpSuX37rzblXTCm9vqCbK4RrC2ChW7/g7ywP02OuMYJESScUyhuFHSsgig6bzItEsOPu15FLznnR8yL3FMaorEmE5eHBzD52LmjghQ8isGQXGoJ4u+EtSS//vYSc19m2ylrxTepvOoe0Xvw62i33CyObjFC5omG2nJR9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625110; c=relaxed/simple;
	bh=3ZwAB8Y8ZUIyGagmA9bMT/46c3bkaZgO1OCbdjLIhQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd8pz56DXU0sC+w8lX4QXJaCplRslmOtTtocLVCwVbuiBM/Lj7aBK7V8o8Ns+0ICQag/kWHVIE1PQLnLTLM4VswaLIc3lfQMex2tC1s8dAXQtdUYY9msYDwuLRzfkhFngCJVaHbloayYIGwEvO/QXFUKmXOebKlKxzEedsQYywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7elEJH7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso20472a12.1
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715625107; x=1716229907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp4o1bBP9g8nSA2c4EpHf9/XklxFDXV2HdHmWJKkIqw=;
        b=e7elEJH7NOwhPMOzmp2ISWNlOFIKZWQBH6O7f+CBhbdgjXHnDT53uh1VqoCJxStsxV
         FLUdMPezoowxy5UPF4fY1DKDHalQPgNCH5kc3tmcjnK9AXGdQ4SNf/N/ENGIhmsy3mcX
         wGPqDNgobmMVZzQaU6C1rAUf16YaQy29ZzCPpZI5LvdP7Zuj8zxuF4ojMtj/3KzUqrlI
         YbYv0F1fC0D48FBi95iys9tTQPNT/fB7aEmdfLiTRQtCBTIi2zNntR0TZ/z9snMIfOPw
         7mYccyYxVEzvQXWtcsHweUE8B5s6aKSgWfvxP6juK+3L/4MJ6dIbnhR6abjwntYhiU/F
         LkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625107; x=1716229907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp4o1bBP9g8nSA2c4EpHf9/XklxFDXV2HdHmWJKkIqw=;
        b=RqsAI4m70HQkg1H0c9RgCMoz9uRIjeloNJ+DfooOU2UcBO+qmvKU9F3xNR32nuOgZa
         KDi9UU1BplRku51u2RW2mQf+4eHN6jFhjfHCv1lcdXT4p9DLB/tjmoEwFBfMrTqhuET9
         Qm1E8Hy6p8KbNy7/K+yZ1lQxrJFcApfYqVVw2AlzJ/aKUqBvh/u/Va14jpR9gXQFF1DL
         p6Box/+WnvZiEjZIrVd2Uej9x+u7R7sLUoqbxEohX4DJMTCMJkoSKvFGlhWAFIfPL5k4
         f7yk7JMPzvim29MG8C7n/Ul9g1/ecCUb0HysIYkyI++ljKmy4NIJ3DePFNOHTPXZ3fGM
         Q1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXGhnsFN/hdz9+uBXKffVpoi03azLyaI3Og1o0A4idZtR1g1QAo16mMu0Fnpv2+wirw6BtslHKsdS34OPf5NsGTbCCL
X-Gm-Message-State: AOJu0Ywb/Jg/Lx7XSg0UF+S8koYsX4vGUIm2ACIRMIGD1gs0BWFkWMzm
	7y1artnd6zyHrP1TSpOr+MIaF8sI9jS22fIeld0A87qjXWLYh58MzBScazliVSDLYhkWLh3/6Ry
	ZL8zNo6ToP/3w/5BPNTpV/2HV+C2P8kfJ//A=
X-Google-Smtp-Source: AGHT+IFt9WAWEm8QsBb4sEg9CQQRW3buM/TQvs364N6oHJq9eMGxek+5D8VmJE/YX1MybjfvRdmV3Zq5jL/uB0Qx6C4=
X-Received: by 2002:a50:cc0c:0:b0:572:9eec:774f with SMTP id
 4fb4d7f45d1cf-57421846490mr416314a12.0.1715625106955; Mon, 13 May 2024
 11:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-4-yabinc@google.com>
 <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>
In-Reply-To: <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Mon, 13 May 2024 11:31:34 -0700
Message-ID: <CALJ9ZPP_2=X7XNQrLCV1pQUVH-pnHbW=Kz75ugSy+kda9Xwmpg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

arch/powerpc/perf/core-book3s.c checks sample_type, see
   if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
     ...
     perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
  }
So I think we don't need the "fixes:" line.

On Fri, May 10, 2024 at 2:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> wr=
ote:
> >
> > Check sample_type in perf_sample_save_brstack() to prevent
> > saving branch stack data when it isn't required.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Yabin Cui <yabinc@google.com>
>
> It seems powerpc has the similar bug, then you need this:
>
> Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")
>
> Thanks,
> Namhyung
>
> > ---
> >  arch/x86/events/amd/core.c |  3 +--
> >  arch/x86/events/core.c     |  3 +--
> >  arch/x86/events/intel/ds.c |  3 +--
> >  include/linux/perf_event.h | 13 ++++++++-----
> >  4 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > index 985ef3b47919..fb9bf3aa1b42 100644
> > --- a/arch/x86/events/amd/core.c
> > +++ b/arch/x86/events/amd/core.c
> > @@ -967,8 +967,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *re=
gs)
> >                 if (!x86_perf_event_set_period(event))
> >                         continue;
> >
> > -               if (has_branch_stack(event))
> > -                       perf_sample_save_brstack(&data, event, &cpuc->l=
br_stack, NULL);
> > +               perf_sample_save_brstack(&data, event, &cpuc->lbr_stack=
, NULL);
> >
> >                 if (perf_event_overflow(event, &data, regs))
> >                         x86_pmu_stop(event, 0);
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 5b0dd07b1ef1..ff5577315938 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
> >
> >                 perf_sample_data_init(&data, 0, event->hw.last_period);
> >
> > -               if (has_branch_stack(event))
> > -                       perf_sample_save_brstack(&data, event, &cpuc->l=
br_stack, NULL);
> > +               perf_sample_save_brstack(&data, event, &cpuc->lbr_stack=
, NULL);
> >
> >                 if (perf_event_overflow(event, &data, regs))
> >                         x86_pmu_stop(event, 0);
> > diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> > index c2b5585aa6d1..f25236ffa28f 100644
> > --- a/arch/x86/events/intel/ds.c
> > +++ b/arch/x86/events/intel/ds.c
> > @@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct p=
erf_event *event,
> >         if (x86_pmu.intel_cap.pebs_format >=3D 3)
> >                 setup_pebs_time(event, data, pebs->tsc);
> >
> > -       if (has_branch_stack(event))
> > -               perf_sample_save_brstack(data, event, &cpuc->lbr_stack,=
 NULL);
> > +       perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
> >  }
> >
> >  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 8617815456b0..ecfbe22ff299 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1269,6 +1269,11 @@ static inline void perf_sample_save_raw_data(str=
uct perf_sample_data *data,
> >         data->sample_flags |=3D PERF_SAMPLE_RAW;
> >  }
> >
> > +static inline bool has_branch_stack(struct perf_event *event)
> > +{
> > +       return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
> > +}
> > +
> >  static inline void perf_sample_save_brstack(struct perf_sample_data *d=
ata,
> >                                             struct perf_event *event,
> >                                             struct perf_branch_stack *b=
rs,
> > @@ -1276,6 +1281,9 @@ static inline void perf_sample_save_brstack(struc=
t perf_sample_data *data,
> >  {
> >         int size =3D sizeof(u64); /* nr */
> >
> > +       if (!has_branch_stack(event))
> > +               return;
> > +
> >         if (branch_sample_hw_index(event))
> >                 size +=3D sizeof(u64);
> >         size +=3D brs->nr * sizeof(struct perf_branch_entry);
> > @@ -1665,11 +1673,6 @@ extern void perf_bp_event(struct perf_event *eve=
nt, void *data);
> >  # define perf_arch_bpf_user_pt_regs(regs) regs
> >  #endif
> >
> > -static inline bool has_branch_stack(struct perf_event *event)
> > -{
> > -       return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
> > -}
> > -
> >  static inline bool needs_branch_stack(struct perf_event *event)
> >  {
> >         return event->attr.branch_sample_type !=3D 0;
> > --
> > 2.45.0.118.g7fe29c98d7-goog
> >

