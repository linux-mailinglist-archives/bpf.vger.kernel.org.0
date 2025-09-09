Return-Path: <bpf+bounces-67932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CCDB50588
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BC91C80195
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C0E3019AF;
	Tue,  9 Sep 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JPLMlUpz"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D7219A7D;
	Tue,  9 Sep 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443588; cv=none; b=EiI44dUahaHz+Gl18HwQzD2MRYqqQ3T8FLkdXuHsX+xtP0QcddQykh8idS94WCYcxRQhwLzpl812nhY1RKKRqsX7kbeU/HHAeAuEAsACZT+xwVi7OiG7+DQ/LhG1gLzgIBxbXzaW+o21ca1o4aY7maoekJIx67syc3/o/BiYw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443588; c=relaxed/simple;
	bh=GG5MrdZarwj/hHTsW4LWBjSF9k2G2Z8PjXf0WYdDiis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afMgT7Rpj5y43kDGy1brsRuFewC69s9XGvLGX+P3sj/Yt8j/cu5MkJNEufsAfJWS97KIfKrsrcg0kPj80e8qy9pjnioXSQ/YYJ3ojHLg8hgBhaBcu2d7YWUjEbP3Zrmt9lEXfx+F+E/HL0uvpwjJ/fT+BaiVWE1a5FZ9M8t+Kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JPLMlUpz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lRwvBfaT+yf+uQJrvSGSQs+uuRk8X3P8qH0TRfgm1YI=; b=JPLMlUpzERItWrQzhAqHKr3cEa
	lgvLCXK/1mcEVZUS9+ZzzssMX75QpSPWHJIyM6pRvm5YRU/PHtsGzWR8x3aHbbbJOobSGp/4WjkI7
	mXAwAYChDQ4Wk/3elC1Qk5ZvYAD/S7Jls5dLP1jUWvU+MdzYMPYo3+OdDxycQMStlDTw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uw3M1-007qdT-1T; Tue, 09 Sep 2025 20:46:09 +0200
Date: Tue, 9 Sep 2025 20:46:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 00/11] net: stmmac: timestamping/ptp cleanups
Message-ID: <afb70e68-5e59-47a3-837d-d15cde9dc8da@lunn.ch>
References: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMBaCga5UAXT03Bi@shell.armlinux.org.uk>

> On that point... I hardly (never?) seem to get testing feedback from
> anyone when touching stmmac. I suspect that's because of the structure
> of the driver, where MAINTAINERS only lists people for their appropriate
> dwmac-* files. Thus they don't get Cc'd for core stmmac changes. Not
> sure what the solution is, but manually picking out all the entries
> in MAINTAINERS every time doesn't scale.

One option might be to add an R: entry to the STMMAC ETHERNET DRIVER
for everybody who Maintains a glue driver?

    Andrew

