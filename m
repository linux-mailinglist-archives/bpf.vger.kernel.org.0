Return-Path: <bpf+bounces-57538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74535AAC977
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 17:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2543A0729
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21E283C93;
	Tue,  6 May 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibZ9lgxm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD95A32;
	Tue,  6 May 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746545156; cv=none; b=gsRRMMAF3qz0onYlI7o2NoXEHDx0w0R02ePO3x3CIUbBzzgmU9UqntO/ByOCyB5+BcewD3ZnjW0xLM3bUQEhco7wOeYljt5Hk6tg7v+UBYYIoQbFloJ9vPABmZ65SSzCBHJN3w+vFvybWmuxZnP0fUcNv5OSeKBa8nrU2rwXs9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746545156; c=relaxed/simple;
	bh=8n38TSBJmBwvs64PRmlNU+Hw9KwwnaLfXu8Gxhr7I4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/V5oCMwzO5LmXlYoAEnF7MJMDOP56WZtxxP4H/ZiCpKIx3fDV80llk93lJv+7m9JQaqyKzcR8247IsCZCsUxYiJPZYQswj3TqRFrOZfdhij+LwF9dMXS0EIACSTmMgRjeld9pwdBIAuDR6hSeoIMZPHGeK9xAUKUU7DSF9gz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibZ9lgxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D32C4CEE4;
	Tue,  6 May 2025 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746545155;
	bh=8n38TSBJmBwvs64PRmlNU+Hw9KwwnaLfXu8Gxhr7I4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ibZ9lgxmL6bmeZofnWidzB/nTKHyL2JhpdcpMZYM5tAbA1gdfeEbbCaWIZeIUrZKJ
	 BydPQgKYEEHIo7fdhSvv2L7/x7fE3kD/0v1cllQB1S2kgLRAqoJEvdxm6JHhhUHJHg
	 OnGCkLgbOo9CE52Jsk7ZJBpgp2bDCcq4NKZIbhoJnkDZz0D2EGah6quZaFK2/CWJDt
	 CA5WtciN71wqTGrCn3PVAKFfMKscX/y8LHf9fG969X1rfYU8ugWiHjGZXTs2uKsuNB
	 tRO7EDY1h7b0MoSMglrL2Z9PEak9Jp0q/+1YPRKTGXG0Un/+6BMbF/H4dJoNy3elgT
	 wQT1k2qgYD4/w==
Date: Tue, 6 May 2025 08:25:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jon
 Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: call phylink_carrier_*()
 in XDP functions
Message-ID: <20250506082554.75959fec@kernel.org>
In-Reply-To: <aBnK4i52tEHs3jm_@shell.armlinux.org.uk>
References: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
	<E1uAqYC-002D3p-UO@rmk-PC.armlinux.org.uk>
	<ed54d4e5-ecc3-4327-8739-3d41ca41211e@lunn.ch>
	<aBUG6Z_Crs31W45x@shell.armlinux.org.uk>
	<aBnKKafHHjkL5iP-@shell.armlinux.org.uk>
	<aBnK4i52tEHs3jm_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 09:40:02 +0100 Russell King (Oracle) wrote:
> > Well, this series has been discarded from patchwork. Shrug. I won't be
> > posting another version, stmmac can remain broken. I don't have a
> > suggestion on better names for these functions.  
> 
> ... and in any case, Andrew's comment would be a *separate* change to
> the subject of this series, so is not appropriate to be part of this
> series.

Right, I think the state is purely due to the typo in kdoc of patch 1.

