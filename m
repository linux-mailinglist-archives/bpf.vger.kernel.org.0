Return-Path: <bpf+bounces-61680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D369AEA2C3
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585835A4F7B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA12ED172;
	Thu, 26 Jun 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHKj+7o7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D22EB5CA;
	Thu, 26 Jun 2025 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952087; cv=none; b=SKcOLbs9vXUwB57qzA736zGOAU1Nk4I644/uW9FDYn1j0Zk2uNiQsNItPmFRHE2ULTQEwkP1+DhIkyIh85EyLhqV9EZjV6x5KTBMjDlz5q66/7rvAp3Li+4iWfTijEC3/W/EozpRbIqkjUZfBrLTbO0GPT5ZWthJ+PF1maYjoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952087; c=relaxed/simple;
	bh=z64R6tLwT/igY0srnTmDc4NO29MbjXUBGb8NdSHwt+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpyKZ4m9kCCQjW9QNEai78niOwjhDBT6PpeUk1IGkO81IVoTqN7NrsLFcnDIjdyXy1kO1J2ZKNVxbjp147gd3WsGWPoYbtBvObTrEz9yrDeGE7/OT3mbC1SN1OOxVhT35ITeRQB4awzYfjRtM1XvpadlI7R5BbrHcKDwNdeG6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHKj+7o7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23602481460so13886435ad.0;
        Thu, 26 Jun 2025 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952085; x=1751556885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kmmnms/Q/5n/J94E9RpKr+/e7+IT4/vH9W0izU+rtE0=;
        b=cHKj+7o714uR+A4Xfb3oUb8F5PVMBUmgMMb8FZvXL+3m5gQb2uXq9b5DVE2EzwewGc
         AgeXv/OmA49W8QwhsSxiEmJZfxIHSuY73QoQ0thOSRTIAJO+NmOiZO3S7fmY0G5kpTVs
         HeejmfNtyh81YHUS/Ac0D6YZoAM1xT7DzCFUnTpNb+HgkX6+CSA/CLkdDseG65WDCcs2
         SRL8TtNUWUHW1AnruXj7YqyUd/u4/2zQnfakAhnqm5TW2CUQm76RYgxkUFunoi5OmEb8
         w7NgcghbVsJmeP+WdVzJDRu5mpDAMX4djOQyWO3v5kE1WZplaYwu3e4xO+LRFT1JPPp1
         7Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952085; x=1751556885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmmnms/Q/5n/J94E9RpKr+/e7+IT4/vH9W0izU+rtE0=;
        b=Am2gTxoBr2ERWXb5PrEvM/1aZQUVAWZBAJdOPoSb713qzsC5IurSOZxHklhmOzbf+p
         biPxjDT0J9NLq6+Tg8rJAcfU0m/7FDCxQ7mbugIdUmxmpB2Bk4KexUWYTfg5EQdi8cWn
         YaNCGMnCvnCUxdNLU+G0lxgcJK/Y2Jf3pRFPKjfGjNRFbNLFlrG/Wmz7wQND4W7NE6JY
         kKx3nazrOykZrIUzHuzqtJW2bOuBO9uCoLaoFX14yWiGvNJY9rBvChuS4Zr9VeL+9p/R
         RKfYIlJRP+OcYSypDDdXZa8NzG2Ss+TVsnsGoSEODsxxR6CwRPJXwES8f6yn11RZz+rS
         lE/w==
X-Forwarded-Encrypted: i=1; AJvYcCVOlZQyxGnCryYoXlmbEz808PCaZ1DedSLElPQcSUlp3IqDa2XLOtwbFitKVftClshyzsMbjWwt5jxJkvAu@vger.kernel.org, AJvYcCVhyPbQp5Vxqokd0SnlzJkl+NmoDaO51Nr2ouqeSK2LqrR9wK0IMiJR9NuowvUK5dGPNkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2bopZNCfrdQfEjQG0IupfRyRKD1FBIJa3ib0MkzN7uroD9W7
	E8ca40xR4+zipto+C6vsTfzN3tc1wXQ+g7YT/CvhCT2DiP9tT2qwTlsO
X-Gm-Gg: ASbGncvqhAJ4u1AAJ8SR7BZkBYN++hCwBj60FOf1T+4xnuSkJ5zmEibyv2V2fFps1Jp
	Au0N40JbdkGjwIr7NG5duBGwbP8WNUtCF50swod8DuIq5eXtzklVI+EtjlIPPor5a/QIfev7X9W
	V0mj55mkkO2rVlMk3J5ZP9tjJdPr3OqqLMhtJ+KkiNC7n50hTjuOOZfJEJKBAbSBmYLDSDq6eOc
	U3Px7iAmbycd8DUGJ27ef0Z7wSUIYAWZ24meeIlTF9EgD4FnBhqhG51wZjT0dqRqsR2OohPMykm
	hj4RqPwf+FcO/IisoxSlcMMtZWEx1iCXjW8SlXu2cdfJIjaGu30SYwXmF7QyRxYUNZiRaYAYMsk
	3cr6M2NOf2yZ3I2vclwKpazu7WxCA/W/zL/35CF+I
X-Google-Smtp-Source: AGHT+IEBro7NaKKN1SAi+5I/Ua/Xx0H51iguRiKyeGlRJfzrEBuaCq+4+1hrclw+rac7IKJnr/e9og==
X-Received: by 2002:a17:903:1986:b0:235:f49f:479d with SMTP id d9443c01a7336-238c86ee14amr53330745ad.3.1750952084612;
        Thu, 26 Jun 2025 08:34:44 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1? ([2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe440a69sm799565ad.242.2025.06.26.08.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:34:44 -0700 (PDT)
Message-ID: <0bf0811e-cdb8-4410-9b69-1c38b06bbadf@gmail.com>
Date: Thu, 26 Jun 2025 22:34:35 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-2-minhquangbui99@gmail.com>
 <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/25 09:34, Jason Wang wrote:
> On Thu, Jun 26, 2025 at 12:10 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> In xdp_linearize_page, when reading the following buffers from the ring,
>> we forget to check the received length with the true allocate size. This
>> can lead to an out-of-bound read. This commit adds that missing check.
>>
>> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> I think we should cc stable.

Okay, I'll do that in next version.

>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..2a130a3e50ac 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
>>    * across multiple buffers (num_buf > 1), and we make sure buffers
>>    * have enough headroom.
>>    */
>> -static struct page *xdp_linearize_page(struct receive_queue *rq,
>> +static struct page *xdp_linearize_page(struct net_device *dev,
>> +                                      struct receive_queue *rq,
>>                                         int *num_buf,
>>                                         struct page *p,
>>                                         int offset,
>> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>>          page_off += *len;
>>
>>          while (--*num_buf) {
>> -               unsigned int buflen;
>> +               unsigned int headroom, tailroom, room;
>> +               unsigned int truesize, buflen;
>>                  void *buf;
>> +               void *ctx;
>>                  int off;
>>
>> -               buf = virtnet_rq_get_buf(rq, &buflen, NULL);
>> +               buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
>>                  if (unlikely(!buf))
>>                          goto err_buf;
>>
>>                  p = virt_to_head_page(buf);
>>                  off = buf - page_address(p);
>>
>> +               truesize = mergeable_ctx_to_truesize(ctx);
> This won't work for receive_small_xdp().

If it is small mode, the num_buf == 1 and we don't get into the while loop.

>
>> +               headroom = mergeable_ctx_to_headroom(ctx);
>> +               tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>> +               room = SKB_DATA_ALIGN(headroom + tailroom);
>> +
>> +               if (unlikely(buflen > truesize - room)) {
>> +                       put_page(p);
>> +                       pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>> +                                dev->name, buflen,
>> +                                (unsigned long)(truesize - room));
>> +                       DEV_STATS_INC(dev, rx_length_errors);
>> +                       goto err_buf;
>> +               }
> I wonder if this issue only affect XDP should we check other places?

In small mode, we check the len with GOOD_PACKET_LEN in receive_small. 
In mergeable mode, we have some checks over the place and this is the 
only one I see we miss. In xsk, we check inside buf_to_xdp. However, in 
the big mode, I feel like there is a bug.

In add_recvbuf_big, 1 first page + vi->big_packets_num_skbfrags pages. 
The pages are managed by a linked list. The vi->big_packets_num_skbfrags 
is set in virtnet_set_big_packets

     vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS : 
DIV_ROUND_UP(mtu, PAGE_SIZE);

So the vi->big_packets_num_skbfrags can be fewer than MAX_SKB_FRAGS.

In receive_big, we call to page_to_skb, there is a check

     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
         /* error case */
     }

But because the number of allocated buffer is 
vi->big_packets_num_skbfrags + 1 and vi->big_packets_num_skbfrags can be 
fewer than MAX_SKB_FRAGS, the check seems not enough

     while (len) {
         unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
                 frag_size, truesize);
         len -= frag_size;
         page = (struct page *)page->private;
         offset = 0;
     }

In the following while loop, we keep running based on len without NULL 
check the pages linked list, so it may result into NULL pointer dereference.

What do you think?

Thanks,
Quang Minh.

>
>> +
>>                  /* guard against a misconfigured or uncooperative backend that
>>                   * is sending packet larger than the MTU.
>>                   */
>> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>                  headroom = vi->hdr_len + header_offset;
>>                  buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>>                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> -               xdp_page = xdp_linearize_page(rq, &num_buf, page,
>> +               xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
>>                                                offset, header_offset,
>>                                                &tlen);
>>                  if (!xdp_page)
>> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>           */
>>          if (!xdp_prog->aux->xdp_has_frags) {
>>                  /* linearize data for XDP */
>> -               xdp_page = xdp_linearize_page(rq, num_buf,
>> +               xdp_page = xdp_linearize_page(vi->dev, rq, num_buf,
>>                                                *page, offset,
>>                                                XDP_PACKET_HEADROOM,
>>                                                len);
>> --
>> 2.43.0
>>


