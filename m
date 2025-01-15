Return-Path: <bpf+bounces-48978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD3A12CB3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F4A16682F
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F91DC988;
	Wed, 15 Jan 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uHP/y9C0"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0D1DA2FD;
	Wed, 15 Jan 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973047; cv=none; b=ouPGIjESCQMoZGlg4uRHxgxJp3YdUvjuLnJQaxkuxebqiE9dxhETQy+y3LxwmEcjNBzl1sekTLi1NKPUq3Jp7aVnBYWgacnzSCSNPvf3BJ3zTlXXFdM7/KGFe2yhgHNeAClRxCt1qx6/vk6rqu3GWMhNfp84KsgNS64yDH2nCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973047; c=relaxed/simple;
	bh=BYOO8ahA7KfPQlXlr5RsOfavt8hnK4U757hh8EFudms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgV9Q/bsAwJXTtEfqAlKhmcO4KVVGQOelebUkSLETgzbDbPuIWtTUreW4em8L8u1pkQErwOwsRkLG7R131wzkwg/yqJqLBqJpIg3OWxZvKumELuNJ0FzfF9iojLDKob/L+0dU6rNH9Ox2FH6O+Eb6ygVHxYj8YKD0d4im3NthRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uHP/y9C0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rXTIpr22DZcYITN7Dougj4FUS5jO5aee0GhdxiE+89U=; b=uHP/y9C0A43shn/tMQl7hZFR1e
	sIpapg2etl95IeP6cmwDn9znhIjiDvPCqBWdPBJJhfD8i/RSzRrOc1hbIgbUNh2Q0ziU1NucVot8q
	RuTUkqHershfsAIAa9MPlF1tS3ytnEpa5AqCmtfPPUtTARFHiu6EFs9+dH7XreAIB0UZlD6iegzJS
	iS18Yt+710zhroLLDuOnFsjUghC7IWx/siTwlL7OK1U6VrZBktRzCk1WRWtoadsQg6pmCBwU35l68
	v1PRG7MhP7W6fXJfx0zdwatQlcXXLCtzet6lWptY9HIl0bpMQZpmDUZsPkbWZKiGNAKl2gVCt08CB
	ayNcMSyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33574)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tYA26-0001h3-2T;
	Wed, 15 Jan 2025 20:30:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tYA25-0006TL-0C;
	Wed, 15 Jan 2025 20:30:33 +0000
Date: Wed, 15 Jan 2025 20:30:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com,
	danishanwar@ti.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: ethernet: ti: am65-cpsw: streamline
 .probe() error handling
Message-ID: <Z4ga6N7brU1FrQzx@shell.armlinux.org.uk>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
 <20250115-am65-cpsw-streamline-v1-2-326975c36935@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-am65-cpsw-streamline-v1-2-326975c36935@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 15, 2025 at 06:43:01PM +0200, Roger Quadros wrote:
> Keep things simple by explicitly cleaning up on .probe() error
> path or .remove(). Get rid of devm_add/remove_action() usage.
> 
> Rename am65_cpsw_disable_serdes_phy() to
> am65_cpsw_nuss_cleanup_slave_ports() and move it right before
> am65_cpsw_nuss_init_slave_ports().
> 
> Get rid of am65_cpsw_nuss_phylink_cleanup() and introduce
> am65_cpsw_nuss_cleanup_ndevs() right before am65_cpsw_nuss_init_ndevs()
> 
> Move channel initiailzation code out of am65_cpsw_nuss_register_ndevs()
> into new function am65_cpsw_nuss_init_chns().
> Add am65_cpsw_nuss_remove_chns() to do reverse of
> am65_cpsw_nuss_init_chns().
> 
> Add am65_cpsw_nuss_unregister_ndev() to do reverse of
> am65_cpsw_nuss_register_ndevs().
> 
> Use the introduced helpers in probe/remove.

Wow, so we're now saying that devm shouldn't be used? Given that patch 1
is wrong, I'm not sure I'd trust this patch to be correct either as it
goes against what I understand is preferred - to avoid explicit cleanups
that can get in the wrong order or be missed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

