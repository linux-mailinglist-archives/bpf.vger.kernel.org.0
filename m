Return-Path: <bpf+bounces-32951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F211915938
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E0284C99
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F01A2545;
	Mon, 24 Jun 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6MrxJ+j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A011A0B13
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265629; cv=none; b=fLdWz95mIEIB2M07LXAogiLs/13f03EIN+nCjyEqPx/cyskPDECGt5WxiTnQbrxwPUwXz9G7EE2jAp/IZ8J48IAGv9AmTnKx0ZJC7xakMJdfDfLmJDnQ6VROEZYBS8VK8Gi0q7ysMssk3HN4UCMQPOPPLnAU675weNashFFr4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265629; c=relaxed/simple;
	bh=1uVEUqdRcUo/rJ5R+c++NPkM94ZB+DuQFRakCKBJoYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TxgwxnA0WlBQX6u3W9HbKCPg7Ob2yxv8wn9K0YKht6IIEOO3gy6celmgI263rq486XbHH62QMlo62KdXIPX7kiGtQAXWUmmKd1cLyor0YS1az2soPuBrpH6E2QjhkvU646Uei0J7QdWPjekVeWT7cSle/kTMsInc6uWEaXeAYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6MrxJ+j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso26995ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719265627; x=1719870427; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryU5o2yVn1i6Iaousq7WSn7w6bux8oEB7sHmGtnV9uI=;
        b=p6MrxJ+jFadwPQYB2bHJdf5etvquPE/wVv4H4PFnScMPuSlB/CVYR2Ud654BOpa0Xn
         2dWTZ6vAIagU9M+Zs7ET+mXeOXs9Bwb24fZgEkIM7IS6hnqGvuLpmxoy96S6gQOPkG7v
         Q2GtoHE3/KQ7ReSiMrIyysU64VRv7V93DpwMnL09085nDIbe+jNu93pyTry0RJiDWztD
         aaMXEAWPODT4HfQSga2PE6Tp76pHDBiy1rZHDgk8IH+x2iVh6Pg3HNI4YJyvhSVa8MOM
         nUXBzleVL1gYSPi2hxDU6r7dh7OQ65FJvubVyMeGTulzvYngqMNPyuKL7CPwI7QuqGok
         KohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265627; x=1719870427;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryU5o2yVn1i6Iaousq7WSn7w6bux8oEB7sHmGtnV9uI=;
        b=rUhq8tnL5k59zVzZ3J7A3Tp1JwqNW/HsKLwKIdOZg2Iy195xU3k8vWvGIWsE0Hrsw7
         FlauWQOjWkhZmu/ftTUMF6ATbNKWfyJXEui+PKtbTuLAWihNGYsQWaxYx4kXPmaSRUif
         dpKXWhdr6KFGsOUUFd02UKKR/3FqXmfXZTDNe+cQeGuAamncBLCjEdkOJjzcQ87/z86g
         za2gCMSe3rZqs6PEZAWVgs0YSWbS9EwHpwREHaG2qGkN5AmK3eKvoRNeUIx5XvqyqvKy
         FiEbIC6I/VzEhWsyFw9tbWq+QzLDGdJnuDtztRFbTvOZGlKUuETfEJhx0j2vpZn3MNSx
         aFvA==
X-Forwarded-Encrypted: i=1; AJvYcCXIKBKXmRlwgF3tcxl5s2B/8seb9aYPNAWvfazzZSeuMOA6ZDDFkEb5s9qLvGlcAanRYrno1f5Lk3CBmZ/vVNbJbyK3
X-Gm-Message-State: AOJu0YyrBwlq7tMo95A0uwsBdQw7EhNRkxaGvzXhvua/bbKSqH+KiAv7
	gZzYaH4TGFuwp/Fq0i6+/WhcKfBGr+uJ2KSNnyrWFabI9N7V+OCzyUh8MLfqY16B5Ml8zuLXpls
	XjzF7S0mYM1wew46AUe1DolW0MgvRt/hDwIR+
X-Google-Smtp-Source: AGHT+IEJrMsRDVKc4wpx0FBdMJnJosYDDYfqfwciz733n6udVWvghsvDjxQCFEC37EnR/1LLitbb/jf7rxP7dJ9fEkQ=
X-Received: by 2002:a17:902:bd47:b0:1f7:1c96:d2e8 with SMTP id
 d9443c01a7336-1fa68fb23efmr1044215ad.10.1719265626724; Mon, 24 Jun 2024
 14:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Jun 2024 14:46:54 -0700
Message-ID: <CAP-5=fWZDZWvrysEzL7H2kAXNBhFd3=kcmz1N=W+HgwGPsBPDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Refactor perf python module build
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, coresight@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:31=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Refactor the perf python module build to instead of building C files
> it links libraries. To support this make static libraries for tests,
> ui, util and pmu-events. Doing this allows fewer functions to be
> stubbed out, importantly parse_events is no longer stubbed out which
> will improve the ability to work with heterogeneous cores.
>
> By not building .c files for the python module and for the build of
> perf, this should also help build times.
>
> Patch 1 adds '*.a' cleanup to the clean target.
>
> Patches 2 to 6 add static libraries for existing parts of the perf
> build.
>
> Patch 7 adds the python build using libraries rather than C source
> files.
>
> Patch 8 cleans up the python dependencies and removes the no longer
> needed python-ext-sources.
>
> v3: Add missed xtensa directory for the util build. Remove adding the
>     arch directory to perf-y as it creates an empty object file that
>     breaks with GCC and LTO.
> v2: Add '*.a' cleanup to clean target. Add reviewed-by James Clark.

Ping.

Thanks,
Ian

> Ian Rogers (8):
>   perf build: Add '*.a' to clean targets
>   perf ui: Make ui its own library
>   perf pmu-events: Make pmu-events a library
>   perf test: Make tests its own library
>   perf bench: Make bench its own library
>   perf util: Make util its own library
>   perf python: Switch module to linking libraries from building source
>   perf python: Clean up build dependencies
>
>  tools/perf/Build                              |  14 +-
>  tools/perf/Makefile.config                    |   5 +
>  tools/perf/Makefile.perf                      |  83 +++-
>  tools/perf/arch/Build                         |   5 +-
>  tools/perf/arch/arm/Build                     |   4 +-
>  tools/perf/arch/arm/tests/Build               |   8 +-
>  tools/perf/arch/arm/util/Build                |  10 +-
>  tools/perf/arch/arm64/Build                   |   4 +-
>  tools/perf/arch/arm64/tests/Build             |   8 +-
>  tools/perf/arch/arm64/util/Build              |  20 +-
>  tools/perf/arch/csky/Build                    |   2 +-
>  tools/perf/arch/csky/util/Build               |   6 +-
>  tools/perf/arch/loongarch/Build               |   2 +-
>  tools/perf/arch/loongarch/util/Build          |   8 +-
>  tools/perf/arch/mips/Build                    |   2 +-
>  tools/perf/arch/mips/util/Build               |   6 +-
>  tools/perf/arch/powerpc/Build                 |   4 +-
>  tools/perf/arch/powerpc/tests/Build           |   6 +-
>  tools/perf/arch/powerpc/util/Build            |  24 +-
>  tools/perf/arch/riscv/Build                   |   2 +-
>  tools/perf/arch/riscv/util/Build              |   8 +-
>  tools/perf/arch/s390/Build                    |   2 +-
>  tools/perf/arch/s390/util/Build               |  16 +-
>  tools/perf/arch/sh/Build                      |   2 +-
>  tools/perf/arch/sh/util/Build                 |   2 +-
>  tools/perf/arch/sparc/Build                   |   2 +-
>  tools/perf/arch/sparc/util/Build              |   2 +-
>  tools/perf/arch/x86/Build                     |   6 +-
>  tools/perf/arch/x86/tests/Build               |  20 +-
>  tools/perf/arch/x86/util/Build                |  42 +-
>  tools/perf/arch/xtensa/Build                  |   2 +-
>  tools/perf/bench/Build                        |  46 +-
>  tools/perf/scripts/Build                      |   4 +-
>  tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
>  .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
>  tools/perf/tests/Build                        | 140 +++----
>  tools/perf/tests/workloads/Build              |  12 +-
>  tools/perf/ui/Build                           |  18 +-
>  tools/perf/ui/browsers/Build                  |  14 +-
>  tools/perf/ui/tui/Build                       |   8 +-
>  tools/perf/util/Build                         | 394 +++++++++---------
>  tools/perf/util/arm-spe-decoder/Build         |   2 +-
>  tools/perf/util/cs-etm-decoder/Build          |   2 +-
>  tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
>  tools/perf/util/intel-pt-decoder/Build        |   2 +-
>  tools/perf/util/perf-regs-arch/Build          |  18 +-
>  tools/perf/util/python-ext-sources            |  53 ---
>  tools/perf/util/python.c                      | 271 +++++-------
>  tools/perf/util/scripting-engines/Build       |   4 +-
>  tools/perf/util/setup.py                      |  33 +-
>  50 files changed, 625 insertions(+), 729 deletions(-)
>  delete mode 100644 tools/perf/util/python-ext-sources
>
> --
> 2.45.2.627.g7a2c4fd464-goog
>

