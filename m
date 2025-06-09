Return-Path: <bpf+bounces-60087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD2AD2702
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2B3ACBF7
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F533220F24;
	Mon,  9 Jun 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnDkqIch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372B22068A;
	Mon,  9 Jun 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498551; cv=none; b=S2MnrOd29+BuuhInt5ome9KpKiO5U0zY3mgu+k/qlnLUdbVf4dg19QE3UjTbjOe4+xbcr5CjMKJ2GhoDtbmzSmV/FKHa7EVd+qdTRP3UL4FdAOedMXQYc6Iyq0SyfvTMrPsQEB+uODFqlpOHnoUBRBeKdUJhhnP55yl/DNOwg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498551; c=relaxed/simple;
	bh=NfaEdvw3IQT5MJNS3KQjCx3b2X/FclhrBk50shOMe6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYPtZJAhQv55eR37SjnRV6WYSZQoRkNBcKE5QliuJ2t2FrZqeQ/mE1UHQS8oyN2sZqavb+Qx/qFYtoS9mauUpxxBjCwhT/V+nvuHefn1i9a57tf+SqykSUW7Rwp50B4q+D7pocNrY0R/RZkSnfFNaHMZr7n4sihWFT4UMc9Se5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnDkqIch; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d09a17d2f7so396106685a.1;
        Mon, 09 Jun 2025 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749498549; x=1750103349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeSH/A2je0AmZyahfqiWYvUhnJHMIEFACLeHVV2KLwg=;
        b=hnDkqIch8oY4mCUkua21TUteOscGioq6XEpI8PrlZl2hDwN91cr2gREs8odJAC4yMY
         ogvp8JwGwXdOxWkX3qvKW3GySIjTG488SS6PHyaQI+cYZ+Vf9ahNOXNUpyjVR2lTzWsD
         9l8NBYj4TNuY+ls8jzCN2c0oDKFLUuQrBI2SNtE12N/mLhf0zVz2butVjS8Uhe+9Lk+E
         SDOmc6Uw2Stnzz8WvRl0QDgf5tNxWnQrfV4miyUonoI+0HfXph4S1um/s8TKETbMPT+f
         6oRKD4gS/3Qk61ZPlYPWNtX15LU+TlyTsdOQhoxAFGTmBekCXVFfffCcnaXAuIOzZdta
         Zx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749498549; x=1750103349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeSH/A2je0AmZyahfqiWYvUhnJHMIEFACLeHVV2KLwg=;
        b=mgaNx9OHX0GZtoMF9iVS8oyVpzDtL9Z8ickXMFQ8ePQwHirDhB+IKKl7Kuh93vnM3K
         rB2WcxMC5hV4OUL9IwjcL08i/qfJ+hYZUzq7XkqCk15r984xxMVtF8lnryLo9MhC4M8i
         nEhUAeY2lhqzkU3JKfAzvSvMigR/GMkVpKDl3nfVt6CpmuoVozFZMT334RyW6NBa4jic
         NtT0YVXFKj+y5pSnvW5Ar4JuLiCpsP42OFmvu0mDKsIOiRbvyz3z1JRIVFaKgotrCSn2
         jSJVD9yzEo3l0ex0ow2cCrvNXassg6zz7qg3hHg3Fx8I81SCU3ZcYSFqrMmk7a+4l3Cf
         Vrkg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDdYny1LybEHQ5yCcPhisO/9oukDYxwNxsglzowp2mQZiKGwhluUXDYTTmqKm4EOVriE=@vger.kernel.org, AJvYcCW04bsoDWbeD3gx2R5sdThcM2GP3ohJM4vQ9HTFzSueTjg5NJJ+0Min/t/DL66MrkXUmecY@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9ZeGmlRnFDTTPyMpfRowqFnsaK5UmfOiRlmGoAPIKmORPOVz
	yBsVtUMAfbHh4jsv9Q8vWA+mTyaITdTnkjT3h9SbKpJCDZEOG9Ygpfe2
X-Gm-Gg: ASbGncsO60kN32vgiQmjk/o7DFVGbTL0PzYk9BE8Dh3W9auaL3IfxTaHvL8CQRQj/Yd
	DFp7o6ewWioqSmrsxWVow0ZBulVbUA0lnF/eyuvn3lN+QZRbNTjqaRxSuOq5d+Hjv9qqZofaUl5
	+5BHiaCTSH2gkz+Ve5WG9IYp+e0r1gycf57u1oSQzQEsYpQPqY96/u6TSpBq17mBG7KraUHpOCt
	PaSQwGIA+0CgPmGNjGKhXhDyViBllzcR1nnHgijbRe6T1lkoOzqopl5hRQgkOsl28hxgT8cTJaZ
	JxbHXpVfSMMrJ0x8VyO7QcmT8C7uFuhtX0UX+WKXYKYb6VjDuO3I2U6/chZeP5BQkvkicQyfc7y
	3XnDkS3dhMI8ZorM1mm8y8Oz20IgYq4s8TF4ShoNG1JWhJHvk+Ua4R8I9KUPDR/Y=
X-Google-Smtp-Source: AGHT+IE6oDGHSdMBa/LHIKbHLa8sGh5BJr+uycjoviYS0NXxIhOgnl9eNve0uTt6ZRgMc69sGw1VZA==
X-Received: by 2002:a05:620a:19a2:b0:7c7:bb07:af07 with SMTP id af79cd13be357-7d22986104cmr2200375385a.22.1749498548985;
        Mon, 09 Jun 2025 12:49:08 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab9482sm55573216d6.19.2025.06.09.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 12:49:08 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id ECA1A1200043;
	Mon,  9 Jun 2025 15:49:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Jun 2025 15:49:07 -0400
X-ME-Sender: <xms:szpHaFa_w5E7mnONkbv8ynZWECqbjcX-m9hl7HUqBMoyAMAfqh1E_w>
    <xme:szpHaMbXfS3RNevBz2ZsHDW49ET9MthGrhmtYcTzv0izYf7WNOxojXc4onLDqkm-_
    N7HD2hvFJlp3w4U7w>
X-ME-Received: <xmr:szpHaH8bWQS0a6l9SQST8ue1w5AVbqCzAOMvWQ4XTZa76-Kpvh3i2L9fZgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeljeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulh
    hmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
    pdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrghdprhgtphhtth
    hopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehg
    ohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:szpHaDo7nKgy5sMpBadtC_6Z9JdU8q0OtDRgU5834E1km3w6FbIUNw>
    <xmx:szpHaAoYd0nMX0tb5ks0nEthovQDZozKjUVcduWhIngf4wkhxb6ClA>
    <xmx:szpHaJTUbJ0xTddaN2ieujLxC-XtagAOcMeYx_umnHlzRN6e1rVrdA>
    <xmx:szpHaIoMYZFzkQc_guNzCUAXy4RdQmv3UVDn-M022IXy5LEkxEI-kA>
    <xmx:szpHaJ4ff1tS9AlSqMOYhuFKRErxWf25MLDfh9iS-789F7HpWaq3yR-E>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 15:49:07 -0400 (EDT)
Date: Mon, 9 Jun 2025 12:49:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <aEc6sroqylvlfx_M@tardis.local>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609180125.2988129-2-joelagnelf@nvidia.com>

Hi Joel,

On Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes wrote:
> During rcu_read_unlock_special(), if this happens during irq_exit(), we
> can lockup if an IPI is issued. This is because the IPI itself triggers
> the irq_exit() path causing a recursive lock up.
> 
> This is precisely what Xiongfeng found when invoking a BPF program on
> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> using context-tracking to tell us if we're still in an IRQ.
> context-tracking keeps track of the IRQ until after the tracepoint, so
> it cures the issues.
> 

This does fix the issue, but do we know when the CPU will eventually
report a QS after this fix? I believe we still want to report a QS as
early as possible in this case?

Regards,
Boqun

> irq_exit()
>   __irq_exit_rcu()
>     /* in_hardirq() returns false after this */
>     preempt_count_sub(HARDIRQ_OFFSET)
>     tick_irq_exit()
>       tick_nohz_irq_exit()
> 	    tick_nohz_stop_sched_tick()
> 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> 		   __bpf_trace_tick_stop()
> 		      bpf_trace_run2()
> 			    rcu_read_unlock_special()
>                               /* will send a IPI to itself */
> 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> 
> A simple reproducer can also be obtained by doing the following in
> tick_irq_exit(). It will hang on boot without the patch:
> 
>   static inline void tick_irq_exit(void)
>   {
>  +	rcu_read_lock();
>  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>  +	rcu_read_unlock();
>  +
> 
> While at it, add some comments to this code.
> 
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c0bbbbb686f..53d8b3415776 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -653,6 +653,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  		struct rcu_node *rnp = rdp->mynode;
>  
> +		// In cases where the RCU-reader is boosted, we'd attempt deboost sooner than
> +		// later to prevent inducing latency to other RT tasks. Also, expedited GPs
> +		// should not be delayed too much. Track both these needs in expboost.
>  		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
>  			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
>  			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> @@ -670,10 +673,15 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// Also if no expediting and no possible deboosting,
>  			// slow is OK.  Plus nohz_full CPUs eventually get
>  			// tick enabled.
> +			//
> +			// Also prevent doing this if context-tracking thinks
> +			// we're handling an IRQ (including when we're exiting
> +			// one -- required to prevent self-IPI deadloops).
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu) &&
> +			    !ct_in_irq()) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> -- 
> 2.34.1
> 
> 

