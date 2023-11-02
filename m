Return-Path: <bpf+bounces-13923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2067DEDF4
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCF9281AD6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 08:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BEE6FD3;
	Thu,  2 Nov 2023 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0fWTcXq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DBD6FC7;
	Thu,  2 Nov 2023 08:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803BBC433C7;
	Thu,  2 Nov 2023 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698912887;
	bh=tiXEfTZttWH1SdiJ40AhKXNpvZdi+JYLQ+nsEljGkoY=;
	h=From:To:Cc:Subject:Date:From;
	b=i0fWTcXqs2ifq5uASjhrMQKnyMRZwOvqHkc8kPB2wkvMze3aA/SDGIJqeIbFpxJRD
	 hlsijQnIlQggyDVYYpLtwV5OYLzr59q0jNxEPCK9itOX/ilKJX7m9/uNYmy8iRjkHT
	 vy9sOcvX6jTEonUFKeyNWGzEHxXba/zA6lcW+BD9eIuZiSnEtD/VnKaheCiF1xq0lu
	 0NaKPdECxEzCx+/XE3Fdwv0JcHxTxd5c+zI/kN4PHFE4FsB3TBp6RqcN4727Dl/PGL
	 rAY3bt7lSAUD/pVjNvy6i5IMInxG8QcXPr+3o1MJNkeu+/nykLWzZYEFctOqHXdGuF
	 7CmXPaHRQSpzA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	bpf@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	llvm@lists.linux.dev
Subject: [PATCH] tools/build: Add clang cross-compilation flags to feature detection
Date: Thu,  2 Nov 2023 09:14:41 +0100
Message-Id: <20231102081441.240280-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

When a tool cross-build has LLVM=1 set, the clang cross-compilation
flags are not passed to the feature detection build system. This
results in the host's features are detected instead of the targets.

E.g, triggering a cross-build of bpftool:

  cd tools/bpf/bpftool
  make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1

would report the host's, and not the target's features.

Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
feature detection makefile.

Fixes: cebdb7374577 ("tools: Help cross-building with clang")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/build/Makefile.feature | 2 +-
 tools/build/feature/Makefile | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 934e2777a2db..25b009a6c05f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -8,7 +8,7 @@ endif
 
 feature_check = $(eval $(feature_check_code))
 define feature_check_code
-  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
+  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" CLANG_CROSS_FLAGS="$(CLANG_CROSS_FLAGS)" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
 endef
 
 feature_set = $(eval $(feature_set_code))
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dad79ede4e0a..0231a53024c7 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -84,12 +84,12 @@ PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 all: $(FILES)
 
-__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
+__BUILD = $(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
   BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
   BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
   BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
 
-__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
+__BUILDXX = $(CXX) $(CXXFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
   BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
 
 ###############################
@@ -259,10 +259,10 @@ $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
 $(OUTPUT)test-libbfd-liberty.bin:
-	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
+	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
 
 $(OUTPUT)test-libbfd-liberty-z.bin:
-	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
+	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty

base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
-- 
2.40.1


