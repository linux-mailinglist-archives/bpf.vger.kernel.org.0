Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C81D4D3D
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgEOMAw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 08:00:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726062AbgEOMAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589544051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2SQc7Kw0tOOlWxNV9I62/TRj+qmAVOcVhm20UoLLYM=;
        b=EXjjuvjb+4hgGpaZQhuwVKW5AEWTd0MD8hNxWb+gn8ZaDHCk9+BDBxWDQRaNT+xN0Tx/i/
        Xq2WrFb211Cx35wH9Aw01MhPl/PT80FPdz1RspSbElXAtHHr0DCXQqqdEZoOZ5CT1fx0uk
        8hW4gZD5YJIS3mKWzRfeRmWhiNQkRLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-LqEm3tO3NXG0sREbgVCgCw-1; Fri, 15 May 2020 08:00:48 -0400
X-MC-Unique: LqEm3tO3NXG0sREbgVCgCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12D22835B41;
        Fri, 15 May 2020 12:00:47 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8A761989;
        Fri, 15 May 2020 12:00:44 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 2/3] selftests: fix condition in run_tests
Date:   Fri, 15 May 2020 15:00:25 +0300
Message-Id: <20200515120026.113278-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The check if there are any files to install in case of no files
compares "X  " with "X" so never false.

Remove extra spaces. It may make sense to use make's $(if) function
here.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 5b82433d88e3..7a17ea815736 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -70,7 +70,7 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)" != "X" ]; then \
+	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
-- 
2.26.2

