Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D051D4D3C
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgEOMAr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 08:00:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgEOMAr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589544046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CddcCML9u77RP1qItK3WVdNaZvzlZ+4uDdw9FYA4Ktg=;
        b=CWWP66ZTsK/r1CfXFwpRNc2oD5kgOEtlzARkmZ5UiNBSZUWS/CpNQM/fYABWnp5diHWSMq
        OzwTu2Ma+sbVdCcSME8tB+yuvZg1P5VFf8sQI+6xPJPtJTDV7eUbR9f3OzWmg3d5zWrH2c
        NoywoR9MHAe9Lw5Uunx5rugLKnF6aWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350--wn1hhPoOUe_4918EpGWyA-1; Fri, 15 May 2020 08:00:44 -0400
X-MC-Unique: -wn1hhPoOUe_4918EpGWyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBFA087309A;
        Fri, 15 May 2020 12:00:43 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F2860F8D;
        Fri, 15 May 2020 12:00:37 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 1/3] selftests: do not use .ONESHELL
Date:   Fri, 15 May 2020 15:00:24 +0300
Message-Id: <20200515120026.113278-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using one shell for the whole recipe with long lists can cause

make[1]: execvp: /bin/sh: Argument list too long

with some shells. Triggered by commit 309b81f0fdc4 ("selftests/bpf:
Install generated test progs")

It requires to change the rule which rely on the one shell
behaviour (run_tests).

Simplify also INSTALL_SINGLE_RULE, remove extra echo, required to
workaround .ONESHELL.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/lib.mk | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b0556c752443..5b82433d88e3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -59,9 +59,8 @@ else
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
-.ONESHELL:
 define RUN_TESTS
-	@BASE_DIR="$(selfdir)";			\
+	BASE_DIR="$(selfdir)";			\
 	. $(selfdir)/kselftest/runner.sh;	\
 	if [ "X$(summary)" != "X" ]; then       \
 		per_test_logging=1;		\
@@ -71,22 +70,21 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then
-		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
+	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then \
+		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
-	@if [ "X$(TEST_PROGS)" != "X" ]; then
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS))
-	else
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS))
+	@if [ "X$(TEST_PROGS)" != "X" ]; then \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
+	else \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
 	fi
 else
-	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
+	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-	$(if $(INSTALL_LIST),@echo rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
-	$(if $(INSTALL_LIST),@rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
+	$(if $(INSTALL_LIST),rsync -a $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
 define INSTALL_RULE
-- 
2.26.2

