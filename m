Return-Path: <bpf+bounces-30710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B768D1876
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AB43B27F46
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E416B725;
	Tue, 28 May 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0gQC9ZPn"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F315E96;
	Tue, 28 May 2024 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891802; cv=none; b=uas+o0OUDj2rtVcgJpbDIt6nd3acTso4iHbwCZegHncJP5yq8OozhFKzj3QUvqhgFYeqaapfyO2zS8OkfKR3GbTuB7fi6+EEVWK+7jts+yLfDGNtw4joq/OwTI6eC/0QloJaWjLYDbhx93qmHg9lxEqQ0BO7vLkFlWqc5aygLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891802; c=relaxed/simple;
	bh=ch5ac9DBIgqbQiYKszbFUqZeKjUsPbq/tOX9tgLBZQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwAdSLEP0FtoG109Mj1jFaNTqMhSSDq3Zr3unw4353HnW88qJncvOYGW9yEOMFWuxFaRVXH2VnyLC7ime0c4irUPeusdz+lOkTpw4l+TVf+6oHFco4EHDkqEdFCz6/JkO207n5oxT+Sk++5FhcfGgcZo8jzQXSbBA+O3Pv9H02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0gQC9ZPn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zttd9Ti6dlrdltMOkpQrnFnbw+iW5a9NAfwZ4M3vUCo=; b=0gQC9ZPnrBS+TIfGGqnRL5Ztk3
	jMr9cYdK88WgnFC83V1Z/DwVomq7NX5ByBjlenoZ6mvHkTf8pGfS8A6K4t/nek2oXGny4mK2uvVOi
	vZrn7eJwzLGRRduhpR5HCwUjEhQwYrLjOIK4BGgEtE/fzJHyl5MsB/D2WgS3pnuHp0NYmylntRyFz
	eCxYkovFdtOMVxNZV2ZiCEaPrC/vWIwlJfj7J5tkDAshChoGXVvQUnDrFPt57wPWaY+gjPpsOof5e
	AIkYygEsEOM2dXQ9Qmu+XiopiEG26vzY1bhyU55Sh0wI//yEL6U49w/jng2Zcxwwt2uef7DDXRwqh
	l0/zKlRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37478)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBtyy-0004cT-2s;
	Tue, 28 May 2024 11:23:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBtyz-0003BN-Qy; Tue, 28 May 2024 11:23:05 +0100
Date: Tue, 28 May 2024 11:23:05 +0100
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
Subject: Re: [PATCH RFC net-next 3/3] net: stmmac: Drop TBI/RTBI PCS flags
Message-ID: <ZlWwiQxvvAKd39gN@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524210304.9164-3-fancer.lancer@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 25, 2024 at 12:02:59AM +0300, Serge Semin wrote:
> First of all the flags are never set by any of the driver parts. If nobody
> have them set then the respective statements will always have the same
> result. Thus the statements can be simplified or even dropped with no risk
> to break things.
> 
> Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
> registration will be bypassed. Why? It really seems weird. It's perfectly
> fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
> interface.
> 
> Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
> simplifying the driver code.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

I think this patch can come first in the series, along with another
few patches that remove stuff. Any objection?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

