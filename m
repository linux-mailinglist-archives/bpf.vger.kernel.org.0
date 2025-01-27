Return-Path: <bpf+bounces-49873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D629EA1DAEE
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453961888277
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56117C230;
	Mon, 27 Jan 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDgUDXIa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E591155A30;
	Mon, 27 Jan 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997278; cv=none; b=ZCnVgDM+XsAieb2eoohFOqN2N1LbQpTa2l3f7pULC0rNfs22QiC4XpYC/TKLrr0u8DthGWxFseLEkxkCQuyjhY5JW1FnQESVSFil0dzGS/8twBa5Bjhz1VQ3oT2tvZTRSlaMq9JSWrX33KKpmVnw8uwljowNVTRKJk5oZoQ+xBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997278; c=relaxed/simple;
	bh=nZMe67iC2cfntqyhHatSInrcFPPcQS5JKLd9WXO+8fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvS/+xDMgvuFOje/Rzy074KOGo++eZc+IMjYxlSPrP5gmqYoU/sQ9Dr7aGQ1Zu03VFmm51N+EGywl+Jpdv5S68d0kUzk2k5uoPgMKsUF87jjv8M81/mwaiSZCT/+zQrHjgF89c9LmfrMQ/YnkEXb9ANS0IRz1CH/1edPIiz1Y2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDgUDXIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C934C4CEE4;
	Mon, 27 Jan 2025 17:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737997275;
	bh=nZMe67iC2cfntqyhHatSInrcFPPcQS5JKLd9WXO+8fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDgUDXIaWWNR/FnHgc0fvM7CGuZSMx3U/z7uYCZiZW9BzCjUb3Tqys4K21Mxgyj+M
	 JcH9AlxAukfQhK1cLawv8BxLKkua+LGFy1FogrFlr9XTMXU/5c8mDE4ZGBiJhb1/BH
	 kDVUAixGA5bA6Ria1IqPNo5vdwOaELt+Xcj1LXROlizb9aQ0KvQ5Q+FXDB3fPJ1AXe
	 WjvaI/FFGWJwd3gatfVJP2F1CowM1m1DKYbppkPJgNblyQUCIHtg1Kt/1cuD5M+1nv
	 I5dzqM7y/cWJxqlyaVx2vVR1xrlqS+hPjGQ2jnAUKHK0m4OWP/uHMc8yrnzX4uyXA6
	 bNibi+F1XN/fw==
Date: Mon, 27 Jan 2025 17:01:10 +0000
From: Simon Horman <horms@kernel.org>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, u9012063@gmail.com, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, ast@kernel.org,
	alexandr.lobakin@intel.com, alexanderduyck@fb.com,
	bpf@vger.kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [PATCH net] vmxnet3: Fix tx queue race condition with XDP
Message-ID: <20250127170110.GE5024@kernel.org>
References: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124090211.110328-1-sankararaman.jayaraman@broadcom.com>

On Fri, Jan 24, 2025 at 02:32:11PM +0530, Sankararaman Jayaraman wrote:
> If XDP traffic runs on a CPU which is greater than or equal to
> the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
> always picks up queue 0 for transmission as it uses reciprocal scale
> instead of simple modulo operation.
> 
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
> returned queue without any locking which can lead to race conditions
> when multiple XDP xmits run in parallel on different CPU's.
> 
> This patch uses a simple module scheme when the current CPU equals or
> exceeds the number of Tx queues on the NIC. It also adds locking in
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.
> 
> Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
> Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


