Return-Path: <bpf+bounces-59982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF66AD0ADC
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 03:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859463A2A06
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C242586CE;
	Sat,  7 Jun 2025 01:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6B21CA0E
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749260195; cv=none; b=IueV5j0jqeRbHJSeyNa+XiSpZbg4IrzFWFaPSndkDvmPaxRsq/fhEob648gfq2ujEUamXgOhgoUQvzxDrK+ioh6TY+2YRn8r2PrSeXVhIl0MJcxckwQdvHsAO0gQKezMS7rFqEMKoZVpE2gEn650LaNaNrGss02Ut81NFREP3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749260195; c=relaxed/simple;
	bh=Jg4mQ+GfYNuhgAbf/qQPyeGUeyDJG2M6pqw1yt4AAyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/3cUJBp+ekIeYlUGvTFgEK8OSmI7m/hmIHsErira7hZ/2x16t4RcCvTD0deHRiWgrI3TZpTXTLZuU7CuqQj5/xoTYj1qt5AHqZ08yhiswQPMd81YC+kaDOWMpNtyv3BStURI5LL4z2F/2OR6dBwws7K3C+s99Npj/kJL75LxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0E389909774A; Fri,  6 Jun 2025 18:36:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 18:36:21 -0700
Message-ID: <20250607013621.1552332-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250607013605.1550284-1-yonghong.song@linux.dev>
References: <20250607013605.1550284-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ringbuf max_entries must be PAGE_ALIGNED. See kernel function
ringbuf_map_alloc(). So for arm64 64KB page size, adjust max_entries
and other related metrics properly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c       | 4 ++--
 tools/testing/selftests/bpf/progs/test_ringbuf_write.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
index da430df45aa4..d1e4cb28a72c 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -97,7 +97,7 @@ static void ringbuf_write_subtest(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
=20
-	skel->maps.ringbuf.max_entries =3D 0x4000;
+	skel->maps.ringbuf.max_entries =3D 0x40000;
=20
 	err =3D test_ringbuf_write_lskel__load(skel);
 	if (!ASSERT_OK(err, "skel_load"))
@@ -108,7 +108,7 @@ static void ringbuf_write_subtest(void)
 	mmap_ptr =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, =
rb_fd, 0);
 	if (!ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos"))
 		goto cleanup;
-	*mmap_ptr =3D 0x3000;
+	*mmap_ptr =3D 0x30000;
 	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
=20
 	skel->bss->pid =3D getpid();
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/too=
ls/testing/selftests/bpf/progs/test_ringbuf_write.c
index 350513c0e4c9..f063a0013f85 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
@@ -26,11 +26,11 @@ int test_ringbuf_write(void *ctx)
 	if (cur_pid !=3D pid)
 		return 0;
=20
-	sample1 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample1 =3D bpf_ringbuf_reserve(&ringbuf, 0x30000, 0);
 	if (!sample1)
 		return 0;
 	/* first one can pass */
-	sample2 =3D bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	sample2 =3D bpf_ringbuf_reserve(&ringbuf, 0x30000, 0);
 	if (!sample2) {
 		bpf_ringbuf_discard(sample1, 0);
 		__sync_fetch_and_add(&discarded, 1);
--=20
2.47.1


