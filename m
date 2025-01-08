Return-Path: <bpf+bounces-48201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BBEA04FF7
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6427A252F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B141531C0;
	Wed,  8 Jan 2025 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WmYg1Zzv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B41465AD
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302090; cv=none; b=Ptk+SrODxkVw6PLgvFWp9zdPjLerTalgc8Xd74xtZxPR1Ly8GXyYAoc9tPTwBbx/YTaPb20e/8xZ9W3Y2iq5JqJ/IXi8iJKnIN0bQuY+r7yFpTdxiqEr/+IFvmnMCIyfSU+kn1bvHlK9PY5TeqXn7C1m8GqtIxILvkvLyTwNJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302090; c=relaxed/simple;
	bh=DSDBviiYURCQUASOkPYj5vrx2O1zld+frJ/HqnKFLNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QYGB9FuNBS+5u7nL7b4AlADv6/RCi0yUkW/lNNhNz/VL6JP1RwlOKm+VKCWoujXwDVwA2gMRmgCIvYdG/qinYnVkRSQlbyRpt8DexRJMYrFKQNZjWkWTCYTC06d5VrymRQgputJzidXZ1JVg2m4p45dpwtl7cJJpMqfdpLkre98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WmYg1Zzv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216281bc30fso22644105ad.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 18:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302087; x=1736906887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmsennAv/54mPSZlEcUcoRZz+1ld61A8s3zYAPWHNpI=;
        b=WmYg1ZzvVPJSyJi2NlIxLN9AkPJfJKkHlSETLIgblv3LcMb+OH0W/6oD4YkfXhyy87
         ZozXiaPaurjuCna4uwxW6gDUkjD7rSHHM2zMCtDNIiMw/ENB6UbMoFcJDmLnrUjS/eHc
         QNh3AlqubDnm1zLC1owap2njGFYAa01eTBvh9FH/SIrhkjIFqbXgSSYBgrm6LqNxuwFQ
         Wk1inBVfrfEhx7O3Ebw/xyF6eGkT8DdQ4DG5rlm7vs3yfNPaH5nOzR0FYj8gDMr0lpT5
         pue8wGPS1FdtvgYcihue9O97+X/MTAcA0rI5ulXP3igUOotJ+Y1rJ+6oAOUwRWhUt5/G
         Pmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302087; x=1736906887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmsennAv/54mPSZlEcUcoRZz+1ld61A8s3zYAPWHNpI=;
        b=RwKbMjdGBdLwJP03e01ec//zr5PfCAel5krhh/7+WPoiFHCKkKhy1RlnFe4PKrEJVU
         IfZV8uy8ji1Z4B9Nns5rmfRKfJutnqqOYSg3ETUn0RrGAeViKB1B2em2n2QpphSDBUOq
         Im17ehGyVndQdubs6zKj5c2FTo8Qo7+PZwaiRPBSXYYlyTcpvz//XU8h6YuFWIxDvAbE
         SI81o4fODY9mxq+GS0OzA1kI6tWYradSLVovQ3AzZ+gDCrTmrEYkFxmXdru1mSIcAspG
         i44LorhltD6x1qgCc/Go7OKZ0v6+xKgDA9Oj0lKdePcopG0xGgdmCCUEMX7eC7rUx8jh
         KMEA==
X-Forwarded-Encrypted: i=1; AJvYcCWO3Xusf1hfLH4Msc7SgD4CJPdwKnvPMGPY/mQFqBPuq4UK+IVmhikvWPppzGi9cBTjyo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygT4ltM6o1QBjPmaLTqthxjJ9IGKiyVFYStp1a4JfbxvsE4Ttp
	muXJWyHnHrqRmI/yVJ+UMzBBtZWlWl9dGzte9S+QXid+MR/HJOuMQmLlDgm7u50=
X-Gm-Gg: ASbGncs9KAx6/m/FMmb5Njf0bGBEDulswsa20/VAgwjNxTEyw1vby2uzenVWCESjHH/
	BHyuAQQnZRLrmWDWjvaHcxPjmW4z61X0RNmOGEid/qQIw3Brhzf0mThGBJDRJ7GqzTYZI9W71nl
	FWwsh0OKWMGUb2SNa7Q/uTjeMiTTYqoeBdGgDN+H7EfpKyuh96KxobOZxyYDoEGy5hE+bpKK91L
	Peq2+/K5GBXX8msgko42/MngV8mI1U35qiy54K3uZlV8ki5se4DVETEYTyTi9s6maOqniVY
X-Google-Smtp-Source: AGHT+IEq2Zspq+98QGFyujHxjTam1MP7KbplyThsxm1rRvzkJf+WBVn4MSX77PKCqgXt4GY0SV99ew==
X-Received: by 2002:a17:902:e843:b0:215:a3fb:b4d6 with SMTP id d9443c01a7336-21a83f3f50dmr20000675ad.8.1736302087504;
        Tue, 07 Jan 2025 18:08:07 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:06 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 00/16] perf tools: Use generic syscall scripts for all
 archs
Date: Tue, 07 Jan 2025 18:07:48 -0800
Message-Id: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXdfWcC/23OwWrDMAyA4VcpPs/Dlp3U7qnvMUpxFak1ZEmxi
 1kIefe5uawsPf4CfdIsMqVIWRx2s0hUYo7jUKP52Am8heFKMna1BSiwymsj75T4nKeMoe8fl16
 27F1HjNhyI+rWPRHHn1X8OtW+xfwY07QeKPo5XS2tld1YRUslfegCNbhvNfExxTLmOOAnjt/iy
 RX4I0DDloBKsMPgnWUmq94Q5pVot4SpBBjPyoB1umveEPaVcFvCVuKC9Q1iwODoH7Esyy+mV/b
 uegEAAA==
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
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8419; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=DSDBviiYURCQUASOkPYj5vrx2O1zld+frJ/HqnKFLNs=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rt3f8dSgIzYz98m8m/fGOh3t9H4anf775qWzbjZo+f7
 YSTkS/9OkpZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZhIti/DX+nTMim1Dpxcd9aZ
 zFnclGUmmnlg8dZeT4kz/YbVEnr//jIyvA6/wlXj/vvSIeljWc/WWsu2vdXU6TG0lvlTMj3qnPJ
 VHgA=
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
Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>

---
Changes in v5:
- Remove references to HAVE_SYSCALL_TABLE_SUPPORT that were
  missed/recently introduced
- Rebase on perf-tools-next
- Install headers to $(OUTPUT)arch instead of $(OUTPUT)tools/perf/arch
- Link to v4: https://lore.kernel.org/r/20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com

Changes in v4:
- Remove audit_machine member of syscalltbl struct (Ian)
- Rebase on perf-tools-next
- Link to v3: https://lore.kernel.org/r/20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com

Changes in v3:
- Fix compiliation when OUTPUT is empty
- Correct unused headers to be .h instead of .c  (Namhyung)
- Make variable definition of supported archs (Namhyung)
- Convert += into := for syscalls headers (Namhyung)
- Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com

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
 tools/perf/Documentation/perf-check.txt            |   2 -
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
 tools/perf/builtin-check.c                         |   2 -
 tools/perf/builtin-help.c                          |   2 -
 tools/perf/builtin-trace.c                         |  30 --
 tools/perf/check-headers.sh                        |   9 +
 tools/perf/perf.c                                  |   6 +-
 tools/perf/scripts/Makefile.syscalls               |  61 +++
 tools/perf/scripts/syscalltbl.sh                   |  86 ++++
 tools/perf/tests/make                              |   7 +-
 tools/perf/util/env.c                              |   6 +-
 tools/perf/util/generate-cmdlist.sh                |   4 +-
 tools/perf/util/syscalltbl.c                       |  90 +---
 tools/perf/util/syscalltbl.h                       |   1 -
 tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
 86 files changed, 4103 insertions(+), 623 deletions(-)
---
base-commit: 034b5b147bf7f44a45e39334725f8633b7ca8c3b
change-id: 20240913-perf_syscalltbl-6f98defcc6f5
-- 
- Charlie


