Return-Path: <bpf+bounces-19560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252D82E26E
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 23:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141E6283B3C
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 22:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924D1B5AC;
	Mon, 15 Jan 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="l5dKffgs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184121865A;
	Mon, 15 Jan 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEOQP2002617;
	Mon, 15 Jan 2024 14:08:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=qUAbAl2fxN10CFm519eKRFOf54oJysZiqOT5RK2YGO8=;
 b=l5dKffgs72bTj3anKxs7MXqbIeoS0JfEiAOs17WIRTUMWlI7UWIlRbGS0i2SgdXKB83d
 3KFCCzoft7oKQYBMAmY9TilMitmcNtKIRNiANZq8LJMj+MAvGjEmMAB5dyHcejw2DZhd
 FRDd/014HM+rkq0bEvX4No1nE/1/NDRO5cizzW8MuO+9BZwq794qUA3jKUTb95uL/bTy
 wy3QlI1aBQJAXJPwQikqZvzRjkgM9g0szpXPAcKK00PZzf5xngxGXtRTDKtCldE8KRzY
 IOYWCQ90W/kW5LNIS3TLkEiATR46wRhAwlYuJwRPooaW1vEJ4tMb3gfCHXJbaVmtEWI8 Jg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vn5ve2fn9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jan 2024 14:08:20 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 15 Jan 2024 14:08:17 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>,
        Victor Stewart
	<v@nametag.social>
Subject: [PATCH bpf-next v8 3/3] selftests: bpf: crypto skcipher algo selftests
Date: Mon, 15 Jan 2024 14:08:03 -0800
Message-ID: <20240115220803.1973440-3-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240115220803.1973440-1-vadfed@meta.com>
References: <20240115220803.1973440-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zYJ7D-jecQ-esI6rsJGtDXHmJRHbQ2fF
X-Proofpoint-ORIG-GUID: zYJ7D-jecQ-esI6rsJGtDXHmJRHbQ2fF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_15,2024-01-15_03,2023-05-22_02

Add simple tc hook selftests to show the way to work with new crypto
BPF API. Some tricky dynptr initialization is used to provide empty iv
dynptr. Simple AES-ECB algo is used to demonstrate encryption and
decryption of fixed size buffers.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v7 -> v8:
- use sizeof for all constant buffer operations
- make local functions static
- initialize crypto_key value via access to bss data
- add bpf_skb_pull_data to be sure that data is linear
- some comments around tricky dynptr initialization
v6 -> v7:
- style issues
v5 -> v6:
- use AF_ALG socket to confirm proper algorithm test
- adjust test kernel config to include AF_ALG
v4 -> v5:
- adjust selftests to use new naming
- restore tests on aarch64 and s390 as no sg lists are used
v3 -> v4:
- adjust selftests to use new syntax of helpers
- add tests for acquire and release
v2 -> v3:
- disable tests on s390 and aarch64 because of unknown Fatal exception
  in sg_init_one
v1 -> v2:
- add CONFIG_CRYPTO_AES and CONFIG_CRYPTO_ECB to selftest build config
  suggested by Daniel
---
 tools/testing/selftests/bpf/config            |   5 +
 .../selftests/bpf/prog_tests/crypto_sanity.c  | 217 ++++++++++++++++++
 .../selftests/bpf/progs/crypto_common.h       |  67 ++++++
 .../selftests/bpf/progs/crypto_sanity.c       | 200 ++++++++++++++++
 4 files changed, 489 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c125c441abc7..2221994a36d6 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -13,7 +13,12 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
+CONFIG_CRYPTO_SKCIPHER=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_AES=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_DWARF4=y
diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
new file mode 100644
index 000000000000..70bde9640651
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/in6.h>
+#include <linux/if_alg.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "crypto_sanity.skel.h"
+
+#define NS_TEST "crypto_sanity_ns"
+#define IPV6_IFACE_ADDR "face::1"
+#define UDP_TEST_PORT 7777
+static const unsigned char crypto_key[] = "testtest12345678";
+static const char plain_text[] = "stringtoencrypt0";
+static int opfd = -1, tfmfd = -1;
+
+static int init_afalg(void)
+{
+	struct sockaddr_alg sa = {
+		.salg_family = AF_ALG,
+		.salg_type = "skcipher",
+		.salg_name = "ecb(aes)"
+	};
+
+	tfmfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (tfmfd == -1)
+		return errno;
+	if (bind(tfmfd, (struct sockaddr *)&sa, sizeof(sa)) == -1)
+		return errno;
+	if (setsockopt(tfmfd, SOL_ALG, ALG_SET_KEY, crypto_key, 16) == -1)
+		return errno;
+	opfd = accept(tfmfd, NULL, 0);
+	if (opfd == -1)
+		return errno;
+	return 0;
+}
+
+static void deinit_afalg(void)
+{
+	if (tfmfd)
+		close(tfmfd);
+	if (opfd)
+		close(opfd);
+}
+
+static void do_crypt_afalg(const void *src, void *dst, int size, bool encrypt)
+{
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	char cbuf[CMSG_SPACE(4)] = {0};
+	struct iovec iov;
+
+	msg.msg_control = cbuf;
+	msg.msg_controllen = sizeof(cbuf);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_ALG;
+	cmsg->cmsg_type = ALG_SET_OP;
+	cmsg->cmsg_len = CMSG_LEN(4);
+	*(__u32 *)CMSG_DATA(cmsg) = encrypt ? ALG_OP_ENCRYPT : ALG_OP_DECRYPT;
+
+	iov.iov_base = (char *)src;
+	iov.iov_len = size;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	sendmsg(opfd, &msg, 0);
+	read(opfd, dst, size);
+}
+
+void test_crypto_sanity(void)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach_enc);
+	LIBBPF_OPTS(bpf_tc_opts, tc_attach_dec);
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .repeat = 1,
+	);
+	struct nstoken *nstoken = NULL;
+	struct crypto_sanity *skel;
+	char afalg_plain[16] = {0};
+	char afalg_dst[16] = {0};
+	struct sockaddr_in6 addr;
+	int sockfd, err, pfd;
+	socklen_t addrlen;
+
+	skel = crypto_sanity__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.crypto_acquire, true);
+
+	err = crypto_sanity__load(skel);
+	if (!ASSERT_ERR(err, "crypto_acquire unexpected load success"))
+		goto fail;
+
+	crypto_sanity__destroy(skel);
+
+	skel = crypto_sanity__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.crypto_acquire, false);
+
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	err = crypto_sanity__load(skel);
+	if (!ASSERT_OK(err, "crypto_sanity__load"))
+		goto fail;
+
+	memcpy(skel->bss->crypto_key, crypto_key, sizeof(crypto_key));
+
+	nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto fail;
+
+	err = init_afalg();
+	if (!ASSERT_OK(err, "AF_ALG init fail"))
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
+	pfd = bpf_program__fd(skel->progs.crypto_release);
+	if (!ASSERT_GT(pfd, 0, "crypto_release fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "crypto_release") ||
+	    !ASSERT_OK(opts.retval, "crypto_release retval"))
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
+	tc_attach_enc.prog_fd = bpf_program__fd(skel->progs.encrypt_sanity);
+	err = bpf_tc_attach(&qdisc_hook, &tc_attach_enc);
+	if (!ASSERT_OK(err, "attach encrypt filter"))
+		goto fail;
+
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_NEQ(sockfd, -1, "encrypt socket"))
+		goto fail;
+	err = sendto(sockfd, plain_text, sizeof(plain_text), 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, sizeof(plain_text), "encrypt send"))
+		goto fail;
+
+	do_crypt_afalg(plain_text, afalg_dst, sizeof(afalg_dst), true);
+
+	bpf_tc_detach(&qdisc_hook, &tc_attach_enc);
+	if (!ASSERT_OK(skel->bss->status, "encrypt status"))
+		goto fail;
+	if (!ASSERT_STRNEQ(skel->bss->dst, afalg_dst, sizeof(afalg_dst), "encrypt AF_ALG"))
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
+	err = sendto(sockfd, afalg_dst, sizeof(afalg_dst), 0, (void *)&addr, addrlen);
+	close(sockfd);
+	if (!ASSERT_EQ(err, sizeof(afalg_dst), "decrypt send"))
+		goto fail;
+
+	do_crypt_afalg(afalg_dst, afalg_plain, sizeof(afalg_plain), false);
+
+	bpf_tc_detach(&qdisc_hook, &tc_attach_dec);
+	if (!ASSERT_OK(skel->bss->status, "decrypt status"))
+		goto fail;
+	if (!ASSERT_STRNEQ(skel->bss->dst, afalg_plain, sizeof(afalg_plain), "decrypt AF_ALG"))
+		goto fail;
+
+fail:
+	if (nstoken) {
+		bpf_tc_hook_destroy(&qdisc_hook);
+		close_netns(nstoken);
+	}
+	deinit_afalg();
+	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
+	crypto_sanity__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/crypto_common.h b/tools/testing/selftests/bpf/progs/crypto_common.h
new file mode 100644
index 000000000000..260b9a0fb4ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_common.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _CRYPTO_COMMON_H
+#define _CRYPTO_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+struct bpf_crypto_ctx *bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
+					     const struct bpf_dynptr *pkey,
+					     unsigned int authsize, int *err) __ksym;
+struct bpf_crypto_ctx *bpf_crypto_ctx_acquire(struct bpf_crypto_ctx *ctx) __ksym;
+void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx) __ksym;
+int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *src,
+		       struct bpf_dynptr *dst, struct bpf_dynptr *iv) __ksym;
+int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx, const struct bpf_dynptr *src,
+		       struct bpf_dynptr *dst, struct bpf_dynptr *iv) __ksym;
+
+struct __crypto_ctx_value {
+	struct bpf_crypto_ctx __kptr * ctx;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __crypto_ctx_value);
+	__uint(max_entries, 1);
+} __crypto_ctx_map SEC(".maps");
+
+static inline struct __crypto_ctx_value *crypto_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__crypto_ctx_map, &key);
+}
+
+static inline int crypto_ctx_insert(struct bpf_crypto_ctx *ctx)
+{
+	struct __crypto_ctx_value local, *v;
+	struct bpf_crypto_ctx *old;
+	u32 key = 0;
+	int err;
+
+	local.ctx = NULL;
+	err = bpf_map_update_elem(&__crypto_ctx_map, &key, &local, 0);
+	if (err) {
+		bpf_crypto_ctx_release(ctx);
+		return err;
+	}
+
+	v = bpf_map_lookup_elem(&__crypto_ctx_map, &key);
+	if (!v) {
+		bpf_crypto_ctx_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_crypto_ctx_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _CRYPTO_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
new file mode 100644
index 000000000000..8bf5b6b87410
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
@@ -0,0 +1,200 @@
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
+unsigned char crypto_key[16];
+char dst[16] = {};
+int status;
+
+static int skb_dynptr_validate(struct __sk_buff *skb, struct bpf_dynptr *psrc)
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
+	/* let's make sure that 16 bytes of payload are in the linear part of skb */
+	bpf_skb_pull_data(skb, offset + 16);
+	bpf_dynptr_from_skb(skb, 0, psrc);
+	bpf_dynptr_adjust(psrc, offset, offset + 16);
+
+	return 0;
+}
+
+SEC("fentry.s/bpf_fentry_test1")
+int BPF_PROG(skb_crypto_setup)
+{
+	struct bpf_crypto_ctx *cctx;
+	struct bpf_dynptr key = {};
+	int err = 0;
+
+	status = 0;
+
+	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
+	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	err = crypto_ctx_insert(cctx);
+	if (err && err != -EEXIST)
+		status = err;
+
+	return 0;
+}
+
+SEC("fentry.s/bpf_fentry_test1")
+int BPF_PROG(crypto_release)
+{
+	struct bpf_crypto_ctx *cctx;
+	struct bpf_dynptr key = {};
+	int err = 0;
+
+	status = 0;
+
+	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
+	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	bpf_crypto_ctx_release(cctx);
+
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("Unreleased reference")
+int BPF_PROG(crypto_acquire)
+{
+	struct bpf_crypto_ctx *cctx;
+	struct bpf_dynptr key = {};
+	int err = 0;
+
+	status = 0;
+
+	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
+	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
+
+	if (!cctx) {
+		status = err;
+		return 0;
+	}
+
+	cctx = bpf_crypto_ctx_acquire(cctx);
+	if (!cctx)
+		return -EINVAL;
+
+	bpf_crypto_ctx_release(cctx);
+
+	return 0;
+}
+
+SEC("tc")
+int decrypt_sanity(struct __sk_buff *skb)
+{
+	struct __crypto_ctx_value *v;
+	struct bpf_crypto_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+	int err;
+
+	err = skb_dynptr_validate(skb, &psrc);
+	if (err < 0) {
+		status = err;
+		return TC_ACT_SHOT;
+	}
+
+	v = crypto_ctx_value_lookup();
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
+	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
+	/* iv dynptr has to be initialized with 0 size, but proper memory region
+	 * has to be provided anyway
+	 */
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
+
+	return TC_ACT_SHOT;
+}
+
+SEC("tc")
+int encrypt_sanity(struct __sk_buff *skb)
+{
+	struct __crypto_ctx_value *v;
+	struct bpf_crypto_ctx *ctx;
+	struct bpf_dynptr psrc, pdst, iv;
+	int err;
+
+	status = 0;
+
+	err = skb_dynptr_validate(skb, &psrc);
+	if (err < 0) {
+		status = err;
+		return TC_ACT_SHOT;
+	}
+
+	v = crypto_ctx_value_lookup();
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
+	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
+	/* iv dynptr has to be initialized with 0 size, but proper memory region
+	 * has to be provided anyway
+	 */
+	bpf_dynptr_from_mem(dst, 0, 0, &iv);
+
+	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
+
+	return TC_ACT_SHOT;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.39.3


