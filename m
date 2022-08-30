Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C495A64BA
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiH3N3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiH3N3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:29:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE463979F8
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:29:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id az27so14234318wrb.6
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=oylInSM8kecvu0gj3osIBtCF/roiN+N/RLD20B/hQ84=;
        b=Gk8K/54NHeJZXFL1/lmne0E0SoyV8LgCpemSh1LxBIfrgLuk/fw2mmCoNapbTDP1hW
         KXoXKmSa93e0MstJ4zIDQ04AozAHBIHJaPvWDOiU0EXuxTMsNhreMHSv45AAR71xPH44
         KOCctB1mHuCOw/q0m6AmtzHm4ZhjOqZmwfKawb+3yqbra15493EG1XNKhHo/UqsHqpUA
         gESESDBvyVx/pbmEpp5DCBaCk9ExwrbWQx0VzvlWOXhkNWrkzisit9j+tvE6w7rEnLak
         Dx5Haa+4sPluQ9qv9wOpl/P9wBynhWYdn8XBgO2zB7ZPwQ956rdt6+f8pbQOJB3QvGEX
         uKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oylInSM8kecvu0gj3osIBtCF/roiN+N/RLD20B/hQ84=;
        b=Tb+EhY+ikldM/QuoBox17CFGfki1HcIZ6GCXdoRrYyQHjrLzMYPKUT9Y3s2xCcp+hy
         NPrxYwC6PWaZdnUPNB/cM13Qq6bP1Bs2f0ayl3DFrYOzYp2QadelDiw7cYPHdWfsROXZ
         RScXuLVxQWw1Ziy8yY4o14BOER4oGfB6Zv4cDwlqQHiWgsD3bH53VYlp4gimn5N1HqWx
         qDNtpwWm0242y73VDn/3m98JohzL9VVt1J3odv16qsOrVfmVEOdpbXSyPC1OeY+OBiam
         ATkAeizvaNnXTQPOE3Cbf+ZzGAwwIs6eS2VYLZhPBUptb3itwruAvTKCZ1JHfPv79d77
         5jww==
X-Gm-Message-State: ACgBeo0dCFw2NQNHnMmnb7VjAW56ofeje/pYb8x9YOjwmIi6JyO7GMyc
        G3zSMOrN0AnuObYA7M10UHg=
X-Google-Smtp-Source: AA6agR7l/G3pq1jHK2vNvGdK9ibS4y7QbKS6JzxNb+0KTP6sgripV56yujlNwR1oWYR1dHZ591rzbA==
X-Received: by 2002:adf:e0c3:0:b0:226:d598:85ee with SMTP id m3-20020adfe0c3000000b00226d59885eemr6690003wri.589.1661866162452;
        Tue, 30 Aug 2022 06:29:22 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b00226d217c3e6sm9864941wrb.64.2022.08.30.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:29:21 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 30 Aug 2022 15:29:19 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <Yw4Qr65TnpXBX8vl@krava>
References: <20220826184608.141475-1-jolsa@kernel.org>
 <20220826184608.141475-3-jolsa@kernel.org>
 <Yw3p/WBKlOaN+W9h@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw3p/WBKlOaN+W9h@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 12:44:13PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 26, 2022 at 08:46:08PM +0200, Jiri Olsa wrote:
> > The dispatcher function is attached/detached to trampoline by
> > dispatcher update function. At the same time it's available as
> > ftrace attachable function.
> > 
> > After discussion [1] the proposed solution is to use compiler
> > attributes to alter bpf_dispatcher_##name##_func function:
> > 
> >   - remove it from being instrumented with __no_instrument_function__
> >     attribute, so ftrace has no track of it
> 
> This is typically spelled like: 'notrace' in the kernel.
> 
> >   - but still generate 5 nop instructions with patchable_function_entry(5)
> >     attribute, which are expected by bpf_arch_text_poke used by
> >     dispatcher update function
> > 
> > Enabling HAVE_DYNAMIC_FTRACE_NO_PATCHABLE option for x86, so
> > __patchable_function_entries functions are not part of ftrace/mcount
> > locations.
> > 
> > The dispatcher code is generated and attached only for x86 so it's safe
> > to keep bpf_dispatcher func in patchable_function_entry locations for
> > other archs.
> > 
> > [1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/Kconfig    | 1 +
> >  include/linux/bpf.h | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
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
> > index 9c1674973e03..945d5414bb62 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -925,6 +925,8 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
> >  }
> >  
> >  #define DEFINE_BPF_DISPATCHER(name)					\
> > +	__attribute__((__no_instrument_function__))			\
> > +	__attribute__((patchable_function_entry(5)))			\
> >  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
> >  		const void *ctx,					\
> >  		const struct bpf_insn *insnsi,				\
> 
> What makes that whole dispatcher thing x86 only? AFAICT it is only under
> BPF_JIT here and could be used by anyone.

it is just optimalization on x86, that transform default indirect calls to
direct call,  described in changelog in here:

  75ccbef6369e bpf: Introduce BPF dispatcher

other archs just make the call to bpf_func

jirka

> 
> ARM64 for instance has BPG_JIT and builds net/core/filter.c. And ARM64
> very much does use patchable_function_entry() for its ftrace
> implementation.
