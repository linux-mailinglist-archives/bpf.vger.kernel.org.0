Return-Path: <bpf+bounces-3667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922D7414F0
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 17:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9450280DD2
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8895CD50F;
	Wed, 28 Jun 2023 15:28:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C4D2E3;
	Wed, 28 Jun 2023 15:28:02 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC707268E;
	Wed, 28 Jun 2023 08:28:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qEX5L-00082H-J5; Wed, 28 Jun 2023 17:27:59 +0200
From: Florian Westphal <fw@strlen.de>
To: <bpf@vger.kernel.org>
Cc: "ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, dxu@dxuuu.xyz"@breakpoint.cc,
	<netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add bpf_program__attach_netfilter helper test
Date: Wed, 28 Jun 2023 17:27:38 +0200
Message-Id: <20230628152738.22765-3-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628152738.22765-1-fw@strlen.de>
References: <20230628152738.22765-1-fw@strlen.de>
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
 #145/1   netfilter_link_attach/allzero:OK
 #145/2   netfilter_link_attach/invalid-pf:OK
 #145/3   netfilter_link_attach/invalid-hooknum:OK
 #145/4   netfilter_link_attach/invalid-priority-min:OK
 #145/5   netfilter_link_attach/invalid-priority-max:OK
 #145/6   netfilter_link_attach/invalid-flags:OK
 #145/7   netfilter_link_attach/invalid-inet-not-supported:OK
 #145/8   netfilter_link_attach/attach ipv4:OK
 #145/9   netfilter_link_attach/attach ipv6:OK

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../bpf/prog_tests/netfilter_link_attach.c    | 86 +++++++++++++++++++
 .../bpf/progs/test_netfilter_link_attach.c    | 14 +++
 2 files changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
new file mode 100644
index 000000000000..4297a2a4cb11
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
@@ -0,0 +1,86 @@
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
+	const char * const name;
+};
+
+static const struct nf_link_test nf_hook_link_tests[] = {
+	{ .name = "allzero", },
+	{ .pf = NFPROTO_NUMPROTO, .name = "invalid-pf", },
+	{ .pf = NFPROTO_IPV4, .hooknum = 42, .name = "invalid-hooknum", },
+	{ .pf = NFPROTO_IPV4, .priority = INT_MIN, .name = "invalid-priority-min", },
+	{ .pf = NFPROTO_IPV4, .priority = INT_MAX, .name = "invalid-priority-max", },
+	{ .pf = NFPROTO_IPV4, .flags = UINT_MAX, .name = "invalid-flags", },
+
+	{ .pf = NFPROTO_INET, .priority = 1, .name = "invalid-inet-not-supported", },
+
+	{ .pf = NFPROTO_IPV4, .priority = -10000, .expect_success = true, .name = "attach ipv4", },
+	{ .pf = NFPROTO_IPV6, .priority =  10001, .expect_success = true, .name = "attach ipv6", },
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
+
+		if (!test__start_subtest(nf_hook_link_tests[i].name))
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


