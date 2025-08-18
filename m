Return-Path: <bpf+bounces-65887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F128B2A7F7
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED7E686693
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480C322525;
	Mon, 18 Aug 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOojLOrk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706C21FF4B;
	Mon, 18 Aug 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524631; cv=none; b=G03kMiFOohsqtIblZ7VMUjvnv59Eeq+DR8AxLuVHsUS7brxwB9Xe8C5xdInL5X8muDYmu8yZ7gun/egB3Uy3gY4Ky8W0Pwwviohx3c1kRRtsJpLS8Nav8eiAPE/+EEgO6XIx7ImDhitOpa/o1Y1PC9zwy/C31urA362+oWXf9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524631; c=relaxed/simple;
	bh=EH5R8gXyWE2kpZZPYkkLNKvw76nMUQCVU5AoWHweeG4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB1yxId1RvBL8s5e1B+YdQheMzmlc4A2Bba3mgnGtzRB+8eVubAnDoD/Ndft8GPXbfAZMk8hN7zDKcYVGM9Rjx+0JOmiiW29Y5R8IAX1kV7BDgjxste4PnzNXk+v406UKsYdQJk9v2lrXxpPF3SbDDky9mxk6UebifseOftHvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOojLOrk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso20239295e9.1;
        Mon, 18 Aug 2025 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755524628; x=1756129428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ksd4ZkEJJDNxja3j4P7wzYuF2zcMxe1sJg0wW5wmYxA=;
        b=bOojLOrkpzV6Zfb7pK42P4HX8/2KLcP2TSFrOLE01qTopIfBTCPhlgpr1aEN8TMdFg
         ZKElfUWKZ59fqZzR3RglB4cA8BUoeBg+z27zY9VgbIsbYyW4TtISF5LwWuoZSUdPVU0r
         LbbftkneSkXsHhVVRTj7jeXchh5Ui1GcfQ2x7LPB3Ib+6gxQ8tn0h08CkjX3ulbTFGAI
         lRJHSWT/RkzBodu8LYYmwSXn9DVo7P0wdgU/luRQ7qO4h1RQajnXTKCGw0C0Tu9b/bVe
         tMMrHsyYzSGLuFZ5y3zw/HC3aCKCZMXxQAomKFn5MGoesPqzgXkxHbaQa8VueTvycFTD
         JI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524628; x=1756129428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ksd4ZkEJJDNxja3j4P7wzYuF2zcMxe1sJg0wW5wmYxA=;
        b=cClqV7A+Mqt9vI99/WlI4grMPZahHxSl7wyWugb6YfOkmMEvMGxT8C6lMtEZujMNNL
         ceiLMCE92VE6FcDcYZ11HCK29u+1t/ldlJs/ctuS19td2xfPgqUgY2Yl+wipBx1aga58
         iyexewqjbv8ojI76pfLXR74NNiwfDZxs9K6yDlwfYAKynIblmRFNIYHZlmPBKl/KsK9f
         q/IjiHykIS4Y1UL2TmhgM+2u428h2b7fHbUGhs2HSfk/ILM52R3FZCqWIeOVTVKwuRjL
         z0SCesPHsclh9VY6tirhPlTnJkaaDKDINXJEYOOqET1bl54N+loMj5iVZGGbgJQrYZ5x
         bixA==
X-Forwarded-Encrypted: i=1; AJvYcCUlcMGrBJ/ut6lNzlL8a3iJZiOQfU0RGuzjOosuhEYICtm/OR0KZ69vGZNzJcTv2ueYkiyuRQfusk6JRqLa@vger.kernel.org, AJvYcCUxBuy1vbbsT0rbSeOFdVxgeTve65c65NQLnDxeGu2TZ5gZGhvS4W/nEX+NoMGBWKHelAsm7QFPypEl++ab2pOHVW7J@vger.kernel.org, AJvYcCWtmohFiVteV/sDmYaznRYi6mqpbw3WUijiVU7WpcYRmW6T0rIWE79tvwcC90dqH7O/O6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvnFHJEDbRPMHIIN7W7yWY+7cYDRUZaRzMLBLR6hMWWY45iy0
	Ut1IFkV5xxUMflpKAvN0jrxxnQPErLfr84AgjB/lNo+xoDzr08McIIyz
X-Gm-Gg: ASbGncurVQk+jt6GeePZ5p+uK8iyJc1HHCyZQAeZOUJp1DivJbACWQIwbRrnbZ26U74
	2U25wf141Xg/A40mIzgqhie16gVC8cWWQA7vfFKl9v0eup1eg2TrGy+OCuCblW0sFo1/QBYhyG0
	SEzYFOaTt+YqtDuYcdJuC7ZOvhubr/fJxe9+3NRFFyyszzqWMqjJ8KMlksNwqYbwR1kfk2qGOpB
	3KEkz2LSbQsXY0OWOU6PsuzgtOekCSr1gpiRWuca2eEktW7RwdAvcW5vyQBfL1FvryOnESkiYc8
	Cy9Ce8uf5ya9l/d3nsLSeWsONfrJIWk+OUxlU11z8hWKMQ3MOC8u9eRcfWCX4ZFN3oWA6GPJ
X-Google-Smtp-Source: AGHT+IFefD8L/5AECmOQWgwZG7vBzg4GVr69pUWnjr280iqHcR09XLeHb5ncoD/H3ipricvKqKH7cQ==
X-Received: by 2002:a5d:5f49:0:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3bb66a3baa4mr10095478f8f.14.1755524627746;
        Mon, 18 Aug 2025 06:43:47 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d29a70sm13155211f8f.17.2025.08.18.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:43:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Aug 2025 15:43:44 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com,
	revest@chromium.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/4] fprobe: use rhltable for fprobe_ip_table
Message-ID: <aKMuENl9omxi6OwJ@krava>
References: <20250817024607.296117-1-dongml2@chinatelecom.cn>
 <20250817024607.296117-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817024607.296117-2-dongml2@chinatelecom.cn>

On Sun, Aug 17, 2025 at 10:46:02AM +0800, Menglong Dong wrote:

SNIP

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
> @@ -92,9 +92,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
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

I think rhltable_lookup needs rcu lock

>  }
>  
>  /* Check existence of the fprobe */
> @@ -249,9 +251,10 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
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
> @@ -260,14 +263,11 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	if (WARN_ON_ONCE(!fregs))
>  		return 0;
>  
> -	first = node = find_first_fprobe_node(func);
> -	if (unlikely(!first))
> -		return 0;
> -
> +	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);

ditto

jirka


>  	reserved_words = 0;
> -	hlist_for_each_entry_from_rcu(node, hlist) {
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  		if (node->addr != func)
> -			break;
> +			continue;
>  		fp = READ_ONCE(node->fp);
>  		if (!fp || !fp->exit_handler)
>  			continue;
> @@ -278,13 +278,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  		reserved_words +=
>  			FPROBE_HEADER_SIZE_IN_LONG + SIZE_IN_LONG(fp->entry_data_size);
>  	}
> -	node = first;
>  	if (reserved_words) {
>  		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
>  		if (unlikely(!fgraph_data)) {
> -			hlist_for_each_entry_from_rcu(node, hlist) {
> +			rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  				if (node->addr != func)
> -					break;
> +					continue;
>  				fp = READ_ONCE(node->fp);
>  				if (fp && !fprobe_disabled(fp))
>  					fp->nmissed++;
> @@ -299,12 +298,12 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
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
> @@ -448,25 +447,21 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
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
> @@ -474,8 +469,9 @@ static int fprobe_module_callback(struct notifier_block *nb,
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
> @@ -486,8 +482,16 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  		return NOTIFY_DONE;
>  
>  	mutex_lock(&fprobe_mutex);
> -	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
> -		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
> +	rhltable_walk_enter(&fprobe_ip_table, &iter);
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
> @@ -727,8 +731,16 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
> @@ -824,3 +836,10 @@ int unregister_fprobe(struct fprobe *fp)
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
> 

