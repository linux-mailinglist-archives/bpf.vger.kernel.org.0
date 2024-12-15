Return-Path: <bpf+bounces-47009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98639F2672
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 23:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE6D1885183
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5991C5483;
	Sun, 15 Dec 2024 22:12:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B41C3C0D;
	Sun, 15 Dec 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300769; cv=none; b=o75C+NVyQ0c6a1pDL31W/Ksk0ai2ZQnH0sihn+CJW/vCHTQqFzjwRi1cRAB0i2dmiSUj3dEGtbKt6uz+aqYobcpRxb5Lp4yzkWyH/aP1X0xi0agmDnG88imN0zYahPclcC/xhbxsxfcH15vOKzrCP3x4+raHBUhrf/NYftbczyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300769; c=relaxed/simple;
	bh=cejteu26OFS/bbgZBUIfz1AIVTEWFGANsO6qmCunL/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTHacVbmzKLq0iCVXesvVHwDAfNNN4uk/KEgBcAOrooTriicWfrOrnF7WAeEqOB/Tjl27RlRchzsGq2ehcxqtIYyxzNLScgIGYejwVfMTb5hCKe9k/DSjhx9oJSVev9UnoUcLgNUpTbfSJVl7j5y4xDTgO3t8d8za4JhQny7t/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB8311FB;
	Sun, 15 Dec 2024 14:13:11 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6CF4A3F720;
	Sun, 15 Dec 2024 14:12:40 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
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
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 1/3] tools build: Add feature test for libelf with ZSTD
Date: Sun, 15 Dec 2024 22:12:21 +0000
Message-Id: <20241215221223.293205-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215221223.293205-1-leo.yan@arm.com>
References: <20241215221223.293205-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro ELFCOMPRESS_ZSTD defines the compress algorithm, which was
introduced in the commit ("libelf: Document and make ELFCOMPRESS_ZSTD
usable with old system elf.h") of the repository elfutils-0.188-67.
Therefore, libelf 0.189 and later versions require to link the libzstd
library.

Add a test for checking if libelf supports ZSTD algorithm.  Pass the
macro ELFCOMPRESS_ZSTD as an argument to the elf_compress() function.
If the build succeeds, it means the feature is supported.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Tested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/build/Makefile.feature           | 1 +
 tools/build/feature/Makefile           | 4 ++++
 tools/build/feature/test-all.c         | 4 ++++
 tools/build/feature/test-libelf-zstd.c | 9 +++++++++
 4 files changed, 18 insertions(+)
 create mode 100644 tools/build/feature/test-libelf-zstd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index e25cdb7db40e..ce2f37f62dfc 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -77,6 +77,7 @@ FEATURE_TESTS_BASIC :=                  \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
         libelf-getshdrstrndx            \
+        libelf-zstd                     \
         libnuma                         \
         numa_num_possible_cpus          \
         libperl                         \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cbf751b6f0f7..680f9b07150f 100644
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


