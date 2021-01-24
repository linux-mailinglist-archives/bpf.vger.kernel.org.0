Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9A301E56
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAXTGh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbhAXTGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jan 2021 14:06:33 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D72C061574
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:05:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id u20so1918473qku.7
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPWvRZtCBbG8jcNCNxE2nMsbpJ/uVvKUutGwBt6Xp58=;
        b=YKrofE/B7z/hc+E7+d4Grydl3QcvMwLhRxhNBDR1Ym4kdcCSIq6Y6jXAriyhae10GX
         ej6EI8jux0TIazlKMx2Yo4amo2MIOvQ+Ho6p311ugCAYVFDBsPDUwsysx1ZbjQTnKn+A
         yMnY+S6XI97t3HOr62eS7IXc1DASLQYazB82nha9C9IM3RMSk0X0LSxz1QBFgq6mIfnT
         nCmSv+PZARu++1xy76ZGQ3sdL6qzvzTng30DpgWCBqaGa2ZRqL8UNmpNBCbIFdbRjMue
         MFe+IX1tXW91rjy6GNSuQNHyOIhoHR84dmPe3B/dTWwvblYN+hkHrsIMoNFOTz5UKL+2
         7Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPWvRZtCBbG8jcNCNxE2nMsbpJ/uVvKUutGwBt6Xp58=;
        b=nLDd4UaJnO1xGesA1210R9xQTuVdilrOaVdXZxx58WUokUkWPFPe7TL6Q44pUGn4XL
         OWTtPWGcxggFYhqb7nvSSev6H+oFrYoYlUmZfvPH5ZodODgEMof3O9jk4vArC2p36SxY
         AktBpYWJJ4z/R4ONDHdYsZrnkYGwfzLfcNwUaS9rMJVWfYRkZMN9ZiNEXbEEvQzFWhKm
         4Q43Wmnnfiew1ZrHcoireyJkK6edgzLJtUa62YvVsScdckJIztZRbxKlRXPMev5ibgS5
         E4h5Iw5YxPS3vE7y5lb3cbQDz/MMt02NBKG1HlEuTZKZGyG+PWQUEcYivZeLFBmbhGR/
         sf1Q==
X-Gm-Message-State: AOAM531sI9YGO5T2zRqsZLvwF0Dv8ejUBCRiwvHfaJ00ZMjpTPZ5q5z/
        Q+MHtkyKgY2cMMpXT55f8C2kJkta/4z/kg==
X-Google-Smtp-Source: ABdhPJzXdH5z1TZ5r03/bYcTxRnvUBgNWaclU2uQVfoejoKYx1bkOMtC/YEVXt9EDtLmRna+/Ht+vw==
X-Received: by 2002:a37:87c5:: with SMTP id j188mr1647247qkd.210.1611515150485;
        Sun, 24 Jan 2021 11:05:50 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id a2sm2072713qka.11.2021.01.24.11.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:05:49 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next] selftest/bpf: testing for multiple logs on REJECT
Date:   Sun, 24 Jan 2021 14:05:32 -0500
Message-Id: <20210124190532.428065-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support to verifier tests to check for a succession of
verifier log messages on program load failure. This makes the
errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.

This patch also increases the maximum size of an accepted series of
messages to test from 80 chars to 200 chars. This is in order to keep
existing tests working, which sometimes test for messages larger than 80
chars (which was accepted in the REJECT case, when testing for a single
message, but ironically not in the VERBOSE_ACCEPT case, when testing for
possibly multiple messages).
And example of such a long, checked message is in bounds.c:
"R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
it prohibited for !root"

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 59bfa6201d1d..69298bf8ee86 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -88,6 +88,9 @@ struct bpf_test {
 	int fixup_map_event_output[MAX_FIXUPS];
 	int fixup_map_reuseport_array[MAX_FIXUPS];
 	int fixup_map_ringbuf[MAX_FIXUPS];
+	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT. Can be a
+	 * tab-separated sequence of expected strings.
+	 */
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t insn_processed;
@@ -995,9 +998,11 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	return 0;
 }
 
+/* Returns true if every part of exp (tab-separated) appears in log, in order.
+ */
 static bool cmp_str_seq(const char *log, const char *exp)
 {
-	char needle[80];
+	char needle[200];
 	const char *p, *q;
 	int len;
 
@@ -1015,7 +1020,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
 		needle[len] = 0;
 		q = strstr(log, needle);
 		if (!q) {
-			printf("FAIL\nUnexpected verifier log in successful load!\n"
+			printf("FAIL\nUnexpected verifier log!\n"
 			       "EXP: %s\nRES:\n", needle);
 			return false;
 		}
@@ -1130,7 +1135,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 			printf("FAIL\nUnexpected success to load!\n");
 			goto fail_log;
 		}
-		if (!expected_err || !strstr(bpf_vlog, expected_err)) {
+		if (!expected_err) {
+			printf("FAIL\nTestcase bug; missing expected_err\n");
+			goto fail_log;
+		}
+		if ((strlen(expected_err) > 0) && !cmp_str_seq(bpf_vlog, expected_err)) {
 			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
 			      expected_err, bpf_vlog);
 			goto fail_log;
-- 
2.27.0

