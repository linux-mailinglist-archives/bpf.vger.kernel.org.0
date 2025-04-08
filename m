Return-Path: <bpf+bounces-55448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B00A7F97D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBBE175EC9
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D28264F90;
	Tue,  8 Apr 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjFf/ewd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34E264A85
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104542; cv=none; b=rVgMjn9H9II3WRBPfk5DgXaHIdrQvYiC7ko13Mis/WTYi4bSWK6ziEiYANzmqhkKr8GiiYs4JLfY4PeDQRukL6wnkx1uAcZcdstp86LiI6YCqCRgfzYLId6RLEj7ZhHJKmdE99SEQIIVI2xO9s+QNtlm4y6eubanOD99JA020ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104542; c=relaxed/simple;
	bh=6GXjoR9+j3K5oqC5DbXewEtoWag0AaWHJyjmg134Js8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU+K9HWGH1sujrdxpEeAyg/FajzIJJT/U2nhjkCrUy7/2d7LSc6Qlx0Fp7+3vbc2S9d0J3gF47mxzu0ElK29F9zKfBGuPNnGYYDYUOYXbzihkP14LboUMJU4LR0D5grFVy9l3P4EYVCOHk2wUHpGSuKUUELGkABdDXnQGtyp0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjFf/ewd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744104539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kFJkKUSX4bPqKPH1LRnxjH0+XkR8hOBduchqaJy8g8=;
	b=AjFf/ewdlHHT0pmbgyMqtX2TkSZVxkm1qzBrWkeTmYiNcYF0gD0pvOp3tbR8L0mDkUbFn4
	3R4HtoMxPzpNSkRWByoOgVivYK8rbSZNgf7CMPFFTbyywp59JScdM1fFBW6quxCjjg/YWc
	H2HQqTs3Ctwhc38C4pdqBuYg8QTMNAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-4BM9c8XwO5iTdrgxD-dWFg-1; Tue, 08 Apr 2025 05:28:58 -0400
X-MC-Unique: 4BM9c8XwO5iTdrgxD-dWFg-1
X-Mimecast-MFC-AGG-ID: 4BM9c8XwO5iTdrgxD-dWFg_1744104537
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so30011805e9.1
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 02:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744104537; x=1744709337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kFJkKUSX4bPqKPH1LRnxjH0+XkR8hOBduchqaJy8g8=;
        b=orYWIyjBitjoV0soqH4HPQnVzVe634aC4I3xsiHO94agUd9Wwgew56C09hJBUnGUMx
         OOI8DSXZ2bwPjmPQrRA6iHxgXMLBCgIsLSSAwtCtqdGIdMBQ2M8xOFJPEhmA9tMjTAJw
         HQe1RmmxG7pn23OuifvkhFiY3ygJMedCg2bF0tyxfBdFlh+dzYqFpxnwVZHUbMkKYUIA
         drIJ7CDUHgCBX41a3+rWorp0O+SN3LyzMlJu/g/0LC3Gt8/EOVby1+vta/ys/C37hP0e
         So4iM6X5I3a76Wsq6QWtN/ctI7t8Gb7cRWpCIKa0HECm5Nh1Ki5ZuX4xLq1ASqALOeA3
         2tCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmuf8my8XyDWtdlhS5hPRRDg54S3hHUXSiQl8ehj+eK4eve/Bua7e9omTExxYkxjH75ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRr+DZA1kRtBcmmGy3EaR4kVYUEAXFQBwuMXgrBON6RvvYGey7
	fWlDon4JZEV09AnKBY5DfF6CP1k/t7a479Op/grXiEq3c15Yxmh+/qitiIvGa4JByGDnaRMm46R
	GV71Ga3pXOhC+KNJymluMriWcG52MOCbtn/xCoryI4gK/qMf5xQ==
X-Gm-Gg: ASbGnctop1clGUSbSqi6Wle4AMithp5ljpJJg8L1DOmEOCDpmiwWre1seI+fgy0ExqD
	9a8jA/44cJiQepcOH7r6znYEqaF2xH7g9UpSrv1JL2IIYrK8K15fKsqJOlslHTe1aMS0obrbgAm
	3Wizg/fkoUjlxOMYU5zjBvTxC1KdWy2IgkFg5XxUTBpUI6aZ1gd7gfKKrCGbJS+4ZGV7kYJaaQp
	vitiv9g+DWNUjCXRiOHfIqah6C6tAAISvROHJ7PjESVtOB/Bxz3cYoBCIllNACxNuuUvAbAUJSl
	fY9XUwVRIOa3t3u4VGZWzdZLjEYHtUI1SbOy/RcNRcw=
X-Received: by 2002:a05:600c:4fcf:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43f0e559b59mr17275465e9.2.1744104537135;
        Tue, 08 Apr 2025 02:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhpOS2RXvhgff3wksFzuaqSdXSfMzYI4OqpbYjwZCmgj2nkzJ65yFcKEppTsA1r/gQVzTICQ==
X-Received: by 2002:a05:600c:4fcf:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43f0e559b59mr17275315e9.2.1744104536739;
        Tue, 08 Apr 2025 02:28:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1660eb3sm159792645e9.11.2025.04.08.02.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 02:28:56 -0700 (PDT)
Message-ID: <1b78c63b-7c07-4d25-8785-bfb0e28c71ad@redhat.com>
Date: Tue, 8 Apr 2025 11:28:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Jason Wang <jasowang@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 9:34 AM, Jason Wang wrote:
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
>>>
>>> So, what is the problem? The refill_work is waiting? As I know, that thread
>>> will sleep some time, so the cpu can do other work.
>>
>> When napi_disable is called on an already disabled napi, it will sleep
>> in napi_disable_locked while still holding the netdev_lock. As a result,
>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>> This leads to refill_work and the pause-then-resume tx are stuck altogether.
> 
> This needs to be added to the chagelog. And it looks like this is a fix for
> 
> commit 413f0271f3966e0c73d4937963f19335af19e628
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Tue Jan 14 19:53:14 2025 -0800
> 
>     net: protect NAPI enablement with netdev_lock()
> 
> ?
> 
> I wonder if it's simpler to just hold the netdev lock in resize or xsk
> binding instead of this.

Setting:

	dev->request_ops_lock = true;

in virtnet_probe() before calling register_netdevice() should achieve
the above. Could you please have a try?

Thanks,

Paolo


