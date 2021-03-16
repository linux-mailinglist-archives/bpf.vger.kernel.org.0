Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB233DE0C
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 20:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhCPTqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 15:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240665AbhCPTqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 15:46:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0899364F52;
        Tue, 16 Mar 2021 19:45:58 +0000 (UTC)
Date:   Tue, 16 Mar 2021 15:45:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf] ftrace: Fix modify_ftrace_direct.
Message-ID: <20210316154557.0c513225@gandalf.local.home>
In-Reply-To: <20210316191046.28002-1-alexei.starovoitov@gmail.com>
References: <20210316191046.28002-1-alexei.starovoitov@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Mar 2021 12:10:46 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> From: Alexei Starovoitov <ast@kernel.org>
> 
> The following sequence of commands:
>   register_ftrace_direct(ip, addr1);
>   modify_ftrace_direct(ip, addr1, addr2);
>   unregister_ftrace_direct(ip, addr2);
> will cause the kernel to warn:
> [   30.179191] WARNING: CPU: 2 PID: 1961 at kernel/trace/ftrace.c:5223 unregister_ftrace_direct+0x130/0x150
> [   30.180556] CPU: 2 PID: 1961 Comm: test_progs    W  O      5.12.0-rc2-00378-g86bc10a0a711-dirty #3246
> [   30.182453] RIP: 0010:unregister_ftrace_direct+0x130/0x150
> 
> When modify_ftrace_direct() changes the addr from old to new it should update
> the addr stored in ftrace_direct_funcs. Otherwise the final
> unregister_ftrace_direct() won't find the address and will cause the splat.
> 
> Fixes: 0567d6809182 ("ftrace: Add modify_ftrace_direct()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
> Steven,
> I think I've changed it the way you requested. Please ack if so.

The changes look fine, but I just found another issue that needs to be
handled as well.


> @@ -5329,6 +5339,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>  int modify_ftrace_direct(unsigned long ip,
>  			 unsigned long old_addr, unsigned long new_addr)
>  {
> +	struct ftrace_direct_func *direct, *new_direct;
>  	struct ftrace_func_entry *entry;
>  	struct dyn_ftrace *rec;
>  	int ret = -ENODEV;
> @@ -5344,6 +5355,20 @@ int modify_ftrace_direct(unsigned long ip,
>  	if (entry->direct != old_addr)
>  		goto out_unlock;
>  
> +	direct = ftrace_find_direct_func(old_addr);
> +	if (WARN_ON(!direct))
> +		goto out_unlock;
> +	if (direct->count > 1) {
> +		ret = -ENOMEM;
> +		new_direct = ftrace_alloc_direct_func(new_addr);
> +		if (!new_direct)
> +			goto out_unlock;
> +		direct->count--;
> +		new_direct->count++;
> +	} else {
> +		direct->addr = new_addr;
> +	}
> +
>  	/*
>  	 * If there's no other ftrace callback on the rec->ip location,
>  	 * then it can be changed directly by the architecture.

Everything looks good above, but then looking below this code we have:

	if (ftrace_rec_count(rec) == 1) {
		ret = ftrace_modify_direct_caller(entry, rec, old_addr, new_addr);
	} else {
		entry->direct = new_addr;
		ret = 0;
	}

Where if ftrace_modify_direct_caller() fails, you need to put back the
direct descriptors to where they were.

	struct ftrace_direct_func *new_direct = NULL;

	[..]

	if (unlikely(ret && new_direct)) {
		direct->count++;
		list_del_rcu(&new_direct->next);
		synchronize_rcu_tasks();
		kfree(new_direct);
	}
			
The above is highly unlikely to happen, but it could.

-- Steve
