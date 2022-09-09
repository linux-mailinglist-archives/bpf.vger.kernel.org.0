Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF85B37BD
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiIIM0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiIIM0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 08:26:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09FA219B
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 05:26:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so2216013edd.13
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=o/izZYVLPCgUyPBcGlrfzek75+4jwN49+Tt4Vg8snrg=;
        b=Uat5Amzor2NKt3A8vp6K4+DGXWXG6lfRnBcxbI2/dE4QyJDM1zupLeqn9j1oqmO3sv
         +pOnwB+WIHJaPvE7xptBMPltu0tVqTR3c7QfzFU4aKEzUazIEoQdoXcp93gwie4xEBYZ
         FecsoCpg6B8NVBXPQBJCnRn3UXJ6GfAFzGG/OqEkRwY39G+2I0RWApNv912YGW34upPw
         3sVS97lQ5YRFkmPvAu/Wu60OFroDb1ewswHsdZ/C9cWiYUh8qU5sa59Q3c5Te2PZkKSF
         AjU639R02jYgkI3BXlHRD0JVMDjv8SkLgOFFLcse4lSFJy5CaYAEFle5b85MQ7j5MSgn
         x04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=o/izZYVLPCgUyPBcGlrfzek75+4jwN49+Tt4Vg8snrg=;
        b=RlsgOu2ct38qJQwJnlIT3CAgifk1lBNeBug6+FEEX3ZarsPRK+vKqguagBWWRQ1D/7
         eSXsGyYu9jYeYqC50KjmK9PqAgowu3KwXGhQaBu4kDqIlMd6txmXXtlbBop5L+TQH9rB
         Qf9jEB6mGKMw5iWQf/RTVGGmxRPhc2hjo9sCMcOT61FjdFEeXfru7S/Pre6cgPL8UBST
         smH/YIf0X3ntV1USljdSbeeW+LPjCMorfvDkPWO4yUW8FGvGUAqb5IQe7RIG0swFEG+9
         tarDxNFKTLlf1D4UQ/zHkbuW4pOtySVoptU4N1TR+4tWREaeltPnPljL2+59WsP/NElw
         OHyA==
X-Gm-Message-State: ACgBeo2CJHUbDYjmHs0nikOvb++0QetUQOd7JSiq53Mgm0VAqGe9vyvF
        Lrk6q+Q4N+xuQbFinxNRnw4=
X-Google-Smtp-Source: AA6agR59WoPNCqJqqxbhkmvwJL8BIWCxm67g57YBb4hbseaMOyc63Tu3TlHdf/Icu2DNaJ2d48TIKw==
X-Received: by 2002:aa7:df87:0:b0:44e:2851:7e8d with SMTP id b7-20020aa7df87000000b0044e28517e8dmr11367100edy.106.1662726358866;
        Fri, 09 Sep 2022 05:25:58 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id z25-20020aa7d419000000b0044efc3d4c4csm300330edq.33.2022.09.09.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:25:58 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 9 Sep 2022 14:25:55 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv3 bpf-next 4/6] bpf: Adjust kprobe_multi entry_ip for
 CONFIG_X86_KERNEL_IBT
Message-ID: <Yxsw00lIqYmdO4Ir@krava>
References: <20220909101245.347173-1-jolsa@kernel.org>
 <20220909101245.347173-5-jolsa@kernel.org>
 <YxsoPLVnSjcTqQDf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxsoPLVnSjcTqQDf@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 01:49:16PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 12:12:43PM +0200, Jiri Olsa wrote:
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 68e5cdd24cef..bcada91b0b3b 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2419,6 +2419,10 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long entry_ip,
> >  {
> >  	struct bpf_kprobe_multi_link *link;
> >  
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +	if (is_endbr(*((u32 *) entry_ip - 1)))
> > +		entry_ip -= ENDBR_INSN_SIZE;
> > +#endif
> >  	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
> >  	kprobe_multi_link_prog_run(link, entry_ip, regs);
> >  }
> 
> Strictly speaking this can explode if this function is one without ENDBR
> and it's on a page-edge and -1 is a guard page or something silly like
> that (could conceivably happen for a module or so).

ok, as per discussion on irc, we could use get_kernel_nofault() to
read it safely as you suggested

> 
> I'm also thinking this function might be a bit clearer if the argument
> were called fentry_ip -- that way it would be clearer this is an ftrace
> __fentry__ ip.

ok

> 
> The canonical way to get at +0 would be something like:
> 
> 	kallsyms_lookup_size_offset(fentry_ip, &size, &offset);
> 	entry_ip = fentry_ip - offset;
> 
> But I appreciate that might be too expensive here; is this a hot path?
> 
> Could you store this information in struct bpf_kprobe_multi_link?

we could use the same way we use when looking for cookies in
bpf_kprobe_multi_cookie ... having extra array of real entry
ips.. or some similar approach

but let's try to read it safely with get_kernel_nofault first

jirka
