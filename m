Return-Path: <bpf+bounces-35515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934493B388
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E11FB21D38
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFE415B133;
	Wed, 24 Jul 2024 15:22:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781A158D80
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834558; cv=none; b=XrsXHwT9ahOxj/4dZFoycH1BAWM0pLiGRFS0Sr7gBeSlMU0YPlbdlL4vJWf7yEUnlL0ff8LNPppVtnIVI8NFPHK3FThdrU1ey/y3ofFceNltukftxLulBoaxq/Dk1owTtwoSEPfPeKNXTax1+JLFyxlfkST83XvCWTgBubly0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834558; c=relaxed/simple;
	bh=MCPQY8jllkPyNHYJzTUR5uzo4QSGF1b5rkeXthfaRo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaPGLeLJhKUXoTflzGyeKcHR47dstHbjxaLlCJPA6p2SFXEQAxgC7UkGJ4HmdakquWxcOKQqQ67v27cbKbJwdTjcIT61Wx6nm2sMxy2oajRNE+4AqYpntboxFyop4T0wtEcIrMccUNLStd8LKlDMTyfV361yvr0ArOOTGDQZN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d162eef54so2670998b3a.3
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834555; x=1722439355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QZHOF+aoH+6t/vAb34zUDCrX3v3rjUoX4hX9qN1CRg=;
        b=O8LhKxmn3Y/P140kInxar1f6Im+zKb+LWtX9HhbCit+t4mwWdEW5oAofznZY8dC+ZW
         rr19vw5p+POZzUDflGRzBBoqGdgu9MRSLgR0lFrqmUYQt7kM9Xj9ISZak6uXjFCBOQlI
         cAU9mj9dA+Ig/p2Ar8lOYGqj+bJYf38y3nZ592aCeqL4sosVnm4I/ekoAJqoWzEkEYDw
         Fst9z65RaHECljFg4u2HSfpIRgtxJXR9Tm6XA8z7SjtoTFMTzXqXFHArB3+HDXuC9HUG
         iL+JExvQmXffULX7nyHUnITZptdZ12IOP/tSLoRdDJHsZZtw/eIUef46V6W2tQEHaTgr
         P8dA==
X-Gm-Message-State: AOJu0YyoyWwY0JOavY7lZEkUwqDlTfTbmnAgSrf1Ph0TLTmfrxEkldPW
	RmOlGh80k0vkGnAGS+wiBnxmNQIP34OKAQOmY1paoI24huCqsP4=
X-Google-Smtp-Source: AGHT+IGwJdnfo7dGhmUIyiyXGZ3TAM0Sop20RDexUp65p6TI0ZIW7McvMM8mzLLkMH8Zz98lGYAfSQ==
X-Received: by 2002:a05:6a21:e88:b0:1bd:27be:5dca with SMTP id adf61e73a8af0-1c472a942f6mr226666637.29.1721834554724;
        Wed, 24 Jul 2024 08:22:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d15fa98ffsm6511155b3a.186.2024.07.24.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:22:34 -0700 (PDT)
Date: Wed, 24 Jul 2024 08:22:33 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor
 functions.
Message-ID: <ZqEcOWd7qKo84YuW@mini-arch>
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-2-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723182439.1434795-2-thinker.li@gmail.com>

On 07/23, Kui-Feng Lee wrote:
> Add functions that capture packets and print log in the background. They
> are supposed to be used for debugging flaky network test cases. A monitored
> test case should call traffic_monitor_start() to start a thread to capture
> packets in the background for a given namespace and call
> traffic_monitor_stop() to stop capturing.
> 
>     IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>     IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
>     IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>     IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>     IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
>     IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
>     Packet file: packets-2172-86.log
>     #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
> 
> The above is the output of an example. It shows the packets of a connection
> and the name of the file that contains captured packets in the directory
> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
> 
> This feature only works if TRAFFIC_MONITOR variable has been passed to
> build BPF selftests. For example,
> 
>   make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
> 
> This command will build BPF selftests with this feature enabled.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   5 +
>  tools/testing/selftests/bpf/network_helpers.c | 382 ++++++++++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  16 +
>  3 files changed, 403 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index dd49c1d23a60..9dfe17588689 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -41,6 +41,11 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
>  LDFLAGS += $(SAN_LDFLAGS)
>  LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>  
> +ifneq ($(TRAFFIC_MONITOR),)
> +LDLIBS += -lpcap
> +CFLAGS += -DTRAFFIC_MONITOR=1
> +endif
> +
>  # The following tests perform type punning and they may break strict
>  # aliasing rules, which are exploited by both GCC and clang by default
>  # while optimizing.  This can lead to broken programs.
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index e0cba4178e41..c881f53c8218 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -10,6 +10,7 @@
>  
>  #include <arpa/inet.h>
>  #include <sys/mount.h>
> +#include <sys/select.h>
>  #include <sys/stat.h>
>  #include <sys/un.h>
>  
> @@ -18,6 +19,14 @@
>  #include <linux/in6.h>
>  #include <linux/limits.h>
>  
> +#include <netinet/udp.h>
> +
> +#include <pthread.h>
> +/* Prevent pcap.h from including pcap/bpf.h and causing conflicts */
> +#define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
> +#include <pcap/pcap.h>
> +#include <pcap/dlt.h>
> +
>  #include "bpf_util.h"
>  #include "network_helpers.h"
>  #include "test_progs.h"
> @@ -575,6 +584,379 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
>  	return 0;
>  }
>  
> +#ifdef TRAFFIC_MONITOR
> +struct tmonitor_ctx {
> +	pcap_t *pcap;
> +	pcap_dumper_t *dumper;
> +	pthread_t thread;
> +	int wake_fd_r;
> +	int wake_fd_w;
> +
> +	bool done;
> +	char pkt_fname[PATH_MAX];
> +	int pcap_fd;
> +};


[..]

> +/* Is this packet captured with a Ethernet protocol type? */
> +static bool is_ethernet(const u_char *packet)
> +{
> +	u16 arphdr_type;
> +
> +	memcpy(&arphdr_type, packet + 8, 2);
> +	arphdr_type = ntohs(arphdr_type);
> +
> +	/* Except the following cases, the protocol type contains the
> +	 * Ethernet protocol type for the packet.
> +	 *
> +	 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
> +	 */
> +	switch (arphdr_type) {
> +	case 770: /* ARPHRD_FRAD */
> +	case 778: /* ARPHDR_IPGRE */
> +	case 803: /* ARPHRD_IEEE80211_RADIOTAP */
> +		return false;
> +	}
> +	return true;
> +}

Are we actually getting non-ethernet packets? Any idea why?

> +/* Show the information of the transport layer in the packet */
> +static void show_transport(const u_char *packet, u16 len, u32 ifindex,
> +			   const char *src_addr, const char *dst_addr,
> +			   u16 proto, bool ipv6)
> +{
> +	struct udphdr *udp;
> +	struct tcphdr *tcp;
> +	u16 src_port, dst_port;
> +	const char *transport_str;
> +
> +	if (proto == IPPROTO_UDP) {
> +		udp = (struct udphdr *)packet;
> +		src_port = ntohs(udp->source);
> +		dst_port = ntohs(udp->dest);
> +		transport_str = "UDP";
> +	} else if (proto == IPPROTO_TCP) {
> +		tcp = (struct tcphdr *)packet;
> +		src_port = ntohs(tcp->source);
> +		dst_port = ntohs(tcp->dest);
> +		transport_str = "TCP"
> +;
> +	} else {
> +		printf("%s (proto %d): %s -> %s, ifindex %d\n",
> +		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, ifindex);
> +		return;
> +	}
> +
> +	if (ipv6)
> +		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifindex %d",
> +		       transport_str, src_addr, src_port,
> +		       dst_addr, dst_port, len, ifindex);
> +	else
> +		printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifindex %d",
> +		       transport_str, src_addr, src_port,
> +		       dst_addr, dst_port, len, ifindex);
> +
> +	if (proto == IPPROTO_TCP) {
> +		if (tcp->fin)
> +			printf(", FIN");
> +		if (tcp->syn)
> +			printf(", SYN");
> +		if (tcp->rst)
> +			printf(", RST");
> +		if (tcp->ack)
> +			printf(", ACK");
> +	}
> +
> +	printf("\n");
> +}
> +
> +static void show_ipv6_packet(const u_char *packet, u32 ifindex)
> +{
> +	struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
> +	struct in6_addr src;
> +	struct in6_addr dst;
> +	char src_str[INET6_ADDRSTRLEN], dst_str[INET6_ADDRSTRLEN];
> +	u_char proto;

[..]

> +	memcpy(&src, &pkt->saddr, sizeof(src));
> +	memcpy(&dst, &pkt->daddr, sizeof(dst));
> +	inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));
> +	inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));

nit: can probably inet_ntop(AF_INET6, &pkt->saddr, ...) directly? No
need to copy. Same for ipv4.

> +	proto = pkt->nexthdr;
> +	show_transport(packet + sizeof(struct ipv6hdr),
> +		       ntohs(pkt->payload_len),
> +		       ifindex, src_str, dst_str, proto, true);
> +}
> +
> +static void show_ipv4_packet(const u_char *packet, u32 ifindex)
> +{
> +	struct iphdr *pkt = (struct iphdr *)packet;
> +	struct in_addr src;
> +	struct in_addr dst;
> +	u_char proto;
> +	char src_str[INET_ADDRSTRLEN], dst_str[INET_ADDRSTRLEN];
> +
> +	memcpy(&src, &pkt->saddr, sizeof(src));
> +	memcpy(&dst, &pkt->daddr, sizeof(dst));
> +	inet_ntop(AF_INET, &src, src_str, sizeof(src_str));
> +	inet_ntop(AF_INET, &dst, dst_str, sizeof(dst_str));
> +	proto = pkt->protocol;
> +	show_transport(packet + sizeof(struct iphdr),
> +		       ntohs(pkt->tot_len),
> +		       ifindex, src_str, dst_str, proto, false);
> +}
> +
> +static void *traffic_monitor_thread(void *arg)
> +{
> +	const u_char *packet, *payload;
> +	struct tmonitor_ctx *ctx = arg;
> +	struct pcap_pkthdr header;
> +	pcap_t *pcap = ctx->pcap;
> +	pcap_dumper_t *dumper = ctx->dumper;
> +	int fd = ctx->pcap_fd;
> +	int wake_fd = ctx->wake_fd_r;
> +	u16 proto;
> +	u32 ifindex;
> +	fd_set fds;
> +	int nfds, r;
> +
> +	nfds = (fd > wake_fd ? fd : wake_fd) + 1;
> +	FD_ZERO(&fds);
> +
> +	while (!ctx->done) {
> +		FD_SET(fd, &fds);
> +		FD_SET(wake_fd, &fds);
> +		r = select(nfds, &fds, NULL, NULL, NULL);
> +		if (!r)
> +			continue;
> +		if (r < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			log_err("Fail to select on pcap fd and wake fd: %s", strerror(errno));
> +			break;
> +		}
> +
> +		packet = pcap_next(pcap, &header);
> +		if (!packet)
> +			continue;
> +
> +		/* According to the man page of pcap_dump(), first argument
> +		 * is the pcap_dumper_t pointer even it's argument type is
> +		 * u_char *.
> +		 */
> +		pcap_dump((u_char *)dumper, &header, packet);
> +
> +		/* Not sure what other types of packets look like. Here, we
> +		 * parse only Ethernet and compatible packets.
> +		 */
> +		if (!is_ethernet(packet)) {
> +			printf("Packet captured\n");
> +			continue;
> +		}
> +
> +		/* Skip SLL2 header
> +		 * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
> +		 *
> +		 * Although the document doesn't mention that, the payload
> +		 * doesn't include the Ethernet header. The payload starts
> +		 * from the first byte of the network layer header.
> +		 */
> +		payload = packet + 20;
> +
> +		memcpy(&proto, packet, 2);
> +		proto = ntohs(proto);
> +		memcpy(&ifindex, packet + 4, 4);
> +		ifindex = ntohl(ifindex);
> +
> +		if (proto == ETH_P_IPV6)
> +			show_ipv6_packet(payload, ifindex);
> +		else if (proto == ETH_P_IP)
> +			show_ipv4_packet(payload, ifindex);
> +		else
> +			printf("Unknown network protocol type %x, ifindex %d\n", proto, ifindex);
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Prepare the pcap handle to capture packets.
> + *
> + * This pcap is non-blocking and immediate mode is enabled to receive
> + * captured packets as soon as possible.  The snaplen is set to 1024 bytes
> + * to limit the size of captured content. The format of the link-layer
> + * header is set to DLT_LINUX_SLL2 to enable handling various link-layer
> + * technologies.
> + */
> +static pcap_t *traffic_monitor_prepare_pcap(void)
> +{
> +	char errbuf[PCAP_ERRBUF_SIZE];
> +	pcap_t *pcap;
> +	int r;
> +
> +	/* Listen on all NICs in the namespace */
> +	pcap = pcap_create("any", errbuf);
> +	if (!pcap) {
> +		log_err("Failed to open pcap: %s", errbuf);
> +		return NULL;
> +	}
> +	/* Limit the size of the packet (first N bytes) */
> +	r = pcap_set_snaplen(pcap, 1024);
> +	if (r) {
> +		log_err("Failed to set snaplen: %s", pcap_geterr(pcap));
> +		goto error;
> +	}
> +	/* To receive packets as fast as possible */
> +	r = pcap_set_immediate_mode(pcap, 1);
> +	if (r) {
> +		log_err("Failed to set immediate mode: %s", pcap_geterr(pcap));
> +		goto error;
> +	}
> +	r = pcap_setnonblock(pcap, 1, errbuf);
> +	if (r) {
> +		log_err("Failed to set nonblock: %s", errbuf);
> +		goto error;
> +	}
> +	r = pcap_activate(pcap);
> +	if (r) {
> +		log_err("Failed to activate pcap: %s", pcap_geterr(pcap));
> +		goto error;
> +	}
> +	/* Determine the format of the link-layer header */
> +	r = pcap_set_datalink(pcap, DLT_LINUX_SLL2);
> +	if (r) {
> +		log_err("Failed to set datalink: %s", pcap_geterr(pcap));
> +		goto error;
> +	}
> +
> +	return pcap;
> +error:
> +	pcap_close(pcap);
> +	return NULL;
> +}
> +
> +#define PCAP_DIR "/tmp/tmon_pcap"
> +
> +/* Start to monitor the network traffic in the given network namespace.
> + *
> + * netns: the name of the network namespace to monitor. If NULL, the
> + * current network namespace is monitored.
> + *
> + * This function will start a thread to capture packets going through NICs
> + * in the give network namespace.
> + */
> +struct tmonitor_ctx *traffic_monitor_start(const char *netns)
> +{
> +	struct tmonitor_ctx *ctx = NULL;
> +	struct nstoken *nstoken = NULL;
> +	int pipefd[2] = {-1, -1};
> +	static int tmon_seq;
> +	int r;
> +
> +	if (netns) {
> +		nstoken = open_netns(netns);
> +		if (!nstoken)
> +			return NULL;
> +	}
> +	ctx = malloc(sizeof(*ctx));
> +	if (!ctx) {
> +		log_err("Failed to malloc ctx");
> +		goto fail_ctx;
> +	}
> +	memset(ctx, 0, sizeof(*ctx));
> +
> +	snprintf(ctx->pkt_fname, sizeof(ctx->pkt_fname),
> +		 PCAP_DIR "/packets-%d-%d.log", getpid(), tmon_seq++);
> +
> +	r = mkdir(PCAP_DIR, 0755);
> +	if (r && errno != EEXIST) {
> +		log_err("Failed to create " PCAP_DIR);
> +		goto fail_pcap;
> +	}
> +
> +	ctx->pcap = traffic_monitor_prepare_pcap();
> +	if (!ctx->pcap)
> +		goto fail_pcap;
> +	ctx->pcap_fd = pcap_get_selectable_fd(ctx->pcap);
> +	if (ctx->pcap_fd < 0) {
> +		log_err("Failed to get pcap fd");
> +		goto fail_dumper;
> +	}
> +
> +	/* Create a packet file */
> +	ctx->dumper = pcap_dump_open(ctx->pcap, ctx->pkt_fname);
> +	if (!ctx->dumper) {
> +		log_err("Failed to open pcap dump");
> +		goto fail_dumper;
> +	}
> +

[..]

> +	/* Create a pipe to wake up the monitor thread */
> +	r = pipe(pipefd);
> +	if (r) {
> +		log_err("Failed to create pipe: %s", strerror(errno));
> +		goto fail;
> +	}
> +	ctx->wake_fd_r = pipefd[0];
> +	ctx->wake_fd_w = pipefd[1];

eventfd might be a simpler way to handle this. Gives you one fd which is
readable/writable. But probably ok to keep the pipe since you already
have all the code written.

