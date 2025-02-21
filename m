Return-Path: <bpf+bounces-52159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C7A3F0E0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8A919C7D2E
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536F3209673;
	Fri, 21 Feb 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6Tj1yBm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C65208997;
	Fri, 21 Feb 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130989; cv=none; b=Bz6cR7LbGoZxA9TuRA+2BMppqgatWhF/P0s6BPYU5xoBHu0yvsyUcq0AjPH9bC8BWxgOXuyvAz95W66DXR48fHNKqlcHu2+ShnzhRyhnwPabdBte8ehtX3VyL1EMZ0ZM9UkHVoEdkIO7lRAv0XuiZFKOWro8dN/ZpKaq32a5GSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130989; c=relaxed/simple;
	bh=xELPkWKrTFyerseVN6ZsabfQW5T13xesUDluQhW1BPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1irTo9ZEYWatNPp326vfh0OIuyJXbj+1bCjk8FORLMWCNs3ZUVwTIUUra+A/Ws1iw2SUh4NpjFBv+M4nZNUK+v0sA2o0EG3q9gIznkLEBvGyp9Zi3lO0tpe/hCtq26uILmUNw25lJReDVvk+koNE2HtUszWmsbtzJgsDFJERgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6Tj1yBm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso3847574a91.3;
        Fri, 21 Feb 2025 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130987; x=1740735787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp8DvYGUWgTHXAPWqbMBZV8Rl/qxPnTYUxFzmDOOo1U=;
        b=H6Tj1yBmr31n3Zar8goGvfGcf7/zYB8k/LOEU3vbliSsYQyTGuHKFL0SluOy1s6uPh
         jrU1lNPXt0OeuBH0Hli6+p42b8mHpUVEAEvkLMBYIOmhBg/JVpDPPK+BfxfVRYKqygwG
         5nI58DIYTRwBLMeV06R3yxaEMu+GUlyVEw1J3FB5tsSQ9HJGxY3+TJPZyQFiasCdz6tK
         yzchxdaaoRxXqp9ALNRlnakrf1sBpIWxVlTzJnfHRhh7HeIOq+V3pVmACKorGVg8DF3u
         FkTaocua+YcWvywb5+kddSfNkXV6gurxXguniRj/hnUbOdlBMZKcA6oIO458HFmPIZaO
         RwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130987; x=1740735787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp8DvYGUWgTHXAPWqbMBZV8Rl/qxPnTYUxFzmDOOo1U=;
        b=XjfLo6+RDXrD81HHHUGApBOnIUH3hEhOkdxWCotUP5zleoTShG5Pwpj2R3rr6ZKam5
         Zr6+lG0mW3mDyTPihP+SmYfXy8kCj1voOCCcA3JcyZM19G291B4rF7hutupPCQYJ9p80
         /cRcpRArxUKfAcQtjHrtcB21ifY+CwSd8sQLKMyI9fLiEzzT2veeRUQja4QmPsaDLQr+
         72BPVrpLGRtthQJf97vImbGd+QvM6QXOdjtONuf7yRmTHkyRjNP5DlibnJRMycSd+LUj
         1hgOMKIT+2DfN5BmQViAnkYF2iCl7MfWSHIRFclPM242hPdEMqwLZ11r5JJndFP/dU5x
         Pquw==
X-Forwarded-Encrypted: i=1; AJvYcCUHVQTCLQ7fbPwPc4rGUNt2VAiBhL0hoZsrRgaIjcgbihNdrZnuCfyVvVux+TJp0f1eBSHB2BQv@vger.kernel.org, AJvYcCULcgKCwFRqzuWNZqZOgwZxsFp7gbJXTBUFG3DL6zwBWshH1ithCNgGJxbhXT2nZszi6LU=@vger.kernel.org, AJvYcCWHJnzC2H110In401jvKUymGqe9a2Ab6mWMsgc+NJjw87JdvQKJOEkItRJqgx1IGgsyPdT4k16ZHvIPPcn1@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWVugU8u0zpIVCcrVnxUUx6QmZPE6M80BalsZ8tSUlO0c+oeh
	Ieq4IXwwuACRWF9UfZltXq8jX5c1UJe8Ndsk09gQaFdkUhA3yC57
X-Gm-Gg: ASbGncuF6/r7z3Quu5wCYhfrB8XyByc/d2od9SnVTqd5xk+5mq8pbGVpj29jV6o08Bt
	VYqLFjuuVl7FYsabQaL5DGBt20ulgEc22dJd6AnFlkiceFkk7ChMFaID7um5fxULw7amoqmA2Dp
	N9/CO9cKQYCigRCIwxV8yCrHSoZeKXysgWGBCumpz0GAY9cG05KnOFaKgoi0P72rvG3INXFp7yq
	5xw8d1cDG2YQqT7Hzc+Z5VmXwqsFtDZ9Jg15ZbglGISkT6/I2ukfyvqSJHKLt7SYuw83dsd/RPy
	CwUY3w9gy3vSl/fEXAjoE3E=
X-Google-Smtp-Source: AGHT+IEFLkFCj2bQJ0yLXnoXnz387Bz22Ke8KnkO2x0EryQr6MWOx9pTmc0bN1V4MOkAKGnHvqQCJw==
X-Received: by 2002:a17:90b:2e0d:b0:2fa:2124:8782 with SMTP id 98e67ed59e1d1-2fce7b1f6afmr4454759a91.25.1740130987274;
        Fri, 21 Feb 2025 01:43:07 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcb844c60asm3042021a91.0.2025.02.21.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:43:07 -0800 (PST)
Date: Fri, 21 Feb 2025 17:42:49 +0800
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
Message-ID: <20250221174249.000000cc@gmail.com>
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

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> It appears that stmmac is not the only hardware which requires a
> software-driven verification state machine for the MAC Merge layer.
> 
> While on the one hand it's good to encourage hardware implementations,
> on the other hand it's quite difficult to tolerate multiple drivers
> implementing independently fairly non-trivial logic.
> 
> Extract the hardware-independent logic from stmmac into library code and
> put it in ethtool. Name the state structure "mmsv" for MAC Merge
> Software Verification. Let this expose an operations structure for
> executing the hardware stuff: sync hardware with the tx_active boolean
> (result of verification process), enable/disable the pMAC, send mPackets,
> notify library of external events (reception of mPackets), as well as
> link state changes.
> 
> Note that it is assumed that the external events are received in hardirq
> context. If they are not, it is probably a good idea to disable hardirqs
> when calling ethtool_mmsv_event_handle(), because the library does not
> do so.
> 
> Also, the MM software verification process has no business with the
> tx_min_frag_size, that is all the driver's to handle.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Co-developed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  41 +---
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++-----------
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
>  include/linux/ethtool.h                       | 131 ++++++++++
>  net/ethtool/mm.c                              | 225 +++++++++++++++++-
>  7 files changed, 399 insertions(+), 201 deletions(-)
> 
[...]
> +void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
> +{
> +	unsigned long flags;
> +
> +	ethtool_mmsv_stop(mmsv);
> +
> +	spin_lock_irqsave(&mmsv->lock, flags);
> +
> +	if (up && mmsv->pmac_enabled) {
> +		/* VERIFY process requires pMAC enabled when NIC comes up */
> +		ethtool_mmsv_configure_pmac(mmsv, true);
> +
> +		/* New link => maybe new partner => new verification process */
> +		ethtool_mmsv_apply(mmsv);
> +	} else {
> +		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;

Tested this patch on my side, everything works well, but the verify-status
is a little weird:

# kernel booted, check initial states:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": false,
        "tx-enabled": false,
        "tx-active": false,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": false,
        "verify-time": 128,
        "max-verify-time": 128,
        "verify-status": "INITIAL",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

# Enable pMAC by: ethtool --set-mm eth1 pmac-enabled on
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": false,
        "tx-active": false,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": false,
        "verify-time": 128,
        "max-verify-time": 128,
        "verify-status": "DISABLED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

# Disable pMAC by: ethtool --set-mm eth1 pmac-enabled off
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": false,
        "tx-active": false,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": false,
        "verify-time": 128,
        "max-verify-time": 128,
        "verify-status": "DISABLED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

verify-status always normal on other cases.

@Vladimir, maybe we shouldn't update mmsv->status in ethtool_mmsv_link_state_handle()?
Or, update mmsv->status like below:
mmsv->status = mmsv->pmac_enabled ?
		ETHTOOL_MM_VERIFY_STATUS_INITIAL :
		ETHTOOL_MM_VERIFY_STATUS_DISABLED;

Anyway, this is too minor, so:

Tested-by: Furong Xu <0x1207@gmail.com>


> +		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
> +
> +		/* No link or pMAC not enabled */
> +		ethtool_mmsv_configure_pmac(mmsv, false);
> +		ethtool_mmsv_configure_tx(mmsv, false);
> +	}
> +
> +	spin_unlock_irqrestore(&mmsv->lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(ethtool_mmsv_link_state_handle);



