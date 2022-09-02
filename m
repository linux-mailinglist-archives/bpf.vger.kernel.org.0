Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6A5AB6E5
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiIBQxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBQxn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 12:53:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93F10951B
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 09:53:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c7so3031865wrp.11
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=pmNyEhBPkdn5Nz03uCpkSCdIgqEnBz521X+8Hc4hnOA=;
        b=khwko6HfwVSGi/ttD6l78FCM6ADy8xbufeLaG5HB/YoZ4Hftdivy2Et6OOEu9TqWCX
         DhOgZ3O6inCc0VjQS17AqZLM1YYfDc89oCDxv9f4GOEkX9NGGH0hbYkgVP7RLEY3/PtD
         aICf2mI6lt580xZcy+AAt3h4QoIQzWGWcpimR1jb1Ek5xM59scBqcwEgBeWKS5ViwJEH
         gcF7cQrP9QAX5QNhvngXGMiXpwayAwOKbSMkpp7iriz/tSO6COJmcwtoFn7vWMs4SEVO
         2WLR5ZCN2IztwANM9vIjC3vQREBKN+gY35CGrTnhL4PtlmJaxi4PH/KSf0Oe5W206NC7
         26yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pmNyEhBPkdn5Nz03uCpkSCdIgqEnBz521X+8Hc4hnOA=;
        b=QE74yAJTHOYx0pgeObyWKb3GzssejcQo/bbMlm2FbsBEa8wPNGAvAiPd4uLPLq/TY0
         keTmwO53V4hCICYwVPg9qHu+PlwjbNhJ1Wb2tKY0lNpMZrjU6WQN3eHPfwQ4jk1Z9T8C
         3PIoCHlHX+LEbA0/koHXM5DGzjoXTX1Pj5wg89uXEydYoALehQesEbzxIsAe22Noeltl
         lvZfoc8iCdxnCvq0gYccwaA2NQEDuQahvept4B5TBKdV77Ztfm0XBtsMXYaHkLSNw4dq
         j2/dlBProTidEzsaXg3zFfbZeWImGPIAENUKLKUEuBxPAy4PeAAT2j3sdtR+v/ZVaF8E
         XSVg==
X-Gm-Message-State: ACgBeo2gANjhZyZ/w1wHaD97f7nilzaS8jv45wARa3euoslgI+N5LCwl
        2sQdwoGaHp2wVBLFgqUuBts=
X-Google-Smtp-Source: AA6agR5HdsL1AdtAvLOph+0DlmCDvNB4xc4KvcP9l9SzzWVCzthYI/hIRm3UjI2ASy2zCMTDAhwBmA==
X-Received: by 2002:a5d:64ab:0:b0:226:d997:ad5c with SMTP id m11-20020a5d64ab000000b00226d997ad5cmr14642135wrp.602.1662137620852;
        Fri, 02 Sep 2022 09:53:40 -0700 (PDT)
Received: from krava ([46.189.28.51])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003a30fbde91dsm8397203wmp.20.2022.09.02.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:53:40 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 2 Sep 2022 18:53:38 +0200
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
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Move bpf_dispatcher function out of
 ftrace locations
Message-ID: <YxI1EtYjkLaooFm8@krava>
References: <20220901134150.418203-1-jolsa@kernel.org>
 <20220901134150.418203-3-jolsa@kernel.org>
 <YxHli+6C5rylF3EH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxHli+6C5rylF3EH@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 02, 2022 at 01:14:19PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 01, 2022 at 03:41:50PM +0200, Jiri Olsa wrote:
> 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 9c1674973e03..4ab4b0a1beb8 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -924,7 +924,15 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
> >  	},							\
> >  }
> >  
> > +#ifdef CONFIG_X86_64
> > +#define BPF_DISPATCHER_ATTRIBUTES __attribute__((__no_instrument_function__)) \
> > +				   __attribute__((patchable_function_entry(5)))
> > +#else
> > +#define BPF_DISPATCHER_ATTRIBUTES
> > +#endif
> > +
> >  #define DEFINE_BPF_DISPATCHER(name)					\
> > +	BPF_DISPATCHER_ATTRIBUTES					\
> >  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
> >  		const void *ctx,					\
> >  		const struct bpf_insn *insnsi,				\
> 
> Are you sure you want the notrace x86_64 only?
> 
> That is, perhaps something like this...
> 
> +#ifdef CONFIG_X86_64
> +#define BPF_DISPATCHER_ATTRIBUTES	   __attribute__((patchable_function_entry(5)))
> +#else
> +#define BPF_DISPATCHER_ATTRIBUTES
> +#endif
> +
>  #define DEFINE_BPF_DISPATCHER(name)					\
> +	notrace BPF_DISPATCHER_ATTRIBUTES				\
>  	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
> 

that's also an option.. but I don't this it's big deal that the function
is traceable on other arches, because the dispatcher image is generated
only on x86, so no other arch is touching that function entry, so it's
safe for ftrace to attach

jirka
