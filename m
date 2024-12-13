Return-Path: <bpf+bounces-46773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C6A9F00D4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143FD163774
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D8747F;
	Fri, 13 Dec 2024 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xcrmqTaH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D10383
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049991; cv=none; b=UWfE97MfGWMNKQZdUL8K9nAQiv/3H0iUc/QhrhC5Rxzi5g+85g4LyewMeAkDfuDdgCVVyGtTR+uc7VZvLe71B5nYuajsWxorkpYwdzdAkCndbKe2Icl32Jk0lhewcg8QmDkd0OSAzsJt7iHtplxWsBPW9cSrscBSNDwqYTUaVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049991; c=relaxed/simple;
	bh=WZq3jkoID8QunDd/Lk9gkIo3P2ul9rqI69DPd+QU7VY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H1NJtYbouX6E/oG032IUMLQcIt4FWGZuwDmG3OVdECsh95bhJfJ9adq4zhsQ4D7TVdLI388+pNxtD9Qym6yGO1b6YFWCw5jQPdFlk0VnG8p8+K5Td1DGdJ1qLov0hCZj0kaWp6TojtoM4GqqvqhHzclbNCbaLFSkMLvik9cB1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xcrmqTaH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso1058857a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734049988; x=1734654788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJpXILRLfXKK0+MdF5T9u9jkQmQMEKo5rgup6DDy1VM=;
        b=xcrmqTaHu99U1yAcZFSRxwAwkcR2hVmCgIqspwP8JL5Fhd+zL9KylVFCrtr8wl6BbY
         IvaCIsMsIHgKqcZicqVDsLVIZczYxz1HzpoHlmwrWOLLS2f9yraGyXtVfbZiOmg9T/Ja
         emBxTEjcnDIc7Kg7POyEsefmFzCo6mLC86gKsaI0oFOCCfx7/7mK/xZV70OWKjrfK2XW
         OuD37a3i7TVJdcVS9yeL3ibkEvt6RZUVn5E/50aCkQhHMG9e2NFCw5PAeDi2vxjhOC97
         ze8rg1L5kHkyUQozSaeFcdbzJb4xoMv2e5dVnjRDcDF0TETBd2/EfHIT9u2fWhH66fLC
         nb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049988; x=1734654788;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJpXILRLfXKK0+MdF5T9u9jkQmQMEKo5rgup6DDy1VM=;
        b=pDAu4OMeP9TtrD3badOppczxAIFq58Dm54m0z/o6XG3oMG8Nys1RV7/PpYBP/fNp29
         NtYbaTCqd0VX3R36Mr0T7bRLZdLhOaXM8W7DoHu7ZbfMoJWfuRrYH7pfC4wzJ2Nxz2bD
         /W12rfS1j3KyP2Cdug2v/zUhWMxuML8tTLyAjw9b4xwWvLPjgB7323DKd2TFs9aq4goD
         QzYobya/G5Ls4kIopJOJN2qF5HDFnOqI+8/46Z/o8iD1PG3jplKHEQ+RVpRYm1qoNAWl
         lEJDCeXHDjtVQPrBE8CKae2pSZfnWcviwXlmpgdVUd+sk0g8UYwt9oVZ5I5276fxg6EC
         W7QA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkcTbZMIathcJrbCHycTMCG3+oZEE2D4BGSN4Wxk6sLS1MVV5f4COPYzEvjgDYFf+wSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUAoxksUbCx/3123Upr6yYlOnGCl1cbDF/EgwOTIZ/YyD3oTR
	EZwGBBkzjUeAo2Qk58usQHkg+Qzq58XweeBdocWdvXUKFUOrqpJllBOhvY/fkpGajbu+f+OV++/
	I
X-Gm-Gg: ASbGncvZ2sAC/W36Bo6HE2jUSVtNgSDujVqr6DKUUqagpT6rUvgr2QviMzSjOBk7lxo
	lVPqhxc+GW796irtiyewkcTgGjP6juppXmrPpG+gj0nprlPOgGxkABkIH6MxKh3t8Zv8AZMgcmx
	xJoemrV4WGLGO6WaQWbIdgPNmnLAWgrWgaEgFRi2cn+c88NljTA+CeLTvMeYSZT4cpTSkcydluK
	Ge0I4JXZ7/Ly4/QCuvweGGhmYY2Zqy3uq5nnoJTI+Rde32NhGOlTDsn94AsSp1gVc1tNSOa
X-Google-Smtp-Source: AGHT+IG9JHkY7uaO8cnj26AhO6FgsLiu0T95fS/O5OYFvSj2rewtkHH5sLKhgnXsj2ZgFA4t6YukOA==
X-Received: by 2002:a17:90b:3b48:b0:2ee:7415:4768 with SMTP id 98e67ed59e1d1-2f28fd6f5c1mr1368966a91.17.1734049988177;
        Thu, 12 Dec 2024 16:33:08 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:07 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 00/16] perf tools: Use generic syscall scripts for all
 archs
Date: Thu, 12 Dec 2024 16:32:50 -0800
Message-Id: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALKAW2cC/2WNQQ6CMBBFr0JmbU2LgOLKexhi6jCVSbAlHdJIC
 He3snX5XvLfX0EoMglcixUiJRYOPkN5KAAH61+kuM8MpS4r3ZqTmii6hyyCdhzn56ga1156coi
 NqyGvpkiOP3vx3mUeWOYQl/0gmZ/dW8bo6q+VjNKqtb2lGs+NIXeLnIKwxyOGN3Tbtn0Br+Vo5
 LEAAAA=
X-Change-ID: 20240913-perf_syscalltbl-6f98defcc6f5
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7428; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=WZq3jkoID8QunDd/Lk9gkIo3P2ul9rqI69DPd+QU7VY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w7aTgWd5pnZ/dZ3zhM/4IM9yXcsqu3SRWaUCUtzCO
 5vf8U3rKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCK9/IwMzXFPkxqubI248pU9
 c9HS4/ej7Wcdck6u0kgR6mvs+j1dgpGhryyV5SP7/mXevnGM7//87Dw6vfhr+q72gz5Ce5W/OCr
 yAAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Standardize the generation of syscall headers around syscall tables.
Previously each architecture independently selected how syscall headers
would be generated, or would not define a way and fallback onto
libaudit. Convert all architectures to use a standard syscall header
generation script and allow each architecture to override the syscall
table to use if they do not use the generic table.

As a result of these changes, no architecture will require libaudit, and
so the fallback case of using libaudit is removed by this series.

Testing:

I have tested that the syscall mappings of id to name generation works
as expected for every architecture, but I have only validated that perf
trace compiles and runs as expected on riscv, arm64, and x86_64.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Rebase onto 6.13-rc2
- Fix output path so it generates to /tools/perf/arch properly
- Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com

---
Charlie Jenkins (16):
      perf tools: Create generic syscall table support
      perf tools: arc: Support generic syscall headers
      perf tools: csky: Support generic syscall headers
      perf tools: arm: Support syscall headers
      perf tools: sh: Support syscall headers
      perf tools: sparc: Support syscall headers
      perf tools: xtensa: Support syscall header
      perf tools: x86: Use generic syscall scripts
      perf tools: alpha: Support syscall header
      perf tools: parisc: Support syscall header
      perf tools: arm64: Use syscall table
      perf tools: loongarch: Use syscall table
      perf tools: mips: Use generic syscall scripts
      perf tools: powerpc: Use generic syscall table scripts
      perf tools: s390: Use generic syscall table scripts
      perf tools: Remove dependency on libaudit

 Documentation/admin-guide/workload-tracing.rst     |   2 +-
 tools/build/feature/Makefile                       |   4 -
 tools/build/feature/test-libaudit.c                |  11 -
 tools/perf/Documentation/perf-check.txt            |   1 -
 tools/perf/Makefile.config                         |  39 +-
 tools/perf/Makefile.perf                           |  12 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
 .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 ++++++++++++++++++++
 tools/perf/arch/alpha/include/syscall_table.h      |   2 +
 tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
 .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
 tools/perf/arch/arc/include/syscall_table.h        |   2 +
 tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
 .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++
 tools/perf/arch/arm/include/syscall_table.h        |   2 +
 tools/perf/arch/arm64/Makefile                     |  22 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
 .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
 .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++
 .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/arm64/include/syscall_table.h      |   8 +
 tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
 .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
 tools/perf/arch/csky/include/syscall_table.h       |   2 +
 tools/perf/arch/loongarch/Makefile                 |  22 -
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
 .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
 tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
 tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
 .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/mips/include/syscall_table.h       |   2 +
 tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
 .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++
 tools/perf/arch/parisc/include/syscall_table.h     |   8 +
 tools/perf/arch/powerpc/Makefile                   |  25 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
 tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
 tools/perf/arch/riscv/Makefile                     |  22 -
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
 tools/perf/arch/riscv/include/syscall_table.h      |   8 +
 tools/perf/arch/s390/Makefile                      |  21 -
 tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
 .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/s390/include/syscall_table.h       |   2 +
 tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
 .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++++++
 tools/perf/arch/sh/include/syscall_table.h         |   2 +
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
 tools/perf/arch/sparc/include/syscall_table.h      |   8 +
 tools/perf/arch/x86/Build                          |   1 -
 tools/perf/arch/x86/Makefile                       |  25 -
 tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
 tools/perf/arch/x86/include/syscall_table.h        |   8 +
 tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
 .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 ++++++++++++++++++
 tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
 tools/perf/builtin-check.c                         |   1 -
 tools/perf/builtin-help.c                          |   2 -
 tools/perf/builtin-trace.c                         |  30 --
 tools/perf/check-headers.sh                        |   9 +
 tools/perf/perf.c                                  |   6 +-
 tools/perf/scripts/Makefile.syscalls               |  60 +++
 tools/perf/scripts/syscalltbl.sh                   |  86 ++++
 tools/perf/tests/make                              |   7 +-
 tools/perf/util/env.c                              |   4 +-
 tools/perf/util/generate-cmdlist.sh                |   4 +-
 tools/perf/util/syscalltbl.c                       |  91 +---
 tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
 85 files changed, 4101 insertions(+), 620 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20240913-perf_syscalltbl-6f98defcc6f5
-- 
- Charlie


