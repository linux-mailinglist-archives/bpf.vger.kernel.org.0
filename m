Return-Path: <bpf+bounces-55508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AC2A81D53
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 08:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1168817F607
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F41DF75C;
	Wed,  9 Apr 2025 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCjoTyZ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522311DE4E7;
	Wed,  9 Apr 2025 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181057; cv=none; b=aEEsOKqMmXeNY/1Jmh3e/3hHnTtVLB039as1yfC44YAY43J+iO8zZs6Bfoudhr1U0O8+y+sDkyhG+80T7okOQci/ePJtJQLoetPXuaok4h9jRPOIa2TBGhX17UvpoiPVELyhnS3/uEPlXIBiC5ouH8/O0yBqRo5RQUHOxblyWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181057; c=relaxed/simple;
	bh=EA2abmK970vc5VUSwknSZAbpfozmiJ2WLu2yC0Rm9Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+iBxptMY39zla1sf2g0IDBWeQgpOFpQu2ZPZp07f7t30NzaZav4WfRL88zk5nIBod8Qrlh6nFtBq/K69rJcsriI7S1C0oAW67SPLKqz/lZT8Oi+C7hGzj/BhylPjUdJ8DixsP9Ry6DI77CuT8XzFprg1JRKTkwxgIoAe9bqrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCjoTyZ7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so2921946a91.1;
        Tue, 08 Apr 2025 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744181055; x=1744785855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFnPHqAViJTArLLnMbNb1yqvVoshG4R2mnj5u2i0toE=;
        b=UCjoTyZ7n8tvGR7OjR7tS9Ro8L6DZwRuJrPXMXc0xYRDuSBjkVrXWTFGds+H1WQgfk
         Cw8H8bFkttNmiWr0SkDD4d0ub/uTIlEey5XyoJlu5OeKZmfVmXl5qwo2rsavYFKLg3yQ
         UCFG7H0G13HgI95y2pp0HayFIU3KMNkU58fypUztZHcanuF14xDNsvgT+kodRqefKlDd
         m1CFbvPnOqpieeNvWkDFeUraia1KI1JU9YLB++Gji1oXn/3WGhoXFJGCUtDcQrvFNeAC
         b9boKIxtjNKpTZv2GJGSOFprw3lPe8+4pqSghfe12fvjbYM4NItRj7d9j83Tkuf9zjTa
         TlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181055; x=1744785855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFnPHqAViJTArLLnMbNb1yqvVoshG4R2mnj5u2i0toE=;
        b=OQ2enlJ411P2VUcc1F9WQlnCjPh0rvXYq5os0OAujFdDezIhkZQGzNh0VjoWA5MWmc
         DrOLzJOqIemG+2jMYf7Was/W/S0fSAepk3txAPPkNMIOv25HZlrV9UIKCmw/6IIf3Kti
         HXGm/LOi23iEiktDscbdWlgd1aS2KVjBVOQbCFuuDNvf9CgusCKsTwiY+VfVgtG6bJir
         AFn1RcRmGicYQWhzemyFnpHWI/h80TTfJtSexteLvBiotFYtlJeupNFw4jyX6LeW3qKS
         RxML25+hUH585ZH2GjSFUZvkYyMc0Hw6NkPPY131JcrVbgsQR7TGg87aYi9SCKGQway2
         /VZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEexOdK9qCPYZhGyULaaX5xXql0mPZ1WT38S6QbreWmoSaGMMZqqRLhlh06TtdN8OdjBnRtMCh@vger.kernel.org, AJvYcCUuKXJsKYqwjQErzh/Wxfc9cS4OKEPyBKaXclXWqK1usyGbMki0wMieocSTAZd1xoMVa8o=@vger.kernel.org, AJvYcCWxPsPKgl8iqnUFTxILAMzUBFIJuFKf7xKXa/hBSMrrnckZt/IgQy4ndfvh7o8wNUGUrIsZGzCCXNUrDfaf@vger.kernel.org
X-Gm-Message-State: AOJu0YwVs00Dro6bD73Lzk4Oakg95dvYnwgg/sLaTQLisIEBwPjNf5jK
	ozKTnLpdB1DqV6+yqt0Bw/6aBgg4DffkUsl90/gNCWvnk79l6Cek
X-Gm-Gg: ASbGncssGAHIzNeIQWr6+2uIo3cJHX7KoICN+ZEiVL8K/7jw3fwJQ6XoLFmP2VN2vXj
	ypaglAht/e6lNVkYHvGq8jSUQfrfIaeJTDCAzA6HTpJToQrNGbk7xJW9443DCfSZcOKkv1CuGxc
	W7xiR4yiMe6pqMeOaTIMkgwWvqRfTYCu1WUUo2QAGhomNLBisOf9Uqn72V1HIpIIZE2oFG0fe+/
	Tyzl9dnDCH1Ruabapkp1d1cKXY8OowF9f5CxTxTTGRvzy9NNPccOKuiuE1DgL0G/PdNUYtj21Pj
	2JaI5K47dfrf3vRHKa4dAtuKVuwHDT+zoKO6GRlrqbd1ifp0yQ==
X-Google-Smtp-Source: AGHT+IFEFBrVdU4Z60J6u9c77Kly+wSwU0+rEdmF+faACzLEkBXEARmQGsGuz7F6mtlkCJR4WkAuvA==
X-Received: by 2002:a17:90a:d00b:b0:2fe:9783:afd3 with SMTP id 98e67ed59e1d1-306dbb8e8a5mr2762085a91.2.1744181055366;
        Tue, 08 Apr 2025 23:44:15 -0700 (PDT)
Received: from [192.168.0.118] ([14.169.40.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8c617sm4321055ad.67.2025.04.08.23.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:44:14 -0700 (PDT)
Message-ID: <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
Date: Wed, 9 Apr 2025 13:44:07 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/25 14:34, Jason Wang wrote:
> On Mon, Apr 7, 2025 at 10:27 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 4/7/25 08:03, Xuan Zhuo wrote:
>>> On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>>>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>>>> also calls napi_disable() on the receive queue's napi. This can leads to
>>>> deadlock when napi_disable() is called on an already disabled napi. This
>>>> scenario can be reproducible by binding a XDP socket to virtio-net
>>>> interface without setting up the fill ring. As a result, try_fill_recv
>>>> will fail until the fill ring is set up and refill_work is scheduled.
>>> So, what is the problem? The refill_work is waiting? As I know, that thread
>>> will sleep some time, so the cpu can do other work.
>> When napi_disable is called on an already disabled napi, it will sleep
>> in napi_disable_locked while still holding the netdev_lock. As a result,
>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>> This leads to refill_work and the pause-then-resume tx are stuck altogether.
> This needs to be added to the chagelog. And it looks like this is a fix for
>
> commit 413f0271f3966e0c73d4937963f19335af19e628
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Tue Jan 14 19:53:14 2025 -0800
>
>      net: protect NAPI enablement with netdev_lock()
>
> ?

I'm not aware of this, will update the fix tags in the next patch.

> I wonder if it's simpler to just hold the netdev lock in resize or xsk
> binding instead of this.

That looks cleaner, let me try that approach.

Thanks,
Quang Minh

