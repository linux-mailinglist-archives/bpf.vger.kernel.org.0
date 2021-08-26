Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0523F8F09
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbhHZTmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243632AbhHZTmt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvwmNaf8LZrHvZynooCcnzAt3fHTMCuVZNqKAgXRXAQ=;
        b=DHZN+t5s3Ly+MVybrF93HbMIx6NOvMELtPkNrWMOmnaW+aaKet48I401FW9Xr3p4Tdr/xc
        NNMPkJ7LXl37LmVezlHzfKLtl3lKhvsq5MweYZFf5drn9V/QoScfESeA0tTKkSwNa/Epfm
        L+Z7NzF6il/7mqiT0ubVT4CHHuYvS4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-8aUS3IT2Pq-bWosCXPz4Wg-1; Thu, 26 Aug 2021 15:42:00 -0400
X-MC-Unique: 8aUS3IT2Pq-bWosCXPz4Wg-1
Received: by mail-wm1-f71.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so1127061wmj.6
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvwmNaf8LZrHvZynooCcnzAt3fHTMCuVZNqKAgXRXAQ=;
        b=Ga+7YfAFxMXLW0zeVEhU/ZDa+QavjwCt4tpizUYTbb6lusm/GGmoW48ky9mYEbM56S
         ZwLXMz/sIJdSPChERCQ2459vm8PaOaFSLBFPcC/5I/VNsvkMblHqernmvX+ZrCuZzrI2
         DguiwJq882Ow4MRkmHMdiJ8lM5wHGb1UxdARuPORV8Nh4abUBOFSnH2l8FsYaKDqQKDS
         s0qb7LyvMnwWtSWK2ZQwVJlpNOHTashof+p3+vbtIwVBtufls5CrUHPWkzmPO8lROJPV
         xij9uoKNGDKf5FYyjUXoGbhVT+JVHdXghf9BJ2jRT6F/3por5ieWuvcRpn4MXnSvjImH
         yvjA==
X-Gm-Message-State: AOAM531xV97bzdCaBV6NQ8PhW0VIElI4XYP04uotCEjuRdCe+mMTPa8L
        YGYP++Knc5cDxzdoljcgoTvEb530vktt02coMoQOQE9kc6+a0+eRO9LWEyP70vGexQEq5Ri0AVN
        7Hb25ZpZ0y+zi
X-Received: by 2002:adf:ba08:: with SMTP id o8mr6045288wrg.234.1630006919528;
        Thu, 26 Aug 2021 12:41:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbSIcNWq3pNhPfh5PAZx+X4g/ugKXyanA20urzEHBZSEH0UpdYlBiliDK4HUiYLPJSI0J1qQ==
X-Received: by 2002:adf:ba08:: with SMTP id o8mr6045267wrg.234.1630006919384;
        Thu, 26 Aug 2021 12:41:59 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id r129sm3599334wmr.7.2021.08.26.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:41:59 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 25/27] selftests/bpf: Add mixed multi func test
Date:   Thu, 26 Aug 2021 21:39:20 +0200
Message-Id: <20210826193922.66204-26-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding selftest for fentry/fexit multi func tests that attaches
to bpf_fentry_test* functions, where some of them have already
attached trampoline.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../bpf/prog_tests/multi_mixed_test.c         | 34 +++++++++++++++
 .../testing/selftests/bpf/progs/multi_mixed.c | 43 +++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_mixed_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_mixed.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6272d9c166f9..1c80d76ebc70 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -314,7 +314,7 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h			\
 		multi_fentry_test.skel.h multi_fexit_test.skel.h	\
-		multi_fentry_fexit_test.skel.h
+		multi_fentry_fexit_test.skel.h multi_mixed_test.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ksyms_module.c test_ringbuf.c atomics.c trace_printk.c
@@ -327,6 +327,7 @@ linked_maps.skel.h-deps := linked_maps1.o linked_maps2.o
 multi_fentry_test.skel.h-deps := multi_fentry.o multi_check.o
 multi_fexit_test.skel.h-deps := multi_fexit.o multi_check.o
 multi_fentry_fexit_test.skel.h-deps := multi_fentry_fexit.o multi_check.o
+multi_mixed_test.skel.h-deps := multi_mixed.o multi_check.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/multi_mixed_test.c b/tools/testing/selftests/bpf/prog_tests/multi_mixed_test.c
new file mode 100644
index 000000000000..c9395b4eb5ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/multi_mixed_test.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "multi_mixed_test.skel.h"
+
+void test_multi_mixed_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_update_opts, link_upd_opts);
+	struct multi_mixed_test *skel = NULL;
+	__u32 duration = 0, retval;
+	int err, prog_fd;
+
+	skel = multi_mixed_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_skel_load"))
+		goto cleanup;
+
+	err = multi_mixed_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
+	ASSERT_EQ(skel->bss->test3_arg_result, 8, "test3_arg_result");
+	ASSERT_EQ(skel->bss->test4_arg_result, 8, "test4_arg_result");
+	ASSERT_EQ(skel->bss->test4_ret_result, 8, "test4_ret_result");
+
+cleanup:
+	multi_mixed_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/multi_mixed.c b/tools/testing/selftests/bpf/progs/multi_mixed.c
new file mode 100644
index 000000000000..2ccd507747c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/multi_mixed.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
+__hidden extern void multi_ret_check(void *ctx, int ret, __u64 *test_result);
+
+__u64 test1_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	test1_result += a == 1;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_fentry_test2")
+int BPF_PROG(test2, int a, __u64 b, int ret)
+{
+	test2_result += a == 2 && b == 3;
+	return 0;
+}
+
+__u64 test3_arg_result = 0;
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test3, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test3_arg_result);
+	return 0;
+}
+
+__u64 test4_arg_result = 0;
+__u64 test4_ret_result = 0;
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test4, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f, int ret)
+{
+	multi_arg_check(ctx, &test4_arg_result);
+	multi_ret_check(ctx, ret, &test4_ret_result);
+	return 0;
+}
-- 
2.31.1

