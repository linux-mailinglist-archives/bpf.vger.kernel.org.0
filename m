Return-Path: <bpf+bounces-59259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455CDAC768B
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D9F7ACCA8
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF2248897;
	Thu, 29 May 2025 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKVDvwIP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538B21E0AC;
	Thu, 29 May 2025 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490158; cv=none; b=paiw7NWCO58R5s5l0MxV4idtqcwHMKGxzOVzJi1hKZSRqbO4Epcsiugzo2DdJB2m1Z4QSekSkOB5pwJEusAgm/CzvzvLUSNuhcFwBGjzXZX5LSrtr12XBRcQ5qoxG0vBk5FH+F5hJlqNsuK3XiwQbbKYBzGjyWUXTRoTWiZhmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490158; c=relaxed/simple;
	bh=1oGqF+kLpE2T0HCkMCKtmAmdZ5GNX4oGFxPLWIQEJkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub5TpxBsfdg2XKgIz1VeI5MrJesf/smI7A3X6vL0t61ELaNY6tTmzE4hnQX92rVvPdVGKnQqBLXnfrLUQbRTIHjEIrEIDGXdZ4qUzzXJ4PqAilg/rVOUib3ixPRSC4PWNkFzCAdHRHykDkLatjEij2B86pd9uqx/njSnIhMZZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKVDvwIP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e033a3a07so6633485ad.0;
        Wed, 28 May 2025 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748490156; x=1749094956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGQ6gPvbs0cdDm4yHXwvrbROFKsQxn254OqSH+zgs90=;
        b=SKVDvwIPhY5SRAf3WrEqvnDZHnSz+jDKiovCNnjcTXVLXcVb/3TXxTrRzlbGaDBfcj
         faBLDrbo1tdK3pLB0jMvTuJgNwdT07PxU6/8KNM2RyX79QlkUZjwDZidPE/8YGcrW9XU
         zRlo9iIqhNcwen7l5aUSOBTjWJl9NlQh8vqrmfyzE6lpw1k5ZmzuZPYr6qnNhjw2S6gB
         VIrhEdCf09O23kYJr/mRN6yj1WtWOTEq2/KQKJHUSJWwpji9hc23Y+7t+5NbkvXddZa0
         CGXdseA/kBzog2vIa4GvKKTGIEtz894uJ2TARovnY/WY2eqeLMlGf/epbHyqSG/znJiQ
         +UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490156; x=1749094956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGQ6gPvbs0cdDm4yHXwvrbROFKsQxn254OqSH+zgs90=;
        b=v+qyEFKgSxHN4eyFUWRENM5WLKmV/fj+DXzxBQIEIgsvZ4h3h9gGfoY5njvbVmolwd
         AGgaMiAe7p+hXXcpYVvGcCLaANKb5kEJbK9B9vI8V9SvWDYJQR4EDmLQqPmhYaAWnai9
         LDrVI+toKUDlvQxOfvWL/t5etQAkeRpIQlW71azq+0yiICF46mRqpUC6eYSGHkwPjWLA
         9HXVh03gwgccChPJdVcyLI+EB5sEhsMInRO8UIo9nKsw0NxezsJzSlQrxrmM7rinB2eh
         rSf2ZPZCsavEubJQ0QPNkkBAnJsn/NtxCYKgVS8g7CEXJSQzbeLY2eB6eqj0o7KfS2d8
         S63g==
X-Forwarded-Encrypted: i=1; AJvYcCURxnHrC8V/TNvJZh8hvDRK4/zAi9qJ/XrXtenn3ciK51x9faicTOo3PfMb641EDObL4BUFOetSVu/eSWTi@vger.kernel.org, AJvYcCWib8q8DrXNP47zz67mdqo9otWuxGXvtGN5lQrZ6hcgnvxk5zwJoN82IvcOw+GCgzm0ip4=@vger.kernel.org, AJvYcCXIzBfJJTtFXtzxBbsD8PmRFE4TTP+R7MU2s7y60Je5U8gAc5QUP0O5YyFXmwN85sbPBMvTFg33@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qrnPVxkvnveNnMb7/9If4sdkwbOOOAx5PGFK0KVB2D6aCnUs
	IXNVLgGk0BNxeF82jsaENgLshQP9sUvwLDpK/TeLB1DKvg46tHOgz1kp
X-Gm-Gg: ASbGnctz4K6+WxYEQt9gGoGUL3gw+mDDiUFQuu0nOPmpirehi5SB4cpTwIIxDq/WlBf
	JXPwvtS0uzbrguMsK7Jo4ONMWJ5sgaBWC+lcYboxmIw3s6T6xRiTp3P0i4rZ8YYJNx0U0Sln/0U
	CkbBuM8JqQY2Z7S+iN3fXoU9e2dCVpwYzR9z3yZcu8oHWw61y83j/yqeGfcvBy74jxpsStZKcep
	By1kS86fqBYvQEI6CvJvuBf+t8t+q02SBHUMGzd2CjXBLzdWqh2sqhsHms/0ts4/Bw0lIo9+O4l
	8If/xAQ1c//OaRX8fM69NrcBP1itGCGCh2Na+Q+KeXa2Qd+ZgO5qb4Th4gSBQ8bM3AoGMP/fi8R
	e8fpUjrxD+9Wov3VqL5Q7qHqXkfA=
X-Google-Smtp-Source: AGHT+IGeJBpGKs8MTyCqIF7KiEXWtVJVhEgmHCJGR2AwCEysIcKML8h49AWwZtiK+qYj1P1TkFjW1g==
X-Received: by 2002:a17:903:32c7:b0:234:f580:9f8 with SMTP id d9443c01a7336-23507fda8edmr8895975ad.3.1748490156212;
        Wed, 28 May 2025 20:42:36 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:76aa:9d32:607:b042? ([2001:ee0:4f0e:fb30:76aa:9d32:607:b042])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235069fa2c7sm3485485ad.0.2025.05.28.20.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 20:42:35 -0700 (PDT)
Message-ID: <c75005c0-7e1a-48f0-b39b-b6310642ad4a@gmail.com>
Date: Thu, 29 May 2025 10:42:27 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
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
 <d855c95e-06db-4c68-af01-8997ce9b9257@oracle.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <d855c95e-06db-4c68-af01-8997ce9b9257@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/25 23:44, ALOK TIWARI wrote:
>
>
> On 27-05-2025 21:49, Bui Quang Minh wrote:
>> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
>> does not support multi buffer but a single buffer only. This commit adds
>> support for multi mergeable receive buffer in the zerocopy XDP path by
>> utilizing XDP buffer with frags.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
>>   1 file changed, 66 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..a9558650f205 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>>   #define VIRTIO_XDP_TX        BIT(0)
>>   #define VIRTIO_XDP_REDIR    BIT(1)
>>   +#define VIRTNET_MAX_ZC_SEGS    8
>> +
>>   /* RX packet size EWMA. The average packet size is used to 
>> determine the packet
>>    * buffer size when refilling RX rings. As the entire RX ring may 
>> be refilled
>>    * at once, the weight is chosen so that the EWMA will be 
>> insensitive to short-
>> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct 
>> net_device *dev,
>>       }
>>   }
>>   -static int xsk_append_merge_buffer(struct virtnet_info *vi,
>> -                   struct receive_queue *rq,
>> -                   struct sk_buff *head_skb,
>> -                   u32 num_buf,
>> -                   struct virtio_net_hdr_mrg_rxbuf *hdr,
>> -                   struct virtnet_rq_stats *stats)
>> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
>> +                      struct receive_queue *rq,
>> +                      u32 num_buf,
>> +                      struct xdp_buff *xdp,
>> +                      struct virtnet_rq_stats *stats)
>>   {
>> -    struct sk_buff *curr_skb;
>> -    struct xdp_buff *xdp;
>> -    u32 len, truesize;
>> -    struct page *page;
>> +    unsigned int len;
>>       void *buf;
>>   -    curr_skb = head_skb;
>> +    if (num_buf < 2)
>> +        return 0;
>> +
>> +    while (num_buf > 1) {
>> +        struct xdp_buff *new_xdp;
>>   -    while (--num_buf) {
>>           buf = virtqueue_get_buf(rq->vq, &len);
>> -        if (unlikely(!buf)) {
>> -            pr_debug("%s: rx error: %d buffers out of %d missing\n",
>> -                 vi->dev->name, num_buf,
>> -                 virtio16_to_cpu(vi->vdev,
>> -                         hdr->num_buffers));
>> +        if (!unlikely(buf)) {
>
> if (unlikely(!buf)) { ?

Thanks, I'll fix this in the next version.

>
>> +            pr_debug("%s: rx error: %d buffers missing\n",
>> +                 vi->dev->name, num_buf);
>>               DEV_STATS_INC(vi->dev, rx_length_errors);
>
> Thanks,
> Alok


