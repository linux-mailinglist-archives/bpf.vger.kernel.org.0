Return-Path: <bpf+bounces-59002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A820AAC52F4
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663B69E0DB0
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316C28000E;
	Tue, 27 May 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp4gAHip"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24427F72C;
	Tue, 27 May 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362785; cv=none; b=Ap5tTun0M+6jJRxpOQdE2PABJ4+2BZd1HS0Ystepd+5Zh1R6x+l256SYNqYAiCqEwQqm5qqt9yyIarb2TD4oSWBN2nqqUpYBG614rXEhFrpSmM5bI2cn3zBLMhLq1oanb+g4oLhtbBsAN+M+Tid2vaTzg1P7sy6KKaR/ZMpZiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362785; c=relaxed/simple;
	bh=GxJnCoCywSfj04E5CZqm/ZtgXqq8qJEOhMHdpE4tz0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovVcAllsaOxlv5Xa/RMerP8tXfSM5nWOyL4/WF5FoZLDiDs4oByVc9ba99McGtAjS+9ePLGSzszSQE6gvnsfS2RyEcIgiEo4WnyO8rIFoUZKDbDrc0e30ebcxDm8be+Iw9U4j6xAI3hC8/rsgUAaQDdYei3TwzIFVXLQy8wKKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp4gAHip; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2524536b3a.1;
        Tue, 27 May 2025 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748362781; x=1748967581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90R6A++gtPZWq67DZypChaSVtDu+EZq/m8b2334jUgI=;
        b=Lp4gAHip5qU5A+t6zbORQVPryjxWqfay5KzZywGFnDznMgJUWZhhaRXQMGyi2OlcNs
         18tULon7QPrz9KdkBqq6RDSYBkptSWaESN+28gAaXSF0G7BeSDTigNRsz+RbQf41SMwD
         c7d8rQw6Jxw/J3IOt8qyub9MzDWjwqRw6OuoN1fCaxThsz4rNu+TkN7U1Ifmobca8W2e
         68tClmFOaRYHR/8ZLtkcvAOkpiwoBGK5gy1fDrHdqaIRraAokRdmuwXqSC20nFMish3H
         7WduUpXfxvJgy7veyfETk7SBvYDwsQTKwsIgqHQtj74F1IlJoDmzLNoN22OdgPOijHpS
         n+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362781; x=1748967581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90R6A++gtPZWq67DZypChaSVtDu+EZq/m8b2334jUgI=;
        b=NWxpPXls7BQ86C+Y6JhT6QAv1AF4qPbL0rpnyWED605vvVpCSA3XRKMCPWt+d1yg9i
         CnIIz1TvuCyavM6ZYvMlZAeytqfCLeURlreU7hWNvmqNdGD938t2n0xVJt8pwojk7nmd
         tN2UwE60myB9TfiqQoGCq/5JwXILAhLnBn7tbmC07sBiIlgWjAzjep4ioQBZe4rMm4Ff
         97ZNXmqrx6PMnKxGqICZ6pUtM1h2wFcYLfVPl/JIG7CJOqaZJ8nPAtWDh9BLN0vI7SeU
         U/UBHOIYoe/AOrW0fzvZkJoOM8skidc+GexqLdlxOtIJEDHd5MeiO7oBwW3udipOK6zt
         Zxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWB6e+KwRGn9yodc98fljqaoi4pDVODniv/bofp/1TS6zMN9rhGOmtSKZVzxSb8JQr46D+XnZWCgoVgYfWk@vger.kernel.org, AJvYcCXfZAiadJJI+awk84v5xROxBb1t6fuds7ybSGS1svgjprflzVBMdoVRL2pXZ9ifcoSP/oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjyt+7RQDD3VUP5aEpeG/yMlWE52cmIFP8CsqV8FCylzoC/vs
	g+1rR5OqOQgsSYrc5zU4VxWndhDKU4OJ0qU99XyVSzXzDAXwz1lDLLpGtThv2BOU32k=
X-Gm-Gg: ASbGncs5BLrE0KQST4oXUvwFRUyTILtfIBzaSyQxTEs9P+HEWgeFxPZSYhn2OfFlgeM
	4jeY0tcOh+eb/AYn6ia0WskBaCbSAzkgSKV8pP7cNfhDPs4AafwGEsZ8CpjsFUxDezAiZm73Vvn
	k29zY7lvOKEhiWSZLKeUI+kp+dloR8Y5Rf1sVtRlSmR+6VBLDjaZzB90qUXsmIy7kWhmVRnbieU
	xTct2KFeKWw/wATbxfdiu1AObIKl3VfU4cBUAmuleDmHjvfIN4OPYTx5KWmhMHqT0rCZo3Zg6eK
	DUS2gw6bIcMus5Xn2BL4KPCwMDVtbdCld3/K8yWpStoKAgf9c4Kftb0jpivX9KBv+GM=
X-Google-Smtp-Source: AGHT+IH2t382sXXANLRskfg4maHJpEmaHwmnBsYZa8bvr+4T4Mg80xVzehbmSdLKZjYSSBfMJg+QRA==
X-Received: by 2002:a05:6a00:1148:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-745fe0c7e82mr20582541b3a.21.1748362780825;
        Tue, 27 May 2025 09:19:40 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52e0:fc81:ee8a:bb3f])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7462aefb414sm1118121b3a.34.2025.05.27.09.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:19:40 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests for virtio-net
Date: Tue, 27 May 2025 23:19:04 +0700
Message-ID: <20250527161904.75259-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527161904.75259-1-minhquangbui99@gmail.com>
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a test to test the virtio-net rx when there is a XDP socket
bound to it. There are tests for both copy mode and zerocopy mode, both
cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 .../selftests/drivers/net/hw/.gitignore       |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |  12 +-
 .../drivers/net/hw/xsk_receive.bpf.c          |  43 ++
 .../selftests/drivers/net/hw/xsk_receive.c    | 398 ++++++++++++++++++
 .../selftests/drivers/net/hw/xsk_receive.py   |  75 ++++
 5 files changed, 530 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_receive.py

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 6942bf575497..c32271faecff 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iou-zcrx
 ncdevmem
+xsk_receive.skel.h
+xsk_receive
+tools
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index df2c047ffa90..964edbb3b79f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
-TEST_GEN_FILES = iou-zcrx
+TEST_GEN_FILES = \
+	iou-zcrx \
+	xsk_receive \
+	#
 
 TEST_PROGS = \
 	csum.py \
@@ -20,6 +23,7 @@ TEST_PROGS = \
 	rss_input_xfrm.py \
 	tso.py \
 	xsk_reconfig.py \
+	xsk_receive.py \
 	#
 
 TEST_FILES := \
@@ -48,3 +52,9 @@ include ../../../net/ynl.mk
 include ../../../net/bpf.mk
 
 $(OUTPUT)/iou-zcrx: LDLIBS += -luring
+
+$(OUTPUT)/xsk_receive.skel.h: xsk_receive.bpf.o
+	bpftool gen skeleton xsk_receive.bpf.o > xsk_receive.skel.h
+
+$(OUTPUT)/xsk_receive: xsk_receive.skel.h
+$(OUTPUT)/xsk_receive: LDLIBS += -lbpf
diff --git a/tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c b/tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
new file mode 100644
index 000000000000..462046d95bfe
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include <linux/in.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} xsk_map SEC(".maps");
+
+SEC("xdp.frags")
+int dummy_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+SEC("xdp.frags")
+int redirect_xsk_prog(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct ethhdr *eth = data;
+	struct iphdr *iph;
+
+	if (data + sizeof(*eth) + sizeof(*iph) > data_end)
+		return XDP_PASS;
+
+	if (bpf_htons(eth->h_proto) != ETH_P_IP)
+		return XDP_PASS;
+
+	iph = data + sizeof(*eth);
+	if (iph->protocol != IPPROTO_UDP)
+		return XDP_PASS;
+
+	return bpf_redirect_map(&xsk_map, 0, XDP_DROP);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/hw/xsk_receive.c b/tools/testing/selftests/drivers/net/hw/xsk_receive.c
new file mode 100644
index 000000000000..96213ceeda5c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_receive.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <poll.h>
+#include <stdatomic.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <net/if.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <linux/if_xdp.h>
+
+#include "xsk_receive.skel.h"
+
+#define load_acquire(p) \
+	atomic_load_explicit((_Atomic typeof(*(p)) *)(p), memory_order_acquire)
+
+#define store_release(p, v) \
+	atomic_store_explicit((_Atomic typeof(*(p)) *)(p), v, \
+			      memory_order_release)
+
+#define UMEM_CHUNK_SIZE 0x1000
+#define BUFFER_SIZE 0x2000
+
+#define SERVER_PORT 8888
+#define CLIENT_PORT 9999
+
+const int num_entries = 256;
+const char *pass_msg = "PASS";
+
+int cfg_client;
+int cfg_server;
+char *cfg_server_ip;
+char *cfg_client_ip;
+int cfg_ifindex;
+int cfg_redirect;
+int cfg_zerocopy;
+
+struct xdp_sock_context {
+	int xdp_sock;
+	void *umem_region;
+	void *rx_ring;
+	void *fill_ring;
+	struct xdp_mmap_offsets off;
+};
+
+struct xdp_sock_context *setup_xdp_socket(int ifindex)
+{
+	struct xdp_mmap_offsets off;
+	void *rx_ring, *fill_ring;
+	struct xdp_umem_reg umem_reg = {};
+	int optlen = sizeof(off);
+	int umem_len, sock, ret, i;
+	void *umem_region;
+	uint32_t *fr_producer;
+	uint64_t *addr;
+	struct sockaddr_xdp sxdp = {
+		.sxdp_family = AF_XDP,
+		.sxdp_ifindex = ifindex,
+		.sxdp_queue_id = 0,
+		.sxdp_flags = XDP_USE_SG,
+	};
+	struct xdp_sock_context *ctx;
+
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		error(1, 0, "malloc()");
+
+	if (cfg_zerocopy)
+		sxdp.sxdp_flags |= XDP_ZEROCOPY;
+	else
+		sxdp.sxdp_flags |= XDP_COPY;
+
+	umem_len = UMEM_CHUNK_SIZE * num_entries;
+	umem_region = mmap(0, umem_len, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (umem_region == MAP_FAILED)
+		error(1, errno, "mmap() umem");
+	ctx->umem_region = umem_region;
+
+	sock = socket(AF_XDP, SOCK_RAW, 0);
+	if (sock < 0)
+		error(1, errno, "socket() XDP");
+	ctx->xdp_sock = sock;
+
+	ret = setsockopt(sock, SOL_XDP, XDP_RX_RING, &num_entries,
+			 sizeof(num_entries));
+	if (ret < 0)
+		error(1, errno, "setsockopt() XDP_RX_RING");
+
+	ret = setsockopt(sock, SOL_XDP, XDP_UMEM_COMPLETION_RING, &num_entries,
+			 sizeof(num_entries));
+	if (ret < 0)
+		error(1, errno, "setsockopt() XDP_UMEM_COMPLETION_RING");
+
+	ret = setsockopt(sock, SOL_XDP, XDP_UMEM_FILL_RING, &num_entries,
+			 sizeof(num_entries));
+	if (ret < 0)
+		error(1, errno, "setsockopt() XDP_UMEM_FILL_RING");
+
+	ret = getsockopt(sock, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
+	if (ret < 0)
+		error(1, errno, "getsockopt()");
+	ctx->off = off;
+
+	rx_ring = mmap(0, off.rx.desc + num_entries * sizeof(struct xdp_desc),
+		       PROT_READ | PROT_WRITE, MAP_SHARED, sock,
+		       XDP_PGOFF_RX_RING);
+	if (rx_ring == (void *)-1)
+		error(1, errno, "mmap() rx-ring");
+	ctx->rx_ring = rx_ring;
+
+	fill_ring = mmap(0, off.fr.desc + num_entries * sizeof(uint64_t),
+			 PROT_READ | PROT_WRITE, MAP_SHARED, sock,
+			 XDP_UMEM_PGOFF_FILL_RING);
+	if (fill_ring == (void *)-1)
+		error(1, errno, "mmap() fill-ring");
+	ctx->fill_ring = fill_ring;
+
+	umem_reg.addr = (unsigned long long)ctx->umem_region;
+	umem_reg.len = umem_len;
+	umem_reg.chunk_size = UMEM_CHUNK_SIZE;
+	ret = setsockopt(sock, SOL_XDP, XDP_UMEM_REG, &umem_reg,
+			 sizeof(umem_reg));
+	if (ret < 0)
+		error(1, errno, "setsockopt() XDP_UMEM_REG");
+
+	i = 0;
+	while (1) {
+		ret = bind(sock, (const struct sockaddr *)&sxdp, sizeof(sxdp));
+		if (!ret)
+			break;
+
+		if (errno == EBUSY && i < 3) {
+			i++;
+			sleep(1);
+		} else {
+			error(1, errno, "bind() XDP");
+		}
+	}
+
+	/* Submit all umem entries to fill ring */
+	addr = fill_ring + off.fr.desc;
+	for (i = 0; i < umem_len; i += UMEM_CHUNK_SIZE) {
+		*addr = i;
+		addr++;
+	}
+	fr_producer = fill_ring + off.fr.producer;
+	store_release(fr_producer, num_entries);
+
+	return ctx;
+}
+
+void setup_xdp_prog(int sock, int ifindex, int redirect)
+{
+	struct xsk_receive_bpf *bpf;
+	int key, ret;
+
+	bpf = xsk_receive_bpf__open_and_load();
+	if (!bpf)
+		error(1, 0, "open eBPF");
+
+	key = 0;
+	ret = bpf_map__update_elem(bpf->maps.xsk_map, &key, sizeof(key),
+				   &sock, sizeof(sock), 0);
+	if (ret < 0)
+		error(1, errno, "eBPF map update");
+
+	if (redirect) {
+		ret = bpf_xdp_attach(ifindex,
+				bpf_program__fd(bpf->progs.redirect_xsk_prog),
+				0, NULL);
+		if (ret < 0)
+			error(1, errno, "attach eBPF");
+	} else {
+		ret = bpf_xdp_attach(ifindex,
+				     bpf_program__fd(bpf->progs.dummy_prog),
+				     0, NULL);
+		if (ret < 0)
+			error(1, errno, "attach eBPF");
+	}
+}
+
+void send_pass_msg(int sock)
+{
+	int ret;
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr = inet_addr(cfg_client_ip),
+		.sin_port = htons(CLIENT_PORT),
+	};
+
+	ret = sendto(sock, pass_msg, sizeof(pass_msg), 0,
+		     (const struct sockaddr *)&addr, sizeof(addr));
+	if (ret < 0)
+		error(1, errno, "sendto()");
+}
+
+void server_recv_xdp(struct xdp_sock_context *ctx, int udp_sock)
+{
+	int ret;
+	struct pollfd fds = {
+		.fd = ctx->xdp_sock,
+		.events = POLLIN,
+	};
+
+	ret = poll(&fds, 1, -1);
+	if (ret < 0)
+		error(1, errno, "poll()");
+
+	if (fds.revents & POLLIN) {
+		uint32_t *producer_ptr = ctx->rx_ring + ctx->off.rx.producer;
+		uint32_t *consumer_ptr = ctx->rx_ring + ctx->off.rx.consumer;
+		uint32_t producer, consumer;
+		struct xdp_desc *desc;
+
+		producer = load_acquire(producer_ptr);
+		consumer = load_acquire(consumer_ptr);
+
+		printf("Receive %d XDP buffers\n", producer - consumer);
+
+		store_release(consumer_ptr, producer);
+	} else {
+		error(1, 0, "unexpected poll event: %d", fds.revents);
+	}
+
+	send_pass_msg(udp_sock);
+}
+
+void server_recv_udp(int sock)
+{
+	char *buffer;
+	int i, ret;
+
+	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (buffer == MAP_FAILED)
+		error(1, errno, "mmap() send buffer");
+
+	ret = recv(sock, buffer, BUFFER_SIZE, 0);
+	if (ret < 0)
+		error(1, errno, "recv()");
+
+	if (ret != BUFFER_SIZE)
+		error(1, errno, "message is truncated, expected: %d, got: %d",
+		      BUFFER_SIZE, ret);
+
+	for (i = 0; i < BUFFER_SIZE; i++)
+		if (buffer[i] != 'a' + (i % 26))
+			error(1, 0, "message mismatches at %d", i);
+
+	send_pass_msg(sock);
+}
+
+int setup_udp_sock(const char *addr, int port)
+{
+	int sock, ret;
+	struct sockaddr_in saddr = {
+		.sin_family = AF_INET,
+		.sin_addr = inet_addr(addr),
+		.sin_port = htons(port),
+	};
+
+	sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		error(1, errno, "socket() UDP");
+
+	ret = bind(sock, (const struct sockaddr *)&saddr, sizeof(saddr));
+	if (ret < 0)
+		error(1, errno, "bind() UDP");
+
+	return sock;
+}
+
+void run_server(void)
+{
+	int udp_sock;
+	struct xdp_sock_context *ctx;
+
+	ctx = setup_xdp_socket(cfg_ifindex);
+	setup_xdp_prog(ctx->xdp_sock, cfg_ifindex, cfg_redirect);
+	udp_sock = setup_udp_sock(cfg_server_ip, SERVER_PORT);
+
+	if (cfg_redirect)
+		server_recv_xdp(ctx, udp_sock);
+	else
+		server_recv_udp(udp_sock);
+}
+
+void run_client(void)
+{
+	char *buffer;
+	int sock, ret, i;
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr = inet_addr(cfg_server_ip),
+		.sin_port = htons(SERVER_PORT),
+	};
+
+	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (buffer == MAP_FAILED)
+		error(1, errno, "mmap() send buffer");
+
+	for (i = 0; i < BUFFER_SIZE; i++)
+		buffer[i] = 'a' + (i % 26);
+
+	sock = setup_udp_sock(cfg_client_ip, CLIENT_PORT);
+
+	ret = sendto(sock, buffer, BUFFER_SIZE, 0,
+		     (const struct sockaddr *)&addr, sizeof(addr));
+	if (ret < 0)
+		error(1, errno, "sendto()");
+
+	if (ret != BUFFER_SIZE)
+		error(1, 0, "sent buffer is truncated, expected: %d got: %d",
+		      BUFFER_SIZE, ret);
+
+	ret = recv(sock, buffer, BUFFER_SIZE, 0);
+	if (ret < 0)
+		error(1, errno, "recv()");
+
+	if ((ret != sizeof(pass_msg)) || strcmp(buffer, pass_msg))
+		error(1, 0, "message mismatches, expected: %s, got: %s",
+		      pass_msg, buffer);
+}
+
+void print_usage(char *prog)
+{
+	fprintf(stderr, "Usage: %s (-c|-s) -r<server_ip> -l<client_ip>"
+		" -i<server_ifname> [-d] [-z]\n", prog);
+}
+
+void parse_opts(int argc, char **argv)
+{
+	int opt;
+	char *ifname = NULL;
+
+	while ((opt = getopt(argc, argv, "hcsr:l:i:dz")) != -1) {
+		switch (opt) {
+		case 'c':
+			if (cfg_server)
+				error(1, 0, "Pass one of -s or -c");
+
+			cfg_client = 1;
+			break;
+		case 's':
+			if (cfg_client)
+				error(1, 0, "Pass one of -s or -c");
+
+			cfg_server = 1;
+			break;
+		case 'r':
+			cfg_server_ip = optarg;
+			break;
+		case 'l':
+			cfg_client_ip = optarg;
+			break;
+		case 'i':
+			ifname = optarg;
+			break;
+		case 'd':
+			cfg_redirect = 1;
+			break;
+		case 'z':
+			cfg_zerocopy = 1;
+			break;
+		case 'h':
+		default:
+			print_usage(argv[0]);
+			exit(1);
+		}
+	}
+
+	if (!cfg_client && !cfg_server)
+		error(1, 0, "Pass one of -s or -c");
+
+	if (ifname) {
+		cfg_ifindex = if_nametoindex(ifname);
+		if (!cfg_ifindex)
+			error(1, errno, "Invalid interface %s", ifname);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	parse_opts(argc, argv);
+	if (cfg_client)
+		run_client();
+	else if (cfg_server)
+		run_server();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/drivers/net/hw/xsk_receive.py b/tools/testing/selftests/drivers/net/hw/xsk_receive.py
new file mode 100755
index 000000000000..f32cb4477b75
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_receive.py
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This a test for virtio-net rx when there is a XDP socket bound to it. The test
+# is expected to be run in the host side.
+#
+# The run example:
+#
+# export NETIF=tap0
+# export LOCAL_V4=192.168.31.1
+# export REMOTE_V4=192.168.31.3
+# export REMOTE_TYPE=ssh
+# export REMOTE_ARGS='root@192.168.31.3'
+# ./ksft-net-drv/run_kselftest.sh -t drivers/net/hw:xsk_receive.py
+#
+# where:
+# - 192.168.31.1 is the IP of tap device in the host
+# - 192.168.31.3 is the IP of virtio-net device in the guest
+#
+# The Qemu command to setup virtio-net
+# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
+# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
+#
+# The MTU of tap device can be adjusted to test more cases:
+# - 1500: single buffer XDP
+# - 9000: multi-buffer XDP
+
+from lib.py import ksft_exit, ksft_run
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEpEnv
+from lib.py import bkg, cmd, wait_port_listen
+from os import path
+
+SERVER_PORT = 8888
+CLIENT_PORT = 9999
+
+def test_xdp_pass(cfg, server_cmd, client_cmd):
+    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
+        cmd(client_cmd)
+
+def test_xdp_pass_zc(cfg, server_cmd, client_cmd):
+    server_cmd += " -z"
+    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
+        cmd(client_cmd)
+
+def test_xdp_redirect(cfg, server_cmd, client_cmd):
+    server_cmd += " -d"
+    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
+        cmd(client_cmd)
+
+def test_xdp_redirect_zc(cfg, server_cmd, client_cmd):
+    server_cmd += " -d -z"
+    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(SERVER_PORT, proto="udp", host=cfg.remote)
+        cmd(client_cmd)
+
+def main():
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.bin_local = path.abspath(path.dirname(__file__)
+                            + "/../../../drivers/net/hw/xsk_receive")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+        server_cmd = f"{cfg.bin_remote} -s -i {cfg.remote_ifname} "
+        server_cmd += f"-r {cfg.remote_addr_v["4"]} -l {cfg.addr_v["4"]}"
+        client_cmd = f"{cfg.bin_local} -c -r {cfg.remote_addr_v["4"]} "
+        client_cmd += f"-l {cfg.addr_v["4"]}"
+
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, server_cmd, client_cmd))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0


