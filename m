Return-Path: <bpf+bounces-27607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B08AFD59
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C258B284369
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14543224;
	Wed, 24 Apr 2024 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FvDEDUK4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70164639
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918496; cv=none; b=HesLCuNSnoGTU36oq583kgeN8+sTsPj2wSmwkOxM0krFL0tdocSoi03IwRLJMVlCrPOBBJLnJHPA5b7A1c1+THTWWMbgt4hooHO5y14tLHWu6X+ZPely5or+Ktbfi0UcL+m1/BFmgE1F0DSTTVCfbWZ19i9C99L5X0iazeQSqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918496; c=relaxed/simple;
	bh=R/OgSmiO5urrOxI3K+4q4wNzXhrJbrqWVoXEWuijYx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFPEWHRDqRWAvkEzJQ3MduMpl/cBjEho/7jKwdJocdsdpWPMM+X9g8F1J/ErUl5rnqEZsNXGprgcaggkWF95yXUyn5UYcEObqfMVav8+4f2b6mPGriHYbFbuFA4PBSd2rFRZsEzH2Ne/6PJmGlIbrTJrcwM4s7cQHUEKTN6YBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FvDEDUK4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5193363d255so8346214e87.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713918491; x=1714523291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXU+ikToE9vTgd0d2ogVMdIIk0usIDCY3palNyF75i4=;
        b=FvDEDUK49YxIx6JmmZnqcjWAK8rb8EFRKf4UjII+hm7SJcl/MZqnBCRWM0ag8Q3+EO
         yyz3VLEBGWAd2lZ2rl7iidbe69JZ/hDgOcEgytBi2RtPrWVdgPZfYZD72YXv8kKKfUlS
         dSQLYMnW0iW6SR/lAUipjpC20TPZ/1YphTSWUyL7k/zYTRWAvZT2l8qsGwawqgCrMp9d
         hE4u37bQYk97SxcHeSfgELYBVGSfRw3RmAGcSlora4d2oYxQ1nwEx4NAGUaQ8bhWRit/
         z2w1Ap5K3RdbFDWeJU27yifdwjz97VnqHC5UOxsehTXEf0Zuex1cGWKgJCuNF3ywFSBT
         WiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918491; x=1714523291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXU+ikToE9vTgd0d2ogVMdIIk0usIDCY3palNyF75i4=;
        b=T9Qb859qsW1yyGDxN8azt4VgEdZmEGdKUzBEEEWx5YoyURo10800JDRVcXXo/5jtdR
         lAyALCqtwC4mRKUuX2/pTRpd7wJwDobPi2z5aLD4u3QLdIoyCDe4LltYn3aGVydNNf4T
         5CYq/NQBwombGUKxDAwJCaiZVgSShMLMmHtSZUQcg7on9riClwCXFlrJ3Dxu1TcJjIIM
         u8aF4Pqw3YFCr+X061ZDPho9egf35qaxdAAPFOQW73K2IBsA99XuYXA4nbhaLTuILCVE
         XPRS6p2je73PgKAhaPi0AxtebWd3rOcNQl9F+EWD92pSy6qbML0Bv6QEM3teO3Ayu+UX
         4M/w==
X-Forwarded-Encrypted: i=1; AJvYcCVzYSuJWsHnfFhG/Gx6M9WY4ZtO6MwyeL0SR6I7ha5uZNT89TKellCKSE9yIKNVsrFSMJsYPfwSPd++G7NQ96+3EesP
X-Gm-Message-State: AOJu0Yw65EhrhqF0WXADRzzWgkJksSxzmG1q/dLeP/CsLAlV1HBjet9O
	fcrXSOjCEK/TcHJ50YqmDokADfgOW4Z8DO6DRdz+FCMe8cA7A5tltJkyDYLVKnejiQh3FEMRLyL
	6LWEmxXdO/rnWuroB5AP6eqlnL32CzUWOpvZtRsBRwxEPfdWzM/o=
X-Google-Smtp-Source: AGHT+IFmAtveWqF5KaXct/eDRNhEoPLTdbLM1bttvHvTHWx51gYkcxlUgQIhdEx7nF7tg8XpB0fvpPToj5um1tKlVE0=
X-Received: by 2002:a19:914d:0:b0:516:c696:9078 with SMTP id
 y13-20020a19914d000000b00516c6969078mr607660lfj.50.1713918491483; Tue, 23 Apr
 2024 17:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 23 Apr 2024 17:28:00 -0700
Message-ID: <CAHBxVyF-u__MY9BNkqxUJg4ra76CzT0p_JBVaQqZm=u4V4u5AQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Consistently prefer sysfs/json events
To: Ian Rogers <irogers@google.com>
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

On Mon, Apr 15, 2024 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As discussed in:
> https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com=
/
> preferring sysfs/json events consistently (with or without a given
> PMU) will enable RISC-V's hope to customize legacy events in the perf
> tool.
>

Thanks for remapping legacy events in a generic way. This looks great
and got rid of my
ugly arch specific way of remapping.  Is there a good way for the
driver (e.g via sysfs) to tell the perf tool
whether to remap the legacy event or not ?

In RISC-V the legacy systems without the new ISA extension may not
want to remap if running
the latest kernel.

I described the problem in detail in the original thread as well.
https://lore.kernel.org/lkml/63d73f09-84e5-49e1-99f5-60f414b22d70@rivosinc.=
com/

FWIW, for the entire series.
Tested-by: Atish Patra <atishp@rivosinc.com>

> Some minor clean-up is performed on the way.
>
> v2. Additional cleanup particularly adding better error messages. Fix
>     some line length issues on the earlier patches.
>
> Ian Rogers (16):
>   perf parse-events: Factor out '<event_or_pmu>/.../' parsing
>   perf parse-events: Directly pass PMU to parse_events_add_pmu
>   perf parse-events: Avoid copying an empty list
>   perf pmu: Refactor perf_pmu__match
>   perf tests parse-events: Use branches rather than cache-references
>   perf parse-events: Legacy cache names on all PMUs and lower priority
>   perf parse-events: Handle PE_TERM_HW in name_or_raw
>   perf parse-events: Constify parse_events_add_numeric
>   perf parse-events: Prefer sysfs/json hardware events over legacy
>   perf parse-events: Inline parse_events_update_lists
>   perf parse-events: Improve error message for bad numbers
>   perf parse-events: Inline parse_events_evlist_error
>   perf parse-events: Improvements to modifier parsing
>   perf parse-event: Constify event_symbol arrays
>   perf parse-events: Minor grouping tidy up
>   perf parse-events: Tidy the setting of the default event name
>
>  tools/perf/tests/parse-events.c |   6 +-
>  tools/perf/util/parse-events.c  | 482 ++++++++++++++++----------------
>  tools/perf/util/parse-events.h  |  49 ++--
>  tools/perf/util/parse-events.l  | 196 +++++++++----
>  tools/perf/util/parse-events.y  | 261 +++++++----------
>  tools/perf/util/pmu.c           |  27 +-
>  tools/perf/util/pmu.h           |   2 +-
>  7 files changed, 540 insertions(+), 483 deletions(-)
>
> --
> 2.44.0.683.g7961c838ac-goog
>

