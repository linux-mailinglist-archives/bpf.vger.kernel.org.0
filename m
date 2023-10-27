Return-Path: <bpf+bounces-13432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37277D9ECC
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D8E2824A3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6ED3AC2E;
	Fri, 27 Oct 2023 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gFAXhBBl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2A3986B;
	Fri, 27 Oct 2023 17:21:20 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0256B8;
	Fri, 27 Oct 2023 10:21:18 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5kTa022252;
	Fri, 27 Oct 2023 10:21:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=rAZ5q/YQJKgx9Ot1qq1Aa0hG1eyqpOvoB2bkQ5Jk16E=;
 b=gFAXhBBlVPJRw0N8ng3+Fyz1NLMqETmLoqGTn6b1EvgxzNkVvowsy+tp4i6M+yF2Ezcu
 u1CxDYyMAUWOS80hbKtbrtwn+cDNajJGmf0EjEw2tKuhH4ghDgHc338boB6GuyOWXXN9
 HaueUSv8+0ms4VW8umizM9ZRtdcKoiTTEpjZggZpFGZb0PK1ArO+UVW39CcXauRg+ErV
 6I4i8CVGo8Ig5yRI7mQTO6y8r2TWSw1WlpFzFHR+9Pmiladq1puUICCqUiBZrJN9c1YF
 XXepC5lqz48wXVN8rHN/uAg6J7U86ytuDeEUeByWrxsN5KUJicfwUQ/MLgfuWfHZYB/8 CA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tywr4026a-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 27 Oct 2023 10:21:05 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 27 Oct 2023 10:21:03 -0700
From: Vadim Fedorenko <vadfed@meta.com>
To: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests: bpf: crypto skcipher algo selftests
Date: Fri, 27 Oct 2023 10:20:39 -0700
Message-ID: <20231027172039.1365917-2-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231027172039.1365917-1-vadfed@meta.com>
References: <20231027172039.1365917-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::30]
X-Proofpoint-GUID: wEPRCYkdKMIgjv-1gKRusSyWh1BkzL7V
X-Proofpoint-ORIG-GUID: wEPRCYkdKMIgjv-1gKRusSyWh1BkzL7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_16,2023-10-27_01,2023-05-22_02

Add simple tc hook selftests to show the way to work with new crypto
BPF API. Some weird structre and map are added to setup program to make
verifier happy about dynptr initialization from memory. Simple AES-ECB
algo is used to demonstrate encryption and decryption of fixed size
buffers.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

---
v1 -> v2:
- add CONFIG_CRYPTO_AES and CONFIG_CRYPTO_ECB to selftest build config
  suggested by Daniel

 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/crypto_sanity.c  | 129 +++++++++++++++
 .../selftests/bpf/progs/crypto_common.h       | 104 ++++++++++++
 .../selftests/bpf/progs/crypto_sanity.c       | 154 ++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 02dd4409200e..48b570fd1752 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -14,6 +14,9 @@ CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_SKCIPHER=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_AES=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
new file mode 100644
index 000000000000..a43969da6d15
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -0,0 +1,129 @@
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
+#include "crypto_sanity.skel.h"
+
+#define NS_TEST "crypto_sanity_ns"
+#define IPV6_IFACE_ADDR "face::1"
+#define UDP_TEST_PORT 7777
+static const char plain_text[] = "stringtoencrypt0";
+static const char crypted_data[] = "\x5B\x59\x39\xEA\xD9\x7A\x2D\xAD\xA7\xE0\x43" \
+				   "\x37\x8A\x77\x17\xB2";
+
+void test_crypto_sanity(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach_enc);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach_dec);
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = crypted_data,
+		    .data_size_in = sizeof(crypted_data),
+		    .repeat = 1,
+	);
+	struct nstoken *nstoken = NULL;
+	struct crypto_sanity *skel;
+	struct sockaddr_in6 addr;
+	int sockfd, err, pfd;
+	socklen_t addrlen;
+
+	skel = crypto_sanity__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.skb_crypto_setup, true);
+
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	err = crypto_sanity__load(skel);
+	if (!ASSERT_OK(err, "crypto_sanity__load"))
+		goto fail;
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	qdisc_hook.ifindex = if_nametoindex("lo");
+	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
+		goto fail;
+
+	err = crypto_sanity__attach(skel);
+	if (!ASSERT_OK(err, "crypto_sanity__attach"))
+		goto fail;
+
+	pfd = bpf_program__fd(skel->progs.skb_crypto_setup);
+	if (!ASSERT_GT(pfd, 0, "skb_crypto_setup fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "skb_crypto_setup") ||
+	    !ASSERT_OK(opts.retval, "skb_crypto_setup retval"))
+		goto fail;
+
+	if (!ASSERT_OK(skel->bss->status, "skb_crypto_setup status"))
+		goto fail;
+
+	err = bpf_tc_hook_create(&qdisc_hook);
+	if (!ASSERT_OK(err, "create qdisc hook"))
+		goto fail;
+
+	addrlen = sizeof(addr);
+	err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
+			    (void *)&addr, &addrlen);
+	if (!ASSERT_OK(err, "make_sockaddr"))
+		goto fail;
+
+	tc_attach_dec.prog_fd = bpf_program__fd(skel->progs.decrypt_sanity);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach_dec);
+	if (!ASSERT_OK(err, "attach decrypt filter"))
+		goto fail;
+
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "decrypt socket"))
+		goto fail;
+	err = sendto(sockfd, crypted_data, 16, 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, 16, "decrypt send"))
+		goto fail;
+
+	bpf_tc_detach(&qdisc_hook, &tc_attach_dec);
+	if (!ASSERT_OK(skel->bss->status, "decrypt status"))
+		goto fail;
+	if (!ASSERT_STRNEQ(skel->bss->dst, plain_text, sizeof(plain_text), "decrypt"))
+		goto fail;
+
+	tc_attach_enc.prog_fd = bpf_program__fd(skel->progs.encrypt_sanity);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach_enc);
+	if (!ASSERT_OK(err, "attach encrypt filter"))
+		goto fail;
+
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "encrypt socket"))
+		goto fail;
+	err = sendto(sockfd, plain_text, 16, 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, 16, "encrypt send"))
+		goto fail;
+
+	bpf_tc_detach(&qdisc_hook, &tc_attach_enc);
+	if (!ASSERT_OK(skel->bss->status, "encrypt status"))
+		goto fail;
+	if (!ASSERT_STRNEQ(skel->bss->dst, crypted_data, sizeof(crypted_data), "encrypt"))
+		goto fail;
+
+fail:
+	if (nstoken) {
+		bpf_tc_hook_destroy(&qdisc_hook);
+		close_netns(nstoken);
+	}
+	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	crypto_sanity__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/crypto_common.h b/tools/testing/selftests/bpf/progs/crypto_common.h
new file mode 100644
index 000000000000..26929942d480
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_common.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _CRYPTO_COMMON_H
+#define _CRYPTO_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+private(CTX) static struct bpf_crypto_skcipher_ctx __kptr * global_crypto_ctx;
+
+struct bpf_crypto_skcipher_ctx *bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr *algo,
+							       const struct bpf_dynptr *key,
+							       int *err) __ksym;
+struct bpf_crypto_skcipher_ctx *bpf_crypto_skcipher_ctx_acquire(struct bpf_crypto_skcipher_ctx *ctx) __ksym;
+void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx) __ksym;
+int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
+				const struct bpf_dynptr *src, struct bpf_dynptr *dst,
+				const struct bpf_dynptr *iv) __ksym;
+int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
+				const struct bpf_dynptr *src, struct bpf_dynptr *dst,
+				const struct bpf_dynptr *iv) __ksym;
+
+struct __crypto_skcipher_ctx_value {
+	struct bpf_crypto_skcipher_ctx __kptr * ctx;
+};
+
+struct crypto_conf_value {
+	__u8 algo[32];
+	__u32 algo_size;
+	__u8 key[32];
+	__u32 key_size;
+	__u8 iv[32];
+	__u32 iv_size;
+	__u8 dst[32];
+	__u32 dst_size;
+};
+
+struct array_conf_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct crypto_conf_value);
+	__uint(max_entries, 1);
+} __crypto_conf_map SEC(".maps");
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __crypto_skcipher_ctx_value);
+	__uint(max_entries, 1);
+} __crypto_skcipher_ctx_map SEC(".maps");
+
+static inline struct crypto_conf_value *crypto_conf_lookup(void)
+{
+	struct crypto_conf_value *v, local = {};
+	u32 key = 0;
+
+	v = bpf_map_lookup_elem(&__crypto_conf_map, &key);
+	if (v)
+		return v;
+
+	bpf_map_update_elem(&__crypto_conf_map, &key, &local, 0);
+	return bpf_map_lookup_elem(&__crypto_conf_map, &key);
+}
+
+
+static inline struct __crypto_skcipher_ctx_value *crypto_skcipher_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__crypto_skcipher_ctx_map, &key);
+}
+
+static inline int crypto_skcipher_ctx_insert(struct bpf_crypto_skcipher_ctx *ctx)
+{
+	struct __crypto_skcipher_ctx_value local, *v;
+	long status;
+	struct bpf_crypto_skcipher_ctx *old;
+	u32 key = 0;
+
+	local.ctx = NULL;
+	status = bpf_map_update_elem(&__crypto_skcipher_ctx_map, &key, &local, 0);
+	if (status) {
+		bpf_crypto_skcipher_ctx_release(ctx);
+		return status;
+	}
+
+	v = bpf_map_lookup_elem(&__crypto_skcipher_ctx_map, &key);
+	if (!v) {
+		bpf_crypto_skcipher_ctx_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_crypto_skcipher_ctx_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _CRYPTO_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
new file mode 100644
index 000000000000..71a172d8d2a2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+#include "crypto_common.h"
+
+#define UDP_TEST_PORT 7777
+unsigned char crypto_key[16] = "testtest12345678";
+char crypto_algo[9] = "ecb(aes)";
+char dst[32] = {};
+int status;
+
+static inline int skb_validate_test(const struct __sk_buff *skb)
+{
+	struct ipv6hdr ip6h;
+	struct udphdr udph;
+	u32 offset;
+
+	if (skb->protocol != __bpf_constant_htons(ETH_P_IPV6))
+		return -1;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip6h, sizeof(ip6h)))
+		return -1;
+
+	if (ip6h.nexthdr != IPPROTO_UDP)
+		return -1;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph, sizeof(udph)))
+		return -1;
+
+	if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
+		return -1;
+
+	offset = ETH_HLEN + sizeof(ip6h) + sizeof(udph);
+	if (skb->len < offset + 16)
+		return -1;
+
+	return offset;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+int BPF_PROG(skb_crypto_setup)
+{
+	struct crypto_conf_value *c;
+	struct bpf_dynptr algo, key;
+	int err = 0;
+
+	status = 0;
+
+	c = crypto_conf_lookup();
+	if (!c) {
+		status = -EINVAL;
+		return 0;
+	}
+
+	bpf_dynptr_from_mem(crypto_algo, sizeof(crypto_algo), 0, &algo);
+	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
+	struct bpf_crypto_skcipher_ctx *cctx = bpf_crypto_skcipher_ctx_create(&algo, &key, &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	err = crypto_skcipher_ctx_insert(cctx);
+	if (err && err != -EEXIST)
+		status = err;
+
+	return 0;
+}
+
+SEC("tc")
+int decrypt_sanity(struct __sk_buff *skb)
+{
+	struct __crypto_skcipher_ctx_value *v;
+	struct bpf_crypto_skcipher_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+	int err;
+
+	err = skb_validate_test(skb);
+	if (err < 0) {
+		status = err;
+		return TC_ACT_SHOT;
+	}
+
+	v = crypto_skcipher_ctx_value_lookup();
+	if (!v) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	ctx = v->ctx;
+	if (!ctx) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	bpf_dynptr_from_skb(skb, 0, &psrc);
+	bpf_dynptr_adjust(&psrc, err, err + 16);
+	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	bpf_crypto_skcipher_decrypt(ctx, &psrc, &pdst, &iv);
+
+	status = 0;
+
+	return TC_ACT_SHOT;
+}
+
+SEC("tc")
+int encrypt_sanity(struct __sk_buff *skb)
+{
+	struct __crypto_skcipher_ctx_value *v;
+	struct bpf_crypto_skcipher_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+	int err;
+
+	status = 0;
+
+	err = skb_validate_test(skb);
+	if (err < 0) {
+		status = err;
+		return TC_ACT_SHOT;
+	}
+
+	v = crypto_skcipher_ctx_value_lookup();
+	if (!v) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	ctx = v->ctx;
+	if (!ctx) {
+		status = -ENOENT;
+		return TC_ACT_SHOT;
+	}
+
+	bpf_dynptr_from_skb(skb, 0, &psrc);
+	bpf_dynptr_adjust(&psrc, err, err + 16);
+	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	bpf_crypto_skcipher_encrypt(ctx, &psrc, &pdst, &iv);
+
+	return TC_ACT_SHOT;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.39.3


