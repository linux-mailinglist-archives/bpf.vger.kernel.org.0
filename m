Return-Path: <bpf+bounces-55306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E62A7B68D
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 05:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF17F189C67D
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 03:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA453155316;
	Fri,  4 Apr 2025 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3BZlWx4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96E137930
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735760; cv=none; b=Sl078qr6+qak2t7XydMgOPLdEPlD6gh4MxEDyL+fbKL+ABzJA2p1ztfCDahfH6ZwGe4BsOAJ6y5YA+YzwfiivjN+rPQf4GolOaVbDVCMreEW51ysmdVwcC1yAZx8osBNA7RZ4lo6p9oniBJ+c8RyVZchRB9uyJlNsUYDYEkPF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735760; c=relaxed/simple;
	bh=2sYAl2Fwr6HCWtwGgWYHxNbDD9Cu60jLfBWQJJO7Jnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMMDLBo4ibMHRWpEYb7g7cIhvwAmc/RnUJzfQW7s4KE7zD8d+6XdB2bVtekLxZDDXJxnoynH95QPZGmy+V+ROUR951bfMDLs4egI1hwQQP2xy6GYxE1p4U7XY9aHVSb2RkIkgDSIP1L5FxLVhuxV0v2+h7uQsjL1cKqmBWtNu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3BZlWx4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736b0c68092so1272304b3a.0
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743735757; x=1744340557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9Tum5et4LDIakJCvl06N89cBzWprJL+GIfoG1eFc28=;
        b=j3BZlWx4kB5hPj3JTiT0SF23N8ShDTPcbRnpBXOZb57OWNaHGLIAJiWL9Wd5SCgp9e
         FVD+o70TnAuMezvXJ3CMWW0xGyaQbNi7UfusGm1wJf9ES5/uDp6fi9Pp7XOidqyh0MvF
         mwvcIwxFTbHk+NDPOkX82OnobEyRLGp/gOKru0DYlcqu1Myl9NsOq332BIOI0gWAoyez
         MAOzjcIz3IaDcDaV2BJ0RB8kTqqRW4vSpt9HXod1NdIMAN2ITWjgCCEKg4eEion/zJlF
         u3lHlz4SqLj/iPY3S5Tdrp5s/PqrYshX8X3iJ2oO7eJWpV6cmJAvVsjl8ZiNheb+rwEu
         5ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743735757; x=1744340557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9Tum5et4LDIakJCvl06N89cBzWprJL+GIfoG1eFc28=;
        b=oXaR0h+FThRUah871mvaKAmaWvUtxdDxYGcyTByJECzP61uQPsMUwIbBzgxefGoxeL
         3dQLMTjznUypNfkVD1S1yjil1iskmoR/Zw0XIWM4QiwiKaaCtFoH1Sl+oOAfxsar7o/0
         ukBlCPesS9sAfwfCwDKyXOVCq30gq0Y2ZBc2QronbaHc0rZhnEQXSHbbFCaiBa8XAJVd
         wZKabB9jPdbuzZ6EA4XsYQl3BG78enW9bGX7D7mQEWff3Zy9xI2IF1DIhyz6g3o6+sP3
         CeneBCgqZ8M9QyXz/aLtIfNoYFMy5CmEo2ornTSAZAobJzEn1sGKdzHG17xbBKozFEJr
         b6vw==
X-Gm-Message-State: AOJu0YzhN8+306OrjTNjLOrXdgiIk3mJFfJ2v44CG6FV4q+4pkk9uXcR
	YGyq1oqRLa7rh02u6mul0PxcYLHUPlEodSVRxd2e/4+g9cfQVVWpUg1zew==
X-Gm-Gg: ASbGncsUv0XF8f3C+hqS4539TeP9SoSGrlu2Z7gdyDJo4e4lYXXy6yMLkwLC2WEuddw
	7T242yFZ4oT8K9MB5GoVZ9xAD6GOYOf+0FcsDJm0S9/WYxf/8qNGXAIddQ7BhWAfYgoAHutaNHJ
	sEj43QRIAQSX7FZdosfUvluOFGUGe5WVUQfBiZv5Ecuir3iYoS0bBw7o7JcCyEZ+zh8TpwvnR4G
	dVcSCE/++M5f63DEU5VOJGvfOlEkEvqydFyOfxpMJRHQu1QZ3GvbyIJEf7JzxybzoZ2mMy7GLWY
	xjq/R1NcduUBGuRbPVNxOPLC1Nf57SzV5k+4xHby7X8jMlkMZK7dkR0krN0rU4QKO2TkoGISuSf
	8Bj/XBj+xXCAnEedCYnI=
X-Google-Smtp-Source: AGHT+IFNzZkVhkVBRVifHAnmoiGkpyYjB9E06oW7qSOa5VUwviVIivFOrAB/jaR5uq0WELqTm9+Syw==
X-Received: by 2002:a05:6a00:2da2:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-739e48cf2eemr2353762b3a.2.1743735756723;
        Thu, 03 Apr 2025 20:02:36 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0791sm2262954b3a.110.2025.04.03.20.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 20:02:36 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH v2 3/4] selftests/bpf: Test basic uptr KV store APIs from user space and bpf
Date: Thu,  3 Apr 2025 20:02:26 -0700
Message-ID: <20250404030227.2690759-4-ameryhung@gmail.com>
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

Make sure both user space and bpf programs can correctly manipulate the
KV store. In the first loop, for each key, we first try to get the value,
this should fail as it is not yet initialized. Then, we set the value as
the key. In the second loop, for each key, a bpf program is triggered to
get the value, and then set a new value. In the final loop, we get the
value again in the user space and make sure they are the updated value.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_uptr_kv_store.c       | 75 +++++++++++++++++++
 .../selftests/bpf/progs/test_uptr_kv_store.c  | 37 +++++++++
 .../selftests/bpf/test_uptr_kv_store_common.h |  9 +++
 3 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/test_uptr_kv_store_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
new file mode 100644
index 000000000000..c61b44ba8639
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
@@ -0,0 +1,75 @@
+#include <test_progs.h>
+
+#include "uptr_kv_store.h"
+#include "test_uptr_kv_store_common.h"
+#include "test_uptr_kv_store.skel.h"
+
+static void test_uptr_kv_store_basic(void)
+{
+	int err, i, pid, zero = 0, *int_val_p, max_int_entries;
+	struct test_uptr_kv_store *skel;
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
+	kvs = kv_store_init(getpid(), skel->maps.data_map, "/sys/fs/bpf/kv_store_data_map", NULL);
+	if (!ASSERT_OK_PTR(kvs, "kv_store_init"))
+		return;
+
+	max_int_entries = KVS_MAX_VAL_ENTRIES;
+
+	err = kv_store_set(kvs, 0, &zero, KVS_MAX_VAL_SIZE + 1);
+	ASSERT_EQ(err, -E2BIG, "kv_store_set(kvs, 0, &zero, 4097)");
+
+	err = kv_store_set(kvs, max_int_entries, &zero, sizeof(int));
+	ASSERT_EQ(err, -ENOENT, "kv_store_set(kvs, 1024, &zero, 4)");
+
+	for (i = 0; i < max_int_entries; i++) {
+		int_val_p = kv_store_get(kvs, i);
+		if (!ASSERT_ERR_PTR(int_val_p, "kv_store_get(kvs, i)"))
+			goto out;
+
+		err = kv_store_set(kvs, i, &i, sizeof(i));
+		if (!ASSERT_OK(err, "kv_store_set(kvs, i)"))
+			goto out;
+	}
+
+	pid = sys_gettid();
+	skel->bss->target_pid = pid;
+	for (i = 0; i < max_int_entries; i++) {
+		skel->bss->test_key = i;
+		skel->bss->test_op = KVS_INT_GET;
+		sys_gettid();
+		ASSERT_EQ(skel->bss->test_int_val, i, "bpf:value[i]");
+
+		skel->bss->test_int_val += 1;
+		skel->bss->test_op = KVS_INT_SET;
+		sys_gettid();
+		skel->bss->test_int_val = 0;
+	}
+	skel->bss->target_pid = -1;
+
+	for (i = 0; i < max_int_entries; i++) {
+		int_val_p = kv_store_get(kvs, i);
+		if (!ASSERT_OK_PTR(int_val_p, "kv_store_get(kvs, i)"))
+			goto out;
+
+		ASSERT_EQ(*int_val_p, i + 1, "userspace:value[i]");
+	}
+
+out:
+	kv_store_close(kvs);
+}
+
+void test_uptr_kv_store(void)
+{
+	if (test__start_subtest("uptr_kv_store_basic"))
+		test_uptr_kv_store_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c b/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
new file mode 100644
index 000000000000..bc58269b1ab2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
@@ -0,0 +1,37 @@
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
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/test_uptr_kv_store_common.h b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
new file mode 100644
index 000000000000..056d744c5d74
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
@@ -0,0 +1,9 @@
+#ifndef _TEST_UPTR_KV_STORE_COMMON_H
+#define _TEST_UPTR_KV_STORE_COMMON_H
+
+enum test_kvs_op {
+	KVS_INT_GET,
+	KVS_INT_SET,
+};
+
+#endif
-- 
2.47.1


