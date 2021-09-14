Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9633B40BA7F
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhINVm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 17:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhINVm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 17:42:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD86F60F46;
        Tue, 14 Sep 2021 21:41:40 +0000 (UTC)
Date:   Tue, 14 Sep 2021 17:41:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <20210914174134.1d8fd944@oasis.local.home>
In-Reply-To: <20210831095017.412311-8-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
        <20210831095017.412311-8-jolsa@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 31 Aug 2021 11:50:16 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> Adding interface to modify registered direct function
> for ftrace_ops. Adding following function:
> 
>    modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> 
> The function changes the currently registered direct
> function for all attached functions.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h |  6 ++++++
>  kernel/trace/ftrace.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e40b5201c16e..f3ba6366f7af 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -318,6 +318,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>  unsigned long ftrace_find_rec_direct(unsigned long ip);
>  int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
>  int unregister_ftrace_direct_multi(struct ftrace_ops *ops);
> +int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
> +
>  #else
>  struct ftrace_ops;
>  # define ftrace_direct_func_count 0
> @@ -357,6 +359,10 @@ static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
>  {
>  	return -ENODEV;
>  }
> +static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7243769493c9..59940a6a907c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5518,6 +5518,49 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
> +

Needs kernel doc comments.

> +int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
> +{
> +	struct ftrace_hash *hash = ops->func_hash->filter_hash;
> +	struct ftrace_func_entry *entry, *iter;
> +	int i, size;
> +	int err;
> +
> +	if (check_direct_multi(ops))
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +	mutex_lock(&ftrace_lock);
> +
> +	/*
> +	 * Shutdown the ops, change 'direct' pointer for each
> +	 * ops entry in direct_functions hash and startup the
> +	 * ops back again.
> +	 */
> +	err = ftrace_shutdown(ops, 0);

This needs to be commented that there's going to be a rather large time
frame that there will be no callbacks happening while this update occurs.

A better solution, that prevents having to do this, is to first change
the function fentry's to call the ftrace list loop function, that calls
the ftrace_ops list, and will call the direct call via the ops in the
loop. Have the ops->func call the new direct function (all will be
immediately affected). Update the entries, and then switch from the
loop back to the direct caller.

-- Steve



> +	if (err)
> +		goto out_unlock;
> +
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
> +			entry = __ftrace_lookup_ip(direct_functions, iter->ip);
> +			if (!entry)
> +				continue;
> +			entry->direct = addr;
> +		}
> +	}
> +
> +	err = ftrace_startup(ops, 0);
> +
> + out_unlock:
> +	mutex_unlock(&ftrace_lock);
> +	mutex_unlock(&direct_mutex);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**

