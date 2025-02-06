Return-Path: <bpf+bounces-50596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1FA29F05
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7F53A6D68
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824861482E1;
	Thu,  6 Feb 2025 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho/QCs5h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A21DF60;
	Thu,  6 Feb 2025 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810607; cv=none; b=RG9Z7KJE5T3gxgPJmUIzv2JENkI9qmJBKuaxLZ867tQOj43k/B8VacL+CNCp4Sx3OuZqILisUVBzqVyUPoxXmkmh/pkhLsI5JK3nJDG07o4J5jSNH7iBKww/PqY7lw4Co5IbNHSMs//508xiGX0LgPRgTKqnvVnkCyQOEPHuD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810607; c=relaxed/simple;
	bh=AxTvfcbhpyggT28jMmsnd7/+ETqOiR4Qs2lCMDe15l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVKz/KJeVnV3FFMZK2MJfAFFqbMTv8U+GV077Su/HG7y3zL1DqiqbC0ffuYgf54fBQFb7FRaGWs8k6QmZHkHWpTHJVuCAFn/1BdLH7NM7UaszarBNSOpCOFwXEIOaNyqhHvap5nnHWLqSzMAzA1lgUViozywTpoRqnQ9LuX04i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho/QCs5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7A5C4CED1;
	Thu,  6 Feb 2025 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810606;
	bh=AxTvfcbhpyggT28jMmsnd7/+ETqOiR4Qs2lCMDe15l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ho/QCs5hELsBiIeYuSMwd5zWhfFiXJr40+JxZWR3JtFrpIUhgEXbsKiHW7T73X56J
	 qsdehYpJyxjLjQm6VzqiL1KAXdV4TntW3Iy52IrDXMX+rL2kH/tS4kj+ckjO+o4w5k
	 fHYOETBK8GxBPY3FcNAKLOXTrGiXTNG8K4BqqfTO00IkKis/5zeMB0Dl5P+NbivKuW
	 PuM6n1wUbnfR5PbGRZJu6XIBYkmzity/B40yxmQbBoJc2R+IszmRimI5VtlZuOEQTW
	 h7oN5hwVSEdjC9UKtIuoXSW2G7FYpkw7/3p1vG1KfGvsObq2H+P8ns/4k/PcbDYG9X
	 f6jSWNEHp8CoQ==
Date: Wed, 5 Feb 2025 18:56:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI
 layer
Message-ID: <20250205185645.51fd5f1f@kernel.org>
In-Reply-To: <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
	<20250205163609.3208829-2-aleksander.lobakin@intel.com>
	<CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 18:48:50 +0100 Eric Dumazet wrote:
> > +       struct_group_tagged(gro_node, gro,
> > +               unsigned long           bitmask;
> > +               struct gro_list         hash[GRO_HASH_BUCKETS];
> > +               struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
> > +               int                     rx_count; /* length of rx_list */
> > +               u32                     napi_id; /* protected by netdev_lock */
> > +  
> 
> I am old school, I would prefer a proper/standalone old C construct.

+1, fwiw, I thought it was just me..

