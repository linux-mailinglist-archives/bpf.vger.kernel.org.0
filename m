Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE17F663197
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjAIUfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjAIUfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 15:35:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB63E625D2
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 12:34:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c6bd2981d8so65945937b3.2
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2khZ+quYNpCJzdtw6oMn43k0U7G9Lbi6luDGhG8S4qA=;
        b=raiy5wp5U9GrX48SAiGlvw4axiO2faRoXtK7evJFvPH9PfiVtTCPXcPikZjzCfCYsI
         18F4w1mF9pQzzMu399Ms6GL2SDoGgvGhlYvahPjs8UgVFcTK8+LochZpEq8RSl8x+YXL
         qUPPr8QCuqxH2Anih11R3N/Ltawh+ZnEma2GM0XaUAHmhxN6NBb1TizCt9yN8mNsQs9A
         OPkK8lOA17L8e209m+KKsU0gV6zshuvtUrJ1J3Po54/IR71feNkx8QckowfUC+Gu2dvl
         EyXWkeWzbZVqvqnWlnp1Daj9ODihNxtY7v2qCmQt2sCEy7EtHWcXJOfan1f7zPnkJpX6
         a/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2khZ+quYNpCJzdtw6oMn43k0U7G9Lbi6luDGhG8S4qA=;
        b=1uBna6VJI6J+A03AlOJw0P9cfY7krlZRIN0gKij3s0Gs1IgEixC53xDPjTtEzC355O
         YM4bUViVEaRdvk2GHd4CHzImKTRCd3Eq/SegS+S2TH1cJsrUiDD5mYFMkYIwrPVlhCqG
         2HQA5dDgGHCyJisw/Xpwyca1OJmwrEfKk9Bs+6Vt1CjZqE8Bdg/kV+cO3OQeipefVaAZ
         bkQCPckpuargUEcxVUKNmUTM1drjz5f938HKFWkw/4ddo1IQ9Z4HqZnylGZ3B/nzk9qt
         TaMJf/cqt27rMfdPfqSs7Xxr4wq1N+ZGY9WzrGHQkZ+NLKGbpvQ7kXH26gq1RAvQaBB/
         +utg==
X-Gm-Message-State: AFqh2kqcX1exsz3kdWiTMTtBbsePPlSXPmJRmNtoKs4+K06zQ946RxuJ
        sQKbNQgdPJXagkOJw2OxaojR38H/g69g
X-Google-Smtp-Source: AMrXdXuQNxrM0XRmhS/MeXx5cb0b8U3GxhmjVDdCDzpi5zy9ShWtv1Z1nq0IxppXKR985EHfASNVbA+G255I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:59e7:81ad:bc43:d9dc])
 (user=irogers job=sendgmr) by 2002:a25:e808:0:b0:7b8:507e:26dc with SMTP id
 k8-20020a25e808000000b007b8507e26dcmr845197ybd.440.1673296496062; Mon, 09 Jan
 2023 12:34:56 -0800 (PST)
Date:   Mon,  9 Jan 2023 12:34:23 -0800
In-Reply-To: <20230109203424.1157561-1-irogers@google.com>
Message-Id: <20230109203424.1157561-3-irogers@google.com>
Mime-Version: 1.0
References: <20230109203424.1157561-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 2/3] perf build: Remove libbpf pre-1.0 feature tests
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The feature tests were necessary for libbpf pre-1.0, but as the libbpf
implies at least 1.0 we can remove these now.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile                  |  7 ---
 .../feature/test-libbpf-bpf_map_create.c      |  8 ----
 .../test-libbpf-bpf_object__next_map.c        |  8 ----
 .../test-libbpf-bpf_object__next_program.c    |  8 ----
 .../build/feature/test-libbpf-bpf_prog_load.c |  9 ----
 .../test-libbpf-bpf_program__set_insns.c      |  8 ----
 .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ----
 .../build/feature/test-libbpf-btf__raw_data.c |  8 ----
 tools/perf/Makefile.config                    | 46 ++++---------------
 9 files changed, 10 insertions(+), 100 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
 delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
 delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 690fe97be190..dc9323e01e42 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -58,13 +58,6 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
-         test-libbpf-btf__load_from_kernel_by_id.bin	\
-         test-libbpf-bpf_prog_load.bin          \
-         test-libbpf-bpf_map_create.bin		\
-         test-libbpf-bpf_object__next_program.bin \
-         test-libbpf-bpf_object__next_map.bin   \
-         test-libbpf-bpf_program__set_insns.bin	\
-         test-libbpf-btf__raw_data.bin          \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
diff --git a/tools/build/feature/test-libbpf-bpf_map_create.c b/tools/build/feature/test-libbpf-bpf_map_create.c
deleted file mode 100644
index b9f550e332c8..000000000000
--- a/tools/build/feature/test-libbpf-bpf_map_create.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/bpf.h>
-
-int main(void)
-{
-	return bpf_map_create(0 /* map_type */, NULL /* map_name */, 0, /* key_size */,
-			      0 /* value_size */, 0 /* max_entries */, NULL /* opts */);
-}
diff --git a/tools/build/feature/test-libbpf-bpf_object__next_map.c b/tools/build/feature/test-libbpf-bpf_object__next_map.c
deleted file mode 100644
index 64adb519e97e..000000000000
--- a/tools/build/feature/test-libbpf-bpf_object__next_map.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/libbpf.h>
-
-int main(void)
-{
-	bpf_object__next_map(NULL /* obj */, NULL /* prev */);
-	return 0;
-}
diff --git a/tools/build/feature/test-libbpf-bpf_object__next_program.c b/tools/build/feature/test-libbpf-bpf_object__next_program.c
deleted file mode 100644
index 8bf4fd26b545..000000000000
--- a/tools/build/feature/test-libbpf-bpf_object__next_program.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/libbpf.h>
-
-int main(void)
-{
-	bpf_object__next_program(NULL /* obj */, NULL /* prev */);
-	return 0;
-}
diff --git a/tools/build/feature/test-libbpf-bpf_prog_load.c b/tools/build/feature/test-libbpf-bpf_prog_load.c
deleted file mode 100644
index 47f516d63ebc..000000000000
--- a/tools/build/feature/test-libbpf-bpf_prog_load.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/bpf.h>
-
-int main(void)
-{
-	return bpf_prog_load(0 /* prog_type */, NULL /* prog_name */,
-			     NULL /* license */, NULL /* insns */,
-			     0 /* insn_cnt */, NULL /* opts */);
-}
diff --git a/tools/build/feature/test-libbpf-bpf_program__set_insns.c b/tools/build/feature/test-libbpf-bpf_program__set_insns.c
deleted file mode 100644
index f3b7f18c8f49..000000000000
--- a/tools/build/feature/test-libbpf-bpf_program__set_insns.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/libbpf.h>
-
-int main(void)
-{
-	bpf_program__set_insns(NULL /* prog */, NULL /* new_insns */, 0 /* new_insn_cnt */);
-	return 0;
-}
diff --git a/tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c b/tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
deleted file mode 100644
index a17647f7d5a4..000000000000
--- a/tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/btf.h>
-
-int main(void)
-{
-	btf__load_from_kernel_by_id(20151128);
-	return 0;
-}
diff --git a/tools/build/feature/test-libbpf-btf__raw_data.c b/tools/build/feature/test-libbpf-btf__raw_data.c
deleted file mode 100644
index 57da31dd7581..000000000000
--- a/tools/build/feature/test-libbpf-btf__raw_data.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/btf.h>
-
-int main(void)
-{
-	btf__raw_data(NULL /* btf_ro */, NULL /* size */);
-	return 0;
-}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7c00ce0a7464..399e03338613 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -565,52 +565,26 @@ ifndef NO_LIBELF
 
       # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
       $(call feature_check,libbpf)
+
+      # Feature test requires libbpf 1.0 so we can assume the following:
+      CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
+      CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
+      CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
+      CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
+      CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
+      CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
+      CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
+
       ifdef LIBBPF_DYNAMIC
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
           $(call detected,CONFIG_LIBBPF_DYNAMIC)
-
-          $(call feature_check,libbpf-btf__load_from_kernel_by_id)
-          ifeq ($(feature-libbpf-btf__load_from_kernel_by_id), 1)
-            CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
-          endif
-          $(call feature_check,libbpf-bpf_prog_load)
-          ifeq ($(feature-libbpf-bpf_prog_load), 1)
-            CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
-          endif
-          $(call feature_check,libbpf-bpf_object__next_program)
-          ifeq ($(feature-libbpf-bpf_object__next_program), 1)
-            CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
-          endif
-          $(call feature_check,libbpf-bpf_object__next_map)
-          ifeq ($(feature-libbpf-bpf_object__next_map), 1)
-            CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
-          endif
-          $(call feature_check,libbpf-bpf_program__set_insns)
-          ifeq ($(feature-libbpf-bpf_program__set_insns), 1)
-            CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
-          endif
-          $(call feature_check,libbpf-btf__raw_data)
-          ifeq ($(feature-libbpf-btf__raw_data), 1)
-            CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
-          endif
-          $(call feature_check,libbpf-bpf_map_create)
-          ifeq ($(feature-libbpf-bpf_map_create), 1)
-            CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
-          endif
         else
           dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
         endif
       else
         # Libbpf will be built as a static library from tools/lib/bpf.
 	LIBBPF_STATIC := 1
-	CFLAGS += -DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID
-        CFLAGS += -DHAVE_LIBBPF_BPF_PROG_LOAD
-        CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
-        CFLAGS += -DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP
-        CFLAGS += -DHAVE_LIBBPF_BPF_PROGRAM__SET_INSNS
-        CFLAGS += -DHAVE_LIBBPF_BTF__RAW_DATA
-        CFLAGS += -DHAVE_LIBBPF_BPF_MAP_CREATE
       endif
     endif
 
-- 
2.39.0.314.g84b9a713c41-goog

