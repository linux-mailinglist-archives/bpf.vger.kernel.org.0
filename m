Return-Path: <bpf+bounces-69495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BBB97DCA
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 02:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527EB19C702E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332C13BC0C;
	Wed, 24 Sep 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSRexJtq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF723AD;
	Wed, 24 Sep 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673398; cv=none; b=cpWNMm/alYsO34/7Hu2eR7kre/24PdNWrbIzRuHlCmzeCoLMNY/0cDE7HAjmjVdPKr4ei+2q6QgH+mi2k73FOf9B8Qjy+Ro2uNSetuV1x8Z9DwARkJ2JE8W7q/UTimJg3sIgggFArbr7PYhK0Pwa+Ko9Rr5RdU6EWSvFAf8/hPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673398; c=relaxed/simple;
	bh=38LZ1R2ABGcM6BK150Wvx2Xd3Cpx9dDHz21DTbNfTOI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pHp79D8AO7k4Sc89QLApBepvPRNyltqvNyE1RMxzihqSehKeFrj52eSWlYwzz+llqcnuDv8Gat2qdq7vEdSUHrY7dUBlisniEaYxNZ1kszPOHnSPWOX7jTJiyZESQ9WrmyKW5nmVSHsAHDo+9vbB9Gl1oItkxLEgzOh1Qv50jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSRexJtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89569C4CEF5;
	Wed, 24 Sep 2025 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673397;
	bh=38LZ1R2ABGcM6BK150Wvx2Xd3Cpx9dDHz21DTbNfTOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CSRexJtq8izR0OBD57fVeuOIWSiGjTVt1IZzrQ2azvDwZLTKNmGXaZT4PaZRR1MT4
	 xtOxrpRnu1eDTXeZ7fMJyNwVrMwwxwSE2XrPfRpKZSfBbYm/XZC4g+qOs0kaKT0MxJ
	 FdUXlcI9nZi/RfFNoPWfQdmuFAE9WT/eU3pJgiXH9adK23ViB3Anwp0N5Q10V8L/4N
	 3lmT82byl7JrxwFP7l9yV2FXb9km1o3zv0r4QXQZ8nd/yykJR2qN91OumKki9WLOkW
	 jhme+pI/LTAWsrzYzRkOyuN2xE1ALfb48YKCadsSiWY0VSnniOGwvjO4PyTlea/pyd
	 gzzzlR5YXwSPA==
Date: Wed, 24 Sep 2025 09:23:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Message-Id: <20250924092314.4b790ff9fbdb7693717669c2@kernel.org>
In-Reply-To: <20250923092001.1087678-2-dongml2@chinatelecom.cn>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
	<20250923092001.1087678-2-dongml2@chinatelecom.cn>
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

Please add a cover letter if you make a series of patches.

On Tue, 23 Sep 2025 17:20:01 +0800
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

Hmm, indeed. If it is used only for entry, it can use ftrace.

Also, please merge [1/2] and [2/2]. [1/2] is meaningless (and do
nothing) without this change. Moreover, it changes the same file.

You can split the patch if "that cleanup is meaningful independently"
or "that changes different subsystem/component (thus you need an Ack
from another maintainer)".

But basically looks good to me. Just have some nits.

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 1785fba367c9..de4ae075548d 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  				if (node->addr != func)
>  					continue;
>  				fp = READ_ONCE(node->fp);
> -				if (fp && !fprobe_disabled(fp))
> +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
>  					fp->nmissed++;
>  			}
>  			return 0;
> @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  		if (node->addr != func)
>  			continue;
>  		fp = READ_ONCE(node->fp);
> -		if (!fp || fprobe_disabled(fp))
> +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
>  			continue;
>  
>  		data_size = fp->entry_data_size;
> -		if (data_size && fp->exit_handler)
> +		if (data_size)
>  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
>  		else
>  			data = NULL;
> @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
>  			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
>  
>  		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> -		if (!ret && fp->exit_handler) {
> +		if (!ret) {
>  			int size_words = SIZE_IN_LONG(data_size);
>  
>  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
>  };
>  static int fprobe_graph_active;
>  

> +/* ftrace_ops backend (entry-only) */
                 ^ callback ?

Also, add similar comments on top of fprobe_fgraph_entry. 

/* fgraph_ops callback, this processes fprobes which have exit_handler. */

> +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct fprobe_hlist_node *node;
> +	struct rhlist_head *head, *pos;
> +	struct fprobe *fp;
> +
> +	guard(rcu)();
> +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> +
> +	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> +		if (node->addr != ip)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (unlikely(!fp || fprobe_disabled(fp) || fp->exit_handler))
> +			continue;
> +		/* entry-only path: no exit_handler nor per-call data */
> +		if (fprobe_shared_with_kprobes(fp))
> +			__fprobe_kprobe_handler(ip, parent_ip, fp, fregs, NULL);
> +		else
> +			__fprobe_handler(ip, parent_ip, fp, fregs, NULL);
> +	}
> +}
> +NOKPROBE_SYMBOL(fprobe_ftrace_entry);

OK.

> +
> +static struct ftrace_ops fprobe_ftrace_ops = {
> +	.func	= fprobe_ftrace_entry,
> +	.flags	= FTRACE_OPS_FL_SAVE_REGS,

[OT] I just wonder we can have FTRACE_OPS_FL_SAVE_FTRACE_REGS instead.

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
> @@ -500,9 +564,12 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	} while (node == ERR_PTR(-EAGAIN));
>  	rhashtable_walk_exit(&iter);
>  
> -	if (alist.index < alist.size && alist.index > 0)
> +	if (alist.index < alist.size && alist.index > 0) {

Oops, here is my bug. Let me fix it.

Thank you,

>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
>  				      alist.addrs, alist.index, 1, 0);
> +		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> +				      alist.addrs, alist.index, 1, 0);
> +	}
>  	mutex_unlock(&fprobe_mutex);
>  
>  	kfree(alist.addrs);
> @@ -735,7 +802,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
> @@ -831,7 +902,10 @@ int unregister_fprobe(struct fprobe *fp)
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

