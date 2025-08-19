Return-Path: <bpf+bounces-65957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33980B2B6B5
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 04:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEDA3ACD29
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AA286D64;
	Tue, 19 Aug 2025 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frs/NxNN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C252F852;
	Tue, 19 Aug 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569476; cv=none; b=daeILF3s7e+FYB+YCK8iOkkGj0KDnX6Kaa36d79p+8RTiqmrev6fl5dqN+B37p7BesOAwrPD2umy4DUxnfX4syqqGsFUPC4JliDCpn6K3VOw3HvdY1s7o/k2LO22q9tXCrwBm75TR/Q3VfPYX+gNxBKu02HHDd0zUcvDaNFlUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569476; c=relaxed/simple;
	bh=lt435QE/FFmHEwI82/HenA85O+4hQRrgiYwR7cJaXjc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Eu83lEh49vDLoy1sYMwg2WyTrwZeQqoYa1rX25vkbydcUw0pWtLGs/tiTgTXEJ+XyIuthdiaj+10VvgdWf2saRNPi0mUZij57WAx1sVFl3Qn1elX3UTu6dBl8LP+AqRkT5po45Z8ntUQxWfY4SZxW3KRGlMKpgtq7ScGQrM8/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frs/NxNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624A7C4CEEB;
	Tue, 19 Aug 2025 02:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755569474;
	bh=lt435QE/FFmHEwI82/HenA85O+4hQRrgiYwR7cJaXjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=frs/NxNNh+9SqAyvlUDxM95mjp6PLBbjYjZbwvNJJZ1VJVDNhUts3ySWN+y2bMGQn
	 dk7KAIPfYbnV1qpUghAKm1kSbFm2TOXzIDOVLsarI4yBxaDXVNIMCHLVaUmkSwosOX
	 DgQsmFUBQJ/Eln3rpzEwSZ8dMcDcHjKOFOKjeBcVexqjANYUooFtj8Vg7ddX329xYX
	 +tZCiiubrToQlMVW0vvIA3zClAyiD/Eb13mS14wxTY0yuF/a8pEbpCiHZ/kOAyD5P5
	 5oMjCLEHdCOuq+APJLIMwI/EFBta/EKGz/iGVo2VnYG5OyDxV7irh+wANx7JrvAPqT
	 ohVFnFYhyYzOQ==
Date: Tue, 19 Aug 2025 11:11:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, mhiramat@kernel.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, hca@linux.ibm.com,
 revest@chromium.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/4] fprobe: use rhltable for
 fprobe_ip_table
Message-Id: <20250819111111.40f443fd7faae8e92f93beaf@kernel.org>
In-Reply-To: <aKMuENl9omxi6OwJ@krava>
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
	<20250817024607.296117-2-dongml2@chinatelecom.cn>
	<aKMuENl9omxi6OwJ@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 15:43:44 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Sun, Aug 17, 2025 at 10:46:02AM +0800, Menglong Dong wrote:
> 
> SNIP
> 
> > +/* Node insertion and deletion requires the fprobe_mutex */
> > +static int insert_fprobe_node(struct fprobe_hlist_node *node)
> > +{
> >  	lockdep_assert_held(&fprobe_mutex);
> >  
> > -	next = find_first_fprobe_node(ip);
> > -	if (next) {
> > -		hlist_add_before_rcu(&node->hlist, &next->hlist);
> > -		return;
> > -	}
> > -	head = &fprobe_ip_table[hash_ptr((void *)ip, FPROBE_IP_HASH_BITS)];
> > -	hlist_add_head_rcu(&node->hlist, head);
> > +	return rhltable_insert(&fprobe_ip_table, &node->hlist, fprobe_rht_params);
> >  }
> >  
> >  /* Return true if there are synonims */
> > @@ -92,9 +92,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
> >  	/* Avoid double deleting */
> >  	if (READ_ONCE(node->fp) != NULL) {
> >  		WRITE_ONCE(node->fp, NULL);
> > -		hlist_del_rcu(&node->hlist);
> > +		rhltable_remove(&fprobe_ip_table, &node->hlist,
> > +				fprobe_rht_params);
> >  	}
> > -	return !!find_first_fprobe_node(node->addr);
> > +	return !!rhltable_lookup(&fprobe_ip_table, &node->addr,
> > +				 fprobe_rht_params);
> 
> I think rhltable_lookup needs rcu lock

Good catch! Hmm, previously we guaranteed that the find_first_fprobe_node()
must be called under rcu read locked or fprobe_mutex locked, so that the
node list should not be changed. But according to the comment of
rhltable_lookup(), we need to lock the rcu_read_lock() around that.

> 
> >  }
> >  
> >  /* Check existence of the fprobe */
> > @@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
> >  static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >  			struct ftrace_regs *fregs)
> >  {
> > -	struct fprobe_hlist_node *node, *first;
> >  	unsigned long *fgraph_data = NULL;
> >  	unsigned long func = trace->func;
> > +	struct fprobe_hlist_node *node;
> > +	struct rhlist_head *head, *pos;
> >  	unsigned long ret_ip;
> >  	int reserved_words;
> >  	struct fprobe *fp;
> > @@ -260,14 +263,11 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >  	if (WARN_ON_ONCE(!fregs))
> >  		return 0;
> >  
> > -	first = node = find_first_fprobe_node(func);
> > -	if (unlikely(!first))
> > -		return 0;
> > -
> > +	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> 
> ditto

So this was pointed in the previous thread. In fprobe_entry(), the
preempt is disabled already. Thus we don't need locking rcu.

Thank you,

> 
> jirka
> 
> 
> >  	reserved_words = 0;
> > -	hlist_for_each_entry_from_rcu(node, hlist) {
> > +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >  		if (node->addr != func)
> > -			break;
> > +			continue;
> >  		fp = READ_ONCE(node->fp);
> >  		if (!fp || !fp->exit_handler)
> >  			continue;
> > @@ -278,13 +278,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >  		reserved_words +=
> >  			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
> >  	}
> > -	node = first;
> >  	if (reserved_words) {
> >  		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
> >  		if (unlikely(!fgraph_data)) {
> > -			hlist_for_each_entry_from_rcu(node, hlist) {
> > +			rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >  				if (node->addr != func)
> > -					break;
> > +					continue;
> >  				fp = READ_ONCE(node->fp);
> >  				if (fp && !fprobe_disabled(fp))
> >  					fp->nmissed++;
> > @@ -299,12 +298,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >  	 */
> >  	ret_ip = ftrace_regs_get_return_address(fregs);
> >  	used = 0;
> > -	hlist_for_each_entry_from_rcu(node, hlist) {
> > +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >  		int data_size;
> >  		void *data;
> >  
> >  		if (node->addr != func)
> > -			break;
> > +			continue;
> >  		fp = READ_ONCE(node->fp);
> >  		if (!fp || fprobe_disabled(fp))
> >  			continue;
> > @@ -448,25 +447,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
> >  	return 0;
> >  }
> >  
> > -static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *head,
> > -					struct fprobe_addr_list *alist)
> > +static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
> > +					 struct fprobe_addr_list *alist)
> >  {
> > -	struct fprobe_hlist_node *node;
> >  	int ret = 0;
> >  
> > -	hlist_for_each_entry_rcu(node, head, hlist,
> > -				 lockdep_is_held(&fprobe_mutex)) {
> > -		if (!within_module(node->addr, mod))
> > -			continue;
> > -		if (delete_fprobe_node(node))
> > -			continue;
> > -		/*
> > -		 * If failed to update alist, just continue to update hlist.
> > -		 * Therefore, at list user handler will not hit anymore.
> > -		 */
> > -		if (!ret)
> > -			ret = fprobe_addr_list_add(alist, node->addr);
> > -	}
> > +	if (!within_module(node->addr, mod))
> > +		return;
> > +	if (delete_fprobe_node(node))
> > +		return;
> > +	/*
> > +	 * If failed to update alist, just continue to update hlist.
> > +	 * Therefore, at list user handler will not hit anymore.
> > +	 */
> > +	if (!ret)
> > +		ret = fprobe_addr_list_add(alist, node->addr);
> >  }
> >  
> >  /* Handle module unloading to manage fprobe_ip_table. */
> > @@ -474,8 +469,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  				  unsigned long val, void *data)
> >  {
> >  	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
> > +	struct fprobe_hlist_node *node;
> > +	struct rhashtable_iter iter;
> >  	struct module *mod = data;
> > -	int i;
> >  
> >  	if (val != MODULE_STATE_GOING)
> >  		return NOTIFY_DONE;
> > @@ -486,8 +482,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  		return NOTIFY_DONE;
> >  
> >  	mutex_lock(&fprobe_mutex);
> > -	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
> > -		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
> > +	rhltable_walk_enter(&fprobe_ip_table, &iter);
> > +	do {
> > +		rhashtable_walk_start(&iter);
> > +
> > +		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> > +			fprobe_remove_node_in_module(mod, node, &alist);
> > +
> > +		rhashtable_walk_stop(&iter);
> > +	} while (node == ERR_PTR(-EAGAIN));
> > +	rhashtable_walk_exit(&iter);
> >  
> >  	if (alist.index < alist.size && alist.index > 0)
> >  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> > @@ -727,8 +731,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
> >  	ret = fprobe_graph_add_ips(addrs, num);
> >  	if (!ret) {
> >  		add_fprobe_hash(fp);
> > -		for (i = 0; i < hlist_array->size; i++)
> > -			insert_fprobe_node(&hlist_array->array[i]);
> > +		for (i = 0; i < hlist_array->size; i++) {
> > +			ret = insert_fprobe_node(&hlist_array->array[i]);
> > +			if (ret)
> > +				break;
> > +		}
> > +		/* fallback on insert error */
> > +		if (ret) {
> > +			for (i--; i >= 0; i--)
> > +				delete_fprobe_node(&hlist_array->array[i]);
> > +		}
> >  	}
> >  	mutex_unlock(&fprobe_mutex);
> >  
> > @@ -824,3 +836,10 @@ int unregister_fprobe(struct fprobe *fp)
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_fprobe);
> > +
> > +static int __init fprobe_initcall(void)
> > +{
> > +	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> > +	return 0;
> > +}
> > +late_initcall(fprobe_initcall);
> > -- 
> > 2.50.1
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

