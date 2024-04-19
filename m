Return-Path: <bpf+bounces-27205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0328AA864
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 08:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6411F281CE6
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B71079D;
	Fri, 19 Apr 2024 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmdOMnWd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DDC144
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507755; cv=none; b=CzmDYJoArUpKFlSS02volwhBQD94BRQog96ksauljFC54pE/lDDiaB/DSRoZJ9NslivZBfX7lzR2YQH3ryv2GdJevSPJUp7bhFL3P+RKZINjzKVgnn3pN79EGC5ZYYeKUZlvHxhe4U9mWrP2uzj0L42a/PqlCwTlsbn4SqxiEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507755; c=relaxed/simple;
	bh=IKq6kKpYxQNQOiztjaJiLJb/Gw02MGrfhHR94xStGEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnjmVhE9qA7t6kEX+tY/ivHFFdv2U3hiT/5hg4++yqY1hWke3UYDKYYPAGqgSmRZ5hh+/rRdh5As8sFpExOdzdL1m5iQXPhrSwb880dl9eqK5YLF6EXO957eUWe0NPHF/rTnXlW6nQCHpzQL7rp++b73qvTPYBQj7zH7ueUebjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmdOMnWd; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-436ed871225so159961cf.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713507751; x=1714112551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5DJQiWaC946xoBV83e/CuzUpiC08XaA6Db/7lyPjZ8=;
        b=rmdOMnWdRLwjUSRmjrtt0PLz9T/mZFDuB/nxbV2G5tD9rfF2tg/jMkHHM07L8Ytu8d
         LYsf+JcknV3Ozu2oqGWAtHyPBCtK41jbOomljSknpNMhjix706WQTrZZAXFgjAzCAQL8
         auj1dF2I3tKLd/rRs6R6c0/ek50qJbMaOjMruo3YZsDFb3D2DETF2L6EsYqgl5EXDFki
         LD1iS2Hzqy4qan/oeF7mYRAl9V5sMbOc0v/h6eTxJ+uZWY5ns4MwqKCx2j4oOM7X0tM5
         F1d5gKVWJtOOziJDRNJBi+cnXFxRR8LlLfBEzjPub+xP6Sk1HV7leexNJe+FELrqd2hX
         Wr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713507751; x=1714112551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5DJQiWaC946xoBV83e/CuzUpiC08XaA6Db/7lyPjZ8=;
        b=ny5z546AiUZ/bAmt309VYVJv4Xoop8f8rdHWqSKapaLLZrA4ff1mFhhGKTVy8EB48H
         lzpKEzNT2vJAGniTonvaPnBaVGaCESOgJNQGvEQeDqXRJ/yYuURmKLQiChscBotX3BrD
         KYG6ULBg8AjZKXKSnrIsLXBPLQwgedev38+s6rnIh1Hwlwgk1lCSVWZaYICy7sLE/Gi2
         8KjETtct0i+uQ3lrsDpDyUsC3+O5vr3T5eRiwTfGoJV8qDqCF88HXiZcGGh9gRBZc5BI
         QLvAaDlXUIAQ9MDC4nCRFJBW2Vi7MCW0HYwb2ICTCxQa1/p0OQjYUfkc9KHV++BTd0lK
         rKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSgAaPP3h49UKAQmi+Is1DwFYkW4/ez31pKNDVl8pFtqBmyXGiXAqHp3mIxZ0PaL+J3MExzaStC/5ZHrF+S7GDz0tT
X-Gm-Message-State: AOJu0Yz29rqksgXduDh68DEBrtFFH3yTHg36wFdiHp7fczvqlvrr1nr0
	5ar2adRZ4KXwH+7FEXSFDBSwArfXnVRgkC/tIjzpVnvq8X2sXP7ZJB/HXPfjm5jr7FhCvtGXLOd
	6JHMmR2NTSfz+yFE626bebpo1WSKi39qsUTZ/
X-Google-Smtp-Source: AGHT+IENV2HEZCn2LqbsJxRcCDznXxeH7z8V4If10jpgSw5wWwDWNX0+BrOqw4akRra4KlLXGnxfubGbL44SASaMpIU=
X-Received: by 2002:a05:622a:1aa2:b0:437:87f9:21cd with SMTP id
 s34-20020a05622a1aa200b0043787f921cdmr190046qtc.16.1713507750715; Thu, 18 Apr
 2024 23:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com> <20240416061533.921723-14-irogers@google.com>
 <e8147f53-1930-44d8-abb8-fee460ec355f@linux.intel.com>
In-Reply-To: <e8147f53-1930-44d8-abb8-fee460ec355f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Apr 2024 23:22:18 -0700
Message-ID: <CAP-5=fVXv_gsoq5L08gaEJvU1E8xoihc3-L4taA+bPHyOJfgqw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] perf parse-events: Improvements to modifier parsing
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:32=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-16 2:15 a.m., Ian Rogers wrote:
> > Use a struct/bitmap rather than a copied string from lexer.
> >
> > In lexer give improved error message when too many precise flags are
> > given or repeated modifiers.
> >
> > Before:
> > ```
> > $ perf stat -e 'cycles:kuk' true
> > event syntax error: 'cycles:kuk'
> >                             \___ Bad modifier
> > ...
> > $ perf stat -e 'cycles:pppp' true
> > event syntax error: 'cycles:pppp'
> >                             \___ Bad modifier
> > ...
> > $ perf stat -e '{instructions:p,cycles:pp}:pp' -a true
> > event syntax error: '..cycles:pp}:pp'
> >                                   \___ Bad modifier
> > ...
> > ```
> > After:
> > ```
> > $ perf stat -e 'cycles:kuk' true
> > event syntax error: 'cycles:kuk'
> >                               \___ Duplicate modifier 'k' (kernel)
> > ...
> > $ perf stat -e 'cycles:pppp' true
> > event syntax error: 'cycles:pppp'
> >                                \___ Maximum precise value is 3
> > ...
> > $ perf stat -e '{instructions:p,cycles:pp}:pp' true
> > event syntax error: '..cycles:pp}:pp'
> >                                   \___ Maximum combined precise value i=
s 3, adding precision to "cycles:pp"
> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 250 ++++++++++++---------------------
> >  tools/perf/util/parse-events.h |  23 ++-
> >  tools/perf/util/parse-events.l |  75 +++++++++-
> >  tools/perf/util/parse-events.y |  28 +---
> >  4 files changed, 194 insertions(+), 182 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index ebada37ef98a..3ab533d0e653 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1700,12 +1700,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct=
 parse_events_state *parse_state
> >       return -EINVAL;
> >  }
> >
> > -int parse_events__modifier_group(struct list_head *list,
> > -                              char *event_mod)
> > -{
> > -     return parse_events__modifier_event(list, event_mod, true);
> > -}
> > -
> >  void parse_events__set_leader(char *name, struct list_head *list)
> >  {
> >       struct evsel *leader;
> > @@ -1720,183 +1714,125 @@ void parse_events__set_leader(char *name, str=
uct list_head *list)
> >       leader->group_name =3D name;
> >  }
> >
> > -struct event_modifier {
> > -     int eu;
> > -     int ek;
> > -     int eh;
> > -     int eH;
> > -     int eG;
> > -     int eI;
> > -     int precise;
> > -     int precise_max;
> > -     int exclude_GH;
> > -     int sample_read;
> > -     int pinned;
> > -     int weak;
> > -     int exclusive;
> > -     int bpf_counter;
> > -};
> > +static int parse_events__modifier_list(struct parse_events_state *pars=
e_state,
> > +                                    YYLTYPE *loc,
> > +                                    struct list_head *list,
> > +                                    struct parse_events_modifier mod,
> > +                                    bool group)
> > +{
> > +     struct evsel *evsel;
> >
> > -static int get_event_modifier(struct event_modifier *mod, char *str,
> > -                            struct evsel *evsel)
> > -{
> > -     int eu =3D evsel ? evsel->core.attr.exclude_user : 0;
> > -     int ek =3D evsel ? evsel->core.attr.exclude_kernel : 0;
> > -     int eh =3D evsel ? evsel->core.attr.exclude_hv : 0;
> > -     int eH =3D evsel ? evsel->core.attr.exclude_host : 0;
> > -     int eG =3D evsel ? evsel->core.attr.exclude_guest : 0;
> > -     int eI =3D evsel ? evsel->core.attr.exclude_idle : 0;
> > -     int precise =3D evsel ? evsel->core.attr.precise_ip : 0;
> > -     int precise_max =3D 0;
> > -     int sample_read =3D 0;
> > -     int pinned =3D evsel ? evsel->core.attr.pinned : 0;
> > -     int exclusive =3D evsel ? evsel->core.attr.exclusive : 0;
> > -
> > -     int exclude =3D eu | ek | eh;
> > -     int exclude_GH =3D evsel ? evsel->exclude_GH : 0;
> > -     int weak =3D 0;
> > -     int bpf_counter =3D 0;
> > -
> > -     memset(mod, 0, sizeof(*mod));
> > -
> > -     while (*str) {
> > -             if (*str =3D=3D 'u') {
> > +     if (!group && mod.weak) {
> > +             parse_events_error__handle(parse_state->error, loc->first=
_column,
> > +                                        strdup("Weak modifier is for u=
se with groups"), NULL);
> > +             return -EINVAL;
> > +     }
> > +
> > +     __evlist__for_each_entry(list, evsel) {
> > +             /* Translate modifiers into the equivalent evsel excludes=
. */
> > +             int eu =3D group ? evsel->core.attr.exclude_user : 0;
> > +             int ek =3D group ? evsel->core.attr.exclude_kernel : 0;
> > +             int eh =3D group ? evsel->core.attr.exclude_hv : 0;
> > +             int eH =3D group ? evsel->core.attr.exclude_host : 0;
> > +             int eG =3D group ? evsel->core.attr.exclude_guest : 0;
> > +             int exclude =3D eu | ek | eh;
> > +             int exclude_GH =3D group ? evsel->exclude_GH : 0;
> > +
> > +             if (mod.precise) {
> > +                     /* use of precise requires exclude_guest */
> > +                     eG =3D 1;
> > +             }
> > +             if (mod.user) {
> >                       if (!exclude)
> >                               exclude =3D eu =3D ek =3D eh =3D 1;
> >                       if (!exclude_GH && !perf_guest)
> >                               eG =3D 1;
> >                       eu =3D 0;
> > -             } else if (*str =3D=3D 'k') {
> > +             }
> > +             if (mod.kernel) {
> >                       if (!exclude)
> >                               exclude =3D eu =3D ek =3D eh =3D 1;
> >                       ek =3D 0;
> > -             } else if (*str =3D=3D 'h') {
> > +             }
> > +             if (mod.hypervisor) {
> >                       if (!exclude)
> >                               exclude =3D eu =3D ek =3D eh =3D 1;
> >                       eh =3D 0;
> > -             } else if (*str =3D=3D 'G') {
> > +             }
> > +             if (mod.guest) {
> >                       if (!exclude_GH)
> >                               exclude_GH =3D eG =3D eH =3D 1;
> >                       eG =3D 0;
> > -             } else if (*str =3D=3D 'H') {
> > +             }
> > +             if (mod.host) {
> >                       if (!exclude_GH)
> >                               exclude_GH =3D eG =3D eH =3D 1;
> >                       eH =3D 0;
> > -             } else if (*str =3D=3D 'I') {
> > -                     eI =3D 1;
> > -             } else if (*str =3D=3D 'p') {
> > -                     precise++;
> > -                     /* use of precise requires exclude_guest */
> > -                     if (!exclude_GH)
> > -                             eG =3D 1;
> > -             } else if (*str =3D=3D 'P') {
> > -                     precise_max =3D 1;
> > -             } else if (*str =3D=3D 'S') {
> > -                     sample_read =3D 1;
> > -             } else if (*str =3D=3D 'D') {
> > -                     pinned =3D 1;
> > -             } else if (*str =3D=3D 'e') {
> > -                     exclusive =3D 1;
> > -             } else if (*str =3D=3D 'W') {
> > -                     weak =3D 1;
> > -             } else if (*str =3D=3D 'b') {
> > -                     bpf_counter =3D 1;
> > -             } else
> > -                     break;
> > -
> > -             ++str;
> > +             }
> > +             evsel->core.attr.exclude_user   =3D eu;
> > +             evsel->core.attr.exclude_kernel =3D ek;
> > +             evsel->core.attr.exclude_hv     =3D eh;
> > +             evsel->core.attr.exclude_host   =3D eH;
> > +             evsel->core.attr.exclude_guest  =3D eG;
> > +             evsel->exclude_GH               =3D exclude_GH;
> > +
> > +             /* Simple modifiers copied to the evsel. */
> > +             if (mod.precise) {
> > +                     u8 precise =3D evsel->core.attr.precise_ip + mod.=
precise;
> > +                     /*
> > +                      * precise ip:
> > +                      *
> > +                      *  0 - SAMPLE_IP can have arbitrary skid
> > +                      *  1 - SAMPLE_IP must have constant skid
> > +                      *  2 - SAMPLE_IP requested to have 0 skid
> > +                      *  3 - SAMPLE_IP must have 0 skid
> > +                      *
> > +                      *  See also PERF_RECORD_MISC_EXACT_IP
> > +                      */
> > +                     if (precise > 3) {
>
> The pmu_max_precise() should return the max precise the current kernel
> supports. It checks the /sys/devices/cpu/caps/max_precise.
>
> I think we should use that value rather than hard code it to 3.

I'll add an extra patch to do that. I'm a bit concerned it may break
event parsing on platforms not supporting max_precise of 3.

Thanks,
Ian

> Thanks,
> Kan
>
> > +                             char *help;
> > +
> > +                             if (asprintf(&help,
> > +                                          "Maximum combined precise va=
lue is 3, adding precision to \"%s\"",
> > +                                          evsel__name(evsel)) > 0) {
> > +                                     parse_events_error__handle(parse_=
state->error,
> > +                                                                loc->f=
irst_column,
> > +                                                                help, =
NULL);
> > +                             }
> > +                             return -EINVAL;
> > +                     }
> > +                     evsel->core.attr.precise_ip =3D precise;
> > +             }
> > +             if (mod.precise_max)
> > +                     evsel->precise_max =3D 1;
> > +             if (mod.non_idle)
> > +                     evsel->core.attr.exclude_idle =3D 1;
> > +             if (mod.sample_read)
> > +                     evsel->sample_read =3D 1;
> > +             if (mod.pinned && evsel__is_group_leader(evsel))
> > +                     evsel->core.attr.pinned =3D 1;
> > +             if (mod.exclusive && evsel__is_group_leader(evsel))
> > +                     evsel->core.attr.exclusive =3D 1;
> > +             if (mod.weak)
> > +                     evsel->weak_group =3D true;
> > +             if (mod.bpf)
> > +                     evsel->bpf_counter =3D true;
> >       }
> > -
> > -     /*
> > -      * precise ip:
> > -      *
> > -      *  0 - SAMPLE_IP can have arbitrary skid
> > -      *  1 - SAMPLE_IP must have constant skid
> > -      *  2 - SAMPLE_IP requested to have 0 skid
> > -      *  3 - SAMPLE_IP must have 0 skid
> > -      *
> > -      *  See also PERF_RECORD_MISC_EXACT_IP
> > -      */
> > -     if (precise > 3)
> > -             return -EINVAL;
> > -
> > -     mod->eu =3D eu;
> > -     mod->ek =3D ek;
> > -     mod->eh =3D eh;
> > -     mod->eH =3D eH;
> > -     mod->eG =3D eG;
> > -     mod->eI =3D eI;
> > -     mod->precise =3D precise;
> > -     mod->precise_max =3D precise_max;
> > -     mod->exclude_GH =3D exclude_GH;
> > -     mod->sample_read =3D sample_read;
> > -     mod->pinned =3D pinned;
> > -     mod->weak =3D weak;
> > -     mod->bpf_counter =3D bpf_counter;
> > -     mod->exclusive =3D exclusive;
> > -
> >       return 0;
> >  }
> >
> > -/*
> > - * Basic modifier sanity check to validate it contains only one
> > - * instance of any modifier (apart from 'p') present.
> > - */
> > -static int check_modifier(char *str)
> > +int parse_events__modifier_group(struct parse_events_state *parse_stat=
e, void *loc,
> > +                              struct list_head *list,
> > +                              struct parse_events_modifier mod)
> >  {
> > -     char *p =3D str;
> > -
> > -     /* The sizeof includes 0 byte as well. */
> > -     if (strlen(str) > (sizeof("ukhGHpppPSDIWeb") - 1))
> > -             return -1;
> > -
> > -     while (*p) {
> > -             if (*p !=3D 'p' && strchr(p + 1, *p))
> > -                     return -1;
> > -             p++;
> > -     }
> > -
> > -     return 0;
> > +     return parse_events__modifier_list(parse_state, loc, list, mod, /=
*group=3D*/true);
> >  }
> >
> > -int parse_events__modifier_event(struct list_head *list, char *str, bo=
ol add)
> > +int parse_events__modifier_event(struct parse_events_state *parse_stat=
e, void *loc,
> > +                              struct list_head *list,
> > +                              struct parse_events_modifier mod)
> >  {
> > -     struct evsel *evsel;
> > -     struct event_modifier mod;
> > -
> > -     if (str =3D=3D NULL)
> > -             return 0;
> > -
> > -     if (check_modifier(str))
> > -             return -EINVAL;
> > -
> > -     if (!add && get_event_modifier(&mod, str, NULL))
> > -             return -EINVAL;
> > -
> > -     __evlist__for_each_entry(list, evsel) {
> > -             if (add && get_event_modifier(&mod, str, evsel))
> > -                     return -EINVAL;
> > -
> > -             evsel->core.attr.exclude_user   =3D mod.eu;
> > -             evsel->core.attr.exclude_kernel =3D mod.ek;
> > -             evsel->core.attr.exclude_hv     =3D mod.eh;
> > -             evsel->core.attr.precise_ip     =3D mod.precise;
> > -             evsel->core.attr.exclude_host   =3D mod.eH;
> > -             evsel->core.attr.exclude_guest  =3D mod.eG;
> > -             evsel->core.attr.exclude_idle   =3D mod.eI;
> > -             evsel->exclude_GH          =3D mod.exclude_GH;
> > -             evsel->sample_read         =3D mod.sample_read;
> > -             evsel->precise_max         =3D mod.precise_max;
> > -             evsel->weak_group          =3D mod.weak;
> > -             evsel->bpf_counter         =3D mod.bpf_counter;
> > -
> > -             if (evsel__is_group_leader(evsel)) {
> > -                     evsel->core.attr.pinned =3D mod.pinned;
> > -                     evsel->core.attr.exclusive =3D mod.exclusive;
> > -             }
> > -     }
> > -
> > -     return 0;
> > +     return parse_events__modifier_list(parse_state, loc, list, mod, /=
*group=3D*/false);
> >  }
> >
> >  int parse_events_name(struct list_head *list, const char *name)
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 290ae6c72ec5..f104faef1a78 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -186,8 +186,27 @@ void parse_events_terms__init(struct parse_events_=
terms *terms);
> >  void parse_events_terms__exit(struct parse_events_terms *terms);
> >  int parse_events_terms(struct parse_events_terms *terms, const char *s=
tr, FILE *input);
> >  int parse_events_terms__to_strbuf(const struct parse_events_terms *ter=
ms, struct strbuf *sb);
> > -int parse_events__modifier_event(struct list_head *list, char *str, bo=
ol add);
> > -int parse_events__modifier_group(struct list_head *list, char *event_m=
od);
> > +
> > +struct parse_events_modifier {
> > +     u8 precise;     /* Number of repeated 'p' for precision. */
> > +     bool precise_max : 1;   /* 'P' */
> > +     bool non_idle : 1;      /* 'I' */
> > +     bool sample_read : 1;   /* 'S' */
> > +     bool pinned : 1;        /* 'D' */
> > +     bool exclusive : 1;     /* 'e' */
> > +     bool weak : 1;          /* 'W' */
> > +     bool bpf : 1;           /* 'b' */
> > +     bool user : 1;          /* 'u' */
> > +     bool kernel : 1;        /* 'k' */
> > +     bool hypervisor : 1;    /* 'h' */
> > +     bool guest : 1;         /* 'G' */
> > +     bool host : 1;          /* 'H' */
> > +};
> > +
> > +int parse_events__modifier_event(struct parse_events_state *parse_stat=
e, void *loc,
> > +                              struct list_head *list, struct parse_eve=
nts_modifier mod);
> > +int parse_events__modifier_group(struct parse_events_state *parse_stat=
e, void *loc,
> > +                              struct list_head *list, struct parse_eve=
nts_modifier mod);
> >  int parse_events_name(struct list_head *list, const char *name);
> >  int parse_events_add_tracepoint(struct list_head *list, int *idx,
> >                               const char *sys, const char *event,
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-eve=
nts.l
> > index 0cd68c9f0d4f..4aaf0c53d9b6 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -142,6 +142,77 @@ static int hw(yyscan_t scanner, int config)
> >       return PE_TERM_HW;
> >  }
> >
> > +static void modifiers_error(struct parse_events_state *parse_state, yy=
scan_t scanner,
> > +                         int pos, char mod_char, const char *mod_name)
> > +{
> > +     struct parse_events_error *error =3D parse_state->error;
> > +     char *help =3D NULL;
> > +
> > +     if (asprintf(&help, "Duplicate modifier '%c' (%s)", mod_char, mod=
_name) > 0)
> > +             parse_events_error__handle(error, get_column(scanner) + p=
os, help , NULL);
> > +}
> > +
> > +static int modifiers(struct parse_events_state *parse_state, yyscan_t =
scanner)
> > +{
> > +     YYSTYPE *yylval =3D parse_events_get_lval(scanner);
> > +     char *text =3D parse_events_get_text(scanner);
> > +     struct parse_events_modifier mod =3D { .precise =3D 0, };
> > +
> > +     for (size_t i =3D 0, n =3D strlen(text); i < n; i++) {
> > +#define CASE(c, field)                                                =
       \
> > +             case c:                                                 \
> > +                     if (mod.field) {                                \
> > +                             modifiers_error(parse_state, scanner, i, =
c, #field); \
> > +                             return PE_ERROR;                        \
> > +                     }                                               \
> > +                     mod.field =3D true;                              =
 \
> > +                     break
> > +
> > +             switch (text[i]) {
> > +             CASE('u', user);
> > +             CASE('k', kernel);
> > +             CASE('h', hypervisor);
> > +             CASE('I', non_idle);
> > +             CASE('G', guest);
> > +             CASE('H', host);
> > +             case 'p':
> > +                     mod.precise++;
> > +                     /*
> > +                      * precise ip:
> > +                      *
> > +                      *  0 - SAMPLE_IP can have arbitrary skid
> > +                      *  1 - SAMPLE_IP must have constant skid
> > +                      *  2 - SAMPLE_IP requested to have 0 skid
> > +                      *  3 - SAMPLE_IP must have 0 skid
> > +                      *
> > +                      *  See also PERF_RECORD_MISC_EXACT_IP
> > +                      */
> > +                     if (mod.precise > 3) {
> > +                             struct parse_events_error *error =3D pars=
e_state->error;
> > +                             char *help =3D strdup("Maximum precise va=
lue is 3");
> > +
> > +                             if (help) {
> > +                                     parse_events_error__handle(error,=
 get_column(scanner) + i,
> > +                                                                help ,=
 NULL);
> > +                             }
> > +                             return PE_ERROR;
> > +                     }
> > +                     break;
> > +             CASE('P', precise_max);
> > +             CASE('S', sample_read);
> > +             CASE('D', pinned);
> > +             CASE('W', weak);
> > +             CASE('e', exclusive);
> > +             CASE('b', bpf);
> > +             default:
> > +                     return PE_ERROR;
> > +             }
> > +#undef CASE
> > +     }
> > +     yylval->mod =3D mod;
> > +     return PE_MODIFIER_EVENT;
> > +}
> > +
> >  #define YY_USER_ACTION                                       \
> >  do {                                                 \
> >       yylloc->last_column  =3D yylloc->first_column;    \
> > @@ -174,7 +245,7 @@ drv_cfg_term      [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\=
.:]+)?
> >   * If you add a modifier you need to update check_modifier().
> >   * Also, the letters in modifier_event must not be in modifier_bp.
> >   */
> > -modifier_event       [ukhpPGHSDIWeb]+
> > +modifier_event       [ukhpPGHSDIWeb]{1,15}
> >  modifier_bp  [rwx]{1,3}
> >  lc_type      (L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruc=
tion|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|=
bpu|btb|bpc|node)
> >  lc_op_result (load|loads|read|store|stores|write|prefetch|prefetches|s=
peculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
> > @@ -341,7 +412,7 @@ r{num_raw_hex}            { return str(yyscanner, P=
E_RAW); }
> >  {num_dec}            { return value(_parse_state, yyscanner, 10); }
> >  {num_hex}            { return value(_parse_state, yyscanner, 16); }
> >
> > -{modifier_event}     { return str(yyscanner, PE_MODIFIER_EVENT); }
> > +{modifier_event}     { return modifiers(_parse_state, yyscanner); }
> >  {name}                       { return str(yyscanner, PE_NAME); }
> >  {name_tag}           { return str(yyscanner, PE_NAME); }
> >  "/"                  { BEGIN(config); return '/'; }
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index 2c4817e126c1..79f254189be6 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -68,11 +68,11 @@ static void free_list_evsel(struct list_head* list_=
evsel)
> >  %type <num> PE_VALUE
> >  %type <num> PE_VALUE_SYM_SW
> >  %type <num> PE_VALUE_SYM_TOOL
> > +%type <mod> PE_MODIFIER_EVENT
> >  %type <term_type> PE_TERM
> >  %type <str> PE_RAW
> >  %type <str> PE_NAME
> >  %type <str> PE_LEGACY_CACHE
> > -%type <str> PE_MODIFIER_EVENT
> >  %type <str> PE_MODIFIER_BP
> >  %type <str> PE_EVENT_NAME
> >  %type <str> PE_DRV_CFG_TERM
> > @@ -110,6 +110,7 @@ static void free_list_evsel(struct list_head* list_=
evsel)
> >  {
> >       char *str;
> >       u64 num;
> > +     struct parse_events_modifier mod;
> >       enum parse_events__term_type term_type;
> >       struct list_head *list_evsel;
> >       struct parse_events_terms *list_terms;
> > @@ -175,20 +176,13 @@ event
> >  group:
> >  group_def ':' PE_MODIFIER_EVENT
> >  {
> > +     /* Apply the modifier to the events in the group_def. */
> >       struct list_head *list =3D $1;
> >       int err;
> >
> > -     err =3D parse_events__modifier_group(list, $3);
> > -     free($3);
> > -     if (err) {
> > -             struct parse_events_state *parse_state =3D _parse_state;
> > -             struct parse_events_error *error =3D parse_state->error;
> > -
> > -             parse_events_error__handle(error, @3.first_column,
> > -                                        strdup("Bad modifier"), NULL);
> > -             free_list_evsel(list);
> > +     err =3D parse_events__modifier_group(_parse_state, &@3, list, $3)=
;
> > +     if (err)
> >               YYABORT;
> > -     }
> >       $$ =3D list;
> >  }
> >  |
> > @@ -238,17 +232,9 @@ event_name PE_MODIFIER_EVENT
> >        * (there could be more events added for multiple tracepoint
> >        * definitions via '*?'.
> >        */
> > -     err =3D parse_events__modifier_event(list, $2, false);
> > -     free($2);
> > -     if (err) {
> > -             struct parse_events_state *parse_state =3D _parse_state;
> > -             struct parse_events_error *error =3D parse_state->error;
> > -
> > -             parse_events_error__handle(error, @2.first_column,
> > -                                        strdup("Bad modifier"), NULL);
> > -             free_list_evsel(list);
> > +     err =3D parse_events__modifier_event(_parse_state, &@2, list, $2)=
;
> > +     if (err)
> >               YYABORT;
> > -     }
> >       $$ =3D list;
> >  }
> >  |

