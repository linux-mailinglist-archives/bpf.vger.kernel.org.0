Return-Path: <bpf+bounces-59951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47511AD098E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2518189DCFE
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425123C516;
	Fri,  6 Jun 2025 21:31:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9326233136
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245482; cv=none; b=eO1Us13Asgf9OME2g4dN3WhEphbrGuBHYar0tO0PRbLProaCk2MK3USj5fWGHk4/Hf4zEKbDROA8xR0Tw7le/B6n5A5qFuoORlpDfZ5MGE5U1y9MPzsKrPY2XDmXqftcG+dRHrynhXFs2hCkRrB0o6hLVq07D8i5kwOeb7BvbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245482; c=relaxed/simple;
	bh=m96GOMeVkUz4k2cAYTGWFPmwjxY3HJFmW2fhMLk/1po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZwukfsFBfWj38dhh3RVXwpHP6gRT4lIcP8ZsruyqUitgwxYgM9CO+588L1WwIWouP7sFrxEsz68LhW6On0U3Is6hHq41iErTvKauyAW3glneXhd7FWvqzz5r+YC0L378njXBZXBvAhSpioR+GETpXoKU7gOQnquMvI4GaF6sUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 78BE1906E287; Fri,  6 Jun 2025 14:31:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
Date: Fri,  6 Jun 2025 14:31:08 -0700
Message-ID: <20250606213108.342156-1-yonghong.song@linux.dev>
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


