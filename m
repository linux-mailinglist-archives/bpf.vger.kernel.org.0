Return-Path: <bpf+bounces-58364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB1AB917B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D381885934
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DED289E20;
	Thu, 15 May 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cecATN5I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A427F75F;
	Thu, 15 May 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343772; cv=none; b=SwKGe/QIOOwe8Z8tYYJHLNgEiJI4YG1ba7HuH8zsHanlnrO9I4yYam6AIg670osMdMf3XrCIYYOCS1dFtLstcSutfFUYBFQFSWKQsfzGm+OBoMgIN1w9bTByH4K43wxWo1OT4g72uKwKXCs4wEE9m1gu2uA2mfPxLPTJBUPgiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343772; c=relaxed/simple;
	bh=Xmf/GH6AJBsUEn9F/uZgHXO1affS9szlzgBfgqNu2wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzSMbGSwJWMSwWaDcq9Mr36612bWjwvtntXG0Q5fhyiF+NahGQ2evMeUYdVgZyAylyBoHzBZ6ZP40qYh4d9KPHLJ/8mlMFAT5euoklOuhHqA5sgHnmzpuoF+ZrhjDUO6wcUmELEaa8rai7Y4/CLJx+fUwEuqbw3RL07BXY6CoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cecATN5I; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso1784190b3a.2;
        Thu, 15 May 2025 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343770; x=1747948570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6elvRMS8CWz+pBPlzINLQbGsQ3Xy3y0zHNjGsLUgwi4=;
        b=cecATN5IzhflSjQ95WjjxE4QJ6gTt9qL8Oc5BSGYWOCp46PWEinqTLwyXmp8IpOtxH
         H562uC5KrvEkvxvIsxCtRCcPXEujVf6WDTbRY0WiIOvigLgJTlsFAh2R60GoY2jhFoR2
         mIxFp4pwxlXYGYpcyzY1joTTEFsxNRRqYRwi6ctev4m79axL09ypWg8gpPp4nAZqL1jj
         Xcus1yuVQRszAOk2xEKhMpB3AEL+Vu/b9N9BXeA8TD+bTUfU843uPerveSI4pOKhS+pN
         imbIhWtIt2WR4XKusSdjPduci3BcCPV5UGNxi/nMLNcmXuDxMv0PWOfcq+/UaRXZkJGX
         LuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343770; x=1747948570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6elvRMS8CWz+pBPlzINLQbGsQ3Xy3y0zHNjGsLUgwi4=;
        b=Hkidm+I55gsgGdmoPPMRR5ktj5GXN6/3D5EIDFzA6dUiSfnjFPj2blPbv4Cz6jW3Bb
         OkQdgHjSfC8R8tv7Mi1jCteoQ5tqDWQhY8wfKC9zYj+cUFW0I+u85H2F5rtgcNsYQsjw
         D3EKJ3sseAQR0PxsjMxYL2QMIUFU1yLCvAxQwWDbCr4Q2NKh+X5kabWksaWQITJ3PXFz
         oLmgcHIgoPnFzBhsRBiEpPq5agybS5uBWvG6rDRJ/5s/YZGvMfLMVjeoE9Ra7CvkhoyP
         px4gXvuavUx52/gn8TnS4UD7FAruSkno6emp+ohqg4jFZiOafRRcIM+EDJTXi+0TKSzG
         Q/eQ==
X-Gm-Message-State: AOJu0YwgkXps/TaVrUVDXkYpAN+oLZbifRgqLWYE4EkWGGvO2PcH8Ape
	3UfLv6jy8P1JpdrS+2QD4J5goGf1IOGgFL1Zr7LlfSph1I1kjPt6ezT6XNFWAA==
X-Gm-Gg: ASbGncshvRw2W4hp/9vTYdqKK59zMh2gQDcyZGhfd3mRbtalwTYE9Fo2mJD3D6z6oBb
	n+vZMZQKPY62RR8v57p+WJlY0BUXEGzbH5Yii1rWQw4g6nSAHJ5hUhu5PvAXLOBYgPYRzLWhXL+
	5nqF1cZ7thpR1YdS31C2m3L/X0fkUV4T45U8ogOQJ2gS41R9cp+YFuZDcoD344XO81K63sbPpuZ
	uZ9PLj35hEh+LNIfKuIKpwBDJx6kuWhjd17OqqXreoYzScFj4R30jNyioNjrNdq0Z5dVYnkOsGf
	Fu+hqUa49ynbzb73+eNc5Li8fU84gpQDeBGLQ5pcaQ==
X-Google-Smtp-Source: AGHT+IEgzXPxuqG/LNAkzS8nZZkIbzPjmC23vnbP4sCU5PleC0nR07kHMxiUA1VVyiJ2tIjU1gbSWw==
X-Received: by 2002:a05:6a21:9988:b0:1f5:80a3:b008 with SMTP id adf61e73a8af0-216219b25c7mr1319846637.32.1747343769787;
        Thu, 15 May 2025 14:16:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9709293sm253025b3a.37.2025.05.15.14.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:16:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Test basic task local data operations
Date: Thu, 15 May 2025 14:16:01 -0700
Message-ID: <20250515211606.2697271-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250515211606.2697271-1-ameryhung@gmail.com>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test basic operations of task local data with valid and invalid
tld_create_key(). For invalid calls, make sure they return the right
error code, and verifiy that no TLDs are inserted by trying fetching
keys in the bpf program. For valid calls, first make sure the TLDs
are created using tld_fetch_key(). Then, verify that they are task-
specific with multiple user threads. This done by writing values unique
to each thread to TLDs, reading them from both user space and bpf, and
checking if the value read back are the same as the value written.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_task_local_data.c     | 163 ++++++++++++++++++
 .../bpf/progs/test_task_local_data.c          |  81 +++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
new file mode 100644
index 000000000000..738fc1c9d8a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+
+struct test_struct {
+	__u64 a;
+	__u64 b;
+	__u64 c;
+	__u64 d;
+};
+
+#include "test_task_local_data.skel.h"
+#include "task_local_data.h"
+
+/*
+ * Reset task local data between subtests by clearing metadata. This is only safe
+ * in selftests as subtests run sequentially. Users of task local data libraries
+ * should not do this.
+ */
+static void reset_tld(void)
+{
+	if (tld_metadata_p)
+		memset(tld_metadata_p, 0, PAGE_SIZE);
+}
+
+/* Serialize access to bpf program's global variables */
+static pthread_mutex_t global_mutex;
+
+#define TEST_BASIC_THREAD_NUM 63
+static tld_key_t tld_keys[TEST_BASIC_THREAD_NUM];
+
+void *test_task_local_data_basic_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct test_task_local_data *skel = (struct test_task_local_data *)arg;
+	struct test_struct *value2;
+	int fd, err, tid, *value1;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
+
+	value1 = tld_get_data(fd, tld_keys[0]);
+	if (!ASSERT_OK_PTR(value1, "tld_get_data"))
+		goto out;
+
+	value2 = tld_get_data(fd, tld_keys[1]);
+	if (!ASSERT_OK_PTR(value1, "tld_get_data"))
+		goto out;
+
+	tid = gettid();
+
+	*value1 = tid + 0;
+	value2->a = tid + 1;
+	value2->b = tid + 2;
+	value2->c = tid + 3;
+	value2->d = tid + 4;
+
+	pthread_mutex_lock(&global_mutex);
+	/*
+	 * Run task_init which simulates an initialization bpf prog that runs once
+	 * for every new task. The program saves keys for subsequent bpf programs.
+	 */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_init), &opts);
+	ASSERT_OK(err, "run task_init");
+	ASSERT_OK(opts.retval, "task_init retval");
+	/* Run task_main that read task local data and save to global variables */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
+	ASSERT_OK(err, "run task_main");
+	ASSERT_OK(opts.retval, "task_main retval");
+
+	ASSERT_EQ(skel->bss->test_value1, tid + 0, "tld_get_data value1");
+	ASSERT_EQ(skel->bss->test_value2.a, tid + 1, "tld_get_data value2.a");
+	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2.b");
+	ASSERT_EQ(skel->bss->test_value2.c, tid + 3, "tld_get_data value2.c");
+	ASSERT_EQ(skel->bss->test_value2.d, tid + 4, "tld_get_data value2.d");
+	pthread_mutex_unlock(&global_mutex);
+
+	/* Make sure valueX are indeed local to threads */
+	ASSERT_EQ(*value1, tid + 0, "value1");
+	ASSERT_EQ(value2->a, tid + 1, "value2.a");
+	ASSERT_EQ(value2->b, tid + 2, "value2.b");
+	ASSERT_EQ(value2->c, tid + 3, "value2.c");
+	ASSERT_EQ(value2->d, tid + 4, "value2.d");
+
+	*value1 = tid + 4;
+	value2->a = tid + 3;
+	value2->b = tid + 2;
+	value2->c = tid + 1;
+	value2->d = tid + 0;
+
+	/* Run task_main again */
+	pthread_mutex_lock(&global_mutex);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
+	ASSERT_OK(err, "run task_main");
+	ASSERT_OK(opts.retval, "task_main retval");
+
+	ASSERT_EQ(skel->bss->test_value1, tid + 4, "tld_get_data value1");
+	ASSERT_EQ(skel->bss->test_value2.a, tid + 3, "tld_get_data value2.a");
+	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2.b");
+	ASSERT_EQ(skel->bss->test_value2.c, tid + 1, "tld_get_data value2.c");
+	ASSERT_EQ(skel->bss->test_value2.d, tid + 0, "tld_get_data value2.d");
+	pthread_mutex_unlock(&global_mutex);
+
+	tld_free();
+out:
+	pthread_exit(NULL);
+}
+
+static void test_task_local_data_basic(void)
+{
+	struct test_task_local_data *skel;
+	pthread_t thread[TEST_BASIC_THREAD_NUM];
+	char dummy_key_name[TLD_NAME_LEN];
+	tld_key_t key;
+	int i, fd, err;
+
+	reset_tld();
+
+	ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex_init");
+
+	skel = test_task_local_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
+
+	tld_keys[0] = tld_create_key(fd, "value1", sizeof(int));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[0]), "tld_create_key");
+	tld_keys[1] = tld_create_key(fd, "value2", sizeof(struct test_struct));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
+
+	key = tld_create_key(fd, "value_not_exist",
+			     PAGE_SIZE - sizeof(int) - sizeof(struct test_struct) + 1);
+	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
+
+	key = tld_create_key(fd, "value2", sizeof(struct test_struct));
+	ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
+
+	for (i = 2; i < TLD_DATA_CNT; i++) {
+		snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i);
+		tld_keys[i] = tld_create_key(fd, dummy_key_name, sizeof(int));
+		ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key");
+	}
+
+	key = tld_create_key(fd, "value_not_exist", sizeof(struct test_struct));
+	ASSERT_EQ(tld_key_err_or_zero(key), -ENOSPC, "tld_create_key");
+
+	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++) {
+		err = pthread_create(&thread[i], NULL, test_task_local_data_basic_thread, skel);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto out;
+	}
+
+out:
+	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++)
+		pthread_join(thread[i], NULL);
+}
+
+void test_task_local_data(void)
+{
+	if (test__start_subtest("task_local_data_basic"))
+		test_task_local_data_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data.c b/tools/testing/selftests/bpf/progs/test_task_local_data.c
new file mode 100644
index 000000000000..4cf0630b19bd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_local_data.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+#include "task_local_data.bpf.h"
+
+struct tld_keys {
+	tld_key_t value1;
+	tld_key_t value2;
+	tld_key_t value_not_exist;
+};
+
+struct test_struct {
+	unsigned long a;
+	unsigned long b;
+	unsigned long c;
+	unsigned long d;
+};
+
+int test_value1;
+struct test_struct test_value2;
+
+SEC("syscall")
+int task_init(void *ctx)
+{
+	struct tld_object tld_obj;
+	struct task_struct *task;
+	int err;
+
+	task = bpf_get_current_task_btf();
+	err = tld_object_init(task, &tld_obj);
+	if (err)
+		return 1;
+
+	if (!tld_fetch_key(&tld_obj, "value1", value1))
+		return 2;
+
+	if (!tld_fetch_key(&tld_obj, "value2", value2))
+		return 3;
+
+	if (tld_fetch_key(&tld_obj, "value_not_exist", value_not_exist))
+		return 6;
+
+	return 0;
+}
+
+SEC("syscall")
+int task_main(void *ctx)
+{
+	struct tld_object tld_obj;
+	struct test_struct *struct_p;
+	struct task_struct *task;
+	int err, *int_p;
+
+	task = bpf_get_current_task_btf();
+	err = tld_object_init(task, &tld_obj);
+	if (err)
+		return 1;
+
+	int_p = tld_get_data(&tld_obj, value1, sizeof(int));
+	if (int_p)
+		test_value1 = *int_p;
+	else
+		return 2;
+
+	struct_p = tld_get_data(&tld_obj, value2, sizeof(struct test_struct));
+	if (struct_p)
+		test_value2 = *struct_p;
+	else
+		return 3;
+
+	int_p = tld_get_data(&tld_obj, value_not_exist, sizeof(int));
+	if (int_p)
+		return 4;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+
-- 
2.47.1


