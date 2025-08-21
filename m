Return-Path: <bpf+bounces-66192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0BDB2F6EE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952861BA7A80
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63A30F545;
	Thu, 21 Aug 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thnjZZX4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8682253A1;
	Thu, 21 Aug 2025 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776510; cv=none; b=imoJmaKMporvIzGbhojdUZfbSZPvcC4j66jhcc1n73rrz2SYO6PdZELvC6JvSVAxHFpz6QW1jR1QTCbW6osD5+KwmcBPpWapPLIJ+/7yMEtSm6E7cydR6BYeT7z+7r+bcgDK7InEFrx4/H6N3ZoEE7VtueAzVRx+XyxEds6iLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776510; c=relaxed/simple;
	bh=UlimAOmq4oBwLMElEItrHUAt5oszOCegMRpxWXdd0K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmsAxMjP/OHHaScujhABi/L274obWLypVjRTY71T9Zh46DgsLf+BfJi00urz+2fMKB6vTQYPpSkMDcay2xOR+rfedOkfgLPVQEKdQ+FPHhXqM9kmkpcGmWorIqRNNaAeRjIUGFCQmDSwyuqqbEv82vAxyx31zWUhh390sGccINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thnjZZX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C06C4CEEB;
	Thu, 21 Aug 2025 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755776510;
	bh=UlimAOmq4oBwLMElEItrHUAt5oszOCegMRpxWXdd0K0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=thnjZZX4M0j7D4VmGOdSAk4KMpbTymEJH6+vygU/eBOW/Y5XYrXKRwSNocQ79AAZI
	 tNhfBxJBg3G399FlkyAZ/Ys1Bo9gr/jB3Qu1sgyEb9UmH4JMEjURK6QU2K9i5d2Sca
	 CsI+KJNhsS6Pb0//+QqvQ+3uJ/s0bZNjs/6gsL4MoosfUOx8Ui7FqkBETdNbrMZIri
	 nQe43p3CezaEVWHZIX0WFvZ1UnS364zDzdrB6MWPfw1dUY/vS7sHvGhuGulKKPo9mU
	 PwZysvqIDGD1ktFoRYGUtZXVjWwjBcv6C30C0iu93nENDITwWGqArAEE51VdZ3egsn
	 jE0YeLbweXzWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5A27CE0A48; Thu, 21 Aug 2025 04:41:49 -0700 (PDT)
Date: Thu, 21 Aug 2025 04:41:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/7] rcu: add rcu_read_lock_dont_migrate()
Message-ID: <a9745beb-133a-447d-80ea-b7322676b3ed@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250821090609.42508-1-dongml2@chinatelecom.cn>
 <20250821090609.42508-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821090609.42508-2-dongml2@chinatelecom.cn>

On Thu, Aug 21, 2025 at 05:06:03PM +0800, Menglong Dong wrote:
> migrate_disable() is called to disable migration in the kernel, and it is
> often used together with rcu_read_lock().
> 
> However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
> will always disable preemption, which will also disable migration.
> 
> Introduce rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate(),
> which will do the migration enable and disable only when PREEMPT_RCU.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Much better!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> v3:
> - make rcu_read_lock_dont_migrate() more compact
> 
> v2:
> - introduce rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
> ---
>  include/linux/rcupdate.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 120536f4c6eb..9691ca380a4f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -962,6 +962,20 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  	preempt_enable_notrace();
>  }
>  
> +static __always_inline void rcu_read_lock_dont_migrate(void)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +		migrate_disable();
> +	rcu_read_lock();
> +}
> +
> +static inline void rcu_read_unlock_migrate(void)
> +{
> +	rcu_read_unlock();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +		migrate_enable();
> +}
> +
>  /**
>   * RCU_INIT_POINTER() - initialize an RCU protected pointer
>   * @p: The pointer to be initialized.
> -- 
> 2.50.1
> 

