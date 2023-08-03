Return-Path: <bpf+bounces-6894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F1F76F3D4
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 22:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F7D282347
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDD263AF;
	Thu,  3 Aug 2023 20:05:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BA63BC
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 20:05:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C606A30FD
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 13:05:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbea147034so13694845e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1691093126; x=1691697926;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ioJfYtz1TuNJRqUHEf+SsX11YoIWxHULpK24zIYE4NU=;
        b=Qf+PuLMu1j28tdSpx7LXpcCSgC7iGSDn4Xrqd6X7Mb0v93KT04rx9uWOdkOmhQ7HNw
         tawLyawLaqDyU0Yv9mmpks8lvYki95IIZpeURvJxSbSMCWJrxpBaNG1dTdh4J5DW7Wie
         6+i5F6+KQEVwFQsJznNxqooN4SHnHRMdaeqG/VCxZUK3qTS+CO4m6M2wfccGKiSfpTvf
         GtDTkU7gqB26NG7rs+lkHxOBV32Bh+8l4a5dBjC4WeFPt41HDRW+BlVkbOBIW+pxuw+M
         DVJHsaGizweeZkv6YW4Wf7s9bY9Z3Zlt4Pkc0QbDvByOkOm691CN60ggMXaI3199Z/b4
         MDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691093126; x=1691697926;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioJfYtz1TuNJRqUHEf+SsX11YoIWxHULpK24zIYE4NU=;
        b=VKAxUN/ut8baYXhWmt4iSiPtPg/6kLK36r6zIpheVxzLL5K6L4I/OR6bPv2EXdSKcv
         TVXfTyVRJAe5eGb86AKz03yUos06Baf9dSBjAX+eoAS8gwA7cFbhjynAlWD3h3FXzBW8
         6s16ulEYQ+5+FhUUquBA2JEmuoNM6jy4goT14/3qoNeIzgy/y7ojOohfsuLa3Ju57dsm
         ZvoYcLlkGRsD/0KCWFWMqMTkL/zwVbiAuAucCfh0CpjwzzzlTsXjQ27AyPv5CZVTTxJL
         KLu+uesNAgEboqFB1tRXsUk4ssNVbsm8Jx5DaBZdxgweK2z80dAvDVWOc+SAeCBTK2C8
         cp+w==
X-Gm-Message-State: ABy/qLabNIj+OcUXer9qJfjcDW6VWRnS9eDYkvk+uJn4hwA06lGWo6XQ
	7W+ZX8UeZ6RNmcBdfvQhpez5GQ==
X-Google-Smtp-Source: APBJJlH7InHX0JW2pClS2HpU/xA5Wu42rvRiNdsUmUqhXlwABmSi3MmMNcnb6g4G0NGnCd0WYKq8vg==
X-Received: by 2002:a05:600c:2a4e:b0:3fe:b78:f4b1 with SMTP id x14-20020a05600c2a4e00b003fe0b78f4b1mr8131628wme.2.1691093126109;
        Thu, 03 Aug 2023 13:05:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:8744:d9d0:7d69:3a24? ([2a01:e0a:b41:c160:8744:d9d0:7d69:3a24])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003fbc9b9699dsm609159wmk.45.2023.08.03.13.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 13:05:25 -0700 (PDT)
Message-ID: <75b021a8-88cb-b44c-fd97-e34be83e702f@6wind.com>
Date: Thu, 3 Aug 2023 22:05:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org,
 Siwar Zitouni <siwar.zitouni@6wind.com>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
 <ZMtpSdLUQx2A6bdx@debian> <34f246ba-3ebc-1257-fe8d-5b7e0670a4a6@6wind.com>
 <ZMuI5mxR704O9nDq@debian> <62a8762c-40b4-f03f-ca8f-13d33db84f10@6wind.com>
Organization: 6WIND
In-Reply-To: <62a8762c-40b4-f03f-ca8f-13d33db84f10@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 03/08/2023 à 14:22, Nicolas Dichtel a écrit :
> Le 03/08/2023 à 13:00, Guillaume Nault a écrit :
>> On Thu, Aug 03, 2023 at 11:37:00AM +0200, Nicolas Dichtel wrote:
>>> Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
>>>> On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
>>>>> This kind of interface doesn't have a mac header.
>>>>
>>>> Well, PPP does have a link layer header.
>>> It has a link layer, but not an ethernet header.
>>
>> This is generic code. The layer two protocol involved doesn't matter.
>> What matter is that the device requires a specific l2 header.
> Ok. Note, that addr_len is set to 0 for these devices:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ppp/ppp_generic.c#n1614
> 
>>
>>>> Do you instead mean that PPP automatically adds it?
>>>>
>>>>> This patch fixes bpf_redirect() to a ppp interface.
>>>>
>>>> Can you give more details? Which kind of packets are you trying to
>>>> redirect to PPP interfaces?
>>> My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
>>> at ingress to a ppp device at egress.
>>
>> So you're kind of bridging two incompatible layer two protocols.
>> I see no reason to be surprised if that doesn't work out of the box.
> I don't see the difference with a gre or ip tunnel. This kind of "bridging" is
> supported.
> 
>>
>>> In this case, the bpf_redirect() function
>>> should remove the ethernet header from the packet before calling the xmit ppp
>>> function.
>>
>> That's what you need for your specific use case, not necessarily what
>> the code "should" do.
> At least, it was my understanding of bpf_redirect() (:
> 
>>
>>> Before my patch, the ppp xmit function adds a ppp header (protocol IP
>>> / 0x0021) before the ethernet header. It results to a corrupted packet. After
>>> the patch, the ppp xmit function encapsulates the IP packet, as expected.
>>
>> The problem is to treat the PPP link layer differently from the
>> Ethernet one.
>>
>> Just try to redirect PPP frames to an Ethernet device. The PPP l2
>> header isn't going to be stripped, and no Ethernet header will be
>> automatically added.
>>
>> Before your patch, bridging incompatible L2 protocols just didn't work.
>> After your patch, some combinations work, some don't, Ethernet is
>> handled in one way, PPP in another way. And these inconsistencies are
>> exposed to user space. That's the problem I have with this patch.
>>
>>>> To me this looks like a hack to work around the fact that
>>>> ppp_start_xmit() automatically adds a PPP header. Maybe that's the
>>> It's not an hack, it works like for other kind of devices managed by the
>>> function bpf_redirect() / dev_is_mac_header_xmit().
>>
>> I don't think the users of dev_is_mac_header_xmit() (BPF redirect and
>> TC mirred) actually work correctly with any non-Ethernet l2 devices.
>> L3 devices are a bit different because we can test if an skb has a
>> zero-length l2 header.
>>
>>> Hope it's more clear.
>>
>> Let me be clearer too. As I said, this patch may be the best we can do.
>> Making a proper l2 generic BPF-redirect/TC-mirred might require too
>> much work for the expected gain (how many users of non-Ethernet l2
>> devices are going to use this). But at least we should make it clear in
>> the commit message and in the code why we're finding it convenient to
>> treat PPP as an l3 device. Like
>>
>> +	/* PPP adds its l2 header automatically in ppp_start_xmit().
>> +	 * This makes it look like an l3 device to __bpf_redirect() and
>> +	 * tcf_mirred_init().
>> +	 */
>> +	case ARPHRD_PPP:
> I better understand your point with this comment, I can add it, no problem.
> But I fail to see why it is different from a L3 device. ip, gre, etc. tunnels
> also add automatically another header (ipip.c has dev->addr_len configured to 4,
> ip6_tunnels.c to 16, etc.).
> A tcpdump on the physical output interface shows the same kind of packets (the
> outer hdr (ppp / ip / etc.) followed by the encapsulated packet and a tcpdump on
> the ppp or ip tunnel device shows only the inner packet.
> 
> Without my patch, a redirect from a ppp interface to another ppp interface would
> have the same problem.
I will be off for 15 days, I will come back on this when I return.


Regards,
Nicolas

