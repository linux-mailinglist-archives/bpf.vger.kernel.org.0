Return-Path: <bpf+bounces-55307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04012A7B680
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 05:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B863BA302
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2115990C;
	Fri,  4 Apr 2025 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf91+YzC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66597E0E4
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735760; cv=none; b=cagFEdLDQiXEF6FGuHRjejTAzA7BkmwrznL+TI4lMyy6tsadI16EliFgAkj4hg0NAp62nOlG91c2lXIAagx3T52bn2AuxlXRgu1i7aYeotkMkv6IMMrEbWnF+H5KG9RsY+JHtUOCmybcq8g0jh5uWG5w0NCHDqIbXtY0NDivyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735760; c=relaxed/simple;
	bh=n+dLiwKJsOMQ5MduL7pEjDugiQuow9xWIHCWHK97StE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj0fcILNLrX86Ltfdt/VSY+RuXV6/O9y6RC4r25P81HgmXzvv+fXME7pLOkcfcKCtdcV4VCHUp6NYnfZst+eGksKS6oMLYwJe/FhHBTHfbdGFR3bMlodtALvWcZugV2zpSMKvLTMsB2zxERz+0TE5JK5yZCnMvN9QI/yOJTPVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf91+YzC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224100e9a5cso16690325ad.2
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743735758; x=1744340558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTKHfzmLxwpjo5XyMlBV0ireHJWZGqVpIVl7R6DN1cA=;
        b=Mf91+YzCFfyCEby6cgj8DsuoC0DImz+CBvjaYUjniEUGaHGFw0fECguXaJIfGm1nj4
         gfP1DGPB4qNOvCNu4bA+EXtu+f0ljBW1xcpJwD1X7Wdz+p/mami8wLQGFFccP1T52Ke4
         MN1U+jYsLql7fVf6hNqjRcGvJtZdfaWS0xsFgdVbkP90bGYVxz1umo1RDwSQgMKCLU6I
         +djwoW4k/7Mkle7jaXDmmuC2XIBJmsBbu5MtOgfv9OeOqS4LVszGpk2x2tNwdaEmBGQR
         llvLMfa9p4gDG4kmDu0Ah9G7B7zKTUiZHgKBKoyyQFiO8rSbvf/mgzlEeZr1NCh+vkz9
         /J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743735758; x=1744340558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTKHfzmLxwpjo5XyMlBV0ireHJWZGqVpIVl7R6DN1cA=;
        b=FcgSjpj6FezNO2eIXe94GyL88u7iMwZozlpT8d1LcaXPpS/it9RbN7X/hJuLhKTkPg
         oGq2v1M/8SfkH/ljvfVve+TXsqBetE8twTyS/3OPu3Df36cp0NiudAWDt0tyCBXyLxZR
         HUg4CqSHU6xLKB16rmZsKI8HHLDWPUAIBy/6xFFw6PB0qTyjFIJh0RD+hzvGbyvwQ0CH
         49TXt6XBLaHmUY/FjJNa1PBp9uj9tag2hPxPo4ptuivHT1Ox5raC6Mvq4zny8W2xBk7+
         X18TsqypWyrTavWx7lLHjwRB+GQVDbpH8o5yZWkfWFhyuuOCRWAnH2yhTt7vNyfqOXYF
         ox5Q==
X-Gm-Message-State: AOJu0Yxk04hKAFT1LmZJ0gWWsbNNSu5pfhXEmpc6JerNo9JLuxj0dH0W
	THy3IOndzrh4y/eAcH/eT/NDdaS8+o0erT8tg2OGxrF5bNrrnf+aKAtMow==
X-Gm-Gg: ASbGncvT7TyGcvCGeaJ5XPzBfxU+s68R3CxWL3Dh8UADl03JuaHMkdgdnjJxjIL4z6I
	2Z4MplMVTZWbuinFzO7BQqmvEY7yCriDUpIZ1s8+VTat0BpWvjnbWJ0D0qy+QOLJGcaRMR1dVKS
	+6S98XW1/a2/EjIfjHOAcM73Ne0FaoN3dZ7kL7WhcIBJcguow5AboUTlvzsre+TU84Ab+nQbmvS
	boKAllVJ9vW95KFavDqLBCPPfSKuFKIeoDIj5013ZSNPDuvK8RwrNja/ss9aKmyE1X+6SIumAox
	yatdgkLKrsBLkJZ6g7q32mIeFIIaYtDReTSzndOiBW12b1ueUkxUIq7tqJBh1H1xY5UyNvi24di
	tepTti91Bl9OYNq9qmF8+132V4NE/kg==
X-Google-Smtp-Source: AGHT+IEzvGyXdhZiX8hCaPAUp4Xgzu0c3fsqLYEtho6dTlYA2pwGozx5IxvaNQI6sr+OWYdW4UP1kQ==
X-Received: by 2002:a17:902:ef07:b0:223:37b8:c213 with SMTP id d9443c01a7336-22a8a8e47bemr17404305ad.52.1743735757623;
        Thu, 03 Apr 2025 20:02:37 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0791sm2262954b3a.110.2025.04.03.20.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:02:37 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v2 4/4] selftests/bpf: Test updating KV store layout when rolling out new prog
Date: Thu,  3 Apr 2025 20:02:27 -0700
Message-ID: <20250404030227.2690759-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404030227.2690759-1-ameryhung@gmail.com>
References: <20250404030227.2690759-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This example shows how user space manages a KV store by maintain a
manifest of key-value pairs. The user space program should know all key-
value pairs used in the bpf program before attaching the program and keeps
them in a struct kv_pairs. Inside kv_pairs::array, each element is a
struct kv_pair. It comprises the key, the size of the value and optionally
the initial value.

When first creating a kv_store object, kv_pairs can be used to initialized
its content via kv_store_init(). If not provided, a 16-key, 256-byte
value storage KV store will be created and the user space program will use
kv_store_set() to initialize it.

When rolling out a new bpf program, the user space program will need to
tell libbpf to reuse the task local storage map used to back the KV store
by calling kv_store_reuse(). Then, it will update the kv_pairs and call
kv_store_update() to update the KV store. Keys no longer exist in
kv_pairs will be deleted. Keys that exists but whose value sizes change
will also be deleted, and then a new key-value pair associated with the
same key will be created. Finally, new key-value pairs are added. When
updating key-value pairs, if kv_pair::val is not NULL, the value will be
set to the value provided. Otherwise, the value will be zero initialized
if the key-value pair is newly added, or it will remain what it is if
the key-value pair already exists.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_uptr_kv_store.c       | 184 ++++++++++++++++++
 .../selftests/bpf/progs/test_uptr_kv_store.c  |   7 +
 .../bpf/progs/test_uptr_kv_store_v1.c         |  44 +++++
 .../selftests/bpf/test_uptr_kv_store_common.h |  13 ++
 4 files changed, 248 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
index c61b44ba8639..42c7000de14e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
@@ -3,6 +3,7 @@
 #include "uptr_kv_store.h"
 #include "test_uptr_kv_store_common.h"
 #include "test_uptr_kv_store.skel.h"
+#include "test_uptr_kv_store_v1.skel.h"
 
 static void test_uptr_kv_store_basic(void)
 {
@@ -68,8 +69,191 @@ static void test_uptr_kv_store_basic(void)
 	kv_store_close(kvs);
 }
 
+static void test_uptr_kv_store_update(void)
+{
+	struct test_struct val2 = {.a = 1, .b = 2};
+	struct kv_pair kvp_array[5] = {
+		{.key = 0, .val = NULL, .size = sizeof(int)},
+		{.key = 1, .val = NULL, .size = sizeof(int)},
+		{.key = 2, .val = &val2, .size = sizeof(struct test_struct)},
+		{.key = 3, .val = NULL, .size = sizeof(struct test_struct)},
+		{.key = 4, .val = NULL, .size = sizeof(int)},
+	};
+	struct test_struct_v1 val2_v1 = {.a = 3, .b = 4, .c = 5};
+	int val4 = 1234;
+	struct kv_pair kvp_array_v1[5] = {
+		{.key = 0, .val = NULL, .size = sizeof(int)},
+		{.key = 2, .val = &val2_v1, .size = sizeof(struct test_struct_v1)},
+		{.key = 4, .val = &val4, .size = sizeof(int)},
+		{.key = 6, .val = NULL, .size = sizeof(struct test_struct_v1)},
+		{.key = 8, .val = NULL, .size = sizeof(int)},
+	};
+	struct test_uptr_kv_store_v1 *skel_v1;
+	struct test_uptr_kv_store *skel;
+	struct kv_pairs *kvp, *kvp_v1;
+	struct kv_store *kvs = NULL;
+	int err, pid, val;
+	void *val_p;
+
+	kvp = malloc(sizeof(struct kv_pairs) + sizeof(struct kv_pair) * 5);
+	if (!ASSERT_OK_PTR(kvp, "malloc kvp"))
+		goto out;
+	kvp->array_cnt = 5;
+	memcpy(&kvp->array, &kvp_array, sizeof(struct kv_pair) * 5);
+
+	kvp_v1 = malloc(sizeof(struct kv_pairs) + sizeof(struct kv_pair) * 5);
+	if (!ASSERT_OK_PTR(kvp_v1, "malloc kvp_v1"))
+		goto out;
+	kvp_v1->array_cnt = 5;
+	memcpy(&kvp_v1->array, &kvp_array_v1, sizeof(struct kv_pair) * 5);
+
+	/* Rollout the initial version */
+	skel = test_uptr_kv_store__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	pid = sys_gettid();
+	kvs = kv_store_init(pid, skel->maps.data_map, "/sys/fs/bpf/kv_store_data_map", kvp);
+	if (!ASSERT_OK_PTR(kvs, "kv_store_init"))
+		goto out;
+
+	skel->bss->target_pid = -1;
+	err = test_uptr_kv_store__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		return;
+
+	/* Check if the KV store is initialized correctly */
+	val_p = kv_store_get(kvs, 0);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 0)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 0, "value[0]");
+
+	val_p = kv_store_get(kvs, 1);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 1)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 0, "value[1]");
+
+	val_p = kv_store_get(kvs, 2);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 2)"))
+		goto out;
+	ASSERT_EQ(((struct test_struct *)val_p)->a, 1, "value[2].a");
+	ASSERT_EQ(((struct test_struct *)val_p)->b, 2, "value[2].b");
+
+	val_p = kv_store_get(kvs, 3);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 3)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 0, "value[3]");
+
+	val_p = kv_store_get(kvs, 4);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 4)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 0, "value[4] = 0");
+
+	/* Make sure bpf prog see the same thing */
+	skel->bss->target_pid = pid;
+	skel->bss->test_key = 2;
+	skel->bss->test_op = KVS_STRUCT_GET;
+	sys_gettid();
+	ASSERT_EQ(skel->bss->test_struct_val.a, 1, "bpf:value[2].a");
+	ASSERT_EQ(skel->bss->test_struct_val.b, 2, "bpf:value[2].b");
+	skel->bss->target_pid = -1;
+
+	/* Change some key-value pairs */
+	val = 1;
+	kv_store_set(kvs, 0, &val, sizeof(val));
+
+	/* Reuse the KV store and rollout v1 program */
+	skel_v1 = test_uptr_kv_store_v1__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open v1"))
+		goto out;
+
+	kv_store_reuse(kvs, skel_v1->maps.data_map);
+
+	kv_store_update(kvs, kvp_v1);
+
+	err = test_uptr_kv_store_v1__load(skel_v1);
+	if (!ASSERT_OK(err, "skel_load v1"))
+		goto out;
+
+	skel_v1->bss->target_pid = -1;
+	err = test_uptr_kv_store_v1__attach(skel_v1);
+	if (!ASSERT_OK(err, "skel_attach v1"))
+		goto out;
+
+	/* Check if the KV store is updated correctly */
+	/* value[0] already exists and should not be zero initialized again */
+	val_p = kv_store_get(kvs, 0);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 0)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 1, "value[0]");
+
+	/* value[1] was deleted */
+	val_p = kv_store_get(kvs, 1);
+	ASSERT_ERR_PTR(val_p, "kv_store_get(kvs, 1)");
+
+	/* value[2] was deleted and a new value[2] of a different type was set */
+	val_p = kv_store_get(kvs, 2);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 2)"))
+		goto out;
+	ASSERT_EQ(((struct test_struct_v1 *)val_p)->a, 3, "value[2].a");
+	ASSERT_EQ(((struct test_struct_v1 *)val_p)->b, 4, "value[2].b");
+	ASSERT_EQ(((struct test_struct_v1 *)val_p)->c, 5, "value[2].c");
+
+	/* value[3] was be deleted */
+	val_p = kv_store_get(kvs, 3);
+	ASSERT_ERR_PTR(val_p, "kv_store_get(kvs, 3)");
+
+	/* value[4] was updated to a new integer value */
+	val_p = kv_store_get(kvs, 4);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 4)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 1234, "value[4]");
+
+	/* value[5] was never set */
+	val_p = kv_store_get(kvs, 5);
+	ASSERT_ERR_PTR(val_p, "kv_store_get(kvs, 5)");
+
+	/* value[6] of struct test_struct_v1 type was newly set */
+	val_p = kv_store_get(kvs, 6);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 6)"))
+		goto out;
+	ASSERT_EQ(((struct test_struct_v1 *)val_p)->a, 0, "value[6].a");
+	ASSERT_EQ(((struct test_struct_v1 *)val_p)->b, 0, "value[6].b");
+	ASSERT_EQ(((struct test_struct_v1 *)val_p)->c, 0, "value[6].c");
+
+	/* value[7] was never set */
+	val_p = kv_store_get(kvs, 7);
+	ASSERT_ERR_PTR(val_p, "kv_store_get(kvs, 7)");
+
+	/* value[8] of int type was newly set */
+	val_p = kv_store_get(kvs, 8);
+	if (!ASSERT_OK_PTR(val_p, "kv_store_get(kvs, 8)"))
+		goto out;
+	ASSERT_EQ(*(int *)val_p, 0, "value[8]");
+
+	/* Make sure bpf prog see the same thing */
+	skel_v1->bss->target_pid = pid;
+	skel_v1->bss->test_key = 2;
+	skel_v1->bss->test_op = KVS_STRUCT_GET;
+	sys_gettid();
+	ASSERT_EQ(skel_v1->bss->test_struct_val.a, 3, "bpf:value[2].a");
+	ASSERT_EQ(skel_v1->bss->test_struct_val.b, 4, "bpf:value[2].b");
+	ASSERT_EQ(skel_v1->bss->test_struct_val.c, 5, "bpf:value[2].c");
+	skel_v1->bss->target_pid = -1;
+
+out:
+	if (kvp)
+		free(kvp);
+	if (kvp_v1)
+		free(kvp_v1);
+	if (kvs)
+		kv_store_close(kvs);
+}
+
 void test_uptr_kv_store(void)
 {
 	if (test__start_subtest("uptr_kv_store_basic"))
 		test_uptr_kv_store_basic();
+	if (test__start_subtest("uptr_kv_store_update"))
+		test_uptr_kv_store_update();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c b/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
index bc58269b1ab2..763a71722152 100644
--- a/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
+++ b/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
@@ -8,6 +8,7 @@ pid_t target_pid = 0;
 int test_op;
 int test_key;
 int test_int_val;
+struct test_struct test_struct_val;
 
 SEC("tp_btf/sys_enter")
 int on_enter(__u64 *ctx)
@@ -28,6 +29,12 @@ int on_enter(__u64 *ctx)
 	case KVS_INT_GET:
 		kv_store_get(data, test_key, &test_int_val, 4);
 		break;
+	case KVS_STRUCT_SET:
+		kv_store_set(data, test_key, &test_struct_val, sizeof(test_struct_val));
+		break;
+	case KVS_STRUCT_GET:
+		kv_store_get(data, test_key, &test_struct_val, sizeof(test_struct_val));
+		break;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c b/tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c
new file mode 100644
index 000000000000..5c89e01e7f77
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c
@@ -0,0 +1,44 @@
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#include "uptr_kv_store.h"
+#include "test_uptr_kv_store_common.h"
+
+pid_t target_pid = 0;
+int test_op;
+int test_key;
+int test_int_val;
+struct test_struct_v1 test_struct_val;
+
+SEC("tp_btf/sys_enter")
+int on_enter(__u64 *ctx)
+{
+	struct kv_store_data_map_value *data;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_pid)
+		return 0;
+
+	data = bpf_task_storage_get(&data_map, task, 0, 0);
+
+	switch (test_op) {
+	case KVS_INT_SET:
+		kv_store_set(data, test_key, &test_int_val, 4);
+		break;
+	case KVS_INT_GET:
+		kv_store_get(data, test_key, &test_int_val, 4);
+		break;
+	case KVS_STRUCT_SET:
+		kv_store_set(data, test_key, &test_struct_val, sizeof(test_struct_val));
+		break;
+	case KVS_STRUCT_GET:
+		kv_store_get(data, test_key, &test_struct_val, sizeof(test_struct_val));
+		break;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/test_uptr_kv_store_common.h b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
index 056d744c5d74..fa8e77d6ad9a 100644
--- a/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
+++ b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
@@ -4,6 +4,19 @@
 enum test_kvs_op {
 	KVS_INT_GET,
 	KVS_INT_SET,
+	KVS_STRUCT_GET,
+	KVS_STRUCT_SET,
+};
+
+struct test_struct {
+	int a;
+	int b;
+};
+
+struct test_struct_v1 {
+	int a;
+	int b;
+	int c;
 };
 
 #endif
-- 
2.47.1


