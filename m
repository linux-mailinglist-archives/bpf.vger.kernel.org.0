Return-Path: <bpf+bounces-37244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36059528F8
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38301C23367
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989BD15D5CE;
	Thu, 15 Aug 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvkFsDLF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9213FB30
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699982; cv=none; b=SArpRkvETOdLKi9BfqbWDeiW2/an1w/4xo2h/527V4G0jocsmyTy2plewnFDMUFlADKkTIdTjgXUMo3XBZwoZs6ft1831/6U5KxJAFP7oiTlbv8CDiq8IeoEFAPjzloRo6CtOgAu3oXpXVXiGmqxb/2dKY0LiaBNLo4nYiPbfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699982; c=relaxed/simple;
	bh=8nin/9AdEQs5VaYZsjUcUHIYahB5oXSrqBbuK+odDmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZaXHEHHX3VXEHh9zUGLmHmItgcP7En224TGh+v7xNpWYctJGIFFqabk9ERHWMg8HwjIxJwEMZrbua+sbkB0hi+jxvO7YNroVFgj8yLEuKhZMijmjLWms1+DoQR0U1Ra3BvY45QsAB3Ame2Sl2aSeul6YCkVYj5j3lpBZvsfUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvkFsDLF; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-690b6cbce11so6395617b3.2
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723699979; x=1724304779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35ut6a8/gE7dJAvn2qrSWoTLvd61YxIpZy4R3Py9NXw=;
        b=BvkFsDLFUK6/5l+BmnM1TdYko276ZAeCc+9mRgQU8DE/mmok6Ly1z3XAXLgCbLx04J
         2PcS4vwFy/lPCvXWSUDs1mS534W4jFJwM57UNNmEPOLfN+oR3rfdR1QAn2XD593ZT3Wt
         AmMCuyRrxC4njgiANgoG+sAKTNAuFRnf/xL/0fSpcGKiuWktBBniLkSNLwMQel1krIa6
         QqMkh54rN4LtkIMgdHxh4CQUw19BdFrnMgsFgdTkXCsFETeUfkhKbLzxkghSDTatw5cB
         rM8CiyFaIhoMQuwlirlXtV3lcxM+vowwOtoJpf3ZhxgHBqfOfsuVY2mFYkb1ytYtPuID
         kB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699979; x=1724304779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35ut6a8/gE7dJAvn2qrSWoTLvd61YxIpZy4R3Py9NXw=;
        b=SZxw29SCA3cda+L9G9gNMAbGsmTzba4qnnHHvnQoZV0f2kuG497xdYR5S886aijFaB
         CjuygCRBeWyHAD8q7qoQQ9rifbI7YUoPEq3YOlRQqmli1nmDaOA0pZHfTRgKlPBaTDs/
         fgAkN10OEB0ic9txFkLHk3XUB3SJohtM8wozOZfVKevf9/ZopqWUteIklCeQKZJHaXYa
         kIgvbUAX4rBtDI2RPQ19AQoelQOcsOZo2s/7WPNrNfQ0HtoSQvSpOKsHtyqCVsN68XyB
         FpfiJBFqBX3O93D4TQqC+FsTQOl1tL/XwIX6U5CfEA1eRb4KsMH6LyrRPiRWbywkzvly
         kwvg==
X-Gm-Message-State: AOJu0Yz1JsdObMpxS2QuLi15DWNkEfg0UwDljyZAO1esCxvZeRhOXLkj
	YU4HCeH3/nqBIAJz0tJ3IoNBv9GwQges6wzkdKQiGesc+nxKZT4Q4M4Ml617
X-Google-Smtp-Source: AGHT+IGOtg8HbIYqG5SqGGd4ADO4KcSNpfm0lou3Ti5O3G7BcFWX7DsKHnjwUmeh5q4ftKoBkLZU5w==
X-Received: by 2002:a05:690c:4c09:b0:6b0:45d:bf81 with SMTP id 00721157ae682-6b0045dc3c7mr8620777b3.38.1723699978816;
        Wed, 14 Aug 2024 22:32:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:11c4:fddc:768f:9072])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da160c7sm1482307b3.118.2024.08.14.22.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:32:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 1/6] selftests/bpf: Add traffic monitor functions.
Date: Wed, 14 Aug 2024 22:32:49 -0700
Message-Id: <20240815053254.470944-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
References: <20240815053254.470944-1-thinker.li@gmail.com>
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

    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 68, SYN
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 60, SYN, ACK
    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 60, ACK
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, ACK
    lo      In  IPv4 127.0.0.1:40265 > 127.0.0.1:55907: TCP, length 52, FIN, ACK
    lo      In  IPv4 127.0.0.1:55907 > 127.0.0.1:40265: TCP, length 52, RST, ACK
    Packet file: packets-2173-86-select_reuseport:sockhash_IPv4_TCP_LOOPBACK_test_detach_bpf-test.log
    #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK

The above is the output of an example. It shows the packets of a connection
and the name of the file that contains captured packets in the directory
/tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.

This feature only works if libpcap is available. (Could be found by pkg-config)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +
 tools/testing/selftests/bpf/network_helpers.c | 454 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  18 +
 3 files changed, 476 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b1259922d0aa..a7b100e73c78 100644
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
index a3f0a49fb26f..4ab0568d7309 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -11,17 +11,31 @@
 #include <arpa/inet.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
+#include <sys/types.h>
 #include <sys/un.h>
+#include <sys/eventfd.h>
 
 #include <linux/err.h>
 #include <linux/in.h>
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
@@ -660,3 +674,443 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 
 	return err;
 }
+
+#ifdef TRAFFIC_MONITOR
+struct tmonitor_ctx {
+	pcap_t *pcap;
+	pcap_dumper_t *dumper;
+	pthread_t thread;
+	int wake_fd;
+
+	volatile bool done;
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
+		printf("Packet captured: arphdr_type=%d\n", arphdr_type);
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
+		transport_str = "TCP";
+	} else if (proto == IPPROTO_ICMP) {
+		printf("%-7s %-3s IPv4 %s > %s: ICMP, length %d, type %d, code %d\n",
+		       ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
+		       packet[0], packet[1]);
+		return;
+	} else if (proto == IPPROTO_ICMPV6) {
+		printf("%-7s %-3s IPv6 %s > %s: ICMPv6, length %d, type %d, code %d\n",
+		       ifname, pkt_type_str(pkt_type), src_addr, dst_addr, len,
+		       packet[0], packet[1]);
+		return;
+	} else {
+		printf("%-7s %-3s %s %s > %s: protocol %d\n",
+		       ifname, pkt_type_str(pkt_type), ipv6 ? "IPv6" : "IPv4",
+		       src_addr, dst_addr, proto);
+		return;
+	}
+
+	/* TCP or UDP*/
+
+	flockfile(stdout);
+	if (ipv6)
+		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d",
+		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
+		       dst_addr, dst_port, transport_str, len);
+	else
+		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d",
+		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
+		       dst_addr, dst_port, transport_str, len);
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
+	char src_buf[INET6_ADDRSTRLEN], dst_buf[INET6_ADDRSTRLEN];
+	struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
+	const char *src, *dst;
+	u_char proto;
+
+	src = inet_ntop(AF_INET6, &pkt->saddr, src_buf, sizeof(src_buf));
+	if (!src)
+		src = "<invalid>";
+	dst = inet_ntop(AF_INET6, &pkt->daddr, dst_buf, sizeof(dst_buf));
+	if (!dst)
+		dst = "<invalid>";
+	proto = pkt->nexthdr;
+	show_transport(packet + sizeof(struct ipv6hdr),
+		       ntohs(pkt->payload_len),
+		       ifindex, src, dst, proto, true, pkt_type);
+}
+
+static void show_ipv4_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
+{
+	char src_buf[INET_ADDRSTRLEN], dst_buf[INET_ADDRSTRLEN];
+	struct iphdr *pkt = (struct iphdr *)packet;
+	const char *src, *dst;
+	u_char proto;
+
+	src = inet_ntop(AF_INET, &pkt->saddr, src_buf, sizeof(src_buf));
+	if (!src)
+		src = "<invalid>";
+	dst = inet_ntop(AF_INET, &pkt->daddr, dst_buf, sizeof(dst_buf));
+	if (!dst)
+		dst = "<invalid>";
+	proto = pkt->protocol;
+	show_transport(packet + sizeof(struct iphdr),
+		       ntohs(pkt->tot_len),
+		       ifindex, src, dst, proto, false, pkt_type);
+}
+
+static void *traffic_monitor_thread(void *arg)
+{
+	char *ifname, _ifname[IF_NAMESIZE];
+	const u_char *packet, *payload;
+	struct tmonitor_ctx *ctx = arg;
+	pcap_dumper_t *dumper = ctx->dumper;
+	int fd = ctx->pcap_fd, nfds, r;
+	int wake_fd = ctx->wake_fd;
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
+			log_err("Fail to select on pcap fd and wake fd");
+			break;
+		}
+
+		/* This instance of pcap is non-blocking */
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
+		if (!is_ethernet(packet))
+			continue;
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
+			printf("%-7s %-3s Unknown network protocol type 0x%x\n",
+			       ifname, pkt_type_str(ptype), proto);
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
+		snprintf(buf, len, "%s__%s", test_name, subtest_name);
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
+	struct nstoken *nstoken = NULL;
+	struct tmonitor_ctx *ctx;
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
+	/* Create an eventfd to wake up the monitor thread */
+	ctx->wake_fd = eventfd(0, 0);
+	if (ctx->wake_fd < 0) {
+		log_err("Failed to create eventfd");
+		goto fail_eventfd;
+	}
+
+	r = pthread_create(&ctx->thread, NULL, traffic_monitor_thread, ctx);
+	if (r) {
+		log_err("Failed to create thread");
+		goto fail;
+	}
+
+	close_netns(nstoken);
+
+	return ctx;
+
+fail:
+	close(ctx->wake_fd);
+
+fail_eventfd:
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
+	close(ctx->wake_fd);
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
+	u64 w = 1;
+
+	if (!ctx)
+		return;
+
+	/* Stop the monitor thread */
+	ctx->done = true;
+	/* Wake up the background thread. */
+	write(ctx->wake_fd, &w, sizeof(w));
+	pthread_join(ctx->thread, NULL);
+
+	printf("Packet file: %s\n", strrchr(ctx->pkt_fname, '/') + 1);
+
+	traffic_monitor_release(ctx);
+}
+#endif /* TRAFFIC_MONITOR */
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index cce56955371f..0d032ae706c6 100644
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
+	return NULL;
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


