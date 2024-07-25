Return-Path: <bpf+bounces-35685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5A93CAF6
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 00:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459371F228CA
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03291442F6;
	Thu, 25 Jul 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQs+bYdZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B114A82
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947672; cv=none; b=R9vFHWP7PndnEjPX8pTGNA7qfYu80PZEN1DfOX2wp3aNnWYgsvjtRQUoY9j/JU8uzWujlnInHk3rWihpKjk4/TlZF+k71JIesijijaXILGrsALooXhU7nG+k0GGWXKN6cIdLHG8kZgBHcp2xGfrRjsNRviNpDuTepPEgmlYWwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947672; c=relaxed/simple;
	bh=CcS0cRMO/GQC2nDKVM/4JnhRup2TsOKPRiNCR/+WF0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fh0cmr7ttoRJ5StqsYpxSumvO5BuigIjKRb2+URcxDI4i7DjLqfdTDtovxY63GultYDLuFMbUfCZGzAytDgulkABRMErZ900v2uh4ZvDrSKwjVt4dHj6e+0ezeg1878xmx8qlm1ruDRyYtRUP7Af006ktsFPctmreFsnsFwb2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQs+bYdZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66a1842b452so12896207b3.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721947669; x=1722552469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wv+AGMWnSPSALxeE4enzuQciL+RU/KmcX51bEGwMq5M=;
        b=RQs+bYdZeUaFB45nhk+7w67oBGNm/Ppkf1apb4tKFOHGtlIF8fl0ogXpufEswEQ2rL
         urH7gP4qz0etUABrnFxsyfkFRk9e2lmTfvNO6QwV/j6koY94bCcLG2+o6lkGSO8Cn8RC
         CgWYGl6m4Yzt4HrbWn/zGKrW88Rs4wyySezcYsuBaf5tS349xVEPtOUuTbFxibLDm8U6
         TT66wyMaJDuTsFJujwWNl2x9IlBk2OnqK8QXMXAk4DzVKCaTz0EbxIMBu9LLVizVMD+b
         G9Sp9ZtBgPX4WLAqkyTE0Ozbj8jHQqO+DR4GjLFe4hjITPst6x6LgwUhGpXFHiwaEPUO
         hxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721947669; x=1722552469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wv+AGMWnSPSALxeE4enzuQciL+RU/KmcX51bEGwMq5M=;
        b=cQ52kYImPBkeC6u5CeeiuP5FIH9Ed+nGfLLLgWrqVH9XFsGK9o0ikxFbwxK1y41Cvb
         37JuOPbjIxjkd6/UAjP+lG1FNcTuK86+OlK/pzmFzGI6XzM5F4+LEQiT/FHk5AUKQD5W
         it15wzTZvTiDHgtph+DBz6D8kmnDzXGRBZd0z05pzaZKB2PXrqw0f8Dju0v3wtjEfUXx
         9U7g4scx2WrW+N8PGxlSg9HcyQMPie8c5SGZ9com+jRMLVTo6gqT4GDchtbUPHTaM4h8
         kZdONXBpPBbA1mm0dJfOFDqOFCYWKIUIGRcQjRnY6JT5ta912CnncN4XdmeQClFBFNoE
         SkSw==
X-Gm-Message-State: AOJu0Yy0i++IQv8Fkxxl/qAkMPryTm0qwDx6RxZaJoRth9k+FwzsK4vE
	CRyBdArOWM4I4nopRKsSOwwAqq6Yohli0G2bk8x0gVwZJghY++v+
X-Google-Smtp-Source: AGHT+IEN/IrXtNZDqHKs1AFtNS8pVbZt/Ya0i+JAaT51iDzeloVcT010aaC7lJ0Q+vCGDpxvU5La7Q==
X-Received: by 2002:a0d:fd86:0:b0:667:e5fa:5d4f with SMTP id 00721157ae682-675bd732ce6mr32505467b3.46.1721947669251;
        Thu, 25 Jul 2024 15:47:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:43cc:6ce2:4b7f:1689? ([2600:1700:6cf8:1240:43cc:6ce2:4b7f:1689])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024d9dsm5963207b3.79.2024.07.25.15.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 15:47:48 -0700 (PDT)
Message-ID: <c80120a6-6991-4de9-a705-5533282e3e67@gmail.com>
Date: Thu, 25 Jul 2024 15:47:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: Add traffic monitor
 functions.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me, kuifeng@meta.com
References: <20240723182439.1434795-1-thinker.li@gmail.com>
 <20240723182439.1434795-2-thinker.li@gmail.com>
 <51966001-297e-4dae-a7b8-41cdef0fd35c@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <51966001-297e-4dae-a7b8-41cdef0fd35c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/24 12:08, Martin KaFai Lau wrote:
> On 7/23/24 11:24 AM, Kui-Feng Lee wrote:
>> Add functions that capture packets and print log in the background. They
>> are supposed to be used for debugging flaky network test cases. A 
>> monitored
>> test case should call traffic_monitor_start() to start a thread to 
>> capture
>> packets in the background for a given namespace and call
>> traffic_monitor_stop() to stop capturing.
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
>>      Packet file: packets-2172-86.log
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
> 
> If bpf CI does not have libpcap, it is better to get bpf CI ready 
> first/soon.
> 
> [ ... ]
> 
>> +/* Show the information of the transport layer in the packet */
>> +static void show_transport(const u_char *packet, u16 len, u32 ifindex,
>> +               const char *src_addr, const char *dst_addr,
>> +               u16 proto, bool ipv6)
>> +{
>> +    struct udphdr *udp;
>> +    struct tcphdr *tcp;
>> +    u16 src_port, dst_port;
>> +    const char *transport_str;
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
>> +    } else {
> 
> It will be useful to at least print the ICMP[46] also. Some tests use 
> ping to test. For IPv6, printing the ICMPv6 messages will be useful for 
> debugging, e.g. the neigh discovery. The icmp type (and code?) should be 
> good enough.

Right, ICMP is something should be included.

> 
> That should be enough to begin with. The pcap dumped file can be used 
> for the rest.
> 
> Thanks for switching to libpcap. It is easier to handle the captured 
> packets in different ways.
> 
>> +        printf("%s (proto %d): %s -> %s, ifindex %d\n",
>> +               ipv6 ? "IPv6" : "IPv4", proto, src_addr, dst_addr, 
>> ifindex);
>> +        return;
>> +    }
>> +
>> +    if (ipv6)
>> +        printf("IPv6 %s packet: [%s]:%d -> [%s]:%d, len %d, ifindex %d",
> 
> It will be useful to print the ifname also such that easier for human 
> parsing. It should be possible by if_indextoname (cheap enough?) if 
> libpcap doesn't have it. It could be something for a later followup 
> though. Mostly nit here.

This is not a big work. I will include it in the next version.

> 
>> +               transport_str, src_addr, src_port,
>> +               dst_addr, dst_port, len, ifindex);
>> +    else
>> +        printf("IPv4 %s packet: %s:%d -> %s:%d, len %d, ifindex %d",
>> +               transport_str, src_addr, src_port,
>> +               dst_addr, dst_port, len, ifindex);
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
>> +}
> 
> [ ... ]
> 
>> +/* Start to monitor the network traffic in the given network namespace.
>> + *
>> + * netns: the name of the network namespace to monitor. If NULL, the
>> + * current network namespace is monitored.
>> + *
>> + * This function will start a thread to capture packets going through 
>> NICs
>> + * in the give network namespace.
>> + */
>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns)
> 
> There is opportunity to make the traffic monitoring easier for tests 
> that create its own netns which I hope most of the networking tests fall 
> into this bucket now. Especially for tests that create multiple netns 
> such that the test does not have to start/stop for each individual netns.
> 
> May be adding an API like "struct nstoken *netns_new(const char 
> *netns_name)". The netns_new() will create the netns and (optionally) 
> start the monitoring thread also. It will need another "void 
> netns_free(struct nstoken *nstoken)" to stop the thread and remove the 
> netns. The "struct tmonitor_ctx" probably makes sense to be embedded 
> into "struct nstoken" if we go with this new API.

Agree! But, I think we need another type rather than to reuse "struct
netns". People may accidentally call close_netns() on the nstoken
returned by this function.

> 
> This will need some changes to the tests creating netns but it probably 
> should be obvious change considering most test do "ip netns add..." and 
> then open_netns(). It can start with the flaky test at hand first like 
> tc_redirect.
> 
> May be a little more changes for the test using "unshare(CLONE_NEWNET)" 
> but should not be too bad either. This can be done only when we need to 
> turn on libpcap to debug that test.
> 
> Also, when the test is flaky, make it easier for people not familiar 
> with the codes of the networking test to turn on traffic monitoring 
> without changing the test code. May be in a libpcap.list file (in 
> parallel to the existing DENYLIST)?
> 
> For the tests without having its own netns, they can either move to 
> netns (which I think it is a good thing to do) or use the 
> traffic_monitor_start/stop() manually by changing the testing code,
> or a better way is to ask test_progs do it for the host netns 
> (init_netns) automatically for all tests in the libpcap.list.

Agree! I will start move some tests to netns, and use libpcap.list to
enable them.

> 
> wdyt?
> 
>> +{
>> +    struct tmonitor_ctx *ctx = NULL;
>> +    struct nstoken *nstoken = NULL;
>> +    int pipefd[2] = {-1, -1};
>> +    static int tmon_seq;
>> +    int r;
>> +
>> +    if (netns) {
>> +        nstoken = open_netns(netns);
>> +        if (!nstoken)
>> +            return NULL;
>> +    }
>> +    ctx = malloc(sizeof(*ctx));
>> +    if (!ctx) {
>> +        log_err("Failed to malloc ctx");
>> +        goto fail_ctx;
>> +    }
>> +    memset(ctx, 0, sizeof(*ctx));
>> +
>> +    snprintf(ctx->pkt_fname, sizeof(ctx->pkt_fname),
>> +         PCAP_DIR "/packets-%d-%d.log", getpid(), tmon_seq++);
> 
> nit. I wonder if it is useful to also have the netns name in the filename?
> 
> Not sure if it is more useful to have the test_num and subtest_num 
> instead of pid. Probably doable from looking at test__start_subtest().

It should be doable. These information is available through test_env.
Last time I tried to use env, but run into an error. I will try again.


> 
> 

