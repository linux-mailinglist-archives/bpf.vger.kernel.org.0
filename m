Return-Path: <bpf+bounces-54471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1395A6A67F
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 13:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D69C48573C
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649629406;
	Thu, 20 Mar 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mshW1Y1m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9463A9;
	Thu, 20 Mar 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475256; cv=none; b=Ynjn7ZTlif3D/AsVd8gs6PzcmXKpCictWnB8bZf3B1n033mHz54yA96k/j8KACrETeO2XSjrH6n2mAQCz8jAXfOt/GJ9KfWJeMm6wCI8SVSPvYXm3oWgZdhuB0XavRY0GnaB5D8hjbraFqqsmD/mD3PJQQCu8ewc5CIlBP+mKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475256; c=relaxed/simple;
	bh=vxV+a/fLmjjCRymtdhQarF9ezoeGwerQqeFxyUA3row=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjOgzRuaYYeXkFgTFXNCcj2Yy0LlE4KCGB98pEsmGxV11f0Hp6UaiJQvM2Y/Cg0D9bfW84CMOBB7B9sZQ3/oy3AkAsFGMOPeZT8FuAPohqV26NCRz/e9TTp5+mEvyXKwie7QeXhhb+QcescZYfNwVOrmvx3oti33lhG5Tc3usN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mshW1Y1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734EBC4CEDD;
	Thu, 20 Mar 2025 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742475254;
	bh=vxV+a/fLmjjCRymtdhQarF9ezoeGwerQqeFxyUA3row=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mshW1Y1mUUWzSAYHX9v4UeBiVBN7iJ+TcNCV6wFNs7ezLg1Su9nsxvJML07ynWPyS
	 7bBrvZaRYZaffw1osYjlU28JPszJOQD7uAno0Z4FDSCn2Gn2M7f28MfKhgAMz9kvU2
	 X5Z00tR5QE4aPdzX8QFqr2DnTkYUs0X5pf48SfxX9yGRx8HFoLPDH8tsZ+HRZiHTlm
	 BspfnzdRWUxEdCj2w4ie9gD9KSkqD77LBZuHVsqF3FdyHMOYqdlC+sTROuhWo9ba+A
	 glkEgWE98+ENvZ7R1gFGQLaklueQud518AhZutgCB0C+v+djPuXQTGlWT/hgf8wIoz
	 9MAaLVz7SAOVg==
Date: Thu, 20 Mar 2025 12:54:08 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kory.maincent@bootlin.com,
	javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
	jacob.e.keller@intel.com, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next 2/3] net: ti: prueth: Fix possible NULL pointer
 dereference inside emac_xmit_xdp_frame()
Message-ID: <20250320125408.GO280585@kernel.org>
References: <20250317101551.1005706-1-m-malladi@ti.com>
 <20250317101551.1005706-3-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317101551.1005706-3-m-malladi@ti.com>

On Mon, Mar 17, 2025 at 03:45:49PM +0530, Meghana Malladi wrote:
> There is an error check inside emac_xmit_xdp_frame() function which
> is called when the driver wants to transmit XDP frame, to check if
> the allocated tx descriptor is NULL, if true to exit and return
> ICSSG_XDP_CONSUMED implying failure in transmission.
> 
> In this case trying to free a descriptor which is NULL will result
> in kernel crash due to NULL pointer dereference. Fix this error handling
> and increase netdev tx_dropped stats in the caller of this function
> if the function returns ICSSG_XDP_CONSUMED.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


