Return-Path: <bpf+bounces-43238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED689B1945
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D91E1C20159
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D9D13B2A8;
	Sat, 26 Oct 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4loFfCD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB920224CC;
	Sat, 26 Oct 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957083; cv=none; b=u688xSrC7GIhcKK5iTlbjM3dDsV0PFsDzeYfSgMXW5O5AIatlzr1OSEF5enyh6PyIlGqWnawXIZRZ/V1S8yZvOeQIVS4ZTAaQLEMxSE0UoVws6CmTAC4nRMd7xVpDScMxBrDC1b9y/mBr+5cfNLZ7il+gnuiot03b1TqZ4Hu3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957083; c=relaxed/simple;
	bh=kfIY95pLBR/QjZ2VU50kuWXzRCaY64hreBQnX/RCywY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXY7nE/CH81Q0HiOxq4QtcDvFzmPJ9CtHONcYTBEbn32Ekm3RyCTJC+X7kKPkiecQOG9pO1pcnsUKeRaRSgEPV40Qz3CuOaF9Mz7bV+kk3y2Pm3xuK60vqCSwJayPv86p4qqD9+9leY/yNQ5p4mfd+pa+ceJkGnxAX+7E0CTchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4loFfCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F5BC4CEC6;
	Sat, 26 Oct 2024 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729957082;
	bh=kfIY95pLBR/QjZ2VU50kuWXzRCaY64hreBQnX/RCywY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4loFfCDaJRcni7y7zwoZH4ivEXGqEwmWul+6KClw86Um9/PtqHtjzImuR2iSnhlb
	 fpoR853BTYJ41Zl7T27EFEPbLnxt9FZPZ3twhiawjpJuFArX/2cvUZc/LShQ9iqu/q
	 xnqvpJ5f2kD6rFdemk02bAIr9/64ZMF2uag27ubVXiRyayXIqQHm4AKL9Ll1xPHZ6e
	 gzVBspRiUh3XuSjSALbdkxPqxLWN8t63pGvWw8c3HWfYSkydCEEYCnNW2MLh/2YpXi
	 rBn8GyDJ9luZIKLh9vVJ5VInoGuh7AaQgCk6gvBner2zmcisABzvatxnkOFSwZShBq
	 vl8TLYj56+P+g==
Date: Sat, 26 Oct 2024 16:37:56 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com,
	maciej.fijalkowski@intel.com, vedang.patel@intel.com,
	jithu.joseph@intel.com, andre.guedes@intel.com,
	jacob.e.keller@intel.com, sven.auhagen@voleatech.de,
	alexander.h.duyck@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 3/4] ixgbe: Fix passing 0 to ERR_PTR in
 ixgbe_run_xdp()
Message-ID: <20241026153756.GM1507976@kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-4-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026041249.1267664-4-yuehaibing@huawei.com>

On Sat, Oct 26, 2024 at 12:12:48PM +0800, Yue Haibing wrote:
> ixgbe_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> ixgbe_clean_rx_irq(). Remove this error pointer handing instead use
> plain int return value.
> 
> Fixes: 924708081629 ("ixgbe: add XDP support for pass and drop actions")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


