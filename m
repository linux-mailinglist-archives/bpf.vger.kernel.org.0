Return-Path: <bpf+bounces-3564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F056773FB93
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 14:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAFC1C20AF2
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 12:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0615182AA;
	Tue, 27 Jun 2023 11:59:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB417FE6;
	Tue, 27 Jun 2023 11:59:17 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFDE199C;
	Tue, 27 Jun 2023 04:59:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qE7Le-0003gp-8D; Tue, 27 Jun 2023 13:59:06 +0200
From: Florian Westphal <fw@strlen.de>
To: <bpf@vger.kernel.org>
Cc: dxu@dxuuu.xyz,
	qde@naccy.de,
	netdev@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add bpf_program__attach_netfilter helper test
Date: Tue, 27 Jun 2023 13:58:39 +0200
Message-Id: <20230627115839.1034-3-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230627115839.1034-1-fw@strlen.de>
References: <20230627115839.1034-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=ANY_BOUNCE_MESSAGE,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,VBOUNCE_MESSAGE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Call bpf_program__attach_netfilter() with different
protocol/hook/priority combinations.

Test fails if supposedly-illegal attachments work
(e.g., bogus protocol family, illegal priority and so on) or if a
should-work attachment fails.  Expected output:

 ./test_progs -t netfilter_link_attach
 #145/1   netfilter_link_attach/netfilter link attach 0:OK
 #145/2   netfilter_link_attach/netfilter link attach 1:OK
 #145/3   netfilter_link_attach/netfilter link attach 2:OK
 #145/4   netfilter_link_attach/netfilter link attach 3:OK
 #145/5   netfilter_link_attach/netfilter link attach 4:OK
 #145/6   netfilter_link_attach/netfilter link attach 5:OK
 #145/7   netfilter_link_attach/netfilter link attach 6:OK
 #145/8   netfilter_link_attach/netfilter link attach 7:OK
 #145/9   netfilter_link_attach/netfilter link attach 8:OK
 #145     netfilter_link_attach:OK

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../bpf/prog_tests/netfilter_link_attach.c    | 88 +++++++++++++++++++
 .../bpf/progs/test_netfilter_link_attach.c    | 14 +++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
new file mode 100644
index 000000000000..dfec6c44f81d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <netinet/in.h>
+#include <linux/netfilter.h>
+
+#include "test_progs.h"
+#include "test_netfilter_link_attach.skel.h"
+
+struct nf_link_test {
+	__u32 pf;
+	__u32 hooknum;
+	__s32 priority;
+	__u32 flags;
+
+	bool expect_success;
+};
+
+struct nf_link_test nf_hook_link_tests[] = {
+	{  },
+	{ .pf = NFPROTO_NUMPROTO, },
+	{ .pf = NFPROTO_IPV4, .hooknum = 42, },
+	{ .pf = NFPROTO_IPV4, .priority = INT_MIN },
+	{ .pf = NFPROTO_IPV4, .priority = INT_MAX },
+	{ .pf = NFPROTO_IPV4, .flags = UINT_MAX },
+
+	{ .pf = NFPROTO_INET, .priority = 1, },
+
+	{ .pf = NFPROTO_IPV4, .priority = -10000, .expect_success = true },
+	{ .pf = NFPROTO_IPV6, .priority = 10001, .expect_success = true },
+};
+
+void test_netfilter_link_attach(void)
+{
+	struct test_netfilter_link_attach *skel;
+	struct bpf_program *prog;
+	LIBBPF_OPTS(bpf_netfilter_opts, opts);
+	int i;
+
+	skel = test_netfilter_link_attach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_netfilter_link_attach__open_and_load"))
+		goto out;
+
+	prog = skel->progs.nf_link_attach_test;
+	if (!ASSERT_OK_PTR(prog, "attach program"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(nf_hook_link_tests); i++) {
+		struct bpf_link *link;
+		char name[128];
+
+		snprintf(name, sizeof(name), "netfilter link attach %u", i);
+
+		if (!test__start_subtest(name))
+			continue;
+
+#define X(opts, m, i)	opts.m = nf_hook_link_tests[(i)].m
+		X(opts, pf, i);
+		X(opts, hooknum, i);
+		X(opts, priority, i);
+		X(opts, flags, i);
+#undef X
+		link = bpf_program__attach_netfilter(prog, &opts);
+		if (nf_hook_link_tests[i].expect_success) {
+			struct bpf_link *link2;
+
+			if (!ASSERT_OK_PTR(link, "program attach successful"))
+				continue;
+
+			link2 = bpf_program__attach_netfilter(prog, &opts);
+			ASSERT_ERR_PTR(link2, "attach program with same pf/hook/priority");
+
+			if (!ASSERT_OK(bpf_link__destroy(link), "link destroy"))
+				break;
+
+			link2 = bpf_program__attach_netfilter(prog, &opts);
+			if (!ASSERT_OK_PTR(link2, "program reattach successful"))
+				continue;
+			if (!ASSERT_OK(bpf_link__destroy(link2), "link destroy"))
+				break;
+		} else {
+			ASSERT_ERR_PTR(link, "program load failure");
+		}
+	}
+
+out:
+	test_netfilter_link_attach__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c b/tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
new file mode 100644
index 000000000000..03a475160abe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#define NF_ACCEPT 1
+
+SEC("netfilter")
+int nf_link_attach_test(struct bpf_nf_ctx *ctx)
+{
+	return NF_ACCEPT;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.3


