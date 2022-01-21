Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7824965CF
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiAUTkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiAUTkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 14:40:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50878C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s4so614164wrb.0
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APBr1dXLngqF7qgBZ4hXBmkjAVPr6Q0A4kkFMRBGOHA=;
        b=KXTU2xXxFABErjr1sXsYGj5lDf7rQXh8LgrJT+1SCf+N2EAWnEDurlIHGh3ozOwOjU
         SYh7pCrJImvn9Hluw4HrWq+BT71eTCKbXQfW6Bp1kQU34W8oQZc5S9vovw6fvTyOfGi0
         t8bzkJ/9MJlIOdNQG3QLD4mHTdyXdphVw+IzxNafU6GrUDVkdROF6IACIdDmGRNV9Paj
         UqGo1EkDtmOqdEuCG8ejyxUm7yerdM+2diZzcM20o8XTDvM+7nRQf9KHT6wQZ4oru+8M
         aulmuMw2Isoz8UNU9+zO/GG6J0poexLpmqx9lB8GpDH9PmTbbwdw4Wir1OxLesIf6TKk
         G3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APBr1dXLngqF7qgBZ4hXBmkjAVPr6Q0A4kkFMRBGOHA=;
        b=1CHmBccR8HL8A2lZdE8B+8uSgmaDHBauKJz7LTM5vSMYqMIWtv9trIi5fCeDEKFsNS
         P3P/37obNeu+ic/g8TZGpkd0Qib3qMQnUvfionL0ixip8rxZyY7UDhRFmBYrLKHz0okJ
         Z7sdJTl4dQIIzPdl9jjz5rMDTLcwAf+2rSay018fTeIg6rJzoq7ajk2tGqBAnSQ1lVAZ
         cmGKcqGV1lsXIk1/zHbq9M7jdHF8dG0q2ph7Ajvhr2kd5fIlr8DM4p4VVAsiBi4Xk28E
         NnL26W3bGqJ07jzZpwEy9de3xsNstbIf5HE/qRgRS0ya/RNR3waTm4nU52ZsNisId2OS
         LcmQ==
X-Gm-Message-State: AOAM5300WvVe1N58a+jxLgoVB+SxRq6GZOBCQsTbt6wyMfZm0DWXZ/oQ
        GUPM3+f+yknQH4DfOzOsML2eqwN9qpxMtA==
X-Google-Smtp-Source: ABdhPJxSe2R1JRKZK+EqCpgXsH88/crff/Zn5v2gIlGt1LAJBpqmN/39OSiC4ZSOeXweGWBbLzm8fg==
X-Received: by 2002:a5d:4567:: with SMTP id a7mr4925239wrc.363.1642794021800;
        Fri, 21 Jan 2022 11:40:21 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:575f:679d:7c2f:fa19])
        by smtp.gmail.com with ESMTPSA id n14sm6988059wri.101.2022.01.21.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:40:21 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com
Cc:     fam.zheng@bytedance.com, cong.wang@bytedance.com, song@kernel.org,
        Usama Arif <usama.arif@bytedance.com>
Subject: [RFC bpf-next 3/3] selftests/bpf: add test for module helper
Date:   Fri, 21 Jan 2022 19:39:56 +0000
Message-Id: <20220121193956.198120-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121193956.198120-1-usama.arif@bytedance.com>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a simple test for a module hepler that accepts
2 pointers to integer, prints them (using printk which isn't
directly accessible to eBPF applications) and returns their sum.
The test has been adapted from test_ksyms_module.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 21 +++++++
 .../selftests/bpf/prog_tests/helper_module.c  | 59 +++++++++++++++++++
 .../selftests/bpf/progs/test_helper_module.c  | 18 ++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/helper_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_helper_module.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 42ffc24e9e71..34df13cdfb05 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -332,7 +332,8 @@ LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
 	map_ptr_kern.c core_kern.c
 # Generate both light skeleton and libbpf skeleton for these
-LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
+LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c \
+	test_helper_module.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index bdbacf5adcd2..38d344e2d12d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -120,11 +121,29 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 
 extern int bpf_fentry_test1(int a);
 
+int bpf_helper_print_add(int *input1, int *input2)
+{
+	printk(KERN_INFO "input numbers for module helper %d %d\n", *input1, *input2);
+	return *input1 + *input2;
+}
+
+struct bpf_func_proto bpf_helper_print_add_proto = {
+	.gpl_only       = false,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_INT,
+	.arg2_type      = ARG_PTR_TO_INT,
+};
+
+DEFINE_MOD_HELPER(mod_helper, THIS_MODULE, bpf_helper_print_add, bpf_helper_print_add_proto);
+
 static int bpf_testmod_init(void)
 {
 	int ret;
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
+	if (ret < 0)
+		return ret;
+	ret = register_mod_helper(&mod_helper);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
@@ -134,6 +153,8 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
+	unregister_mod_helper(&mod_helper);
+
 	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/helper_module.c b/tools/testing/selftests/bpf/prog_tests/helper_module.c
new file mode 100644
index 000000000000..d8e8600ab3be
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/helper_module.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "test_helper_module.lskel.h"
+#include "test_helper_module.skel.h"
+
+void test_helper_module_lskel(void)
+{
+	struct test_helper_module_lskel *skel;
+	int retval;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = test_helper_module_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_helper_module_lskel__open_and_load"))
+		return;
+	err = bpf_prog_test_run(skel->progs.load.prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, (__u32 *)&retval, NULL);
+	if (!ASSERT_OK(err, "bpf_prog_test_run"))
+		goto cleanup;
+	ASSERT_EQ(retval, 7, "retval");
+cleanup:
+	test_helper_module_lskel__destroy(skel);
+}
+
+void test_helper_module_libbpf(void)
+{
+	struct test_helper_module *skel;
+	int retval, err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = test_helper_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_helper_module__open"))
+		return;
+	err = bpf_prog_test_run(bpf_program__fd(skel->progs.load), 1, &pkt_v4,
+				sizeof(pkt_v4), NULL, NULL, (__u32 *)&retval, NULL);
+	if (!ASSERT_OK(err, "bpf_prog_test_run"))
+		goto cleanup;
+	ASSERT_EQ(retval, 7, "retval");
+cleanup:
+	test_helper_module__destroy(skel);
+}
+
+void test_helper_module(void)
+{
+	if (test__start_subtest("lskel"))
+		test_helper_module_lskel();
+	if (test__start_subtest("libbpf"))
+		test_helper_module_libbpf();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_helper_module.c b/tools/testing/selftests/bpf/progs/test_helper_module.c
new file mode 100644
index 000000000000..66dadd317498
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_helper_module.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+extern int bpf_helper_print_add(int *a, int *b) __ksym;
+
+SEC("tc")
+int load(struct __sk_buff *skb)
+{
+	int a, b;
+
+	a = 3;
+	b = 4;
+	return bpf_helper_print_add(&a, &b);
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.25.1

