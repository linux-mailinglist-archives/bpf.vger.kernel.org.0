Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3C4833F4
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiACPId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 10:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233881AbiACPIb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 10:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641222511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liH+qN0WmF6KG3mO/mKBj0yNsvaPZ08gu8hDBnDNrZY=;
        b=Vij0pA4H7U5ZdAx7NRFmnu6z8hJpspKMX+XVb9hrybdR/AMlXXWUuj74BtcndNra6lvWOE
        JbgcHeCWo4YG6pvRjlba+SiyuvwlYkVv830b6lMFLLUo29+AoWKvM1y6CNoqNV8rdnvHD1
        8+Djktdzcf2aZJrEVECiLu5rGN8UezY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-NJaFhaqqOtOCH8rvadyakw-1; Mon, 03 Jan 2022 10:08:30 -0500
X-MC-Unique: NJaFhaqqOtOCH8rvadyakw-1
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso15850646edd.16
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 07:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=liH+qN0WmF6KG3mO/mKBj0yNsvaPZ08gu8hDBnDNrZY=;
        b=uMJQNQD5DLhrSUuzccRsvri1R9Drf6kXFywO/aZfsKhrLSn+3zgzD9qjIBMPuse2qt
         RKEpWmhOkuLvyTXQ60j52XvofoxXbpVwDQ68SSFAVHEDK0EA5Ii8rblAwxge+ClsbMLB
         Uy8Smr7uWoN7WRM47ZWIybc5BgYayAMsTioWVt/y671fgIrUdLo4W/whlMDHEYXxui1x
         3gKgGj7RKJHjpkbZ31lpRo99A5Bt0aBXFikJgKMB4XltS7VXhCK11DhIz+GadUh35ojj
         mmbKfYlWUaxyIF8lg1Q2LNvvY5fVW+ZcSDhCfZZesL08oWKwMeFoW+464Rx119PoKtJ5
         8LdA==
X-Gm-Message-State: AOAM5337+h330kxxc2LeWplz8O3ZOHm60CLqPHIiBs8BTAfwVnWDX+52
        xt2tJsqoGV8E+JWoYWzWdPv3nBUvCAAiVCTFGXZZxWPc4Jlx3cTTHyxb/AJeoEXNw7fLPfThZ1j
        J4ScxfXY0vyFs
X-Received: by 2002:a17:906:d552:: with SMTP id cr18mr36275500ejc.260.1641222507432;
        Mon, 03 Jan 2022 07:08:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsRVCvB++XaDGgB0IoilqLN7chbS8Duehkorg0cuF3gtkSNzcGZOpHIEx/bJEgW06PjwrcLw==
X-Received: by 2002:a17:906:d552:: with SMTP id cr18mr36275402ejc.260.1641222506100;
        Mon, 03 Jan 2022 07:08:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c12sm13989442edx.80.2022.01.03.07.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:08:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C6B85181F2A; Mon,  3 Jan 2022 16:08:22 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 7/7] selftests/bpf: Add selftest for XDP_REDIRECT in bpf_prog_run()
Date:   Mon,  3 Jan 2022 16:08:12 +0100
Message-Id: <20220103150812.87914-8-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103150812.87914-1-toke@redhat.com>
References: <20220103150812.87914-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a selftest for the XDP_REDIRECT facility in bpf_prog_run, that
redirects packets into a veth and counts them using an XDP program on the
other side of the veth pair.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../bpf/prog_tests/xdp_do_redirect.c          | 118 ++++++++++++++++++
 .../bpf/progs/test_xdp_do_redirect.c          |  39 ++++++
 2 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
new file mode 100644
index 000000000000..a587c351d495
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <net/if.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <linux/udp.h>
+#include <bpf/bpf_endian.h>
+#include "test_xdp_do_redirect.skel.h"
+
+#define SYS(fmt, ...)						\
+	({							\
+		char cmd[1024];					\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
+		if (!ASSERT_OK(system(cmd), cmd))		\
+			goto fail;				\
+	})
+
+struct udp_packet {
+	struct ethhdr eth;
+	struct ipv6hdr iph;
+	struct udphdr udp;
+	__u8 payload[64 - sizeof(struct udphdr)
+		     - sizeof(struct ethhdr) - sizeof(struct ipv6hdr)];
+} __packed;
+
+static struct udp_packet pkt_udp = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+	.eth.h_dest = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55},
+	.eth.h_source = {0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb},
+	.iph.version = 6,
+	.iph.nexthdr = IPPROTO_UDP,
+	.iph.payload_len = bpf_htons(sizeof(struct udp_packet)
+				     - offsetof(struct udp_packet, udp)),
+	.iph.hop_limit = 2,
+	.iph.saddr.s6_addr16 = {bpf_htons(0xfc00), 0, 0, 0, 0, 0, 0, bpf_htons(1)},
+	.iph.daddr.s6_addr16 = {bpf_htons(0xfc00), 0, 0, 0, 0, 0, 0, bpf_htons(2)},
+	.udp.source = bpf_htons(1),
+	.udp.dest = bpf_htons(1),
+	.udp.len = bpf_htons(sizeof(struct udp_packet)
+			     - offsetof(struct udp_packet, udp)),
+	.payload = {0x42}, /* receiver XDP program matches on this */
+};
+
+#define NUM_PKTS 3
+void test_xdp_do_redirect(void)
+{
+	struct test_xdp_do_redirect *skel = NULL;
+	struct xdp_md ctx_in = { .data_end = sizeof(pkt_udp) };
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &pkt_udp,
+			    .data_size_in = sizeof(pkt_udp),
+			    .ctx_in = &ctx_in,
+			    .ctx_size_in = sizeof(ctx_in),
+			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
+			    .repeat = NUM_PKTS,
+		);
+	int err, prog_fd, ifindex_src, ifindex_dst;
+	struct bpf_link *link;
+
+	skel = test_xdp_do_redirect__open();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+
+	/* We setup a veth pair that we can not only XDP_REDIRECT packets
+	 * between, but also route them. The test packet (defined above) has
+	 * address information so it will be routed back out the same interface
+	 * after it has been received, which will allow it to be picked up by
+	 * the XDP program on the destination interface.
+	 *
+	 * The XDP program we run with bpf_prog_run() will cycle through all
+	 * four return codes (DROP/PASS/TX/REDIRECT), so we should end up with
+	 * NUM_PKTS - 1 packets seen on the dst iface. We match the packets on
+	 * the UDP payload.
+	 */
+	SYS("ip link add veth_src type veth peer name veth_dst");
+	SYS("ip link set dev veth_src address 00:11:22:33:44:55");
+	SYS("ip link set dev veth_dst address 66:77:88:99:aa:bb");
+	SYS("ip link set dev veth_src up");
+	SYS("ip link set dev veth_dst up");
+	SYS("ip addr add dev veth_src fc00::1/64");
+	SYS("ip addr add dev veth_dst fc00::2/64");
+	SYS("ip neigh add fc00::2 dev veth_src lladdr 66:77:88:99:aa:bb");
+	SYS("sysctl -w net.ipv6.conf.all.forwarding=1");
+
+	ifindex_src = if_nametoindex("veth_src");
+	ifindex_dst = if_nametoindex("veth_dst");
+	if (!ASSERT_NEQ(ifindex_src, 0, "ifindex_src") ||
+	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
+		goto fail;
+
+	memcpy(skel->rodata->expect_dst, &pkt_udp.eth.h_dest, ETH_ALEN);
+	skel->rodata->ifindex_out = ifindex_src;
+	ctx_in.ingress_ifindex = ifindex_src;
+
+	if (!ASSERT_OK(test_xdp_do_redirect__load(skel), "load"))
+		goto fail;
+
+	link = bpf_program__attach_xdp(skel->progs.xdp_count_pkts, ifindex_dst);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		goto fail;
+	skel->links.xdp_count_pkts = link;
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_redirect_notouch);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ASSERT_OK(err, "prog_run"))
+		goto fail;
+
+	/* wait for the packets to be flushed */
+	kern_sync_rcu();
+
+	ASSERT_EQ(skel->bss->pkts_seen, NUM_PKTS - 1, "pkt_count");
+fail:
+	system("ip link del dev veth_src");
+	test_xdp_do_redirect__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
new file mode 100644
index 000000000000..f9ea587b0876
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#define ETH_ALEN 6
+const volatile int ifindex_out;
+const volatile __u8 expect_dst[ETH_ALEN];
+volatile int pkts_seen = 0;
+volatile int retcode = XDP_DROP;
+
+SEC("xdp")
+int xdp_redirect_notouch(struct xdp_md *xdp)
+{
+	if (retcode == XDP_REDIRECT)
+		bpf_redirect(ifindex_out, 0);
+	return retcode++;
+}
+
+SEC("xdp")
+int xdp_count_pkts(struct xdp_md *xdp)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	struct ipv6hdr *iph = (void *)(eth + 1);
+	struct udphdr *udp = (void *)(iph + 1);
+	__u8 *payload = (void *)(udp + 1);
+	int i;
+
+	if (payload + 1 > data_end)
+		return XDP_ABORTED;
+
+	if (iph->nexthdr == IPPROTO_UDP && *payload == 0x42)
+		pkts_seen++;
+
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

