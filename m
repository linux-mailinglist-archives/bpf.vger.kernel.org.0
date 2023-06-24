Return-Path: <bpf+bounces-3371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C186C73CB70
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFDC1C2098B
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BE35675;
	Sat, 24 Jun 2023 14:44:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3846B0;
	Sat, 24 Jun 2023 14:44:38 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673818E;
	Sat, 24 Jun 2023 07:44:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1347357a12.1;
        Sat, 24 Jun 2023 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687617876; x=1690209876;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vJmDaKU4Ib4pJXRd1yORA65Rzqd159XVS7SbpIKack=;
        b=R+YZN6sCYnkNmfLbovLwWUQwPShZrJnInzBwM1/U6Pcex/G+vwiGdSe2U6rNWIxY7l
         xEY4Q3xhjhPBlX1yMJgiPxxmfEhMuLBpNW5WHlzB4kYP9ZsR/gpUNttdFj35Xp39dSxb
         +367SYkL0eqIriiUgNxiUKQjjwPczy/gyao1VTHzdy2LwKyq29Tmw87LM6woAeCB4qTe
         E0IBQd0uRgp1Tkl1HPGj0CxrIYIC7MvvLuqXeWYctvFIZbzFk+7o9eC7YGbyNpJeA+o8
         QyyiD1q1zGxGsFWFzvupor1byEZvzAAJt6KBj0k/H8VGrLSHi4Hb72dgWFvQKfrdr2er
         xt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687617876; x=1690209876;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vJmDaKU4Ib4pJXRd1yORA65Rzqd159XVS7SbpIKack=;
        b=iRWuUEgk/CSijKsbuAUdmBD1KNGSjitFd7xb8DPoLpV5M+ejQlt3NKW9RXZ55V1poE
         EGJwwz9XBre0gNZkK+v3IFV/BqHiCQSderLl7xGHvv+kuwq6umd7d5/gBHZk2TTXgjT+
         HGk9LAFDzF16ZlT8tbNuJzoPxh+//AS8DIcUQu0tutqQ0KR/WpE3S9g5dizS1GUhKHCk
         MI+IHCLZzblhlYBGQLT5ghW7+/vh3f8zk34s7xQDlypwzSfchLh39tPuSuuXN2QKjGiE
         Y0sGPgGdVUPe3bt+Bx6Qk4L26yFBaNvoP9cjRA97LY0cwDBZE8qSDiKDHpI4/FeVNGIq
         q0fQ==
X-Gm-Message-State: AC+VfDyDhgq2mbcDhI/Va4jCSb3svar9y9q9CCHHOPXcyM7FaIoP0ljV
	XjAHps0+TGzJNVbl29j13bBav5arGxEc3Jn+8wo=
X-Google-Smtp-Source: ACHHUZ7CP0TUiEYRNEhB+Q/AnZCddjvg/nUlVf6D2r9b0dEkDcWeQYwnqajmoL5F0mwMxKlJLk5GBA==
X-Received: by 2002:a17:90a:e60d:b0:25e:8326:488e with SMTP id j13-20020a17090ae60d00b0025e8326488emr24028485pjy.17.1687617875824;
        Sat, 24 Jun 2023 07:44:35 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:5d8f:b0cc:e645:f4d? ([2409:8a55:301b:e120:5d8f:b0cc:e645:f4d])
        by smtp.gmail.com with ESMTPSA id o6-20020a63e346000000b00553b9e0510esm1333096pgj.60.2023.06.24.07.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 07:44:35 -0700 (PDT)
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
To: Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>
Cc: brouer@redhat.com, Yunsheng Lin <linyunsheng@huawei.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Maryam Tahhan <mtahhan@redhat.com>,
 bpf <bpf@vger.kernel.org>
References: <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
 <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
 <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
 <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
 <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
 <CAKgT0UcNOYwxRP_zkaBaZh-VBL-CriL8dFG-VY7-FUyzxfHDWw@mail.gmail.com>
 <ZI8dP5+guKdR7IFE@lore-desk>
 <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>
 <ZJIXSyjxPf7FQQKo@lore-rh-laptop>
 <3e6c191a-3be3-d6ff-92a2-2685bade2e66@redhat.com>
From: Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <8d93fbf0-43bb-7a9c-9470-0085cf25a228@gmail.com>
Date: Sat, 24 Jun 2023 22:44:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3e6c191a-3be3-d6ff-92a2-2685bade2e66@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/6/21 19:55, Jesper Dangaard Brouer wrote:
> 
> 
> On 20/06/2023 23.16, Lorenzo Bianconi wrote:
>> [...]
>>
>>>> I did some experiments using page_frag_cache/page_frag_alloc() instead of
>>>> page_pools in a simple environment I used to test XDP for veth driver.
>>>> In particular, I allocate a new buffer in veth_convert_skb_to_xdp_buff() from
>>>> the page_frag_cache in order to copy the full skb in the new one, actually
>>>> "linearizing" the packet (since we know the original skb length).
>>>> I run an iperf TCP connection over a veth pair where the
>>>> remote device runs the xdp_rxq_info sample (available in the kernel source
>>>> tree, with action XDP_PASS):
>>>>
>>>> TCP clietn -- v0 === v1 (xdp_rxq_info) -- TCP server
>>>>
>>>> net-next (page_pool):
>>>> - MTU 1500B: ~  7.5 Gbps
>>>> - MTU 8000B: ~ 15.3 Gbps
>>>>
>>>> net-next + page_frag_alloc:
>>>> - MTU 1500B: ~  8.4 Gbps
>>>> - MTU 8000B: ~ 14.7 Gbps
>>>>
>>>> It seems there is no a clear "win" situation here (at least in this environment
>>>> and we this simple approach). Moreover:
>>>
>>> For the 1500B packets it is a win, but for 8000B it looks like there
>>> is a regression. Any idea what is causing it?
>>
>> nope, I have not looked into it yet.
>>
> 
> I think I can explain via using micro-benchmark numbers.
> (Lorenzo and I have discussed this over IRC, so this is our summary)
> 
> *** MTU 1500***
> 
> * The MTU 1500 case, where page_frag_alloc is faster than PP (page_pool):
> 
> The PP alloc a 4K page for MTU 1500. The cost of alloc + recycle via
> ptr_ring cost 48 cycles (page_pool02_ptr_ring Per elem: 48 cycles(tsc)).
> 
> The page_frag_alloc API allocates a 32KB order-3 page, and chops it up
> for packets.  The order-3 alloc + free cost 514 cycles (page_bench01:
> alloc_pages order:3(32768B) 514 cycles). The MTU 1500 needs alloc size
> 1514+320+256 = 2090 bytes.  In 32KB we can fit 15 packets.  Thus, the
> amortized cost per packet is only 34.3 cycles (514/15).
> 
> Thus, this explains why page_frag_alloc API have an advantage here, as
> amortized cost per packet is lower (for page_frag_alloc).
> 
> 
> *** MTU 8000 ***
> 
> * The MTU 8000 case, where PP is faster than page_frag_alloc.
> 
> The page_frag_alloc API cannot slice the same 32KB into as many packets.
> The MTU 8000 needs alloc size 8000+14+256+320 = 8590 bytes.  This is can
> only store 3 full packets (32768/8590 = 3.81).
> Thus, cost is 514/3 = 171 cycles.
> 
> The PP is actually challenged at MTU 8000, because it unfortunately
> leads to allocating 3 full pages (12KiB), due to needed alloc size 8590
> bytes. Thus cost is 3x 48 cycles = 144 cycles.
> (There is also a chance of Jakubs "allow_direct" optimization in page_pool_return_skb_page to increase performance for PP).
> 
> Thus, this explains why PP is fastest in this case.

Great analysis.
So the problem seems to be: can we optimize the page fragment cache
implementation so that it can at least match the performance of PP
for the above case? As Alexander seems to be against using PP for
the veth case without involving DMA mapping.

> 
> 
> *** Surprising insights ***
> 
> My (maybe) surprising conclusion is that we should combine the two
> approaches.  Which is basically what Lin's patchset is doing!
> Thus, I'm actually suddenly become a fan of this patchset...
> 
> The insight is that PP can also work with higher-order pages and the
> cost of PP recycles via ptr_ring will be the same, regardless of page
> order size.  Thus, we can reduced the order-3 cost 514 cycles to
> basically 48 cycles, and fit 15 packets (MTU 1500) resulting is
> amortized allocator cost 48/15 = 3.2 cycles.
> 
> On the PP alloc-side this will be amazingly fast. When PP recycles frags
> side, see page_pool_defrag_page() there is an atomic_sub operation.
> I've measured atomic_inc to cost 17 cycles (for optimal non-contended
> case), thus 3+17 = 20 cycles, it should still be a win.
> 
> 
> --Jesper
> 
> 

