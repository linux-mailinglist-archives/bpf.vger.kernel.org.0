Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC12652B1C
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiLUBtZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 20:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLUBtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 20:49:24 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CF1A3A4
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:49:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671587360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CMkxvb1kdnUo9l1Ly5vI/SD5G+CigXQ6bCGiH5fe5Ng=;
        b=W+LG6JrkTk9z+nahll0q0Fl9IWEYdslk33VL39ucM5ZbQKPcmO4GwGB40VbnuWU9awH4YX
        zrSOXouwLrqPVabCE1VwuALg7MgQ829TyF0CyGum/GEgYVEmdZTh/6PDd6JnDkkSe13BeW
        D8TrKUV9n2cvWufSGOk6zvWbOR0F610=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 bpf] selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL
Date:   Tue, 20 Dec 2022 17:49:14 -0800
Message-Id: <20221221014914.3543155-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

When the bpf_skb_adjust_room() shrinks the skb such that
its csum_start is invalid, the skb->ip_summed should
be reset from CHECKSUM_PARTIAL to CHECKSUM_NONE.

The commit 54c3f1a81421 ("bpf: pull before calling skb_postpull_rcsum()")
fixed it.

This patch adds a test to ensure the skb->ip_summed changed
from CHECKSUM_PARTIAL to CHECKSUM_NONE after bpf_skb_adjust_room().

Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
v2: Add test to DENYLIST.s390x due to kfunc usage

 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../selftests/bpf/prog_tests/decap_sanity.c   | 83 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  6 ++
 .../selftests/bpf/progs/decap_sanity.c        | 68 +++++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/decap_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/decap_sanity.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 585fcf73c731..dba6c027920d 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -86,3 +86,4 @@ xdp_bpf2bpf                              # failed to auto-attach program 'trace_
 xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
 xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
 xfrm_info                                # JIT does not support calling kernel function                                (kfunc)
+decap_sanity                             # JIT does not support calling kernel function                                (kfunc)
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
new file mode 100644
index 000000000000..2fbb3017b740
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/in6.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "decap_sanity.skel.h"
+
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			goto fail;				\
+	})
+
+#define NS_TEST "decap_sanity_ns"
+#define IPV6_IFACE_ADDR "face::1"
+#define UDP_TEST_PORT 7777
+
+void test_decap_sanity(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach);
+	struct nstoken *nstoken = NULL;
+	struct decap_sanity *skel;
+	struct sockaddr_in6 addr;
+	socklen_t addrlen;
+	char buf[128] = {};
+	int sockfd, err;
+
+	skel = decap_sanity__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	SYS("ip netns add %s", NS_TEST);
+	SYS("ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
+	SYS("ip -net %s link set dev lo up", NS_TEST);
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	qdisc_hook.ifindex = if_nametoindex("lo");
+	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
+		goto fail;
+
+	err = bpf_tc_hook_create(&qdisc_hook);
+	if (!ASSERT_OK(err, "create qdisc hook"))
+		goto fail;
+
+	tc_attach.prog_fd = bpf_program__fd(skel->progs.decap_sanity);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach);
+	if (!ASSERT_OK(err, "attach filter"))
+		goto fail;
+
+	addrlen = sizeof(addr);
+	err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
+			    (void *)&addr, &addrlen);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto fail;
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "socket"))
+		goto fail;
+	err = sendto(sockfd, buf, sizeof(buf), 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, sizeof(buf), "send"))
+		goto fail;
+
+	ASSERT_EQ(skel->bss->init_csum_partial, true, "init_csum_partial");
+	ASSERT_EQ(skel->bss->final_csum_none, true, "final_csum_none");
+	ASSERT_EQ(skel->bss->broken_csum_start, false, "broken_csum_start");
+
+fail:
+	if (nstoken)
+		close_netns(nstoken);
+	system("ip netns del " NS_TEST " >& /dev/null");
+	decap_sanity__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index b394817126cf..cfed4df490f3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -50,6 +50,12 @@
 #define ICSK_TIME_LOSS_PROBE	5
 #define ICSK_TIME_REO_TIMEOUT	6
 
+#define ETH_HLEN		14
+#define ETH_P_IPV6		0x86DD
+
+#define CHECKSUM_NONE		0
+#define CHECKSUM_PARTIAL	3
+
 #define IFNAMSIZ		16
 
 #define RTF_GATEWAY		0x0002
diff --git a/tools/testing/selftests/bpf/progs/decap_sanity.c b/tools/testing/selftests/bpf/progs/decap_sanity.c
new file mode 100644
index 000000000000..b85113554cbf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/decap_sanity.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define UDP_TEST_PORT 7777
+
+void *bpf_cast_to_kern_ctx(void *) __ksym;
+bool init_csum_partial = false;
+bool final_csum_none = false;
+bool broken_csum_start = false;
+
+static inline unsigned int skb_headlen(const struct sk_buff *skb)
+{
+	return skb->len - skb->data_len;
+}
+
+static unsigned int skb_headroom(const struct sk_buff *skb)
+{
+	return skb->data - skb->head;
+}
+
+static int skb_checksum_start_offset(const struct sk_buff *skb)
+{
+	return skb->csum_start - skb_headroom(skb);
+}
+
+SEC("tc")
+int decap_sanity(struct __sk_buff *skb)
+{
+	struct sk_buff *kskb;
+	struct ipv6hdr ip6h;
+	struct udphdr udph;
+	int err;
+
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IPV6))
+		return TC_ACT_SHOT;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip6h, sizeof(ip6h)))
+		return TC_ACT_SHOT;
+
+	if (ip6h.nexthdr != IPPROTO_UDP)
+		return TC_ACT_SHOT;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph, sizeof(udph)))
+		return TC_ACT_SHOT;
+
+	if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
+		return TC_ACT_SHOT;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	init_csum_partial = (kskb->ip_summed == CHECKSUM_PARTIAL);
+	err = bpf_skb_adjust_room(skb, -(s32)(ETH_HLEN + sizeof(ip6h) + sizeof(udph)),
+				  1, BPF_F_ADJ_ROOM_FIXED_GSO);
+	if (err)
+		return TC_ACT_SHOT;
+	final_csum_none = (kskb->ip_summed == CHECKSUM_NONE);
+	if (kskb->ip_summed == CHECKSUM_PARTIAL &&
+	    (unsigned int)skb_checksum_start_offset(kskb) >= skb_headlen(kskb))
+		broken_csum_start = true;
+
+	return TC_ACT_SHOT;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.30.2

