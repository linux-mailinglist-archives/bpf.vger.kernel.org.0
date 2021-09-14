Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C140BA59
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhINVhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232047AbhINVhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B916113B;
        Tue, 14 Sep 2021 21:36:02 +0000 (UTC)
Date:   Tue, 14 Sep 2021 17:35:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 6/8] ftrace: Add multi direct register/unregister
 interface
Message-ID: <20210914173555.056cd20c@oasis.local.home>
In-Reply-To: <20210831095017.412311-7-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
        <20210831095017.412311-7-jolsa@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 31 Aug 2021 11:50:15 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> Adding interface to register multiple direct functions
> within single call. Adding following functions:
> 
>   register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>   unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> 
> The register_ftrace_direct_multi registers direct function (addr)
> with all functions in ops filter. The ops filter can be updated
> before with ftrace_set_filter_ip calls.
> 
> All requested functions must not have direct function currently
> registered, otherwise register_ftrace_direct_multi will fail.
> 
> The unregister_ftrace_direct_multi unregisters ops related direct
> functions.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h |  11 ++++
>  kernel/trace/ftrace.c  | 111 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index d399621a67ee..e40b5201c16e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -316,7 +316,10 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>  				unsigned long old_addr,
>  				unsigned long new_addr);
>  unsigned long ftrace_find_rec_direct(unsigned long ip);
> +int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> +int unregister_ftrace_direct_multi(struct ftrace_ops *ops);
>  #else
> +struct ftrace_ops;
>  # define ftrace_direct_func_count 0
>  static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
>  {
> @@ -346,6 +349,14 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
>  {
>  	return 0;
>  }
> +static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +{
> +	return -ENODEV;
> +}
> +static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c60217d81040..7243769493c9 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5407,6 +5407,117 @@ int modify_ftrace_direct(unsigned long ip,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> +
> +#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
> +		     FTRACE_OPS_FL_SAVE_REGS)
> +
> +static int check_direct_multi(struct ftrace_ops *ops)
> +{
> +	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> +		return -EINVAL;
> +	if ((ops->flags & MULTI_FLAGS) != MULTI_FLAGS)
> +		return -EINVAL;
> +	return 0;
> +}
> +

Needs kernel doc comments as this is an interface outside this file.

> +int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +{
> +	struct ftrace_hash *hash, *free_hash = NULL;
> +	struct ftrace_func_entry *entry, *new;
> +	int err = -EBUSY, size, i;
> +
> +	if (ops->func || ops->trampoline)
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
> +		return -EINVAL;
> +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> +		return -EINVAL;
> +
> +	hash = ops->func_hash->filter_hash;
> +	if (ftrace_hash_empty(hash))
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +
> +	/* Make sure requested entries are not already registered.. */
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			if (ftrace_find_rec_direct(entry->ip))
> +				goto out_unlock;
> +		}
> +	}
> +
> +	/* ... and insert them to direct_functions hash. */
> +	err = -ENOMEM;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
> +			if (!new)
> +				goto out_remove;
> +			entry->direct = addr;
> +		}
> +	}
> +
> +	ops->func = call_direct_funcs;
> +	ops->flags = MULTI_FLAGS;
> +	ops->trampoline = FTRACE_REGS_ADDR;
> +
> +	err = register_ftrace_function(ops);
> +
> + out_remove:
> +	if (err) {

The below code:

> +		for (i = 0; i < size; i++) {
> +			hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +				new = __ftrace_lookup_ip(direct_functions, entry->ip);
> +				if (new) {
> +					remove_hash_entry(direct_functions, new);
> +					kfree(new);
> +				}
> +			}
> +		}

is identical to code below.

> +	}
> +
> + out_unlock:
> +	mutex_unlock(&direct_mutex);
> +
> +	if (free_hash) {
> +		synchronize_rcu_tasks();
> +		free_ftrace_hash(free_hash);
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
> +

Should have kernel doc as well.

> +int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
> +{
> +	struct ftrace_hash *hash = ops->func_hash->filter_hash;
> +	struct ftrace_func_entry *entry, *new;
> +	int err, size, i;
> +
> +	if (check_direct_multi(ops))
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +	err = unregister_ftrace_function(ops);
> +
> +	size = 1 << hash->size_bits;


> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			new = __ftrace_lookup_ip(direct_functions, entry->ip);
> +			if (new) {
> +				remove_hash_entry(direct_functions, new);
> +				kfree(new);
> +			}
> +		}
> +	}

Would probably make sense to turn this into a static inline helper.

-- Steve


> +
> +	mutex_unlock(&direct_mutex);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**

