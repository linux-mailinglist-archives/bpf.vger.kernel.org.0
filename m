Return-Path: <bpf+bounces-75994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F50ECA1F18
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7D443005006
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526482EC0A3;
	Wed,  3 Dec 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiHusylU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8252DF6F5;
	Wed,  3 Dec 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804568; cv=none; b=rjB/iuvDMGUA13GHH4mVJzZnibJWZnQdMY/zGZLFwLCn0eCjuVQFGYQNUY9JPwG84UfKGHKhkwEq9w1Q8+ObaxGpcop+LaX3YbxkPdQiGvpQja2mUqOuV/C/cOlGvtP1GGHBtfaWwwEnMhpWENYlQ61bJ4lg+FcUyPrnBNkXWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804568; c=relaxed/simple;
	bh=Msz1qdTlSduYtlkGLXjKX6yQwIOxN6BZ+ZD7TPrZZeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPmlqkMrWM4+4UcHgi5Z+YkPPwElQcYTMF4dBiStRXnhetUmTFPbLnHUAquDrjjcdpKJ1BaiOxWStY64Psf74NEEwfVP48h7/fi00Mclp/SQ1zbTe1mFqeXWCUZ5MqoFxwRr3lTAhAIE+nQZ3CM+mBGnFaJLHbIGHmeSJ1s5XKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiHusylU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279B0C4CEF5;
	Wed,  3 Dec 2025 23:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764804568;
	bh=Msz1qdTlSduYtlkGLXjKX6yQwIOxN6BZ+ZD7TPrZZeo=;
	h=From:To:Cc:Subject:Date:From;
	b=DiHusylUqEsbkGT7sw2T6xs0E/SSJG4FR1sU3/0Hpvez+hyYnT/7q6zSXhUHHwqjS
	 0zo8KS4OTgejSY1gf0gy9jvGefLlJoWJPf8j4qi0QFQVitkEn19ISjK5GoRdHcpF25
	 New4Rc8Yq2JVCLPG9P5hDqjH5Bs8kAgJjs/Ax3V5h4DvCEbBV1elOOQTgSsYC2NWh+
	 ZImah/NLFND2EMRCvSydNez++mCRf+uVI1N8HfQ0Hl7OGnNxKb9SW+vWAn9JyyMI2A
	 CdDINIdp+R3/JjTH40lFvGzcItTvPk7WdULU127rTkN8ZVnfymm5I1/U2OizAM/p7F
	 tlc76iiq5nymw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] tools/build: Add a feature test for libopenssl
Date: Wed,  3 Dec 2025 15:29:23 -0800
Message-ID: <20251203232924.1119206-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's used by bpftool and the kernel build.  Let's add a feature test so
that perf can decide what to do based on the availability.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/build/Makefile.feature          | 6 ++++--
 tools/build/feature/Makefile          | 8 ++++++--
 tools/build/feature/test-all.c        | 5 +++++
 tools/build/feature/test-libopenssl.c | 7 +++++++
 4 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 tools/build/feature/test-libopenssl.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index fc6abe369f7373c5..bc6d85bad379321b 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -99,7 +99,8 @@ FEATURE_TESTS_BASIC :=                  \
         libzstd				\
         disassembler-four-args		\
         disassembler-init-styled	\
-        file-handle
+        file-handle			\
+        libopenssl
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -147,7 +148,8 @@ FEATURE_DISPLAY ?=              \
          lzma                   \
          bpf			\
          libaio			\
-         libzstd
+         libzstd		\
+         libopenssl
 
 #
 # Declare group members of a feature to display the logical OR of the detection
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7c90e0d0157ac9b1..3fd5ad0db2109778 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -67,12 +67,13 @@ FILES=                                          \
          test-libopencsd.bin			\
          test-clang.bin				\
          test-llvm.bin				\
-         test-llvm-perf.bin   \
+         test-llvm-perf.bin   			\
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-co-re.bin		\
          test-file-handle.bin			\
-         test-libpfm4.bin
+         test-libpfm4.bin			\
+         test-libopenssl.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -381,6 +382,9 @@ endif
 $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
+$(OUTPUT)test-libopenssl.bin:
+	$(BUILD) -lssl
+
 $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
 		> $(@:.bin=.make.output) 2>&1
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index eb346160d0ba0e2f..1488bf6e607836e5 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -142,6 +142,10 @@
 # include "test-libtraceevent.c"
 #undef main
 
+#define main main_test_libopenssl
+# include "test-libopenssl.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -173,6 +177,7 @@ int main(int argc, char *argv[])
 	main_test_reallocarray();
 	main_test_libzstd();
 	main_test_libtraceevent();
+	main_test_libopenssl();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libopenssl.c b/tools/build/feature/test-libopenssl.c
new file mode 100644
index 0000000000000000..168c45894e8be687
--- /dev/null
+++ b/tools/build/feature/test-libopenssl.c
@@ -0,0 +1,7 @@
+#include <openssl/ssl.h>
+#include <openssl/opensslv.h>
+
+int main(void)
+{
+	return SSL_library_init();
+}
-- 
2.52.0.177.g9f829587af-goog


