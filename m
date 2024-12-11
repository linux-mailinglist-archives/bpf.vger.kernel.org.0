Return-Path: <bpf+bounces-46608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842339EC920
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDC31886906
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A31EC4D1;
	Wed, 11 Dec 2024 09:31:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB581A83F2;
	Wed, 11 Dec 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909493; cv=none; b=uSvyGO6uBG+ls3WxXM6DD7eqYvlZW9CvHaMOFLhOMIPihCscwIg/aMubO7u/cuoIwHHW1s6YNzX7DQ14x/pxcUh58vLrcCMo4VYbBPfPB391I66v1yJzdbaTRbImHlehq/PcKNYsWsOHcmuTMFyUfQbKiaoeHjwFoAk8MdMA0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909493; c=relaxed/simple;
	bh=+2hNpiRkDq+lYivHIxOhw1agZtenBpaN92VHsvs+U3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7YbloAg1zfSj0sBEMbF3V80Pro5ptziHnwu5HDrama2b8XvxsUhQ/6yFVrw1LiDBJ5GnUJOBkgbDysrwpqQsbhXy90C8BxtDovHqO3XJH8AsPouxBzFeG/dnVmxJWWM8FB6deSvzSYvmRWn4t3MZdCRyk18qigW2yFDLXpq3KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BE131692;
	Wed, 11 Dec 2024 01:31:57 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 126E83F5A1;
	Wed, 11 Dec 2024 01:31:25 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 1/3] tools build: Add feature test for libelf with ZSTD
Date: Wed, 11 Dec 2024 09:31:12 +0000
Message-Id: <20241211093114.263742-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211093114.263742-1-leo.yan@arm.com>
References: <20241211093114.263742-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for checking if libelf supports ZSTD compress algorithm.

The macro ELFCOMPRESS_ZSTD is defined for the algorithm, pass it as an
argument to the elf_compress() function.  If the build succeeds, it
means the feature is supported.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/Makefile.feature           | 1 +
 tools/build/feature/Makefile           | 4 ++++
 tools/build/feature/test-all.c         | 4 ++++
 tools/build/feature/test-libelf-zstd.c | 9 +++++++++
 4 files changed, 18 insertions(+)
 create mode 100644 tools/build/feature/test-libelf-zstd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index bca47d136f05..b2884bc23775 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -43,6 +43,7 @@ FEATURE_TESTS_BASIC :=                  \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
         libelf-getshdrstrndx            \
+        libelf-zstd                     \
         libnuma                         \
         numa_num_possible_cpus          \
         libperl                         \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 043dfd00fce7..f12b89103d7a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -28,6 +28,7 @@ FILES=                                          \
          test-libelf-getphdrnum.bin             \
          test-libelf-gelf_getnote.bin           \
          test-libelf-getshdrstrndx.bin          \
+         test-libelf-zstd.bin                   \
          test-libdebuginfod.bin                 \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
@@ -196,6 +197,9 @@ $(OUTPUT)test-libelf-gelf_getnote.bin:
 $(OUTPUT)test-libelf-getshdrstrndx.bin:
 	$(BUILD) -lelf
 
+$(OUTPUT)test-libelf-zstd.bin:
+	$(BUILD) -lelf -lz -lzstd
+
 $(OUTPUT)test-libdebuginfod.bin:
 	$(BUILD) -ldebuginfod
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 80ac297f8196..67125f967860 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -58,6 +58,10 @@
 # include "test-libelf-getshdrstrndx.c"
 #undef main
 
+#define main main_test_libelf_zstd
+# include "test-libelf-zstd.c"
+#undef main
+
 #define main main_test_libslang
 # include "test-libslang.c"
 #undef main
diff --git a/tools/build/feature/test-libelf-zstd.c b/tools/build/feature/test-libelf-zstd.c
new file mode 100644
index 000000000000..a1324a1db3bb
--- /dev/null
+++ b/tools/build/feature/test-libelf-zstd.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <libelf.h>
+
+int main(void)
+{
+	elf_compress(NULL, ELFCOMPRESS_ZSTD, 0);
+	return 0;
+}
-- 
2.34.1


