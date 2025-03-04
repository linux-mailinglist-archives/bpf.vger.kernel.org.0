Return-Path: <bpf+bounces-53212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5029FA4E7C7
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630FB17D57E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59A285419;
	Tue,  4 Mar 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+4x6aZ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EBB283C9F
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106200; cv=none; b=Dp2tShjAfihfP3lg8XDofSv7+v2Bzlzs5y16cAfJDnMbC0XDSy33tvR3v8rQGGIKnexh7UmnrIxv2k47iGbl3bwUwtgQFqtL78MD1TdRdnm3EoMIE/EFYbYeuXoqljyhDYNZSppZdXmW0U4QYKaYsF22Nd2MfY55Yp24pN/2nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106200; c=relaxed/simple;
	bh=kqNHw2+T/1wXMr6Y3928ToTIzaObb12uuShcoklOe2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJRG5YdZjAdqdm7IbmUbkr5qcVdftRMg3ULRKMHa/Z+gcz0FoVKbb+4weKVEsnYEZSsCvP+LUMRFTdMGZBikqsJ1FW6n5yWVqzNg0sbHOOqulpHu6XKZRShPoeFuxK9FKkjnae8dpfl/JEgqbGIdxGArtGdIkAARAU737UcHsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+4x6aZ1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2239f8646f6so56708915ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106198; x=1741710998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGXRguMufwQmV+Pu+mdyOEnpHQa0yP21dRDMQmg9c/c=;
        b=e+4x6aZ1uYBB21Fbx5uJsdsES8z6tdp8xNYPTAAWiMwkEX96YgR/zUkeYb5ir31xZw
         t2kf/vmXBq7qmujJtMpbAWUeTVRorY599YsYoOTP1sEthd+HBoZztrrm+UvHMr2Z9IHR
         YwuwBF/EC8GvsCNSvXL1nr1LAxItW6uK/sJpneaPHEW6XekUqEmoz+JwtFgBPaX4pfd8
         gu/+SFrHbKfmxC2yiImcacl6pZCWiVc5dNhPi2A7P7xnU3HVFDEtf/Rm1brtO7SAaNDA
         c9mtTBA8S1Q20FbMzbKZmYc7Ffaw8cpDTqmOPdtQIK7c1XBr7WJRLYm1xFnty9PAUOq8
         9K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106198; x=1741710998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGXRguMufwQmV+Pu+mdyOEnpHQa0yP21dRDMQmg9c/c=;
        b=VKUWHDqCMa//haFKAk/kwvMIhkw2JhL54BSA8ehrWjNJ0a1mgX8uG98LA1ax8iXpo7
         CG8UYaQPYheTyqMuZJnx3gJlH1rUftUs3Bv/zNOAKVRaFEJJiv65rVevAj6+HbOmVFme
         C8WqS9qcGAZXutXDIqpgC+lo0DDbXUTzdf/wPZKaAJnszIhyyB7Jcs/yPS13V328Ql/I
         5C7dlYSZcl2Irlu3Tr80ELC46dXNlywtWW5o426s1iWPJEmLWMgyfn+ZxkneEfzZBqEh
         NtPkMGP3Qsxo6HOumtLkJWA1MqrsXix21HwovvRcqWFNFhEtpTAKcxaWY/oelRsElARv
         YznQ==
X-Gm-Message-State: AOJu0Yz3oDwPXWzpO05pk4eudyg9EBDc0u/HH8UZspRPnfK5mbBYl7kq
	rjBsOYhY5rHQgPebsqr7epk+so7lEl+jcME8iZaPBaJ26xUqU3jCnlKHtA==
X-Gm-Gg: ASbGncuGrJk3/qU7gHXA6aEVng4ijFnrz3as0ahfQHF76SKn1ME5jJOfemxhZ/FXFas
	cP6IUR3ZdAjYBiS1qKsOzE2wi9DbucvE+ttShUukbQiQTuRl2EB/c5y+aew0VoE6A22xvQC1ILe
	OupkUhmACMT2iJBvCsmn8ZgIdtKrCKDuiMOOJr0+of0g8W87eWqJ9UiyOjrImvIYa8T33HJ3OIX
	Ju1cOVCXWjp49VZjlyb0+UVuUXqEAu2+b/9OshbaX/IoaP559ILqaAZWTAR0sdkSoK2WYv8O75S
	O6bAEYfe2WVnlGK4fj9hUqkB4DaipB89ErmmtK665BeMfJQ9BouK12ahqBcA6ToEXEw9LrZ+Qpu
	00cnxdAbp5CAlRjW58yo=
X-Google-Smtp-Source: AGHT+IG/pbhzU6mnv3ToWceZ6QtglhmDrfkKRkwpNRGQaLUrEBC6RP7ocpNAivPitxOJTF1jBMmfKA==
X-Received: by 2002:a05:6a00:b4c:b0:736:450c:fa54 with SMTP id d2e1a72fcca58-736450cff8amr13852469b3a.6.1741106197819;
        Tue, 04 Mar 2025 08:36:37 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a640sm11522175b3a.16.2025.03.04.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:36:37 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Fix dangling stdout seen by traffic monitor thread
Date: Tue,  4 Mar 2025 08:36:26 -0800
Message-ID: <20250304163626.1362031-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250304163626.1362031-1-ameryhung@gmail.com>
References: <20250304163626.1362031-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traffic monitor thread may see dangling stdout as the main thread closes
and reassigns stdout without protection. This happens when the main thread
finishes one subtest and moves to another one in the same netns_new()
scope.

The issue can be reproduced by running test_progs repeatedly with traffic
monitor enabled:

for ((i=1;i<=100;i++)); do
   ./test_progs -a flow_dissector_skb* -m '*'
done

Fix it by first consolidating stdout assignment into stdio_restore().
stdout will be restored to env.stdout_saved when a test ends or running
in the crash handler and to test_state.stdout_saved otherwise.
Then, protect use/close/reassignment of stdout with a lock. The locking
in the main thread is always performed regradless of whether traffic
monitor is running or not for simplicity. It won't have any side-effect.
stdio_restore() is kept in the crash handler instead of making all print
functions in the crash handler use env.stdout_saved to make it less
error-prone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 59 ++++++++++++++++--------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index ab0f2fed3c58..5b89f6ca5a0a 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -88,7 +88,11 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
 #endif
 }
 
-static void stdio_restore_cleanup(void)
+static pthread_mutex_t stdout_lock = PTHREAD_MUTEX_INITIALIZER;
+
+static bool in_crash_handler(void);
+
+static void stdio_restore(void)
 {
 #ifdef __GLIBC__
 	if (verbose() && env.worker_id == -1) {
@@ -98,34 +102,34 @@ static void stdio_restore_cleanup(void)
 
 	fflush(stdout);
 
-	if (env.subtest_state) {
+	pthread_mutex_lock(&stdout_lock);
+
+	if (!env.subtest_state || in_crash_handler()) {
+		if (stdout == env.stdout_saved)
+			goto out;
+
+		fclose(env.test_state->stdout_saved);
+		env.test_state->stdout_saved = NULL;
+		stdout = env.stdout_saved;
+		stderr = env.stderr_saved;
+	} else {
 		fclose(env.subtest_state->stdout_saved);
 		env.subtest_state->stdout_saved = NULL;
 		stdout = env.test_state->stdout_saved;
 		stderr = env.test_state->stdout_saved;
-	} else {
-		fclose(env.test_state->stdout_saved);
-		env.test_state->stdout_saved = NULL;
 	}
+out:
+	pthread_mutex_unlock(&stdout_lock);
 #endif
 }
 
-static void stdio_restore(void)
+static int traffic_monitor_print_fn(const char *format, va_list args)
 {
-#ifdef __GLIBC__
-	if (verbose() && env.worker_id == -1) {
-		/* nothing to do, output to stdout by default */
-		return;
-	}
-
-	if (stdout == env.stdout_saved)
-		return;
-
-	stdio_restore_cleanup();
+	pthread_mutex_lock(&stdout_lock);
+	vfprintf(stdout, format, args);
+	pthread_mutex_unlock(&stdout_lock);
 
-	stdout = env.stdout_saved;
-	stderr = env.stderr_saved;
-#endif
+	return 0;
 }
 
 /* Adapted from perf/util/string.c */
@@ -536,7 +540,8 @@ void test__end_subtest(void)
 				   test_result(subtest_state->error_cnt,
 					       subtest_state->skipped));
 
-	stdio_restore_cleanup();
+	stdio_restore();
+
 	env.subtest_state = NULL;
 }
 
@@ -1276,6 +1281,18 @@ void crash_handler(int signum)
 	backtrace_symbols_fd(bt, sz, STDERR_FILENO);
 }
 
+static bool in_crash_handler(void)
+{
+	struct sigaction sigact;
+
+	/* sa_handler will be cleared if invoked since crash_handler is
+	 * registered with SA_RESETHAND
+	 */
+	sigaction(SIGSEGV, NULL, &sigact);
+
+	return sigact.sa_handler != crash_handler;
+}
+
 void hexdump(const char *prefix, const void *buf, size_t len)
 {
 	for (int i = 0; i < len; i++) {
@@ -1957,6 +1974,8 @@ int main(int argc, char **argv)
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 	libbpf_set_print(libbpf_print_fn);
 
+	traffic_monitor_set_print(traffic_monitor_print_fn);
+
 	srand(time(NULL));
 
 	env.jit_enabled = is_jit_enabled();
-- 
2.47.1


