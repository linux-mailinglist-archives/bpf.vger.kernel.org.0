Return-Path: <bpf+bounces-64743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0DB166A7
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AC4E6C53
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313242E4276;
	Wed, 30 Jul 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjjukA+T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E42E2F1F;
	Wed, 30 Jul 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901951; cv=none; b=lFLyCfp2KruJ4/Bl5EczI2ionEAO2oC27mpnZPROQ99JjjSrqVQhpWkx9wDp1JSJRxqySA2b8fm88jH7wBsZqylfvQSWARl1EM7idfl4wtr7FbF8RhxH60+kFOXjso2XDo79+ykgpBuRJ9Ifjfv+r8q6GgxYNROjo1XafQh2YKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901951; c=relaxed/simple;
	bh=5gyh9zJYLUsjxLjKeucQeZqy1TvhSuu/jJ+ZSIAore0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZhgfZAzmeVPUG/oNZlPk9F5iTNh0Un2mWpKrmwdMcz4nFDFXkSoWyrskesPt4BRDabaUr3wH5kxdah70ghdV93N2uF+TwFGkwH4nKoqgbxkrbUUUAtdflco3T7UhCxic0j8bQ7fgaOxKIXYVX6P0tY155org+pfnZSMQRNsaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjjukA+T; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23ffdea3575so1490775ad.2;
        Wed, 30 Jul 2025 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753901948; x=1754506748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F65HxIstaWwrs7zVvIf1P3cX1istjVMzDxwPl7tdrzQ=;
        b=BjjukA+TpwjDF6aBhLokOnILB3SxVZIFSuT/696LFBZN2PNXcPhHNLPDxGCRAT9l37
         zBZN7GQkFmDtTBRVhWrHUE2/u/7yhYcVegonQ57Y5x4aDngcSHRkgUl/xq6Y2YK84Od+
         3fKFPdNNh2yNsxK/hB0Y+uaqiR8mdupyYMaddV52/OeiezYYXB/fLWfWzm/t2HcKlzbE
         +Ka/yhFsr6mkSJlHSa8Hhi9Cp5ecI4BwvrFwTSPG3BYlZHUS93yh7dsAQrL55788F7N0
         s6ZGU9k6ECoMQPgAcvB/W0pL8Bb4xkMOFSlCDOvkIB27DYqpa19/AvTrLtFz9lXrD9eO
         1QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901948; x=1754506748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F65HxIstaWwrs7zVvIf1P3cX1istjVMzDxwPl7tdrzQ=;
        b=eumpE412IjdahcZaOHTKRrrnGUvTdVou+d4ViAy4cKukOH8qXWeGwmEaOlD9FNuhyi
         XvUUa+25NobyVzPNYO7+syjBfsbOUP06p/Opil5TiT4waWdn5QBTlDjD1E4wbdYWhiKK
         RRyQkG7y7SQ6sBKVnqrkTFVMd2MYDbuTvAOM3IzQIqT1aq7ocRP/bP4ZxoNQuSQ119sB
         byCPEcyXcU32VMcr9o3oQEfEkIy4wC5XaRtOdZs1XtCNK0lnzNeT7/KzFMs+ID+6BqP9
         cq5odA4Hn9IrVTPDeBeD2IH284D9qTH0bLHFgzo5WuzPYpWrd29ZGCg9h/9T10G2LG76
         f4Dw==
X-Gm-Message-State: AOJu0Yy2HUVPaWoq8SFJLVn6GxhIrJJn+aiVifpTOHltkzQGR+Glh9rP
	ZooOr4q76JdOHyc09T/fivgtCBhlfG16uWdA0yYvdKElzTkaYP7LARr4o/N03w==
X-Gm-Gg: ASbGncuJMJwzFI8CjCYQ5KU0Fr44ImsxO2pXPfiFpj/F0vTHZdTworoStwSXp/+CZo3
	+R3HgC6yrWl2Br/+pOOU4riAL5bDu4RN4bI6i1r/X7/DezN8557Pll5L9ZGwM3mBPwNuASHhAnH
	o2Tmmq4ko8t9Na2SDQhgLmgtwyFDt3z+CBQ87ytAJNJk+LSezwDyGZjfTBg1cVcIz2ibVDDOvxi
	QPKjfivmP/ISjQF/9pDaXDpDfP+QLH48+Jxazxu0Ms9gGGzg9eYrmYAFOBcEzuknCrfqUeeQPpW
	TrGJ8RILoBBI3h22RnVP5JQvhIkZCr/3hbsrmxaVhByltN2KY5bytIVK1E0Mdt5vWGZptYGbS55
	7K1A73ZWO/cO7
X-Google-Smtp-Source: AGHT+IEh0oMKwntL2fz2sR+gTycIorb87OmZ9qbHlFhaWCcdMYfR8ExryN5msJn+d3tfORKgRvdpdA==
X-Received: by 2002:a17:903:32d0:b0:240:3ed3:13f6 with SMTP id d9443c01a7336-24096a87440mr62456465ad.18.1753901947763;
        Wed, 30 Jul 2025 11:59:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2408fe58baasm29925255ad.189.2025.07.30.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:59:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	linux-lists@etsalapatis.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 3/4] selftests/bpf: Test basic task local data operations
Date: Wed, 30 Jul 2025 11:58:54 -0700
Message-ID: <20250730185903.3574598-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250730185903.3574598-1-ameryhung@gmail.com>
References: <20250730185903.3574598-1-ameryhung@gmail.com>
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
index 000000000000..2e77d3fa2534
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
+	if (TLD_READ_ONCE(tld_meta_p)) {
+		/* Remove TLDs created by tld_create_key() */
+		tld_meta_p->cnt = 1;
+		tld_meta_p->size = TLD_DYN_DATA_SIZE;
+		memset(&tld_meta_p->metadata[1], 0,
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
2.47.3


