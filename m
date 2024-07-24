Return-Path: <bpf+bounces-35555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C70293B736
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 21:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036C91F22050
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A4161327;
	Wed, 24 Jul 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wuf9H69z"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9965E20
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848112; cv=none; b=qlMw5swfKWEv97f7B7pPzcnEzwQt0sDAVluRxeXxmhLxmgxUGM82WH5MYCekluPtcXy6+dLtgoHrAkmGr1TmMibDtHmh9wDuOhw/3N4NUHpSeYSPkPwY1m4QR36heR2AIIFCn6J4Qn4n9wl3NaqUnhMhTWi5w8evk0TNiuTLkjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848112; c=relaxed/simple;
	bh=r9MW8BE1vajpRESu6xpts4eZqwke9O7V9eR/viCm/t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmQgHPSTegKowP8O9Ahdf/fCGFOAHy9rAVOCAifWwWDU+CDRcpyxhk2AAf3tO2jieR7ntUU5jx90DnrJxK73HyXem6AYTAwFvEBSQGcX9KqXyKih9x102uyeh9nga2YyUpFwuR8WqYjL+AqsJMBvcnPnvjLvgF6gil4Il+J8Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wuf9H69z; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51966001-297e-4dae-a7b8-41cdef0fd35c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721848107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGMm0/2s6XAobgE+g6tupbnXEgJku9N1Z0lf0GLhngo=;
	b=wuf9H69zItNMZqG7kJN/ulKGrxowSuQd9z3nOP7htUtq4vq1nNc39XRy7EGZOw9GRjlaQa
	VmfPR3FLydwd4Zp7JDzQd+TIk31DSIfr67qkxll2rgFs+Bmh2k3AikKEwUPJZkXjvph7V4
	EGhGZzaqWVxVGdRYsC+JggcFAStNhSU=
Date: Wed, 24 Jul 2024 12:08:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 sinquersw@gmail.com, kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-2-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240723182439.1434795-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/23/24 11:24 AM, Kui-Feng Lee wrote:
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

If bpf CI does not have libpcap, it is better to get bpf CI ready first/soon.

[ ... ]

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

It will be useful to at least print the ICMP[46] also. Some tests use ping to 
test. For IPv6, printing the ICMPv6 messages will be useful for debugging, e.g. 
the neigh discovery. The icmp type (and code?) should be good enough.

That should be enough to begin with. The pcap dumped file can be used for the rest.

Thanks for switching to libpcap. It is easier to handle the captured packets in 
different ways.

> +		printf("%s (proto %d): %s -> %s, ifindex %d\n",
> +		       ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, ifindex);
> +		return;
> +	}
> +
> +	if (ipv6)
> +		printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifindex %d",

It will be useful to print the ifname also such that easier for human parsing. 
It should be possible by if_indextoname (cheap enough?) if libpcap doesn't have 
it. It could be something for a later followup though. Mostly nit here.

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

[ ... ]

> +/* Start to monitor the network traffic in the given network namespace.
> + *
> + * netns: the name of the network namespace to monitor. If NULL, the
> + * current network namespace is monitored.
> + *
> + * This function will start a thread to capture packets going through NICs
> + * in the give network namespace.
> + */
> +struct tmonitor_ctx *traffic_monitor_start(const char *netns)

There is opportunity to make the traffic monitoring easier for tests that create 
its own netns which I hope most of the networking tests fall into this bucket 
now. Especially for tests that create multiple netns such that the test does not 
have to start/stop for each individual netns.

May be adding an API like "struct nstoken *netns_new(const char *netns_name)". 
The netns_new() will create the netns and (optionally) start the monitoring 
thread also. It will need another "void netns_free(struct nstoken *nstoken)" to 
stop the thread and remove the netns. The "struct tmonitor_ctx" probably makes 
sense to be embedded into "struct nstoken" if we go with this new API.

This will need some changes to the tests creating netns but it probably should 
be obvious change considering most test do "ip netns add..." and then 
open_netns(). It can start with the flaky test at hand first like tc_redirect.

May be a little more changes for the test using "unshare(CLONE_NEWNET)" but 
should not be too bad either. This can be done only when we need to turn on 
libpcap to debug that test.

Also, when the test is flaky, make it easier for people not familiar with the 
codes of the networking test to turn on traffic monitoring without changing the 
test code. May be in a libpcap.list file (in parallel to the existing DENYLIST)?

For the tests without having its own netns, they can either move to netns (which 
I think it is a good thing to do) or use the traffic_monitor_start/stop() 
manually by changing the testing code,
or a better way is to ask test_progs do it for the host netns (init_netns) 
automatically for all tests in the libpcap.list.

wdyt?

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

nit. I wonder if it is useful to also have the netns name in the filename?

Not sure if it is more useful to have the test_num and subtest_num instead of 
pid. Probably doable from looking at test__start_subtest().



