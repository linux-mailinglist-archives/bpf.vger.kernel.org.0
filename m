Return-Path: <bpf+bounces-64776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75CB16DCB
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D213558464F
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CB2BCF75;
	Thu, 31 Jul 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EIAd2lYM"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E629C35C;
	Thu, 31 Jul 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951378; cv=none; b=JaRF2aFH3+yM84HDM3BniewC5y3L4iRSymLHFCdJQt8+DBn+Xygo6n3tFi6U6YsZ7rX+2RoaXpbgy0yqod1eGJdnIQLs+bbbHy8Z480dKNZJENeaIShOr6b2Xkr0VHOLHHKUu71pnSTP10oRc5vazISiKSktOF6u2I4qpRyJ/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951378; c=relaxed/simple;
	bh=bio6b4KiRN+80uv0pG8k1TFJRKTPZLMHXNxFPBkwY3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOXUrivK9OVOBYNASku40vormBgXIBWULR69REtP761oAyBGQOfj8+UHeJtdygQPjspUQU0E1plsRH61SjSuPe+PrMNyd6lhKLBDFI0oM5RPFP57fWQkGZ/MPqNxC2jXwIY6i7/vqrl/1R8vECTFZtg1wd3mG5EpzYGhRHo3MVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EIAd2lYM; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753951373; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AmD/sEUthDmRo+atuzIwIR3cYX2K90KPgwnE2oO3Pm8=;
	b=EIAd2lYMmhf/VChjKO0qb7CsYLmzWy0YFGlv8dAvuODGYechR66ooLOg1CK8kM8ql+NQdhSoRrh4xQx3NFyBZgnEQynUImW42QRkZMpCPoW3dIK0wXksAahiv814OgoSRUN4F1fcjQTCEI3ziVSMpNVr9hr0FBEno7yqf7O6/L4=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WkXYUnR_1753951371 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 16:42:51 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	Mahanta.Jambigi@ibm.com,
	Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next 5/5] bpf/selftests: add selftest for bpf_smc_hs_ctrl
Date: Thu, 31 Jul 2025 16:42:40 +0800
Message-ID: <20250731084240.86550-6-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250731084240.86550-1-alibuda@linux.alibaba.com>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tests introduces a tiny smc_hs_ctrl for filtering SMC connections
based on IP pairs, and also adds a realistic topology model to verify it.

Also, we can only use SMC loopback under CI test, so an additional
configuration needs to be enabled.

Follow the steps below to run this test.

make -C tools/testing/selftests/bpf
cd tools/testing/selftests/bpf
sudo ./test_progs -t smc

Results shows:
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Tested-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 tools/testing/selftests/bpf/config            |   4 +
 .../selftests/bpf/prog_tests/test_bpf_smc.c   | 396 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 117 ++++++
 3 files changed, 517 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 7247833fe623..257ac8537212 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -119,3 +119,7 @@ CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
 CONFIG_TCP_CONG_DCTCP=y
 CONFIG_TCP_CONG_BBR=y
+CONFIG_INFINIBAND=y
+CONFIG_SMC=y
+CONFIG_SMC_HS_CTRL_BPF=y
+CONFIG_SMC_LO=y
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
new file mode 100644
index 000000000000..200658d28793
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <linux/genetlink.h>
+#include "network_helpers.h"
+#include "bpf_smc.skel.h"
+
+#ifndef IPPROTO_SMC
+#define IPPROTO_SMC 256
+#endif
+
+#define CLIENT_IP			"127.0.0.1"
+#define SERVER_IP			"127.0.1.0"
+#define SERVER_IP_VIA_RISK_PATH	"127.0.2.0"
+
+#define SERVICE_1	11234
+#define SERVICE_2	22345
+#define SERVICE_3	33456
+
+#define TEST_NS	"bpf_smc_netns"
+
+static struct netns_obj *test_netns;
+
+struct smc_strat_ip_key {
+	__u32  sip;
+	__u32  dip;
+};
+
+struct smc_strat_ip_value {
+	__u8	mode;
+};
+
+#if defined(__s390x__)
+/* s390x has default seid  */
+static bool setup_ueid(void) { return true; }
+static void cleanup_ueid(void) {}
+#else
+enum {
+	SMC_NETLINK_ADD_UEID = 10,
+	SMC_NETLINK_REMOVE_UEID
+};
+
+enum {
+	SMC_NLA_EID_TABLE_UNSPEC,
+	SMC_NLA_EID_TABLE_ENTRY,    /* string */
+};
+
+struct msgtemplate {
+	struct nlmsghdr n;
+	struct genlmsghdr g;
+	char buf[1024];
+};
+
+#define GENLMSG_DATA(glh)	((void *)(NLMSG_DATA(glh) + GENL_HDRLEN))
+#define GENLMSG_PAYLOAD(glh)	(NLMSG_PAYLOAD(glh, 0) - GENL_HDRLEN)
+#define NLA_DATA(na)		((void *)((char *)(na) + NLA_HDRLEN))
+#define NLA_PAYLOAD(len)	((len) - NLA_HDRLEN)
+
+#define SMC_GENL_FAMILY_NAME	"SMC_GEN_NETLINK"
+#define SMC_BPFTEST_UEID	"SMC-BPFTEST-UEID"
+
+static uint16_t smc_nl_family_id = -1;
+
+static int send_cmd(int fd, __u16 nlmsg_type, __u32 nlmsg_pid,
+		    __u16 nlmsg_flags, __u8 genl_cmd, __u16 nla_type,
+		    void *nla_data, int nla_len)
+{
+	struct nlattr *na;
+	struct sockaddr_nl nladdr;
+	int r, buflen;
+	char *buf;
+
+	struct msgtemplate msg = {0};
+
+	msg.n.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
+	msg.n.nlmsg_type = nlmsg_type;
+	msg.n.nlmsg_flags = nlmsg_flags;
+	msg.n.nlmsg_seq = 0;
+	msg.n.nlmsg_pid = nlmsg_pid;
+	msg.g.cmd = genl_cmd;
+	msg.g.version = 1;
+	na = (struct nlattr *)GENLMSG_DATA(&msg);
+	na->nla_type = nla_type;
+	na->nla_len = nla_len + 1 + NLA_HDRLEN;
+	memcpy(NLA_DATA(na), nla_data, nla_len);
+	msg.n.nlmsg_len += NLMSG_ALIGN(na->nla_len);
+
+	buf = (char *)&msg;
+	buflen = msg.n.nlmsg_len;
+	memset(&nladdr, 0, sizeof(nladdr));
+	nladdr.nl_family = AF_NETLINK;
+
+	while ((r = sendto(fd, buf, buflen, 0, (struct sockaddr *)&nladdr,
+			   sizeof(nladdr))) < buflen) {
+		if (r > 0) {
+			buf += r;
+			buflen -= r;
+		} else if (errno != EAGAIN) {
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static bool get_smc_nl_family_id(void)
+{
+	struct sockaddr_nl nl_src;
+	struct msgtemplate msg;
+	struct nlattr *nl;
+	int fd, ret;
+	pid_t pid;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (!ASSERT_OK_FD(fd, "nl_family socket"))
+		return false;
+
+	pid = getpid();
+
+	memset(&nl_src, 0, sizeof(nl_src));
+	nl_src.nl_family = AF_NETLINK;
+	nl_src.nl_pid = pid;
+
+	ret = bind(fd, (struct sockaddr *)&nl_src, sizeof(nl_src));
+	if (!ASSERT_OK(ret, "nl_family bind"))
+		goto fail;
+
+	ret = send_cmd(fd, GENL_ID_CTRL, pid,
+		       NLM_F_REQUEST, CTRL_CMD_GETFAMILY,
+		       CTRL_ATTR_FAMILY_NAME, (void *)SMC_GENL_FAMILY_NAME,
+		       strlen(SMC_GENL_FAMILY_NAME));
+	if (!ASSERT_OK(ret, "nl_family query"))
+		goto fail;
+
+	ret = recv(fd, &msg, sizeof(msg), 0);
+	if (!ASSERT_FALSE(msg.n.nlmsg_type == NLMSG_ERROR || ret < 0 ||
+			  !NLMSG_OK(&msg.n, ret), "nl_family response"))
+		goto fail;
+
+	nl = (struct nlattr *)GENLMSG_DATA(&msg);
+	nl = (struct nlattr *)((char *)nl + NLA_ALIGN(nl->nla_len));
+	if (!ASSERT_EQ(nl->nla_type, CTRL_ATTR_FAMILY_ID, "nl_family nla type"))
+		goto fail;
+
+	smc_nl_family_id = *(uint16_t *)NLA_DATA(nl);
+	close(fd);
+	return true;
+fail:
+	close(fd);
+	return false;
+}
+
+static bool smc_ueid(int op)
+{
+	struct sockaddr_nl nl_src;
+	struct msgtemplate msg;
+	struct nlmsgerr *err;
+	char test_ueid[32];
+	int fd, ret;
+	pid_t pid;
+
+	/* UEID required */
+	memset(test_ueid, '\x20', sizeof(test_ueid));
+	memcpy(test_ueid, SMC_BPFTEST_UEID, strlen(SMC_BPFTEST_UEID));
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (!ASSERT_OK_FD(fd, "ueid socket"))
+		return false;
+
+	pid = getpid();
+	memset(&nl_src, 0, sizeof(nl_src));
+	nl_src.nl_family = AF_NETLINK;
+	nl_src.nl_pid = pid;
+
+	ret = bind(fd, (struct sockaddr *)&nl_src, sizeof(nl_src));
+	if (!ASSERT_OK(ret, "ueid bind"))
+		goto fail;
+
+	ret = send_cmd(fd, smc_nl_family_id, pid,
+		       NLM_F_REQUEST | NLM_F_ACK, op, SMC_NLA_EID_TABLE_ENTRY,
+		       (void *)test_ueid, sizeof(test_ueid));
+	if (!ASSERT_OK(ret, "ueid cmd"))
+		goto fail;
+
+	ret = recv(fd, &msg, sizeof(msg), 0);
+	if (!ASSERT_FALSE(ret < 0 ||
+			  !NLMSG_OK(&msg.n, ret), "ueid response"))
+		goto fail;
+
+	if (msg.n.nlmsg_type == NLMSG_ERROR) {
+		err = NLMSG_DATA(&msg);
+		switch (op) {
+		case SMC_NETLINK_REMOVE_UEID:
+			if (!ASSERT_FALSE((err->error && err->error != -ENOENT),
+					  "ueid remove"))
+				goto fail;
+			break;
+		case SMC_NETLINK_ADD_UEID:
+			if (!ASSERT_OK(err->error, "ueid add"))
+				goto fail;
+			break;
+		default:
+			break;
+		}
+	}
+	close(fd);
+	return true;
+fail:
+	close(fd);
+	return false;
+}
+
+static bool setup_ueid(void)
+{
+	/* get smc nl id */
+	if (!get_smc_nl_family_id())
+		return false;
+	/* clear old ueid for bpftest */
+	smc_ueid(SMC_NETLINK_REMOVE_UEID);
+	/* smc-loopback required ueid */
+	return smc_ueid(SMC_NETLINK_ADD_UEID);
+}
+
+static void cleanup_ueid(void)
+{
+	smc_ueid(SMC_NETLINK_REMOVE_UEID);
+}
+#endif /* __s390x__ */
+
+static bool setup_netns(void)
+{
+	test_netns = netns_new(TEST_NS, true);
+	if (!ASSERT_OK_PTR(test_netns, "open net namespace"))
+		goto fail_netns;
+
+	if (!ASSERT_OK(system("ip addr add 127.0.1.0/8 dev lo"),
+		       "add server node"))
+		goto fail_ip;
+
+	if (!ASSERT_OK(system("ip addr add 127.0.2.0/8 dev lo"),
+		       "server via risk path"))
+		goto fail_ip;
+
+	return true;
+fail_ip:
+	netns_free(test_netns);
+fail_netns:
+	return false;
+}
+
+static void cleanup_netns(void)
+{
+	netns_free(test_netns);
+	remove_netns(TEST_NS);
+}
+
+static bool setup_smc(void)
+{
+	if (!setup_ueid())
+		return false;
+
+	if (!setup_netns())
+		goto fail_netns;
+
+	return true;
+fail_netns:
+	cleanup_ueid();
+	return false;
+}
+
+static int set_client_addr_cb(int fd, void *opts)
+{
+	const char *src = (const char *)opts;
+	struct sockaddr_in localaddr;
+
+	localaddr.sin_family = AF_INET;
+	localaddr.sin_port = htons(0);
+	localaddr.sin_addr.s_addr = inet_addr(src);
+	return !ASSERT_OK(bind(fd, &localaddr, sizeof(localaddr)), "client bind");
+}
+
+static void run_link(const char *src, const char *dst, int port)
+{
+	struct network_helper_opts opts = {0};
+	int server, client;
+
+	server = start_server_str(AF_INET, SOCK_STREAM, dst, port, NULL);
+	if (!ASSERT_OK_FD(server, "start service_1"))
+		return;
+
+	opts.proto = IPPROTO_TCP;
+	opts.post_socket_cb = set_client_addr_cb;
+	opts.cb_opts = (void *)src;
+
+	client = connect_to_fd_opts(server, &opts);
+	if (!ASSERT_OK_FD(client, "start connect"))
+		goto fail_client;
+
+	close(client);
+fail_client:
+	close(server);
+}
+
+static void block_link(int map_fd, const char *src, const char *dst)
+{
+	struct smc_strat_ip_value val = { .mode = /* block */ 0 };
+	struct smc_strat_ip_key key = {
+		.sip = inet_addr(src),
+		.dip = inet_addr(dst),
+	};
+
+	bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
+}
+
+/*
+ * This test describes a real-life service topology as follows:
+ *
+ *                             +-------------> service_1
+ *            link 1           |                     |
+ *   +--------------------> server                   |  link 2
+ *   |                         |                     V
+ *   |                         +-------------> service_2
+ *   |        link 3
+ *  client -------------------> server_via_unsafe_path -> service_3
+ *
+ * Among them,
+ * 1. link-1 is very suitable for using SMC.
+ * 2. link-2 is not suitable for using SMC, because the mode of this link is
+ *    kind of short-link services.
+ * 3. link-3 is also not suitable for using SMC, because the RDMA link is
+ *    unavailable and needs to go through a long timeout before it can fallback
+ *    to TCP.
+ * To achieve this goal, we use a customized SMC ip strategy via smc_hs_ctrl.
+ */
+static void test_topo(void)
+{
+	struct bpf_smc *skel;
+	int rc, map_fd;
+
+	skel = bpf_smc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_smc__open_and_load"))
+		return;
+
+	rc = bpf_smc__attach(skel);
+	if (!ASSERT_OK(rc, "bpf_smc__attach"))
+		goto fail;
+
+	map_fd = bpf_map__fd(skel->maps.smc_strats_ip);
+	if (!ASSERT_OK_FD(map_fd, "bpf_map__fd"))
+		goto fail;
+
+	/* Mock the process of transparent replacement, since we will modify
+	 * protocol to ipproto_smc accropding to it via
+	 * fmod_ret/update_socket_protocol.
+	 */
+	system("sysctl -w net.smc.hs_ctrl=linkcheck");
+
+	/* Configure ip strat */
+	block_link(map_fd, CLIENT_IP, SERVER_IP_VIA_RISK_PATH);
+	block_link(map_fd, SERVER_IP, SERVER_IP);
+
+	/* should go with smc */
+	run_link(CLIENT_IP, SERVER_IP, SERVICE_1);
+	/* should go with smc fallback */
+	run_link(SERVER_IP, SERVER_IP, SERVICE_2);
+
+	ASSERT_EQ(skel->bss->smc_cnt, 2, "smc count");
+	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
+
+	/* should go with smc */
+	run_link(CLIENT_IP, SERVER_IP, SERVICE_2);
+
+	ASSERT_EQ(skel->bss->smc_cnt, 3, "smc count");
+	ASSERT_EQ(skel->bss->fallback_cnt, 1, "fallback count");
+
+	/* should go with smc fallback */
+	run_link(CLIENT_IP, SERVER_IP_VIA_RISK_PATH, SERVICE_3);
+
+	ASSERT_EQ(skel->bss->smc_cnt, 4, "smc count");
+	ASSERT_EQ(skel->bss->fallback_cnt, 2, "fallback count");
+
+fail:
+	bpf_smc__destroy(skel);
+}
+
+void test_bpf_smc(void)
+{
+	if (!setup_smc()) {
+		printf("setup for smc test failed, test SKIP:\n");
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("topo"))
+		test_topo();
+
+	cleanup_ueid();
+	cleanup_netns();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c b/tools/testing/selftests/bpf/progs/bpf_smc.c
new file mode 100644
index 000000000000..d6abc3b9e6c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_tracing_net.h"
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	BPF_SMC_LISTEN	= 10,
+};
+
+struct smc_sock___local {
+	struct sock sk;
+	struct smc_sock *listen_smc;
+	bool use_fallback;
+} __attribute__((preserve_access_index));
+
+int smc_cnt = 0;
+int fallback_cnt = 0;
+
+SEC("fentry/smc_release")
+int BPF_PROG(bpf_smc_release, struct socket *sock)
+{
+	/* only count from one side (client) */
+	if (sock->sk->__sk_common.skc_state == BPF_SMC_LISTEN)
+		return 0;
+	smc_cnt++;
+	return 0;
+}
+
+SEC("fentry/smc_switch_to_fallback")
+int BPF_PROG(bpf_smc_switch_to_fallback, struct smc_sock___local *smc)
+{
+	/* only count from one side (client) */
+	if (smc && !smc->listen_smc)
+		fallback_cnt++;
+	return 0;
+}
+
+/* go with default value if no strat was found */
+bool default_ip_strat_value = true;
+
+struct smc_strat_ip_key {
+	__u32	sip;
+	__u32	dip;
+};
+
+struct smc_strat_ip_value {
+	__u8	mode;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct smc_strat_ip_key));
+	__uint(value_size, sizeof(struct smc_strat_ip_value));
+	__uint(max_entries, 128);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} smc_strats_ip SEC(".maps");
+
+static bool smc_check(__u32 src, __u32 dst)
+{
+	struct smc_strat_ip_value *value;
+	struct smc_strat_ip_key key = {
+		.sip = src,
+		.dip = dst,
+	};
+
+	value = bpf_map_lookup_elem(&smc_strats_ip, &key);
+	return value ? value->mode : default_ip_strat_value;
+}
+
+SEC("fmod_ret/update_socket_protocol")
+int BPF_PROG(smc_run, int family, int type, int protocol)
+{
+	struct task_struct *task;
+
+	if (family != AF_INET && family != AF_INET6)
+		return protocol;
+
+	if ((type & 0xf) != SOCK_STREAM)
+		return protocol;
+
+	if (protocol != 0 && protocol != IPPROTO_TCP)
+		return protocol;
+
+	task = bpf_get_current_task_btf();
+	/* Prevent from affecting other tests */
+	if (!task || !task->nsproxy->net_ns->smc.hs_ctrl)
+		return protocol;
+
+	return IPPROTO_SMC;
+}
+
+SEC("struct_ops/bpf_smc_set_tcp_option_cond")
+int BPF_PROG(bpf_smc_set_tcp_option_cond, const struct tcp_sock *tp,
+	     struct inet_request_sock *ireq)
+{
+	return smc_check(ireq->req.__req_common.skc_daddr,
+			 ireq->req.__req_common.skc_rcv_saddr);
+}
+
+SEC("struct_ops/bpf_smc_set_tcp_option")
+int BPF_PROG(bpf_smc_set_tcp_option, struct tcp_sock *tp)
+{
+	return smc_check(tp->inet_conn.icsk_inet.sk.__sk_common.skc_rcv_saddr,
+			 tp->inet_conn.icsk_inet.sk.__sk_common.skc_daddr);
+}
+
+SEC(".struct_ops.link")
+struct smc_hs_ctrl  linkcheck = {
+	.name		= "linkcheck",
+	.syn_option	= (void *)bpf_smc_set_tcp_option,
+	.synack_option	= (void *)bpf_smc_set_tcp_option_cond,
+};
-- 
2.45.0


