Return-Path: <bpf+bounces-74048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F2C4573C
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DD0188E86F
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 08:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3912FE057;
	Mon, 10 Nov 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a+c+LxcM"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C226EA926;
	Mon, 10 Nov 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764744; cv=none; b=lIhCVmqpz0kTVxPl7P5ZHTWo+D8ejFZ/TG5SJNHhWPJ9F4PWc9MdONx+4+ruU6rhIT/AN8RJWkn7SJ0RnXMtRH1+BeZxql8HBTKZdYNMIcIUe4o2qejZ//jK85uNKo80IBAkcmBD03qkEUI4k3h4Rd/rjLUygSsscIDQi2pVIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764744; c=relaxed/simple;
	bh=9yaWt4J/YCTVdEjS+KQm9t8jdwbgGWgJOXd95kUi6m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjBnUtfaC0mOwO5Jy4bSdInvjA3hDDbAsRTJn2KRCU0HHGD0z+YEqSgPH+r9sNCVSFfdBhtlyJLjlzspTrHLqJFywr159lPIik6+TZgSRNsdLteVvsQqSjU6fY6z33n3i+8vhi/xYV0YmjDXpt6DGCiHDG4SAR71YQ3Le2bfLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a+c+LxcM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8gIELCuPU4s4dS0eT/lo51+RpmsRIzDjRKzivzFowRo=; b=a+c+LxcMIG8ZkyPPfYrmEIzCTV
	Wfd6RRv3N1x0mAdRYhkcE3ZJlo9YqwteRgBPoDDsogfocqT6qPU8v1TxBAT3A9NWr1vvkVU3XYZlm
	cNayLkPDPx9ezCIaQqx1TN7X7cgnKUgyWM5xhuUHsZL0GHTLsGWMjljsHQ7pdFY7QAYaBo4aVlbHw
	nK68JX+50bJEXM1IVcTxNYHYZ0Ped73ZfGbVTq9XRTsSTmZ1QetRcMjgxY03KGtPiDabCFfVIqr55
	mk0wtyA4VVoTwyG1/HZyy4sak5Ku/npid2aDZqGfj6aXSvaX8eg4aYIqyNhfJCBohx7Ffz7fn3jgK
	V5EqqvEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vINdD-0000000AxAa-2UtE;
	Mon, 10 Nov 2025 08:52:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 203FC30029E; Mon, 10 Nov 2025 09:52:10 +0100 (CET)
Date: Mon, 10 Nov 2025 09:52:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/3] perf: Add atomic operation in
 get_recursion_context
Message-ID: <20251110085210.GV3245006@noisy.programming.kicks-ass.net>
References: <20251109163559.4102849-1-chen.dylane@linux.dev>
 <20251109163559.4102849-3-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109163559.4102849-3-chen.dylane@linux.dev>

On Mon, Nov 10, 2025 at 12:35:58AM +0800, Tao Chen wrote:
> From BPF side, preemption usually is enabled. Yonghong said, it is
> possible that both tasks (at process level) may reach right before
> "recursion[rctx]++;". In such cases, both tasks will be able to get
> buffer and this is not right.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---

Nope, this function really is meant to be used with preemption disabled.
If BPF doesn't abide, fix that.

>  kernel/events/internal.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index d9cc5708309..684bde972ba 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -214,12 +214,9 @@ static inline int get_recursion_context(u8 *recursion)
>  {
>  	unsigned char rctx = interrupt_context_level();
>  
> -	if (recursion[rctx])
> +	if (cmpxchg(&recursion[rctx], 0, 1) != 0)
>  		return -1;
>  
> -	recursion[rctx]++;
> -	barrier();
> -
>  	return rctx;
>  }
>  
> -- 
> 2.48.1
> 

