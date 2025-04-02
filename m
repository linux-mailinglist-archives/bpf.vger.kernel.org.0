Return-Path: <bpf+bounces-55153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF62A78E64
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B319C16C53E
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341E239586;
	Wed,  2 Apr 2025 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+jQJxeH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7723906A;
	Wed,  2 Apr 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596926; cv=none; b=TtMhkoOCCVtmZhDrELzXluIn2pEphkW+4BoSKvZhrbM4wEoHegUYGFRyUjEIUAIKskQgJMdod8bgKJqSewIzhKdcY675+EE6AnAIswE4Aj+AHAk0CznRlXw7mO1W1LUpen/X3yJTU7ytgDaCgbkSZ0R4ZunokZKbzCsQwxQe5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596926; c=relaxed/simple;
	bh=onuIhjTXJJlHvvsqV+euGzwFz3yBubvRTM3rD33wVhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUAvM6havoVPLjf+/fzg6c5ODvj5lqtj1VUAH68DyFIZqvQk5ZEuJrUsedwHEoRCy7CE7+I4Q6nSdRjg8yp9QTn/JvKGm7k+Mq5XP1QWrqBEI1GHaTD8A6J1hsmWR7s+yuHTtwS09QI7ec5laOmUU2wMefrw7r+Ne55k1gNwmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+jQJxeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D84C4CEEA;
	Wed,  2 Apr 2025 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743596925;
	bh=onuIhjTXJJlHvvsqV+euGzwFz3yBubvRTM3rD33wVhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X+jQJxeHNYK2sE30eKgGhKnxxnXIgISmGZZWJnbO5E0Op+wIXxk9g0SXQDOKxYqnj
	 4wdPQq0h18/PDzj1mTEGOYE9/hoT8kiSz/Od0yakv20gz8RA0QslR9YGIKZyUaBemp
	 C83G78lnzM2GRIqvVuRwJx6BK4RdRKBxWY/E+oMzumfgYGvKz2ZQK5dj7LrT5faWOi
	 mE1djQ0v8i7Rnlvu2BBVCrZFIOiRMgOaEnEmI68GLCpcDzGUAkiFdZ3DdUsgO4AAAo
	 rB49S1p8dCnibfF0yKNiFx47YyiRHSH/nwbbZN+OaXnuB6TRidOueCGTM0EliiT8DA
	 DGIXcuj3YXoxg==
Message-ID: <0fb67fc2-4915-49af-aa20-8bdc9bed4226@kernel.org>
Date: Wed, 2 Apr 2025 15:28:38 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
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
 <20250328102403.2626974-4-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250328102403.2626974-4-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Meghana,

On 28/03/2025 12:24, Meghana Malladi wrote:
> ICSS IEP driver has flags to check if perout or pps has been enabled
> at any given point of time. Whenever there is request to enable or
> disable the signal, the driver first checks its enabled or disabled
> and acts accordingly.
> 
> After bringing the interface down and up, calling PPS/perout enable
> doesn't work as the driver believes PPS is already enabled,

How? aren't we calling icss_iep_pps_enable(iep, false)?
wouldn't this disable the IEP and clear the iep->pps_enabled flag?

And, what if you brought 2 interfaces of the same ICSS instances up
but put only 1 interface down and up?

> (iep->pps_enabled is not cleared during interface bring down)
> and driver will just return true even though there is no signal.
> Fix this by setting pps and perout flags to false instead of
> disabling perout to avoid possible null pointer dereference.
> 
> Fixes: 9b115361248d ("net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> Changes from v2(v3-v2):
> - Add Reported-by tag and link to the bug reported by Dan Carpenter <dan.carpenter@linaro.org>
> - drop calling icss_iep_perout_enable() for disabling perout and set perout to false instead
> 
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index b4a34c57b7b4..b70e4c482d74 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -820,9 +820,9 @@ int icss_iep_exit(struct icss_iep *iep)
>  	icss_iep_disable(iep);
>  
>  	if (iep->pps_enabled)
> -		icss_iep_pps_enable(iep, false);
> +		iep->pps_enabled = false;
>  	else if (iep->perout_enabled)
> -		icss_iep_perout_enable(iep, NULL, false);
> +		iep->perout_enabled = false;
>  
>  	return 0;
>  }

-- 
cheers,
-roger


