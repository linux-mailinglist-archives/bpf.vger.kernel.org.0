Return-Path: <bpf+bounces-18071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4DB81566A
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2592A1F21A03
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA401C38;
	Sat, 16 Dec 2023 02:30:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80956443E
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0E10A2B95861F; Fri, 15 Dec 2023 18:30:30 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
Date: Fri, 15 Dec 2023 18:30:30 -0800
Message-Id: <20231216023030.3742304-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216023004.3738749-1-yonghong.song@linux.dev>
References: <20231216023004.3738749-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the previous patch, the maximum data size for bpf_global_percpu_ma
is 512 bytes. This breaks selftest test_bpf_ma. The test is adjusted
in two aspects:
  - Since the maximum allowed data size for bpf_global_percpu_ma is
    512, remove all tests beyond that, names sizes 1024, 2048 and 4096.
  - Previously the percpu data size is bucket_size - 8 in order to
    avoid percpu allocation into the next bucket. This patch removed
    such data size adjustment thanks to Patch 1.

Also, a better way to generate BTF type is used than adding
a member to the value struct.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/test_bpf_ma.c    | 20 +++++++----
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 34 +++++++++----------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c b/tools=
/testing/selftests/bpf/prog_tests/test_bpf_ma.c
index d3491a84b3b9..ccae0b31ac6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
@@ -14,7 +14,8 @@ static void do_bpf_ma_test(const char *name)
 	struct test_bpf_ma *skel;
 	struct bpf_program *prog;
 	struct btf *btf;
-	int i, err;
+	int i, err, id;
+	char tname[32];
=20
 	skel =3D test_bpf_ma__open();
 	if (!ASSERT_OK_PTR(skel, "open"))
@@ -25,16 +26,21 @@ static void do_bpf_ma_test(const char *name)
 		goto out;
=20
 	for (i =3D 0; i < ARRAY_SIZE(skel->rodata->data_sizes); i++) {
-		char name[32];
-		int id;
-
-		snprintf(name, sizeof(name), "bin_data_%u", skel->rodata->data_sizes[i=
]);
-		id =3D btf__find_by_name_kind(btf, name, BTF_KIND_STRUCT);
-		if (!ASSERT_GT(id, 0, "bin_data"))
+		snprintf(tname, sizeof(tname), "bin_data_%u", skel->rodata->data_sizes=
[i]);
+		id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
+		if (!ASSERT_GT(id, 0, tname))
 			goto out;
 		skel->rodata->data_btf_ids[i] =3D id;
 	}
=20
+	for (i =3D 0; i < ARRAY_SIZE(skel->rodata->percpu_data_sizes); i++) {
+		snprintf(tname, sizeof(tname), "percpu_bin_data_%u", skel->rodata->per=
cpu_data_sizes[i]);
+		id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
+		if (!ASSERT_GT(id, 0, tname))
+			goto out;
+		skel->rodata->percpu_data_btf_ids[i] =3D id;
+	}
+
 	prog =3D bpf_object__find_program_by_name(skel->obj, name);
 	if (!ASSERT_OK_PTR(prog, "invalid prog name"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_ma.c
index b685a4aba6bd..e453a9392e5a 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -20,6 +20,9 @@ char _license[] SEC("license") =3D "GPL";
 const unsigned int data_sizes[] =3D {8, 16, 32, 64, 96, 128, 192, 256, 5=
12, 1024, 2048, 4096};
 const volatile unsigned int data_btf_ids[ARRAY_SIZE(data_sizes)] =3D {};
=20
+const unsigned int percpu_data_sizes[] =3D {8, 16, 32, 64, 96, 128, 192,=
 256, 512};
+const volatile unsigned int percpu_data_btf_ids[ARRAY_SIZE(data_sizes)] =
=3D {};
+
 int err =3D 0;
 int pid =3D 0;
=20
@@ -27,10 +30,10 @@ int pid =3D 0;
 	struct bin_data_##_size { \
 		char data[_size - sizeof(void *)]; \
 	}; \
+	/* See Commit 5d8d6634ccc, force btf generation for type bin_data_##_si=
ze */	\
+	struct bin_data_##_size *__bin_data_##_size; \
 	struct map_value_##_size { \
 		struct bin_data_##_size __kptr * data; \
-		/* To emit BTF info for bin_data_xx */ \
-		struct bin_data_##_size not_used; \
 	}; \
 	struct { \
 		__uint(type, BPF_MAP_TYPE_ARRAY); \
@@ -40,8 +43,12 @@ int pid =3D 0;
 	} array_##_size SEC(".maps")
=20
 #define DEFINE_ARRAY_WITH_PERCPU_KPTR(_size) \
+	struct percpu_bin_data_##_size { \
+		char data[_size]; \
+	}; \
+	struct percpu_bin_data_##_size *__percpu_bin_data_##_size; \
 	struct map_value_percpu_##_size { \
-		struct bin_data_##_size __percpu_kptr * data; \
+		struct percpu_bin_data_##_size __percpu_kptr * data; \
 	}; \
 	struct { \
 		__uint(type, BPF_MAP_TYPE_ARRAY); \
@@ -114,7 +121,7 @@ static __always_inline void batch_percpu_alloc(struct=
 bpf_map *map, unsigned int
 			return;
 		}
 		/* per-cpu allocator may not be able to refill in time */
-		new =3D bpf_percpu_obj_new_impl(data_btf_ids[idx], NULL);
+		new =3D bpf_percpu_obj_new_impl(percpu_data_btf_ids[idx], NULL);
 		if (!new)
 			continue;
=20
@@ -179,7 +186,7 @@ DEFINE_ARRAY_WITH_KPTR(1024);
 DEFINE_ARRAY_WITH_KPTR(2048);
 DEFINE_ARRAY_WITH_KPTR(4096);
=20
-/* per-cpu kptr doesn't support bin_data_8 which is a zero-sized array *=
/
+DEFINE_ARRAY_WITH_PERCPU_KPTR(8);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(16);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(32);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(64);
@@ -188,9 +195,6 @@ DEFINE_ARRAY_WITH_PERCPU_KPTR(128);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(192);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(256);
 DEFINE_ARRAY_WITH_PERCPU_KPTR(512);
-DEFINE_ARRAY_WITH_PERCPU_KPTR(1024);
-DEFINE_ARRAY_WITH_PERCPU_KPTR(2048);
-DEFINE_ARRAY_WITH_PERCPU_KPTR(4096);
=20
 SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
 int test_batch_alloc_free(void *ctx)
@@ -248,9 +252,10 @@ int test_batch_percpu_alloc_free(void *ctx)
 	if ((u32)bpf_get_current_pid_tgid() !=3D pid)
 		return 0;
=20
-	/* Alloc 128 16-bytes per-cpu objects in batch to trigger refilling,
-	 * then free 128 16-bytes per-cpu objects in batch to trigger freeing.
+	/* Alloc 128 8-bytes per-cpu objects in batch to trigger refilling,
+	 * then free 128 8-bytes per-cpu objects in batch to trigger freeing.
 	 */
+	CALL_BATCH_PERCPU_ALLOC_FREE(8, 128, 0);
 	CALL_BATCH_PERCPU_ALLOC_FREE(16, 128, 1);
 	CALL_BATCH_PERCPU_ALLOC_FREE(32, 128, 2);
 	CALL_BATCH_PERCPU_ALLOC_FREE(64, 128, 3);
@@ -259,9 +264,6 @@ int test_batch_percpu_alloc_free(void *ctx)
 	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
 	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
 	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
-	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
-	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
-	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
=20
 	return 0;
 }
@@ -272,9 +274,10 @@ int test_percpu_free_through_map_free(void *ctx)
 	if ((u32)bpf_get_current_pid_tgid() !=3D pid)
 		return 0;
=20
-	/* Alloc 128 16-bytes per-cpu objects in batch to trigger refilling,
+	/* Alloc 128 8-bytes per-cpu objects in batch to trigger refilling,
 	 * then free these object through map free.
 	 */
+	CALL_BATCH_PERCPU_ALLOC(8, 128, 0);
 	CALL_BATCH_PERCPU_ALLOC(16, 128, 1);
 	CALL_BATCH_PERCPU_ALLOC(32, 128, 2);
 	CALL_BATCH_PERCPU_ALLOC(64, 128, 3);
@@ -283,9 +286,6 @@ int test_percpu_free_through_map_free(void *ctx)
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


