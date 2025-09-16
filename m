Return-Path: <bpf+bounces-68538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F6B59FD8
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7042C580DBF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9627E1B1;
	Tue, 16 Sep 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo8soUkv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65084276022
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045418; cv=none; b=HTQZzRjG3DVrE7hC77ktsqCbom2MbwtRwU9QKz25kPlf7fwUoUsaaxXpbys3LEL7WKPe6CE4xwOPRuSQSxSQrx+fJPBfzv3l3EPfWY1XWS8szFiF+Chfqjq3EjrdvowHjciH670U+IB+t43n9fqsMk+t9S7UD7DH7gaKBZLcR+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045418; c=relaxed/simple;
	bh=cDozfFwW2Mxhy4ok+9q5Hu+CCkTPCzsESjRIPQbL5Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/lf8nXIn/1lhGiforb7FxPimFZDD8LCAiet1ceCPv/QqG1paccD+C31WET/VeB6+FjOBUFBlCY4/CeDb4zXd1Z807WzNmz77izZ3zBVDFYuquRwSheYBHNQ4lgwvHdJue+wfGM99HSW9ZekcPcz9KAAKT5npD7l5rrk8HWo8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo8soUkv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2637b6e9149so20075ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758045416; x=1758650216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JULZbZSuy+d6SrJ9VTUs3Qg/BN69AXtJydIQcSLLLE0=;
        b=Oo8soUkvvoqoTHjyCsNywXXbvbpcKdpJbT4SPHsGmv/c6pD/mYUwC7hrjfwBPVxd0z
         8p9t6boVjKrzSSfVWFVFInl2K/ovWuafBogwth0AUmnRnwW/92dKer87OraHUb6/Kf7r
         64k5/bhEkZT2A3N/RvbGVzwXevgZjH7mBNWGhtSuipMRNEolAqqvWTs1ThSU6zZ37IZc
         s5226Y3yH5eYuNrqos0zEp+je50Efp0ugMfHy5m4nNj4Q2so2zDia/sVALikmRg6EqA9
         cSMOxIhv+6f/8YmC1FVYL3g5G5bKq9tmV86tgKIzMyxsOyxxQIqtSv9WhzA56lIbiSi/
         zm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045416; x=1758650216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JULZbZSuy+d6SrJ9VTUs3Qg/BN69AXtJydIQcSLLLE0=;
        b=dDvc+4MK4AFSneJPoWVWZIVm/S61gbVwq9ZmejgLn0LWM7EhhNeQPuCxHhLyloCpv9
         4pbktFAgxbtqbWBtJxr2YkA4cSw/vngE9tacn4eWKAW4thGBoFnnRf9YjPMaycC/8tO3
         I6XEC0h43zRUdyuACNSps4xiULH54uq2zidDmCR3PIXDCf46ZIt7tXivkwOETdi453iC
         f4BZmso+GlP3SOD7cwWLl4+e6ZSRt7HeGqiGjTT571UZ65/W2rsR3WEp0TW6DnDVKPe8
         CFtVIHj1iQMrklSw37y4MHxp4WZBKG06O1rgCMKwuBpUUhSIvq8qb5v0gIdTAikq1xJn
         Ei7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMeohseI4UIVW4YxDTDdn/13+xuHwUTEBokCCEFP01b5cPiGBv3L+cgZGvAL4Ntfk1iJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64f/c3qri5hjOzkzBflVBvja2Ffp9+kbx6uQ1roSjCuYT+7Xn
	piuXk2NQIsxluhl9tMY4a79SeNuRCgL9MNMQphBPgEwHCICgOMUBCil+IiP2Juc8OMGEyLuPj32
	qYPOX9GZo3QTldNTolE8tv4RPA7ygycUXRDYOVVub
X-Gm-Gg: ASbGncsyYM39NDfLTpaJh9w5k7g3DWVZpv7YjJQ3erMgf19CjbS8brFFFZ6Fs2a6cye
	aSWyh/Qq8buCkUfrCFsyhoikaAeX7QcQ76vikTo4tYF7iTQYkW3QpSkGd4a9BrweTqynvyPjxl4
	B49LQSBozoDlPywLM0BfrMOenpy68LCTju4L4oMAVxEtsN+QGRZN0gmp9g1IPnXFQPzMe27rstR
	FFFQiCj2IwEviVq8KKa4mFT2eBBtwHCml+c+3aVL2Y1
X-Google-Smtp-Source: AGHT+IGQBYa1iWzAf2RA/7yMmjr8biiADm07fpwcaYqZfTZXbtlLY/jjJwGUjYyoV7+Qjuzv/JhRIGg+GyzBQzgbBiU=
X-Received: by 2002:a17:902:db09:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-268010a0487mr370405ad.1.1758045414875; Tue, 16 Sep 2025
 10:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com> <20250914181121.1952748-21-irogers@google.com>
 <aMljsNZxTw5ZPfeb@J2N7QTR9R3.cambridge.arm.com> <CAP-5=fUx5oyCBtp2NO-h1mTC+ANt=uTOp9tS3rVN=CQFuXo00g@mail.gmail.com>
In-Reply-To: <CAP-5=fUx5oyCBtp2NO-h1mTC+ANt=uTOp9tS3rVN=CQFuXo00g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 10:56:43 -0700
X-Gm-Features: AS18NWCcaAOx1ZC4pD8SFApEfUNpw7DKFVaN-cpmhRizsPZ9P5y9DuABKP36mcM
Message-ID: <CAP-5=fW_KuGhMhe+81mu8KBKj=TaUV_B428q_nhQEmTqtiwGvg@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 8:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Sep 16, 2025 at 6:18=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Sun, Sep 14, 2025 at 11:11:20AM -0700, Ian Rogers wrote:
> > > ARM managed to significantly overload the meaning of the "cycles"
> > > event in their PMU kernel drivers through sysfs.
> >
> > Ian, please stop phrasing this as if Arm have done something wrong here=
.
> >
> > It's true that some system PMU drivers have events named 'cycles'.
> >
> > It's not true that this is "overloading" the meaning of 'cycles'; those
> > PMU-specific events were never intended to be conflated with the
> > PERF_TYPE_HARDWARE events which have the same name.
> >
> > This was never a problem until the perf tool was changed to handle
> > events such that it blindly assumed all events were in the same
> > namespace. I have repeatedly explained that this was a bad idea.
> >
> > There is no reason that this should be handled in an ARM-specific way;
> > if you want the bare 'cycles' event (withj no explcit PMU) to mean
> > PERF_TYPE_HARDWARE:PERF_COUNT_HW_CPU_CYCLES, then *don't* match that
> > with other PMU types. We cna specifically identify CPU PMUs which
> > support that with the extended type ID if necessary.
>
> Is the "cycles" event meaning uncore events a problem on anything
> other than ARM, no.
> Is having more than one event of the same name overloading the name,
> by my definition yes.
> Am I implying ARM has done something wrong? Well other than in fixing
> a problem created by ARM's drivers..
>
> Firstly, let's not pretend ARM has always elegantly supported the
> legacy cycles event. When BIG.little came out, as you explained to me,
> the legacy events would be opened on the first PMU registered with the
> kernel. You would get legacy events on some fraction of the CPU cores.
> ARM was reliant on a lot of seemingly correct behavior by having its
> core PMU drivers appear as uncore ones. I am very much still in the
> process of trying to clean up the tech debt and mess that falls out
> from BIG.little and Intel's hybrid.
>
> The behavior of legacy events with extended types and wildcarding.
> This was introduced by Intel. The right moment to complain would have
> been when Intel added the extended type and wildcarding support in the
> kernel and perf tool. I wasn't even a reviewer on those patches.
>
> Do ARM do things in their drivers that seem unthought through? Yes,
> when hex suffixes of physical addresses were added to uncore PMU
> drivers it was missed that a53 and a57 would also match this wildcard
> suffix as ARM has unconventional core PMU names and the suffix on
> those match as hex. We've worked around the issue by saying a hex
> suffix must be longer than 3 characters but when ARM bumps up its CPU
> names that will be broken. It seems there is some ambition to reinvent
> rules when ARM drivers do things and the fallout has all too often had
> to be fixed and addressed by me, with emails like this for thanks.

Oh wow, this could be broken sooner than expected with Cortex-A720AE:
https://lore.kernel.org/linux-perf-users/87plbri0k3.wl-kuninori.morimoto.gx=
@renesas.com/
*sigh* I'm guessing it is too late for the AE suffix to contain
non-hex characters.

Thanks,
Ian



> I'm sorry that you think I'm targeting ARM by fixing the issues your
> drivers have introduced. It would have been better if ARM's drivers
> didn't keep introducing issues. I'd repeat my call here that ARM add
> support for the parse-events test for their PMUs. I don't understand
> your last paragraph, in the context of the patch series it makes
> little to no sense as the patch series is very much doing this.
>
> Finally, doing things this way was prompted by James Clark's concerns
> and I posted about this exact patch here:
> https://lore.kernel.org/lkml/CAP-5=3DfUsZCz8Li1noKMODKXTLYFH9FsDCpXqCUxfu=
1h+s4c6Vw@mail.gmail.com/
> ie I only added this patch at someone from Linaro's request and
> received 0 feedback that doing so would be wrong. I don't think it is
> and recommend this patch series for review.
>
> Thanks,
> Ian
>
> > Mark.
> >
> > > In the tool use
> > > "cpu-cycles" on ARM to avoid wildcard matching on different PMUS. Thi=
s
> > > is most commonly done in test code.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-stat.c           |   4 +-
> > >  tools/perf/tests/code-reading.c     |   4 +-
> > >  tools/perf/tests/keep-tracking.c    |   2 +-
> > >  tools/perf/tests/parse-events.c     | 100 ++++++++++++++------------=
--
> > >  tools/perf/tests/perf-time-to-tsc.c |   2 +-
> > >  tools/perf/tests/switch-tracking.c  |   2 +-
> > >  tools/perf/util/evlist.c            |   2 +-
> > >  tools/perf/util/parse-events.h      |  10 +++
> > >  tools/perf/util/perf_api_probe.c    |   4 +-
> > >  9 files changed, 71 insertions(+), 59 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 2c38dd98f6ca..9f522b787ad5 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -1957,7 +1957,7 @@ static int add_default_events(void)
> > >                               "cpu-migrations,"
> > >                               "page-faults,"
> > >                               "instructions,"
> > > -                             "cycles,"
> > > +                             HW_CYCLES_STR ","
> > >                               "stalled-cycles-frontend,"
> > >                               "stalled-cycles-backend,"
> > >                               "branches,"
> > > @@ -2043,7 +2043,7 @@ static int add_default_events(void)
> > >                        * Make at least one event non-skippable so fat=
al errors are visible.
> > >                        * 'cycles' always used to be default and non-s=
kippable, so use that.
> > >                        */
> > > -                     if (strcmp("cycles", evsel__name(evsel)))
> > > +                     if (strcmp(HW_CYCLES_STR, evsel__name(evsel)))
> > >                               evsel->skippable =3D true;
> > >               }
> > >       }
> > > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-=
reading.c
> > > index 9c2091310191..baa44918f555 100644
> > > --- a/tools/perf/tests/code-reading.c
> > > +++ b/tools/perf/tests/code-reading.c
> > > @@ -649,7 +649,9 @@ static int do_test_code_reading(bool try_kcore)
> > >       struct map *map;
> > >       bool have_vmlinux, have_kcore;
> > >       struct dso *dso;
> > > -     const char *events[] =3D { "cycles", "cycles:u", "cpu-clock", "=
cpu-clock:u", NULL };
> > > +     const char *events[] =3D {
> > > +             HW_CYCLES_STR, HW_CYCLES_STR ":u", "cpu-clock", "cpu-cl=
ock:u", NULL
> > > +     };
> > >       int evidx =3D 0;
> > >       struct perf_env host_env;
> > >
> > > diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep=
-tracking.c
> > > index eafb49eb0b56..d54ddb4db47b 100644
> > > --- a/tools/perf/tests/keep-tracking.c
> > > +++ b/tools/perf/tests/keep-tracking.c
> > > @@ -90,7 +90,7 @@ static int test__keep_tracking(struct test_suite *t=
est __maybe_unused, int subte
> > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > >
> > >       CHECK__(parse_event(evlist, "dummy:u"));
> > > -     CHECK__(parse_event(evlist, "cycles:u"));
> > > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> > >
> > >       evlist__config(evlist, &opts, NULL);
> > >
> > > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse=
-events.c
> > > index 4e55b0d295bd..7d59648a0591 100644
> > > --- a/tools/perf/tests/parse-events.c
> > > +++ b/tools/perf/tests/parse-events.c
> > > @@ -198,7 +198,7 @@ static int test__checkevent_symbolic_name_config(=
struct evlist *evlist)
> > >       TEST_ASSERT_VAL("wrong number of entries", 0 !=3D evlist->core.=
nr_entries);
> > >
> > >       perf_evlist__for_each_evsel(&evlist->core, evsel) {
> > > -             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, =
"cycles");
> > > +             int ret =3D assert_hw(evsel, PERF_COUNT_HW_CPU_CYCLES, =
HW_CYCLES_STR);
> > >
> > >               if (ret)
> > >                       return ret;
> > > @@ -884,7 +884,7 @@ static int test__group1(struct evlist *evlist)
> > >
> > >               /* cycles:upp */
> > >               evsel =3D evsel__next(evsel);
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
> > >                       continue;
> > >               }
> > >               /* cycles:k */
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1085,7 +1085,7 @@ static int test__group4(struct evlist *evlist _=
_maybe_unused)
> > >
> > >               /* cycles:u + p */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1133,7 +1133,7 @@ static int test__group5(struct evlist *evlist _=
_maybe_unused)
> > >       for (int i =3D 0; i < num_core_entries(); i++) {
> > >               /* cycles + G */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1168,7 +1168,7 @@ static int test__group5(struct evlist *evlist _=
_maybe_unused)
> > >       for (int i =3D 0; i < num_core_entries(); i++) {
> > >               /* cycles:G */
> > >               evsel =3D leader =3D evsel__next(evsel);
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1202,7 +1202,7 @@ static int test__group5(struct evlist *evlist _=
_maybe_unused)
> > >       for (int i =3D 0; i < num_core_entries(); i++) {
> > >               /* cycles */
> > >               evsel =3D evsel__next(evsel);
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1231,7 +1231,7 @@ static int test__group_gh1(struct evlist *evlis=
t)
> > >
> > >               /* cycles + :H group modifier */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1278,7 +1278,7 @@ static int test__group_gh2(struct evlist *evlis=
t)
> > >
> > >               /* cycles + :G group modifier */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1325,7 +1325,7 @@ static int test__group_gh3(struct evlist *evlis=
t)
> > >
> > >               /* cycles:G + :u group modifier */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1372,7 +1372,7 @@ static int test__group_gh4(struct evlist *evlis=
t)
> > >
> > >               /* cycles:G + :uG group modifier */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1417,7 +1417,7 @@ static int test__leader_sample1(struct evlist *=
evlist)
> > >
> > >               /* cycles - sampling group leader */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1540,7 +1540,7 @@ static int test__pinned_group(struct evlist *ev=
list)
> > >
> > >               /* cycles - group leader */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1594,7 +1594,7 @@ static int test__exclusive_group(struct evlist =
*evlist)
> > >
> > >               /* cycles - group leader */
> > >               evsel =3D leader =3D (i =3D=3D 0 ? evlist__first(evlist=
) : evsel__next(evsel));
> > > -             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, "cycles");
> > > +             ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLE=
S, HW_CYCLES_STR);
> > >               if (ret)
> > >                       return ret;
> > >
> > > @@ -1759,7 +1759,7 @@ static int test__checkevent_raw_pmu(struct evli=
st *evlist)
> > >  static int test__sym_event_slash(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel =3D evlist__first(evlist);
> > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "=
cycles");
> > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, H=
W_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -1771,7 +1771,7 @@ static int test__sym_event_slash(struct evlist =
*evlist)
> > >  static int test__sym_event_dc(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel =3D evlist__first(evlist);
> > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "=
cycles");
> > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, H=
W_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -1783,7 +1783,7 @@ static int test__sym_event_dc(struct evlist *ev=
list)
> > >  static int test__term_equal_term(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel =3D evlist__first(evlist);
> > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "=
cycles");
> > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, H=
W_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -1795,7 +1795,7 @@ static int test__term_equal_term(struct evlist =
*evlist)
> > >  static int test__term_equal_legacy(struct evlist *evlist)
> > >  {
> > >       struct evsel *evsel =3D evlist__first(evlist);
> > > -     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, "=
cycles");
> > > +     int ret =3D assert_hw(&evsel->core, PERF_COUNT_HW_CPU_CYCLES, H=
W_CYCLES_STR);
> > >
> > >       if (ret)
> > >               return ret;
> > > @@ -2006,27 +2006,27 @@ static const struct evlist_test test__events[=
] =3D {
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  =3D "{instructions:k,cycles:upp}",
> > > +             .name  =3D "{instructions:k," HW_CYCLES_STR ":upp}",
> > >               .check =3D test__group1,
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  =3D "{faults:k,branches}:u,cycles:k",
> > > +             .name  =3D "{faults:k,branches}:u," HW_CYCLES_STR ":k",
> > >               .check =3D test__group2,
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  =3D "group1{syscalls:sys_enter_openat:H,cycles:k=
ppp},group2{cycles,1:3}:G,instructions:u",
> > > +             .name  =3D "group1{syscalls:sys_enter_openat:H," HW_CYC=
LES_STR ":kppp},group2{" HW_CYCLES_STR ",1:3}:G,instructions:u",
> > >               .check =3D test__group3,
> > >               /* 0 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles:u,instructions:kp}:p",
> > > +             .name  =3D "{" HW_CYCLES_STR ":u,instructions:kp}:p",
> > >               .check =3D test__group4,
> > >               /* 1 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles,instructions}:G,{cycles:G,instructi=
ons:G},cycles",
> > > +             .name  =3D "{" HW_CYCLES_STR ",instructions}:G,{" HW_CY=
CLES_STR ":G,instructions:G}," HW_CYCLES_STR,
> > >               .check =3D test__group5,
> > >               /* 2 */
> > >       },
> > > @@ -2036,27 +2036,27 @@ static const struct evlist_test test__events[=
] =3D {
> > >               /* 3 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles,cache-misses:G}:H",
> > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses:G}:H",
> > >               .check =3D test__group_gh1,
> > >               /* 4 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles,cache-misses:H}:G",
> > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses:H}:G",
> > >               .check =3D test__group_gh2,
> > >               /* 5 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles:G,cache-misses:H}:u",
> > > +             .name  =3D "{" HW_CYCLES_STR ":G,cache-misses:H}:u",
> > >               .check =3D test__group_gh3,
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles:G,cache-misses:H}:uG",
> > > +             .name  =3D "{" HW_CYCLES_STR ":G,cache-misses:H}:uG",
> > >               .check =3D test__group_gh4,
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles,cache-misses,branch-misses}:S",
> > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-miss=
es}:S",
> > >               .check =3D test__leader_sample1,
> > >               /* 8 */
> > >       },
> > > @@ -2071,7 +2071,7 @@ static const struct evlist_test test__events[] =
=3D {
> > >               /* 0 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles,cache-misses,branch-misses}:D",
> > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-miss=
es}:D",
> > >               .check =3D test__pinned_group,
> > >               /* 1 */
> > >       },
> > > @@ -2109,7 +2109,7 @@ static const struct evlist_test test__events[] =
=3D {
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  =3D "task-clock:P,cycles",
> > > +             .name  =3D "task-clock:P," HW_CYCLES_STR,
> > >               .check =3D test__checkevent_precise_max_modifier,
> > >               /* 7 */
> > >       },
> > > @@ -2140,17 +2140,17 @@ static const struct evlist_test test__events[=
] =3D {
> > >               /* 2 */
> > >       },
> > >       {
> > > -             .name  =3D "cycles/name=3D'COMPLEX_CYCLES_NAME:orig=3Dc=
ycles,desc=3Dchip-clock-ticks'/Duk",
> > > +             .name  =3D HW_CYCLES_STR "/name=3D'COMPLEX_CYCLES_NAME:=
orig=3Dcycles,desc=3Dchip-clock-ticks'/Duk",
> > >               .check =3D test__checkevent_complex_name,
> > >               /* 3 */
> > >       },
> > >       {
> > > -             .name  =3D "cycles//u",
> > > +             .name  =3D HW_CYCLES_STR "//u",
> > >               .check =3D test__sym_event_slash,
> > >               /* 4 */
> > >       },
> > >       {
> > > -             .name  =3D "cycles:k",
> > > +             .name  =3D HW_CYCLES_STR ":k",
> > >               .check =3D test__sym_event_dc,
> > >               /* 5 */
> > >       },
> > > @@ -2160,17 +2160,17 @@ static const struct evlist_test test__events[=
] =3D {
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  =3D "{cycles,cache-misses,branch-misses}:e",
> > > +             .name  =3D "{" HW_CYCLES_STR ",cache-misses,branch-miss=
es}:e",
> > >               .check =3D test__exclusive_group,
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  =3D "cycles/name=3Dname/",
> > > +             .name  =3D HW_CYCLES_STR "/name=3Dname/",
> > >               .check =3D test__term_equal_term,
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  =3D "cycles/name=3Dl1d/",
> > > +             .name  =3D HW_CYCLES_STR "/name=3Dl1d/",
> > >               .check =3D test__term_equal_legacy,
> > >               /* 9 */
> > >       },
> > > @@ -2311,7 +2311,7 @@ static const struct evlist_test test__events_pm=
u[] =3D {
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  =3D "cpu/cycles,period=3D100000,config2/",
> > > +             .name  =3D "cpu/" HW_CYCLES_STR ",period=3D100000,confi=
g2/",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__checkevent_symbolic_name_config,
> > >               /* 0 */
> > > @@ -2335,43 +2335,43 @@ static const struct evlist_test test__events_=
pmu[] =3D {
> > >               /* 3 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/instructions/k,cpu/cycles/upp}",
> > > +             .name  =3D "{cpu/instructions/k,cpu/" HW_CYCLES_STR "/u=
pp}",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__group1,
> > >               /* 4 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/u,cpu/instructions/kp}:p",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/u,cpu/instructions/k=
p}:p",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__group4,
> > >               /* 5 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/G}:H",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/G}=
:H",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__group_gh1,
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/H}:G",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/H}=
:G",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__group_gh2,
> > >               /* 7 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:u",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H=
}:u",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__group_gh3,
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/G,cpu/cache-misses/H}:uG",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/G,cpu/cache-misses/H=
}:uG",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__group_gh4,
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-m=
isses/}:S",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,c=
pu/branch-misses/}:S",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__leader_sample1,
> > >               /* 0 */
> > > @@ -2389,7 +2389,7 @@ static const struct evlist_test test__events_pm=
u[] =3D {
> > >               /* 2 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-m=
isses/}:D",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,c=
pu/branch-misses/}:D",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__pinned_group,
> > >               /* 3 */
> > > @@ -2407,13 +2407,13 @@ static const struct evlist_test test__events_=
pmu[] =3D {
> > >               /* 5 */
> > >       },
> > >       {
> > > -             .name  =3D "cpu/cycles/u",
> > > +             .name  =3D "cpu/" HW_CYCLES_STR "/u",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__sym_event_slash,
> > >               /* 6 */
> > >       },
> > >       {
> > > -             .name  =3D "cpu/cycles/k",
> > > +             .name  =3D "cpu/" HW_CYCLES_STR "/k",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__sym_event_dc,
> > >               /* 7 */
> > > @@ -2425,19 +2425,19 @@ static const struct evlist_test test__events_=
pmu[] =3D {
> > >               /* 8 */
> > >       },
> > >       {
> > > -             .name  =3D "{cpu/cycles/,cpu/cache-misses/,cpu/branch-m=
isses/}:e",
> > > +             .name  =3D "{cpu/" HW_CYCLES_STR "/,cpu/cache-misses/,c=
pu/branch-misses/}:e",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__exclusive_group,
> > >               /* 9 */
> > >       },
> > >       {
> > > -             .name  =3D "cpu/cycles,name=3Dname/",
> > > +             .name  =3D "cpu/" HW_CYCLES_STR ",name=3Dname/",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__term_equal_term,
> > >               /* 0 */
> > >       },
> > >       {
> > > -             .name  =3D "cpu/cycles,name=3Dl1d/",
> > > +             .name  =3D "cpu/" HW_CYCLES_STR ",name=3Dl1d/",
> > >               .valid =3D test__pmu_cpu_valid,
> > >               .check =3D test__term_equal_legacy,
> > >               /* 1 */
> > > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/p=
erf-time-to-tsc.c
> > > index d4437410c99f..7ebcb1f004b2 100644
> > > --- a/tools/perf/tests/perf-time-to-tsc.c
> > > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > > @@ -101,7 +101,7 @@ static int test__perf_time_to_tsc(struct test_sui=
te *test __maybe_unused, int su
> > >
> > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > >
> > > -     CHECK__(parse_event(evlist, "cycles:u"));
> > > +     CHECK__(parse_event(evlist, HW_CYCLES_STR ":u"));
> > >
> > >       evlist__config(evlist, &opts, NULL);
> > >
> > > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/sw=
itch-tracking.c
> > > index 5be294014d3b..ad3a87978c0d 100644
> > > --- a/tools/perf/tests/switch-tracking.c
> > > +++ b/tools/perf/tests/switch-tracking.c
> > > @@ -332,7 +332,7 @@ static int process_events(struct evlist *evlist,
> > >  static int test__switch_tracking(struct test_suite *test __maybe_unu=
sed, int subtest __maybe_unused)
> > >  {
> > >       const char *sched_switch =3D "sched:sched_switch";
> > > -     const char *cycles =3D "cycles:u";
> > > +     const char *cycles =3D HW_CYCLES_STR ":u";
> > >       struct switch_tracking switch_tracking =3D { .tids =3D NULL, };
> > >       struct record_opts opts =3D {
> > >               .mmap_pages          =3D UINT_MAX,
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index e8217efdda53..d7e935faeda0 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -112,7 +112,7 @@ struct evlist *evlist__new_default(void)
> > >               char buf[256];
> > >               int err;
> > >
> > > -             snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> > > +             snprintf(buf, sizeof(buf), "%s/%s/%s", pmu->name, HW_CY=
CLES_STR,
> > >                        can_profile_kernel ? "P" : "Pu");
> > >               err =3D parse_event(evlist, buf);
> > >               if (err) {
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-e=
vents.h
> > > index db92cd67bc0f..304676bf32dd 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -20,6 +20,16 @@ struct option;
> > >  struct perf_pmu;
> > >  struct strbuf;
> > >
> > > +/*
> > > + * The name used for the "cycles" event. A different event name is u=
sed on ARM
> > > + * as many ARM PMUs define a "cycles" event.
> > > + */
> > > +#if defined(__aarch64__) || defined(__arm__)
> > > +#define HW_CYCLES_STR "cpu-cycles"
> > > +#else
> > > +#define HW_CYCLES_STR "cycles"
> > > +#endif
> > > +
> > >  const char *event_type(size_t type);
> > >
> > >  /* Arguments encoded in opt->value. */
> > > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_=
api_probe.c
> > > index 6ecf38314f01..693bb5891bc4 100644
> > > --- a/tools/perf/util/perf_api_probe.c
> > > +++ b/tools/perf/util/perf_api_probe.c
> > > @@ -74,9 +74,9 @@ static bool perf_probe_api(setup_probe_fn_t fn)
> > >       if (!ret)
> > >               return true;
> > >
> > > -     pmu =3D perf_pmus__scan_core(/*pmu=3D*/NULL);
> > > +     pmu =3D perf_pmus__find_core_pmu();
> > >       if (pmu) {
> > > -             const char *try[] =3D {"cycles", "instructions", NULL};
> > > +             const char *try[] =3D {HW_CYCLES_STR, "instructions", N=
ULL};
> > >               char buf[256];
> > >               int i =3D 0;
> > >
> > > --
> > > 2.51.0.384.g4c02a37b29-goog
> > >

