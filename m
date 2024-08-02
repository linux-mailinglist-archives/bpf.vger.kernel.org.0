Return-Path: <bpf+bounces-36254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD19A9456AC
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C75B21E26
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B471862;
	Fri,  2 Aug 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cu+M6sN8"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A522EE4
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 03:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722569395; cv=none; b=iS5nWoRZAmbRuX4G72KeBGz2G0tjvPOTvD1i5OcsIRPFChN/M4Ixm/XOMZlCE4aIIidFsP8yjw9BVifcIwn1La9u2oqzIHfZma9JShjlPxSQFhp3uKbkSclUG8n7RNUgVMqUAT6FsiVoOmbf21XuXROwX+E8aGTofNhgVf8AD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722569395; c=relaxed/simple;
	bh=wGlpdZ6JEzqG2rn073MrWky3ldxMXh6ratvzzHA49Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4AeXrXVQL/KLQRogxmO+YkM4dJudkyW5BUzaHzIh0rU04dU8AkVXaInnGUONmwzwJNMB6u72Lr0CuMa6cfxl0J8QS81Y6oPaoGht93wRcMQDvGasd5VsEUWb/ReuCdhBNj2dFy5eyt0lAvdFnUHp5SPnntT06pBKAS+ZM0lU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cu+M6sN8; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <157ef482-a018-46da-b049-10c47fd286c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722569390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXWUPKIzHvM0Lw9BLBH3vCFntvsmPINwoQD+SACIKRs=;
	b=cu+M6sN85XnaCB2OJ7hTgnfEeQ2gsIpHvlIzD3hyW8+tzFcq8k98t+SykocBum6DcxjdEO
	QSAJo/ffcd2v2e7sltwk9aT8ZEVGdYZeUMbYVwsqDDTV1/NkAjtdscLhVYRXX/4ldOUgVG
	gbvImoApAGoMlGT7tasI6NOKTxFujuE=
Date: Thu, 1 Aug 2024 20:29:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240731193140.758210-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
> Add functions that capture packets and print log in the background. They
> are supposed to be used for debugging flaky network test cases. A monitored
> test case should call traffic_monitor_start() to start a thread to capture
> packets in the background for a given namespace and call
> traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
> the later patches.)
> 
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, ifindex 1, SYN
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, ifindex 1, SYN, ACK
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, ifindex 1, ACK
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, ACK
>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, ifindex 1, FIN, ACK
>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, ifindex 1, RST, ACK

nit. Instead of ifindex, it should be ifname now.

>      Packet file: packets-2172-86-select_reuseport:sockhash-test.log
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
>   tools/testing/selftests/bpf/Makefile     |   5 +
>   tools/testing/selftests/bpf/test_progs.c | 432 +++++++++++++++++++++++

In the cover letter, it mentioned the traffic monitoring implementation is moved 
from the network_helpers.c to test_progs.c.

Can you share more about the reason?

Is it because the traffic monitor now depends on the test_progs's test name, 
should_tmon...etc ? Can the test name and should_tmon be exported for the 
network_helpers to use?

What other compilation issues did it hit if the traffic monitor codes stay in 
the network_helpers.c? Some individual binaries (with main()) like 
test_tcp_check_syncookie_user that links to network_helpers.o but not to 
test_progs.o?

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
> +	char *ifname, _ifname[IF_NAMESIZE];
> +
> +	ifname = if_indextoname(ifindex, _ifname);
> +	if (!ifname) {
> +		snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
> +		ifname = _ifname;
> +	}
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
> +	} else if (proto == IPPROTO_ICMP) {
> +		printf("IPv4 ICMP packet: %s -> %s, len %d, type %d, code %d, ifname %s\n",
> +		       src_addr, dst_addr, len, packet[0], packet[1], ifname);
> +		return;
> +	} else if (proto == IPPROTO_ICMPV6) {
> +		printf("IPv6 ICMPv6 packet: %s -> %s, len %d, type %d, code %d, ifname %s\n",
> +		       src_addr, dst_addr, len, packet[0], packet[1], ifname);
> +		return;
> +	} else {
> +		printf("%s (proto %d): %s -> %s, ifname %s\n",
> +		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, ifname);
> +		return;
> +	}
> +
> +	/* TCP */
> +
> +	if (ipv6)
> +		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifname %s",
> +		       transport_str, src_addr, src_port,
> +		       dst_addr, dst_port, len, ifname);
> +	else
> +		printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifname %s",
> +		       transport_str, src_addr, src_port,
> +		       dst_addr, dst_port, len, ifname);
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

The TCP packet output is done by multiple printf. There is a good chance that 
one TCP packet is interleaved with the other printf(s), considering the traffic 
monitoring is done in its own thread. I am seeing this in the tc_redirect test.

Does it help to do multiple snprintf (for the tcp flags?) first and then calls 
one printf?

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
> +	char *ifname, _ifname[IF_NAMESIZE];
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

The captured file has the "In", "Out", and "M" (Multicast) when it is read by 
tcpdump. Is it easy to printf that in show_ipv[46]_packet() also? Just want to 
ensure we didn't miss it if it is easy.

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
> +		if (proto == ETH_P_IPV6) {
> +			show_ipv6_packet(payload, ifindex);
> +		} else if (proto == ETH_P_IP) {
> +			show_ipv4_packet(payload, ifindex);
> +		} else {
> +			ifname = if_indextoname(ifindex, _ifname);
> +			if (!ifname) {
> +				snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
> +				ifname = _ifname;
> +			}
> +
> +			printf("Unknown network protocol type %x, ifname %s\n", proto, ifname);
> +		}
> +	}
> +
> +	return NULL;
> +}



