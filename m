Return-Path: <bpf+bounces-48011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B3A03258
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F817A223B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF31E0B62;
	Mon,  6 Jan 2025 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTN9JNVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9D1DFE2A
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200498; cv=none; b=D+wt64ELEPKAtGe5r4dqdVJm8ArHPktbUN0iDgYMYjJhuphBiz4IGTvDblPW6Z/CuMQ8vex3grKbAevWW+Dtph6auabZO9PKf122kAKRmN3fXxNf7G9QAmbWOvFq+SoYbC674XED1wMddJzCp4n5xza0+b1Vr3rhOGXV4qs37DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200498; c=relaxed/simple;
	bh=sRXqLyS08FKNyNXeLLqR2Uqp92xRYnK/WmwVCzkZZM8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=SI4YA+3wgXop3URFWSO1aaTk0kx/l1iAM0A9jOc+cBrI80RV4EHqrnfjNr4BpBGZdw1GVAAAJ9eJ+eE6cEPBnaDhlte644av5skgEUjIL4rnwbVQmf322Rj+6NPuHAVqSDbwmwsqj3KV/WL85YcT5ydr+wdE5XSrdYGJ1/WsL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTN9JNVZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso32063576276.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736200495; x=1736805295; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwbv0eBjXSqz5JyL8D/QAxclSgEvZsMWK7PCNFEcUhM=;
        b=UTN9JNVZxPyVZE8nT8QyFD5ej8eXRxYypxfyon7pXdY1TxaIz0yXJthxxNRB6hyM+j
         iU7YAqcGfgMA/Sgw0k4ocg5rBJbuG2cIocV3ooV9YcJg66dhc3d1zdVgWr6OT07HCtXw
         7+f7Ira7HEcoqvuvf+6UG8QAj4JdD32uBfUS2R5ulbxdHf8DwGM8zHC5Pmz5Km4STd4G
         taaftzZlLe5u1D8CHBW9uoq+BHQcJzGWougqpmjf6s0//3z2tD5mPXMbFBzO/8aAz62t
         dsJV5Bz4OusvserZ5YwmGjvFYKSlXjasB8oHhzAY+K1EdmQ5aI+WUPMa0sfF1NnLcuXL
         hwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200495; x=1736805295;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwbv0eBjXSqz5JyL8D/QAxclSgEvZsMWK7PCNFEcUhM=;
        b=ma1yUy5frLvExfc/OipPpqo9JwmkrV/dJLiaIfs9OWojsgBmeJ/GXDsED99JIki+/s
         E44+TwJoIOjXLzG/jCWtMjikWJ4JEDqnEDwP/Q2ZaKQfChCSXyiYa+eiMEb5w6JFgeRu
         LKHhhk9PvJfKxMmvwU68Ar/ekYgFHQx0Vg/aHQ9sfJIloR5YiQ9YGHpJ2CFiuPffx0m5
         iPmIt6YgP2nqMha+OayBwlE+paino8pAjwzxsezflsvuEiNJQTFkCE3A0yL3ehpNdS4H
         wJASDfZfeVKLmHNWSD7h0z7zI4ZbNKVcsML6CS8ji0eK45FZOBrvM7JZ2CUbr5hTSP88
         42Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUMj9JL6HAZ4DJXVTzWFyKS0Wq3uytAa6VeRoO27HIKqV8XeawUNKZpHNrgDhwZzVGFsDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7MJA7TAZ85DOH4nD1UzAqri89DJyJ6IBG3N8L1wduw+5tsmf
	bX4rXFhB9/+crShzTPtys78FNI2R+o+t+92RlNPx+pvarWADY3lXeXosTa8StXiwuISyfnNTog3
	rr8FmHA==
X-Google-Smtp-Source: AGHT+IE64pOhFEk2+u849QZKBcx8pDByl5WTcbQqlErdPCsQ1+glVFWCoU4GnGilavMrM1gmfnnTIY3k1Ojn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e0b:b0:6ef:7c9e:9232 with SMTP
 id 00721157ae682-6f3f8208468mr1348377b3.4.1736200495480; Mon, 06 Jan 2025
 13:54:55 -0800 (PST)
Date: Mon,  6 Jan 2025 13:54:42 -0800
Message-Id: <20250106215443.198633-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] tools build: Fix a number of Wconversion warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

There's some expressed interest in having the compiler flag
-Wconversion detect at build time certain kinds of potential problems:
https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/

As feature detection passes -Wconversion from CFLAGS when set, the
feature detection compile tests need to not fail because of
-Wconversion as the failure will be interpretted as a missing
feature. Switch various types to avoid the -Wconversion issue, the
exact meaning of the code is unimportant as it is typically looking
for header file definitions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-backtrace.c           | 2 +-
 tools/build/feature/test-bpf.c                 | 2 +-
 tools/build/feature/test-glibc.c               | 2 +-
 tools/build/feature/test-libdebuginfod.c       | 2 +-
 tools/build/feature/test-libdw.c               | 2 +-
 tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
 tools/build/feature/test-libelf.c              | 2 +-
 tools/build/feature/test-lzma.c                | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature/test-backtrace.c
index e9ddd27c69c3..7962fbad6401 100644
--- a/tools/build/feature/test-backtrace.c
+++ b/tools/build/feature/test-backtrace.c
@@ -5,7 +5,7 @@
 int main(void)
 {
 	void *backtrace_fns[10];
-	size_t entries;
+	int entries;
 
 	entries = backtrace(backtrace_fns, 10);
 	backtrace_symbols_fd(backtrace_fns, entries, 1);
diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
index 727d22e34a6e..e7a405f83af6 100644
--- a/tools/build/feature/test-bpf.c
+++ b/tools/build/feature/test-bpf.c
@@ -44,5 +44,5 @@ int main(void)
 	 * Test existence of __NR_bpf and BPF_PROG_LOAD.
 	 * This call should fail if we run the testcase.
 	 */
-	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) == 0;
 }
diff --git a/tools/build/feature/test-glibc.c b/tools/build/feature/test-glibc.c
index 9ab8e90e7b88..20a250419f31 100644
--- a/tools/build/feature/test-glibc.c
+++ b/tools/build/feature/test-glibc.c
@@ -16,5 +16,5 @@ int main(void)
 	const char *version = XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);
 #endif
 
-	return (long)version;
+	return version == NULL;
 }
diff --git a/tools/build/feature/test-libdebuginfod.c b/tools/build/feature/test-libdebuginfod.c
index da22548b8413..823f9fa9391d 100644
--- a/tools/build/feature/test-libdebuginfod.c
+++ b/tools/build/feature/test-libdebuginfod.c
@@ -4,5 +4,5 @@
 int main(void)
 {
 	debuginfod_client* c = debuginfod_begin();
-	return (long)c;
+	return !!c;
 }
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 2fb59479ab77..aabd63ca76b4 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -9,7 +9,7 @@ int test_libdw(void)
 {
 	Dwarf *dbg = dwarf_begin(0, DWARF_C_READ);
 
-	return (long)dbg;
+	return dbg == NULL;
 }
 
 int test_libdw_unwind(void)
diff --git a/tools/build/feature/test-libelf-gelf_getnote.c b/tools/build/feature/test-libelf-gelf_getnote.c
index 075d062fe841..e06121161161 100644
--- a/tools/build/feature/test-libelf-gelf_getnote.c
+++ b/tools/build/feature/test-libelf-gelf_getnote.c
@@ -4,5 +4,5 @@
 
 int main(void)
 {
-	return gelf_getnote(NULL, 0, NULL, NULL, NULL);
+	return gelf_getnote(NULL, 0, NULL, NULL, NULL) == 0;
 }
diff --git a/tools/build/feature/test-libelf.c b/tools/build/feature/test-libelf.c
index 905044127d56..2dbb6ea870f3 100644
--- a/tools/build/feature/test-libelf.c
+++ b/tools/build/feature/test-libelf.c
@@ -5,5 +5,5 @@ int main(void)
 {
 	Elf *elf = elf_begin(0, ELF_C_READ, 0);
 
-	return (long)elf;
+	return !!elf;
 }
diff --git a/tools/build/feature/test-lzma.c b/tools/build/feature/test-lzma.c
index 78682bb01d57..b57103774e8e 100644
--- a/tools/build/feature/test-lzma.c
+++ b/tools/build/feature/test-lzma.c
@@ -4,7 +4,7 @@
 int main(void)
 {
 	lzma_stream strm = LZMA_STREAM_INIT;
-	int ret;
+	lzma_ret ret;
 
 	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
 	return ret ? -1 : 0;
-- 
2.47.1.613.gc27f4b7a9f-goog


