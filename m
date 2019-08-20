Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCC896B61
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHTVYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 17:24:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:55030 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 17:24:32 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0Bc5-0007QV-Pz; Tue, 20 Aug 2019 23:24:21 +0200
Received: from [178.197.249.40] (helo=pc-63.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0Bc5-0006tF-Df; Tue, 20 Aug 2019 23:24:21 +0200
Subject: Re: [PATCH bpf-next] xsk: proper socket state check in xsk_poll
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     syzbot+c82697e3043781e08802@syzkaller.appspotmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs@googlegroups.com, Xdp <xdp-newbies@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, hdanton@sina.com
References: <0000000000009167320590823a8c@google.com>
 <20190820100405.25564-1-bjorn.topel@gmail.com>
 <beef16bb-a09b-40f1-7dd0-c323b4b89b17@iogearbox.net>
 <CAJ+HfNj8qNwCpiLBw1eO_ggSf11Qq9323NVOcTS6wtfTm=RWcg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fa423b3d-d9da-7142-c7bf-e202967620ea@iogearbox.net>
Date:   Tue, 20 Aug 2019 23:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJ+HfNj8qNwCpiLBw1eO_ggSf11Qq9323NVOcTS6wtfTm=RWcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25547/Tue Aug 20 10:27:49 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/20/19 5:29 PM, Björn Töpel wrote:
> On Tue, 20 Aug 2019 at 16:30, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 8/20/19 12:04 PM, Björn Töpel wrote:
>>> From: Björn Töpel <bjorn.topel@intel.com>
>>>
>>> The poll() implementation for AF_XDP sockets did not perform the
>>> proper state checks, prior accessing the socket umem. This patch fixes
>>> that by performing a xsk_is_bound() check.
>>>
>>> Suggested-by: Hillf Danton <hdanton@sina.com>
>>> Reported-by: syzbot+c82697e3043781e08802@syzkaller.appspotmail.com
>>> Fixes: 77cd0d7b3f25 ("xsk: add support for need_wakeup flag in AF_XDP rings")
>>> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
>>> ---
>>>    net/xdp/xsk.c | 14 ++++++++++++--
>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>>> index ee4428a892fa..08bed5e92af4 100644
>>> --- a/net/xdp/xsk.c
>>> +++ b/net/xdp/xsk.c
>>> @@ -356,13 +356,20 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
>>>        return err;
>>>    }
>>>
>>> +static bool xsk_is_bound(struct xdp_sock *xs)
>>> +{
>>> +     struct net_device *dev = READ_ONCE(xs->dev);
>>> +
>>> +     return dev && xs->state == XSK_BOUND;
>>> +}
>>> +
>>>    static int xsk_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>>>    {
>>>        bool need_wait = !(m->msg_flags & MSG_DONTWAIT);
>>>        struct sock *sk = sock->sk;
>>>        struct xdp_sock *xs = xdp_sk(sk);
>>>
>>> -     if (unlikely(!xs->dev))
>>> +     if (unlikely(!xsk_is_bound(xs)))
>>>                return -ENXIO;
>>>        if (unlikely(!(xs->dev->flags & IFF_UP)))
>>>                return -ENETDOWN;
>>> @@ -383,6 +390,9 @@ static unsigned int xsk_poll(struct file *file, struct socket *sock,
>>>        struct net_device *dev = xs->dev;
>>>        struct xdp_umem *umem = xs->umem;
>>>
>>> +     if (unlikely(!xsk_is_bound(xs)))
>>> +             return mask;
>>> +
>>>        if (umem->need_wakeup)
>>>                dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id,
>>>                                                umem->need_wakeup);
>>> @@ -417,7 +427,7 @@ static void xsk_unbind_dev(struct xdp_sock *xs)
>>>    {
>>>        struct net_device *dev = xs->dev;
>>>
>>> -     if (!dev || xs->state != XSK_BOUND)
>>> +     if (!xsk_is_bound(xs))
>>>                return;
>>
>> I think I'm a bit confused by your READ_ONCE() usage. ;-/ I can see why you're
>> using it in xsk_is_bound() above, but then at the same time all the other callbacks
>> like xsk_poll() or xsk_unbind_dev() above have a struct net_device *dev = xs->dev
>> right before the test. Could you elaborate?
> 
> Yes, now I'm confused as well! Digging deeper... I believe there are a
> couple of places in xsk.c that do not have
> READ_ONCE/WRITE_ONCE-correctness. Various xdp_sock members are read
> lock-less outside the control plane mutex (mutex member of struct
> xdp_sock). This needs some re-work. I'll look into using the newly

Right, so even in above two cases, the compiler could have refetched, e.g.
dev variable could have first been NULL, but xsk_is_bound() later returns
true.

> introduced state member (with corresponding read/write barriers) for
> this.
> 
> I'll cook some patch(es) that address this, but first it sounds like I
> need to reread [1] two, or three times. At least. ;-)
> 
> 
> Thanks,
> Björn
> 
> 
> [1] https://lwn.net/Articles/793253/
> 
> 
>> Thanks,
>> Daniel

