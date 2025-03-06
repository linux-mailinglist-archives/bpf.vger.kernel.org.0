Return-Path: <bpf+bounces-53441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FBA5404F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B319518916FA
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC318DB2C;
	Thu,  6 Mar 2025 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV1grGz4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E911713;
	Thu,  6 Mar 2025 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226970; cv=none; b=I21zJjkvYG/B4+4ENEp9SVn0LhJSvnpSF9vt/rHnxBNxSAhqRDIOF0tvlSkvrF2NSUYSWnRZUulKSqTTs3HojZgSY4O6NJU8iMjueQ3VLMa6OQnjUXHO8lrzzU4HWG6H0Fjd/Wi2ilmZoEIxcj9Mbm7XbpcrHjWeMRqGOjDFtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226970; c=relaxed/simple;
	bh=yR20MrocLc0xWy0/rUVvFiw9xf4pRDqto20+qryWOxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daW4yc7EDqFXJ3I3/CvIirbqBVNpRklNNLIGSmTAH0RpP0lpo4tcBCy/ztfy2r8nduhMYom+RxsrZeAR+6Aim/FQtIZbKG/tl3gJ+DC0nklIuSXj4W1PA1nXsjiV+fDfUyv79/pHvfu/YVrewyTG2vdc5Ct0D2ZcWkox+vAEyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV1grGz4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso1776425ad.2;
        Wed, 05 Mar 2025 18:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741226968; x=1741831768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1rT13AxT6i7F5Ycxl5JT25b4uDj1fZ8K6rhKfIa2rM=;
        b=KV1grGz4zS8Z5VBKAquBJsiho35R4bK9ASqaJLDzwrn8ELDBQtp35hm2YWQqhdCVvh
         FdmbEZcBZDvPVdsKXyhAEHvv9OBeAkb45MaOofw6B2NeqsTayBXRRfRlbJqdOoVd9ez6
         QRlaIX1Bom7n6YJIacBhbJB2fd0WIJrGzMjOD143SfqunwNAL5gh0jgkBwk5g/U9viWr
         xkU1cepZKbA2rOPko/IJ6rsHE6NwI0JQtOOrM2sBN5n4GzNgEECBJE4j5JNyGFHwEonJ
         UZAlPFguUwbMr0EOPLzYo7d8aSvMVL7eflqHIxxTvEJ7dy9J/K6PFdo7+1+mHoCnMP+F
         xH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741226968; x=1741831768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1rT13AxT6i7F5Ycxl5JT25b4uDj1fZ8K6rhKfIa2rM=;
        b=qglcFy+FFKRc9jRaRHwxcIOLzLDmHc18p3HMaB+Ds2Aw7j2CDTtolQulCW5VIh9sKb
         /oKSAwf8DsJs6NAbhqSXvq8OttrcWlw73XPFsXtXi42AHFxSKLLy5vbCIYZeFAoeEM1E
         4DlfZzyiwP84w7C/z1B3Ys/iZJXAPqJEr6XycVgBMfmuOkZOuoobmA/9AGV14eEWOuag
         s2nzzO9g3E7oYj+zVBVVj9zDCkkdtIE2/CgTj/5emlPL7VC/2YSeOhN0adexefBSjMT/
         jQI0akfUTSU69LyhbFNVo1k6HxzfRtDbwIoQ5SHcKcEde1KfRJfFgQpu01UUdkAVq5Gh
         pGCw==
X-Forwarded-Encrypted: i=1; AJvYcCVPhdFVr5NWQ5hSJTGx0WqVWeD2JdXjIn89X7RDwtXahd7oVMRmpcljdF+8vr9cppKR/UaE5zqVjqLNGVRW@vger.kernel.org, AJvYcCVoewXN5IUrmRrIuJclDkYJog6RsUM9JiAPlJqVauNeKz6YXhLpytEvYWigFff3cCUZfus=@vger.kernel.org, AJvYcCX2k7kBBfgzQr33PUvCWeKHb8ssBTg7KL59Lh6uRSVaGJ1I2uvLt2QSbvA6J8HftlB+vKspCgfe@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCTP9Y93htQqkerLqjBeXyVlFoQOPeddlrW3b1MsAXKvWdXuW
	PfTeXtSywLKzoZvScCPF/padjxaY9692YV86XFz4eYgs0j/hY4Fm
X-Gm-Gg: ASbGncuBkJdsoantJXP6T6FFC5T4WILHPlx7oW+jLiTwT05FukxmVn3Xs8nh9AuthaH
	Nb6m1+o5x5ZA09VNUM0NnulzY8gzqYDF12bKK0UzUC8OQDW9r6STabHbWSn6Q5ZDWrupHA/Phfe
	9+CrR+4Ann3r3RXyyzq1UzzVGxzi7t5nCMlFbzYSJVHI++HLH1GIVZGqHr+VugD5bRSqADdUv5k
	LK0KPQDhpqH2zrGqiFISsEukNILKL/Fbe8Fsvdk0cb54fPQOgMkMxTgQ7J0kzDhwoN6W8Vs5yfC
	n3La7mOI4jwLWqWzJN0EodV1yVouvflNkGuL9g==
X-Google-Smtp-Source: AGHT+IF9QeRgv+6Z/cPJtnzTG5KuBBCd8Qdr6JTrB73F+Bp0n4Wqinq/xvlObO2mPBHhOim0ujthOA==
X-Received: by 2002:a05:6a00:889:b0:736:55ec:ea8b with SMTP id d2e1a72fcca58-73682d00a42mr7712708b3a.24.1741226967842;
        Wed, 05 Mar 2025 18:09:27 -0800 (PST)
Received: from localhost ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698519026sm139246b3a.144.2025.03.05.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:09:27 -0800 (PST)
Date: Thu, 6 Mar 2025 10:09:13 +0800
From: Furong Xu <0x1207@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Russell King
 <rmk+kernel@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Serge Semin <fancer.lancer@gmail.com>, Xiaolei Wang
 <xiaolei.wang@windriver.com>, Suraj Jaiswal <quic_jsuraj@quicinc.com>, Kory
 Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper
 Nilsson <jesper.nilsson@axis.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Chwee-Lin Choong
 <chwee.lin.choong@intel.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v8 01/11] net: stmmac: move frag_size handling
 out of spin_lock
Message-ID: <20250306100913.00005bb8@gmail.com>
In-Reply-To: <20250305130026.642219-2-faizal.abdul.rahim@linux.intel.com>
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
	<20250305130026.642219-2-faizal.abdul.rahim@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Mar 2025 08:00:16 -0500
Faizal Rahim <faizal.abdul.rahim@linux.intel.com> wrote:

> The upcoming patch will extract verification logic into a new module,
> MMSV (MAC Merge Software Verification). MMSV will handle most FPE fields,
> except frag_size. It introduces its own lock (mmsv->lock), replacing
> fpe_cfg->lock.
> 
> Since frag_size handling remains in the driver, the existing rtnl_lock()
> is sufficient. Move frag_size handling out of spin_lock_irq_save() to keep
> the upcoming patch a pure refactoring without behavior changes.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 918a32f8fda8..cfe5aea24549 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -1216,6 +1216,10 @@ static int stmmac_get_mm(struct net_device *ndev,
>  	if (!stmmac_fpe_supported(priv))
>  		return -EOPNOTSUPP;
>  
> +	state->rx_min_frag_size = ETH_ZLEN;
> +	frag_size = stmmac_fpe_get_add_frag_size(priv);
> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
> +
>  	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
>  
>  	state->max_verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
> @@ -1224,7 +1228,6 @@ static int stmmac_get_mm(struct net_device *ndev,
>  	state->verify_time = priv->fpe_cfg.verify_time;
>  	state->tx_enabled = priv->fpe_cfg.tx_enabled;
>  	state->verify_status = priv->fpe_cfg.status;
> -	state->rx_min_frag_size = ETH_ZLEN;
>  
>  	/* FPE active if common tx_enabled and
>  	 * (verification success or disabled(forced))
> @@ -1236,9 +1239,6 @@ static int stmmac_get_mm(struct net_device *ndev,
>  	else
>  		state->tx_active = false;
>  
> -	frag_size = stmmac_fpe_get_add_frag_size(priv);
> -	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
> -
>  	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
>  
>  	return 0;
> @@ -1258,6 +1258,8 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>  	if (err)
>  		return err;
>  
> +	stmmac_fpe_set_add_frag_size(priv, frag_size);
> +
>  	/* Wait for the verification that's currently in progress to finish */
>  	timer_shutdown_sync(&fpe_cfg->verify_timer);
>  
> @@ -1271,7 +1273,6 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>  	if (!cfg->verify_enabled)
>  		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>  
> -	stmmac_fpe_set_add_frag_size(priv, frag_size);
>  	stmmac_fpe_apply(priv);
>  
>  	spin_unlock_irqrestore(&fpe_cfg->lock, flags);

Reviewed-by: Furong Xu <0x1207@gmail.com>


