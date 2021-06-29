Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9F3B78A9
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhF2Tca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 15:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234853AbhF2Tc2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 15:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624995000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yu/yssvroh5wN9vZzKT4DxZ0/5KDe3VlIF6FttuA20I=;
        b=ew9WRxm1eUwmXg5GZsjslM0fXGHWD0lqwSDTcUyF6/mKCqIWR4v+F/5ajMqIoKt5gxo0xf
        Q/J9vqDpH3RQAF4+GtKaET0G9KYiIJ16vWun0fLuh2qeD8GbSQxdGu2N29gOUTsElPMoNO
        y0D31mvSZ4BQ46yunxzMZ4Lr9sD/xG0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-daqy5WELOkWyuGMijRtIpA-1; Tue, 29 Jun 2021 15:29:59 -0400
X-MC-Unique: daqy5WELOkWyuGMijRtIpA-1
Received: by mail-ej1-f70.google.com with SMTP id l6-20020a1709062a86b029046ec0ceaf5cso6170193eje.8
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 12:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yu/yssvroh5wN9vZzKT4DxZ0/5KDe3VlIF6FttuA20I=;
        b=GpBm2cGWYZG2PBI7ocU67SES3ojLCVYwopK4wWHQ08BMmb16Baa5AgKbOzT0DZwWfH
         Mid6hFVYHXH66VC1MSGIqKzNsI2MLUF28Foq/yrg9aWOsXcTaNW64BfoAfkw/+dhTreR
         BGoBF8EGVAiBuN4XwOqZJ7wu0IK3D+iuWzV+PLxk3rRdGhS6lrSNihkcJkuHiYwW00i5
         Ry6H0kz+QgfkxIRzSSkve1aBdN9gi5NtzoA5eSymjTeKYAeOn/+1vj0vVbZTgQIwxaiX
         yVvp5sw0EknkqbBiSmm2FbW9p8ypNfvp5owm04h//64muGZF/0rL/6mGUodTAjgU40yv
         u6CQ==
X-Gm-Message-State: AOAM532NxVAqFfpJsLj/5LkRLvyD8/IutrApUL/yfnOHW4PNz8EZpZcH
        jMXvSmXPINwO70HMXHjj9CX08mNF4rHBb9DkXBGZz/fJCoDBWnIhb85HfhsqKzVn7Ritxv8Qemu
        ouF1fjleO+fDN
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr30740839ejf.383.1624994998032;
        Tue, 29 Jun 2021 12:29:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFqLD5YCRlfenVEivGZyabGHfxF7mU0HSy+wA1Y71DK6LzEYJsG5ZYRxtGnReuiXs6VqLUjg==
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr30740823ejf.383.1624994997819;
        Tue, 29 Jun 2021 12:29:57 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id n22sm472559eje.3.2021.06.29.12.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:29:57 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add test for bpf_get_func_ip helper
Date:   Tue, 29 Jun 2021 21:29:45 +0200
Message-Id: <20210629192945.1071862-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629192945.1071862-1-jolsa@kernel.org>
References: <20210629192945.1071862-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test for bpf_get_func_ip helper for fentry, fexit,
kprobe, kretprobe and fmod_ret programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 42 +++++++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 62 +++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
new file mode 100644
index 000000000000..06d34f566bbb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "get_func_ip_test.skel.h"
+
+void test_get_func_ip_test(void)
+{
+	struct get_func_ip_test *skel = NULL;
+	__u32 duration = 0, retval;
+	int err, prog_fd, i;
+	__u64 *result;
+
+	skel = get_func_ip_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open_and_load"))
+		goto cleanup;
+
+	err = get_func_ip_test__attach(skel);
+	if (!ASSERT_OK(err, "get_func_ip_test__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+
+	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+
+	ASSERT_OK(err, "test_run");
+
+	result = (__u64 *)skel->bss;
+	for (i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(result[i], 1, "fentry_result"))
+			break;
+	}
+
+	get_func_ip_test__detach(skel);
+
+cleanup:
+	get_func_ip_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
new file mode 100644
index 000000000000..8ca54390d2b1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_modify_return_test __ksym;
+
+__u64 test1_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test1_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+
+__u64 test2_result = 0;
+SEC("fexit/bpf_fentry_test2")
+int BPF_PROG(test2, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test2_result = (const void *) addr == &bpf_fentry_test2;
+	return 0;
+}
+
+__u64 test3_result = 0;
+SEC("kprobe/bpf_fentry_test3")
+int test3(struct pt_regs *ctx)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test3_result = (const void *) addr == &bpf_fentry_test3;
+	return 0;
+}
+
+__u64 test4_result = 0;
+SEC("kretprobe/bpf_fentry_test4")
+int BPF_KRETPROBE(test4)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test4_result = (const void *) addr == &bpf_fentry_test4;
+	return 0;
+}
+
+__u64 test5_result = 0;
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test5_result = (const void *) addr == &bpf_modify_return_test;
+	return ret;
+}
-- 
2.31.1

