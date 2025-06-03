Return-Path: <bpf+bounces-59525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072BAACCC68
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD81759DB
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860FF1E5B99;
	Tue,  3 Jun 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8vkgwvQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352E1E491B;
	Tue,  3 Jun 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972794; cv=none; b=sPZ3D5olnzWXqZkqTthNlbggIxgQoj+c8QSmhaT3xEv3x9JUXfJ0oZcXhFDIhNtd56Yqp99kAzrthYqhscE4fr3zsnRaxKV7U0HP+bbJavklZgbkbkwUPCA4EXlSmE86BKd0c4jp667+cx5wuWuOO8cVnzskj8tw0l+3w9AVhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972794; c=relaxed/simple;
	bh=cQMSEfxHGG8Dm77wIoKa4HHmMVOd9aj8W1pMm7ROYXA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlajiS82JEFQgzZ/67hhgUCA99B47NlHwmLYpJF4bq6bH+cDariAoiGW+1Z1VCZo7uzdDh8r4KLcm8dGDiWSB+zv/ldrV5yub4ca5YOivv55T/74GAFoX7vIPqDqGmayjRFlVzBm3osMZFJPH72V5RbMsDBPQECpOt6HrGljoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8vkgwvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51854C4CEED;
	Tue,  3 Jun 2025 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748972793;
	bh=cQMSEfxHGG8Dm77wIoKa4HHmMVOd9aj8W1pMm7ROYXA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G8vkgwvQQmQjsUHwO/cWRaqTBwd1GE+s2ZZDvrDX8MPDYaU6cYTfe5+i3eaH+D/qE
	 T+C0lRDYaHUMLVtLwckhTLmY0ZZj4apRnB6PRKD2ycnK7pNT/nDcjwrm0pa0Byo+c3
	 ZSxiJ/v8vSUIHzyeer5qVSfZ8oGRNVUkWdVnkNK3DnkYef0uGPI+hu/th0KbBv2wDd
	 EJx1hvsrN5WEq7zA9kSEpwz1kLsNidpTkbNs4KUOdURR+YgShiJ0IZHmuiCaiscWYz
	 4Q6yp4mCf4t0R/2eBvLMTpoQrv0IF5xFeOp+P4Z2tmrJsjaJIdOKvSr81M3SBgEEfW
	 kdYCEYsRZBoQQ==
Subject: [PATCH bpf-next V1 6/7] bpf: selftests: Add rx_meta store kfuncs
 selftest
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Tue, 03 Jun 2025 19:46:28 +0200
Message-ID: <174897278834.1677018.7674555608317742053.stgit@firesoul>
In-Reply-To: <174897271826.1677018.9096866882347745168.stgit@firesoul>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce bpf selftests for the XDP rx_meta store kfuncs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/xdp_rxmeta.c  |  166 ++++++++++++++++++++
 .../selftests/bpf/progs/xdp_rxmeta_receiver.c      |   44 +++++
 .../selftests/bpf/progs/xdp_rxmeta_redirect.c      |   48 ++++++
 3 files changed, 258 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_rxmeta.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_rxmeta_receiver.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_rxmeta.c b/tools/testing/selftests/bpf/prog_tests/xdp_rxmeta.c
new file mode 100644
index 000000000000..544279b58e10
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_rxmeta.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <bpf/btf.h>
+#include <linux/if_link.h>
+
+#include "xdp_rxmeta_redirect.skel.h"
+#include "xdp_rxmeta_receiver.skel.h"
+
+#define LOCAL_NETNS_NAME	"local"
+#define FWD_NETNS_NAME		"forward"
+#define DST_NETNS_NAME		"dest"
+
+#define LOCAL_NAME	"local"
+#define FWD0_NAME	"fwd0"
+#define FWD1_NAME	"fwd1"
+#define DST_NAME	"dest"
+
+#define LOCAL_MAC	"00:00:00:00:00:01"
+#define FWD0_MAC	"00:00:00:00:00:02"
+#define FWD1_MAC	"00:00:00:00:01:01"
+#define DST_MAC		"00:00:00:00:01:02"
+
+#define LOCAL_ADDR	"10.0.0.1"
+#define FWD0_ADDR	"10.0.0.2"
+#define FWD1_ADDR	"20.0.0.1"
+#define DST_ADDR	"20.0.0.2"
+
+#define PREFIX_LEN	"8"
+#define NUM_PACKETS	10
+
+static int run_ping(const char *dst, int num_ping)
+{
+	SYS(fail, "ping -c%d -W1 -i0.5 %s >/dev/null", num_ping, dst);
+	return 0;
+fail:
+	return -1;
+}
+
+void test_xdp_rxmeta(void)
+{
+	struct xdp_rxmeta_redirect *skel_redirect = NULL;
+	struct xdp_rxmeta_receiver *skel_receiver = NULL;
+	struct bpf_devmap_val val = {};
+	struct bpf_program *prog;
+	__u32 key = 0, stats;
+	struct nstoken *tok;
+	int ret, index;
+
+	SYS(out, "ip netns add " LOCAL_NETNS_NAME);
+	SYS(out, "ip netns add " FWD_NETNS_NAME);
+	SYS(out, "ip netns add " DST_NETNS_NAME);
+
+	tok = open_netns(LOCAL_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "ip link add " LOCAL_NAME " type veth peer " FWD0_NAME);
+	SYS(out, "ip link set " FWD0_NAME " netns " FWD_NETNS_NAME);
+	SYS(out, "ip link set dev " LOCAL_NAME " address " LOCAL_MAC);
+	SYS(out, "ip addr add " LOCAL_ADDR "/" PREFIX_LEN " dev " LOCAL_NAME);
+	SYS(out, "ip link set dev " LOCAL_NAME " up");
+	SYS(out, "ip route add default via " FWD0_ADDR);
+	close_netns(tok);
+
+	tok = open_netns(DST_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "ip link add " DST_NAME " type veth peer " FWD1_NAME);
+	SYS(out, "ip link set " FWD1_NAME " netns " FWD_NETNS_NAME);
+	SYS(out, "ip link set dev " DST_NAME " address " DST_MAC);
+	SYS(out, "ip addr add " DST_ADDR "/" PREFIX_LEN " dev " DST_NAME);
+	SYS(out, "ip link set dev " DST_NAME " up");
+	SYS(out, "ip route add default via " FWD1_ADDR);
+
+	skel_receiver = xdp_rxmeta_receiver__open();
+	if (!ASSERT_OK_PTR(skel_receiver, "open skel_receiver"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel_receiver->obj,
+						"xdp_rxmeta_receiver");
+	index = if_nametoindex(DST_NAME);
+	bpf_program__set_ifindex(prog, index);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+
+	if (!ASSERT_OK(xdp_rxmeta_receiver__load(skel_receiver),
+		       "load skel_receiver"))
+		goto out;
+
+	ret = bpf_xdp_attach(index,
+			     bpf_program__fd(skel_receiver->progs.xdp_rxmeta_receiver),
+			     XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach rx_meta_redirect"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(FWD_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	SYS(out, "ip link set dev " FWD0_NAME " address " FWD0_MAC);
+	SYS(out, "ip addr add " FWD0_ADDR "/" PREFIX_LEN " dev " FWD0_NAME);
+	SYS(out, "ip link set dev " FWD0_NAME " up");
+
+	SYS(out, "ip link set dev " FWD1_NAME " address " FWD1_MAC);
+	SYS(out, "ip addr add " FWD1_ADDR "/" PREFIX_LEN " dev " FWD1_NAME);
+	SYS(out, "ip link set dev " FWD1_NAME " up");
+
+	SYS(out, "sysctl -qw net.ipv4.conf.all.forwarding=1");
+
+	skel_redirect = xdp_rxmeta_redirect__open();
+	if (!ASSERT_OK_PTR(skel_redirect, "open skel_redirect"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel_redirect->obj,
+						"xdp_rxmeta_redirect");
+	index = if_nametoindex(FWD0_NAME);
+	bpf_program__set_ifindex(prog, index);
+	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
+
+	if (!ASSERT_OK(xdp_rxmeta_redirect__load(skel_redirect),
+		       "load skel_redirect"))
+		goto out;
+
+	val.ifindex = if_nametoindex(FWD1_NAME);
+	ret = bpf_map_update_elem(bpf_map__fd(skel_redirect->maps.dev_map),
+				  &key, &val, 0);
+	if (!ASSERT_GE(ret, 0, "bpf_map_update_elem"))
+		goto out;
+
+	ret = bpf_xdp_attach(index,
+			     bpf_program__fd(skel_redirect->progs.xdp_rxmeta_redirect),
+			     XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach rxmeta_redirect"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(LOCAL_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	if (!ASSERT_OK(run_ping(DST_ADDR, NUM_PACKETS), "ping"))
+		goto out;
+
+	close_netns(tok);
+	tok = open_netns(DST_NETNS_NAME);
+	if (!ASSERT_OK_PTR(tok, "setns"))
+		goto out;
+
+	ret = bpf_map__lookup_elem(skel_receiver->maps.stats,
+				   &key, sizeof(key),
+				   &stats, sizeof(stats), 0);
+	if (!ASSERT_GE(ret, 0, "bpf_map_update_elem"))
+		goto out;
+
+	ASSERT_EQ(stats, NUM_PACKETS, "rx_meta stats");
+out:
+	xdp_rxmeta_redirect__destroy(skel_redirect);
+	xdp_rxmeta_receiver__destroy(skel_receiver);
+	if (tok)
+		close_netns(tok);
+	SYS_NOFAIL("ip netns del " LOCAL_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " FWD_NETNS_NAME);
+	SYS_NOFAIL("ip netns del " DST_NETNS_NAME);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_rxmeta_receiver.c b/tools/testing/selftests/bpf/progs/xdp_rxmeta_receiver.c
new file mode 100644
index 000000000000..1033fa558970
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_rxmeta_receiver.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
+				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
+					 __u64 *timestamp) __ksym;
+
+#define RX_TIMESTAMP	0x12345678
+#define RX_HASH		0x1234
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} stats SEC(".maps");
+
+SEC("xdp")
+int xdp_rxmeta_receiver(struct xdp_md *ctx)
+{
+	enum xdp_rss_hash_type rss_type;
+	__u64 timestamp;
+	__u32 hash;
+
+	if (!bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type) &&
+	    !bpf_xdp_metadata_rx_timestamp(ctx, &timestamp)) {
+		if (hash == RX_HASH && rss_type == XDP_RSS_L4_TCP &&
+		    timestamp == RX_TIMESTAMP) {
+			__u32 *val, key = 0;
+
+			val = bpf_map_lookup_elem(&stats, &key);
+			if (val)
+				 __sync_add_and_fetch(val, 1);
+		}
+	}
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c b/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c
new file mode 100644
index 000000000000..1606454a1fbc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_rxmeta_redirect.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+extern void bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
+				  enum xdp_rss_hash_type rss_type) __ksym;
+extern void bpf_xdp_store_rx_ts(struct xdp_md *ctx, __u64 ts) __ksym;
+
+#define RX_TIMESTAMP	0x12345678
+#define RX_HASH		0x1234
+
+#define ETH_ALEN	6
+#define ETH_P_IP	0x0800
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_devmap_val));
+	__uint(max_entries, 1);
+} dev_map SEC(".maps");
+
+SEC("xdp")
+int xdp_rxmeta_redirect(struct xdp_md *ctx)
+{
+	__u8 src_mac[] = { 0x00, 0x00, 0x00, 0x00, 0x01, 0x01 };
+	__u8 dst_mac[] = { 0x00, 0x00, 0x00, 0x00, 0x01, 0x02 };
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct ethhdr *eh = data;
+
+	if (eh + 1 > (struct ethhdr *)data_end)
+		return XDP_DROP;
+
+	if (eh->h_proto != bpf_htons(ETH_P_IP))
+		return XDP_PASS;
+
+	__builtin_memcpy(eh->h_source, src_mac, ETH_ALEN);
+	__builtin_memcpy(eh->h_dest, dst_mac, ETH_ALEN);
+
+	bpf_xdp_store_rx_hash(ctx, RX_HASH, XDP_RSS_L4_TCP);
+	bpf_xdp_store_rx_ts(ctx, RX_TIMESTAMP);
+
+	return bpf_redirect_map(&dev_map, ctx->rx_queue_index, XDP_PASS);
+}
+
+char _license[] SEC("license") = "GPL";



