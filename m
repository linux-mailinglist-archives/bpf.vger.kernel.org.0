Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E373AAB92
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQGEA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 02:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhFQGD7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 02:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623909712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeqlgzOeyLHlVfCtn0FqLKQsQgrLb4eS0/o16mmkHIk=;
        b=HQVBy7XNPOQBd67v9aUfo7b3r52ySO6h+aRP88RKTdck1kS83V1aTKNdhKlqgQXbiBOm9p
        +/4nmn2gmL07dbFwRN2/BtAxSf5qLn/GnoRdLrmPjrET18tAfuIbUNlES0qKu1craxV1qO
        VrIO39c9bnqEtMi+B1eIMubV5RBPI4Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-LMj_juyfPlKco3f8lN_iAQ-1; Thu, 17 Jun 2021 02:01:51 -0400
X-MC-Unique: LMj_juyfPlKco3f8lN_iAQ-1
Received: by mail-pj1-f69.google.com with SMTP id fu20-20020a17090ad194b0290163ff5d5867so683673pjb.2
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 23:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zeqlgzOeyLHlVfCtn0FqLKQsQgrLb4eS0/o16mmkHIk=;
        b=pWBURM8BXAOtJC9XQIcEV6wIdTgT1Y39LO32Uy/ootHJ/pujjBKxok/7Gq/GWdwoA3
         VM7ifwf49dbf24+mWj9BRaHITnK/rU3B+wCr1vmjlinbgkm1F5Nquh9pprkCjfE0j6ym
         +U6FqVUwV6bO8VBz1v7XHD6rmCC1ocx9g6tNKoc6wGuhHp7iRKbVxG2AE+a50M3yiy8s
         J4J3Of/LobPh6djHja+4umJ653GNN+x2Vzn9uJy3TtiCjkB19191+MCBbTc45195wOPM
         HBv6MoSEizRlg+MHg3wboODBBh/vdJ3HHD8FKIupbLtRLrtPamwdkUw1aa3wvd1KuQaJ
         kYdQ==
X-Gm-Message-State: AOAM532FCholPFoDFX9ta7Ho46TjLbPVDrEw8Y4Tv0smRLydUbY0NrFd
        Pp8uaK+VwjQKFF3xB8+Yi52Y2wAwzCti8WmkTika6RMw3how0U7ZpQ/QS8Rez7p21BE2nZQxT2h
        Gh2YgXsoMLeXD
X-Received: by 2002:a63:ce07:: with SMTP id y7mr3428190pgf.249.1623909710020;
        Wed, 16 Jun 2021 23:01:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCbt3koOSCSoPCxeKahYUVTaehdFD8TluMS6k/bbR0i7dh8yWIpiWdNXvdky6YrOTUyk7Wsw==
X-Received: by 2002:a63:ce07:: with SMTP id y7mr3428160pgf.249.1623909709764;
        Wed, 16 Jun 2021 23:01:49 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n11sm3800958pfu.29.2021.06.16.23.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 23:01:49 -0700 (PDT)
Subject: Re: [PATCH net-next v5 14/15] virtio-net: xsk direct xmit inside xsk
 wakeup
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        "dust.li" <dust.li@linux.alibaba.com>, netdev@vger.kernel.org
References: <1623909331.6403847-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e606f6aa-5aba-0d47-8cc1-616cfead0faf@redhat.com>
Date:   Thu, 17 Jun 2021 14:01:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623909331.6403847-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2021/6/17 下午1:55, Xuan Zhuo 写道:
> On Thu, 17 Jun 2021 11:07:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> 在 2021/6/10 下午4:22, Xuan Zhuo 写道:
>>> Calling virtqueue_napi_schedule() in wakeup results in napi running on
>>> the current cpu. If the application is not busy, then there is no
>>> problem. But if the application itself is busy, it will cause a lot of
>>> scheduling.
>>>
>>> If the application is continuously sending data packets, due to the
>>> continuous scheduling between the application and napi, the data packet
>>> transmission will not be smooth, and there will be an obvious delay in
>>> the transmission (you can use tcpdump to see it). When pressing a
>>> channel to 100% (vhost reaches 100%), the cpu where the application is
>>> located reaches 100%.
>>>
>>> This patch sends a small amount of data directly in wakeup. The purpose
>>> of this is to trigger the tx interrupt. The tx interrupt will be
>>> awakened on the cpu of its affinity, and then trigger the operation of
>>> the napi mechanism, napi can continue to consume the xsk tx queue. Two
>>> cpus are running, cpu0 is running applications, cpu1 executes
>>> napi consumption data. The same is to press a channel to 100%, but the
>>> utilization rate of cpu0 is 12.7% and the utilization rate of cpu1 is
>>> 2.9%.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>>    drivers/net/virtio/xsk.c | 28 +++++++++++++++++++++++-----
>>>    1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
>>> index 36cda2dcf8e7..3973c82d1ad2 100644
>>> --- a/drivers/net/virtio/xsk.c
>>> +++ b/drivers/net/virtio/xsk.c
>>> @@ -547,6 +547,7 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>>    {
>>>    	struct virtnet_info *vi = netdev_priv(dev);
>>>    	struct xsk_buff_pool *pool;
>>> +	struct netdev_queue *txq;
>>>    	struct send_queue *sq;
>>>
>>>    	if (!netif_running(dev))
>>> @@ -559,11 +560,28 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>>
>>>    	rcu_read_lock();
>>>    	pool = rcu_dereference(sq->xsk.pool);
>>> -	if (pool) {
>>> -		local_bh_disable();
>>> -		virtqueue_napi_schedule(&sq->napi, sq->vq);
>>> -		local_bh_enable();
>>> -	}
>>> +	if (!pool)
>>> +		goto end;
>>> +
>>> +	if (napi_if_scheduled_mark_missed(&sq->napi))
>>> +		goto end;
>>> +
>>> +	txq = netdev_get_tx_queue(dev, qid);
>>> +
>>> +	__netif_tx_lock_bh(txq);
>>> +
>>> +	/* Send part of the packet directly to reduce the delay in sending the
>>> +	 * packet, and this can actively trigger the tx interrupts.
>>> +	 *
>>> +	 * If no packet is sent out, the ring of the device is full. In this
>>> +	 * case, we will still get a tx interrupt response. Then we will deal
>>> +	 * with the subsequent packet sending work.
>>> +	 */
>>> +	virtnet_xsk_run(sq, pool, sq->napi.weight, false);
>>
>> This looks tricky, and it won't be efficient since there could be some
>> contention on the tx lock.
>>
>> I wonder if we can simulate the interrupt via IPI like what RPS did.
> Let me try.
>
>> In the long run, we may want to extend the spec to support interrupt
>> trigger though driver.
> Can we submit this with reset queue?


We need separate features. And it looks to me it's not as urgent as reset.

Thanks


>
> Thanks.
>
>> Thanks
>>
>>
>>> +
>>> +	__netif_tx_unlock_bh(txq);
>>> +
>>> +end:
>>>    	rcu_read_unlock();
>>>    	return 0;
>>>    }

