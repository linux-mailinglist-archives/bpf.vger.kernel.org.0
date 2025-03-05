Return-Path: <bpf+bounces-53278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75431A4F4A5
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 03:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6C13AA66E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B8155342;
	Wed,  5 Mar 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dd2RvTQz"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942BABA33
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141401; cv=none; b=hJOoak3CwVJVE+2TLcnjW6s9Nzs5KX6oHTx/Wb+mjm2Ik9WMiO1wSnXNanv3UpgXssWzoZv26Rqt/KMFBFE8cwIOWJBPiYFMyHZbQb44xTfc6qciguOCKI8vjd0DwRTcpuJ51fr6JGorgNqkB1hBDaSYGgrtQb3Rev06cJeQgGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141401; c=relaxed/simple;
	bh=2AQSt3gElzlRI92wpFE8gQ5I2LGRUgqh1Uf4VzYvEEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDB/jpNqQAtJAkSA/NFtRAiQ3hWDBX0lEr2YvWbz/aEHZRfGZSs6bbAJB1H4V3Qdq0gjeGhD3aqbvt0UjWg3s82q3yg1a0Y/DsXng1gM6Csvi6WNfcQhm5wVinTGCqnvMQXkfTM1iFqYgJrCaWKoYsdOt9m7a5M8uh16PfVeayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dd2RvTQz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XkC0H
	DqTroiv0yyg9PZ+b3hVAktKPeImTeWt8RE42+k=; b=dd2RvTQz+ClpYEiTtJDI6
	UGQQTz1O2zu0Gq78t0sjwZSys4nV0vA9lR4pyMsy8CohAoL8mbg6SDEDpmUyZGdb
	oA0Mp9UWxV5bRjxGdy+chRQ28ncoyOiNhubhVpx5HiVQR83hI5LzEZ4nEysh0be9
	8i1xLNgzAW75JPj4yFVMOo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCX4fZutcdn+jxKJw--.7533S2;
	Wed, 05 Mar 2025 10:22:39 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	martin.lau@linux.dev,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn,
	yonghong.song@linux.dev
Subject: [PATCH] selftests/bpf: Strerror expects positive number
Date: Wed,  5 Mar 2025 10:22:34 +0800
Message-Id: <20250305022234.44932-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCX4fZutcdn+jxKJw--.7533S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr48Jr1kWrWrAw47Xw1kKrg_yoWrtFyrpa
	18J34Yka4SqF13XF17Aa1j9FWrXwsavFW7t348Kw13ZF18Jr92qr4IkFWYgFn8Wws5Wws5
	Za4F9FWrCw1kJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piL0ePUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRsHeGfHrm7kPwABsT

From: Feng Yang <yangfeng@kylinos.cn>

Before:
  failed to restore CAP_SYS_ADMIN: -1, Unknown error -1
  ...

After:
  failed to restore CAP_SYS_ADMIN: -3, No such process
  failed to restore CAP_SYS_ADMIN: -22, Invalid argument
  ...

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- cap_{enable,disable}_effective return -errno. Thanks, Eduard Zingerman!
- Link to v1: https://lore.kernel.org/all/20250304111722.7694-1-yangfeng59949@163.com
---
 tools/testing/selftests/bpf/cap_helpers.c         | 8 ++++----
 tools/testing/selftests/bpf/cap_helpers.h         | 1 +
 tools/testing/selftests/bpf/prog_tests/verifier.c | 4 ++--
 tools/testing/selftests/bpf/test_loader.c         | 6 +++---
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/cap_helpers.c b/tools/testing/selftests/bpf/cap_helpers.c
index d5ac507401d7..98f840c3a38f 100644
--- a/tools/testing/selftests/bpf/cap_helpers.c
+++ b/tools/testing/selftests/bpf/cap_helpers.c
@@ -19,7 +19,7 @@ int cap_enable_effective(__u64 caps, __u64 *old_caps)
 
 	err = capget(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	if (old_caps)
 		*old_caps = (__u64)(data[1].effective) << 32 | data[0].effective;
@@ -32,7 +32,7 @@ int cap_enable_effective(__u64 caps, __u64 *old_caps)
 	data[1].effective |= cap1;
 	err = capset(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	return 0;
 }
@@ -49,7 +49,7 @@ int cap_disable_effective(__u64 caps, __u64 *old_caps)
 
 	err = capget(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	if (old_caps)
 		*old_caps = (__u64)(data[1].effective) << 32 | data[0].effective;
@@ -61,7 +61,7 @@ int cap_disable_effective(__u64 caps, __u64 *old_caps)
 	data[1].effective &= ~cap1;
 	err = capset(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/cap_helpers.h b/tools/testing/selftests/bpf/cap_helpers.h
index 6d163530cb0f..8dcb28557f76 100644
--- a/tools/testing/selftests/bpf/cap_helpers.h
+++ b/tools/testing/selftests/bpf/cap_helpers.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/capability.h>
+#include <errno.h>
 
 #ifndef CAP_PERFMON
 #define CAP_PERFMON		38
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8a0e1ff8a2dc..ecc320e04551 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -121,7 +121,7 @@ static void run_tests_aux(const char *skel_name,
 	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
 	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
 	if (err) {
-		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
 		return;
 	}
 
@@ -131,7 +131,7 @@ static void run_tests_aux(const char *skel_name,
 
 	err = cap_enable_effective(old_caps, NULL);
 	if (err)
-		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
 }
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 53b06647cf57..8a403e5aa314 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -773,7 +773,7 @@ static int drop_capabilities(struct cap_state *caps)
 
 	err = cap_disable_effective(caps_to_drop, &caps->old_caps);
 	if (err) {
-		PRINT_FAIL("failed to drop capabilities: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to drop capabilities: %i, %s\n", err, strerror(-err));
 		return err;
 	}
 
@@ -790,7 +790,7 @@ static int restore_capabilities(struct cap_state *caps)
 
 	err = cap_enable_effective(caps->old_caps, NULL);
 	if (err)
-		PRINT_FAIL("failed to restore capabilities: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to restore capabilities: %i, %s\n", err, strerror(-err));
 	caps->initialized = false;
 	return err;
 }
@@ -959,7 +959,7 @@ void run_subtest(struct test_loader *tester,
 		if (subspec->caps) {
 			err = cap_enable_effective(subspec->caps, NULL);
 			if (err) {
-				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(err));
+				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(-err));
 				goto subtest_cleanup;
 			}
 		}
-- 
2.25.1


