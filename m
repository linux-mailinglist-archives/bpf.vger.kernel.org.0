Return-Path: <bpf+bounces-77527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B0BCEA2CA
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431B930194D5
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A445321426;
	Tue, 30 Dec 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfuEmRU1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192F320CA7
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112140; cv=none; b=V5Fu2ylzvMVLPnw2RUVD+ElAqEtx/KrBzZ7e6wX7LwiWUPezdMeP+7Lnqt9ofx2+NYwjdHsRzy67MP9Tmh5e17W4RMl5uPkNzVOHTjrVDhu3e2Alzcoza/BxjtwUrdq6HL5JxxjqyTw7bVhb7BhNVy31POeh/wxzRKxDCH8hmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112140; c=relaxed/simple;
	bh=KKpqZbEtskgb5NBKeJlGWbLifno9PTy5moTyS5l7PDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPvEdoUOiZCZgGj4HYagzYOn0d3fTnrr+1g2qGl/0PKWh84mCJpKukqBQ/4e7oYcKo0T6RhzEw8Ow3FH+f03tsra/kPWqnuV4qiHDFZwIvJen9OvaUeSO2EUfbMDzvgzZ50oLFNydRTIWNdpPXF7Fk+6A8jT6bMNhs74qE0wvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfuEmRU1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f651586be1so4831752b3a.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767112138; x=1767716938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avaMKZupKtJgQKOisKq5Lh5/+7xstw6Aa+YwOZ+A+Sg=;
        b=GfuEmRU1fG637DEnYsbPDCCTXc/r5UNtEuBwx2pMEHH33LgxuwY4q+WJ5bZq5AsFXi
         MlffsCiiADNH7SHjMejf7MFFLutoKIMkBhnwGY4U0L5Nq24xbrZsUzmFYUSCNbWTl8ze
         /PyzO9MGFbSCKoF/gc2rg+j7/ITZKWsw9SK1SmlPGhVbIPDsOhXaGAWIcndFCWuuqdm8
         GJOCSHNKd0UwJcSMWvldthW+K6YnP3ATlrM/fTxIFPB88oo8SGH0qjtdLrLj0TZrctqv
         vlxxyiVOcUVXETUeWZvu5igrA4FECRH75XhwKIlOVpxo++xnuwotqsEP+bx1SAPMQUiT
         bxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112138; x=1767716938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avaMKZupKtJgQKOisKq5Lh5/+7xstw6Aa+YwOZ+A+Sg=;
        b=Pi1ER/XnTcIkpDZdzz6iZ/3mTHQsrNzbDdWqUpd0a9UvalJII1cFYmdXoQqTmqcaOg
         0g/LrcCQruTfkv8blUfpbAbuRDExJ+CNwTjsnykS1bOy+fklkpFgs31Dj8ZsM2naajSI
         pnOJeHodiJB1n8I+Ha7zIG75SnuO2LU1z17LaccuqbeQGKL0aFHwUFg/ODmrwO2jVbn+
         xpmz5WVluXzx1NK9WIjfBMPjZfNMfxHIoXIkO+6+JuKQsPScBs5eKplDGid1Pof1dU7E
         xTS/F+vZ6sWDcm9ZGKX7DN9ySTI5OitoNoDvdo0ODWqRs1eVCJucMlUW1Ue1s+avuVr+
         Z9Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXMxsS8xEHLspY50OdZCg0ORR+t2aQIcQ2i+SWTe3nCbkWSBLOJI21x0ecImArn/xM6KRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOcD4GhhI+bMhehhB4UrWsa4qz+0WMxvyHQKd9dcVhu9cG0mN
	GBlMfpgPm+Gx/yLQuNF6S9PMYcDIzUcmya78MtZvlGojK3RLfilfYPA74/vOQk1K
X-Gm-Gg: AY/fxX7mL0OWCKhGU57Q1Lmo5eKAWO1vshVqb+xMc0gY4YwrlMED6u3mTf/FJW0Dc+3
	67nuDpqkRyU5mk7vNkMlzZQ0m3yezwBlobLuhhU6QzajxiL072qK3eo5gNkkB+orIPURZbuw6s+
	ofqen78THDR1QiPuaDx97IjRC7mNA7yXfTHhUWk4VPn5r73kjqhgelI7iK2hbQ38h3VSsPtRlpC
	YXPciefnlPbDYU+wJinGNq5Gm33EaZt6UhmPn+zazE/gBXqxhsbZCThgS21XNZDGhjJp81zX+CJ
	jApVzC4Qz95qm78wUQ79sRMU1YIw1VBgC2HJps/O5ioVkwZU2CQ0KG5lpjdeyIjMe/ZgbaFAiH0
	tjpi7WirrJwD4o8Kh6t3XP9XoYSKNmwndr3C4KE/nVTc4p764QYDl/msji9xFiGc1B2WTrElBl+
	vrPKrxkudwqBJg8pI8qUA5m081AKns5w7nLJUagGf9sOe6bI7oXHzWBR+EILqJnPy+5zQxHRD2
X-Google-Smtp-Source: AGHT+IEeIFcn942167d2Oa9jA5JH71Kb7EInHlhV/HyENTzZnTajimLC14AMzvcWvH9NUqaWmckHDQ==
X-Received: by 2002:a05:6a20:1588:b0:366:14b0:4b18 with SMTP id adf61e73a8af0-3769ff1a89amr35543258637.35.1767112138052;
        Tue, 30 Dec 2025 08:28:58 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:f996:1f74:6f8f:2cf2? ([2001:ee0:4f4c:210:f996:1f74:6f8f:2cf2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm33010825b3a.11.2025.12.30.08.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 08:28:57 -0800 (PST)
Message-ID: <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
Date: Tue, 30 Dec 2025 23:28:50 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251226022727-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/26/25 14:37, Michael S. Tsirkin wrote:
> On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
>> On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
>>>> On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>>>>>> Hi Jason,
>>>>>>
>>>>>> I'm wondering why we even need this refill work. Why not simply let NAPI retry
>>>>>> the refill on its next run if the refill fails? That would seem much simpler.
>>>>>> This refill work complicates maintenance and often introduces a lot of
>>>>>> concurrency issues and races.
>>>>>>
>>>>>> Thanks.
>>>>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>>>>>
>>>>> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
>>>> Btw, I see some drivers are doing things as Xuan said. E.g
>>>> mlx5e_napi_poll() did:
>>>>
>>>> busy |= INDIRECT_CALL_2(rq->post_wqes,
>>>>                                  mlx5e_post_rx_mpwqes,
>>>>                                  mlx5e_post_rx_wqes,
>>>>
>>>> ...
>>>>
>>>> if (busy) {
>>>>           if (likely(mlx5e_channel_no_affinity_change(c))) {
>>>>                  work_done = budget;
>>>>                  goto out;
>>>> ...
>>>
>>> is busy a GFP_ATOMIC allocation failure?
>> Yes, and I think the logic here is to fallback to ksoftirqd if the
>> allocation fails too much.
>>
>> Thanks
>
> True. I just don't know if this works better or worse than the
> current design, but it is certainly simpler and we never actually
> worried about the performance of the current one.
>
>
> So you know, let's roll with this approach.
>
> I do however ask that some testing is done on the patch forcing these OOM
> situations just to see if we are missing something obvious.
>
>
> the beauty is the patch can be very small:
> 1. patch 1 do not schedule refill ever, just retrigger napi
> 2. remove all the now dead code
>
> this way patch 1 will be small and backportable to stable.

I've tried 1. with this patch

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..9e890aff2d95 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
  }

  static int virtnet_receive(struct receive_queue *rq, int budget,
-               unsigned int *xdp_xmit)
+               unsigned int *xdp_xmit, bool *retry_refill)
  {
      struct virtnet_info *vi = rq->vq->vdev->priv;
      struct virtnet_rq_stats stats = {};
@@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
          packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);

      if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-            spin_lock(&vi->refill_lock);
-            if (vi->refill_enabled)
-                schedule_delayed_work(&vi->refill, 0);
-            spin_unlock(&vi->refill_lock);
-        }
+        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+            *retry_refill = true;
      }

      u64_stats_set(&stats.packets, packets);
@@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
      struct send_queue *sq;
      unsigned int received;
      unsigned int xdp_xmit = 0;
-    bool napi_complete;
+    bool napi_complete, retry_refill = false;

      virtnet_poll_cleantx(rq, budget);

-    received = virtnet_receive(rq, budget, &xdp_xmit);
+    received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
      rq->packets_in_napi += received;

      if (xdp_xmit & VIRTIO_XDP_REDIR)
          xdp_do_flush();

      /* Out of packets? */
-    if (received < budget) {
+    if (received < budget && !retry_refill) {
          napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
          /* Intentionally not taking dim_lock here. This may result in a
           * spurious net_dim call. But if that happens virtnet_rx_dim_work
@@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)

      for (i = 0; i < vi->max_queue_pairs; i++) {
          if (i < vi->curr_queue_pairs)
-            /* Make sure we have some buffers: if oom use wq. */
-            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-                schedule_delayed_work(&vi->refill, 0);
+            /* If this fails, we will retry later in
+             * NAPI poll, which is scheduled in the below
+             * virtnet_enable_queue_pair
+             */
+            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

          err = virtnet_enable_queue_pair(vi, i);
          if (err < 0)
@@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
                  bool refill)
  {
      bool running = netif_running(vi->dev);
-    bool schedule_refill = false;

-    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-        schedule_refill = true;
+    if (refill)
+        /* If this fails, we will retry later in NAPI poll, which is
+         * scheduled in the below virtnet_napi_enable
+         */
+        try_fill_recv(vi, rq, GFP_KERNEL);
+
      if (running)
          virtnet_napi_enable(rq);
-
-    if (schedule_refill)
-        schedule_delayed_work(&vi->refill, 0);
  }

  static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
      struct virtio_net_rss_config_trailer old_rss_trailer;
      struct net_device *dev = vi->dev;
      struct scatterlist sg;
+    int i;

      if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
          return 0;
@@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
      }
  succ:
      vi->curr_queue_pairs = queue_pairs;
-    /* virtnet_open() will refill when device is going to up. */
-    spin_lock_bh(&vi->refill_lock);
-    if (dev->flags & IFF_UP && vi->refill_enabled)
-        schedule_delayed_work(&vi->refill, 0);
-    spin_unlock_bh(&vi->refill_lock);
+    for (i = 0; i < vi->curr_queue_pairs; i++)
+        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

      return 0;
  }


But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
the fill ring. So xsk_pool does not have any descriptors and
try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,

virtnet_xsk_pool_disable
-> virtnet_rq_bind_xsk_pool
   -> virtnet_rx_pause
     -> __virtnet_rx_pause
       -> virtnet_napi_disable
         -> napi_disable

We get stuck in napi_disable because the RX NAPI is still polling.

In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
(mlx5e_napi_poll) without using napi_disable/enable. However, in
drivers/net/ethernet/intel/ice,

ice_xsk_pool_setup
-> ice_qp_dis
   -> ice_qvec_toggle_napi
     -> napi_disable

it still uses napi_disable. Did I miss something in the above patch?
I'll try to look into using another synchronization instead of
napi_disable/enable in xsk_pool setup path too.

Thanks,
Quang Minh.


