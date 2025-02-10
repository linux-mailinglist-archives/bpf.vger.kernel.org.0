Return-Path: <bpf+bounces-50932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DCA2E580
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5E0164908
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272C1ADC86;
	Mon, 10 Feb 2025 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dXlZGBiJ"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E81A3159
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172989; cv=none; b=NPx//YHKjuZM2eLHhEJPNU4/wPBlgjeiwR59jQbodcGWF8JP3+a/Nlj2rz75jFfQ1q18CY0qrwyeE7D9v1ymmrV04RaZfabtFX52QUMhdmuZ+MyWMbCjG+XBgVntukhRdP32YL/lMfabtoayaGy5omS++EQ2ute34WhNbfMNi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172989; c=relaxed/simple;
	bh=gzvzffTMcxnH+4ciLp9im4w+VoQB2/Wmwi86stA29lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DM8DZ4o7KMbPEIZsSbVrSmHdJxzgJURdl7iQ6xJTsgsMQW6+TJpSRyEpLR0YNBJRmlbjkYcGU7g/y6rRBvudFIBgo+yeiUwx2w0Kh8nW0AfYrmJcPcfCCMIbS3lDcwKOvOQHFFbItzAbmUuczJQXtI5/3VR2h0s0SM5X9mUSgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dXlZGBiJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Gv7ga
	OMPgUpUYoe51vE9rUDxHe9ia0GPkm5LkmURdSw=; b=dXlZGBiJaimvnxNk9d366
	AUeiZ28ENkMT872/iQVsX1+GoJFg9yu1NNdJuIH0Sv2s1Lq7/G6kGKQJZxnWW689
	JEx/irg15yDCRrkihmkpR5j2k/3MQAh1ZP9gHuoaBczXh5rogE1Oot8y1RSvVrkF
	lSYk87Z6tCJflcA1JOCUXQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHQY03rKlnG_C_LA--.33048S3;
	Mon, 10 Feb 2025 15:35:20 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH 2/3] Revert "selftests/bpf: Add test for __nullable suffix in tp_btf"
Date: Mon, 10 Feb 2025 15:35:08 +0800
Message-Id: <20250210073509.232007-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210073509.232007-1-yangfeng59949@163.com>
References: <20250210073509.232007-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHQY03rKlnG_C_LA--.33048S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr48try8tw43Kry8trWUArb_yoWrGFy7pa
	s7A34jyF4IkF4jqF18CF47WF4Fyws3ZrWUAF18Grn8Z34xJa4jqF1xKF18tF95Z39Yvrs5
	Zwn7KF9xCa1xX3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwKsUUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTQnveGepqRU+BgAAsZ

From: Feng Yang <yangfeng@kylinos.cn>

This commit 838a10bd2ebf 
("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL") 
has already resolved the issue, so we can roll back these patches.
This reverts commit 2060f07f861a237345922023e9347a204c0795af.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../bpf/prog_tests/tp_btf_nullable.c          | 14 -----------
 .../bpf/progs/test_tp_btf_nullable.c          | 24 -------------------
 .../bpf/test_kmods/bpf_testmod-events.h       |  6 -----
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  2 --
 4 files changed, 46 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
deleted file mode 100644
index accc42e01f8a..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <test_progs.h>
-#include "test_tp_btf_nullable.skel.h"
-
-void test_tp_btf_nullable(void)
-{
-	if (!env.has_testmod) {
-		test__skip();
-		return;
-	}
-
-	RUN_TESTS(test_tp_btf_nullable);
-}
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
deleted file mode 100644
index 39ff06f2c834..000000000000
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include "../test_kmods/bpf_testmod.h"
-#include "bpf_misc.h"
-
-SEC("tp_btf/bpf_testmod_test_nullable_bare")
-__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
-int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
-{
-	return nullable_ctx->len;
-}
-
-SEC("tp_btf/bpf_testmod_test_nullable_bare")
-int BPF_PROG(handle_tp_btf_nullable_bare2, struct bpf_testmod_test_read_ctx *nullable_ctx)
-{
-	if (nullable_ctx)
-		return nullable_ctx->len;
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
index aeef86b3da74..a565681ec057 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
@@ -34,12 +34,6 @@ DECLARE_TRACE(bpf_testmod_test_write_bare,
 	TP_ARGS(task, ctx)
 );
 
-/* Used in bpf_testmod_test_read() to test __nullable suffix */
-DECLARE_TRACE(bpf_testmod_test_nullable_bare,
-	TP_PROTO(struct bpf_testmod_test_read_ctx *ctx__nullable),
-	TP_ARGS(ctx__nullable)
-);
-
 struct sk_buff;
 
 DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index cc9dde507aba..f1582d431b61 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -431,8 +431,6 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	if (bpf_testmod_loop_test(101) > 100)
 		trace_bpf_testmod_test_read(current, &ctx);
 
-	trace_bpf_testmod_test_nullable_bare(NULL);
-
 	/* Magic number to enable writable tp */
 	if (len == 64) {
 		struct bpf_testmod_test_writable_ctx writable = {
-- 
2.43.0


