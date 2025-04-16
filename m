Return-Path: <bpf+bounces-56032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7EA8B4A0
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4133ABC47
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B8234966;
	Wed, 16 Apr 2025 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJbmPB5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E020E6E4;
	Wed, 16 Apr 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794060; cv=none; b=h67ylQRuB8EBueGUVovYKEhPp/nALMOeWvHd/V0nWCBmh7M31EWtmJLajKFb52SJoXlMA/PLpR6pgxvAWRji8Vtqxh1Wz/414kn/jQkMEUoJU0Bb1GP85r+cwFfkPSeRVVszw/h48WYiCnhtB6LxJCnywuPQxITJI4QCnefSsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794060; c=relaxed/simple;
	bh=LkkRxVsKuChlvoYMnjLCZHxahJRvcKvpegCE7X/JCx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGzqebanb/Huvp8fHvXszZrpHvFTevuGJAIOnYFjmSNqYeAZRy3+Ee/eDKhCN28IxTKTzHGQMcXPjV+0yjeu54x0EGDl/2Yu4rMIyxYn8UhTqcM+5AV0brM/Jpi7zMF/PXilmsO7qXyZmBwPb08wj7U+Y6In68bUGNNribUSr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJbmPB5V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227b828de00so60574605ad.1;
        Wed, 16 Apr 2025 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744794058; x=1745398858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmG5wLnCycwNioKCuXAaZLGjYi/ybga0dH9UjvjLbBQ=;
        b=aJbmPB5Vncf0a/tUZhWmsq4UGTLJnmKn3/NWRjAz7YvVecQUC4/iQgvypOLZMO8Koi
         eKazaAILvw/w6rVdOoLU9MTo8p0x11IysAGOEFkERDAvUIZ/YCimHv7pOW2SWyyjFC3U
         UPeZY8KnftJUbEO81h2MvrBTz2ptJW8umNFFCjnFkzDeRIyuay/ZPCpX1ytBQsljJWEM
         /jY9YFGE0A7jRYOtLNNHS9rK+4OQI+FDiSDhSHKE31bxxA9fObIEMYdUlp8Wwb8rp8T/
         AEoBf5Gko6IZ0lMJb9ME8oUcBzBlqbRC72ZpK9Jcv92lH5mZnoCTi0IsC0st4OIDhdwa
         7QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794058; x=1745398858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmG5wLnCycwNioKCuXAaZLGjYi/ybga0dH9UjvjLbBQ=;
        b=QndeAT/mlcGwmYkjF5BwwFV9DVWa2OmB9gaUOEYyWm/AzV3NBChO6CXzhiOSLC2npQ
         LBw+2+CjTXCoMCbQUCaQL3thrvhYkWT+FWmj+hCadsC6yR8z995uC6IXN1vwjsZ/dpB2
         9d+KEcl0L9nlBQjB/1yp69IVBXG/inG7RavY8LMMzhJxwd1m49i20elsOBqjb+2H+Fph
         E1Pqegas0IzgHwM7MUxLK/5JIs5D2G2s8g0RBi73SEEvG73kVWYyD9icXS0qutFqv1O7
         ff+xGtHqCHTpa2Xl9Fup6wvY/7VMquMkMw8weqBnYk9XAtOSgifPiRmdsYOVO/qMGbPL
         QMiA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCFlufYl2/qz06ZLUY4DeJs3Hmlr4PWP9msyxU5qFZsWRbL8zAOoWz8P/Bu0twdFWL+y9+IqS@vger.kernel.org, AJvYcCW5RuUmXiCfNXJIlPH9eRhSIstttin/4H1sg4MF0TqSfxgWiaJXCCWNXSwWKZcfAHf4UtQ=@vger.kernel.org, AJvYcCWkg4dW/11ulOxa9qOKgaWqulKPyd+wn+gDLShwzCb6GaTnWDzzxfdbjlZhBgoq1avWsHfLvIIJEGg5SosW@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeM1Q9PcGibpaAs0ye/HBBqp+9n1uVRLjWQJgLiyqKIWYW5W4
	++uZVqJySu+MLCHp/uqE2NRIoagW/sC70XHVnmU/9pxEVSYk0LoS
X-Gm-Gg: ASbGncvN3CFeCZ1mTnFOWahuIY6dEk38M/xqCKBP7eY950rCu5KgU+UFOps4n9yQa1S
	Y8jAgPZH5TpCbtqWTpOmtDYscsfvvIMMbpvBY77RYci9lHAdE/a7265L9EwkbmlgsXgvd0dLh63
	b7vfR6iyHV1OjQrZLNKrctezCJIcf9GRW2EYwHvfSKwibHuEZ+02zcmMEjZTCTjhrmfVg90TUYF
	4PU2CJSJdF8UC+DxLF9X6isWHe19dbbg9shPFV/eqLdT6vtYK6RFe4AqwCzV+BSWp8pm8OB4jZe
	dyKyrH/Li1/0vFVtpi/2x5EftXlNS+Dw/MLGyieFDebP3mUZukXBrN5Q4Ig=
X-Google-Smtp-Source: AGHT+IFKvp8JSTcKdJ90nG6KVwZddhuAz0H9jshWa+isMyWM0doLGpZ4rJFIqTTHy7XwTHyjEXrxRg==
X-Received: by 2002:a17:902:ccc8:b0:22c:2492:b96b with SMTP id d9443c01a7336-22c358d9c65mr20545865ad.15.1744794058037;
        Wed, 16 Apr 2025 02:00:58 -0700 (PDT)
Received: from [172.16.0.99] ([113.161.92.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8253sm10208920b3a.93.2025.04.16.02.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:00:57 -0700 (PDT)
Message-ID: <e5369006-1439-4936-9193-3f931f8a6f29@gmail.com>
Date: Wed, 16 Apr 2025 16:00:51 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-4-minhquangbui99@gmail.com>
 <20250415212709.39eafdb5@kernel.org>
 <1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
 <CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 14:46, Jason Wang wrote:
> On Wed, Apr 16, 2025 at 2:54 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 4/16/25 11:27, Jakub Kicinski wrote:
>>> On Tue, 15 Apr 2025 14:43:41 +0700 Bui Quang Minh wrote:
>>>> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
>>>> +    # Probe for support
>>>> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
>>>> +    if xdp.ret == 255:
>>>> +        raise KsftSkipEx('AF_XDP unsupported')
>>>> +    elif xdp.ret > 0:
>>>> +        raise KsftFailEx('unable to create AF_XDP socket')
>>>> +
>>>> +    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
>>>> +               ksft_wait=3)
>>>> +
>>>> +def check_xdp_bind(cfg):
>>>> +    ip(f"link set dev %s xdp obj %s sec xdp" %
>>>> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
>>>> +    ip(f"link set dev %s xdp off" % cfg.ifname)
>>>> +
>>>> +def check_rx_resize(cfg, queue_size = 128):
>>>> +    rx_ring = _get_rx_ring_entries(cfg)
>>>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
>>>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
>>> Unfortunately this doesn't work on a basic QEMU setup:
>>>
>>> # ethtool -G eth0 rx 128
>>> [   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx queue index: 0 err: -2
>>> netlink error: No such file or directory
>>>
>>> Is there a way to enable more capable virtio_net with QEMU?
> What's the qemu command line and version?
>
> Resize depends on queue_reset which should be supported from Qemu 7.2
>
>> I guess that virtio-pci-legacy is used in your setup.
> Note that modern devices are used by default.
>
>> Here is how I setup virtio-net with Qemu
>>
>>       -netdev tap,id=hostnet1,vhost=on,script=$NETWORK_SCRIPT,downscript=no \
>>       -device
>> virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on \
>>
>> The iommu_platform=on is necessary to make vring use dma API which is a
>> requirement to enable xsk_pool in virtio-net (XDP socket will be in
>> zerocopy mode for this case). Otherwise, the XDP socket will fallback to
>> copy mode, xsk_pool is not enabled in virtio-net that makes the
>> probability to reproduce bug to be very small. Currently, when you don't
>> have iommu_platform=on, you can pass the test even before the fix, so I
>> think I will try to harden the selftest to make it return skip in this case.
> I would like to keep the resize test as it doesn't require iommu_platform.

Okay, in next version I will force the XDP socket binding to zerocopy to 
setup xsk_pool. When the binding fails, 2 tests still run but I will 
print a warning message.

Thanks,
Quang Minh.

