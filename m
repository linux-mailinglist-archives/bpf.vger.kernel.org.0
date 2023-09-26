Return-Path: <bpf+bounces-10852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEEE7AE56A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2DA141F254B9
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 06:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347AA4C92;
	Tue, 26 Sep 2023 05:59:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040C538A;
	Tue, 26 Sep 2023 05:59:48 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741A3D6;
	Mon, 25 Sep 2023 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BIZVqZRaNiAC0t8PNEMpLHnLPep96YivTv7Xa2TuOeY=; b=JQ+7ZvmBALoX12aaGIfLq1YTi4
	NGeAp25bz6ZiVspNKG2YQYgqrdgd7HRUcjTfCKz6LA4WlqLaUV9ymu6gWkTOYUVwqNWwrO/a0Whql
	qdSZKUSfE/Gg9LcQE9BV/54v+HKnEod1OFFXmKjXjyZM9kriuzGfizWIK2q7TYuBWU8aubkWw3AcQ
	7Eo6E+9enQ6ol8zkA+Eg7utik5n/wHiL0GGigv7N6vd0j0W7YXCcUsVVlcj/J9C7dnrqqHaNElQvL
	Zjl3ioA6IHD1AX8U5nuItLgAcG9tZh5HxjcVF/L025hCiUV0YkeZl1aTMHtMVE4W5u6wgXInZm4dR
	YGcnFcEQ==;
Received: from mob-194-230-148-205.cgn.sunrise.net ([194.230.148.205] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ql16k-0006of-1I; Tue, 26 Sep 2023 07:59:42 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@kernel.org,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add selftests for meta
Date: Tue, 26 Sep 2023 07:59:13 +0200
Message-Id: <20230926055913.9859-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230926055913.9859-1-daniel@iogearbox.net>
References: <20230926055913.9859-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27042/Mon Sep 25 09:37:53 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a bigger batch of test coverage to assert correct operation of
meta device and its BPF program management:

  # ./vmtest.sh -- ./test_progs -t tc_meta
  [...]
  ./test_progs -t tc_meta
  [    1.211407] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.211805] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  [    1.271692] tsc: Refined TSC clocksource calibration: 3407.989 MHz
  [    1.274015] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc9c9451, max_idle_ns: 440795361646 ns
  [    1.275241] clocksource: Switched to clocksource tsc
  #255     tc_meta_basic:OK
  #256     tc_meta_device:OK
  #257     tc_meta_multi_links:OK
  #258     tc_meta_multi_opts:OK
  #259     tc_meta_neigh_links:OK
  Summary: 5/0 PASSED, 0 SKIPPED, 0 FAILED
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/tc_helpers.h     |   4 +
 .../selftests/bpf/prog_tests/tc_meta.c        | 650 ++++++++++++++++++
 .../selftests/bpf/progs/test_tc_link.c        |  13 +
 4 files changed, 668 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_meta.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index e41eb33b2704..c00bac17dace 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -43,6 +43,7 @@ CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
+CONFIG_META=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
index 6c93215be8a3..03dbb10918ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/tc_helpers.h
@@ -4,6 +4,10 @@
 #define TC_HELPERS
 #include <test_progs.h>
 
+#ifndef loopback
+# define loopback 1
+#endif
+
 static inline __u32 id_from_prog_fd(int fd)
 {
 	struct bpf_prog_info prog_info = {};
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_meta.c b/tools/testing/selftests/bpf/prog_tests/tc_meta.c
new file mode 100644
index 000000000000..c528fcedd519
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_meta.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+#include <uapi/linux/if_link.h>
+#include <net/if.h>
+#include <test_progs.h>
+
+#define meta_peer "m0"
+#define meta_name "m1"
+
+#define ping_addr_neigh		0x0a000002 /* 10.0.0.2 */
+#define ping_addr_noneigh	0x0a000003 /* 10.0.0.3 */
+
+#include "test_tc_link.skel.h"
+#include "netlink_helpers.h"
+#include "tc_helpers.h"
+
+#define ICMP_ECHO 8
+
+struct icmphdr {
+	__u8		type;
+	__u8		code;
+	__sum16		checksum;
+	struct {
+		__be16	id;
+		__be16	sequence;
+	} echo;
+};
+
+struct iplink_req {
+	struct nlmsghdr  n;
+	struct ifinfomsg i;
+	char             buf[1024];
+};
+
+static int create_meta(int mode, int policy, int peer_policy, int *ifindex,
+		       bool same_netns)
+{
+	struct rtnl_handle rth = { .fd = -1 };
+	struct iplink_req req = {};
+	struct rtattr *linkinfo, *data;
+	const char *type = "meta";
+	int err;
+
+	err = rtnl_open(&rth, 0);
+	if (!ASSERT_OK(err, "open_rtnetlink"))
+		return err;
+
+	memset(&req, 0, sizeof(req));
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+	req.n.nlmsg_type = RTM_NEWLINK;
+	req.i.ifi_family = AF_UNSPEC;
+
+	addattr_l(&req.n, sizeof(req), IFLA_IFNAME, meta_name,
+		  strlen(meta_name));
+	linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
+	addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type));
+	data = addattr_nest(&req.n, sizeof(req), IFLA_INFO_DATA);
+	addattr32(&req.n, sizeof(req), IFLA_META_POLICY, policy);
+	addattr32(&req.n, sizeof(req), IFLA_META_PEER_POLICY, peer_policy);
+	addattr32(&req.n, sizeof(req), IFLA_META_MODE, mode);
+	addattr_nest_end(&req.n, data);
+	addattr_nest_end(&req.n, linkinfo);
+
+	err = rtnl_talk(&rth, &req.n, NULL);
+	ASSERT_OK(err, "talk_rtnetlink");
+	rtnl_close(&rth);
+	*ifindex = if_nametoindex(meta_name);
+
+	ASSERT_GT(*ifindex, 0, "retrieve_ifindex");
+	ASSERT_OK(system("ip netns add foo"), "create netns");
+	ASSERT_OK(system("ip link set dev " meta_name " up"),
+			 "up primary");
+	ASSERT_OK(system("ip addr add dev " meta_name " 10.0.0.1/24"),
+			 "addr primary");
+	if (same_netns) {
+		ASSERT_OK(system("ip link set dev " meta_peer " up"),
+				 "up peer");
+		ASSERT_OK(system("ip addr add dev " meta_peer " 10.0.0.2/24"),
+				 "addr peer");
+	} else {
+		ASSERT_OK(system("ip link set " meta_peer " netns foo"),
+				 "move peer");
+		ASSERT_OK(system("ip netns exec foo ip link set dev "
+				 meta_peer " up"), "up peer");
+		ASSERT_OK(system("ip netns exec foo ip addr add dev "
+				 meta_peer " 10.0.0.2/24"), "addr peer");
+	}
+	return err;
+}
+
+static void destroy_meta(void)
+{
+	ASSERT_OK(system("ip link del dev " meta_name), "del primary");
+	ASSERT_OK(system("ip netns del foo"), "delete netns");
+	ASSERT_EQ(if_nametoindex(meta_name), 0, meta_name "_ifindex");
+}
+
+static int __send_icmp(__u32 dest)
+{
+	struct sockaddr_in addr;
+	struct icmphdr icmp;
+	int sock, ret;
+
+	ret = write_sysctl("/proc/sys/net/ipv4/ping_group_range", "0 0");
+	if (!ASSERT_OK(ret, "write_sysctl(net.ipv4.ping_group_range)"))
+		return ret;
+
+	sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+	if (!ASSERT_GE(sock, 0, "icmp_socket"))
+		return -errno;
+
+	ret = setsockopt(sock, SOL_SOCKET, SO_BINDTODEVICE,
+			 meta_name, strlen(meta_name) + 1);
+	if (!ASSERT_OK(ret, "setsockopt(SO_BINDTODEVICE)"))
+		goto out;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(dest);
+
+	memset(&icmp, 0, sizeof(icmp));
+	icmp.type = ICMP_ECHO;
+	icmp.echo.id = 1234;
+	icmp.echo.sequence = 1;
+
+	ret = sendto(sock, &icmp, sizeof(icmp), 0,
+		     (struct sockaddr *)&addr, sizeof(addr));
+	if (!ASSERT_GE(ret, 0, "icmp_sendto"))
+		ret = -errno;
+	else
+		ret = 0;
+out:
+	close(sock);
+	return ret;
+}
+
+static int send_icmp(void)
+{
+	return __send_icmp(ping_addr_neigh);
+}
+
+void serial_test_tc_meta_basic(void)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	LIBBPF_OPTS(bpf_meta_opts, optl);
+	__u32 prog_ids[2], link_ids[2];
+	__u32 pid1, pid2, lid1, lid2;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex;
+
+	err = create_meta(META_L2, META_PASS, META_PASS, &ifindex, false);
+	if (err)
+		return;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	link = bpf_program__attach_meta(skel->progs.tc1, ifindex, false, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, BPF_META_PRIMARY, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	link = bpf_program__attach_meta(skel->progs.tc2, ifindex, true, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+	ASSERT_NEQ(lid1, lid2, "link_ids_1_2");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_tc2 = false;
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 1);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, BPF_META_PEER, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid2, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid2, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+	destroy_meta();
+}
+
+void serial_test_tc_meta_multi_links_target(int mode, int target)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	LIBBPF_OPTS(bpf_meta_opts, optl);
+	__u32 prog_ids[3], link_ids[3];
+	__u32 pid1, pid2, lid1, lid2;
+	bool peer = target == BPF_META_PEER;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex;
+
+	err = create_meta(mode, META_PASS, META_PASS, &ifindex, false);
+	if (err)
+		return;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, false, "seen_eth");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	link = bpf_program__attach_meta(skel->progs.tc1, ifindex, peer, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, true, "seen_eth");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	LIBBPF_OPTS_RESET(optl,
+		.flags = BPF_F_BEFORE,
+		.relative_fd = bpf_program__fd(skel->progs.tc1),
+	);
+
+	link = bpf_program__attach_meta(skel->progs.tc2, ifindex, peer, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc2 = link;
+
+	lid2 = id_from_link_fd(bpf_link__fd(skel->links.tc2));
+	ASSERT_NEQ(lid1, lid2, "link_ids_1_2");
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_eth = false;
+	skel->bss->seen_tc2 = false;
+
+	assert_mprog_count_ifindex(ifindex, target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid2, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid2, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], lid1, "link_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+	ASSERT_EQ(optq.link_ids[2], 0, "link_ids[2]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, true, "seen_eth");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+	destroy_meta();
+}
+
+void serial_test_tc_meta_multi_links(void)
+{
+	serial_test_tc_meta_multi_links_target(META_L2, BPF_META_PRIMARY);
+	serial_test_tc_meta_multi_links_target(META_L3, BPF_META_PRIMARY);
+	serial_test_tc_meta_multi_links_target(META_L2, BPF_META_PEER);
+	serial_test_tc_meta_multi_links_target(META_L3, BPF_META_PEER);
+}
+
+void serial_test_tc_meta_multi_opts_target(int mode, int target)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	__u32 pid1, pid2, fd1, fd2;
+	__u32 prog_ids[3];
+	struct test_tc_link *skel;
+	int err, ifindex;
+
+	err = create_meta(mode, META_PASS, META_PASS, &ifindex, false);
+	if (err)
+		return;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	fd1 = bpf_program__fd(skel->progs.tc1);
+	fd2 = bpf_program__fd(skel->progs.tc2);
+
+	pid1 = id_from_prog_fd(fd1);
+	pid2 = id_from_prog_fd(fd2);
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, false, "seen_eth");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	err = bpf_prog_attach_opts(fd1, ifindex, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup;
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+
+	optq.prog_ids = prog_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_fd1;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, true, "seen_eth");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	LIBBPF_OPTS_RESET(opta,
+		.flags = BPF_F_BEFORE,
+		.relative_fd = fd1,
+	);
+
+	err = bpf_prog_attach_opts(fd2, ifindex, target, &opta);
+	if (!ASSERT_EQ(err, 0, "prog_attach"))
+		goto cleanup_fd1;
+
+	skel->bss->seen_tc1 = false;
+	skel->bss->seen_eth = false;
+	skel->bss->seen_tc2 = false;
+
+	assert_mprog_count_ifindex(ifindex, target, 2);
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup_fd2;
+
+	ASSERT_EQ(optq.count, 2, "count");
+	ASSERT_EQ(optq.revision, 3, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid2, "prog_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], pid1, "prog_ids[1]");
+	ASSERT_EQ(optq.prog_ids[2], 0, "prog_ids[2]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, true, "seen_eth");
+	ASSERT_EQ(skel->bss->seen_tc2, true, "seen_tc2");
+
+cleanup_fd2:
+	err = bpf_prog_detach_opts(fd2, ifindex, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count_ifindex(ifindex, target, 1);
+cleanup_fd1:
+	err = bpf_prog_detach_opts(fd1, ifindex, target, &optd);
+	ASSERT_OK(err, "prog_detach");
+	assert_mprog_count_ifindex(ifindex, target, 0);
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+	destroy_meta();
+}
+
+void serial_test_tc_meta_multi_opts(void)
+{
+	serial_test_tc_meta_multi_opts_target(META_L2, BPF_META_PRIMARY);
+	serial_test_tc_meta_multi_opts_target(META_L3, BPF_META_PRIMARY);
+	serial_test_tc_meta_multi_opts_target(META_L2, BPF_META_PEER);
+	serial_test_tc_meta_multi_opts_target(META_L3, BPF_META_PEER);
+}
+
+void serial_test_tc_meta_device(void)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	LIBBPF_OPTS(bpf_meta_opts, optl);
+	__u32 prog_ids[2], link_ids[2];
+	__u32 pid1, pid2, lid1;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex, ifindex2;
+
+	err = create_meta(META_L3, META_PASS, META_PASS, &ifindex, true);
+	if (err)
+		return;
+
+	ifindex2 = if_nametoindex(meta_peer);
+	ASSERT_NEQ(ifindex, ifindex2, "ifindex_1_2");
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+	pid2 = id_from_prog_fd(bpf_program__fd(skel->progs.tc2));
+
+	ASSERT_NEQ(pid1, pid2, "prog_ids_1_2");
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	link = bpf_program__attach_meta(skel->progs.tc1, ifindex, false, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, BPF_META_PRIMARY, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_EQ(send_icmp(), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_tc2, false, "seen_tc2");
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex2, BPF_META_PRIMARY, &optq);
+	ASSERT_EQ(err, -EACCES, "prog_query_should_fail");
+
+	err = bpf_prog_query_opts(ifindex2, BPF_META_PEER, &optq);
+	ASSERT_EQ(err, -EACCES, "prog_query_should_fail");
+
+	link = bpf_program__attach_meta(skel->progs.tc2, ifindex2, true, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	link = bpf_program__attach_meta(skel->progs.tc2, ifindex2, false, &optl);
+	if (!ASSERT_ERR_PTR(link, "link_attach_should_fail")) {
+		bpf_link__destroy(link);
+		goto cleanup;
+	}
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 1);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex, BPF_META_PRIMARY, 0);
+	assert_mprog_count_ifindex(ifindex, BPF_META_PEER, 0);
+	destroy_meta();
+}
+
+void serial_test_tc_meta_neigh_links_target(int mode, int target)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, optq);
+	LIBBPF_OPTS(bpf_meta_opts, optl);
+	__u32 prog_ids[2], link_ids[2];
+	__u32 pid1, lid1;
+	struct test_tc_link *skel;
+	struct bpf_link *link;
+	int err, ifindex;
+
+	err = create_meta(mode, META_PASS, META_PASS, &ifindex, false);
+	if (err)
+		return;
+
+	skel = test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
+
+	pid1 = id_from_prog_fd(bpf_program__fd(skel->progs.tc1));
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+
+	ASSERT_EQ(skel->bss->seen_tc1, false, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, false, "seen_eth");
+
+	link = bpf_program__attach_meta(skel->progs.tc1, ifindex, false, &optl);
+	if (!ASSERT_OK_PTR(link, "link_attach"))
+		goto cleanup;
+
+	skel->links.tc1 = link;
+
+	lid1 = id_from_link_fd(bpf_link__fd(skel->links.tc1));
+
+	assert_mprog_count_ifindex(ifindex, target, 1);
+
+	optq.prog_ids = prog_ids;
+	optq.link_ids = link_ids;
+
+	memset(prog_ids, 0, sizeof(prog_ids));
+	memset(link_ids, 0, sizeof(link_ids));
+	optq.count = ARRAY_SIZE(prog_ids);
+
+	err = bpf_prog_query_opts(ifindex, target, &optq);
+	if (!ASSERT_OK(err, "prog_query"))
+		goto cleanup;
+
+	ASSERT_EQ(optq.count, 1, "count");
+	ASSERT_EQ(optq.revision, 2, "revision");
+	ASSERT_EQ(optq.prog_ids[0], pid1, "prog_ids[0]");
+	ASSERT_EQ(optq.link_ids[0], lid1, "link_ids[0]");
+	ASSERT_EQ(optq.prog_ids[1], 0, "prog_ids[1]");
+	ASSERT_EQ(optq.link_ids[1], 0, "link_ids[1]");
+
+	ASSERT_EQ(__send_icmp(ping_addr_noneigh), 0, "icmp_pkt");
+
+	ASSERT_EQ(skel->bss->seen_tc1, true /* L2: ARP */, "seen_tc1");
+	ASSERT_EQ(skel->bss->seen_eth, mode == META_L3, "seen_eth");
+cleanup:
+	test_tc_link__destroy(skel);
+
+	assert_mprog_count_ifindex(ifindex, target, 0);
+	destroy_meta();
+}
+
+void serial_test_tc_meta_neigh_links(void)
+{
+	serial_test_tc_meta_neigh_links_target(META_L2, BPF_META_PRIMARY);
+	serial_test_tc_meta_neigh_links_target(META_L3, BPF_META_PRIMARY);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
index 30e7124c49a1..992400acb957 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_link.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Isovalent */
 #include <stdbool.h>
+
 #include <linux/bpf.h>
+#include <linux/if_ether.h>
+
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
 char LICENSE[] SEC("license") = "GPL";
@@ -12,10 +16,19 @@ bool seen_tc3;
 bool seen_tc4;
 bool seen_tc5;
 bool seen_tc6;
+bool seen_eth;
 
 SEC("tc/ingress")
 int tc1(struct __sk_buff *skb)
 {
+	struct ethhdr eth = {};
+
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IP))
+		goto out;
+	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
+		goto out;
+	seen_eth = eth.h_proto == bpf_htons(ETH_P_IP);
+out:
 	seen_tc1 = true;
 	return TCX_NEXT;
 }
-- 
2.34.1


