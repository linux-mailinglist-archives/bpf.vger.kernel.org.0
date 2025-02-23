Return-Path: <bpf+bounces-52262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E8A40CDC
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 06:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB34117C855
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA251D7E4A;
	Sun, 23 Feb 2025 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb8cRfOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945852AE97;
	Sun, 23 Feb 2025 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740289206; cv=none; b=nZ0XCYtUbr3duyG6WA8YzcJdMuHK3v2hJh2Qcz7BPX0ejQLPsSYXteu5KDLFYTWxlmpP6a/Vc9dw2xp5SFLUE/qaAP1dTFLdefdJgZYqfpix8V26GLdBde8f1l9LyH9qU7v0hNPSVDlJtH8UbHKf5h/N2nfDnf4gQIJKkxBQqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740289206; c=relaxed/simple;
	bh=GWnXskB+Vnogo6jwBuCS8eCJI1+64mIPToLBsPkUOtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvVIGzbkdCJ4hYIIb6ZrhKEQlSvK9Q4q6VdzGO1Na1Cg7kyxvKfBSlnf3X9C3Oh0iKncJ6wTy3AQRUiM/0f5RKr8VAkyn6W0IRr/9JB6z1CtMWxXxU6vSfSaPAsgJZSyjO+jPqIzyjCv/ZAg5KhIswznkvvq4gX9oxZ+0jLgEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb8cRfOI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so6908280a91.3;
        Sat, 22 Feb 2025 21:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740289204; x=1740894004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfvuWvSB4FrYuL3Q9W8pUmNF8XrVHM6syd74IbIbqmI=;
        b=bb8cRfOIDBvRVwrkc9TaYxxGtTt+onBQv/sYuOod8yGAkMJYKmvTU9pXIURG2Rlltc
         fr0XdS1tgECDQxtQ0iyDi8P/uxdhqItpiaNxVbwXLIhMX0gioC8y0oq4f8o7xS8gDvs9
         1FX/IrQcPjGHzA2RRLnT0XkYZBbmVDm/obzWO7nOdQZHu284Dj4ATSyOrhhUXQYekUjT
         d89daMHeSySrTnSa5KG9jZZbhUuqk4LYQ9FHtUNilHZ8ZTbrdgBW+Hm1nYK8l99PkZRL
         TytJvcEHRdhgRSe2k512oVSCjUWbLQ5LFc4szZH5BiWBiWmVFvXYMvXMKABdBuHE3Ko8
         KaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740289204; x=1740894004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfvuWvSB4FrYuL3Q9W8pUmNF8XrVHM6syd74IbIbqmI=;
        b=oAZu5paSMBx3dEiX4JCrHWrqNQt4MWB2fBIwC/8yeZuimINvPX8U6eoaBo0yes3eVq
         t1m0vsCi6l09RwFiFY5Aygx2RnYzlN6B2O5TDN4Ediv+ZqKzRqI9xNmZlDne3ZYROxZa
         fB+sX1iLESgy0vEV6IdMCY6h5MXWWKCkobWb6kGhOUtoSKmNgSjoNvbLLBk2JTm+eIWC
         /ZTNlRo2IUm5wD9sBVO69m/reLgCrhlaiF7tODz5YKPtc/tIAOPg32Hq7hANNyZ4thHu
         WRHtC2ZUcYn/rMrrkMlTDhy1ZQxSG7R5PO8EyLaAw2HunYU9z4pCiwwkgW7ldI9dWejY
         B3hw==
X-Forwarded-Encrypted: i=1; AJvYcCUDeSUCbGq/Xb/DiHb9YOf33AC+Z28GLKtCpZdiyaSDbu1cGtAZGeF1ktTKgExzWD3JRv4WvfEg@vger.kernel.org, AJvYcCWM6jsqKq7Z6hKQ7lB3QJ6hiyqO1SdFuGnlq0+jPuNfaMsTFW9vJ1M43nLdjyCvttrAL8YAKh9AL2Px1NXF@vger.kernel.org, AJvYcCXQ0Y0KNZf+Hmh0Oexb1EZPgkXYgFsiJq14pz0n/BTzSX+hRicKXylHCTbTOBPzJIA5zzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUi7aczZQcm/364mgozTY01aj28TxnbuxBKEBrE555UiQ6APP5
	fQVtw9Bs1oAWwld5MxEujwDf+s8hYi8ZgIM328pV9SDNSNqFy4od
X-Gm-Gg: ASbGncuX1T9NmlQAeXz9ylfHGMADYDGXFd51N+rHuN90UMp150at/RWDwBk9+ykt83T
	j0jyWUo7qpCj/IE2wAGbI8emo/h6ftZcPr+O7lVJM0dd3X0eImjRgS0reVY7oBLJl1gyCZgUvyj
	VyhRlIwc46Y5bP9eNqGpBIaN9cRfRtxnwZiBODSfdr1m2C4/7hmctSOd1ghdqI7aYM4azit54Nv
	UcgoOqZ76/hnTd+DkCciAGw7Ub9nfM6mm21sWBWC69/2bMLNG7Owyp9ckUbio6rkTai4aOnzcWX
	kxAInh0HVnv+rRs9hhp8S8Y=
X-Google-Smtp-Source: AGHT+IEsyitKBEB+TjtOIJ7j0ghQQ1PUySgYsjd6ENH+ooYHWDcum4IoJa9MuHEv9g0sOVIJCIQYCA==
X-Received: by 2002:a05:6a20:8403:b0:1ee:efa5:6573 with SMTP id adf61e73a8af0-1eef52c9981mr17773167637.8.1740289203622;
        Sat, 22 Feb 2025 21:40:03 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73261ca7831sm15022814b3a.104.2025.02.22.21.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 21:40:03 -0800 (PST)
Date: Sun, 23 Feb 2025 13:39:47 +0800
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
 Nilsson <jesper.nilsson@axis.com>, Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250223133947.00002f06@gmail.com>
In-Reply-To: <20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
	<20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 21:53:41 -0500, Faizal Rahim <faizal.abdul.rahim@linux.intel.com> wrote:

> @@ -1258,23 +1236,8 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
>  	if (err)
>  		return err;
>  
> -	/* Wait for the verification that's currently in progress to finish */
> -	timer_shutdown_sync(&fpe_cfg->verify_timer);
> -
> -	spin_lock_irqsave(&fpe_cfg->lock, flags);
> -
> -	fpe_cfg->verify_enabled = cfg->verify_enabled;
> -	fpe_cfg->pmac_enabled = cfg->pmac_enabled;
> -	fpe_cfg->verify_time = cfg->verify_time;
> -	fpe_cfg->tx_enabled = cfg->tx_enabled;
> -
> -	if (!cfg->verify_enabled)
> -		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> -
> +	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
>  	stmmac_fpe_set_add_frag_size(priv, frag_size);
> -	stmmac_fpe_apply(priv);

Well, I would prefer keeping stmmac_fpe_set_add_frag_size() before
ethtool_mmsv_set_mm(), but not after, the VERIFY process should be
triggered after all the parameters are set.

> -
> -	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
>  
>  	return 0;
>  }


