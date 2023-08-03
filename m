Return-Path: <bpf+bounces-6877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A599176EEA8
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 17:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A861282235
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D199124164;
	Thu,  3 Aug 2023 15:51:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB223BF3
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 15:51:09 +0000 (UTC)
Received: from out-91.mta0.migadu.com (out-91.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F0DE6B
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 08:51:07 -0700 (PDT)
Message-ID: <6e423425-b079-b0ca-eec3-192447b51a23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691077865; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDGMaNtmSrJg5GAiQBc8Fh8gzblNw5w94JvZfeOzYew=;
	b=EaXlRUBaZ0Job1n7gnNcNlmcv1cGrr73ocmklKc64vYat9v3lNpX1tHxxtuz3TA42p0Ob6
	vGCiiCYIm6tl/kgKF5j1mvBhj1HysJNui5rpSklqbegls523ZU0TIozwCQy5Bx6ipOA/H+
	yqjrhvb8OxFwP0rfsc9ETP1By7FilCw=
Date: Thu, 3 Aug 2023 08:50:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv2 bpf-next 1/3] bpf: Add support for bpf_get_func_ip
 helper for uprobe program
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20230803095219.1669065-1-jolsa@kernel.org>
 <20230803095219.1669065-2-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230803095219.1669065-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 2:52 AM, Jiri Olsa wrote:
> Adding support for bpf_get_func_ip helper for uprobe program to return
> probed address for both uprobe and return uprobe.
> 
> We discussed this in [1] and agreed that uprobe can have special use
> of bpf_get_func_ip helper that differs from kprobe.
> 
> The kprobe bpf_get_func_ip returns:
>    - address of the function if probe is attach on function entry
>      for both kprobe and return kprobe
>    - 0 if the probe is not attach on function entry
> 
> The uprobe bpf_get_func_ip returns:
>    - address of the probe for both uprobe and return uprobe
> 
> The reason for this semantic change is that kernel can't really tell
> if the probe user space address is function entry.
> 
> The uprobe program is actually kprobe type program attached as uprobe.
> One of the consequences of this design is that uprobes do not have its
> own set of helpers, but share them with kprobes.
> 
> As we need different functionality for bpf_get_func_ip helper for uprobe,
> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
> detect that it's executed in uprobe context and call specific code.
> 
> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable, which
> is currently used only for executing bpf programs in uprobe.
> 
> Renaming bpf_prog_run_array_sleepable to bpf_prog_run_array_uprobe
> to address that it's only used for uprobes and that it sets the
> run_ctx.is_uprobe as suggested by Yafang Shao.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> [1] https://lore.kernel.org/bpf/CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/linux/bpf.h            |  9 +++++++--
>   include/uapi/linux/bpf.h       |  7 ++++++-
>   kernel/trace/bpf_trace.c       | 21 ++++++++++++++++++++-
>   kernel/trace/trace_probe.h     |  5 +++++
>   kernel/trace/trace_uprobe.c    |  7 +------
>   tools/include/uapi/linux/bpf.h |  7 ++++++-
>   6 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index abe75063630b..db3fe5a61b05 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1819,6 +1819,7 @@ struct bpf_cg_run_ctx {
>   struct bpf_trace_run_ctx {
>   	struct bpf_run_ctx run_ctx;
>   	u64 bpf_cookie;
> +	bool is_uprobe;
>   };
>   
>   struct bpf_tramp_run_ctx {
> @@ -1867,6 +1868,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>   	if (unlikely(!array))
>   		return ret;
>   
> +	run_ctx.is_uprobe = false;
> +
>   	migrate_disable();
>   	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>   	item = &array->items[0];
> @@ -1891,8 +1894,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>    * rcu-protected dynamically sized maps.
>    */
>   static __always_inline u32
> -bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
> -			     const void *ctx, bpf_prog_run_fn run_prog)
> +bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
> +			  const void *ctx, bpf_prog_run_fn run_prog)
>   {
>   	const struct bpf_prog_array_item *item;
>   	const struct bpf_prog *prog;
> @@ -1906,6 +1909,8 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
>   	rcu_read_lock_trace();
>   	migrate_disable();
>   
> +	run_ctx.is_uprobe = true;
> +
>   	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
>   	if (unlikely(!array))
>   		goto out;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>    * u64 bpf_get_func_ip(void *ctx)
>    * 	Description
>    * 		Get address of the traced function (for tracing and kprobe programs).
> + *
> + * 		When called for kprobe program attached as uprobe it returns
> + * 		probe address for both entry and return uprobe.
> + *
>    * 	Return
> - * 		Address of the traced function.
> + * 		Address of the traced function for kprobe.
>    * 		0 for kprobes placed within the function (not at the entry).
> + * 		Address of the probe for uprobe and return uprobe.
>    *
>    * u64 bpf_get_attach_cookie(void *ctx)
>    * 	Description
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 83bde2475ae5..d35f9750065a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1046,9 +1046,28 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
>   #define get_entry_ip(fentry_ip) fentry_ip
>   #endif
>   
> +#ifdef CONFIG_UPROBES
> +static unsigned long bpf_get_func_ip_uprobe(struct pt_regs *regs)
> +{
> +	struct uprobe_dispatch_data *udd;
> +
> +	udd = (struct uprobe_dispatch_data *) current->utask->vaddr;
> +	return udd->bp_addr;
> +}
> +#else
> +#define bpf_get_func_ip_uprobe(regs) (u64) -EOPNOTSUPP
> +#endif

If I understand correctly, if below run_ctx->is_uprobe is true,
then bpf_get_func_ip_uprobe() func in the above will be called.
If run_ctx->is_uprobe is false, the above bpf_get_func_ip_uprobe
macro will be not be called. The that macro definition with
-EOPNOTSUPP really does not matter.

To avoid the above confusion, maybe we should put the CONFIG_UPROBES 
inside bpf_get_func_ip_kprobe like below.

> +
>   BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>   {
> -	struct kprobe *kp = kprobe_running();
> +	struct bpf_trace_run_ctx *run_ctx;
> +	struct kprobe *kp;
> +
> +	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> +	if (run_ctx->is_uprobe)
> +		return bpf_get_func_ip_uprobe(regs);
> +
> +	kp = kprobe_running();

...
struct bpf_trace_run_ctx *run_ctx __maybe_unused;
...

#ifdef CONFIG_UPROBES
	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, 
run_ctx);
	if (run_ctx->is_uprobe)
		return ((struct uprobe_dispatch_data *)current->utask->vaddr)->bp_addr;
#endif

What do you think?
	

>   
>   	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
>   		return 0;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 01ea148723de..7dde806be91e 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
>   
>   #define trace_probe_log_err(offs, err)	\
>   	__trace_probe_log_err(offs, TP_ERR_##err)
> +
> +struct uprobe_dispatch_data {
> +	struct trace_uprobe	*tu;
> +	unsigned long		bp_addr;
> +};
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 555c223c3232..576b3bcb8ebd 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -88,11 +88,6 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
>   static int register_uprobe_event(struct trace_uprobe *tu);
>   static int unregister_uprobe_event(struct trace_uprobe *tu);
>   
> -struct uprobe_dispatch_data {
> -	struct trace_uprobe	*tu;
> -	unsigned long		bp_addr;
> -};
> -
>   static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
>   static int uretprobe_dispatcher(struct uprobe_consumer *con,
>   				unsigned long func, struct pt_regs *regs);
> @@ -1352,7 +1347,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>   	if (bpf_prog_array_valid(call)) {
>   		u32 ret;
>   
> -		ret = bpf_prog_run_array_sleepable(call->prog_array, regs, bpf_prog_run);
> +		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
>   		if (!ret)
>   			return;
>   	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>    * u64 bpf_get_func_ip(void *ctx)
>    * 	Description
>    * 		Get address of the traced function (for tracing and kprobe programs).
> + *
> + * 		When called for kprobe program attached as uprobe it returns
> + * 		probe address for both entry and return uprobe.
> + *
>    * 	Return
> - * 		Address of the traced function.
> + * 		Address of the traced function for kprobe.
>    * 		0 for kprobes placed within the function (not at the entry).
> + * 		Address of the probe for uprobe and return uprobe.
>    *
>    * u64 bpf_get_attach_cookie(void *ctx)
>    * 	Description

