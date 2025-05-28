Return-Path: <bpf+bounces-59213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0CAC7442
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3811C02359
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5613E2236EB;
	Wed, 28 May 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jei24ZVe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362992222D7
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473210; cv=none; b=hIM8uRBMjZjqHptW2I/GpprpbfTnwFZDyxrINCFBGyF59bQMW4zVxiMBzsCkp+mwkC3kqU1gJoQg2RKJdR3BvMAR/WwU3YhhU65EvbkNZxBjQ8JL/S9c7fgrKFBz7N/2wxfXS5kuEer5GlEv+5K/PttuLVurTd/rS2R3vNt9sdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473210; c=relaxed/simple;
	bh=3ja/7pjhYpVhznAyrWg1GMhS5AjUE5sAaHrB6yPPRtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioR8Rc+RgMnIJsUPK20oci/t0qHp45SihBIU4JK3QFGIhrgJaq1VYm5erN5VT4HxXE8A/SNrRKauQDEJ6b4ariXPe51W8R6J4ZkJbIt1DHgXsbFriePlNY3jSDRLL07oKqzmWZwNTL2FMcupjACIAWovFHgecLFwC67l7PZ0mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jei24ZVe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231ba6da557so39745ad.1
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748473208; x=1749078008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyrwrcKgw3GWmOoBKXzsCVfv7qouElSski6VKs1Vde0=;
        b=Jei24ZVeiOO/DwRUfI3EjEWHjBMTTz0F5y0p7guilGBW/PUm34G3JfSq0fZnfsrVk4
         y0IYTqhYVWtN7v3jvzJ+P4xdaiYZpVs73paT0OPm+hQdzuI4QVLPgBUFPXzNeWyW9wNC
         g+z73W449MVvm5wQPBrp43K5C7I8hPXR88O1NWuxlmsJonID53rCUdYlR5TTKUtR16gN
         nI7Z9Y4mCM/V2f0at7VMgV0Vqgblvy7pejogfGo5bUv2LQdCprcg5oBznFSQg6I1rek8
         yQp3SgPP2Fe1BAmQlTuziPY8h9qzgJONB4+U33xXWPGm58kGpRfGOkgmQVfdec45cQDk
         a8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473208; x=1749078008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyrwrcKgw3GWmOoBKXzsCVfv7qouElSski6VKs1Vde0=;
        b=mRrXY9EPQJOplbhS9FDSk86+LhhX2hnQOxCxx+fvZ1IZ49L9h432pMCi3HxrNd8NVQ
         oYs7L8Vr5ByGbtfS/Tsf6P8gMhBw2v1VUJEgc1lA/APIBEnM3mpaiSTHnjJZXBh8kq0V
         Wn7PEezvm3vpS0zmuQL6jcegK21HgY3/wiz5KT3p11pAbNuvynWIyiutyuRGjXudkXCq
         y7TeyqmVeBlcqmkq1rT6wrRQInl/PIrD2NpBACVcGzUuJNCr1JWTDC6qL/H0RbYuzW0T
         YJjtQ35eXg9Fyk2cN41dP+DYdj5nORHKVh/yc79Nu60zH/BnaxB61X9Jp6XkncfA8poq
         54eg==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ83kQfLuHvZLt4bm9JNDMP9g4yzlTozTG8P8RbGAXBDwYjZQTqvbuikTWdjvu8NnKPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbk4RPIWM6q/44MR8CW0Lj98zwio6xkfkHnFY574S0B+syPbTD
	XrQxmrGyn7t5NhtJ0iBX6teRRowFxGPG9vjk1cc5BAYOEXirjwBdW6BaPrRFSEaNdEYlexpEFQo
	3yfzziWEgE015XP07H0iVovDH2Lqqq3mUnd890MOg
X-Gm-Gg: ASbGncvO2FdS+H5tK8VTF2IHhMlI8zvJ+WLAWNrvvsXhLVd/2CwqNp5CfxNG/a/5EYA
	bn3pnoj1AVF/CA9jQA3FQpKRFQSscgLM5WF8goJK7gc0yRm4Ul0iNjsm6wdWBx7W2HdOFDNHO0B
	bja0dvAnQwamQLOiuGZtBmCAWW4/LWwsC1c4nVTn8C7sB4E8bbcjVq4YSh524kcXlCUlYNSwH/r
	HpefUyVjZGZ
X-Google-Smtp-Source: AGHT+IF9RSIu2Agv8OM5GN9jL96VyCN37lz85qfAqjUiJLgied1N7IKt/ksuB4tT0CTY5d7MnJAyQVrlMbM7Cymyzco=
X-Received: by 2002:a17:902:f60d:b0:234:a734:4ab9 with SMTP id
 d9443c01a7336-23501b91ae9mr1145705ad.20.1748473208055; Wed, 28 May 2025
 16:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <aDXi3VpAOPHQ576e@mini-arch> <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>
 <aDcvfvLMN2y5xkbo@mini-arch>
In-Reply-To: <aDcvfvLMN2y5xkbo@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 May 2025 15:59:55 -0700
X-Gm-Features: AX0GCFvJK7-EQq9tYH-o39pB6QkCNRWG5v8pYmEJTC9dd4cC3U1cvbbtJbu6Xkw
Message-ID: <CAHS8izMhCm1+UzmWK2Ju+hbA5U-7OYUcHpdd8yEuQEux3QZ74A@mail.gmail.com>
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:45=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/28, Dragos Tatulea wrote:
> > On Tue, May 27, 2025 at 09:05:49AM -0700, Stanislav Fomichev wrote:
> > > On 05/23, Tariq Toukan wrote:
> > > > This series from the team adds support for zerocopy rx TCP with dev=
mem
> > > > and io_uring for ConnectX7 NICs and above. For performance reasons =
and
> > > > simplicity HW-GRO will also be turned on when header-data split mod=
e is
> > > > on.
> > > >
> > > > Find more details below.
> > > >
> > > > Regards,
> > > > Tariq
> > > >
> > > > Performance
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Test setup:
> > > >
> > > > * CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
> > > > * NIC: ConnectX7
> > > > * Benchmarking tool: kperf [1]
> > > > * Single TCP flow
> > > > * Test duration: 60s
> > > >
> > > > With application thread and interrupts pinned to the *same* core:
> > > >
> > > > |------+-----------+----------|
> > > > | MTU  | epoll     | io_uring |
> > > > |------+-----------+----------|
> > > > | 1500 | 61.6 Gbps | 114 Gbps |
> > > > | 4096 | 69.3 Gbps | 151 Gbps |
> > > > | 9000 | 67.8 Gbps | 187 Gbps |
> > > > |------+-----------+----------|
> > > >
> > > > The CPU usage for io_uring is 95%.
> > > >
> > > > Reproduction steps for io_uring:
> > > >
> > > > server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
> > > >         --iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2
> > > >
> > > > server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc
> > > >
> > > > client --src 2001:db8::2 --dst 2001:db8::1 \
> > > >         --msg-zerocopy -t 60 --cpu-min=3D2 --cpu-max=3D2
> > > >
> > > > Patch overview:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > First, a netmem API for skb_can_coalesce is added to the core to be=
 able
> > > > to do skb fragment coalescing on netmems.
> > > >
> > > > The next patches introduce some cleanups in the internal SHAMPO cod=
e and
> > > > improvements to hw gro capability checks in FW.
> > > >
> > > > A separate page_pool is introduced for headers. Ethtool stats are a=
dded
> > > > as well.
> > > >
> > > > Then the driver is converted to use the netmem API and to allow sup=
port
> > > > for unreadable netmem page pool.
> > > >
> > > > The queue management ops are implemented.
> > > >
> > > > Finally, the tcp-data-split ring parameter is exposed.
> > > >
> > > > Changelog
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Changes from v1 [0]:
> > > > - Added support for skb_can_coalesce_netmem().
> > > > - Avoid netmem_to_page() casts in the driver.
> > > > - Fixed code to abide 80 char limit with some exceptions to avoid
> > > > code churn.
> > >
> > > Since there is gonna be 2-3 weeks of closed net-next, can you
> > > also add a patch for the tx side? It should be trivial (skip dma unma=
p
> > > for niovs in tx completions plus netdev->netmem_tx=3D1).
> > >
> > Seems indeed trivial. We will add it.
> >
> > > And, btw, what about the issue that Cosmin raised in [0]? Is it addre=
ssed
> > > in this series?
> > >
> > > 0: https://lore.kernel.org/netdev/9322c3c4826ed1072ddc9a2103cc6410606=
65864.camel@nvidia.com/
> > We wanted to fix this afterwards as it needs to change a more subtle
> > part in the code that replenishes pages. This needs more thinking and
> > testing.
>
> Thanks! For my understanding: does the issue occur only during initial
> queue refill? Or the same problem will happen any time there is a burst
> of traffic that might exhaust all rx descriptors?
>

Minor: a burst in traffic likely won't reproduce this case, I'm sure
mlx5 can drive the hardware to line rate consistently. It's more if
the machine is under extreme memory pressure, I think,
page_pool_alloc_pages and friends may return ENOMEM, which reproduces
the same edge case as the dma-buf being extremely small which also
makes page_pool_alloc_netmems return -ENOMEM.

--=20
Thanks,
Mina

