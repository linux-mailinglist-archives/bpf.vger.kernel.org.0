Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF562E1B5
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiKQQ1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiKQQ0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:36 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392307C472
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:58 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n17so2394274pgh.9
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=AdGGCjMWnLhVJVhIVz4PNOXJV5mzLxIb9HB4xWrGKuTcliyarL8uoao2N48G2tu0s7
         eYeipiZjPbQ/jHlZSKxig5zjHlrFLM5SfEri5s1JfxOHxUkM2UKP0Hrm3bfhLYS89VhT
         ujUhRJ+AYuxbMXXEwcBDd8KgPcnOm+llRGbgOkxtxIp2p9X5DiB009YD2Z8DsNYzTHwZ
         0xeRgRRXFAZVo8szYTXueS8ywnn1abJcqmlSIjDIqkuSvZ4+C8K+NNKxs/smPdFIv3W1
         MnR1V0feFeZiPeMMxW3m9jHO7qAsSaG0K9sflMlz6cReG8TRDVnk0wh9zWTkpqTpBVCC
         x5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orrU9bkwct7hSaHpeFwTQHPvPh3WfieLrB51Oysef3o=;
        b=FbKbyx6l3kCnrLLVz9TFYwBt6qfl1oAe0/YYV8T4xypt09dzNn4eXyTH9QhE/Kl9AS
         VyKR8iuUa8Y2vF2+t9AqjYGSB6E1P0jS8ckmk2ZfLwzfotjKnYM5WeDYTib+WI8yVH3S
         sJP5HoDrxkDoPPzJviu8WIjbfiltF3dPhl/79h6TgtlYA8DlKO+m8EVfPEp3iVb2pRyJ
         /dljNlf9X0Xax5waf9jxyNJlwUBpyTY+fg4TzwfFOZSZcxDyuqB4qvGl9canLh/Ute71
         jt3z8pBJuBaxk3I/uS7Uo3HXoEUP53Sg8xl0Hu5EcrTJjnP+1BsxR2e71feYDVMfunPe
         rGCA==
X-Gm-Message-State: ANoB5pm1Rv9g7nHVRRX+2QF/WyEAR6yzMiy9sPMPRjJ3uTjtsAcAIEiP
        XUt59CDncSOeQbcjpBaBhQGfGGFl3fM=
X-Google-Smtp-Source: AA0mqf4N2CYroRdRlCP5OHUs2A+/xtAxh+MdEt2TesonExRdxN7ktn21opn+QpxBzeEJLdQuMJEX9w==
X-Received: by 2002:a63:a05:0:b0:42b:42fb:3da1 with SMTP id 5-20020a630a05000000b0042b42fb3da1mr2677638pgk.538.1668702357638;
        Thu, 17 Nov 2022 08:25:57 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001714c36a6e7sm815215plg.284.2022.11.17.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 19/22] selftests/bpf: Update spinlock selftest
Date:   Thu, 17 Nov 2022 21:54:27 +0530
Message-Id: <20221117162430.1213770-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; i=memxor@gmail.com; h=from:subject; bh=7VEkgc+BO3uo7sABXUFzym09WvMjkfDkhbTvKZAA/+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl8A4CA2EmruSzd0pkEr5lKkj3lWXgt8hXk7B9gB YUq2/fyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3ZfAAAKCRBM4MiGSL8RypSXD/ 4l9T+M9OqFPJJ+N2v6IkiHYx7NCH7tSUWMb6e4UP8PlonfdvcCj9yE1zwi8LZ7T3EeDrtAg3YrKf8W 5IrZ5VYkud+ZFY87zhgDdvXU55AbP5F5+l1SeFmWCP9oU/oKm27E7S1H+F12D1UICmv3zUOHpQP80l iUnxHQD8WQs3sj7o4RdRx4ys9E2UZSB/3Ln62snz1lY6aPQBSi0JOnXbvk4YtzS5KU77UmYZzzsx4x vB7zwQDUpcCRKmGQmmBR/J4l13WOkrFuWUGEWW7imgbX60FPY3OWsklgMEqhem2LF6wpo3pws3Ucop 98ymDUq1jwLiZIFIFFh3SGkOP5c1pzU1mLkrTaLZ/OcFtYIlo6WJZdZaYsWbz5iojmkNltfUEkRnRD aStAIaq/OCdua3bGDiDRIcQXsqiciCxFfGvy0mamv1ZmLXOBNHUfxE2IguGS5e0ABtC4Bmw6MHtpeB fVnuw8Yy5f6M7PRZFm56MN5KQlEBzmLn/s4+0kMQe8k+NgKPoSMbjuAz0i+P4RTnNyzoPpIERQpYG2 +MoqpNGxSonAxrgmIoXvNYfUzeLftTRICBwtDmJ5zuEA14VUVWXb96DEuzsS8f1jZiS8h0FICM4rmO 0qnbnpYshPoPAVtZBBKnHJRjBSRXy8iKrI9Xw0okkx3IWo3Foqozx+b1wvzw==
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

