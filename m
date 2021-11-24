Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1B45B6D0
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbhKXIqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 03:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236264AbhKXIpW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 03:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637743333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVPX1C8DkAsQL3LcqECKnIevVpxJ6A8wbBxNyLDX/uc=;
        b=iSfJrEe4vp2c54+oEA0SMoHVQdO3Njpl92JCwOgkvg2+FwbDdPZJnOXz5Px2X8I/10tF3I
        kMbwXGsoK7945HWH8iia43SBH+tDbd/Qab7z3RGXXmi8JVeIiSDqcctrLnik9VFtwbiE8m
        CFB8NMPucnl2gxHynpLUf0kr+vpXPEQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-7lNuhmotNQWiDF537zKz1A-1; Wed, 24 Nov 2021 03:42:12 -0500
X-MC-Unique: 7lNuhmotNQWiDF537zKz1A-1
Received: by mail-wm1-f70.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so969417wmb.3
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 00:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVPX1C8DkAsQL3LcqECKnIevVpxJ6A8wbBxNyLDX/uc=;
        b=tRuMUxEaLCwl9RDVAsL2AKyHpYgU8NvatyZJUQm46FArVmB0nrxlRrS2rKdJaTu6Cs
         2/aUHy2p4IN9ep9FNYrAya9lV4J4LrA9tzNLdm+EOXRSSGZEHdXTfPWVN2E4zYLbqovm
         HiSAN9Ds5797g9Ka7FqfAa5NTtuilrZ4XZEbTwWyGGwF7qSVOwT2KZwcRYtFRq/lBCif
         SiDqaWaxTzGMNKSRmsgZtbtoh10XVcJbBQT3htFlXLGkjSL6iOKvVaSS4OAvYZCD259f
         8ZCW3KUvGMaIPfJFHZVS//uAQ4CWvJAt33fL8JCw3nOEvj+YsOZFmyhkQTMq0Gqf3stH
         jsTQ==
X-Gm-Message-State: AOAM530BQeaOik3VCDgEGuJjXNUeuJcJ42UMpLMX1NzQRV/PXLZXkr6v
        yJVHhd1lV9B0JM6FtAWcU1mD14BYhw3MFcdrWk3+jafxzHp6VBktHsO2emyM0Rt2b5T9sTPO7MV
        mUqlw098O4XHZ
X-Received: by 2002:a5d:508d:: with SMTP id a13mr16396288wrt.41.1637743330683;
        Wed, 24 Nov 2021 00:42:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6/WR79tvkz0a/wesKRWwrirlPIfewyeSdc0r7FwkTqiU7DqPNa47T69UwS0Hg8oKZU/6+Ag==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr16396251wrt.41.1637743330451;
        Wed, 24 Nov 2021 00:42:10 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h27sm4322402wmc.43.2021.11.24.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:42:10 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 8/8] selftest/bpf: Add uprobe multi attach test
Date:   Wed, 24 Nov 2021 09:41:19 +0100
Message-Id: <20211124084119.260239-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124084119.260239-1-jolsa@kernel.org>
References: <20211124084119.260239-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding uprobe multi attach test that uses new interface
to attach multiple probes within single perf event.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/multi_uprobe_test.c        | 97 +++++++++++++++++++
 .../selftests/bpf/progs/multi_uprobe.c        | 26 +++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/multi_uprobe.c

diff --git a/tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c b/tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c
new file mode 100644
index 000000000000..0f939893ef45
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/multi_uprobe_test.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "multi_uprobe.skel.h"
+
+/* this is how USDT semaphore is actually defined, except volatile modifier */
+extern volatile unsigned short uprobe_ref_ctr;
+
+/* attach points */
+static void method0(void) { return ; }
+static void method1(void) { return ; }
+static void method2(void) { return ; }
+static void method3(void) { return ; }
+static void method4(void) { return ; }
+static void method5(void) { return ; }
+static void method6(void) { return ; }
+static void method7(void) { return ; }
+
+void test_multi_uprobe_test(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct bpf_link *uretprobe_link = NULL;
+	struct bpf_link *uprobe_link = NULL;
+	ssize_t base_addr, ref_ctr_offset;
+	struct multi_uprobe *skel;
+	const char *paths[8];
+	int duration = 0;
+	__u64 offs[8];
+
+	skel = multi_uprobe__open_and_load();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+
+	base_addr = get_base_addr();
+	if (CHECK(base_addr < 0, "get_base_addr",
+		  "failed to find base addr: %zd", base_addr))
+		return;
+
+	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
+	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
+		return;
+
+#define INIT(__i)								\
+	do {									\
+		paths[__i] = (const char *) "/proc/self/exe";			\
+		offs[__i]  = get_uprobe_offset(&method ## __i, base_addr);	\
+	} while (0)
+
+	INIT(0);
+	INIT(1);
+	INIT(2);
+	INIT(3);
+	INIT(4);
+	INIT(5);
+	INIT(6);
+	INIT(7);
+
+#undef INIT
+
+	uprobe_opts.multi.paths = paths;
+	uprobe_opts.multi.offs = offs;
+
+	uprobe_opts.multi.cnt = 8;
+
+	uprobe_opts.retprobe = false;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
+						      0 /* self pid */,
+						      NULL, 0,
+						      &uprobe_opts);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
+		goto cleanup;
+
+	uprobe_opts.retprobe = true;
+	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
+							 -1 /* any pid */,
+							 NULL, 0,
+							 &uprobe_opts);
+	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe"))
+		goto cleanup;
+
+	method0();
+	method1();
+	method2();
+	method3();
+	method4();
+	method5();
+	method6();
+	method7();
+
+	ASSERT_EQ(skel->bss->test_uprobe_result, 8, "test_uprobe_result");
+	ASSERT_EQ(skel->bss->test_uretprobe_result, 8, "test_uretprobe_result");
+
+cleanup:
+	bpf_link__destroy(uretprobe_link);
+	bpf_link__destroy(uprobe_link);
+	multi_uprobe__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/multi_uprobe.c b/tools/testing/selftests/bpf/progs/multi_uprobe.c
new file mode 100644
index 000000000000..831f7b98baef
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/multi_uprobe.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 test_uprobe_result = 0;
+
+SEC("uprobe/trigger_func")
+int handle_uprobe(struct pt_regs *ctx)
+{
+	test_uprobe_result++;
+	return 0;
+}
+
+__u64 test_uretprobe_result = 0;
+
+SEC("uretprobe/trigger_func")
+int handle_uretprobe(struct pt_regs *ctx)
+{
+	test_uretprobe_result++;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.33.1

