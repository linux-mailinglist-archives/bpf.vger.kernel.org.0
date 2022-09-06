Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA6E5AE503
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiIFKIG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiIFKIF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 06:08:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542125C5B
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 03:08:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e17so6839102edc.5
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=zmJzNViE34p6/jA1hPcZaxIhLbmiyBCQ1vHBKsBEiKI=;
        b=XmNGGEU/lM/VX9Pbm6CZ9V1PonF5qn2K8ULq9JF+GAkqBh0NpyvsD3Uyyfzc38pykf
         wlwWbAWDLSOUPS0bxa1Ajw5Brt/L3tSieN0JCdVaEs3HZjVgwKsH6vu6RI9QAIQoo2WI
         IwriVGn0zunFZ2yeeIiQMZEadlURC8oVBw93Gil8JydmxMHZr1XRqj6u3mz/m4lqwqmr
         vP3dBXdlar9+j6BOJlXTN7XwnyhsjbaSn9eDdSS7m0kLvKZyWXmFs+CX5jugvxM2XvsC
         cP8vmA69Qu1m4kniJukQYvdU7meEohUvUqHkvXzL+nGqF2YBFZL3rKlTP5h+V45aF1Fv
         rmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zmJzNViE34p6/jA1hPcZaxIhLbmiyBCQ1vHBKsBEiKI=;
        b=S5VP8EoHpvIYzb8jwK341NcLLb9UXa821HYtyoy+9aLcoPKU+yMDdOYcd2FiUxjQk6
         yryruTQcFohfQv99Txd2/Pzm8xCUC7/Mdhc8b2AXCYL0DcjpP9VZ1O20wCvzxdHjKoYH
         T41ynZEb0joOZYmgWNA8LQQdPXbLH52HOKZm6QLmbllMBXsnxhyHEMwJ1sgjKwhGwOk9
         uBqhfRK/uMJIQTKYdtUCQNswBT4wrUum8FBKkblJ5L78PMmk+35klVqslGHoZLAMmALD
         ok9XQhD15JxcwnFwFckH5LduTLLktCcKufkpkr/Bh0VM3Ernioj46U3I67rMljWJkcy4
         1l6w==
X-Gm-Message-State: ACgBeo00V9xVcy4zIGR6v7tfvCVKNn/hna7/QgFe6hREkdN4AuGyE6aE
        Sx7qsbbTIdIiZu7xNZnUOV0=
X-Google-Smtp-Source: AA6agR4WyoB1Jpi1zEexzPm6CmzknSux2PLdA0EMVF+ONytiWyVraACVhq872zW75ebvPq4w9BvqcQ==
X-Received: by 2002:a05:6402:2937:b0:44e:b578:6fdd with SMTP id ee55-20020a056402293700b0044eb5786fddmr4330530edb.159.1662458882429;
        Tue, 06 Sep 2022 03:08:02 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id qt14-20020a170906ecee00b00728f6d4d0d7sm6388124ejb.67.2022.09.06.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:08:01 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 6 Sep 2022 12:07:59 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCHv3 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <Yxcb/9W3XsoA+QM/@krava>
References: <20220903131154.420467-1-jolsa@kernel.org>
 <20220903131154.420467-3-jolsa@kernel.org>
 <20220905112345.3daf34a1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905112345.3daf34a1@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 05, 2022 at 11:23:45AM -0400, Steven Rostedt wrote:
> On Sat,  3 Sep 2022 15:11:54 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index f9920f1341c8..089c20cefd2b 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -284,6 +284,7 @@ config X86
> >  	select PROC_PID_ARCH_STATUS		if PROC_FS
> >  	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
> >  	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> > +	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> >  
> >  config INSTRUCTION_DECODER
> >  	def_bool y
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9c1674973e03..e267625557cb 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -924,7 +924,14 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
> >  	},							\
> >  }
> >  
> > +#ifdef CONFIG_X86_64
> 
> I think Peter may have already mentioned this, but shouldn't he above be:
> 
>   #ifdef HAVE_DYNAMIC_FTRACE_NO_PATCHABLE

different archs need different patchable_function_entry(X) attribute
so I think we should use arch configs in here

also having HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option enabled does not
imply there's support for dispatcher image generation, so we might
endup with extra nop bytes

jirka

> 
> ??
> 
> -- Steve
> 
> > +#define BPF_DISPATCHER_ATTRIBUTES __attribute__((patchable_function_entry(5)))
> > +#else
> > +#define BPF_DISPATCHER_ATTRIBUTES
> > +#endif
> > +
> >  #define DEFINE_BPF_DISPATCHER(name)					\
> > +	notrace BPF_DISPATCHER_ATTRIBUTES				\
> >  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
> >  		const void *ctx,					\
> >  		const struct bpf_insn *insnsi,				\
> > -- 
