Return-Path: <bpf+bounces-53177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DF7A4DC5D
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60668178F8E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C961C2BD;
	Tue,  4 Mar 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kCC5ov3+"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEB8200BBD
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087120; cv=none; b=ayRgKcatEu4Q1S7pruQyqGxjgAnmsKsiDKDmTZR14KqkNlr4Rl+0/P+KUEkNPGPlkkZnbmsTq31FdsFioGZakzIhAOhfriqKkP4W17Hg5jkWQOe/XVH6eaxTHBDtqzyyNXr+InJeX0hDZWnMDG8A5YzNPArCmrZesqd2/FfJ/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087120; c=relaxed/simple;
	bh=bY3Pyv8IyngQpQZW1FDRI6OBdwZmQ1FyLStF/Wv+3HA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bLnjF4ynm0YX7w1ILmDKpFbQsaxhukXM7Anc5KiPRmx/zW7JdrOD5PP/6GwwUrvWdxLoMDygl1cxkpAw0ZHwzWuMvjMptX7sTodIjPdR1aumX8fUkeuPwx7g7IBoUX5dX6cyGQ8LfO6Th+NiKHEKqGWrnQ7/G2ug7qrDo5sC5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kCC5ov3+; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=i2rJue+0leagCNJnLF
	BTd3RRx5jlJ2ahCVIyhwC10BY=; b=kCC5ov3+h3CpQpf/iqJjyOOPVeIVUugnm+
	OaEiw9ijplpg7GK+un3Cq582E5Q6GLzpgZio8OuOVLhORaKTtkAl8ncojuRddG0E
	loF3muFBF5Kw9VKHATxaiZi03XQmxjcKnc8XGaEj7K2bZX58/QYyzhCOw1myvG1r
	ruFKRCmHk=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCHH1pe4cZnShbHQA--.50058S2;
	Tue, 04 Mar 2025 19:17:51 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH] selftests/bpf: Strerror expects positive number
Date: Tue,  4 Mar 2025 19:17:22 +0800
Message-Id: <20250304111722.7694-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wCHH1pe4cZnShbHQA--.50058S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4UWr4kWFWxAF13Jr1rXrb_yoW5Wr4Dpr
	48J3sxtF1ftF43Xr17Aayj9FW8XwnYvrWUt340qw1rAF18Jr92qFs3KFWYgFn8C392qwn5
	Za4v9FZ5Cw1kt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo2NtUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwh4GeGfG3P5n5QABsi
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Feng Yang <yangfeng@kylinos.cn>

Before:
  failed to restore CAP_SYS_ADMIN: -1, Unknown error -1
  ...

After:
  failed to restore CAP_SYS_ADMIN: -1, Operation not permitted
  ...

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c | 4 ++--
 tools/testing/selftests/bpf/test_loader.c         | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

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


