Return-Path: <bpf+bounces-62566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A8AAFBE20
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA509188BF71
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB028B7DA;
	Mon,  7 Jul 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Dxcj3pOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC951F1302
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926027; cv=none; b=fgPYTtqP3hpd80SKp3Dzzsbmy2Ydipj/KPfvYk3ck/QPG8mZQBKF5v8bax8TX+fSdGZBIoxURZMl1n4KPu/scquJe1lILD/5oVTjl1mJ5lXCAsu8PenyAod8nH439Sz8OvdvRPHuT6r6neVAHWbX0QX0g4/PtTHjvcQwWmvHafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926027; c=relaxed/simple;
	bh=2CePHKqoGmwfYfDlHzvg06c1YcP12ndsDwRMN9J337g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW5AYRolP4caAiZPTwiB3nViV1NSZwOJjETnhkfDtqTNVGRkThtzB/0p8QEx7oJj2dvWSRhZTlkaiDQoorolWfleF0Gg0Mm5wPD6qMuHNOsUgw//kTRd7gQeymzUWnTLxg7Wh8OxhNs6lbNeVaFkaGFfqYXeOGJA+4EiUkEHSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Dxcj3pOC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-73af5dc0066so940586a34.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751926025; x=1752530825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwKWUSnF0lzwVdGs0An+rVvS0EXVok8+0wgY2PEYFg4=;
        b=Dxcj3pOC2byEnQRPbMaq3ENIoVkIttnZOpgKPLQdADgZqec7ZFK6HBNzHqsOYKUBZV
         ErrrVEcCgzY8+YBbeBXeRb2oPj32A/OU/8VVo2ofGFNLDRf4RbJ4sD/nzuMlBirBw0cr
         7ni8Ic8ua0ISw7FUQF5qOd/EgjKfSsaikCBM6RoLTB7pkTKxQBuTduwO9pkEeSTkRpIs
         gEyaPvbwnDn8p413slkSTUl607u30bLkdmeDTyH6/kyA5vYHLqvMlW7ilu0+jng0vDGx
         bVUFOkN3ept1kqXxA5EFazC3A8+jcSVA54YuYVQDM+d0QOo0J7GPvNDwUWEP/v6R0AsQ
         XRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926025; x=1752530825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwKWUSnF0lzwVdGs0An+rVvS0EXVok8+0wgY2PEYFg4=;
        b=J55FKb9ReIe+y22fEhODcMEhWCd7TfqhM7eQu+RAh66ouqk5hcL0WHpuML+T/jwj8n
         qNi8r0QnfgfneYe+B2tNosGvvQAa+Y13rpfx9nvcLedWZBsiojqOgOw+1sUewgOORQuc
         C9uFavEoskepFnIrsVwOmcr4sqxtgafQmtNbuIokoTMCYb5UUAAwdV4UXrKWZmJnsPn+
         P9JueQFQ21jdMbbKmxBCWQGPRP3fim+bKN7Xt8jk7jeWjFnGN8WGiny63E39LGkMvBzq
         4SFRoS5/gKkRfucEBxWMC0Yv/c+vAsguB5I8U7Lok//ek2J5z95yEmZyxG8+zb9lqxQb
         jFTw==
X-Forwarded-Encrypted: i=1; AJvYcCXgKbnK05tkwmrhgAQEYtYfuYwhRE3tUsXsFjtGcHWoj3Uk3YxSl6JBJ11VKYFjqpvXy/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4MDLuzNmaco9yMPqh8O0Qguy1ugxbqQyvNkvPGsZ3SjEKWnC
	jWDeYZQLm17NHEfkvCl9qcvR/NWaQoWPfyB9OnpqMRXQcpfOMsHhRpXwkOXyt1VdsYs=
X-Gm-Gg: ASbGncuo49ADz3r+MpIV1U2fzx7O9M440a4EiJg4tIUD/vTHpJnzjrYF2zNIDRGV0qW
	UQ/gWKEshZkpySUAXJUB3BP2nB2Zqve2D5apxkpAEbW59YjsHaXjBWAxZj+nzvyTpHVDEsxclBn
	6beuMkFCRlErT4MiZdi3+TolU/Jq0Ln09nfuc5B17qWVtTJ9tT2Jxo70LiwG6cuCjkdscKRK1O1
	ogYjUIfy/K6yxPJYhbi+1gS2bifwzGldQ21/c8IT5VmNGykhX4qLkb+tBG4+C9890B5q09AHIn1
	5c4Mw4m0z1UICP0+a3/QJlurF0FLfR4ghSn1s6lzqEtIXQ==
X-Google-Smtp-Source: AGHT+IEqx803zdcRO6xOM0Bcpmkx8P7kV+CaRWkmkuUcqwXwJgab4Kj1w88FgT4Jm4rpb7I0vp3cAg==
X-Received: by 2002:a05:6830:6b0c:b0:72b:992b:e41 with SMTP id 46e09a7af769-73cd66621a9mr693561a34.23.1751926025157;
        Mon, 07 Jul 2025 15:07:05 -0700 (PDT)
Received: from 861G6M3 ([2a09:bac1:76a0:540::22e:3a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90e8adsm1708279a34.41.2025.07.07.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:07:04 -0700 (PDT)
Date: Mon, 7 Jul 2025 17:07:02 -0500
From: Chris Arges <carges@cloudflare.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com,
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Rzeznik <arzeznik@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <aGw-2geTw7Y0UXg2@861G6M3>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <md46ky57c74xrw2l2y5biwnw4vzgn6juiovqkx7tzdwks6smab@vpfd5hmclioa>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <md46ky57c74xrw2l2y5biwnw4vzgn6juiovqkx7tzdwks6smab@vpfd5hmclioa>

On Fri, Jul 04, 2025 at 08:14:20PM +0000, Dragos Tatulea wrote:
> On Fri, Jul 04, 2025 at 12:37:36PM +0000, Dragos Tatulea wrote:
> > On Thu, Jul 03, 2025 at 10:49:20AM -0500, Chris Arges wrote:
> > > When running iperf through a set of XDP programs we were able to crash
> > > machines with NICs using the mlx5_core driver. We were able to confirm
> > > that other NICs/drivers did not exhibit the same problem, and suspect
> > > this could be a memory management issue in the driver code.
> > > Specifically we found a WARNING at include/net/page_pool/helpers.h:277
> > > mlx5e_page_release_fragmented.isra. We are able to demonstrate this
> > > issue in production using hardware, but cannot easily bisect because
> > > we don’t have a simple reproducer.
> > >
> > Thanks for the report! We will investigate.
> > 
> > > I wanted to share stack traces in
> > > order to help us further debug and understand if anyone else has run
> > > into this issue. We are currently working on getting more crashdumps
> > > and doing further analysis.
> > > 
> > > 
> > > The test setup looks like the following:
> > >   ┌─────┐
> > >   │mlx5 │
> > >   │NIC  │
> > >   └──┬──┘
> > >      │xdp ebpf program (does encap and XDP_TX)
> > >      │
> > >      ▼
> > >   ┌──────────────────────┐
> > >   │xdp.frags             │
> > >   │                      │
> > >   └──┬───────────────────┘
> > >      │tailcall
> > >      │BPF_REDIRECT_MAP (using CPUMAP bpf type)
> > >      ▼
> > >   ┌──────────────────────┐
> > >   │xdp.frags/cpumap      │
> > >   │                      │
> > >   └──┬───────────────────┘
> > >      │BPF_REDIRECT to veth (*potential trigger for issue)
> > >      │
> > >      ▼
> > >   ┌──────┐
> > >   │veth  │
> > >   │      │
> > >   └──┬───┘
> > >      │
> > >      │
> > >      ▼
> > > 
> > > Here an mlx5 NIC has an xdp.frags program attached which tailcalls via
> > > BPF_REDIRECT_MAP into an xdp.frags/cpumap. For our reproducer we can
> > > choose a random valid CPU to reproduce the issue. Once that packet
> > > reaches the xdp.frags/cpumap program we then do another BPF_REDIRECT
> > > to a veth device which has an XDP program which redirects to an
> > > XSKMAP. It wasn’t until we added the additional BPF_REDIRECT to the
> > > veth device that we noticed this issue.
> > > 
> > Would it be possible to try to use a single program that redirects to
> > the XSKMAP and check that the issue reproduces?
> >
> I forgot to ask: what is the MTU size?
> Also, are you setting any other special config on the device?
>  
> Thanks,
> Dragos

Dragos,

The device has the following settings:
2: ext0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1600 xdp qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 1c:34:da:48:7f:e8 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 9978 addrgenmode eui64 numtxqueues 520 numrxqueues 65 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536 portname p0 switchid e87f480003da341c parentbus pci parentdev 0000:c1:00.0
    prog/xdp id 173

As far as testing other packet paths to help narrow down the problem we tested:

1) Fails: XDP (mlx5 nic) -> CPU MAP -> DEV MAP (to veth) -> XSK
2) Works: XDP (mlx5 nic) -> CPU MAP -> Linux routing (to veth) -> XSK
3) Works: XDP (mlx5 nic) -> Linux routing (to veth) -> XSK

Given those cases, I would think a single program that redirects just to XSKMAP
would also work fine.

Thanks,
--chris

