Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A54702CE
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbhLJObO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 09:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242149AbhLJObO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 09:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639146458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeYVFn3C/kHLoloeDuy+DYyyuZygKIHXuCGMV5j00so=;
        b=RxMZ4QstZEIf/6ZGDCwJ6mR8Hh1fXb59wt64OEGl9KnNuqmNWFMjQ9b3+QpUupvPHmy80o
        PJ7ZIXIXZ4kg6v2sFohDEfQ+C3Iz1ZXVZolwHTvCCvFLh2esb6u24TloXH5tVVbSaAlZ46
        0e4Wv7CHLBcBMzoUS2HztOqbKPxb/Ec=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-EddzMFlZOU2L-oSS1Zrr-w-1; Fri, 10 Dec 2021 09:27:37 -0500
X-MC-Unique: EddzMFlZOU2L-oSS1Zrr-w-1
Received: by mail-ed1-f69.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so8402261ede.0
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 06:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HeYVFn3C/kHLoloeDuy+DYyyuZygKIHXuCGMV5j00so=;
        b=4906sADThr7kJudyXmbm72yM2tbKa9nVgXgEldVzeGgIJ/yB0mowK7DwL9YccG+zfW
         hICBsobY1H+NvXEfrTkbzTTCHPvNyRnQNiX4H/vs1JrRGq3OwEkIE6nNp/Rgf9Q5otFN
         klMfnHyQlAJubijpNAh+nnmGBK+fszNfWpz1CN/uYMYlTQq1T6t9E9oBYm4WjBg1Hhor
         rPLZ7upgua4IRFQL6p97REpPNd80gWK0n1zQsGjRyRU4P13zMpa6Dc8I6VXgVJ7lLlq6
         5ohBa8ZlNXZv45pjgp0wyy72zGS9mg8Fk/4FEITX32aFBxhaZC8PeeIWzEVnY00CjdGA
         UtDg==
X-Gm-Message-State: AOAM533SuDX3w+lMG4OS7y1u7oyom4tPnTIB3hEa09hciXY3i/Xyg2D8
        JRXLTX9Vw/sohbeO8brwXtSVPWi3KTYs20AWezSUjQOM/HmQRbR6CNmkIpf5NGfST2nr+XcCdrZ
        Hx/Ly4OpLGzsU
X-Received: by 2002:a05:6402:5156:: with SMTP id n22mr39515625edd.222.1639146455837;
        Fri, 10 Dec 2021 06:27:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxinPCiE2Kz0RkR9yMgt+6KLn4ZFACvVqNCbU6KsM8lYXopuZ55BTLBL2yWwTu1MciwC+uIkA==
X-Received: by 2002:a05:6402:5156:: with SMTP id n22mr39515418edd.222.1639146454079;
        Fri, 10 Dec 2021 06:27:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f7sm1542117edw.44.2021.12.10.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:27:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DA2E51804A2; Fri, 10 Dec 2021 15:20:48 +0100 (CET)
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
Subject: [PATCH bpf-next v2 7/8] selftests/bpf: Add selftest for XDP_REDIRECT in bpf_prog_run()
Date:   Fri, 10 Dec 2021 15:20:07 +0100
Message-Id: <20211210142008.76981-8-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211210142008.76981-1-toke@redhat.com>
References: <20211210142008.76981-1-toke@redhat.com>
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
 .../bpf/prog_tests/xdp_do_redirect.c          | 74 +++++++++++++++++++
 .../bpf/progs/test_xdp_do_redirect.c          | 34 +++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
new file mode 100644
index 000000000000..c2effcf076a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <net/if.h>
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
+#define NUM_PKTS 10
+void test_xdp_do_redirect(void)
+{
+	struct test_xdp_do_redirect *skel = NULL;
+	struct ipv6_packet data = pkt_v6;
+	struct xdp_md ctx_in = { .data_end = sizeof(data) };
+	__u8 dst_mac[ETH_ALEN] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
+	__u8 src_mac[ETH_ALEN] = {0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .ctx_in = &ctx_in,
+			    .ctx_size_in = sizeof(ctx_in),
+			    .flags = BPF_F_TEST_XDP_DO_REDIRECT,
+			    .repeat = NUM_PKTS,
+		);
+	int err, prog_fd, ifindex_src, ifindex_dst;
+	struct bpf_link *link;
+
+	memcpy(data.eth.h_dest, dst_mac, ETH_ALEN);
+	memcpy(data.eth.h_source, src_mac, ETH_ALEN);
+
+	skel = test_xdp_do_redirect__open();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+
+	SYS("ip link add veth_src type veth peer name veth_dst");
+	SYS("ip link set dev veth_src up");
+	SYS("ip link set dev veth_dst up");
+
+	ifindex_src = if_nametoindex("veth_src");
+	ifindex_dst = if_nametoindex("veth_dst");
+	if (!ASSERT_NEQ(ifindex_src, 0, "ifindex_src") ||
+	    !ASSERT_NEQ(ifindex_dst, 0, "ifindex_dst"))
+		goto fail;
+
+	memcpy(skel->rodata->expect_dst, dst_mac, ETH_ALEN);
+	skel->rodata->ifindex_out = ifindex_src;
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
+	ASSERT_EQ(skel->bss->pkts_seen, NUM_PKTS, "pkt_count");
+fail:
+	system("ip link del dev veth_src");
+	test_xdp_do_redirect__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
new file mode 100644
index 000000000000..254ebf523f37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#define ETH_ALEN 6
+const volatile int ifindex_out;
+const volatile __u8 expect_dst[ETH_ALEN];
+volatile int pkts_seen = 0;
+
+SEC("xdp")
+int xdp_redirect_notouch(struct xdp_md *xdp)
+{
+	return bpf_redirect(ifindex_out, 0);
+}
+
+SEC("xdp")
+int xdp_count_pkts(struct xdp_md *xdp)
+{
+	void *data = (void *)(long)xdp->data;
+	void *data_end = (void *)(long)xdp->data_end;
+	struct ethhdr *eth = data;
+	int i;
+
+	if (eth + 1 > data_end)
+		return XDP_ABORTED;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		if (expect_dst[i] != eth->h_dest[i])
+			return XDP_ABORTED;
+	pkts_seen++;
+	return XDP_DROP;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.0

