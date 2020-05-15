Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD811D4D3F
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEOMA5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 08:00:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEOMA4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 08:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589544055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeFCFQKYr22MWNIUPQRp475JW512YZ2vYFblYXBP+94=;
        b=SamXQe+3OdLBnViWvmKQ7IHrZ15uCQQ5BfghHnRwaP8FhVtzWi3fcMP3iQ6CW3xiMJYQj2
        ZB0DbQYKqoUFmLjei0bWt5TVImqO8+93B2wkdkRRZsLKL9c5BwtslD3sJ6r9D9w68WpzYA
        G0VwKCJcn7+LinuA26lEz86eLzfoi/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-hwwb6QX7P1KP2O9yk5obgg-1; Fri, 15 May 2020 08:00:53 -0400
X-MC-Unique: hwwb6QX7P1KP2O9yk5obgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93FB7100AA26;
        Fri, 15 May 2020 12:00:52 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7113760F8D;
        Fri, 15 May 2020 12:00:47 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 3/3] selftests: simplify run_tests
Date:   Fri, 15 May 2020 15:00:26 +0300
Message-Id: <20200515120026.113278-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove redundant check for TEST_PROGS and use the same command for
in- and out-of-source builds, and

fix bug with adding $(OUTPUT)/ to first $(TEST_PROGS) element only:

1) use $(addprefix ...) function to add $(OUTPUT). In case of blank
$(TEST_PROGS) it will be expanded to blank, so no need for extra
check;

2) $(OUTPUT) is always initialized to current dir or supplied value,
so it does not make any harm to add it unconditionally.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/lib.mk | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7a17ea815736..fac4f7de37fb 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -73,14 +73,9 @@ ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
-	@if [ "X$(TEST_PROGS)" != "X" ]; then \
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
-	else \
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
-	fi
-else
-	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
+	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
+			   $(addprefix $(OUTPUT)/,$(TEST_PROGS)))
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-- 
2.26.2

