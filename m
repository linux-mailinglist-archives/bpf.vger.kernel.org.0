Return-Path: <bpf+bounces-56309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54FA951DB
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6861218945A6
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368326656A;
	Mon, 21 Apr 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agg/ZlKf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5741A83F9;
	Mon, 21 Apr 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243088; cv=none; b=XwILiCtwsgE3r9Xfk95pb4WdtfAYALbeNNcS5XXlWDmDt2Nqzu7I8f99Y/t8GXADvoisfOuLMkOSzSeJzWj+9IPGdQgQ2i2auoRD/qvM8BD25mibUpfkIa7bizWF8E4wsoGB92m3tcSgT6uQk0K3pCVcOS4g2d7WEPSoXrbl5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243088; c=relaxed/simple;
	bh=G6FxoJLKFHERPMeKjiLbFx7X8l5JWlzu9uf8PTSsFW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj0zbPY4VVf9bC+RbwTn/zrUDGOdiAxZ8A+JQW4RCfFsunaKNNwP093LOBhNqyE49kt+QxvSacVdIwR11EzyrZ9TnWQhcHm2CId4tl+A7S9I1Bq9k3ehssxHCZju3MPmluqWADCZYyepOejeVJ3LaRxz8OERVKqGrIUJpWoap9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agg/ZlKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E97C4CEE4;
	Mon, 21 Apr 2025 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243088;
	bh=G6FxoJLKFHERPMeKjiLbFx7X8l5JWlzu9uf8PTSsFW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agg/ZlKfSuamPNpyykRssodgY9plQYN3lWy1fsotU6TQdY/3Thj1lzrZW3vaUvK3N
	 4q8OVPe6r3Ana/gWRObTrW+LVGb0mtK+odvI+c+3+fnVBgV5zMx8ld4a+an1rNvdXY
	 0VOSD/hLCONTXJMCNkBA19EZqq8KxxMpbFxT4xFKjrrKOatHc0aPaaa6rFSyzTHwZ3
	 JP9D8hlhdYTJ7qS4KqmAj1RnID31L8Z+LZvTfAKGPtgY79Pqi20HgBmrLgbkUvDdyE
	 qYSpqAEQ7GGbeDfQsranY9+8foNSTTaefjdDCVllsvysBm9kD9gIDT4vlG5fM5cLHv
	 iPfe6jXJebaCA==
Date: Mon, 21 Apr 2025 14:44:43 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net v3] net: lwtunnel: disable BHs when required
Message-ID: <20250421134443.GG2789685@horms.kernel.org>
References: <20250416160716.8823-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416160716.8823-1-justin.iurman@uliege.be>

On Wed, Apr 16, 2025 at 06:07:16PM +0200, Justin Iurman wrote:
> v3:
> - removed unrelated code cleanups
> v2:
> - https://lore.kernel.org/netdev/20250415173239.39781-1-justin.iurman@uliege.be/
> v1:
> - https://lore.kernel.org/netdev/20250403083956.13946-1-justin.iurman@uliege.be/

Hi Justin,

There is probably no need to resend because of this,
but the changelog above belongs below the scissors ("---")
which will preserve it in mailing list archives and so on,
while excluding it from git history.

> 
> In lwtunnel_{output|xmit}(), dev_xmit_recursion() may be called in
> preemptible scope for PREEMPT kernels. This patch disables BHs before
> calling dev_xmit_recursion(). BHs are re-enabled only at the end, since
> we must ensure the same CPU is used for both dev_xmit_recursion_inc()
> and dev_xmit_recursion_dec() (and any other recursion levels in some
> cases) in order to maintain valid per-cpu counters.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com/
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Closes: https://lore.kernel.org/netdev/m2h62qwf34.fsf@gmail.com/
> Fixes: 986ffb3a57c5 ("net: lwtunnel: fix recursion loops")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>

I agree that this patch is in keeping with the solution discussed
at the links above.

Reviewed-by: Simon Horman <horms@kernel.org>

