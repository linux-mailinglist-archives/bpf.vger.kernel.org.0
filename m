Return-Path: <bpf+bounces-43949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C569BBF3C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B01F21EBD
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3C1FAC21;
	Mon,  4 Nov 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z1yOEn+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA71FA266
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754405; cv=none; b=ShUUqurNoj83sck6WOMqFKpmh2UIoUGkU3+mk9svLt+sYiI4LUAo6tkhiWropVGdRw7p7udpuV4jsYWizSmhzOq5W9mlfrBx5cvyxObhbT37lZrMGWhxKswQNRtS2uUNUllIYjF6TsAs68qp6Y0Ki1ZPoOhAPrCheWkmXEndiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754405; c=relaxed/simple;
	bh=5/i4aYa+bDmYTyC5+2MiIF90lU7UD7sa8a5447uXxv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bHK58pvYVUSBBupb8sndr3wuBveRqZGJAN9rcy6jkK2Gm/D5b7WSE7RYp4y1ISZ9u8TKxIG71BMMZXo5LD25SNwSSjGjqdk+EOQGtcU82wHvxffGuPgXdvfDLOBh2uJKA7PStxuSkNcAFxi54tsmgxjIH6EcNFBMCGF1v/oXOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z1yOEn+f; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so3713125b3a.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754402; x=1731359202; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4V9Yv2fAvOK/vMiP82IoKQz/aaC4GtvY8C8de1dPo6U=;
        b=z1yOEn+flhKXg8I1JSj4uCDyhQcr++5qhPuW4e9nTtRUhby6Iefe42ANg2SspvsKfv
         KaIcgOL45jgrnR9I0HEBcgjbTjTCodEvlvwTY+pH3AUb+laFPqyJGEd1YN6P3W5KGxt3
         RUycyDy9/OGrKHnqqUKQSUkliPPfIEF5ipHIpUq/BO84d/EXAk4Thpdaj3y41xNkPVtc
         0KMckUeSErZiXjnMPLlrGGPHXCg9wJhlHUUu6YrXyjhMcZNo4zX5SQHZ/mfoQ8ZKMH0V
         49iqVr9vmjmHmw0YvhXb1/AnuTA0OhkgJeRCBbD9eKTjFWcNa8CJaHq7f8ZFT91h7daz
         lsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754402; x=1731359202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V9Yv2fAvOK/vMiP82IoKQz/aaC4GtvY8C8de1dPo6U=;
        b=qMmUd7HRShVpEwWwKDBGyePyCKMdOKGP1QYv9ZmpYmuFU5V0McqyKXPNi480Q7gc/x
         +RYYZvGaW/odPBY0L7rnP0FeBimwnZrLDojiyf6j++FxDr+5RtARYzyQeNFCCGUlH539
         hqG/oycx7Rhg5KJon8pTgvjE6gKk0mO9ISM5Azn0F36KJbalO5rfNnPSTvULYDmuOIqO
         vZaYsZ6Tz2hxAnmlhBjgrPdTF+yRMwGzAB9jJQmvALjNAc30ttHGhzjwPz6G2LLO0wYd
         TX6wumongXmpfG6UDWBxsdSJwm9P6ydMS8WUd+eY8/GG3WURWavkIy+x9l5x5bFcGIxG
         +/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWQaEimlMTa1F7bDxQ/KVj3WCDJUn4lXLt2Jg0RXq4YRusOjnAdkmh4zxCCVE7jOtv9BbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNuZFU+2EfHdZdLJ10grxlh/GpzcyUuLwRtSfMqKpOIyHG24e
	6nw3LRs+beFGl97B4CaiHaAN+XmbeqgPWK4gnswCz20nmL+CDx/kTaxUDor9iM0=
X-Google-Smtp-Source: AGHT+IFk0UULo9afhQbnlnWjUo65KmcRu9RXVFubvhCDhtDv1i7bMZR037d187cAIN7jV72mG65BAw==
X-Received: by 2002:a05:6a00:398f:b0:71e:3b8:666f with SMTP id d2e1a72fcca58-72062f712a6mr45086642b3a.11.1730754402245;
        Mon, 04 Nov 2024 13:06:42 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:06:41 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH RFT 00/16] perf tools: Use generic syscall scripts for all
 archs
Date: Mon, 04 Nov 2024 13:06:02 -0800
Message-Id: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADs3KWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Nj3YLUorT44sri5MScnJKkHF2zNEuLlNS05GSzNFMloK6CotS0zAq
 widFKQW4hSrG1tQBojDoLZgAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7158; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=5/i4aYa+bDmYTyC5+2MiIF90lU7UD7sa8a5447uXxv8=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmeciNY1P03++xMXAsfRHbpe+78drinTw1tXbGz7+Wr
 Ju8KWh2RykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABM5EsbI8GVF2ZM24Xkrris0
 z/sq5lEb29TY+lRskptvquex1zdnTmVkeMmzRCpUqM1DZ3Uzn/zaQNNXQb5t557syf19M6pitXc
 /DwA=
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
 tools/perf/Makefile.config                         |  28 +-
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
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 479 +++++++++++++++++++
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
 tools/perf/arch/mips/Makefile                      |  18 -
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
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
 tools/perf/arch/riscv/include/syscall_table.h      |   8 +
 tools/perf/arch/s390/Makefile                      |  21 -
 tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
 .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/s390/include/syscall_table.h       |   2 +
 tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
 .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 468 +++++++++++++++++++
 tools/perf/arch/sh/include/syscall_table.h         |   2 +
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 510 +++++++++++++++++++++
 tools/perf/arch/sparc/include/syscall_table.h      |   8 +
 tools/perf/arch/x86/Build                          |   1 -
 tools/perf/arch/x86/Makefile                       |  25 -
 tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
 tools/perf/arch/x86/include/syscall_table.h        |   8 +
 tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
 .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 435 ++++++++++++++++++
 tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
 tools/perf/builtin-check.c                         |   1 -
 tools/perf/builtin-help.c                          |   2 -
 tools/perf/builtin-trace.c                         |  30 --
 tools/perf/check-headers.sh                        |   9 +
 tools/perf/perf.c                                  |   6 +-
 tools/perf/scripts/Makefile.syscalls               |  69 +++
 tools/perf/scripts/syscalltbl.sh                   |  86 ++++
 tools/perf/tests/make                              |   7 +-
 tools/perf/util/env.c                              |   4 +-
 tools/perf/util/generate-cmdlist.sh                |   4 +-
 tools/perf/util/syscalltbl.c                       |  87 +---
 tools/scripts/syscall.tbl                          | 405 ++++++++++++++++
 84 files changed, 4089 insertions(+), 555 deletions(-)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20240913-perf_syscalltbl-6f98defcc6f5
-- 
- Charlie


