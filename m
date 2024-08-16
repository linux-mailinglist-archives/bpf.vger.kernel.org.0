Return-Path: <bpf+bounces-37385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26A9550D3
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 20:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D431F23C6C
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F931C37B7;
	Fri, 16 Aug 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvh8mfqQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436C1B5825;
	Fri, 16 Aug 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832864; cv=none; b=hhMyNevbZJuNJZK4XlV3sv3f6AK2BRTzqTd4PVdxlWoodX0NZCsjB1NGcCZGZEoybBpRDGisAJMqumM3H10+1fTAFO35M9CGm9yFu/QoVFPhI4MuCaa4APjPksgaaMktqzLW50Kezdx5FeblwNL3eQH+tDtwDZ3kyqk110WTg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832864; c=relaxed/simple;
	bh=7hRyuPjRLop1xNh3m+HIzsw6TPl/Rhga53lhKhjmo6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhobM/dCaCD6G2g4zPdivEOYSUklrFozFMfh/cDH3VSZzqx/6xN2ePZ6A7+36FkFZqu3n3i0oDbJQ6xP2+ToNQON/VFdPi40WxkCLt2M6xZmb0rlK3rOJ5XEdses5zZBUlKIDeyB2Nqg9ZgU3ApvEbVkmtOem3U+hgA0XMkajkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvh8mfqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81552C32782;
	Fri, 16 Aug 2024 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723832863;
	bh=7hRyuPjRLop1xNh3m+HIzsw6TPl/Rhga53lhKhjmo6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lvh8mfqQWWNO95bHqCGvTn3e238eCjDwmdI8DYP/PqwdDkHXRlLjR6pQ+aWhsk/1I
	 5Qkrm7+uCAkcrncMfOAo4tBq19PnyGKXUgmm4Iv9bssmHH8mLgbSD7IsipxsXlXYW3
	 i38Fu+SO9BhmEIJn4IczcmXDmvoB3ZQ6dogHJDed7NTNdwfGoF4PIXUyNfuKfuCc7X
	 MCVEViCK+fxuNfs9+6koKOtZDxRt9zwhSALsdATCd8OaR+ImsVXEevALsVHGlovBeU
	 8IEb1ReyVEbx7vLQzPON4SDxMtFKRthJww23EWR5POtu/Vvl374GSKvS4fauXwWymZ
	 N9zRgneda67aQ==
Date: Fri, 16 Aug 2024 11:27:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, fancer.lancer@gmail.com,
 rmk+kernel@armlinux.org.uk, ahalaney@redhat.com,
 xiaolei.wang@windriver.com, rohan.g.thomas@intel.com,
 Jianheng.Zhang@synopsys.com, leong.ching.swee@intel.com,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch,
 linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [net-next v4 4/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <20240816112741.33a3405f@kernel.org>
In-Reply-To: <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com>
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
	<20240814221818.2612484-5-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 15:18:17 -0700 jitendra.vegiraju@broadcom.com wrote:
> +	pci_restore_state(pdev);
> +	pci_set_power_state(pdev, PCI_D0);
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pdev);

pci_restore_state() doesn't restore master and enable?

