Return-Path: <bpf+bounces-55956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3710A8A099
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 16:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83229189E749
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DD294A1F;
	Tue, 15 Apr 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKxb5ptz"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594EE1A238E
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725893; cv=none; b=H2mj9/1CogCXN5YHEtw9PK3CvnukABX/r2gpHvkHdzMHCwLIh+LtkT0838D/iXiU95T+XM3G5hO+k4EU9gsc1TqI8cI1KiePe12xpio2Wn5ac1YG+7VRgkljSG6JiisfabQCCpuuN2aKqugq8PrYlWc873LBQ1KGRgpLY/bkvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725893; c=relaxed/simple;
	bh=QXP9FxMrw7KNSGwJPkQN8Q4+F9sKVBVOP6V3LiUSFH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxv8adyZwmoCl7WYe9ZbdkgNj2vP1U4PssHemJ3kbYpg+xPcmT/fmZy2KhAJWrcIaRLZK0frIIlYDhDQFunCoF+GdYyBzoF054/9+7yH3RLAdkPVXwRYvK2JhDmEXdxaZyE559+enpgmyMdYTrYtKADJ0yvFM3qrGDeR3+197ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKxb5ptz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744725890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJjI0lY/xyReq3ZmWkhvSF6/rYPEyl6oWq19qSKGU2Q=;
	b=BKxb5ptzYCieGjbhUBpuISLlRTjvhxhXtdxZTgHmQf43cyAOnm2dRBLFH56ZhaI0kHb4g4
	0ibdiTKEMUOfg2uleC+LGKTdP+pwH7cR56SZLE4afWiYEJMyLaD6xSIDLIrnAnpb0tE9Dk
	0ZfvbVmcHe9jaHxZkfRqvCA3/TTQ0Rc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-UZfFpuAnOjGzKpNoAtGNWg-1; Tue, 15 Apr 2025 10:04:48 -0400
X-MC-Unique: UZfFpuAnOjGzKpNoAtGNWg-1
X-Mimecast-MFC-AGG-ID: UZfFpuAnOjGzKpNoAtGNWg_1744725887
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so48757595e9.3
        for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744725887; x=1745330687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJjI0lY/xyReq3ZmWkhvSF6/rYPEyl6oWq19qSKGU2Q=;
        b=OK/u8Sgxfekc1ta+vJ8SLgI6IVaygsHVylPi64Rm7H9LNMsGFTJWsaR/4rBPrZ8Em/
         2C+EeUywwfrDMNgwaZxRwIoUYOsuWuan+i8TaHvVes7ZuhXjBwWrYhAJpbQoqN9jSVTl
         v755MBZIxuLoNrUIrup0B4BjEaFs2fHiMxfLcCgPnTbEiRI2lc8zxx4WfWJxpWUt9dlK
         hY6OKGYBESM1PPCn5T2efLle7aN/JMS37dNA0TNN2aCSAtazzf7HpydNekkawDSW3aDc
         UGHBPc+DMxgYKaSS9GTRYnJB+vuizv3HqWwKQ95nyOsM8ZG8CRWptU+I9NZL3m/8R5jf
         quvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlmzdnII59LBt7I+bvsPJAoccQ0EARrINY2tYNBv6kcdV6jlECWtlxq5U9BENs1ct+xBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoIGE8Q3cEgFBQZW5JeJDEBzdUqSKj8J/50aasl/0YXAAGqZh
	N02OgMPMJD1wPdIQXZ7lIfXJDYAFIQXYtwhnp86jv9BktzbvSeRA8NBUIjMG6a767AHEFASlIN8
	vLTo+Sz/ttDJzi+TFSSKxwtehszSoxiKXL8BAdX7zYue1EmRecw==
X-Gm-Gg: ASbGncv/xIvTon+fA1yQiek+hJ0iXdjE157KtF+pBvcboOud04fLj9LH/i5SYyzA77W
	GD70eHjtRySGjkMuRnZvrbWl9CyDpeC6vvjefGXcF1rvYwU23VSljea4VoP7AYKghmNHzyak38i
	P1rrPwCiBUOcM5EcMT5MW9xfUm/m+PxUMPgK2r/ndVoFbFm2SMxOrdlZgR4ku90E0dhD/ybchs0
	HFfOYTyJnvjAUqohmaZqec2wxC5jzWch7YE5GmLmbXdK0v9lmRrcaes4+lMMDzVpnFwwzF9trKu
	E48tzQ==
X-Received: by 2002:a05:600c:3b93:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43f3a93ce18mr130332845e9.8.1744725887405;
        Tue, 15 Apr 2025 07:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHITYoM+E4rIVBkVC+Zy7bnyx80+fEMQuQMdwZhPsCxD1+xYR+TZ77Lv7xvd8u4v2RkPh0L7w==
X-Received: by 2002:a05:600c:3b93:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43f3a93ce18mr130331785e9.8.1744725886545;
        Tue, 15 Apr 2025 07:04:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ed041sm210253075e9.2.2025.04.15.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 07:04:45 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250415100425-mutt-send-email-mst@kernel.org>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>

On Tue, Apr 15, 2025 at 02:43:38PM +0700, Bui Quang Minh wrote:
> Hi everyone,
> 
> This series tries to fix a deadlock in virtio-net when binding/unbinding
> XDP program, XDP socket or resizing the rx queue.
> 
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi. When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
> 
> This fix adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
> 
> Version 3 changes:
> - Patch 1: refactor to avoid code duplication
> 
> Version 2 changes:
> - Add selftest for deadlock scenario
> 
> Thanks,
> Quang Minh.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Bui Quang Minh (3):
>   virtio-net: disable delayed refill when pausing rx
>   selftests: net: move xdp_helper to net/lib
>   selftests: net: add a virtio_net deadlock selftest
> 
>  drivers/net/virtio_net.c                      | 69 +++++++++++++++----
>  tools/testing/selftests/Makefile              |  2 +-
>  tools/testing/selftests/drivers/net/Makefile  |  2 -
>  tools/testing/selftests/drivers/net/queues.py |  4 +-
>  .../selftests/drivers/net/virtio_net/Makefile |  2 +
>  .../selftests/drivers/net/virtio_net/config   |  1 +
>  .../drivers/net/virtio_net/lib/py/__init__.py | 16 +++++
>  .../drivers/net/virtio_net/xsk_pool.py        | 52 ++++++++++++++
>  tools/testing/selftests/net/lib/.gitignore    |  1 +
>  tools/testing/selftests/net/lib/Makefile      |  1 +
>  .../{drivers/net => net/lib}/xdp_helper.c     |  0
>  11 files changed, 133 insertions(+), 17 deletions(-)
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
>  rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)
> 
> -- 
> 2.43.0


