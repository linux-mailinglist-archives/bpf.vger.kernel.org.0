Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62856620371
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiKGXLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGXLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826C21255
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:18 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 130so12200860pfu.8
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/pYzeiT/HbBhrq855JyBemRpl0D3d/RiN0J/SST5Cs=;
        b=gsgVwgZGORhaP2GIqXpP9ojPnOGkBoR18Em6l18F4OUnOKtCHtsBJ1nd0cKjn5I/Jf
         vaTI1QI5fgmC8wg4xaNR5xmXvs1MMCI1oCVpDOpeKf+8u3WEhiFoIVqd2mfQHzkxE+4F
         V5qvemXTcLEmxZcqRjmICCyXQfILJKjWWnV250qED/k+OYRE6YUCqUx6h4i5orHkg5pL
         a0dvAi6cpXsrQer9p7/uM87DOyW88dCRD0FuAWw0utmT6XQFU2aqDP8c41nDF/bzlVjU
         m0ZglP1AenPd5EwoW4JlOs0H++52k+iQGAIVIF80vwEf8vFOkIgVaPaYS+TH9datp4q3
         vQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/pYzeiT/HbBhrq855JyBemRpl0D3d/RiN0J/SST5Cs=;
        b=17xMURfXDaUWSi5O3VTBP8vtlaOmHr4hBpLKgsfSKSFUzIHTNAT0emjb1tWPNjo+pI
         Qc/nDA1k8WippOPzb6R1lFA8imBL8Wf1AhK83n0B5Afmqhb2UhliujtJLUlkcxiswpDN
         R+FXg6cWTsCkpw71hkFeA9g1/9vb4QjHDIG54OgMaxgZ5JTQhySe92urNZvTVVFJZ/sc
         R2Mdd2yUZAJ7knF+tmJIeh3y6apzA+Ag+VcvKKdyJXSUMrfybOjWgigwaq4RTOU6JSYE
         4iRdnLvM8m9IyqbY4/hNYv/JqH4FtoYAiLjes9Q+2XJpjprWB+kCSqzEgDrmIhXXBWur
         avxw==
X-Gm-Message-State: ACrzQf2Lwbz8TJ0NrxlhD1dOT5ocbqFzPIWvkQ36msjYWbUigYAcnOyZ
        Oq8K1S8RFRyV908UYS1TxnM1AyR2ZPwMqA==
X-Google-Smtp-Source: AMsMyM6my81H3VwTa4pVBumepcvrG4hgXqbq8xxwhMFKZp9YTJAIQOnQovoga3LEbxtRb2Ih7B2nxw==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr45686073pgc.512.1667862677595;
        Mon, 07 Nov 2022 15:11:17 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id f186-20020a6238c3000000b0056e5bce5b7asm4977209pfa.201.2022.11.07.15.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:17 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 22/25] selftests/bpf: Update spinlock selftest
Date:   Tue,  8 Nov 2022 04:39:47 +0530
Message-Id: <20221107230950.7117-23-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4216; i=memxor@gmail.com; h=from:subject; bh=gzlzDi/pDR4JSxvoLhdPAoukG/FRGz4EvJTMKaO3GFo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+3/eQd65yff16YKsQ6wIDB40eW3Biv3CaU6wh+ IAIsz6KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtwAKCRBM4MiGSL8RyiyGEA Cw1USzboLjyl0Ki+MGUAUlgVZID/SPjkRloC/HW/hpnJ1w8lea9KGPnlBP2/gQOuNOF069i6+SjE+i 19UGvz1iu1T1UbvAlfH2zqnWk7sCdtVRHcujnDV9MbYkSw+XLO8xNKh/PS4opmqY3RyNRMe6J7T5N9 RBRKctnUPwWNmW3dUgmPi2WjdVfsjfR5NJF0f8LvopJ6xTJqeSAEgWWt6WuYElnjPxIUddXKEOo8WQ X+TxLRCoSlMgP8mFwTlEZrYwSD4q5P9K/LpuXxoXAlKguWNIumWiwCj/sX3Fud9xUskl96LElTaQD2 iFoA8CnLZqJHBAyBw27+qfwUk89PVPzD4WBzTWv3AtE2MJPkojX3poliLwZGEBh4O2EFvXTgb7RH3k lnLeQa5XgY/Z7A8OvRAtMFOPeRuB9f3jCGAioMUfpb9qVpl/o10iJ/ACjNPaKE0O9RC8RONdMZ1vGF ufHSuz+8Z4LzfEuz7MfUxz/QLIp+dw2HwKYyemRCsLisgQ6dU3iQVqWpyTmUqFnVpI3RDAb06mnsfp Dvp0XhsXlLgscd8J5Qgjotc/h3zqDJAuvkhMJgEQNMX1mhRGTxGX1cEsAjYRiuwZxxi4DXFqo8IItw EWdNn99tzIpeR6r3LIrCnucAUxCcPpo1uI7Tfd5a/aHpCsO2NYVQnSCPYDKQ==
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
 .../selftests/bpf/prog_tests/spin_lock.c      | 46 +++++++++++++++++++
 .../selftests/bpf/prog_tests/spinlock.c       | 45 ------------------
 .../selftests/bpf/progs/test_spin_lock.c      |  4 +-
 3 files changed, 48 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
new file mode 100644
index 000000000000..1f720002fe56
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -0,0 +1,46 @@
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
+	for (i = 0; i < 4; i++)
+		if (!ASSERT_OK(pthread_create(&thread_id[i], NULL,
+					      &spin_lock_thread, &prog_fd), "pthread_create"))
+			goto end;
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

