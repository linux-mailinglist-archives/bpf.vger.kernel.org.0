Return-Path: <bpf+bounces-59950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EEAD098C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B8917B69E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E452376E6;
	Fri,  6 Jun 2025 21:31:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417C23C513
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245476; cv=none; b=UIP/GViyDL56FotSVsIhdjuArCvqrTPfV5h6QexuLzZSDpACHUM+bVkYcFYWty6sgvXE2/K2I/CIRz3+81qt42GDDuzl7VyP1Oc+TmZXBzpApXk6CiQZBlEecuse42wuuy20UDwHG2GKnLBzDBngpS1jlYJwWlWwY81jA0zI6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245476; c=relaxed/simple;
	bh=2EvVueSGKzvQwAiZ2SFMZDkqGO8WOhemIROEr5IydP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERsv2w/MUwRqpkEy+RIy23+9MHz+U2sTMCIBd5kCepIWmc+Qoe2gMlqLegXVMJ4ZtD9kD94d/LcjtNlIQuBeWjxaVazw84tfBCqhXOuV6O6tvDtpE7bBtD5i7wIFQuSXkLiFCbD1uusJp0lhKXKhBsum0CDWxsZa24be15p1Ggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 60C24906E24D; Fri,  6 Jun 2025 14:31:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 14:31:03 -0700
Message-ID: <20250606213103.341143-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606213048.340421-1-yonghong.song@linux.dev>
References: <20250606213048.340421-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ringbuf max_entries must be PAGE_ALIGNED. See kernel function
ringbuf_map_alloc(). So for arm64 64KB page size, adjust max_entries
properly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c       | 4 ++--
 tools/testing/selftests/bpf/progs/test_ringbuf_write.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
index da430df45aa4..d89a1f68ae39 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -97,7 +97,7 @@ static void ringbuf_write_subtest(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
=20
-	skel->maps.ringbuf.max_entries =3D 0x4000;
+	skel->maps.ringbuf.max_entries =3D 4 * page_size;
=20
 	err =3D test_ringbuf_write_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -108,7 +108,7 @@ static void ringbuf_write_subtest(void)
 	mmap_ptr =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, =
rb_fd, 0);
 	if (!ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos"))
 		goto cleanup;
-	*mmap_ptr =3D 0x3000;
+	*mmap_ptr =3D 3 * page_size;
 	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
=20
 	skel->bss->pid =3D getpid();
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/too=
ls/testing/selftests/bpf/progs/test_ringbuf_write.c
index 350513c0e4c9..5f9d0c8bbffd 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
=20
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
=20
@@ -10,6 +10,8 @@ struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
 } ringbuf SEC(".maps");
=20
+extern bool CONFIG_ARM64_64K_PAGES __kconfig __weak;
+
 /* inputs */
 int pid =3D 0;
=20
@@ -26,11 +28,12 @@ int test_ringbuf_write(void *ctx)
 	if (cur_pid !=3D pid)
 		return 0;
=20
-	sample1 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample1 =3D bpf_ringbuf_reserve(&ringbuf, CONFIG_ARM64_64K_PAGES ? 0x30=
000 : 0x3000, 0);
+
 	if (!sample1)
 		return 0;
 	/* first one can pass */
-	sample2 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample2 =3D bpf_ringbuf_reserve(&ringbuf, CONFIG_ARM64_64K_PAGES ? 0x30=
000 : 0x3000, 0);
 	if (!sample2) {
 		bpf_ringbuf_discard(sample1, 0);
 		__sync_fetch_and_add(&discarded, 1);
--=20
2.47.1


