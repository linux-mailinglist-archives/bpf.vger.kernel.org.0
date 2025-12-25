Return-Path: <bpf+bounces-77441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D18CDDE8A
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 16:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED2F301275B
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC532D450;
	Thu, 25 Dec 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfmRrSd6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE8824BD
	for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766678144; cv=none; b=FxLw4gexwsd2SWxvSxGYP2RCgcGFa+o++musyPzm7jiVftoAlm49FC8KQUpqRsIMlcELwhBCCD7vaO8HiPzfrQcxl0kny339WnRIrmVud8SNghcjljh+e8N6xKxfRbDvzc6L7AV7KtWGezozocBINaZJDDIZtNOEYAj7xQNclvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766678144; c=relaxed/simple;
	bh=DgG95W0KWoWtUbCoxucc6TeEUsImaF4Yq6XZDFST7nU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sff73BeP+KeMycBY943HAh+yKYCUTFeTcx+gbwbIbA0RSFeERAFqdTsMSg8GvRqF5cqAZpQwLt4RMnK3s4H2GKWjb5J9am1Z4cOZBi+SuKNbLdNmZBcFX6lDN1XXyErz7z0FDo/OTI2HzC1kDDrUSWhq1a/5xatEIIYUxt0mtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfmRrSd6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f102b013fso82258235ad.2
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766678142; x=1767282942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hYaWKXWkYbIN4q4wZN9wEW98pBsJkuu1pUVxbOWJvx0=;
        b=XfmRrSd6C83afEl9dmiyKzl0oIlBpBIn9dUE9Mi853GtLtDhBdx3jwMyTYTY9+rAbk
         RZPUVUGDZmHYVebdO4WK63S+uSJ1K4d59+0vxA8loD98SOh4jAWIZEh2kk+Mkvkvi+vJ
         8IC/L7Loijf3Qbh1cYj2Y6LyqJirBEJbQ9Jr0ct9516yiW/gfs8avib9rAWxYfyKyPuQ
         BN/lsilC1dRPVCNpsvxQfMdBR0QW9f4sYlCA+ApOHKTLNIhvcoLm0AFkFpiwQN13zNhm
         tjP6DYAs/bUBOQGVFxKNs1BXc4QiUWdx+vzeHepripnrwJ1Gd97M24+boPYAYPDG9eSG
         X4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766678142; x=1767282942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYaWKXWkYbIN4q4wZN9wEW98pBsJkuu1pUVxbOWJvx0=;
        b=tLU7inzwotv9ATM/PvJdWkTThKgQsnu2/KB3NjXSDig5kcjn4TweW9m7vKtz7ZYjZZ
         JUfCKadt06G6p1eLRW7LTPOE6upfB/d/0Mp0QQG+qTXoArMi0793Dr5G4gNPF5MCTJTv
         QVI0Dtml8aP5eoltpEOwEY2q9TdTswb5HXWkEPrLpFdkdE8r8d69a45dSRcBxdrUfRV1
         80wZ+Svlz67CCsXFQZghI9ZJ8jlM3KC6HYVEG9cuUw0Js1akJ8OrGHmrXyJRf9Tj6H3Y
         4r0mES6M1tCZMdv1xEU1/xXreBSlPYEzQ2OBLZH9814DSMDNGFm2zEMdG4HN0zp7qLro
         sr8A==
X-Forwarded-Encrypted: i=1; AJvYcCWl+uvI0zTUxCXIJE//0nxyusZod3ln2Lg26cLJjkxKSNCCKS/owKF/WJ5hNLeJ1nQ3yaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQqqbhk7SZg5NYvN6SfD4CigMMoe48b+OITvQGLHuza4BNKN0
	Yss+RoFr33RzXQacjB3JOkcwF5QE8RXOyVkkIUQkQYs9l0+eNAUrpiQr
X-Gm-Gg: AY/fxX7R1DRGY/6vswQ3ANYQweCH242OoNiiDbaHhc6ABh6wSjmw53cUDtkTy4eDZJQ
	Hd9DpEHobAdk6XYdTyV5oikxk8lxxCfYq0r3hkyYzLN1T0u+niWNnw9cPZMDGG+A5C17LgtwqvL
	woPaChokYPuIXsTUV10G1MNLrT9IH5C7JLupKMnaddXq054v4STV3x93+kRhJZwIZ09NL8QOyP/
	hm3WnYB4XNRv9mnkesX0LtIHfwt5cWieEVp7TM4x/XBivZYM07d3STK6VmcXa1SZd1pY0wwNuQa
	y37ZfsNnIWLKi5/NKbm4yYpzR7oRKyHDLDZc0929OFTgdF+W3AqptWCgdG3ChlDHYAd8lxgU06E
	Td4M8MsJSc2XpqZ5uOJmOF0pOdnseF9wnf3/y5bRaCuSC88ebsOIkFKQ36yGZQwLNs9O+DYOTZE
	dDShxkhyLsPnkWAxMFnbOqYYI6n0asbvpSzzXG1g346wZLM4ac2X0H+fD6UKxnHA==
X-Google-Smtp-Source: AGHT+IFjaNIMrol5SdAN856m9AmK7B5O/amLAW7CnntJVFYaTER95zxgN8oN1gQDiGKwdhTwQiVC5Q==
X-Received: by 2002:a17:902:da48:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2a2f2a4f5acmr169647525ad.50.1766678142511;
        Thu, 25 Dec 2025 07:55:42 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:77e8:13fb:83fb:4ed6? ([2001:ee0:4f4c:210:77e8:13fb:83fb:4ed6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c839b7sm185337805ad.37.2025.12.25.07.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 07:55:42 -0800 (PST)
Message-ID: <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
Date: Thu, 25 Dec 2025 22:55:36 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
 <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Content-Language: en-US
In-Reply-To: <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 23:49, Bui Quang Minh wrote:
> On 12/24/25 08:47, Michael S. Tsirkin wrote:
>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>>> Hi Jason,
>>>
>>> I'm wondering why we even need this refill work. Why not simply let 
>>> NAPI retry
>>> the refill on its next run if the refill fails? That would seem much 
>>> simpler.
>>> This refill work complicates maintenance and often introduces a lot of
>>> concurrency issues and races.
>>>
>>> Thanks.
>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>>
>> And if GFP_ATOMIC failed, aggressively retrying might not be a great 
>> idea.
>>
>> Not saying refill work is a great hack, but that is the reason for it.
>
> In case no allocated received buffer and NAPI refill fails, the host 
> will not send any packets. If there is no busy polling loop either, 
> the RX will be stuck. That's also the reason why we need refill work. 
> Is it correct?

I've just looked at mlx5e_napi_poll which is mentioned by Jason. So if 
we want to retry refilling in the next NAPI, we can set a bool (e.g. 
retry_refill) in virtnet_receive, then in virtnet_poll, we don't call 
virtqueue_napi_complete. As a result, our napi poll is still in the 
softirq's poll list, so we don't need a new host packet to trigger 
virtqueue's callback which calls napi_schedule again.
>
> Thanks,
> Quang Minh.
>
>


