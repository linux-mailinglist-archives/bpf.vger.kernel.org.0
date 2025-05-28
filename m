Return-Path: <bpf+bounces-59214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C5AC7446
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8FF1BC33B3
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E40221F2D;
	Wed, 28 May 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/9gpJeQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63627188006;
	Wed, 28 May 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473461; cv=none; b=BFamyE94kwtVXYrs5Xqk1C6TrG2d4V0ycFde2ZcsXHvk1o/HsyIkEbOQrl5GHRnSmhmvWXglaolzr2YupBUXshzZC59hFrgVPoAP2O5E2CyidajZVkdM3zShHrhBePt+4LFwo5vtSvQzxTdp1BvJXzYs7HpJMZtUh7SLA9BtZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473461; c=relaxed/simple;
	bh=+ai0y54uuyQ+w+1z+6J2zhVGMb2O/yjgKktck2/hOgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3F9CQqR1pda4C0/PlA4qslyoCnf/AiiJt+vAN1HBYCjw/YMJ6Opl8Urns+xGTy10vWB2977zI3Trfh04CnXI6/XNpqMMqbPQNRyu7P8nPY4VU3za3shOV5Gy8g0tD55JrpbOos2+H6V9uWUVsazEhIzOMN5WkI4c6NdDaYTSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/9gpJeQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3121aed2435so153367a91.2;
        Wed, 28 May 2025 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748473459; x=1749078259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2sp4j8hUuo5JLsN8/BURvi7Nkc+AGbFgOl/lmj7DHbs=;
        b=j/9gpJeQlxeNT5EGMc4YYM79tB6k2OlDrqzYDJIANfMcwbomvslQ3GvRkwbjShlaJn
         BbdQ9qXTq6JN43bGaSkRtR2LAawjFBKSHN5Pi8VlLLfAxjWp3FtPwq/qLa/3WmXGcGb0
         nX04JOigKcjWuR7tjtp6Dx2poNzoCo3OWAjgo5v7wTT8issXv7LZhywGLSBFgigNWS0D
         +DXcgltwEVbCTmfHMhXwIH/za+q0oJUmRtJBwt9J/mASJ3RySo117apunxfMNZYCHThq
         rMoNdCVN1xC9du0qw1aX+0fDl9vgj2dzt5ecRJ0PPdqx3DrhdbQeX1iHFULCbCa0PGSe
         JJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473459; x=1749078259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sp4j8hUuo5JLsN8/BURvi7Nkc+AGbFgOl/lmj7DHbs=;
        b=VWmu1N6ie1kOyf1NRJaE91lMnxonVJX7wbcbonPE0cEbs3oFyOboq4yl6barhNmruf
         4LbckBe6xxJQNSevQBSNKW1Ld09d2G5mGjKBKgDtLyHmcEG6Ap3lbl0VhftQWwwGRWiz
         zJI/oc1OY4C4x0DYaDwnw0AQrv+h7JVDFGc3NGFZBZRzQUFu4Bgat7vgxufNw2tmktem
         wvDNP0oq8rzjlYZfLOLf4stHCz9/GSmxlZIInFW9BTwcSdwT3zWcu/3DybuP7nkB0gF9
         MRN4WjDxE3oL77OwLA05irStUPvH/DgAVAibJyz6jKr7a7zkwhh0RLeEPkY/1SsJ6WNp
         qo8A==
X-Forwarded-Encrypted: i=1; AJvYcCUZw67ORkr4SLBCs6OB4/w/jc3QXtlECATarfxBDTm88s+YG8Q91cBGFQpXANiqpGSwoQOaEylIMBux4A==@vger.kernel.org, AJvYcCVMQ1i5eq4Te6F+PbwxxYG4yDKow88fLsezIzwEpdMbJjzApyB5FxzumLvWM5BSoONWdDWHZxjUP9adnwF0@vger.kernel.org, AJvYcCViRt3/9sqgrOVEZo6E0Z73hTf5NyWCsBJhKp8AZ5nbEfH1RrmSpr4icgdlq9zLGYlE+jw=@vger.kernel.org, AJvYcCX3nRLg8hsHpmq+4NKZqcyF5xtaoSCBsBhHmpEEBAYlXHDZlfpY8cQPf0H9SXJLTXndnkWdpxJq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KUWPZZeyq+P3g+4OUZiLpLSK4mfjYTtlNWVVs2VBuVfVmZV+
	uoul0K9R3InwngWoHhJ3ej88bsuoZczL+PQzzt5X6kqIGggUBL1j1gA=
X-Gm-Gg: ASbGnctkb6qtONqsHTvP/oI7NIkaTSDFMm4Czk5fKpa4NlZYCIyXLboZfJJ8KgObHCi
	tvtNVLExfaAid73pHSuSGb0tiWF8KWzb6GnE0FnCjWtIC2HLzLsDPJp4ZsQ6KZGAwfaJIAwvF0U
	qZ7qiiqRSskzKk8tOg2nGIaXIxg4+4HmFfuiV3zBhbAA3eyX5v9BuqHIjx/JimyNt/roJO5Z7Sw
	r0f0/nZjk7hRQ9tDrnLslZO144JQKr5RBeUWMx+zLx3LOk1j2q/mxqpAgmyZKgtju4bCIdfRzzX
	5kL3TeYpqsMLVYQ6ZV+xXRAtgmnoMbawNtrqWevSh/v2+ZJvvwRmRuwdN09YvFPJ45r28oxqWB5
	raQzG5xT8v/JeU6QKA67EbV0=
X-Google-Smtp-Source: AGHT+IHSxhR7xxHJFY8zi7jWzihGhAcFeIjQGJz3EIUMztBhyJx0Bl4c4FDPLS3+9R0q/l1cSrUJsg==
X-Received: by 2002:a17:90b:2e83:b0:312:1516:5ef1 with SMTP id 98e67ed59e1d1-3121dc21454mr47908a91.7.1748473459456;
        Wed, 28 May 2025 16:04:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3121b93b3c5sm171136a91.39.2025.05.28.16.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:04:19 -0700 (PDT)
Date: Wed, 28 May 2025 16:04:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
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
Message-ID: <aDeWcntZgm7Je8TZ@mini-arch>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <aDXi3VpAOPHQ576e@mini-arch>
 <izjshibliwhxfqiidy24xmxsq6q6te4ydmcffucwrhikaokqgg@l5tn6arxiwgo>
 <aDcvfvLMN2y5xkbo@mini-arch>
 <CAHS8izMhCm1+UzmWK2Ju+hbA5U-7OYUcHpdd8yEuQEux3QZ74A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMhCm1+UzmWK2Ju+hbA5U-7OYUcHpdd8yEuQEux3QZ74A@mail.gmail.com>

On 05/28, Mina Almasry wrote:
> On Wed, May 28, 2025 at 8:45 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 05/28, Dragos Tatulea wrote:
> > > On Tue, May 27, 2025 at 09:05:49AM -0700, Stanislav Fomichev wrote:
> > > > On 05/23, Tariq Toukan wrote:
> > > > > This series from the team adds support for zerocopy rx TCP with devmem
> > > > > and io_uring for ConnectX7 NICs and above. For performance reasons and
> > > > > simplicity HW-GRO will also be turned on when header-data split mode is
> > > > > on.
> > > > >
> > > > > Find more details below.
> > > > >
> > > > > Regards,
> > > > > Tariq
> > > > >
> > > > > Performance
> > > > > ===========
> > > > >
> > > > > Test setup:
> > > > >
> > > > > * CPU: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz (single NUMA)
> > > > > * NIC: ConnectX7
> > > > > * Benchmarking tool: kperf [1]
> > > > > * Single TCP flow
> > > > > * Test duration: 60s
> > > > >
> > > > > With application thread and interrupts pinned to the *same* core:
> > > > >
> > > > > |------+-----------+----------|
> > > > > | MTU  | epoll     | io_uring |
> > > > > |------+-----------+----------|
> > > > > | 1500 | 61.6 Gbps | 114 Gbps |
> > > > > | 4096 | 69.3 Gbps | 151 Gbps |
> > > > > | 9000 | 67.8 Gbps | 187 Gbps |
> > > > > |------+-----------+----------|
> > > > >
> > > > > The CPU usage for io_uring is 95%.
> > > > >
> > > > > Reproduction steps for io_uring:
> > > > >
> > > > > server --no-daemon -a 2001:db8::1 --no-memcmp --iou --iou_sendzc \
> > > > >         --iou_zcrx --iou_dev_name eth2 --iou_zcrx_queue_id 2
> > > > >
> > > > > server --no-daemon -a 2001:db8::2 --no-memcmp --iou --iou_sendzc
> > > > >
> > > > > client --src 2001:db8::2 --dst 2001:db8::1 \
> > > > >         --msg-zerocopy -t 60 --cpu-min=2 --cpu-max=2
> > > > >
> > > > > Patch overview:
> > > > > ================
> > > > >
> > > > > First, a netmem API for skb_can_coalesce is added to the core to be able
> > > > > to do skb fragment coalescing on netmems.
> > > > >
> > > > > The next patches introduce some cleanups in the internal SHAMPO code and
> > > > > improvements to hw gro capability checks in FW.
> > > > >
> > > > > A separate page_pool is introduced for headers. Ethtool stats are added
> > > > > as well.
> > > > >
> > > > > Then the driver is converted to use the netmem API and to allow support
> > > > > for unreadable netmem page pool.
> > > > >
> > > > > The queue management ops are implemented.
> > > > >
> > > > > Finally, the tcp-data-split ring parameter is exposed.
> > > > >
> > > > > Changelog
> > > > > =========
> > > > >
> > > > > Changes from v1 [0]:
> > > > > - Added support for skb_can_coalesce_netmem().
> > > > > - Avoid netmem_to_page() casts in the driver.
> > > > > - Fixed code to abide 80 char limit with some exceptions to avoid
> > > > > code churn.
> > > >
> > > > Since there is gonna be 2-3 weeks of closed net-next, can you
> > > > also add a patch for the tx side? It should be trivial (skip dma unmap
> > > > for niovs in tx completions plus netdev->netmem_tx=1).
> > > >
> > > Seems indeed trivial. We will add it.
> > >
> > > > And, btw, what about the issue that Cosmin raised in [0]? Is it addressed
> > > > in this series?
> > > >
> > > > 0: https://lore.kernel.org/netdev/9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com/
> > > We wanted to fix this afterwards as it needs to change a more subtle
> > > part in the code that replenishes pages. This needs more thinking and
> > > testing.
> >
> > Thanks! For my understanding: does the issue occur only during initial
> > queue refill? Or the same problem will happen any time there is a burst
> > of traffic that might exhaust all rx descriptors?
> >
> 
> Minor: a burst in traffic likely won't reproduce this case, I'm sure
> mlx5 can drive the hardware to line rate consistently. It's more if
> the machine is under extreme memory pressure, I think,
> page_pool_alloc_pages and friends may return ENOMEM, which reproduces
> the same edge case as the dma-buf being extremely small which also
> makes page_pool_alloc_netmems return -ENOMEM.

What I want to understand is whether the kernel/driver will oops when dmabuf
runs out of buffers after initial setup. Either traffic burst and/or userspace
being slow on refill - doesn't matter.

