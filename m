Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93434A91C8
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 01:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356322AbiBDAzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 19:55:44 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41494 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356316AbiBDAzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 19:55:43 -0500
Received: by mail-wr1-f48.google.com with SMTP id j16so8240033wrd.8;
        Thu, 03 Feb 2022 16:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kU7g6tMkpTj/AU6TPU7JxrwuE+kJFMbSckL9QL5y1sU=;
        b=CfLkkVekrqcfQk26cIQ1Dv9Qzr+8NC16IUlXGGZxR9duwsfygShQiz7Gyn3oCcIcjh
         WsZ1crzXJBevtbQXXEpFbP3aIU35Xmn4BoYd6vjzxEjZMMiOplqyY9IzulJ9XCnvf/vS
         hgsTDa/nCT3zu+nfCnH9mWeTQICqlJeWVJNYp3aVGpLw1pm5YZCX3xcGdmE7okvgXRPB
         szeaJi6O/2CQY6X4iQPkD2bWaak9ROFzho6Eg2AmzjezzCNhhkkTMZ2kkaMSWF2xA7Ou
         TrkOORY24REw65mcMPWifPTfaXuacdwXkGQZeCWYE9IZCe1l7FmGZQxQj32IS433RO9h
         tv/g==
X-Gm-Message-State: AOAM531XXtrGFwJkN7YCRR5i42xbx+2PLgoiqv0mtMzR+xJqO5WJV92v
        0Wxr53Xo1dII3HxDQqnYas8=
X-Google-Smtp-Source: ABdhPJzUphLNSqiWTFVE+GQLHIt9Jj+F9GZyf0Xlq3ZdZ6955J1HL85BRrSGwqzrhWn9SGXQRHkzwQ==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr372663wrr.97.1643936142393;
        Thu, 03 Feb 2022 16:55:42 -0800 (PST)
Received: from t490s.teknoraver.net (net-2-35-22-35.cust.vodafonedsl.it. [2.35.22.35])
        by smtp.gmail.com with ESMTPSA id c8sm240391wmq.34.2022.02.03.16.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:55:41 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: test maximum recursion depth for bpf_core_types_are_compat()
Date:   Fri,  4 Feb 2022 01:55:19 +0100
Message-Id: <20220204005519.60361-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204005519.60361-1-mcroce@linux.microsoft.com>
References: <20220204005519.60361-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

bpf_core_types_are_compat() was limited to 2 recursion levels, which are
enough to parse a function prototype.
Add a test which checks the existence of a function prototype, so to
test the bpf_core_types_are_compat() code path.

The test for the recursion limit being hit is done in a separate object,
because the kernel failure makes the whole load to fail.

Sample run log with extra prints:

	[ 5689.913751] bpf_core_apply_relo_insn:1200 cands->len: 2
	[ 5689.913902] bpf_core_types_are_compat:6896: ret: 1
	[ 5689.913994] bpf_core_types_are_compat:6896: ret: 0
	[ 5689.914025] bpf_core_apply_relo_insn:1200 cands->len: 2
	[ 5689.914141] bpf_core_types_are_compat:6896: ret: 0
	[ 5689.914246] bpf_core_types_are_compat:6896: ret: 0
	test_core_kern_lskel:PASS:open_and_load 0 nsec
	test_core_kern_lskel:PASS:attach(core_relo_proto) 0 nsec
	test_core_kern_lskel:PASS:bpf_core_type_exists 0 nsec
	test_core_kern_lskel:PASS:!bpf_core_type_exists 0 nsec
	#41 core_kern_lskel:OK
	[ 5689.915267] bpf_core_apply_relo_insn:1200 cands->len: 2
	[ 5689.915399] bpf_core_types_are_compat:6896: ret: 0
	[ 5689.915504] bpf_core_types_are_compat:6896: ret: -22
	test_core_kern_overflow_lskel:PASS:open_and_load 0 nsec
	#42 core_kern_overflow_lskel:OK
	Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED
	Successfully unloaded bpf_testmod.ko.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  5 +++++
 .../selftests/bpf/prog_tests/core_kern.c      | 15 ++++++++++++-
 .../bpf/prog_tests/core_kern_overflow.c       | 13 ++++++++++++
 tools/testing/selftests/bpf/progs/core_kern.c | 14 +++++++++++++
 .../selftests/bpf/progs/core_kern_overflow.c  | 21 +++++++++++++++++++
 6 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern_overflow.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_kern_overflow.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 945f92d71db3..91ea729990da 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -330,7 +330,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
-	map_ptr_kern.c core_kern.c
+	map_ptr_kern.c core_kern.c core_kern_overflow.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_subprog.c
 SKEL_BLACKLIST += $$(LSKELS)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 595d32ab285a..e5ba8d8a17da 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -13,6 +13,11 @@
 #define CREATE_TRACE_POINTS
 #include "bpf_testmod-events.h"
 
+typedef int (*func_proto_typedef___match)(long);
+typedef int (*func_proto_typedef___overflow)(func_proto_typedef___match);
+func_proto_typedef___match funcp = NULL;
+func_proto_typedef___overflow funcp_of = NULL;
+
 DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
 
 noinline void
diff --git a/tools/testing/selftests/bpf/prog_tests/core_kern.c b/tools/testing/selftests/bpf/prog_tests/core_kern.c
index 561c5185d886..91493f5836ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_kern.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_kern.c
@@ -7,8 +7,21 @@
 void test_core_kern_lskel(void)
 {
 	struct core_kern_lskel *skel;
+	int link_fd;
 
 	skel = core_kern_lskel__open_and_load();
-	ASSERT_OK_PTR(skel, "open_and_load");
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link_fd = core_kern_lskel__core_relo_proto__attach(skel);
+	if (!ASSERT_GT(link_fd, 0, "attach(core_relo_proto)"))
+		goto cleanup;
+
+	/* trigger tracepoints */
+	usleep(1);
+	ASSERT_TRUE(skel->bss->proto_out[0], "bpf_core_type_exists");
+	ASSERT_FALSE(skel->bss->proto_out[1], "!bpf_core_type_exists");
+
+cleanup:
 	core_kern_lskel__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/core_kern_overflow.c b/tools/testing/selftests/bpf/prog_tests/core_kern_overflow.c
new file mode 100644
index 000000000000..04cc145bc26a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/core_kern_overflow.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "test_progs.h"
+#include "core_kern_overflow.lskel.h"
+
+void test_core_kern_overflow_lskel(void)
+{
+	struct core_kern_overflow_lskel *skel;
+
+	skel = core_kern_overflow_lskel__open_and_load();
+	if (!ASSERT_NULL(skel, "open_and_load"))
+		core_kern_overflow_lskel__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/core_kern.c b/tools/testing/selftests/bpf/progs/core_kern.c
index 13499cc15c7d..acabe4cb0480 100644
--- a/tools/testing/selftests/bpf/progs/core_kern.c
+++ b/tools/testing/selftests/bpf/progs/core_kern.c
@@ -101,4 +101,18 @@ int balancer_ingress(struct __sk_buff *ctx)
 	return 0;
 }
 
+typedef int (*func_proto_typedef___match)(long);
+typedef void (*func_proto_typedef___doesnt_match)(char*);
+
+int proto_out[2];
+
+SEC("raw_tracepoint/sys_enter")
+int core_relo_proto(void *ctx)
+{
+	proto_out[0] = bpf_core_type_exists(func_proto_typedef___match);
+	proto_out[1] = bpf_core_type_exists(func_proto_typedef___doesnt_match);
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/core_kern_overflow.c b/tools/testing/selftests/bpf/progs/core_kern_overflow.c
new file mode 100644
index 000000000000..70417413af55
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/core_kern_overflow.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+typedef int (*func_proto_typedef___match)(long);
+typedef int (*func_proto_typedef___overflow)(func_proto_typedef___match);
+
+int proto_out;
+
+SEC("raw_tracepoint/sys_enter")
+int core_relo_proto(void *ctx)
+{
+	proto_out = bpf_core_type_exists(func_proto_typedef___overflow);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.34.1

