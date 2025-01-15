Return-Path: <bpf+bounces-48979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F43A12CBD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC19A7A23A8
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4251D935A;
	Wed, 15 Jan 2025 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JG8WxfK+"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D51D6DC9;
	Wed, 15 Jan 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973244; cv=none; b=JgB6SQAHznQq89FET4Iph0qRmiA3b+Zns6985YYshjphlEgaeq0rQkKR8B52HzcW0lNHSk8EktT0ddEN0MgZ/bSNxRTpMUiI7HzORH5P1aj8b76s/RWZTciyl96Gm5OSEUto/VAbvC+L0YqI6DSalwUT5dmXjctHBio+Lyxpxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973244; c=relaxed/simple;
	bh=KZxR19csE3un82z3vbatrBUQSSwl8b+Ml2h9SIkQfhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjOIWAN+D8oeCZbVqNBMSc2sDAq6J7WCC8zMNn5ffCCBIpHZgJswkjM9podRTs39p8929gb1IlK4RskDbHZaWwJ1z4gVckCq9ZlMsGCRPgMTqozBqJ4LIarE3LjOcjw/cQct0bozDrisvDImUGYNsbonKq85WIkt9UgXG6cxXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JG8WxfK+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ceb4oq7WhDog+LiW7ivw1MeE3NGGByFdmcwvde172Mw=; b=JG8WxfK+seQ+y9nGV3w0egZqpW
	Ji9WiJQ9+ECy8O30SGntVO1MayR3tgU93slkxCdVp5yyFLNhfhRFjWwwLVGN8elU2IiZJ4zKv0T7T
	VKrK3AfeOhKnIxlte/7iQdWIwlaTm01zmQYCfk/5OENm6gAX/iznPstQKhEoORyJX3aNXTYbcYjf6
	M+OiYjEFFrQYn6SoNegiFTfPpU47K4yv5hpx/64bIDG2fVE9FDlU1AmaPaLfsfMNY3l+5V02mmDwB
	jkGhtCNTLW81NQN40IXMvSJ1pUq7f8R3cBMXerXAJxB0h/kV/YwBWzIf9EkUtDqBw7+9VQFBMAOmd
	7kGEXaKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tY9zt-0001gb-2I;
	Wed, 15 Jan 2025 20:28:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tY9zp-0006T6-32;
	Wed, 15 Jan 2025 20:28:13 +0000
Date: Wed, 15 Jan 2025 20:28:13 +0000
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
Subject: Re: [PATCH net-next 1/4] net: ethernet: am65-cpsw: call
 netif_carrier_on/off() when appropriate
Message-ID: <Z4gaXU76kzlsmtwK@shell.armlinux.org.uk>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
 <20250115-am65-cpsw-streamline-v1-1-326975c36935@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-am65-cpsw-streamline-v1-1-326975c36935@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 15, 2025 at 06:43:00PM +0200, Roger Quadros wrote:
> Call netif_carrier_on/off when link is up/down.
> When link is up only wake TX netif queue if network device is
> running.

Sorry, but no, this is wrong.

Documentation/networking/sfp-phylink.rst:

16. Verify that the driver does not call::

        netif_carrier_on()
        netif_carrier_off()

    as these will interfere with phylink's tracking of the link state,
    and cause phylink to omit calls via the :c:func:`mac_link_up` and
    :c:func:`mac_link_down` methods.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

