Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284662E8D9
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiKQW4d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiKQW4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D81A3BA
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:30 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id jn7so1134464plb.13
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=AEt8wmo4ikfncfr7mx+a0wEX+Xd2vn08+hMorLqGnepiNNKwqeaQImZvwsGnOLjWoU
         L0HAGbJ/xkpk4F4xe2vSLcNgrn7ZWchII+YcWwTxdretXnIZfu/Q6ongcYR2SptvSgNg
         iMVXqU51O1JI08pQCQIvldHLa7x9ibchN+rAXXUObzC6MgoQ05MrAI4+s2CLt0S3IVjO
         eZBv5R91xgZ5Bbc1VkNRGu5e46TeTz6pt6fbVnz2+i3kzP5Cgpj48Z1IhX+vJLo97Nw8
         6oaYLGt/MkNuvDq0jWIqzQz2FneTVOVXpm+aiCmLU4/wZsHzP4epQxjtyHjCcTxWGAut
         HdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=C8A0Qq77dNbRR0eLlKXayu7PiFLRCLM9ToXZy87junvY8RTuPycCVo6oLza9Gdwr4L
         HL1ExnXWu5OzW97VWOuDnzjZDwDfxBaXpCVreKy2nO5Pq6rqD2Lxd3x6Pol92SVbhDHp
         clUAsp/p++68yhL5D0hpA2JTFRkmMjXxE32CxxFI+1xJVTtpVQKSaS0MwrJ2ke8yuGIx
         zim3sWw6SO+uQr4fc0tPwdrS7+N1ZJ2cmcFMdGtpZh7reSSkKXACcTqkHCy4WdNKdkTS
         W1D/HScsxxGufzVtir+0VEHk2pNwuXM4FhDHoS0r+h6xlq1sZ/T/jdjeWK1yRLzvUWQm
         vmyg==
X-Gm-Message-State: ANoB5pnLBsmy0kl2d1Ijsln+OjFDpO9oiZUKRid+b+2+2aIAH8c/G2c3
        XWa28grMt6Evrj05S/cHaqHPIej04k0=
X-Google-Smtp-Source: AA0mqf6JWa4sUKOcLqymE52XdvVBELtJc2/LxBQBbPAUT6W/AH3H++uOX1DVwAuVQmxJAXQYBPgNSQ==
X-Received: by 2002:a17:902:ecc3:b0:188:59d2:33e with SMTP id a3-20020a170902ecc300b0018859d2033emr4529858plh.142.1668725789303;
        Thu, 17 Nov 2022 14:56:29 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902c40b00b0017f5ad327casm2024583plk.103.2022.11.17.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:28 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 20/23] selftests/bpf: Update spinlock selftest
Date:   Fri, 18 Nov 2022 04:25:07 +0530
Message-Id: <20221117225510.1676785-21-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; i=memxor@gmail.com; h=from:subject; bh=7VEkgc+BO3uo7sABXUFzym09WvMjkfDkhbTvKZAA/+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkc4CA2EmruSzd0pkEr5lKkj3lWXgt8hXk7B9gB YUq2/fyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8Ryu5TD/ 91lYYfFBXqGePqF9i8tStr/oFNBQ9O+FzmlYa5N+TCiRjPFWw8NsaUw2fkzfPXyVMpavAk13Q2rxR2 luIUmnf2m17OubzXnEKl2mc0euZE/pZF3Sr1ja3y9Np1cdYWx/WLBxYBIOLZiaGT3ZvbAWXstSrncH OC//7nVtVRJSQtP+Fq+pwUb8FBxqEs/7ZOuFTfI1EF4nKGLDa2d4pATlzVGY0WcZRHl4szTpPlUqbj 9WJ/v2J34q2+s40+XpvSWR5ZoGpmjTHinYqFGQSxhlguXWHtNQbcoQN3P5OBp8aLndESbnlyjTFvR+ NP7qoPVOqEWHOIH7KYoONobvG1AIJYezm3SXoofqx2E/IdyxNs8lWh2kE0SvUHIqPhoSh9QNz+5UN2 wR+5dWJgiSIsnzNKehhjw+ZQahn06AtKjez8mhMSnP9IeexOby6LoWqtTT/bvzXn6be2eMkaMIYGc1 o4lvcGc10VAGnzXYuxebtLrVgz9JVloEwXDs8wANTvBvbvmtsa4VRGB4zD3F9Jqz3AoNaFFq2LIPS8 qcdVmWMUiHAS1jVKVxQ6gBJAn5aRrwNzB8ArFZilL9aVVQQE3oHUPky6RXPnM4SLD2fN98x8soNmaF wPPEX9ExhR4ihmCgQWjJl8tlnE8bgMsCvCaxBGNkkOhgfBOywUXJv4IarNBQ==
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

