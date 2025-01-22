Return-Path: <bpf+bounces-49487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CFA19225
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 14:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13B0160BAB
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52E213220;
	Wed, 22 Jan 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhpoVxp2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77798212B1C;
	Wed, 22 Jan 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551628; cv=none; b=PqCd9yRMKDEHt7cFNx0v0dRbmLfUyTOFP8nD/sw5SySmew/HoxyUlQ7Ba+jKC1c+E44+GICBxXBCqH540VGJ50yfSQ/xj7LMV3gVpEoJIXvVtCCdL2de4nuRjDyLbG5aOgb3TM+mn9FF114KztAZ1Fc1jbmEPkJ0wAK6BPgV95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551628; c=relaxed/simple;
	bh=Pg6l1vJipWXLQ85LZCUUwCiUt36EuYl/z6XJ1txMOiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkCfEpAiwwY3L5C7426HcWTrM8v3OXbto6n6KfTSa8mr5SvfMWh0cT5ckGGzFryOPNgODWT8SZx7un4MQcf0jk7NgT83o2dWZ0D9VyhqDE+VzHbV3Mmnpa+RzxMkduGY4btzCgNbvJV1mectyYL+MoLruOCPni0kOanaBKudawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhpoVxp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECCEC4CED6;
	Wed, 22 Jan 2025 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737551628;
	bh=Pg6l1vJipWXLQ85LZCUUwCiUt36EuYl/z6XJ1txMOiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhpoVxp2nfLJrvRCK3UG1TwY8mzw/Xl+DRTyxPH5SnMPPI8TVO8i2tf8FrOR0Cx3g
	 xmN+HsR9s9CdLzUpGtXLf888jgJohZVZZ9mdTzYNhfeGrbBnx7L87ZjzMs7oP/vFKC
	 P9viMoohMzqxLiMi9H3hnssoy/tu2c/5Um8I2yxpAVXkcxPQhDnz0Lolc3zUMGf30k
	 jXGL3Lri/TOwfOgzucIrbIZwRMNzCKWzBpifyFniVBatv3dhcGqhN1AH2uVhd86Zu6
	 W0Q8mvlGc+WX9mBhAo80U7VZEbNGDCNgd23mv6hxXMiNYW5yqH3elDHon6rQpHwpG0
	 AR/KmgNabkHHQ==
Date: Wed, 22 Jan 2025 13:13:41 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, robh@kernel.org,
	matthias.schiffer@ew.tq-group.com, dan.carpenter@linaro.org,
	rdunlap@infradead.org, diogo.ivo@siemens.com,
	schnelle@linux.ibm.com, glaroque@baylibre.com,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net 0/3] Add native mode XDP support
Message-ID: <20250122131341.GH390877@kernel.org>
References: <20250122124951.3072410-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122124951.3072410-1-m-malladi@ti.com>

On Wed, Jan 22, 2025 at 06:19:48PM +0530, Meghana Malladi wrote:
> This series adds native XDP support using page_pool.
> XDP zero copy support is not included in this patch series.
> 
> Patch 1/3: Replaces skb with page pool for Rx buffer allocation
> Patch 2/3: Adds prueth_swdata struct for SWDATA for all swdata cases
> Patch 3/3: Introduces native mode XDP support

Hi Meghana,

Unless I am mistaken this patchset should be targeted at net-next,
as a new feature, rather than net, as bug fixes.

With that in mind:

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

--
pw-bot: deferred

