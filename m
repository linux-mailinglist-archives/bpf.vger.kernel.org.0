Return-Path: <bpf+bounces-43237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA679B1941
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD001F2229E
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CF1D271D;
	Sat, 26 Oct 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK9W7vPA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561678C6C;
	Sat, 26 Oct 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957068; cv=none; b=GqU9eN5jldBEmLmC0glq1khUKnW1MZ1r+UrBnQTAeDQ46gxgeJbJ6g0elGJ0sC0yKsFQqtuCCPwQI6gLt/8TWtcPv5EMvEK/3Qdbk8YCG3yxNAV5ScS17+yXOv7Kup5JLwdxVGk+5ewicAugipkk8O/0tDFAEIB5zr6qaMg/5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957068; c=relaxed/simple;
	bh=J/pySOqdQbC0PUYIJrkvno4pdFRrrM8O/AMC9oqFvOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASyqgRTMRptVY8fx9jvjBsbGwhgw7dDLSTdtxbbwB/QxHsfqbQq0OldZ8MpuhT//J/L4OX9YkUqo2UQQO9gECyhiRko0IWurfxVB4OrBxCeMr7WmzG67VL1HWhbOcNjXkKcrVtEkDEGpjVUFc1BV1Xwp2X+vZWYsKHs+cN/zCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK9W7vPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB03C4CEE5;
	Sat, 26 Oct 2024 15:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729957068;
	bh=J/pySOqdQbC0PUYIJrkvno4pdFRrrM8O/AMC9oqFvOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lK9W7vPAwGUPtwc42qru4fapuGmElf2Mfl5Az5wkZZocNeNFVhic7Ix/GUJ3xrqtr
	 Gokwrg/cN5sNA/HrVGBGvS/okrGF4DPdrmGVRE+zTtB4gHfUEjSTXa8fAG6fQlQZEI
	 3mFdyBwznc2kenqyjrMxwyAi2ZIG0y4tNWt76BElluIZZ+LGovHmbMf6D67b+4W2FA
	 3r+PFPGRe5AB3UaWZC+583UqarYFbXT1b3RpM+x7gGuOhXd6sRfXRJyyqHu1/7+0+V
	 mtGReDo288JQDQlQ+7y+u2DOVvnH5ORL370Bs5jSdieuNyY4YdXPQsMh+hJExq8Nrs
	 u3NNeoxEARuDA==
Date: Sat, 26 Oct 2024 16:37:41 +0100
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
Subject: Re: [PATCH v4 net-next 2/4] igb: Fix passing 0 to ERR_PTR in
 igb_run_xdp()
Message-ID: <20241026153741.GL1507976@kernel.org>
References: <20241026041249.1267664-1-yuehaibing@huawei.com>
 <20241026041249.1267664-3-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026041249.1267664-3-yuehaibing@huawei.com>

On Sat, Oct 26, 2024 at 12:12:47PM +0800, Yue Haibing wrote:
> igb_run_xdp() converts customed xdp action to a negative error code
> with the sk_buff pointer type which be checked with IS_ERR in
> igb_clean_rx_irq(). Remove this error pointer handing instead use plain
> int return value.
> 
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


