Return-Path: <bpf+bounces-60190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD93AD3CF0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCED1794FE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F614248F6A;
	Tue, 10 Jun 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRlSM1rU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84324887A;
	Tue, 10 Jun 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568723; cv=none; b=FaP0ux71tEjCP698tfR9fslxWseZCFMLsX6rM7b+g1Ft8zDy0HlwZ3FXtG2FH9DUNQgE8hhEdVWrJvz1GaQjCV/UeBcXG6sBIyRmrKh7Y3jEqKhmYutgp9l6CStIjKHLxuX6cpwYS9TjYE1GqNnD//sklcSaIJjjPwMfsggTYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568723; c=relaxed/simple;
	bh=gOnIpi7jKT6E0yFvnngAH2TDUzwDY8Q0gWw1+BeaW+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3JNBkcZSMacdusBHamfZjGyRvQDFUF8Rgt1z3Bbxdi8rvIpLZ2OpH52hcOeS2h+qI49B/6mLgCHuuMV9WyKvZSpSbaomYKZdlUMHjo33NJJZbhZt4WogQKva4DhnMb/XecFFW9LPc+wCl02T1oObqhzKTsZZDlZ//C6nAVLK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRlSM1rU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313a188174fso677605a91.1;
        Tue, 10 Jun 2025 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568720; x=1750173520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hbx+bHktyO4/4VPvenmlBdgvye7zZKBy6tNsedw1riY=;
        b=GRlSM1rU3T53yAj33gXUbvE+HTYNND41ip1lf5mieUylJLXzuAnMcfDErS4szgS4gf
         QxRKt/av8bGxn0Qv14Mq2bQwB2OQ6aPWswa2dgsTQ+cnPGhGS8mPB0SSWV/yQHC/ibnR
         n+UJMSN9TV5tqoJPCiNgi5tzm9S254lJwMhP8Ub/CBxu2zY4uYewlZ267JDqoP4xL673
         1GQw2ACxXlxUhyQrL5OdVyt5fE+1cd137KgREZX3PeMpFOLfhOYjvLxceRBS+Y80UdyC
         xg3iyqjMDsT8eze/vsxJ6kML9ZjWpt7F8p8sb80xEujVnx2KMJL2inodANT4BBvZSA4e
         XzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568720; x=1750173520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hbx+bHktyO4/4VPvenmlBdgvye7zZKBy6tNsedw1riY=;
        b=pIx7BCtnG8WGtJ5jUo84qWj/uCdGE3r6KmKcqt7AGxaaKgMx+Yp4cqhWlQu09rlZBs
         6TvtU1nYrjH+XqOxOSFQpWwAMjCCKJlGvzBbYxeYx6D/cGRye/HODpBA9Qat5aw2BBc0
         Ael2jsK7q2r4ujN9MGs5c5+aD8MMmDEHREFW6EGkFsha/L9HB24Szt5mR8jHzvUbDUyf
         8pO4DdHqUzaHppg8xxgbar7qu8Exwk9ryU5rA20S757ZufOx4vyiiXmNvNF+tRq3mSdr
         zKM59LTBM8CD6kkU/eqhgBYrb3hz7RUH4s5UZsyE5m0Q4bnch4ZCtJW9L1qgzl9ViRck
         ju1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrc7qQiQbnTplaGwXj+qClCX/TKSAPgeVavoRInAlM7LVkmmTF3hFhPRAzYYOPksjFgSY=@vger.kernel.org, AJvYcCVgagnqlbefL1di3C5AXsvYw/XiL6RE5ytKP1HSXmBk1wIKAcIeQVxt18/xqGpCdYjcRkcIOYGC@vger.kernel.org, AJvYcCXWK/uNDQFF1mwPLVjzk9IZ/C9ByE1mgCGyDwDSbDdw8ce1eonxEP2SRIYhqgFkrRZPfy+b20Vx0f+jtnwV@vger.kernel.org, AJvYcCXX3BnByirBk65o1uNxQMQASCGiQiPmJ68Oqh8ZstSK0Giz1jjIKqvesqJWP55utIPkuwclAsc/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1v42WAYGtUJ7wKLGdEw1rOtgONGgrkQMOvOUN7GGXBfmrwZk
	utXx48lRi6jdPjyvhdpbagzcz4US9At8JeK9QeOMb8bo63tFR5VR1rQE
X-Gm-Gg: ASbGncsCREQzADC60kIiCWmqPBdHecW2iqeLG5PD37hNwzuhHpT8iLYkCYd/kwg0i1K
	q2/mfN8/40iEc4fxNRUWtznGV4XRf6w0EJH4HWA3QY4CUXuXE99Zc725TR96Oo45MN6ReUqKFHA
	nJOaJmkMZnnICP0gdo6vsaJaSVCZ5erc54oIXx5c8z3GJ7/5fQI9Quqs1uy/j307pUAJHPW6jWR
	c9zeKT5RMugEM/rd+rvyYqQPa2I+F32UX11ZJcaSDMbIObvd+VDaVXzezFdtFhmt2s9Q8UbWT+p
	4T1oU4ev6CoggXIMJ7aQi4SY79PF/k73qNWIE9o7wOPiVA9xp+CW1ZuYa7RKkh/BLH9AXW9NKwf
	a+36c1c9LeeffMlUy75XuO5prcPEkylr4wRdh6HXF
X-Google-Smtp-Source: AGHT+IFaLkJBXLMB5kRAXzQ6BTbGig21zU55qmOvpJ9RWPtjwP3TLdPuITWrEAgEHQ56jpCpm82CNQ==
X-Received: by 2002:a17:90a:dfd0:b0:30e:9b31:9495 with SMTP id 98e67ed59e1d1-3139e039a1dmr4917189a91.9.1749568720457;
        Tue, 10 Jun 2025 08:18:40 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:6df1:5935:37b2:fe6a? ([2001:ee0:4f0e:fb30:6df1:5935:37b2:fe6a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f17bd2sm7467484a91.5.2025.06.10.08.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:18:40 -0700 (PDT)
Message-ID: <e2de0cd8-6ee2-4dab-9d41-cfe5e85d796d@gmail.com>
Date: Tue, 10 Jun 2025 22:18:32 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
 <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
 <20250605074810.2b3b2637@kernel.org>
 <f073b150-b2e9-43db-aa61-87eee4755a2f@gmail.com>
 <20250609095824.414cffa1@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250609095824.414cffa1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:58, Jakub Kicinski wrote:
> On Fri, 6 Jun 2025 22:48:53 +0700 Bui Quang Minh wrote:
>>>> But currently, if a multi-buffer packet arrives, it will not go through
>>>> XDP program so it doesn't increase the stats but still goes to network
>>>> stack. So I think it's not a correct behavior.
>>> Sounds fair, but at a glance the normal XDP path seems to be trying to
>>> linearize the frame. Can we not try to flatten the frame here?
>>> If it's simply to long for the chunk size that's a frame length error,
>>> right?
>> Here we are in the zerocopy path, so the buffers for the frame to fill
>> in are allocated from XDP socket's umem. And if the frame spans across
>> multiple buffers then the total frame size is larger than the chunk
>> size.
> Is that always the case? Can the multi-buf not be due to header-data
> split of the incoming frame? (I'm not familiar with the virtio spec)

Ah, maybe I cause some confusion :) zerocopy here means zerocopy if the 
frame is redirected to XDP socket. In this zerocopy mode, XDP socket 
will provide buffers to virtio-net, the frame from vhost will be placed 
in those buffers. If the bind XDP program in virtio-net returns 
XDP_REDIRECT to that XDP socket, then the frame is zerocopy. In case 
XDP_PASS is returned, the frame's data is copied to newly created skb 
and the frame's buffer is returned to XDP socket. AFAIK, virtio-net has 
not supported header-data split yet.

>> Furthermore, we are in the zerocopy so we cannot linearize by
>> allocating a large enough buffer to cover the whole frame then copy the
>> frame data to it. That's not zerocopy anymore. Also, XDP socket zerocopy
>> receive has assumption that the packet it receives must from the umem
>> pool. AFAIK, the generic XDP path is for copy mode only.
> Generic XDP == do_xdp_generic(), here I think you mean the normal XDP
> patch in the virtio driver? If so then no, XDP is very much not
> expected to copy each frame before processing.

Yes, I mean generic XDP = do_xdp_generic(). I mean that we can linearize 
the frame if needed (like in netif_skb_check_for_xdp()) in copy mode for 
XDP socket but not in zerocopy mode.

>
> This is only slightly related to you patch but while we talk about
> multi-buf - in the netdev CI the test which sends ping while XDP
> multi-buf program is attached is really flaky :(
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-drv-hw&test=ping-py.ping-test-xdp-native-mb&ld-cases=1

metal-drv-hw means the NETIF is the real NIC, right?

Thanks,
Quang Minh.


