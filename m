Return-Path: <bpf+bounces-66331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6AB325D2
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65D0B0275A
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA7FBF6;
	Sat, 23 Aug 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aETvgwLV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302F175A5
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909152; cv=none; b=FviJpkcv9pQ6Jd1VtTmUIT0/toTjStzznLlLMpRwOXDIoNVWT8kEBCdBP5AlpQ0VOtbEaC8YHn1qRgNASnfWkIx85gHU7WuagLpSpwXN8dgfEB0aZ/MnczddZv/CP7QRSQdZS+BfxEI/AzaxIYHuyb/Wz2fF1jG89oJ9JOfEwn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909152; c=relaxed/simple;
	bh=mZ5k/3Vkyfz8Z4KJVL7joRVzBpIaiSreRWEnmU1umtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=oQ75z2iY/4uoTZS4qwaAC/vPmfl4vlOUl1sazNdFbztby+4OuyaD+EbeDc7bAGsPm9bTToiAP4JOJ8UuXZWY5MRZqrgz/sVhERHe+F8LHBz92vwAYZ4Qct26lrEeyzkhN1YHjgTF4h7zugSDkj9A/DS5h9G13vYmvD+7waLJ0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aETvgwLV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246164c4743so41300115ad.3
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909149; x=1756513949; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YShzOxlKe/FmAZPtZyBmMwoWni8azVcezuusK/af7Dk=;
        b=aETvgwLVbGEKsa6VrOlPSE9COytVEI2kxbOd9e9uQfhD1o9GVdUuP3ZcSi7GAjaHQ/
         JI8eslp/vsmzP8m6TbNwWYCsRGdedgI20/m9RfeFjoC7ylECO0uL8DJqFMQa0PkwN+7b
         rc6pQ2tp+g4oMmauySVJKBSfNS+gwAaAEvaT5hzjs0zNirUA7bFXtpnEoodMuJarkkpU
         L+NZiXxeFDOZvuELzmTRVAyGpOxrPErx0OigvbIIt5lEMqWvipQwIvpwhvAkth9jWTR2
         8Xyb5FUvEwUx9cqs7CGXQrv4p7Uc1GmLzSHiVbyGw000WhL9SA1RbhfmrzTfRAaFczIu
         JDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909149; x=1756513949;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YShzOxlKe/FmAZPtZyBmMwoWni8azVcezuusK/af7Dk=;
        b=NQh0ccRmxQag77+O0PTL2XONrzHwZxPYoKZSGWtwTlehFf2yscHRcLjdJPabtnR4EG
         wHN8LNOBSn+8EmaHsgQKXFzOUNXYLSsv7QIiWVk5h3owD7oX/ilKrmsXYJVAQiSMYcZc
         wTBCggat/Dc4dd922E7hqLbixOFDS9Q3KWgpa5tw6VKnAAQMGEVrRhSz+AAcxoZEM33f
         Sq7HFPBf/j6RxyvKRusdsyPpsrmsdeFGdzJmI6fPsn0Otlc+L0q7uGAIRgN5aw5lF474
         7133de1CiDSw9Ju3HDm63ccBqxHwNRhxc/3um9uC3oDXBvusworIyI/xy5217vg4gzra
         /rmg==
X-Forwarded-Encrypted: i=1; AJvYcCXVp5pLpYzrOE99syGt/cYsE7Kl5G3h5B2waoT/wA9mzXhpOAUf0c9SdAhSQ3VuS38DM8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9cIfoyIjoDVmNykwT5QD653/kJZfSi0tYUMkxDlw6XYZJ30a
	1cFs3rybBwKgK2hkIncoqov2YkJMg9xmtGuNY1YDl3HIIxxcojYSXVG5EbdRpo2+u07j7Tui1Er
	6wM7j7+OLMw==
X-Google-Smtp-Source: AGHT+IGzr6GhJucF9cOZgIikuIRQUPQ/76/GCNWGjtrx0aVv6U1BMzYz9dndilEDmun6oUSPS7zZGIkHIVj6
X-Received: from plbd18.prod.google.com ([2002:a17:902:f152:b0:23f:fded:852b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cf:b0:244:9c9e:3c6d
 with SMTP id d9443c01a7336-2462ef1307cmr63652425ad.46.1755909148861; Fri, 22
 Aug 2025 17:32:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:31:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-1-irogers@google.com>
Subject: [PATCH v5 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
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

v5: Rebase and comment typo fix.
v4: Rebase and addition of a patch removing an unused struct variable.
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

Ian Rogers (19):
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
  perf disasm: Remove unused evsel from annotate_args

 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  95 +--
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
 tools/perf/util/annotate.c              |   1 -
 tools/perf/util/annotate.h              |   1 -
 tools/perf/util/capstone.c              | 682 +++++++++++++++++++++
 tools/perf/util/capstone.h              |  24 +
 tools/perf/util/config.c                |   2 +-
 tools/perf/util/demangle-cxx.cpp        |  22 +-
 tools/perf/util/disasm.c                | 628 +------------------
 tools/perf/util/disasm.h                |   6 +-
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
 tools/perf/util/symbol-elf.c            |  85 ---
 tools/perf/util/symbol.c                | 145 -----
 tools/perf/util/symbol.h                |   4 -
 37 files changed, 2020 insertions(+), 2166 deletions(-)
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
2.51.0.rc2.233.g662b1ed5c5-goog


