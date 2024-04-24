Return-Path: <bpf+bounces-27687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF88B0DB8
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A631C23906
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B5E15F3E9;
	Wed, 24 Apr 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cz/AbNt1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66015EFBE
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971659; cv=none; b=ORuTLaM712Tjb837GhWLfgGQZTxcy4gVeDlJcIGR6BRCJ8QM1hqCnAFUH2n0ZmXWhTbeuGutzkwwIXYWplP4UpvKFDFJRnWMMom+wRaKs4YdwfPM990vL5WgrVVELES7hH7evAFTy8nc6tO4OBWSCz0F6JQO+V2Wy+VEiQkznt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971659; c=relaxed/simple;
	bh=9ApGTsY8uxB5PcD5HHBxIE2iGBtDP6lO/IMIeZfW83Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bD46+RcI1+nZsyVyKqWJumGkr08YQpwCztYx/PPDjPvXiMOX6ZQnoMIYhWQzx5CMX7lXwK/Y+lMNPXv9FyffbFyD+LypzeQw9pBzwgRIvbeSPzO/sEweaubB1JjWkMd7QlDascrjQ8CRoBjTsYEPmQILiDhu6Xv3L84FnRkJcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cz/AbNt1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a0c8c5f18so109585ab.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713971657; x=1714576457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l96CL3C0CMjmESU5d/Yu/i0e8lRRnuduS9TzRkrFrs8=;
        b=Cz/AbNt1Xdf4OUbM6wP0UmJ/lTr//CYR2z5BhFNhyUKcx89V29c8HbcaMdwjVB3WR3
         dGwqUT0n3lcvVyM0QYhqapM1NcN0r/pe+E+El2XgREoZOLnP5IzHc9pbIflScsYJbTE5
         uYJLBKjJMHjPKCZXIBRVvZH2iota/vPeI4VyNiYFFVEN38iEMsYreIH7ztJ/8Qj+l1J/
         40UmBiHA7h+rHPpVCxUeqbD0rXL9/duwhYjophMvdbqqpgPgrnKeEbsoVmoywz8PQEQk
         JtFbubS6RDJzaVJK/4kfv31RKmFauUpjDdwUHy40MJCnUfg9wtJ6obdT6j601oqR/N0z
         kvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971657; x=1714576457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l96CL3C0CMjmESU5d/Yu/i0e8lRRnuduS9TzRkrFrs8=;
        b=h785IxfGyl87fFj32sJhh7t9pUET8acYvYM4U1f1GJM+t5BPX6hdoDmdaTSNrxvVm7
         C0lRAlkbGPXosr0RcGMZGV4i/6Kw4vQqsz6vlD48xjvGHIrkjoP14uWvL0sFNpgfFme/
         Lj0IULFa6cCA1fc0oA9FVFmaoWdRdPbmLO5IppppjMZudaW2juccQo9sZ75WI9ksBGOi
         HmcxUUcgQi1MVIzrESUmyY8L3UUuZYNTY2/dW+z07XBDZHllfx6wXhJh12IRyq7xNtlw
         F5oQt1DxZPWI3ggqI9wxvryOM6RMqKQbm8E6mbPmiqbLjtdGW0nBkcb6G3G1NYRFMYuj
         in9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCVpFSAU8fXN1BN9jV7VdwWLFGiii1yxsb0rADXH3Vs12DwntPPqpSBqko2s7sUjMUn1Q7eniDQGPQz3rDMMGf1+Ks
X-Gm-Message-State: AOJu0Yxh4IGzPuWG+y+hyAggVML6JosaOi7nAPPQC0QQ2iIfw1s90VDE
	iKx80XevccfFw9cPgRcWlhIoaxhFkpb9AEv49LW216BwgYBXbiEDSZ17057rUsrNduD/Gxm0cyO
	/qEq94ofhZ/rZ/ITVuukKLgX9nkI/pNBEOt77
X-Google-Smtp-Source: AGHT+IF1c/EmZd9psYA18Gea/5hrwJliRY1WEl7Zid/rcAB2YtofHNqZVPhKqZjEnOZaG/rK0JCnXz3rEn7q6LLfybA=
X-Received: by 2002:a92:c9c9:0:b0:36b:fbb3:2e96 with SMTP id
 k9-20020a92c9c9000000b0036bfbb32e96mr227535ilq.22.1713971656469; Wed, 24 Apr
 2024 08:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com> <CAHBxVyF-u__MY9BNkqxUJg4ra76CzT0p_JBVaQqZm=u4V4u5AQ@mail.gmail.com>
In-Reply-To: <CAHBxVyF-u__MY9BNkqxUJg4ra76CzT0p_JBVaQqZm=u4V4u5AQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Apr 2024 08:14:02 -0700
Message-ID: <CAP-5=fXqtvorr8JVwbEFubhAkcF2FTWNSzB+8G7En-9-rjfCdQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Consistently prefer sysfs/json events
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:28=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> On Mon, Apr 15, 2024 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > As discussed in:
> > https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.c=
om/
> > preferring sysfs/json events consistently (with or without a given
> > PMU) will enable RISC-V's hope to customize legacy events in the perf
> > tool.
> >
>
> Thanks for remapping legacy events in a generic way. This looks great
> and got rid of my
> ugly arch specific way of remapping.  Is there a good way for the
> driver (e.g via sysfs) to tell the perf tool
> whether to remap the legacy event or not ?
>
> In RISC-V the legacy systems without the new ISA extension may not
> want to remap if running
> the latest kernel.
>
> I described the problem in detail in the original thread as well.
> https://lore.kernel.org/lkml/63d73f09-84e5-49e1-99f5-60f414b22d70@rivosin=
c.com/

So the sysfs/json events have priority over the legacy hardware events
with this patch series. I'm not clear on your question but here are
some scenarios:

1) for a vendor/model with a CPUID json files want to be used:
1.1) the driver shouldn't advertise the events /sys/devices/<pmu name>/even=
ts
1.2) the json in the perf tool needs to have a mapfile.csv entry for
the cpuid to a model directory containing the event json. In the
directory the legacy events should be defined.

2) for a vendor/model with a CPUID the driver files should be used:
2.1) the driver should advertise the events in /sys/devices/<pmu name>/even=
ts
2.2) in the json for the CPUID avoid redefining the events

3) for a vendor/model with a CPUID the legacy events should be used:
3.1) the driver shouldn't advertise the events in /sys/devices/<pmu name>/e=
vents
3.2) in the json for the CPUID avoid defining the events

Are you asking to have both sysfs and json events for a model? In this
case, which have priority over the other? It's possible in the pmu.c
code to have a prioritized lookup either from json then sysfs or
vice-versa, at the moment it is first come first served. To some
extent this can be seen on Intel uncore events where there are both
sysfs and json events with the same config, when we reverse map if the
sysfs name is loaded then it is reverse mapped in verbose log or by
perf trace, whilst typically I think the json name is reverse mapped.
Are you asking for the search order to be configurable by the driver?
In the past I've considered that the search order may be configured in
the tool and the user may want to provide their own directory
containing additional events and metrics.

> FWIW, for the entire series.
> Tested-by: Atish Patra <atishp@rivosinc.com>

Thanks, I think we can go ahead to land this. Kan's comment was to ask
for a follow up changing max_precise behavior and I'm hesitant to do
two behavior changes in 1 patch series.

Ian

> > Some minor clean-up is performed on the way.
> >
> > v2. Additional cleanup particularly adding better error messages. Fix
> >     some line length issues on the earlier patches.
> >
> > Ian Rogers (16):
> >   perf parse-events: Factor out '<event_or_pmu>/.../' parsing
> >   perf parse-events: Directly pass PMU to parse_events_add_pmu
> >   perf parse-events: Avoid copying an empty list
> >   perf pmu: Refactor perf_pmu__match
> >   perf tests parse-events: Use branches rather than cache-references
> >   perf parse-events: Legacy cache names on all PMUs and lower priority
> >   perf parse-events: Handle PE_TERM_HW in name_or_raw
> >   perf parse-events: Constify parse_events_add_numeric
> >   perf parse-events: Prefer sysfs/json hardware events over legacy
> >   perf parse-events: Inline parse_events_update_lists
> >   perf parse-events: Improve error message for bad numbers
> >   perf parse-events: Inline parse_events_evlist_error
> >   perf parse-events: Improvements to modifier parsing
> >   perf parse-event: Constify event_symbol arrays
> >   perf parse-events: Minor grouping tidy up
> >   perf parse-events: Tidy the setting of the default event name
> >
> >  tools/perf/tests/parse-events.c |   6 +-
> >  tools/perf/util/parse-events.c  | 482 ++++++++++++++++----------------
> >  tools/perf/util/parse-events.h  |  49 ++--
> >  tools/perf/util/parse-events.l  | 196 +++++++++----
> >  tools/perf/util/parse-events.y  | 261 +++++++----------
> >  tools/perf/util/pmu.c           |  27 +-
> >  tools/perf/util/pmu.h           |   2 +-
> >  7 files changed, 540 insertions(+), 483 deletions(-)
> >
> > --
> > 2.44.0.683.g7961c838ac-goog
> >

