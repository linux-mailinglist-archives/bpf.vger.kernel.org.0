Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC729032
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 06:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfEXEyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 00:54:43 -0400
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:36499 "EHLO
        tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEXEyn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 00:54:43 -0400
Received: from vc1.ecl.ntt.co.jp (vc1.ecl.ntt.co.jp [129.60.86.153])
        by tama500.ecl.ntt.co.jp (8.13.8/8.13.8) with ESMTP id x4O4sCOR003200;
        Fri, 24 May 2019 13:54:12 +0900
Received: from vc1.ecl.ntt.co.jp (localhost [127.0.0.1])
        by vc1.ecl.ntt.co.jp (Postfix) with ESMTP id 90D65EA7F56;
        Fri, 24 May 2019 13:54:12 +0900 (JST)
Received: from jcms-pop21.ecl.ntt.co.jp (jcms-pop21.ecl.ntt.co.jp [129.60.87.134])
        by vc1.ecl.ntt.co.jp (Postfix) with ESMTP id 85EAEEA7F04;
        Fri, 24 May 2019 13:54:12 +0900 (JST)
Received: from [IPv6:::1] (eb8460w-makita.sic.ecl.ntt.co.jp [129.60.241.47])
        by jcms-pop21.ecl.ntt.co.jp (Postfix) with ESMTPSA id 7A2B4400870;
        Fri, 24 May 2019 13:54:12 +0900 (JST)
Subject: Re: [PATCH bpf-next 3/3] veth: Support bulk XDP_TX
References: <1558609008-2590-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <1558609008-2590-4-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <87zhnd1kg9.fsf@toke.dk> <599302b2-96d2-b571-01ee-f4914acaf765@lab.ntt.co.jp>
 <20190523152927.14bf7ed1@carbon>
 <c902c0f4-947b-ba9e-7baa-628ba87a8f01@gmail.com>
 <94046143-f05d-77db-88c4-7bd62f2c98d4@redhat.com>
 <c560baa0-8a71-4ab3-7107-c831d6ef8bb8@lab.ntt.co.jp>
 <1035faf0-3fd2-4986-540e-b76ab53fe99b@redhat.com>
From:   Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <3a3217f2-89d0-fc1e-bca8-953cf83f5e57@lab.ntt.co.jp>
Date:   Fri, 24 May 2019 13:52:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1035faf0-3fd2-4986-540e-b76ab53fe99b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CC-Mail-RelayStamp: 1
To:     Jason Wang <jasowang@redhat.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org
X-TM-AS-MML: disable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019/05/24 12:54, Jason Wang wrote:
> On 2019/5/24 上午11:28, Toshiaki Makita wrote:
>> On 2019/05/24 12:13, Jason Wang wrote:
>>> On 2019/5/23 下午9:51, Toshiaki Makita wrote:
>>>> On 19/05/23 (木) 22:29:27, Jesper Dangaard Brouer wrote:
>>>>> On Thu, 23 May 2019 20:35:50 +0900
>>>>> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
>>>>>
>>>>>> On 2019/05/23 20:25, Toke Høiland-Jørgensen wrote:
>>>>>>> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> writes:
>>>>>>>> This improves XDP_TX performance by about 8%.
>>>>>>>>
>>>>>>>> Here are single core XDP_TX test results. CPU consumptions are
>>>>>>>> taken
>>>>>>>> from "perf report --no-child".
>>>>>>>>
>>>>>>>> - Before:
>>>>>>>>
>>>>>>>>     7.26 Mpps
>>>>>>>>
>>>>>>>>     _raw_spin_lock  7.83%
>>>>>>>>     veth_xdp_xmit  12.23%
>>>>>>>>
>>>>>>>> - After:
>>>>>>>>
>>>>>>>>     7.84 Mpps
>>>>>>>>
>>>>>>>>     _raw_spin_lock  1.17%
>>>>>>>>     veth_xdp_xmit   6.45%
>>>>>>>>
>>>>>>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>>>>>>> ---
>>>>>>>>    drivers/net/veth.c | 26 +++++++++++++++++++++++++-
>>>>>>>>    1 file changed, 25 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>>>>>>> index 52110e5..4edc75f 100644
>>>>>>>> --- a/drivers/net/veth.c
>>>>>>>> +++ b/drivers/net/veth.c
>>>>>>>> @@ -442,6 +442,23 @@ static int veth_xdp_xmit(struct net_device
>>>>>>>> *dev, int n,
>>>>>>>>        return ret;
>>>>>>>>    }
>>>>>>>>    +static void veth_xdp_flush_bq(struct net_device *dev)
>>>>>>>> +{
>>>>>>>> +    struct xdp_tx_bulk_queue *bq = this_cpu_ptr(&xdp_tx_bq);
>>>>>>>> +    int sent, i, err = 0;
>>>>>>>> +
>>>>>>>> +    sent = veth_xdp_xmit(dev, bq->count, bq->q, 0);
>>>>>>> Wait, veth_xdp_xmit() is just putting frames on a pointer ring. So
>>>>>>> you're introducing an additional per-cpu bulk queue, only to avoid
>>>>>>> lock
>>>>>>> contention around the existing pointer ring. But the pointer ring is
>>>>>>> per-rq, so if you have lock contention, this means you must have
>>>>>>> multiple CPUs servicing the same rq, no?
>>>>>> Yes, it's possible. Not recommended though.
>>>>>>
>>>>> I think the general per-cpu TX bulk queue is overkill.  There is a
>>>>> loop
>>>>> over packets in veth_xdp_rcv(struct veth_rq *rq, budget, *status), and
>>>>> the caller veth_poll() will call veth_xdp_flush(rq->dev).
>>>>>
>>>>> Why can't you store this "temp" bulk array in struct veth_rq ?
>>>> Of course I can. But I thought tun has the same problem and we can
>>>> decrease memory footprint by sharing the same storage between devices.
>>>
>>> For TUN and for its fast path where vhost passes a bulk of XDP frames
>>> (through msg_control) to us, we probably just need a temporary bulk
>>> array in tun_xdp_one() instead of a global one. I can post patch or
>>> maybe you if you're interested in this.
>> Of course you/I can. What I'm concerned is that could be waste of cache
>> line when softirq runs veth napi handler and then tun napi handler.
>>
> 
> Well, technically the bulk queue passed to TUN could be reused. I admit
> it may save cacheline in ideal case but I wonder how much we could gain
> on real workload.

I see veth_rq ptr_ring suffering from cacheline miss, which makes me
conservative about adding more buffers for xdp_frames.
I'll wait for some more feedback from others.

> (Note TUN doesn't use napi handler to do XDP, it has a
> NAPI mode but it was mainly used for hardening and XDP was not
> implemented there, maybe we should fix this).

Ah, that's true. Sorry for confusion.

> 
> Thanks
> 
> 
>>> Thanks
>>>
>>>
>>>> Or if other devices want to reduce queues so that we can use XDP on
>>>> many-cpu servers and introduce locks, we can use this storage for that
>>>> case as well.
>>>>
>>>> Still do you prefer veth-specific solution?
>>>>
>>>>> You could even alloc/create it on the stack of veth_poll() and send it
>>>>> along via a pointer to veth_xdp_rcv).
>>>>>
>>>> Toshiaki Makita
>>>
> 
> 

-- 
Toshiaki Makita

