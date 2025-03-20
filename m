Return-Path: <bpf+bounces-54496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D671A6B009
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53BE3A722F
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13F22836C;
	Thu, 20 Mar 2025 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjsjMY/T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E8226D18
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506872; cv=none; b=pr2HMQ2nuyTCZAYHPbw4LXAVo6N46acsJ5bydAmblbGUST0IxuFGnGJF5gO1XV+BdQV+62Q+PHqsSpTKDmiOVXtSRhNuoWa/BjzypXKXa1o7dv+IFNhb5REYgdacHnWmfpEQCT33XwHjjdXrtrO7dykc9ZXPpJgERFpzxoSvw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506872; c=relaxed/simple;
	bh=pI9dO26f5IuKiryrVVbyaLJLatT4Raz/7NZ2zotPaKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dN4iMs25RnZUA/6/DX19auPG0ygjM3y4NB4z9xU4t0l+vUycyMTPOztsWD5H58CBTFPFXK8hQmVuan9UisNo/4aYlPa8dk4YUIP/n1/C4f5Wk9cKS279Uq+KJQf30MXSO/SprPSOIrmoOuxTqx1eik9DkgIuqrkB9wlb0kEERag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjsjMY/T; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225df540edcso51407905ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742506870; x=1743111670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf2kJn05mGDKk9HZEMhwnUdJ6t5UN5ghQjduwVmYszY=;
        b=CjsjMY/TkZKtqlIXHyfJIyVDfsE/OGXCSvRm+5362RvY97jzkWJiwQaEC1wuNI0krf
         6dkqnE7RelK2gzHNnhgxK9eFSniSPeWwaoFFzPimw3Lb1xHlyHq24F+ve+L5WsMbx/bt
         dN8pCtoTuUJKz+QQJXwNUmJ6Pgya9nd5HeBr6f0rb3UQL1nqvPuZBXTmnAgfeSqKxSUD
         jZZt4+qBIqOUyXZMl2Yu7h0mHBgoO2lQcLlKpqC10nyH3w13CEgQHf45vZ4aPCdXKQ00
         XrXH4uKX4jJXOd9FY0k2YI7wt6GrmcSCM5Z+TXMGxXkmy4/49zRVQ60mRdS2/9Kpkwrs
         YzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742506870; x=1743111670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf2kJn05mGDKk9HZEMhwnUdJ6t5UN5ghQjduwVmYszY=;
        b=EBm4ax7w9xxBg6R3AyfSBEuadOq3OlOHuUPl+y4rspMGuAU7YUwMuTr/m3svIOVdmG
         y6SFzhcSX88TqPmpr1QzIyy7jM7IHoEy13kbjov3/7SaV8kw+gH/q62i5aKcGIFtNXqF
         gBuDJhm0ieMdj3RaeDQ5RvIztcqNWVVf76Pwz/UP3zjUrPPvT9ayyCPu/cm3tow7rrTT
         HrS3JLI3x5OTOt9nZPvysIV0rZ/l9+pd5iA3KrwnP3su6K/Woo4m0V6YRYVgRBMbhaJw
         i69GnZkku5y/HCyxaPSY29gz+Gr+DbQgD56AyQCpK+Z7FyamZQrm8/dmhoobkC8G9v80
         c33A==
X-Gm-Message-State: AOJu0Yy1fkpkm+4F6nGDGToX55JvA6lz1NfqLmmRDT9GuUt9cB86rfS4
	nh9JEHT1I744d6GAae3pMgrdC7czbouQ/jU1LCf95H98pCYvwjcfwQgUga1X0jU=
X-Gm-Gg: ASbGncsICHfW0y/rfp4ejUB5KAKdXhGahWYfPWRNuvjnQ8L2ruTehgHvdIYhC8vgCZx
	EmqBxFgseFkjXFRRSJK5OwjJ3jDMpOrgbZ8SZBV7nUoUH6gFLSs3SVs2UmsW1ISxBhn6lPSsFBH
	8jg7hqqzsEbgAjymcJgvL2W104s4I2bnjxGkcd/6I+lid7ABtp2p7AhG2sCSW7LCMNTJ0s53l6B
	AM+P4AsA21dosS1WrnCWTzg3DL/zqyQQG/aIZk6rYpmUburYADfl09k7kMqSqGacQaS/pzHRJYa
	eu0J7YWsswY4BI16MZtMBsKoRJVUrHKnDFK0p4cUqdKF0K07c6IBTNNOjjcbbC1d1jDCqLWtV6e
	JQi3XKDW7un4HcPSzoEI=
X-Google-Smtp-Source: AGHT+IEra5gQ/UA08yBwhqS0FBXojsFVc31gpMmo8nvJLISLurqW+lHv1W2MZZIgrpWSsxKSsyAsPQ==
X-Received: by 2002:a05:6a00:3d01:b0:730:9637:b2ff with SMTP id d2e1a72fcca58-73905a054d3mr1556844b3a.7.1742506869867;
        Thu, 20 Mar 2025 14:41:09 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e59esm321135b3a.170.2025.03.20.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:41:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH 3/4] selftests/bpf: Test basic uptr KV store operations from user space and bpf
Date: Thu, 20 Mar 2025 14:40:57 -0700
Message-ID: <20250320214058.2946857-4-ameryhung@gmail.com>
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

Make sure both user space and bpf programs can correctly manipulate the
KV store. In the first loop, for each key, we first try to get the value,
this should fail as it is not yet initialized. Then, we put the value as
the key. In the second loop, for each key, a bpf program is triggered to
get the value, and then put a new value. In the final loop, we get the
value again in the user space and make sure they are the new value.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_uptr_kv_store.c       | 77 +++++++++++++++++++
 .../selftests/bpf/progs/test_uptr_kv_store.c  | 37 +++++++++
 .../selftests/bpf/test_uptr_kv_store_common.h |  9 +++
 3 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uptr_kv_store.c
 create mode 100644 tools/testing/selftests/bpf/test_uptr_kv_store_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
new file mode 100644
index 000000000000..2075b8e47972
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_uptr_kv_store.c
@@ -0,0 +1,77 @@
+#include <test_progs.h>
+
+#include "uptr_kv_store.h"
+#include "test_uptr_kv_store_common.h"
+#include "test_uptr_kv_store.skel.h"
+
+static void test_uptr_kv_store_basic(void)
+{
+	int err, i, pid, int_val, *int_val_p, max_int_entries;
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
+	kvs = kv_store_init(getpid(), skel->maps.data_map, "/sys/fs/bpf/kv_store_data_map");
+	if (!ASSERT_OK_PTR(kvs, "kv_store_init"))
+		return;
+
+	max_int_entries = KVS_MAX_VAL_ENTRIES;
+
+	err = kv_store_update_value_size(kvs, 0, KVS_MAX_VAL_SIZE);
+	ASSERT_ERR(err, "kv_store_update_value_size");
+
+	err = kv_store_put(kvs, 0, &int_val, KVS_MAX_VAL_SIZE + 1);
+	ASSERT_ERR(err, "kv_store_put");
+
+	for (i = 0; i < max_int_entries; i++) {
+		int_val_p = kv_store_get(kvs, i);
+		if (!ASSERT_ERR_PTR(int_val_p, "kv_store_get int_val"))
+			goto out;
+
+		err = kv_store_put(kvs, i, &i, sizeof(i));
+		if (!ASSERT_OK(err, "kv_store_put int_val"))
+			goto out;
+	}
+
+	pid = sys_gettid();
+	skel->bss->target_pid = pid;
+	for (i = 0; i < max_int_entries; i++) {
+		skel->bss->test_key = i;
+		skel->bss->test_op = KVS_INT_GET;
+		sys_gettid();
+		ASSERT_EQ(skel->bss->test_int_val, i, "bpf: check int_val[i] = i");
+
+		skel->bss->test_int_val += 1;
+		skel->bss->test_op = KVS_INT_PUT;
+		sys_gettid();
+	}
+	skel->bss->target_pid = -1;
+
+	for (i = 0; i < max_int_entries; i++) {
+		int_val_p = kv_store_get(kvs, i);
+		if (!ASSERT_OK_PTR(int_val_p, "kv_store_get int_val"))
+			goto out;
+
+		ASSERT_EQ(*int_val_p, i + 1, "user space: check int_val[i] == i + 1");
+	}
+
+	err = kv_store_put(kvs, max_int_entries, &int_val, sizeof(int));
+	ASSERT_EQ(err, -ENOENT, "kv_store_put int_val");
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
index 000000000000..b358cb7fb616
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
+	case KVS_INT_PUT:
+		kv_store_put(data, test_key, &test_int_val, 4);
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
index 000000000000..ff7d010ed08f
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_uptr_kv_store_common.h
@@ -0,0 +1,9 @@
+#ifndef _TEST_UPTR_KV_STORE_COMMON_H
+#define _TEST_UPTR_KV_STORE_COMMON_H
+
+enum test_kvs_op {
+	KVS_INT_GET,
+	KVS_INT_PUT,
+};
+
+#endif
-- 
2.47.1


