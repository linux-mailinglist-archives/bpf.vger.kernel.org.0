Return-Path: <bpf+bounces-31970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D55905B0A
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9998B270B0
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314555B68F;
	Wed, 12 Jun 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amjkUyZu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE694AEF2
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217210; cv=none; b=fJCBzHYq3bGVNfH8wY4IhrZN7vxjgfnxfKFFINZNnCtvv4H4DyCdsbNEQFoD3jWFIgLpzMkM+4AB+82MFcDZzVA9jY0THeqWmaEhVtuJGaK4XNc4u4o5IJ2JQGLLZQUs0tXtiWeEKVhA5eQe5se3INuQL3KrYyIoWuQjKaAkLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217210; c=relaxed/simple;
	bh=xgg4zHwGeqMcxWJL7P+K/9CH+X7F2jIwkiY5qfhp9HU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QLQjcPMiIYYIXKIAIYcLbvcZq2O6bg4TWuH2BM0c/W7RoiyW1DGqwCNuNmSPGHIS/OOl4C3ntZeTKRdRmON52Ex+VkiK+VEpH5Id+TonAG7CBGZUh/C8rLwTPNSH12upEdD4OIJfnfm895Xs8H6GJeewGF4aTZHHYruIJluoaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amjkUyZu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df79945652eso328048276.0
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217207; x=1718822007; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rm0EtUlY7qVzQZI97HOfdq0hSIaq1mUCwGuA2+Hn2yY=;
        b=amjkUyZueUzii7OyKrNUzMPmfhEbZvq+6fSgCL+qh7hkibin4ZSX5GezZGSGil2N48
         geDhXQlkOWd0b25uGnZPTA58CMSOJ+f4Eydz/8fBwOsAnD4b5Kt5VEgFu/oiCwJQc7HE
         xrbmOzjC5ZPru7j07AclvJvPelxw5SNdksO4ne1eyIBH0vD1CBlbUdFOcRH2Ku0dF1Q4
         1GgBb3WYw9gkHtDPWBqRX/mQnQ3WCRG4sBcGY/4ZLHYN1zeBTBTkSfu3hR2VBSCIbn/W
         ND1/bXfe+2llFtu5bCP/wwT+9P9ZdV6d3hWmJ0kEACzmQpV1g0yPZBqGuPGXCUXOFaDG
         a0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217207; x=1718822007;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rm0EtUlY7qVzQZI97HOfdq0hSIaq1mUCwGuA2+Hn2yY=;
        b=s934sLkdgml3cbDVJ3QLmsYlgzHl53GeRFY/6+9lq4lEu9Qdi/DG/VVYlZ8SGUBC+B
         qwTFfnhe+fSuxn2YNP2/vGApA97O9/pBroIoTq8i3z0C5dzGywRfFVVILDBmsxbzq+WU
         S4BCiipC1xtCCwVX5WtonVPXuDdVS2vq9Er1NtFfSx2D8MNTzP1UbCwqUKKfq/jUD9vL
         o7Fca+1PqFfMIGy+2tti20QOsXiuOd9xAnW2comTrDMEzyVog7q84BSHi2yipCv4R98d
         DnsjrJp9HkL+aGSPOOaeKrGqlnpGR9G9dRXu/UdtJiMXgY1SCh+6YMtSAmQD92ts67oH
         y0SA==
X-Forwarded-Encrypted: i=1; AJvYcCVDdUMJp0D6gFNZc0s4zPcikK1ktUIhHC8FoFfRZim6iVgswU/ckr2obGFg0Iv3+arMbUnehhX7+ArGpoeJBY/kS2VT
X-Gm-Message-State: AOJu0Yx2SbOHxkoJFkEqqIh/NP2hNmKCFtdwDMb+oVFE6ATtJMmwk5+F
	TgUgKUPRiURp3bWFY7hmVQEp39JlTvnqo6ld6WbFKNY1Kcd0JMCYF7oaKX7xxcqbwtqHqR2sJRH
	FcgEODg==
X-Google-Smtp-Source: AGHT+IH1yI9i/s+26+jM/E/uI8+fPG/zWe9dsO6CmMohvLKaJEU2deKggpKC2BICy6YM6dj4+CXqvZYdg/vu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:959d:4302:db0e:d12a])
 (user=irogers job=sendgmr) by 2002:a25:c841:0:b0:dfb:197c:8caf with SMTP id
 3f1490d57ef6-dfe66b6704fmr445067276.6.1718217207099; Wed, 12 Jun 2024
 11:33:27 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:31:58 -0700
Message-Id: <20240612183205.3120248-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1 0/7] Refactor perf python module build
From: Ian Rogers <irogers@google.com>
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
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor the perf python module build to instead of building C files
it links libraries. To support this make static libraries for tests,
ui, util and pmu-events. Doing this allows fewer functions to be
stubbed out, importantly parse_events is no longer stubbed out which
will improve the ability to work with heterogeneous cores.

Patches 1 to 5 add static libraries for existing parts of the perf
build.

Patch 6 adds the python build using libraries rather than C source
files.

Patch 7 cleans up the python dependencies and removes the no longer
needed python-ext-sources.

Ian Rogers (7):
  perf ui: Make ui its own library
  perf pmu-events: Make pmu-events a library
  perf test: Make tests its own library
  perf bench: Make bench its own library
  perf util: Make util its own library
  perf python: Switch module to linking libraries from building source
  perf python: Clean up build dependencies

 tools/perf/Build                              |  14 +-
 tools/perf/Makefile.config                    |   5 +
 tools/perf/Makefile.perf                      |  66 ++-
 tools/perf/arch/Build                         |   4 +-
 tools/perf/arch/arm/Build                     |   4 +-
 tools/perf/arch/arm/tests/Build               |   8 +-
 tools/perf/arch/arm/util/Build                |  10 +-
 tools/perf/arch/arm64/Build                   |   4 +-
 tools/perf/arch/arm64/tests/Build             |   8 +-
 tools/perf/arch/arm64/util/Build              |  20 +-
 tools/perf/arch/csky/Build                    |   2 +-
 tools/perf/arch/csky/util/Build               |   6 +-
 tools/perf/arch/loongarch/Build               |   2 +-
 tools/perf/arch/loongarch/util/Build          |   8 +-
 tools/perf/arch/mips/Build                    |   2 +-
 tools/perf/arch/mips/util/Build               |   6 +-
 tools/perf/arch/powerpc/Build                 |   4 +-
 tools/perf/arch/powerpc/tests/Build           |   6 +-
 tools/perf/arch/powerpc/util/Build            |  24 +-
 tools/perf/arch/riscv/Build                   |   2 +-
 tools/perf/arch/riscv/util/Build              |   8 +-
 tools/perf/arch/s390/Build                    |   2 +-
 tools/perf/arch/s390/util/Build               |  16 +-
 tools/perf/arch/sh/Build                      |   2 +-
 tools/perf/arch/sh/util/Build                 |   2 +-
 tools/perf/arch/sparc/Build                   |   2 +-
 tools/perf/arch/sparc/util/Build              |   2 +-
 tools/perf/arch/x86/Build                     |   6 +-
 tools/perf/arch/x86/tests/Build               |  20 +-
 tools/perf/arch/x86/util/Build                |  42 +-
 tools/perf/bench/Build                        |  46 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/tests/Build                        | 140 +++----
 tools/perf/tests/workloads/Build              |  12 +-
 tools/perf/ui/Build                           |  18 +-
 tools/perf/ui/browsers/Build                  |  14 +-
 tools/perf/ui/tui/Build                       |   8 +-
 tools/perf/util/Build                         | 394 +++++++++---------
 tools/perf/util/arm-spe-decoder/Build         |   2 +-
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   2 +-
 tools/perf/util/perf-regs-arch/Build          |  18 +-
 tools/perf/util/python-ext-sources            |  53 ---
 tools/perf/util/python.c                      | 271 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 49 files changed, 612 insertions(+), 722 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

-- 
2.45.2.505.gda0bf45e8d-goog


