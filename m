Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BF455A5D
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbhKRLch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343899AbhKRLag (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsW/H1X5SXKb3SkfnLF8OThiEczj7whjd6wk1z+2Cn4=;
        b=QsqO70oPaNhy43N7ntWfsm3CPz3bhEwJrftR4Q1ho4vhNDzSMPItqcKs17bUh0CjGII+sw
        d2wkRCoY3kAyan/m8Ecs9Ewrg9BfETCH9fiJ1Yr8lKqRSYKYOvyqE/VbYFWYhMdcWmJfYj
        cUhKZgohp9SvIoG5kOjrBvbyk4sO2Co=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-YZ9Yu3U6NcuXOpJCg3CGDg-1; Thu, 18 Nov 2021 06:27:34 -0500
X-MC-Unique: YZ9Yu3U6NcuXOpJCg3CGDg-1
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso5000442edc.7
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsW/H1X5SXKb3SkfnLF8OThiEczj7whjd6wk1z+2Cn4=;
        b=hN2tXb/35EdXGkkbwQ4L0OTHF9UdxKPFAzrkJXpakPDZsSXzhwyFw7q6hf2VBPpMz8
         3UN3adfAIo1OKEjBJWnROiwiHHScLPVnhVHX0yVWD0L7e+iTww/GicMR4A8ELqEs8Qqh
         GLMuJkN3gXfD9A//Pk+C3Lb2ehNnkAyAYpe6gt4P/JxlPPGz4XMbAX570HCbqtW6UHCL
         /cWXAgo5wVmKSwNMU7bcd4Yb+HwYFYKTUPsN9vkPmri7kW9dlSyChg0evw5nMs5H56vo
         nJlf1Eb3lcJucnNIyAaG4vD66jN5Ny2S/JfqZ+yHEqpXnwu3HibkP9/mYg+OKJaHw/3w
         Uguw==
X-Gm-Message-State: AOAM533qoyQ3FoxwSsmZEeA7dTrZqrrO7i7D8HVIHtSc04GRNbYhFE9P
        swJcNxqkl56VI2iCdMuoKPEMxbrbFZFIy0TvcedPc+t/KT0WWriEUX7Gsw1/2vimKF7ChIVxxhe
        x+8eFcJsg0Rem
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr33000605ejc.75.1637234853336;
        Thu, 18 Nov 2021 03:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNIOqscLZtBmNLPGLo+AGS5074peYacS+Gr3CSw5E/dwY/58Gho08YE3Vj8B2JynfOt2rC2Q==
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr33000570ejc.75.1637234853179;
        Thu, 18 Nov 2021 03:27:33 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l18sm524029ejo.114.2021.11.18.03.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:27:32 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 26/29] selftests/bpf: Add fentry/fexit multi func test
Date:   Thu, 18 Nov 2021 12:24:52 +0100
Message-Id: <20211118112455.475349-27-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding selftest for fentry/fexit multi func tests that attaches
to bpf_fentry_test* functions and checks argument values based
on the processed function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 ++-
 .../bpf/prog_tests/multi_fentry_fexit_test.c  | 32 +++++++++++++++++++
 .../selftests/bpf/progs/multi_fentry_fexit.c  | 28 ++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_fentry_fexit_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_fentry_fexit.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 42b67834d803..236b6e0a36de 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -323,7 +323,8 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h			\
-		multi_fentry_test.skel.h multi_fexit_test.skel.h
+		multi_fentry_test.skel.h multi_fexit_test.skel.h	\
+		multi_fentry_fexit_test.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c
@@ -337,6 +338,7 @@ linked_vars.skel.h-deps := linked_vars1.o linked_vars2.o
 linked_maps.skel.h-deps := linked_maps1.o linked_maps2.o
 multi_fentry_test.skel.h-deps := multi_fentry.o multi_check.o
 multi_fexit_test.skel.h-deps := multi_fexit.o multi_check.o
+multi_fentry_fexit_test.skel.h-deps := multi_fentry_fexit.o multi_check.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/multi_fentry_fexit_test.c b/tools/testing/selftests/bpf/prog_tests/multi_fentry_fexit_test.c
new file mode 100644
index 000000000000..d54abf36ab2f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/multi_fentry_fexit_test.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "multi_fentry_fexit_test.skel.h"
+
+void test_multi_fentry_fexit_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, link_upd_opts);
+	struct multi_fentry_fexit_test *skel = NULL;
+	__u32 duration = 0, retval;
+	int err, prog_fd;
+
+	skel = multi_fentry_fexit_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_skel_load"))
+		goto cleanup;
+
+	err = multi_fentry_fexit_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_fexit_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test2);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_arg_result, 8, "test1_arg_result");
+	ASSERT_EQ(skel->bss->test2_arg_result, 8, "test2_arg_result");
+	ASSERT_EQ(skel->bss->test2_ret_result, 8, "test2_ret_result");
+
+cleanup:
+	multi_fentry_fexit_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/multi_fentry_fexit.c b/tools/testing/selftests/bpf/progs/multi_fentry_fexit.c
new file mode 100644
index 000000000000..54ee94d060b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/multi_fentry_fexit.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_arg_result = 0;
+__u64 test2_arg_result = 0;
+__u64 test2_ret_result = 0;
+
+__hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
+__hidden extern void multi_ret_check(void *ctx, __u64 *test_result);
+
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test1, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test1_arg_result);
+	return 0;
+}
+
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test2, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f, int ret)
+{
+	multi_arg_check(ctx, &test2_arg_result);
+	multi_ret_check(ctx, &test2_ret_result);
+	return 0;
+}
-- 
2.31.1

