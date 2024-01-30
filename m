Return-Path: <bpf+bounces-20694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6D8841F72
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B9928468D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75905605D8;
	Tue, 30 Jan 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CAJAYaog"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C653605BE;
	Tue, 30 Jan 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606887; cv=none; b=i5lTBulUTtyO/LhyoyoWIi+JLt18JeEJr77G5Xe5zEaQnZhFFI8NRFlP4uJl2Ui4C4M0Wt3mo2iwWSgmzAd72VFnw++DwuS50f3VNcNhDyYNj1mZn0gcEYwVMXyxuPQXYC/VHFHx/nIEFokyaFI1xIqbPVWWFzufRshMylyLLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606887; c=relaxed/simple;
	bh=WeXsrjerVgdjp7ERsnWmrusKzZmU1eEbSH9QDZQMrwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCLivti3F77qlZTbNpmgrgaV76ASA4PXGuqXHblssPQQysbAAFLMmARQEtN0bSSwhDIGj8ejDedoABgWqZSaLNzgC8gX0OsJJ2yt9134WoXASP/0RcEkf3d+YulYEW6Rt4Ie/qo9i3eL9y8s4wwqO9dN4C028W1iWPTkkEh8/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CAJAYaog; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wBVJH31eVDzBpyupvBp7B4u8sfC8jD1DSOL/7C0GLE4=; b=CAJAYaogKroU2lJyjJipR7b8uy
	+6k0mduJVPIEKPyCwBjAt72D44vvkyqqgwx/LuZV9D66NjKAIOEZqy04A3PSqNZawfNP5oiAx6Sk4
	DuztLAxmu8Cjt/01yLc+BuMEBDb/T0XhppzZVslMM5vVy+0QD68VAnOl1U+4N2E+WjIPGlhCYsq/1
	//v9869QKVkEJQ6lX6Y7ieG6OCziOncVZsVdAtQ1lwDzwS0oLQki0brLtUkNQL3Mce9N4LVnBCMyX
	vg5NXQJDrsGxZ3rxYTz5psJXGH61lSehIaDitqzKVOyC45Db1jkwmiLDUMT0M65RYreibsYpRKRSi
	WTA0Za9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60964)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUkP8-0001Vq-02;
	Tue, 30 Jan 2024 09:27:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUkP1-0005OV-T1; Tue, 30 Jan 2024 09:27:35 +0000
Date: Tue, 30 Jan 2024 09:27:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>,
	Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: Re: [PATCH net-next v4 01/11] net: phylink: publish ethtool link
 modes that supported and advertised
Message-ID: <ZbjBB81+Jh5uTqnz@shell.armlinux.org.uk>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-2-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129130253.1400707-2-yong.liang.choong@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 29, 2024 at 09:02:43PM +0800, Choong Yong Liang wrote:
> Adding the allow_switch_interface flag to publish all the ethtool
> link modes that can be supported and advertised.
> 
> This will allow the interface switching based on different ethtool
> link modes.

I don't think you need this at all. You seem to be suggesting that you
have a PHY which switches between different interface modes on its host
interface. We already support several PHYs with this capability.

Generic support for this was added, and you need the PHY driver to
fill in phydev->possible_interfaces so phylink knows which interface
modes the PHY can switch between.

Instead, you are modifying the legacy path, which eventually I want
to get rid of.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

