Return-Path: <bpf+bounces-18749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD14182040F
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D231C20BFF
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351712584;
	Sat, 30 Dec 2023 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOrXnMgu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10A23A5;
	Sat, 30 Dec 2023 08:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C058CC433C8;
	Sat, 30 Dec 2023 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703925696;
	bh=dzteouM10pv6wk8uNmQ/VLB0p6VTmDWkZ/hi/6DF8y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DOrXnMguPzj6kjPbJVJBJ7kOOWHicouD6MQY3Kv1TdJ7Ho6rbLqIV/Uuh3dsKLdKC
	 wiFVZuqbXEX5wSK65we2CMbdKa4nzX2HdkBxZ1DWoe4ndj84K8un/Dw7rgKgZcg21m
	 bwX60dCXvvbTwCPNA24KrK/Vk84lOoz+fcLqkVQNcnoRsjgyOgH7sg4MfHZc2ndqyU
	 DEu2QQG6xG9xF89MA5BQ58hN6A7dOOUWCsQSyNahq9QDLXiX4f7X3Zear9X21iJ0z5
	 U3Sx1H8YBD9gvmPpyse21kuuSqg7zh3cD8ZD6ap1WIKdK3/lm1ygtXK1POVLOpnZ30
	 uYFoy4Jswp+/g==
Date: Sat, 30 Dec 2023 17:41:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix modification of direct_function hash while
 in use
Message-Id: <20231230174131.fe6dc271f126d0e17662514c@kernel.org>
In-Reply-To: <20231229115134.08dd5174@gandalf.local.home>
References: <20231229115134.08dd5174@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Dec 2023 11:51:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

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

Oops, I also misunderstood.

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

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

