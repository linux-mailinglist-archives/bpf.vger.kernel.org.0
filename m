Return-Path: <bpf+bounces-55456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B599A80C6D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445DC500CDA
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791419E975;
	Tue,  8 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAimeBVO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7523D3B8;
	Tue,  8 Apr 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118921; cv=none; b=NMrKUH2YR59irdIaA+Z01uekCBQzJsOs4NaNG1earQcWqppV+Qd0X8DSoAYI/VQ7GGed97i2iRYRvtp8B2466AlVQMv+YiRyp9g7MSlsuGaDpEFgIN7+Fm5ZvG7pgSqmsCLQX61eT02txHTlzLyuzTyBaj4gWGOPFSsWqxIR6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118921; c=relaxed/simple;
	bh=aYF9FWo782B49TO/S9gTruogL0e5IOq0xZ5tZSQ2TQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zto4wJkVXhQyN/6y/jqp0brY17Jdjsiixj9kJIB5dhDIoWIHesTA99EU2uZFt1Z2q3w9V4UeK7vBKXQbIsEiAwvpQ4qPue86dKm7E+IXutigFXYMVfUzsyUsIEGaH1nuVlZTgXtY7xBXTPXqnYAml9duY8duAz/y2Ko/3px05Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAimeBVO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4774ce422easo56432811cf.1;
        Tue, 08 Apr 2025 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744118918; x=1744723718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAYemulSdbd81iolX4MVM3BB8R1nIUo5CtW9k38XFoQ=;
        b=bAimeBVOubkOlvBinv6ZjwfgVZlV8kmg4ZJH210looVRJv68v+wcEKfoDVs2mOLTWJ
         7ed8awQH0Fzk89DBmM0DkfEZyntMOnD04LPk5VzSbew8d93Mh70uRc7PGAxFMpY8BZmD
         eUbFgcHcjusanvj9cHyn2nLUTYOI6lttxUnNKSwmf8W2Dw1/kZAmtli46x03sRX19vQ6
         D/TgnQ0GykC2ETIctVqVeP4B0dPhLS/SU4VUUJJlRS9AByXu7rT07jMYbVMrkDjgZ2w7
         bLs0uVVitKNNsQQ4wFt0UdoYsgMuV3MY+ityGCaTw0wzHI/8tO/IhY9GPybzF6unKFDi
         zIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118918; x=1744723718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAYemulSdbd81iolX4MVM3BB8R1nIUo5CtW9k38XFoQ=;
        b=p7q/jNr2iuKjwt/drGleXN3ZVjyTm7yJh32rngcNXvR3e39oTgICibMPq/qfRFYv9f
         df+duKmM+JprsV6eQHBOdnVI/VUvaDSCe3alHIvH3DLJ1xYs7xqbTogz6p0ytlVGQP6c
         ocArNCVfclstlW51RuFBirsAhO1D29fFRUvAw9s3gqqfzBQ1rsOQQmcyeftCFp1cYXE+
         XpY/mPd7zgbGHSNMZA3vIthvWWY42MBRjOCTCaC8Hl8Ue+Fin1tUTI6AClf80OK0v8/o
         IrVzyJ/OpkZ9SxIRPFyRq2RKTihkIrRMAaq16oDwOUoWGzzlDTQdw0IVWlVC3azqBl26
         xSKg==
X-Gm-Message-State: AOJu0YxOrc8ZzQa/4eJZvVv5yy8NraNcyRocfq6XFUo/e7yRj4AzAFKK
	92tOQ7z80P4pYg2mKpjoNiDZBmZGZLS5mLCdxKWdWGikBXaCsg15EM33KA==
X-Gm-Gg: ASbGncu9rDnFPMhQikYA2nePU/YAjM5PZXOtLHKpRDrp/S+V/3kY5C4say8eKJoQncg
	Ts6BBwNtahGN4aBljMMaD7Ui1p3ebzEafdFQYJ+2cxZ/VCwTX+xO2Czw7gjluD/1QaA/vrmny0r
	ajNJlGiv5FtsVXCCXPE0Fc3EzATYwtYx53cevz2ZIOlMzVRuWoGUHWhI1yLJqDI52EGUwqhIX4w
	5rRVEo1YmpHpDGaI8CB/ejlYMpYRcRZ301GwU0cYMjPxRo6cPTrT120YQJQBRfPTV98vVCGKsxZ
	xDVk24JpTPtcsfLnsj3tiVHsN+CYuPTupsdm6XBsguHAkk4pz2mVvAkauNWN3bumw3l7jkMfufQ
	Xp5PDa3MnGH0oqvDUr2RAl8JsZxG2UrMJy15XhtNXoaTo
X-Google-Smtp-Source: AGHT+IHe9hw7oOpmh9/2GkxOr6VnJsCytgi15Xm1kamyGQ0eSiOHNRP/1DvpHWOtHfac3S3aACj82A==
X-Received: by 2002:ac8:5803:0:b0:476:8f90:b5b1 with SMTP id d75a77b69052e-4792494914dmr216989511cf.25.1744118918446;
        Tue, 08 Apr 2025 06:28:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b07125asm77413551cf.20.2025.04.08.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:28:38 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf v3 2/2] selftests/net: test sk_filter support for SKF_NET_OFF on frags
Date: Tue,  8 Apr 2025 09:27:49 -0400
Message-ID: <20250408132833.195491-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
References: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Verify that a classic BPF linux socket filter correctly matches
packet contents. Including when accessing contents in an
skb_frag.

1. Open a SOCK_RAW socket with a classic BPF filter on UDP dport 8000.
2. Open a tap device with IFF_NAPI_FRAGS to inject skbs with frags.
3. Send a packet for which the UDP header is in frag[0].
4. Receive this packet to demonstrate that the socket accepted it.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - add comment why early demux must be disabled
---
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   2 +
 tools/testing/selftests/net/skf_net_off.c  | 244 +++++++++++++++++++++
 tools/testing/selftests/net/skf_net_off.sh |  30 +++
 4 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/net/skf_net_off.c
 create mode 100755 tools/testing/selftests/net/skf_net_off.sh

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 679542f565a4..532bb732bc6d 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -39,6 +39,7 @@ scm_rights
 sk_bind_sendto_listen
 sk_connect_zero_addr
 sk_so_peek_off
+skf_net_off
 socket
 so_incoming_cpu
 so_netns_cookie
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6d718b478ed8..124078b56fa4 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -106,6 +106,8 @@ TEST_PROGS += ipv6_route_update_soft_lockup.sh
 TEST_PROGS += busy_poll_test.sh
 TEST_GEN_PROGS += proc_net_pktgen
 TEST_PROGS += lwt_dst_cache_ref_loop.sh
+TEST_PROGS += skf_net_off.sh
+TEST_GEN_FILES += skf_net_off
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/skf_net_off.c b/tools/testing/selftests/net/skf_net_off.c
new file mode 100644
index 000000000000..1fdf61d6cd7f
--- /dev/null
+++ b/tools/testing/selftests/net/skf_net_off.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Open a tun device.
+ *
+ * [modifications: use IFF_NAPI_FRAGS, add sk filter]
+ *
+ * Expects the device to have been configured previously, e.g.:
+ *   sudo ip tuntap add name tap1 mode tap
+ *   sudo ip link set tap1 up
+ *   sudo ip link set dev tap1 addr 02:00:00:00:00:01
+ *   sudo ip -6 addr add fdab::1 peer fdab::2 dev tap1 nodad
+ *
+ * And to avoid premature pskb_may_pull:
+ *
+ *   sudo ethtool -K tap1 gro off
+ *   sudo bash -c 'echo 0 > /proc/sys/net/ipv4/ip_early_demux'
+ */
+
+#define _GNU_SOURCE
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <error.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <linux/filter.h>
+#include <linux/if.h>
+#include <linux/if_packet.h>
+#include <linux/if_tun.h>
+#include <linux/ipv6.h>
+#include <netinet/if_ether.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#include <netinet/ip6.h>
+#include <netinet/udp.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+static bool cfg_do_filter;
+static bool cfg_do_frags;
+static int cfg_dst_port = 8000;
+static char *cfg_ifname;
+
+static int tun_open(const char *tun_name)
+{
+	struct ifreq ifr = {0};
+	int fd, ret;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd == -1)
+		error(1, errno, "open /dev/net/tun");
+
+	ifr.ifr_flags = IFF_TAP;
+	if (cfg_do_frags)
+		ifr.ifr_flags |= IFF_NAPI | IFF_NAPI_FRAGS;
+
+	strncpy(ifr.ifr_name, tun_name, IFNAMSIZ - 1);
+
+	ret = ioctl(fd, TUNSETIFF, &ifr);
+	if (ret)
+		error(1, ret, "ioctl TUNSETIFF");
+
+	return fd;
+}
+
+static void sk_set_filter(int fd)
+{
+	const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
+	const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
+
+	/* Filter UDP packets with destination port cfg_dst_port */
+	struct sock_filter filter_code[] = {
+		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
+		BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
+		BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, cfg_dst_port, 1, 0),
+		BPF_STMT(BPF_RET + BPF_K, 0),
+		BPF_STMT(BPF_RET + BPF_K, 0xFFFF),
+	};
+
+	struct sock_fprog filter = {
+		sizeof(filter_code) / sizeof(filter_code[0]),
+		filter_code,
+	};
+
+	if (setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &filter, sizeof(filter)))
+		error(1, errno, "setsockopt attach filter");
+}
+
+static int raw_open(void)
+{
+	int fd;
+
+	fd = socket(PF_INET6, SOCK_RAW, IPPROTO_UDP);
+	if (fd == -1)
+		error(1, errno, "socket raw (udp)");
+
+	if (cfg_do_filter)
+		sk_set_filter(fd);
+
+	return fd;
+}
+
+static void tun_write(int fd)
+{
+	const char eth_src[] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x02 };
+	const char eth_dst[] = { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 };
+	struct tun_pi pi = {0};
+	struct ipv6hdr ip6h = {0};
+	struct udphdr uh = {0};
+	struct ethhdr eth = {0};
+	uint32_t payload;
+	struct iovec iov[5];
+	int ret;
+
+	pi.proto = htons(ETH_P_IPV6);
+
+	memcpy(eth.h_source, eth_src, sizeof(eth_src));
+	memcpy(eth.h_dest, eth_dst, sizeof(eth_dst));
+	eth.h_proto = htons(ETH_P_IPV6);
+
+	ip6h.version = 6;
+	ip6h.payload_len = htons(sizeof(uh) + sizeof(uint32_t));
+	ip6h.nexthdr = IPPROTO_UDP;
+	ip6h.hop_limit = 8;
+	if (inet_pton(AF_INET6, "fdab::2", &ip6h.saddr) != 1)
+		error(1, errno, "inet_pton src");
+	if (inet_pton(AF_INET6, "fdab::1", &ip6h.daddr) != 1)
+		error(1, errno, "inet_pton src");
+
+	uh.source = htons(8000);
+	uh.dest = htons(cfg_dst_port);
+	uh.len = ip6h.payload_len;
+	uh.check = 0;
+
+	payload = htonl(0xABABABAB);		/* Covered in IPv6 length */
+
+	iov[0].iov_base = &pi;
+	iov[0].iov_len  = sizeof(pi);
+	iov[1].iov_base = &eth;
+	iov[1].iov_len  = sizeof(eth);
+	iov[2].iov_base = &ip6h;
+	iov[2].iov_len  = sizeof(ip6h);
+	iov[3].iov_base = &uh;
+	iov[3].iov_len  = sizeof(uh);
+	iov[4].iov_base = &payload;
+	iov[4].iov_len  = sizeof(payload);
+
+	ret = writev(fd, iov, sizeof(iov) / sizeof(iov[0]));
+	if (ret <= 0)
+		error(1, errno, "writev");
+}
+
+static void raw_read(int fd)
+{
+	struct timeval tv = { .tv_usec = 100 * 1000 };
+	struct msghdr msg = {0};
+	struct iovec iov[2];
+	struct udphdr uh;
+	uint32_t payload[2];
+	int ret;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
+		error(1, errno, "setsockopt rcvtimeo udp");
+
+	iov[0].iov_base = &uh;
+	iov[0].iov_len = sizeof(uh);
+
+	iov[1].iov_base = payload;
+	iov[1].iov_len = sizeof(payload);
+
+	msg.msg_iov = iov;
+	msg.msg_iovlen = sizeof(iov) / sizeof(iov[0]);
+
+	ret = recvmsg(fd, &msg, 0);
+	if (ret <= 0)
+		error(1, errno, "read raw");
+	if (ret != sizeof(uh) + sizeof(payload[0]))
+		error(1, errno, "read raw: len=%d\n", ret);
+
+	fprintf(stderr, "raw recv: 0x%x\n", payload[0]);
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "fFi:")) != -1) {
+		switch (c) {
+		case 'f':
+			cfg_do_filter = true;
+			printf("bpf filter enabled\n");
+			break;
+		case 'F':
+			cfg_do_frags = true;
+			printf("napi frags mode enabled\n");
+			break;
+		case 'i':
+			cfg_ifname = optarg;
+			break;
+		default:
+			error(1, 0, "unknown option %c", optopt);
+			break;
+		}
+	}
+
+	if (!cfg_ifname)
+		error(1, 0, "must specify tap interface name (-i)");
+}
+
+int main(int argc, char **argv)
+{
+	int fdt, fdr;
+
+	parse_opts(argc, argv);
+
+	fdr = raw_open();
+	fdt = tun_open(cfg_ifname);
+
+	tun_write(fdt);
+	raw_read(fdr);
+
+	if (close(fdt))
+		error(1, errno, "close tun");
+	if (close(fdr))
+		error(1, errno, "close udp");
+
+	fprintf(stderr, "OK\n");
+	return 0;
+}
+
diff --git a/tools/testing/selftests/net/skf_net_off.sh b/tools/testing/selftests/net/skf_net_off.sh
new file mode 100755
index 000000000000..5da5066fb465
--- /dev/null
+++ b/tools/testing/selftests/net/skf_net_off.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+readonly NS="ns-$(mktemp -u XXXXXX)"
+
+cleanup() {
+	ip netns del $NS
+}
+
+ip netns add $NS
+trap cleanup EXIT
+
+ip -netns $NS link set lo up
+ip -netns $NS tuntap add name tap1 mode tap
+ip -netns $NS link set tap1 up
+ip -netns $NS link set dev tap1 addr 02:00:00:00:00:01
+ip -netns $NS -6 addr add fdab::1 peer fdab::2 dev tap1 nodad
+ip netns exec $NS ethtool -K tap1 gro off
+
+# disable early demux, else udp_v6_early_demux pulls udp header into linear
+ip netns exec $NS sysctl -w net.ipv4.ip_early_demux=0
+
+echo "no filter"
+ip netns exec $NS ./skf_net_off -i tap1
+
+echo "filter, linear skb (-f)"
+ip netns exec $NS ./skf_net_off -i tap1 -f
+
+echo "filter, fragmented skb (-f) (-F)"
+ip netns exec $NS ./skf_net_off -i tap1 -f -F
-- 
2.49.0.504.g3bcea36a83-goog


