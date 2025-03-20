Return-Path: <bpf+bounces-54470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6FA6A681
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 13:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00398A43EB
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0B262A6;
	Thu, 20 Mar 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSEaEywe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED32F9EC;
	Thu, 20 Mar 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475236; cv=none; b=qHTBWclWRE1MNvFg/RDy0PIL8MkciDarRYb4yEqj8cuDe1ZZ9MxoPBB+GTTe84/r/wz2mEQda88BAiGqGM9vEqbrxKYes6dG1n+xpo35AYpyJmwfQTtpaiNUHuMKGZH8NJc/zee357a6HhyQWqun2g6V+MBBkAn7WaDjqsl5VJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475236; c=relaxed/simple;
	bh=qz7MeaPR8fOUUQcZ6yj6cjFnFISOPaxEsa/PQ0ftEok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju0xaMAfrsXT13/3bFmozirK+B3b+ILZfT46/22xMcdXqoV9tm3PSl0smqEPkyvuve98DJeAnDo6kaxGZZCGiwTNcs6i+UhNZyT64qmtIk3KDSlvMXgj3gr3ozeirCeV28M9gl6h7F6zZXT9dG3bL01xgqSwpB5CFIrbP3UuJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSEaEywe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDDBC4CEDD;
	Thu, 20 Mar 2025 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742475235;
	bh=qz7MeaPR8fOUUQcZ6yj6cjFnFISOPaxEsa/PQ0ftEok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSEaEyweNzA4Glaku9/kxFiZYPTRlTzqNWNKbcpiVt/T0M7WrzFY/xXDcutG7k5+u
	 uHHjzBC581oQo4wIvbP1SEszyEzB1856/ZDv9NriIotrP4CF5GrlZ5psV42voERfr4
	 Ry42mOocCkwIBXO99fp9JpMdoSBFOglm9n4ZYiuyu08kYdyzcSgWv5nYUXfvl9JAim
	 6/o3gNfm+Nd/BuOtWDP54RdRLSi9n08t5BY+Dq2+Zpj2mxxcRQozAOFtFHLDBKiSdz
	 2+5DGh2sJPOchXiUFxqv97zueJDS01w781OpmO9C61jXvCcvhi0cXCJ3Krgz7gGHGJ
	 vgccg7ifdK5XQ==
Date: Thu, 20 Mar 2025 12:53:49 +0000
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
Subject: Re: [PATCH net-next 1/3] net: ti: prueth: Fix kernel warning while
 bringing down network interface
Message-ID: <20250320125349.GN280585@kernel.org>
References: <20250317101551.1005706-1-m-malladi@ti.com>
 <20250317101551.1005706-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317101551.1005706-2-m-malladi@ti.com>

On Mon, Mar 17, 2025 at 03:45:48PM +0530, Meghana Malladi wrote:
> During network interface initialization, the NIC driver needs to register
> its Rx queue with the XDP, to ensure the incoming XDP buffer carries a
> pointer reference to this info and is stored inside xdp_rxq_info.
> 
> While this struct isn't tied to XDP prog, if there are any changes in
> Rx queue, the NIC driver needs to stop the Rx queue by unregistering
> with XDP before purging and reallocating memory. Drop page_pool destroy
> during Rx channel reset and this is already handled by XDP during
> xdp_rxq_info_unreg (Rx queue unregister), failing to do will cause the
> following warning:
> 
> [  271.494611] ------------[ cut here ]------------
> [  271.494629] WARNING: CPU: 0 PID: 2453 at /net/core/page_pool.c:1108 0xffff8000808d5f60

I think it would be nice to include a bit more of the stack trace here.

> 
> Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

It is a shame that we now have more asymmetry regarding
the allocation of the pool and unwind on error prueth_prepare_rx_chan().

But if I see things correctly the freeing of the pool via
xdp_rxq_info_unreg() is unconditional. And with that in mind
I agree the approach taken by this patch makes sense.

Reviewed-by: Simon Horman <horms@kernel.org>

...

