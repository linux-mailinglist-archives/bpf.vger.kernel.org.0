Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0481D43D4
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 05:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgEODBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 23:01:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgEODBB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 23:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589511659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=La4b/fC5MXOK9UrrO4wGU7CGg+zIEUJJ22+O6l7daB0=;
        b=WxgJUnN+XSUnWGhU5J6aVGlHnv1bmWmI2A9k1COCLwBa9K1pdbWD9ez3AYxGNXY38i/xFu
        jvKh4Qq5KWCnYTzH/WsG1s/8CeqExa7ZdYJVb3OMv4H4Ti+rqeilklLybwC3D2tvhO8mPv
        wrwMEKkuEETVhBu7igovPVFkEQB+SjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-xI0o2lzzNP-s8VGxIM97nQ-1; Thu, 14 May 2020 23:00:56 -0400
X-MC-Unique: xI0o2lzzNP-s8VGxIM97nQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442CB1005510;
        Fri, 15 May 2020 03:00:55 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01F9A5D9D7;
        Fri, 15 May 2020 03:00:53 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH RFC] selftests: do not use .ONESHELL
Date:   Fri, 15 May 2020 06:00:51 +0300
Message-Id: <20200515030051.60148-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
---

1) I'm wondering how commit c363eb48ada5 ("selftests: fix too long
argument") worked without the patch.

2) The code does not look working as expected for me:
2.1) "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" is
always true sine the left part will be at least "X  " (spaces);
2.2) according to manual in .ONESHELL case gmake checks only first
line for @, so @rsync is passed to the shell;
2.3) $(OUTPUT)/(TEST_PROGS) adds $(OUTPUT) only to the first prog;


Did I miss something?

---
 tools/testing/selftests/lib.mk | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index b0556c752443..e9e5e33297cf 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -59,7 +59,6 @@ else
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 endif
 
-.ONESHELL:
 define RUN_TESTS
 	@BASE_DIR="$(selfdir)";			\
 	. $(selfdir)/kselftest/runner.sh;	\
@@ -71,13 +70,13 @@ endef
 
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
 	$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
-- 
2.26.2

