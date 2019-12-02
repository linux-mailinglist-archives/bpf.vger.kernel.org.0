Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B803E10F287
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2019 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLBV7f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Dec 2019 16:59:35 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:44523 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLBV7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Dec 2019 16:59:34 -0500
Received: by mail-pj1-f73.google.com with SMTP id m20so704254pjn.11
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2019 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xpzDNy6fcpNL0+CS70qjmWa8QlA1tuukWSYASDOD21o=;
        b=CU/EH1/HbZ1dWQh0XNu8uB6IuRiLNQD9ceqQVNUl1AGxsLuLPZYg48bVlxQ0t864cF
         l+pDsCLHzuvLEB0a2aqoFTBocv9G5u5+wWWsJ8XoLMwBZhMHDdatdn2qMLIK/NjmLL0K
         GHyW7bx38MK5CZoupveRbjjIjKFkQHRyRmOK0Cj+IY8htmnhu7kEHMfpQF08phb56Jvp
         tnRcG5dmDWS/ya2bQ9mRx8R+zHIbUcWtQX4AVpY0xsDpXbDB8F7+T+a48w6bi+F4oDsJ
         d9QeoCtr2nD3DNKivilG7UtXN70a4sckAKMQaEI0WFQAFkYwk7zaQJpNFRpR4AxbgjgA
         1+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xpzDNy6fcpNL0+CS70qjmWa8QlA1tuukWSYASDOD21o=;
        b=dlQhQgbQQ6zSmcVmbPy2TiD1JMTwyq6U/vyexUPsVrrPDecdBpOWPhRRvCaKi85WYL
         sT5vIVfjx4GHq4rVTZnU1SBNHSP8hOfutCW4CU09RdLkwKpNPFU6pU4TZEsnKM35g+vb
         CdATqZp4I1mLwqHTEEhLiw+Y6+r7/aymMSBqfmbdpUxS0AXrC+KvlgJ5CCkSCoAp4bRS
         VgygDvBDBqfVhNZecMBoNUaGvHund3NS2xjWKJtKEjtjWyWQwJk/hkKPWfIZB/QRasYe
         ObnXrCtAMhZXTXMMdqfpMOA1jIZ0NA986rk83JzsUT8DrWVpzXejUb07TUpOxtyrx4OJ
         uZ+A==
X-Gm-Message-State: APjAAAVLzEDSLgV0XKANtOhB82asafmB6G59kVe3vi8YFqfQa9m/bWB0
        MTq8xQlDReqAdWD/Syo2nypyFAI=
X-Google-Smtp-Source: APXvYqwbGu1MWjKdb1n8tn0lF477FR+UjZt0fx/ZdRvlr4pOXYWlrjpIGO5uYHCc8QzrM+ylSg0SY6Y=
X-Received: by 2002:a63:1b4e:: with SMTP id b14mr1493407pgm.280.1575323974007;
 Mon, 02 Dec 2019 13:59:34 -0800 (PST)
Date:   Mon,  2 Dec 2019 13:59:31 -0800
Message-Id: <20191202215931.248178-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH bpf v2] selftests/bpf: bring back c++ include/link test
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 5c26f9a78358 ("libbpf: Don't use cxx to test_libpf target")
converted existing c++ test to c. We still want to include and
link against libbpf from c++ code, so reinstate this test back,
this time in a form of a selftest with a clear comment about
its purpose.

v2:
* -lelf -> $(LDLIBS) (Andrii Nakryiko)

Fixes: 5c26f9a78358 ("libbpf: Don't use cxx to test_libpf target")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/.gitignore                                    | 1 -
 tools/lib/bpf/Makefile                                      | 5 +----
 tools/testing/selftests/bpf/.gitignore                      | 1 +
 tools/testing/selftests/bpf/Makefile                        | 6 +++++-
 .../test_libbpf.c => testing/selftests/bpf/test_cpp.cpp}    | 0
 5 files changed, 7 insertions(+), 6 deletions(-)
 rename tools/{lib/bpf/test_libbpf.c => testing/selftests/bpf/test_cpp.cpp} (100%)

diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
index 35bf013e368c..e97c2ebcf447 100644
--- a/tools/lib/bpf/.gitignore
+++ b/tools/lib/bpf/.gitignore
@@ -1,7 +1,6 @@
 libbpf_version.h
 libbpf.pc
 FEATURE-DUMP.libbpf
-test_libbpf
 libbpf.so.*
 TAGS
 tags
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 3d3d024f7b94..defae23a0169 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -152,7 +152,7 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 
-CMD_TARGETS = $(LIB_TARGET) $(PC_FILE) $(OUTPUT)test_libbpf
+CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
 
 all: fixdep
 	$(Q)$(MAKE) all_cmd
@@ -196,9 +196,6 @@ $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN_SHARED)
 $(OUTPUT)libbpf.a: $(BPF_IN_STATIC)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
-$(OUTPUT)test_libbpf: test_libbpf.c $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
-
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
 		-e "s|@LIBDIR@|$(libdir_SQ)|" \
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4865116b96c7..419652458da4 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -37,5 +37,6 @@ libbpf.so.*
 test_hashmap
 test_btf_dump
 xdping
+test_cpp
 /no_alu32
 /bpf_gcc
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 085678d88ef8..e0fe01d9ec33 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -71,7 +71,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
-	test_lirc_mode2_user xdping
+	test_lirc_mode2_user xdping test_cpp
 
 TEST_CUSTOM_PROGS = urandom_read
 
@@ -317,6 +317,10 @@ verifier/tests.h: verifier/*.c
 $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
+# Make sure we are able to include and link libbpf against c++.
+$(OUTPUT)/test_cpp: test_cpp.cpp $(BPFOBJ)
+	$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
+
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)					\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature $(OUTPUT)/*.o $(OUTPUT)/no_alu32 $(OUTPUT)/bpf_gcc
diff --git a/tools/lib/bpf/test_libbpf.c b/tools/testing/selftests/bpf/test_cpp.cpp
similarity index 100%
rename from tools/lib/bpf/test_libbpf.c
rename to tools/testing/selftests/bpf/test_cpp.cpp
-- 
2.24.0.393.g34dc348eaf-goog

