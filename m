Return-Path: <bpf+bounces-68525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D0B59C74
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994443A4A4A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA393451D7;
	Tue, 16 Sep 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pcd/CotQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739E28315A
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037804; cv=none; b=kuSP1eJBqqtp/3zE4tj2GKyb/j5NLUWYLIkuBnQMVi6waTremGHYb8i2Ae1ffUhPmFa2c238kgMTAFQ6o/g4IEkthxeUx/XNl7ipd3AS5kUngg4LipQY4BAg7VjqP2R20GSwzFEuuRWsINTTH0fg81Anv/WYE7HrngaLbd990aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037804; c=relaxed/simple;
	bh=S0XEByRj3uWWPR8wRdKPW+KDKTAkPQN2ij2tuBBIN5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVh4awaNSyvmK7xkFpflcYOxasuRpqO8RGVkKn+KLlRXGCwDHm3LqwHq9JEKtejaDITSxMREi5GPPCAhDMowCnP4qYJfouPSbWsjwX9sBOgG+vM+2vavnXYiBnDzwddcg2hfSBVujfd91DsnNcRp2cW1HDMCJj+mx5ugYKAnfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pcd/CotQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267c90c426dso205025ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758037801; x=1758642601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuwGZjJj1aKaQ7ZqHDfU0A1t1yFPzale/y9ksaYhCOc=;
        b=Pcd/CotQYw+Brq/1keqaWETkD3M9ZO9eDhkNa+5AacdUm7MCH9jf+YKs3vxgf8niTd
         Tv2Dxumz0rSgvn5B/FaydjJBJ8hLm4xlnAW5JMwAm2a/S53XGdQSdWKPon6cqzcuyiXg
         IJZ+W/fAMSlqRy0FzvzjwRjN/JpuR2uYTazo3wgj0+60aYJi6F2ktTDOzkqxJ63/y5ec
         ZTb9Cq9tiTfs/LSlxX9T3bo/wQuPMriCkmpmoY4NXXBhDR8uzXak/rmSjUNQGjZldHkU
         LQAMcmTeDZn/j0CBeOcPGK+uOZTcn00ouBhrH1wEz1R6+slENtWF0HtYVbMRwxlURw4b
         zSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758037801; x=1758642601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuwGZjJj1aKaQ7ZqHDfU0A1t1yFPzale/y9ksaYhCOc=;
        b=J0FevBBiXMvc2iZHDWN/kM0HJhDo+BcWjZfwaDOTpGY9H1nQy1G8UCePTCxVT2qE4I
         4SdJDQiRV5xJfKL17JxQp/zxwqJorK3/mhjaGyy36dB1ENZp8gIL/ieIhWnep6crRtoA
         VJFQZsIez8B+HQSWrawyrdnF6d0vTnCT+eVk2UC6/CIeljHCxUhw57vwAq+HaXSwjlk/
         okrrIfSJxqRNLRL3kpOgqineyg7JWq89SyPS/UCIgs5RGwJmarWUrbLdnbLO0nYu7Z62
         E95dQXSBtpSBMiEfRv3tUGNJwQc1aMiz5pJUPZLz4TodYyOAiVKsm5RkGAPY1R9iLeYH
         CgYg==
X-Forwarded-Encrypted: i=1; AJvYcCVPWik6Ay/9TLM5w/csnMj5Fg9dar4r72j2yymD+WHPW4ZNaXk6P4rdvG25ErMHMskNnGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl89CgGp2gWlRowtIxnXwsyfzq8qXe99M0V2oq/sB08zxmR+3g
	QbvyvT4rr2zF8N9cGMM3LVVlcC3tilSJeH4/lvD3OBSO88uBUd0WO5wWi0FME+9KGxTlbE2Hlm8
	C8wuvpAH++5ypnk3RlvNFCq277IfZTjySL2ULGqRn
X-Gm-Gg: ASbGncvJ50ICdKjSeBW4JZ3dvRp8/sd0yU8xevgjD3TwxU6kXsaGkkQ+CS/CoxVXQ6P
	bxO0vlZhrosipJoaitkh4ArLmgka0lB2Mh2rvx+21czSeCGapek5PtQrWKK5eqBkZoBQmj0Cg/i
	8Oc0kS2pwxCRGMuYbAYpskooX8V4K/d+xG1OjHBvnaOXF7O8L7EUCp0nvduyUewIugeFIbMuFQ+
	kOqD6gZdSKj+g==
X-Google-Smtp-Source: AGHT+IHO6Zl9Jk8wMRrYE1wi/CNz3JGNtGLcqSlLjI9RIzas2xUIXAGM4U+bZdcGwJ8a+qtinK6iKlrssjmhx4oYZ/s=
X-Received: by 2002:a17:902:da8e:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-267ca0e9effmr4655365ad.9.1758037800581; Tue, 16 Sep 2025
 08:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com> <20250914181121.1952748-21-irogers@google.com>
 <aMljsNZxTw5ZPfeb@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <aMljsNZxTw5ZPfeb@J2N7QTR9R3.cambridge.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 08:49:48 -0700
X-Gm-Features: AS18NWBQ3rj5UkKzcvJIZ9hFyWsCBwkA8vExEGXv8JNku2mCbKvbtMi7bfqrCdg
Message-ID: <CAP-5=fUx5oyCBtp2NO-h1mTC+ANt=uTOp9tS3rVN=CQFuXo00g@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] perf parse-events: Add HW_CYCLES_STR as default
 cycles event string
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:18=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Sun, Sep 14, 2025 at 11:11:20AM -0700, Ian Rogers wrote:
> > ARM managed to significantly overload the meaning of the "cycles"
> > event in their PMU kernel drivers through sysfs.
>
> Ian, please stop phrasing this as if Arm have done something wrong here.
>
> It's true that some system PMU drivers have events named 'cycles'.
>
> It's not true that this is "overloading" the meaning of 'cycles'; those
> PMU-specific events were never intended to be conflated with the
> PERF_TYPE_HARDWARE events which have the same name.
>
> This was never a problem until the perf tool was changed to handle
> events such that it blindly assumed all events were in the same
> namespace. I have repeatedly explained that this was a bad idea.
>
> There is no reason that this should be handled in an ARM-specific way;
> if you want the bare 'cycles' event (withj no explcit PMU) to mean
> PERF_TYPE_HARDWARE:PERF_COUNT_HW_CPU_CYCLES, then *don't* match that
> with other PMU types. We cna specifically identify CPU PMUs which
> support that with the extended type ID if necessary.

Is the "cycles" event meaning uncore events a problem on anything
other than ARM, no.
Is having more than one event of the same name overloading the name,
by my definition yes.
Am I implying ARM has done something wrong? Well other than in fixing
a problem created by ARM's drivers..

Firstly, let's not pretend ARM has always elegantly supported the
legacy cycles event. When BIG.little came out, as you explained to me,
the legacy events would be opened on the first PMU registered with the
kernel. You would get legacy events on some fraction of the CPU cores.
ARM was reliant on a lot of seemingly correct behavior by having its
core PMU drivers appear as uncore ones. I am very much still in the
process of trying to clean up the tech debt and mess that falls out
from BIG.little and Intel's hybrid.

The behavior of legacy events with extended types and wildcarding.
This was introduced by Intel. The right moment to complain would have
been when Intel added the extended type and wildcarding support in the
kernel and perf tool. I wasn't even a reviewer on those patches.

Do ARM do things in their drivers that seem unthought through? Yes,
when hex suffixes of physical addresses were added to uncore PMU
drivers it was missed that a53 and a57 would also match this wildcard
suffix as ARM has unconventional core PMU names and the suffix on
those match as hex. We've worked around the issue by saying a hex
suffix must be longer than 3 characters but when ARM bumps up its CPU
names that will be broken. It seems there is some ambition to reinvent
rules when ARM drivers do things and the fallout has all too often had
to be fixed and addressed by me, with emails like this for thanks.

I'm sorry that you think I'm targeting ARM by fixing the issues your
drivers have introduced. It would have been better if ARM's drivers
didn't keep introducing issues. I'd repeat my call here that ARM add
support for the parse-events test for their PMUs. I don't understand
your last paragraph, in the context of the patch series it makes
little to no sense as the patch series is very much doing this.

Finally, doing things this way was prompted by James Clark's concerns
and I posted about this exact patch here:
https://lore.kernel.org/lkml/CAP-5=3DfUsZCz8Li1noKMODKXTLYFH9FsDCpXqCUxfu1h=
+s4c6Vw@mail.gmail.com/
ie I only added this patch at someone from Linaro's request and
received 0 feedback that doing so would be wrong. I don't think it is
and recommend this patch series for review.

Thanks,
Ian

> Mark.
>
> > In the tool use
> > "cpu-cycles" on ARM to avoid wildcard matching on different PMUS. This
> > is most commonly done in test code.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c           |   4 +-
> >  tools/perf/tests/code-reading.c     |   4 +-
> >  tools/perf/tests/keep-tracking.c    |   2 +-
> >  tools/perf/tests/parse-events.c     | 100 ++++++++++++++--------------
> >  tools/perf/tests/perf-time-to-tsc.c |   2 +-
> >  tools/perf/tests/switch-tracking.c  |   2 +-
> >  tools/perf/util/evlist.c            |   2 +-
> >  tools/perf/util/parse-events.h      |  10 +++
> >  tools/perf/util/perf_api_probe.c    |   4 +-
> >  9 files changed, 71 insertions(+), 59 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 2c38dd98f6ca..9f522b787ad5 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1957,7 +1957,7 @@ static int add_default_events(void)
> >                               "cpu-migrations,"
> >                               "page-faults,"
> >                               "instructions,"
> > -                             "cycles,"
> > +                             HW_CYCLES_STR ","
> >                               "stalled-cycles-frontend,"
> >                               "stalled-cycles-backend,"
> >                               "branches,"
> > @@ -2043,7 +2043,7 @@ static int add_default_events(void)
> >                        * Make at least one event non-skippable so fatal=
 errors are visible.
> >                        * 'cycles' always used to be default and non-ski=
ppable, so use that.
> >                        */
> > -                     if (strcmp("cycles", evsel__name(evsel)))
> > +                     if (strcmp(HW_CYCLES_STR, evsel__name(evsel)))
> >                               evsel->skippable =3D true;
> >               }
> >       }
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-re=
ading.c
> > index 9c2091310191..baa44918f555 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -649,7 +649,9 @@ static int do_test_code_reading(bool try_kcore)
> >       struct map *map;
> >       bool have_vmlinux, have_kcore;
> >       struct dso *dso;
> > -     const char *events[] =3D { "cycles", "cycles:u", "cpu-clock", "cp=
u-clock:u", NULL };
> > +     const char *events[] =3D {
> > +             HW_CYCLES_STR, HW_CYCLES_STR ":u", "cpu-clock", "cpu-cloc=
k:u", NULL
> > +     };
> >       int evidx =3D 0;
> >       struct perf_env host_env;
> >
> > diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-t=
racking.c
> > index eafb49eb0b56..d54ddb4db47b 100644
> > --- a/tools/perf/tests/keep-tracking.c
> > +++ b/tools/perf/tests/keep-tracking.c
> > @@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite *tes=
t __maybe_unused, int subte
> >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> >
> >       CHECK__(parse_event(evlist, "dummy:u"));
> > -     CHECK__(parse_event(evlist, "cycles:u"));
> > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> >
> >       evlist__config(evlist, &opts, NULL);
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index 4e55b0d295bd..7d59648a0591 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -198,7 +198,7 @@ static int test__checkevent_symbolic_name_config(st=
ruct evlist *evlist)
> >       TEST_ASSERT_VAL("wrong number of entries", 0 !=3D evlist->core.nr=
_entries);
> >
> >       perf_evlist__for_each_evsel(&evlist->core, evsel) {
> > -             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, "c=
ycles");
> > +             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, HW=
_CYCLES_STR);
> >
> >               if (ret)
> >                       return ret;
> > @@ -884,7 +884,7 @@ static int test__group1(struct evlist *evlist)
> >
> >               /* cycles:upp */
> >               evsel =3D evsel__next(evsel);
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
> >                       continue;
> >               }
> >               /* cycles:k */
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1085,7 +1085,7 @@ static int test__group4(struct evlist *evlist __m=
aybe_unused)
> >
> >               /* cycles:u + p */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1133,7 +1133,7 @@ static int test__group5(struct evlist *evlist __m=
aybe_unused)
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> >               /* cycles + G */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1168,7 +1168,7 @@ static int test__group5(struct evlist *evlist __m=
aybe_unused)
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> >               /* cycles:G */
> >               evsel =3D leader =3D evsel__next(evsel);
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1202,7 +1202,7 @@ static int test__group5(struct evlist *evlist __m=
aybe_unused)
> >       for (int i =3D 0; i < num_core_entries(); i++) {
> >               /* cycles */
> >               evsel =3D evsel__next(evsel);
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1231,7 +1231,7 @@ static int test__group_gh1(struct evlist *evlist)
> >
> >               /* cycles + :H group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1278,7 +1278,7 @@ static int test__group_gh2(struct evlist *evlist)
> >
> >               /* cycles + :G group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1325,7 +1325,7 @@ static int test__group_gh3(struct evlist *evlist)
> >
> >               /* cycles:G + :u group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1372,7 +1372,7 @@ static int test__group_gh4(struct evlist *evlist)
> >
> >               /* cycles:G + :uG group modifier */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1417,7 +1417,7 @@ static int test__leader_sample1(struct evlist *ev=
list)
> >
> >               /* cycles - sampling group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1540,7 +1540,7 @@ static int test__pinned_group(struct evlist *evli=
st)
> >
> >               /* cycles - group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1594,7 +1594,7 @@ static int test__exclusive_group(struct evlist *e=
vlist)
> >
> >               /* cycles - group leader */
> >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist) =
: evsel__next(evsel));
> > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1759,7 +1759,7 @@ static int test__checkevent_raw_pmu(struct evlist=
 *evlist)
> >  static int test__sym_event_slash(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_=
CYCLES_STR);
> >
> >       if (ret)
> >               return ret;
> > @@ -1771,7 +1771,7 @@ static int test__sym_event_slash(struct evlist *e=
vlist)
> >  static int test__sym_event_dc(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_=
CYCLES_STR);
> >
> >       if (ret)
> >               return ret;
> > @@ -1783,7 +1783,7 @@ static int test__sym_event_dc(struct evlist *evli=
st)
> >  static int test__term_equal_term(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_=
CYCLES_STR);
> >
> >       if (ret)
> >               return ret;
> > @@ -1795,7 +1795,7 @@ static int test__term_equal_term(struct evlist *e=
vlist)
> >  static int test__term_equal_legacy(struct evlist *evlist)
> >  {
> >       struct evsel *evsel =3D evlist__first(evlist);
> > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "cy=
cles");
> > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, HW_=
CYCLES_STR);
> >
> >       if (ret)
> >               return ret;
> > @@ -2006,27 +2006,27 @@ static const struct evlist_test test__events[] =
=3D {
> >               /* 7 */
> >       },
> >       {
> > -             .name  =3D "{instructions:k,cycles:upp}",
> > +             .name  =3D "{instructions:k," HW_CYCLES_STR ":upp}",
> >               .check =3D test__group1,
> >               /* 8 */
> >       },
> >       {
> > -             .name  =3D "{faults:k,branches}:u,cycles:k",
> > +             .name  =3D "{faults:k,branches}:u," HW_CYCLES_STR ":k",
> >               .check =3D test__group2,
> >               /* 9 */
> >       },
> >       {
> > -             .name  =3D "group1{syscalls:sys_enter_openat:H,cycles:kpp=
p},group2{cycles,1:3}:G,instructions:u",
> > +             .name  =3D "group1{syscalls:sys_enter_openat:H," HW_CYCLE=
S_STR ":kppp},group2{" HW_CYCLES_STR ",1:3}:G,instructions:u",
> >               .check =3D test__group3,
> >               /* 0 */
> >       },
> >       {
> > -             .name  =3D "{cycles:u,instructions:kp}:p",
> > +             .name  =3D "{" HW_CYCLES_STR ":u,instructions:kp}:p",
> >               .check =3D test__group4,
> >               /* 1 */
> >       },
> >       {
> > -             .name  =3D "{cycles,instructions}:G,{cycles:G,instruction=
s:G},cycles",
> > +             .name  =3D "{" HW_CYCLES_STR ",instructions}:G,{" HW_CYCL=
ES_STR ":G,instructions:G}," HW_CYCLES_STR,
> >               .check =3D test__group5,
> >               /* 2 */
> >       },
> > @@ -2036,27 +2036,27 @@ static const struct evlist_test test__events[] =
=3D {
> >               /* 3 */
> >       },
> >       {
> > -             .name  =3D "{cycles,cache-misses:G}:H",
> > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses:G}:H",
> >               .check =3D test__group_gh1,
> >               /* 4 */
> >       },
> >       {
> > -             .name  =3D "{cycles,cache-misses:H}:G",
> > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses:H}:G",
> >               .check =3D test__group_gh2,
> >               /* 5 */
> >       },
> >       {
> > -             .name  =3D "{cycles:G,cache-misses:H}:u",
> > +             .name  =3D "{" HW_CYCLES_STR ":G,cache-misses:H}:u",
> >               .check =3D test__group_gh3,
> >               /* 6 */
> >       },
> >       {
> > -             .name  =3D "{cycles:G,cache-misses:H}:uG",
> > +             .name  =3D "{" HW_CYCLES_STR ":G,cache-misses:H}:uG",
> >               .check =3D test__group_gh4,
> >               /* 7 */
> >       },
> >       {
> > -             .name  =3D "{cycles,cache-misses,branch-misses}:S",
> > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-misses=
}:S",
> >               .check =3D test__leader_sample1,
> >               /* 8 */
> >       },
> > @@ -2071,7 +2071,7 @@ static const struct evlist_test test__events[] =
=3D {
> >               /* 0 */
> >       },
> >       {
> > -             .name  =3D "{cycles,cache-misses,branch-misses}:D",
> > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-misses=
}:D",
> >               .check =3D test__pinned_group,
> >               /* 1 */
> >       },
> > @@ -2109,7 +2109,7 @@ static const struct evlist_test test__events[] =
=3D {
> >               /* 6 */
> >       },
> >       {
> > -             .name  =3D "task-clock:P,cycles",
> > +             .name  =3D "task-clock:P," HW_CYCLES_STR,
> >               .check =3D test__checkevent_precise_max_modifier,
> >               /* 7 */
> >       },
> > @@ -2140,17 +2140,17 @@ static const struct evlist_test test__events[] =
=3D {
> >               /* 2 */
> >       },
> >       {
> > -             .name  =3D "cycles/name=3D'COMPLEX_CYCLES_NAME:orig=3Dcyc=
les,desc=3Dchip-clock-ticks'/Duk",
> > +             .name  =3D HW_CYCLES_STR "/name=3D'COMPLEX_CYCLES_NAME:or=
ig=3Dcycles,desc=3Dchip-clock-ticks'/Duk",
> >               .check =3D test__checkevent_complex_name,
> >               /* 3 */
> >       },
> >       {
> > -             .name  =3D "cycles//u",
> > +             .name  =3D HW_CYCLES_STR "//u",
> >               .check =3D test__sym_event_slash,
> >               /* 4 */
> >       },
> >       {
> > -             .name  =3D "cycles:k",
> > +             .name  =3D HW_CYCLES_STR ":k",
> >               .check =3D test__sym_event_dc,
> >               /* 5 */
> >       },
> > @@ -2160,17 +2160,17 @@ static const struct evlist_test test__events[] =
=3D {
> >               /* 6 */
> >       },
> >       {
> > -             .name  =3D "{cycles,cache-misses,branch-misses}:e",
> > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-misses=
}:e",
> >               .check =3D test__exclusive_group,
> >               /* 7 */
> >       },
> >       {
> > -             .name  =3D "cycles/name=3Dname/",
> > +             .name  =3D HW_CYCLES_STR "/name=3Dname/",
> >               .check =3D test__term_equal_term,
> >               /* 8 */
> >       },
> >       {
> > -             .name  =3D "cycles/name=3Dl1d/",
> > +             .name  =3D HW_CYCLES_STR "/name=3Dl1d/",
> >               .check =3D test__term_equal_legacy,
> >               /* 9 */
> >       },
> > @@ -2311,7 +2311,7 @@ static const struct evlist_test test__events_pmu[=
] =3D {
> >               /* 9 */
> >       },
> >       {
> > -             .name  =3D "cpu/cycles,period=3D100000,config2/",
> > +             .name  =3D "cpu/" HW_CYCLES_STR ",period=3D100000,config2=
/",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__checkevent_symbolic_name_config,
> >               /* 0 */
> > @@ -2335,43 +2335,43 @@ static const struct evlist_test test__events_pm=
u[] =3D {
> >               /* 3 */
> >       },
> >       {
> > -             .name  =3D "{cpu/instructions/k,cpu/cycles/upp}",
> > +             .name  =3D "{cpu/instructions/k,cpu/" HW_CYCLES_STR "/upp=
}",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__group1,
> >               /* 4 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/u,cpu/instructions/kp}:p",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/u,cpu/instructions/kp}=
:p",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__group4,
> >               /* 5 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/G}:H",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/G}:H=
",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__group_gh1,
> >               /* 6 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/H}:G",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/H}:G=
",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__group_gh2,
> >               /* 7 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:u",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H}:=
u",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__group_gh3,
> >               /* 8 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:uG",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H}:=
uG",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__group_gh4,
> >               /* 9 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-mis=
ses/}:S",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu=
/branch-misses/}:S",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__leader_sample1,
> >               /* 0 */
> > @@ -2389,7 +2389,7 @@ static const struct evlist_test test__events_pmu[=
] =3D {
> >               /* 2 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-mis=
ses/}:D",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu=
/branch-misses/}:D",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__pinned_group,
> >               /* 3 */
> > @@ -2407,13 +2407,13 @@ static const struct evlist_test test__events_pm=
u[] =3D {
> >               /* 5 */
> >       },
> >       {
> > -             .name  =3D "cpu/cycles/u",
> > +             .name  =3D "cpu/" HW_CYCLES_STR "/u",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__sym_event_slash,
> >               /* 6 */
> >       },
> >       {
> > -             .name  =3D "cpu/cycles/k",
> > +             .name  =3D "cpu/" HW_CYCLES_STR "/k",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__sym_event_dc,
> >               /* 7 */
> > @@ -2425,19 +2425,19 @@ static const struct evlist_test test__events_pm=
u[] =3D {
> >               /* 8 */
> >       },
> >       {
> > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-mis=
ses/}:e",
> > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,cpu=
/branch-misses/}:e",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__exclusive_group,
> >               /* 9 */
> >       },
> >       {
> > -             .name  =3D "cpu/cycles,name=3Dname/",
> > +             .name  =3D "cpu/" HW_CYCLES_STR ",name=3Dname/",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__term_equal_term,
> >               /* 0 */
> >       },
> >       {
> > -             .name  =3D "cpu/cycles,name=3Dl1d/",
> > +             .name  =3D "cpu/" HW_CYCLES_STR ",name=3Dl1d/",
> >               .valid =3D test__pmu_cpu_valid,
> >               .check =3D test__term_equal_legacy,
> >               /* 1 */
> > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/per=
f-time-to-tsc.c
> > index d4437410c99f..7ebcb1f004b2 100644
> > --- a/tools/perf/tests/perf-time-to-tsc.c
> > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > @@ -101,7 +101,7 @@ static int test__perf_time_to_tsc(struct test_suite=
 *test __maybe_unused, int su
> >
> >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> >
> > -     CHECK__(parse_event(evlist, "cycles:u"));
> > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> >
> >       evlist__config(evlist, &opts, NULL);
> >
> > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/swit=
ch-tracking.c
> > index 5be294014d3b..ad3a87978c0d 100644
> > --- a/tools/perf/tests/switch-tracking.c
> > +++ b/tools/perf/tests/switch-tracking.c
> > @@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist,
> >  static int test__switch_tracking(struct test_suite *test __maybe_unuse=
d, int subtest __maybe_unused)
> >  {
> >       const char *sched_switch =3D "sched:sched_switch";
> > -     const char *cycles =3D "cycles:u";
> > +     const char *cycles =3D HW_CYCLES_STR ":u";
> >       struct switch_tracking switch_tracking =3D { .tids =3D NULL, };
> >       struct record_opts opts =3D {
> >               .mmap_pages          =3D UINT_MAX,
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index e8217efdda53..d7e935faeda0 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -112,7 +112,7 @@ struct evlist *evlist__new_default(void)
> >               char buf[256];
> >               int err;
> >
> > -             snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> > +             snprintf(buf, sizeof(buf), "%s/%s/%s", pmu->name, HW_CYCL=
ES_STR,
> >                        can_profile_kernel ? "P" : "Pu");
> >               err =3D parse_event(evlist, buf);
> >               if (err) {
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index db92cd67bc0f..304676bf32dd 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -20,6 +20,16 @@ struct option;
> >  struct perf_pmu;
> >  struct strbuf;
> >
> > +/*
> > + * The name used for the "cycles" event. A different event name is use=
d on ARM
> > + * as many ARM PMUs define a "cycles" event.
> > + */
> > +#if defined(__aarch64__) || defined(__arm__)
> > +#define HW_CYCLES_STR "cpu-cycles"
> > +#else
> > +#define HW_CYCLES_STR "cycles"
> > +#endif
> > +
> >  const char *event_type(size_t type);
> >
> >  /* Arguments encoded in opt->value. */
> > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_ap=
i_probe.c
> > index 6ecf38314f01..693bb5891bc4 100644
> > --- a/tools/perf/util/perf_api_probe.c
> > +++ b/tools/perf/util/perf_api_probe.c
> > @@ -74,9 +74,9 @@ static bool perf_probe_api(setup_probe_fn_t fn)
> >       if (!ret)
> >               return true;
> >
> > -     pmu =3D perf_pmus__scan_core(/*pmu=3D*/NULL);
> > +     pmu =3D perf_pmus__find_core_pmu();
> >       if (pmu) {
> > -             const char *try[] =3D {"cycles", "instructions", NULL};
> > +             const char *try[] =3D {HW_CYCLES_STR, "instructions", NUL=
L};
> >               char buf[256];
> >               int i =3D 0;
> >
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >

