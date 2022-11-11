Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8362620F
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiKKTei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiKKTef (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:35 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A47879A
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:33 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z26so5718538pff.1
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=UhrzKS3RempGl3UdBOI6x4RIvPzylyBqXcdKbeRodKSVgF9yd5V7PR8fe4S7z+v07/
         LNPnuYza+aMv+jIgezsvzEdIdHLCZe4VQdns5UyUUFp74UjvqM2fWBe/kZz0xam8wnO5
         32YDRtTcCyTXCO4arJjwYt5/CPJem7bTu6WmqRDknPnC/vqcdLkS5sSxhrNnsiY6oEYn
         bXCqjV+CtbcIDE/zjq1yv1cWEcfIpnLTAFQ19YEzvjd7ulGGILEIMD6Epj3mlvq6o3Ta
         ZbYDoOns49WiBRCl6mih/iEaYKhCaQmck0S/1zPzp5ik/CKBCe02MIHbuHNzkKBrFvUK
         l7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=W3RFNDLYma8sfWaL7ZoTnC1djjdZHwxQGngrscX/3OWI0TOln2sVenyWckAir8P8Z8
         K1xExAMbygZUNjQe/G7Z10k5k4rv0+oaU35LBJ8hKvZqmoPaOZwRb69jDPH0Hh0QG0MB
         LFb0J6D9ZyhsXLVQQf3nuS/YCgBF6EdA08svagKqApy+s8JwPyyne4y8hh0gIzdGqS88
         fa3mmKlHC4O9Y7D6HEDiy99Li+NnnoWZ026tx/X79zVdvU7zIFC1LUIAGmm2xQ/JEC9+
         IydNsWtveYBC+pjLQxKM5EBsq2MA9f8RCGza9Ie7KY6P3Va84MMkMx0QFd97Cc/PfYm7
         X3Cw==
X-Gm-Message-State: ANoB5plFgutMj5imrmqRK/poC+d2eE20yC1NBg0g2nZfYO11UplFN88F
        WskdBaTebB2dfYjXZUfJeNEzoFfvIaAkkw==
X-Google-Smtp-Source: AA0mqf5lBS/o5j2eOxM6e315bR6/vRSuMiLfk2TeKXJQaaNzAR99e7KW00az8tJWzpX72Bt5XT2VnA==
X-Received: by 2002:a63:4551:0:b0:435:7957:559d with SMTP id u17-20020a634551000000b004357957559dmr2858304pgk.122.1668195272978;
        Fri, 11 Nov 2022 11:34:32 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id q28-20020aa7983c000000b0056e8eb09d57sm1958897pfl.63.2022.11.11.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:32 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 23/26] selftests/bpf: Update spinlock selftest
Date:   Sat, 12 Nov 2022 01:02:21 +0530
Message-Id: <20221111193224.876706-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; i=memxor@gmail.com; h=from:subject; bh=7VEkgc+BO3uo7sABXUFzym09WvMjkfDkhbTvKZAA/+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIp4CA2EmruSzd0pkEr5lKkj3lWXgt8hXk7B9gB YUq2/fyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKQAKCRBM4MiGSL8RymVND/ 4o9zsxx3d0UQI/Z0ZnObXToZooc0BHXO8YyOD4umDcV6vKLn/+NBHBkljnZAG0rAE1gDjUakdAv59f EnleTqtxn6rC/d+737C5AtcoIqT/5Oe76wC+ugkBstQeNa3Z6OoM5jzDCStsBwTUxdwEMBAMKJyip8 /v+LwoJbLnS8gXz1YWhsNMcYBEIGOYTr+Q84lXn4uuin7Dtvqtue1/NFLZGAOEZbwotHFuyu+/3Vc1 acfXJ40ljYfuUm1wb1K3SXRy3UeEcwK6+zY+j1nApwPqfinPviK7plaYyk5nWW6PHxxde3aZrkdRU6 9h4DcTppHbsetVmn0xVBcU5nNs45JAFlsfERplptnyfVCCLqaqjsevIJmgaszC0xd6zp1h85NJoSZv CD2iIV7rkchvcUHArehu+r037ix2RoRkXmXRelGRpEU6JmLCekc0yHqjvbkWxBO42fhhNI7vJ4yiOr rWrzg2siEhd2cLoo2nSxKe77+dm6S/BkmAHxipZcx62+dsJPF1U7YiQmcMF1E9DlD2rzqns+dYiAK/ brW8ciuN9vRmVxUFXrnCvdInh9vB26liD4QaJ8NVkptYfEmcigwrxXHfRi5rQJLzn7Igcn97xz0GXv 63SgGXOHiwZLIIUcifSK+m7B1KHamhfuua3IwoaULHLw5nNTjKB6ylPunzig==
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

