Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7335B26F6
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 21:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIHTl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIHTl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 15:41:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE3DA3D40
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 12:41:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh9so18582705ejc.8
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=8p+7MflHXiLLMaioFmkIEBXJg9ZuyazYQ8vxHd7AuMY=;
        b=FE1LoRXC3F6M4bvkZuKmaqVcpKcBA1HNXeKbJvIZBRAZ8CB1MoYPfmlRtGTr6Q3z32
         iOAv37YoTagt0L+mj9l6Wg5LebJAf11Tt7343ehnNzdBvJ4wC9lB5SQczDSvSBkHxqGD
         lvfH/dvhvtvCoCBVzaKsK6YCi4x1GXrF6kcENNU+J4m7xzoMhINRc8P1iqqHeQHQIHsZ
         MOQkNVNj+UTkG05iPeulcOuKtPCrteNVzYnI7DNVxia6ovzIv4RLsUqfd14+SGud6vxl
         7OrQ2Ub72K7dRbriV1/Vse5pJtdVjeauPMdOgo2s572q01Fn0mybLhMPwJO62Vr/Nv1m
         kb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8p+7MflHXiLLMaioFmkIEBXJg9ZuyazYQ8vxHd7AuMY=;
        b=yrRH4aIHzV17uWzgD/SRid/kQIHlF/TLYF0IlroyX7OSCI5QMFnlfAKR1N2FZ2Of3n
         xSw7KpKickQ6zQNQtwOYmHsXtpa30D6gAraqorTRtjLUziO6iwUDuw1y/EZ+8OJvWCMD
         8gOsfLi0PI+tezXgRq0qvurrR74eqM/qjlV5iBcPkCwntkOjuHT103Izj3LdQbleMsa6
         LpKdKWsiNxuz93SaAXsFRzFe1/tE1a+LbdUPcS7iO4NpmcYg33OsJ6jjUaa39kyDrjXX
         El2BWyKntgKZ70Xn0gPhZVhvbSWp6mr3Iu/9dmcccHqopJJqWgkQzfqPicoDJiD4euRe
         WjSA==
X-Gm-Message-State: ACgBeo23h7RqLkqWut3HJY/V1ksFmbZ0sbot8rCa2nwrXy+wMm5A3yfw
        yZlrKXrJWAAG4BJ59wO57zk=
X-Google-Smtp-Source: AA6agR5wdhIhcG8Ma9i0KrWdtMGEiI5iOvGSU1HHK3IL3wXT1bTHuJsWzUBrZ4064pHABY3FoDOMFQ==
X-Received: by 2002:a17:906:dc8c:b0:74f:25e3:5f81 with SMTP id cs12-20020a170906dc8c00b0074f25e35f81mr7035774ejc.564.1662666083680;
        Thu, 08 Sep 2022 12:41:23 -0700 (PDT)
Received: from krava ([83.240.62.96])
        by smtp.gmail.com with ESMTPSA id l19-20020a056402345300b0044e84d05cd8sm8479456edc.0.2022.09.08.12.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:41:23 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 8 Sep 2022 21:41:21 +0200
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2 bpf-next 2/6] ftrace: Keep the resolved addr in
 kallsyms_callback
Message-ID: <YxpFYSkkZmrR7OP3@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-3-jolsa@kernel.org>
 <20220908213551.5d51406ff9846bcd079fcc3f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908213551.5d51406ff9846bcd079fcc3f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 09:35:51PM +0900, Masami Hiramatsu wrote:
> On Thu, 11 Aug 2022 11:15:22 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Keeping the resolved 'addr' in kallsyms_callback, instead of taking
> > ftrace_location value, because we depend on symbol address in the
> > cookie related code.
> > 
> > With CONFIG_X86_KERNEL_IBT option the ftrace_location value differs
> > from symbol address, which screwes the symbol address cookies matching.
> > 
> > There are 2 users of this function:
> > - bpf_kprobe_multi_link_attach
> >     for which this fix is for
> > 
> > - get_ftrace_locations
> >     which is used by register_fprobe_syms
> > 
> >     this function needs to get symbols resolved to addresses,
> >     but does not need 'ftrace location addresses' at this point
> >     there's another ftrace location translation in the path done
> >     by ftrace_set_filter_ips call:
> > 
> >      register_fprobe_syms
> >        addrs = get_ftrace_locations
> > 
> >        register_fprobe_ips(addrs)
> >          ...
> >          ftrace_set_filter_ips
> >            ...
> >              __ftrace_match_addr
> >                ip = ftrace_location(ip);
> >                ...
> > 
> 
> Yes, this looks OK for fprobe. I confirmed above.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> One concern was that the caller might expect that the address
> must be ftrace_location(), but as far as I can read the function
> document, there is no such description.
> 
>  * ftrace_lookup_symbols - Lookup addresses for array of symbols
> ...
>  * This function looks up addresses for array of symbols provided in
>  * @syms array (must be alphabetically sorted) and stores them in
>  * @addrs array, which needs to be big enough to store at least @cnt
>  * addresses.
> 
> So this change is OK.
> 
> Thank you,

thanks for review, I'll rebase and new version

jirka

> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/ftrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index bc921a3f7ea8..8a8c90d1a387 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -8268,8 +8268,7 @@ static int kallsyms_callback(void *data, const char *name,
> >  	if (args->addrs[idx])
> >  		return 0;
> >  
> > -	addr = ftrace_location(addr);
> > -	if (!addr)
> > +	if (!ftrace_location(addr))
> >  		return 0;
> >  
> >  	args->addrs[idx] = addr;
> > -- 
> > 2.37.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
