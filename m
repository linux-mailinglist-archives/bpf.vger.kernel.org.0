Return-Path: <bpf+bounces-63637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74738B09229
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71647A8265
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11512FD592;
	Thu, 17 Jul 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAIch7Qj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEF2FCE30;
	Thu, 17 Jul 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770928; cv=none; b=onwV9OzdaUop2lIjzRcJ9YH7zgNDNTegOwKwFP3HC9VfYaBffUtdCEiJ/vFZq+PBFIOea4Co/85AMG6O1niGQMCMnHXwLMyx8KWxeCBCLBTqq9z6gXKe1Rnj1HrzcddcHlQKw6/Gx6B3ETCU+pI7lcu1gTeA2sh42iD/dWcyhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770928; c=relaxed/simple;
	bh=beHgZXhiL+Zfy+Kt8yh/Wiwx5+0wNHrb/3SNWzDiS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAmgy8ZJdxkNHFwdYJo3gaDpdyYQdyx7XxvZ+wGDiD6TBjJPEaBt5ll0V2UBZ2ry4TDrby6VQG79nHJGssmvpNUyYGDv3fMyLUqw53FO4Le9uTn2WUsk2NVT8qCD8+R4oNHjprB/ocDN+fCXED1qnYYvY7EqZHo3WW+Xe5L2QoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAIch7Qj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1161966b3a.0;
        Thu, 17 Jul 2025 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770926; x=1753375726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Aytf9yr4dP2OT8uJN0jq/koLr+hctQ/6TUSZZZjKbU=;
        b=bAIch7QjoVwp9NfVeha4+cB3kyfqhCAexlHmvERJocWmiESRPdAy51rX7mU4Xf60dm
         P/lJIykG2i8p9Np4uQ+7NClVAkigqfGb4pSedLckt3FsxlIvPhpehPlcCfSOBcBY5PnU
         qHgV4aNTGaOaDVf3eZJMULOXEAG7gkPH+QprscyqIROU9rgKUOwjYB/g4n2UZ3lxYakK
         Hb5IQGiv/Bbun0CNzovKsixNG3jxscUCcS18alyvsZBHt7tythkmAJE1V3R4RfYFZ0uf
         t21ec8lnwaHA/Nfmg+3Qec1D1hUX37Ext3MB00giK6pNlVDeD4yYTqr8QTEmMgo0tDAa
         XF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770926; x=1753375726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Aytf9yr4dP2OT8uJN0jq/koLr+hctQ/6TUSZZZjKbU=;
        b=ufBGWSfh4hpj8tgpaWStstrztNmiMRzoS6VY3/FY6U/JBaarCTskZNetucQz+U2iqV
         SnkwUzYVA0FBNR98e8tfQopwi/s+K0gScEKCV3DM3qEsJHWm/+8cLKGAsQ2M9Uu669IN
         118w5/q05KbkiFCbc1t4ctc5zBmyskE8FJ+2KgCSHmgUfYDoTKa53OwkDdtb+cPHNQh0
         D3de6Chk3FUHhhEfF2yC09wmbTZfYlmy9xEqnbj2uNep6m2shvYDYIaxWH0dPfiDMBDC
         iVAWmGGtFZVf/TfF0uQhGli9XPpDGk4gqPxrwXcaFfEcddL2aROiWsZfsJHbSs/5W/tG
         0eSg==
X-Gm-Message-State: AOJu0Yx58cfzRimm67cIg78j4KvsRCgtMsYLVWj+TUiPwcFaRFkOp13j
	JaTRbuIqG9uEYP2kyOZUvNOPNd3t+Y8b2KGJPok6fnSdQ2F1GmE3ev3an1C7pA==
X-Gm-Gg: ASbGncuRgVmIDjf9xpoX35lqEIhu0Ex0eRGhZxEPj3TIpMgiVhNVWulgmdkeiOxNZQl
	71SIw1o0VWQVRk+s9QZPfHelyCe0wO8ukUKfbgA01HhIfrDeXNeHd3LkUFWRGc9f26k12fKR19O
	m9OxvJ9qRVs3JiNLq5iOjoS0UAIhPySnWLr2261Qp5XsOPYvfQpMDe2RhWOwepUPH+MxdJnktvC
	EYzCh+TUVJ4hc31yMc+Es0wvhArs0QP6HHCHRlcEgbDfmBEdZa7seWiAfkCAQimeI3hezq+lAVp
	svWJiFLChBcwQoH38PfqMzWsb3bFy7cbojQtmENjTfwgFKYbozXyANSoNZfGjI2NgP7RlJhM4HK
	3FD3enKJzB9d445Xo7+d12XE=
X-Google-Smtp-Source: AGHT+IFbsUIBPQq1mobFdlETnqY92OrKgTSrBtT37GJX20jOlPoz9xB8HA/e2yPT5b3DuHFpWkrCfA==
X-Received: by 2002:a05:6a00:21d4:b0:74e:a560:dd23 with SMTP id d2e1a72fcca58-757248722c6mr9849244b3a.21.1752770925754;
        Thu, 17 Jul 2025 09:48:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f22c01sm16939549b3a.101.2025.07.17.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:48:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/3] selftests/bpf: Test basic task local data operations
Date: Thu, 17 Jul 2025 09:48:40 -0700
Message-ID: <20250717164842.1848817-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717164842.1848817-1-ameryhung@gmail.com>
References: <20250717164842.1848817-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test basic operations of task local data with valid and invalid
tld_create_key().

For invalid calls, make sure they return the right error code and check
that the TLDs are not inserted by running tld_get_data("
value_not_exists") on the bpf side. The call should a null pointer.

For valid calls, first make sure the TLDs are created by calling
tld_get_data() on the bpf side. The call should return a valid pointer.

Finally, verify that the TLDs are indeed task-specific (i.e., their
addresses do not overlap) with multiple user threads. This done by
writing values unique to each thread, reading them from both user space
and bpf, and checking if the value read back matches the value written.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_task_local_data.c     | 192 ++++++++++++++++++
 .../bpf/progs/test_task_local_data.c          |  65 ++++++
 2 files changed, 257 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
new file mode 100644
index 000000000000..fde4a030ab42
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+
+#define TLD_FREE_DATA_ON_THREAD_EXIT
+#define TLD_DYN_DATA_SIZE 4096
+#include "task_local_data.h"
+
+struct test_tld_struct {
+	__u64 a;
+	__u64 b;
+	__u64 c;
+	__u64 d;
+};
+
+#include "test_task_local_data.skel.h"
+
+TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
+
+/*
+ * Reset task local data between subtests by clearing metadata other
+ * than the statically defined value0. This is safe as subtests run
+ * sequentially. Users of task local data library should not touch
+ * library internal.
+ */
+static void reset_tld(void)
+{
+	if (TLD_READ_ONCE(tld_metadata_p)) {
+		/* Remove TLDs created by tld_create_key() */
+		tld_metadata_p->cnt = 1;
+		tld_metadata_p->size = TLD_DYN_DATA_SIZE;
+		memset(&tld_metadata_p->metadata[1], 0,
+		       (TLD_MAX_DATA_CNT - 1) * sizeof(struct tld_metadata));
+	}
+}
+
+/* Serialize access to bpf program's global variables */
+static pthread_mutex_t global_mutex;
+
+static tld_key_t *tld_keys;
+
+#define TEST_BASIC_THREAD_NUM 32
+
+void *test_task_local_data_basic_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct test_task_local_data *skel = (struct test_task_local_data *)arg;
+	int fd, err, tid, *value0, *value1;
+	struct test_tld_struct *value2;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
+
+	value0 = tld_get_data(fd, value0_key);
+	if (!ASSERT_OK_PTR(value0, "tld_get_data"))
+		goto out;
+
+	value1 = tld_get_data(fd, tld_keys[1]);
+	if (!ASSERT_OK_PTR(value1, "tld_get_data"))
+		goto out;
+
+	value2 = tld_get_data(fd, tld_keys[2]);
+	if (!ASSERT_OK_PTR(value2, "tld_get_data"))
+		goto out;
+
+	tid = gettid();
+
+	*value0 = tid + 0;
+	*value1 = tid + 1;
+	value2->a = tid + 2;
+	value2->b = tid + 3;
+	value2->c = tid + 4;
+	value2->d = tid + 5;
+
+	pthread_mutex_lock(&global_mutex);
+	/* Run task_main that read task local data and save to global variables */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.task_main), &opts);
+	ASSERT_OK(err, "run task_main");
+	ASSERT_OK(opts.retval, "task_main retval");
+
+	ASSERT_EQ(skel->bss->test_value0, tid + 0, "tld_get_data value0");
+	ASSERT_EQ(skel->bss->test_value1, tid + 1, "tld_get_data value1");
+	ASSERT_EQ(skel->bss->test_value2.a, tid + 2, "tld_get_data value2.a");
+	ASSERT_EQ(skel->bss->test_value2.b, tid + 3, "tld_get_data value2.b");
+	ASSERT_EQ(skel->bss->test_value2.c, tid + 4, "tld_get_data value2.c");
+	ASSERT_EQ(skel->bss->test_value2.d, tid + 5, "tld_get_data value2.d");
+	pthread_mutex_unlock(&global_mutex);
+
+	/* Make sure valueX are indeed local to threads */
+	ASSERT_EQ(*value0, tid + 0, "value0");
+	ASSERT_EQ(*value1, tid + 1, "value1");
+	ASSERT_EQ(value2->a, tid + 2, "value2.a");
+	ASSERT_EQ(value2->b, tid + 3, "value2.b");
+	ASSERT_EQ(value2->c, tid + 4, "value2.c");
+	ASSERT_EQ(value2->d, tid + 5, "value2.d");
+
+	*value0 = tid + 5;
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
+	ASSERT_EQ(skel->bss->test_value0, tid + 5, "tld_get_data value0");
+	ASSERT_EQ(skel->bss->test_value1, tid + 4, "tld_get_data value1");
+	ASSERT_EQ(skel->bss->test_value2.a, tid + 3, "tld_get_data value2.a");
+	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "tld_get_data value2.b");
+	ASSERT_EQ(skel->bss->test_value2.c, tid + 1, "tld_get_data value2.c");
+	ASSERT_EQ(skel->bss->test_value2.d, tid + 0, "tld_get_data value2.d");
+	pthread_mutex_unlock(&global_mutex);
+
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
+	int i, err;
+
+	reset_tld();
+
+	ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex_init");
+
+	skel = test_task_local_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	tld_keys = calloc(TLD_MAX_DATA_CNT, sizeof(tld_key_t));
+	if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
+		goto out;
+
+	ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
+	tld_keys[1] = tld_create_key("value1", sizeof(int));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
+	tld_keys[2] = tld_create_key("value2", sizeof(struct test_tld_struct));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[2]), "tld_create_key");
+
+	/*
+	 * Shouldn't be able to store data exceed a page. Create a TLD just big
+	 * enough to exceed a page. TLDs already created are int value0, int
+	 * value1, and struct test_tld_struct value2.
+	 */
+	key = tld_create_key("value_not_exist",
+			     TLD_PAGE_SIZE - 2 * sizeof(int) - sizeof(struct test_tld_struct) + 1);
+	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
+
+	key = tld_create_key("value2", sizeof(struct test_tld_struct));
+	ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
+
+	/* Shouldn't be able to create the (TLD_MAX_DATA_CNT+1)-th TLD */
+	for (i = 3; i < TLD_MAX_DATA_CNT; i++) {
+		snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i);
+		tld_keys[i] = tld_create_key(dummy_key_name, sizeof(int));
+		ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key");
+	}
+	key = tld_create_key("value_not_exist", sizeof(struct test_tld_struct));
+	ASSERT_EQ(tld_key_err_or_zero(key), -ENOSPC, "tld_create_key");
+
+	/* Access TLDs from multiple threads and check if they are thread-specific */
+	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++) {
+		err = pthread_create(&thread[i], NULL, test_task_local_data_basic_thread, skel);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto out;
+	}
+
+out:
+	for (i = 0; i < TEST_BASIC_THREAD_NUM; i++)
+		pthread_join(thread[i], NULL);
+
+	if (tld_keys) {
+		free(tld_keys);
+		tld_keys = NULL;
+	}
+	tld_free();
+	test_task_local_data__destroy(skel);
+}
+
+void test_task_local_data(void)
+{
+	if (test__start_subtest("task_local_data_basic"))
+		test_task_local_data_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data.c b/tools/testing/selftests/bpf/progs/test_task_local_data.c
new file mode 100644
index 000000000000..fffafc013044
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_local_data.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+#include "task_local_data.bpf.h"
+
+struct tld_keys {
+	tld_key_t value0;
+	tld_key_t value1;
+	tld_key_t value2;
+	tld_key_t value_not_exist;
+};
+
+struct test_tld_struct {
+	__u64 a;
+	__u64 b;
+	__u64 c;
+	__u64 d;
+};
+
+int test_value0;
+int test_value1;
+struct test_tld_struct test_value2;
+
+SEC("syscall")
+int task_main(void *ctx)
+{
+	struct tld_object tld_obj;
+	struct test_tld_struct *struct_p;
+	struct task_struct *task;
+	int err, *int_p;
+
+	task = bpf_get_current_task_btf();
+	err = tld_object_init(task, &tld_obj);
+	if (err)
+		return 1;
+
+	int_p = tld_get_data(&tld_obj, value0, "value0", sizeof(int));
+	if (int_p)
+		test_value0 = *int_p;
+	else
+		return 2;
+
+	int_p = tld_get_data(&tld_obj, value1, "value1", sizeof(int));
+	if (int_p)
+		test_value1 = *int_p;
+	else
+		return 3;
+
+	struct_p = tld_get_data(&tld_obj, value2, "value2", sizeof(struct test_tld_struct));
+	if (struct_p)
+		test_value2 = *struct_p;
+	else
+		return 4;
+
+	int_p = tld_get_data(&tld_obj, value_not_exist, "value_not_exist", sizeof(int));
+	if (int_p)
+		return 5;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


