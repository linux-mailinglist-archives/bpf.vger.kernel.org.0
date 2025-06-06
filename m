Return-Path: <bpf+bounces-59833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62137ACFB9B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 05:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6EB7A1CC1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511B1E32D6;
	Fri,  6 Jun 2025 03:23:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBD91DF963
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180210; cv=none; b=bVg/9V4ILHM+Zj7xZUGethXVHQdDcguK+qMxH8MEMwR01aPuiYwaPKXoRd5IrYXcE7Yxk3pJcvMIzM6F8xiA40FPXCAfhbv9QSLFCy/HOczeA4CQDJxeqcJf98c49PNoXfsjSbECPqdg1rwDe4f6NBk67rUhH8dGWoEGPn8PPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180210; c=relaxed/simple;
	bh=NmJ+Msv6fUmqKhjBC4MSS0SFpd8+eyyd3BJsab8idZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k31IV2iDa2Xd6PboDVPGeaf/d9gafGoahkFcrJFnfqnu1Z0M3gv41GIoB2mvIp29w/WYQEXGFvCG9eHFLz7LzFWJOfGjHBfhSoffAtl/77/nhCwqthvz6oXtBeFYJVPq5STwnqDJHHpvBD4aup0VKJnjgOIoAhc1zzzyi9K3sbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig061.cco5.facebook.com (Postfix, from userid 128203)
	id 12398202EDDC; Thu,  5 Jun 2025 20:23:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
Date: Thu,  5 Jun 2025 20:23:25 -0700
Message-ID: <20250606032325.445567-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606032309.444401-1-yonghong.song@linux.dev>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
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
 tools/testing/selftests/bpf/prog_tests/ringbuf.c       | 5 +++--
 tools/testing/selftests/bpf/progs/test_ringbuf_write.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
index da430df45aa4..89fd3401a23e 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -97,7 +97,8 @@ static void ringbuf_write_subtest(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
=20
-	skel->maps.ringbuf.max_entries =3D 0x4000;
+	skel->maps.ringbuf.max_entries =3D 4 * page_size;
+	skel->rodata->reserve_size =3D 3 * page_size;
=20
 	err =3D test_ringbuf_write_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -108,7 +109,7 @@ static void ringbuf_write_subtest(void)
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
index 350513c0e4c9..9acef7afbe8a 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
@@ -12,6 +12,7 @@ struct {
=20
 /* inputs */
 int pid =3D 0;
+const volatile int reserve_size =3D 0;
=20
 /* outputs */
 long passed =3D 0;
@@ -26,11 +27,11 @@ int test_ringbuf_write(void *ctx)
 	if (cur_pid !=3D pid)
 		return 0;
=20
-	sample1 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample1 =3D bpf_ringbuf_reserve(&ringbuf, reserve_size, 0);
 	if (!sample1)
 		return 0;
 	/* first one can pass */
-	sample2 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample2 =3D bpf_ringbuf_reserve(&ringbuf, reserve_size, 0);
 	if (!sample2) {
 		bpf_ringbuf_discard(sample1, 0);
 		__sync_fetch_and_add(&discarded, 1);
--=20
2.47.1


