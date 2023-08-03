Return-Path: <bpf+bounces-6884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F076F078
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 19:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EA528229C
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722F24192;
	Thu,  3 Aug 2023 17:16:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24384200B4
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 17:16:19 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A52D43
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 10:16:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9a828c920so18412271fa.1
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691082976; x=1691687776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hC7gerl5K2kOmmDUWbirDjV8Ryb8iz7FSHMlInyXLs=;
        b=qc6V0/q5grLqARLyHFamtb5KJujnDmhhlPLidpydRiLapfccrBhiRoMqna1Rql1gl5
         W0Cb4PXBvq3suqGBP51ljm0ekG01frQV379AVj8JLNxbwDg19EfnEJ5caVZ8VJiAwmGS
         xJCa+NFVWU4MKVN6ZofNDIKMoEMl/8TUI3pXSOayXuM8vxFpy/9nyu+/fxJHZ9l77t24
         MPUTztfzhMyA/LezMzWoGXfaxVXcaxQNu+vvTJITyOSPFCpnYADo7U3Q+UAns9Fepaqg
         ttfDQFNddA/jWNZIHKouVNfcIPRRuA7DOknAoBdAYQWEA38hZ9l+BYcZvb+XsAz+GDPc
         sWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082976; x=1691687776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hC7gerl5K2kOmmDUWbirDjV8Ryb8iz7FSHMlInyXLs=;
        b=HPmxYQ7e1mgq1WIbTzow1M48bxLqrejUKp9KuWXHZ+UVH5bJiOQpN9twoIgt+UiZbO
         x6ZSqvQevDIurke75iqRw/NfI9hd23VgkbVXtpmhGXgaNebi64GrePURfx3OZCEm3TPu
         8QuqMknt0TMGG3IvjbWVpWqUnDuyjjVhMxdyHXtn9E5NNant09p7CFdl5zyDdZw6AwUw
         Ia0y/oEprOmxSQsvtlTdq2qpceIph7gTy8LM1+a9xKuypKROvvb7szNCyRfRMn9t5EfH
         U3gAUhHAQjwakBUWlk1/4zKszb0mqi3Q9DLb4Vy5HXjsP+oTixatPAT4InAkSFcX7g6M
         gP2g==
X-Gm-Message-State: ABy/qLaP/3ZCcc+GR+5KkLMYC/PkEkEsK3Cjvmtte+lzWgHJf1wuvJ4t
	Q5L+YR4qV4LyOZ1PewmNZWo=
X-Google-Smtp-Source: APBJJlEluoybImsoaNLFSpWTPA+MyL2zDpqrIpSaAjuJv8FZsNzwUD7p8UGbTCY6OwRMh4m91Oz1Aw==
X-Received: by 2002:a2e:9049:0:b0:2b5:bc27:d6eb with SMTP id n9-20020a2e9049000000b002b5bc27d6ebmr7668094ljg.8.1691082976142;
        Thu, 03 Aug 2023 10:16:16 -0700 (PDT)
Received: from krava ([2a00:102a:500b:273a:b7b9:4847:2b1f:b4e3])
        by smtp.gmail.com with ESMTPSA id si10-20020a170906ceca00b00992e14af9c3sm83683ejb.143.2023.08.03.10.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 10:16:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 3 Aug 2023 19:16:12 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf: Add support for bpf_get_func_ip
 helper for uprobe program
Message-ID: <ZMvg3FLjXxZj1vcX@krava>
References: <20230803095219.1669065-1-jolsa@kernel.org>
 <20230803095219.1669065-2-jolsa@kernel.org>
 <6e423425-b079-b0ca-eec3-192447b51a23@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e423425-b079-b0ca-eec3-192447b51a23@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 08:50:59AM -0700, Yonghong Song wrote:

SNIP

> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 83bde2475ae5..d35f9750065a 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1046,9 +1046,28 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
> >   #define get_entry_ip(fentry_ip) fentry_ip
> >   #endif
> > +#ifdef CONFIG_UPROBES
> > +static unsigned long bpf_get_func_ip_uprobe(struct pt_regs *regs)
> > +{
> > +	struct uprobe_dispatch_data *udd;
> > +
> > +	udd = (struct uprobe_dispatch_data *) current->utask->vaddr;
> > +	return udd->bp_addr;
> > +}
> > +#else
> > +#define bpf_get_func_ip_uprobe(regs) (u64) -EOPNOTSUPP
> > +#endif
> 
> If I understand correctly, if below run_ctx->is_uprobe is true,
> then bpf_get_func_ip_uprobe() func in the above will be called.
> If run_ctx->is_uprobe is false, the above bpf_get_func_ip_uprobe
> macro will be not be called. The that macro definition with
> -EOPNOTSUPP really does not matter.
> 
> To avoid the above confusion, maybe we should put the CONFIG_UPROBES inside
> bpf_get_func_ip_kprobe like below.
> 
> > +
> >   BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
> >   {
> > -	struct kprobe *kp = kprobe_running();
> > +	struct bpf_trace_run_ctx *run_ctx;
> > +	struct kprobe *kp;
> > +
> > +	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> > +	if (run_ctx->is_uprobe)
> > +		return bpf_get_func_ip_uprobe(regs);
> > +
> > +	kp = kprobe_running();
> 
> ...
> struct bpf_trace_run_ctx *run_ctx __maybe_unused;
> ...
> 
> #ifdef CONFIG_UPROBES
> 	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx,
> run_ctx);
> 	if (run_ctx->is_uprobe)
> 		return ((struct uprobe_dispatch_data *)current->utask->vaddr)->bp_addr;
> #endif
> 
> What do you think?

I thought having that in function is nicer, but yes, that will save
some cycles if CONFIG_UPROBES is disabled... on the other hand I'd
think it's enabled everywhere ... then it's true the function is just
multiple deref.. so yea, sure ;-)

thanks,
jirka

> 	
> 
> >   	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> >   		return 0;
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 01ea148723de..7dde806be91e 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
> >   #define trace_probe_log_err(offs, err)	\
> >   	__trace_probe_log_err(offs, TP_ERR_##err)
> > +
> > +struct uprobe_dispatch_data {
> > +	struct trace_uprobe	*tu;
> > +	unsigned long		bp_addr;
> > +};
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 555c223c3232..576b3bcb8ebd 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -88,11 +88,6 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
> >   static int register_uprobe_event(struct trace_uprobe *tu);
> >   static int unregister_uprobe_event(struct trace_uprobe *tu);
> > -struct uprobe_dispatch_data {
> > -	struct trace_uprobe	*tu;
> > -	unsigned long		bp_addr;
> > -};
> > -
> >   static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
> >   static int uretprobe_dispatcher(struct uprobe_consumer *con,
> >   				unsigned long func, struct pt_regs *regs);
> > @@ -1352,7 +1347,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
> >   	if (bpf_prog_array_valid(call)) {
> >   		u32 ret;
> > -		ret = bpf_prog_run_array_sleepable(call->prog_array, regs, bpf_prog_run);
> > +		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
> >   		if (!ret)
> >   			return;
> >   	}
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 70da85200695..d21deb46f49f 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -5086,9 +5086,14 @@ union bpf_attr {
> >    * u64 bpf_get_func_ip(void *ctx)
> >    * 	Description
> >    * 		Get address of the traced function (for tracing and kprobe programs).
> > + *
> > + * 		When called for kprobe program attached as uprobe it returns
> > + * 		probe address for both entry and return uprobe.
> > + *
> >    * 	Return
> > - * 		Address of the traced function.
> > + * 		Address of the traced function for kprobe.
> >    * 		0 for kprobes placed within the function (not at the entry).
> > + * 		Address of the probe for uprobe and return uprobe.
> >    *
> >    * u64 bpf_get_attach_cookie(void *ctx)
> >    * 	Description

