Return-Path: <bpf+bounces-18284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E26818898
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94BF1F24AC6
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA7199CA;
	Tue, 19 Dec 2023 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM5u7iyT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB891BDE4;
	Tue, 19 Dec 2023 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1fae88e66eso506047066b.3;
        Tue, 19 Dec 2023 05:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702992231; x=1703597031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohwYq5yvCWylGOCoc6Y4haRzMcah4GL3U4oOACkoFzA=;
        b=SM5u7iyTBNgorQl5b5reRwNHUYurdglIVUzCKJE0zHEem/+otcJq5ul9k/soESdCTR
         VOtutIy5a66iETJ2fg1zSjz/ETRUuu8I44OTCuk9yEd3OGNjA/7TQxOCGdyU+aG1C4dT
         FvTfZ60Iz+3LsEOuCXjLkOEECa3ldgC/Ip+w+1pQygdhr6N/jMMlNTO1OvYD7Un9ahrQ
         ZBdCE/PT2aL7vygAvF8DtluHDE3dBrjU3u1Vhp4RKvoX/OvEEQeta1M1y+G9i5uWCATG
         Mj2NINyxUVwREfXpGp9pGmQRxyrpMzFmjQ7SyYSIQ3zz/9hAtfQk6/APd+vhPZ2Li73F
         FKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702992231; x=1703597031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohwYq5yvCWylGOCoc6Y4haRzMcah4GL3U4oOACkoFzA=;
        b=iK45I26RlyHEANcEn+AngsQ4u+lQ03hTSI612w+Hed5Ndto9TPOv8hhpiQQEt7jFQt
         NXboPJ2zdD+rp4RstAXzEuUiHqDwtrTu1ikhmk4x8nA7ybRGOv8uB8PpEm7SB/wj/gsM
         oFQmYa2JTzOHTwDfN+dEC1/CCdySteRkJn/OEORm+srhWmzxDTInltx3AReHyo17OMxz
         eBA+XyOgMn+6+ctLs0J/EVD9mvoYXelJ53DXTRnO6yBgZpUFJLwbw2sHzNNz9fowFAiM
         WHJHcriIL6F72vb+Dx6TPZMNaU7xgd2aPgfpKvhOJsEeGmFwYs+bFCiQXD/N82kNTq1m
         bx1Q==
X-Gm-Message-State: AOJu0Yz6dQIGyEwUHZpq2H0Li6I+dSCrAbbcYMOUgrBiqGRwab0K1o/x
	wSYbigC0t5yL+tuiYLVGq85PRLWtRJp/KA==
X-Google-Smtp-Source: AGHT+IGRuUI5sjGWayqzk1nu+YcOF+NdSZNg0993gxhNqRabSi0YpJqlMgSlxTmgC+d4nSCVRZI+Fw==
X-Received: by 2002:a17:906:21d:b0:a23:59ea:1065 with SMTP id 29-20020a170906021d00b00a2359ea1065mr1815968ejd.55.1702992231231;
        Tue, 19 Dec 2023 05:23:51 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id vt6-20020a170907a60600b00a1ce98016b6sm15544493ejc.97.2023.12.19.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:23:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Dec 2023 14:23:48 +0100
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
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 24/34] fprobe: Use ftrace_regs in fprobe entry handler
Message-ID: <ZYGZZES--JmqQN_v@krava>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290538307.220107.14964448383069008953.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170290538307.220107.14964448383069008953.stgit@devnote2>

On Mon, Dec 18, 2023 at 10:16:23PM +0900, Masami Hiramatsu (Google) wrote:

SNIP

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 84e8a0f6e4e0..d3f8745d8ead 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2503,7 +2503,7 @@ static int __init bpf_event_init(void)
>  fs_initcall(bpf_event_init);
>  #endif /* CONFIG_MODULES */
>  
> -#ifdef CONFIG_FPROBE
> +#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
>  struct bpf_kprobe_multi_link {
>  	struct bpf_link link;
>  	struct fprobe fp;
> @@ -2733,10 +2733,14 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  
>  static int
>  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> -			  unsigned long ret_ip, struct pt_regs *regs,
> +			  unsigned long ret_ip, struct ftrace_regs *fregs,
>  			  void *data)
>  {
>  	struct bpf_kprobe_multi_link *link;
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
> +
> +	if (!regs)
> +		return 0;
>  
>  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
>  	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> @@ -3008,7 +3012,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	kvfree(cookies);
>  	return err;
>  }
> -#else /* !CONFIG_FPROBE */
> +#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 6cd2a4e3afb8..f12569494d8a 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -46,7 +46,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
>  	}
>  
>  	if (fp->entry_handler)
> -		ret = fp->entry_handler(fp, ip, parent_ip, ftrace_get_regs(fregs), entry_data);
> +		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
>  
>  	/* If entry_handler returns !0, nmissed is not counted. */
>  	if (rh) {
> @@ -182,7 +182,7 @@ static void fprobe_init(struct fprobe *fp)
>  		fp->ops.func = fprobe_kprobe_handler;
>  	else
>  		fp->ops.func = fprobe_handler;
> -	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
> +	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;

so with this change you move to ftrace_caller trampoline,
but we need ftrace_regs_caller right?

otherwise the (!regs) check in kprobe_multi_link_handler
will be allways true IIUC

jirka

>  }
>  
>  static int fprobe_init_rethook(struct fprobe *fp, int num)
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 7d2ddbcfa377..ef6b36fd05ae 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -320,12 +320,16 @@ NOKPROBE_SYMBOL(fexit_perf_func);
>  #endif	/* CONFIG_PERF_EVENTS */
>  
>  static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> -			     unsigned long ret_ip, struct pt_regs *regs,
> +			     unsigned long ret_ip, struct ftrace_regs *fregs,
>  			     void *entry_data)
>  {
>  	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
>  	int ret = 0;
>  
> +	if (!regs)
> +		return 0;
> +
>  	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
>  		fentry_trace_func(tf, entry_ip, regs);
>  #ifdef CONFIG_PERF_EVENTS
> diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
> index 24de0e5ff859..ff607babba18 100644
> --- a/lib/test_fprobe.c
> +++ b/lib/test_fprobe.c
> @@ -40,7 +40,7 @@ static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
>  
>  static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
>  				    unsigned long ret_ip,
> -				    struct pt_regs *regs, void *data)
> +				    struct ftrace_regs *fregs, void *data)
>  {
>  	KUNIT_EXPECT_FALSE(current_test, preemptible());
>  	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
> @@ -81,7 +81,7 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
>  
>  static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
>  				      unsigned long ret_ip,
> -				      struct pt_regs *regs, void *data)
> +				      struct ftrace_regs *fregs, void *data)
>  {
>  	KUNIT_EXPECT_FALSE(current_test, preemptible());
>  	return 0;
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index 64e715e7ed11..1545a1aac616 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -50,7 +50,7 @@ static void show_backtrace(void)
>  
>  static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
>  				unsigned long ret_ip,
> -				struct pt_regs *regs, void *data)
> +				struct ftrace_regs *fregs, void *data)
>  {
>  	if (use_trace)
>  		/*
> 

