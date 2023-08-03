Return-Path: <bpf+bounces-6841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C276E817
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69A12820F1
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58291ED5C;
	Thu,  3 Aug 2023 12:22:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC411ED46
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 12:22:25 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7719F30FF
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 05:22:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3175d5ca8dbso737256f8f.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1691065339; x=1691670139;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hfUyjLKR9zqnE1r8gBdpyN/vaCW8ir0mogXFyginmbU=;
        b=h45lt3W2BlkLG6VEWJQiLlu9p6Ogm1Tehn6GOJUQbKPNtw5d6t2fnLEa9f/b7scdIo
         yAhds76OH8DGQnFeAehP6rLtgKlThoBBr+LAfuwhhqLhGXtc8QkeLneffEi7+j1uTXnU
         TFEvJ1obyyyJbDcbG/pG94wW6AKRjBF6hclhoED6OCGTPcHycBMjemkBTEisb5QLLJIG
         SoIqgYKjoNCYehi50wNHbGO5Z5s5T7EpYUNyol21nHqha9D/iUvsx1hNFqxFhNU5vRct
         F7mTwtxAgdHQimjz08PrFU4XeJORlWHi1e4TmXrFCtgVMScdm81n4RRPkZoGODZWeCTc
         WJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691065339; x=1691670139;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfUyjLKR9zqnE1r8gBdpyN/vaCW8ir0mogXFyginmbU=;
        b=Oa9AA/1Ik7+E32tcEEHv+6/TR1Cy0MFe8lar3LDY/eB5/WaTCuvvLmwSrHFttuma5L
         oi3CD8c4Fh0xWWvo8xIBhI982gWnLfgIeOkhB+TeSI/3KLeW5HpjNkbvEhzWQ4SvuimY
         JrCfgu1ZEdsbtI8KrnZ1d7IJQ25hUQ35+q4DtJWw4n/mzTNWN4vLNBqS2jEEEtsVWl1I
         iEXrdiVnIWnHnyMfMmpaQDafxpEBILtYA8pviZAzt+nROk9rnbUiyLfytrN/Q05Owp0K
         3vBnFrQ4qmvVmOIFdOq/+QMdFTLjlMNyBBSoTfWR0y4aPZlbuT7SWTxdb/UjLHkRDZ+5
         GnfQ==
X-Gm-Message-State: ABy/qLYbnsJheWeN81UDC3iPw2Zd4+o9rJj90MnHa22CAnKRN4V1Re0f
	thin+rbqlAZ4QAqILbHJBuOywA==
X-Google-Smtp-Source: APBJJlFKXKgGDnku3ZhcHlVfR+fUHsQLPft2WmmXlYbmAMrFjvpbH0tWvSV3PKfBYevXRIuDjtN+hA==
X-Received: by 2002:a5d:61cd:0:b0:313:f347:eea0 with SMTP id q13-20020a5d61cd000000b00313f347eea0mr6407533wrv.60.1691065338783;
        Thu, 03 Aug 2023 05:22:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:715:a86c:f2f5:a28? ([2a01:e0a:b41:c160:715:a86c:f2f5:a28])
        by smtp.gmail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm21715656wrr.56.2023.08.03.05.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 05:22:18 -0700 (PDT)
Message-ID: <62a8762c-40b4-f03f-ca8f-13d33db84f10@6wind.com>
Date: Thu, 3 Aug 2023 14:22:17 +0200
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
 <ZMuI5mxR704O9nDq@debian>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZMuI5mxR704O9nDq@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 03/08/2023 à 13:00, Guillaume Nault a écrit :
> On Thu, Aug 03, 2023 at 11:37:00AM +0200, Nicolas Dichtel wrote:
>> Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
>>> On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
>>>> This kind of interface doesn't have a mac header.
>>>
>>> Well, PPP does have a link layer header.
>> It has a link layer, but not an ethernet header.
> 
> This is generic code. The layer two protocol involved doesn't matter.
> What matter is that the device requires a specific l2 header.
Ok. Note, that addr_len is set to 0 for these devices:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ppp/ppp_generic.c#n1614

> 
>>> Do you instead mean that PPP automatically adds it?
>>>
>>>> This patch fixes bpf_redirect() to a ppp interface.
>>>
>>> Can you give more details? Which kind of packets are you trying to
>>> redirect to PPP interfaces?
>> My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
>> at ingress to a ppp device at egress.
> 
> So you're kind of bridging two incompatible layer two protocols.
> I see no reason to be surprised if that doesn't work out of the box.
I don't see the difference with a gre or ip tunnel. This kind of "bridging" is
supported.

> 
>> In this case, the bpf_redirect() function
>> should remove the ethernet header from the packet before calling the xmit ppp
>> function.
> 
> That's what you need for your specific use case, not necessarily what
> the code "should" do.
At least, it was my understanding of bpf_redirect() (:

> 
>> Before my patch, the ppp xmit function adds a ppp header (protocol IP
>> / 0x0021) before the ethernet header. It results to a corrupted packet. After
>> the patch, the ppp xmit function encapsulates the IP packet, as expected.
> 
> The problem is to treat the PPP link layer differently from the
> Ethernet one.
> 
> Just try to redirect PPP frames to an Ethernet device. The PPP l2
> header isn't going to be stripped, and no Ethernet header will be
> automatically added.
> 
> Before your patch, bridging incompatible L2 protocols just didn't work.
> After your patch, some combinations work, some don't, Ethernet is
> handled in one way, PPP in another way. And these inconsistencies are
> exposed to user space. That's the problem I have with this patch.
> 
>>> To me this looks like a hack to work around the fact that
>>> ppp_start_xmit() automatically adds a PPP header. Maybe that's the
>> It's not an hack, it works like for other kind of devices managed by the
>> function bpf_redirect() / dev_is_mac_header_xmit().
> 
> I don't think the users of dev_is_mac_header_xmit() (BPF redirect and
> TC mirred) actually work correctly with any non-Ethernet l2 devices.
> L3 devices are a bit different because we can test if an skb has a
> zero-length l2 header.
> 
>> Hope it's more clear.
> 
> Let me be clearer too. As I said, this patch may be the best we can do.
> Making a proper l2 generic BPF-redirect/TC-mirred might require too
> much work for the expected gain (how many users of non-Ethernet l2
> devices are going to use this). But at least we should make it clear in
> the commit message and in the code why we're finding it convenient to
> treat PPP as an l3 device. Like
> 
> +	/* PPP adds its l2 header automatically in ppp_start_xmit().
> +	 * This makes it look like an l3 device to __bpf_redirect() and
> +	 * tcf_mirred_init().
> +	 */
> +	case ARPHRD_PPP:
I better understand your point with this comment, I can add it, no problem.
But I fail to see why it is different from a L3 device. ip, gre, etc. tunnels
also add automatically another header (ipip.c has dev->addr_len configured to 4,
ip6_tunnels.c to 16, etc.).
A tcpdump on the physical output interface shows the same kind of packets (the
outer hdr (ppp / ip / etc.) followed by the encapsulated packet and a tcpdump on
the ppp or ip tunnel device shows only the inner packet.

Without my patch, a redirect from a ppp interface to another ppp interface would
have the same problem.

Regards,
Nicolas

