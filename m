Return-Path: <bpf+bounces-49148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B820EA14766
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC57416C054
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E561F95A;
	Fri, 17 Jan 2025 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIdN/Ms1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058710E4;
	Fri, 17 Jan 2025 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076264; cv=none; b=q9FRf3o0guHctDDBP/ihlywWMDfS07FiaT1dUW9GNtO/v5P8vmykRpZagNvCmj7AWXx3QO4fEUiZgFAdkhjjU1zlJQp0eNCpvDqlUmJasRI2b+W2Kd1v0mt6zgQqDhF9+EqJLPPNhsysy/bIc4jr0hnqSVBO29246+kYXdLQB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076264; c=relaxed/simple;
	bh=J6R/py7eeZ92qAGAR/7aoeC36jdbsofwkFC90dPm0/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoO0RX0pj8baHnEht4hKFcr7S6kePO1XjoqJYrbn7YpaGvq6ponstTR8bPf543LPvFZuaICWSsF4IhkAZZkRWcLwUnIgWVHvkpJlHcvGOkzuEsO9e9Mn8ucKRwymDhrun4/tANpaC2hfApWTwoJgP5EjyVYdcW5QfdQqMnLMWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIdN/Ms1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B87C4CED6;
	Fri, 17 Jan 2025 01:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076264;
	bh=J6R/py7eeZ92qAGAR/7aoeC36jdbsofwkFC90dPm0/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIdN/Ms1OYimLyZEGur8AFQ7ppAeV9JehYVSIGwReLG2f2CvNjlVQ4Fp8wdAXmqPf
	 l4WIRXNedDIQbMeXPr3w0jzm8sEWYjNdFNxbZL6Y9T/inJzEVLPSUW9Gt1etlxTb14
	 b7mSlXcXRVuuO3fKiGlasbMfeiq6KTIOvVkqBhU5fjrUVyNkSMEBrVh5Kc2PsPl5QD
	 d2tW7MQOrf2wGTLGonpFqbNq0qjToHe6lYbtGSipWIAmrPyUg6kIK/Yx96c/jveDvt
	 7UbvDA1cPEGhfQRZYaBYYtjpTFYNVFZxLmnxFjxN8LTV2Rj5iUIdskiv/pwc3irE5f
	 Qxe9gm/AJIaKQ==
Date: Thu, 16 Jan 2025 17:11:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] net: gro: decouple GRO from the NAPI
 layer
Message-ID: <20250116171102.47be0ded@kernel.org>
In-Reply-To: <20250115151901.2063909-2-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
	<20250115151901.2063909-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 16:18:54 +0100 Alexander Lobakin wrote:
> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>    (u32 napi_id + another 4-byte padding).
> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>    into two functions or add an `if`, as this would be less efficient,
>    but we need it to be NAPI-independent. The current approach doesn't
>    change anything for NAPI-backed GROs; for standalone ones (which
>    are less important currently), the embedded napi_id will be just
>    zero => no-op.

Fine :)

Acked-by: Jakub Kicinski <kuba@kernel.org>

but you need to rebase..
-- 
pw-bot: cr

