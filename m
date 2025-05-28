Return-Path: <bpf+bounces-59177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12844AC6D23
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D040A2440E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB628C026;
	Wed, 28 May 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEAN2DQY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D128C2C8;
	Wed, 28 May 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447106; cv=none; b=mfp7aD1Qtg9p8lPIsUm3+1BGlz0DgEJxqwQKFmc4O5W5G/d7WQOB8vy/foWyHiwLMKUf/2NA3Ek2CBFD8TfshkJu5L7bv2MpA0bOuJko9UxDh5ppa06uzVioLm5ZKxAVa2MJ+0BVE+FjVFuH+BW9U5Ye/eugEog7Y4kwkFkNmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447106; c=relaxed/simple;
	bh=gyWQ50bxUGAr7H5zPZLBDhEZf8F8PQAbcSfeFFmzTzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cbv7xs7sVl3yn172rDGz70XvBs7ab5sNLaMAN0Fm8DhC3XcM7gegCfibCgZXFPUv76z8A0pDe7Bh9xsbOT5UEcBa7goEJNqWesLx55la+56PBUITpwpTYQwIKYp3cREkD4+XHCP3mbMzD7xLoptVrcu60XWXVtCavfvHVTY+vRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEAN2DQY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso188638b3a.1;
        Wed, 28 May 2025 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748447104; x=1749051904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvyh2sL5jukcsE+iHbmofbSz17i0re3e8SaGtWtBoVc=;
        b=fEAN2DQYYDjcnrIQgrkEo9X+Wqv6YzFepfHeXKqVhiN683FX8e+nIVrwjB2TaXOjfl
         0SAJ5RzyQlAPKxHjItYS8ncWsssbJ6w3SVi1bBZp696bwMjMy/0eaWPcbbVK+KGctlUg
         ddMICNoQaAns3GpbP9YAY0v6zGFyW9e4MinkCYkHjFYYIyVvyGcqsGDy5H4KscnYy9c3
         DKOCWYAPNfwblyhLWdBFmaJ8HkjTXf7QnYvu8BfhPTTJVjeRXbQzC9HuTYUnT95YCdnU
         hrrqubPxPYcl6x1JOlVab/8j/NffbBc58+Ji4YbNmhA/BDns5te8A4S9+lQ3UAMuo+/N
         gvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447104; x=1749051904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvyh2sL5jukcsE+iHbmofbSz17i0re3e8SaGtWtBoVc=;
        b=UWfBDxroPdzpvGWajtqqXU7I7FdQGOZG6VuL+IPX7K3qoEIO8vcqX4AGqpDRShJLZr
         9Eb8CA0153Rf6Ps/C/+Qi+GlY/JjzNsjAvmtiSO+zGvxw70kdGbClNlv6TvxV/VuaXk/
         XXBuf0ynEVZxc9MVBjB4Y7yEZ7JlqCdTWlz3PmkuAVr1zkrUOzooeO//w5fPPC7PLBhv
         YdnB+2A8nc+2Yni1RXk07VY01Hwrvdiw092r3z4GWgKNlv+HQwQm4ubU2rJ24GI2JyM6
         28TkY5CsrPO3O97OvE4BeRzNCXrjzLKngr6fs0h/8M+ln8D5wv7eOakBef39J4Kj7RXc
         1Wog==
X-Forwarded-Encrypted: i=1; AJvYcCUWA3M1OwbvV5OVaLr1axqHecO0w2Zbcd+76yj+XYYuF7PR5qom50WwaHw/MKemFypcsIjCWWvZ@vger.kernel.org, AJvYcCVGAgOXR5lRZe1C70bpCtilnVGHOYNNm/YMl6Xjpy1vSZG6UageRCCkDdNr+bghRmGJ0k7yCwdE5jwyzR01@vger.kernel.org, AJvYcCXSFQCjlalcz64jWwOGBTdSUfL74WJMKRTQG+ERdzyHvpmy48E/X4EYPr6U275HWWzo+/o=@vger.kernel.org, AJvYcCXleH3dJIs+hXFjQKSuj2i9XmQ9iXo0rkzYKelxvC6VckMtAD293SVZG349FlGvtDO0FjKZTqKSr8SXaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YximIZVDh2UW4fnCs3HWwbHy5jw+rRnVKS1EtKi/SWT6iH6eRVm
	aXrkDlIyPyURtgs34MBkcOZdlH/Lw1MPEX20wQk7C7qYUgYfK9hZxuU=
X-Gm-Gg: ASbGncvh8JrLlHOQ2BM/NtPcPJ3rnn6nZ+lEv0SG8Gdz9MBkwF8LehAW+Su4DL7lPQ/
	msM2XCxAFt1jE5yQOoQUHoFyba9aDZpLw4IJOH4mzwTx6WGfmkqgVnMvw3cvgx5j/ZitSUdsrFt
	9uLF96eHrwjq0SwghqCjPAwRbKO4SJSJA0UQkS4/QgPSL6cRb6IuUH9bav/4UxuMmXkcblM3eCe
	T6L0dE8XYMxzBSI6dmbQpyY/ujhBmiVHOjEWbqfBRCvI9GwJqDyfelsFDv1+wkNkTKq8BGRbbMY
	nQ00kCP3M944knHtNkhk3XSBCgyGr+nVIBnlSwH1omtMh3UNcGJpAHJc9rinGttoB6cyr5W2Vuy
	jvnT+8+ca+Vxh
X-Google-Smtp-Source: AGHT+IGSIsno6X7q+kUR6kRJB9l4MrL/N1la21dLaIi3MVJ9y47uMvcECGTsZZ59dCO2/u8b0YoX3Q==
X-Received: by 2002:a05:6a21:33a4:b0:218:2264:1178 with SMTP id adf61e73a8af0-21ac5b89dc1mr94275637.7.1748447104474;
        Wed, 28 May 2025 08:45:04 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2d99ec4b05sm1300558a12.49.2025.05.28.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 08:45:03 -0700 (PDT)
Date: Wed, 28 May 2025 08:45:02 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
Message-ID: <aDcvfvLMN2y5xkbo@mini-arch>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <aDXi3VpAOPHQ576e@mini-arch>
 <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>

On 05/28, Dragos Tatulea wrote:
> On Tue, May 27, 2025 at 09:05:49AM -0700, Stanislav Fomichev wrote:
> > On 05/23, Tariq Toukan wrote:
> > > This series from the team adds support for zerocopy rx TCP with devmem
> > > and io_uring for ConnectX7 NICs and above. For performance reasons and
> > > simplicity HW-GRO will also be turned on when header-data split mode is
> > > on.
> > > 
> > > Find more details below.
> > > 
> > > Regards,
> > > Tariq
> > > 
> > > Performance
> > > ===========
> > > 
> > > Test setup:
> > > 
> > > * CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
> > > * NIC: ConnectX7
> > > * Benchmarking tool: kperf [1]
> > > * Single TCP flow
> > > * Test duration: 60s
> > > 
> > > With application thread and interrupts pinned to the *same* core:
> > > 
> > > |------+-----------+----------|
> > > | MTU  | epoll     | io_uring |
> > > |------+-----------+----------|
> > > | 1500 | 61.6 Gbps | 114 Gbps |
> > > | 4096 | 69.3 Gbps | 151 Gbps |
> > > | 9000 | 67.8 Gbps | 187 Gbps |
> > > |------+-----------+----------|
> > > 
> > > The CPU usage for io_uring is 95%.
> > > 
> > > Reproduction steps for io_uring:
> > > 
> > > server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
> > >         --iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2
> > > 
> > > server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc
> > > 
> > > client --src 2001:db8::2 --dst 2001:db8::1 \
> > >         --msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2
> > > 
> > > Patch overview:
> > > ================
> > > 
> > > First, a netmem API for skb_can_coalesce is added to the core to be able
> > > to do skb fragment coalescing on netmems.
> > > 
> > > The next patches introduce some cleanups in the internal SHAMPO code and
> > > improvements to hw gro capability checks in FW.
> > > 
> > > A separate page_pool is introduced for headers. Ethtool stats are added
> > > as well.
> > > 
> > > Then the driver is converted to use the netmem API and to allow support
> > > for unreadable netmem page pool.
> > > 
> > > The queue management ops are implemented.
> > > 
> > > Finally, the tcp-data-split ring parameter is exposed.
> > > 
> > > Changelog
> > > =========
> > > 
> > > Changes from v1 [0]:
> > > - Added support for skb_can_coalesce_netmem().
> > > - Avoid netmem_to_page() casts in the driver.
> > > - Fixed code to abide 80 char limit with some exceptions to avoid
> > > code churn.
> > 
> > Since there is gonna be 2-3 weeks of closed net-next, can you
> > also add a patch for the tx side? It should be trivial (skip dma unmap
> > for niovs in tx completions plus netdev->netmem_tx=1).
> >
> Seems indeed trivial. We will add it.
> 
> > And, btw, what about the issue that Cosmin raised in [0]? Is it addressed
> > in this series?
> > 
> > 0: https://lore.kernel.org/netdev/9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com/
> We wanted to fix this afterwards as it needs to change a more subtle
> part in the code that replenishes pages. This needs more thinking and
> testing.

Thanks! For my understanding: does the issue occur only during initial
queue refill? Or the same problem will happen any time there is a burst
of traffic that might exhaust all rx descriptors?

