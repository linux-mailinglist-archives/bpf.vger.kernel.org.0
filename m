Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634841DDE9C
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgEVENo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbgEVENn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cH40HAWZ/3Qx3sDVnVqBbfj0xwcDt+Jaa0AZ6Vk1J8=;
        b=V3hf6ZYyRqhDOK45XCeHHdkJU9m3gzvVZ4OfrKKGBbpfS81Gs4QMSDyTKqUUtmOFcHCOFA
        3H/CJKHMrRHpv3T73nRFygzDN8vlXDNEwMFNuM0gPRbcDz7PGmfiahLycuYP1ojIS98PlQ
        J/HMr5azkN8ZgO2zHOFhz28d8Q3Xo/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-R_bNKGvANTKe5_hd5zV5nA-1; Fri, 22 May 2020 00:13:38 -0400
X-MC-Unique: R_bNKGvANTKe5_hd5zV5nA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2781980183C;
        Fri, 22 May 2020 04:13:35 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B19B15D9C9;
        Fri, 22 May 2020 04:13:31 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 8/8] selftests/bpf: factor out MKDIR rule
Date:   Fri, 22 May 2020 07:13:10 +0300
Message-Id: <20200522041310.233185-9-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do not repeat youself, move common mkdir code (message and action)
to a variable.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bade24e29a1a..26497d8869ea 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -252,6 +252,11 @@ define COMPILE_C_RULE
 	$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 endef
 
+define MKDIR_RULE
+	$(call msg,MKDIR,,$@)
+	mkdir -p $@
+endef
+
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
@@ -294,8 +299,7 @@ define DEFINE_TEST_RUNNER_RULES
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
 $(TRUNNER_OUTPUT)-dir := y
 $(TRUNNER_OUTPUT):
-	$$(call msg,MKDIR,,$$@)
-	mkdir -p $$@
+	$$(MKDIR_RULE)
 
 ifneq ($2,)
 EXTRA_CLEAN +=$(TRUNNER_OUTPUT)
@@ -337,8 +341,7 @@ $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c | $(dir $(TRUNNER_TESTS_HDR))
 EXTRA_CLEAN += $(TRUNNER_TESTS_HDR)
 
 $(dir $(TRUNNER_TESTS_HDR)):
-	$$(call msg,MKDIR,,$$@)
-	mkdir -p $$@
+	$$(MKDIR_RULE)
 endif
 
 # compile individual test files
@@ -425,8 +428,7 @@ $(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)/verifier
 EXTRA_CLEAN += $(OUTPUT)/verifier/tests.h
 
 $(OUTPUT)/verifier:
-	$(call msg,MKDIR,,$@)
-	mkdir -p $@
+	$(MKDIR_RULE)
 
 $(OUTPUT)/test_verifier: CFLAGS += -I$(abspath verifier)
 $(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) \
-- 
2.26.2

