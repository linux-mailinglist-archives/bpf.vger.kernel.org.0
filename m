Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735B91DDE99
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgEVENc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727914AbgEVENb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=us9Z3GIkI4cfKum+7ndNy2o1Apdj6w4EtN4Y1Uj+Bi4=;
        b=VWgtIAsiL6zFHr09rSLHPza4LoB4Ky1QBXdeO5Y0DXq53+a+HrGjEGZpfnOcdiFnoLXCsn
        0Usizz+YV/Ca5AXRQ3OfGF3+4ULKVRXUUaq8QVv9bZSQ9W/V7oEGV8kznNsCZdhnRy1sEm
        ZMTw3Htyxkyaf983VSLAhYdajlqSn8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-gS7mXSPyPYCGUWY8d72x5Q-1; Fri, 22 May 2020 00:13:26 -0400
X-MC-Unique: gS7mXSPyPYCGUWY8d72x5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6F648014D4;
        Fri, 22 May 2020 04:13:25 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 264A65D9C9;
        Fri, 22 May 2020 04:13:19 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4/8] selftests/bpf: fix object files installation
Date:   Fri, 22 May 2020 07:13:06 +0300
Message-Id: <20200522041310.233185-5-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are problems with bpf test programs object files:

1) some of them are build for flavored test runner and should be
installed in the subdirectory;
2) it's possible that the same file mentioned several times (added
for every different unflavored test runner);
3) some generated files are not treated properly.

Fix 1) by adding subdirectory to the list. rsync -a in the install
target will handle it.

Fix 2) by filtering the list. Performance should not matter for such
amount of files.

Fix 3) by use proper (TEST_GEN_FILES) variable for the list.

Fixes: 309b81f0fdc4 ("selftests/bpf: Install generated test progs")
Fixes: e47a179997ce ("bpf, testing: Add missing object file to
TEST_FILES")

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 19091dbc8ca4..1ba3d72c3261 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -42,8 +42,7 @@ ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 endif
 
-TEST_GEN_FILES =
-TEST_FILES = test_lwt_ip_encap.o \
+TEST_GEN_FILES = test_lwt_ip_encap.o \
 	test_tc_edt.o
 
 BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
@@ -273,7 +272,11 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST),	\
 					       $$(TRUNNER_BPF_SRCS)))
-TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
+
+TO_ADD := $(if $2,$$(TRUNNER_OUTPUT),$$(TRUNNER_BPF_OBJS))
+$$(foreach i,$$(TO_ADD),\
+	$$(eval \
+		TEST_GEN_FILES += $$(if $$(filter $$i,$$(TEST_GEN_FILES)),,$$i)))
 
 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
 $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
-- 
2.26.2

