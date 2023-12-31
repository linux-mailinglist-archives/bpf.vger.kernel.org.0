Return-Path: <bpf+bounces-18756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F34820934
	for <lists+bpf@lfdr.de>; Sun, 31 Dec 2023 01:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA18B21B87
	for <lists+bpf@lfdr.de>; Sun, 31 Dec 2023 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08955658;
	Sun, 31 Dec 2023 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAgroevB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F73375;
	Sun, 31 Dec 2023 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so99559661fa.0;
        Sat, 30 Dec 2023 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703981997; x=1704586797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4wxf2V4Kgwn4shFkWEi1vRz4S3m+eki29twTukIBuI=;
        b=XAgroevBCxPvUQILHNvUi/Rq7kOZH1yUs7hUDbWKarYku2xH5HYFk6wxtLSA1E08mC
         +kpwIqrshSbDViyAbPk61iH52GW6z9MOkV+/FtibFldn+fg9c9Ql2FD4l+VB8Zba/4rB
         WWYC6lQX704w1vbJU9QzN1ztNOK3VKwu2+Ijt0ICMWMYCsirjKwHuqgOjh9Mpbv2Fzv/
         ypgDJ2sFcDmuLbhZxF0gHqAbr9XpakIb8Sh5D8Xa0phPcn2nMhqzAk7dJwKiiU5F5Xh5
         lNt4nbuLW2X8khwpZuYwGFTRuMqL9gfgJnR7QrfWEXGl2NKHYmvcNDo4Gr5Eg5yKM92M
         yPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703981997; x=1704586797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4wxf2V4Kgwn4shFkWEi1vRz4S3m+eki29twTukIBuI=;
        b=LlSzbga2/zUaqN0w08dYalFHTeHuKQfI1f6HCG9p5xs8Sb4umksC7uMIjCFNFFYkyV
         trAT9xSaHEorl0qj24KuIZieg3A7/PRtajVu5W/uBm2VuIC1EbCPKnZrujM81NQyXJ4d
         EIcEUXujKTEBRJzpfKjq9p8ryAW7PVedXv7oFAcigBRN9FNmdn4xceatYgD22QxTLsYx
         qjfGTgRDmbhmjYylq4yz1+N8upXVo7/jDXGa39s5wgzntB5AU80ceGLtEbc6ebV+y1et
         wi/wlr+gc/XgerlcihKrbTbAb1JeIrSBP8nSS7tYrGD1gqob8Jij51VZd2U/gtGipyA4
         ShBQ==
X-Gm-Message-State: AOJu0Yx2/UV/VJsO3VFZ65qOJ3kUKHZwkOw6uuugDIT1RaT5wrQjTFz1
	0TNiPj+q8GgCOzPlCqu6lvM=
X-Google-Smtp-Source: AGHT+IFpXk3C7xrBbiFD/pChpmH1dvEEPb+7wEt3RH9fXEg8XlAoDMbs2aWcGZ7gNJifqJdxxBhEiA==
X-Received: by 2002:a05:6512:944:b0:50e:3ad6:c34 with SMTP id u4-20020a056512094400b0050e3ad60c34mr5539762lft.112.1703981996288;
        Sat, 30 Dec 2023 16:19:56 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id x17-20020a1709065ad100b00a27e2641941sm236513ejs.113.2023.12.30.16.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 16:19:55 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 31 Dec 2023 01:19:53 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix modification of direct_function hash while
 in use
Message-ID: <ZZCzqaxTnDB8ISZt@krava>
References: <20231229115134.08dd5174@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229115134.08dd5174@gandalf.local.home>

On Fri, Dec 29, 2023 at 11:51:34AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Masami Hiramatsu reported a memory leak in register_ftrace_direct() where
> if the number of new entries are added is large enough to cause two
> allocations in the loop:
> 
>         for (i = 0; i < size; i++) {
>                 hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
>                         new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
>                         if (!new)
>                                 goto out_remove;
>                         entry->direct = addr;
>                 }
>         }
> 
> Where ftrace_add_rec_direct() has:
> 
>         if (ftrace_hash_empty(direct_functions) ||
>             direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
>                 struct ftrace_hash *new_hash;
>                 int size = ftrace_hash_empty(direct_functions) ? 0 :
>                         direct_functions->count + 1;
> 
>                 if (size < 32)
>                         size = 32;
> 
>                 new_hash = dup_hash(direct_functions, size);
>                 if (!new_hash)
>                         return NULL;
> 
>                 *free_hash = direct_functions;
>                 direct_functions = new_hash;
>         }
> 
> The "*free_hash = direct_functions;" can happen twice, losing the previous
> allocation of direct_functions.

nice catch, I'm running bpf CI on this and it looks good so far [1]

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


[1] https://github.com/kernel-patches/bpf/pull/6202

> 
> But this also exposed a more serious bug.
> 
> The modification of direct_functions above is not safe. As
> direct_functions can be referenced at any time to find what direct caller
> it should call, the time between:
> 
>                 new_hash = dup_hash(direct_functions, size);
>  and
>                 direct_functions = new_hash;
> 
> can have a race with another CPU (or even this one if it gets interrupted),
> and the entries being moved to the new hash are not referenced.
> 
> That's because the "dup_hash()" is really misnamed and is really a
> "move_hash()". It moves the entries from the old hash to the new one.
> 
> Now even if that was changed, this code is not proper as direct_functions
> should not be updated until the end. That is the best way to handle
> function reference changes, and is the way other parts of ftrace handles
> this.
> 
> The following is done:
> 
>  1. Change add_hash_entry() to return the entry it created and inserted
>     into the hash, and not just return success or not.
> 
>  2. Replace ftrace_add_rec_direct() with add_hash_entry(), and remove
>     the former.
> 
>  3. Allocate a "new_hash" at the start that is made for holding both the
>     new hash entries as well as the existing entries in direct_functions.
> 
>  4. Copy (not move) the direct_function entries over to the new_hash.
> 
>  5. Copy the entries of the added hash to the new_hash.
> 
>  6. If everything succeeds, then use rcu_pointer_assign() to update the
>     direct_functions with the new_hash.
> 
> This simplifies the code and fixes both the memory leak as well as the
> race condition mentioned above.
> 
> Link: https://lore.kernel.org/all/170368070504.42064.8960569647118388081.stgit@devnote2/
> 
> Cc: stable@vger.kernel.org
> Fixes: 763e34e74bb7d ("ftrace: Add register_ftrace_direct()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 100 ++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 53 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..b01ae7d36021 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1183,18 +1183,19 @@ static void __add_hash_entry(struct ftrace_hash *hash,
>  	hash->count++;
>  }
>  
> -static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
> +static struct ftrace_func_entry *
> +add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
>  {
>  	struct ftrace_func_entry *entry;
>  
>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>  	if (!entry)
> -		return -ENOMEM;
> +		return NULL;
>  
>  	entry->ip = ip;
>  	__add_hash_entry(hash, entry);
>  
> -	return 0;
> +	return entry;
>  }
>  
>  static void
> @@ -1349,7 +1350,6 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_hash *new_hash;
>  	int size;
> -	int ret;
>  	int i;
>  
>  	new_hash = alloc_ftrace_hash(size_bits);
> @@ -1366,8 +1366,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
>  	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> -			ret = add_hash_entry(new_hash, entry->ip);
> -			if (ret < 0)
> +			if (add_hash_entry(new_hash, entry->ip) == NULL)
>  				goto free_hash;
>  		}
>  	}
> @@ -2536,7 +2535,7 @@ ftrace_find_unique_ops(struct dyn_ftrace *rec)
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  /* Protected by rcu_tasks for reading, and direct_mutex for writing */
> -static struct ftrace_hash *direct_functions = EMPTY_HASH;
> +static struct ftrace_hash __rcu *direct_functions = EMPTY_HASH;
>  static DEFINE_MUTEX(direct_mutex);
>  int ftrace_direct_func_count;
>  
> @@ -2555,39 +2554,6 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
>  	return entry->direct;
>  }
>  
> -static struct ftrace_func_entry*
> -ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
> -		      struct ftrace_hash **free_hash)
> -{
> -	struct ftrace_func_entry *entry;
> -
> -	if (ftrace_hash_empty(direct_functions) ||
> -	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
> -		struct ftrace_hash *new_hash;
> -		int size = ftrace_hash_empty(direct_functions) ? 0 :
> -			direct_functions->count + 1;
> -
> -		if (size < 32)
> -			size = 32;
> -
> -		new_hash = dup_hash(direct_functions, size);
> -		if (!new_hash)
> -			return NULL;
> -
> -		*free_hash = direct_functions;
> -		direct_functions = new_hash;
> -	}
> -
> -	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> -	if (!entry)
> -		return NULL;
> -
> -	entry->ip = ip;
> -	entry->direct = addr;
> -	__add_hash_entry(direct_functions, entry);
> -	return entry;
> -}
> -
>  static void call_direct_funcs(unsigned long ip, unsigned long pip,
>  			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
> @@ -4223,8 +4189,8 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
>  		/* Do nothing if it exists */
>  		if (entry)
>  			return 0;
> -
> -		ret = add_hash_entry(hash, rec->ip);
> +		if (add_hash_entry(hash, rec->ip) == NULL)
> +			ret = -ENOMEM;
>  	}
>  	return ret;
>  }
> @@ -5266,7 +5232,8 @@ __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
>  		return 0;
>  	}
>  
> -	return add_hash_entry(hash, ip);
> +	entry = add_hash_entry(hash, ip);
> +	return entry ? 0 :  -ENOMEM;
>  }
>  
>  static int
> @@ -5410,7 +5377,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>   */
>  int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  {
> -	struct ftrace_hash *hash, *free_hash = NULL;
> +	struct ftrace_hash *hash, *new_hash = NULL, *free_hash = NULL;
>  	struct ftrace_func_entry *entry, *new;
>  	int err = -EBUSY, size, i;
>  
> @@ -5436,17 +5403,44 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  		}
>  	}
>  
> -	/* ... and insert them to direct_functions hash. */
>  	err = -ENOMEM;
> +
> +	/* Make a copy hash to place the new and the old entries in */
> +	size = hash->count + direct_functions->count;
> +	if (size > 32)
> +		size = 32;
> +	new_hash = alloc_ftrace_hash(fls(size));
> +	if (!new_hash)
> +		goto out_unlock;
> +
> +	/* Now copy over the existing direct entries */
> +	size = 1 << direct_functions->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &direct_functions->buckets[i], hlist) {
> +			new = add_hash_entry(new_hash, entry->ip);
> +			if (!new)
> +				goto out_unlock;
> +			new->direct = entry->direct;
> +		}
> +	}
> +
> +	/* ... and add the new entries */
> +	size = 1 << hash->size_bits;
>  	for (i = 0; i < size; i++) {
>  		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> -			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
> +			new = add_hash_entry(new_hash, entry->ip);
>  			if (!new)
> -				goto out_remove;
> +				goto out_unlock;
> +			/* Update both the copy and the hash entry */
> +			new->direct = addr;
>  			entry->direct = addr;
>  		}
>  	}
>  
> +	free_hash = direct_functions;
> +	rcu_assign_pointer(direct_functions, new_hash);
> +	new_hash = NULL;
> +
>  	ops->func = call_direct_funcs;
>  	ops->flags = MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
> @@ -5454,17 +5448,17 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  
>  	err = register_ftrace_function_nolock(ops);
>  
> - out_remove:
> -	if (err)
> -		remove_direct_functions_hash(hash, addr);
> -
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
>  
> -	if (free_hash) {
> +	if (free_hash && free_hash != EMPTY_HASH) {
>  		synchronize_rcu_tasks();
>  		free_ftrace_hash(free_hash);
>  	}
> +
> +	if (new_hash)
> +		free_ftrace_hash(new_hash);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(register_ftrace_direct);
> @@ -6309,7 +6303,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
>  
>  				if (entry)
>  					continue;
> -				if (add_hash_entry(hash, rec->ip) < 0)
> +				if (add_hash_entry(hash, rec->ip) == NULL)
>  					goto out;
>  			} else {
>  				if (entry) {
> -- 
> 2.42.0
> 

