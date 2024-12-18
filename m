Return-Path: <bpf+bounces-47281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061379F7055
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AA816AF6D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D11FCCFB;
	Wed, 18 Dec 2024 22:55:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8C1DDC2A
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562526; cv=none; b=jMzEgnovdePJycvy1+5gcAhHycn9vKBa/Oum5XbwNzFslQkNd4P5IDBvotBpBVkQfABcfoi9pZt+ZnJMsYipM+EdLqvD5w+zLyz1Nca7trY13B73Tzge04oGVXZyw4G4lgOSMoXLW/VelryKvyNop8ldpMkkVWyTDbVNxqW59Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562526; c=relaxed/simple;
	bh=g5wz4QlDUJ+MC0jk4ahnyb0isM0RT799/H8IvdHe6IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agcHENUdEQhBm/LY8IDkhwpxKFusSZSY/T2qr+YALPSJmFk2OXxgj5TL+/mSev5/P/aQ3R9QS7+4PqT3GO7dn+xldPkmG04ca+kp0ykrLkKoP7wMlwgpLzQ9ypZEF8uFTiPYICYdCGcpTkLyaTVSSpk3D6IAn/aMgm4T0/6d20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 59D8DC2A6A8B; Wed, 18 Dec 2024 14:52:52 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test for kprobe multi with unique_match
Date: Wed, 18 Dec 2024 14:52:52 -0800
Message-ID: <20241218225252.3170962-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218225246.3170300-1-yonghong.song@linux.dev>
References: <20241218225246.3170300-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a kprobe multi subtest to test kprobe multi unique_match option.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 66ab1cae923e..e19ef509ebf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -397,6 +397,31 @@ static void test_session_cookie_skel_api(void)
 	kprobe_multi_session_cookie__destroy(skel);
 }
=20
+static void test_unique_match(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct kprobe_multi *skel =3D NULL;
+	struct bpf_link *link =3D NULL;
+
+	skel =3D kprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi__open_and_load"))
+		return;
+
+	opts.unique_match =3D true;
+	skel->bss->pid =3D getpid();
+	link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_=
manual,
+						     "bpf_fentry_test*", &opts);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
+		bpf_link__destroy(link);
+
+	link =3D bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_=
manual,
+						     "bpf_fentry_test8*", &opts);
+	if (ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
+		bpf_link__destroy(link);
+
+	kprobe_multi__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -765,5 +790,7 @@ void test_kprobe_multi_test(void)
 		test_session_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
+	if (test__start_subtest("unique_match"))
+		test_unique_match();
 	RUN_TESTS(kprobe_multi_verifier);
 }
--=20
2.43.5


