Return-Path: <bpf+bounces-30712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAB8D1884
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C8C1F2162B
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB5F16C687;
	Tue, 28 May 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gDfb6/La"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03616ABC6;
	Tue, 28 May 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891886; cv=none; b=UYPT/bDPCA0/QZdazJiAfPyRF2izdmym93KMGdoT1wKQ36ZC7j0hYOuigVmrY+Y7nFnusTS2Cm2lR33ChB2JGSTh9fSA/UT3L8oiyGJntCWNKrZo24rhvlk1du2SMpWeLJyBcETFG6feUG/+C9VNllGzzbJK9xnNRHAskqeHkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891886; c=relaxed/simple;
	bh=D/i19GV6H88/mxlwtG4orLNiK9ojQnMQDqlOwTWuQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsRhKTv+aEvScPPqnmY79bvDzETwcjNeGmrPJ+6kE+Wa2hNptF03MRGOXELXAK3XP9iEznwY1zECidzUiDeguWCYq+6W9myVDXlf0xRLB9a5gM0YDZfvQwV+LeO2dyacHeGELfNtCQtgt8lCORbrD5lCMDhTU4J9wgmr4QfKkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gDfb6/La; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O36LPsodbr+2D1LuW6n/mh2TD3fN2BTOqCrbAVe7KjQ=; b=gDfb6/LalxU55OpMYkI7ZZw5PA
	pa6zDAdGyYDPpF4jr1O93jiILKaH6JB0fDzzYMMKoUz2JDGWJHsTVelvgnDjpcIhYRnFaQTHR0lrC
	9YEaI3enubY6Aerfr5oFRqqGQZXkQAbjDJ2iirS1PX1GstNNEq4n6jF1q/KisjnxOw77yYlvXNSA+
	I/nwWk+1JIT4hDHfREMujDorQqroyelNkYEtFLFzs86KcCPmBdetpOBeigq3A3AbtDU6jDmRSwO5z
	+pjV1gqtMRhzuN/VKM1XN0QuKCtwU6+w8dig8X9OR9EG43+NDArukdzLifVQr8okHRnXuAo5V1f8L
	snrqv0Rw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33096)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBu0L-0004cr-1n;
	Tue, 28 May 2024 11:24:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBu0M-0003BW-RI; Tue, 28 May 2024 11:24:30 +0100
Date: Tue, 28 May 2024 11:24:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/3] net: stmmac: Prevent RGSMIIIS IRQs flood
Message-ID: <ZlWw3hJdOARzdl2S@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524210304.9164-1-fancer.lancer@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 25, 2024 at 12:02:57AM +0300, Serge Semin wrote:
> Without reading the GMAC_RGSMIIIS/MAC_PHYIF_Control_Status the IRQ line
> won't be de-asserted causing interrupt handler executed over and over. As
> a quick-fix let's just dummy-read the CSR for now.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

I think it would make sense to merge these into the patches that do the
conversion to avoid a git bisect hitting on a patch that causes an
interrupt storm. Any objection?

(I'm now converting these two in separate patches, so would need to
split this patch...)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

