Return-Path: <bpf+bounces-55150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C424A78E25
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2093B164C7A
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761D239587;
	Wed,  2 Apr 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW/2qggx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E63238147;
	Wed,  2 Apr 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596388; cv=none; b=PqGV8EK77U7hgqTTtuBqnYAuERx7F2vU6SH6VOehU9/65XT6oO0eUxUOrak0L5gVafUvXsSFI9W8R/BBn5NnKTJ7h5AdxrNfdxeKfUQXznqpQA3wdRtCgwkUs3IabN6by2LrIdxKXMjbUXvqbYJuQlz4liOKcTFdQ9rEYhUB1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596388; c=relaxed/simple;
	bh=JuHVA5+8TCS9Wnl3ErI7KLLe5QXbdlX/nJKEhl2WNnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbw6NwWNdjNZcW/M0NSWVZRW5yOsVG6G/BFaPVh1R3vIrqq+j2W5yBhuqVQdsSWsYIeyIaj3VLKEUI5orounCMlbH8rR4Idy1qmAXc1VOy0WbEub3C1Mphn59R3eHTmVAZNDB1pq+9xTbWTVBGhifOV+sKXZP36LGXNUKFKCmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW/2qggx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839ADC4CEDD;
	Wed,  2 Apr 2025 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743596387;
	bh=JuHVA5+8TCS9Wnl3ErI7KLLe5QXbdlX/nJKEhl2WNnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KW/2qggx+iOP+JLKFUL809XxFqzG5AqtgpHTMCP2wl7W8AHTrHX6FqaozU4Qn4uGe
	 9QnVErmZChI3R1hFL2H+avv/VZWLU2+ZkUJQ+OtDinRt44DTcsbF7qE+6E/UQWlgk8
	 8nreQWCz1V0vuFauKlSAZaNF/ezygzxvMNyOmAp/LsNBk9tIO3vWGurc7rFpemY3Fg
	 NY8mEEBenri5vVlpNh+gujQB11KaMEGq6TCcGsAhxSFaN2kbnjNwFjVZX+Ym0o/UAh
	 1697a2MTjvJqqLw+cOUtPbqitwrFIULyKqgohWI18y6XjU3nOpYt2+sQyxxolbu3EO
	 dhG0fHPBiTdrg==
Message-ID: <ba453200-429c-4828-b4b3-6df8b7cfb134@kernel.org>
Date: Wed, 2 Apr 2025 15:19:39 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] net: ti: icssg-prueth: Fix possible NULL
 pointer dereference inside emac_xmit_xdp_frame()
To: Meghana Malladi <m-malladi@ti.com>, dan.carpenter@linaro.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 namcao@linutronix.de, javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 horms@kernel.org, jacob.e.keller@intel.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
References: <20250328102403.2626974-1-m-malladi@ti.com>
 <20250328102403.2626974-3-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250328102403.2626974-3-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 28/03/2025 12:24, Meghana Malladi wrote:
> There is an error check inside emac_xmit_xdp_frame() function which
> is called when the driver wants to transmit XDP frame, to check if
> the allocated tx descriptor is NULL, if true to exit and return
> ICSSG_XDP_CONSUMED implying failure in transmission.
> 
> In this case trying to free a descriptor which is NULL will result
> in kernel crash due to NULL pointer dereference. Fix this error handling
> and increase netdev tx_dropped stats in the caller of this function
> if the function returns ICSSG_XDP_CONSUMED.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain/
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


