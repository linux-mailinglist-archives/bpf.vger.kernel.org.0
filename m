Return-Path: <bpf+bounces-60439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87EAD6644
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9B817BA82
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D041D90C8;
	Thu, 12 Jun 2025 03:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9B1CAA76
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700245; cv=none; b=EOa20jlJi8QcjPDCGXz0Oi2j56Z8W0nCsqGDjrP+vbvvgvnYZiTmmq2uUncl3lhD/JMG4Y6jLzc7aZTgzQKWc6K53ZapAbMYlY7r1c5m0rzrWcn91hmpdzKwdpyP61h/2krKhUzK8RqzfaB+W9CRjw0x6KVVrgFGY6ECZuJTRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700245; c=relaxed/simple;
	bh=jJgT63k4r+/mDJ1wI8n6mvKTyi6x10RwgW4AYPOjMNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PluEKoqQ2V+hpJ2tGGRm27MZ7KT3pVsMW78TtakjvPTm2Nr9HRwk0TX/Kc9kRbnmuxoulUuKFRywBlxSN9R49yvBESS0LxsYyYMAgWZJSnXMfcKS8Ty0L8l2OuRrW2Jog9JBJLLXGs7GzY+8Dq+/4woHLtb3G5YAtuXCRNsoRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C529E96FFE57; Wed, 11 Jun 2025 20:50:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Fix xdp_do_redirect failure with 64KB page size
Date: Wed, 11 Jun 2025 20:50:42 -0700
Message-ID: <20250612035042.2208630-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250612035027.2207299-1-yonghong.song@linux.dev>
References: <20250612035027.2207299-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On arm64 with 64KB page size, the selftest xdp_do_redirect failed like
below:
  ...
  test_xdp_do_redirect:PASS:pkt_count_tc 0 nsec
  test_max_pkt_size:PASS:prog_run_max_size 0 nsec
  test_max_pkt_size:FAIL:prog_run_too_big unexpected prog_run_too_big: ac=
tual -28 !=3D expected -22

With 64KB page size, the xdp frame size will be much bigger so
the existing test will fail.

Adjust various parameters so the test can also work on 64K page size.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_do_redirect.c      | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 7dac044664ac..dd34b0cc4b4e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -66,16 +66,25 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, i=
nt fd)
 #else
 #define MAX_PKT_SIZE 3408
 #endif
+
+#define PAGE_SIZE_4K  4096
+#define PAGE_SIZE_64K 65536
+
 static void test_max_pkt_size(int fd)
 {
-	char data[MAX_PKT_SIZE + 1] =3D {};
+	char data[PAGE_SIZE_64K + 1] =3D {};
 	int err;
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in =3D &data,
-			    .data_size_in =3D MAX_PKT_SIZE,
 			    .flags =3D BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat =3D 1,
 		);
+
+	if (getpagesize() =3D=3D PAGE_SIZE_64K)
+		opts.data_size_in =3D MAX_PKT_SIZE + PAGE_SIZE_64K - PAGE_SIZE_4K;
+	else
+		opts.data_size_in =3D MAX_PKT_SIZE;
+
 	err =3D bpf_prog_test_run_opts(fd, &opts);
 	ASSERT_OK(err, "prog_run_max_size");
=20
--=20
2.47.1


