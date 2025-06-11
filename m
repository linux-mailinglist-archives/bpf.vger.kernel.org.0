Return-Path: <bpf+bounces-60346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AAAD5C09
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854213A6488
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE291E9915;
	Wed, 11 Jun 2025 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/WvkbOb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346819D8A7;
	Wed, 11 Jun 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659108; cv=none; b=IvuEHCZOCnZsF4ykEW7EDT6H5v3bs0NBb8h5HFFXhAz6NQi/r6ewBpETHD6VPrmnOViRlMloJsYwNp9uc+4E647Q4ecgw+1XDAmJsrhr6KamHnvRdZ9RVh0ivvMXs/rG1E9n6Tqiw4olx72cR837CHo0jqo1ULtWOVcmBNJHJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659108; c=relaxed/simple;
	bh=G+T8wW9Nt6f9EEFn99e/NM3xHauN4ohp03gUHIvPj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAOW/QCSAvz8mW+AlYxsxkrcDjZlXO216U/2UP+IHc0s213wW9j61pcUuKnhrLliWbXYKy9kVJ6C6PlkZvYoJVJs/IPCHv3njE1wPfkgEbWOLzdKADEgC6Re9oZ+naEexX9GLylzfRvDsy6mtrKJfrl+615qk6fRK4HJJWtlcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/WvkbOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01CAC4CEE3;
	Wed, 11 Jun 2025 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659107;
	bh=G+T8wW9Nt6f9EEFn99e/NM3xHauN4ohp03gUHIvPj4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/WvkbObsbjNbgbEriiSoaQKl/8tmYm0VWOix2l+jaU6aISJJ/jeU4XPGeiPg5ecr
	 o9NIzLQh4Blqe5BtVC/JF9ULmsTdW6ESVq2KjPgTvv4ex0vGX849E/ZuVfz7mqOVOs
	 f2PKfEQ/gdnBcd8WlJlgh19glj4Tks3/+5R6ZATk+p6io3uzrtmefSZSPx1jOi7O8h
	 QLXNRFeDP9FqtS9il+mFfflReX29kL/C9p8NG3XsMRMezyP+7Uc3OtWG9APQXlKfa3
	 cClW3aYu+/KJf9YA4zo/vjFVQtPLJ1rG3012zm/Y4cA8tB/y9WaVadgP+4yZVoTeaG
	 hlsk3GsEB01FA==
Date: Wed, 11 Jun 2025 18:25:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] context_tracking: Provide helper to determine if
 we're in IRQ
Message-ID: <aEmt4Aa3-gULNtic@localhost.localdomain>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609180125.2988129-1-joelagnelf@nvidia.com>

Le Mon, Jun 09, 2025 at 02:01:23PM -0400, Joel Fernandes a écrit :
> context_tracking keeps track of whether we're handling IRQ well after
> the preempt masks give take it off their books. We need this
> functionality in a follow-up patch to fix a bug. Provide a helper API
> for the same.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  include/linux/context_tracking_irq.h |  2 ++
>  kernel/context_tracking.c            | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
> index 197916ee91a4..35a5ad971514 100644
> --- a/include/linux/context_tracking_irq.h
> +++ b/include/linux/context_tracking_irq.h
> @@ -9,6 +9,7 @@ void ct_irq_enter_irqson(void);
>  void ct_irq_exit_irqson(void);
>  void ct_nmi_enter(void);
>  void ct_nmi_exit(void);
> +bool ct_in_irq(void);
>  #else
>  static __always_inline void ct_irq_enter(void) { }
>  static __always_inline void ct_irq_exit(void) { }
> @@ -16,6 +17,7 @@ static inline void ct_irq_enter_irqson(void) { }
>  static inline void ct_irq_exit_irqson(void) { }
>  static __always_inline void ct_nmi_enter(void) { }
>  static __always_inline void ct_nmi_exit(void) { }
> +static inline bool ct_in_irq(void) { return false; }
>  #endif
>  
>  #endif
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index fb5be6e9b423..d0759ef9a6bd 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -392,6 +392,18 @@ noinstr void ct_irq_exit(void)
>  	ct_nmi_exit();
>  }
>  
> +/**
> + * ct_in_irq - check if CPU is in a context-tracked IRQ context.
> + *
> + * Returns true if ct_irq_enter() has been called and ct_irq_exit()
> + * has not yet been called. This indicates the CPU is currently
> + * processing an interrupt.
> + */
> +bool ct_in_irq(void)
> +{
> +	return ct_nmi_nesting() != 0;

If rcu_is_watching() and not in an interrupt, ct_nmi_nesting()
is actually CT_NESTING_IRQ_NONIDLE. If rcu_is_watching() and
in an interrupt, ct_nmi_nesting() can be CT_NESTING_IRQ_NONIDLE + whatever.

So this doesn't work. I wish we could remove that CT_NESTING_IRQ_NONIDLE
that is there for hysterical raisins but that doesn't fit in an urgent pile.

So probably:

bool ct_in_irq(void)
{
	long nesting = ct_nmi_nesting();

	return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
}

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

