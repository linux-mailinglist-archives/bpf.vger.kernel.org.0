Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C76662EB75
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiKRB53 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbiKRB51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:27 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB162047
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:27 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y4so3330036plb.2
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=n+Tkq5R8y6IZ80dqavUCcVk7J1+D2NJgSt1Te4drxjtV2F4AMk5kbyhSIyezEbuUl2
         95kFSX+m7HpYhGtnAOLzaC4fsluALEvvA9p7sQLA3qhM2Q4p8Q3o+KltMf+nDo0Lp1Lp
         Nolct+0SkG86fqZZGGPSi2JIx0CxPWogKc4unGAQCXnD4IfoEkh52pC3NSuE96rMQbSR
         dlOTa3JgqckewyNu3NZhHZPwsywDek/mjluxxF7oPRb2A8UM75VmxykQazfzI8186Gme
         E55pVaoSnAQw/mPpbHlpcaRl1JS4Jgfg7GiwMvzGvZ2+cgdyOeCrNJyhakAPQBb4bQEB
         t4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=fUPVaEFU4C9UqHiKvj7LzcpcupGfAvg7A8F47EyHDgQGIcoIb1vXpn+x5LVdOUZ857
         FWeoLtbWCS8vrrArnG+rIviMO2aduSMPROAcBNsir/sqy7lCInsG2j7LFOaUFoVfFLYB
         QPPAE7NSdjqEceCEf48NxeEvl3wAatxpYbx3pjyrqiFBuDR4qB8TbXICPM1iUYvzFWpD
         URBFnmFOFl5VXelaqwbJh1srSM3BA1YLwMbnv6n+Dfv2rNKWbVeMbw8Dd6ed6L1VzIPY
         pF4QJYyc8LJUgESn/wM4L747ZkyAI5IDLCERLrht0RS6JlZadm2QYkIas/REde25upH9
         zSWw==
X-Gm-Message-State: ANoB5pmyt5BoaBHK1aSa4bn954CqcTglDrxFGJdY1kMNnAfhEp6f6Igp
        h2etL8yt2VJLl4RYcA0Mk0WvwrOobOI=
X-Google-Smtp-Source: AA0mqf5NOVbeh+xrzysqrjRcLI2iQoIottZvQYkfNB2US5fZuFiR/jIcyRj3dmWukCcYyLfr2tdygw==
X-Received: by 2002:a17:902:f712:b0:178:71f9:b8fc with SMTP id h18-20020a170902f71200b0017871f9b8fcmr5619705plo.44.1668736646541;
        Thu, 17 Nov 2022 17:57:26 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016be834d54asm2064842plh.306.2022.11.17.17.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:26 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 20/24] selftests/bpf: Update spinlock selftest
Date:   Fri, 18 Nov 2022 07:26:10 +0530
Message-Id: <20221118015614.2013203-21-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; i=memxor@gmail.com; h=from:subject; bh=7VEkgc+BO3uo7sABXUFzym09WvMjkfDkhbTvKZAA/+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXP4CA2EmruSzd0pkEr5lKkj3lWXgt8hXk7B9gB YUq2/fyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8RyrkJEA CjC+MkLvBEfJJgqYyPwFMyO8O5wS4SdSnUxm/YOy7rmsjx9hM95PI8oI4QE+Mbdd6KIPWc5zIVULdj 7/IRvii23RGDpdPXRxIwa0L6Wqa4vtTG0FgkRTUxB2ruTT0K7BcCjYZbIyfnSO9Z8TCZ8QVCoeVmfm mRV89WRaYMPD9kYtVv452PZ9A9rMmAVODG3KHM44cufDIwyFPAfUuw3CYDBtaD0O+U2b1o+vik4sGS On+QCk6aL2/F4MYmCns4/z8K/D4WHJEdUxVsf5E+Wtr4QrZClY4dFwUFeFJh1Ezr/b0XgdNdmnSV4g sNh2aAlRX2sOiDvgANZHDVKUJ4KBE6AVbTfNxCGMhRhoyb1cc+LEWaVTXb2qoaveixJbg0BW2X6LDO dA+42Tuq35LdbV/IhmqHd+bYLIgjpXvJ3oebFqlKfasGWOLbxNoLhe89c/73NSA9WF17PN5iVHwO8x kSPuK61giq+mDjyi8+ifeg6oGRJJ5RDnEPLCT+YiM/Bvg102XmQ5Z5aDpifw7UnuhElLTuwb4Q2HFr Xz5CBuEO0RvQtDPw4jhbWeB1N5bdm2fgfQaGhtI5b2l5ipLiJ1ZSIPwBrSVBTbQsen5WjB/Y9vAZnK fCebcIRLCJdOWVe/ZydMPYPvBk94wr1H8wwcl+clnj4bzh5t8H5dUpUvT+gA==
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

