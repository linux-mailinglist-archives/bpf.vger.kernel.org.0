Return-Path: <bpf+bounces-59983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EDAD0ADD
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 03:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251D83A2629
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B930B8F6B;
	Sat,  7 Jun 2025 01:36:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6422FF2B
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749260197; cv=none; b=Cx3WwB3MgfPWsLfJW0+adMdoEpVJct6hc/ii33Z/LKjctNmfAPfY6T4GdggoZQHhYjKhkhU0pU+XXm3a42upp4RTQVVFkE2sGfht0kxRzqnB29/Djd9VWegMbQIA7unNDbY1kms9X9uva+ikgogDLvtir5GJ8TsFIn1LgAtA3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749260197; c=relaxed/simple;
	bh=m96GOMeVkUz4k2cAYTGWFPmwjxY3HJFmW2fhMLk/1po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/sMjrGZcib0fiNowGhVAlXkOokw+WQR44oF7NCej5kDjbfs8OWYFRaYIijVm38nBAmoWTt3PoQhOrFy1z34Enj9FtTsXGpktNR29ATR9rNJmlN4rvMJ6KDKokTBsEUrXVLOcRqyGeFaTsGteUpRDRkdStoz53EmM0AN4Nfk/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2619E909783C; Fri,  6 Jun 2025 18:36:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 18:36:26 -0700
Message-ID: <20250607013626.1553001-1-yonghong.song@linux.dev>
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
properly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tool=
s/testing/selftests/bpf/prog_tests/user_ringbuf.c
index d424e7ecbd12..9fd3ae987321 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -21,8 +21,7 @@
 #include "../progs/test_user_ringbuf.h"
=20
 static const long c_sample_size =3D sizeof(struct sample) + BPF_RINGBUF_=
HDR_SZ;
-static const long c_ringbuf_size =3D 1 << 12; /* 1 small page */
-static const long c_max_entries =3D c_ringbuf_size / c_sample_size;
+static long c_ringbuf_size, c_max_entries;
=20
 static void drain_current_samples(void)
 {
@@ -424,7 +423,9 @@ static void test_user_ringbuf_loop(void)
 	uint32_t remaining_samples =3D total_samples;
 	int err;
=20
-	BUILD_BUG_ON(total_samples <=3D c_max_entries);
+	if (!ASSERT_LT(c_max_entries, total_samples, "compare_c_max_entries"))
+		return;
+
 	err =3D load_skel_create_user_ringbuf(&skel, &ringbuf);
 	if (err)
 		return;
@@ -686,6 +687,9 @@ void test_user_ringbuf(void)
 {
 	int i;
=20
+	c_ringbuf_size =3D getpagesize(); /* 1 page */
+	c_max_entries =3D c_ringbuf_size / c_sample_size;
+
 	for (i =3D 0; i < ARRAY_SIZE(success_tests); i++) {
 		if (!test__start_subtest(success_tests[i].test_name))
 			continue;
--=20
2.47.1


