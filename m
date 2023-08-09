Return-Path: <bpf+bounces-7331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBB775AA7
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7212B1C21128
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4617758;
	Wed,  9 Aug 2023 11:09:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52C53B7;
	Wed,  9 Aug 2023 11:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6A7C433C9;
	Wed,  9 Aug 2023 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691579397;
	bh=3Wv/fOquDhwM4PQubxLEW0sEpc4CURoTiDKWKH6VRuI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CfPD9DpgGD7pma4wFzIKTbCQRrEN4QKfDTqWQCL/GzgESJrADcF57CKkt+P0XcOwN
	 N7P6pOwnYnR6Y+u1GkD5KjfC3+2yCGGO1yWabC1QRUguhhjCcXfsnzfKdnyP32n0wq
	 vrH9FxnU0hdH4KNngPLZdArA4WJYOAFvRr1Xq6k9avD86cbutzy/ayFzMWtbkKlzMe
	 YP95BSi4dx7LEkK73HBgEFIXU9bVnpg2Ur3XKM0LLHsaCQdPCpPA0aqo8dz9m1nGys
	 eFXFz5r27/etHlxHRgVOKRu0VFMhZsHJOBv6RJGJSuo+YP9QiW6fKdMFNBS99PmE8E
	 rgu6TkQis76+Q==
Message-ID: <68f73855-f206-80a2-a546-3d40864ee176@kernel.org>
Date: Wed, 9 Aug 2023 13:09:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Kees Cook <keescook@chromium.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
 Donald Hunter <donhunte@redhat.com>, Dave Tucker <datucker@redhat.com>
Subject: Re: [RFC v3 Optimizing veth xsk performance 0/9]
Content-Language: en-US
To: =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
 <87v8dpbv5r.fsf@toke.dk>
 <CABKxMyNrwSOrzpq6mhqtU_kEk5B9nKPODtmfjJO5_NmGpw_Oag@mail.gmail.com>
 <87msz04mb4.fsf@toke.dk>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87msz04mb4.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/08/2023 11.06, Toke Høiland-Jørgensen wrote:
> 黄杰 <huangjie.albert@bytedance.com> writes:
> 
>> Toke Høiland-Jørgensen <toke@redhat.com> 于2023年8月8日周二 20:01写道：
>>>
>>> Albert Huang <huangjie.albert@bytedance.com> writes:
>>>
>>>> AF_XDP is a kernel bypass technology that can greatly improve performance.
>>>> However,for virtual devices like veth,even with the use of AF_XDP sockets,
>>>> there are still many additional software paths that consume CPU resources.
>>>> This patch series focuses on optimizing the performance of AF_XDP sockets
>>>> for veth virtual devices. Patches 1 to 4 mainly involve preparatory work.
>>>> Patch 5 introduces tx queue and tx napi for packet transmission, while
>>>> patch 8 primarily implements batch sending for IPv4 UDP packets, and patch 9
>>>> add support for AF_XDP tx need_wakup feature. These optimizations significantly
>>>> reduce the software path and support checksum offload.
>>>>
>>>> I tested those feature with
>>>> A typical topology is shown below:
>>>> client(send):                                        server:(recv)
>>>> veth<-->veth-peer                                    veth1-peer<--->veth1
>>>>    1       |                                                  |   7
>>>>            |2                                                6|
>>>>            |                                                  |
>>>>          bridge<------->eth0(mlnx5)- switch -eth1(mlnx5)<--->bridge1
>>>>                    3                    4                 5
>>>>               (machine1)                              (machine2)
>>>
>>> I definitely applaud the effort to improve the performance of af_xdp
>>> over veth, this is something we have flagged as in need of improvement
>>> as well.
>>>
>>> However, looking through your patch series, I am less sure that the
>>> approach you're taking here is the right one.
>>>
>>> AFAIU (speaking about the TX side here), the main difference between
>>> AF_XDP ZC and the regular transmit mode is that in the regular TX mode
>>> the stack will allocate an skb to hold the frame and push that down the
>>> stack. Whereas in ZC mode, there's a driver NDO that gets called
>>> directly, bypassing the skb allocation entirely.
>>>
>>> In this series, you're implementing the ZC mode for veth, but the driver
>>> code ends up allocating an skb anyway. Which seems to be a bit of a
>>> weird midpoint between the two modes, and adds a lot of complexity to
>>> the driver that (at least conceptually) is mostly just a
>>> reimplementation of what the stack does in non-ZC mode (allocate an skb
>>> and push it through the stack).
>>>
>>> So my question is, why not optimise the non-zc path in the stack instead
>>> of implementing the zc logic for veth? It seems to me that it would be
>>> quite feasible to apply the same optimisations (bulking, and even GRO)
>>> to that path and achieve the same benefits, without having to add all
>>> this complexity to the veth driver?
>>>
>>> -Toke
>>>
>> thanks!
>> This idea is really good indeed. You've reminded me, and that's
>> something I overlooked. I will now consider implementing the solution
>> you've proposed and test the performance enhancement.
> 
> Sounds good, thanks! :)

Good to hear, that you want to optimize the non-zc TX path of AF_XDP, as
Toke suggests.

There is a number of performance issues for AF_XDP non-zc TX that I've
talked/complained to Magnus and Bjørn about over the years.
I've recently started to work on fixing these myself, in collaboration
with Maryam (cc).

The most obvious is that non-zc TX uses socket memory accounting for the
SKBs that gets allocated. (ZC TX obviously doesn't).  IMHO this doesn't
make sense as AF_XDP concept is to pre-allocate memory, thus AF_XDP
memory limits are already bounded at setup time.  Further more,
__xsk_generic_xmit() already have a backpressure mechanism based on
avail room in the CQ (Completion Queue) .  Hint: the call
sock_alloc_send_skb() includes/does socket mem accounting.

When AF_XDP gets combined with veth (or other layered software devices),
the problem gets worse, because:

  (1) the SKB that gets allocated by xsk_build_skb() doesn't have enough
      headroom to satisfy XDP requirement XDP_PACKET_HEADROOM.

  (2) the backing memory type from sock_alloc_send_skb() is not
      compatible with generic/veth XDP.

Both these issues, result in that when peer veth device RX the (AF_XDP)
TX packet, then it have to reallocate memory+SKB and copy data *again*.

I'm currently[1] looking into how to fix this and have some PoC patches
to estimate the performance benefit from avoiding the realloc when
entering veth.  With packet size 512, the numbers start at 828Kpps and
after increase to 1002Kpps (and increase of 20% or 208 nanosec).

  [1] 
https://github.com/xdp-project/xdp-project/blob/veth-benchmark01/areas/core/veth_benchmark03.org

--
Best regards,
   Jesper Dangaard Brouer
   MSc.CS, Sr. Principal Kernel Engineer at Red Hat
   LinkedIn: http://www.linkedin.com/in/brouer

