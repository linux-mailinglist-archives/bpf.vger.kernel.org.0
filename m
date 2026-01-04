Return-Path: <bpf+bounces-77787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998DCF115D
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 15:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D5E3027A78
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A3227EB9;
	Sun,  4 Jan 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0YGU+9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F23FF1
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767538479; cv=none; b=i1J7F3ZgriEYMH+4/VVRiBW+LtH3xnrQWSjhOHgYzFWdjZ5oKellYLdQCE+IEfxxDJgax+jcW75bUXyO6NParsD3LST/EdpccWexo1YNKTHwD3U5ilMl/Z/FPAu6jpygF9mE8ADJxkipdcIx8hdMwf7cV3YEXEQT0o7Nlm7SEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767538479; c=relaxed/simple;
	bh=QHN1ZqjNUwWomcgwFcWsm6frTHBvJPBAwHRGJXWsHIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMogSiso9AX7V952qeN9Dt37Np8z/L5suEtdhtyOnEsi9CGR7niRPaxvFOoBRhzUhJ8uyC9nL7zhIC9J4GwCShrQ/h033/QWzavdDuCWe9hu/HFTIImHS+ZwVCuzkxcJCoA6wyKMfm9LkdXw7D5JI7FDv7bkgzWriQaKjsg+Phw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0YGU+9k; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d67f1877so175590825ad.2
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767538477; x=1768143277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWDmkLu9ILzlZftYSOtoNsctqqGAHzf9VuIaMeoe6w8=;
        b=c0YGU+9k7s0AER3VnzhvB3GL6iP7TE+Rz6NT9pTsXhVZakAECh850aeXrTWCOf9EeH
         TosuV2fKPHPP5gAoxN55p37Ifi1WrzKS0LTRN1he13L6oj+0aNa3Z9nlVLq30y96xV/G
         Uues4ONH7w3ru9saLRVzm9aQ4BihTdMITTmqSbc/AaYoGtKtUiDVsxxZoCXOT9ynTeG/
         wOrtth5DFAA4ZV535/xm5EdmIb/bSPe0s1/gLrcBg8yhnItKxRSnny1F6ntCevVIJ/a1
         ItDq/dtbA+q7yWGKkQFPlmbDI0SPe4Y979oIwv78iij3WF5fli2uXojYaktUTvIja5Op
         M4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767538477; x=1768143277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWDmkLu9ILzlZftYSOtoNsctqqGAHzf9VuIaMeoe6w8=;
        b=C+iopgZQ6n3v8YLz4Qu/kn/zK0wPfnQkXIMGjvKo0/XUyNG5ms8l9bWMfbRvs2bMh5
         emU8tV9dthmn4qf1123h6gfmQ8pPrZkNXM5dStgjcYCC6ns92HoYwYI/yf7LvP6cKgHC
         4i+OmWSdUN+m7Qn9z9Dh+y7IjjeHz/B0tRPiksrY6qhZNpCfB7vB8l3IGgRwv/rnzB+K
         1UMKBEXuiJBBd44Y52OSctKaaoEs2b8qetBZkG8LecCnpe0rS/6P8WL+x2qy7nfkij1u
         aqq82yOsioaqiuhnFYxywodSPNtKq8AtPHhJTF+/aTvqvfJpPYQMmyKXNccboskRSi72
         WsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6wEpjbpYEujkurLTKYX2PLH2wzVpMrWnN9C3C7zOmfgpgqp/50+BWgM/MT3BtTwp3vRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiTshCX5ZnzBl+JUX3fk+qpuiLH4dKNUwoWpLbbv6k0nDaHkp
	PBBlTjYcY3RHxe5ZvO3jMpPh1JlzUBKhvGDYaNkhJA4IdicfPkUAeXEK
X-Gm-Gg: AY/fxX6BpiN2Jfr0Gt96VxbusnrkDZ11OlyxtHdqRVBWDHTIKvzSG+BwhrFYJ7DbpIR
	a7YKDNUVG0hnb7qOoh/uHZS0oNnL2W6ShGgCf5FCdguBAvV2qw+nRp10Wtm8ELig0mPIc5hxPkt
	+UZ4o75spWcEBCzZm2Jipch6GpvKR5BnpKb4UNvkP7dHErW0Vw6dJq6natLOtM1+1azrhEFvWFk
	uAABhw8JBV3JsuS1usFAHO/TnGoH8cZXJpneqjqbqvO0GchowfK8No954BP79AkutIsa41wL+vt
	+SDD6e5rAi/kH5gMPhfe0Jym7cKJrGMa3Q3gXGkKxB+QAjnqdkVhoAzquNEYOVcrNzlDnM7/9mL
	Y5lJSZ+LSyP2rAmGbD50j+Sn1N5qYc8AxQ1kjj7XNiT7cqaGzkm4/DY9v988hFV/ks4uByRn7Uh
	fkkcZfZPUw7uvqWM+q9j/Na1FoHZWQQ2AovOz15p49ANVQo5vguIOLbmhaU0OOjw==
X-Google-Smtp-Source: AGHT+IGuMhR4yV7wEQecdGQSH+gBCn0UHCgS5wCeYyxyHeZyL43DWyqhUZBw+deIGGOk+5wM573WzA==
X-Received: by 2002:a17:902:ce87:b0:2a0:a8c3:5f0c with SMTP id d9443c01a7336-2a2f2214a65mr443185735ad.16.1767538477329;
        Sun, 04 Jan 2026 06:54:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:179f:3939:5dff:9686? ([2001:ee0:4f4c:210:179f:3939:5dff:9686])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm421414765ad.5.2026.01.04.06.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 06:54:36 -0800 (PST)
Message-ID: <f4ac3940-d99c-4f63-bab3-cc68731fc9f1@gmail.com>
Date: Sun, 4 Jan 2026 21:54:30 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <CACGkMEs9wCM8s4_r1HCQGj9mUDdTF+BqkF0rse+dzB3USprhMA@mail.gmail.com>
 <6bac1895-d4a3-4e98-8f39-358fa14102db@gmail.com>
 <20260104085846-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260104085846-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 21:03, Michael S. Tsirkin wrote:
> On Sun, Jan 04, 2026 at 03:34:52PM +0700, Bui Quang Minh wrote:
>> On 1/4/26 13:09, Jason Wang wrote:
>>> On Fri, Jan 2, 2026 at 11:20 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> When we fail to refill the receive buffers, we schedule a delayed worker
>>>> to retry later. However, this worker creates some concurrency issues
>>>> such as races and deadlocks. To simplify the logic and avoid further
>>>> problems, we will instead retry refilling in the next NAPI poll.
>>>>
>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>>>>    1 file changed, 30 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 1bb3aeca66c6..ac514c9383ae 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>>>>    }
>>>>
>>>>    static int virtnet_receive(struct receive_queue *rq, int budget,
>>>> -                          unsigned int *xdp_xmit)
>>>> +                          unsigned int *xdp_xmit, bool *retry_refill)
>>>>    {
>>>>           struct virtnet_info *vi = rq->vq->vdev->priv;
>>>>           struct virtnet_rq_stats stats = {};
>>>> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>>>                   packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>>>
>>>>           if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>>>> -               if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>>>> -                       spin_lock(&vi->refill_lock);
>>>> -                       if (vi->refill_enabled)
>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>> -                       spin_unlock(&vi->refill_lock);
>>>> -               }
>>>> +               if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>>>> +                       *retry_refill = true;
>>>>           }
>>>>
>>>>           u64_stats_set(&stats.packets, packets);
>>>> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>>>           struct send_queue *sq;
>>>>           unsigned int received;
>>>>           unsigned int xdp_xmit = 0;
>>>> -       bool napi_complete;
>>>> +       bool napi_complete, retry_refill = false;
>>>>
>>>>           virtnet_poll_cleantx(rq, budget);
>>>>
>>>> -       received = virtnet_receive(rq, budget, &xdp_xmit);
>>>> +       received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>>> I think we can simply let virtnet_receive() to return the budget when
>>> reill fails.
>> That makes sense, I'll change it.
>>
>>>>           rq->packets_in_napi += received;
>>>>
>>>>           if (xdp_xmit & VIRTIO_XDP_REDIR)
>>>>                   xdp_do_flush();
>>>>
>>>>           /* Out of packets? */
>>>> -       if (received < budget) {
>>>> +       if (received < budget && !retry_refill) {
>>>>                   napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>>>>                   /* Intentionally not taking dim_lock here. This may result in a
>>>>                    * spurious net_dim call. But if that happens virtnet_rx_dim_work
>>>> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>>>                   virtnet_xdp_put_sq(vi, sq);
>>>>           }
>>>>
>>>> -       return received;
>>>> +       return retry_refill ? budget : received;
>>>>    }
>>>>
>>>>    static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>>>> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>>>>
>>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>                   if (i < vi->curr_queue_pairs)
>>>> -                       /* Make sure we have some buffers: if oom use wq. */
>>>> -                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>> +                       /* If this fails, we will retry later in
>>>> +                        * NAPI poll, which is scheduled in the below
>>>> +                        * virtnet_enable_queue_pair
>>>> +                        */
>>>> +                       try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>> Consider NAPI will be eventually scheduled, I wonder if it's still
>>> worth to refill here.
>> With GFP_KERNEL here, I think it's more likely to succeed than GFP_ATOMIC in
>> NAPI poll. Another small benefit is that the actual packet can happen
>> earlier. In case the receive buffer is empty and we don't refill here, the
>> #1 NAPI poll refill the buffer and the #2 NAPI poll can receive packets. The
>> #2 NAPI poll is scheduled in the interrupt handler because the #1 NAPI poll
>> will deschedule the NAPI and enable the device interrupt. In case we
>> successfully refill here, the #1 NAPI poll can receive packets right away.
>>
> Right. But I think this is a part that needs elucidating, not
> error handling.
>
> /* Pre-fill rq agressively, to make sure we are ready to get packets
>   * immediately.
>   * */
>
>>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>>                   if (err < 0)
>>>> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>>>                                   bool refill)
>>>>    {
>>>>           bool running = netif_running(vi->dev);
>>>> -       bool schedule_refill = false;
>>>>
>>>> -       if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>>>> -               schedule_refill = true;
>>>> +       if (refill)
>>>> +               /* If this fails, we will retry later in NAPI poll, which is
>>>> +                * scheduled in the below virtnet_napi_enable
>>>> +                */
>>>> +               try_fill_recv(vi, rq, GFP_KERNEL);
>>> and here.
>>>
>>>> +
>>>>           if (running)
>>>>                   virtnet_napi_enable(rq);
> here the part that isn't clear is why are we refilling if !running
> and what handles failures in that case.

You are right, we should not refill when !running. I'll move the if 
(refill) inside the if (running).

>
>>>> -
>>>> -       if (schedule_refill)
>>>> -               schedule_delayed_work(&vi->refill, 0);
>>>>    }
>>>>
>>>>    static void virtnet_rx_resume_all(struct virtnet_info *vi)
>>>> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>           struct virtio_net_rss_config_trailer old_rss_trailer;
>>>>           struct net_device *dev = vi->dev;
>>>>           struct scatterlist sg;
>>>> +       int i;
>>>>
>>>>           if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>>>                   return 0;
>>>> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>           }
>>>>    succ:
>>>>           vi->curr_queue_pairs = queue_pairs;
>>>> -       /* virtnet_open() will refill when device is going to up. */
>>>> -       spin_lock_bh(&vi->refill_lock);
>>>> -       if (dev->flags & IFF_UP && vi->refill_enabled)
>>>> -               schedule_delayed_work(&vi->refill, 0);
>>>> -       spin_unlock_bh(&vi->refill_lock);
>>>> +       if (dev->flags & IFF_UP) {
>>>> +               /* Let the NAPI poll refill the receive buffer for us. We can't
>>>> +                * safely call try_fill_recv() here because the NAPI might be
>>>> +                * enabled already.
>>>> +                */
>>>> +               local_bh_disable();
>>>> +               for (i = 0; i < vi->curr_queue_pairs; i++)
>>>> +                       virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
>>>> +
>>>> +               local_bh_enable();
>>>> +       }
>>>>
>>>>           return 0;
>>>>    }
>>>> --
>>>> 2.43.0
>>>>
>>> Thanks
>>>
>> Thanks,
>> Quang Minh.


