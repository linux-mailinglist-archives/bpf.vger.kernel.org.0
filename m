Return-Path: <bpf+bounces-61788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1EAEC30F
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 01:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951294A55CC
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D5292B2E;
	Fri, 27 Jun 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN/DEcN8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640C291C15;
	Fri, 27 Jun 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067606; cv=none; b=FSQCZUVTZWUSC/QCz1zRGxxyztyVorS3gg2jyW4kdydBjySEauWKCP3P3gxsiFT3HsZv02BGmkXHFannVZgMdzY1SpndP/tYtpbO+9XJOR75DlzsuXZlOgjXkB+OspP2VPsOmeCFizHJ/ZIkgThrNaUv/5LyDM2UZVwQXwzA7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067606; c=relaxed/simple;
	bh=ksb9bE8D+kZqcV3GF3USB4jr/1TfHYqNsYf1vxMVHkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQUfVfYDVLGc6QA+eqfUC8pDHFRXYGA4aOZkWMY4A2uFX+oVekv50FSwOK/Mg4YjVuQ1VlmQC/ZcbyDNgFX2TNv/En70EvoqMVIKIAx+drbQl4/VNQwr7uyIM17Y5wH2myy5gFYcVHBp3u0CUX3jZlW3LBR5ym72/SxtSGa4c80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN/DEcN8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso59239a91.2;
        Fri, 27 Jun 2025 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751067603; x=1751672403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJgphU+a5XaVPmQNfGw0qG/l1MNTZ8+XW+O4l8NJ1ig=;
        b=GN/DEcN8e+4pBtzzdoSD+DLl/Ya5NNl57GJ6dEQ1ElmVXOulCt9a5izxXZY89oBa1D
         4Z3GWIJy9kHi7grgfUixLuH01Qcz2/I/xL8krLZejS76sMybyB4RM+8fYPL2BeQD8d95
         L3TL5pOs7HPeQqQ4wxBUrUvDhHbl5CX2W+wyyFx/1JxH/4798m31/gDTGIfanUHKcVTW
         PMY6VpJIMda17bPWP9wktf2mcer3fk735JoqyzR9irYyTMvLFj3Slz+qv5GAUmfVQIVN
         od56Cpv+bsJcRhAszwlOLmND3Mj1l7tGNeHChDjiHB/7ZpLP42J/C8kuEmzVMqqMdVXl
         dtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067603; x=1751672403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJgphU+a5XaVPmQNfGw0qG/l1MNTZ8+XW+O4l8NJ1ig=;
        b=SX7kSi032o/hn6Qw9H0+VhBx3uFsGHLKFSiYr2ktPawENO2ivONamC41m0zbgja08x
         3sr9WIbOltecEyHANZ40eulS+ZW/iD0whsDFHrfzMq0p2b3SogRznrOfStzZ5AMtCynj
         T6foX1f2gIwiEvMTvZ5vo+Px16ka5L7TFdYEwDnHZpyjqMXq3y9gE1/AyuxqkrqG5oc2
         fH9hrVea6GDERsg3n6N5QWc3TIK50AaiU5u+KuF4dS+6aIJo6/1+vF3Wrhse6d7iZsYU
         74jVuFj/0na5gT4Ju8nix4C8S04E75U6g7EqR7xVippVBi/2RYMYTzPPfhDsXi63R4PF
         k4Ww==
X-Gm-Message-State: AOJu0YybapkLZZLi0wGV1j16B5UDf3m8rDtdx/COli9tBqEXKvK06AB9
	WErzbUEUeiha1xYbu0oFPghYMhSpytTMNTXBhpxtzVhLO1Eut4RGKRVR6oUGGw==
X-Gm-Gg: ASbGncv7tjC453/ijCLbMxCIvamoMMAhQR+vJ2Jbl18IyEJDg6j/jbNtPLCpqM1c/H/
	RxFnc7Xw9toYH6pKgb3Exu4LMr34waXkKPrDvcVFsD+5JTaBGzilSL/hoIPfSIP6SHJr3s3loPL
	81ApHcWZVq9EGsCq0G61uH+WyWMgBKxE39ltAhl7KzuzsRL7nOykjUOjbrW44fQLMBulptA5zwY
	K7Y01JqGlQinfV/ut6dFKcojlIwvaJtwkoHvxfG5+HVPlrBBc2oPBJ8YZndKKzQT0eGQdfGFUz8
	bd+GxzQ7F6t0LXpl1nPw2a+BUwY43XBd4hF0Cu8IRwBxJMfTSwP0
X-Google-Smtp-Source: AGHT+IFkFExwE/0eYuJTXjLX5Uj09lAvPHC/hmjaA+50xkRK/1m7EBzD+2Lddco7xLKxCqF5OJxaIQ==
X-Received: by 2002:a17:90b:3e84:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-318c923baacmr6083006a91.22.1751067603253;
        Fri, 27 Jun 2025 16:40:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315edd0dfedsm2564749a91.1.2025.06.27.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:40:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Test basic task local data operations
Date: Fri, 27 Jun 2025 16:39:56 -0700
Message-ID: <20250627233958.2602271-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250627233958.2602271-1-ameryhung@gmail.com>
References: <20250627233958.2602271-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/test_task_local_data.c     | 191 ++++++++++++++++++
 .../bpf/progs/test_task_local_data.c          |  65 ++++++
 2 files changed, 256 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
new file mode 100644
index 000000000000..53cdb8466f8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -0,0 +1,191 @@
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
+#define TLD_FREE_DATA_ON_THREAD_EXIT
+#define TLD_DYN_DATA_SIZE 4096
+#include "task_local_data.h"
+
+#include "test_task_local_data.skel.h"
+
+TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
+
+/*
+ * Reset task local data between subtests by clearing metadata. This is safe
+ * as subtests run sequentially. Users of task local data libraries
+ * should not do this.
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
+#define TEST_BASIC_THREAD_NUM TLD_MAX_DATA_CNT
+
+void *test_task_local_data_basic_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct test_task_local_data *skel = (struct test_task_local_data *)arg;
+	int fd, err, tid, *value0, *value1;
+	struct test_struct *value2;
+
+	fd = bpf_map__fd(skel->maps.tld_data_map);
+
+	value0 = tld_get_data(fd, value0_key);
+	if (!ASSERT_OK_PTR(value0, "tld_get_data"))
+		goto out;
+
+	value1 = tld_get_data(fd, tld_keys[0]);
+	if (!ASSERT_OK_PTR(value1, "tld_get_data"))
+		goto out;
+
+	value2 = tld_get_data(fd, tld_keys[1]);
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
+	tld_keys = calloc(TEST_BASIC_THREAD_NUM, sizeof(tld_key_t));
+	if (!ASSERT_OK_PTR(tld_keys, "calloc tld_keys"))
+		goto out;
+
+	ASSERT_FALSE(tld_key_is_err(value0_key), "TLD_DEFINE_KEY");
+	tld_keys[0] = tld_create_key("value1", sizeof(int));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[0]), "tld_create_key");
+	tld_keys[1] = tld_create_key("value2", sizeof(struct test_struct));
+	ASSERT_FALSE(tld_key_is_err(tld_keys[1]), "tld_create_key");
+
+	/*
+	 * Shouldn't be able to store data exceed a page. Create a TLD just big
+	 * enough to exceed a page. TLDs already created are int value0, int
+	 * value1, and struct test_struct value2.
+	 */
+	key = tld_create_key("value_not_exist",
+			     TLD_PAGE_SIZE - 2 * sizeof(int) - sizeof(struct test_struct) + 1);
+	ASSERT_EQ(tld_key_err_or_zero(key), -E2BIG, "tld_create_key");
+
+	key = tld_create_key("value2", sizeof(struct test_struct));
+	ASSERT_EQ(tld_key_err_or_zero(key), -EEXIST, "tld_create_key");
+
+	/* Shouldn't be able to create the (TLD_MAX_DATA_CNT+1)-th TLD */
+	for (i = 3; i < TLD_MAX_DATA_CNT; i++) {
+		snprintf(dummy_key_name, TLD_NAME_LEN, "dummy_value%d", i);
+		tld_keys[i] = tld_create_key(dummy_key_name, sizeof(int));
+		ASSERT_FALSE(tld_key_is_err(tld_keys[i]), "tld_create_key");
+	}
+	key = tld_create_key("value_not_exist", sizeof(struct test_struct));
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
index 000000000000..94d1745dd8d4
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
+struct test_struct {
+	unsigned long a;
+	unsigned long b;
+	unsigned long c;
+	unsigned long d;
+};
+
+int test_value0;
+int test_value1;
+struct test_struct test_value2;
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
+	struct_p = tld_get_data(&tld_obj, value2, "value2", sizeof(struct test_struct));
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


