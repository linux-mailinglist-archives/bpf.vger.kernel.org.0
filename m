Return-Path: <bpf+bounces-17908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9594813E93
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F13B1F22B30
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A2EC8;
	Fri, 15 Dec 2023 00:12:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF8EBD
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 406F52B862860; Thu, 14 Dec 2023 16:12:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
Date: Thu, 14 Dec 2023 16:12:27 -0800
Message-Id: <20231215001227.3254314-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215001152.3249146-1-yonghong.song@linux.dev>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the previous patch, the maximum data size for bpf_global_percpu_ma
is 512 bytes. This breaks selftest test_bpf_ma. Let us adjust it
accordingly. Also added a selftest to capture the verification failure
when the allocation size is greater than 512.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/percpu_alloc_fail.c    | 18 ++++++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_ma.c  |  9 ---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tool=
s/testing/selftests/bpf/progs/percpu_alloc_fail.c
index 1a891d30f1fe..f2b8eb2ff76f 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -17,6 +17,10 @@ struct val_with_rb_root_t {
 	struct bpf_spin_lock lock;
 };
=20
+struct val_600b_t {
+	char b[600];
+};
+
 struct elem {
 	long sum;
 	struct val_t __percpu_kptr *pc;
@@ -161,4 +165,18 @@ int BPF_PROG(test_array_map_7)
 	return 0;
 }
=20
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("bpf_percpu_obj_new type size (600) is greater than 512"=
)
+int BPF_PROG(test_array_map_8)
+{
+	struct val_600b_t __percpu_kptr *p;
+
+	p =3D bpf_percpu_obj_new(struct val_600b_t);
+	if (!p)
+		return 0;
+
+	bpf_percpu_obj_drop(p);
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_ma.c
index b685a4aba6bd..68cba55eb828 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -188,9 +188,6 @@ DEFINE_ARRAY_WITH_PERCPU_KPTR(128);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(192);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(256);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(512);
-DEFINE_ARRAY_WITH_PERCPU_KPTR(1024);
-DEFINE_ARRAY_WITH_PERCPU_KPTR(2048);
-DEFINE_ARRAY_WITH_PERCPU_KPTR(4096);
=20
 SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
 int test_batch_alloc_free(void *ctx)
@@ -259,9 +256,6 @@ int test_batch_percpu_alloc_free(void *ctx)
 	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
 	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
 	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
-	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
-	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
-	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
=20
 	return 0;
 }
@@ -283,9 +277,6 @@ int test_percpu_free_through_map_free(void *ctx)
 	CALL_BATCH_PERCPU_ALLOC(192, 128, 6);
 	CALL_BATCH_PERCPU_ALLOC(256, 128, 7);
 	CALL_BATCH_PERCPU_ALLOC(512, 64, 8);
-	CALL_BATCH_PERCPU_ALLOC(1024, 32, 9);
-	CALL_BATCH_PERCPU_ALLOC(2048, 16, 10);
-	CALL_BATCH_PERCPU_ALLOC(4096, 8, 11);
=20
 	return 0;
 }
--=20
2.34.1


