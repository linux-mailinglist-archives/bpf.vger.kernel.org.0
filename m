Return-Path: <bpf+bounces-26423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C389F428
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D0A1C20C6A
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30515F40D;
	Wed, 10 Apr 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eaok+4aH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F4B15F3F4;
	Wed, 10 Apr 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755454; cv=none; b=D6HWwzr+MBGLrzWOGAsVpHV6+9UnVn8PUldVKdEqNbjm5dzn4Jl25h6gyq8ciOIYlT20wybaSZggdNs4PmO0fON2Nj82kakUn+fdYmnJd9p06OJeD4sMFCbMI36WFnVAlHd8KjMoHW2YemsJj6c0tMkBQEJSaqZqBrB+7W1eQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755454; c=relaxed/simple;
	bh=WNjHEnZYwyX9uPtDNGEk3WQ8G2R5IDZTvmlqm+KjAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biQbzswzLB8++EZzG4YT8WmS0mYCSjdH8aL6koahrkRNxdNGxz1eMWQawhxxqH3u0ZObHHU0EypFR5xt4DY3wjhDg5oBqEL4bkIo95x222JEOqbVA4Lb+1asIMHoZeJTiZCZsF7dZXFz9CZXpr1Zuop1T7ELWgaH5f3F4Tua5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eaok+4aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937DEC433C7;
	Wed, 10 Apr 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755453;
	bh=WNjHEnZYwyX9uPtDNGEk3WQ8G2R5IDZTvmlqm+KjAj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eaok+4aHCN8wUZsm/y/+J4rMX5hOhpAUn+GHi2BkviKOJj4O6qyRbFsHL0J9wQuCZ
	 560bix0pr3PEB/C9zVVqMNGYqnP4ZoKcqkWr1p2f+nFAGK8cJ7spiwTQOswhxqvExb
	 Ryx/qOriQaDG4VeHIrGx1qnyG/YSzsFgGkQWmBGyL4UaIR7rjlnyS7aLURSgStOPRY
	 SCieJNwJtB9OYFZ1/2Go6Ge3afIsIHlWx3mV25b1kHMwjmywQ6pefbCWzol/PP87Y/
	 P/+zK//v1smceidm0Nxh1TQiamFqM5w8nkfg9wUQRY2J0yhk0TLMGTRXQjBMLJpTLZ
	 4KB0dvQbOnRlg==
Date: Wed, 10 Apr 2024 06:24:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Ratheesh Kannoth <rkannoth@marvell.com>, Naveen
 Mamindlapalli <naveenm@marvell.com>, danishanwar@ti.com,
 yuehaibing@huawei.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v8 2/3] net: ethernet: ti: Add desc_infos
 member to struct k3_cppi_desc_pool
Message-ID: <20240410062411.1096c881@kernel.org>
In-Reply-To: <6f356fec-4384-4367-8812-a18b71156116@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
	<20240223-am65-cpsw-xdp-basic-v8-2-f3421b58da09@baylibre.com>
	<20240409173948.66abe6fa@kernel.org>
	<6f356fec-4384-4367-8812-a18b71156116@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 10:36:16 +0200 Julien Panis wrote:
> Also, about mem alloc failures, shouldn't we free 'pool' on kstrdup_const()
> error at the beginning of k3_cppi_desc_pool_create_name() ?
> I mean, it's not visible in my patch but I now wonder if this was done
> properly even before I modify the file.

Yes, it uses managed memory (devm_*) but prueth (I didn't check other
callers) calls it from .ndo_open. So while not technically a full leak
we can accumulate infinite memory by repeatedly failing here :S

