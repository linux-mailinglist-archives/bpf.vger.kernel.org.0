Return-Path: <bpf+bounces-7198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A55F7732D1
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 00:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40AB1C20B17
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7917AA7;
	Mon,  7 Aug 2023 22:09:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1617736
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 22:09:39 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB7448C;
	Mon,  7 Aug 2023 15:09:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so6641472a12.2;
        Mon, 07 Aug 2023 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691446094; x=1692050894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6+h3JPtffH3KCnU+FPVbWvNYGtSA/UOocgPTJJmPrM=;
        b=dhwsK4bB5MaJTm9+mzIvA5OXXQvBIIJkM3LHvM0/KCirJESPqHr/1ROandY8hhMcF1
         Ypy8TqMIwmFozUDcajbUy72oPZj2xQxT+0oJ8sz02MO9GCY+MyJ70npaJmzZK+24sBFH
         OBDsvT0M/XL5XYy9mQV5wowXxgCvtqK+Wq7TSdrX3/d5hjMj8LiDD/yY1PtpBbgAGzJz
         X+fmNKB+as6A60nEV0fRcHN4yM/RDpgZANcjIrRq1qxlo3TvobWe5w6o4mPncr93v6nh
         mzCEzEJuHBg8G+09kfF8qQI59MEuXUWjhguHVj0KzUCxFHXOlExxnb3wVqBndwc4ir7z
         Q/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691446094; x=1692050894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6+h3JPtffH3KCnU+FPVbWvNYGtSA/UOocgPTJJmPrM=;
        b=Q96FQii6I8/rbMQWhCcppCpDv6ZsSYSr0XzQCeaG25vj9Z59qtk637BEfrCahrArHv
         Whx0gUGGQ2V9ZKrAVh+qqSzwJMr8LcjzbB884Rs54WLPVYY+ZVfDfE42dUaJP85Vro5L
         N8sN/xcVdshSwuNVj0SI8PuQvxpuyoYzpTdCBTU5FRV0PIAeWxbjNqT47PLUWDoA+dG6
         TbHqzQ4JQajnSHKVjEJczAKZOkOcx2jw/kDar2itm1yzcpT22Ks+98d5JwUunYYjieiH
         kKcz6bKXs5AgxmYwRGH7iT1XO1LH7TdGqjVrxF5gng+3WtOn/9axAFrzB2t5TnEXdhfG
         zQRA==
X-Gm-Message-State: AOJu0Yx86rLPgd8Afs2wtJXHY65cMN96y0VeftIqLx+BlbqcbxRv+rX7
	1Q0k43g+ajAhNcLYTHfixmk=
X-Google-Smtp-Source: AGHT+IHcFeSC/KLA5gbHHDoZ38Wjuek7W2QjlW9lOhBV5LyfzbSNg41cd2VqVgu1h/MLxxqARpsyCQ==
X-Received: by 2002:a05:6402:110a:b0:523:7b1:3718 with SMTP id u10-20020a056402110a00b0052307b13718mr7820189edv.14.1691446093469;
        Mon, 07 Aug 2023 15:08:13 -0700 (PDT)
Received: from krava ([83.240.60.134])
        by smtp.gmail.com with ESMTPSA id d13-20020a50fe8d000000b0051e1660a34esm5637299edt.51.2023.08.07.15.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 15:08:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Aug 2023 00:08:11 +0200
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 6/6] bpf: Enable kprobe_multi feature if
 CONFIG_FPROBE is enabled
Message-ID: <ZNFrS4YGcW8dyxnF@krava>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
 <169139097360.324433.2521527070503682979.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169139097360.324433.2521527070503682979.stgit@devnote2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 03:49:33PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> may always returns 0. But it should be enough for function entry (access
> arguments) and exit (access return value).
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/bpf_trace.c |   22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 99c5f95360f9..0725272a3de2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2460,7 +2460,7 @@ static int __init bpf_event_init(void)
>  fs_initcall(bpf_event_init);
>  #endif /* CONFIG_MODULES */
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#ifdef CONFIG_FPROBE
>  struct bpf_kprobe_multi_link {
>  	struct bpf_link link;
>  	struct fprobe fp;
> @@ -2482,6 +2482,8 @@ struct user_syms {
>  	char *buf;
>  };
>  
> +static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
> +
>  static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
>  {
>  	unsigned long __user usymbol;
> @@ -2623,13 +2625,14 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
>  
>  static int
>  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> -			   unsigned long entry_ip, struct pt_regs *regs)
> +			   unsigned long entry_ip, struct ftrace_regs *fregs)
>  {
>  	struct bpf_kprobe_multi_run_ctx run_ctx = {
>  		.link = link,
>  		.entry_ip = entry_ip,
>  	};
>  	struct bpf_run_ctx *old_run_ctx;
> +	struct pt_regs *regs;
>  	int err;
>  
>  	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> @@ -2639,6 +2642,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  
>  	migrate_disable();
>  	rcu_read_lock();
> +	regs = ftrace_partial_regs(fregs, this_cpu_ptr(&bpf_kprobe_multi_pt_regs));

you did check for !regs when returned from ftrace_get_regs, why don't we need
to check it in here? both ftrace_partial_regs and ftrace_get_regs call
arch_ftrace_get_regs on x86

also also I can't find the place ensuring fregs->regs.cs != 0 for FL_SAVE_REGS
flag as stated in arch_ftrace_get_regs, any hint?

thanks,
jirka


>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  	err = bpf_prog_run(link->link.prog, regs);
>  	bpf_reset_run_ctx(old_run_ctx);
> @@ -2656,13 +2660,9 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
>  			  void *data)
>  {
>  	struct bpf_kprobe_multi_link *link;
> -	struct pt_regs *regs = ftrace_get_regs(fregs);
> -
> -	if (!regs)
> -		return 0;
>  
>  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> -	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> +	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
>  	return 0;
>  }
>  
> @@ -2672,13 +2672,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
>  			       void *data)
>  {
>  	struct bpf_kprobe_multi_link *link;
> -	struct pt_regs *regs = ftrace_get_regs(fregs);
> -
> -	if (!regs)
> -		return;
>  
>  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> -	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> +	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
>  }
>  
>  static int symbols_cmp_r(const void *a, const void *b, const void *priv)
> @@ -2918,7 +2914,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	kvfree(cookies);
>  	return err;
>  }
> -#else /* !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +#else /* !CONFIG_FPROBE */
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  {
>  	return -EOPNOTSUPP;
> 

