Return-Path: <bpf+bounces-51292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B650A32EAF
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AC3162985
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BF925EFA3;
	Wed, 12 Feb 2025 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF44JGYY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942E2116E0;
	Wed, 12 Feb 2025 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384978; cv=none; b=rKvJqCOzJGX8JLKP8kGYGcmPIQ/js1dx16KhOERP8cnASiZVkKKsQ2anFOfCdtvulQC3PxhOwdi1vKIrBMgEDIjshHabrcm3pF3eUMiuByYaEFGFeSveTxDIwYWq47fk61+/i0Sq2d6v547j/FhIGw2begL2JO77YEkO7IjVOBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384978; c=relaxed/simple;
	bh=/sWCr49y4RKiGymT+GIb+7irPIxq1eSs9+acjXDs/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArrCe2dfCe9MM4Dcz4I1QisX4tgM1BCQfZW26yrSVdhY9ogxciD5WIiQXBnQzqZPTVA94TaUKxaqO+26eivRuVG+Ndne1VaJ+XdTx/gruH/Yh7ss1b8BaqAXKTb9bLREZksxqCSahmZqFqgmkpkjEaBGJJtb3aqKoerTXCv63zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF44JGYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BF9C4CEDF;
	Wed, 12 Feb 2025 18:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739384978;
	bh=/sWCr49y4RKiGymT+GIb+7irPIxq1eSs9+acjXDs/Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eF44JGYYDXc5yymVFpeGzq0PrSiCXOlTo/i9DbrI2F/C//8gq+ZsXqdp5uKKoJCen
	 MQYu05o3kXklsCW1AvkGPoFYi6UPN2JlGWEpgh94QLtTzRrQp6G+Hln0zlwlT7W35L
	 GSZJ8NPCdQA6w2sYxDGz9/8ELHKDdb2k6oa3otqXOgF1L9+uT5zxKEEixT4PQdK9M3
	 1Wrm4Iiim0Kj6j4rJ5IINbqvPCwfJRuiHwWtkQ3ex0C3p70q7KXpf18hGZdqAhN2Ic
	 XuEQ5W/0HH5MsGrlDdOerdd2TOb3g44uU9T63hDCXo1W2HjBK22meNUZSmACH5igLy
	 f/7IYXHsTgM4g==
Date: Wed, 12 Feb 2025 10:29:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
Message-ID: <20250212102936.23617f03@kernel.org>
In-Reply-To: <1dd14ece-578b-4fe6-8ef1-557b0f5d3144@intel.com>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
	<79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
	<CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
	<7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
	<20250210163529.1ba7360a@kernel.org>
	<0a8aac38-a221-4046-8c8a-a019602e25dc@intel.com>
	<1dd14ece-578b-4fe6-8ef1-557b0f5d3144@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 16:55:52 +0100 Alexander Lobakin wrote:
> > You mean to cache napi_id in gro_node?
> > 
> > Then we get +8 bytes to sizeof(napi_struct) for little reason...

Right but I think the expectation would be that we don't ever touch
that on the fast path, right? The "real" napi_id would basically
go down below:

	/* control-path-only fields follow */

8B of cold data doesn't matter at all. But I haven't checked if
we need the napi->napi_id access anywhere hot, do we?

> > Dunno, if you really prefer, I can do it that way.  
> 
> Alternative to avoid +8 bytes:
> 
> struct napi_struct {
> 	...
> 
> 	union {
> 		struct gro_node	gro;
> 		struct {
> 			u8 pad[offsetof(struct gro_node, napi_id)];
> 			u32 napi_id;
> 		};
> 	};
> 
> This is effectively the same what struct_group() does, just more ugly.
> But allows to declare gro_node separately.

