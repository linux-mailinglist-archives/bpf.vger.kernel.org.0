Return-Path: <bpf+bounces-43239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA49B1948
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE7A282A83
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BB1CC8BD;
	Sat, 26 Oct 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZialk5I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517B25776;
	Sat, 26 Oct 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957096; cv=none; b=gDpcp7LjFh2b7AOjM6PfZQBWXF8AGMQB8fdupwelwTvNo5uokdYHtGEsSEq1ou9IPa5H9OILyQEX+hMDHAe3EZGsE/k4rRopI5geFl2RqjLQ83JzCNe0RCTnA9xiZ/cweNxNVm0rix6c9CufIexlZZfYISMTtj2gLmO3tPKoktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957096; c=relaxed/simple;
	bh=WoFOQrFDbt2BycOyxn0Rx5XH/N5keHBSRn4+P/slL3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTxeIl797snPKNEkM0/vB7bEABzWOfinF0qcyx0uSjrozh5VkOe9gamMjtwGT/Fd4RLpIzBTmviEUMbGckqg7yX/R25FsZF6/XfxmtqDEjK1hpSN4StZGRMURZhRwd+tR8ny5EAFsBZREE0KIWLTSMmxnrLWp12slqSCiZE1Atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZialk5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24343C4CEC6;
	Sat, 26 Oct 2024 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729957096;
	bh=WoFOQrFDbt2BycOyxn0Rx5XH/N5keHBSRn4+P/slL3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZialk5IA7F8jwSiHW3amfsbfcZQEOLS3YLnu3MDowfEfxUfJYvx4ybNKAOJAgNkp
	 StTtJ7ELKCJlvZxR+7fzw1/UMbAOEGoEtDPOtJbSnGfH+X7J3/tAFUkDp+XuMPgmIK
	 Dw20FZCCTOG0b/yUqmA10j/RHIZr3qj5Ig529JpVChUtrhmVT4Q+Hs+/hxwGSX1nYc
	 NrdAc6L1y6LI9nn/UFAQsfteG9zM+hZ854RQo/OiI65c1C5kd6JkN8I04gC9JItjJp
	 ZRAI6DiKkQ3XffMQTakCBtsW8eyjwVSnXoODEVH8WQkb+0d9SsHCmFqcpOxSebqi0R
	 FfaWzy5qtYUig==
Date: Sat, 26 Oct 2024 16:38:10 +0100
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
Subject: Re: [PATCH v4 net-next 4/4] ixgbevf: Fix passing 0 to ERR_PTR in
 ixgbevf_run_xdp()
Message-ID: <20241026153810.GN1507976@kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-5-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026041249.1267664-5-yuehaibing@huawei.com>

On Sat, Oct 26, 2024 at 12:12:49PM +0800, Yue Haibing wrote:
> ixgbevf_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use
> plain int return value.
> 
> Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


