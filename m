Return-Path: <bpf+bounces-18299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7E818A35
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B5C1F2B779
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7871C6B2;
	Tue, 19 Dec 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzLJLGl3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230571CA84;
	Tue, 19 Dec 2023 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a234139b725so353669466b.3;
        Tue, 19 Dec 2023 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996746; x=1703601546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCYuataRQgXoc1YQkgEEVBGJBr58nw2hRZs26iZ3l4k=;
        b=hzLJLGl3oMSBbaxYXGt9ySqvf3SK2nz8AI9LpPXy2Q1jgx2P4LhAg+R2fezXErrZYK
         Mx4UEUjCXIQujWsfSaRHNOaVblR+N5a2vRNgiNVGoKXU+6G8exFBTnIlo5fGQrF5MFrJ
         MdmlO1Ae6c9yvDz0PFlLGW8xTsccP9ZIJJbyb+v44hFkYv4fLYsr/F3kjfEkh+4Av5+N
         mWrFv5b+6s3jOicudt4bm3XiBiB1zz2QflUwOs9Um/9YcgznlyD7ZHkArOTlqHT9NmyD
         NPc5fdYYYOa+GBZ4YClIugphWEIAbSQ+ipTWCkPwqSVZQl8EE9dRzQ1AS39aYSbY1CRM
         br3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996746; x=1703601546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCYuataRQgXoc1YQkgEEVBGJBr58nw2hRZs26iZ3l4k=;
        b=GO63UeBqxXe2DnP8gAgA+7jRlte3yXMIIWcBqwhLASwOhvIJC2X69SHHODFUC4bb7n
         5gFhFd2LE34pml3E/mDOI1KvFjBmr+XZO+6+JTmcrcz3iJeQohMCRoY5wKSHtuyMeija
         SQRf/wVTGbqhiOgZCxMXvsdviZWvrFktwLv+gvXVUDh3srUYd0M30su1EcRTd0UQDcNp
         JA26RtZaqfaNZ0lmzpQ1FwnnZp1eajlwzqpWaQfMG42utoUtKG2LhHr94f2RxRELQMni
         oA4Gq0eoTTZQ/qGpQKYgbCOIZOzWZJnWuI6kdRsi2SffD8CJzDJwKnq/vmV1qdwI92WJ
         f2og==
X-Gm-Message-State: AOJu0YzGo8l/HWrhS22vNrbXpOjQGEPVB4o9ehCGkf4sC9ceaM0kle6Y
	lN/4TYYjhafKkQVTzhRj6Cg=
X-Google-Smtp-Source: AGHT+IG5a5aZa0ytfiDPoQYWo5AOxcsDCqi2QEnyn5m3+Zpe6BdYQp0+129t9BvKxutcdz3NX7XTWA==
X-Received: by 2002:a17:906:4099:b0:a23:3515:b200 with SMTP id u25-20020a170906409900b00a233515b200mr1099426ejj.246.1702996745939;
        Tue, 19 Dec 2023 06:39:05 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id jw23-20020a17090776b700b00a23365f1290sm3538144ejc.218.2023.12.19.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:39:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Dec 2023 15:39:03 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 28/34] fprobe: Rewrite fprobe on function-graph tracer
Message-ID: <ZYGrB7NsDEWk2liL@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290542972.220107.9135357273431693988.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170290542972.220107.9135357273431693988.stgit@devnote2>

On Mon, Dec 18, 2023 at 10:17:10PM +0900, Masami Hiramatsu (Google) wrote:

SNIP

> -static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> -				unsigned long ret_ip, struct pt_regs *regs)
> +static int fprobe_entry(unsigned long func, unsigned long ret_ip,
> +			struct ftrace_regs *fregs, struct fgraph_ops *gops)
>  {
> -	struct fprobe *fp = (struct fprobe *)data;
> -	struct fprobe_rethook_node *fpr;
> -	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
> -	int bit;
> +	struct fprobe_hlist_node *node, *first;
> +	unsigned long *fgraph_data = NULL;
> +	unsigned long header;
> +	int reserved_words;
> +	struct fprobe *fp;
> +	int used, ret;
>  
> -	if (!fp || fprobe_disabled(fp))
> -		return;
> +	if (WARN_ON_ONCE(!fregs))
> +		return 0;
>  
> -	fpr = container_of(rh, struct fprobe_rethook_node, node);
> +	first = node = find_first_fprobe_node(func);
> +	if (unlikely(!first))
> +		return 0;
> +
> +	reserved_words = 0;
> +	hlist_for_each_entry_from_rcu(node, hlist) {
> +		if (node->addr != func)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (!fp || !fp->exit_handler)
> +			continue;
> +		/*
> +		 * Since fprobe can be enabled until the next loop, we ignore the
> +		 * fprobe's disabled flag in this loop.
> +		 */
> +		reserved_words +=
> +			DIV_ROUND_UP(fp->entry_data_size, sizeof(long)) + 1;
> +	}
> +	node = first;
> +	if (reserved_words) {
> +		fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
> +		if (unlikely(!fgraph_data)) {
> +			hlist_for_each_entry_from_rcu(node, hlist) {
> +				if (node->addr != func)
> +					break;
> +				fp = READ_ONCE(node->fp);
> +				if (fp && !fprobe_disabled(fp))
> +					fp->nmissed++;
> +			}
> +			return 0;
> +		}
> +	}

this looks expensive compared to what we do now.. IIUC due to the graph
ops limitations (16 ctive ops), you have just single graph ops for fprobe
and each fprobe registration stores ips into hash which you need to search
in here to get registered callbacks..?

I wonder would it make sense to allow arbitrary number of active graph_ops
with the price some callback might fail because there's no stack space so
each fprobe instance would have its own graph_ops.. and we would get rid
of the code above (and below) ?

jirka

>  
>  	/*
> -	 * we need to assure no calls to traceable functions in-between the
> -	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
> +	 * TODO: recursion detection has been done in the fgraph. Thus we need
> +	 * to add a callback to increment missed counter.
>  	 */
> -	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
> -	if (bit < 0) {
> -		fp->nmissed++;
> +	used = 0;
> +	hlist_for_each_entry_from_rcu(node, hlist) {
> +		void *data;
> +
> +		if (node->addr != func)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (!fp || fprobe_disabled(fp))
> +			continue;
> +
> +		if (fp->entry_data_size && fp->exit_handler)
> +			data = fgraph_data + used + 1;
> +		else
> +			data = NULL;
> +
> +		if (fprobe_shared_with_kprobes(fp))
> +			ret = __fprobe_kprobe_handler(func, ret_ip, fp, fregs, data);
> +		else
> +			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
> +		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> +		if (!ret && fp->exit_handler) {
> +			int size_words = DIV_ROUND_UP(fp->entry_data_size, sizeof(long));
> +
> +			header = encode_fprobe_header(fp, size_words);
> +			if (likely(header)) {
> +				fgraph_data[used] = header;
> +				used += size_words + 1;
> +			}
> +		}
> +	}
> +	if (used < reserved_words)
> +		memset(fgraph_data + used, 0, reserved_words - used);
> +
> +	/* If any exit_handler is set, data must be used. */
> +	return used != 0;
> +}
> +NOKPROBE_SYMBOL(fprobe_entry);
> +
> +static void fprobe_return(unsigned long func, unsigned long ret_ip,
> +			  struct ftrace_regs *fregs, struct fgraph_ops *gops)
> +{
> +	unsigned long *fgraph_data = NULL;
> +	unsigned long val;
> +	struct fprobe *fp;
> +	int size, curr;
> +	int size_words;
> +
> +	fgraph_data = (unsigned long *)fgraph_retrieve_data(gops->idx, &size);
> +	if (!fgraph_data)
> +		return;
> +	size_words = DIV_ROUND_UP(size, sizeof(long));
> +
> +	preempt_disable();
> +
> +	curr = 0;
> +	while (size_words > curr) {
> +		val = fgraph_data[curr++];
> +		if (!val)
> +			break;
> +
> +		size = decode_fprobe_header(val, &fp);
> +		if (fp && is_fprobe_still_exist(fp) && !fprobe_disabled(fp)) {
> +			if (WARN_ON_ONCE(curr + size > size_words))
> +				break;
> +			fp->exit_handler(fp, func, ret_ip, fregs,
> +					 size ? fgraph_data + curr : NULL);
> +		}
> +		curr += size + 1;
> +	}
> +	preempt_enable();
> +}
> +NOKPROBE_SYMBOL(fprobe_return);
> +
> +static struct fgraph_ops fprobe_graph_ops = {
> +	.entryregfunc	= fprobe_entry,
> +	.retregfunc	= fprobe_return,
> +};
> +static int fprobe_graph_active;
> +
> +/* Add @addrs to the ftrace filter and register fgraph if needed. */
> +static int fprobe_graph_add_ips(unsigned long *addrs, int num)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&fprobe_mutex);
> +
> +	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (!fprobe_graph_active) {
> +		ret = register_ftrace_graph(&fprobe_graph_ops);
> +		if (WARN_ON_ONCE(ret)) {
> +			ftrace_free_filter(&fprobe_graph_ops.ops);
> +			return ret;
> +		}
> +	}
> +	fprobe_graph_active++;
> +	return 0;
> +}
> +
> +/* Remove @addrs from the ftrace filter and unregister fgraph if possible. */
> +static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
> +{
> +	lockdep_assert_held(&fprobe_mutex);
> +
> +	fprobe_graph_active--;
> +	if (!fprobe_graph_active) {
> +		/* Q: should we unregister it ? */
> +		unregister_ftrace_graph(&fprobe_graph_ops);
>  		return;
>  	}
>  
> -	fp->exit_handler(fp, fpr->entry_ip, ret_ip, fregs,
> -			 fp->entry_data_size ? (void *)fpr->data : NULL);
> -	ftrace_test_recursion_unlock(bit);
> +	ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
>  }
> -NOKPROBE_SYMBOL(fprobe_exit_handler);
>  
>  static int symbols_cmp(const void *a, const void *b)
>  {
> @@ -176,55 +406,97 @@ static unsigned long *get_ftrace_locations(const char **syms, int num)
>  	return ERR_PTR(-ENOENT);
>  }
>  
> -static void fprobe_init(struct fprobe *fp)
> -{
> -	fp->nmissed = 0;
> -	if (fprobe_shared_with_kprobes(fp))
> -		fp->ops.func = fprobe_kprobe_handler;
> -	else
> -		fp->ops.func = fprobe_handler;
> -	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;
> -}
> +struct filter_match_data {
> +	const char *filter;
> +	const char *notfilter;
> +	size_t index;
> +	size_t size;
> +	unsigned long *addrs;
> +};
>  
> -static int fprobe_init_rethook(struct fprobe *fp, int num)
> +static int filter_match_callback(void *data, const char *name, unsigned long addr)
>  {
> -	int size;
> +	struct filter_match_data *match = data;
>  
> -	if (num <= 0)
> -		return -EINVAL;
> +	if (!glob_match(match->filter, name) ||
> +	    (match->notfilter && glob_match(match->notfilter, name)))
> +		return 0;
>  
> -	if (!fp->exit_handler) {
> -		fp->rethook = NULL;
> +	if (!ftrace_location(addr))
>  		return 0;
> -	}
>  
> -	/* Initialize rethook if needed */
> -	if (fp->nr_maxactive)
> -		size = fp->nr_maxactive;
> -	else
> -		size = num * num_possible_cpus() * 2;
> -	if (size <= 0)
> -		return -EINVAL;
> +	if (match->addrs)
> +		match->addrs[match->index] = addr;
>  
> -	/* Initialize rethook */
> -	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
> -				sizeof(struct fprobe_rethook_node), size);
> -	if (IS_ERR(fp->rethook))
> -		return PTR_ERR(fp->rethook);
> +	match->index++;
> +	return match->index == match->size;
> +}
>  
> -	return 0;
> +/*
> + * Make IP list from the filter/no-filter glob patterns.
> + * Return the number of matched symbols, or -ENOENT.
> + */
> +static int ip_list_from_filter(const char *filter, const char *notfilter,
> +			       unsigned long *addrs, size_t size)
> +{
> +	struct filter_match_data match = { .filter = filter, .notfilter = notfilter,
> +		.index = 0, .size = size, .addrs = addrs};
> +	int ret;
> +
> +	ret = kallsyms_on_each_symbol(filter_match_callback, &match);
> +	if (ret < 0)
> +		return ret;
> +	ret = module_kallsyms_on_each_symbol(NULL, filter_match_callback, &match);
> +	if (ret < 0)
> +		return ret;
> +
> +	return match.index ?: -ENOENT;
>  }
>  
>  static void fprobe_fail_cleanup(struct fprobe *fp)
>  {
> -	if (!IS_ERR_OR_NULL(fp->rethook)) {
> -		/* Don't need to cleanup rethook->handler because this is not used. */
> -		rethook_free(fp->rethook);
> -		fp->rethook = NULL;
> +	kfree(fp->hlist_array);
> +	fp->hlist_array = NULL;
> +}
> +
> +/* Initialize the fprobe data structure. */
> +static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
> +{
> +	struct fprobe_hlist *hlist_array;
> +	unsigned long addr;
> +	int size, i;
> +
> +	if (!fp || !addrs || num <= 0)
> +		return -EINVAL;
> +
> +	size = ALIGN(fp->entry_data_size, sizeof(long));
> +	if (size > MAX_FPROBE_DATA_SIZE)
> +		return -E2BIG;
> +	fp->entry_data_size = size;
> +
> +	hlist_array = kzalloc(struct_size(hlist_array, array, num), GFP_KERNEL);
> +	if (!hlist_array)
> +		return -ENOMEM;
> +
> +	fp->nmissed = 0;
> +
> +	hlist_array->size = num;
> +	fp->hlist_array = hlist_array;
> +	hlist_array->fp = fp;
> +	for (i = 0; i < num; i++) {
> +		hlist_array->array[i].fp = fp;
> +		addr = ftrace_location(addrs[i]);
> +		if (!addr) {
> +			fprobe_fail_cleanup(fp);
> +			return -ENOENT;
> +		}
> +		hlist_array->array[i].addr = addr;
>  	}
> -	ftrace_free_filter(&fp->ops);
> +	return 0;
>  }
>  
> +#define FPROBE_IPS_MAX	INT_MAX
> +
>  /**
>   * register_fprobe() - Register fprobe to ftrace by pattern.
>   * @fp: A fprobe data structure to be registered.
> @@ -238,46 +510,24 @@ static void fprobe_fail_cleanup(struct fprobe *fp)
>   */
>  int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter)
>  {
> -	struct ftrace_hash *hash;
> -	unsigned char *str;
> -	int ret, len;
> +	unsigned long *addrs;
> +	int ret;
>  
>  	if (!fp || !filter)
>  		return -EINVAL;
>  
> -	fprobe_init(fp);
> -
> -	len = strlen(filter);
> -	str = kstrdup(filter, GFP_KERNEL);
> -	ret = ftrace_set_filter(&fp->ops, str, len, 0);
> -	kfree(str);
> -	if (ret)
> +	ret = ip_list_from_filter(filter, notfilter, NULL, FPROBE_IPS_MAX);
> +	if (ret < 0)
>  		return ret;
>  
> -	if (notfilter) {
> -		len = strlen(notfilter);
> -		str = kstrdup(notfilter, GFP_KERNEL);
> -		ret = ftrace_set_notrace(&fp->ops, str, len, 0);
> -		kfree(str);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	/* TODO:
> -	 * correctly calculate the total number of filtered symbols
> -	 * from both filter and notfilter.
> -	 */
> -	hash = rcu_access_pointer(fp->ops.local_hash.filter_hash);
> -	if (WARN_ON_ONCE(!hash))
> -		goto out;
> -
> -	ret = fprobe_init_rethook(fp, (int)hash->count);
> -	if (!ret)
> -		ret = register_ftrace_function(&fp->ops);
> +	addrs = kcalloc(ret, sizeof(unsigned long), GFP_KERNEL);
> +	if (!addrs)
> +		return -ENOMEM;
> +	ret = ip_list_from_filter(filter, notfilter, addrs, ret);
> +	if (ret > 0)
> +		ret = register_fprobe_ips(fp, addrs, ret);
>  
> -out:
> -	if (ret)
> -		fprobe_fail_cleanup(fp);
> +	kfree(addrs);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(register_fprobe);
> @@ -285,7 +535,7 @@ EXPORT_SYMBOL_GPL(register_fprobe);
>  /**
>   * register_fprobe_ips() - Register fprobe to ftrace by address.
>   * @fp: A fprobe data structure to be registered.
> - * @addrs: An array of target ftrace location addresses.
> + * @addrs: An array of target function address.
>   * @num: The number of entries of @addrs.
>   *
>   * Register @fp to ftrace for enabling the probe on the address given by @addrs.
> @@ -297,23 +547,27 @@ EXPORT_SYMBOL_GPL(register_fprobe);
>   */
>  int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
>  {
> -	int ret;
> -
> -	if (!fp || !addrs || num <= 0)
> -		return -EINVAL;
> -
> -	fprobe_init(fp);
> +	struct fprobe_hlist *hlist_array;
> +	int ret, i;
>  
> -	ret = ftrace_set_filter_ips(&fp->ops, addrs, num, 0, 0);
> +	ret = fprobe_init(fp, addrs, num);
>  	if (ret)
>  		return ret;
>  
> -	ret = fprobe_init_rethook(fp, num);
> -	if (!ret)
> -		ret = register_ftrace_function(&fp->ops);
> +	mutex_lock(&fprobe_mutex);
> +
> +	hlist_array = fp->hlist_array;
> +	ret = fprobe_graph_add_ips(addrs, num);
> +	if (!ret) {
> +		add_fprobe_hash(fp);
> +		for (i = 0; i < hlist_array->size; i++)
> +			insert_fprobe_node(&hlist_array->array[i]);
> +	}
> +	mutex_unlock(&fprobe_mutex);
>  
>  	if (ret)
>  		fprobe_fail_cleanup(fp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(register_fprobe_ips);
> @@ -351,14 +605,13 @@ EXPORT_SYMBOL_GPL(register_fprobe_syms);
>  
>  bool fprobe_is_registered(struct fprobe *fp)
>  {
> -	if (!fp || (fp->ops.saved_func != fprobe_handler &&
> -		    fp->ops.saved_func != fprobe_kprobe_handler))
> +	if (!fp || !fp->hlist_array)
>  		return false;
>  	return true;
>  }
>  
>  /**
> - * unregister_fprobe() - Unregister fprobe from ftrace
> + * unregister_fprobe() - Unregister fprobe.
>   * @fp: A fprobe data structure to be unregistered.
>   *
>   * Unregister fprobe (and remove ftrace hooks from the function entries).
> @@ -367,23 +620,40 @@ bool fprobe_is_registered(struct fprobe *fp)
>   */
>  int unregister_fprobe(struct fprobe *fp)
>  {
> -	int ret;
> +	struct fprobe_hlist *hlist_array;
> +	unsigned long *addrs = NULL;
> +	int ret = 0, i, count;
>  
> -	if (!fprobe_is_registered(fp))
> -		return -EINVAL;
> +	mutex_lock(&fprobe_mutex);
> +	if (!fp || !is_fprobe_still_exist(fp)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
> -	if (!IS_ERR_OR_NULL(fp->rethook))
> -		rethook_stop(fp->rethook);
> +	hlist_array = fp->hlist_array;
> +	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
> +	if (!addrs) {
> +		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
> +		goto out;
> +	}
>  
> -	ret = unregister_ftrace_function(&fp->ops);
> -	if (ret < 0)
> -		return ret;
> +	/* Remove non-synonim ips from table and hash */
> +	count = 0;
> +	for (i = 0; i < hlist_array->size; i++) {
> +		if (!delete_fprobe_node(&hlist_array->array[i]))
> +			addrs[count++] = hlist_array->array[i].addr;
> +	}
> +	del_fprobe_hash(fp);
>  
> -	if (!IS_ERR_OR_NULL(fp->rethook))
> -		rethook_free(fp->rethook);
> +	fprobe_graph_remove_ips(addrs, count);
>  
> -	ftrace_free_filter(&fp->ops);
> +	kfree_rcu(hlist_array, rcu);
> +	fp->hlist_array = NULL;
>  
> +out:
> +	mutex_unlock(&fprobe_mutex);
> +
> +	kfree(addrs);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(unregister_fprobe);
> diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
> index 271ce0caeec0..cf92111b5c79 100644
> --- a/lib/test_fprobe.c
> +++ b/lib/test_fprobe.c
> @@ -17,10 +17,8 @@ static u32 rand1, entry_val, exit_val;
>  /* Use indirect calls to avoid inlining the target functions */
>  static u32 (*target)(u32 value);
>  static u32 (*target2)(u32 value);
> -static u32 (*target_nest)(u32 value, u32 (*nest)(u32));
>  static unsigned long target_ip;
>  static unsigned long target2_ip;
> -static unsigned long target_nest_ip;
>  static int entry_return_value;
>  
>  static noinline u32 fprobe_selftest_target(u32 value)
> @@ -33,11 +31,6 @@ static noinline u32 fprobe_selftest_target2(u32 value)
>  	return (value / div_factor) + 1;
>  }
>  
> -static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
> -{
> -	return nest(value + 2);
> -}
> -
>  static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
>  				    unsigned long ret_ip,
>  				    struct ftrace_regs *fregs, void *data)
> @@ -79,22 +72,6 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
>  		KUNIT_EXPECT_NULL(current_test, data);
>  }
>  
> -static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
> -				      unsigned long ret_ip,
> -				      struct ftrace_regs *fregs, void *data)
> -{
> -	KUNIT_EXPECT_FALSE(current_test, preemptible());
> -	return 0;
> -}
> -
> -static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
> -				      unsigned long ret_ip,
> -				      struct ftrace_regs *fregs, void *data)
> -{
> -	KUNIT_EXPECT_FALSE(current_test, preemptible());
> -	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
> -}
> -
>  /* Test entry only (no rethook) */
>  static void test_fprobe_entry(struct kunit *test)
>  {
> @@ -191,25 +168,6 @@ static void test_fprobe_data(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
>  }
>  
> -/* Test nr_maxactive */
> -static void test_fprobe_nest(struct kunit *test)
> -{
> -	static const char *syms[] = {"fprobe_selftest_target", "fprobe_selftest_nest_target"};
> -	struct fprobe fp = {
> -		.entry_handler = nest_entry_handler,
> -		.exit_handler = nest_exit_handler,
> -		.nr_maxactive = 1,
> -	};
> -
> -	current_test = test;
> -	KUNIT_EXPECT_EQ(test, 0, register_fprobe_syms(&fp, syms, 2));
> -
> -	target_nest(rand1, target);
> -	KUNIT_EXPECT_EQ(test, 1, fp.nmissed);
> -
> -	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
> -}
> -
>  static void test_fprobe_skip(struct kunit *test)
>  {
>  	struct fprobe fp = {
> @@ -247,10 +205,8 @@ static int fprobe_test_init(struct kunit *test)
>  	rand1 = get_random_u32_above(div_factor);
>  	target = fprobe_selftest_target;
>  	target2 = fprobe_selftest_target2;
> -	target_nest = fprobe_selftest_nest_target;
>  	target_ip = get_ftrace_location(target);
>  	target2_ip = get_ftrace_location(target2);
> -	target_nest_ip = get_ftrace_location(target_nest);
>  
>  	return 0;
>  }
> @@ -260,7 +216,6 @@ static struct kunit_case fprobe_testcases[] = {
>  	KUNIT_CASE(test_fprobe),
>  	KUNIT_CASE(test_fprobe_syms),
>  	KUNIT_CASE(test_fprobe_data),
> -	KUNIT_CASE(test_fprobe_nest),
>  	KUNIT_CASE(test_fprobe_skip),
>  	{}
>  };
> 

