Return-Path: <bpf+bounces-16685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A5E804425
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE69E281463
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492A184E;
	Tue,  5 Dec 2023 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BhpTj734"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D490E6;
	Mon,  4 Dec 2023 17:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701740160; x=1733276160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERJ94gnqNeCu52I9uOvt95eUngUsxy4hziM/+MJ0IrY=;
  b=BhpTj734EEymsi6SZlh8MtziBJE09ny7+pWyduypxj7xCFlXBxKUfEoe
   YlVcY4EmYI5OLIELJGxmp+v/AJDk7zCO5oyZqtEn1HP6gFasBtLoLd0XU
   0x+K2+L0fNoeUAAxQ61kiWaX+ckluAFdCyQmSZRFp07sw+zYxEiz9YKMb
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,251,1695686400"; 
   d="scan'208";a="623270439"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:35:58 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id DBCE380C2A;
	Tue,  5 Dec 2023 01:35:55 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:59364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.8:2525] with esmtp (Farcaster)
 id 82b24f55-2295-4161-947e-a4797ca77017; Tue, 5 Dec 2023 01:35:54 +0000 (UTC)
X-Farcaster-Flow-ID: 82b24f55-2295-4161-947e-a4797ca77017
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 5 Dec 2023 01:35:54 +0000
Received: from 88665a182662.ant.amazon.com (10.119.0.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 01:35:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v4 bpf-next 3/3] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Date: Tue, 5 Dec 2023 10:34:20 +0900
Message-ID: <20231205013420.88067-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231205013420.88067-1-kuniyu@amazon.com>
References: <20231205013420.88067-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This commit adds a sample selftest to demonstrate how we can use
bpf_sk_assign_tcp_reqsk() as the backend of SYN Proxy.

The test creates IPv4/IPv6 x TCP/MPTCP connections and transfer
messages over them on lo with BPF tc prog attached.

The tc prog will process SYN and returns SYN+ACK with the following
ISN and TS.  In a real use case, this part will be done by other
hosts.

        MSB                                   LSB
  ISN:  | 31 ... 8 | 7 6 |   5 |    4 | 3 2 1 0 |
        |   Hash_1 | MSS | ECN | SACK |  WScale |

  TS:   | 31 ... 8 |          7 ... 0           |
        |   Random |           Hash_2           |

  WScale in SYN is reused in SYN+ACK.

The client returns ACK, and tc prog will recalculate ISN and TS
from ACK and validate SYN Cookie.

If it's valid, the prog calls kfunc to allocate a reqsk for skb and
configure the reqsk based on the argument created from SYN Cookie.

Later, the reqsk will be processed in cookie_v[46]_check() to create
a connection.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 163 +++++
 .../selftests/bpf/progs/test_siphash.h        |  64 ++
 .../bpf/progs/test_tcp_custom_syncookie.c     | 573 ++++++++++++++++++
 .../bpf/progs/test_tcp_custom_syncookie.h     | 162 +++++
 6 files changed, 973 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index b4e78c1eb37b..e2a1651851cf 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -51,6 +51,16 @@ extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clo
 extern int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 				      const __u8 *sun_path, __u32 sun_path__sz) __ksym;
 
+/* Description
+ *  Allocate and configure a reqsk and link it with a listener and skb.
+ * Returns
+ *  Error code
+ */
+struct sock;
+struct tcp_cookie_attributes;
+extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *sk,
+				   struct tcp_cookie_attributes *attr, int attr__sz) __ksym;
+
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
 void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c125c441abc7..01f241ea2c67 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -81,6 +81,7 @@ CONFIG_NF_NAT=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
+CONFIG_SYN_COOKIES=y
 CONFIG_TEST_BPF=m
 CONFIG_USERFAULTFD=y
 CONFIG_VSOCKETS=y
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
new file mode 100644
index 000000000000..fefb52d8222c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+#include <net/if.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "test_tcp_custom_syncookie.skel.h"
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+static struct test_tcp_custom_syncookie_case {
+	int family, type, protocol;
+	char addr[16];
+	char name[10];
+} test_cases[] = {
+	{
+		.name = "IPv4 TCP  ",
+		.family = AF_INET,
+		.type = SOCK_STREAM,
+		.addr = "127.0.0.1",
+	},
+	{
+		.name = "IPv6 TCP  ",
+		.family = AF_INET6,
+		.type = SOCK_STREAM,
+		.addr = "::1",
+	},
+	{
+		.name = "IPv4 MPTCP",
+		.family = AF_INET,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+		.addr = "127.0.0.1",
+	},
+	{
+		.name = "IPv6 MPTCP",
+		.family = AF_INET6,
+		.type = SOCK_STREAM,
+		.protocol = IPPROTO_MPTCP,
+		.addr = "::1",
+	},
+};
+
+static int setup_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return -1;
+
+	if (!ASSERT_OK(system("ip link set dev lo up"), "ip"))
+		goto err;
+
+	if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/tcp_ecn", "1"),
+		       "write_sysctl"))
+		goto err;
+
+	return 0;
+err:
+	return -1;
+}
+
+static int setup_tc(struct test_tcp_custom_syncookie *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
+		    .prog_fd = bpf_program__fd(skel->progs.tcp_custom_syncookie));
+
+	qdisc_lo.ifindex = if_nametoindex("lo");
+	if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo clsact"))
+		goto err;
+
+	if (!ASSERT_OK(bpf_tc_attach(&qdisc_lo, &tc_attach),
+		       "filter add dev lo ingress"))
+		goto err;
+
+	return 0;
+err:
+	return -1;
+}
+
+#define msg "Hello World"
+#define msglen 11
+
+static void transfer_message(int sender, int receiver)
+{
+	char buf[msglen];
+	int ret;
+
+	ret = send(sender, msg, msglen, 0);
+	if (!ASSERT_EQ(ret, msglen, "send"))
+		return;
+
+	memset(buf, 0, sizeof(buf));
+
+	ret = recv(receiver, buf, msglen, 0);
+	if (!ASSERT_EQ(ret, msglen, "recv"))
+		return;
+
+	ret = strncmp(buf, msg, msglen);
+	if (!ASSERT_EQ(ret, 0, "strncmp"))
+		return;
+}
+
+static void create_connection(struct test_tcp_custom_syncookie_case *test_case)
+{
+	int server, client, child;
+
+	if (test_case->protocol == IPPROTO_MPTCP)
+		server = start_mptcp_server(test_case->family, test_case->addr, 0, 0);
+	else
+		server = start_server(test_case->family, test_case->type, test_case->addr, 0, 0);
+	if (!ASSERT_NEQ(server, -1, "start_server"))
+		return;
+
+	client = connect_to_fd(server, 0);
+	if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
+		goto close_server;
+
+	child = accept(server, NULL, 0);
+	if (!ASSERT_NEQ(child, -1, "accept"))
+		goto close_client;
+
+	transfer_message(client, child);
+	transfer_message(child, client);
+
+	close(child);
+close_client:
+	close(client);
+close_server:
+	close(server);
+}
+
+void test_tcp_custom_syncookie(void)
+{
+	struct test_tcp_custom_syncookie *skel;
+	int i;
+
+	if (setup_netns())
+		return;
+
+	skel = test_tcp_custom_syncookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (setup_tc(skel))
+		goto destroy_skel;
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
+		test__start_subtest(test_cases[i].name);
+		create_connection(&test_cases[i]);
+	}
+
+destroy_skel:
+	system("tc qdisc del dev lo clsact");
+
+	test_tcp_custom_syncookie__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_siphash.h b/tools/testing/selftests/bpf/progs/test_siphash.h
new file mode 100644
index 000000000000..25334079f8be
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_siphash.h
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#ifndef _TEST_SIPHASH_H
+#define _TEST_SIPHASH_H
+
+/* include/linux/bitops.h */
+static __always_inline __u64 rol64(__u64 word, unsigned int shift)
+{
+	return (word << (shift & 63)) | (word >> ((-shift) & 63));
+}
+
+/* include/linux/siphash.h */
+#define SIPHASH_PERMUTATION(a, b, c, d) ( \
+	(a) += (b), (b) = rol64((b), 13), (b) ^= (a), (a) = rol64((a), 32), \
+	(c) += (d), (d) = rol64((d), 16), (d) ^= (c), \
+	(a) += (d), (d) = rol64((d), 21), (d) ^= (a), \
+	(c) += (b), (b) = rol64((b), 17), (b) ^= (c), (c) = rol64((c), 32))
+
+#define SIPHASH_CONST_0 0x736f6d6570736575ULL
+#define SIPHASH_CONST_1 0x646f72616e646f6dULL
+#define SIPHASH_CONST_2 0x6c7967656e657261ULL
+#define SIPHASH_CONST_3 0x7465646279746573ULL
+
+/* lib/siphash.c */
+#define SIPROUND SIPHASH_PERMUTATION(v0, v1, v2, v3)
+
+#define PREAMBLE(len) \
+	u64 v0 = SIPHASH_CONST_0; \
+	u64 v1 = SIPHASH_CONST_1; \
+	u64 v2 = SIPHASH_CONST_2; \
+	u64 v3 = SIPHASH_CONST_3; \
+	u64 b = ((u64)(len)) << 56; \
+	v3 ^= key->key[1]; \
+	v2 ^= key->key[0]; \
+	v1 ^= key->key[1]; \
+	v0 ^= key->key[0];
+
+#define POSTAMBLE \
+	v3 ^= b; \
+	SIPROUND; \
+	SIPROUND; \
+	v0 ^= b; \
+	v2 ^= 0xff; \
+	SIPROUND; \
+	SIPROUND; \
+	SIPROUND; \
+	SIPROUND; \
+	return (v0 ^ v1) ^ (v2 ^ v3);
+
+static inline u64 siphash_2u64(const u64 first, const u64 second, const siphash_key_t *key)
+{
+	PREAMBLE(16)
+	v3 ^= first;
+	SIPROUND;
+	SIPROUND;
+	v0 ^= first;
+	v3 ^= second;
+	SIPROUND;
+	SIPROUND;
+	v0 ^= second;
+	POSTAMBLE
+}
+#endif
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
new file mode 100644
index 000000000000..9a6e2fc1379c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_kfuncs.h"
+#include "test_siphash.h"
+#include "test_tcp_custom_syncookie.h"
+
+/* Hash is calculated for each client and split into ISN and TS.
+ *
+ *       MSB                                   LSB
+ * ISN:  | 31 ... 8 | 7 6 |   5 |    4 | 3 2 1 0 |
+ *       |   Hash_1 | MSS | ECN | SACK |  WScale |
+ *
+ * TS:   | 31 ... 8 |          7 ... 0           |
+ *       |   Random |           Hash_2           |
+ */
+#define COOKIE_BITS	8
+#define COOKIE_MASK	(((__u32)1 << COOKIE_BITS) - 1)
+
+enum {
+	/* 0xf is invalid thus means that SYN did not have WScale. */
+	BPF_SYNCOOKIE_WSCALE_MASK	= (1 << 4) - 1,
+	BPF_SYNCOOKIE_SACK		= (1 << 4),
+	BPF_SYNCOOKIE_ECN		= (1 << 5),
+};
+
+#define MSS_LOCAL_IPV4	65495
+#define MSS_LOCAL_IPV6	65476
+
+const __u16 msstab4[] = {
+	536,
+	1300,
+	1460,
+	MSS_LOCAL_IPV4,
+};
+
+const __u16 msstab6[] = {
+	1280 - 60, /* IPV6_MIN_MTU - 60 */
+	1480 - 60,
+	9000 - 60,
+	MSS_LOCAL_IPV6,
+};
+
+static siphash_key_t test_key_siphash = {
+	{ 0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL }
+};
+
+struct tcp_syncookie {
+	struct __sk_buff *skb;
+	void *data_end;
+	struct ethhdr *eth;
+	struct iphdr *ipv4;
+	struct ipv6hdr *ipv6;
+	struct tcphdr *tcp;
+	union {
+		char *ptr;
+		__be32 *ptr32;
+	};
+	struct tcp_cookie_attributes attr;
+	u32 cookie;
+	u64 first;
+};
+
+static __always_inline int tcp_load_headers(struct tcp_syncookie *ctx)
+{
+	ctx->data_end = (void *)(long)ctx->skb->data_end;
+	ctx->eth = (struct ethhdr *)(long)ctx->skb->data;
+
+	if (ctx->eth + 1 > ctx->data_end)
+		goto err;
+
+	switch (bpf_ntohs(ctx->eth->h_proto)) {
+	case ETH_P_IP:
+		ctx->ipv4 = (struct iphdr *)(ctx->eth + 1);
+
+		if (ctx->ipv4 + 1 > ctx->data_end)
+			goto err;
+
+		if (ctx->ipv4->ihl != sizeof(*ctx->ipv4) / 4)
+			goto err;
+
+		if (ctx->ipv4->version != 4)
+			goto err;
+
+		if (ctx->ipv4->protocol != IPPROTO_TCP)
+			goto err;
+
+		ctx->tcp = (struct tcphdr *)(ctx->ipv4 + 1);
+		break;
+	case ETH_P_IPV6:
+		ctx->ipv6 = (struct ipv6hdr *)(ctx->eth + 1);
+
+		if (ctx->ipv6 + 1 > ctx->data_end)
+			goto err;
+
+		if (ctx->ipv6->version != 6)
+			goto err;
+
+		if (ctx->ipv6->nexthdr != NEXTHDR_TCP)
+			goto err;
+
+		ctx->tcp = (struct tcphdr *)(ctx->ipv6 + 1);
+		break;
+	default:
+		goto err;
+	}
+
+	if (ctx->tcp + 1 > ctx->data_end)
+		goto err;
+
+	return 0;
+err:
+	return -1;
+}
+
+static __always_inline int tcp_reload_headers(struct tcp_syncookie *ctx)
+{
+	/* Without volatile,
+	 * R3 32-bit pointer arithmetic prohibited
+	 */
+	volatile u64 data_len = ctx->skb->data_end - ctx->skb->data;
+
+	if (ctx->tcp->doff < sizeof(*ctx->tcp) / 4)
+		goto err;
+
+	/* Needed to calculate csum and parse TCP options. */
+	if (bpf_skb_change_tail(ctx->skb, data_len + 60 - ctx->tcp->doff * 4, 0))
+		goto err;
+
+	ctx->data_end = (void *)(long)ctx->skb->data_end;
+	ctx->eth = (struct ethhdr *)(long)ctx->skb->data;
+	if (ctx->ipv4) {
+		ctx->ipv4 = (struct iphdr *)(ctx->eth + 1);
+		ctx->ipv6 = NULL;
+		ctx->tcp = (struct tcphdr *)(ctx->ipv4 + 1);
+	} else {
+		ctx->ipv4 = NULL;
+		ctx->ipv6 = (struct ipv6hdr *)(ctx->eth + 1);
+		ctx->tcp = (struct tcphdr *)(ctx->ipv6 + 1);
+	}
+
+	if ((void *)ctx->tcp + 60 > ctx->data_end)
+		goto err;
+
+	return 0;
+err:
+	return -1;
+}
+
+static __always_inline __sum16 tcp_v4_csum(struct tcp_syncookie *ctx, __wsum csum)
+{
+	return csum_tcpudp_magic(ctx->ipv4->saddr, ctx->ipv4->daddr,
+				 ctx->tcp->doff * 4, IPPROTO_TCP, csum);
+}
+
+static __always_inline __sum16 tcp_v6_csum(struct tcp_syncookie *ctx, __wsum csum)
+{
+	return csum_ipv6_magic(&ctx->ipv6->saddr, &ctx->ipv6->daddr,
+			       ctx->tcp->doff * 4, IPPROTO_TCP, csum);
+}
+
+static __always_inline int tcp_validate_header(struct tcp_syncookie *ctx)
+{
+	s64 csum;
+
+	if (tcp_reload_headers(ctx))
+		goto err;
+
+	csum = bpf_csum_diff(0, 0, (void *)ctx->tcp, ctx->tcp->doff * 4, 0);
+	if (csum < 0)
+		goto err;
+
+	if (ctx->ipv4) {
+		/* check tcp_v4_csum(csum) is 0 if not on lo. */
+
+		csum = bpf_csum_diff(0, 0, (void *)ctx->ipv4, ctx->ipv4->ihl * 4, 0);
+		if (csum < 0)
+			goto err;
+
+		if (csum_fold(csum) != 0)
+			goto err;
+	} else if (ctx->ipv6) {
+		/* check tcp_v6_csum(csum) is 0 if not on lo. */
+	}
+
+	return 0;
+err:
+	return -1;
+}
+
+static int tcp_parse_option(__u32 index, struct tcp_syncookie *ctx)
+{
+	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
+	char opcode, opsize;
+
+	if (ctx->ptr + 1 > ctx->data_end)
+		goto stop;
+
+	opcode = *ctx->ptr++;
+
+	if (opcode == TCPOPT_EOL)
+		goto stop;
+
+	if (opcode == TCPOPT_NOP)
+		goto next;
+
+	if (ctx->ptr + 1 > ctx->data_end)
+		goto stop;
+
+	opsize = *ctx->ptr++;
+
+	if (opsize < 2)
+		goto stop;
+
+	switch (opcode) {
+	case TCPOPT_MSS:
+		if (opsize == TCPOLEN_MSS && ctx->tcp->syn &&
+		    ctx->ptr + (TCPOLEN_MSS - 2) < ctx->data_end)
+			tcp_opt->mss_clamp = get_unaligned_be16(ctx->ptr);
+		break;
+	case TCPOPT_WINDOW:
+		if (opsize == TCPOLEN_WINDOW && ctx->tcp->syn &&
+		    ctx->ptr + (TCPOLEN_WINDOW - 2) < ctx->data_end) {
+			tcp_opt->wscale_ok = 1;
+			tcp_opt->snd_wscale = *ctx->ptr;
+		}
+		break;
+	case TCPOPT_TIMESTAMP:
+		if (opsize == TCPOLEN_TIMESTAMP &&
+		    ctx->ptr + (TCPOLEN_TIMESTAMP - 2) < ctx->data_end) {
+			tcp_opt->saw_tstamp = 1;
+			tcp_opt->rcv_tsval = get_unaligned_be32(ctx->ptr);
+			tcp_opt->rcv_tsecr = get_unaligned_be32(ctx->ptr + 4);
+
+			if (ctx->tcp->syn && tcp_opt->rcv_tsecr)
+				tcp_opt->tstamp_ok = 0;
+			else
+				tcp_opt->tstamp_ok = 1;
+		}
+		break;
+	case TCPOPT_SACK_PERM:
+		if (opsize == TCPOLEN_SACK_PERM && ctx->tcp->syn &&
+		    ctx->ptr + (TCPOLEN_SACK_PERM - 2) < ctx->data_end)
+			tcp_opt->sack_ok = 1;
+		break;
+	}
+
+	ctx->ptr += opsize - 2;
+next:
+	return 0;
+stop:
+	return 1;
+}
+
+static __always_inline void tcp_parse_options(struct tcp_syncookie *ctx)
+{
+	ctx->ptr = (char *)(ctx->tcp + 1);
+
+	bpf_loop(40, tcp_parse_option, ctx, 0);
+}
+
+static __always_inline int tcp_validate_sysctl(struct tcp_syncookie *ctx)
+{
+	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
+
+	if ((ctx->ipv4 && tcp_opt->mss_clamp != MSS_LOCAL_IPV4) ||
+	    (ctx->ipv6 && tcp_opt->mss_clamp != MSS_LOCAL_IPV6))
+		goto err;
+
+	if (!tcp_opt->wscale_ok || tcp_opt->snd_wscale != 7)
+		goto err;
+
+	if (!tcp_opt->tstamp_ok)
+		goto err;
+
+	if (!tcp_opt->sack_ok)
+		goto err;
+
+	if (!ctx->tcp->ece || !ctx->tcp->cwr)
+		goto err;
+
+	return 0;
+err:
+	return -1;
+}
+
+static __always_inline void tcp_prepare_cookie(struct tcp_syncookie *ctx)
+{
+	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
+	u32 seq = bpf_ntohl(ctx->tcp->seq);
+	u64 first = 0, second;
+	int mssind = 0;
+	u32 hash;
+
+	if (ctx->ipv4) {
+		for (mssind = ARRAY_SIZE(msstab4) - 1; mssind; mssind--)
+			if (tcp_opt->mss_clamp >= msstab4[mssind])
+				break;
+
+		tcp_opt->mss_clamp = msstab4[mssind];
+
+		first = (u64)ctx->ipv4->saddr << 32 | ctx->ipv4->daddr;
+	} else if (ctx->ipv6) {
+		for (mssind = ARRAY_SIZE(msstab6) - 1; mssind; mssind--)
+			if (tcp_opt->mss_clamp >= msstab6[mssind])
+				break;
+
+		tcp_opt->mss_clamp = msstab6[mssind];
+
+		first = (u64)ctx->ipv6->saddr.in6_u.u6_addr8[0] << 32 |
+			ctx->ipv6->daddr.in6_u.u6_addr32[0];
+	}
+
+	second = (u64)seq << 32 | ctx->tcp->source << 16 | ctx->tcp->dest;
+	hash = siphash_2u64(first, second, &test_key_siphash);
+
+	if (tcp_opt->tstamp_ok) {
+		tcp_opt->rcv_tsecr = bpf_get_prandom_u32();
+		tcp_opt->rcv_tsecr &= ~COOKIE_MASK;
+		tcp_opt->rcv_tsecr |= hash & COOKIE_MASK;
+	}
+
+	hash &= ~COOKIE_MASK;
+	hash |= mssind << 6;
+
+	if (tcp_opt->wscale_ok)
+		hash |= tcp_opt->snd_wscale & BPF_SYNCOOKIE_WSCALE_MASK;
+
+	if (tcp_opt->sack_ok)
+		hash |= BPF_SYNCOOKIE_SACK;
+
+	if (tcp_opt->tstamp_ok && ctx->tcp->ece && ctx->tcp->cwr)
+		hash |= BPF_SYNCOOKIE_ECN;
+
+	ctx->cookie = hash;
+}
+
+static __always_inline void tcp_write_options(struct tcp_syncookie *ctx)
+{
+	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
+
+	ctx->ptr32 = (__be32 *)(ctx->tcp + 1);
+
+	*ctx->ptr32++ = bpf_htonl(TCPOPT_MSS << 24 | TCPOLEN_MSS << 16 |
+				  tcp_opt->mss_clamp);
+
+	if (tcp_opt->wscale_ok)
+		*ctx->ptr32++ = bpf_htonl(TCPOPT_NOP << 24 |
+					  TCPOPT_WINDOW << 16 |
+					  TCPOLEN_WINDOW << 8 |
+					  tcp_opt->snd_wscale);
+
+	if (tcp_opt->tstamp_ok) {
+		if (tcp_opt->sack_ok)
+			*ctx->ptr32++ = bpf_htonl(TCPOPT_SACK_PERM << 24 |
+						  TCPOLEN_SACK_PERM << 16 |
+						  TCPOPT_TIMESTAMP << 8 |
+						  TCPOLEN_TIMESTAMP);
+		else
+			*ctx->ptr32++ = bpf_htonl(TCPOPT_NOP << 24 |
+						  TCPOPT_NOP << 16 |
+						  TCPOPT_TIMESTAMP << 8 |
+						  TCPOLEN_TIMESTAMP);
+
+		*ctx->ptr32++ = bpf_htonl(tcp_opt->rcv_tsecr);
+		*ctx->ptr32++ = bpf_htonl(tcp_opt->rcv_tsval);
+	} else if (tcp_opt->sack_ok) {
+		*ctx->ptr32++ = bpf_htonl(TCPOPT_NOP << 24 |
+					  TCPOPT_NOP << 16 |
+					  TCPOPT_SACK_PERM << 8 |
+					  TCPOLEN_SACK_PERM);
+	}
+}
+
+static __always_inline int tcp_handle_syn(struct tcp_syncookie *ctx)
+{
+	s64 csum;
+
+	if (tcp_validate_header(ctx))
+		goto err;
+
+	tcp_parse_options(ctx);
+
+	if (tcp_validate_sysctl(ctx))
+		goto err;
+
+	tcp_prepare_cookie(ctx);
+	tcp_write_options(ctx);
+
+	swap(ctx->tcp->source, ctx->tcp->dest);
+	ctx->tcp->check = 0;
+	ctx->tcp->ack_seq = bpf_htonl(bpf_ntohl(ctx->tcp->seq) + 1);
+	ctx->tcp->seq = bpf_htonl(ctx->cookie);
+	ctx->tcp->doff = ((long)ctx->ptr32 - (long)ctx->tcp) >> 2;
+	ctx->tcp->ack = 1;
+	if (!ctx->attr.tcp_opt.tstamp_ok || !ctx->tcp->ece || !ctx->tcp->cwr)
+		ctx->tcp->ece = 0;
+	ctx->tcp->cwr = 0;
+
+	csum = bpf_csum_diff(0, 0, (void *)ctx->tcp, ctx->tcp->doff * 4, 0);
+	if (csum < 0)
+		goto err;
+
+	if (ctx->ipv4) {
+		swap(ctx->ipv4->saddr, ctx->ipv4->daddr);
+		ctx->tcp->check = tcp_v4_csum(ctx, csum);
+
+		ctx->ipv4->check = 0;
+		ctx->ipv4->tos = 0;
+		ctx->ipv4->tot_len = bpf_htons((long)ctx->ptr32 - (long)ctx->ipv4);
+		ctx->ipv4->id = 0;
+		ctx->ipv4->ttl = 64;
+
+		csum = bpf_csum_diff(0, 0, (void *)ctx->ipv4, sizeof(*ctx->ipv4), 0);
+		if (csum < 0)
+			goto err;
+
+		ctx->ipv4->check = csum_fold(csum);
+	} else if (ctx->ipv6) {
+		swap(ctx->ipv6->saddr, ctx->ipv6->daddr);
+		ctx->tcp->check = tcp_v6_csum(ctx, csum);
+
+		*(__be32 *)ctx->ipv6 = bpf_htonl(0x60000000);
+		ctx->ipv6->payload_len = bpf_htons((long)ctx->ptr32 - (long)ctx->tcp);
+		ctx->ipv6->hop_limit = 64;
+	}
+
+	swap_array(ctx->eth->h_source, ctx->eth->h_dest);
+
+	if (bpf_skb_change_tail(ctx->skb, (long)ctx->ptr32 - (long)ctx->eth, 0))
+		goto err;
+
+	return bpf_redirect(ctx->skb->ifindex, 0);
+err:
+	return TC_ACT_SHOT;
+}
+
+static __always_inline int tcp_validate_cookie(struct tcp_syncookie *ctx)
+{
+	struct tcp_options_received *tcp_opt = &ctx->attr.tcp_opt;
+	u32 cookie = bpf_ntohl(ctx->tcp->ack_seq) - 1;
+	u32 seq = bpf_ntohl(ctx->tcp->seq) - 1;
+	u64 first = 0, second;
+	int mssind;
+	u32 hash;
+
+	if (ctx->ipv4)
+		first = (u64)ctx->ipv4->saddr << 32 | ctx->ipv4->daddr;
+	else if (ctx->ipv6)
+		first = (u64)ctx->ipv6->saddr.in6_u.u6_addr8[0] << 32 |
+			ctx->ipv6->daddr.in6_u.u6_addr32[0];
+
+	second = (u64)seq << 32 | ctx->tcp->source << 16 | ctx->tcp->dest;
+	hash = siphash_2u64(first, second, &test_key_siphash);
+
+	if (tcp_opt->saw_tstamp)
+		hash -= tcp_opt->rcv_tsecr & COOKIE_MASK;
+	else
+		hash &= ~COOKIE_MASK;
+
+	hash -= cookie & ~COOKIE_MASK;
+	if (hash)
+		goto err;
+
+	mssind = (cookie & (3 << 6)) >> 6;
+	if (ctx->ipv4) {
+		if (mssind > ARRAY_SIZE(msstab4))
+			goto err;
+
+		tcp_opt->mss_clamp = msstab4[mssind];
+	} else {
+		if (mssind > ARRAY_SIZE(msstab6))
+			goto err;
+
+		tcp_opt->mss_clamp = msstab6[mssind];
+	}
+
+	tcp_opt->snd_wscale = cookie & BPF_SYNCOOKIE_WSCALE_MASK;
+	tcp_opt->rcv_wscale = tcp_opt->snd_wscale;
+	tcp_opt->wscale_ok = tcp_opt->snd_wscale == BPF_SYNCOOKIE_WSCALE_MASK;
+	tcp_opt->sack_ok = cookie & BPF_SYNCOOKIE_SACK;
+	ctx->attr.ecn_ok = cookie & BPF_SYNCOOKIE_ECN;
+
+	return 0;
+err:
+	return -1;
+}
+
+static __always_inline int tcp_handle_ack(struct tcp_syncookie *ctx)
+{
+	struct bpf_sock_tuple tuple;
+	struct bpf_sock *skc;
+	int ret = TC_ACT_OK;
+	struct sock *sk;
+	u32 tuple_size;
+
+	if (ctx->ipv4) {
+		tuple.ipv4.saddr = ctx->ipv4->saddr;
+		tuple.ipv4.daddr = ctx->ipv4->daddr;
+		tuple.ipv4.sport = ctx->tcp->source;
+		tuple.ipv4.dport = ctx->tcp->dest;
+		tuple_size = sizeof(tuple.ipv4);
+	} else if (ctx->ipv6) {
+		__builtin_memcpy(tuple.ipv6.saddr, &ctx->ipv6->saddr, sizeof(tuple.ipv6.saddr));
+		__builtin_memcpy(tuple.ipv6.daddr, &ctx->ipv6->daddr, sizeof(tuple.ipv6.daddr));
+		tuple.ipv6.sport = ctx->tcp->source;
+		tuple.ipv6.dport = ctx->tcp->dest;
+		tuple_size = sizeof(tuple.ipv6);
+	} else {
+		goto out;
+	}
+
+	skc = bpf_skc_lookup_tcp(ctx->skb, &tuple, tuple_size, BPF_F_CURRENT_NETNS, 0);
+	if (!skc)
+		goto out;
+
+	if (skc->state != TCP_LISTEN)
+		goto release;
+
+	sk = (struct sock *)bpf_skc_to_tcp_sock(skc);
+	if (!sk)
+		goto err;
+
+	if (tcp_validate_header(ctx))
+		goto err;
+
+	tcp_parse_options(ctx);
+
+	if (tcp_validate_cookie(ctx))
+		goto err;
+
+	ret = bpf_sk_assign_tcp_reqsk(ctx->skb, sk, &ctx->attr, sizeof(ctx->attr));
+	if (ret < 0)
+		goto err;
+
+release:
+	bpf_sk_release(skc);
+out:
+	return ret;
+
+err:
+	ret = TC_ACT_SHOT;
+	goto release;
+}
+
+SEC("tc")
+int tcp_custom_syncookie(struct __sk_buff *skb)
+{
+	struct tcp_syncookie ctx = {
+		.skb = skb,
+	};
+
+	if (tcp_load_headers(&ctx))
+		return TC_ACT_OK;
+
+	if (ctx.tcp->rst)
+		return TC_ACT_OK;
+
+	if (ctx.tcp->syn) {
+		if (ctx.tcp->ack)
+			return TC_ACT_OK;
+
+		return tcp_handle_syn(&ctx);
+	}
+
+	return tcp_handle_ack(&ctx);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
new file mode 100644
index 000000000000..a401f59e46d8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#ifndef _TEST_TCP_SYNCOOKIE_H
+#define _TEST_TCP_SYNCOOKIE_H
+
+#define TC_ACT_OK	0
+#define TC_ACT_SHOT	2
+
+#define ETH_ALEN	6
+#define ETH_P_IP	0x0800
+#define ETH_P_IPV6	0x86DD
+
+#define NEXTHDR_TCP	6
+
+#define TCPOPT_NOP		1
+#define TCPOPT_EOL		0
+#define TCPOPT_MSS		2
+#define TCPOPT_WINDOW		3
+#define TCPOPT_TIMESTAMP	8
+#define TCPOPT_SACK_PERM	4
+
+#define TCPOLEN_MSS		4
+#define TCPOLEN_WINDOW		3
+#define TCPOLEN_TIMESTAMP	10
+#define TCPOLEN_SACK_PERM	2
+#define BPF_F_CURRENT_NETNS	(-1)
+
+#define __packed __attribute__((__packed__))
+#define __force
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+#define swap(a, b)				\
+	do {					\
+		typeof(a) __tmp = (a);		\
+		(a) = (b);			\
+		(b) = __tmp;			\
+	} while (0)
+
+#define swap_array(a, b)				\
+	do {						\
+		typeof(a) __tmp[sizeof(a)];		\
+		__builtin_memcpy(__tmp, a, sizeof(a));	\
+		__builtin_memcpy(a, b, sizeof(a));	\
+		__builtin_memcpy(b, __tmp, sizeof(a));	\
+	} while (0)
+
+/* asm-generic/unaligned.h */
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed * __pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define get_unaligned(ptr) __get_unaligned_t(typeof(*(ptr)), (ptr))
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return bpf_ntohs(__get_unaligned_t(__be16, p));
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return bpf_ntohl(__get_unaligned_t(__be32, p));
+}
+
+/* lib/checksum.c */
+static inline u32 from64to32(u64 x)
+{
+	/* add up 32-bit and 32-bit for 32+c bit */
+	x = (x & 0xffffffff) + (x >> 32);
+	/* add up carry.. */
+	x = (x & 0xffffffff) + (x >> 32);
+	return (u32)x;
+}
+
+static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
+					__u32 len, __u8 proto, __wsum sum)
+{
+	unsigned long long s = (__force u32)sum;
+
+	s += (__force u32)saddr;
+	s += (__force u32)daddr;
+#ifdef __BIG_ENDIAN
+	s += proto + len;
+#else
+	s += (proto + len) << 8;
+#endif
+	return (__force __wsum)from64to32(s);
+}
+
+/* asm-generic/checksum.h */
+static inline __sum16 csum_fold(__wsum csum)
+{
+	u32 sum = (__force u32)csum;
+
+	sum = (sum & 0xffff) + (sum >> 16);
+	sum = (sum & 0xffff) + (sum >> 16);
+	return (__force __sum16)~sum;
+}
+
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
+					__u8 proto, __wsum sum)
+{
+	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
+}
+
+/* net/ipv6/ip6_checksum.c */
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+				      __u32 len, __u8 proto, __wsum csum)
+{
+	int carry;
+	__u32 ulen;
+	__u32 uproto;
+	__u32 sum = (__force u32)csum;
+
+	sum += (__force u32)saddr->in6_u.u6_addr32[0];
+	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[0]);
+	sum += carry;
+
+	sum += (__force u32)saddr->in6_u.u6_addr32[1];
+	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[1]);
+	sum += carry;
+
+	sum += (__force u32)saddr->in6_u.u6_addr32[2];
+	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[2]);
+	sum += carry;
+
+	sum += (__force u32)saddr->in6_u.u6_addr32[3];
+	carry = (sum < (__force u32)saddr->in6_u.u6_addr32[3]);
+	sum += carry;
+
+	sum += (__force u32)daddr->in6_u.u6_addr32[0];
+	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[0]);
+	sum += carry;
+
+	sum += (__force u32)daddr->in6_u.u6_addr32[1];
+	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[1]);
+	sum += carry;
+
+	sum += (__force u32)daddr->in6_u.u6_addr32[2];
+	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[2]);
+	sum += carry;
+
+	sum += (__force u32)daddr->in6_u.u6_addr32[3];
+	carry = (sum < (__force u32)daddr->in6_u.u6_addr32[3]);
+	sum += carry;
+
+	ulen = (__force u32)bpf_htonl((__u32)len);
+	sum += ulen;
+	carry = (sum < ulen);
+	sum += carry;
+
+	uproto = (__force u32)bpf_htonl(proto);
+	sum += uproto;
+	carry = (sum < uproto);
+	sum += carry;
+
+	return csum_fold((__force __wsum)sum);
+}
+#endif
-- 
2.30.2


