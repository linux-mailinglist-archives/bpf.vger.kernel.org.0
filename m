Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3917B597018
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiHQNkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHQNkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 09:40:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11546558FD
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 06:40:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e13so17505866edj.12
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=/shrZJ8ddaMQ6sZoDylnaXiWZxyzOFcpivKKuT6fMyc=;
        b=d2pOrog5idCTUDSEE8SNuCAEey6Re8+jl66OsZa0J+kjVyIf/QlO8eABaK+0uSE7BK
         Pb74SqJ8H/ehXxQ38mpjJeUpWo6KkdG9DU6a7yX0gwhng0v60vBLDPMF09twEnzboqLu
         sUF+281dMUFKHQxw7xkguYsy8iQZJGZbH+1Nh3ajBBS8KPlwaMwn/+jmlern9j9jjHFB
         sAJ2D+Co2jy55FjSOK9IqnY5vL/vH6VH7vmmRpp+q7AzM7Ou+9/m5MzYm+1h9xcvJuC9
         UlNmM1+iVZui5QIe/1ujDyza9i2blGOclYEqCNLiU1nTXhi8y+cgmVze9xA7d26hWpaZ
         ob3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=/shrZJ8ddaMQ6sZoDylnaXiWZxyzOFcpivKKuT6fMyc=;
        b=LRgRahs74XSS6m/NTPxviu0Vulx9GigkSr0Fy0grVZBuAN8Hoo6kAaslg0TVpPB+FN
         gHG7AStA+UvrsbrvPlTynj5X8sQgKEJ8bgp+mQsIsoccK5xR2xG8zWqWVUXxA7xdNWRv
         nHaHQvjJ7U4+ny8dbaKQ31D5Jscr50wibKxMnLx0aaDJZhkLUWsIqcGhxHEjyvj4pjuc
         fCgmcSY0hPdoFOTv8k0gRJh5iTB+a8z0dcaharLrFCRPVUcSrjBVfrBLuOeH73WcYW5G
         i5wVYGeSLth002jtWPkpinQRV+gKLx+H67As004uBxheBP1ExB471g9dvnjXbL+ShdZk
         oRtQ==
X-Gm-Message-State: ACgBeo34MrMo2uC2oGJbdUuwy2gN31pFMCBx4KCylc13+1RW7M0Intxr
        vYsWZkXatpdgyTGrLzBzLk8=
X-Google-Smtp-Source: AA6agR4akAXaXh8blxMq4TScZ5jaCIIhjuLgcYlA35CSSLgg57fjKfw3fSL+5FhSfSAc6JI8gCHO7A==
X-Received: by 2002:a05:6402:331a:b0:445:f60e:48cd with SMTP id e26-20020a056402331a00b00445f60e48cdmr352090eda.201.1660743619662;
        Wed, 17 Aug 2022 06:40:19 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7cf0e000000b0043acddee068sm10674256edy.83.2022.08.17.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:40:19 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 17 Aug 2022 15:40:16 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 3/6] bpf: Use given function address for
 trampoline ip arg
Message-ID: <YvzvwJr+TneJi3Eo@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-4-jolsa@kernel.org>
 <Yvodfh6OJhSIq8X9@worktop.programming.kicks-ass.net>
 <YvomoyS/3Op8FAMa@krava>
 <YvpBVDP3FydnAtHA@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvpBVDP3FydnAtHA@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 02:51:32PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 15, 2022 at 12:57:39PM +0200, Jiri Olsa wrote:
> > On Mon, Aug 15, 2022 at 12:18:38PM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 11, 2022 at 11:15:23AM +0200, Jiri Olsa wrote:
> > > > Using function address given at the generation time as the trampoline
> > > > ip argument. This way we get directly the function address that we
> > > > need, so we don't need to:
> > > >   - read the ip from the stack
> > > >   - subtract X86_PATCH_SIZE
> > > >   - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
> > > >     which is not even implemented yet ;-)
> > > 
> > > Can you please tell me what all this does and why?
> > > 
> > 
> > arch_prepare_bpf_trampoline prepares bpf trampoline for given function
> > specified by 'func_addr' argument
> 
> The bpf trampoline is what's used for ftrace direct call, no?

sorry I forgot to answer this one.. yes ;-)

> 
> > the changed code is storing/preparing caller's 'ip' address on the
> > trampoline's stack so the get_func_ip helper can use it
> 
> I've no idea what get_func_ip() helper is...

it's kernel code that can be executed by bpf program,
get_func_ip returns ip address of the probed function
that triggered bpf program

jirka

> 
> > currently the trampoline code gets the caller's ip address by reading
> > caller's return address from stack and subtracting X86_PATCH_SIZE from
> > it
> > 
> > the change uses 'func_addr' as caller's 'ip' address when trampoline is
> > generated .. this way we don't need to retrieve the return address from
> > stack and care about endbr instruction if IBT is enabled
> 
> Ok, I *think* I sorta understand that.
