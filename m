Return-Path: <bpf+bounces-67370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77FB42E62
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F96546DD5
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85014D2B7;
	Thu,  4 Sep 2025 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4a+Hk3X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239A14A9B;
	Thu,  4 Sep 2025 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946930; cv=none; b=B4UhAAsYDtQJ8IVdmJOMDgTPtCRxOKPENWjzWJTzKC/+CH+Rf9K2ZYv9b2v46Wku02RgBPVd3iCWaD6HvX+8oxoLwjWMlVmPtegf7TxI/RcNOQz30TTrHvGvUkq4FDa4YuV3sN7iGm4EqS8ANt2QAuee1RjG2Zx40jQWi/OCxhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946930; c=relaxed/simple;
	bh=/eZokcjTYsgn7x3TN1nV0vQhMpWaAhi7YQj4lS/oW5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rte9gRCPFWtsNq4A0xwVoLJdQqSVdY39oC0axF5bkrqbVOexHKjlQ2Nxf1aTwFolZUjiwE4Ho/fZ7f0r6Ok84YIagISHMbZV3h+z1QF21WMWcDnagbUcadzd8jy7cX6zOLizms57S5Y+Tt56xdFgCC7iCHZ2F1nvDbYmMzauvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4a+Hk3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F46C4CEE7;
	Thu,  4 Sep 2025 00:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756946929;
	bh=/eZokcjTYsgn7x3TN1nV0vQhMpWaAhi7YQj4lS/oW5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f4a+Hk3XTjiN/mfxv9pyjGmIzHB8EyWE1g9mMRhBYpyErEFM2eLS2RLCNLZ9m+flb
	 usBL3tioZb1jmbnGl2cnprJzZgY+7pXdM1pTdJM/l7LSADXMr8lVMlXEjMiGbORW+l
	 ylL1uOUITFWfR5Vf2cQlWFj287PPpY3SnuOoIUMARaFXEEbDEiJfG2mlCm55uL15H7
	 EeIpGd0/dS2PeLYfhNQl8FVow1ttEyNVHftFywOVWIkdDwukIuF755hy2naOdqX4iN
	 mT+GB2IWk5KvmNBlsutFJjAZgnVXN8wIkBAU7y8uonErOB31WtsIKKO8H9zXSHUUsF
	 U/aLizS4FgT5Q==
Date: Wed, 3 Sep 2025 17:48:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
 <christian.koenig@amd.com>, <sumit.semwal@linaro.org>, <sdf@fomichev.me>,
 <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net-next v2 1/6] net: ti: icssg-prueth: Add functions to
 create and destroy Rx/Tx queues
Message-ID: <20250903174847.5d8d1c9f@kernel.org>
In-Reply-To: <20250901100227.1150567-2-m-malladi@ti.com>
References: <20250901100227.1150567-1-m-malladi@ti.com>
	<20250901100227.1150567-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 15:32:22 +0530 Meghana Malladi wrote:
>  	if (!emac->xdpi.prog && !prog)
>  		return 0;
>  
> -	WRITE_ONCE(emac->xdp_prog, prog);
> +	if (netif_running(emac->ndev)) {
> +		prueth_destroy_txq(emac);
> +		prueth_destroy_rxq(emac);
> +	}
> +
> +	old_prog = xchg(&emac->xdp_prog, prog);
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	if (netif_running(emac->ndev)) {
> +		ret = prueth_create_rxq(emac);

shutting the device down and freeing all rx memory for reconfig is not
okay. If the system is low on memory the Rx buffer allocations may fail
and system may drop off the network. You must either pre-allocate or
avoid freeing the memory, and just restart the queues.

> +		if (ret) {
> +			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = prueth_create_txq(emac);
> +		if (ret) {
> +			netdev_err(emac->ndev, "Failed to create TX queue: %d\n", ret);
> +			prueth_destroy_rxq(emac);
> +			emac->xdp_prog = NULL;
> +			return ret;
> +		}
> +	}
>  
>  	xdp_attachment_setup(&emac->xdpi, bpf);

