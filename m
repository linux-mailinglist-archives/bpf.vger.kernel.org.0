Return-Path: <bpf+bounces-55745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1DA86333
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51001BA71F7
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA521CC5D;
	Fri, 11 Apr 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjurHYzZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2266126C13;
	Fri, 11 Apr 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388834; cv=none; b=Op1iUrBv9RT1Rf+YMRrjjsbEaeoOxIjkyCYj6vug5Lz73sSXxQgD8D4xMHxUUlLELNiynbxuk8Y7jSoDfSWKFkAjNcVMjojawJe5cjNujuhuv0tzgl/pqPi9s0Xq3QKLFttZF/55vlNhBx1g8uNKe/1PSZFQ3f2Gkd5le8Elid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388834; c=relaxed/simple;
	bh=DzmZ98UHOcBa/uDcZVOeIvJFc1PO8euYkm5Q5FQwIOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4hjX/VVFRjmya02P7wd7iE/SOsWLAAdhcyuMHcfZY/sT2ruYBoIJInRl7+7HNQCxMAFVBfCTR/Siy6NHcfaiCvVWM3ANQGIADMfVkN/D9d4dJf2azDseYAGdwpMwcbkq7wKciJPKV+nkbNodDE1qU+BZOaoj7nLLI+SCxo8gSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjurHYzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B78C4CEE8;
	Fri, 11 Apr 2025 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744388834;
	bh=DzmZ98UHOcBa/uDcZVOeIvJFc1PO8euYkm5Q5FQwIOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjurHYzZOQN4uXaLNZNK8RjGupHq3dHjtJ+hzR3/aZ4DOEn7KHKOeXl+L2Lbotkwr
	 9TXYlia3Fy88adO9DQCwSa5bIEoon7tKKpAihh6MVe/jYjsd9mk5aufUgb0bTY9MuG
	 2W3njw3FD2CMrJG16WcPZOdbYddag5vUVNsFwWn6SLY1wKT+93K5kZ+J7OxSUelHsf
	 4odvMCcQ5WXabNegXRZDJuu53hCQAIKnJJ6k4sQ4JWSe5UvuIokMtZedbzM5NV3xJ6
	 nqmd0n9mBEyeM+NqvYR6IuadjG5/s+A0oCPoKCpWVTn5z9G8FijAsMelN6MMHCr6Fo
	 ACNVIagXKA95g==
Date: Fri, 11 Apr 2025 17:27:08 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: Refactor VLAN implementation
Message-ID: <20250411162708.GL395307@horms.kernel.org>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
 <20250408081354.25881-2-boon.khai.ng@altera.com>
 <20250410161912.0000168a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410161912.0000168a@gmail.com>

On Thu, Apr 10, 2025 at 04:19:12PM +0800, Furong Xu wrote:
> On Tue,  8 Apr 2025 16:13:53 +0800, Boon Khai Ng <boon.khai.ng@altera.com> wrote:
> 
> > Refactor VLAN implementation by moving common code for DWMAC4 and
> > DWXGMAC IPs into a separate VLAN module. VLAN implementation for
> > DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
> > for the VLAN ID and VLAN VALID bit field.
> > 
> > Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
> >  drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 ---
> >  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 295 +-----------------
> >  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  13 -
> >  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  87 ------
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c    |   8 +
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  61 ++--
> >  .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 294 +++++++++++++++++
> >  .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  63 ++++
> >  10 files changed, 401 insertions(+), 463 deletions(-)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
> > 
> [...]
> > +static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
> > +			     __le16 perfect_match, bool is_double)
> > +{
> > +	void __iomem *ioaddr = hw->pcsr;
> > +	u32 value;
> > +
> > +	writel(hash, ioaddr + VLAN_HASH_TABLE);
> > +
> > +	value = readl(ioaddr + VLAN_TAG);
> > +
> > +	if (hash) {
> > +		value |= VLAN_VTHM | VLAN_ETV;
> > +		if (is_double) {
> > +			value |= VLAN_EDVLP;
> > +			value |= VLAN_ESVL;
> > +			value |= VLAN_DOVLTC;
> 
> I can confirm that 802.1ad (QinQ) has been broken on stmmac for years,
> and it will be so nice if this refactoring includes some fixes for QinQ

FWIIW, please be sure that fixes are separate patches from refactoring.

