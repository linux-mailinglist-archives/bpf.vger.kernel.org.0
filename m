Return-Path: <bpf+bounces-56749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D81A9D45E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F319E778B
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A409279793;
	Fri, 25 Apr 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bri+qpN4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7226A091;
	Fri, 25 Apr 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617247; cv=none; b=QT6jQ3h8XdmA8EihYfsNoxAh5xgoyeYAp/APowXq4xsfhB7HRhLB30+CPdrz9+qdVGpDjncLXWk6PhoHcOzUiWRk+Pj4PyFU6G+ucFPf/hdjxulNr91qXr6UvxS41SZOXhbdpAyx5VOoxPQBoRrhYbb/FviH/YqN8teZGWVqYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617247; c=relaxed/simple;
	bh=LAJe9kljdM0va3v2nWMAIe1qLaSp1Oher7CRxV16W54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHNoH0eVkBXx938+3niDQxFTL78ioaRvmXWBDd/q6n2BaGNUcpFWMbvCDEuQfMmjS0hN6o/UAnZiNVIbaUGZmUmBhctSDz2Km8pgWUG6oxhV6SQLWcLsnlYhjUqYpSjDMrjxBjHOt0/DJJXCh3fKIB4ceH+kJWedYeQNND+rsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bri+qpN4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22928d629faso31068155ad.3;
        Fri, 25 Apr 2025 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745617244; x=1746222044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59lVFW2/rI0XbXoUNSi7R0MnTUaoQMLeq46MfEUfU1Q=;
        b=Bri+qpN4tIXIbPH5ildiJVVFICycssSzSgOA791MA8bHnPUnyox+GqHumIcsFXEHpb
         GuH7hsjsNZuz0GLsrdedClOU7/YEPrXWLSkOonIPt0ELXegqY+EMZZpp++IVGHq4rRwj
         UkE7jEAw4pJn5R+9yrhuEUeMHVaWHFBs4TzjZRRW5KdulF/Bw9o3eLgIRLUdYtOjFRNC
         a+A9kfGmUkMeU9azygRAibcY+VPMPZK/SJD7eRS3fy5UW1rjnc1eEcBBQMfrsoGpS3Em
         2ojchu3UmC1umg42Uxfa/oQG6Df56mRflOI7Y6G1TvqfmXzVTI5KkbgREdvU43sQX6CW
         msKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617244; x=1746222044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59lVFW2/rI0XbXoUNSi7R0MnTUaoQMLeq46MfEUfU1Q=;
        b=niyIZVHwwBf+jQZ/fqk8DAPN/CL2bPu7EhpuxUmBbVlQrH3o3tQX5GaD9Af+Vii0fn
         ocEtj36IMps7xRDhanaDZ+gvzhjZoJD735oYOMkeKpB9o2u7QaoykK/z1xQkA/vlXiFK
         sdYFH0wjDPthcUn7J3sPPlT/qbRzDVnIgun6NDRojfBlmIigGbbwyypil7V30Lca8KiC
         WJtFqvZCR/h7+sVZ46+geYynHsXyL/j8j4yuy3QlbFYAIL6892iSEouzzvCJY7Wbp2Sm
         Nnu8QP+ZkmKewz1DDJs5GJxHy6GNXaRR2Opod7PbUER1gGZfLQxZVOlCIoeH+6mLj0/Z
         ju+Q==
X-Gm-Message-State: AOJu0Yz9CINtHKzPrLbKGOLOl8aEtG/H9XJwmazJLmQWUopGvqlA/SKP
	5KsyZKhlcqJFX5nsaNkJ4GZxLkXpbjJHOTWFpJoWunWww/DzLvgsXMDDXA==
X-Gm-Gg: ASbGncukIpO8yrvIfQ6NN2GKJ54wbzkPqrinSTJ3UB+cXIfEnIKb0hZ8mmvHMQ0OPn4
	FgoygpKEs/FgdpOaP5JSBfBwFknwkmAzIIGnr9Koylcp+c66PHQ0EnaDlXp+HNJnQLSQfKLG4Z/
	J+sQdXu2j4yzwUlhEAynNc52MwwPFLQzoQZtXjDYDaT2Z8M4PQiYVoRUp3frFqLYH45RvvbthZS
	Pubamu+t9XBoInkICVE6iam8MGpQyP60VaSBpOVq0pDQkHEGI7oMJLaQB5+GiMOLDpIgaZ5lSER
	btXw4R1k6sDmOLZEljcPcGuDuVbhHsw=
X-Google-Smtp-Source: AGHT+IFX/IT8/fzTow/fsjz21BqOpQAT2qLAHBQotxV0JnpNEnrAtH8PR68Wh2iHUhlKc63ginSAkA==
X-Received: by 2002:a17:903:298e:b0:223:fabd:4f99 with SMTP id d9443c01a7336-22dbf5d5211mr61539915ad.5.1745617243583;
        Fri, 25 Apr 2025 14:40:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76e21sm37618625ad.45.2025.04.25.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:40:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH RFC v3 2/2] selftests/bpf: Test basic workflow of task local data
Date: Fri, 25 Apr 2025 14:40:34 -0700
Message-ID: <20250425214039.2919818-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425214039.2919818-1-ameryhung@gmail.com>
References: <20250425214039.2919818-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the workflow of task local data. A user space program first declares
task local data using two different APIs. As the test starts, it calls
bpf_tld_thread_init() for every new thread that would access the
storage. Then, values can be accessed directly. The user space triggers
two bpf programs: prog_init and prog_main. prog_init simulates a
sched_ext_ops::init_task, which runs only once for every new task. It
caches the offsets of values of the task. prog_main represents bpf
programs for normal operation. It reads the task local data and write the
result to global variables for verification.

The user space program will launch 32 threads to make sure not only
umetadata, but thread-specific udata and udata_start are handled
correctly. It is verified by writing values in user space, reading
them the bpf program and checking that they match. Also make sure
the data are indeed thread-specific. Finally, a large task local data is
declared to see if the declaration API prevents it from spanning across
two pages.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_task_local_data.c     | 156 ++++++++++++++++++
 .../bpf/progs/test_task_local_data_basic.c    |  78 +++++++++
 .../selftests/bpf/task_local_data_common.h    |   8 +
 3 files changed, 242 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_data_basic.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
new file mode 100644
index 000000000000..5754687026f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -0,0 +1,156 @@
+#include <pthread.h>
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "task_local_data.h"
+#include "test_task_local_data_basic.skel.h"
+
+#define TEST_THREAD_NUM 32
+
+/* Used to declare a large tasl local data below to see if bpf_tld_type_var() prevents
+ * a value from crossing the page boundary
+ */
+struct dummy {
+	char data[1000];
+};
+
+/* Declare task local data */
+bpf_tld_type_var(int, value1);
+bpf_tld_type_var(struct test_struct, value2);
+bpf_tld_type_var(struct dummy, dummy);
+bpf_tld_key_type_var("test_basic_value3", int, value3);
+bpf_tld_key_type_var("test_basic_value4", struct test_struct, value4);
+
+/* Serialize access to bpf program's global variables */
+static pthread_mutex_t global_mutex;
+
+static void run_prog_init(struct test_task_local_data_basic *skel, int tid)
+{
+	skel->bss->target_tid = tid;
+	(void)syscall(__NR_getuid);
+	skel->bss->target_tid = -1;
+}
+
+static void run_prog_main(struct test_task_local_data_basic *skel, int tid)
+{
+	skel->bss->target_tid = tid;
+	(void)syscall(__NR_gettid);
+	skel->bss->target_tid = -1;
+}
+
+void *test_task_local_data_basic_thread(void *arg)
+{
+	struct test_task_local_data_basic *skel = (struct test_task_local_data_basic *)arg;
+	int err, tid;
+
+	tid = gettid();
+
+	err = bpf_tld_thread_init();
+	if (!ASSERT_OK(err, "bpf_tld_thread_init"))
+		return NULL;
+
+	value1 = tid + 0;
+	value2.a = tid + 1;
+	value2.b = tid + 2;
+	value2.c = tid + 3;
+	value2.d = tid + 4;
+	value3 = tid + 5;
+	value4.a = tid + 6;
+	value4.b = tid + 7;
+	value4.c = tid + 8;
+	value4.d = tid + 9;
+
+	pthread_mutex_lock(&global_mutex);
+	/* Simulate an initialization bpf prog that runs once for every new task.
+	 * The program caches data offsets for subsequent bpf programs
+	 */
+	run_prog_init(skel, tid);
+	/* Run main prog that lookup task local data and save to global variables */
+	run_prog_main(skel, tid);
+	ASSERT_EQ(skel->bss->test_value1, tid + 0, "bpf_tld_lookup value1");
+	ASSERT_EQ(skel->bss->test_value2.a, tid + 1, "bpf_tld_lookup value2.a");
+	ASSERT_EQ(skel->bss->test_value2.b, tid + 2, "bpf_tld_lookup value2.b");
+	ASSERT_EQ(skel->bss->test_value2.c, tid + 3, "bpf_tld_lookup value2.c");
+	ASSERT_EQ(skel->bss->test_value2.d, tid + 4, "bpf_tld_lookup value2.d");
+	ASSERT_EQ(skel->bss->test_value3, tid + 5, "bpf_tld_lookup value3");
+	ASSERT_EQ(skel->bss->test_value4.a, tid + 6, "bpf_tld_lookup value4.a");
+	ASSERT_EQ(skel->bss->test_value4.b, tid + 7, "bpf_tld_lookup value4.b");
+	ASSERT_EQ(skel->bss->test_value4.c, tid + 8, "bpf_tld_lookup value4.c");
+	ASSERT_EQ(skel->bss->test_value4.d, tid + 9, "bpf_tld_lookup value4.d");
+	pthread_mutex_unlock(&global_mutex);
+
+	/* Make sure valueX are indeed local to threads */
+	ASSERT_EQ(value1, tid + 0, "value1");
+	ASSERT_EQ(value2.a, tid + 1, "value2.a");
+	ASSERT_EQ(value2.b, tid + 2, "value2.b");
+	ASSERT_EQ(value2.c, tid + 3, "value2.c");
+	ASSERT_EQ(value2.d, tid + 4, "value2.d");
+	ASSERT_EQ(value3, tid + 5, "value3");
+	ASSERT_EQ(value4.a, tid + 6, "value4.a");
+	ASSERT_EQ(value4.b, tid + 7, "value4.b");
+	ASSERT_EQ(value4.c, tid + 8, "value4.c");
+	ASSERT_EQ(value4.d, tid + 9, "value4.d");
+
+	value1 = tid + 9;
+	value2.a = tid + 8;
+	value2.b = tid + 7;
+	value2.c = tid + 6;
+	value2.d = tid + 5;
+	value3 = tid + 4;
+	value4.a = tid + 3;
+	value4.b = tid + 2;
+	value4.c = tid + 1;
+	value4.d = tid + 0;
+
+	/* Run main prog again */
+	pthread_mutex_lock(&global_mutex);
+	run_prog_main(skel, tid);
+	ASSERT_EQ(skel->bss->test_value1, tid + 9, "bpf_tld_lookup value1");
+	ASSERT_EQ(skel->bss->test_value2.a, tid + 8, "bpf_tld_lookup value2.a");
+	ASSERT_EQ(skel->bss->test_value2.b, tid + 7, "bpf_tld_lookup value2.b");
+	ASSERT_EQ(skel->bss->test_value2.c, tid + 6, "bpf_tld_lookup value2.c");
+	ASSERT_EQ(skel->bss->test_value2.d, tid + 5, "bpf_tld_lookup value2.d");
+	ASSERT_EQ(skel->bss->test_value3, tid + 4, "bpf_tld_lookup value3");
+	ASSERT_EQ(skel->bss->test_value4.a, tid + 3, "bpf_tld_lookup value4.a");
+	ASSERT_EQ(skel->bss->test_value4.b, tid + 2, "bpf_tld_lookup value4.b");
+	ASSERT_EQ(skel->bss->test_value4.c, tid + 1, "bpf_tld_lookup value4.c");
+	ASSERT_EQ(skel->bss->test_value4.d, tid + 0, "bpf_tld_lookup value4.d");
+	pthread_mutex_unlock(&global_mutex);
+
+	pthread_exit(NULL);
+}
+
+static void test_task_local_data_basic(void)
+{
+	struct test_task_local_data_basic *skel;
+	pthread_t thread[TEST_THREAD_NUM];
+	int i, err;
+
+	ASSERT_OK(pthread_mutex_init(&global_mutex, NULL), "pthread_mutex_init");
+
+	skel = test_task_local_data_basic__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = test_task_local_data_basic__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	for (i = 0; i < TEST_THREAD_NUM; i++) {
+		err = pthread_create(&thread[i], NULL, test_task_local_data_basic_thread, skel);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto out;
+	}
+
+	for (i = 0; i < TEST_THREAD_NUM; i++)
+		pthread_join(thread[i], NULL);
+out:
+	unlink(TASK_LOCAL_DATA_MAP_PIN_PATH);
+}
+
+void test_task_local_data(void)
+{
+	if (test__start_subtest("task_local_data_basic"))
+		test_task_local_data_basic();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c b/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
new file mode 100644
index 000000000000..345d7c6e37de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_task_local_data_basic.c
@@ -0,0 +1,78 @@
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#include "task_local_data.h"
+
+struct task_local_data_offsets {
+	short value1;
+	short value2;
+	short test_basic_value3;
+	short test_basic_value4;
+};
+
+pid_t target_tid = 0;
+int test_value1 = 0;
+struct test_struct test_value2;
+int test_value3 = 0;
+struct test_struct test_value4;
+
+SEC("tp/syscalls/sys_enter_getuid")
+int prog_init(void *ctx)
+{
+	struct bpf_task_local_data tld;
+	struct task_struct *task;
+	int err;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_tid)
+		return 0;
+
+	err = bpf_tld_init(task, &tld);
+	if (err)
+		return 0;
+
+	bpf_tld_init_var(&tld, value1);
+	bpf_tld_init_var(&tld, value2);
+	bpf_tld_init_var(&tld, test_basic_value3);
+	bpf_tld_init_var(&tld, test_basic_value4);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_gettid")
+int prog_main(void *ctx)
+{
+	struct bpf_task_local_data tld;
+	struct test_struct *struct_p;
+	struct task_struct *task;
+	int err, *int_p;
+
+	task = bpf_get_current_task_btf();
+	if (task->pid != target_tid)
+		return 0;
+
+	err = bpf_tld_init(task, &tld);
+	if (err)
+		return 0;
+
+	int_p = bpf_tld_lookup(&tld, value1, sizeof(int));
+	if (int_p)
+		test_value1 = *int_p;
+
+	struct_p = bpf_tld_lookup(&tld, value2, sizeof(struct test_struct));
+	if (struct_p)
+		test_value2 = *struct_p;
+
+	int_p = bpf_tld_lookup(&tld, test_basic_value3, sizeof(int));
+	if (int_p)
+		test_value3 = *int_p;
+
+	struct_p = bpf_tld_lookup(&tld, test_basic_value4, sizeof(struct test_struct));
+	if (struct_p)
+		test_value4 = *struct_p;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/task_local_data_common.h b/tools/testing/selftests/bpf/task_local_data_common.h
index 2a0bb724c77c..ad99c66d3305 100644
--- a/tools/testing/selftests/bpf/task_local_data_common.h
+++ b/tools/testing/selftests/bpf/task_local_data_common.h
@@ -38,4 +38,12 @@ struct task_local_data_map_value {
 	short udata_start;
 };
 
+/* test specific */
+struct test_struct {
+	unsigned long a;
+	unsigned long b;
+	unsigned long c;
+	unsigned long d;
+};
+
 #endif
-- 
2.47.1


