Return-Path: <bpf+bounces-35434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E893A908
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 00:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E82838BC
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C21448D8;
	Tue, 23 Jul 2024 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC3b7Nt9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514B1422CC
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772222; cv=none; b=HGQkimXfC/Eh1H1DMUpNSUAZuz9mcs1OjUa9wIjLyeF3YDV+KWbJZfh/bAaZFjiXgY+fUcS8+3TWgSOAqQGTCC2Q4xDDCfGny2ZiPySI+gzgrA86/SMtBrGfqobcZTOlhjU84yVkyFNT7owRXK9sMYWloeoPojSGn3rTsqiyAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772222; c=relaxed/simple;
	bh=iyOfunYYV6miut1LCi4sik/5Vmm/6ub7VM06yHTbQus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvB0HhskFKPs9+6Yy0fpqzC9WOYVVO/U9K1I3/nXdDWBJpVu+zsHDSO0XKFdL4d5ZrrkvhpnLxhEKarxtWSt7v7WIJYbc8MrrXJqNQRjimX0prZxXXsanBIdf9++lTFvPVoQ4Cedz/3+6V87toYFDPQs/Je3cZGfBHd9YK4oBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC3b7Nt9; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65f7bd30546so2504667b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721772220; x=1722377020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsDpeP67vTxwqNhp8IComO5UluxMWK+hnLJop7Cf6dQ=;
        b=cC3b7Nt9qEsPIKGSKJCz0k0p3TQBfDmiF/Y2kedQZhIG5WgBzhBmsFotDFeDlLMa/+
         ehrhRP8tGzKnhIxelb4oRxiAgyP6CaD+uhHNzsUvg042UyD9cTvm/QUszdlcbnej3NxB
         e/vhplilja4rZ6Poi4RpIR1lANPkc5gbHJ6fRqn0IAGOS2Q54o+FxB0zEzDvkfbUs11W
         jpQR9B7IWjh5F8E17yvW3VvSamcMo+QhqGMdaGWGvJk+v7ueaFhdgouzm8BNO+HJfkay
         7OflVZwUfJhKTVMrFHri7l0RqEvzDaiFr1VY7MYVvPcPwUzBt5Hu6F8mUv+noEKGJ0r8
         B95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721772220; x=1722377020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsDpeP67vTxwqNhp8IComO5UluxMWK+hnLJop7Cf6dQ=;
        b=TfW7YXkNfx8u95E4kv0JyBQRkxKOzNUbx2mJl5RHM9Rb4fGIIFZJ6jc8YDSQZNQcEx
         Sv3ethyiA7OQbQ88Ap+1QJZk4hbHNlsmnKs7LCiSOtA4Yz8NxJolqr/GsEwwUXKd/pmc
         5V9Md51kLyTXwpszf/Hzmtaqzz8OuPtruycd/gqeFrlcCdsWaSKxwL4ooChf2TR4qRZK
         3T2U+tkgoXt1NE75DNBL9i5GxxEz6lmNG70PVGG0yH+i9m/XWTFHmZmvDa4+EmUXwHz6
         EtBOKG7WGqFUYUe/7UpD4YC6i8W4dUQ1/Hr3Vk7gCwIWKDcijwCr6hki2YbtjeQp5tZy
         HHuw==
X-Forwarded-Encrypted: i=1; AJvYcCWFURr+Ct1ko/5LXHja+/w+71aRGYYTY17GLHuXxO+fNAzHgsALUQiZtsk4wZ/QXNoLUDAeCBhsttzR32bNOa45F0Gq
X-Gm-Message-State: AOJu0Yyw4h0M+waSkb51zdX20N9eSP+nvZkTgm9zNzTGBaPa9OmVK3w1
	CW7BY5qJJ/l+zSNVFxCVlyHLbs2wq2kpdBv2HQcXsHnLhIjK9iob
X-Google-Smtp-Source: AGHT+IGJMobJZ/bRfdlzrLOGn5n+ooB8Do4R/3GQACNvMlIIsJ64sHNQ0+/v71mgXi0+NVUdGwAY/g==
X-Received: by 2002:a0d:f841:0:b0:62f:19da:a53f with SMTP id 00721157ae682-672b691d181mr141817b3.0.1721772219606;
        Tue, 23 Jul 2024 15:03:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8343:a788:55dc:60a4? ([2600:1700:6cf8:1240:8343:a788:55dc:60a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66951f728a4sm21573907b3.18.2024.07.23.15.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 15:03:39 -0700 (PDT)
Message-ID: <0dd13ca7-f0f3-4561-a0bb-d1b9d1887233@gmail.com>
Date: Tue, 23 Jul 2024 15:03:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, sdf@fomichev.me
Cc: kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-2-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240723182439.1434795-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 11:24, Kui-Feng Lee wrote:
> Add functions that capture packets and print log in the background. They
> are supposed to be used for debugging flaky network test cases. A monitored
> test case should call traffic_monitor_start() to start a thread to capture
> packets in the background for a given namespace and call
> traffic_monitor_stop() to stop capturing.
> 
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK
>      Packet file: packets-2172-86.log
>      #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK test_detach_bpf:OK
> 
> The above is the output of an example. It shows the packets of a connection
> and the name of the file that contains captured packets in the directory
> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
> 
> This feature only works if TRAFFIC_MONITOR variable has been passed to
> build BPF selftests. For example,
> 
>    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
> 
> This command will build BPF selftests with this feature enabled.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   5 +
>   tools/testing/selftests/bpf/network_helpers.c | 382 ++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  16 +
>   3 files changed, 403 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index dd49c1d23a60..9dfe17588689 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -41,6 +41,11 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
>   LDFLAGS += $(SAN_LDFLAGS)
>   LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
>   
> +ifneq ($(TRAFFIC_MONITOR),)
> +LDLIBS += -lpcap
> +CFLAGS += -DTRAFFIC_MONITOR=1
> +endif
> +
>   # The following tests perform type punning and they may break strict
>   # aliasing rules, which are exploited by both GCC and clang by default
>   # while optimizing.  This can lead to broken programs.
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index e0cba4178e41..c881f53c8218 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -10,6 +10,7 @@
>   
>   #include <arpa/inet.h>
>   #include <sys/mount.h>
> +#include <sys/select.h>
>   #include <sys/stat.h>
>   #include <sys/un.h>
>   
> @@ -18,6 +19,14 @@
>   #include <linux/in6.h>
>   #include <linux/limits.h>
>   
> +#include <netinet/udp.h>
> +
> +#include <pthread.h>
> +/* Prevent pcap.h from including pcap/bpf.h and causing conflicts */
> +#define PCAP_DONT_INCLUDE_PCAP_BPF_H 1
> +#include <pcap/pcap.h>
> +#include <pcap/dlt.h>

Just noticed that the above lines fails on an environment without pcap
installed. It will be fixed in next version.

> +
>   #include "bpf_util.h"
>   #include "network_helpers.h"
>   #include "test_progs.h"
> @@ -575,6 +584,379 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
>   	return 0;
>   }
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
> +
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
> +
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
> +
> +	memcpy(&src, &pkt->saddr, sizeof(src));
> +	memcpy(&dst, &pkt->daddr, sizeof(dst));
> +	inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));
> +	inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));
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
> +	/* Create a pipe to wake up the monitor thread */
> +	r = pipe(pipefd);
> +	if (r) {
> +		log_err("Failed to create pipe: %s", strerror(errno));
> +		goto fail;
> +	}
> +	ctx->wake_fd_r = pipefd[0];
> +	ctx->wake_fd_w = pipefd[1];
> +
> +	r = pthread_create(&ctx->thread, NULL, traffic_monitor_thread, ctx);
> +	if (r) {
> +		log_err("Failed to create thread: %s", strerror(r));
> +		goto fail;
> +	}
> +
> +	close_netns(nstoken);
> +
> +	return ctx;
> +
> +fail:
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +
> +	pcap_dump_close(ctx->dumper);
> +	unlink(ctx->pkt_fname);
> +
> +fail_dumper:
> +	pcap_close(ctx->pcap);
> +
> +fail_pcap:
> +	free(ctx);
> +
> +fail_ctx:
> +	close_netns(nstoken);
> +
> +	return NULL;
> +}
> +
> +static void traffic_monitor_release(struct tmonitor_ctx *ctx)
> +{
> +	pcap_close(ctx->pcap);
> +	pcap_dump_close(ctx->dumper);
> +
> +	close(ctx->wake_fd_r);
> +	close(ctx->wake_fd_w);
> +
> +	free(ctx);
> +}
> +
> +/* Stop the network traffic monitor.
> + *
> + * ctx: the context returned by traffic_monitor_start()
> + */
> +void traffic_monitor_stop(struct tmonitor_ctx *ctx)
> +{
> +	if (!ctx)
> +		return;
> +
> +	/* Stop the monitor thread */
> +	ctx->done = true;
> +	write(ctx->wake_fd_w, "x", 1);
> +	pthread_join(ctx->thread, NULL);
> +
> +	printf("Packet file: %s\n", strrchr(ctx->pkt_fname, '/') + 1);
> +
> +	traffic_monitor_release(ctx);
> +}
> +#endif /* TRAFFIC_MONITOR */
> +
>   struct send_recv_arg {
>   	int		fd;
>   	uint32_t	bytes;
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index aac5b94d6379..a4067f33a800 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -82,6 +82,22 @@ int get_socket_local_port(int sock_fd);
>   int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
>   int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
>   
> +struct tmonitor_ctx;
> +
> +#ifdef TRAFFIC_MONITOR
> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
> +#else
> +static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns)
> +{
> +	return (struct tmonitor_ctx *)-1;
> +}
> +
> +static inline void traffic_monitor_stop(struct tmonitor_ctx *ctx)
> +{
> +}
> +#endif
> +
>   struct nstoken;
>   /**
>    * open_netns() - Switch to specified network namespace by name.

