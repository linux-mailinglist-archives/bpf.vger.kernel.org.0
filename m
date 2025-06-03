Return-Path: <bpf+bounces-59507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F0ACC900
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C7116814B
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296423957D;
	Tue,  3 Jun 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdLG3Qc4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4451422DD;
	Tue,  3 Jun 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960563; cv=none; b=my63g5vesMS2/uv/sFdi8dM2w0OBHhum/8vPEktnjQwGZ497LZay7EMNkN66/xMfGkqQ5WozZEEH+I0Wg/ra0/WIrprorf5O87wuHqcEFAhoaf5jsxHbx6/xdN98+fObhK52wE9NUP7/7QYquAOchhkbVXqqu3OmL11lBGrAm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960563; c=relaxed/simple;
	bh=NFXvWV9RWBcgb8+zVHGoZH/qYrQ9xMEZs7k/wpqfV/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifXo7QsI7VsXkZM+bygwQa+RIQx2LQUTZxi1rVMNtNlVMS9GLXwRyWUBmdZxtuyq0oV0HdkO8qSNsd4JMPlTAVgxpol/nYgVkewlt6n92eoakcww4KZR2sqb3Jz3Ndznzv+46qBg7kRxSx6H6EXOj9Z5P1s3Fo8ot7z+PLzK7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdLG3Qc4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22d95f0dda4so70349875ad.2;
        Tue, 03 Jun 2025 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748960561; x=1749565361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUxo3xHjSYhzhZohzXIdAjJ/KXmJOJii3aOTP1KR6Wo=;
        b=mdLG3Qc40qNJENBaoVA3piTb90U7nB8UwFRKD3RVXlU6l3kZTHSpyL5QTqG/TlMxjC
         s2siKEEX8H7SGz0ObCmGHA+CDyAtb791hd4R4r3nMML+oD67Xk03zDv2yjykll0/hZhQ
         u1tcRLXvy16swmuPzeTB7OnxMjRBAkYDaKqW8rdLYky59RI10+fbDRC2FGyyO6Wq5/Bg
         NwSAlyPAw9sSdlkENXp2phN07EvEkzUqMeu3R/SprcqDvvHkqxAcVu6MoF3xa+J99cun
         1cfMShSmJTQ7qKjDt+Ge5YsNQaEXxvEvqT02ZPvAniUk88v100wlf6QKlvXgkXvEB/bJ
         xRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960561; x=1749565361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUxo3xHjSYhzhZohzXIdAjJ/KXmJOJii3aOTP1KR6Wo=;
        b=ZL25tt0Z+EN0hp5kww9Y7c/1Wp5/zkioNhw57XqdIkky/1Q0FS7ZEViCwZXZ2IA11v
         NlDb24RMJi4z6P3AxAFd3Et2S6mY4nncMEGVfc3/yRJbAWQZYk8w/0cTGLlM3Abxotx6
         ZNdxIJuXf9ASV1OKLOmjtiWNw6G9kI/p5jRHhNZe3mnrB44KrgyGbd7ahsfURu1jhec7
         ACMAP4HQ9SQNyS26ObfJTwgwmGfYNp3UCQVMOoo0ulkPTbOlIVKs9seEU3SWFWFh/9E2
         F2wQJjNl2reQzXszvSrebJejdAOzxEAmqGCsivWjAa2gNzU/N9M8MaRwO3jW/FFZNKbP
         DE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMj8IxAkwV81dGSfUI3wCuMwRuZt1cLp8WJ7yXvq922VL4mejHo1DZa7gIQufyHnu9x3Tf61tVAe/C0/bj@vger.kernel.org, AJvYcCVqk9/JqyVINzZN7pUjjmk8CkuKZJXuodqMJRDqpbMosHiOo8coYspr5ZmsORNjQy08XB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwbG8LD0zlf8MKZZxTNzJiHlAEjWCisaNPTefEuVOoHIpYRfF
	4aAB40QZqZZQ0U+nmVoBYX3gioR6smSQA2m9eJeHW5YmvSgaXhknxAcQyNMk5w==
X-Gm-Gg: ASbGnct8KPvFe7B3IUUFDvPgCr20F36EcSCHVybxu3WhZuYaQE6TH/3FphF4rX75HS1
	JjFAoAMRo69OEX/1FSgkzayJXh8OOhZYYLPTL0+Tmf0sWHuNGeqOn9tbtkdlWfV5jWBOhk16da1
	GH7ns9Fm+9el57/ySP1fKAVIgyyBBQGrYegJQXB+9sAI3ISAh+4lYW4oMNw9+vEt8pK20uIfzYZ
	2py54rTEeVo9epr+LFtXmKUawf+XptCjmGU523hpuAmZk3o70gH5B/xLQEV2QquqfCqIT8mfAKU
	FaETD9kXmdx8rpu3VQwL4eBai9fCZBc4hVxAT3HKHP9uqMdaD0D54GKi/YUWdKnJI3d4r+pl+YS
	dYm5z4GIRlIjTmjvlDiz73TuW//f4Y1WQkpphSmRX
X-Google-Smtp-Source: AGHT+IHuU2IQcCkyR9YUQBf2e7OEXed4fgtZEkA3a1UZp9Ak3QKx5+ndMj0g0cVkD1MKjg4OwjLOlg==
X-Received: by 2002:a17:902:ce83:b0:234:ed31:fcae with SMTP id d9443c01a7336-235291ee55bmr282385605ad.22.1748960559991;
        Tue, 03 Jun 2025 07:22:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:c672:ef11:a97b:5717? ([2001:ee0:4f0e:fb30:c672:ef11:a97b:5717])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d142cfsm87818655ad.211.2025.06.03.07.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:22:39 -0700 (PDT)
Message-ID: <87bd6ce0-f900-433b-908c-a77fe85e300b@gmail.com>
Date: Tue, 3 Jun 2025 21:22:32 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-2-minhquangbui99@gmail.com>
 <CACGkMEvAJziO3KW3Nk9+appXmR92ixcTeWY_XEZz4Qz1MwrhYA@mail.gmail.com>
 <d572e8b6-e25c-480e-9d05-8c7eeb396b12@gmail.com>
 <CACGkMEvBPaqXxnmNqZAbAbYFh=9gONva+dpouAeW-sd1pzK58Q@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvBPaqXxnmNqZAbAbYFh=9gONva+dpouAeW-sd1pzK58Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/25 09:56, Jason Wang wrote:
> On Thu, May 29, 2025 at 8:28 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 5/29/25 12:59, Jason Wang wrote:
>>> On Wed, May 28, 2025 at 12:19 AM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
>>>> does not support multi buffer but a single buffer only. This commit adds
>>>> support for multi mergeable receive buffer in the zerocopy XDP path by
>>>> utilizing XDP buffer with frags.
>>>>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
>>>>    1 file changed, 66 insertions(+), 57 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index e53ba600605a..a9558650f205 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>>>>    #define VIRTIO_XDP_TX          BIT(0)
>>>>    #define VIRTIO_XDP_REDIR       BIT(1)
>>>>
>>>> +#define VIRTNET_MAX_ZC_SEGS    8
>>>> +
>>>>    /* RX packet size EWMA. The average packet size is used to determine the packet
>>>>     * buffer size when refilling RX rings. As the entire RX ring may be refilled
>>>>     * at once, the weight is chosen so that the EWMA will be insensitive to short-
>>>> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_device *dev,
>>>>           }
>>>>    }
>>>>
>>>> -static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>>> -                                  struct receive_queue *rq,
>>>> -                                  struct sk_buff *head_skb,
>>>> -                                  u32 num_buf,
>>>> -                                  struct virtio_net_hdr_mrg_rxbuf *hdr,
>>>> -                                  struct virtnet_rq_stats *stats)
>>>> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
>>>> +                                     struct receive_queue *rq,
>>>> +                                     u32 num_buf,
>>>> +                                     struct xdp_buff *xdp,
>>>> +                                     struct virtnet_rq_stats *stats)
>>>>    {
>>>> -       struct sk_buff *curr_skb;
>>>> -       struct xdp_buff *xdp;
>>>> -       u32 len, truesize;
>>>> -       struct page *page;
>>>> +       unsigned int len;
>>>>           void *buf;
>>>>
>>>> -       curr_skb = head_skb;
>>>> +       if (num_buf < 2)
>>>> +               return 0;
>>>> +
>>>> +       while (num_buf > 1) {
>>>> +               struct xdp_buff *new_xdp;
>>>>
>>>> -       while (--num_buf) {
>>>>                   buf = virtqueue_get_buf(rq->vq, &len);
>>>> -               if (unlikely(!buf)) {
>>>> -                       pr_debug("%s: rx error: %d buffers out of %d missing\n",
>>>> -                                vi->dev->name, num_buf,
>>>> -                                virtio16_to_cpu(vi->vdev,
>>>> -                                                hdr->num_buffers));
>>>> +               if (!unlikely(buf)) {
>>>> +                       pr_debug("%s: rx error: %d buffers missing\n",
>>>> +                                vi->dev->name, num_buf);
>>>>                           DEV_STATS_INC(vi->dev, rx_length_errors);
>>>> -                       return -EINVAL;
>>>> -               }
>>>> -
>>>> -               u64_stats_add(&stats->bytes, len);
>>>> -
>>>> -               xdp = buf_to_xdp(vi, rq, buf, len);
>>>> -               if (!xdp)
>>>> -                       goto err;
>>>> -
>>>> -               buf = napi_alloc_frag(len);
>>>> -               if (!buf) {
>>>> -                       xsk_buff_free(xdp);
>>>> -                       goto err;
>>>> +                       return -1;
>>>>                   }
>>>>
>>>> -               memcpy(buf, xdp->data - vi->hdr_len, len);
>>>> -
>>>> -               xsk_buff_free(xdp);
>>>> +               new_xdp = buf_to_xdp(vi, rq, buf, len);
>>>> +               if (!new_xdp)
>>>> +                       goto drop_bufs;
>>>>
>>>> -               page = virt_to_page(buf);
>>>> +               /* In virtnet_add_recvbuf_xsk(), we ask the host to fill from
>>>> +                * xdp->data - vi->hdr_len with both virtio_net_hdr and data.
>>>> +                * However, only the first packet has the virtio_net_hdr, the
>>>> +                * following ones do not. So we need to adjust the following
>>> Typo here.
>> I'm sorry, could you clarify which word contains the typo?
>>
>>>> +                * packets' data pointer to the correct place.
>>>> +                */
>>> I wonder what happens if we don't use this trick? I meant we don't
>>> reuse the header room for the virtio-net header. This seems to be fine
>>> for a mergeable buffer and can help to reduce the trick.
>> I don't think using the header room for virtio-net header creates this
>> case handling. In my opinion, it comes from the slightly difference in
>> the recvbuf between single buffer and multi-buffer. When we have n
>> single-buffer packets, each buffer will have its own virtio-net header.
>> But when we have 1 multi-buffer packet (which spans across n buffers),
>> only the first buffer has virtio-net header, the following buffers do not.
>>
>> There 2 important pointers here. The pointer we announce to the vhost
>> side to fill the data, let's call it announced_addr, and xdp_buff->data
>> which is expected to point the the start of Ethernet frame. Currently,
>>
>>       announced_addr = xdp_buff->data - hdr_len
>>
>> The host side will write the virtio-net header to announced_addr then
>> the Ethernet frame's data in the first buffer. In case of multi-buffer
>> packet, in the following buffers, host side writes the Ethernet frame's
>> data to the announced_addr no virtio-net header. So in the virtio-net,
>> we need to subtract xdp_buff->data, otherwise, we lose some Ethernet
>> frame's data.
>>
>> I think a slightly better solution is that we set announced_addr =
>> xdp_buff->data then we only need to xdp_buff->data += hdr_len for the
>> first buffer and do need to adjust xdp_buff->data of the following buffers.
> Exactly my point.
>
>>>> +               new_xdp->data -= vi->hdr_len;
>>>> +               new_xdp->data_end = new_xdp->data + len;
>>>>
>>>> -               truesize = len;
>>>> +               if (!xsk_buff_add_frag(xdp, new_xdp))
>>>> +                       goto drop_bufs;
>>>>
>>>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>>>> -                                                   buf, len, truesize);
>>>> -               if (!curr_skb) {
>>>> -                       put_page(page);
>>>> -                       goto err;
>>>> -               }
>>>> +               num_buf--;
>>>>           }
>>>>
>>>>           return 0;
>>>>
>>>> -err:
>>>> +drop_bufs:
>>>>           xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
>>>> -       return -EINVAL;
>>>> +       return -1;
>>>>    }
>>>>
>>>>    static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
>>>> @@ -1307,23 +1297,42 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>>>>           num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>>>>
>>>>           ret = XDP_PASS;
>>>> +       if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
>>>> +               goto drop;
>>>> +
>>>>           rcu_read_lock();
>>>>           prog = rcu_dereference(rq->xdp_prog);
>>>> -       /* TODO: support multi buffer. */
>>>> -       if (prog && num_buf == 1)
>>>> -               ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>>> Without this patch it looks like we had a bug:
>>>
>>>           ret = XDP_PASS;
>>>           rcu_read_lock();
>>>           prog = rcu_dereference(rq->xdp_prog);
>>>           /* TODO: support multi buffer. */
>>>           if (prog && num_buf == 1)
>>>                   ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>>>           rcu_read_unlock();
>>>
>>> This implies if num_buf is greater than 1, we will assume XDP_PASS?
>> Yes, I think XDP_DROP should be returned in that case.
> Care to post a patch and cc stable?

Okay, I'll submit a patch shortly.

Thanks,
Quang Minh.

>
>>>> +       if (prog) {
>>>> +               /* We are in zerocopy mode so we cannot copy the multi-buffer
>>>> +                * xdp buff to a single linear xdp buff. If we do so, in case
>>>> +                * the BPF program decides to redirect to a XDP socket (XSK),
>>>> +                * it will trigger the zerocopy receive logic in XDP socket.
>>>> +                * The receive logic thinks it receives zerocopy buffer while
>>>> +                * in fact, it is the copy one and everything is messed up.
>>>> +                * So just drop the packet here if we have a multi-buffer xdp
>>>> +                * buff and the BPF program does not support it.
>>>> +                */
>>>> +               if (xdp_buff_has_frags(xdp) && !prog->aux->xdp_has_frags)
>>>> +                       ret = XDP_DROP;
>>> Could we move the check before trying to build a multi-buffer XDP buff?
>> Yes, I'll fix this in next version.
>>
>>>> +               else
>>>> +                       ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
>>>> +                                                 stats);
>>>> +       }
>>>>           rcu_read_unlock();
>>>>
>>>>           switch (ret) {
>>>>           case XDP_PASS:
>>>> -               skb = xsk_construct_skb(rq, xdp);
>>>> +               skb = xdp_build_skb_from_zc(xdp);
>>> Is this better to make this change a separate patch?
>> Okay, I'll create a separate patch to convert the current XDP_PASS
>> handler to use xdp_build_skb_from_zc helper.
> That would be better.
>
>>>>                   if (!skb)
>>>> -                       goto drop_bufs;
>>>> +                       break;
>>>>
>>>> -               if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
>>>> -                       dev_kfree_skb(skb);
>>>> -                       goto drop;
>>>> -               }
>>>> +               /* Later, in virtnet_receive_done(), eth_type_trans()
>>>> +                * is called. However, in xdp_build_skb_from_zc(), it is called
>>>> +                * already. As a result, we need to reset the data to before
>>>> +                * the mac header so that the later call in
>>>> +                * virtnet_receive_done() works correctly.
>>>> +                */
>>>> +               skb_push(skb, ETH_HLEN);
>>>>
>>>>                   return skb;
>>>>
>>>> @@ -1332,14 +1341,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>>>>                   return NULL;
>>>>
>>>>           default:
>>>> -               /* drop packet */
>>>> -               xsk_buff_free(xdp);
>>>> +               break;
>>>>           }
>>>>
>>>> -drop_bufs:
>>>> -       xsk_drop_follow_bufs(dev, rq, num_buf, stats);
>>>> -
>>>>    drop:
>>>> +       xsk_buff_free(xdp);
>>>>           u64_stats_inc(&stats->drops);
>>>>           return NULL;
>>>>    }
>>>> @@ -1396,6 +1402,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>>>                   return -ENOMEM;
>>>>
>>>>           len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>>> +       /* Reserve some space for skb_shared_info */
>>>> +       len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>>
>>>>           for (i = 0; i < num; ++i) {
>>>>                   /* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
>>>> @@ -6734,6 +6742,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>           dev->netdev_ops = &virtnet_netdev;
>>>>           dev->stat_ops = &virtnet_stat_ops;
>>>>           dev->features = NETIF_F_HIGHDMA;
>>>> +       dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
>>>>
>>>>           dev->ethtool_ops = &virtnet_ethtool_ops;
>>>>           SET_NETDEV_DEV(dev, &vdev->dev);
>>>> --
>>>> 2.43.0
>>>>
>>> Thanks
>>>
> Thanks
>


