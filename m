Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667A333A847
	for <lists+bpf@lfdr.de>; Sun, 14 Mar 2021 22:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhCNVjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Mar 2021 17:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhCNVil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Mar 2021 17:38:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB5664E67;
        Sun, 14 Mar 2021 21:38:40 +0000 (UTC)
Date:   Sun, 14 Mar 2021 17:38:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] ftrace: Fix modify_ftrace_direct.
Message-ID: <20210314173838.15c94fb3@gandalf.local.home>
In-Reply-To: <20210312224237.75061-1-alexei.starovoitov@gmail.com>
References: <20210312224237.75061-1-alexei.starovoitov@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 12 Mar 2021 14:42:37 -0800
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
> 
> I was fixing bpf trampoline and realized that modify_ftrace_direct() was
> broken from the beginning. bpf trampoline was lucky that it was
> reusing the same page and the final unregister_ftrace_direct() always
> happened with original addr.
> Pls ack if the fix looks good to you.
> I'd like to cary this patch through bpf tree with the other fixes
> I'm working on.
> 
> Thanks!
> 
>  kernel/trace/ftrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4d8e35575549..510e1c1050a1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5329,6 +5329,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>  int modify_ftrace_direct(unsigned long ip,
>  			 unsigned long old_addr, unsigned long new_addr)
>  {
> +	struct ftrace_direct_func *direct;
>  	struct ftrace_func_entry *entry;
>  	struct dyn_ftrace *rec;
>  	int ret = -ENODEV;
> @@ -5344,6 +5345,11 @@ int modify_ftrace_direct(unsigned long ip,
>  	if (entry->direct != old_addr)
>  		goto out_unlock;
>  
> +	direct = ftrace_find_direct_func(old_addr);
> +	if (WARN_ON(!direct))
> +		goto out_unlock;
> +	direct->addr = new_addr;
> +

I think this needs a bit more, as a ftrace_direct_func could be called by
more than one function, which is why the ftrace_direct_func has a ref
count. You'll need something like:

	if (direct->count > 1) {
		ret = -ENOMEM;
		new_direct = kmalloc(sizeof(*direct), GFP_KERNEL);
		if (!new_direct)
			goto out_unlock;
		direct->count--;
		new_direct->count = 1;
		list_add_rcu(&new_direct->next, &ftrace_direct_funcs);
		ftrace_direct_func_count++;
		direct = new_direct;
	}
	direct->addr = new_addr;

A helper function should probably be made to add a new direct instead of
just copying the code, but you get the idea.

-- Steve

>  	/*
>  	 * If there's no other ftrace callback on the rec->ip location,
>  	 * then it can be changed directly by the architecture.

