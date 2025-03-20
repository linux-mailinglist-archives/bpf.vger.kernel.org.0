Return-Path: <bpf+bounces-54497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45647A6B00A
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232483A9E39
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3C229B23;
	Thu, 20 Mar 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LycZMZjf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7368215162
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506873; cv=none; b=aLSxztK9TYvVbacxjw8U9D26hRBfyvVOXdQHW0mtqT3DLp2CCxhsLq4Z/ylMva5BZeP01bm/jeOe8YciVoEyTG9errs9r8BN3DWEQYgNj2QW2vusX6ys3IPDWCfMZTdeM5/id87ZwtjxO+cHxjtFozwLMhbyjq9fptJjXFXnUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506873; c=relaxed/simple;
	bh=qjTIdPEHNHLm74yJdYyKm06tYPxaU4hKntQf7ax/m2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdvz9e2lVVY+2hHuUlKUmkxPZCIDDvekNuG0PrF7FTYBMAoucPa8PIJ9vFyhlM6l3U+c228LPIsHShuDO6dzAclxoCdV+P4JlnrPzjJ07YvBhcPwr/pQ5myC4f/cOnYesYq/bIsCDK5WXoWKhnFgKlBOOK0Nlt3jc4Xu6z8yg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LycZMZjf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224191d92e4so26285805ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506871; x=1743111671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn2/jHm0OsAiNawS5f76arsuUPd0oMd4W9sk8yrRJt8=;
        b=LycZMZjfAzRn9EgaYJayY5XQmfCBBt8xWvxf4D2/a3szb6DRkYC5OjRz8Z5quSHKVf
         ABU9TgentMRh/3ej1WgQ/H/PRPqkfCZt92L6LtByvJg9zBPPgoPC8HguNWMQiaBPJu/+
         BO0Pf9rM2oVPrOTErFj24tV3Ji8uK+6C4ELaCIU1obroOkVwAQe+tcemKGGmlfcAnZXI
         VYkeT+x71y6ErZvO+VXpFDYu1dTdZ4qARsWa53in//Bg9gOSSKqP9EejwLgHYrT7lhq8
         vyxpBCcriE0XBxUp8DiL3a8evmVztO+7ptqKXCYLtyKV/FqxYKObXxx7qdEzdzCK/AAl
         iBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506871; x=1743111671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn2/jHm0OsAiNawS5f76arsuUPd0oMd4W9sk8yrRJt8=;
        b=dGAFkqLe+r5VuB4RW8IrgEA+tp9FnQ5lG+kYvQtvkqHvXMxqGC4WOMxFyC/rrJvcrR
         9m/77gYlJB38YSlPPAU4DHTqncOZaytuY49JndwrS1hS9Cg3OOg92wh4sGkwmwsisBVM
         iyAXGqyx5mAKRyeZdFXScQ1fjgjB7/qJXwaBlYHWH/zRtlrhJ6fhgvXRZdHaMOD4ikBa
         6ye8GQgoZQ3+97TPrbDBbKEl5NLgR2Efx628o5HxQ4F3E1r+tz/Vlsh1FPapl/1ktL5R
         jm1/U2f0NhX66xtPUcG+xVl3IB69lVITBl1IeqRA4/JAohxhrO8gV3C9IZ1WEBvcavBx
         c2Vg==
X-Gm-Message-State: AOJu0YwxZmZGaUaESM2TUs3qmPnoY/C2m+V+bBUtHHBARJiv3rNbhh7D
	7iYlggAyaxqiYBr2x39oM/zswzd6rng8mnicjh8+6J/XOiWdPBIEnHRS+W0RwfA=
X-Gm-Gg: ASbGncsAzbOmA+Zo0SG/3/kGJeblP5TlShGSSX4A+xqD/RLQQPwCaB3dGyhFGVErjZj
	rAr5X+k6cnEPZOPrMGw7kUNjwbsrBa0hha/UnMsWkqSLmRHIV8XUR266Mxv8GWnGhGp+CbS2stU
	+YB8PMpxL+uCT3lVPeuAzwsGhz5YlmSLtuD1OltSA8mP+9c6mMQLHjg/DHvzEsWmnXD2dXchFmF
	VoAjrh150Wpq24jnC0yKArk0XuW+jg6KqQZJ2hrpfF1/7W5kmCf8khEqWUGNbF2xGsC16LXi63E
	DAoO85K40gTosAoZPxR5KCNbRiZDnUkweT+59sxqZFdIohQcjAwKtl5TVbd7tmWOpnTHnomCKmz
	VDI6Wun9K1B0QqzwlYFQ=
X-Google-Smtp-Source: AGHT+IG/RF1JsUl3zVyEjxRL9QMETxDHwkURIDwoIwyXsnfueihlVoh7Wlq/4RTytKZyOMKDcdaqUQ==
X-Received: by 2002:a05:6a21:3381:b0:1f5:7ba7:69d8 with SMTP id adf61e73a8af0-1fe42f74fdbmr1710022637.15.1742506870858;
        Thu, 20 Mar 2025 14:41:10 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e59esm321135b3a.170.2025.03.20.14.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:41:10 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH 4/4] selftests/bpf: Test changing KV store value layout
Date: Thu, 20 Mar 2025 14:40:58 -0700
Message-ID: <20250320214058.2946857-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320214058.2946857-1-ameryhung@gmail.com>
References: <20250320214058.2946857-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While it is not the most ideal way I imagine how the KV store to be
used. The test tries to show upgrading a bpf program with a change in
the definition of a structure. If using a structure for the value, while
adding a new member is easy, it is less clear how removing or changing
member layout would work.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_uptr_kv_store.c       | 77 +++++++++++++++++++
 .../selftests/bpf/progs/test_uptr_kv_store.c  |  9 +++
 .../bpf/progs/test_uptr_kv_store_v1.c         | 46 +++++++++++
 .../selftests/bpf/test_uptr_kv_store_common.h | 13 ++++
 4 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
index 2075b8e47972..2e86bb08b26e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
@@ -3,6 +3,7 @@
 #include "uptr_kv_store.h"
 #include "test_uptr_kv_store_common.h"
 #include "test_uptr_kv_store.skel.h"
+#include "test_uptr_kv_store_v1.skel.h"
 
 static void test_uptr_kv_store_basic(void)
 {
@@ -70,8 +71,84 @@ static void test_uptr_kv_store_basic(void)
 	kv_store_close(kvs);
 }
 
+static void test_uptr_kv_store_change_value(void)
+{
+	int err, pid;
+	struct test_uptr_kv_store_v1 *skel_v1;
+	struct test_uptr_kv_store *skel;
+	struct test_struct_v1 val_v1;
+	struct test_struct val, *val_p;
+	struct kv_store *kvs = NULL;
+
+	skel = test_uptr_kv_store__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->target_pid = -1;
+	err = test_uptr_kv_store__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		return;
+
+	pid = sys_gettid();
+	kvs = kv_store_init(pid, skel->maps.data_map, "/sys/fs/bpf/kv_store_data_map");
+
+	/* update key 0 to test_struct in user space */
+	val.a = 1;
+	val.b = 2;
+	err = kv_store_put(kvs, 0, &val, sizeof(val));
+	ASSERT_OK(err, "kv_store_put struct val");
+	val_p = kv_store_get(kvs, 0);
+	ASSERT_OK_PTR(val_p, "kv_store_get struct val");
+	ASSERT_EQ(val_p->a, val.a, "user space: check get val.a == put val.a");
+	ASSERT_EQ(val_p->b, val.b, "user space: check get val.b == put val.b");
+
+	/* lookup test_struct at key 0 in test_uptr_kv_store */
+	skel->bss->test_key = 0;
+	skel->bss->test_op = KVS_STRUCT_GET;
+	skel->bss->target_pid = pid;
+	sys_gettid();
+	skel->bss->target_pid = -1;
+	ASSERT_EQ(skel->bss->test_struct_val.a, val.a, "bpf: check get val.a == put val.a");
+	ASSERT_EQ(skel->bss->test_struct_val.b, val.b, "bpf: check get val.b == put val.b");
+
+	/* add a new field to test_struct */
+	err = kv_store_update_value_size(kvs, 0, sizeof(val_v1));
+	ASSERT_OK(err, "kv_store_update_value_size");
+
+	/* rollout a new version */
+	skel_v1 = test_uptr_kv_store_v1__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open v1"))
+		goto out;
+
+	kv_store_data_map_set_reuse(kvs, skel_v1->maps.data_map);
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
+	/* lookup struct_key_0 in test_uptr_kv_store */
+	skel_v1->bss->test_key = 0;
+	skel_v1->bss->test_op = KVS_STRUCT_GET;
+	skel_v1->bss->target_pid = pid;
+	sys_gettid();
+	skel_v1->bss->target_pid = -1;
+
+	ASSERT_EQ(skel_v1->bss->test_struct_val.a, val.a, "bpf: check get val_v1.a == put val.a");
+	ASSERT_EQ(skel_v1->bss->test_struct_val.b, val.b, "bpf: check get val_v1.b == put val.b");
+
+out:
+	kv_store_close(kvs);
+}
+
 void test_uptr_kv_store(void)
 {
 	if (test__start_subtest("uptr_kv_store_basic"))
 		test_uptr_kv_store_basic();
+	if (test__start_subtest("uptr_kv_store_change_value"))
+		test_uptr_kv_store_change_value();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c b/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
index b358cb7fb616..2ed993ab4b01 100644
--- a/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
+++ b/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
@@ -8,6 +8,7 @@ pid_t target_pid = 0;
 int test_op;
 int test_key;
 int test_int_val;
+struct test_struct test_struct_val;
 
 SEC("tp_btf/sys_enter")
 int on_enter(__u64 *ctx)
@@ -28,6 +29,14 @@ int on_enter(__u64 *ctx)
 	case KVS_INT_GET:
 		kv_store_get(data, test_key, &test_int_val, 4);
 		break;
+	case KVS_STRUCT_PUT:
+		kv_store_put(data, test_key, &test_struct_val,
+			     sizeof(test_struct_val));
+		break;
+	case KVS_STRUCT_GET:
+		kv_store_get(data, test_key, &test_struct_val,
+			     sizeof(test_struct_val));
+		break;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c b/tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c
new file mode 100644
index 000000000000..e3dd11e7d11b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_uptr_kv_store_v1.c
@@ -0,0 +1,46 @@
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
+	case KVS_INT_PUT:
+		kv_store_put(data, test_key, &test_int_val, 4);
+		break;
+	case KVS_INT_GET:
+		kv_store_get(data, test_key, &test_int_val, 4);
+		break;
+	case KVS_STRUCT_PUT:
+		kv_store_put(data, test_key, &test_struct_val,
+			     sizeof(test_struct_val));
+		break;
+	case KVS_STRUCT_GET:
+		kv_store_get(data, test_key, &test_struct_val,
+			     sizeof(test_struct_val));
+		break;
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/test_uptr_kv_store_common.h b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
index ff7d010ed08f..db91e862789f 100644
--- a/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
+++ b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
@@ -4,6 +4,19 @@
 enum test_kvs_op {
 	KVS_INT_GET,
 	KVS_INT_PUT,
+	KVS_STRUCT_GET,
+	KVS_STRUCT_PUT,
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


