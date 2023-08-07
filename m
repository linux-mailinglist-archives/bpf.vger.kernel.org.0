Return-Path: <bpf+bounces-7159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F177724AC
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442DE1C20BFC
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22906100BD;
	Mon,  7 Aug 2023 12:48:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F84D52D
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:48:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F6F1710
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691412489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjoSbRnkSsuUPp813IqZ0sdieUeAOWa7rz+23O3Cf54=;
	b=Wiqcx88ChHo7J4bUjI1KurI7EpZE519e9RTDhyPUDvN1uachUjILMYIV5yZ6CnuYn41azq
	qH8/n8eZBZt9kMpq9mWGExF0zBpKkB7QrGXDKcQaiR6wrTdQTqs0t4ApI+ha6m2FH9O0uB
	UOIzsxJ7S1wCXR9BdlInt/MFF152FGo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-T4vaqLrzMIGHKXQYyX4IAQ-1; Mon, 07 Aug 2023 08:48:08 -0400
X-MC-Unique: T4vaqLrzMIGHKXQYyX4IAQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99beea69484so342489266b.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 05:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412487; x=1692017287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjoSbRnkSsuUPp813IqZ0sdieUeAOWa7rz+23O3Cf54=;
        b=TvCBvrfP0Dnogjgr4c6d4wgzR0AstcNWx7i7lYpc4SMXGc4fWBZYlnV3XtkgMhYpUK
         zET8Yh+Q6Sj2R/WBF7FxTsukYmkzhRWPmaV43ob3wNIOLioxjLK2kHPIuSERCLoYm3DH
         pB2MKArN7nrzfg3bxosgLgnUATq9xGVXMCv7UBx+B8KDpD0ZaAA1wZX8CKWM4t1l+o+I
         3NbTzezsLlIz4w2lKeImTVKJ2AooDOxcfTDbm7tS1NdqDg3GdbkkrvZJboTDOMI/I97E
         3DJxpygx6FDexyglmSCRCCmYCr6QI5yIogdXX9N7dy2cmVTb+BX6SOdnb20EEp6RNJ/Z
         wA9A==
X-Gm-Message-State: AOJu0YwKqlvgBGcNhO/jq0zMWEKbclF/AmE2NbMfa3pNnbd1Rwy9GTCb
	4NW4oQn8/rPQ8G3IuSXUZ9XfjF9Xc23tfblth1bACSUI9Laggeu+MrfI0jFp/fqDptjwWfEm4Zv
	0tfsJCFTA3P4=
X-Received: by 2002:a17:906:3193:b0:99b:c2b2:e4ac with SMTP id 19-20020a170906319300b0099bc2b2e4acmr8394225ejy.33.1691412487231;
        Mon, 07 Aug 2023 05:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1tz/HdXJNpFyLmSe+zR26RCG4bw40fBwOQOk82GKOr5dtnLYieMQHi2NRK9HIwXdEJO+DWg==
X-Received: by 2002:a17:906:3193:b0:99b:c2b2:e4ac with SMTP id 19-20020a170906319300b0099bc2b2e4acmr8394205ejy.33.1691412486849;
        Mon, 07 Aug 2023 05:48:06 -0700 (PDT)
Received: from [192.168.0.159] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170906a0ca00b0099bd86f9248sm5134987ejb.63.2023.08.07.05.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 05:48:06 -0700 (PDT)
Message-ID: <64b718ef-8c90-b750-238d-4b3da3d928ae@redhat.com>
Date: Mon, 7 Aug 2023 14:48:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv3 bpf-next 1/3] bpf: Add support for bpf_get_func_ip
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
References: <20230807085956.2344866-1-jolsa@kernel.org>
 <20230807085956.2344866-2-jolsa@kernel.org>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <20230807085956.2344866-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/7/23 10:59, Jiri Olsa wrote:
> Adding support for bpf_get_func_ip helper for uprobe program to return
> probed address for both uprobe and return uprobe.

Works nicely with bpftrace (after small tweaks to the tool).

    # cat test.c
    #include <unistd.h>
    int fun2() { return 42; }
    int fun1() { return fun2(); }
    int main() { fun1(); usleep(1000000); }

    # cat uprobe.bt
    uprobe:./test:fun* { printf("-> %s\n", func) }
    uretprobe:./test:fun* { printf("<- %s\n", func) }

Before ('func' was obtained from IP):

    # bpftrace uprobe.bt -c ./test
    -> fun1
    -> fun2
    <- fun1
    <- main

After ('func' is obtained from the bpf_get_func_ip helper):

    # bpftrace uprobe.bt -c ./test
    -> fun1
    -> fun2
    <- fun2
    <- fun1

Tested-by: Viktor Malik <vmalik@redhat.com>

> We discussed this in [1] and agreed that uprobe can have special use
> of bpf_get_func_ip helper that differs from kprobe.
> 
> The kprobe bpf_get_func_ip returns:
>   - address of the function if probe is attach on function entry
>     for both kprobe and return kprobe
>   - 0 if the probe is not attach on function entry
> 
> The uprobe bpf_get_func_ip returns:
>   - address of the probe for both uprobe and return uprobe
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
>  include/linux/bpf.h            |  9 +++++++--
>  include/uapi/linux/bpf.h       |  7 ++++++-
>  kernel/trace/bpf_trace.c       | 11 ++++++++++-
>  kernel/trace/trace_probe.h     |  5 +++++
>  kernel/trace/trace_uprobe.c    |  7 +------
>  tools/include/uapi/linux/bpf.h |  7 ++++++-
>  6 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index abe75063630b..db3fe5a61b05 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1819,6 +1819,7 @@ struct bpf_cg_run_ctx {
>  struct bpf_trace_run_ctx {
>  	struct bpf_run_ctx run_ctx;
>  	u64 bpf_cookie;
> +	bool is_uprobe;
>  };
>  
>  struct bpf_tramp_run_ctx {
> @@ -1867,6 +1868,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>  	if (unlikely(!array))
>  		return ret;
>  
> +	run_ctx.is_uprobe = false;
> +
>  	migrate_disable();
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  	item = &array->items[0];
> @@ -1891,8 +1894,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>   * rcu-protected dynamically sized maps.
>   */
>  static __always_inline u32
> -bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
> -			     const void *ctx, bpf_prog_run_fn run_prog)
> +bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
> +			  const void *ctx, bpf_prog_run_fn run_prog)
>  {
>  	const struct bpf_prog_array_item *item;
>  	const struct bpf_prog *prog;
> @@ -1906,6 +1909,8 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
>  	rcu_read_lock_trace();
>  	migrate_disable();
>  
> +	run_ctx.is_uprobe = true;
> +
>  	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
>  	if (unlikely(!array))
>  		goto out;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>   * u64 bpf_get_func_ip(void *ctx)
>   * 	Description
>   * 		Get address of the traced function (for tracing and kprobe programs).
> + *
> + * 		When called for kprobe program attached as uprobe it returns
> + * 		probe address for both entry and return uprobe.
> + *
>   * 	Return
> - * 		Address of the traced function.
> + * 		Address of the traced function for kprobe.
>   * 		0 for kprobes placed within the function (not at the entry).
> + * 		Address of the probe for uprobe and return uprobe.
>   *
>   * u64 bpf_get_attach_cookie(void *ctx)
>   * 	Description
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d6296d51a826..792445e1f3f0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1055,7 +1055,16 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
>  
>  BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>  {
> -	struct kprobe *kp = kprobe_running();
> +	struct bpf_trace_run_ctx *run_ctx __maybe_unused;
> +	struct kprobe *kp;
> +
> +#ifdef CONFIG_UPROBES
> +	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> +	if (run_ctx->is_uprobe)
> +		return ((struct uprobe_dispatch_data *)current->utask->vaddr)->bp_addr;
> +#endif
> +
> +	kp = kprobe_running();
>  
>  	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
>  		return 0;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 01ea148723de..7dde806be91e 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
>  
>  #define trace_probe_log_err(offs, err)	\
>  	__trace_probe_log_err(offs, TP_ERR_##err)
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
>  static int register_uprobe_event(struct trace_uprobe *tu);
>  static int unregister_uprobe_event(struct trace_uprobe *tu);
>  
> -struct uprobe_dispatch_data {
> -	struct trace_uprobe	*tu;
> -	unsigned long		bp_addr;
> -};
> -
>  static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
>  				unsigned long func, struct pt_regs *regs);
> @@ -1352,7 +1347,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	if (bpf_prog_array_valid(call)) {
>  		u32 ret;
>  
> -		ret = bpf_prog_run_array_sleepable(call->prog_array, regs, bpf_prog_run);
> +		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
>  		if (!ret)
>  			return;
>  	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>   * u64 bpf_get_func_ip(void *ctx)
>   * 	Description
>   * 		Get address of the traced function (for tracing and kprobe programs).
> + *
> + * 		When called for kprobe program attached as uprobe it returns
> + * 		probe address for both entry and return uprobe.
> + *
>   * 	Return
> - * 		Address of the traced function.
> + * 		Address of the traced function for kprobe.
>   * 		0 for kprobes placed within the function (not at the entry).
> + * 		Address of the probe for uprobe and return uprobe.
>   *
>   * u64 bpf_get_attach_cookie(void *ctx)
>   * 	Description


