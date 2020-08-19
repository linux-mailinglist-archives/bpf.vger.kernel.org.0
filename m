Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856482492EA
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 04:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHSCeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 22:34:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60935 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726718AbgHSCeg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 22:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597804474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xG+Smo/hbvCwpLsWztqMEz2PRikMhrGpQAYmDOYK+mQ=;
        b=eHcBo7ZklmLxmY7mtdNqafiBFO6LZKRSXQCIs6YJpzHKSOcOpbPewwK5ZGc6luXv0Cd/hE
        EEkLKXMd5CEOaNCU53vtI6xNIGSoSgh2SdDyn7EBDJJWx4PF/o0rjNxrypX+Wz1kIe9XzJ
        nEFvqyYehq2dgE2t9Ez2a4JONwzTX00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-br62jBZONMa9-nHLs4qulQ-1; Tue, 18 Aug 2020 22:34:32 -0400
X-MC-Unique: br62jBZONMa9-nHLs4qulQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93CCA10066FB;
        Wed, 19 Aug 2020 02:34:31 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-30.ams2.redhat.com [10.36.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2520760BE5;
        Wed, 19 Aug 2020 02:34:29 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH] bpf: selftests: global_funcs: check err_str before strstr
Date:   Wed, 19 Aug 2020 05:34:27 +0300
Message-Id: <20200819023427.267182-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

The patch does not fix the test itself.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 25b068591e9a..6ad14c5465eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
 	log_buf = va_arg(args, char *);
 	if (!log_buf)
 		goto out;
-	if (strstr(log_buf, err_str) == 0)
+	if ((err_str != NULL) && (strstr(log_buf, err_str) == 0))
 		found = true;
 out:
 	printf(format, log_buf);
-- 
2.26.2

