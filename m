Return-Path: <bpf+bounces-16331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C06A7FFDC4
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 22:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C44B2111F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49B5A10E;
	Thu, 30 Nov 2023 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j64Vc1mr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24E10D9;
	Thu, 30 Nov 2023 13:44:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc985c92dso13637665ad.0;
        Thu, 30 Nov 2023 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701380699; x=1701985499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8FS6Qd0IZN+Dl33FIv740MIgRTs5bvaTZEj8QOFaik=;
        b=j64Vc1mrsKNt0fRCnOYjwJL1NrJhmpp/onZhAUNx8mSmMZo87xRdsp8X32bGQBuEyk
         Atrd8lcNEVnEXNNGko/V8ZrJZNrPVue+pGQgHjikXya9A6ZakFPGDzCdA0TKEvnl9wfc
         7JrqPEeLGC/jeCu2DjL7nEGJj+c0BFSRPbPhuEUtDlyw9onfdhssMguf2rfRqrjXeYSu
         AZ4yo+uy84tk9P2Ah6K3AMIjO3A0RZzjRwSSx26QCazUsQtj+5uWCkY28LubDGj63Q7Q
         dv8HlFH9dfQsxRMXoXHjvotx8frHriXStx0Zhfv37hNk/jQEYn4HV0YxrY3rLj97yUnv
         bTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380699; x=1701985499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8FS6Qd0IZN+Dl33FIv740MIgRTs5bvaTZEj8QOFaik=;
        b=m3BouU8S5e2gfJIE9xG/SfTNxF7c+0GPSIMLTWBULVqCfx92/138hxHwOUW6ef2b8l
         CoeVCOWLPuRxLWHZ2nOkR1ad65309R6lK4iXOFw3oJ0ZtbjexKmS421lt0bfDJu7gOqZ
         03HbE0HFX6L1rIcueU1DHMmZix4UEUxSnvEkj9//cJHRtT5EU/TuEmWCgDwW8rKNbPz9
         OTsmCKHuE6hBL0AHolSFBqtTM0AFB5HMkfRUC54Ee1+Iq9nTRgTpC0K0TI/7agfFlkQW
         T4tPLrJcEwkYQ7KdQItMdxWcQ+obku92HmzdHbbEiqPJp8hYNRdynHHb65jEqKPPxrBF
         a/IA==
X-Gm-Message-State: AOJu0YyhrnIrFdx7fsSsnrKDqQFVcYqU43lgjNorFURQwAX+KyHvJTmq
	gGkvF9ovgCiLu/I8PQU+Qlw=
X-Google-Smtp-Source: AGHT+IFsN8egBzuuF5TGzDI9KEu/DFQqXoaBeG6pJoYadt8ZQn7j8+n5w3/qYyPceygABiu9P+djvA==
X-Received: by 2002:a17:90b:3906:b0:286:1e60:69a4 with SMTP id ob6-20020a17090b390600b002861e6069a4mr5341591pjb.24.1701380698735;
        Thu, 30 Nov 2023 13:44:58 -0800 (PST)
Received: from localhost.localdomain ([2601:648:8900:1ba9:692:26ff:fed8:afdd])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001cfe19e2508sm1865321plx.274.2023.11.30.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:44:58 -0800 (PST)
Date: Thu, 30 Nov 2023 13:44:55 -0800
From: JP Kobryn <inwardvessel@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	peterz@infradead.org
Subject: Re: [PATCH v2] rethook: Use __rcu pointer for rethook::handler
Message-ID: <ZWkCV_D8Yw-cFsXE@localhost.localdomain>
References: <170126066201.398836.837498688669005979.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170126066201.398836.837498688669005979.stgit@devnote2>

On Wed, Nov 29, 2023 at 09:24:22PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the rethook::handler is an RCU-maganged pointer so that it will
> notice readers the rethook is stopped (unregistered) or not, it should
> be an __rcu pointer and use appropriate functions to be accessed. This
> will use appropriate memory barrier when accessing it. OTOH,
> rethook::data is never changed, so we don't need to check it in
> get_kretprobe().
> 
> NOTE: To avoid sparse warning, rethook::handler is defined by a raw
> function pointer type with __rcu instead of rethook_handler_t.
> 
> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311241808.rv9ceuAh-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/kprobes.h |    6 ++----
>  include/linux/rethook.h |    7 ++++++-
>  kernel/trace/rethook.c  |   23 ++++++++++++++---------
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 64672bace560..0ff44d6633e3 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -197,10 +197,8 @@ extern int arch_trampoline_kprobe(struct kprobe *p);
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>  static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
>  {
> -	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> -		"Kretprobe is accessed from instance under preemptive context");
> -
> -	return (struct kretprobe *)READ_ONCE(ri->node.rethook->data);
> +	/* rethook::data is non-changed field, so that you can access it freely. */
> +	return (struct kretprobe *)ri->node.rethook->data;
>  }
>  static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
>  {
> diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> index ce69b2b7bc35..ba60962805f6 100644
> --- a/include/linux/rethook.h
> +++ b/include/linux/rethook.h
> @@ -28,7 +28,12 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long,
>   */
>  struct rethook {
>  	void			*data;
> -	rethook_handler_t	handler;
> +	/*
> +	 * To avoid sparse warnings, this uses a raw function pointer with
> +	 * __rcu, instead of rethook_handler_t. But this must be same as
> +	 * rethook_handler_t.
> +	 */
> +	void (__rcu *handler) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
>  	struct objpool_head	pool;
>  	struct rcu_head		rcu;
>  };
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 6fd7d4ecbbc6..fa03094e9e69 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -48,7 +48,7 @@ static void rethook_free_rcu(struct rcu_head *head)
>   */
>  void rethook_stop(struct rethook *rh)
>  {
> -	WRITE_ONCE(rh->handler, NULL);
> +	rcu_assign_pointer(rh->handler, NULL);
>  }
>  
>  /**
> @@ -63,7 +63,7 @@ void rethook_stop(struct rethook *rh)
>   */
>  void rethook_free(struct rethook *rh)
>  {
> -	WRITE_ONCE(rh->handler, NULL);
> +	rethook_stop(rh);
>  
>  	call_rcu(&rh->rcu, rethook_free_rcu);
>  }
> @@ -82,6 +82,12 @@ static int rethook_fini_pool(struct objpool_head *head, void *context)
>  	return 0;
>  }
>  
> +static inline rethook_handler_t rethook_get_handler(struct rethook *rh)
> +{
> +	return (rethook_handler_t)rcu_dereference_check(rh->handler,
> +							rcu_read_lock_any_held());
> +}
> +
>  /**
>   * rethook_alloc() - Allocate struct rethook.
>   * @data: a data to pass the @handler when hooking the return.
> @@ -107,7 +113,7 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
>  		return ERR_PTR(-ENOMEM);
>  
>  	rh->data = data;
> -	rh->handler = handler;
> +	rcu_assign_pointer(rh->handler, handler);
>  
>  	/* initialize the objpool for rethook nodes */
>  	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
> @@ -135,9 +141,10 @@ static void free_rethook_node_rcu(struct rcu_head *head)
>   */
>  void rethook_recycle(struct rethook_node *node)
>  {
> -	lockdep_assert_preemption_disabled();
> +	rethook_handler_t handler;
>  
> -	if (likely(READ_ONCE(node->rethook->handler)))
> +	handler = rethook_get_handler(node->rethook);
> +	if (likely(handler))
>  		objpool_push(node, &node->rethook->pool);
>  	else
>  		call_rcu(&node->rcu, free_rethook_node_rcu);
> @@ -153,9 +160,7 @@ NOKPROBE_SYMBOL(rethook_recycle);
>   */
>  struct rethook_node *rethook_try_get(struct rethook *rh)
>  {
> -	rethook_handler_t handler = READ_ONCE(rh->handler);
> -
> -	lockdep_assert_preemption_disabled();
> +	rethook_handler_t handler = rethook_get_handler(rh);
>  
>  	/* Check whether @rh is going to be freed. */
>  	if (unlikely(!handler))
> @@ -300,7 +305,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
>  		rhn = container_of(first, struct rethook_node, llist);
>  		if (WARN_ON_ONCE(rhn->frame != frame))
>  			break;
> -		handler = READ_ONCE(rhn->rethook->handler);
> +		handler = rethook_get_handler(rhn->rethook);
>  		if (handler)
>  			handler(rhn, rhn->rethook->data,
>  				correct_ret_addr, regs);
> 

I applied and tested this patch locally on an x86_64 machine and can
confirm there are no RCU-related sparse warnings. Also, kprobe tests
within the ftrace selftest suite succeed just the same as before
applying the patch.

Tested-by: JP Kobryn <inwardvessel@gmail.com>

