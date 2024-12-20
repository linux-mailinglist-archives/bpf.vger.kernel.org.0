Return-Path: <bpf+bounces-47387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826119F8AB2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 04:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB00316B501
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 03:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B26F073;
	Fri, 20 Dec 2024 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3qWFqSH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F718641;
	Fri, 20 Dec 2024 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666660; cv=none; b=bduOaqEZPM+sfA3gDMno/NOESQh9nGOoYaH905wiHMoJaUuSk+eaOm5aV0jth4KsBOuXOyZvQBCAmGUep6wMHMKQhiP61dZ4o//XPNUDOy7ikgU2ZiJMSowiVUE0qFGCbxr3wYZrXBnfncgFimIlP2+htfGpkr8P/sNznCCWvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666660; c=relaxed/simple;
	bh=zcaXxBHqTnOZfVyt2pfXMG9/i1c5dgAO8SbvqZDHoxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3sKyjrlFUjL7Pa8kGe3BxNYjYm/4gg4KjhYh6uvY8S9lGpB0RGCags2cWKhcjEHhbZE8GaBdBVUemzUPo/WXaT97oZi389MmBuOygxsdr1opm2kU5MixDB5ema5Wz7sgDe6/7jqzoiQUQ4GFVMcTj2CZwijUzWXh4ux8/lWbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3qWFqSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C58BC4CECD;
	Fri, 20 Dec 2024 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666660;
	bh=zcaXxBHqTnOZfVyt2pfXMG9/i1c5dgAO8SbvqZDHoxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O3qWFqSHbyeiNqLfLZAF1kkogHCQQkkvpT66AZRr5ws67AXEXo6YBIanY4uu4s/P3
	 4xjOZv5JfecQ2/MZ7SKySX9Qsk2G5G/8cPyrlHSavcqgAqxD197jN2OSU3mxF5qYBc
	 SMCfLMp1sXf4jz/S5soeizADQRu92vhWJeo1TSZVHKHTls+yHb2sIn1CeRBTvUfy8m
	 KREF0HORnG45hm0UTIzLIljnbkk8ZvF2KEufhNwHtUd5mxKmXdNXNESn3qFbxUIoJA
	 x5D8wIlhxc4P8Tu6MrOKX1Qujs8ZEoDBoAMkQ8I2vH1Q4B6lsjCA2XDYj17pF+d+m8
	 0FTtvz3VWCoBg==
Date: Thu, 19 Dec 2024 19:50:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] xsk: add helper to get &xdp_desc's DMA and
 meta pointer in one go
Message-ID: <20241219195058.7910c10a@kernel.org>
In-Reply-To: <20241218174435.1445282-7-aleksander.lobakin@intel.com>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
	<20241218174435.1445282-7-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 18:44:34 +0100 Alexander Lobakin wrote:
> +	ret = (typeof(ret)){
> +		/* Same logic as in xp_raw_get_dma() */
> +		.dma	= (pool->dma_pages[addr >> PAGE_SHIFT] &
> +			   ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK),
> +	};

This is quite ugly IMHO

