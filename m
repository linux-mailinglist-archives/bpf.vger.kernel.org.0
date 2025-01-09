Return-Path: <bpf+bounces-48426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A0BA07F1E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C523A6A46
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F581AA1F6;
	Thu,  9 Jan 2025 17:40:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E1190678
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444442; cv=none; b=BXPripR1ez7ywuGx4AdE2IPQocneawoTca00CiYKNnYeuaEgpbaOqAiYv2yhal3Kfbyj0EE1H4WogHiIE0LNRFRMaUlq04XZP5UPw7MguEr+RawHCAEB1DI+9OuChidJWRd9gQXNf/vkLR8k/AfnkngxmN1gnzOYKt6b4ByX2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444442; c=relaxed/simple;
	bh=g5wz4QlDUJ+MC0jk4ahnyb0isM0RT799/H8IvdHe6IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqVL7DSmraVzVuzxHjMr7ikJ7lB3e5AeGR9vd8TWga3bF/KDx7ze7+1dSpuwEMDK7oKUEN6FHder329BVGkyXvcSeoYHTF1AlnM8EiwkWpPmPvs5HRjHFHVh+FgfGetGlaK5ZRFiLnXDGSYd/HrK05oHANvTd7YdHJqlxx2QrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A8E42CCB2383; Thu,  9 Jan 2025 09:40:28 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test for kprobe multi with unique_match
Date: Thu,  9 Jan 2025 09:40:28 -0800
Message-ID: <20250109174028.3368967-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250109174023.3368432-1-yonghong.song@linux.dev>
References: <20250109174023.3368432-1-yonghong.song@linux.dev>
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


