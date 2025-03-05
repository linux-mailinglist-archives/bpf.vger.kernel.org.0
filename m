Return-Path: <bpf+bounces-53351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBCEA50472
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DBB188858B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6718CBEC;
	Wed,  5 Mar 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk4MLJl+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E948567D;
	Wed,  5 Mar 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191644; cv=none; b=KpQl7BBkCF+oDE1fuo4cCvIm9PXgHBzZTGKp3W2vk6yHQFxJizgAzRgZV+RNmssbxGsYfheOkLPtyx0Sx1+kbmkk9A9gpTp6Z9gCPudap3KgjKIAxQnasmFfy/wWJROIqN1RXTd1JiBBIpa4LtYlvvr7h/snLtpkCJlwQvmyibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191644; c=relaxed/simple;
	bh=HWjA/54qT1T38UrU9K3wIAlo9/R2j+5fLIVn8dgqyXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAQ75573B6daZTl6FOtAy8Zv+jcPmddFlLX7RLypSMXCBJOEHZ4qtoPsLwI7uwML0kGY14+U9zdpaQsPJcs6b8bFxDL897WmclY0aPxO4wAiOi3FXo2Vx4FdQ9dmWbJPIIUfy3re5ohAEubeWIOnbFTPkNoY5xfkGMLXK5vyqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk4MLJl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3DAC4CED1;
	Wed,  5 Mar 2025 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741191643;
	bh=HWjA/54qT1T38UrU9K3wIAlo9/R2j+5fLIVn8dgqyXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mk4MLJl+uuKL2Nffx6CigEQOKXqD4rQShmjlajABN45BiRggskUECk5yxrAhgRVpj
	 NLku0mu9r4Ml+HRtk6VvXyPE0BTWlsTGYPa0FSX6WLr0elpiX7VVIFiCJImpKoE9Pr
	 muGYG6bMan4XsqT/uRRFfWYINWUYKibRmUJ+jrQ2Wv9IoEzkZcPP/R0XzweUyCPUwW
	 56wHr3athTy9mo3UFevOvmznabo1v+K94IYcUPClc9e3WRPykNyZ8hcKh/16tE4TNW
	 59zSeG4YlSZ77m/4+KZ1jCk0zx/r9hSFpJrW8Rdd82qeCwvVXCTpFXulUDSJCVx7Ey
	 2gtltonjeWO/w==
Date: Wed, 5 Mar 2025 16:20:31 +0000
From: Simon Horman <horms@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org,
	joel@jms.id.au, eajames@linux.ibm.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dmitry.torokhov@gmail.com, mchehab@kernel.org,
	awalls@md.metrocast.net, hverkuil@xs4all.nl,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	louis.peens@corigine.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
	johannes@sipsolutions.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, hpa@zytor.com, alistair@popple.id.au,
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v2 03/18] bitops: Add parity16(), parity32(), and
 parity64() helpers
Message-ID: <20250305162031.GO3666230@kernel.org>
References: <20250301142409.2513835-1-visitorckw@gmail.com>
 <20250301142409.2513835-4-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301142409.2513835-4-visitorckw@gmail.com>

On Sat, Mar 01, 2025 at 10:23:54PM +0800, Kuan-Wei Chiu wrote:
> Introduce parity16(), parity32(), and parity64() functions for
> computing parity on 16-bit, 32-bit, and 64-bit integers, respectively.
> These functions use __builtin_parity() or __builtin_parityll() when
> available, ensuring efficient computation. If the input is a
> compile-time constant, they expand using the _parity_const() macro to
> allow constant folding.
> 
> These additions provide parity computation helpers for larger integer
> types, ensuring consistency and performance across different
> bit-widths.
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  include/linux/bitops.h | 63 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 4c307d9c1545..41e9e7fb894b 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -276,6 +276,69 @@ static inline __attribute_const__ int parity8(u8 val)
>  	return __builtin_constant_p(val) ? _parity_const(val) : _parity8(val);
>  }
>  
> +#ifndef _parity16
> +static inline __attribute_const__ int _parity16(u16 val)
> +{
> +	return __builtin_parity(val);
> +}
> +#endif
> +
> +/**
> + * parity16 - get the parity of an u16 value
> + * @value: the value to be examined

nit: This really ought to be @val to match the function signature.
     Likewise for parity8, parity32, and parity64.

> + *
> + * Determine the parity of the u16 argument.
> + *
> + * Returns:
> + * 0 for even parity, 1 for odd parity
> + */
> +static inline __attribute_const__ int parity16(u16 val)
> +{
> +	return __builtin_constant_p(val) ? _parity_const(val) : _parity16(val);
> +}

...

