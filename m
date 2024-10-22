Return-Path: <bpf+bounces-42756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8349A9B1F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5FB25B53
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB91537B9;
	Tue, 22 Oct 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVfp3th2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3814B088;
	Tue, 22 Oct 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582352; cv=none; b=LQJHDFndNnGKghzJIY5rE3tORLO2v7ropSje38heTTAU1qaHh1I7vQv4djNgAjS6ndP2y8TFf8ya6bklNEs7GONkPGPGO1kI8mXCfXPJIy6uzSAOqMQm2/ZHPwjM7XNp8fV6RytX+TFSuvTDKHeq00CbVPIgknVc9chxjTFvyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582352; c=relaxed/simple;
	bh=KPwac6l+2tUtMD2vs4OOQYjiSpu5Fyksb4QT8Letd7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGhJ3YF14GAHxhh7u2+G+DYjCZz0Xf4Nf8O8C56PJ/jVi4N0xJBUIT1kDQBeMtKluiDa88Ns54wjv3EUeFmue678Kyj/RvEwzqvN+iZ2abwc2K48C/BvNEenzdWvy1wwyRayhbL2Mn4TJpimvTevBvm1Zuh0PwDYI0AvfrfcrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVfp3th2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B53C4CEE4;
	Tue, 22 Oct 2024 07:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729582352;
	bh=KPwac6l+2tUtMD2vs4OOQYjiSpu5Fyksb4QT8Letd7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVfp3th2asmEs1VDi+Jim8+lR++xFADU+Psocn9CuEgAduqY6GvxVNMmxO36SIfhZ
	 UNs25XfBW7YVmeZV8sKvwMJ7XT6PeEkUF97iIdc3pvd//oqQ8O8k6qISB1y7gFHQFI
	 nkubjcuMtn8Ip/NQG/8pGwZsPCZ+b8Vlbv6mB/cOzhN0uN7G+auRQ2eDOOzbp4xzMI
	 kldfoB6SbR+QaKtCHEotTUzD0Ky6XyuTA/0KFpf2/txPy+3IOvfFh6Njxa5A6xb/0t
	 t0qBLZ4ZMPE9k7c2ZjN5hIuLF5Blk3V5omeLCxzbjwFDIHcabo11m3/PWSXnVy3X1h
	 0edHIR25rvMIQ==
Date: Tue, 22 Oct 2024 08:32:25 +0100
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
Subject: Re: [PATCH v3 net 0/4] Fix passing 0 to ERR_PTR in intel ether
 drivers
Message-ID: <20241022073225.GO402847@kernel.org>
References: <20241022065623.1282224-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022065623.1282224-1-yuehaibing@huawei.com>

On Tue, Oct 22, 2024 at 02:56:19PM +0800, Yue Haibing wrote:
> Fixing sparse error in xdp run code by introducing new variable xdp_res
> instead of overloading this into the skb pointer as i40e drivers done
> in commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") and
> commit ae4393dfd472 ("i40e: fix broken XDP support").
> 
> v3: Fix uninitialized 'xdp_res' in patch 3 and 4 which Reported-by
>     kernel test robot
> v2: Fix this as i40e drivers done instead of return NULL in xdp run code

Hi Yue Haibing, all,

I like these changes a lot. But I do wonder if it would
be more appropriate to target them at net-next (or iwl-next)
rather than net, without Fixes tags. This is because they
don't seem to be fixing (user-visible) bugs. Am I missing something?

...

