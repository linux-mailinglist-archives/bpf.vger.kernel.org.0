Return-Path: <bpf+bounces-59835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FACACFB9D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 05:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B283AFC82
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F801E1C3A;
	Fri,  6 Jun 2025 03:23:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2019066B
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180223; cv=none; b=Segg4doNWveTGFBwGbhiRI4ORFhwu4/nUZMhQkzTv8Wla15m8fOdfNlUEL8hGmsnieSxCg6Sky1YmoCXOrfdYRscLItCXzkNFDcURRvLYZGf1kLLj5Y2QkY4fx0PxoBrxZPHZ2lstBBfNbpQO1NLgcQ6U63O4iHU+bbcVcTG5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180223; c=relaxed/simple;
	bh=06RDIb69u1gSeiB+Xdk31l6rl3SQm6P5JNBNcbsavok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp9c40bsarop7CshQuovBuf+tmEgDmc5tqu1TxfJctsDWw9h/H9e4D7dKEsus0z6cmiYLZ7b/nuRFDbblphB9xIXKx6A1GlOflA1iGR2z71GXtFwv2fcGALYN/TUEYX0mndTS3wkyBdzSa0MvssAjJgJSHMw4LlQ+yEp6Lz7Xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig061.cco5.facebook.com (Postfix, from userid 128203)
	id 20359202EDF0; Thu,  5 Jun 2025 20:23:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
Date: Thu,  5 Jun 2025 20:23:30 -0700
Message-ID: <20250606032330.446016-1-yonghong.song@linux.dev>
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
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tool=
s/testing/selftests/bpf/prog_tests/user_ringbuf.c
index d424e7ecbd12..f50aa8e7f6c2 100644
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
@@ -686,6 +685,9 @@ void test_user_ringbuf(void)
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


