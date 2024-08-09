Return-Path: <bpf+bounces-36780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0694D41A
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83152853DB
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68A198A0F;
	Fri,  9 Aug 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doGZcYyP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4C168B1
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219293; cv=none; b=CrC8YgGS1fbxyImxz5DMkgYJAD6oHitp/frjFTczbnoe3Vc3UrfdCNgAWFaw2s0nHHoH8W4PsM4xL7FNHwATyeRPwC5Ne9HyOkTdWC7uSKBclT8zvfOIg1TRZyFT9P1z2sM1tbxhiRYsuYIPvSXObWOZyYaGGXd1SbKLIb9cjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219293; c=relaxed/simple;
	bh=z+zeLKVddJqNPnAh2JT9l6AK59/KxtfS8wVTGrPsFYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unZqs9HZMm0FiAGTDsIH9IMpTIILx8g9e1JL72DKHbT/5acb5v8CG/4EshEb7j+e6GvmWNs1TzXq50eEbPmm9tsrkWlA4UOU8bkwdybMTdru7ssrWRTWy3mTyZ/d0SHTT8mDScCJqf9NWL9QhPR+URbKz18Rod0OtuR6wIQIqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doGZcYyP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0bfa0b70ceso2092182276.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723219291; x=1723824091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWjsXlEAEMc96ONRil3xqXQD0QyJAXK4YBnw0XtOCJo=;
        b=doGZcYyPvGTRHkvBZkx0LoRAFdoJBrTYS5eGWxfnTeQv798j+UcoThPMFUgcjqDEf0
         i+ClbSvdUweX+bJog6z0b+uYUhRN3l/7N2O1lYEXctQuZZc9w/gS0UKVb8/6Vb0C4sHE
         JcuHtcTGSZ3vEQNx8qk6OPf99dM9Mgz5Y3VROd9O+zzf3gEdk7lejlkvfvr2vIKj+7qv
         sICT/wGO2q41bDHAN1MAOk681vcQEFzWS+Cij48K5AWiDF6ikPs+KJinTHPVtfljbv9+
         9Y6+gPBjLtOgha+9axLCVjIePPGw6A3eMle7dfl3hRZyQ1aijjTlFOA49aWapK12jN1O
         7wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219291; x=1723824091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWjsXlEAEMc96ONRil3xqXQD0QyJAXK4YBnw0XtOCJo=;
        b=W7JQmHz5QRVT9ULPb5Q9HbDtHSLZY2kgqPaefqrBvbXeWOEcAamyR5qKjTAkzRwF3O
         cmxBzriavQjEE0lX5Txe8TjnSCD8hicW7jvfLzyjPBEZ20PjeZ6Hu1npeyo20+s2JfPV
         QwPQScyk0ZCwQCoII6SL7A2iz+SQMC6vqms5U/Dvk1XJ6ViUdIR1AHB8jpZGXmuSoBWQ
         FnIqgkzmPZIHZ/CXMmP8oBzAWUW7VjRHBLZ6ed+/h6kUxtjL+OYZ4yrc1J6wcgLJAIkM
         vh2mgQUVVrP8w9J6Z3xrv6MpwaZf2nC+xUb1Vfhm0K0/drWzhrKZBdJKxiPbygObzKb9
         1urQ==
X-Gm-Message-State: AOJu0Yw/aXr+PtoL94FHvkhWiNcaUhvOw12TafUd7BLMPqDyUhSrD+if
	vb8Ejf8wA/T0ccg3MsS7MRM/WaIRLjvEBg4o5StQLSNM7z+dKvL+
X-Google-Smtp-Source: AGHT+IG7+wGlZYhD0DgDBg0Wbf5O7KHSxeAAuylTqXScyTqqLO4u2ejuQbEhweMtYg0TgVrkIwa4pw==
X-Received: by 2002:a05:6902:2805:b0:e0e:98d8:8a19 with SMTP id 3f1490d57ef6-e0eb9a4cb49mr2072891276.49.1723219290697;
        Fri, 09 Aug 2024 09:01:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2? ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be5379c6bsm2974621276.30.2024.08.09.09.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:01:30 -0700 (PDT)
Message-ID: <91890a6a-19fa-4b7c-b69b-e2b7c9a42a4a@gmail.com>
Date: Fri, 9 Aug 2024 09:01:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-2-thinker.li@gmail.com>
 <be108b0b-202c-4a87-8ac3-1b9f61dca3c4@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <be108b0b-202c-4a87-8ac3-1b9f61dca3c4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/24 14:35, Martin KaFai Lau wrote:
> On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
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
>> +static const char * const pkt_types[] = {
>> +    "In",
>> +    "B",            /* Broadcast */
>> +    "M",            /* Multicast */
>> +    "C",            /* Captured with the promiscuous mode */
>> +    "Out",
>> +};
>> +
>> +static const char *pkt_type_str(u16 pkt_type)
>> +{
>> +    if (pkt_type < ARRAY_SIZE(pkt_types))
>> +        return pkt_types[pkt_type];
>> +    return "Unknown";
>> +}
>> +
>> +/* Show the information of the transport layer in the packet */
>> +static void show_transport(const u_char *packet, u16 len, u32 ifindex,
>> +               const char *src_addr, const char *dst_addr,
>> +               u16 proto, bool ipv6, u8 pkt_type)
>> +{
>> +    char *ifname, _ifname[IF_NAMESIZE];
>> +    const char *transport_str;
>> +    u16 src_port, dst_port;
>> +    struct udphdr *udp;
>> +    struct tcphdr *tcp;
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
> 
> nit. ";" spilled over to a newline.

Got it!
> 
>> +    } else if (proto == IPPROTO_ICMP) {
>> +        printf("IPv4 ICMP packet: %s -> %s, len %d, type %d, code %d, 
>> ifname %s (%s)\n",
>> +               src_addr, dst_addr, len, packet[0], packet[1], ifname,
>> +               pkt_type_str(pkt_type));
> 
> nit. Move pkt_type_str(pkt_type) to the front. That will resemble the 
> tcpdump output to make the output familiar to most people. Same for the 
> other proto below.

Sure!

> 
>> +        return;
>> +    } else if (proto == IPPROTO_ICMPV6) {
>> +        printf("IPv6 ICMPv6 packet: %s -> %s, len %d, type %d, code 
>> %d, ifname %s (%s)\n",
>> +               src_addr, dst_addr, len, packet[0], packet[1], ifname,
>> +               pkt_type_str(pkt_type));
>> +        return;
>> +    } else {
>> +        printf("%s (proto %d): %s -> %s, ifname %s (%s)\n",
>> +               ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr,
>> +               ifname, pkt_type_str(pkt_type));
>> +        return;
>> +    }
>> +
>> +    /* TCP */
>> +
>> +    flockfile(stdout);
>> +    if (ipv6)
>> +        printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifname %s 
>> (%s)",
>> +               transport_str, src_addr, src_port,
>> +               dst_addr, dst_port, len, ifname, pkt_type_str(pkt_type));
>> +    else
>> +        printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifname %s (%s)",
>> +               transport_str, src_addr, src_port,
>> +               dst_addr, dst_port, len, ifname, pkt_type_str(pkt_type));
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
>> +    funlockfile(stdout);
>> +}
>> +
>> +static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 
>> pkt_type)
>> +{
>> +    char src_str[INET6_ADDRSTRLEN], dst_str[INET6_ADDRSTRLEN];
>> +    struct ipv6hdr *pkt = (struct ipv6hdr *)packet;
>> +    struct in6_addr src;
>> +    struct in6_addr dst;
>> +    u_char proto;
>> +
>> +    memcpy(&src, &pkt->saddr, sizeof(src));
>> +    memcpy(&dst, &pkt->daddr, sizeof(dst));
>> +    inet_ntop(AF_INET6, &src, src_str, sizeof(src_str));
> 
> nit. In v2, I think Stan has mentioned a similar point that &pkt->saddr 
> can be directly used instead of memcpy. I don't see this mentioned in 
> the changelog also. Re-mentioning here just in case it is an overlook.

Got it!

> 
> Does it need to check inet_ntop error or it will never fail for whatever 
> address a bpf prog may have written to a packet?
> 
> Does the src/dst_str need to be initialized if there was a inet_ntop error?

It will never fail if passing valid parameters.
In our case, the size of src_str & dst_str is big enough for v6 here for
v4 below. And, the address family is valid for sure. It should not
return any error for any address.

However, I will check it since you have concern about it.

> 
>> +    inet_ntop(AF_INET6, &dst, dst_str, sizeof(dst_str));
>> +    proto = pkt->nexthdr;
>> +    show_transport(packet + sizeof(struct ipv6hdr),
>> +               ntohs(pkt->payload_len),
>> +               ifindex, src_str, dst_str, proto, true, pkt_type);
>> +}
>> +
>> +static void show_ipv4_packet(const u_char *packet, u32 ifindex, u8 
>> pkt_type)
>> +{
>> +    char src_str[INET_ADDRSTRLEN], dst_str[INET_ADDRSTRLEN];
>> +    struct iphdr *pkt = (struct iphdr *)packet;
>> +    struct in_addr src;
>> +    struct in_addr dst;
>> +    u_char proto;
>> +
>> +    memcpy(&src, &pkt->saddr, sizeof(src));
>> +    memcpy(&dst, &pkt->daddr, sizeof(dst));
>> +    inet_ntop(AF_INET, &src, src_str, sizeof(src_str));
>> +    inet_ntop(AF_INET, &dst, dst_str, sizeof(dst_str));
>> +    proto = pkt->protocol;
>> +    show_transport(packet + sizeof(struct iphdr),
>> +               ntohs(pkt->tot_len),
>> +               ifindex, src_str, dst_str, proto, false, pkt_type);
>> +}
>> +
>> +static void *traffic_monitor_thread(void *arg)
>> +{
>> +    char *ifname, _ifname[IF_NAMESIZE];
>> +    const u_char *packet, *payload;
>> +    struct tmonitor_ctx *ctx = arg;
>> +    pcap_dumper_t *dumper = ctx->dumper;
>> +    int fd = ctx->pcap_fd, nfds, r;
>> +    int wake_fd = ctx->wake_fd_r;
>> +    struct pcap_pkthdr header;
>> +    pcap_t *pcap = ctx->pcap;
>> +    u32 ifindex;
>> +    fd_set fds;
>> +    u16 proto;
>> +    u8 ptype;
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
> 
> nit. log_err already has the strerror(errno). There is at least another 
> case in this patch. Please check.

Got it!
> 
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
>> +
>> +        /* Not sure what other types of packets look like. Here, we
>> +         * parse only Ethernet and compatible packets.
>> +         */
>> +        if (!is_ethernet(packet)) {
>> +            printf("Packet captured\n");
> 
> nit. print the value of the arphdr_type.

Sure!

> 
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
>> +        ptype = packet[10];
>> +
>> +        if (proto == ETH_P_IPV6) {
>> +            show_ipv6_packet(payload, ifindex, ptype);
>> +        } else if (proto == ETH_P_IP) {
>> +            show_ipv4_packet(payload, ifindex, ptype);
>> +        } else {
>> +            ifname = if_indextoname(ifindex, _ifname);
>> +            if (!ifname) {
>> +                snprintf(_ifname, sizeof(_ifname), "unknown(%d)", 
>> ifindex);
>> +                ifname = _ifname;
>> +            }
>> +
>> +            printf("Unknown network protocol type %x, ifname %s (%s)\n",
>> +                   proto, ifname, pkt_type_str(ptype));
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}

