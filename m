Return-Path: <bpf+bounces-43236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70649B193B
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 566F4B21953
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7C1770E2;
	Sat, 26 Oct 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piwt6JmX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1136224CC;
	Sat, 26 Oct 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957052; cv=none; b=Im5GrQG9VNsGygYwOVigwsSpdQk/SUTHepu4Ho1llOpGz7/lP2rLAL1Pu4182dd3Us9ffWXYrjRQ+o58Lnqtj32Bz0SZJOIuBNBJN7mM4f7CU1T5soLjQXmjPYElIGLWM92693rfM0Aa2KT6erRtzdhJdw1L+TJFpg45hb2YDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957052; c=relaxed/simple;
	bh=24uikJwv2E0K8ruOuVRCKxHRPuMbdhTKRWr2+7XjN5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXiyNqw11ykubqktvSmjutm5naIroZgg0Sqqc40bg56IdNN/OgSAARsb/f6dHkJTDTezgTdNws6TKICTNt176EfZk8PQvIusWIwPGXwwgYAKIOXhaXasYqeGnPyREAKSdhjaUVOHtbIOepHVoYtw3HetYaYJsppPGnuJoDa1iFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piwt6JmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E80C4CEC6;
	Sat, 26 Oct 2024 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729957052;
	bh=24uikJwv2E0K8ruOuVRCKxHRPuMbdhTKRWr2+7XjN5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piwt6JmXGff/XbUWVO8/1CW8P3vFxzlME+kxDaiR7f9fWdhF4abVkctvz3fNx9NWk
	 sDJ3XJAewjLvn8iHTa/ul7OS73zw8haAReIChBCXoDtRf9k5dl9jWJajG9oTl10Cai
	 JYf/IvE6ECpIgrrIRaHYTGsJT/2/oYPdaHMAyMyqeqZzGJKra3y77UabtkXrWdWq3s
	 juq2A2NiEt5DkM6VRTFEBbYRpBrtRCWI0h+6USWvRkgHSzwHS8OKjwUhXDDjFbxpgj
	 X9wCc4J5IFto17kTFfaGTl1yGFYcqL3yl9mzfb6sZsZNwwWO/d1h0Iy0WXonBU/5oS
	 GeEdmPLLwz2Dg==
Date: Sat, 26 Oct 2024 16:37:26 +0100
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
Subject: Re: [PATCH v4 net-next 1/4] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
Message-ID: <20241026153726.GK1507976@kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-2-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026041249.1267664-2-yuehaibing@huawei.com>

On Sat, Oct 26, 2024 at 12:12:46PM +0800, Yue Haibing wrote:
> igc_xdp_run_prog() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> igc_clean_rx_irq(). Remove this error pointer handing instead use plain
> int return value to fix this smatch warnings:
> 
> drivers/net/ethernet/intel/igc/igc_main.c:2533
>  igc_xdp_run_prog() warn: passing zero to 'ERR_PTR'
> 
> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


