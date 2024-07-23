Return-Path: <bpf+bounces-35409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD293A57F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD53B21C89
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF315885A;
	Tue, 23 Jul 2024 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHFJFuOY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120AF1581EB
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759087; cv=none; b=V+e69nxfy2xJFH6Q/YKFFzQgpp+lDEDwwr186AnN6q2QgieJR4M6JqlRQlR2tiWkrRmpt3pbtpR6AV7lfw899wMfHhvkTXHnSg2R4OyfkLfvOWPD/WUvXvNhl+8/SBpYJSWfi2dO4SeqJRLEhKFgjAsc2pA4oBb/ejwVxxj0H7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759087; c=relaxed/simple;
	bh=nvIcnh2E8f7dFrFhBEhkqGT+vmhcW1Csl2uu8oUZsFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zbwo0XglX/gB0qNVbJv/JbraIbsLHaNNe4cEAehLXVYErJ8h6IkNRMpueyT9hiD21rympgvyYclAFTJjrD5ewpSzqPEAwIi3puQvw+IXp+3gnsNfTfoWVNpc8p3moUxDXeEJ+B+nec7ngBrhIn4UeCfk7wgCy5Os5T6gfE85O5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHFJFuOY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-664b4589b1aso929757b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721759084; x=1722363884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMVfRwutfef2Q9BR3ChJW1oC0AgSMTROQ0q1Xl3rlb8=;
        b=kHFJFuOY3eYB4g02pXwOOo9fpUF7+e4ZYQrNwtjtNLOVEu6m/d7OIciZTSrqptZbHq
         D8PRq+asJG3+FARDPEl6t/yWbgp9RCyhEdzqDhR2rEsaZ7Hee4/4RGBLW2RDBY/ZPQPs
         pVTAVoV4L+xo7p0SEUyFUcdAxipVBNEljhC7cpyTzW2V8xUrJe4qf1njtJU3n8JVEdXQ
         bD84MSQmOg8bXMDGl6USxaLPl9DlpnJfh6IC+riMG1vWB8WbntxNjb+bmOYnGA04f7k+
         KMYvy5QgKrWbDc6HUlYrzkyuPKDAuDy+ykxWyppPLRNIrV7GrTAxCon/F5h+OGTIotcx
         DXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759084; x=1722363884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMVfRwutfef2Q9BR3ChJW1oC0AgSMTROQ0q1Xl3rlb8=;
        b=phLEdaDcV/mJQ37nzUVZG+38k1Ss6vnX+yiX33ag0p0GCzjtAXQGysDrCMZ9bC8xw4
         5FhEGIe42aPE66Kz62rsPtnS7k4gzWNxqg3HKFFIA0gCv7zrFg8hIZujVhSn9xbvqekz
         UaTOisRGMCtie/SsHmZFmyvy6pNzAupgTipdpF+o2JG8/WMRSNSusYsKzzevgN6waI3u
         D9Fg1ruIhGGr5bJtDUgv/AGUg0QdBCdG42rPNT+NncmiO0oBHWEsLc/tbzo5zhs0K5z2
         JD4UM5rh8e0WiOiKJnJkDRR1cVU6nHJJfEVRIxoO/BA4hzLI1b3ZcX/Iq0DudluDqX6f
         jEyQ==
X-Gm-Message-State: AOJu0Yzu7f4UyW+dzKVM6O9H44eLGWrHs4ZT0TuQCoiJgwHOXrRE+IY7
	XmXsoFqIvUzeTFnxZRJcmlo3S5a/iFutaYUV1eDeNsqpJxetpwrODOq4CPlm
X-Google-Smtp-Source: AGHT+IG58PXXI5R0bAebyikGGUKV+5hwkcQWrKeeCEdsyg85EKbf0CJb/WrGlvNliI54VzgmEtec6A==
X-Received: by 2002:a05:690c:f:b0:640:aec2:101c with SMTP id 00721157ae682-66e8ff97af4mr29605667b3.2.1721759083852;
        Tue, 23 Jul 2024 11:24:43 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e02a:b5d8:6984:234c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6695293fd9csm20637577b3.69.2024.07.23.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:24:43 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor functions.
Date: Tue, 23 Jul 2024 11:24:36 -0700
Message-Id: <20240723182439.1434795-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723182439.1434795-1-thinker.li@gmail.com>
References: <20240723182439.1434795-1-thinker.li@gmail.com>
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
traffic_monitor_stop() to stop capturing.

    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
    IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
    IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
    Packet file: packets-2172-86.log
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
 tools/testing/selftests/bpf/Makefile          |   5 +
 tools/testing/selftests/bpf/network_helpers.c | 382 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  16 +
 3 files changed, 403 insertions(+)

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
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e0cba4178e41..c881f53c8218 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -10,6 +10,7 @@
 
 #include <arpa/inet.h>
 #include <sys/mount.h>
+#include <sys/select.h>
 #include <sys/stat.h>
 #include <sys/un.h>
 
@@ -18,6 +19,14 @@
 #include <linux/in6.h>
 #include <linux/limits.h>
 
+#include <netinet/udp.h>
+
+#include <pthread.h>
+/* Prevent pcap.h from including pcap/bpf.h and causing conflicts */
+#define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
+#include <pcap/pcap.h>
+#include <pcap/dlt.h>
+
 #include "bpf_util.h"
 #include "network_helpers.h"
 #include "test_progs.h"
@@ -575,6 +584,379 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	return 0;
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
+	} else {
+		printf("%s (proto %d): %s -> %s, ifindex %d\n",
+		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, ifindex);
+		return;
+	}
+
+	if (ipv6)
+		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifindex %d",
+		       transport_str, src_addr, src_port,
+		       dst_addr, dst_port, len, ifindex);
+	else
+		printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifindex %d",
+		       transport_str, src_addr, src_port,
+		       dst_addr, dst_port, len, ifindex);
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
+		if (proto == ETH_P_IPV6)
+			show_ipv6_packet(payload, ifindex);
+		else if (proto == ETH_P_IP)
+			show_ipv4_packet(payload, ifindex);
+		else
+			printf("Unknown network protocol type %x, ifindex %d\n", proto, ifindex);
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
+	snprintf(ctx->pkt_fname, sizeof(ctx->pkt_fname),
+		 PCAP_DIR "/packets-%d-%d.log", getpid(), tmon_seq++);
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
+		log_err("Failed to open pcap dump");
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
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index aac5b94d6379..a4067f33a800 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -82,6 +82,22 @@ int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
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
 struct nstoken;
 /**
  * open_netns() - Switch to specified network namespace by name.
-- 
2.34.1


