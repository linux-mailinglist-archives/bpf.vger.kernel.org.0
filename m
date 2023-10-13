Return-Path: <bpf+bounces-12195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BB7C901B
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE58228302D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B032B5FD;
	Fri, 13 Oct 2023 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DHElGdJu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E628E14;
	Fri, 13 Oct 2023 22:10:15 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC229BF;
	Fri, 13 Oct 2023 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697235013; x=1728771013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vnbb/K3Qk2RQvdMzq1cEBvtTfTeUQm5xAjqQ52XGHVA=;
  b=DHElGdJusQ/7Y3RfkAK/7rHfPNSa7aqrtWa3BzS1CZcfHZ0ehJvzltgp
   KOS9XuwpbcU9wfKgHVLW29WEn1lWfXLExtE4CzERZvGmigrtXt912ES/N
   1T/XFvgmcws1wo66uBbnBiAPmMCQ61QFa0aHDTgSWpTylzYtK2VKC8Ul+
   8=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="369809157"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:10:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id 66F8D84F2A;
	Fri, 13 Oct 2023 22:10:00 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:09:47 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 22:09:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v1 bpf-next 11/11] selftest: bpf: Test BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB.
Date: Fri, 13 Oct 2023 15:04:33 -0700
Message-ID: <20231013220433.70792-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013220433.70792-1-kuniyu@amazon.com>
References: <20231013220433.70792-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.60]
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a test for BPF_SOCK_OPS_(GEN|CHECK)_SYNCOOKIE_CB hooks.

BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook generates a hash using SipHash from
based on 4-tuple.  The hash is split into ISN and TS.  MSS, ECN, SACK,
and WScale are encoded into the lower 8-bits of ISN.

  ISN:
    MSB                                   LSB
    | 31 ... 8 | 7 6 | 5   | 4    | 3 2 1 0 |
    | Hash_1   | MSS | ECN | SACK | WScale  |

  TS:
    MSB                LSB
    | 31 ... 8 | 7 ... 0 |
    | Random   | Hash_2  |

BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB hook re-calculates the hash and validates
the cookie.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Currently, the validator is incomplete...

If this line is changed

    skops->replylong[0] = msstab[3];

to
    skops->replylong[0] = msstab[mssind];

, we will get the error below during make:

    GEN-SKEL [test_progs] test_tcp_syncookie.skel.h
  ...
  Error: failed to open BPF object file: No such file or directory
    GEN-SKEL [test_progs-no_alu32] test_tcp_syncookie.skel.h
  make: *** [Makefile:603: /home/ec2-user/kernel/bpf_syncookie/tools/testing/selftests/bpf/test_tcp_syncookie.skel.h] Error 254
  make: *** Deleting file '/home/ec2-user/kernel/bpf_syncookie/tools/testing/selftests/bpf/test_tcp_syncookie.skel.h'
  make: *** Waiting for unfinished jobs....
---
 .../selftests/bpf/prog_tests/tcp_syncookie.c  |  84 +++++++++
 .../selftests/bpf/progs/test_siphash.h        |  65 +++++++
 .../selftests/bpf/progs/test_tcp_syncookie.c  | 170 ++++++++++++++++++
 .../selftests/bpf/test_tcp_hdr_options.h      |   8 +-
 4 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_syncookie.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_syncookie.c b/tools/testing/selftests/bpf/prog_tests/tcp_syncookie.c
new file mode 100644
index 000000000000..53af1434fc2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_syncookie.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "test_tcp_syncookie.skel.h"
+
+static int setup_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return -1;
+
+	if (!ASSERT_OK(system("ip link set dev lo up"), "system"))
+		return -1;
+
+	if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", "2"),
+		       "write_sysctl(tcp_syncookies)"))
+		return -1;
+
+	if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/tcp_ecn", "1"),
+		       "write_sysctl(tcp_ecn)"))
+		return -1;
+
+	return 0;
+}
+
+static void create_connection(void)
+{
+	int server, client, child;
+
+	server = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
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
+	close(child);
+close_client:
+	close(client);
+close_server:
+	close(server);
+}
+
+void test_tcp_syncookie(void)
+{
+	struct test_tcp_syncookie *skel;
+	struct bpf_link *link;
+	int cgroup;
+
+	if (setup_netns())
+		return;
+
+	skel = test_tcp_syncookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	cgroup = test__join_cgroup("/tcp_syncookie");
+	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
+		goto destroy_skel;
+
+	link = bpf_program__attach_cgroup(skel->progs.syncookie, cgroup);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
+		goto close_cgroup;
+
+	create_connection();
+
+	bpf_link__destroy(link);
+
+close_cgroup:
+	close(cgroup);
+destroy_skel:
+	test_tcp_syncookie__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_siphash.h b/tools/testing/selftests/bpf/progs/test_siphash.h
new file mode 100644
index 000000000000..e36de63fdbaa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_siphash.h
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+/* include/linux/bitops.h */
+static __always_inline __u64 rol64(__u64 word, unsigned int shift)
+{
+	return (word << (shift & 63)) | (word >> ((-shift) & 63));
+}
+
+/* include/linux/siphash.h */
+typedef struct {
+	__u64 key[2];
+} siphash_key_t;
+
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
+	__u64 v0 = SIPHASH_CONST_0; \
+	__u64 v1 = SIPHASH_CONST_1; \
+	__u64 v2 = SIPHASH_CONST_2; \
+	__u64 v3 = SIPHASH_CONST_3; \
+	__u64 b = ((__u64)(len)) << 56; \
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
+static __always_inline __u64 siphash_2u64(const __u64 first, const __u64 second,
+					  const siphash_key_t *key)
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
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c
new file mode 100644
index 000000000000..5d1fc928602b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tcp_syncookie.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/tcp.h>
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#define BPF_PROG_TEST_TCP_HDR_OPTIONS
+#include "test_tcp_hdr_options.h"
+#include "test_siphash.h"
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+static int assert_gen_syncookie_cb(struct bpf_sock_ops *skops)
+{
+	struct tcp_opt tcp_opt;
+	int ret;
+
+	tcp_opt.kind = TCPOPT_WINDOW;
+	tcp_opt.len = 0;
+
+	ret = bpf_load_hdr_opt(skops, &tcp_opt, TCPOLEN_WINDOW, 0);
+	if (ret != TCPOLEN_WINDOW ||
+	    tcp_opt.data[0] != (skops->args[1] & BPF_SYNCOOKIE_WSCALE_MASK))
+		goto err;
+
+	tcp_opt.kind = TCPOPT_SACK_PERM;
+	tcp_opt.len = 0;
+
+	ret = bpf_load_hdr_opt(skops, &tcp_opt, TCPOLEN_SACK_PERM, 0);
+	if (ret != TCPOLEN_SACK_PERM ||
+	    !(skops->args[1] & BPF_SYNCOOKIE_SACK))
+		goto err;
+
+	tcp_opt.kind = TCPOPT_TIMESTAMP;
+	tcp_opt.len = 0;
+
+	ret = bpf_load_hdr_opt(skops, &tcp_opt, TCPOLEN_TIMESTAMP, 0);
+	if (ret != TCPOLEN_TIMESTAMP ||
+	    !(skops->args[1] & BPF_SYNCOOKIE_TS))
+		goto err;
+
+	if (((skops->skb_tcp_flags & (TCPHDR_ECE | TCPHDR_CWR)) !=
+	     (TCPHDR_ECE | TCPHDR_CWR)) ||
+	    !(skops->args[1] & BPF_SYNCOOKIE_ECN))
+		goto err;
+
+	return CG_OK;
+
+err:
+	return CG_ERR;
+}
+
+static siphash_key_t test_key_siphash = {
+	{ 0x0706050403020100ULL, 0x0f0e0d0c0b0a0908ULL }
+};
+
+static __u32 cookie_hash(struct bpf_sock_ops *skops)
+{
+	return siphash_2u64((__u64)skops->remote_ip4 << 32 | skops->local_ip4,
+			    (__u64)skops->remote_port << 32 | skops->local_port,
+			    &test_key_siphash);
+}
+
+static const __u16 msstab[] = {
+	536,
+	1300,
+	1440,
+	1460,
+};
+
+#define COOKIE_BITS	8
+#define COOKIE_MASK	(((__u32)1 << COOKIE_BITS) - 1)
+
+/* Hash is calculated for each client and split into
+ * ISN and TS.
+ *
+ * ISN:
+ *
+ * MSB                                   LSB
+ * | 31 ... 8 | 7 6 | 5   | 4    | 3 2 1 0 |
+ * | Hash_1   | MSS | ECN | SACK | WScale  |
+ *
+ * TS:
+ *
+ * MSB                LSB
+ * | 31 ... 8 | 7 ... 0 |
+ * | Random   | Hash_2  |
+ */
+static void gen_syncookie(struct bpf_sock_ops *skops)
+{
+	__u16 mss = skops->args[0];
+	__u32 tstamp = 0;
+	__u32 cookie;
+	int mssind;
+
+	for (mssind = ARRAY_SIZE(msstab) - 1; mssind; mssind--)
+		if (mss > msstab[mssind])
+			break;
+
+	cookie = cookie_hash(skops);
+
+	if (skops->args[1] & BPF_SYNCOOKIE_TS) {
+		tstamp = bpf_get_prandom_u32();
+		tstamp &= ~COOKIE_MASK;
+		tstamp |= cookie & COOKIE_MASK;
+	}
+
+	cookie &= ~COOKIE_MASK;
+	cookie |= mssind << 6;
+	cookie |= skops->args[1] & (BPF_SYNCOOKIE_ECN |
+				    BPF_SYNCOOKIE_SACK |
+				    BPF_SYNCOOKIE_WSCALE_MASK);
+
+	skops->replylong[0] = cookie;
+	skops->replylong[1] = tstamp;
+}
+
+static int check_syncookie(struct bpf_sock_ops *skops)
+{
+	__u32 cookie = cookie_hash(skops);
+	__u32 tstamp = skops->args[1];
+	__u8 mssind;
+
+	if (tstamp)
+		cookie -= tstamp & COOKIE_MASK;
+	else
+		cookie &= ~COOKIE_MASK;
+
+	cookie -= skops->args[0] & ~COOKIE_MASK;
+	if (cookie)
+		return CG_ERR;
+
+	mssind = (skops->args[0] & (3 << 6)) >> 6;
+	if (mssind > ARRAY_SIZE(msstab))
+		return CG_ERR;
+
+	/* msstab[mssind]; does not compile ... */
+	skops->replylong[0] = msstab[3];
+	skops->replylong[1] = skops->args[0] & (BPF_SYNCOOKIE_ECN |
+						BPF_SYNCOOKIE_SACK |
+						BPF_SYNCOOKIE_WSCALE_MASK);
+
+	return CG_OK;
+}
+
+SEC("sockops")
+int syncookie(struct bpf_sock_ops *skops)
+{
+	int ret = CG_OK;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_TCP_LISTEN_CB:
+		bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG);
+		break;
+	case BPF_SOCK_OPS_GEN_SYNCOOKIE_CB:
+		ret = assert_gen_syncookie_cb(skops);
+		if (ret)
+			gen_syncookie(skops);
+		break;
+	case BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB:
+		ret = check_syncookie(skops);
+		break;
+	}
+
+	return ret;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tcp_hdr_options.h b/tools/testing/selftests/bpf/test_tcp_hdr_options.h
index 56c9f8a3ad3d..3efca29a1394 100644
--- a/tools/testing/selftests/bpf/test_tcp_hdr_options.h
+++ b/tools/testing/selftests/bpf/test_tcp_hdr_options.h
@@ -52,8 +52,14 @@ struct linum_err {
 #define TCPOPT_NOP		1
 #define TCPOPT_MSS		2
 #define TCPOPT_WINDOW		3
+#define TCPOPT_SACK_PERM	4
+#define TCPOPT_TIMESTAMP	8
 #define TCPOPT_EXP		254
 
+#define TCPOLEN_WINDOW		3
+#define TCPOLEN_SACK_PERM	2
+#define TCPOLEN_TIMESTAMP	10
+
 #define TCP_BPF_EXPOPT_BASE_LEN 4
 #define MAX_TCP_HDR_LEN		60
 #define MAX_TCP_OPTION_SPACE	40
@@ -81,7 +87,7 @@ struct tcp_opt {
 	__u8 kind;
 	__u8 len;
 	union {
-		__u8 data[4];
+		__u8 data[8];
 		__u32 data32;
 	};
 } __attribute__((packed));
-- 
2.30.2


