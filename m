Return-Path: <bpf+bounces-48955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAFA1298A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FBE1889DD0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836FD1A00EC;
	Wed, 15 Jan 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dQZ256E9"
X-Original-To: bpf@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9A1553BB;
	Wed, 15 Jan 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961206; cv=none; b=dUHJW0B8aKui9584kgLCu2u75l6a9gKETZCQAFxcfrkB/JeClXQ/iw2ipSu3ihwsRW4MWOArm5h5HnbvN7XjdnNrBdGBwU8xLOjswQNO4MiGwVkhdTh+iC9DpufnnZiFfx3+WLkaW/aI+HpDXc5eSDMHBxINNtFBVcJo0HnZ2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961206; c=relaxed/simple;
	bh=sQWi0hAlnI/n4FFLHgBO3J6LQDaAlkjwLOwnznMHcoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqZGvWSv0rHlAwKNABqRPdpGUTvnSBPfGdNnsp+3OTV6mD+rXdVkWYxDy6DJyXQdxDuWhrC9hFZgDkkSuzYinVkUK7sA7usnfCyJEoUxebsRVPbLRQ50mJcsOGUQ45tiZ6PJ9gTP4klMnwSJg8UzBiZFBQ7d85mWjSl1hpAwHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dQZ256E9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51BF41BF206;
	Wed, 15 Jan 2025 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736961201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peY423sOLg6YfVQUI9JX17xkbO0gPvff/6HW1B3bmug=;
	b=dQZ256E9PSCAmJ6u5SNoJ0IZanXOugS1K90QuWsL1+3TgOhtukFeobs0kO7Bji50wT1Uvt
	weVh94cXnFCgqSuta4TUPqqmDBtYRRsWeJs/JCglgm8irp1op2PKZpnSbAU7N+YWuU5RgN
	ziL6KMtAyn3KuBiLhl5Ky6XE8bW+LdsIPxLLu+Xy+2nPecQaovcbkwy2qhzw4cobPghm0m
	nbJ31hlpO77GxCm5j31KKXwaDLP+EBJ8WoMzRPWcZUtzWsV3IQbvWbd/foCFe5i/hdjXC+
	owndjBuZfIPqB+xUhn2Lb1B1DlCBm/bNXlEUAw7y0w5OnjwYYGQHDah1gaIHIA==
Date: Wed, 15 Jan 2025 18:13:18 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, srk@ti.com, danishanwar@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: ethernet: am65-cpsw: call
 netif_carrier_on/off() when appropriate
Message-ID: <20250115181318.2dd11693@fedora.home>
In-Reply-To: <20250115-am65-cpsw-streamline-v1-1-326975c36935@kernel.org>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
	<20250115-am65-cpsw-streamline-v1-1-326975c36935@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Roger,

On Wed, 15 Jan 2025 18:43:00 +0200
Roger Quadros <rogerq@kernel.org> wrote:

> Call netif_carrier_on/off when link is up/down.
> When link is up only wake TX netif queue if network device is
> running.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index dcb6662b473d..36c29d3db329 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2155,6 +2155,7 @@ static void am65_cpsw_nuss_mac_link_down(struct phylink_config *config, unsigned
>  	cpsw_sl_ctl_clr(port->slave.mac_sl, mac_control);
>  
>  	am65_cpsw_qos_link_down(ndev);
> +	netif_carrier_off(ndev);

You shouldn't need to do that, phylink does that for you :
https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/net/phy/phylink.c#L1434

Are you facing any specific problem that motivates that patch ?

>  	netif_tx_stop_all_queues(ndev);
>  }
>  
> @@ -2196,7 +2197,9 @@ static void am65_cpsw_nuss_mac_link_up(struct phylink_config *config, struct phy
>  	cpsw_ale_control_set(common->ale, port->port_id, ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
>  
>  	am65_cpsw_qos_link_up(ndev, speed);
> -	netif_tx_wake_all_queues(ndev);
> +	netif_carrier_on(ndev);

Same here, phylink will set the carrier on by itself.

Thanks,

Maxime

