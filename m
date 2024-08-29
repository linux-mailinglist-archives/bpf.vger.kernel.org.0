Return-Path: <bpf+bounces-38492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0974596534B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FA72837CB
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F461B8EBD;
	Thu, 29 Aug 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTV8r4s8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4721156F41;
	Thu, 29 Aug 2024 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973010; cv=none; b=VpYPM4RElDO/xCcuoEDFaWRJqypAGHVHY8z+VvXBhGOvIoUDOAZLbtNTn/Iq0RW6wr5JIWL/63lfZ9K1HH77gN37ntn/5PW5O3iuVZNXnWJfsn0DXzOMMxMoLJwrQtVLLw4LPMkiV1hMybBCsl32CS2cEjvxqw1b5MwxLLWlR/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973010; c=relaxed/simple;
	bh=fgwTAYAIae5fjo3su91MNKFPTLLf9w4QSVaZYm8uCHw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Emz3AxMwixiCYn46IE6waT+i5q24kNPmTndVQqh5ROvLLMhFJLDlGac0bSwalL+SP67tf5pyWeuR7a2YU+IHpyffYPF8SiG/hRzIVwofidpsXNdrSLF1dIjdFz92037YFE/VHeMnCBXPVwgGanjOyHNs8hVQtSMDNOG555raZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTV8r4s8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334879ba28so1612196e87.3;
        Thu, 29 Aug 2024 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724973007; x=1725577807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRlsZ+3H5fYdYp9L3nxbm/aJCbmtautxoF+qQQN3vuU=;
        b=cTV8r4s8u8YVo+4pP6fk/QFm/Md8wC1sPvxZ7ICH0gpvHp29ILhOHmNAircS0t5ePh
         vz5smoP+aILD7bpZT12Q0A3eTq6gUdDpr1ZPmY9ap0fI+sns8d2ixgvSl+moA6OfM27K
         RODsMNHDIElRuT8YN+hIj6+SXPxcv4HmvG8Je8YWjlmEbqOvmL7+I4XGTVAVRTOY+oqi
         klDXPBie6ITtsqXFfpVPtp/9NbUMswEGwW2WH8vd4aKZOhqOB8MbgSY3QxRtYdK3fZ4i
         P0e//NENHbEvVH1iMgTWF3yErtMrGjhoh8bAPOZwXuNwpu102cL2y1YwKRqKR7241TPO
         mRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724973007; x=1725577807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRlsZ+3H5fYdYp9L3nxbm/aJCbmtautxoF+qQQN3vuU=;
        b=LWwy7LJ7xJZiHzZapJefVPhtY3YFej0IUr6eOEz6M+1b5zGcUjVL4/RyX4R1yY2t14
         vyX1XDIpjn63VK5Iz8NkLal9Rplo4ktnUC9ARRfoe2aBMQOqa2JVIoTefOCS1WDO6tLt
         av5fbnp94kMdYQsh7xeq20sLv3+OGfuY6xImqJlbcBqhWJaQhdqFbY78Too2i5RGlfzW
         gzoar5iI0fVyEGpdOgC+mNKoR7ksGJWGymQHkIKckQHQV0ru1tln/4ZfbLbhhA5ycuMc
         oaCTjRtJ8SItmZJq3Hp5MZvp16drPOriLEudBBkCotEbYKDbkbiZLugWy9DKIFhkk6IB
         gNag==
X-Forwarded-Encrypted: i=1; AJvYcCXaBIxQY+mE2IfQNdzQTPobliI7+78/3xzi5tRg0/WTpBssDJ1+PCDywir+2ZfKzHW9tUo=@vger.kernel.org, AJvYcCXtNenrhVJ0ijNCw77DiimhTtWs9ATbhsO22tSVN7AX9jIwjdQ/WvWRt2JAQZZPOddhOCMn5SzqnrBzBGF9@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMtyiHfKZkW90YfG0eBTenQOz+tDauiIXiD1jVOEVOTuhag8I
	SLKJf6aygj6R8bi6v7siAMaigKI3WQNmMbagYepIBlgii1KMMiEF
X-Google-Smtp-Source: AGHT+IGiK68KeCI51IGjOWFrUsz8CF4G0YKtUFVxpFkhV4qOK3nx4YQ9l73a9k2ptKkm5Re9KMmESA==
X-Received: by 2002:a05:6512:2387:b0:530:c1fc:1c32 with SMTP id 2adb3069b0e04-53546b8e196mr90507e87.45.1724973006428;
        Thu, 29 Aug 2024 16:10:06 -0700 (PDT)
Received: from krava (brn-rj-tbond02.sa.cz. [185.94.55.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fefc12sm135358866b.9.2024.08.29.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:10:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Aug 2024 01:09:59 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <ZtD_x9zxLjyhS37Z@krava>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829183741.3331213-5-andrii@kernel.org>

On Thu, Aug 29, 2024 at 11:37:37AM -0700, Andrii Nakryiko wrote:
> uprobe->register_rwsem is one of a few big bottlenecks to scalability of
> uprobes, so we need to get rid of it to improve uprobe performance and
> multi-CPU scalability.
> 
> First, we turn uprobe's consumer list to a typical doubly-linked list
> and utilize existing RCU-aware helpers for traversing such lists, as
> well as adding and removing elements from it.
> 
> For entry uprobes we already have SRCU protection active since before
> uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> won't go away from under us, but we add SRCU protection around consumer
> list traversal.
> 
> Lastly, to keep handler_chain()'s UPROBE_HANDLER_REMOVE handling simple,
> we remember whether any removal was requested during handler calls, but
> then we double-check the decision under a proper register_rwsem using
> consumers' filter callbacks. Handler removal is very rare, so this extra
> lock won't hurt performance, overall, but we also avoid the need for any
> extra protection (e.g., seqcount locks).
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h |   2 +-
>  kernel/events/uprobes.c | 104 +++++++++++++++++++++++-----------------
>  2 files changed, 62 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 9cf0dce62e4c..29c935b0d504 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -35,7 +35,7 @@ struct uprobe_consumer {
>  				struct pt_regs *regs);
>  	bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
>  
> -	struct uprobe_consumer *next;
> +	struct list_head cons_node;
>  };
>  
>  #ifdef CONFIG_UPROBES
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8bdcdc6901b2..97e58d160647 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -59,7 +59,7 @@ struct uprobe {
>  	struct rw_semaphore	register_rwsem;
>  	struct rw_semaphore	consumer_rwsem;
>  	struct list_head	pending_list;
> -	struct uprobe_consumer	*consumers;
> +	struct list_head	consumers;
>  	struct inode		*inode;		/* Also hold a ref to inode */
>  	struct rcu_head		rcu;
>  	loff_t			offset;
> @@ -783,6 +783,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>  	uprobe->inode = inode;
>  	uprobe->offset = offset;
>  	uprobe->ref_ctr_offset = ref_ctr_offset;
> +	INIT_LIST_HEAD(&uprobe->consumers);
>  	init_rwsem(&uprobe->register_rwsem);
>  	init_rwsem(&uprobe->consumer_rwsem);
>  	RB_CLEAR_NODE(&uprobe->rb_node);
> @@ -808,32 +809,19 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>  	down_write(&uprobe->consumer_rwsem);
> -	uc->next = uprobe->consumers;
> -	uprobe->consumers = uc;
> +	list_add_rcu(&uc->cons_node, &uprobe->consumers);
>  	up_write(&uprobe->consumer_rwsem);
>  }
>  
>  /*
>   * For uprobe @uprobe, delete the consumer @uc.
> - * Return true if the @uc is deleted successfully
> - * or return false.
> + * Should never be called with consumer that's not part of @uprobe->consumers.
>   */
> -static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
> -	struct uprobe_consumer **con;
> -	bool ret = false;
> -
>  	down_write(&uprobe->consumer_rwsem);
> -	for (con = &uprobe->consumers; *con; con = &(*con)->next) {
> -		if (*con == uc) {
> -			*con = uc->next;
> -			ret = true;
> -			break;
> -		}
> -	}
> +	list_del_rcu(&uc->cons_node);
>  	up_write(&uprobe->consumer_rwsem);
> -
> -	return ret;
>  }
>  
>  static int __copy_insn(struct address_space *mapping, struct file *filp,
> @@ -929,7 +917,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
>  	bool ret = false;
>  
>  	down_read(&uprobe->consumer_rwsem);
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
>  		ret = consumer_filter(uc, mm);
>  		if (ret)
>  			break;
> @@ -1125,18 +1114,29 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  	int err;
>  
>  	down_write(&uprobe->register_rwsem);
> -	if (WARN_ON(!consumer_del(uprobe, uc))) {
> -		err = -ENOENT;
> -	} else {
> -		err = register_for_each_vma(uprobe, NULL);
> -		/* TODO : cant unregister? schedule a worker thread */
> -		if (unlikely(err))
> -			uprobe_warn(current, "unregister, leaking uprobe");
> -	}
> +	consumer_del(uprobe, uc);
> +	err = register_for_each_vma(uprobe, NULL);
>  	up_write(&uprobe->register_rwsem);
>  
> -	if (!err)
> -		put_uprobe(uprobe);
> +	/* TODO : cant unregister? schedule a worker thread */
> +	if (unlikely(err)) {
> +		uprobe_warn(current, "unregister, leaking uprobe");
> +		goto out_sync;
> +	}
> +
> +	put_uprobe(uprobe);
> +
> +out_sync:
> +	/*
> +	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
> +	 * uprobe->consumers list under RCU protection without holding
> +	 * uprobe->register_rwsem, we need to wait for RCU grace period to
> +	 * make sure that we can't call into just unregistered
> +	 * uprobe_consumer's callbacks anymore. If we don't do that, fast and
> +	 * unlucky enough caller can free consumer's memory and cause
> +	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
> +	 */
> +	synchronize_srcu(&uprobes_srcu);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>  
> @@ -1214,13 +1214,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
>  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
>  {
>  	struct uprobe_consumer *con;
> -	int ret = -ENOENT;
> +	int ret = -ENOENT, srcu_idx;
>  
>  	down_write(&uprobe->register_rwsem);
> -	for (con = uprobe->consumers; con && con != uc ; con = con->next)
> -		;
> -	if (con)
> -		ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
> +		if (con == uc) {
> +			ret = register_for_each_vma(uprobe, add ? uc : NULL);
> +			break;
> +		}
> +	}
> +	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> +
>  	up_write(&uprobe->register_rwsem);
>  
>  	return ret;
> @@ -2085,10 +2092,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  	struct uprobe_consumer *uc;
>  	int remove = UPROBE_HANDLER_REMOVE;
>  	bool need_prep = false; /* prepare return uprobe, when needed */
> +	bool has_consumers = false;
>  
> -	down_read(&uprobe->register_rwsem);
>  	current->utask->auprobe = &uprobe->arch;
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +
> +	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
>  		int rc = 0;
>  
>  		if (uc->handler) {
> @@ -2101,17 +2110,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  			need_prep = true;
>  
>  		remove &= rc;
> +		has_consumers = true;
>  	}
>  	current->utask->auprobe = NULL;
>  
>  	if (need_prep && !remove)
>  		prepare_uretprobe(uprobe, regs); /* put bp at return */
>  
> -	if (remove && uprobe->consumers) {
> -		WARN_ON(!uprobe_is_active(uprobe));
> -		unapply_uprobe(uprobe, current->mm);
> +	if (remove && has_consumers) {
> +		down_read(&uprobe->register_rwsem);
> +
> +		/* re-check that removal is still required, this time under lock */
> +		if (!filter_chain(uprobe, current->mm)) {

sorry for late question, but I do not follow this change.. 

at this point we got 1 as handler's return value from all the uprobe's consumers,
why do we need to call filter_chain in here.. IIUC this will likely skip over
the removal?

with single uprobe_multi consumer:

  handler_chain
    uprobe_multi_link_handler
      uprobe_prog_run
        bpf_prog returns 1

    remove = 1

    if (remove && has_consumers) {

      filter_chain - uprobe_multi_link_filter returns true.. so the uprobe stays?

maybe I just need to write test for it ;-)

thanks,
jirka


> +			WARN_ON(!uprobe_is_active(uprobe));
> +			unapply_uprobe(uprobe, current->mm);
> +		}
> +
> +		up_read(&uprobe->register_rwsem);
>  	}
> -	up_read(&uprobe->register_rwsem);
>  }
>  
>  static void
> @@ -2119,13 +2135,15 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe = ri->uprobe;
>  	struct uprobe_consumer *uc;
> +	int srcu_idx;
>  
> -	down_read(&uprobe->register_rwsem);
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> +				 srcu_read_lock_held(&uprobes_srcu)) {
>  		if (uc->ret_handler)
>  			uc->ret_handler(uc, ri->func, regs);
>  	}
> -	up_read(&uprobe->register_rwsem);
> +	srcu_read_unlock(&uprobes_srcu, srcu_idx);
>  }
>  
>  static struct return_instance *find_next_ret_chain(struct return_instance *ri)
> -- 
> 2.43.5
> 

