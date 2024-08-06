Return-Path: <bpf+bounces-36510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D99949B01
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EE31F233DA
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF7170A11;
	Tue,  6 Aug 2024 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fANTuIGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90936170A21
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982374; cv=none; b=S0KpmQ0mAk0+DENSK82kVb7U8DoCCbUoh4ZEXGaqjNQSAlF9UEuk0uXD46DDdXkzdvU5bF+S4vjSA9GnOtPt9MYmRMAhIeJamxrPcNFST51yl0e1W6jIdxfxkbbjNg9ukFfRL6gdZKWMbzwYPJbcasn+rXL6HfNLKtpgwuUu4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982374; c=relaxed/simple;
	bh=pJq2SQ0T8uFlvgJPsl1DsU9XG/JC+M5eU5EOIj5TwG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIidBBN0mWy2Orz5WZs3AwOtfCWI0sJi+RKQAi0GCM4il7o529stkaeE9+ACSSAgyrVia8ENt32MG93opaxIZmSYH/XCxBn25lRRl1IXQ9npV16n0kBI14+8uwZoYIPMi0p5gdisn23VcE3Igyo3YB6uuzRO0NOgQngGX1HDY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fANTuIGQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-685cc5415e8so10226227b3.3
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982371; x=1723587171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gsuy8/7yET29BL4/c9fSIYJ0jL/Y5H1Xes9/wvROxM=;
        b=fANTuIGQq/I7D43pmCmw4zQcQLko+5KxqHBTCN/QghYximB1tT4Y7T8c0F1YC4E3L7
         820D1HvbEEx8Oqm6OY8NafPom81S+YKP3ujbFQATiw6NC+fsaR126lFIsnCH/28WVxCj
         UxI2XR8E62UXzDbVYgos/wbXarqhl8P0YadKfNoXY/VGpxb1NBu3ZJfR+BMuo1TcJtet
         4o5PadPyS5uxq1/w+zrTmr0PG4k8+rpS0lvJM+aW4qJB6b0FWRGjkmsoY0fwxnH0pdJn
         Nq5vbE110JHleAEkAvUekcvpSTRBrkJI8ixP1Br9B+7fl6VPK5SeqASMgHsy2ytH0SLn
         adrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982371; x=1723587171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gsuy8/7yET29BL4/c9fSIYJ0jL/Y5H1Xes9/wvROxM=;
        b=i+QKguyxHTqU4fMRmjC7m5sxgUkA2FnaJWdoUJS2k6fVP02go7/U3ayBwXRXBWz01u
         uCn2Mql1nrXrqajBOs1X57SOrsz2AFrRiWUGXxXMhDj/7xoRt3OU6Xzg7cI8RRFMISRl
         2CQtoJieMOX4pVpu70R2mZCLRvzhpvJlQICBxE+uZ3zmtlrjg1CZuDTX9JN1HW7hsl/f
         /0X8udiyeIj9vzQC33/z8FM/aSlyr0AL7pSFWU1XIB8H3mkIosRahAs3TPFRAxUoErs8
         2rfzvPlFaq09f0Fg6vMOruU8emYjHNdXH8ZN/pyddNr6ZuRKHzwKWrhAnbTiaEXzP4sN
         YBAg==
X-Gm-Message-State: AOJu0YyqiD5kw48QOqbObfNOTphRnk8YYYXFyhBe6nPrWu/5jqd2faXI
	VdrJpbEp1KHSz6fOjxeo+G+GUCOcGHND1fZDPJAomwvVa15WVv1+MGlr15zP
X-Google-Smtp-Source: AGHT+IFCdhUYX2w6paP2a0G5SRIS9NqjVKSUExNMmsmWNVPfgRcqxQ/XNucKwhgc3CfG8CAWViTXKg==
X-Received: by 2002:a0d:e087:0:b0:647:88ba:f91b with SMTP id 00721157ae682-68960777bcemr169989617b3.11.1722982371375;
        Tue, 06 Aug 2024 15:12:51 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:50 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 1/6] selftests/bpf: Add traffic monitor functions.
Date: Tue,  6 Aug 2024 15:12:38 -0700
Message-Id: <20240806221243.1806879-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806221243.1806879-1-thinker.li@gmail.com>
References: <20240806221243.1806879-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions that capture packets and print log in the background. They
are supposed to be used for debugging flaky network test cases. A monitored
test case should call traffic_monitor_start() to start a thread to capture
packets in the background for a given namespace and call
traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
the later patches.)

    IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 68, ifname lo (In), SYN
    IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 60, ifname lo (In), SYN, ACK
    IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 60, ifname lo (In), ACK
    IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 52, ifname lo (In), ACK
    IPv4 TCP packet: 127.0.0.1:48423 -> 127.0.0.1:40991, len 52, ifname lo (In), FIN, ACK
    IPv4 TCP packet: 127.0.0.1:40991 -> 127.0.0.1:48423, len 52, ifname lo (In), RST, ACK
    Packet file: packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log
    #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK

The above is the output of an example. It shows the packets of a connection
and the name of the file that contains captured packets in the directory
/tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.

This feature only works if libpcap is available. (Could be found by pkg-config)

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +
 tools/testing/selftests/bpf/network_helpers.c | 454 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  18 +
 3 files changed, 476 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f54185e96a95..098e1092f1f5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -41,6 +41,10 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
+LDLIBS += $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
+CFLAGS += $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
+CFLAGS += $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+
 # The following tests perform type punning and they may break strict
 # aliasing rules, which are exploited by both GCC and clang by default
 # while optimizing.  This can lead to broken programs.
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a3f0a49fb26f..462aeadd767e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -11,6 +11,7 @@
 #include <arpa/inet.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <sys/un.h>
 
 #include <linux/err.h>
@@ -18,10 +19,22 @@
 #include <linux/in6.h>
 #include <linux/limits.h>
 
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <netinet/tcp.h>
+#include <net/if.h>
+
 #include "bpf_util.h"
 #include "network_helpers.h"
 #include "test_progs.h"
 
+#ifdef TRAFFIC_MONITOR
+/* Prevent pcap.h from including pcap/bpf.h and causing conflicts */
+#define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
+#include <pcap/pcap.h>
+#include <pcap/dlt.h>
+#endif
+
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
@@ -660,3 +673,444 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 
 	return err;
 }
+
+#ifdef TRAFFIC_MONITOR
+struct tmonitor_ctx {
+	pcap_t *pcap;
+	pcap_dumper_t *dumper;
+	pthread_t thread;
+	int wake_fd_r;
+	int wake_fd_w;
+
+	bool done;
+	char pkt_fname[PATH_MAX];
+	int pcap_fd;
+};
+
+/* Is this packet captured with a Ethernet protocol type? */
+static bool is_ethernet(const u_char *packet)
+{
+	u16 arphdr_type;
+
+	memcpy(&arphdr_type, packet + 8, 2);
+	arphdr_type = ntohs(arphdr_type);
+
+	/* Except the following cases, the protocol type contains the
+	 * Ethernet protocol type for the packet.
+	 *
+	 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
+	 */
+	switch (arphdr_type) {
+	case 770: /* ARPHRD_FRAD */
+	case 778: /* ARPHDR_IPGRE */
+	case 803: /* ARPHRD_IEEE80211_RADIOTAP */
+		return false;
+	}
+	return true;
+}
+
+static const char * const pkt_types[] = {
+	"In",
+	"B",			/* Broadcast */
+	"M",			/* Multicast */
+	"C",			/* Captured with the promiscuous mode */
+	"Out",
+};
+
+static const char *pkt_type_str(u16 pkt_type)
+{
+	if (pkt_type < ARRAY_SIZE(pkt_types))
+		return pkt_types[pkt_type];
+	return "Unknown";
+}
+
+/* Show the information of the transport layer in the packet */
+static void show_transport(const u_char *packet, u16 len, u32 ifindex,
+			   const char *src_addr, const char *dst_addr,
+			   u16 proto, bool ipv6, u8 pkt_type)
+{
+	char *ifname, _ifname[IF_NAMESIZE];
+	const char *transport_str;
+	u16 src_port, dst_port;
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+
+	ifname = if_indextoname(ifindex, _ifname);
+	if (!ifname) {
+		snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
+		ifname = _ifname;
+	}
+
+	if (proto == IPPROTO_UDP) {
+		udp = (struct udphdr *)packet;
+		src_port = ntohs(udp->source);
+		dst_port = ntohs(udp->dest);
+		transport_str = "UDP";
+	} else if (proto == IPPROTO_TCP) {
+		tcp = (struct tcphdr *)packet;
+		src_port = ntohs(tcp->source);
+		dst_port = ntohs(tcp->dest);
+		transport_str = "TCP"
+;
+	} else if (proto == IPPROTO_ICMP) {
+		printf("IPv4 ICMP packet: %s -> %s, len %d, type %d, code %d, ifname %s (%s)\n",
+		       src_addr, dst_addr, len, packet[0], packet[1], ifname,
+		       pkt_type_str(pkt_type));
+		return;
+	} else if (proto == IPPROTO_ICMPV6) {
+		printf("IPv6 ICMPv6 packet: %s -> %s, len %d, type %d, code %d, ifname %s (%s)\n",
+		       src_addr, dst_addr, len, packet[0], packet[1], ifname,
+		       pkt_type_str(pkt_type));
+		return;
+	} else {
+		printf("%s (proto %d): %s -> %s, ifname %s (%s)\n",
+		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr,
+		       ifname, pkt_type_str(pkt_type));
+		return;
+	}
+
+	/* TCP */
+
+	flockfile(stdout);
+	if (ipv6)
+		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifname %s (%s)",
+		       transport_str, src_addr, src_port,
+		       dst_addr, dst_port, len, ifname, pkt_type_str(pkt_type));
+	else
+		printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifname %s (%s)",
+		       transport_str, src_addr, src_port,
+		       dst_addr, dst_port, len, ifname, pkt_type_str(pkt_type));
+
+	if (proto == IPPROTO_TCP) {
+		if (tcp->fin)
+			printf(", FIN");
+		if (tcp->syn)
+			printf(", SYN");
+		if (tcp->rst)
+			printf(", RST");
+		if (tcp->ack)
+			printf(", ACK");
+	}
+
+	printf("\n");
+	funlockfile(stdout);
+}
+
+static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
+{
+	char src_str[INET6_ADDRSTRLEN], dst_str[INET6_ADDRSTRLEN];
+	struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
+	struct in6_addr src;
+	struct in6_addr dst;
+	u_char proto;
+
+	memcpy(&src, &pkt->saddr, sizeof(src));
+	memcpy(&dst, &pkt->daddr, sizeof(dst));
+	inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));
+	inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));
+	proto = pkt->nexthdr;
+	show_transport(packet + sizeof(struct ipv6hdr),
+		       ntohs(pkt->payload_len),
+		       ifindex, src_str, dst_str, proto, true, pkt_type);
+}
+
+static void show_ipv4_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
+{
+	char src_str[INET_ADDRSTRLEN], dst_str[INET_ADDRSTRLEN];
+	struct iphdr *pkt = (struct iphdr *)packet;
+	struct in_addr src;
+	struct in_addr dst;
+	u_char proto;
+
+	memcpy(&src, &pkt->saddr, sizeof(src));
+	memcpy(&dst, &pkt->daddr, sizeof(dst));
+	inet_ntop(AF_INET, &src, src_str, sizeof(src_str));
+	inet_ntop(AF_INET, &dst, dst_str, sizeof(dst_str));
+	proto = pkt->protocol;
+	show_transport(packet + sizeof(struct iphdr),
+		       ntohs(pkt->tot_len),
+		       ifindex, src_str, dst_str, proto, false, pkt_type);
+}
+
+static void *traffic_monitor_thread(void *arg)
+{
+	char *ifname, _ifname[IF_NAMESIZE];
+	const u_char *packet, *payload;
+	struct tmonitor_ctx *ctx = arg;
+	pcap_dumper_t *dumper = ctx->dumper;
+	int fd = ctx->pcap_fd, nfds, r;
+	int wake_fd = ctx->wake_fd_r;
+	struct pcap_pkthdr header;
+	pcap_t *pcap = ctx->pcap;
+	u32 ifindex;
+	fd_set fds;
+	u16 proto;
+	u8 ptype;
+
+	nfds = (fd > wake_fd ? fd : wake_fd) + 1;
+	FD_ZERO(&fds);
+
+	while (!ctx->done) {
+		FD_SET(fd, &fds);
+		FD_SET(wake_fd, &fds);
+		r = select(nfds, &fds, NULL, NULL, NULL);
+		if (!r)
+			continue;
+		if (r < 0) {
+			if (errno == EINTR)
+				continue;
+			log_err("Fail to select on pcap fd and wake fd: %s", strerror(errno));
+			break;
+		}
+
+		packet = pcap_next(pcap, &header);
+		if (!packet)
+			continue;
+
+		/* According to the man page of pcap_dump(), first argument
+		 * is the pcap_dumper_t pointer even it's argument type is
+		 * u_char *.
+		 */
+		pcap_dump((u_char *)dumper, &header, packet);
+
+		/* Not sure what other types of packets look like. Here, we
+		 * parse only Ethernet and compatible packets.
+		 */
+		if (!is_ethernet(packet)) {
+			printf("Packet captured\n");
+			continue;
+		}
+
+		/* Skip SLL2 header
+		 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
+		 *
+		 * Although the document doesn't mention that, the payload
+		 * doesn't include the Ethernet header. The payload starts
+		 * from the first byte of the network layer header.
+		 */
+		payload = packet + 20;
+
+		memcpy(&proto, packet, 2);
+		proto = ntohs(proto);
+		memcpy(&ifindex, packet + 4, 4);
+		ifindex = ntohl(ifindex);
+		ptype = packet[10];
+
+		if (proto == ETH_P_IPV6) {
+			show_ipv6_packet(payload, ifindex, ptype);
+		} else if (proto == ETH_P_IP) {
+			show_ipv4_packet(payload, ifindex, ptype);
+		} else {
+			ifname = if_indextoname(ifindex, _ifname);
+			if (!ifname) {
+				snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
+				ifname = _ifname;
+			}
+
+			printf("Unknown network protocol type %x, ifname %s (%s)\n",
+			       proto, ifname, pkt_type_str(ptype));
+		}
+	}
+
+	return NULL;
+}
+
+/* Prepare the pcap handle to capture packets.
+ *
+ * This pcap is non-blocking and immediate mode is enabled to receive
+ * captured packets as soon as possible.  The snaplen is set to 1024 bytes
+ * to limit the size of captured content. The format of the link-layer
+ * header is set to DLT_LINUX_SLL2 to enable handling various link-layer
+ * technologies.
+ */
+static pcap_t *traffic_monitor_prepare_pcap(void)
+{
+	char errbuf[PCAP_ERRBUF_SIZE];
+	pcap_t *pcap;
+	int r;
+
+	/* Listen on all NICs in the namespace */
+	pcap = pcap_create("any", errbuf);
+	if (!pcap) {
+		log_err("Failed to open pcap: %s", errbuf);
+		return NULL;
+	}
+	/* Limit the size of the packet (first N bytes) */
+	r = pcap_set_snaplen(pcap, 1024);
+	if (r) {
+		log_err("Failed to set snaplen: %s", pcap_geterr(pcap));
+		goto error;
+	}
+	/* To receive packets as fast as possible */
+	r = pcap_set_immediate_mode(pcap, 1);
+	if (r) {
+		log_err("Failed to set immediate mode: %s", pcap_geterr(pcap));
+		goto error;
+	}
+	r = pcap_setnonblock(pcap, 1, errbuf);
+	if (r) {
+		log_err("Failed to set nonblock: %s", errbuf);
+		goto error;
+	}
+	r = pcap_activate(pcap);
+	if (r) {
+		log_err("Failed to activate pcap: %s", pcap_geterr(pcap));
+		goto error;
+	}
+	/* Determine the format of the link-layer header */
+	r = pcap_set_datalink(pcap, DLT_LINUX_SLL2);
+	if (r) {
+		log_err("Failed to set datalink: %s", pcap_geterr(pcap));
+		goto error;
+	}
+
+	return pcap;
+error:
+	pcap_close(pcap);
+	return NULL;
+}
+
+static void encode_test_name(char *buf, size_t len, const char *test_name, const char *subtest_name)
+{
+	char *p;
+
+	if (subtest_name)
+		snprintf(buf, len, "%s:%s", test_name, subtest_name);
+	else
+		snprintf(buf, len, "%s", test_name);
+	while ((p = strchr(buf, '/')))
+		*p = '_';
+	while ((p = strchr(buf, ' ')))
+		*p = '_';
+}
+
+#define PCAP_DIR "/tmp/tmon_pcap"
+
+/* Start to monitor the network traffic in the given network namespace.
+ *
+ * netns: the name of the network namespace to monitor. If NULL, the
+ *        current network namespace is monitored.
+ * test_name: the name of the running test.
+ * subtest_name: the name of the running subtest if there is. It should be
+ *               NULL if it is not a subtest.
+ *
+ * This function will start a thread to capture packets going through NICs
+ * in the give network namespace.
+ */
+struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
+					   const char *subtest_name)
+{
+	struct tmonitor_ctx *ctx = NULL;
+	struct nstoken *nstoken = NULL;
+	int pipefd[2] = {-1, -1};
+	char test_name_buf[64];
+	static int tmon_seq;
+	int r;
+
+	if (netns) {
+		nstoken = open_netns(netns);
+		if (!nstoken)
+			return NULL;
+	}
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx) {
+		log_err("Failed to malloc ctx");
+		goto fail_ctx;
+	}
+	memset(ctx, 0, sizeof(*ctx));
+
+	encode_test_name(test_name_buf, sizeof(test_name_buf), test_name, subtest_name);
+	snprintf(ctx->pkt_fname, sizeof(ctx->pkt_fname),
+		 PCAP_DIR "/packets-%d-%d-%s-%s.log", getpid(), tmon_seq++,
+		 test_name_buf, netns ? netns : "unknown");
+
+	r = mkdir(PCAP_DIR, 0755);
+	if (r && errno != EEXIST) {
+		log_err("Failed to create " PCAP_DIR);
+		goto fail_pcap;
+	}
+
+	ctx->pcap = traffic_monitor_prepare_pcap();
+	if (!ctx->pcap)
+		goto fail_pcap;
+	ctx->pcap_fd = pcap_get_selectable_fd(ctx->pcap);
+	if (ctx->pcap_fd < 0) {
+		log_err("Failed to get pcap fd");
+		goto fail_dumper;
+	}
+
+	/* Create a packet file */
+	ctx->dumper = pcap_dump_open(ctx->pcap, ctx->pkt_fname);
+	if (!ctx->dumper) {
+		log_err("Failed to open pcap dump: %s", ctx->pkt_fname);
+		goto fail_dumper;
+	}
+
+	/* Create a pipe to wake up the monitor thread */
+	r = pipe(pipefd);
+	if (r) {
+		log_err("Failed to create pipe: %s", strerror(errno));
+		goto fail;
+	}
+	ctx->wake_fd_r = pipefd[0];
+	ctx->wake_fd_w = pipefd[1];
+
+	r = pthread_create(&ctx->thread, NULL, traffic_monitor_thread, ctx);
+	if (r) {
+		log_err("Failed to create thread: %s", strerror(r));
+		goto fail;
+	}
+
+	close_netns(nstoken);
+
+	return ctx;
+
+fail:
+	close(pipefd[0]);
+	close(pipefd[1]);
+
+	pcap_dump_close(ctx->dumper);
+	unlink(ctx->pkt_fname);
+
+fail_dumper:
+	pcap_close(ctx->pcap);
+
+fail_pcap:
+	free(ctx);
+
+fail_ctx:
+	close_netns(nstoken);
+
+	return NULL;
+}
+
+static void traffic_monitor_release(struct tmonitor_ctx *ctx)
+{
+	pcap_close(ctx->pcap);
+	pcap_dump_close(ctx->dumper);
+
+	close(ctx->wake_fd_r);
+	close(ctx->wake_fd_w);
+
+	free(ctx);
+}
+
+/* Stop the network traffic monitor.
+ *
+ * ctx: the context returned by traffic_monitor_start()
+ */
+void traffic_monitor_stop(struct tmonitor_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	/* Stop the monitor thread */
+	ctx->done = true;
+	write(ctx->wake_fd_w, "x", 1);
+	pthread_join(ctx->thread, NULL);
+
+	printf("Packet file: %s\n", strrchr(ctx->pkt_fname, '/') + 1);
+
+	traffic_monitor_release(ctx);
+}
+#endif /* TRAFFIC_MONITOR */
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index cce56955371f..496723b194fe 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -136,4 +136,22 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold((__u32)s);
 }
 
+struct tmonitor_ctx;
+
+#ifdef TRAFFIC_MONITOR
+struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
+					   const char *subtest_name);
+void traffic_monitor_stop(struct tmonitor_ctx *ctx);
+#else
+static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
+							 const char *subtest_name)
+{
+	return (struct tmonitor_ctx *)-1;
+}
+
+static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
+{
+}
+#endif
+
 #endif
-- 
2.34.1


