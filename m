Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC41F395396
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 03:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhEaBMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 May 2021 21:12:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2413 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhEaBMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 May 2021 21:12:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FtcZ73RDtz66wN;
        Mon, 31 May 2021 09:06:39 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:10:20 +0800
Received: from [127.0.0.1] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 09:10:20 +0800
Subject: Re: [Linuxarm] Re: [PATCH net-next 2/3] net: sched: implement
 TCQ_F_CAN_BYPASS for lockless qdisc
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Yunsheng Lin <yunshenglin0825@gmail.com>
CC:     <davem@davemloft.net>, <olteanv@gmail.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andriin@fb.com>, <edumazet@google.com>,
        <weiwan@google.com>, <cong.wang@bytedance.com>,
        <ap420073@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <mkl@pengutronix.de>, <linux-can@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <bpf@vger.kernel.org>, <jonas.bonn@netrounds.com>,
        <pabeni@redhat.com>, <mzhivich@akamai.com>, <johunt@akamai.com>,
        <albcamus@gmail.com>, <kehuan.feng@gmail.com>,
        <a.fatoum@pengutronix.de>, <atenart@kernel.org>,
        <alexander.duyck@gmail.com>, <hdanton@sina.com>, <jgross@suse.com>,
        <JKosina@suse.com>, <mkubecek@suse.cz>, <bjorn@kernel.org>,
        <alobakin@pm.me>
References: <1622170197-27370-1-git-send-email-linyunsheng@huawei.com>
 <1622170197-27370-3-git-send-email-linyunsheng@huawei.com>
 <20210528180012.676797d6@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <a6a965ee-7368-d37b-9c70-bba50c67eec9@huawei.com>
 <20210528213218.2b90864c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <ee1a62da-9758-70db-abd3-c5ca2e8e0ce0@huawei.com>
 <20210529114919.4f8b1980@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <9cc9f513-7655-07df-3c74-5abe07ae8321@gmail.com>
 <20210530132111.3a974275@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <3c2fbc70-841f-d90b-ca13-1f058169be50@huawei.com>
Message-ID: <3a307707-9fb5-d73a-01f9-93aaf5c7a437@huawei.com>
Date:   Mon, 31 May 2021 09:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <3c2fbc70-841f-d90b-ca13-1f058169be50@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021/5/31 8:40, Yunsheng Lin wrote:
> On 2021/5/31 4:21, Jakub Kicinski wrote:
>> On Sun, 30 May 2021 09:37:09 +0800 Yunsheng Lin wrote:
>>> On 2021/5/30 2:49, Jakub Kicinski wrote:
>>>> The fact that MISSED is only cleared under q->seqlock does not matter,
>>>> because setting it and ->enqueue() are not under any lock. If the thread
>>>> gets interrupted between:
>>>>
>>>> 	if (q->flags & TCQ_F_CAN_BYPASS && nolock_qdisc_is_empty(q) &&
>>>> 	    qdisc_run_begin(q)) {
>>>>
>>>> and ->enqueue() we can't guarantee that something else won't come in,
>>>> take q->seqlock and clear MISSED.
>>>>
>>>> thread1                thread2             thread3
>>>> # holds seqlock
>>>>                        qdisc_run_begin(q)
>>>>                        set(MISSED)
>>>> pfifo_fast_dequeue
>>>>   clear(MISSED)
>>>>   # recheck the queue
>>>> qdisc_run_end()  
>>>>                        ->enqueue()  
>>>>                                             q->flags & TCQ_F_CAN_BYPASS..
>>>>                                             qdisc_run_begin() # true
>>>>                                             sch_direct_xmit()
>>>>                        qdisc_run_begin()
>>>>                        set(MISSED)
>>>>
>>>> Or am I missing something?
>>>>
>>>> Re-checking nolock_qdisc_is_empty() may or may not help.
>>>> But it doesn't really matter because there is no ordering
>>>> requirement between thread2 and thread3 here.  
>>>
>>> I were more focued on explaining that using MISSED is reliable
>>> as sch_may_need_requeuing() checking in RFCv3 [1] to indicate a
>>> empty qdisc, and forgot to mention the data race described in
>>> RFCv3, which is kind of like the one described above:
>>>
>>> "There is a data race as below:
>>>
>>>       CPU1                                   CPU2
>>> qdisc_run_begin(q)                            .
>>>         .                                q->enqueue()
>>> sch_may_need_requeuing()                      .
>>>     return true                               .
>>>         .                                     .
>>>         .                                     .
>>>     q->enqueue()                              .
>>>
>>> When above happen, the skb enqueued by CPU1 is dequeued after the
>>> skb enqueued by CPU2 because sch_may_need_requeuing() return true.
>>> If there is not qdisc bypass, the CPU1 has better chance to queue
>>> the skb quicker than CPU2.
>>>
>>> This patch does not take care of the above data race, because I
>>> view this as similar as below:
>>>
>>> Even at the same time CPU1 and CPU2 write the skb to two socket
>>> which both heading to the same qdisc, there is no guarantee that
>>> which skb will hit the qdisc first, becuase there is a lot of
>>> factor like interrupt/softirq/cache miss/scheduling afffecting
>>> that."
>>>
>>> Does above make sense? Or any idea to avoid it?
>>>
>>> 1. https://patchwork.kernel.org/project/netdevbpf/patch/1616404156-11772-1-git-send-email-linyunsheng@huawei.com/
>>
>> We agree on this one.
>>
>> Could you draw a sequence diagram of different CPUs (like the one
>> above) for the case where removing re-checking nolock_qdisc_is_empty()
>> under q->seqlock leads to incorrect behavior? 
> 
> When nolock_qdisc_is_empty() is not re-checking under q->seqlock, we
> may have:
> 
> 
>         CPU1                                   CPU2
>   qdisc_run_begin(q)                            .
>           .                                enqueue skb1
> deuqueue skb1 and clear MISSED                  .
>           .                        nolock_qdisc_is_empty() return true
>     requeue skb                                 .
>    q->enqueue()                                 .
>     set MISSED                                  .
>         .                                       .
>  qdisc_run_end(q)                               .
>         .                              qdisc_run_begin(q)
>         .                             transmit skb2 directly
>         .                           transmit the requeued skb1
> 
> The problem here is that skb1 and skb2  are from the same CPU, which
> means they are likely from the same flow, so we need to avoid this,
> right?


         CPU1                                   CPU2
   qdisc_run_begin(q)                            .
           .                                enqueue skb1
     dequeue skb1                                .
           .                                     .
netdevice stopped and MISSED is clear            .
           .                        nolock_qdisc_is_empty() return true
     requeue skb                                 .
           .                                     .
           .                                     .
           .                                     .
  qdisc_run_end(q)                               .
           .                              qdisc_run_begin(q)
           .                             transmit skb2 directly
           .                           transmit the requeued skb1

The above sequence diagram seems more correct, it is basically about how to
avoid transmitting a packet directly bypassing the requeued packet.

> 
>>
>> If there is no such case would you be willing to repeat the benchmark
>> with and without this test?
>>
>> Sorry for dragging the review out..
>>
>> .
>>
> _______________________________________________
> Linuxarm mailing list -- linuxarm@openeuler.org
> To unsubscribe send an email to linuxarm-leave@openeuler.org
> 

