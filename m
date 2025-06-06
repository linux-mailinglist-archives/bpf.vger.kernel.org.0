Return-Path: <bpf+bounces-59910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A250AD07A6
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CBD7A70E3
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62C28C2A8;
	Fri,  6 Jun 2025 17:42:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9528C020
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231735; cv=none; b=qlXUVEzvi36wZ36yc8ylPGIQCzsoVZ40bQLFRdBh+GTDU0JIip/j9U+E2ZBFm9jtbEC+YqwTZ+coUSkM4Ti2Im9C91KICeWmI+ispR0tz7GZztrp4RQAEmol0w7n5fzqiJStTQ0XG8nzUseoqf/TLKYdCbefNa9gexmfbI096Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231735; c=relaxed/simple;
	bh=m96GOMeVkUz4k2cAYTGWFPmwjxY3HJFmW2fhMLk/1po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzPLGqWznNUCv+gdOyfrhyykMGHGTb14OTy2crjIhqe9muI3evx2HAhmAqPxjm2wi9uTTuxoTgeCDvdpoCKDZSjDXln96dq06A2gYQZcJQ+z3p/3zeczIyb2zFCgWAZ31PaaHK3eb5eOOqP5yFisiC+hH3LfCFI1beGF0bvKxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 634F39046D49; Fri,  6 Jun 2025 10:42:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 10:42:00 -0700
Message-ID: <20250606174200.3037511-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606174139.3036576-1-yonghong.song@linux.dev>
References: <20250606174139.3036576-1-yonghong.song@linux.dev>
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


