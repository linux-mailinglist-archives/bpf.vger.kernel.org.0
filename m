Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1324BA03
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgHTL6r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 07:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729716AbgHTL6k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 07:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597924719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0JsyfIwa+8GriEHyvv6HcAO6z5z27/c9oHAAPEBOpJM=;
        b=fCqVb4KzmDthjtpce7oywgkhkIU8ZmtLXj8hFR6b88L5O6uOWjPLUXkj2rN7q7IaXkM8Jf
        CXLqBHpZWcal5fNRQvx8LwnwR6jfq+akD5/AGUrJTECICVYeLaKnuKgYiAX/jyVzXIyJ06
        uf3LMZqHI5uwDnIWVhijUsNUNLiAULE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-n0W9MtINMvW0m216YYnCeg-1; Thu, 20 Aug 2020 07:58:35 -0400
X-MC-Unique: n0W9MtINMvW0m216YYnCeg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CADEE807354;
        Thu, 20 Aug 2020 11:58:33 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-208.ams2.redhat.com [10.36.112.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DC8210013C4;
        Thu, 20 Aug 2020 11:58:32 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2] bpf: selftests: global_funcs: check err_str before strstr
Date:   Thu, 20 Aug 2020 14:58:30 +0300
Message-Id: <20200820115830.39394-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The error path in libbpf.c:load_program() has calls to pr_warn()
which ends up for global_funcs tests to
test_global_funcs.c:libbpf_debug_print().

For the tests with no struct test_def::err_str initialized with a
string, it causes call of strstr() with NULL as the second argument
and it segfaults.

Fix it by calling strstr() only for non-NULL err_str.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Acked-by: Yonghong Song <yhs@fb.com>
---

v1->v2:

- remove extra parenthesis;
- remove vague statement from changelog.

---
 tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 25b068591e9a..2e80a57e5f9d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
 	log_buf = va_arg(args, char *);
 	if (!log_buf)
 		goto out;
-	if (strstr(log_buf, err_str) == 0)
+	if (err_str != NULL && strstr(log_buf, err_str) == 0)
 		found = true;
 out:
 	printf(format, log_buf);
-- 
2.26.2

