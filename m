Return-Path: <bpf+bounces-59137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53429AC637E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F1317F30F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7845246762;
	Wed, 28 May 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="evO/lKUw"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042283C01;
	Wed, 28 May 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419109; cv=none; b=i7Nyz41Ro0DpSt79nFRjiR2fpCcaJR0NgU55D+VllbQBiC/hL8PEaucF/NCjsAyv5t6nPd9n0+hw2exazf7zpCMl77IYhC5O95WhI+xbmnf9oWk2iShsy1i59ZE9bqiHZLMlIXmWB6b743NoaPVNTPIJ5/e+WuldMGaK1ltGbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419109; c=relaxed/simple;
	bh=EhB0hPfGz22xprRM8wkMV43cCAg/VXZ3QzUsu3SMRdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0uO688b8a67swKaZObZNFcF31dTjmBWGoGiPAdhg2EjxSz1J4JJb+qqwgtJVpi7eNlRItc3G4RAWE6GV9thkwNFs+XIeMu00Iw40y5pm6mKY6aOUk63cbCnhkebA4VhPNtxCcKEWUXIOTfbT65ZeZ9/PSPZDMlEYG/+ck2/owE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=evO/lKUw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IFyA/Ev6J4dUYbbORf9U6czVrOpgGxA4vABlRFXcEts=; b=evO/lKUw5MnJ7tsXnKrD9jnoqg
	b+PYF3g+tT3s31UjYVEVLUGD4QbVFxAfDe3jTt6zSBYs+BqcW7L4o5H/4lV7IAFO87k6z8drWy5fa
	+vScF2jVlpn9cLiY4WYiOtgEi5WgKmCMIPgwHxusoT7b3o06F4DVQjoJZe9dfpVaBHibLWbrJd6IW
	Gu1oxMalrZustOdJN5UvUSgvwrh1CdrLPzbN+K2eLneCuzGPxEUMaOW3MhnK4aFdt455xrGh5qZC7
	Zo/NTYKwb6lkek7YVLTY6lXsIjJqz+8AwcuyThkWfOmH+M4By7TooetgF5MUQQ5zdFOoTXrpTeUEt
	P7lO75mA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41916)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uKBg3-0008Nv-1S;
	Wed, 28 May 2025 08:58:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uKBfw-0002GD-2Q;
	Wed, 28 May 2025 08:58:12 +0100
Date: Wed, 28 May 2025 08:58:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, fancer.lancer@gmail.com,
	ahalaney@redhat.com, xiaolei.wang@windriver.com,
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	horms@kernel.org, florian.fainelli@broadcom.com,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <aDbCFGIi09h1irho@shell.armlinux.org.uk>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
 <CAMdnO-+FjsRX4fjbCE_RVNY4pEoArD68dAWoEM+oaEZNJiuA3g@mail.gmail.com>
 <67919001-1cb7-4e9b-9992-5b3dd9b03406@quicinc.com>
 <CAMdnO-+HwXf7c=igt2j6VHcki3cYanXpFApZDcEe7DibDz810g@mail.gmail.com>
 <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac5c034-9e6d-45c4-b20a-2a386b4d9117@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 27, 2025 at 05:04:52PM -0700, Abhishek Chauhan (ABC) wrote:
> Thanks Jitendra, I am sorry but just a follow up. 
> 
> Do we know if stmmac maintainer are identified now ?
> 
> Andrew/Russell - Can you please help us ? 

My mainline work is in abayence at the moment (apart from occasionally
replying to a few emails from time to time) as I have other commitments
at the moment. I still have my own patches from before the previous
merge window that I didn't get around to submitting.

Sorry, I'm not in a position to help right now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

