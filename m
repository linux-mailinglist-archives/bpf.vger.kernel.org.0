Return-Path: <bpf+bounces-36257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05BF94571B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 06:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9051B281D87
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 04:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0CA1B7F4;
	Fri,  2 Aug 2024 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJZVW4G4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2C1BC58
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573110; cv=none; b=QnAx/QemESi2GMSJrXe8yjD3vdeDVw3HtXvRhED7WdRooNLJ0fvI8wrgsIFINLqHopvjBgGDSobzWHD6GRHiJe5bbTBThgdpfKNbMd8MyFLXbJ6/BDXpclcJhkJLyrxXRboOqHlRNdrV1sQq2yq79acEO24N02i7j9w5J1WvEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573110; c=relaxed/simple;
	bh=IF8X2A+g2o9ajZfJkj4XFYt/WLBLYVJ/jGYJbqVqv14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uhixkwz/pzRO5Tae+M+5b/tFXsX8yODum+COHQYxoJCzIPzWaMwNqeF7aV34vkh2s24F5CnP9hBltbb/Z4qcVLzpJUBUVjxXOdSfZAMsRprEBmm2A3pFHDyiGClgVEfU/HVzwoY4ZuU1/oM5kIPvoUIxB+IrsxsABo5ZOeu43lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJZVW4G4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65f880c56b1so62978077b3.3
        for <bpf@vger.kernel.org>; Thu, 01 Aug 2024 21:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722573107; x=1723177907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShbR3s5jI3jAulMXjz8Ydyp/eBUWLZFkwXbGxYDTqMc=;
        b=lJZVW4G4O3VDvtEEXYhtGDwOcGGp0lxr6e9gz4Ei04bW6Sk1UJdVxGge4fVD61bvEA
         355/Pmo/vUaaBtrx9XDd70KrtRJViMAnYTr4vTOb8rbPopDWsMSZCfDT6cmxCKZWp628
         oUfI6V9rUxjzVZu7fQS8lHUC61WIZMIA6z4+1CNCsuzeDvKPYoqpWLT0BYc17jgCrpbK
         iSjKDlqN5Wyn02RGVHWR0q+rUbsHHR5dq6nup/sqlekARzYvhaddhpxT7P/CNyqV7gPO
         pTKDdAzpo5jYpOOFHJQ4vcO9T+0qlvi9IKUL+5tcSE5LfhJteRZ3Nvq0qosq4mPslxzI
         E5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722573107; x=1723177907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShbR3s5jI3jAulMXjz8Ydyp/eBUWLZFkwXbGxYDTqMc=;
        b=r4tx4ui7bYazoFFOiMEzeE5Gs2kQ1EAOYTF+QHPN0Y0KwtaLZFxgIM60eKLfsOXtSE
         cb2CEaiZaGenYM6tC0YfVa/NLgsl2VlUh7x86kfUn9PE95LOTIjEDUtP5SxOpX9pMPFE
         ggy5M+9YBeIepyExmbn0A1OaWf+lm3SYRxPTA9oTHdX55RZB6pw7/8XoBa+l1jbApioA
         prYOw/o4dJsXlDCi8DyebmApDkqzP7GOAIl9JNFm6fTU6ImnSemgY9ehVSs7IU+zxYbv
         8Vmxjqk5/jIHfiyLegvYVd8VsRv73+xiTZXoHSjM4gMusPW/SH/ldNNr7IBNDEvAvADh
         Fwtg==
X-Gm-Message-State: AOJu0Yw1bXdCmszQdkRkWTk+3C8ZH3rUqpxJQE6BGc9LVO8CFneNChR2
	teL9O1+DleNVCj4RnIN8uwv/qUGRyk5RDFh/HNKBXvRZvVlhUYfEML+rzQ==
X-Google-Smtp-Source: AGHT+IE1cJmQ4rtaJMEW9Ibvhk575qreBh9dVodrS11TJ3pyBmX/QWLVray/GxNXDhCOSVp6gQaxAA==
X-Received: by 2002:a0d:f386:0:b0:62a:530:472f with SMTP id 00721157ae682-68962a7c064mr25502107b3.32.1722573106890;
        Thu, 01 Aug 2024 21:31:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:10ed:40b:8a2e:9686? ([2600:1700:6cf8:1240:10ed:40b:8a2e:9686])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a10659cafsm1310467b3.60.2024.08.01.21.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 21:31:46 -0700 (PDT)
Message-ID: <8c20454b-9e45-4371-bc47-6dd079573130@gmail.com>
Date: Thu, 1 Aug 2024 21:31:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <157ef482-a018-46da-b049-10c47fd286c7@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <157ef482-a018-46da-b049-10c47fd286c7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/1/24 20:29, Martin KaFai Lau wrote:
> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>> Add functions that capture packets and print log in the background. They
>> are supposed to be used for debugging flaky network test cases. A 
>> monitored
>> test case should call traffic_monitor_start() to start a thread to 
>> capture
>> packets in the background for a given namespace and call
>> traffic_monitor_stop() to stop capturing. (Or, option '-m' implemented by
>> the later patches.)
>>
>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 68, 
>> ifindex 1, SYN
>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 60, 
>> ifindex 1, SYN, ACK
>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 60, 
>> ifindex 1, ACK
>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, 
>> ifindex 1, ACK
>>      IPv4 TCP packet: 127.0.0.1:48165 -> 127.0.0.1:36707, len 52, 
>> ifindex 1, FIN, ACK
>>      IPv4 TCP packet: 127.0.0.1:36707 -> 127.0.0.1:48165, len 52, 
>> ifindex 1, RST, ACK
> 
> nit. Instead of ifindex, it should be ifname now.

Sure! I will update it.

> 
>>      Packet file: packets-2172-86-select_reuseport:sockhash-test.log
>>      #280/87 select_reuseport/sockhash IPv4/TCP LOOPBACK 
>> test_detach_bpf:OK
>>
>> The above is the output of an example. It shows the packets of a 
>> connection
>> and the name of the file that contains captured packets in the directory
>> /tmp/tmon_pcap. The file can be loaded by tcpdump or wireshark.
>>
>> This feature only works if TRAFFIC_MONITOR variable has been passed to
>> build BPF selftests. For example,
>>
>>    make TRAFFIC_MONITOR=1 -C tools/testing/selftests/bpf
>>
>> This command will build BPF selftests with this feature enabled.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile     |   5 +
>>   tools/testing/selftests/bpf/test_progs.c | 432 +++++++++++++++++++++++
> 
> In the cover letter, it mentioned the traffic monitoring implementation 
> is moved from the network_helpers.c to test_progs.c.
> 
> Can you share more about the reason?

network_helpers.c has been used by several test programs.
However, they don't have env that we found in test_progs.c.
That means we could not access env directly. Instead, the caller
have to pass the test name and subtest name to the function.
Leter, we also need to check if a test name matches the patterns. It is
inconvient for users. So, I move these functions to test_progs.c to make
user's life eaiser.


> 
> Is it because the traffic monitor now depends on the test_progs's test 
> name, should_tmon...etc ? Can the test name and should_tmon be exported 
> for the network_helpers to use?

Yes! And in later patches, we also introduce a list of patterns.
> 
> What other compilation issues did it hit if the traffic monitor codes 
> stay in the network_helpers.c? Some individual binaries (with main()) 
> like test_tcp_check_syncookie_user that links to network_helpers.o but 
> not to test_progs.o?

Yes, they are problems as well. These binary also need to link to
libpcap even they don't use it although this is not an important issue.


> 
>> +#ifdef TRAFFIC_MONITOR
>> +struct tmonitor_ctx {
>> +    pcap_t *pcap;
>> +    pcap_dumper_t *dumper;
>> +    pthread_t thread;
>> +    int wake_fd_r;
>> +    int wake_fd_w;
>> +
>> +    bool done;
>> +    char pkt_fname[PATH_MAX];
>> +    int pcap_fd;
>> +};
>> +
>> +/* Is this packet captured with a Ethernet protocol type? */
>> +static bool is_ethernet(const u_char *packet)
>> +{
>> +    u16 arphdr_type;
>> +
>> +    memcpy(&arphdr_type, packet + 8, 2);
>> +    arphdr_type = ntohs(arphdr_type);
>> +
>> +    /* Except the following cases, the protocol type contains the
>> +     * Ethernet protocol type for the packet.
>> +     *
>> +     * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
>> +     */
>> +    switch (arphdr_type) {
>> +    case 770: /* ARPHRD_FRAD */
>> +    case 778: /* ARPHDR_IPGRE */
>> +    case 803: /* ARPHRD_IEEE80211_RADIOTAP */
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +/* Show the information of the transport layer in the packet */
>> +static void show_transport(const u_char *packet, u16 len, u32 ifindex,
>> +               const char *src_addr, const char *dst_addr,
>> +               u16 proto, bool ipv6)
>> +{
>> +    struct udphdr *udp;
>> +    struct tcphdr *tcp;
>> +    u16 src_port, dst_port;
>> +    const char *transport_str;
>> +    char *ifname, _ifname[IF_NAMESIZE];
>> +
>> +    ifname = if_indextoname(ifindex, _ifname);
>> +    if (!ifname) {
>> +        snprintf(_ifname, sizeof(_ifname), "unknown(%d)", ifindex);
>> +        ifname = _ifname;
>> +    }
>> +
>> +    if (proto == IPPROTO_UDP) {
>> +        udp = (struct udphdr *)packet;
>> +        src_port = ntohs(udp->source);
>> +        dst_port = ntohs(udp->dest);
>> +        transport_str = "UDP";
>> +    } else if (proto == IPPROTO_TCP) {
>> +        tcp = (struct tcphdr *)packet;
>> +        src_port = ntohs(tcp->source);
>> +        dst_port = ntohs(tcp->dest);
>> +        transport_str = "TCP"
>> +;
>> +    } else if (proto == IPPROTO_ICMP) {
>> +        printf("IPv4 ICMP packet: %s -> %s, len %d, type %d, code %d, 
>> ifname %s\n",
>> +               src_addr, dst_addr, len, packet[0], packet[1], ifname);
>> +        return;
>> +    } else if (proto == IPPROTO_ICMPV6) {
>> +        printf("IPv6 ICMPv6 packet: %s -> %s, len %d, type %d, code 
>> %d, ifname %s\n",
>> +               src_addr, dst_addr, len, packet[0], packet[1], ifname);
>> +        return;
>> +    } else {
>> +        printf("%s (proto %d): %s -> %s, ifname %s\n",
>> +               ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, 
>> ifname);
>> +        return;
>> +    }
>> +
>> +    /* TCP */
>> +
>> +    if (ipv6)
>> +        printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifname %s",
>> +               transport_str, src_addr, src_port,
>> +               dst_addr, dst_port, len, ifname);
>> +    else
>> +        printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifname %s",
>> +               transport_str, src_addr, src_port,
>> +               dst_addr, dst_port, len, ifname);
>> +
>> +    if (proto == IPPROTO_TCP) {
>> +        if (tcp->fin)
>> +            printf(", FIN");
>> +        if (tcp->syn)
>> +            printf(", SYN");
>> +        if (tcp->rst)
>> +            printf(", RST");
>> +        if (tcp->ack)
>> +            printf(", ACK");
>> +    }
>> +
>> +    printf("\n");
> 
> The TCP packet output is done by multiple printf. There is a good chance 
> that one TCP packet is interleaved with the other printf(s), considering 
> the traffic monitoring is done in its own thread. I am seeing this in 
> the tc_redirect test.
> 
> Does it help to do multiple snprintf (for the tcp flags?) first and then 
> calls one printf?

Sure, it would help. Or, perform flockfile() and funlockfile().

> 
>> +}
>> +
>> +static void show_ipv6_packet(const u_char *packet, u32 ifindex)
>> +{
>> +    struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
>> +    struct in6_addr src;
>> +    struct in6_addr dst;
>> +    char src_str[INET6_ADDRSTRLEN], dst_str[INET6_ADDRSTRLEN];
>> +    u_char proto;
>> +
>> +    memcpy(&src, &pkt->saddr, sizeof(src));
>> +    memcpy(&dst, &pkt->daddr, sizeof(dst));
>> +    inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));
>> +    inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));
>> +    proto = pkt->nexthdr;
>> +    show_transport(packet + sizeof(struct ipv6hdr),
>> +               ntohs(pkt->payload_len),
>> +               ifindex, src_str, dst_str, proto, true);
>> +}
>> +
>> +static void show_ipv4_packet(const u_char *packet, u32 ifindex)
>> +{
>> +    struct iphdr *pkt = (struct iphdr *)packet;
>> +    struct in_addr src;
>> +    struct in_addr dst;
>> +    u_char proto;
>> +    char src_str[INET_ADDRSTRLEN], dst_str[INET_ADDRSTRLEN];
>> +
>> +    memcpy(&src, &pkt->saddr, sizeof(src));
>> +    memcpy(&dst, &pkt->daddr, sizeof(dst));
>> +    inet_ntop(AF_INET, &src, src_str, sizeof(src_str));
>> +    inet_ntop(AF_INET, &dst, dst_str, sizeof(dst_str));
>> +    proto = pkt->protocol;
>> +    show_transport(packet + sizeof(struct iphdr),
>> +               ntohs(pkt->tot_len),
>> +               ifindex, src_str, dst_str, proto, false);
>> +}
>> +
>> +static void *traffic_monitor_thread(void *arg)
>> +{
>> +    char *ifname, _ifname[IF_NAMESIZE];
>> +    const u_char *packet, *payload;
>> +    struct tmonitor_ctx *ctx = arg;
>> +    struct pcap_pkthdr header;
>> +    pcap_t *pcap = ctx->pcap;
>> +    pcap_dumper_t *dumper = ctx->dumper;
>> +    int fd = ctx->pcap_fd;
>> +    int wake_fd = ctx->wake_fd_r;
>> +    u16 proto;
>> +    u32 ifindex;
>> +    fd_set fds;
>> +    int nfds, r;
>> +
>> +    nfds = (fd > wake_fd ? fd : wake_fd) + 1;
>> +    FD_ZERO(&fds);
>> +
>> +    while (!ctx->done) {
>> +        FD_SET(fd, &fds);
>> +        FD_SET(wake_fd, &fds);
>> +        r = select(nfds, &fds, NULL, NULL, NULL);
>> +        if (!r)
>> +            continue;
>> +        if (r < 0) {
>> +            if (errno == EINTR)
>> +                continue;
>> +            log_err("Fail to select on pcap fd and wake fd: %s", 
>> strerror(errno));
>> +            break;
>> +        }
>> +
>> +        packet = pcap_next(pcap, &header);
>> +        if (!packet)
>> +            continue;
>> +
>> +        /* According to the man page of pcap_dump(), first argument
>> +         * is the pcap_dumper_t pointer even it's argument type is
>> +         * u_char *.
>> +         */
>> +        pcap_dump((u_char *)dumper, &header, packet);
> 
> The captured file has the "In", "Out", and "M" (Multicast) when it is 
> read by tcpdump. Is it easy to printf that in show_ipv[46]_packet() 
> also? Just want to ensure we didn't miss it if it is easy.

No problem! IIRC, it is part of the SSL2 header.

> 
>> +
>> +        /* Not sure what other types of packets look like. Here, we
>> +         * parse only Ethernet and compatible packets.
>> +         */
>> +        if (!is_ethernet(packet)) {
>> +            printf("Packet captured\n");
>> +            continue;
>> +        }
>> +
>> +        /* Skip SLL2 header
>> +         * https://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL2.html
>> +         *
>> +         * Although the document doesn't mention that, the payload
>> +         * doesn't include the Ethernet header. The payload starts
>> +         * from the first byte of the network layer header.
>> +         */
>> +        payload = packet + 20;
>> +
>> +        memcpy(&proto, packet, 2);
>> +        proto = ntohs(proto);
>> +        memcpy(&ifindex, packet + 4, 4);
>> +        ifindex = ntohl(ifindex);
>> +
>> +        if (proto == ETH_P_IPV6) {
>> +            show_ipv6_packet(payload, ifindex);
>> +        } else if (proto == ETH_P_IP) {
>> +            show_ipv4_packet(payload, ifindex);
>> +        } else {
>> +            ifname = if_indextoname(ifindex, _ifname);
>> +            if (!ifname) {
>> +                snprintf(_ifname, sizeof(_ifname), "unknown(%d)", 
>> ifindex);
>> +                ifname = _ifname;
>> +            }
>> +
>> +            printf("Unknown network protocol type %x, ifname %s\n", 
>> proto, ifname);
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
> 
> 

