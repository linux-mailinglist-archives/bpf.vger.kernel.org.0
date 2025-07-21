Return-Path: <bpf+bounces-63925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0371B0C7C8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 17:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162156C1480
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8639B2DFA59;
	Mon, 21 Jul 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGf/exmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750C2989AD;
	Mon, 21 Jul 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112265; cv=none; b=SSXDG/wTqN01pu9LLG12ONdgQMHq6cOqCCMESzJHsKRmppvsaZuqZRVkWy+IoU/JgRFEghnfMu7IQy4rpTZ7usczHGJNKnQUMVRP/ENi1Eqt3Rrd+J0fCU3o2JgjzuHVfvAfDM5SX7iyBIiBRBK8jJp7s5bZwE7+ixG6xsp/M6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112265; c=relaxed/simple;
	bh=cGSbVptLFVlc7DyrJ9h4SjbakTeJrwXiH1ZP0XlHoLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH7JGNZlLIeHpichDoKNtLZfffQBCVkDZHiENQAo838zzEbsVfMPxRroT/Znuk0d3wN4iMEGwvpl87JUbn3jb1xTRM5gLEf+Os4L39LXYYVjO35/SGiIF4yekgwaoAjHAzU6klEZGonYXD1eI8KaAsVoX1vvjthR/SbHhK+NIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGf/exmB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3855214b3a.0;
        Mon, 21 Jul 2025 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753112263; x=1753717063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SDh6f89OtCRQRfeV7TsPgYDLKkybdTNwjOtD8a9eZwA=;
        b=CGf/exmBiVsTPnk9okWkiIIm7XUrVpXOrWX+FI9W5bVtge7O0fzEKdVHUmZa72pHGV
         YIjL9/JAuFpV60EVvXc3VZ8EUP+yOLNPYjsjsAjFNtak84UKpxJNru9GFH1Ata13ynhQ
         I8sq2aBPchdn1UrNzeCKf+E2MorrgbTnLhKuLO0aivGQR5ivezNXAzMN06Fm6se8tsAu
         z7NUD6JKLmZG5AcpZs/hwYR1NSh1NOnATIbAI4qIqiD/f2Gdv1n3s5WuHtNE8KVCF7bG
         hn7pWyRl/nzG4tr3Go/yvPuq6Cc18SgrDHKror8b9G0pwZdCH/pJp/pBYge6PnNMbnFO
         MnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112263; x=1753717063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDh6f89OtCRQRfeV7TsPgYDLKkybdTNwjOtD8a9eZwA=;
        b=p4UqtDGDNNTmfFBxqlNDNrNfSIRnlImH55wTlhJY1b+8IUzq9nUxW32QJlEn2GY+SK
         9Qr9mJNEYfL1WZaeWtKprBIMXgRQYVZGlC97UVFPtEQMlGAnW/e84QiQ6CIAsPyss+3S
         tcTbcP0mK3TIOvlqcsqqCT5tAo6StkfLHeD1lPPd1H31+6BdZoHIJ5xqSFKFhDDM9w0y
         yOapCF8BqPYkPqGhyIoRJCZmzB/W668fsvaFy+7qd3MUzGpbuxZ19XjRLxZTdVBfyFFN
         e8B8dZc8yJt5GlJPlFOUS6pfl0r4cfulPg9qKz5l/yyJyF4sfgRnP10eOsqd7A9EeiOj
         cIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5LsWMM8XAiT6TXI/g9c5icC6ubn0R8YHU7y0KihpCfpDYJ/7cUaY7ctA+NjUTCeYH0Ms=@vger.kernel.org, AJvYcCVxOHinb9Y1zdwyuOtmnVbDLm5L/ZEIijmCbMPWgIz7LdKzARuvfF/ZW0JKh+7GPIcSPt/RVuXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6boRomlZquT/c5prejZVd6hcofC12qlHQ9bidCcbyX2DAxiwy
	mCcMTMX/wDLsToeKhyoewiAFEI8JNS4b2MA9w2/cBLIwSG0Cge4UNlU=
X-Gm-Gg: ASbGncuWP5wLILRjaxOfTAy6eDpvQvao9hGh+14KK/MbCiCNBjbcaIJAHDk5sRI8GEd
	2k+56T0r62PsZqFeolw5f+UN0LW+/MWH5aUjpB6pXiehVCqhfiFaV3oWqFtKirq9cZfc9lN1le+
	HJsSvD5Ml5kV7lQWyCjjr78NoK7upHWqbqy5BrARMyGS6shF6HXgdQtHpA+AXNPkxR1YsmDUYUQ
	XuklmajW/gxoLvAtQZVV8kJYQtDXd3OAKvNmF8YtGoE2sDE7b8VvxJyWusT/xmS13CtbFKmaG5l
	HD5/A7wlmzJWWoPR2J/coPjx2sOMg3gux/uZS2LNXDRW5dsuD6fY71rZ+4Ml2K9CgwzA0VUvOMX
	HIRMcHZnznfKZYfdgOEaBYj2h5X36yzxXHxOSasGgp/8IVSv2YlLDsJDHMiBzgM8qBHEvXw==
X-Google-Smtp-Source: AGHT+IEaIspNuv99Qrfx4sC4q4Y93JQlnVL5ZHYgom/rDGQzYOHx3souBPvCEmbOTJYWppBnuW8WRw==
X-Received: by 2002:a05:6a00:856:b0:748:f1ba:9b0d with SMTP id d2e1a72fcca58-75723e74318mr31994730b3a.11.1753112262692;
        Mon, 21 Jul 2025 08:37:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759cb155de8sm6048908b3a.84.2025.07.21.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:37:42 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:37:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] stmmac: xsk: fix underflow of budget in
 zerocopy mode
Message-ID: <aH5exXo_BdonTfmf@mini-arch>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721083343.16482-2-kerneljasonxing@gmail.com>

On 07/21, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The issue can happen when the budget number of descs are consumed. As
> long as the budget is decreased to zero, it will again go into
> while (budget-- > 0) statement and get decreased by one, so the
> underflow issue can happen. It will lead to returning true whereas the
> expected value should be false.
> 
> In this case where all the budget are used up, it means zc function
> should return false to let the poll run again because normally we
> might have more data to process.
> 
> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f350a6662880..ea5541f9e9a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  
>  	budget = min(budget, stmmac_tx_avail(priv, queue));
>  
> -	while (budget-- > 0) {
> +	while (budget > 0) {

There is a continue on line 2621. Should we do 'for (; budget > 0; budget--)'
instead? And maybe the same for ixgbe [0]?

0: https://lore.kernel.org/netdev/20250720091123.474-3-kerneljasonxing@gmail.com/

