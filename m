Return-Path: <bpf+bounces-49501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB983A197DD
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA883AA5A5
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E92153FB;
	Wed, 22 Jan 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/myvM9H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AE216E0E
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567795; cv=none; b=S+LqXbBnmQIKg29zf6AP2pHXk1vOG3CWgMmZKIku7l0kQZPiJtq7wx4SEVEWBwxox0n/dFPUkN2Ycoar47W/7+7HnMMLo0xgwwwBevor+A/6YK166R1BJF5JyutkmBd8ysJUfdLffRVS+NNzeF1wDz+Ks6rVwpS2pE3xazLNNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567795; c=relaxed/simple;
	bh=9VN6QjInjpqpeMllAh6JGaiVUlDwgMRGIx3r+D/S8Ko=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=DAzYk7S0oet8DD/ov2sAI+UHexTzJZSsDfDh4o5ggmKWV9GuZMWrUhVg6Oa/Tn+/1ksCmw9/Y98RSPARfp70AroL5ikyrMeaSShnpgsg8WSYrxKkPHY2lU4ms3bVGvxQnJxYr4LHU6l0LBuJOXZIDrmvrTMYFmy3IdbarbFhdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/myvM9H; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e580a642582so8514276.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567793; x=1738172593; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z9uCPHRntHbZ9KmMQl+SuBXWGQGzkHWS/clQSy2B2wo=;
        b=N/myvM9HY50KHeSQAy6fzb6Pdc7HB8dHn3eEjR4fCazr3kPsLc2hdBWrJ9DaximKDk
         mh76OnCe/LtYxLpETyjGLMG9wLP7JB1LXcJYDitjPqD/8wEoThc88f74dFYtoQnG8LFf
         6+Vmeq18AvHvARYag6+W9V0SVZz685e8R41shuhV+9qFC7j8q8Xl4r3Vwe5v3U/QWLfT
         cP2bN1Dx5HQrOBNe1mFzW3psNJHX6GFVPGc9ZnrcwVWiE/LUXgyc42aW2FOSBeuckjoS
         u6Hl7GI/Xf/gBnAS+y1glgKAZOatR49uBWDX8pgSAbSHxRda/+suCqEQQ5ePCzUZR1If
         eZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567793; x=1738172593;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9uCPHRntHbZ9KmMQl+SuBXWGQGzkHWS/clQSy2B2wo=;
        b=TiHjVkq3ypV8DxEZNyVE920TI/QootNwT+mudFcV84S7zWP+heykz13of6F8wtzneq
         9Jfekxf9V7sKqQAWGwtohGrr3chrKYGNBr9+w9VbKIwJjevYgNp3aLrfBLV+fN/wJpBm
         knvh/43f3KyTL5jix+TuvekNHFfw/Gp6iiKGqfli4MYwHqTJWZNU9szOlwkpoblo6+Vx
         2l72XxusyuYIR8rCvkNpzRy11EPx3qFmHFWwAy+QC4t0KY7ImluoOF53mrNKIy2NXStS
         mRLUuL8ZQefIhCV2B8ZPwenNREYD2Qs2MdIN+L/c1GhhghJYNRvBkP6g76Dn34/XxvIc
         lbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNtw3LMP3ofozFDeyfPP9rvHL8stfDEx48XwOwIFXB97cDKRdFUNEElBak+qOpVFG7+bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlztf06HtROCUgwCYS00b4YhbqUeFqm6fiJ8pC0UmmKquavin
	XOvm2ZYrnicD0sh4q2o4ennDbyKC6CivH5hn/sPLHkXYww4AVD1HEL4o7XH6Wj//jbeXeGi04nz
	h4d0OBA==
X-Google-Smtp-Source: AGHT+IFh6plgusKalIV+rt0enhRru7sGKX4DpTeUM13POHq5b3JfO6EFuKYapMGo4BFswUSO5bdUEJn66ggI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:8087:b0:6f5:53f7:9d40 with SMTP
 id 00721157ae682-6f6eb512461mr327917b3.0.1737567792811; Wed, 22 Jan 2025
 09:43:12 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:50 -0800
Message-Id: <20250122174308.350350-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 00/18] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Linking against libcapstone and libLLVM can be a significant increase
in dependencies and file size if building statically. For something
like `perf record` the disassembler and addr2line functionality won't
be used. Support dynamically loading these libraries using dlopen and
then calling the appropriate functions found using dlsym.

BUILD_NONDISTRO is used to build perf against the license incompatible
libbfd and libiberty libraries. As this has been opt-in for nearly 2
years, commit dd317df07207 ("perf build: Make binutil libraries opt
in"), remove the code to simplify the code base.

The patch series:
1) does some initial clean up;
2) moves the capstone and LLVM code to their own C files,
3) simplifies a little the capstone code;
4) adds perf_ variants of the functions that will either directly call
   the function or use dlsym to discover it;
5) adds BPF JIT disassembly support to LLVM and capstone disassembly;
6) removes the BUILD_NONDISTRO code, reduces scope and removes what's possible;
7) adds fallback to srcline's addr2line so that llvm_addr2line is
   tried first and then the forked command tried next, moving the code
   for forking out of the main srcline.c file in the process.

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
would extend their C API to avoid this.

The libbfd BPF disassembly supported source lines, this wasn't ported
to the capstone and LLVM disassembly.

v3: Add srcline addr2line fallback trying LLVM first then forking a
    process. This came up in conversation with Steinar Gunderson
    <sesse@google.com>.
    Tweak the cover letter message to try to address Andi Kleen's
    <ak@linux.intel.com> feedback that the series doesn't really
    achieve anything.
v2: Add mangling of the function names in libperf-llvm.so to avoid
    potential infinite recursion. Add BPF JIT disassembly support to
    LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
    series from:
    https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
    Some other minor additional clean up.

Ian Rogers (18):
  perf build: Remove libtracefs configuration
  perf map: Constify objdump offset/address conversion APIs
  perf capstone: Move capstone functionality into its own file
  perf llvm: Move llvm functionality into its own file
  perf capstone: Remove open_capstone_handle
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so
  perf llvm: Mangle libperf-llvm.so function names
  perf dso: Move read_symbol from llvm/capstone to dso
  perf dso: Support BPF programs in dso__read_symbol
  perf llvm: Disassemble cleanup
  perf dso: Clean up read_symbol error handling
  perf build: Remove libbfd support
  perf build: Remove libiberty support
  perf build: Remove unused defines
  perf disasm: Remove disasm_bpf
  perf disasm: Make ins__scnprintf and ins__is_nop static
  perf srcline: Fallback between addr2line implementations

 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  90 +--
 tools/perf/Makefile.perf                |  35 +-
 tools/perf/builtin-check.c              |   1 -
 tools/perf/builtin-script.c             |   2 -
 tools/perf/tests/Build                  |   1 -
 tools/perf/tests/builtin-test.c         |   1 -
 tools/perf/tests/make                   |   4 +-
 tools/perf/tests/pe-file-parsing.c      | 101 ----
 tools/perf/tests/tests.h                |   1 -
 tools/perf/util/Build                   |   6 +-
 tools/perf/util/addr2line.c             | 439 ++++++++++++++
 tools/perf/util/addr2line.h             |  20 +
 tools/perf/util/annotate.h              |   1 -
 tools/perf/util/capstone.c              | 682 +++++++++++++++++++++
 tools/perf/util/capstone.h              |  24 +
 tools/perf/util/config.c                |   2 +-
 tools/perf/util/demangle-cxx.cpp        |  22 +-
 tools/perf/util/disasm.c                | 632 +------------------
 tools/perf/util/disasm.h                |   5 +-
 tools/perf/util/disasm_bpf.c            | 195 ------
 tools/perf/util/disasm_bpf.h            |  12 -
 tools/perf/util/dso.c                   |  98 +++
 tools/perf/util/dso.h                   |   4 +
 tools/perf/util/llvm-c-helpers.cpp      | 120 +++-
 tools/perf/util/llvm-c-helpers.h        |  24 +-
 tools/perf/util/llvm.c                  | 484 +++++++++++++++
 tools/perf/util/llvm.h                  |  21 +
 tools/perf/util/map.c                   |  19 +-
 tools/perf/util/map.h                   |   6 +-
 tools/perf/util/print_insn.c            | 117 +---
 tools/perf/util/srcline.c               | 772 +-----------------------
 tools/perf/util/srcline.h               |   7 +-
 tools/perf/util/symbol-elf.c            |  95 ---
 tools/perf/util/symbol.c                | 135 -----
 tools/perf/util/symbol.h                |   4 -
 36 files changed, 2020 insertions(+), 2163 deletions(-)
 delete mode 100644 tools/perf/tests/pe-file-parsing.c
 create mode 100644 tools/perf/util/addr2line.c
 create mode 100644 tools/perf/util/addr2line.h
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h

-- 
2.48.1.262.g85cc9f2d1e-goog


