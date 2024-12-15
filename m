Return-Path: <bpf+bounces-47010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFB39F2674
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 23:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3EE16473F
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158361C54B5;
	Sun, 15 Dec 2024 22:12:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693C1D696;
	Sun, 15 Dec 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300769; cv=none; b=cNi1K+IO3eMK+MmEYMM2h5+elxQVm8yzxgDcpI3FaemJBEzelrf49ie2sc+ikN6t3vvXgaMJQwXULLl++2bfZVqV7dGhpDpPRqILjE3o6v4QRULla9ytDJCy0grys8a+u421jJLhrWZgAG/HyuFP50Ev2tzA46dvAqRs7PdYeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300769; c=relaxed/simple;
	bh=uqtsdcNyl3Tni/swAKj/zH9wX1cn+lVYAjzy6Z9TJ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtdOKL5B8lBGpY/3L2VvT9pppdYi8DyVEgC7dUYUda7HRdhUcqkQEYjTyZT1a5yishuClugxQr/FBxMLNcQaACpaXnWCfcgl6NOyUie8ZwCLfFSTepvdAcpGlK4d54kWpSLGJnSQrQpLNKinQ9bHdfi0PsAVWAlWcTYfezdtuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DF62168F;
	Sun, 15 Dec 2024 14:13:15 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C30A3F720;
	Sun, 15 Dec 2024 14:12:43 -0800 (PST)
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
Subject: [PATCH v3 2/3] perf: build: Minor improvement for linking libzstd
Date: Sun, 15 Dec 2024 22:12:22 +0000
Message-Id: <20241215221223.293205-3-leo.yan@arm.com>
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

The zstd library will be automatically linked by detecting the feature
libzstd.  It is no need to explicitly link it for static builds, so
remove the redundant linkage.

It is contradictory to detect the feature libelf-zstd while the build
configuration NO_LIBZSTD is set.  Report an error for reminding users
not to set NO_LIBZSTD.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Tested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/Makefile.config | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0e4f6a860ae2..155cb9d20011 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -171,7 +171,7 @@ ifdef LIBDW_DIR
 endif
 DWARFLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
+  DWARFLIBS += -lelf -lz -llzma -lbz2
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw).0.0
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
@@ -566,6 +566,12 @@ ifndef NO_LIBELF
     CFLAGS += -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT
   endif
 
+  ifeq ($(feature-libelf-zstd), 1)
+    ifdef NO_LIBZSTD
+      $(error Error: libzstd is required by libelf, please do not set NO_LIBZSTD)
+    endif
+  endif
+
   ifndef NO_LIBDEBUGINFOD
     $(call feature_check,libdebuginfod)
     ifeq ($(feature-libdebuginfod), 1)
-- 
2.34.1


