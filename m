Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BD632BB2
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKUSDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiKUSDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 13:03:47 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9469C5CD33
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:03:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 11-20020a63000b000000b004776fe2eebfso1932825pga.9
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQxXS5ieRy+QMFlCt9c91csphauj8BgoyeTYPTtQ0YA=;
        b=H2mjkrkMA1lGekAvFyDJsbheL4kYYXi8BVh2MCXn3BWVcV9zMyE0w3BTIIEci6qqcQ
         gMtkTiES+6/axtGw2guEJ+IU9UfaDkxV1bEJIz/uJ3zOUfLAhBNVSDKywZAxx6eWXyuA
         oVFrOQsklmhaZzzxlBxd5WrRZCJOQ/9ikk+LxTWzdVSLWvJvbNuER4/RVxNuHoapMOEE
         msA9e3BD9Pr+1uonqcZHLw8L4yZAwgWqbNFePKMwfY3ucWcAa1XN5WQtQ/Rf2SoDqVC9
         HcmpZ/EXGAtR6JEwzrHWL0+RtxkcTnLYn6UdndW2sjlkhgg5KGfnbnyzht8Zk5i/LJpE
         VIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQxXS5ieRy+QMFlCt9c91csphauj8BgoyeTYPTtQ0YA=;
        b=ULel58K9VtKLgd4dhvrJbZJImf1qNg3HA8UG1i1IoZ48jliJ9T2WOIYwLJLC0hZC7r
         sQgcMxpt4gFCh8kkZeIsr0a7ssJaaPnJA0e8jMIFKAo8ylXzvRgi+0jKpj3nAqLvMn2p
         il3WRobs3QbxK18UcZrAlAAFogbula/Z8s05AKsIXJbZ9r8ci+RF10JO5Nm+sy6+2QPK
         LnlLI+tCsmO7jf+aVNU/eH8a8H5A5hLQBu4Gt0u4DBY5v+GgGf2hwyxyMPDKn5Tz5Q6w
         tP05DwaPTNZ067KptUZJIiw/g1822CKcRKa6VcmfgAidOt8/s/IpvXYnPXvLWeb2SfeE
         U2XQ==
X-Gm-Message-State: ANoB5plf3BISXaNYhqDnkGIcsegUSRs4cW8cIn6DSbCrCspD6rRusL1n
        9F6jBv1TnUyZA2udcD3o7knsKmUop2fGg/GcnzzaDCpOjtu8iuuTEUkptPVbPx2M/mVsCeDq7ed
        k1TMYDfow9KudnESrkoK3Dne1YnTko7q1oI1rSdjrihXSbaIPOg==
X-Google-Smtp-Source: AA0mqf6ea6YY9wRgvRvSBXbwUp1EDX8o3SoXAhZ7HsQMpmve7tAwT8y3nS0F37VQ9/epE5SuXvHg5Xo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:cf81:0:b0:56b:add7:fe2f with SMTP id
 b123-20020a62cf81000000b0056badd7fe2fmr1372292pfg.51.1669053822973; Mon, 21
 Nov 2022 10:03:42 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:03:40 -0800
In-Reply-To: <20221121180340.1983627-1-sdf@google.com>
Mime-Version: 1.0
References: <20221121180340.1983627-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121180340.1983627-2-sdf@google.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs aren't redirectable
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LWT_XMIT to test L3 case, TC to test L2 case.

v2:
- s/veth_ifindex/ipip_ifindex/ in two places (Martin)
- add comment about which condition triggers the rejection (Martin)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/empty_skb.c      | 146 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
 2 files changed, 183 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/empty_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
new file mode 100644
index 000000000000..32dd731e9070
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <net/if.h>
+#include "empty_skb.skel.h"
+
+#define SYS(cmd) ({ \
+	if (!ASSERT_OK(system(cmd), (cmd))) \
+		goto out; \
+})
+
+void test_empty_skb(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, tattr);
+	struct empty_skb *bpf_obj = NULL;
+	struct nstoken *tok = NULL;
+	struct bpf_program *prog;
+	char eth_hlen_pp[15];
+	char eth_hlen[14];
+	int veth_ifindex;
+	int ipip_ifindex;
+	int err;
+	int i;
+
+	struct {
+		const char *msg;
+		const void *data_in;
+		__u32 data_size_in;
+		int *ifindex;
+		int err;
+		int ret;
+		bool success_on_tc;
+	} tests[] = {
+		/* Empty packets are always rejected. */
+
+		{
+			/* BPF_PROG_RUN ETH_HLEN size check */
+			.msg = "veth empty ingress packet",
+			.data_in = NULL,
+			.data_size_in = 0,
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+		},
+		{
+			/* BPF_PROG_RUN ETH_HLEN size check */
+			.msg = "ipip empty ingress packet",
+			.data_in = NULL,
+			.data_size_in = 0,
+			.ifindex = &ipip_ifindex,
+			.err = -EINVAL,
+		},
+
+		/* ETH_HLEN-sized packets:
+		 * - can not be redirected at LWT_XMIT
+		 * - can be redirected at TC to non-tunneling dest
+		 */
+
+		{
+			/* __bpf_redirect_common */
+			.msg = "veth ETH_HLEN packet ingress",
+			.data_in = eth_hlen,
+			.data_size_in = sizeof(eth_hlen),
+			.ifindex = &veth_ifindex,
+			.ret = -ERANGE,
+			.success_on_tc = true,
+		},
+		{
+			/* __bpf_redirect_no_mac
+			 *
+			 * lwt: skb->len=0 <= skb_network_offset=0
+			 * tc: skb->len=14 <= skb_network_offset=14
+			 */
+			.msg = "ipip ETH_HLEN packet ingress",
+			.data_in = eth_hlen,
+			.data_size_in = sizeof(eth_hlen),
+			.ifindex = &ipip_ifindex,
+			.ret = -ERANGE,
+		},
+
+		/* ETH_HLEN+1-sized packet should be redirected. */
+
+		{
+			.msg = "veth ETH_HLEN+1 packet ingress",
+			.data_in = eth_hlen_pp,
+			.data_size_in = sizeof(eth_hlen_pp),
+			.ifindex = &veth_ifindex,
+		},
+		{
+			.msg = "ipip ETH_HLEN+1 packet ingress",
+			.data_in = eth_hlen_pp,
+			.data_size_in = sizeof(eth_hlen_pp),
+			.ifindex = &ipip_ifindex,
+		},
+	};
+
+	SYS("ip netns add empty_skb");
+	tok = open_netns("empty_skb");
+	SYS("ip link add veth0 type veth peer veth1");
+	SYS("ip link set dev veth0 up");
+	SYS("ip link set dev veth1 up");
+	SYS("ip addr add 10.0.0.1/8 dev veth0");
+	SYS("ip addr add 10.0.0.2/8 dev veth1");
+	veth_ifindex = if_nametoindex("veth0");
+
+	SYS("ip link add ipip0 type ipip local 10.0.0.1 remote 10.0.0.2");
+	SYS("ip link set ipip0 up");
+	SYS("ip addr add 192.168.1.1/16 dev ipip0");
+	ipip_ifindex = if_nametoindex("ipip0");
+
+	bpf_obj = empty_skb__open_and_load();
+	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		bpf_object__for_each_program(prog, bpf_obj->obj) {
+			char buf[128];
+			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
+
+			tattr.data_in = tests[i].data_in;
+			tattr.data_size_in = tests[i].data_size_in;
+
+			tattr.data_size_out = 0;
+			bpf_obj->bss->ifindex = *tests[i].ifindex;
+			bpf_obj->bss->ret = 0;
+			err = bpf_prog_test_run_opts(bpf_program__fd(prog), &tattr);
+			sprintf(buf, "err: %s [%s]", tests[i].msg, bpf_program__name(prog));
+
+			if (at_tc && tests[i].success_on_tc)
+				ASSERT_GE(err, 0, buf);
+			else
+				ASSERT_EQ(err, tests[i].err, buf);
+			sprintf(buf, "ret: %s [%s]", tests[i].msg, bpf_program__name(prog));
+			if (at_tc && tests[i].success_on_tc)
+				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
+			else
+				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
+		}
+	}
+
+out:
+	if (bpf_obj)
+		empty_skb__destroy(bpf_obj);
+	if (tok)
+		close_netns(tok);
+	system("ip netns del empty_skb");
+}
diff --git a/tools/testing/selftests/bpf/progs/empty_skb.c b/tools/testing/selftests/bpf/progs/empty_skb.c
new file mode 100644
index 000000000000..4b0cd6753251
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/empty_skb.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+char _license[] SEC("license") = "GPL";
+
+int ifindex;
+int ret;
+
+SEC("lwt_xmit")
+int redirect_ingress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
+	return 0;
+}
+
+SEC("lwt_xmit")
+int redirect_egress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, 0);
+	return 0;
+}
+
+SEC("tc")
+int tc_redirect_ingress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, BPF_F_INGRESS);
+	return 0;
+}
+
+SEC("tc")
+int tc_redirect_egress(struct __sk_buff *skb)
+{
+	ret = bpf_clone_redirect(skb, ifindex, 0);
+	return 0;
+}
-- 
2.38.1.584.g0f3c55d4c2-goog

