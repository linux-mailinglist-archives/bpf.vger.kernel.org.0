Return-Path: <bpf+bounces-35958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746FF940221
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC81A1F22E10
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C61B86DD;
	Tue, 30 Jul 2024 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBS21Kfw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800A65C
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299275; cv=none; b=AvE7lCQ8JFoZ9abavfN7snIpH/W9YmoBUwlRCc3JbEpyNxuFg3go8leSrG3VsLHWGdBR16EPYbXm0uX9X6iMWd+TWepJ/Fe2Nw3n37zI0U+TXFe9eIruRdypa2Q7IpJsreyySDQBwH0xSaEADB/txGSngxuJjzETS7asD7V8WCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299275; c=relaxed/simple;
	bh=UeRp76MmlVEAyM7OFAoLagnzvHL1uBoVvdpGZVe5pfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8oGbclKSk3+5Vbt5diiJW+EMlZHA762LDUtPuu0hFZxNAT/z4LLHNKjkIIkJzx82JsGSi8sGRndLfpRsPa711v9tTrTOBEzRNSfDIasnq4/onS/Tj3elBYYf4f3gnCgA+V/q3O1yaQc3jz2voKjwIb75EbnM8Fo1KSmcWto3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBS21Kfw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65f7bd30546so19907047b3.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299273; x=1722904073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J8SWc/SkJPjpXoQ+spKfYiRbDXddgITpmgWFQNXrn8=;
        b=KBS21KfwUj7/5k4/e0jfGq31Bny82Tz0B8UQSsJ5dstfPboDQcO941vtwPAyURdfnk
         1IrWKBgOOMYyCEDjuRf+Fi5lulBt9su/0WTQzB37GRcnai09tzAHhvUr7fXJhUu0V7/i
         E0pBdOCBvuufc0tFLkP1bIpVRynlxVWjF2s/+eO3anecsB0ZW8oFP9fp9vM801HSGxBa
         RKUJc74VDeEJW+TpXa1pOtKoSrOtinP//QUZLW99TLwiC9qH4J3WQHOQS3q564p3sqbA
         NftPtVX+FttOYda8i+bj8e+maHEz831RDRpqlb24xf29CNhH3Z/qkZ60hV/ZOVUoJGPH
         HBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299273; x=1722904073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J8SWc/SkJPjpXoQ+spKfYiRbDXddgITpmgWFQNXrn8=;
        b=cpEHLt9z4Q5v8IBhN+9zvubj2u1EMnuyzdjyemAce+fKHHW0LqnioohE7kBb4Et7vH
         zVr8kmPMLNdcSZWAqbpBxFRqkQZID6WqUgCMCBHpWJhoy+sMnsnZfmiIIF6ID+RPPYwk
         vCnbzhmeHpNGzJyBLr9QUMPkWHKNymd6ELguNm3YM0FZ7UObeoX0b2mEbjKR1VP5ifFk
         TvU41Hj8BYtlitbBhikmvKBGaOPXTB6oSJsft0TwpFIAldqglgOSfrx4yRDHuKAg9GVE
         JicTRNJYuyEGzLtnnWODtgFfQaSL1FhDg1fv1CiM6kO0F+jginqJjy2/8862DjjUmkYG
         HoWg==
X-Gm-Message-State: AOJu0YxzMeD0JQwhYVGQ5vBCP/nW8UtJqzw0IqTakHjVnTHvDPCi3ijD
	TR59Iv5WJTBQ2ZbSs+aamHt31x9sMNFDuTvQMBcSpKy9ctm8qeGopvW/TH//
X-Google-Smtp-Source: AGHT+IELjI16QIc8Vr9B94k0JSRKexU4ZX+lUZRwLokvDCSlVR8PEXr5w3YvZ6r9ReOk6ncnZoah7A==
X-Received: by 2002:a0d:eb0a:0:b0:61b:e61e:8988 with SMTP id 00721157ae682-6826ef4c6e2mr3655997b3.18.1722299272500;
        Mon, 29 Jul 2024 17:27:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/6] selftests/bpf: Add traffic monitor functions.
Date: Mon, 29 Jul 2024 17:27:40 -0700
Message-Id: <20240730002745.1484204-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730002745.1484204-1-thinker.li@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
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

    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
    Packet file: packets-2172-86-select_reuseport:sockhash-test.log
    #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK

The above is the output of an example. It shows the packets of a connection
and the name of the file that contains captured packets in the directory
/tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.

This feature only works if TRAFFIC_MONITOR variable has been passed to
build BPF selftests. For example,

  make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf

This command will build BPF selftests with this feature enabled.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/Makefile     |   5 +
 tools/testing/selftests/bpf/test_progs.c | 432 +++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |  16 +
 3 files changed, 453 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dd49c1d23a60..9dfe17588689 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -41,6 +41,11 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
+ifneq ($(TRAFFIC_MONITOR),)
+LDLIBS += -lpcap
+CFLAGS += -DTRAFFIC_MONITOR=1
+endif
+
 # The following tests perform type punning and they may break strict
 # aliasing rules, which are exploited by both GCC and clang by default
 # while optimizing.  This can lead to broken programs.
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 89ff704e9dad..62303eca11f4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -15,10 +15,25 @@
 #include <netinet/in.h>
 #include <sys/select.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <sys/un.h>
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+#include <linux/ip.h>
+#include <linux/udp.h>
+#include <netinet/tcp.h>
+#include <net/if.h>
+#include "network_helpers.h"
+
+#ifdef TRAFFIC_MONITOR
+/* Prevent pcap.h from including pcap/bpf.h and causing conflicts */
+#define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
+#include <pcap/pcap.h>
+#include <pcap/dlt.h>
+#endif
+
 static bool verbose(void)
 {
 	return env.verbosity > VERBOSE_NONE;
@@ -402,6 +417,423 @@ static void restore_netns(void)
 	}
 }
 
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
+/* Show the information of the transport layer in the packet */
+static void show_transport(const u_char *packet, u16 len, u32 ifindex,
+			   const char *src_addr, const char *dst_addr,
+			   u16 proto, bool ipv6)
+{
+	struct udphdr *udp;
+	struct tcphdr *tcp;
+	u16 src_port, dst_port;
+	const char *transport_str;
+	char *ifname, _ifname[IF_NAMESIZE];
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
+		printf("IPv4 ICMP packet: %s -> %s, len %d, type %d, code %d, ifname %s\n",
+		       src_addr, dst_addr, len, packet[0], packet[1], ifname);
+		return;
+	} else if (proto == IPPROTO_ICMPV6) {
+		printf("IPv6 ICMPv6 packet: %s -> %s, len %d, type %d, code %d, ifname %s\n",
+		       src_addr, dst_addr, len, packet[0], packet[1], ifname);
+		return;
+	} else {
+		printf("%s (proto %d): %s -> %s, ifname %s\n",
+		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, ifname);
+		return;
+	}
+
+	/* TCP */
+
+	if (ipv6)
+		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifname %s",
+		       transport_str, src_addr, src_port,
+		       dst_addr, dst_port, len, ifname);
+	else
+		printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifname %s",
+		       transport_str, src_addr, src_port,
+		       dst_addr, dst_port, len, ifname);
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
+}
+
+static void show_ipv6_packet(const u_char *packet, u32 ifindex)
+{
+	struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
+	struct in6_addr src;
+	struct in6_addr dst;
+	char src_str[INET6_ADDRSTRLEN], dst_str[INET6_ADDRSTRLEN];
+	u_char proto;
+
+	memcpy(&src, &pkt->saddr, sizeof(src));
+	memcpy(&dst, &pkt->daddr, sizeof(dst));
+	inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));
+	inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));
+	proto = pkt->nexthdr;
+	show_transport(packet + sizeof(struct ipv6hdr),
+		       ntohs(pkt->payload_len),
+		       ifindex, src_str, dst_str, proto, true);
+}
+
+static void show_ipv4_packet(const u_char *packet, u32 ifindex)
+{
+	struct iphdr *pkt = (struct iphdr *)packet;
+	struct in_addr src;
+	struct in_addr dst;
+	u_char proto;
+	char src_str[INET_ADDRSTRLEN], dst_str[INET_ADDRSTRLEN];
+
+	memcpy(&src, &pkt->saddr, sizeof(src));
+	memcpy(&dst, &pkt->daddr, sizeof(dst));
+	inet_ntop(AF_INET, &src, src_str, sizeof(src_str));
+	inet_ntop(AF_INET, &dst, dst_str, sizeof(dst_str));
+	proto = pkt->protocol;
+	show_transport(packet + sizeof(struct iphdr),
+		       ntohs(pkt->tot_len),
+		       ifindex, src_str, dst_str, proto, false);
+}
+
+static void *traffic_monitor_thread(void *arg)
+{
+	char *ifname, _ifname[IF_NAMESIZE];
+	const u_char *packet, *payload;
+	struct tmonitor_ctx *ctx = arg;
+	struct pcap_pkthdr header;
+	pcap_t *pcap = ctx->pcap;
+	pcap_dumper_t *dumper = ctx->dumper;
+	int fd = ctx->pcap_fd;
+	int wake_fd = ctx->wake_fd_r;
+	u16 proto;
+	u32 ifindex;
+	fd_set fds;
+	int nfds, r;
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
+
+		if (proto == ETH_P_IPV6) {
+			show_ipv6_packet(payload, ifindex);
+		} else if (proto == ETH_P_IP) {
+			show_ipv4_packet(payload, ifindex);
+		} else {
+			ifname = if_indextoname(ifindex, _ifname);
+			if (!ifname) {
+				snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
+				ifname = _ifname;
+			}
+
+			printf("Unknown network protocol type %x, ifname %s\n", proto, ifname);
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
+static void encode_test_name(char *buf, size_t len)
+{
+	struct prog_test_def *test = env.test;
+	struct subtest_state *subtest_state = env.subtest_state;
+	char *p;
+
+	if (subtest_state)
+		snprintf(buf, len, "%s:%s", test->test_name, subtest_state->name);
+	else
+		snprintf(buf, len, "%s", test->test_name);
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
+ * current network namespace is monitored.
+ *
+ * This function will start a thread to capture packets going through NICs
+ * in the give network namespace.
+ */
+struct tmonitor_ctx *traffic_monitor_start(const char *netns)
+{
+	struct tmonitor_ctx *ctx = NULL;
+	struct nstoken *nstoken = NULL;
+	int pipefd[2] = {-1, -1};
+	static int tmon_seq;
+	char test_name[64];
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
+	encode_test_name(test_name, sizeof(test_name));
+	snprintf(ctx->pkt_fname, sizeof(ctx->pkt_fname),
+		 PCAP_DIR "/packets-%d-%d-%s-%s.log", getpid(), tmon_seq++,
+		 test_name, netns ? netns : "unknown");
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
+
 void test__end_subtest(void)
 {
 	struct prog_test_def *test = env.test;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 51341d50213b..5a9191f69707 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -474,4 +474,20 @@ extern void test_loader_fini(struct test_loader *tester);
 	test_loader_fini(&tester);					       \
 })
 
+struct tmonitor_ctx;
+
+#ifdef TRAFFIC_MONITOR
+struct tmonitor_ctx *traffic_monitor_start(const char *netns);
+void traffic_monitor_stop(struct tmonitor_ctx *ctx);
+#else
+static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns)
+{
+	return (struct tmonitor_ctx *)-1;
+}
+
+static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
+{
+}
+#endif
+
 #endif /* __TEST_PROGS_H */
-- 
2.34.1


