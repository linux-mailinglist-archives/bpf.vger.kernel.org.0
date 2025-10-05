Return-Path: <bpf+bounces-70401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B0BBCC3D
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5FA3B8A5F
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206EB2BD033;
	Sun,  5 Oct 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxr1nsY0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232F2629F
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699342; cv=none; b=AzU+v8XGw22Hs+rRG+VwRMo4kVeVohsO/F+k0XE8SB60TY/WL8a7COa7R3pxp4tSeZ735h1APIwJG40UpHCIL4QVNvmqJpdlP/tGgt3zIEDhGftzpj7qvuylDeBe5gcke8OpVNpDDLqhaxEZUkGAC28fJFDMf1OLb0pYMM23rbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699342; c=relaxed/simple;
	bh=uBfNTZIROFYAuvG18LuPdj2NxQlfFuC7yQVLR2gxl+0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=gev0IOdDBs3eyz60fDty/Ki/wJBogIUJ7pXB6h1mn2cWpKkkPIIbI62tW02Jb7sCp8dmirAu5M7xbYwcgl19DDV3S+8Ewar4aFAPtVBYjkURnHegcHlM3exS6Mt84oB/NMUJwyoDDz7YcXIRh8MrWgCLLWWUcbs1w5PcKH+vpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxr1nsY0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b552f91033cso4977564a12.1
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699340; x=1760304140; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5g52GEX71wtTx2tfnNC5TSdOtsaO7f4YX3EP4D2cWZ8=;
        b=nxr1nsY0LEU1IbTHb5OyguIto73hQxCqGujW7X83nADSZpzC0WAcGi0SzPRdCbxYwC
         wFJJqKQCvBFLm3IxfZLbXqho1FkeDhcEgW5IoT3HTfMekcuRCL6tzZ0EDiEhnQJxQ+P4
         aYW5lgbKACnoO7ZBCP5Pnp/Uhr5YUrRteUs+VdT7gdJs3I/4PhLSuA0qK66TfHTBBN65
         ZCaPIBp6AzibB4txD6Es46npmFZC5Nzhx31FCkUVU7m41sJrRMSrxqxhBV7fQkJekhU3
         Fdan5zDmxjf9MHShWymwU9wg9sZasHONG2yGOXQWTAkDZ3aKCerFcdJJsk8N3o//N4KS
         XrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699340; x=1760304140;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5g52GEX71wtTx2tfnNC5TSdOtsaO7f4YX3EP4D2cWZ8=;
        b=gBy5JIDlg9D90fPorZ8/EzrVz2O3NNMhuiy+oQq6oHMTYkgejQURwVU0bPly9iIk+k
         MdYLT/7WEZXPah61aZ3nWp+sAUwdh9W06ut4JLBrb34uLoovs+WWJTm15HkdXtuoPPEc
         jipdpT6iWMwhBwwVxNHqrCoEMsFTvspS5XgM9DbKMBTuaEkFFNQ/uJvlX/s09Xn/xa5x
         ATkntNmVhbwhYguL/63NVK4AYfuFGoJCUOaPRG12E+Tjrrow+TZwg5ll7tKrFc4tNhBk
         SPgtocoT5sy41eeiDBvWNqBOTYV5ifXd7BdwBhjZ6rKR8xY6rPjE5XA2c+xmVROInysl
         VM5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhqnuODb3r3WA4E6qOjsUxZFnCXTOyPtR4nhSF0a6AgU3HOVE4YRYgauvzmB0TfxWUfE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLk5+oyeviB5967Pn03q24G+ckvH12EiczWYdyXO/wzv15tc1
	3Nm2ieaYWh1DhuQgGH8n0JjXfX8EjG/tyjsOx8pjwrdtXVcopuRK0mXnEqP8dlsDbkw+ABe7eOT
	QcXzOTlDiUg==
X-Google-Smtp-Source: AGHT+IGaGnZmkzZlXEN57mujpYGO6s3ZAN9KBECTlVg1xIa0H7mMnIXmY+upFlssKwOGGndoikR19WyBEF0D
X-Received: from pjbnl7.prod.google.com ([2002:a17:90b:3847:b0:332:8246:26ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f8b:b0:2ac:7567:c069
 with SMTP id adf61e73a8af0-32b61e583d9mr13965706637.17.1759699340343; Sun, 05
 Oct 2025 14:22:20 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-1-irogers@google.com>
Subject: [PATCH v7 00/11] Capstone/llvm improvements + dlopen support
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
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
1) feature check libLLVM support and avoid always reinitializing the
   disassembler.
2) adds BPF JIT disassembly support to in memory disassemblers (LLVM
   and capstone) by just directing them at the BPF info linear JIT
   instructions (note this doesn't support source lines);
3) adds fallback to srcline's addr2line so that llvm_addr2line is
   tried first, then the deprecated libbfd and then the forked command
   tried next, moving the code for forking out of the main srcline.c
   file in the process.
4) adds perf_ variants of the capstone/llvm functions that will either
   directly call the function or use dlsym to discover it;

The addr2line LLVM functionality is written in C++. To avoid linking
against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
the C++ code with the libLLVM dependency will be built into a
libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
would extend their C API to avoid this.

v7: Refactor now the first 5 patches, that largely moved code around,
    have landed. Move the dlopen code to the end of the series so that
    the first 8 patches can be picked improving capstone/LLVM support
    without adding the dlopen code. Rename the cover letter and
    disassembler cleanup patches.
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

Ian Rogers (11):
  perf check: Add libLLVM feature
  perf llvm: Reduce LLVM initialization
  perf dso: Move read_symbol from llvm/capstone to dso
  perf dso: Support BPF programs in dso__read_symbol
  perf dso: Clean up read_symbol error handling
  perf disasm: Make ins__scnprintf and ins__is_nop static
  perf srcline: Fallback between addr2line implementations
  perf disasm: Remove unused evsel from annotate_args
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so
  perf llvm: Mangle libperf-llvm.so function names

 tools/perf/Documentation/perf-check.txt |   1 +
 tools/perf/Makefile.config              |  13 +
 tools/perf/Makefile.perf                |  24 +-
 tools/perf/builtin-check.c              |   1 +
 tools/perf/tests/make                   |   2 +
 tools/perf/util/Build                   |   3 +-
 tools/perf/util/addr2line.c             | 439 +++++++++++++++++++++
 tools/perf/util/addr2line.h             |  20 +
 tools/perf/util/annotate.c              |   1 -
 tools/perf/util/capstone.c              | 352 ++++++++++++-----
 tools/perf/util/config.c                |   2 +-
 tools/perf/util/disasm.c                |  18 +-
 tools/perf/util/disasm.h                |   4 -
 tools/perf/util/dso.c                   | 112 ++++++
 tools/perf/util/dso.h                   |   4 +
 tools/perf/util/libbfd.c                |   4 +-
 tools/perf/util/libbfd.h                |   6 +-
 tools/perf/util/llvm-c-helpers.cpp      | 120 +++++-
 tools/perf/util/llvm-c-helpers.h        |  24 +-
 tools/perf/util/llvm.c                  | 374 +++++++++++++-----
 tools/perf/util/llvm.h                  |   3 -
 tools/perf/util/srcline.c               | 495 ++----------------------
 tools/perf/util/srcline.h               |   1 -
 23 files changed, 1314 insertions(+), 709 deletions(-)
 create mode 100644 tools/perf/util/addr2line.c
 create mode 100644 tools/perf/util/addr2line.h

-- 
2.51.0.618.g983fd99d29-goog


