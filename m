Return-Path: <bpf+bounces-36727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67594C658
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746891F26B7C
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D48C146D6D;
	Thu,  8 Aug 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArICZVpd"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BE10A1E
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723152952; cv=none; b=SH3/wrLc/ZCnN5+H2C4d/H8LKcWhmbQjbgKTqQZOHnYfhfVQSxUZLaEyFqKFgTXoIGhxDUt/CWaQpBa4863pkmrxx8G7PjHtsMTGQk6CIuxvoK+SfDjvbb2Wq3/bhdiPYGPUijCbQm8LH1+IwX9dxvWwtgkocRZLJ+n4t+zEXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723152952; c=relaxed/simple;
	bh=n6+1Jaxrrl2C3Sn0chBkwCCZeo+BYvCv8vsNoMbmfBQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hcYUnJ2MShHADJqSx475X8unVnOKFkRGJ267CN9PPdp/TbomsbmFyn0aosbyJTzzdC8/MIXlMboy8o5FIN3UvgP2e2xiDR1cOkrWgt/jt4QiEshdFCK0UpJC+BiDBYMmMwyJP4q5dHIJSf001hnR7Hf/bPyEHo7gSAtaunr4SAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArICZVpd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be108b0b-202c-4a87-8ac3-1b9f61dca3c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723152946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ+7UWcIUfN3L3nTGRLtvhl2iz7zR7aOyWMbdtELy5Q=;
	b=ArICZVpdso0KObFfVI6jnxYD9AXK1KRFFbV8RExt8XPYEf9t/+Ct8U/QGTPsW8SjTzbU3Q
	8+3HjlKzie7qM0Aot1OlJwuSz1mgKNh4k5SRLljwCFBDra4sg05J+MqgvpVdOaZR0WbReF
	XHU4PH9buZASLGYB0Q1MgtcHHFRPQVc=
Date: Thu, 8 Aug 2024 14:35:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v6 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-2-thinker.li@gmail.com>
Content-Language: en-US
In-Reply-To: <20240807183149.764711-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
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
> +static const char * const pkt_types[] = {
> +	"In",
> +	"B",			/* Broadcast */
> +	"M",			/* Multicast */
> +	"C",			/* Captured with the promiscuous mode */
> +	"Out",
> +};
> +
> +static const char *pkt_type_str(u16 pkt_type)
> +{
> +	if (pkt_type < ARRAY_SIZE(pkt_types))
> +		return pkt_types[pkt_type];
> +	return "Unknown";
> +}
> +
> +/* Show the information of the transport layer in the packet */
> +static void show_transport(const u_char *packet, u16 len, u32 ifindex,
> +			   const char *src_addr, const char *dst_addr,
> +			   u16 proto, bool ipv6, u8 pkt_type)
> +{
> +	char *ifname, _ifname[IF_NAMESIZE];
> +	const char *transport_str;
> +	u16 src_port, dst_port;
> +	struct udphdr *udp;
> +	struct tcphdr *tcp;
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

nit. ";" spilled over to a newline.

> +	} else if (proto == IPPROTO_ICMP) {
> +		printf("IPv4 ICMP packet: %s -> %s, len %d, type %d, code %d, ifname %s (%s)\n",
> +		       src_addr, dst_addr, len, packet[0], packet[1], ifname,
> +		       pkt_type_str(pkt_type));

nit. Move pkt_type_str(pkt_type) to the front. That will resemble the tcpdump 
output to make the output familiar to most people. Same for the other proto below.

> +		return;
> +	} else if (proto == IPPROTO_ICMPV6) {
> +		printf("IPv6 ICMPv6 packet: %s -> %s, len %d, type %d, code %d, ifname %s (%s)\n",
> +		       src_addr, dst_addr, len, packet[0], packet[1], ifname,
> +		       pkt_type_str(pkt_type));
> +		return;
> +	} else {
> +		printf("%s (proto %d): %s -> %s, ifname %s (%s)\n",
> +		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr,
> +		       ifname, pkt_type_str(pkt_type));
> +		return;
> +	}
> +
> +	/* TCP */
> +
> +	flockfile(stdout);
> +	if (ipv6)
> +		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifname %s (%s)",
> +		       transport_str, src_addr, src_port,
> +		       dst_addr, dst_port, len, ifname, pkt_type_str(pkt_type));
> +	else
> +		printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifname %s (%s)",
> +		       transport_str, src_addr, src_port,
> +		       dst_addr, dst_port, len, ifname, pkt_type_str(pkt_type));
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
> +	funlockfile(stdout);
> +}
> +
> +static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
> +{
> +	char src_str[INET6_ADDRSTRLEN], dst_str[INET6_ADDRSTRLEN];
> +	struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
> +	struct in6_addr src;
> +	struct in6_addr dst;
> +	u_char proto;
> +
> +	memcpy(&src, &pkt->saddr, sizeof(src));
> +	memcpy(&dst, &pkt->daddr, sizeof(dst));
> +	inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));

nit. In v2, I think Stan has mentioned a similar point that &pkt->saddr can be 
directly used instead of memcpy. I don't see this mentioned in the changelog 
also. Re-mentioning here just in case it is an overlook.

Does it need to check inet_ntop error or it will never fail for whatever address 
a bpf prog may have written to a packet?

Does the src/dst_str need to be initialized if there was a inet_ntop error?

> +	inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));
> +	proto = pkt->nexthdr;
> +	show_transport(packet + sizeof(struct ipv6hdr),
> +		       ntohs(pkt->payload_len),
> +		       ifindex, src_str, dst_str, proto, true, pkt_type);
> +}
> +
> +static void show_ipv4_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
> +{
> +	char src_str[INET_ADDRSTRLEN], dst_str[INET_ADDRSTRLEN];
> +	struct iphdr *pkt = (struct iphdr *)packet;
> +	struct in_addr src;
> +	struct in_addr dst;
> +	u_char proto;
> +
> +	memcpy(&src, &pkt->saddr, sizeof(src));
> +	memcpy(&dst, &pkt->daddr, sizeof(dst));
> +	inet_ntop(AF_INET, &src, src_str, sizeof(src_str));
> +	inet_ntop(AF_INET, &dst, dst_str, sizeof(dst_str));
> +	proto = pkt->protocol;
> +	show_transport(packet + sizeof(struct iphdr),
> +		       ntohs(pkt->tot_len),
> +		       ifindex, src_str, dst_str, proto, false, pkt_type);
> +}
> +
> +static void *traffic_monitor_thread(void *arg)
> +{
> +	char *ifname, _ifname[IF_NAMESIZE];
> +	const u_char *packet, *payload;
> +	struct tmonitor_ctx *ctx = arg;
> +	pcap_dumper_t *dumper = ctx->dumper;
> +	int fd = ctx->pcap_fd, nfds, r;
> +	int wake_fd = ctx->wake_fd_r;
> +	struct pcap_pkthdr header;
> +	pcap_t *pcap = ctx->pcap;
> +	u32 ifindex;
> +	fd_set fds;
> +	u16 proto;
> +	u8 ptype;
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

nit. log_err already has the strerror(errno). There is at least another case in 
this patch. Please check.

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

nit. print the value of the arphdr_type.

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
> +		ptype = packet[10];
> +
> +		if (proto == ETH_P_IPV6) {
> +			show_ipv6_packet(payload, ifindex, ptype);
> +		} else if (proto == ETH_P_IP) {
> +			show_ipv4_packet(payload, ifindex, ptype);
> +		} else {
> +			ifname = if_indextoname(ifindex, _ifname);
> +			if (!ifname) {
> +				snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
> +				ifname = _ifname;
> +			}
> +
> +			printf("Unknown network protocol type %x, ifname %s (%s)\n",
> +			       proto, ifname, pkt_type_str(ptype));
> +		}
> +	}
> +
> +	return NULL;
> +}

