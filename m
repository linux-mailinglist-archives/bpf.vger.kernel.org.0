Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B645D35ED
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfJKA3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:29:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38077 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfJKA2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so8033585ljj.5
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oHm0qgs35bdRmF9F1S/p3tYJstCeeDVx8Vw6XCI5qDc=;
        b=oZoFP4EBvirEOvHM9IfrnbIXJxjTZbSW136oc9UH1jI/wbPjjRATuu7MjU2Rqqkd/z
         Q12GzulFKtOI+LJ0qj+5jNMmCVsXsm6Du5YO8D0p+tYMDdRNKcMbUISq9/l6pXtBklWP
         janUJ6/iEWpc64Iuj0bEjCQprSWEhsxeyDw24v0xm1+sb7yVT1l1O4BSA94dZdZnN8fq
         0Rdo69y1azsmEHPwIxAdFVnnYGhRyV/skW/4qKuKKE+kQCbdICf5xLj3qVQDQgwjUp4z
         Em25qhXc2WFbbf826EgIg8xT5txDZCz845v5RT3V5P6kDssmNHcAoUYNkrA4/cxF2U5r
         wUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oHm0qgs35bdRmF9F1S/p3tYJstCeeDVx8Vw6XCI5qDc=;
        b=s06k4MchGH6KrCRcljtxto1BklZmzD2p/GD0KV7PmrxYfzBX4earOBesluPnM0nB1T
         Llq+/Lk9G3TquIggF/TGUNhMqpjvH5fHdWW/Ji9W0FNGc3OiHN+t82MTBRw2MuWjtg0S
         rQsF4hdQSGKwgMTBOsqlzzdy8vOYNrcMxlLCBRqPHCfu0cTvXDJTMxAjoG50XcL9w4Yu
         gq1hTgYKP7wWALJXkAUkNHoRJ0wmkK8FHZtE2gDeTetD8HcHA4/cR/1QsDGIKpDutHgm
         QhdDIjxWC+/zKO4rBOr4zaepgOxveqyF7mINL/pmLbujdHHqosT4Sqjs3n+vRKyOh4Wl
         IgEg==
X-Gm-Message-State: APjAAAWWcr+PGuaWt7mzMViCUF0Vnx2oBsL7I23zw3Xzb3K54nl8MIRx
        0vSqWj69bpw7WeIs6WuBLoBUhw==
X-Google-Smtp-Source: APXvYqwTPy70ROgoZDQ55cPuYWUZQKFCSMSQwfrSkuApAs28Wn8XuDBpgk6VAGN8GXArn8LtVqlcmA==
X-Received: by 2002:a2e:658f:: with SMTP id e15mr7832403ljf.254.1570753715857;
        Thu, 10 Oct 2019 17:28:35 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:35 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 11/15] libbpf: don't use cxx to test_libpf target
Date:   Fri, 11 Oct 2019 03:28:04 +0300
Message-Id: <20191011002808.28206-12-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No need to use C++ for test_libbpf target when libbpf is on C and it
can be tested with C, after this change the CXXFLAGS in makefiles can
be avoided, at least in bpf samples, when sysroot is used, passing
same C/LDFLAGS as for lib.

Add "return 0" in test_libbpf to avoid warn, but also remove spaces at
start of the lines to keep same style and avoid warns while apply.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile                         | 18 +++++-------------
 .../lib/bpf/{test_libbpf.cpp => test_libbpf.c} | 14 ++++++++------
 2 files changed, 13 insertions(+), 19 deletions(-)
 rename tools/lib/bpf/{test_libbpf.cpp => test_libbpf.c} (61%)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 1270955e4845..46280b5ad48d 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -52,7 +52,7 @@ ifndef VERBOSE
 endif
 
 FEATURE_USER = .libbpf
-FEATURE_TESTS = libelf libelf-mmap bpf reallocarray cxx
+FEATURE_TESTS = libelf libelf-mmap bpf reallocarray
 FEATURE_DISPLAY = libelf bpf
 
 INCLUDES = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
@@ -142,15 +142,7 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN) | \
 VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 
-CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
-
-CXX_TEST_TARGET = $(OUTPUT)test_libbpf
-
-ifeq ($(feature-cxx), 1)
-	CMD_TARGETS += $(CXX_TEST_TARGET)
-endif
-
-TARGETS = $(CMD_TARGETS)
+CMD_TARGETS = $(LIB_TARGET) $(PC_FILE) $(OUTPUT)test_libbpf
 
 all: fixdep
 	$(Q)$(MAKE) all_cmd
@@ -190,8 +182,8 @@ $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
 $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
-$(OUTPUT)test_libbpf: test_libbpf.cpp $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CXX) $(INCLUDES) $^ -lelf -o $@
+$(OUTPUT)test_libbpf: test_libbpf.c $(OUTPUT)libbpf.a
+	$(QUIET_LINK)$(CC) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
@@ -266,7 +258,7 @@ config-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ clean >/dev/null
 
 clean:
-	$(call QUIET_CLEAN, libbpf) $(RM) $(TARGETS) $(CXX_TEST_TARGET) \
+	$(call QUIET_CLEAN, libbpf) $(RM) $(CMD_TARGETS) \
 		*.o *~ *.a *.so *.so.$(LIBBPF_MAJOR_VERSION) .*.d .*.cmd \
 		*.pc LIBBPF-CFLAGS bpf_helper_defs.h
 	$(call QUIET_CLEAN, core-gen) $(RM) $(OUTPUT)FEATURE-DUMP.libbpf
diff --git a/tools/lib/bpf/test_libbpf.cpp b/tools/lib/bpf/test_libbpf.c
similarity index 61%
rename from tools/lib/bpf/test_libbpf.cpp
rename to tools/lib/bpf/test_libbpf.c
index fc134873bb6d..f0eb2727b766 100644
--- a/tools/lib/bpf/test_libbpf.cpp
+++ b/tools/lib/bpf/test_libbpf.c
@@ -7,12 +7,14 @@
 
 int main(int argc, char *argv[])
 {
-    /* libbpf.h */
-    libbpf_set_print(NULL);
+	/* libbpf.h */
+	libbpf_set_print(NULL);
 
-    /* bpf.h */
-    bpf_prog_get_fd_by_id(0);
+	/* bpf.h */
+	bpf_prog_get_fd_by_id(0);
 
-    /* btf.h */
-    btf__new(NULL, 0);
+	/* btf.h */
+	btf__new(NULL, 0);
+
+	return 0;
 }
-- 
2.17.1

