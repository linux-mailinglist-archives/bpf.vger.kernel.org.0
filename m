Return-Path: <bpf+bounces-22200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA88858CC2
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 02:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E217E1C21DC4
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42C1773D;
	Sat, 17 Feb 2024 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIPYl4Ib"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0499149DE8
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133596; cv=none; b=V5P8G0o/uZKm62Mmy+1C2ekGtyioeL/DeHBlKXB/UiBNExmNiG4b7bNT8uhIJa+xZLNaioro0Tw8TFOxkX0p3Gnz4KS9jCjgnGJWwzq2iFEyW3/kFoa+Z8KQfDwDDSbPC6nRgpSRwtvs1hwSXxdTNPZXZJ2EhsLvlhLGnRKpQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133596; c=relaxed/simple;
	bh=tFma9MVvMZhragAW2jVg6+DR3rScNJ0SSQlrZIb5aVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIFkN+yZsUIuiarbLEr6p1wdTOMs+yIoacaFVtExBDzZ3foDY4e004Xyd0yCNmYDy3Bywhqpz5E9ufwyKIAJ+kxY+Xd7g2c2Sg8K1hKwSIujU7dhTmvqEk5ytpKs3QDZ7EK3X1+5H9Q2DigBk27YmNsUCV3hxQ0dVJWldvxj4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIPYl4Ib; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d5ce88b51cso44955ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708133594; x=1708738394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4QEsHt96n7jp5q0hO7Dy2wXjjgUx+HdH4AM/lX65g4=;
        b=dIPYl4IbR4hu+a0CELtOEM7ST4Ul8nUuEX+RqJGpKHwK7JZxTcNH7gHpOzU63UYtct
         H5/wfXpAO0vmCCdbkKD+neWzrGRqVAXSs/h1nMGBtNO3dk0zcUYX9I/jtj8vtMdGpnXI
         FA0Y/0vPa6w/MJcN7oLqVMyQ5wHUzq5I+iPoICgfRY/dWEiCbVsmJoZJateJRj6WCamk
         c1qvY+GCUFQ0fnaBCnXqHFIOOK7O1ULPdXweOBxPDAdCcqLCcldiaQNKZ0QjUHaL03g1
         i9Plo6MFR/rXR+/mvXpsqXdLzHPJZRQxuwGP+QjwCeNVXORTxbRzkC5IXnGfHgUw6v/d
         G1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133594; x=1708738394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4QEsHt96n7jp5q0hO7Dy2wXjjgUx+HdH4AM/lX65g4=;
        b=Ed1uTS5ojbkiIyGplvCWUVdzXMxA0gadl4FtcyxXxDew4F3KzWpJmOOOr+2a4BBZyW
         Yj7wvYE8dUMn90W2/8H0HWihblNvWCdIIj6wX4xEqzq+8o+bk8rjtFIr2aDKz+Jhbhxj
         Wqupm3LOX+MXYVJfXrIdt2h/qUjZe1HMMqfd91xGYHgFVlSrnh80mKzAo6BH30xDPLs/
         F/Km9Z2lCL5WFFAVYoQ9Xgu5erpqxqtE3EyX4ScihuVBsbvzmb7JaQiS5Vtp6OqKnzkd
         x5eaese/U6qXOHahP/oH9D2GUbeQnM+H4v3ZXPNesWMV8ED3RR9rfazq2R5t8KFIovcF
         4/5A==
X-Forwarded-Encrypted: i=1; AJvYcCVAf0U/BcxlG1bHNS5595xRASc2QRY4kQ7+xnlk9+CwwLrcI4KVREnmanmwdubtVwqxoMWw9nQO+9D7AStsWz3nYFj0
X-Gm-Message-State: AOJu0YzE52/es97h9VSVOYOyJr0tbeNoBswHSjrVenNDVn0xUpKiklQr
	fnUq7NIdRaRwi+n8NmB8JZKPzgneGhHJRy42h0J2k9gvyMznbP5ZABZwKWduhb+JDwOMqmr77mw
	vOUXEx+dpv+VyLKzS3bRg14qejBAWD+AmATEB
X-Google-Smtp-Source: AGHT+IGFdyC08PZ9ECT8uEXa3o1IBOv+/SzYzkyXo7tLXy11o0kACK0N9i0Bl/vYIGE1Qe7iS/7+PXDiU8G3GIfZpR8=
X-Received: by 2002:a17:902:e489:b0:1db:8119:7ce3 with SMTP id
 i9-20020a170902e48900b001db81197ce3mr78884ple.20.1708133593737; Fri, 16 Feb
 2024 17:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com> <20240202234057.2085863-4-irogers@google.com>
 <CAM9d7chPqFGEih7z7rp=eS5P30gSMvG=6fi=0QqT=EdfdMOH_A@mail.gmail.com>
In-Reply-To: <CAM9d7chPqFGEih7z7rp=eS5P30gSMvG=6fi=0QqT=EdfdMOH_A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Feb 2024 17:33:00 -0800
Message-ID: <CAP-5=fXzqF--KUOo1awmxDewupF-r_a2=yFC75tuGasNE-WpXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Changbin Du <changbin.du@huawei.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee <p4ranlee@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 2, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > Rather than iterate all CPUs and see if they are in CPU maps, directly
> > iterate the CPU map. Similarly make use of the intersect function
> > taking care for when "any" CPU is specified. Switch
> > perf_cpu_map__has_any_cpu_or_is_empty to more appropriate
> > alternatives.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c    | 114 ++++++++++++---------------
> >  tools/perf/arch/arm64/util/arm-spe.c |   4 +-
> >  2 files changed, 51 insertions(+), 67 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/ut=
il/cs-etm.c
> > index 77e6663c1703..07be32d99805 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -197,38 +197,37 @@ static int cs_etm_validate_timestamp(struct auxtr=
ace_record *itr,
> >  static int cs_etm_validate_config(struct auxtrace_record *itr,
> >                                   struct evsel *evsel)
> >  {
> > -       int i, err =3D -EINVAL;
> > +       int idx, err =3D 0;
> >         struct perf_cpu_map *event_cpus =3D evsel->evlist->core.user_re=
quested_cpus;
> > -       struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_c=
pus();
> > -
> > -       /* Set option of each CPU we have */
> > -       for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> > -               struct perf_cpu cpu =3D { .cpu =3D i, };
> > +       struct perf_cpu_map *intersect_cpus;
> > +       struct perf_cpu cpu;
> >
> > -               /*
> > -                * In per-cpu case, do the validation for CPUs to work =
with.
> > -                * In per-thread case, the CPU map is empty.  Since the=
 traced
> > -                * program can run on any CPUs in this case, thus don't=
 skip
> > -                * validation.
> > -                */
> > -               if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) =
&&
> > -                   !perf_cpu_map__has(event_cpus, cpu))
> > -                       continue;
> > +       /*
> > +        * Set option of each CPU we have. In per-cpu case, do the vali=
dation
> > +        * for CPUs to work with. In per-thread case, the CPU map has t=
he "any"
> > +        * CPU value. Since the traced program can run on any CPUs in t=
his case,
> > +        * thus don't skip validation.
> > +        */
> > +       if (!perf_cpu_map__has_any_cpu(event_cpus)) {
> > +               struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_=
online_cpus();
> >
> > -               if (!perf_cpu_map__has(online_cpus, cpu))
> > -                       continue;
> > +               intersect_cpus =3D perf_cpu_map__intersect(event_cpus, =
online_cpus);
> > +               perf_cpu_map__put(online_cpus);
> > +       } else {
> > +               intersect_cpus =3D perf_cpu_map__new_online_cpus();
> > +       }
>
> Would it be ok if any of these operations fail?  I believe the
> cpu map functions work well with NULL already.

If the allocation fails then the loop below won't iterate (the map
will be empty). The map is released and not used elsewhere in the
code. An allocation failure here won't cause the code to crash, but
there are other places where the code assumes what the properties of
having done this function are and they won't be working as intended.
It's not uncommon to see ENOMEM to just be abort for this reason.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > -               err =3D cs_etm_validate_context_id(itr, evsel, i);
> > +       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> > +               err =3D cs_etm_validate_context_id(itr, evsel, cpu.cpu)=
;
> >                 if (err)
> > -                       goto out;
> > -               err =3D cs_etm_validate_timestamp(itr, evsel, i);
> > +                       break;
> > +
> > +               err =3D cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
> >                 if (err)
> > -                       goto out;
> > +                       break;
> >         }
> >
> > -       err =3D 0;
> > -out:
> > -       perf_cpu_map__put(online_cpus);
> > +       perf_cpu_map__put(intersect_cpus);
> >         return err;
> >  }
> >
> > @@ -435,7 +434,7 @@ static int cs_etm_recording_options(struct auxtrace=
_record *itr,
> >          * Also the case of per-cpu mmaps, need the contextID in order =
to be notified
> >          * when a context switch happened.
> >          */
> > -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> > +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >                 evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> >                                            "timestamp", 1);
> >                 evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> > @@ -461,7 +460,7 @@ static int cs_etm_recording_options(struct auxtrace=
_record *itr,
> >         evsel->core.attr.sample_period =3D 1;
> >
> >         /* In per-cpu case, always need the time of mmap events etc */
> > -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
> > +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
> >                 evsel__set_sample_bit(evsel, TIME);
> >
> >         err =3D cs_etm_validate_config(itr, cs_etm_evsel);
> > @@ -533,45 +532,31 @@ static size_t
> >  cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> >                       struct evlist *evlist __maybe_unused)
> >  {
> > -       int i;
> > +       int idx;
> >         int etmv3 =3D 0, etmv4 =3D 0, ete =3D 0;
> >         struct perf_cpu_map *event_cpus =3D evlist->core.user_requested=
_cpus;
> > -       struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_online_c=
pus();
> > -
> > -       /* cpu map is not empty, we have specific CPUs to work with */
> > -       if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> > -               for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> > -                       struct perf_cpu cpu =3D { .cpu =3D i, };
> > +       struct perf_cpu_map *intersect_cpus;
> > +       struct perf_cpu cpu;
> >
> > -                       if (!perf_cpu_map__has(event_cpus, cpu) ||
> > -                           !perf_cpu_map__has(online_cpus, cpu))
> > -                               continue;
> > +       if (!perf_cpu_map__has_any_cpu(event_cpus)) {
> > +               /* cpu map is not "any" CPU , we have specific CPUs to =
work with */
> > +               struct perf_cpu_map *online_cpus =3D perf_cpu_map__new_=
online_cpus();
> >
> > -                       if (cs_etm_is_ete(itr, i))
> > -                               ete++;
> > -                       else if (cs_etm_is_etmv4(itr, i))
> > -                               etmv4++;
> > -                       else
> > -                               etmv3++;
> > -               }
> > +               intersect_cpus =3D perf_cpu_map__intersect(event_cpus, =
online_cpus);
> > +               perf_cpu_map__put(online_cpus);
> >         } else {
> > -               /* get configuration for all CPUs in the system */
> > -               for (i =3D 0; i < cpu__max_cpu().cpu; i++) {
> > -                       struct perf_cpu cpu =3D { .cpu =3D i, };
> > -
> > -                       if (!perf_cpu_map__has(online_cpus, cpu))
> > -                               continue;
> > -
> > -                       if (cs_etm_is_ete(itr, i))
> > -                               ete++;
> > -                       else if (cs_etm_is_etmv4(itr, i))
> > -                               etmv4++;
> > -                       else
> > -                               etmv3++;
> > -               }
> > +               /* Event can be "any" CPU so count all online CPUs. */
> > +               intersect_cpus =3D perf_cpu_map__new_online_cpus();
> >         }
> > -
> > -       perf_cpu_map__put(online_cpus);
> > +       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
> > +               if (cs_etm_is_ete(itr, cpu.cpu))
> > +                       ete++;
> > +               else if (cs_etm_is_etmv4(itr, cpu.cpu))
> > +                       etmv4++;
> > +               else
> > +                       etmv3++;
> > +       }
> > +       perf_cpu_map__put(intersect_cpus);
> >
> >         return (CS_ETM_HEADER_SIZE +
> >                (ete   * CS_ETE_PRIV_SIZE) +
> > @@ -813,16 +798,15 @@ static int cs_etm_info_fill(struct auxtrace_recor=
d *itr,
> >         if (!session->evlist->core.nr_mmaps)
> >                 return -EINVAL;
> >
> > -       /* If the cpu_map is empty all online CPUs are involved */
> > -       if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
> > +       /* If the cpu_map has the "any" CPU all online CPUs are involve=
d */
> > +       if (perf_cpu_map__has_any_cpu(event_cpus)) {
> >                 cpu_map =3D online_cpus;
> >         } else {
> >                 /* Make sure all specified CPUs are online */
> > -               for (i =3D 0; i < perf_cpu_map__nr(event_cpus); i++) {
> > -                       struct perf_cpu cpu =3D { .cpu =3D i, };
> > +               struct perf_cpu cpu;
> >
> > -                       if (perf_cpu_map__has(event_cpus, cpu) &&
> > -                           !perf_cpu_map__has(online_cpus, cpu))
> > +               perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
> > +                       if (!perf_cpu_map__has(online_cpus, cpu))
> >                                 return -EINVAL;
> >                 }
> >
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm=
64/util/arm-spe.c
> > index 51ccbfd3d246..0b52e67edb3b 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrac=
e_record *itr,
> >          * In the case of per-cpu mmaps, sample CPU for AUX event;
> >          * also enable the timestamp tracing for samples correlation.
> >          */
> > -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> > +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >                 evsel__set_sample_bit(arm_spe_evsel, CPU);
> >                 evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
> >                                            "ts_enable", 1);
> > @@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrac=
e_record *itr,
> >         tracking_evsel->core.attr.sample_period =3D 1;
> >
> >         /* In per-cpu case, always need the time of mmap events etc */
> > -       if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
> > +       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
> >                 evsel__set_sample_bit(tracking_evsel, TIME);
> >                 evsel__set_sample_bit(tracking_evsel, CPU);
> >
> > --
> > 2.43.0.594.gd9cf4e227d-goog
> >

