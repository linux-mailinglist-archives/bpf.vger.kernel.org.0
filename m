Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCD1DDE9B
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgEVENg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727914AbgEVENg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukD9GJtgzhlNNgb5v6+LpXzvgMP/t/gfajF7CIE4k40=;
        b=TJwW65hn8AVmZj3eUnQsGRuP1AOo0FUELQwfu/+oW8FSF7P4bYnP+fYEtVFnqcNPk/0hRk
        eD3LyS+oArGnUS3soHpOWsit8X/nJM0Q7upaaj+TXT7cTX46L0yc8EDTgydQpqTPee8CD+
        E0bLuRd7+XQiX9903gEVjv3TiH5cBOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-cGiz8Vi2MR6nJw61DUzU3A-1; Fri, 22 May 2020 00:13:32 -0400
X-MC-Unique: cGiz8Vi2MR6nJw61DUzU3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527AD460;
        Fri, 22 May 2020 04:13:31 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D90FF5D9C9;
        Fri, 22 May 2020 04:13:29 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7/8] selftests/bpf: fix test.h placing for out of tree build
Date:   Fri, 22 May 2020 07:13:09 +0300
Message-Id: <20200522041310.233185-8-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Flavors of test.h are generated in tree even for out of tree
build. Use OUTPUT directory for that.

It requires rules to make sure the directories exist.

Split EXTRA_CLEAN generation since existance of test.h files depends
of dynamic makefile generation.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 38 +++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 31598ca2d396..bade24e29a1a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -83,6 +83,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench
 
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
+EXTRA_CLEAN += $(TEST_CUSTOM_PROGS)
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
@@ -267,7 +268,7 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
-TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
+TRUNNER_TESTS_HDR := $(OUTPUT)/$(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
 TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
@@ -295,6 +296,11 @@ $(TRUNNER_OUTPUT)-dir := y
 $(TRUNNER_OUTPUT):
 	$$(call msg,MKDIR,,$$@)
 	mkdir -p $$@
+
+ifneq ($2,)
+EXTRA_CLEAN +=$(TRUNNER_OUTPUT)
+endif
+
 endif
 
 # ensure we set up BPF objects generation rule just once for a given
@@ -320,13 +326,19 @@ endif
 # ensure we set up tests.h header generation rule just once
 ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
 $(TRUNNER_TESTS_DIR)-tests-hdr := y
-$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
+$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c | $(dir $(TRUNNER_TESTS_HDR))
 	$$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
 	$$(shell ( cd $(TRUNNER_TESTS_DIR);				\
 		  echo '/* Generated header, do not edit */';		\
 		  ls *.c 2> /dev/null |					\
 			sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';	\
 		 ) > $$@)
+
+EXTRA_CLEAN += $(TRUNNER_TESTS_HDR)
+
+$(dir $(TRUNNER_TESTS_HDR)):
+	$$(call msg,MKDIR,,$$@)
+	mkdir -p $$@
 endif
 
 # compile individual test files
@@ -402,14 +414,23 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 # It is much simpler than test_maps/test_progs and sufficiently different from
 # them (e.g., test.h is using completely pattern), that it's worth just
 # explicitly defining all the rules explicitly.
-verifier/tests.h: verifier/*.c
+$(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)/verifier
 	$(shell ( cd verifier/; \
 		  echo '/* Generated header, do not edit */'; \
 		  echo '#ifdef FILL_ARRAY'; \
 		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
 		  echo '#endif' \
-		) > verifier/tests.h)
-$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
+		) > $@)
+
+EXTRA_CLEAN += $(OUTPUT)/verifier/tests.h
+
+$(OUTPUT)/verifier:
+	$(call msg,MKDIR,,$@)
+	mkdir -p $@
+
+$(OUTPUT)/test_verifier: CFLAGS += -I$(abspath verifier)
+$(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) \
+			| $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
@@ -433,7 +454,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 	$(call msg,BINARY,,$@)
 	$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
 
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)			\
-	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature								\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc)
+EXTRA_CLEAN += $(SCRATCH_DIR)			\
+	feature					\
+	$(addprefix $(OUTPUT)/,*.o *.skel.h)
-- 
2.26.2

