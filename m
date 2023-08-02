Return-Path: <bpf+bounces-6705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8CF76CC8B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83254281D7B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4E746F;
	Wed,  2 Aug 2023 12:23:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF227460
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:23:43 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF01E2701
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:23:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so11295328e87.0
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690979019; x=1691583819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2gusF8CWYGjNIvzVGdw2wR8dyMqMBXIkM0ayeCiUEI=;
        b=o2irF9kFOKfy251p4wacMwTMfNweZfZPPfs9OpWqTEHv69c59sc9JMPyzmDVThDXhj
         QP4D57bKo7QLqNimC1X5nZymgGBEqVhcqU2Gh0ZKA0jTDDiFlidl4czNyovOJtOEoPTR
         vnJ0MlYooOpOQkithNxPQT6P4KqqUxd0g0o+2tm3DXfaZnI3OoGANF3ao/39wKLYizLu
         mw9vExajtDwlxavN8Yq9mdg3Ky+wq5iB9ltKG81qOjRsKE5kwVaMwqbum83h5QBGPUcE
         Dct6f3L0cSSt46lv4oHbANHYgLtX6PsTnA2Ak9emhZe2BOOHmsCf3ydXFiYcvIznlQsz
         BUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979019; x=1691583819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2gusF8CWYGjNIvzVGdw2wR8dyMqMBXIkM0ayeCiUEI=;
        b=Lvmhns31u6MEdbRnUQeWhjUEHyB76QDtdi9TIc7WYv3QBX8qW9k9iChXdeVnwquBQH
         lkNUIkWtQo8jcXojta9ZdR/Iq601RLtmTNcJVlucr1AUqvgAhLy8Ha2zdVFkbJBcF99l
         zfXrczyKgtatSYc+A5soGVWyo4zKQSjj/QhNgGl9zQt/HVpu0m02ZHXoZfwK6xckWKKL
         Lc3vZvdG+ttS1wHFbyeSW9c1XDtLc7SrexAZbBIzMgoPA2Szln0OYx0pgeHhODwC1OKn
         CayV/Jh34VG0SkSq8br0sTiDJ43RMzt1A6C66dYcOmUdyKDtH6TPSNbjAH7bxwmTW4yo
         mbkw==
X-Gm-Message-State: ABy/qLa2z5XAsOYiYsMxtQO8W6mf1itCswc4SYc000zpd5BASV4bkq/W
	nnWq9gSSRCu5GeK9PQSMqXQ=
X-Google-Smtp-Source: APBJJlFoyB5TlsXz8e/x4lx7o20cPukCvwk1nbUOPkM0Es9lxl5KW7casL65TxKtlRrrpOQS2h52fA==
X-Received: by 2002:a05:6512:281c:b0:4fd:d31b:71c8 with SMTP id cf28-20020a056512281c00b004fdd31b71c8mr5369056lfb.9.1690979018641;
        Wed, 02 Aug 2023 05:23:38 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003fbc30825fbsm1526459wmj.39.2023.08.02.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:23:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Aug 2023 14:23:35 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper
 for uprobe program
Message-ID: <ZMpKx4Ce3NSl7Jn0@krava>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-2-jolsa@kernel.org>
 <e34ef898-28ca-6d17-ff5e-889e9f046ea6@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34ef898-28ca-6d17-ff5e-889e9f046ea6@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 12:21:59PM +0100, Alan Maguire wrote:

SNIP

> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index c92eb8c6ff08..7930a91ca7f3 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1057,9 +1057,28 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
> >  #define get_entry_ip(fentry_ip) fentry_ip
> >  #endif
> >  
> > +#ifdef CONFIG_UPROBES
> > +static unsigned long bpf_get_func_ip_uprobe(struct pt_regs *regs)
> > +{
> > +	struct uprobe_dispatch_data *udd;
> > +
> > +	udd = (struct uprobe_dispatch_data *) current->utask->vaddr;
> > +	return udd->bp_addr;
> > +}
> > +#else
> > +#define bpf_get_func_ip_uprobe(regs) (u64) -1
> 
> Small thing - I don't think this value is exposed to users due to the
> run_ctx->is_uprobe predicate, but would it be worth using -EOPNOTSUPP
> here maybe?

I initially thought of putting WARN_ON_ONCE in here, but as you said it
won't trigger so ended up with -1 .. but I don't mind using -EOPNOTSUPP

jirka

> 
> > +#endif
> > +
> >  BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
> >  {
> > -	struct kprobe *kp = kprobe_running();
> > +	struct bpf_trace_run_ctx *run_ctx;
> > +	struct kprobe *kp;
> > +
> > +	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> > +	if (run_ctx->is_uprobe)
> > +		return bpf_get_func_ip_uprobe(regs);
> > +
> > +	kp = kprobe_running();
> >  
> >  	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> >  		return 0;
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 01ea148723de..7dde806be91e 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
> >  
> >  #define trace_probe_log_err(offs, err)	\
> >  	__trace_probe_log_err(offs, TP_ERR_##err)
> > +
> > +struct uprobe_dispatch_data {
> > +	struct trace_uprobe	*tu;
> > +	unsigned long		bp_addr;
> > +};
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 555c223c3232..fc76c3985672 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -88,11 +88,6 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
> >  static int register_uprobe_event(struct trace_uprobe *tu);
> >  static int unregister_uprobe_event(struct trace_uprobe *tu);
> >  
> > -struct uprobe_dispatch_data {
> > -	struct trace_uprobe	*tu;
> > -	unsigned long		bp_addr;
> > -};
> > -
> >  static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
> >  static int uretprobe_dispatcher(struct uprobe_consumer *con,
> >  				unsigned long func, struct pt_regs *regs);
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 70da85200695..d21deb46f49f 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -5086,9 +5086,14 @@ union bpf_attr {
> >   * u64 bpf_get_func_ip(void *ctx)
> >   * 	Description
> >   * 		Get address of the traced function (for tracing and kprobe programs).
> > + *
> > + * 		When called for kprobe program attached as uprobe it returns
> > + * 		probe address for both entry and return uprobe.
> > + *
> >   * 	Return
> > - * 		Address of the traced function.
> > + * 		Address of the traced function for kprobe.
> >   * 		0 for kprobes placed within the function (not at the entry).
> > + * 		Address of the probe for uprobe and return uprobe.
> >   *
> >   * u64 bpf_get_attach_cookie(void *ctx)
> >   * 	Description

