Return-Path: <bpf+bounces-56026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900BBA8B14C
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 08:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD493B06D2
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC21230277;
	Wed, 16 Apr 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRUvoqXr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A522F3BE;
	Wed, 16 Apr 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786482; cv=none; b=akvSOeDR64bhgpwjsutuzEJu7Jv6/JdkD9IeoXNrW07mFRAecVhZ7DS71IC/S6wyR1gIZMbruG+yYdnEGDTN50Ec3IU7OQe3xV2N5AwFQfN+tz9/5Lx95IOES6tIhehYYuHo3f6fVOw/0V17rko3Q1xFH7LLvLLolD8U5ORdrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786482; c=relaxed/simple;
	bh=eMwxxrI/yqh3c02Xa/Zji/ZDs6jaXH0UXIImJ6rzu0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZjqAY09ERRBIAyO/khCMbRox8Ysj7faMGMLA/RMeXYp/2wNKa6Sh0yXwIUzfQ4mtC7r6nlJiKCNku7+XguJbLIm7YkTZtlu76+yZH4Zm8Ju9mttQoH10G5gCNEqLo+IkLaZtyp6v+8GfIxZYVloqfvzmRk12gaK8kzmHlpNpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRUvoqXr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af519c159a8so5820423a12.3;
        Tue, 15 Apr 2025 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744786480; x=1745391280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwHFx2X+LzqDnaO5ScRT2dnEDpqIh6CuLMeABnbFK/o=;
        b=jRUvoqXrzbyJW8DlJ/fcYmP8PsQ0XwJf6MhsyzMxm/gyKGiUn3kCQFTj8LOKPNe3Qm
         ovEkU4v5opK2yfg6RLovIo4RnoO62gQE81a/4L6knBBreGpMdJcBS1JH8p2+rXejHKrN
         INuGpmvNyaCqEM2K+J/EtwhRM8A7Tv5ss4dJWbjBC6NLNME3mdam0pMqDfxfjbTn21MK
         pwdsDbXUBt8ZJnlI5TeG9L+I+eQzhrJ2DV4oBiPi6Hb7S+wGf/30wWxr/FM0Y3N/SoeJ
         pMPTsX00wf4/jqwb4Z+DKeA3vkAOtwVq/TQ12tnMFppFq/9JTjh+n33AH0iAFYkIf9nX
         /Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744786480; x=1745391280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwHFx2X+LzqDnaO5ScRT2dnEDpqIh6CuLMeABnbFK/o=;
        b=Bn7NsGjs7ya80ku8pUEK1wAEnnFAGgF0ZjwWAEmIi2EmCaGVrygNOcDlzkRAdPASQ0
         coShWohCZICpJ3OtW53N44rkbY3sErhpRWHiAgueZVZfjEdmQ8feoO+U+LyD/cSNF3j9
         oimbcg1U4z5qnibgV0QZ+Yl3XtXgzlqL4dDMxi96GUSQiJQRmqXbgioP34D1SPob3+nK
         bBJ4AitK2eJjrKdE0y3DGB1JjbuVaPTyuTHJKwRVunhJ70g7A1yKnTESvE0nvhVBQ1xv
         ojAV9RW53z9JI82QDB3eA5X6vF4KNmZFUQGNK8bFhwPqBadDwbHkh5RXZ1fKFKXhzvL2
         8/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQtz2mOIAdhpHDWUd2CGEtURc8fc+9ugA8vbpIfaTkJmC9HtqyrsAx9QPY/ifVgSkhZSU=@vger.kernel.org, AJvYcCVGDEWiAfqHkDGH4rYD6befZ0owyepljUP6XDhMmeiIWxQRObFqXJ7yMLC7Cm2NC7L2H6vHh2lepeta2CVL@vger.kernel.org, AJvYcCXysh+SkNgsigSQtK0CIkSV6BoKsX5RVgc2ZFvbB6QOPU4QwIDTpHuZE61HcNfQHA3bsmfYg7z2@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYTzmyWxpr73kB7DsW1RUYDAXZjVsLLClYs7jKoXKIcS2dFi6
	xBiePwRdcV63suiTtK3EmvoS0lJcMel17d37g9WJvsgeoHMWRUuf
X-Gm-Gg: ASbGncs1xMfPgEwEN/c4WZD4ArCbepiKdqPNX2nWGzhorJ4YUoPdQm7hG70ZHsfvA6t
	5n2ukm160ckdxuuf+HhydYVNR8WLJLO/htdWwg1zYgk4wy0BdFlv3GO3y5VB9ZEqS2BR6ACFJ3X
	+DqyJJea9BtMQgULoaaapJtgB+HJBe2psWOxRsCCy2wknwLE9YJkBdpiFETeULYAk2kqb98OS1Q
	I7owSoPQH42weTNEGvAiwKpTvVVhIlNIYrEvBcxGCiNuI/YgLnPUBQWOkw6DxR7Pl1Mjdr8KLMs
	CBfQZZRoQk+/xydWALUvOX8TtROCCRcNKc9+Glz77X5uIbyDp81/BLYqyBEJVhxABENl2W9SQRB
	nMuv/BVdoivGWDSpj8j4=
X-Google-Smtp-Source: AGHT+IF8/C/bE/M8V11NAS4DjSmBrO99vSahBnCYSkXY7IEd2nQ+G+Lw7PFE5CD5FqU81B6JmzCipg==
X-Received: by 2002:a17:90b:254d:b0:2ff:6fc3:79c3 with SMTP id 98e67ed59e1d1-30863f1b878mr1169706a91.9.1744786479803;
        Tue, 15 Apr 2025 23:54:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:bc8e:5d77:bf95:efb6? ([2001:ee0:4f0e:fb30:bc8e:5d77:bf95:efb6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613b2ff9sm785083a91.30.2025.04.15.23.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 23:54:39 -0700 (PDT)
Message-ID: <1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
Date: Wed, 16 Apr 2025 13:54:31 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-4-minhquangbui99@gmail.com>
 <20250415212709.39eafdb5@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250415212709.39eafdb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 11:27, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 14:43:41 +0700 Bui Quang Minh wrote:
>> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
>> +    # Probe for support
>> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
>> +    if xdp.ret == 255:
>> +        raise KsftSkipEx('AF_XDP unsupported')
>> +    elif xdp.ret > 0:
>> +        raise KsftFailEx('unable to create AF_XDP socket')
>> +
>> +    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
>> +               ksft_wait=3)
>> +
>> +def check_xdp_bind(cfg):
>> +    ip(f"link set dev %s xdp obj %s sec xdp" %
>> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
>> +    ip(f"link set dev %s xdp off" % cfg.ifname)
>> +
>> +def check_rx_resize(cfg, queue_size = 128):
>> +    rx_ring = _get_rx_ring_entries(cfg)
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
> Unfortunately this doesn't work on a basic QEMU setup:
>
> # ethtool -G eth0 rx 128
> [   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx queue index: 0 err: -2
> netlink error: No such file or directory
>
> Is there a way to enable more capable virtio_net with QEMU?

I guess that virtio-pci-legacy is used in your setup.

Here is how I setup virtio-net with Qemu

     -netdev tap,id=hostnet1,vhost=on,script=$NETWORK_SCRIPT,downscript=no \
     -device 
virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on \

The iommu_platform=on is necessary to make vring use dma API which is a 
requirement to enable xsk_pool in virtio-net (XDP socket will be in 
zerocopy mode for this case). Otherwise, the XDP socket will fallback to 
copy mode, xsk_pool is not enabled in virtio-net that makes the 
probability to reproduce bug to be very small. Currently, when you don't 
have iommu_platform=on, you can pass the test even before the fix, so I 
think I will try to harden the selftest to make it return skip in this case.

Thanks,
Quang Minh.

