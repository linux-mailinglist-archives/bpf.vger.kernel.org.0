Return-Path: <bpf+bounces-55509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D181A81D8A
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 08:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABE81B883EA
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5F213E60;
	Wed,  9 Apr 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMotCh9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5B212B1B;
	Wed,  9 Apr 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181755; cv=none; b=S5rDiQWbAmTNW8CfrAxtV354JTEvUE+mi2HyZkPt0YqhssoHfUinH0Nni5oxZytId9hvGNlMAjzw1xlJs3lW1T6sBZeZbRBYdZN223nXIMaep7/SMrKtVvSEpgv5gqu0NcUwke1l6xmFFFNyzGFIxCN0kN6kM7E3Tpkvn+hr8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181755; c=relaxed/simple;
	bh=OqC3v9Gphs/qwzgAJtXvKZfDCpF4ZGPS2GOM3FmsfrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzEUVfsM1vDrF5kd/ICEkWgKmibrbhxJXU9hJRFMYv/wmpVWCijRFTbgJghHawzbATKOCpsl9TERlKsr8TSNdVSMjRyH44PfnVz9ejsSuOQqtDCmJ6OLwkkeE1DUqJWGt9WqH5Pj8UnflUj3B0FARiULW5Kr+YlY9tC7w9QYXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMotCh9k; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af55b7d56a1so4618912a12.2;
        Tue, 08 Apr 2025 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744181753; x=1744786553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Co6gQM2wtA55c6R6TA7F5Fe1d0+w5yIt8c2Cnbe3qs=;
        b=GMotCh9kIimQeIGAx/IdswaTuT7+Zf5I2l2rn4ZL956QbBSCwIaffBXYdxrBGSySHe
         jorNWdTPhyDPqCph6UebjXNdj2RdE4g3nRXqn1qlrcgB44kMvheLPL9KqXlXxXNyhnA6
         r9zK7kQEV2bdbkBl3JyFmRrgTvW1hlG7aAc8NYzKCqqfoWwBwK5Elmw+5HhFwKmvIbmJ
         eUvilm4aKla5CgRjdAi6+8mw5YoJoMrtPJMEoLPDHPIrNJqnFTQMZ8fYBAwjwwIUaK2t
         ERQ7xSv9PvgcfBKH8NEOm08jY+B8Tn9XROGoDokl0L0OciG/jzbYSQ/jIiux/+AuGQ+R
         KqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181753; x=1744786553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Co6gQM2wtA55c6R6TA7F5Fe1d0+w5yIt8c2Cnbe3qs=;
        b=nKFfpdWbR8v8eNgPtYEUAt0ZIhLSucYRy13icmj2mg9F/948W+qe/GI0CtoZG86v4m
         cWRd5/baVtd6v7PpjYvJ1gEamhYDrvTIKAmOkB1Nug8VjCzEcdE7CdmEcTx7vrGEPR29
         sKhiIxdpkeHe/7uDxnEqeUEhP6JIePcp6wlgkx3dDN2oNA9RtuYiXk4bC3EObUBnhWQ1
         lxpT88HQD6utbhNh1smWwuPKuT+hRTy6G4j+H/VGmvo4gV4WO19GpBnA14wklCaMJ7sr
         gBedckY6bxNTJRmq8SjnbZIwk5j4S6sabvcQMj61SIPzrjTl9cbzPKYIVHdUEg75DIsZ
         izXw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Z172xDMy/Hu3JzV60Vn6fvoQ5uixdUcvvwMhwDuaTuU2nSrkdZ8Bx9gFuJZlGDXqSCuOuKWS@vger.kernel.org, AJvYcCU75AOQxy/c7qgD2cKRTZaEIhESpIXs2oPQoP6/4OqUHCF/7v0Tqv6X/f5csx4dbHHcjSY=@vger.kernel.org, AJvYcCW+pgBL245DNzVMhVwJE34Loj4lSjt7XHvV2EVlyDO7Ph2gXp2Iy10BTI9F63Ui0qk7uSHlatSjTp4X6oYX@vger.kernel.org
X-Gm-Message-State: AOJu0Yymwqk7azf40CmTfIv6uB5Z6pdy2SuNILTFKq0hfjxfFiS+WOhZ
	T//hbZAVYxdBWpq3EjYn/9jjsUALASMxEZYM9WCqHl0gsXf+/pZk
X-Gm-Gg: ASbGnctR1F395odJyuGwnAqC5i+s31pjtsv2ZxHdMWlEdGQepJiJHTmO7Ku1xSISdah
	oBbDx3ZZzDT/wEaoyq+zukCebxZLufHPPD2hdzgAp9O9aYZ0a/FMw3LPRZH9+K0vZMqnuUO3UPm
	IaZmogMLFqyKUjk17+tvZFiPsa3gnPTzK2V4EvXOQk6+E80mkflPngdr7mT/VusAT2X1hKAcdcK
	YkP7zccy+zZPbuclfxt3c4WSydr+5S5eCnBaH0/yAzlVATRnV2yX9dkgVZIohqz/hR4RangZqgC
	LlvGW+Dz9RNkwuLKqwy8YUa1AlCOr/JGiTA8E1TXi8Z73vZ6Aw==
X-Google-Smtp-Source: AGHT+IEFL/RkO95k+Uctmsp/HTB9p2W38kSipc4AhjUtOz8zgzH7KRoyrtOfhT8hIBTAFqPJi8hqKw==
X-Received: by 2002:a05:6a20:c6c8:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-201591ceb04mr2970714637.24.1744181753017;
        Tue, 08 Apr 2025 23:55:53 -0700 (PDT)
Received: from [192.168.0.118] ([14.169.40.45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf374asm505349a12.26.2025.04.08.23.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:55:52 -0700 (PDT)
Message-ID: <58b84867-086e-44f7-86b1-c1759bbc2009@gmail.com>
Date: Wed, 9 Apr 2025 13:55:45 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <1b78c63b-7c07-4d25-8785-bfb0e28c71ad@redhat.com>
 <20250408073709.4e054636@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250408073709.4e054636@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/25 21:37, Jakub Kicinski wrote:
> On Tue, 8 Apr 2025 11:28:54 +0200 Paolo Abeni wrote:
>>>> When napi_disable is called on an already disabled napi, it will sleep
>>>> in napi_disable_locked while still holding the netdev_lock. As a result,
>>>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>>>> This leads to refill_work and the pause-then-resume tx are stuck altogether.
>>> This needs to be added to the chagelog. And it looks like this is a fix for
>>>
>>> commit 413f0271f3966e0c73d4937963f19335af19e628
>>> Author: Jakub Kicinski <kuba@kernel.org>
>>> Date:   Tue Jan 14 19:53:14 2025 -0800
>>>
>>>      net: protect NAPI enablement with netdev_lock()
>>>
>>> ?
>>>
>>> I wonder if it's simpler to just hold the netdev lock in resize or xsk
>>> binding instead of this.
>> Setting:
>>
>> 	dev->request_ops_lock = true;
>>
>> in virtnet_probe() before calling register_netdevice() should achieve
>> the above. Could you please have a try?
> Can we do that or do we need a more tailored fix? request_ops_lock only
> appeared in 6.15 and the bug AFAIU dates back to 6.14. We don't normally
> worry about given the stream of fixes - request_ops_lock is a bit risky.
> Jason's suggestion AFAIU is just to wrap the disable/enable pairs in
> the lock. We can try request_ops_lock in -next ?
>
> Bui Quang Minh, could you add a selftest for this problem?
> See tools/testing/selftests/drivers/net/virtio_net/
> You can re-use / extend the XSK helper from
> tools/testing/selftests/drivers/net/xdp_helper.c ?
> (move it to tools/testing/selftests/net/lib for easier access)

I've just tried the current selftests and found out that the queues.py 
can trigger the deadlock.

Running this a few times (the probability is quite high) on the guest 
with virtio-net interface
~ NETIF=enp0s2 ./ksft-net-drv/run_kselftest.sh -t drivers/net:queues.py

The test hangs.

I've got the hung task warning

[  363.841549]  #0: ffff88800015c758 
((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x1a9/0x3c9
[  363.841560]  #1: ffffc90000043e28 
((work_completion)(&pool->work)){+.+.}-{0:0}, at: 
process_scheduled_works+0x1c2/0x3c9
[  363.841570]  #2: ffffffff81f5a150 (rtnl_mutex){+.+.}-{4:4}, at: 
rtnl_lock+0x1b/0x1d
[  363.841579]  #3: ffff8880035e49f0 (&dev->lock){+.+.}-{4:4}, at: 
netdev_lock+0x12/0x14
[  363.841587] 3 locks held by kworker/2:0/26:
[  363.841589]  #0: ffff88800015c758 
((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x1a9/0x3c9
[  363.841598]  #1: ffffc900000f7e28 
((work_completion)(&(&vi->refill)->work)){+.+.}-{0:0}, at: 
process_scheduled_works+0x1c2/0x3c9
[  363.841608]  #2: ffff8880035e49f0 (&dev->lock){+.+.}-{4:4}, at: 
netdev_lock+0x12/0x14

~ cat /proc/7/stack
[<0>] netdev_lock+0x12/0x14
[<0>] napi_enable+0x1a/0x35
[<0>] virtnet_napi_do_enable+0x1a/0x40
[<0>] virtnet_napi_enable+0x32/0x4a
[<0>] virtnet_rx_resume+0x4f/0x56
[<0>] virtnet_rq_bind_xsk_pool+0xd8/0xfd
[<0>] virtnet_xdp+0x6d3/0x72d
[<0>] xp_disable_drv_zc+0x5a/0x63
[<0>] xp_clear_dev+0x1d/0x4a
[<0>] xp_release_deferred+0x24/0x75
[<0>] process_scheduled_works+0x23e/0x3c9
[<0>] worker_thread+0x13f/0x1ca
[<0>] kthread+0x1b2/0x1ba
[<0>] ret_from_fork+0x2b/0x40
[<0>] ret_from_fork_asm+0x11/0x20

~ cat /proc/26/stack
[<0>] napi_disable_locked+0x41/0xaf
[<0>] napi_disable+0x22/0x35
[<0>] refill_work+0x4b/0x8f
[<0>] process_scheduled_works+0x23e/0x3c9
[<0>] worker_thread+0x13f/0x1ca
[<0>] kthread+0x1b2/0x1ba
[<0>] ret_from_fork+0x2b/0x40
[<0>] ret_from_fork_asm+0x11/0x20

The deadlock was caused by a race between xsk unbind and refill_work.


Thanks,
Quang Minh.


