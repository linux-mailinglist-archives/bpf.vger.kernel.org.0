Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7BC3C81F7
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhGNJri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 05:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238958AbhGNJri (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626255886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=at0v+SiznMJ5rgxjJyNt+4zpti6KLDNE/wwHxHtwGZM=;
        b=aZAkyhOfN0u/NYi8A5rH9ZdPXzTcfBcG0R8gzR7etiiGoxa0ifkcQH20yvnNQupU1R2zbP
        GAfOb85cGmTf8UvvCZG/x+/iY7dpSEe1WxTR3wKQyLLxzKSENx8cNb6fLHq3gsf4g3zxiQ
        9/cCiD3jUDOQ9oWHcUJoNgYXG/OcqAQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-4n95ckyIN0afyZY_5TlsYg-1; Wed, 14 Jul 2021 05:44:45 -0400
X-MC-Unique: 4n95ckyIN0afyZY_5TlsYg-1
Received: by mail-wr1-f70.google.com with SMTP id g9-20020adff3c90000b0290140a25efc6dso1232637wrp.5
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 02:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=at0v+SiznMJ5rgxjJyNt+4zpti6KLDNE/wwHxHtwGZM=;
        b=GV65t6D/OEViY6kdioyC5bgN26qR/zBZJOa0/6DVZDSTd2v3MEvcxDAooQ9zW7ixyD
         ZzjqeAPzov5AGugzgrt6LK7P9CtRwiZsj1+HqxWPxnufXGZFq44WSG6PCAa5p3tAYvYy
         blVTnBr5Zs5FcoPeum5rDy5ZAOj98hb4/jZL7i0fSBFLDjfbAFDkeyn0HLsTkrPJm+Fv
         th1KDxEZiEVVge7Y33nk+kZwVi2JuLZS/ebOvvZfAcydVFb4wVduDPRbvr4s2YOtytvv
         UgpDz8DOFDZlxl5FbkK0t9VoxE8KzIQrevAVsT0p69LIZTiUokyqJfYLSSRtGzbGkB8v
         dHjA==
X-Gm-Message-State: AOAM530jW6BgfElrV977dHyAsQqCfXUpXsvamw+iK0PIt1/R3gDs5vrw
        CgQjj6Ak0IE3Rpc7RAEtDRIGgcILUgPkdmc8uvOeoPMrKWncJTgheveXA+NdiOgSktbATZymZpR
        gE1AWJjks5PN7
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr11988508wrs.170.1626255884072;
        Wed, 14 Jul 2021 02:44:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6N/hErFIrqsMzdSYW/RV4Olk1siG+GOQcYgq66khqzMit1bnG7E/QCI5/JqG0eik2ujfURA==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr11988487wrs.170.1626255883950;
        Wed, 14 Jul 2021 02:44:43 -0700 (PDT)
Received: from krava.redhat.com ([5.171.203.6])
        by smtp.gmail.com with ESMTPSA id f82sm4654191wmf.25.2021.07.14.02.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:44:43 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv4 bpf-next 5/8] selftests/bpf: Add test for bpf_get_func_ip helper
Date:   Wed, 14 Jul 2021 11:43:57 +0200
Message-Id: <20210714094400.396467-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714094400.396467-1-jolsa@kernel.org>
References: <20210714094400.396467-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test for bpf_get_func_ip helper for fentry, fexit,
kprobe, kretprobe and fmod_ret programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 39 ++++++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 62 +++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
new file mode 100644
index 000000000000..8bb18a8d31a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "get_func_ip_test.skel.h"
+
+void test_get_func_ip_test(void)
+{
+	struct get_func_ip_test *skel = NULL;
+	__u32 duration = 0, retval;
+	int err, prog_fd;
+
+	skel = get_func_ip_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open_and_load"))
+		return;
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
+	prog_fd = bpf_program__fd(skel->progs.test5);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
+	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
+	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
+	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
+
+cleanup:
+	get_func_ip_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
new file mode 100644
index 000000000000..ba3e107b52dd
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
+int BPF_PROG(test5, int a, int *b, int ret)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test5_result = (const void *) addr == &bpf_modify_return_test;
+	return ret;
+}
-- 
2.31.1

