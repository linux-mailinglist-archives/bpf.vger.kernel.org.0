Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB60628921
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiKNTRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbiKNTRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:17:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1827DD2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:17:01 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 130so11923219pfu.8
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=LwyyW9Bf0YoqQe2ggMqqZwhn4PTkC4Lb3MiPwCKm9GOf+dUpmPMTaMvT5HWqDgqk/Y
         oO9ATAqZAWmWsYaBonyIjPH87FXek3xCOw5SPe05Ewo3c+8w5NIZxFdHduefmnUHZDbD
         Uks6CHKvAW/zBAtSQLeandQPDtlgJ26G9AVurAB1+ekX4j8cIL2tioXfGrndlrmSoDGO
         qX28iJyqf2elaGXjgTvf+274Gf+JYnPVjiQJ6fskxrNvdw8f80IGj4VtkDf6xWnZLrEn
         aTDMUwlLE2ArW1+DhQFj9AuvoGSS5Lc9yVRkzIfPH0BwdChjkMlzHwecSc3Bdx/laf3K
         tIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=l3qkTbYBx27O2AlLmKAx4g5Ix09nqLbj2N68uhguHMOCKiSmMjKZFBnB+ZwaMemrZd
         BU4och/G3r+ulyhvZMzDnV9aT6qKA6wqLv6qg65tNm9cyfd/QRI/XfHySUHMEUiclii6
         JCwLZNO7wI+qt/SBGLs5xOruiUY/e1/A28tCNegSj4xoENcbWvwm5haD7ZLLka3jKY8o
         R159JSe+BP8xxIsGHE0cO3saHTHmVCxci837tIvQDZJtZE6++b5GC8TBIA0jSzV6YT9V
         OdjKUXPIsbnPVGPUNK+zg08snz/EZkzYzCw9bRSz9WZSJY4zfV/3vmdSxNrD7laXcOgY
         NGkw==
X-Gm-Message-State: ANoB5plDiTpz/heaem4AwMZurXASf1JZyvFCOiHWq5FI287IA0v0QhVv
        EumfOVKGuf2K9CRKE3uHTGiXlfhuZ9KZoQ==
X-Google-Smtp-Source: AA0mqf66E1eCVm8naDhSxSjPqfD5uqMFUwJU6Tqd64uCI3dQjf866hfHUcJPOHIci7CQ0CcU/LvW3Q==
X-Received: by 2002:a63:1a59:0:b0:473:c377:b82 with SMTP id a25-20020a631a59000000b00473c3770b82mr13401447pgm.113.1668453420566;
        Mon, 14 Nov 2022 11:17:00 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id e5-20020aa79805000000b005632f6490aasm7083892pfl.77.2022.11.14.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:17:00 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 23/26] selftests/bpf: Update spinlock selftest
Date:   Tue, 15 Nov 2022 00:45:44 +0530
Message-Id: <20221114191547.1694267-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; i=memxor@gmail.com; h=from:subject; bh=7VEkgc+BO3uo7sABXUFzym09WvMjkfDkhbTvKZAA/+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPK4CA2EmruSzd0pkEr5lKkj3lWXgt8hXk7B9gB YUq2/fyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTygAKCRBM4MiGSL8RypRtD/ 4+agLXY5dQ29as85gdZr6t/TZeoDY9CF2fNs44Jp+u2emmK4LeLzEqGnjrZPq03wi4PgD9RwV231VU 8BLKR2O8NCcWCVqWWyyluoFCTEMmrEfOcJ/6InWabfB5KheZApkKndq9A3vZs5NR4i82J3XKp4ZDFn 28lZRF7qW7jtcRHsz3KN/NDYd9hup7cpB1hbLfq+ya4uvbK/Q65jCbhYIKwsmXrJ0X4RtV02IagBSk 1U99oxRILCYp1iuUKc/5dt/+eJox3EFqcpzvh3kpdIb9UwHGins3ibet7CKz0Pso+jrgGxWNoS+L0Q Tq6a63r77R9STy5nsMcNRhJhIKEAai9W9MUej5hGXra5lPqYUIMeAtjpapx++gTtLo+zQZ6l0rZeWp IHvf1CL3nYKQ4TuZWipC+v9RN7g3GkwGQjhEBhQH8XEEKRBFt+TxWLryraKU+l/xW7ss7WiK8l1e/D VJLks5CuyR3JIHDLKidvOt8jyEcEgeB5URjw9CnsuLfA+RV6f+SAOBbQXxi5le0ATBTbJT2SKzKmM2 8dWkRZO+1NAIc/OEJj/jIr5oHilPW9ZCcLxi54Pus9R5JdrWj2/q2VFlytN8HPLRSXBnV+AwR/O+ov HhK3OFAFAJeedDZbW0D7ljAeaYdf92maUYFaoG++6tJeU8UtbYKBKtTS4y+Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make updates in preparation for adding more test cases to this selftest:
- Convert from CHECK_ to ASSERT macros.
- Use BPF skeleton
- Fix typo sping -> spin
- Rename spinlock.c -> spin_lock.c

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/spin_lock.c      | 49 +++++++++++++++++++
 .../selftests/bpf/prog_tests/spinlock.c       | 45 -----------------
 .../selftests/bpf/progs/test_spin_lock.c      |  4 +-
 3 files changed, 51 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
new file mode 100644
index 000000000000..fab061e9d77c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "test_spin_lock.skel.h"
+
+static void *spin_lock_thread(void *arg)
+{
+	int err, prog_fd = *(u32 *) arg;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 10000,
+	);
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_OK(topts.retval, "test_run retval");
+	pthread_exit(arg);
+}
+
+void test_spinlock(void)
+{
+	struct test_spin_lock *skel;
+	pthread_t thread_id[4];
+	int prog_fd, i;
+	void *ret;
+
+	skel = test_spin_lock__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_spin_lock__open_and_load"))
+		return;
+	prog_fd = bpf_program__fd(skel->progs.bpf_spin_lock_test);
+	for (i = 0; i < 4; i++) {
+		int err;
+
+		err = pthread_create(&thread_id[i], NULL, &spin_lock_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
+			goto end;
+		if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
+			goto end;
+	}
+end:
+	test_spin_lock__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/spinlock.c b/tools/testing/selftests/bpf/prog_tests/spinlock.c
deleted file mode 100644
index 15eb1372d771..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/spinlock.c
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <test_progs.h>
-#include <network_helpers.h>
-
-static void *spin_lock_thread(void *arg)
-{
-	int err, prog_fd = *(u32 *) arg;
-	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		.data_in = &pkt_v4,
-		.data_size_in = sizeof(pkt_v4),
-		.repeat = 10000,
-	);
-
-	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	ASSERT_OK(err, "test_run");
-	ASSERT_OK(topts.retval, "test_run retval");
-	pthread_exit(arg);
-}
-
-void test_spinlock(void)
-{
-	const char *file = "./test_spin_lock.bpf.o";
-	pthread_t thread_id[4];
-	struct bpf_object *obj = NULL;
-	int prog_fd;
-	int err = 0, i;
-	void *ret;
-
-	err = bpf_prog_test_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
-	if (CHECK_FAIL(err)) {
-		printf("test_spin_lock:bpf_prog_test_load errno %d\n", errno);
-		goto close_prog;
-	}
-	for (i = 0; i < 4; i++)
-		if (CHECK_FAIL(pthread_create(&thread_id[i], NULL,
-					      &spin_lock_thread, &prog_fd)))
-			goto close_prog;
-
-	for (i = 0; i < 4; i++)
-		if (CHECK_FAIL(pthread_join(thread_id[i], &ret) ||
-			       ret != (void *)&prog_fd))
-			goto close_prog;
-close_prog:
-	bpf_object__close(obj);
-}
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index 7e88309d3229..5bd10409285b 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -45,8 +45,8 @@ struct {
 
 #define CREDIT_PER_NS(delta, rate) (((delta) * rate) >> 20)
 
-SEC("tc")
-int bpf_sping_lock_test(struct __sk_buff *skb)
+SEC("cgroup_skb/ingress")
+int bpf_spin_lock_test(struct __sk_buff *skb)
 {
 	volatile int credit = 0, max_credit = 100, pkt_len = 64;
 	struct hmap_elem zero = {}, *val;
-- 
2.38.1

