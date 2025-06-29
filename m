Return-Path: <bpf+bounces-61805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E8AECB73
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 07:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23EC518994E1
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 05:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679151DDA15;
	Sun, 29 Jun 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMSqAJAU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC940BF5;
	Sun, 29 Jun 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751175077; cv=none; b=fWXG4Ihovfz+1uBPLKvSrpAKcA2ypFRmZgiKa6Uxsj+xUsq3ZVTKBquyeUOATnkzwyr2txyRVe/3EfoLTjTIK8hULgMUTdX6LL2DIdAzr96Uha7BWzHCX+sON793njoAOME9G++E56iCC+tmZifLdYtQshKmFpTUTatutyLpk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751175077; c=relaxed/simple;
	bh=ETOpPQhKUGbb3m1DQNXZ9d1API2efLKRSgFfw3wjXYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+2KghDc2Ou4GX2myjryngDUXiNqzVkco6BzY2v/wgsQbAxaq01f6jsFmCPN69cbisF3zphRudZ0yqwoLq/ZCTC3S2hL+17K+WIA5JGhvPXNJuWAxAFoKlC8OQ1K0zMoRn128+kj/0N5r9V02a8SHnM3hDxV4duWA68WTK/TcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMSqAJAU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b34a8f69862so1089186a12.2;
        Sat, 28 Jun 2025 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751175074; x=1751779874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KxQw+8wrv6WHqC8EiMCQt88wHvecAR5EAJYKEAI9aQ=;
        b=jMSqAJAUBjP/nfinIh9SMcf36rg5zUxHFHAYzeW3TvNgk0EBjCEmCw+lrc0ZpiqCBT
         iWWWwTS4Fta7Q5+HUNitu9mmn2cujl5D50+oCKV5ryvQ7fAK1qtpp1eXudFB+Q1axHJM
         6zS8Z0+LC1wQKPPF4N5ItEgxV0gF7SopjAAELpm9Q9bxONndAIrIwWSNzaPvroh51rv4
         u3tnqIhj97vIFhC5p+ldMqO6bZ09DLSu0jeQfvFy0LXHBgOTPQH2IikrlPpx1G87GiG6
         J5ony19EYjcwfxRsrEzV5mEpqWzXfHupOGN3pl0/97WwF/bp4Mt+2qK4FPSubvPi5MBK
         wzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751175074; x=1751779874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KxQw+8wrv6WHqC8EiMCQt88wHvecAR5EAJYKEAI9aQ=;
        b=AhoNv7AXEwnRju8CgE/ImKqzRjo8jiePu92e2n83Ed1dMnv6Rj8TizCT81lM8150ql
         3yzGpyZoPbXM6Ms6zxVQHIcAgvd2pu34n3ZT1AZEuAA9FeoLbCsGvZeU+JwBfgzvGaPd
         oNdWhQ7nV7Yp0WfpPf2mExdE8zLpGcvutwqvIxhdVigt6Ooo5byownUvb4n89PzLbW1i
         FoeUpw54PVt8+QjLz5h1S7V6Cl0iMBnyLFT1Do253CFseznPvPxbaaZu4SC0JyAW0t+e
         S8R/J31fFFFe5zjLBaLHqN0/OcTANi1IbFXFc9eSJmMMrX4SdK+Zlnynk7okwSu+9HSs
         w9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUgILvvIHGFWO12qFeqKYvUe35tpqU36OyC5k8BThKxYmQghyJrQUj7Q0Zc9wfo2Km5cWA4OQKu@vger.kernel.org, AJvYcCWqle11UdvkZ0p0wysWrNk4RKZo4F4stNOXTb5w0XG6bfr7gfD58tPWgY1oh5oOxiJGcflRy4+ZaqkN2eRs@vger.kernel.org, AJvYcCXn351xr/6lCNX0bxhg9Sr4rjmoYiP5I0SINk7xjRlO37YswKmiFB4IoDe7wyeVl6j4Rjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7qaazX/KCH95X/pfO60adSJfQv4ycXjessoD42zeggNkvaNk
	usfqmM69MJb1DFwL6ZcL+sMxrjd0wTS5Zk/Qd/BIQRqowBAn+p7muFj26QgUiA==
X-Gm-Gg: ASbGncsyZmaT1PJZcLT14jhFhf9usEX6KA663UzDJbbCDoFe2O7fQEKmGB3nsRQ1ray
	ximu2NBLWjESVKmHecb/ERDjqjN9TGiQooehN/fbnR/Yc5ATX3PMNmC8HX3mq35frj1nIR+JB79
	sBFzgBNoJxhyKLfl6B8Kp87uRMd7CG3ER+SEjvOkz2sWBcwdPQQW4mRo2151LMzZaCOfacOOlUX
	PFryWXTdM7mhFrEnmXqfMcNbMbYpRQbh4f4833hWpkU0GQWLcRgPCq9q6VKvpDp5FnWpvKXc7x+
	9Va3yX0SgSkrqL5Pf9pThupGxY9+p1oLy+GbSkOc1voy90ktjXruDyz6IMMc20VAl5MPbXslmXQ
	S/gHeuZl3iJ+KvU3nskNxmDdDhepRQpTwlKaxcmpv
X-Google-Smtp-Source: AGHT+IEVZEItwhAmpQ7qT5rj0OSH/4b+v0bHuKzDVzS/4Qq/q+fKX3xbk/96CMChuM4cXxPSEAR6mA==
X-Received: by 2002:a17:90b:4c89:b0:312:29e:9ec9 with SMTP id 98e67ed59e1d1-318c92ee68dmr14182999a91.24.1751175073661;
        Sat, 28 Jun 2025 22:31:13 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:6051:fd69:c29f:10f6? ([2001:ee0:4f0e:fb30:6051:fd69:c29f:10f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54414acsm10901024a91.47.2025.06.28.22.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 22:31:13 -0700 (PDT)
Message-ID: <c207a343-7e08-4a2f-9163-2d64dd47d906@gmail.com>
Date: Sun, 29 Jun 2025 12:31:07 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-3-minhquangbui99@gmail.com>
 <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 17:17, Paolo Abeni wrote:
> On 6/21/25 4:49 PM, Bui Quang Minh wrote:
>> This commit does not do any functional changes. It moves xdp->data
>> adjustment for buffer other than first buffer to buf_to_xdp() helper so
>> that the xdp_buff adjustment does not scatter over different functions.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1eb237cd5d0b..4e942ea1bfa3 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>>   		return NULL;
>>   	}
>>   
>> -	xsk_buff_set_size(xdp, len);
>> +	if (first_buf) {
>> +		xsk_buff_set_size(xdp, len);
>> +	} else {
>> +		/* This is the same as xsk_buff_set_size but with the adjusted
>> +		 * xdp->data.
>> +		 */
>> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
>> +		xdp->data -= vi->hdr_len;
>> +		xdp->data_meta = xdp->data;
>> +		xdp->data_end = xdp->data + len;
>> +		xdp->flags = 0;
>> +	}
>> +
>>   	xsk_buff_dma_sync_for_cpu(xdp);
>>   
>>   	return xdp;
>> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>   			goto err;
>>   		}
>>   
>> -		memcpy(buf, xdp->data - vi->hdr_len, len);
>> +		memcpy(buf, xdp->data, len);
>>   
>>   		xsk_buff_free(xdp);
>>   
> I'm unsure if this change is in the right direction because it almost
> open-code the existing xsk_buff_set_size() helper - any changes there
> should be reflected here, too.

I've found out that there is xdp_prepare_buff helper which gives more 
control over the headroom so it can be used here. I'll update in the 
next version.

Thanks,
Quang Minh.


