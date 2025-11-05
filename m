Return-Path: <bpf+bounces-73697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8117AC37921
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 20:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C0D3AB8D3
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0534405D;
	Wed,  5 Nov 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nALGEc/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7F343D9C
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372314; cv=none; b=QzyL2uD6M91w/m69Lj6bEGSve4CD7Z15YUG0a/0RTjNaSqMzg8rvL3Qsddkgweu+zauE/zdDy94evOAE5VtBGinzOYfcVtxhusMnMogCrldfKT8OQXCe43jHBNVeaI8e6YwJvo4V80G9/7LkODlAvZhCvcm6M9XpfzDW5MSQ9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372314; c=relaxed/simple;
	bh=SyjnyK2mM7BPl8arvIT1TqAsNFqJsg/GvV58Gk3CgP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9+9Cf9gGOo7O9uKMKEfIDd/ohuSo4vMHySX6rldpRtSL0p6ld391jMDRvMnw1oIe/ciSLEy+lITTnljdlVdVplyUJEQlPD2+p05GzNHo5DmMZTInuwLC9PN3VVrb7RSG0K8crCX8M2XYJQM5loZbJV4xPMwfE9BcM153qy3FVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nALGEc/+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29558061c68so2786275ad.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 11:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372312; x=1762977112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksJDtaPRfEdf2wyhHYMWN9wPkaygRfw7CbDDkQ9lv28=;
        b=nALGEc/+SZA0IY4vWvdqu/Tm0hLNqzvjXxAiOUhFBJ/YPAoWxmZv3pHjBkLJroXlDp
         89/fu6UIEIyEdE6QDrRG8lPGSj9f3wL0sqr4NMW8MUQy6HXcFs1W1YtA5LBtBJ5WX5dm
         KO8tay4nX9vTQi+7C0CrF5MS7oowmeSkxqXWUXYS7DTqmbowyYKV6eh7693WkweDIhNC
         gndr3swjfK9qmg2JctGYrCHEEWra5zxcAkU/Akb2+AosAwF3DXc3siUICCCruHiaAiew
         ecsiEYdTLVSLKPIimVsW6eecIL8jn3/QPdu2cspWQ9SFYAl/GGsLwNRHtYr7neHK2qTX
         NGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372312; x=1762977112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksJDtaPRfEdf2wyhHYMWN9wPkaygRfw7CbDDkQ9lv28=;
        b=PrbKE8EqznORgk4zTKTgZ97OLWkMNXW0kDlKKF0O6QgBK92KSGrv+cz2p0d56sH2sR
         LYH63tR0r6ZHtVxmaYZdkU9HvmvH+xUhZBkXTIwXgnq/ceP9BBRk6GK70nfUgBJDHCF9
         tYvoqQE2Ilj1kVbhmY6EzNDSBPVsy1GfXnc/YL5zz0s7n78kCG6mZOlQZGpqrMx/WfEh
         YuMBOIUylt/Q7t6M5FGeYUdcsJpmLKXhdNhAhAyZp/PEHGUWu8EGhe0E6f37xU3G3OAh
         vmgoJCzWyRVr7kYdD4Rzsw18W/neKc3z5By0io8sUeDB2ufq8fS3rGnAelFaXDMHR7fu
         ewLg==
X-Forwarded-Encrypted: i=1; AJvYcCW3VwtXiI14YUlI6np1jKCn0VqemM8bbY6VaTaaFH44keLLGYC3L9O0rM/iCBKK2lny3Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2vsPuzb9LGAmI/082FN4F+vxm41XRf4b4H5IXrT+9IZZPGE6
	P1yMJyVQe7QRjubrXhvSmzaUPcwR1R6Y0W7qG/gP1c7ujm/rha+eTO0=
X-Gm-Gg: ASbGnctRZBZbORhVTbPH/VSepwqf2LyOoOzEU1n9sTbx/bw/ALIU4Ad0zeURKiU3EkH
	NVep9c6nD0scnJ5Mc/E3XWM2fl7oAiChp7P/8z4GPo/Eq0VfMhodVwbNhitrchft6vogkn3QW6h
	zmQ6rxfUAvwqq/UKXjGjD2OutrSkQsk5XudVWnPmZ+SnCjsLCSsFTOJLFzey58CcZfeRMhWQz1s
	TIcRXdvTUpCfUayJ+ULunt45W7eVF1LOy6L/9PfU9zLWyMdQ5FB/dxMNm8q0l5SQ9PsTh6j8QQs
	sfWFj+Lfhzz98kp+IsKKGGn6FkG5Lmb11CQ97rhX32Awb5YU8TwTCHfANoa104KPGnKWRyYw1PR
	vL4gMm/EBrSV2R+O7/ODI1mg8T9TMOp8wk3uBcJ1gmy4fQr4nQ5DX/WikPT2wcuq2dTEs5XOosK
	vJUpdw3dbbEKFiCUenTidqB5YJn32OOsNwCi0x2A4zGtdy8INrYDJ9K7cc2EsfofmVe2EjbPEBU
	lvSqMAcp5y9LjpZfRUDf19hqtw4v2EATTxnj+bGnVQKBfSY8DLXjHVa
X-Google-Smtp-Source: AGHT+IHvedoObPI3pxxfxclSW2jn0qBK9jIAa7IzRD3SI3wu5p6eqVzGifMv2Q3vbiXXa0p/BG3eIA==
X-Received: by 2002:a17:902:d4c7:b0:292:fe19:8896 with SMTP id d9443c01a7336-2962add623emr61147975ad.52.1762372311486;
        Wed, 05 Nov 2025 11:51:51 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d790sm3591555ad.26.2025.11.05.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:51:51 -0800 (PST)
Date: Wed, 5 Nov 2025 11:51:50 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
	sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
	jordan@jrife.io, maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com, toke@redhat.com,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
Message-ID: <aQuq1mhm7cM8kkLY@mini-arch>
References: <20251031212103.310683-1-daniel@iogearbox.net>
 <aQqKsGDdeYQqA91s@mini-arch>
 <458d088f-dace-4869-b4af-b381d6ca5af1@davidwei.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <458d088f-dace-4869-b4af-b381d6ca5af1@davidwei.uk>

On 11/04, David Wei wrote:
> On 2025-11-04 15:22, Stanislav Fomichev wrote:
> > On 10/31, Daniel Borkmann wrote:
> > > Containers use virtual netdevs to route traffic from a physical netdev
> > > in the host namespace. They do not have access to the physical netdev
> > > in the host and thus can't use memory providers or AF_XDP that require
> > > reconfiguring/restarting queues in the physical netdev.
> > > 
> > > This patchset adds the concept of queue peering to virtual netdevs that
> > > allow containers to use memory providers and AF_XDP at native speed.
> > > These mapped queues are bound to a real queue in a physical netdev and
> > > act as a proxy.
> > > 
> > > Memory providers and AF_XDP operations takes an ifindex and queue id,
> > > so containers would pass in an ifindex for a virtual netdev and a queue
> > > id of a mapped queue, which then gets proxied to the underlying real
> > > queue. Peered queues are created and bound to a real queue atomically
> > > through a generic ynl netdev operation.
> > > 
> > > We have implemented support for this concept in netkit and tested the
> > > latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> > > (bnxt_en) 100G NICs. For more details see the individual patches.
> > > 
> > > v3->v4:
> > >   - ndo_queue_create store dst queue via arg (Nikolay)
> > >   - Small nits like a spelling issue + rev xmas (Nikolay)
> > >   - admin-perm flag in bind-queue spec (Jakub)
> > >   - Fix potential ABBA deadlock situation in bind (Jakub, Paolo, Stan)
> > >   - Add a peer dev_tracker to not reuse the sysfs one (Jakub)
> > >   - New patch (12/14) to handle the underlying device going away (Jakub)
> > >   - Improve commit message on queue-get (Jakub)
> > >   - Do not expose phys dev info from container on queue-get (Jakub)
> > >   - Add netif_put_rx_queue_peer_locked to simplify code (Stan)
> > >   - Rework xsk handling to simplify the code and drop a few patches
> > >   - Rebase and retested everything with mlx5 + bnxt_en
> > 
> > I mostly looked at patches 1-8 and they look good to me. Will it be
> > possible to put your sample runs from 13 and 14 into a selftest form? Even
> > if you require real hw, that should be doable, similar to
> > tools/testing/selftests/drivers/net/hw/devmem.py, right?
> 
> Thanks for taking a look. For io_uring at least, it requires both a
> routable VIP that can be assigned to the netkit in a netns and a BPF
> program for skb forwarding. I could add a selftest, but it'll be hard to
> generalise across all envs. I'm hoping to get self contained QEMU VM
> selftest support first. WDYT?

You can start at least with having what you have in patch 3 as a
selftest. NIPA runs with fbnic qemu model, you should be able to at
least test the netns setup, make sure peer-info works as expected, etc.
You can verify that things like changing the number of channels are
blocked when you have the queued bound to netkit..

But also, regarding the datapath test, not sure you need another qemu. Not
even sure why you need a vip? You can carve a single port and share
the same host ip in the netns? Alternatively I think you can carve
out 192.168.x.y from /32 and assign it to the machine. We have datapath
devmem tests working without any special qemu vms (besides, well,
special fbnic qemu, but you should be able to test on it as well).

