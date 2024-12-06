Return-Path: <bpf+bounces-46272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D899E6FCE
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5FC169B2D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255820764A;
	Fri,  6 Dec 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrR8dMCx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5722E859;
	Fri,  6 Dec 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494027; cv=none; b=czkriDslhnhIbzNoXZbeSxkyQdP1Ns8fucQymIjfaj7BDgquVfFfmRzTbP7XFkZf2lK43I62ceMJx6nVoE2UsIUsj8SS6ZG5D6vcwsh1Z5EoWl+tZVCnIRpf7d8F4eGYufCEgWxF5aFa8/+0h/F5Rp/8R0PIKkqTDIfyUsjZztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494027; c=relaxed/simple;
	bh=/T9n9l8yPptrZ8rQNOWy7/kjAYWgocwtitvgqsY4m14=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF3bTl90AT4NgEzCkInexhhmCY3cY1n59of68zI+jEVsXmn2P9Mv/1eIdjTJtFz8owItrMOunDSOi9giJZxDnolRl6minzvakabgFFD3fV3E5gstCwu6BFvdQUbiKGjh5wIiiS73ymxvuVLNFdQZtAmJkAW86NkUiKlQp4Wzt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrR8dMCx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a099ba95so21403665e9.0;
        Fri, 06 Dec 2024 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733494024; x=1734098824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1NqJIFUc2rfcnKJ/ZOj3FWC+O+PqLGFEM848kkhk2U=;
        b=HrR8dMCxbbbDqCp9hmhqxW8nNUJQ1Vj5h9fxJgKUkLsxNxBUyjrG/Zg88xVvL5pIxg
         zYLg40yLNCFAbFjkY2a2/zrBMh1ZNa5AsKir6pquHA1TZTNG29xsx8HICIsnw3OhBI3w
         KUt+AuSGo6vldg5HrFaL86MNlMCw+852Tqt87E0WmSZjs6+IMywTTv3fPYiqF3k8G+de
         1nFgPO+5+G8eNT3+cGIcWtGhgCPqrbzW1T0Ou7JNZ4Ad9VZHdmZeMgJKDlAwtDk5SWjn
         kYuZIwVj/hRTd12woCq6Li1EzkIpn1dvAcfG8id/y6iiPIfkLkhgiSp1RZU0BI8q6B9+
         fQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494024; x=1734098824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1NqJIFUc2rfcnKJ/ZOj3FWC+O+PqLGFEM848kkhk2U=;
        b=pAxVFYt/TsPFCHCQdFdE9mVah3wguXXGwdyedv6XKKfSljZy51NZIGZ+J+8HefVBp1
         hnk8NAVlz1VTbAjIhA63tAuc+UwlDCMc7Sg76Vfl4+LaoW5sEGeAvXz+6/rSNkYCkloW
         9rZXuP0W4pdemubPDypFmNP6T1HDOZsJ/WtVSLEoPIFrGknFSpTxoKyXkOy6C6lZ68cq
         J29O/HgO+wCgm30E8rCqN49yp7V0WSqcREJwzCxQHMs22fLJEyfxXALPmoX3HUxEu3kk
         wsNdHCNjBhqC8SsigJ1OyHTutZbyYOOtVLRbftQ1/DvpQcqJjfn9N0XbZ5GBnhpXt5Fw
         vekA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3y4BMNXJhqbfaHuEYBd2d3+BpRkitCgchLvjDT+biQFO46KH0BLZIxerZ1jeWdC2UCRt4yShLK7J2tPK@vger.kernel.org, AJvYcCWZIk3AIjmmBkeaq/Anh40qPbdOH+jkDE37UlyEEH+Tx3sEid8Z/+bevKRlzuqNiMGfdfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsquVVR4aLighHRUhQ1FY6w4xxLOHvAOfY3g9nGEBXXGzVOP1
	BlDoxCAlQ574bb8ERScE9iixMxoPgbcHwzq31A3988dFBsntf887el9bLw==
X-Gm-Gg: ASbGncv7C1uiI85nOr/Q7VfMp6+Kfrh5192iAkiyj10YZdIxheiMTI7pTKBKTAGV+Zk
	lyY8LQ5ajmySqKbtuhoKrR1MbFQV2uMcH7TwDtUc8xBuzAhrsOX0WxCGard4slzblJDGtTx5HvU
	fJvg2IWY3VhtmMwHTvXXQD9ZdJkIPkrbck/IP9SDK15+K9HWhj3W5LGk1WEFKaIFNarthl/i8ZG
	J8NBWS+D23/fKpckU10Go7f9NV6ikcz4cVNqaqlD6VW98Fqf3iEdpfR7nHQNWYUnSWJjftSrSVM
	QUw8OxwtRqKskUoI6ZKb3z0=
X-Google-Smtp-Source: AGHT+IGw4IMPWXq1GrzcXg2SDSvRxwj1VocovuEZuiK4iMC8QvR2HIXwgj55cindn7/QdDi3ipSdew==
X-Received: by 2002:a05:600c:1911:b0:434:a923:9313 with SMTP id 5b1f17b1804b1-434ddecac75mr25534475e9.25.1733494023668;
        Fri, 06 Dec 2024 06:07:03 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cb6e1sm93071595e9.37.2024.12.06.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 06:07:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Dec 2024 15:07:01 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, liaochang1@huawei.com,
	kernel-team@meta.com
Subject: Re: [PATCH perf/core 4/4] uprobes: reuse return_instances between
 multiple uretprobes within task
Message-ID: <Z1MFBVRuUnuYKo8c@krava>
References: <20241206002417.3295533-1-andrii@kernel.org>
 <20241206002417.3295533-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206002417.3295533-5-andrii@kernel.org>

On Thu, Dec 05, 2024 at 04:24:17PM -0800, Andrii Nakryiko wrote:

SNIP

> +static void free_ret_instance(struct uprobe_task *utask,
> +			      struct return_instance *ri, bool cleanup_hprobe)
> +{
> +	unsigned seq;
> +
>  	if (cleanup_hprobe) {
>  		enum hprobe_state hstate;
>  
> @@ -1897,8 +1923,22 @@ static void free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
>  		hprobe_finalize(&ri->hprobe, hstate);
>  	}
>  
> -	kfree(ri->extra_consumers);
> -	kfree_rcu(ri, rcu);
> +	/*
> +	 * At this point return_instance is unlinked from utask's
> +	 * return_instances list and this has become visible to ri_timer().
> +	 * If seqcount now indicates that ri_timer's return instance
> +	 * processing loop isn't active, we can return ri into the pool of
> +	 * to-be-reused return instances for future uretprobes. If ri_timer()
> +	 * happens to be running right now, though, we fallback to safety and
> +	 * just perform RCU-delated freeing of ri.
> +	 */
> +	if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
> +		/* immediate reuse of ri without RCU GP is OK */
> +		ri_pool_push(utask, ri);

should the push be limitted somehow? I wonder you could make uprobes/consumers
setup that would allocate/push many of ri instances that would not be freed
until the process exits?

jirka

> +	} else {
> +		/* we might be racing with ri_timer(), so play it safe */
> +		ri_free(ri);
> +	}
>  }
>  
>  /*
> @@ -1920,7 +1960,15 @@ void uprobe_free_utask(struct task_struct *t)
>  	ri = utask->return_instances;
>  	while (ri) {
>  		ri_next = ri->next;
> -		free_ret_instance(ri, true /* cleanup_hprobe */);
> +		free_ret_instance(utask, ri, true /* cleanup_hprobe */);
> +		ri = ri_next;
> +	}
> +
> +	/* free_ret_instance() above might add to ri_pool, so this loop should come last */
> +	ri = utask->ri_pool;
> +	while (ri) {
> +		ri_next = ri->next;
> +		ri_free(ri);
>  		ri = ri_next;
>  	}
>  
> @@ -1943,8 +1991,12 @@ static void ri_timer(struct timer_list *timer)
>  	/* RCU protects return_instance from freeing. */
>  	guard(rcu)();
>  
> +	write_seqcount_begin(&utask->ri_seqcount);
> +
>  	for_each_ret_instance_rcu(ri, utask->return_instances)
>  		hprobe_expire(&ri->hprobe, false);
> +
> +	write_seqcount_end(&utask->ri_seqcount);
>  }
>  
>  static struct uprobe_task *alloc_utask(void)
> @@ -1956,6 +2008,7 @@ static struct uprobe_task *alloc_utask(void)
>  		return NULL;
>  
>  	timer_setup(&utask->ri_timer, ri_timer, 0);
> +	seqcount_init(&utask->ri_seqcount);
>  
>  	return utask;
>  }
> @@ -1975,10 +2028,14 @@ static struct uprobe_task *get_utask(void)
>  	return current->utask;
>  }
>  
> -static struct return_instance *alloc_return_instance(void)
> +static struct return_instance *alloc_return_instance(struct uprobe_task *utask)
>  {
>  	struct return_instance *ri;
>  
> +	ri = ri_pool_pop(utask);
> +	if (ri)
> +		return ri;
> +
>  	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>  	if (!ri)
>  		return ZERO_SIZE_PTR;
> @@ -2119,7 +2176,7 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
>  		rcu_assign_pointer(utask->return_instances, ri_next);
>  		utask->depth--;
>  
> -		free_ret_instance(ri, true /* cleanup_hprobe */);
> +		free_ret_instance(utask, ri, true /* cleanup_hprobe */);
>  		ri = ri_next;
>  	}
>  }
> @@ -2186,7 +2243,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
>  
>  	return;
>  free:
> -	kfree(ri);
> +	ri_free(ri);
>  }
>  
>  /* Prepare to single-step probed instruction out of line. */
> @@ -2385,8 +2442,7 @@ static struct return_instance *push_consumer(struct return_instance *ri, __u64 i
>  	if (unlikely(ri->cons_cnt > 0)) {
>  		ric = krealloc(ri->extra_consumers, sizeof(*ric) * ri->cons_cnt, GFP_KERNEL);
>  		if (!ric) {
> -			kfree(ri->extra_consumers);
> -			kfree_rcu(ri, rcu);
> +			ri_free(ri);
>  			return ZERO_SIZE_PTR;
>  		}
>  		ri->extra_consumers = ric;
> @@ -2428,8 +2484,9 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  	struct uprobe_consumer *uc;
>  	bool has_consumers = false, remove = true;
>  	struct return_instance *ri = NULL;
> +	struct uprobe_task *utask = current->utask;
>  
> -	current->utask->auprobe = &uprobe->arch;
> +	utask->auprobe = &uprobe->arch;
>  
>  	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
>  		bool session = uc->handler && uc->ret_handler;
> @@ -2449,12 +2506,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  			continue;
>  
>  		if (!ri)
> -			ri = alloc_return_instance();
> +			ri = alloc_return_instance(utask);
>  
>  		if (session)
>  			ri = push_consumer(ri, uc->id, cookie);
>  	}
> -	current->utask->auprobe = NULL;
> +	utask->auprobe = NULL;
>  
>  	if (!ZERO_OR_NULL_PTR(ri))
>  		prepare_uretprobe(uprobe, regs, ri);
> @@ -2554,7 +2611,7 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
>  			hprobe_finalize(&ri->hprobe, hstate);
>  
>  			/* We already took care of hprobe, no need to waste more time on that. */
> -			free_ret_instance(ri, false /* !cleanup_hprobe */);
> +			free_ret_instance(utask, ri, false /* !cleanup_hprobe */);
>  			ri = ri_next;
>  		} while (ri != next_chain);
>  	} while (!valid);
> -- 
> 2.43.5
> 

