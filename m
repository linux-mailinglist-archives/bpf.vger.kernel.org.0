Return-Path: <bpf+bounces-29543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D18C2BE2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5961F21AA2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09C813B5AE;
	Fri, 10 May 2024 21:27:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2721E50A;
	Fri, 10 May 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376426; cv=none; b=h5dZKmSLko5QpET22pr8s7Bb+G7ARCDAkS1HbWIOAC068WAxDWNvZ9qSwJ6vJhvjWaj0bIu8Bn4R0uk8M+LEHLWIo7W60oq1taG7xc+O5NiNqRuc0YDBOBpVNktgYdyWrgIZGWz7GXGs8+HrtK8eyV3uTpZrYckqBMwjjXyks+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376426; c=relaxed/simple;
	bh=sNiPcW4CUkfv8m2+/2fjixQMwPKzfbWB6JMttm226fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r85+TbDBvNEhiDBxUQpRAi9L92/jaXgdRJn0MR3G2ZoCQa9TcOvxPCqpymoEVB9RFuNJpZSQqkuidL2R/O+DGML5FDfLHGtAuwfpwjSzhR8KudM+o948/1sODhbg8Atl9wKQ3fV4Sdbjl+udnh5HDQnpq45h6AzuF12qBFHRTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso2023638a91.1;
        Fri, 10 May 2024 14:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376424; x=1715981224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X1gWxLNMwt5MyqEDgqv2O3IwJmoQV8kPHRjNegmu3A=;
        b=caplm5ikAD4qJ7PYhuSnW1pEt/jqQEyBUVgg7UeZyJxRRJr9ap236bvu5fxPSWFF3I
         xhNB9d+6nBhxdOxSjWEYfBFlnGmR1aTEPxEXy1n3BVkvPwlCROsW3lkUUfwBIDaOJIDa
         ymQfNFY40xwZ6xVPO+Vs7pB9rIsw9UcEPXKcpGVHVkL5GZNEbkM655YdGiOq9+htw4Yx
         /Nnaiu/FDyI6zjZygBHw0mwgkqjltn67yiGILK2MyyCj6CXeBrsNikuvWdFTuj/kQ1cl
         rG20fy1dUsdZNOpYpbmx5/s0Lwtp3I7BvrRzjH+FKe5CWUwt/dPbJb17+CBeMNCuU2si
         mS0A==
X-Forwarded-Encrypted: i=1; AJvYcCUaSFA7qX2CYpUAQXWz2z0MUvN0Ig6HbpK3L79e88Mxmmn58JeurWlBAQXubqYZK3/JcqNMJRYQakYdY0uqsFGKkVISBaWcnxEUYxyPMyTeUfMG3FXtm6a3RB9k6ik8NfBRh8n9xve5zBWChRfEQq0olZvNORE4wHkGl5mf/lfzMCBz1A==
X-Gm-Message-State: AOJu0Yw/9olazOMSwhuJyhmncbCV0V5t3AMJHPPR+lMVv6ejV578fkl4
	+YAqCIGXTVe8BSo0uOOFSE71ci1TufIhCjvB0DV+d546YGU+dZrJdMy3OYWmitYzKhHz7etSXKU
	egX6vITSLm8qeScweUQ6iqwHtzlSRdQ==
X-Google-Smtp-Source: AGHT+IHO+Qt9vgonlmXZpBAZAwmVEF98AIiUDhAMrdG5mPQ9eyBhjAF1hTddtvpt/V8grIPIPFS9lU6mXOH78oLiPCA=
X-Received: by 2002:a17:90a:6886:b0:2ae:6e16:da91 with SMTP id
 98e67ed59e1d1-2b6cc97d217mr3611595a91.29.1715376424468; Fri, 10 May 2024
 14:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com>
In-Reply-To: <20240510191423.2297538-1-yabinc@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 May 2024 14:26:53 -0700
Message-ID: <CAM9d7chJLfuAf+ZryG6ae0TyB3cyDzQqxPBAZaO9UStPx_O2UA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] perf/core: Check sample_type in sample data saving
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

Hi Yabin,

On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> wrot=
e:
>
> Hello,
>
> We use helper functions to save raw data, callchain and branch stack in
> perf_sample_data. These functions update perf_sample_data->dyn_size witho=
ut
> checking event->attr.sample_type, which may result in unused space alloca=
ted in
> sample records. To prevent this from happening, this patchset enforces ch=
ecking
> sample_type of an event in these helper functions.
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
> Original commit message from v1:
>   perf/core: Trim dyn_size if raw data is absent
>
> Original commit message from v2/v3:
>   perf/core: Save raw sample data conditionally based on sample type
>
> Yabin Cui (3):
>   perf/core: Save raw sample data conditionally based on sample type
>   perf/core: Check sample_type in perf_sample_save_callchain
>   perf/core: Check sample_type in perf_sample_save_brstack

Thanks for doing this!

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
>  include/linux/perf_event.h         | 20 ++++++++++++-----
>  kernel/events/core.c               | 35 +++++++++++++++---------------
>  kernel/trace/bpf_trace.c           | 11 +++++-----
>  10 files changed, 49 insertions(+), 43 deletions(-)
>
> --
> 2.45.0.118.g7fe29c98d7-goog
>

