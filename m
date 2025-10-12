Return-Path: <bpf+bounces-70788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1538BCFF54
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 06:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5C11893FC4
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 04:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33521F152D;
	Sun, 12 Oct 2025 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewb1yZ9f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817413635C;
	Sun, 12 Oct 2025 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760242037; cv=none; b=YwZsRBRdo6kuXRLKMkZBOdNBFPEIVsukxGBUOXjHr538SWWsP+heQd/zDEN43do4CjCMwvuB1PDQ0x/GF0yPHW1mfXCITxI2l+vbFs2w5ybb3/7zmIsZscXQWWC9B6ONn2x9QB8DmQxb4EN/iMIC66u4gD02nc7+5I36rS1bGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760242037; c=relaxed/simple;
	bh=/UMxQdx/gWs1AItzfIRruowFpZD/XTJl3spYEPThPc4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OlZylbSf/unf8wk1+L85Yv3ZCXbeCZTjYqsRNWqJngbiQl30IK1wjHagVVgvkVb4wfIf7I4VkI7TmDp7R8goMBf8xJcvDOjebdaZ6i5EfYSpBosq+S90bZvpzH8TI2hrfTvbdTiVNGeylFnCA9jrn1w+eXzvkcvKR4ENaSmmWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewb1yZ9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F5DC4CEE7;
	Sun, 12 Oct 2025 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760242035;
	bh=/UMxQdx/gWs1AItzfIRruowFpZD/XTJl3spYEPThPc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewb1yZ9fXQjGRG6PhrNskTFHNZDTSg50OclEHFs4xR94Jd5r+6xgu4iTZ6l54GUqa
	 hWiiZ2CUF3G7jeR2arVYjcf0LJwhN6j5dZXboy+msj7tSx/6h05LsvbF+MSxznQX2z
	 mDi7LRRaCIx6P5+Ha1bYJpc6CsfFkqaPmUHvXHDx1d1LVbCvmH2YZTrNgdk6hAH9HU
	 3a2mX/vtZH9pqkGZRXryd1m5/xroIZmvqFyY0MBM1PPAZSnOkU+YcQL8qCcwTOMN30
	 PbUrYuouxykZ51SE4J8nBdAPwkPchy4pH0w42x4ONa6btJAkhOn/jKSoE/lrQSzq7e
	 eSoTVR+zacN+w==
Date: Sun, 12 Oct 2025 13:07:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fprobe: optimization for entry only
 case
Message-Id: <20251012130711.0ea063ac467cb5833a81bd54@kernel.org>
In-Reply-To: <20251010033847.31008-2-dongml2@chinatelecom.cn>
References: <20251010033847.31008-1-dongml2@chinatelecom.cn>
	<20251010033847.31008-2-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Menglong,

On Fri, 10 Oct 2025 11:38:46 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, fgraph is used for the fprobe, even if we need trace the entry
> only. However, the performance of ftrace is better than fgraph, and we
> can use ftrace_ops for this case.
> 
> Then performance of kprobe-multi increases from 54M to 69M. Before this
> commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   54.663 ± 0.493M/s
> 
> After this commit:
> 
>   $ ./benchs/run_bench_trigger.sh kprobe-multi
>   kprobe-multi   :   69.447 ± 0.143M/s
> 
> Mitigation is disable during the bench testing above.
> 

Thanks for updating!

This looks good to me. Just a nit comment below;

[...]
> @@ -379,11 +380,82 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
>  NOKPROBE_SYMBOL(fprobe_return);
>  
>  static struct fgraph_ops fprobe_graph_ops = {
> -	.entryfunc	= fprobe_entry,
> +	.entryfunc	= fprobe_fgraph_entry,
>  	.retfunc	= fprobe_return,
>  };
>  static int fprobe_graph_active;
>  
> +/* ftrace_ops callback, this processes fprobes which have only entry_handler. */
> +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
> +	struct fprobe *fp;
> +	int bit;
> +
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0)
> +		return;
> +

nit: We'd better to explain why we need this here too;

	/*
	 * ftrace_test_recursion_trylock() disables preemption, but
	 * rhltable_lookup() checks whether rcu_read_lcok is held.
	 * So we take rcu_read_lock() here.
	 */

> +	rcu_read_lock();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> +
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> +		if (node->addr != ip)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
> +			continue;
> +
> +		if (fprobe_shared_with_kprobes(fp))
> +			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
> +		else
> +			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
> +	}
> +	rcu_read_unlock();
> +	ftrace_test_recursion_unlock(bit);
> +}
> +NOKPROBE_SYMBOL(fprobe_ftrace_entry);

Thank you,

> +
> +static struct ftrace_ops fprobe_ftrace_ops = {
> +	.func	= fprobe_ftrace_entry,
> +	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> +};
> +static int fprobe_ftrace_active;
> +
> +static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&fprobe_mutex);
> +
> +	ret = ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (!fprobe_ftrace_active) {
> +		ret = register_ftrace_function(&fprobe_ftrace_ops);
> +		if (ret) {
> +			ftrace_free_filter(&fprobe_ftrace_ops);
> +			return ret;
> +		}
> +	}
> +	fprobe_ftrace_active++;
> +	return 0;
> +}
> +
> +static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
> +{
> +	lockdep_assert_held(&fprobe_mutex);
> +
> +	fprobe_ftrace_active--;
> +	if (!fprobe_ftrace_active)
> +		unregister_ftrace_function(&fprobe_ftrace_ops);
> +	if (num)
> +		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
> +}
> +
>  /* Add @addrs to the ftrace filter and register fgraph if needed. */
>  static int fprobe_graph_add_ips(unsigned long *addrs, int num)
>  {
> @@ -498,9 +570,12 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	} while (node == ERR_PTR(-EAGAIN));
>  	rhashtable_walk_exit(&iter);
>  
> -	if (alist.index > 0)
> +	if (alist.index > 0) {
>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
>  				      alist.addrs, alist.index, 1, 0);
> +		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> +				      alist.addrs, alist.index, 1, 0);
> +	}
>  	mutex_unlock(&fprobe_mutex);
>  
>  	kfree(alist.addrs);
> @@ -733,7 +808,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
>  	mutex_lock(&fprobe_mutex);
>  
>  	hlist_array = fp->hlist_array;
> -	ret = fprobe_graph_add_ips(addrs, num);
> +	if (fp->exit_handler)
> +		ret = fprobe_graph_add_ips(addrs, num);
> +	else
> +		ret = fprobe_ftrace_add_ips(addrs, num);
> +
>  	if (!ret) {
>  		add_fprobe_hash(fp);
>  		for (i = 0; i < hlist_array->size; i++) {
> @@ -829,7 +908,10 @@ int unregister_fprobe(struct fprobe *fp)
>  	}
>  	del_fprobe_hash(fp);
>  
> -	fprobe_graph_remove_ips(addrs, count);
> +	if (fp->exit_handler)
> +		fprobe_graph_remove_ips(addrs, count);
> +	else
> +		fprobe_ftrace_remove_ips(addrs, count);
>  
>  	kfree_rcu(hlist_array, rcu);
>  	fp->hlist_array = NULL;
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

