Return-Path: <bpf+bounces-69102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A69B8CB3D
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56681BC1791
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6218DB0D;
	Sat, 20 Sep 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="po8Gucd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93A1A5BBC
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381433; cv=none; b=nvJDUfKr4w89I0BPSAbv96V2zRM9rACuXubPjOMPV+CWdkh5raMaRuLdVHKqDajJC4/BHlZmD3tEPFbOcn2/ZfqpbnUZHICqehTvxaGrrkk3tULsuOQ6eDuLMLP9E2Ov1HZX5Al19HEeVfDrAVi8aAs9zC+g8Qys60VviSUuhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381433; c=relaxed/simple;
	bh=4Z4NdLjn/pdyw5qoG1HMuM1Hki+qRnDtPw/6DRc1zUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovz9AqfPlusH/Gc6krrpYccR3FoMsq78jxdeWWqMsgeqU7H5mVEZYjJaPi0MEQSN6COndZNuje62UJc5NivcoZu7BUV4Vp+BUKp5LFw0kVhhPyfjtpK0+vcDRnma1RBakvI6BQDJ9fma/SBHDxuDm24plKvTTGxl3O1qtsyQMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=po8Gucd/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2681645b7b6so93215ad.1
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758381430; x=1758986230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cllstR6iKYEW2JdabuHGy1LVqdxd/0bYTF+3H4ZLNj4=;
        b=po8Gucd/ihT+bHaIc37GTERkO92oqOCIuJj5dSmS4O7wxrUdZMzCXwKIU+W822h5I1
         OOoatjsRyRuVKEoyTLwh8B5RwIJdNChc08DT8yw9MFJnqE0aMkBYHo2tyTmP/s4rlQls
         eVYF2vTGyFiCQUC6Y3leszJjk40UZ6A8bdrfNootEepNMBaDqRjL9zR1ZpCKpXgfDkwC
         d5uiuFBsXggv0FyIS8MQMRhbeVrfaEMunRakvmMorlMJ/xq6lzvyKHUr03JxIB8OHZci
         m9iJPqCfz2OXoWoZ/7udHfZjHMj6MbY0JNmjzzIpbAr+skpFx0EfWbOHUeLv0xsIt7D8
         lwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758381430; x=1758986230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cllstR6iKYEW2JdabuHGy1LVqdxd/0bYTF+3H4ZLNj4=;
        b=L7WZlwPzJp/Fs/Uq0s2+gM+X//JQ2L8yirU/r157NRhIpRuY6KZ4LwytD0vhbdXTP1
         PBUMcPISouSyTTLYskadD3U4p0vNKQ1BoDvNzJZyzqa3MO7I2JKx0F7ajWw/K7Ucnpzx
         yJEogYMSqtJN3lEr8RI3DOjvg4VOrsPgsRuXSHUJigarGix7V0qgMcBe6iLPaZcuwdPW
         TqcuDjgK+Sl8OGTxWTqIoZQGuOAu4TnIfTJ/3IB4MlZXPcwnBISghMfPoxTB4ZkWFqTI
         TlbfzU57FqY0rm0CR7P2Ylr+sPfFpDl32cthqyOmEAgO0wHLx9d0wxo5OLKA+RwIO1jw
         UE+g==
X-Forwarded-Encrypted: i=1; AJvYcCXOrLQe1KujxZX26I2Qiiz1HjV5lmlBVJnVdeS71TZWem9p1fzrauNBNud7vzp9SlGozIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtj4qHrDDQq/VO8O7QOierx9SKr2s0oaed2/AywmHIhChtNnYB
	KjxCQZ2nwjTf7SrmFAyzw0HMg806k9ZehJv1Ym6uItk8V0CL+EabUc5y5Eu0op0FETPPoWFQpFT
	n99Pm0DbV+IAUqaOx/P2sN29jt27C7LAueJkkL0mc
X-Gm-Gg: ASbGncv3+gAoR/7uFSpNZWt9YUkj3rqvtEBXI1pfaUimWef3EJUFmSoj/V3+w42t+WO
	cib935vxcGRrV71UrbKsXcue6o7dKXOayElfjPf2EdGwHwjgAFRoqKndNrJXobCRsridEY5NfSj
	nKumPFf+c0ZsQPt2WQW8xOR+6FDlCrEaPyjeYfudHqUdmapsmaq79r3tBKjoQu31r/KRCCkKwrM
	aeVgV+m
X-Google-Smtp-Source: AGHT+IG0QqdiPeLEKVF00WNtKga6M6q5aTPg1Okn+TMI8gJYnPA0oKXqa2QSmQyOgB/3kCb3HPweNIGJifm6RoxmImU=
X-Received: by 2002:a17:902:e846:b0:274:506d:7fea with SMTP id
 d9443c01a7336-274506d8309mr40705ad.5.1758381429253; Sat, 20 Sep 2025 08:17:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com> <20250914181121.1952748-21-irogers@google.com>
 <aMljsNZxTw5ZPfeb@J2N7QTR9R3.cambridge.arm.com> <CAP-5=fUx5oyCBtp2NO-h1mTC+ANt=uTOp9tS3rVN=CQFuXo00g@mail.gmail.com>
 <aMpTzWhifwzVlOoD@z2>
In-Reply-To: <aMpTzWhifwzVlOoD@z2>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Sep 2025 08:16:57 -0700
X-Gm-Features: AS18NWC_cleqJ00Ws_xksGaGaEisTguO_ZlpAi9iJ4p7NyDjhlAjNeIDcAizH6I
Message-ID: <CAP-5=fXPt8gThgRtc1jpoNS4v2Hk_U-xS1JYJir-AUg=d0sW3A@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] perf parse-events: Add HW_CYCLES_STR as default
 cycles event string
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
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

On Tue, Sep 16, 2025 at 11:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Tue, Sep 16, 2025 at 08:49:48AM -0700, Ian Rogers wrote:
> > On Tue, Sep 16, 2025 at 6:18=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > >
> > > On Sun, Sep 14, 2025 at 11:11:20AM -0700, Ian Rogers wrote:
> > > > ARM managed to significantly overload the meaning of the "cycles"
> > > > event in their PMU kernel drivers through sysfs.
> > >
> > > Ian, please stop phrasing this as if Arm have done something wrong he=
re.
> > >
> > > It's true that some system PMU drivers have events named 'cycles'.
> > >
> > > It's not true that this is "overloading" the meaning of 'cycles'; tho=
se
> > > PMU-specific events were never intended to be conflated with the
> > > PERF_TYPE_HARDWARE events which have the same name.
> > >
> > > This was never a problem until the perf tool was changed to handle
> > > events such that it blindly assumed all events were in the same
> > > namespace. I have repeatedly explained that this was a bad idea.
> > >
> > > There is no reason that this should be handled in an ARM-specific way=
;
> > > if you want the bare 'cycles' event (withj no explcit PMU) to mean
> > > PERF_TYPE_HARDWARE:PERF_COUNT_HW_CPU_CYCLES, then *don't* match that
> > > with other PMU types. We cna specifically identify CPU PMUs which
> > > support that with the extended type ID if necessary.
> >
> > Is the "cycles" event meaning uncore events a problem on anything
> > other than ARM, no.
> > Is having more than one event of the same name overloading the name,
> > by my definition yes.
> > Am I implying ARM has done something wrong? Well other than in fixing
> > a problem created by ARM's drivers..
>
> Well.. at least we agreed that there's a problem. :)  Let's move on to
> talking about solutions.  Please see below.
>
> >
> > Firstly, let's not pretend ARM has always elegantly supported the
> > legacy cycles event. When BIG.little came out, as you explained to me,
> > the legacy events would be opened on the first PMU registered with the
> > kernel. You would get legacy events on some fraction of the CPU cores.
> > ARM was reliant on a lot of seemingly correct behavior by having its
> > core PMU drivers appear as uncore ones. I am very much still in the
> > process of trying to clean up the tech debt and mess that falls out
> > from BIG.little and Intel's hybrid.
> >
> > The behavior of legacy events with extended types and wildcarding.
> > This was introduced by Intel. The right moment to complain would have
> > been when Intel added the extended type and wildcarding support in the
> > kernel and perf tool. I wasn't even a reviewer on those patches.
>
> In the perf tools, we want to support extended type and wildcarding
> for usability and maintenance reasons.  Right now, IIUC the problem
> happens when it expands the default 'cycles' event for perf record
> where some events from a PMU that doesn't support sampling.  I think
> Ian changed perf record not to fail by the supported events.

It also disables warning for such events on ARM builds.

> (To me, it'd be great if we can get the info whether the PMU supports
> sampling or not from the kernel.  But that's a different story.)
>
> And perf stat can handle unsupported events already.  Then the problem
> sovled?  Almost?
>
> While 'cycles' happens to be found only in some ARM machines, other
> hardware events can have the same problem in other platforms
> theoretically.  So I don't like to add a specicial rule for cycles and
> ARMs.

Agreed. This is the v4 version of this patch with all the prior
versions not having this patch. The prior versions of this series,
updating the parsing and not using json, also didn't carry a patch
like this. So why this patch?

We have primarily test code that assumes: cycles =3D=3D legacy cycles =3D=
=3D
an event that opens only on core PMUs. As James Clark pointed out that
is failing on ARM as cycles is an event on many other ARM PMUs (imo
this is wrong but nobody is fixing it). We can fix the test code so
that it doesn't count cycles events that appear on uncore PMUs, this
is relatively easy in the C code by scanning every PMU and calling
have_event("cycles"), but harder in shell scripts. Rather than do
this, the patch substitutes cycles for cpu-cycles where the only core
PMUs property holds up. The main test impacted by this is
parse-events, and that has a core PMU is "cpu" assumption I've long
asked people not calling their core PMU "cpu" to fix. For the sake of
sanity I guess I'll fix this up.

> Maybe we should use 'cpu-cycles' instead (as it's the same event), if
> you really don't want to expand it with wildcard.  I'm not sure how
> many people care about name of the default event.  Probably we can try
> cpu-cycles for all platforms and see if someone screams..

So on x86 cpu-cycles is a sysfs event which has a slightly higher
overhead in processing. As you mention, people are likely to scream
when they see default perf stat output has changed. Other than that I
have no problem with this as a fix and will update the patch
accordingly.

> Or, we can keep the original name and update the test code to handle
> multiple events (if that's the only concern).  Maybe you just pick a
> correct one after parsing and before running the tests rather than
> dealing with multilple events.

So let's switch to cpu-cycles in the tests for all architectures. For
things like evlist__new_default and perf_probe_api let's specify core
PMUs with cycles. It means the code and the tests are drifting but
whatever.. I do yet more fixing to work around ARM refusing to do
s/cycles/cpu_cycles/ in their event names. *sigh* even with this all
in place I still don't see getting tags as it seems everyone has a
different opinion in solving this problem and we've drifted into the
weeds of not merging a good patch series and working out the kinks
later. I do appreciate at least getting feedback.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Do ARM do things in their drivers that seem unthought through? Yes,
> > when hex suffixes of physical addresses were added to uncore PMU
> > drivers it was missed that a53 and a57 would also match this wildcard
> > suffix as ARM has unconventional core PMU names and the suffix on
> > those match as hex. We've worked around the issue by saying a hex
> > suffix must be longer than 3 characters but when ARM bumps up its CPU
> > names that will be broken. It seems there is some ambition to reinvent
> > rules when ARM drivers do things and the fallout has all too often had
> > to be fixed and addressed by me, with emails like this for thanks.
> >
> > I'm sorry that you think I'm targeting ARM by fixing the issues your
> > drivers have introduced. It would have been better if ARM's drivers
> > didn't keep introducing issues. I'd repeat my call here that ARM add
> > support for the parse-events test for their PMUs. I don't understand
> > your last paragraph, in the context of the patch series it makes
> > little to no sense as the patch series is very much doing this.
> >
> > Finally, doing things this way was prompted by James Clark's concerns
> > and I posted about this exact patch here:
> > https://lore.kernel.org/lkml/CAP-5=3DfUsZCz8Li1noKMODKXTLYFH9FsDCpXqCUx=
fu1h+s4c6Vw@mail.gmail.com/
> > ie I only added this patch at someone from Linaro's request and
> > received 0 feedback that doing so would be wrong. I don't think it is
> > and recommend this patch series for review.
> >
> > Thanks,
> > Ian
> >
> > > Mark.
> > >
> > > > In the tool use
> > > > "cpu-cycles" on ARM to avoid wildcard matching on different PMUS. T=
his
> > > > is most commonly done in test code.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/builtin-stat.c           |   4 +-
> > > >  tools/perf/tests/code-reading.c     |   4 +-
> > > >  tools/perf/tests/keep-tracking.c    |   2 +-
> > > >  tools/perf/tests/parse-events.c     | 100 ++++++++++++++----------=
----
> > > >  tools/perf/tests/perf-time-to-tsc.c |   2 +-
> > > >  tools/perf/tests/switch-tracking.c  |   2 +-
> > > >  tools/perf/util/evlist.c            |   2 +-
> > > >  tools/perf/util/parse-events.h      |  10 +++
> > > >  tools/perf/util/perf_api_probe.c    |   4 +-
> > > >  9 files changed, 71 insertions(+), 59 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 2c38dd98f6ca..9f522b787ad5 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -1957,7 +1957,7 @@ static int add_default_events(void)
> > > >                               "cpu-migrations,"
> > > >                               "page-faults,"
> > > >                               "instructions,"
> > > > -                             "cycles,"
> > > > +                             HW_CYCLES_STR ","
> > > >                               "stalled-cycles-frontend,"
> > > >                               "stalled-cycles-backend,"
> > > >                               "branches,"
> > > > @@ -2043,7 +2043,7 @@ static int add_default_events(void)
> > > >                        * Make at least one event non-skippable so f=
atal errors are visible.
> > > >                        * 'cycles' always used to be default and non=
-skippable, so use that.
> > > >                        */
> > > > -                     if (strcmp("cycles", evsel__name(evsel)))
> > > > +                     if (strcmp(HW_CYCLES_STR, evsel__name(evsel))=
)
> > > >                               evsel->skippable =3D true;
> > > >               }
> > > >       }
> > > > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/cod=
e-reading.c
> > > > index 9c2091310191..baa44918f555 100644
> > > > --- a/tools/perf/tests/code-reading.c
> > > > +++ b/tools/perf/tests/code-reading.c
> > > > @@ -649,7 +649,9 @@ static int do_test_code_reading(bool try_kcore)
> > > >       struct map *map;
> > > >       bool have_vmlinux, have_kcore;
> > > >       struct dso *dso;
> > > > -     const char *events[] =3D { "cycles", "cycles:u", "cpu-clock",=
 "cpu-clock:u", NULL };
> > > > +     const char *events[] =3D {
> > > > +             HW_CYCLES_STR, HW_CYCLES_STR ":u", "cpu-clock", "cpu-=
clock:u", NULL
> > > > +     };
> > > >       int evidx =3D 0;
> > > >       struct perf_env host_env;
> > > >
> > > > diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/ke=
ep-tracking.c
> > > > index eafb49eb0b56..d54ddb4db47b 100644
> > > > --- a/tools/perf/tests/keep-tracking.c
> > > > +++ b/tools/perf/tests/keep-tracking.c
> > > > @@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite =
*test __maybe_unused, int subte
> > > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > >
> > > >       CHECK__(parse_event(evlist, "dummy:u"));
> > > > -     CHECK__(parse_event(evlist, "cycles:u"));
> > > > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> > > >
> > > >       evlist__config(evlist, &opts, NULL);
> > > >
> > > > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/par=
se-events.c
> > > > index 4e55b0d295bd..7d59648a0591 100644
> > > > --- a/tools/perf/tests/parse-events.c
> > > > +++ b/tools/perf/tests/parse-events.c
> > > > @@ -198,7 +198,7 @@ static int test__checkevent_symbolic_name_confi=
g(struct evlist *evlist)
> > > >       TEST_ASSERT_VAL("wrong number of entries", 0 !=3D evlist->cor=
e.nr_entries);
> > > >
> > > >       perf_evlist__for_each_evsel(&evlist->core, evsel) {
> > > > -             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES=
, "cycles");
> > > > +             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES=
, HW_CYCLES_STR);
> > > >
> > > >               if (ret)
> > > >                       return ret;
> > > > @@ -884,7 +884,7 @@ static int test__group1(struct evlist *evlist)
> > > >
> > > >               /* cycles:upp */
> > > >               evsel =3D evsel__next(evsel);
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
> > > >                       continue;
> > > >               }
> > > >               /* cycles:k */
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1085,7 +1085,7 @@ static int test__group4(struct evlist *evlist=
 __maybe_unused)
> > > >
> > > >               /* cycles:u + p */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1133,7 +1133,7 @@ static int test__group5(struct evlist *evlist=
 __maybe_unused)
> > > >       for (int i =3D 0; i < num_core_entries(); i++) {
> > > >               /* cycles + G */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1168,7 +1168,7 @@ static int test__group5(struct evlist *evlist=
 __maybe_unused)
> > > >       for (int i =3D 0; i < num_core_entries(); i++) {
> > > >               /* cycles:G */
> > > >               evsel =3D leader =3D evsel__next(evsel);
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1202,7 +1202,7 @@ static int test__group5(struct evlist *evlist=
 __maybe_unused)
> > > >       for (int i =3D 0; i < num_core_entries(); i++) {
> > > >               /* cycles */
> > > >               evsel =3D evsel__next(evsel);
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1231,7 +1231,7 @@ static int test__group_gh1(struct evlist *evl=
ist)
> > > >
> > > >               /* cycles + :H group modifier */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1278,7 +1278,7 @@ static int test__group_gh2(struct evlist *evl=
ist)
> > > >
> > > >               /* cycles + :G group modifier */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1325,7 +1325,7 @@ static int test__group_gh3(struct evlist *evl=
ist)
> > > >
> > > >               /* cycles:G + :u group modifier */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1372,7 +1372,7 @@ static int test__group_gh4(struct evlist *evl=
ist)
> > > >
> > > >               /* cycles:G + :uG group modifier */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1417,7 +1417,7 @@ static int test__leader_sample1(struct evlist=
 *evlist)
> > > >
> > > >               /* cycles - sampling group leader */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1540,7 +1540,7 @@ static int test__pinned_group(struct evlist *=
evlist)
> > > >
> > > >               /* cycles - group leader */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1594,7 +1594,7 @@ static int test__exclusive_group(struct evlis=
t *evlist)
> > > >
> > > >               /* cycles - group leader */
> > > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evli=
st) : evsel__next(evsel));
> > > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, "cycles");
> > > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYC=
LES, HW_CYCLES_STR);
> > > >               if (ret)
> > > >                       return ret;
> > > >
> > > > @@ -1759,7 +1759,7 @@ static int test__checkevent_raw_pmu(struct ev=
list *evlist)
> > > >  static int test__sym_event_slash(struct evlist *evlist)
> > > >  {
> > > >       struct evsel *evsel =3D evlist__first(evlist);
> > > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> > > >
> > > >       if (ret)
> > > >               return ret;
> > > > @@ -1771,7 +1771,7 @@ static int test__sym_event_slash(struct evlis=
t *evlist)
> > > >  static int test__sym_event_dc(struct evlist *evlist)
> > > >  {
> > > >       struct evsel *evsel =3D evlist__first(evlist);
> > > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> > > >
> > > >       if (ret)
> > > >               return ret;
> > > > @@ -1783,7 +1783,7 @@ static int test__sym_event_dc(struct evlist *=
evlist)
> > > >  static int test__term_equal_term(struct evlist *evlist)
> > > >  {
> > > >       struct evsel *evsel =3D evlist__first(evlist);
> > > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> > > >
> > > >       if (ret)
> > > >               return ret;
> > > > @@ -1795,7 +1795,7 @@ static int test__term_equal_term(struct evlis=
t *evlist)
> > > >  static int test__term_equal_legacy(struct evlist *evlist)
> > > >  {
> > > >       struct evsel *evsel =3D evlist__first(evlist);
> > > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 "cycles");
> > > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES,=
 HW_CYCLES_STR);
> > > >
> > > >       if (ret)
> > > >               return ret;
> > > > @@ -2006,27 +2006,27 @@ static const struct evlist_test test__event=
s[] =3D {
> > > >               /* 7 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{instructions:k,cycles:upp}",
> > > > +             .name  =3D "{instructions:k," HW_CYCLES_STR ":upp}",
> > > >               .check =3D test__group1,
> > > >               /* 8 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{faults:k,branches}:u,cycles:k",
> > > > +             .name  =3D "{faults:k,branches}:u," HW_CYCLES_STR ":k=
",
> > > >               .check =3D test__group2,
> > > >               /* 9 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "group1{syscalls:sys_enter_openat:H,cycles=
:kppp},group2{cycles,1:3}:G,instructions:u",
> > > > +             .name  =3D "group1{syscalls:sys_enter_openat:H," HW_C=
YCLES_STR ":kppp},group2{" HW_CYCLES_STR ",1:3}:G,instructions:u",
> > > >               .check =3D test__group3,
> > > >               /* 0 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles:u,instructions:kp}:p",
> > > > +             .name  =3D "{" HW_CYCLES_STR ":u,instructions:kp}:p",
> > > >               .check =3D test__group4,
> > > >               /* 1 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles,instructions}:G,{cycles:G,instruc=
tions:G},cycles",
> > > > +             .name  =3D "{" HW_CYCLES_STR ",instructions}:G,{" HW_=
CYCLES_STR ":G,instructions:G}," HW_CYCLES_STR,
> > > >               .check =3D test__group5,
> > > >               /* 2 */
> > > >       },
> > > > @@ -2036,27 +2036,27 @@ static const struct evlist_test test__event=
s[] =3D {
> > > >               /* 3 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles,cache-misses:G}:H",
> > > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses:G}:H",
> > > >               .check =3D test__group_gh1,
> > > >               /* 4 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles,cache-misses:H}:G",
> > > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses:H}:G",
> > > >               .check =3D test__group_gh2,
> > > >               /* 5 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles:G,cache-misses:H}:u",
> > > > +             .name  =3D "{" HW_CYCLES_STR ":G,cache-misses:H}:u",
> > > >               .check =3D test__group_gh3,
> > > >               /* 6 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles:G,cache-misses:H}:uG",
> > > > +             .name  =3D "{" HW_CYCLES_STR ":G,cache-misses:H}:uG",
> > > >               .check =3D test__group_gh4,
> > > >               /* 7 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles,cache-misses,branch-misses}:S",
> > > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-mi=
sses}:S",
> > > >               .check =3D test__leader_sample1,
> > > >               /* 8 */
> > > >       },
> > > > @@ -2071,7 +2071,7 @@ static const struct evlist_test test__events[=
] =3D {
> > > >               /* 0 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles,cache-misses,branch-misses}:D",
> > > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-mi=
sses}:D",
> > > >               .check =3D test__pinned_group,
> > > >               /* 1 */
> > > >       },
> > > > @@ -2109,7 +2109,7 @@ static const struct evlist_test test__events[=
] =3D {
> > > >               /* 6 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "task-clock:P,cycles",
> > > > +             .name  =3D "task-clock:P," HW_CYCLES_STR,
> > > >               .check =3D test__checkevent_precise_max_modifier,
> > > >               /* 7 */
> > > >       },
> > > > @@ -2140,17 +2140,17 @@ static const struct evlist_test test__event=
s[] =3D {
> > > >               /* 2 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cycles/name=3D'COMPLEX_CYCLES_NAME:orig=
=3Dcycles,desc=3Dchip-clock-ticks'/Duk",
> > > > +             .name  =3D HW_CYCLES_STR "/name=3D'COMPLEX_CYCLES_NAM=
E:orig=3Dcycles,desc=3Dchip-clock-ticks'/Duk",
> > > >               .check =3D test__checkevent_complex_name,
> > > >               /* 3 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cycles//u",
> > > > +             .name  =3D HW_CYCLES_STR "//u",
> > > >               .check =3D test__sym_event_slash,
> > > >               /* 4 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cycles:k",
> > > > +             .name  =3D HW_CYCLES_STR ":k",
> > > >               .check =3D test__sym_event_dc,
> > > >               /* 5 */
> > > >       },
> > > > @@ -2160,17 +2160,17 @@ static const struct evlist_test test__event=
s[] =3D {
> > > >               /* 6 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cycles,cache-misses,branch-misses}:e",
> > > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-mi=
sses}:e",
> > > >               .check =3D test__exclusive_group,
> > > >               /* 7 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cycles/name=3Dname/",
> > > > +             .name  =3D HW_CYCLES_STR "/name=3Dname/",
> > > >               .check =3D test__term_equal_term,
> > > >               /* 8 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cycles/name=3Dl1d/",
> > > > +             .name  =3D HW_CYCLES_STR "/name=3Dl1d/",
> > > >               .check =3D test__term_equal_legacy,
> > > >               /* 9 */
> > > >       },
> > > > @@ -2311,7 +2311,7 @@ static const struct evlist_test test__events_=
pmu[] =3D {
> > > >               /* 9 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cpu/cycles,period=3D100000,config2/",
> > > > +             .name  =3D "cpu/" HW_CYCLES_STR ",period=3D100000,con=
fig2/",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__checkevent_symbolic_name_config,
> > > >               /* 0 */
> > > > @@ -2335,43 +2335,43 @@ static const struct evlist_test test__event=
s_pmu[] =3D {
> > > >               /* 3 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/instructions/k,cpu/cycles/upp}",
> > > > +             .name  =3D "{cpu/instructions/k,cpu/" HW_CYCLES_STR "=
/upp}",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__group1,
> > > >               /* 4 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/u,cpu/instructions/kp}:p",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/u,cpu/instructions=
/kp}:p",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__group4,
> > > >               /* 5 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/G}:H",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/=
G}:H",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__group_gh1,
> > > >               /* 6 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/H}:G",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/=
H}:G",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__group_gh2,
> > > >               /* 7 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:u",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses=
/H}:u",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__group_gh3,
> > > >               /* 8 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:uG",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses=
/H}:uG",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__group_gh4,
> > > >               /* 9 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch=
-misses/}:S",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/=
,cpu/branch-misses/}:S",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__leader_sample1,
> > > >               /* 0 */
> > > > @@ -2389,7 +2389,7 @@ static const struct evlist_test test__events_=
pmu[] =3D {
> > > >               /* 2 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch=
-misses/}:D",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/=
,cpu/branch-misses/}:D",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__pinned_group,
> > > >               /* 3 */
> > > > @@ -2407,13 +2407,13 @@ static const struct evlist_test test__event=
s_pmu[] =3D {
> > > >               /* 5 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cpu/cycles/u",
> > > > +             .name  =3D "cpu/" HW_CYCLES_STR "/u",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__sym_event_slash,
> > > >               /* 6 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cpu/cycles/k",
> > > > +             .name  =3D "cpu/" HW_CYCLES_STR "/k",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__sym_event_dc,
> > > >               /* 7 */
> > > > @@ -2425,19 +2425,19 @@ static const struct evlist_test test__event=
s_pmu[] =3D {
> > > >               /* 8 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch=
-misses/}:e",
> > > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/=
,cpu/branch-misses/}:e",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__exclusive_group,
> > > >               /* 9 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cpu/cycles,name=3Dname/",
> > > > +             .name  =3D "cpu/" HW_CYCLES_STR ",name=3Dname/",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__term_equal_term,
> > > >               /* 0 */
> > > >       },
> > > >       {
> > > > -             .name  =3D "cpu/cycles,name=3Dl1d/",
> > > > +             .name  =3D "cpu/" HW_CYCLES_STR ",name=3Dl1d/",
> > > >               .valid =3D test__pmu_cpu_valid,
> > > >               .check =3D test__term_equal_legacy,
> > > >               /* 1 */
> > > > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests=
/perf-time-to-tsc.c
> > > > index d4437410c99f..7ebcb1f004b2 100644
> > > > --- a/tools/perf/tests/perf-time-to-tsc.c
> > > > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > > > @@ -101,7 +101,7 @@ static int test__perf_time_to_tsc(struct test_s=
uite *test __maybe_unused, int su
> > > >
> > > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > >
> > > > -     CHECK__(parse_event(evlist, "cycles:u"));
> > > > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> > > >
> > > >       evlist__config(evlist, &opts, NULL);
> > > >
> > > > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/=
switch-tracking.c
> > > > index 5be294014d3b..ad3a87978c0d 100644
> > > > --- a/tools/perf/tests/switch-tracking.c
> > > > +++ b/tools/perf/tests/switch-tracking.c
> > > > @@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist=
,
> > > >  static int test__switch_tracking(struct test_suite *test __maybe_u=
nused, int subtest __maybe_unused)
> > > >  {
> > > >       const char *sched_switch =3D "sched:sched_switch";
> > > > -     const char *cycles =3D "cycles:u";
> > > > +     const char *cycles =3D HW_CYCLES_STR ":u";
> > > >       struct switch_tracking switch_tracking =3D { .tids =3D NULL, =
};
> > > >       struct record_opts opts =3D {
> > > >               .mmap_pages          =3D UINT_MAX,
> > > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > > index e8217efdda53..d7e935faeda0 100644
> > > > --- a/tools/perf/util/evlist.c
> > > > +++ b/tools/perf/util/evlist.c
> > > > @@ -112,7 +112,7 @@ struct evlist *evlist__new_default(void)
> > > >               char buf[256];
> > > >               int err;
> > > >
> > > > -             snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> > > > +             snprintf(buf, sizeof(buf), "%s/%s/%s", pmu->name, HW_=
CYCLES_STR,
> > > >                        can_profile_kernel ? "P" : "Pu");
> > > >               err =3D parse_event(evlist, buf);
> > > >               if (err) {
> > > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse=
-events.h
> > > > index db92cd67bc0f..304676bf32dd 100644
> > > > --- a/tools/perf/util/parse-events.h
> > > > +++ b/tools/perf/util/parse-events.h
> > > > @@ -20,6 +20,16 @@ struct option;
> > > >  struct perf_pmu;
> > > >  struct strbuf;
> > > >
> > > > +/*
> > > > + * The name used for the "cycles" event. A different event name is=
 used on ARM
> > > > + * as many ARM PMUs define a "cycles" event.
> > > > + */
> > > > +#if defined(__aarch64__) || defined(__arm__)
> > > > +#define HW_CYCLES_STR "cpu-cycles"
> > > > +#else
> > > > +#define HW_CYCLES_STR "cycles"
> > > > +#endif
> > > > +
> > > >  const char *event_type(size_t type);
> > > >
> > > >  /* Arguments encoded in opt->value. */
> > > > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/per=
f_api_probe.c
> > > > index 6ecf38314f01..693bb5891bc4 100644
> > > > --- a/tools/perf/util/perf_api_probe.c
> > > > +++ b/tools/perf/util/perf_api_probe.c
> > > > @@ -74,9 +74,9 @@ static bool perf_probe_api(setup_probe_fn_t fn)
> > > >       if (!ret)
> > > >               return true;
> > > >
> > > > -     pmu =3D perf_pmus__scan_core(/*pmu=3D*/NULL);
> > > > +     pmu =3D perf_pmus__find_core_pmu();
> > > >       if (pmu) {
> > > > -             const char *try[] =3D {"cycles", "instructions", NULL=
};
> > > > +             const char *try[] =3D {HW_CYCLES_STR, "instructions",=
 NULL};
> > > >               char buf[256];
> > > >               int i =3D 0;
> > > >
> > > > --
> > > > 2.51.0.384.g4c02a37b29-goog
> > > >

