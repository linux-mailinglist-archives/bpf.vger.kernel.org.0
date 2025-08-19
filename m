Return-Path: <bpf+bounces-66018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51587B2C7D5
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FB13A6D83
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1D283FDD;
	Tue, 19 Aug 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNXMDa6r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B623279DAE;
	Tue, 19 Aug 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615474; cv=none; b=beD7jP48FoJBxVO+wrtc2fM/nJMQa5wITOJfQQ8zBPyCNhRXzSPFCW7RDAcrfzXpcyN0kF83PXZEALGlR9vHD7GeRpIfW5vlZKBANSjv9Eq6ZlkAZ05V8RrUHlxaYMUtj3I6gAvUtktuv5r1pHn3NdG1yX1rP5nihtWUN9tVKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615474; c=relaxed/simple;
	bh=ZIhqK2oLghpkzhJHGJUJuX8CRKAF2F//o9f3wstjuUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfj7Zuj5YmOrL4ZAWETvsPYVKoXUGHUTRk8H4cPEgi5S0h2JCtAafG5r4l8ihmq9mHxzZ9vihLas0d6R24r5Un7qD2eCAAvgVDFx9h8CQpdMSnXgTieLQ1hzAtnrzVtjveaUTaWtYbqkjVi041llMjvtyRYyMttYybOKd5mNUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNXMDa6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82535C4CEF1;
	Tue, 19 Aug 2025 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755615473;
	bh=ZIhqK2oLghpkzhJHGJUJuX8CRKAF2F//o9f3wstjuUc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pNXMDa6r3QTouasN/+4waq+wuc1kimFkgP8G16BAVtugwQAfreIzgVHKjGnJ/Q/O4
	 i7Dtl/n5j4/Rwwtn/c24y7oVpZg0QFHIMXsG3CxGOSed1QC+2b2Shcb1qUNRnAFqkp
	 NaEoHPYsPrfRv/7y/PcAhJbv4K6LGMQzeJYWd0ioHixZ0ihiHaP5KItOc87n3nNlIQ
	 +n3gfkte2s2KPAkPSb5sr83w7Lv7PF8QYe4J9LUbyQ4k1fFMqqNYiBpF8ly1QxV50t
	 HWCTtK09Li6lovZlKPrnqkp1VjGsFTQt1h+L8tqtEhJMOa8wf3hJuvr2TNqTl1lo0b
	 L0OjEmsGrIsZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C2F6CE0853; Tue, 19 Aug 2025 07:57:53 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:57:53 -0700
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
Subject: Re: [PATCH bpf-next v2 1/7] rcu: add rcu_read_lock_dont_migrate()
Message-ID: <38a57013-6c0d-4a98-a887-54ff2133817d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
 <20250819093424.1011645-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819093424.1011645-2-dongml2@chinatelecom.cn>

On Tue, Aug 19, 2025 at 05:34:18PM +0800, Menglong Dong wrote:
> migrate_disable() is called to disable migration in the kernel, and it is
> often used together with rcu_read_lock().
> 
> However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
> will always disable preemption, which will also disable migration.
> 
> Introduce rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate(),
> which will do the migration enable and disable only when !PREEMPT_RCU.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

This works, but could be made much more compact with no performance
degradation.  Please see below.

						Thanx, Paul

> ---
> v2:
> - introduce rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
> ---
>  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 120536f4c6eb..8918b911911f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -962,6 +962,30 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  	preempt_enable_notrace();
>  }
>  
> +#ifdef CONFIG_PREEMPT_RCU
> +static __always_inline void rcu_read_lock_dont_migrate(void)
> +{

Why not use IS_ENABLED(CONFIG_PREEMPT_RCU) to collapse the two sets of
definitions together?

> +	migrate_disable();
> +	rcu_read_lock();
> +}
> +
> +static inline void rcu_read_unlock_migrate(void)
> +{
> +	rcu_read_unlock();
> +	migrate_enable();
> +}
> +#else
> +static __always_inline void rcu_read_lock_dont_migrate(void)
> +{
> +	rcu_read_lock();
> +}
> +
> +static inline void rcu_read_unlock_migrate(void)
> +{
> +	rcu_read_unlock();
> +}
> +#endif
> +
>  /**
>   * RCU_INIT_POINTER() - initialize an RCU protected pointer
>   * @p: The pointer to be initialized.
> -- 
> 2.50.1
> 

