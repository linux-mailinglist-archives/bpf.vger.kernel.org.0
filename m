Return-Path: <bpf+bounces-8352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9125785979
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1C628133E
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202BC135;
	Wed, 23 Aug 2023 13:38:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15656BE79
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 13:38:34 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5644FB
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 06:38:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so4471070f8f.2
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1692797911; x=1693402711;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iKAzMNi8nNivewK5+MFvQ5p70qvs8dwxCWiyewlejjA=;
        b=DXTiaR20zFzXkeale/xF2V1Kr2uWYbB3TvWYkEnVz7t53c3mPxLDaPjD6zJDOiaFRa
         VbVQgeJUNWl1FnIPcjsML2Byy8HfYTJoZq3JhaGFqsf2OfL1tbIzllv8aFqBCpoNM5ht
         s0vPNryawbnm7A+eQ4eBNoOGhGR9h/7NoWOZpdKEWvO80wsPgVhfjhJudCnSs2IrouIJ
         0XFIi5jDWHv3Zjtl1fdipZllYNzWI/OmsBd9duIRuBnbL3zw95/9Xe2MLPjExi4lPsdq
         Vei1a7Ce2seDlDOpX+g3xZ364w7KmjFhUG2jYLRUW8usUWkeSKI2ZE/57QyuVypKfiQ+
         3cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797911; x=1693402711;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKAzMNi8nNivewK5+MFvQ5p70qvs8dwxCWiyewlejjA=;
        b=ezBk7zy6ZNzJXN2SgZBcBBQ6ZABrhjGOW0hgve+1hqzLo2fmHPJcV20Gp8qGvnyUep
         erdLep2CNt2tQx87DbM5Ev4NwDbth40ZB5NEMk6EIqKHHE3cGwEwRd15Wjoy+BPvKZBe
         yw7df8qYlKCchrvBmPnKLFZ4Nlb+oRP5HOwTy/eBXvR90bgmQkbNmrjPuzVTthgYJyMy
         //XhTLUc+TRaFwgsSPFdjmKdgG8XhednuuvmmLesuniFX7U46pjE/bsEhIZC4+73mJbu
         IJOM3aX+S4JEtuLVj+dWTgm6Ea2Z3SfqVxvd9bbIMDap4vfJk7rY40CMPHI+PplN4Dxl
         vLjA==
X-Gm-Message-State: AOJu0YxQqTqwfEvOzqb/toJOEsVFgbhtKCmMJ49Fy5ZwV2rp/LDnqra4
	zyHBDL+fuvCsPdRppkaO/U1gzQ==
X-Google-Smtp-Source: AGHT+IGaSpNVjlokzsffDl1clDwPTvyQxkgYq4A4xPzUtZT8/B1cAud2dYVtVKIJAAjtqm9DrVoZnA==
X-Received: by 2002:a05:6000:11c9:b0:317:6175:95fd with SMTP id i9-20020a05600011c900b00317617595fdmr9623544wrx.43.1692797911124;
        Wed, 23 Aug 2023 06:38:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:e4f8:e750:a906:5580? ([2a01:e0a:b41:c160:e4f8:e750:a906:5580])
        by smtp.gmail.com with ESMTPSA id o2-20020adfcf02000000b00317a04131c5sm19020632wrj.57.2023.08.23.06.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 06:38:30 -0700 (PDT)
Message-ID: <856c3f29-aa38-4cf9-ae8f-a46279c3e262@6wind.com>
Date: Wed, 23 Aug 2023 15:38:28 +0200
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
 <ZMuI5mxR704O9nDq@debian> <62a8762c-40b4-f03f-ca8f-13d33db84f10@6wind.com>
 <ZMz86ADsBWV1gAal@debian>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZMz86ADsBWV1gAal@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 04/08/2023 à 15:28, Guillaume Nault a écrit :
> On Thu, Aug 03, 2023 at 02:22:17PM +0200, Nicolas Dichtel wrote:
>> Le 03/08/2023 à 13:00, Guillaume Nault a écrit :
>>> On Thu, Aug 03, 2023 at 11:37:00AM +0200, Nicolas Dichtel wrote:
>>>> Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
>>>>> On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
>>>>>> This kind of interface doesn't have a mac header.
>>>>>
>>>>> Well, PPP does have a link layer header.
>>>> It has a link layer, but not an ethernet header.
>>>
>>> This is generic code. The layer two protocol involved doesn't matter.
>>> What matter is that the device requires a specific l2 header.
>> Ok. Note, that addr_len is set to 0 for these devices:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ppp/ppp_generic.c#n1614
> 
> PPP has no hardware address. It doesn't need any since it's point to
> point. But it still has an l2 header.
> 
>>>>> Do you instead mean that PPP automatically adds it?
>>>>>
>>>>>> This patch fixes bpf_redirect() to a ppp interface.
>>>>>
>>>>> Can you give more details? Which kind of packets are you trying to
>>>>> redirect to PPP interfaces?
>>>> My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
>>>> at ingress to a ppp device at egress.
>>>
>>> So you're kind of bridging two incompatible layer two protocols.
>>> I see no reason to be surprised if that doesn't work out of the box.
>> I don't see the difference with a gre or ip tunnel. This kind of "bridging" is
>> supported.
> 
> From a protocol point of view, this feature just needs to strip the l2
> header (or add it for the other way around). Here we have to remove the
> previous l2 header, then add a new one of a different kind.
> 
> But honestly, even for the l3-tunnel<->Ethernet "bridging", I don't
> really like how the code tries to be too clever. It'd have been much
> simpler to just require the user to drop the l2 headers explicitely.
> Anyway, that ship has sailed.
> 
>>> Let me be clearer too. As I said, this patch may be the best we can do.
>>> Making a proper l2 generic BPF-redirect/TC-mirred might require too
>>> much work for the expected gain (how many users of non-Ethernet l2
>>> devices are going to use this). But at least we should make it clear in
>>> the commit message and in the code why we're finding it convenient to
>>> treat PPP as an l3 device. Like
>>>
>>> +	/* PPP adds its l2 header automatically in ppp_start_xmit().
>>> +	 * This makes it look like an l3 device to __bpf_redirect() and
>>> +	 * tcf_mirred_init().
>>> +	 */
>>> +	case ARPHRD_PPP:
>> I better understand your point with this comment, I can add it, no problem.
>> But I fail to see why it is different from a L3 device. ip, gre, etc. tunnels
>> also add automatically another header (ipip.c has dev->addr_len configured to 4,
>> ip6_tunnels.c to 16, etc.).
> 
> These are encapsulation protocols. They glue the inner and outer
> packets together. PPP doesn't do that, it's just an l2 protocol.
> To encapsulate PPP into IP or UDP, you need another protocol, like
> L2TP.
> 
> We can compare GRE or IPIP to L2TP (to some extend), not to PPP.
> 
>> A tcpdump on the physical output interface shows the same kind of packets (the
>> outer hdr (ppp / ip / etc.) followed by the encapsulated packet and a tcpdump on
>> the ppp or ip tunnel device shows only the inner packet.
> 
> Packets captured on ppp interfaces seem to be a bit misleading. They
> don't show the l2-header, but the "Linux cooked capture" header
> instead. I don't know the reasoning behind that, maybe to help people
> differenciate between Rx and Tx packets. Anyway, that's different from
> the raw IP packets captured on ipip devices for example.
> 
> Really, PPP isn't like any ip tunnel protocol. It's just not an
> encapsulation protocol. PPP is like Ethernet. And just like Ethernet,
> it can be encapsulated by tunnels, but that requires a separate
> tunneling protocol. As an example, Ethernet has VXLAN and PPP has L2TP.
> 
>> Without my patch, a redirect from a ppp interface to another ppp interface would
>> have the same problem.
> 
> True, but that's because the PPP code is so old and unmaintained, it
> hasn't evolved with the rest of the networking stack. And again, I
> agree that your patch is the easiest way to make it work. But it will
> also expose inconsistencies in how BPF and tc-mirred handle different
> l2 protocols. That makes the logic hard to get from a developper point
> of view and that's why I'm asking for a better commit message and some
> comments in the code. For the user space inconsistencies, well, I guess
> nobody will really care :(.

Thanks for the detailed explanations.


Regards,
Nicolas

