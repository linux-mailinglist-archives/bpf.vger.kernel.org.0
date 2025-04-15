Return-Path: <bpf+bounces-55967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69679A8A3D0
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 18:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A193BEBB6
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5229B212;
	Tue, 15 Apr 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwf/xepf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E52296D1C;
	Tue, 15 Apr 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733632; cv=none; b=qldK0s1lxbg7c//gX1wpFmGP5Nk0CCRR5yXi6Wsu1BbSqC23+lm1pUCshydSd3yZRi9O9gY7MGnQ8RAPjY3WJkZTgUqE8FY2+xal/hJB5ZDGE3H3exniu45AijLancNMksZGRy7ZXeno9K2Ma5uL2YYKQsM/oBTlWahR2PEn16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733632; c=relaxed/simple;
	bh=1jFrBy0lzqpyUKpmfkbxvJvV2QeeBiFeu/gLSlD6DXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7h7e48Rg0EVMvLug2TXBcg7hFYStYFsb2Tqve7syzw2nBkNI64Dc0XKQOyo+9RcWYYK00PZ1sxt6258ZS+eUoUjTyDSUos5LlnSnsCH4qNv93VCA+g7VxXB9BjxV4cMygi7xDbgC5wGqedteRDIno6ubvWuhXhV7cp3F88xIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwf/xepf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382BAC4CEEB;
	Tue, 15 Apr 2025 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744733631;
	bh=1jFrBy0lzqpyUKpmfkbxvJvV2QeeBiFeu/gLSlD6DXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iwf/xepfn8XdaQPkl3OXO2pziEP0MlRo4kLwGSJsiPog0Lg5Q1zc16D6DMGJwuihR
	 wFxPHaCtVDUNGtTLwsWTrCyK5ML3+2kHLLu+hLOI9049UI/1wvm6ANh7f1RkqDDqZE
	 sfK6i25rKsc+rZPzOJjQiMNZCqS9qAsXy/ekUZsqbaFi5M/YNucILhk7ZNjcpj8xhR
	 cTpu1IqsMZdWOGrrLhNg9KBwOnjf8is+U1vUkxZI9HftXGggDq4mt6mtnKRdxCOmja
	 JYxKuYVHbxzBtX6yyWjjBDmrCV6qBEG+qekX20hC4nqmB77hh3oQmv7Pech6xvsaet
	 8MiIM487OnzWg==
Date: Tue, 15 Apr 2025 17:13:37 +0100
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
	akpm@linux-foundation.org, jdelvare@suse.com, linux@roeck-us.net,
	alexandre.belloni@bootlin.com, pgaj@cadence.com, hpa@zytor.com,
	alistair@popple.id.au, linux@rasmusvillemoes.dk,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
	bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, Frank.Li@nxp.com,
	linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
	david.laight.linux@gmail.com, andrew.cooper3@citrix.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v4 09/13] wifi: brcm80211: Replace open-coded parity
 calculation with parity_odd()
Message-ID: <20250415161337.GZ395307@horms.kernel.org>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-10-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409154356.423512-10-visitorckw@gmail.com>

On Wed, Apr 09, 2025 at 11:43:52PM +0800, Kuan-Wei Chiu wrote:
> Refactor parity calculations to use the standard parity_odd() helper.
> This change eliminates redundant implementations.
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmsmac/dma.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> index 80c35027787a..5d7500ee2d3b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> +#include <linux/bitops.h>
>  #include <net/cfg80211.h>
>  #include <net/mac80211.h>
>  
> @@ -283,24 +284,9 @@ struct dma_info {
>  	bool aligndesc_4k;
>  };
>  
> -/* Check for odd number of 1's */
> -static u32 parity32(__le32 data)
> -{
> -	/* no swap needed for counting 1's */
> -	u32 par_data = *(u32 *)&data;
> -
> -	par_data ^= par_data >> 16;
> -	par_data ^= par_data >> 8;
> -	par_data ^= par_data >> 4;
> -	par_data ^= par_data >> 2;
> -	par_data ^= par_data >> 1;
> -
> -	return par_data & 1;
> -}
> -
>  static bool dma64_dd_parity(struct dma64desc *dd)
>  {
> -	return parity32(dd->addrlow ^ dd->addrhigh ^ dd->ctrl1 ^ dd->ctrl2);
> +	return parity_odd(dd->addrlow ^ dd->addrhigh ^ dd->ctrl1 ^ dd->ctrl2);
>  }

parity32 expected a little-endian integer as it's argument
while parity_odd expects a host byte order value.

I realise that the existing code just casts-away the endianness
annotation, but this patch adds a Sparse warning.

 .../brcmsmac/dma.c:289:66: warning: incorrect type in argument 1 (different base types)
 .../brcmsmac/dma.c:289:66:    expected unsigned long long [usertype] val
 .../brcmsmac/dma.c:289:66:    got restricted __le32

>  
>  /* descriptor bumping functions */
> -- 
> 2.34.1
> 
> 

