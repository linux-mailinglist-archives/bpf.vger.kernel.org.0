Return-Path: <bpf+bounces-64228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E737AB0FE2B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 02:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A995833C6
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C96347D5;
	Thu, 24 Jul 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlRisgsX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0717996;
	Thu, 24 Jul 2025 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317040; cv=none; b=OpdCSUtQ9N/up6MQGo3D7Vd7VWKIlrOHdwpF6ACs/BPBUqVE6VB+U9cEIooPF0r/XGTIHVVRcjmsFPi8RX3yOdQLfTPd/2LWV3SzpX6Z4PnXbabAxfZm7bxqPj+N9qE5U/WB5Rw8neAfbzrcFMzJp9CjToldX3w2vtjFEFfc3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317040; c=relaxed/simple;
	bh=XGZboLMQ3b5Ai4S4j+Ya+XOzglf9Zvxo7yDy4nIOKIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiEm+SHn/cU/8BPS4DFkNom4ETCg71Obqnxl7iGakalj00xoBhtYmdBZIQzPNF/hCkJAWMZfXBPIOe/8i57nUYDz80W2vNynaXqvqgtetRz0uKi1bpl/J9xF+Y+LZpTk64PTv6p57/1+mhjmRdg6TvOzFGaDSlq3F2fXYcyu3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlRisgsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D922FC4CEE7;
	Thu, 24 Jul 2025 00:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317039;
	bh=XGZboLMQ3b5Ai4S4j+Ya+XOzglf9Zvxo7yDy4nIOKIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlRisgsXMCGjdQ+AoOOeRV46sZvbu6zFR0hseeM063slHXUz6bTiVPdS+SYs22fuZ
	 uc0mU4zpEaqN8WqY0/yJpSaSb1eqCNVmTCYrUJ5StvbPiY4r9UP6zTQ7LDJv8rJd4m
	 tc9X6pJwLT1fzpLDHbQn477BCDplm86FEgJtGo+Wb+12Fl8e9loEUf2b0aN9Pg94nS
	 PLYHPAmVlS9SuSy8MrBCKvZWmUOVfiPqGDX8ns9Idd9vEYev39potQEsfOZmPDfioO
	 xBflcw0B7tFVJSbEMHsrHtdu7KtGdPWl/hMMg0kuy27VUmZNqvgsaEVGAf4ds3K/dE
	 OUCGIXrS8OwqA==
Date: Wed, 23 Jul 2025 17:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?=
 =?UTF-8?B?bg==?= <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
Message-ID: <20250723173038.45cbaf01@kernel.org>
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 19:36:47 +0200 Jakub Sitnicki wrote:
> Now that we can create a dynptr to skb metadata, make reads to the metadata
> area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
> make writes to the metadata area possible with bpf_dynptr_write() or
> through a bpf_dynptr_slice_rdwr().

What are the expectations around the writes? Presumably we could have
two programs writing into the same metadata if the SKB is a clone, no?

