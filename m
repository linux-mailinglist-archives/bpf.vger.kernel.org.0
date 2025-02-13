Return-Path: <bpf+bounces-51352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C7A336BB
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FE63A745B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9925A2063DC;
	Thu, 13 Feb 2025 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulJj7GnK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAF205E0B;
	Thu, 13 Feb 2025 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420073; cv=none; b=Tchgxe0f2LHGw5RgqCmOzXRESZeYPeNeJWLFoa7cJ9ZkfoEKWw3I94saZTEi6XNac8tDOWudn6+1Pv4eRwo512EgA5tzVsC7GuKgB+IJomGpUHeF6e0FfhiEYbSIjfFslpdN6xrbkzIsYvL207M4MT9+BLOvEVarkf8SbG7VJTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420073; c=relaxed/simple;
	bh=58Bzdokx7tiueOMeiMxU3AG2JHoBNNh+X3sxXba91X4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRAsQhljv2MqEvANeDnuHENjluHt+eM2Zc+1hT8UWhzIaZrjCQxGj5D3ZGE84XISkU/pKtThPGIaBl3S0BAkHnBhB7QFTQX6j6298US6BCwhT7pD+nVmAJWJmKJAqQrFkFyoKXj4ytR7fq/ZFue+FFvY2t0NlIMsyf1vyaD+yTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulJj7GnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B53C4CED1;
	Thu, 13 Feb 2025 04:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739420072;
	bh=58Bzdokx7tiueOMeiMxU3AG2JHoBNNh+X3sxXba91X4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulJj7GnKRHEI1Hvnm/5qQ9PTuZ0Tta8Fv/0HhTDKNF/GVk6xYr/QUFEJw0WEEmKE7
	 MqYFu3VNNbNQjq6VfOMk9SWHxt5ZvQ1L3niwLnMCR3K9t7LjmNNPGVmbRF6xqm2YAp
	 uJDo8xp4FuFPOkfIUTViOPlPGdrEILQyw2kmSDguLdEiFAv9wVLM+MER2OE1ef03Ea
	 sZcILjKUw9JLgl9sOnDe7UNi0oI6txmGg+bjZzb6fqAHrRT1ILky2sfjbSIPtoJfNh
	 PxZSXb4Ux/4phZlgqLDoWQmbDn4mkd1JVKkASe6m/dZ4GkGKCrJS20P7xw1z/wfxBp
	 N/xS2VQ108smw==
Date: Wed, 12 Feb 2025 20:14:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Julien Panis <jpanis@baylibre.com>,
 Jacob Keller <jacob.e.keller@intel.com>, danishanwar@ti.com,
 s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: ethernet: ti: am65-cpsw: fix memleak in
 certain XDP cases
Message-ID: <20250212201430.5bfaecc7@kernel.org>
In-Reply-To: <20250210-am65-cpsw-xdp-fixes-v1-1-ec6b1f7f1aca@kernel.org>
References: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
	<20250210-am65-cpsw-xdp-fixes-v1-1-ec6b1f7f1aca@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 16:52:15 +0200 Roger Quadros wrote:
> -		/* Compute additional headroom to be reserved */
> -		headroom = (xdp.data - xdp.data_hard_start) - skb_headroom(skb);
> -		skb_reserve(skb, headroom);
> +		headroom = xdp.data - xdp.data_hard_start;
> +	}

I'm gonna do a minor touch up here and set the headroom in "else" hope
you don't mind. Easier to read the code if the init isnt all the way up
at definition. Also that way reverse xmas tree is maintained.

