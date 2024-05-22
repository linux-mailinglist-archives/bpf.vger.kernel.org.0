Return-Path: <bpf+bounces-30308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF48CC4E0
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CD72826CE
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1E1411E0;
	Wed, 22 May 2024 16:27:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6C13D8AA;
	Wed, 22 May 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395227; cv=none; b=qrdZ1PFQ3M7lO9aoSbMSnIVqFKwQ7mG9CPKtGeZ4tt9OWZzTO9iHdCgAfkiP5VVG8bxgsnn3fdVYTRqfqPCa1rnGKUqgbeR7kmX9mQ1Z0Q01bASYlL+HwU5go5wtsCS0sVqYBIJ+8XjMp9keUssxyB+cpniIAzufV5VfVOYEoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395227; c=relaxed/simple;
	bh=RxdI4F1CKShHGVqWnvdKwtmWY+Plt0lPfkZWLBQ25so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arUfP7RbJFE71uqq6sX8AT3s+UbFdnS7zr+KFU8FgleKr1fPR1JwpwrlBRHaZz+R275z5A2UsGYrpE1i0nxq/tmmLb9Mu/vHic9r8GxdglTY+wAbd4ZtC0sKppFT+KgrgTC+bHa4LzNuOuJrIX6ME6F+alryhkkJDIWdla10APY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b9dcc745a4so2223307a91.2;
        Wed, 22 May 2024 09:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716395225; x=1717000025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71bEdcCFAmtnhRQcl2H8cfdDF/yHlhWYnXTomnqsrKc=;
        b=BbuiukBl18V40IhHFesoyvib/8QCFGHOmwgVS9I0I6H0BSbQh2DiRdHKJWGD7+W9JV
         AQny2iPc+GqMtawPM6uYvlndly4BGLsVN2cja9aIjO4sK9oR7nR5Dr6HegusUNheD3on
         REK0djE1vNqHGB1/wcPDeY7SQEHhJCi3/+N4qwBzKm5YqlkOaDAGB2D9/cwv8/Uo0P2W
         voibaTlNtDNQpX/eZguamyWYhV4n+LeYTRo+wvwI08GX3JGYxaD+4x90PDUNzPitEFL6
         eSZ+U2a0s4sAfw0zhWFPPs0HYANtyob+7vXDgcPICu/lQhSMoW/YCnUadcHP67ZVQ0SO
         Jvyg==
X-Forwarded-Encrypted: i=1; AJvYcCUqou7TjMHrHb1qX9kClg/F+Xhedvdi4sqA1aqcMiH3UVFOrVOAM4FVUs5sGiNEljc5V3QLG133nQJcZNQtg29jdajATMZnaXKfCVnfFbtvVzi8kph2Zc4jEU44cq/eeuIMn/F0WHraAQ8ookACJs3QgjzGPahQilXAqn+STDt8+X+2aw==
X-Gm-Message-State: AOJu0YyQ3qUjvKAqi8Q0sbC/bKfwGrRKHOOuIRZcwnX2lDgcL36Cqfnk
	lyS8xC2r3LlfVHqPDg75wZx7tGCL9HeMqy34fHKJh3ksVrBzETOlisyhmt2Z8aaNP1MUbmFbnKo
	dJNX/gloNAJio5xsFTcJ4WOdhisg=
X-Google-Smtp-Source: AGHT+IGWE9gpTA5nNjGHhEjGrcBHdnlVHlvBKEjJN9nhqa6bh9ue7l3uNmtMY/c0FUQvqszCGGc+MVbAoNoqkYdYNn8=
X-Received: by 2002:a17:90a:17a5:b0:2ad:c098:ebca with SMTP id
 98e67ed59e1d1-2bd9f4895a1mr2492001a91.20.1716395225061; Wed, 22 May 2024
 09:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com>
In-Reply-To: <20240515193610.2350456-1-yabinc@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 22 May 2024 09:26:52 -0700
Message-ID: <CAM9d7cjmJHC91Q-_V7trfW-LtQVbraSHzm--iDiBi7LgNwD2DA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] perf/core: Check sample_type in sample data saving
 helper functions
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 15, 2024 at 12:36=E2=80=AFPM Yabin Cui <yabinc@google.com> wrot=
e:
>
> Hello,
>
> We use helper functions to save raw data, callchain and branch stack in
> perf_sample_data. These functions update perf_sample_data->dyn_size witho=
ut
> checking event->attr.sample_type, which may result in unused space
> allocated in sample records. To prevent this from happening, this patchse=
t
> enforces checking sample_type of an event in these helper functions.
>
> Thanks,
> Yabin
>
>
> Changes since v1:
>  - Check event->attr.sample_type & PERF_SAMPLE_RAW before
>    calling perf_sample_save_raw_data().
>  - Subject has been changed to reflect the change of solution.
>
> Changes since v2:
>  - Move sample_type check into perf_sample_save_raw_data().
>  - (New patch) Move sample_type check into perf_sample_save_callchain().
>  - (New patch) Move sample_type check into perf_sample_save_brstack().
>
> Changes since v3:
>  - Fix -Werror=3Dimplicit-function-declaration by moving has_branch_stack=
().
>
> Changes since v4:
>  - Give a warning if data->sample_flags is already set when calling the
>    helper functions.
>
> Original commit message from v1:
>   perf/core: Trim dyn_size if raw data is absent
>
> Original commit message from v2/v3:
>   perf/core: Save raw sample data conditionally based on sample type
>
>
> Yabin Cui (3):
>   perf/core: Save raw sample data conditionally based on sample type
>   perf/core: Check sample_type in perf_sample_save_callchain
>   perf/core: Check sample_type in perf_sample_save_brstack

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  arch/s390/kernel/perf_cpum_cf.c    |  2 +-
>  arch/s390/kernel/perf_pai_crypto.c |  2 +-
>  arch/s390/kernel/perf_pai_ext.c    |  2 +-
>  arch/x86/events/amd/core.c         |  3 +--
>  arch/x86/events/amd/ibs.c          |  5 ++---
>  arch/x86/events/core.c             |  3 +--
>  arch/x86/events/intel/ds.c         |  9 +++-----
>  include/linux/perf_event.h         | 26 +++++++++++++++++-----
>  kernel/events/core.c               | 35 +++++++++++++++---------------
>  kernel/trace/bpf_trace.c           | 11 +++++-----
>  10 files changed, 55 insertions(+), 43 deletions(-)
>
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

