Return-Path: <bpf+bounces-69971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769ECBAA686
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7ED2192166E
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89A244675;
	Mon, 29 Sep 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1L/VARC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50622422E
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172905; cv=none; b=Wkf4e6yS9DPGNuF+9QXGHE9cLdEUslHSQF0vNso5+kUuReWAM3CpHIGo2KUKjYBEvaXdHgKTQcTuy4ywAgQLNAFXIBpOxyX+pAyNU5IAponvNQNgvlfoYK3pfB505gsshsyFHYi4uFx/f90JqZTKAda9ViX4keIEg7BIXxHKsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172905; c=relaxed/simple;
	bh=7qrHmbfGn2aKzzxiGGx0dQNxryrNWvLvsBasM7skIBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jmW21YkQ1GB6a/3qgSlc5A3UhpTXqu28iMYQvRKylIPdV3lM29S7b2ZJkHsZmnICw0kx/zCX8lWjDM1XCEl+sj7E3v8QI/ZkKaoaqxfcFnInRHWitlKYK8xzH4k7CId+BY0rAKABcbSgeVvUE0fCreH1dmbVkCg2/sE3+FWp7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1L/VARC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26985173d8eso95195745ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172903; x=1759777703; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Njxey7G3aTuTqShbTBIMUulJ1i1nTX1TYxL9UTCOTos=;
        b=J1L/VARCwC47irL1hwNV8Mjn4O54A8kpyzBXVvf0NYIzdZmEJtmLcNPbMCK/efsCYi
         Jx4vI3T0CcvuwOwvC8hEpPbWjqH0lJ697byR/Dj+sbfiwkoXYWfG6LNbvk3oVJ+EMkyQ
         uO7LPBaB47HB5uCSnYfPI1RaVywtsggXm71R4GtlPKWbZVyoEDFbYoB2WvaklSDmYV0h
         aYFOdpfNrQ7U3WA+m90L2Hoo7tvZIPiGPqlIDpopLYmtzVd0Z1/ceRv2xXguS3oqfieH
         J5iu9W2YWDdwecMLKDc9jTEJO43qx2z16gqhxAyITar1J9/+CTUD4DV67ImiqSKpLUQx
         FZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172903; x=1759777703;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Njxey7G3aTuTqShbTBIMUulJ1i1nTX1TYxL9UTCOTos=;
        b=Hs5G71VUbNEA6ihmMpVwVWr0j7WTCSdx6+Z44phwIDiqU+jOGyWGnKgK81SjjBYf5f
         Hl8yXt9IZX/SUb0UeZJMvwbKJH6c6r7yyMHg+HGnVevof9cbjnJWOE6fzLh3VoQv7/xs
         +/EO46aiuLKVs+zEGj/OGapNwSh9xdIJGshRPppQemKmxw741ujPksNjPwxHNsvC+O9U
         D18tP6SjSAoFABnXQs3DVMdr6vybbV4Bfbe8D5DRjkwnbczjVh593bRq+mP3Uy1zeUnZ
         /Nd/MBQ3MXhqKbKlWu9RM+fQhFT6snrOQQHsFAYsR11XKPdelDogaMZ/SPEWrIV+EU5H
         jWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa7aQs371OKw1yrJpYdzSM9TSXNi9tKYbnJqMgldIq9VPVubY1R0sP+AUdt3D+zCwlmTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahBlmeMgIZHeN55XiOQH4MkVww5HuPcRDR5+oLnDbBb8xCTOF
	lgaVs1D9YEpNSxsSAN3+ZUWDi1C8lYVU+KrXP4aI/0Cv3tWzz16tVwKC8qOsQSZxzDrv0h2DhU6
	e7J9feGHw7A==
X-Google-Smtp-Source: AGHT+IFmUFAVW2JIwu+mAzAudh/QlJTnKWL5DHbA3zxjJEAoKO8ELdvqM7NM2IO10H5OHVK9s9MPkQxl47Lj
X-Received: from plhs13.prod.google.com ([2002:a17:903:320d:b0:268:4e0:9c09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db04:b0:265:9878:4852
 with SMTP id d9443c01a7336-27ed49ddab3mr226842215ad.15.1759172902750; Mon, 29
 Sep 2025 12:08:22 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:07:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-1-irogers@google.com>
Subject: [PATCH v6 00/15] Support dynamic opening of capstone/llvm
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Linking against libcapstone and libLLVM can be a significant increase
in dependencies and file size if building statically. For something
like `perf record` the disassembler and addr2line functionality won't
be used. Support dynamically loading these libraries using dlopen and
then calling the appropriate functions found using dlsym.

The patch series:
1) moves the capstone, LLVM and libbfd code to their own C files,
2) simplifies a little the capstone code;
3) adds perf_ variants of the functions that will either directly call
   the function or use dlsym to discover it;
4) adds BPF JIT disassembly support to in memory disassemblers (LLVM
   and capstone) by just directing them at the BPF info linear JIT
   instructions (note this doesn't support source lines);
5) adds fallback to srcline's addr2line so that llvm_addr2line is
   tried first, then the deprecated libbfd and then the forked command
   tried next, moving the code for forking out of the main srcline.c
   file in the process.

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
would extend their C API to avoid this.

v6: Refactor the libbfd along with capstone and LLVM, previous patch
    series had tried to avoid this by just removing the deprecated
    BUILD_NONDISTRO code. Remove the libtracefs removal into its own
    patch.
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

Ian Rogers (15):
  perf map: Constify objdump offset/address conversion APIs
  perf capstone: Move capstone functionality into its own file
  perf llvm: Move llvm functionality into its own file
  perf libbfd: Move libbfd functionality to its own file
  perf capstone: Remove open_capstone_handle
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so
  perf llvm: Mangle libperf-llvm.so function names
  perf dso: Move read_symbol from llvm/capstone to dso
  perf dso: Support BPF programs in dso__read_symbol
  perf llvm: Disassemble cleanup
  perf dso: Clean up read_symbol error handling
  perf disasm: Make ins__scnprintf and ins__is_nop static
  perf srcline: Fallback between addr2line implementations
  perf disasm: Remove unused evsel from annotate_args

 tools/perf/Makefile.config         |  14 +
 tools/perf/Makefile.perf           |  24 +-
 tools/perf/builtin-script.c        |   2 -
 tools/perf/tests/make              |   2 +
 tools/perf/util/Build              |   7 +-
 tools/perf/util/addr2line.c        | 439 ++++++++++++++++
 tools/perf/util/addr2line.h        |  20 +
 tools/perf/util/annotate.c         |   1 -
 tools/perf/util/capstone.c         | 682 +++++++++++++++++++++++++
 tools/perf/util/capstone.h         |  24 +
 tools/perf/util/config.c           |   2 +-
 tools/perf/util/disasm.c           | 645 ++----------------------
 tools/perf/util/disasm.h           |   6 +-
 tools/perf/util/disasm_bpf.c       | 195 --------
 tools/perf/util/disasm_bpf.h       |  12 -
 tools/perf/util/dso.c              | 112 +++++
 tools/perf/util/dso.h              |   4 +
 tools/perf/util/libbfd.c           | 600 ++++++++++++++++++++++
 tools/perf/util/libbfd.h           |  83 ++++
 tools/perf/util/llvm-c-helpers.cpp | 120 ++++-
 tools/perf/util/llvm-c-helpers.h   |  24 +-
 tools/perf/util/llvm.c             | 484 ++++++++++++++++++
 tools/perf/util/llvm.h             |  21 +
 tools/perf/util/map.c              |  19 +-
 tools/perf/util/map.h              |   6 +-
 tools/perf/util/print_insn.c       | 117 +----
 tools/perf/util/srcline.c          | 772 ++---------------------------
 tools/perf/util/srcline.h          |   9 +-
 tools/perf/util/symbol-elf.c       | 100 +---
 tools/perf/util/symbol.c           | 131 -----
 30 files changed, 2745 insertions(+), 1932 deletions(-)
 create mode 100644 tools/perf/util/addr2line.c
 create mode 100644 tools/perf/util/addr2line.h
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h
 create mode 100644 tools/perf/util/libbfd.c
 create mode 100644 tools/perf/util/libbfd.h
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h

-- 
2.51.0.570.gb178f27e6d-goog


