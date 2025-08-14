Return-Path: <bpf+bounces-65663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6AB26B3D
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 17:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059F9B61A9F
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6DC239072;
	Thu, 14 Aug 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCBZFBpT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4323315A;
	Thu, 14 Aug 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186028; cv=none; b=TuD7nmISNn1VyNmOD6xjbQboChgG9Pguh52TOqAP6sr3zHZs5+8cnJGAyS8ArjRo+aazHfmsDEd7Tneg7WfZxpjEjowgSVPaslHeIChatkjGrKj5q25Ni+QgHJlj5d5h+1l5uNWK3V4ouXz1T9Tq3I15HWTRDd6V89iTgnnn+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186028; c=relaxed/simple;
	bh=qWHyCh4s5aoDVGv8Zl2K1q4zz4KIrH5OJGfZCM+UBwk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lX2p8mZre3xIMVnbcoZHv0+jdAkEOL6dBKpjuS06kJatTQ5esh9kg2OB02xRya1KMdjFndf7NMbkX0tvRW3dzJQWPUxNORcK25chLmmujk/lRnum7Gz7Lo/W1n1Nl6xf5VvuzOI8IwKAO3QEAMq5tImBIUwURtQ2WFUmS64A2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCBZFBpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639B0C4CEED;
	Thu, 14 Aug 2025 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186027;
	bh=qWHyCh4s5aoDVGv8Zl2K1q4zz4KIrH5OJGfZCM+UBwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCBZFBpTlkbIKb60Kv5cnSgcsZbg0IqC7vDT9qrOzFC1E9OCin8qswRsMM7dXQM/2
	 NIBl62wmVmMPbYh3geoyKACn0sdE9zRv//bZMwbxZAXBv+jSnDIp7GJB2QtaaReyMH
	 PsgRX7VuBtZBwIwWEXKqmtNk9mXWRvNhYsOnYHJZBCyzmmaabi2WAgxqSMw5lKD8gb
	 VfVzXM2Oy+UmrbtTsVaEJsH5aRM9fWTcBx4y2smIlYKdtXFdVh7n/CSPn/+aKQmMky
	 TOGZhOb3eD10JT9h+YKFfkAP9DJpJ85YJazyA3RvKnnotVzwA0B9QihcGCzV8vXUoF
	 gNTF0ULUC/p+Q==
Date: Fri, 15 Aug 2025 00:40:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: olsajiri@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 hca@linux.ibm.com, revest@chromium.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/4] fprobe: use rhltable for
 fprobe_ip_table
Message-Id: <20250815004023.144cfbd9ae39fac9ce80ee98@kernel.org>
In-Reply-To: <20250731092433.49367-2-dongml2@chinatelecom.cn>
References: <20250731092433.49367-1-dongml2@chinatelecom.cn>
	<20250731092433.49367-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 17:24:24 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, all the kernel functions who are hooked by the fprobe will be
> added to the hash table "fprobe_ip_table". The key of it is the function
> address, and the value of it is "struct fprobe_hlist_node".
> 
> The budget of the hash table is FPROBE_IP_TABLE_SIZE, which is 256. And
> this means the overhead of the hash table lookup will grow linearly if
> the count of the functions in the fprobe more than 256. When we try to
> hook all the kernel functions, the overhead will be huge.
> 
> Therefore, replace the hash table with rhltable to reduce the overhead.
> 

Hi Menglong,

Thanks for update, I have just some nitpicks. 

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - some format optimization
> - handle the error that returned from rhltable_insert in
>   insert_fprobe_node
> ---
>  include/linux/fprobe.h |   3 +-
>  kernel/trace/fprobe.c  | 154 +++++++++++++++++++++++------------------
>  2 files changed, 90 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index 702099f08929..f5d8982392b9 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -7,6 +7,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/rcupdate.h>
>  #include <linux/refcount.h>
> +#include <linux/rhashtable.h>

nit: can you also include this header file in fprobe.c ?

>  #include <linux/slab.h>
>  
>  struct fprobe;
> @@ -26,7 +27,7 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
>   * @fp: The fprobe which owns this.
>   */
>  struct fprobe_hlist_node {
> -	struct hlist_node	hlist;
> +	struct rhlist_head	hlist;
>  	unsigned long		addr;
>  	struct fprobe		*fp;
>  };
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index ba7ff14f5339..2f1683a26c10 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -41,47 +41,46 @@
>   *  - RCU hlist traversal under disabling preempt
>   */
>  static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
> -static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
> +static struct rhltable fprobe_ip_table;
>  static DEFINE_MUTEX(fprobe_mutex);
>  
> -/*
> - * Find first fprobe in the hlist. It will be iterated twice in the entry
> - * probe, once for correcting the total required size, the second time is
> - * calling back the user handlers.
> - * Thus the hlist in the fprobe_table must be sorted and new probe needs to
> - * be added *before* the first fprobe.
> - */
> -static struct fprobe_hlist_node *find_first_fprobe_node(unsigned long ip)
> +static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
>  {
> -	struct fprobe_hlist_node *node;
> -	struct hlist_head *head;
> +	return hash_ptr(*(unsigned long **)data, 32);
> +}
>  
> -	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
> -	hlist_for_each_entry_rcu(node, head, hlist,
> -				 lockdep_is_held(&fprobe_mutex)) {
> -		if (node->addr == ip)
> -			return node;
> -	}
> -	return NULL;
> +static int fprobe_node_cmp(struct rhashtable_compare_arg *arg,
> +			   const void *ptr)
> +{
> +	unsigned long key = *(unsigned long *)arg->key;
> +	const struct fprobe_hlist_node *n = ptr;
> +
> +	return n->addr != key;
>  }
> -NOKPROBE_SYMBOL(find_first_fprobe_node);
>  
> -/* Node insertion and deletion requires the fprobe_mutex */
> -static void insert_fprobe_node(struct fprobe_hlist_node *node)
> +static u32 fprobe_node_obj_hashfn(const void *data, u32 len, u32 seed)
>  {
> -	unsigned long ip = node->addr;
> -	struct fprobe_hlist_node *next;
> -	struct hlist_head *head;
> +	const struct fprobe_hlist_node *n = data;
> +
> +	return hash_ptr((void *)n->addr, 32);
> +}
> +
> +static const struct rhashtable_params fprobe_rht_params = {
> +	.head_offset		= offsetof(struct fprobe_hlist_node, hlist),
> +	.key_offset		= offsetof(struct fprobe_hlist_node, addr),
> +	.key_len		= sizeof_field(struct fprobe_hlist_node, addr),
> +	.hashfn			= fprobe_node_hashfn,
> +	.obj_hashfn		= fprobe_node_obj_hashfn,
> +	.obj_cmpfn		= fprobe_node_cmp,
> +	.automatic_shrinking	= true,
> +};
>  
> +/* Node insertion and deletion requires the fprobe_mutex */
> +static int insert_fprobe_node(struct fprobe_hlist_node *node)
> +{
>  	lockdep_assert_held(&fprobe_mutex);
>  
> -	next = find_first_fprobe_node(ip);
> -	if (next) {
> -		hlist_add_before_rcu(&node->hlist, &next->hlist);
> -		return;
> -	}
> -	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
> -	hlist_add_head_rcu(&node->hlist, head);
> +	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
>  }
>  
>  /* Return true if there are synonims */
> @@ -92,9 +91,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
>  	/* Avoid double deleting */
>  	if (READ_ONCE(node->fp) != NULL) {
>  		WRITE_ONCE(node->fp, NULL);
> -		hlist_del_rcu(&node->hlist);
> +		rhltable_remove(&fprobe_ip_table, &node->hlist,
> +				fprobe_rht_params);
>  	}
> -	return !!find_first_fprobe_node(node->addr);
> +	return !!rhltable_lookup(&fprobe_ip_table, &node->addr,
> +				 fprobe_rht_params);
>  }
>  
>  /* Check existence of the fprobe */
> @@ -249,9 +250,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  			struct ftrace_regs *fregs)
>  {
> -	struct fprobe_hlist_node *node, *first;
>  	unsigned long *fgraph_data = NULL;
>  	unsigned long func = trace->func;
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
>  	unsigned long ret_ip;
>  	int reserved_words;
>  	struct fprobe *fp;
> @@ -260,14 +262,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	if (WARN_ON_ONCE(!fregs))
>  		return 0;
>  
> -	first = node = find_first_fprobe_node(func);
> -	if (unlikely(!first))
> -		return 0;
> -
> +	rcu_read_lock();
> +	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>  	reserved_words = 0;
> -	hlist_for_each_entry_from_rcu(node, hlist) {
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  		if (node->addr != func)
> -			break;
> +			continue;
>  		fp = READ_ONCE(node->fp);
>  		if (!fp || !fp->exit_handler)
>  			continue;
> @@ -278,17 +278,19 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  		reserved_words +=
>  			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
>  	}
> -	node = first;
> +	rcu_read_unlock();
>  	if (reserved_words) {
>  		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
>  		if (unlikely(!fgraph_data)) {
> -			hlist_for_each_entry_from_rcu(node, hlist) {
> +			rcu_read_lock();
> +			rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  				if (node->addr != func)
> -					break;
> +					continue;
>  				fp = READ_ONCE(node->fp);
>  				if (fp && !fprobe_disabled(fp))
>  					fp->nmissed++;
>  			}
> +			rcu_read_unlock();
>  			return 0;
>  		}
>  	}
> @@ -299,12 +301,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	 */
>  	ret_ip = ftrace_regs_get_return_address(fregs);
>  	used = 0;
> -	hlist_for_each_entry_from_rcu(node, hlist) {
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  		int data_size;
>  		void *data;
>  
>  		if (node->addr != func)
> -			break;
> +			continue;
>  		fp = READ_ONCE(node->fp);
>  		if (!fp || fprobe_disabled(fp))
>  			continue;
> @@ -448,25 +450,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
>  	return 0;
>  }
>  
> -static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *head,
> -					struct fprobe_addr_list *alist)
> +static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
> +					 struct fprobe_addr_list *alist)
>  {
> -	struct fprobe_hlist_node *node;
>  	int ret = 0;
>  
> -	hlist_for_each_entry_rcu(node, head, hlist,
> -				 lockdep_is_held(&fprobe_mutex)) {
> -		if (!within_module(node->addr, mod))
> -			continue;
> -		if (delete_fprobe_node(node))
> -			continue;
> -		/*
> -		 * If failed to update alist, just continue to update hlist.
> -		 * Therefore, at list user handler will not hit anymore.
> -		 */
> -		if (!ret)
> -			ret = fprobe_addr_list_add(alist, node->addr);
> -	}
> +	if (!within_module(node->addr, mod))
> +		return;
> +	if (delete_fprobe_node(node))
> +		return;
> +	/*
> +	 * If failed to update alist, just continue to update hlist.
> +	 * Therefore, at list user handler will not hit anymore.
> +	 */
> +	if (!ret)
> +		ret = fprobe_addr_list_add(alist, node->addr);
>  }
>  
>  /* Handle module unloading to manage fprobe_ip_table. */
> @@ -474,8 +472,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  				  unsigned long val, void *data)
>  {
>  	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
> +	struct fprobe_hlist_node *node;
> +	struct rhashtable_iter iter;
>  	struct module *mod = data;
> -	int i;
>  
>  	if (val != MODULE_STATE_GOING)
>  		return NOTIFY_DONE;
> @@ -486,8 +485,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  		return NOTIFY_DONE;
>  
>  	mutex_lock(&fprobe_mutex);
> -	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
> -		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
> +	rhashtable_walk_enter(&fprobe_ip_table.ht, &iter);

nit: Use rhltable_walk_enter() instead.

Others looks good to me.

Thank you,

> +	do {
> +		rhashtable_walk_start(&iter);
> +
> +		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> +			fprobe_remove_node_in_module(mod, node, &alist);
> +
> +		rhashtable_walk_stop(&iter);
> +	} while (node == ERR_PTR(-EAGAIN));
> +	rhashtable_walk_exit(&iter);
>  
>  	if (alist.index < alist.size && alist.index > 0)
>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> @@ -722,8 +729,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
>  	ret = fprobe_graph_add_ips(addrs, num);
>  	if (!ret) {
>  		add_fprobe_hash(fp);
> -		for (i = 0; i < hlist_array->size; i++)
> -			insert_fprobe_node(&hlist_array->array[i]);
> +		for (i = 0; i < hlist_array->size; i++) {
> +			ret = insert_fprobe_node(&hlist_array->array[i]);
> +			if (ret)
> +				break;
> +		}
> +		/* fallback on insert error */
> +		if (ret) {
> +			for (i--; i >= 0; i--)
> +				delete_fprobe_node(&hlist_array->array[i]);
> +		}
>  	}
>  	mutex_unlock(&fprobe_mutex);
>  
> @@ -819,3 +834,10 @@ int unregister_fprobe(struct fprobe *fp)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(unregister_fprobe);
> +
> +static int __init fprobe_initcall(void)
> +{
> +	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> +	return 0;
> +}
> +late_initcall(fprobe_initcall);
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

