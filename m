Return-Path: <bpf+bounces-15750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5B7F602E
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4036D1C210A1
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974924B5D;
	Thu, 23 Nov 2023 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/nwfGoV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377D24B53
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 13:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08983C433C7;
	Thu, 23 Nov 2023 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700746023;
	bh=qvQuo3HeJmrQpVLhE3Y7RkTHOBgyevGpgvlXQB4o1AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m/nwfGoVuszaYTAzNVhIV+mkLGD0PDfL7aTgjJYjp8FKxDwGA35ZngRKAfNdNYAmD
	 0F2Bnfg0JDBvkoDBfYqfIyw60VfOQhJX2GV95XuDrVjsl/UyrCTAMq9uAsIJuWPcJ1
	 GkOTCt6LkB01yqZQUGnWs2Omh1xsOzcMT0/6hn0kp+TFRTYQbnUVA8Dkp/hgNE+rtK
	 9ohlwc7WoURacGR80XqN1Y0IxcYLtTgGW/ZykTcY8EySy+k5LBXxvroNjEzvF5Gy+T
	 qWNWHtd+u1hCQTWXL/E0GvTkltPQWmLpcJrKS/n1i2BrGnf/jlPTi3HuG0vkTnuiJX
	 i3FlcDe/WSibg==
Date: Thu, 23 Nov 2023 22:26:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: rostedt@goodmis.org, peterz@infradead.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] kprobes: consistent rcu api usage for kretprobe holder
Message-Id: <20231123222659.4f191f9c6b1b7a285ea21b07@kernel.org>
In-Reply-To: <20231122132058.3359-1-inwardvessel@gmail.com>
References: <20231122132058.3359-1-inwardvessel@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 05:20:58 -0800
JP Kobryn <inwardvessel@gmail.com> wrote:

> It seems that the pointer-to-kretprobe "rp" within the kretprobe_holder is
> RCU-managed, based on the (non-rethook) implementation of get_kretprobe().
> The thought behind this patch is to make use of the RCU API where possible
> when accessing this pointer so that the needed barriers are always in place
> and to self-document the code.
> 
> The __rcu annotation to "rp" allows for sparse RCU checking. Plain writes
> done to the "rp" pointer are changed to make use of the RCU macro for
> assignment. For the single read, the implementation of get_kretprobe()
> is simplified by making use of an RCU macro which accomplishes the same,
> but note that the log warning text will be more generic.
> 
> I did find that there is a difference in assembly generated between the
> usage of the RCU macros vs without. For example, on arm64, when using
> rcu_assign_pointer(), the corresponding store instruction is a
> store-release (STLR) which has an implicit barrier. When normal assignment
> is done, a regular store (STR) is found. In the macro case, this seems to
> be a result of rcu_assign_pointer() using smp_store_release() when the
> value to write is not NULL.

Good catch! I think rethook also needs this barrier to access its handler
field. (unlikely to the kretprobe_holder, rethook->data field is not used
for checking unregistered)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  include/linux/kprobes.h | 7 ++-----
>  kernel/kprobes.c        | 4 ++--
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index ab1da3142b06..64672bace560 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -139,7 +139,7 @@ static inline bool kprobe_ftrace(struct kprobe *p)
>   *
>   */
>  struct kretprobe_holder {
> -	struct kretprobe	*rp;
> +	struct kretprobe __rcu *rp;
>  	struct objpool_head	pool;
>  };
>  
> @@ -245,10 +245,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
>  
>  static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
>  {
> -	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> -		"Kretprobe is accessed from instance under preemptive context");
> -
> -	return READ_ONCE(ri->rph->rp);
> +	return rcu_dereference_check(ri->rph->rp, rcu_read_lock_any_held());
>  }
>  
>  static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 075a632e6c7c..d5a0ee40bf66 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2252,7 +2252,7 @@ int register_kretprobe(struct kretprobe *rp)
>  		rp->rph = NULL;
>  		return -ENOMEM;
>  	}
> -	rp->rph->rp = rp;
> +	rcu_assign_pointer(rp->rph->rp, rp);
>  	rp->nmissed = 0;
>  	/* Establish function entry probe point */
>  	ret = register_kprobe(&rp->kp);
> @@ -2300,7 +2300,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>  		rethook_free(rps[i]->rh);
>  #else
> -		rps[i]->rph->rp = NULL;
> +		rcu_assign_pointer(rps[i]->rph->rp, NULL);
>  #endif
>  	}
>  	mutex_unlock(&kprobe_mutex);
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

