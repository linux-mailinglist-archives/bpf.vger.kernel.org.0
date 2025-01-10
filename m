Return-Path: <bpf+bounces-48583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80538A09C14
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 20:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C89A188DF38
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2538F215069;
	Fri, 10 Jan 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wAAgcZBq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF6213E95
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538780; cv=none; b=kvGbaS0n7aoLhv4nfxHTqLq4/bn2FQpWCPBmEUM28mQ/fd3MqOxlLc8UUlLChZA4KajKnli0S7tbRq29c6T8j687HkFdtGMKsLCIrWCk/OJQppLdYQtT+vUv2mlEg0TRZweDKDqwA5RWv2P2hb5U8IJUXH09RV2BORahtAW3eic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538780; c=relaxed/simple;
	bh=51l0jYeI+Vu+JMrsD7hBOYG+I6sQvMVFQCiCEyJ20To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAGlYd/R+Fq/IekzYtUd+w7j61nUnFk5f36IIJdSiEOP/zDk3yjDgyzZb/tZsJ9fFEBOD46Vu1YTnXXDXJCc6WbHp95JUugjLqTaEl57h6MIQk2u68/+pCzgJhW1uKaKuVrbep7/z77gB/+uevZyqbVlM0oaS2M1mHCcLsIlwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wAAgcZBq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-218c8aca5f1so50077705ad.0
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736538778; x=1737143578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE4hZoPbDGgp2xjYDH7T6bYrfv8oifOxSitp1fcCans=;
        b=wAAgcZBq1AUUs2oW+TI/SQd8dAFkywQHFXvV3C19Bvux5eYvE6qRsUwxeqAm20TQpV
         Z2IN3DhXhgdJ9WLqMSQt7G+BzEQe3lGI9JArl2Anzy2ZSjyceBdMcHnVOMS0rEAsz/wS
         wpkE7gpKeWkKT3DvrtpmvzLNOhV5h6bkMA2Mj2IRrGh27ppec/icGUm8uEHoPRwp50h7
         5rzuB1znRLkQu36mgBIs3ZuNnbS1sWIapShOFfuHJuyCBO+UeXtFGKCVYEJHTfvmjm9X
         W+qQyjHRCCR0In4BSFb1sczJFEolyXS6TcDWA0kjvap3SiZO4LZfjOCv69vNzXa7Vruk
         CAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736538778; x=1737143578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE4hZoPbDGgp2xjYDH7T6bYrfv8oifOxSitp1fcCans=;
        b=oi+qbxyUILigEvK4w7m2d/eMFe1OiA0fFe4OqC5gdzFt9uPqUovdQtqKVdAbIjrreC
         mzUR0tssoaxD5dri/h7+rPgOXisGWJdrVLzbR7nIhzUmrl5VeJjdgz4TCnJJ6yWwfQM5
         zVppqse8xzZvpjLv2NT6LA0/2+gupD8w378Ve9ESZs4j19EmuScX9V+s8U8jyMnZ6/KZ
         B65ViGTxZaKnZBfeH1onqIAIE9YSdLomnX8VCPbZfQYSWezJMRxzTBsA3pJ4QdjOH1ec
         BGQY+Ce4m/HfEzbo2xtWWBhfjCUjDOlqDKqpq9qSBZgilMSzmRmysgK0ZiMXYQKy13FN
         G01Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfQxIsUVsXZvbx7GDOize0vvhJk5AsvXba4gFAXYVaT0yB9kCoy03WMLrFdIc4r2WHuQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoF5nQUsc+La9fi2tUSnNpEWvYLDxD3n3A1gjl4A6CUMgO+uDU
	WcDE1zxW/x8Mucb100ZoIo0jZi88iV5YhtopfV/LvvWgef+LlPH//KkZ2eeiONZlCeC+yARAqzi
	Y9vpO/u/BocdOLKN9hmwY9xZNKJl750SQOUIYBw==
X-Gm-Gg: ASbGncsO1F5rWpqrYtI9BPWqKRr5/Hq6MnCNt0Jk8Ig2NN4Q6Ai8MHwtgty7JLMUzip
	YdYW0jpHGBq4FGol59sjmydSuV6pd4dtx+NUs
X-Google-Smtp-Source: AGHT+IGHhxWferEGqVv/gFjByAhHzEH8TzHbG5Kh2+IjuR7LJRepkqyKsk0DrYeivw9N5MJzVMkq9pJBqd43F9GF09U=
X-Received: by 2002:a05:6a00:410d:b0:729:35b:542e with SMTP id
 d2e1a72fcca58-72d21fe0258mr16540052b3a.16.1736538777881; Fri, 10 Jan 2025
 11:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109222109.567031-1-irogers@google.com> <20250109222109.567031-5-irogers@google.com>
 <Z4F3qxFaYnMTtPw7@google.com>
In-Reply-To: <Z4F3qxFaYnMTtPw7@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 10 Jan 2025 11:52:47 -0800
X-Gm-Features: AbW1kvZnw4ZAbGMIvtm_p0PbnwHiHwLZWQ3zplfChuvdX81pzhCc5dmNjVV02bo
Message-ID: <CAHBxVyE12g+GFie6gcOPkzm2ckid=sTjZU4ofj6j6EgwPTsDQw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Beeman Strong <beeman@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 11:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Jan 09, 2025 at 02:21:09PM -0800, Ian Rogers wrote:
> > Originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > This reverts commit 4f1b067359ac8364cdb7f9fda41085fa85789d0f although
> > the patch is now smaller due to related fixes being applied in commit
> > 22a4db3c3603 ("perf evsel: Add alternate_hw_config and use in
> > evsel__match").
> > The original commit message was:
> >
> > It was requested that RISC-V be able to add events to the perf tool so
> > the PMU driver didn't need to map legacy events to config encodings:
> > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.c=
om/
> >
> > This change makes the priority of events specified without a PMU the
> > same as those specified with a PMU, namely sysfs and JSON events are
> > checked first before using the legacy encoding.
>
> I'm still not convinced why we need this change despite of these
> troubles.  If it's because RISC-V cannot define the lagacy hardware
> events in the kernel driver, why not using a different name in JSON and

When the discussion happened a year back. we tried to avoid defining
the legacy hardware events in
the kernel driver. However, we agreed that we have to define it
anyways for other reasons (legacy usage + virtualization)
as described here[1]. I have improved the driver in such a way that it
can handle both legacy events from the
driver or json file (via this patch) if available. If this patch is
available, a platform vendor can choose to encode the legacy events in
json.
Otherwise, it has to specify them in the driver. I will try to send
the series today/tomorrow.

This patch will help avoid proliferation of usage of legacy events in
the long run. But it is no longer absolutely necessary for RISC-V.
If this patch is accepted, there is a hope that we can get rid of the
specifying encodings in the driver in the distant future. However, we
have
to define them in the driver for reasons described in[1].

[1] https://lore.kernel.org/lkml/20241026121758.143259-1-irogers@google.com=
/T/#m653a6b98919a365a361a698032502bd26af9f6ba
> ask users to use the name specifically?  Something like:
>
>   $ perf record -e riscv-cycles ...
>

That was the first alternative I proposed back in 2022 plumbers :).
But it was concluded that we don't want users to learn new ways
of running perf in RISC-V which makes sense to me as well.

> Thanks,
> Namhyung
>
> >
> > The hw_term is made more generic as a hardware_event that encodes a
> > pair of string and int value, allowing parse_events_multi_pmu_add to
> > fall back on a known encoding when the sysfs/JSON adding fails for
> > core events. As this covers PE_VALUE_SYM_HW, that token is removed and
> > related code simplified.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > Tested-by: Atish Patra <atishp@rivosinc.com>
> > Tested-by: James Clark <james.clark@linaro.org>
> > Tested-by: Leo Yan <leo.yan@arm.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Beeman Strong <beeman@rivosinc.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/parse-events.c | 26 +++++++++---
> >  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
> >  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
> >  3 files changed, 98 insertions(+), 64 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 1e23faa364b1..3a60fca53cfa 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1545,8 +1545,8 @@ int parse_events_multi_pmu_add(struct parse_event=
s_state *parse_state,
> >       struct list_head *list =3D NULL;
> >       struct perf_pmu *pmu =3D NULL;
> >       YYLTYPE *loc =3D loc_;
> > -     int ok =3D 0;
> > -     const char *config;
> > +     int ok =3D 0, core_ok =3D 0;
> > +     const char *tmp;
> >       struct parse_events_terms parsed_terms;
> >
> >       *listp =3D NULL;
> > @@ -1559,15 +1559,15 @@ int parse_events_multi_pmu_add(struct parse_eve=
nts_state *parse_state,
> >                       return ret;
> >       }
> >
> > -     config =3D strdup(event_name);
> > -     if (!config)
> > +     tmp =3D strdup(event_name);
> > +     if (!tmp)
> >               goto out_err;
> >
> >       if (parse_events_term__num(&term,
> >                                  PARSE_EVENTS__TERM_TYPE_USER,
> > -                                config, /*num=3D*/1, /*novalue=3D*/tru=
e,
> > +                                tmp, /*num=3D*/1, /*novalue=3D*/true,
> >                                  loc, /*loc_val=3D*/NULL) < 0) {
> > -             zfree(&config);
> > +             zfree(&tmp);
> >               goto out_err;
> >       }
> >       list_add_tail(&term->list, &parsed_terms.terms);
> > @@ -1598,6 +1598,8 @@ int parse_events_multi_pmu_add(struct parse_event=
s_state *parse_state,
> >                       pr_debug("%s -> %s/%s/\n", event_name, pmu->name,=
 sb.buf);
> >                       strbuf_release(&sb);
> >                       ok++;
> > +                     if (pmu->is_core)
> > +                             core_ok++;
> >               }
> >       }
> >
> > @@ -1614,6 +1616,18 @@ int parse_events_multi_pmu_add(struct parse_even=
ts_state *parse_state,
> >               }
> >       }
> >
> > +     if (hw_config !=3D PERF_COUNT_HW_MAX && !core_ok) {
> > +             /*
> > +              * The event wasn't found on core PMUs but it has a hardw=
are
> > +              * config version to try.
> > +              */
> > +             if (!parse_events_add_numeric(parse_state, list,
> > +                                             PERF_TYPE_HARDWARE, hw_co=
nfig,
> > +                                             const_parsed_terms,
> > +                                             /*wildcard=3D*/true))
> > +                     ok++;
> > +     }
> > +
> >  out_err:
> >       parse_events_terms__exit(&parsed_terms);
> >       if (ok)
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index bf7f73548605..29082a22ccc9 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -113,12 +113,12 @@ do {                                             =
               \
> >       yyless(0);                                              \
> >  } while (0)
> >
> > -static int sym(yyscan_t scanner, int type, int config)
> > +static int sym(yyscan_t scanner, int config)
> >  {
> >       YYSTYPE *yylval =3D parse_events_get_lval(scanner);
> >
> > -     yylval->num =3D (type << 16) + config;
> > -     return type =3D=3D PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALU=
E_SYM_SW;
> > +     yylval->num =3D config;
> > +     return PE_VALUE_SYM_SW;
> >  }
> >
> >  static int term(yyscan_t scanner, enum parse_events__term_type type)
> > @@ -129,13 +129,13 @@ static int term(yyscan_t scanner, enum parse_even=
ts__term_type type)
> >       return PE_TERM;
> >  }
> >
> > -static int hw_term(yyscan_t scanner, int config)
> > +static int hw(yyscan_t scanner, int config)
> >  {
> >       YYSTYPE *yylval =3D parse_events_get_lval(scanner);
> >       char *text =3D parse_events_get_text(scanner);
> >
> > -     yylval->hardware_term.str =3D strdup(text);
> > -     yylval->hardware_term.num =3D PERF_TYPE_HARDWARE + config;
> > +     yylval->hardware_event.str =3D strdup(text);
> > +     yylval->hardware_event.num =3D config;
> >       return PE_TERM_HW;
> >  }
> >
> > @@ -324,16 +324,16 @@ aux-output              { return term(yyscanner, =
PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
> >  aux-action           { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_ACTION); }
> >  aux-sample-size              { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
> >  metric-id            { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
> > -cpu-cycles|cycles                            { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
> > -stalled-cycles-frontend|idle-cycles-frontend { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> > -stalled-cycles-backend|idle-cycles-backend   { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > -instructions                                 { return hw_term(yyscanne=
r, PERF_COUNT_HW_INSTRUCTIONS); }
> > -cache-references                             { return hw_term(yyscanne=
r, PERF_COUNT_HW_CACHE_REFERENCES); }
> > -cache-misses                                 { return hw_term(yyscanne=
r, PERF_COUNT_HW_CACHE_MISSES); }
> > -branch-instructions|branches                 { return hw_term(yyscanne=
r, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
> > -branch-misses                                        { return hw_term(=
yyscanner, PERF_COUNT_HW_BRANCH_MISSES); }
> > -bus-cycles                                   { return hw_term(yyscanne=
r, PERF_COUNT_HW_BUS_CYCLES); }
> > -ref-cycles                                   { return hw_term(yyscanne=
r, PERF_COUNT_HW_REF_CPU_CYCLES); }
> > +cpu-cycles|cycles                            { return hw(yyscanner, PE=
RF_COUNT_HW_CPU_CYCLES); }
> > +stalled-cycles-frontend|idle-cycles-frontend { return hw(yyscanner, PE=
RF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> > +stalled-cycles-backend|idle-cycles-backend   { return hw(yyscanner, PE=
RF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > +instructions                                 { return hw(yyscanner, PE=
RF_COUNT_HW_INSTRUCTIONS); }
> > +cache-references                             { return hw(yyscanner, PE=
RF_COUNT_HW_CACHE_REFERENCES); }
> > +cache-misses                                 { return hw(yyscanner, PE=
RF_COUNT_HW_CACHE_MISSES); }
> > +branch-instructions|branches                 { return hw(yyscanner, PE=
RF_COUNT_HW_BRANCH_INSTRUCTIONS); }
> > +branch-misses                                        { return hw(yysca=
nner, PERF_COUNT_HW_BRANCH_MISSES); }
> > +bus-cycles                                   { return hw(yyscanner, PE=
RF_COUNT_HW_BUS_CYCLES); }
> > +ref-cycles                                   { return hw(yyscanner, PE=
RF_COUNT_HW_REF_CPU_CYCLES); }
> >  r{num_raw_hex}               { return str(yyscanner, PE_RAW); }
> >  r0x{num_raw_hex}     { return str(yyscanner, PE_RAW); }
> >  ,                    { return ','; }
> > @@ -377,28 +377,28 @@ r0x{num_raw_hex}        { return str(yyscanner, P=
E_RAW); }
> >  <<EOF>>                      { BEGIN(INITIAL); }
> >  }
> >
> > -cpu-cycles|cycles                            { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
> > -stalled-cycles-frontend|idle-cycles-frontend { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> > -stalled-cycles-backend|idle-cycles-backend   { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > -instructions                                 { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
> > -cache-references                             { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES); }
> > -cache-misses                                 { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
> > -branch-instructions|branches                 { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
> > -branch-misses                                        { return sym(yysc=
anner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }
> > -bus-cycles                                   { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_BUS_CYCLES); }
> > -ref-cycles                                   { return sym(yyscanner, P=
ERF_TYPE_HARDWARE, PERF_COUNT_HW_REF_CPU_CYCLES); }
> > -cpu-clock                                    { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_CLOCK); }
> > -task-clock                                   { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_TASK_CLOCK); }
> > -page-faults|faults                           { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS); }
> > -minor-faults                                 { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
> > -major-faults                                 { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
> > -context-switches|cs                          { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES); }
> > -cpu-migrations|migrations                    { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_MIGRATIONS); }
> > -alignment-faults                             { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
> > -emulation-faults                             { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
> > -dummy                                                { return sym(yysc=
anner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
> > -bpf-output                                   { return sym(yyscanner, P=
ERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
> > -cgroup-switches                                      { return sym(yysc=
anner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
> > +cpu-cycles|cycles                            { return hw(yyscanner, PE=
RF_COUNT_HW_CPU_CYCLES); }
> > +stalled-cycles-frontend|idle-cycles-frontend { return hw(yyscanner, PE=
RF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> > +stalled-cycles-backend|idle-cycles-backend   { return hw(yyscanner, PE=
RF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > +instructions                                 { return hw(yyscanner, PE=
RF_COUNT_HW_INSTRUCTIONS); }
> > +cache-references                             { return hw(yyscanner, PE=
RF_COUNT_HW_CACHE_REFERENCES); }
> > +cache-misses                                 { return hw(yyscanner, PE=
RF_COUNT_HW_CACHE_MISSES); }
> > +branch-instructions|branches                 { return hw(yyscanner, PE=
RF_COUNT_HW_BRANCH_INSTRUCTIONS); }
> > +branch-misses                                        { return hw(yysca=
nner, PERF_COUNT_HW_BRANCH_MISSES); }
> > +bus-cycles                                   { return hw(yyscanner, PE=
RF_COUNT_HW_BUS_CYCLES); }
> > +ref-cycles                                   { return hw(yyscanner, PE=
RF_COUNT_HW_REF_CPU_CYCLES); }
> > +cpu-clock                                    { return sym(yyscanner, P=
ERF_COUNT_SW_CPU_CLOCK); }
> > +task-clock                                   { return sym(yyscanner, P=
ERF_COUNT_SW_TASK_CLOCK); }
> > +page-faults|faults                           { return sym(yyscanner, P=
ERF_COUNT_SW_PAGE_FAULTS); }
> > +minor-faults                                 { return sym(yyscanner, P=
ERF_COUNT_SW_PAGE_FAULTS_MIN); }
> > +major-faults                                 { return sym(yyscanner, P=
ERF_COUNT_SW_PAGE_FAULTS_MAJ); }
> > +context-switches|cs                          { return sym(yyscanner, P=
ERF_COUNT_SW_CONTEXT_SWITCHES); }
> > +cpu-migrations|migrations                    { return sym(yyscanner, P=
ERF_COUNT_SW_CPU_MIGRATIONS); }
> > +alignment-faults                             { return sym(yyscanner, P=
ERF_COUNT_SW_ALIGNMENT_FAULTS); }
> > +emulation-faults                             { return sym(yyscanner, P=
ERF_COUNT_SW_EMULATION_FAULTS); }
> > +dummy                                                { return sym(yysc=
anner, PERF_COUNT_SW_DUMMY); }
> > +bpf-output                                   { return sym(yyscanner, P=
ERF_COUNT_SW_BPF_OUTPUT); }
> > +cgroup-switches                                      { return sym(yysc=
anner, PERF_COUNT_SW_CGROUP_SWITCHES); }
> >
> >  {lc_type}                    { return str(yyscanner, PE_LEGACY_CACHE);=
 }
> >  {lc_type}-{lc_op_result}     { return str(yyscanner, PE_LEGACY_CACHE);=
 }
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index f888cbb076d6..d2ef1890007e 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -55,7 +55,7 @@ static void free_list_evsel(struct list_head* list_ev=
sel)
> >  %}
> >
> >  %token PE_START_EVENTS PE_START_TERMS
> > -%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
> > +%token PE_VALUE PE_VALUE_SYM_SW PE_TERM
> >  %token PE_EVENT_NAME
> >  %token PE_RAW PE_NAME
> >  %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
> > @@ -65,11 +65,9 @@ static void free_list_evsel(struct list_head* list_e=
vsel)
> >  %token PE_DRV_CFG_TERM
> >  %token PE_TERM_HW
> >  %type <num> PE_VALUE
> > -%type <num> PE_VALUE_SYM_HW
> >  %type <num> PE_VALUE_SYM_SW
> >  %type <mod> PE_MODIFIER_EVENT
> >  %type <term_type> PE_TERM
> > -%type <num> value_sym
> >  %type <str> PE_RAW
> >  %type <str> PE_NAME
> >  %type <str> PE_LEGACY_CACHE
> > @@ -85,6 +83,7 @@ static void free_list_evsel(struct list_head* list_ev=
sel)
> >  %type <list_terms> opt_pmu_config
> >  %destructor { parse_events_terms__delete ($$); } <list_terms>
> >  %type <list_evsel> event_pmu
> > +%type <list_evsel> event_legacy_hardware
> >  %type <list_evsel> event_legacy_symbol
> >  %type <list_evsel> event_legacy_cache
> >  %type <list_evsel> event_legacy_mem
> > @@ -102,8 +101,8 @@ static void free_list_evsel(struct list_head* list_=
evsel)
> >  %destructor { free_list_evsel ($$); } <list_evsel>
> >  %type <tracepoint_name> tracepoint_name
> >  %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
> > -%type <hardware_term> PE_TERM_HW
> > -%destructor { free ($$.str); } <hardware_term>
> > +%type <hardware_event> PE_TERM_HW
> > +%destructor { free ($$.str); } <hardware_event>
> >
> >  %union
> >  {
> > @@ -118,10 +117,10 @@ static void free_list_evsel(struct list_head* lis=
t_evsel)
> >               char *sys;
> >               char *event;
> >       } tracepoint_name;
> > -     struct hardware_term {
> > +     struct hardware_event {
> >               char *str;
> >               u64 num;
> > -     } hardware_term;
> > +     } hardware_event;
> >  }
> >  %%
> >
> > @@ -264,6 +263,7 @@ PE_EVENT_NAME event_def
> >  event_def
> >
> >  event_def: event_pmu |
> > +        event_legacy_hardware |
> >          event_legacy_symbol |
> >          event_legacy_cache sep_dc |
> >          event_legacy_mem sep_dc |
> > @@ -306,24 +306,45 @@ PE_NAME sep_dc
> >       $$ =3D list;
> >  }
> >
> > -value_sym:
> > -PE_VALUE_SYM_HW
> > +event_legacy_hardware:
> > +PE_TERM_HW opt_pmu_config
> > +{
> > +     /* List of created evsels. */
> > +     struct list_head *list =3D NULL;
> > +     int err =3D parse_events_multi_pmu_add(_parse_state, $1.str, $1.n=
um, $2, &list, &@1);
> > +
> > +     free($1.str);
> > +     parse_events_terms__delete($2);
> > +     if (err)
> > +             PE_ABORT(err);
> > +
> > +     $$ =3D list;
> > +}
> >  |
> > -PE_VALUE_SYM_SW
> > +PE_TERM_HW sep_dc
> > +{
> > +     struct list_head *list;
> > +     int err;
> > +
> > +     err =3D parse_events_multi_pmu_add(_parse_state, $1.str, $1.num, =
NULL, &list, &@1);
> > +     free($1.str);
> > +     if (err)
> > +             PE_ABORT(err);
> > +     $$ =3D list;
> > +}
> >
> >  event_legacy_symbol:
> > -value_sym '/' event_config '/'
> > +PE_VALUE_SYM_SW '/' event_config '/'
> >  {
> >       struct list_head *list;
> > -     int type =3D $1 >> 16;
> > -     int config =3D $1 & 255;
> >       int err;
> > -     bool wildcard =3D (type =3D=3D PERF_TYPE_HARDWARE || type =3D=3D =
PERF_TYPE_HW_CACHE);
> >
> >       list =3D alloc_list();
> >       if (!list)
> >               YYNOMEM;
> > -     err =3D parse_events_add_numeric(_parse_state, list, type, config=
, $3, wildcard);
> > +     err =3D parse_events_add_numeric(_parse_state, list,
> > +                             /*type=3D*/PERF_TYPE_SOFTWARE, /*config=
=3D*/$1,
> > +                             $3, /*wildcard=3D*/false);
> >       parse_events_terms__delete($3);
> >       if (err) {
> >               free_list_evsel(list);
> > @@ -332,18 +353,17 @@ value_sym '/' event_config '/'
> >       $$ =3D list;
> >  }
> >  |
> > -value_sym sep_slash_slash_dc
> > +PE_VALUE_SYM_SW sep_slash_slash_dc
> >  {
> >       struct list_head *list;
> > -     int type =3D $1 >> 16;
> > -     int config =3D $1 & 255;
> > -     bool wildcard =3D (type =3D=3D PERF_TYPE_HARDWARE || type =3D=3D =
PERF_TYPE_HW_CACHE);
> >       int err;
> >
> >       list =3D alloc_list();
> >       if (!list)
> >               YYNOMEM;
> > -     err =3D parse_events_add_numeric(_parse_state, list, type, config=
, /*head_config=3D*/NULL, wildcard);
> > +     err =3D parse_events_add_numeric(_parse_state, list,
> > +                             /*type=3D*/PERF_TYPE_SOFTWARE, /*config=
=3D*/$1,
> > +                             /*head_config=3D*/NULL, /*wildcard=3D*/fa=
lse);
> >       if (err)
> >               PE_ABORT(err);
> >       $$ =3D list;
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >

