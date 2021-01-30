Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1018330988F
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 23:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhA3WCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 17:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3WCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jan 2021 17:02:40 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD3C061573
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 14:02:00 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a19so12549145qka.2
        for <bpf@vger.kernel.org>; Sat, 30 Jan 2021 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7e1EW2HOoPVxxLJvR1awdy0SCQdemLDA8U6TcWapMk=;
        b=C6cx/E8ZdqfdK940rOybThnK8yu/SO4td45r0qbRYQdLrldKdD2qymqK6Gv3bEwd30
         6TaRhkhdT2OZcMor8QBsLY0oLUFF6ZrwxbcBsPqdYCN1VLg7O7EV7/vZ50bFqxVc8AbP
         ERUgPUveFW9HGD6HsNNFSP5bfQT49YTyaNjfYMu96Mp2UBeNTKfZ9WgQdtA5+teXupi9
         JUEOiH+qx/fcH6aBjYfEa5Ssmb4io7jHmnPVih3e7Wj/Qkekvu/1NXHiAf0zkkd/nYfC
         hazE/bVTLvid+XuS9je4/VpiXCraCXJlPv+CVTT2x9VcbI8h/6iRtTTryJLgD134c+wB
         jsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7e1EW2HOoPVxxLJvR1awdy0SCQdemLDA8U6TcWapMk=;
        b=YFfIhPVme5utich2qgtu1Wwyb7A9MshcP5zj7zvlkeZeUMaUY+KvnibkYV7zZKq+8n
         fBujq2tNcOCtj2ynA+5LRWitJ0XYoVdNcKz0+HBXiODtkKmy2SCF04P2bVm6Afjx8qNL
         S1kJJPkR7hT+Kk4fyHdp5gPxo57NtmjFSd2yifYfdSfwT685RSTcQkAcLzLWFrsbI7Il
         +wP4vqSyI0/ZaPp29LI1CYT1Cp4JpXDFaPfH358a0QmcLBxBNuPnvcs8tE+mgW3xixlx
         MUBIDnR+hjoPH//RdNNdkX7MxENLgefLbDSVdrmfx6OEGPwC9Z0kRnFe7yu9UAo1l2qC
         ez4w==
X-Gm-Message-State: AOAM533pSGuLanNICCeg+3/MuMqPk6YTyjLQTEnFxiVezJRNUiDxf8Xi
        rFmAMro5oaXiXqm6EVdyfS1/xej1B1aNkw==
X-Google-Smtp-Source: ABdhPJzmZJIky7JNjtMly9jRJ1R/q69gkkeS1Q3+XSwW91f6QTPVRmm7ThtPPkNoE+1fnEOKvDe/EA==
X-Received: by 2002:a37:5ac6:: with SMTP id o189mr10088307qkb.96.1612044119089;
        Sat, 30 Jan 2021 14:01:59 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id q4sm10011421qkj.5.2021.01.30.14.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 14:01:58 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, daniel@iogearbox.net
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2] selftest/bpf: testing for multiple logs on REJECT
Date:   Sat, 30 Jan 2021 17:01:50 -0500
Message-Id: <20210130220150.59305-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds support to verifier tests to check for a succession of
verifier log messages on program load failure. This makes the
errstr field work uniformly across REJECT and VERBOSE_ACCEPT checks.

This patch also increases the maximum size of a message in the series of
messages to test from 80 chars to 200 chars. This is in order to keep
existing tests working, which sometimes test for messages larger than 80
chars (which was accepted in the REJECT case, when testing for a single
message, but not in the VERBOSE_ACCEPT case, when testing for possibly
multiple messages).
And example of such a long, checked message is in bounds.c:
"R1 has unknown scalar with mixed signed bounds, pointer arithmetic with
it prohibited for !root"

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 59bfa6201d1d..58b5a349d3ba 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -88,6 +88,10 @@ struct bpf_test {
 	int fixup_map_event_output[MAX_FIXUPS];
 	int fixup_map_reuseport_array[MAX_FIXUPS];
 	int fixup_map_ringbuf[MAX_FIXUPS];
+	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
+	 * Can be a tab-separated sequence of expected strings. An empty string
+	 * means no log verification.
+	 */
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t insn_processed;
@@ -995,13 +999,19 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	return 0;
 }
 
+/* Returns true if every part of exp (tab-separated) appears in log, in order.
+ *
+ * If exp is an empty string, returns true.
+ */
 static bool cmp_str_seq(const char *log, const char *exp)
 {
-	char needle[80];
+	char needle[200];
 	const char *p, *q;
 	int len;
 
 	do {
+		if (!strlen(exp))
+			break;
 		p = strchr(exp, '\t');
 		if (!p)
 			p = exp + strlen(exp);
@@ -1015,7 +1025,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
 		needle[len] = 0;
 		q = strstr(log, needle);
 		if (!q) {
-			printf("FAIL\nUnexpected verifier log in successful load!\n"
+			printf("FAIL\nUnexpected verifier log!\n"
 			       "EXP: %s\nRES:\n", needle);
 			return false;
 		}
@@ -1130,7 +1140,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 			printf("FAIL\nUnexpected success to load!\n");
 			goto fail_log;
 		}
-		if (!expected_err || !strstr(bpf_vlog, expected_err)) {
+		if (!expected_err || !cmp_str_seq(bpf_vlog, expected_err)) {
 			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
 			      expected_err, bpf_vlog);
 			goto fail_log;
-- 
2.27.0

