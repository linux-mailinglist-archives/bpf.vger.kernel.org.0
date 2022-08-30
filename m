Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B85A658C
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiH3NvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiH3NvA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:51:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B648119C12
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:49:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z2so14315278edc.1
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=Zttcy6sB0tRzKcpKB6l21h1Lr4wttTXdFEl7M4+4w0o=;
        b=QXRTIsSea6OFAXV2HlCAqxEGRpjD2ILDt0QwHJpAQ9Bh1MZ48UCv3yOYMsqPfkADy4
         ICOF4ajAJm5ogoKCm3ZPmL9wvfJ/aoKWIL4WveDJJ460XTEH1PHr8j4Oa3DTvGb5V/4e
         b1HKbDgUrGCi4XJplMsjFGoya6e1v7gn+BTaArMv7oO1RAM6NPHLwj/NE3wvy/Q0QrQN
         f2KJ45uqycac/y0KH+gWUvxPT695CNmDdc+OdakLuNfNEYMdN7cEujVsY9lEPnkMDHIa
         3JVkCY0H+YZOVxOmn0aXZzYCCOmEHph19F9HA7yiVPHBrpij+vyng7KR3XNNHzguHYtQ
         e6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Zttcy6sB0tRzKcpKB6l21h1Lr4wttTXdFEl7M4+4w0o=;
        b=CANhcQb2FNEBfmRvBK+mSu1Zev43w7K2r/T1gV8PmlhBoTlm36A8Er99p0VqEDFDRJ
         jd7A0gzOUfFZqyrByvz/W2TLpdlt5xF9i2SqZ/GtK0eQDgE3iuK/IMdja/BnYN1S1lYr
         /a1qW16T5p3u7qMXDn5MnZrB29gwFbNqcSjAQ1cSR26fpZmfowvRVWeHjek80uv0SApg
         Uz8s6CzcBG9eGbiBRzheg0zVFTK7keYVWDtmw8dIO1EeoAJAGMHS9Z5Kj4J3uzUpBMpY
         dxk0EfP3cRT8sU6scflnyG8Jc95rnXZnQ5pqfvO6YzyVOE9i7Gh4sy6xiWZpcZsoq+TM
         yeYg==
X-Gm-Message-State: ACgBeo2k95ioGjK6kbstqY3l1QAVgbqWt+ulkQgipQPOfH9fB4Zqpqup
        kCDab2eAzz3JSPk9E6JsLsU=
X-Google-Smtp-Source: AA6agR6xt6mAPL8j78CRa6qkirhNCc+GuOJh+rTYNq9znFqdtKMkbQtFdIu6JNaLs1P68ABH8un7YA==
X-Received: by 2002:a05:6402:90a:b0:443:8b10:bcad with SMTP id g10-20020a056402090a00b004438b10bcadmr20742716edz.416.1661867341238;
        Tue, 30 Aug 2022 06:49:01 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id s14-20020a1709067b8e00b0073dc60271b2sm5935541ejo.32.2022.08.30.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:49:00 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 30 Aug 2022 15:48:58 +0200
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
Message-ID: <Yw4VSr7X8hacimrB@krava>
References: <20220826184608.141475-1-jolsa@kernel.org>
 <9099057e-124c-8f30-c29d-54be85eeebfd@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9099057e-124c-8f30-c29d-54be85eeebfd@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 12:25:25AM +0200, Daniel Borkmann wrote:
> On 8/26/22 8:46 PM, Jiri Olsa wrote:
> > hi,
> > as discussed [1] sending fix that moves bpf dispatcher function of out
> > ftrace locations together with Peter's HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> > dependency change.
> 
> Looks like the series breaks s390x builds; BPF CI link:
> 
> https://github.com/kernel-patches/bpf/runs/8079411784?check_suite_focus=true
> 
>   [...]
>     CC      net/xfrm/xfrm_state.o
>     CC      net/packet/af_packet.o
>   {standard input}: Assembler messages:
>   {standard input}:16055: Error: bad expression
>   {standard input}:16056: Error: bad expression
>   {standard input}:16057: Error: bad expression
>   {standard input}:16058: Error: bad expression
>   {standard input}:16059: Error: bad expression
>     CC      drivers/s390/char/raw3270.o
>     CC      net/ipv6/ip6_output.o
>   [...]
>     CC      net/xfrm/xfrm_output.o
>     CC      net/ipv6/ip6_input.o
>   {standard input}:16055: Error: invalid operands (*ABS* and *UND* sections) for `%'
>   {standard input}:16056: Error: invalid operands (*ABS* and *UND* sections) for `%'
>   {standard input}:16057: Error: invalid operands (*ABS* and *UND* sections) for `%'
>   {standard input}:16058: Error: invalid operands (*ABS* and *UND* sections) for `%'
>   {standard input}:16059: Error: invalid operands (*ABS* and *UND* sections) for `%'
>   make[3]: *** [scripts/Makefile.build:249: net/core/filter.o] Error 1
>   make[2]: *** [scripts/Makefile.build:465: net/core] Error 2
>   make[2]: *** Waiting for unfinished jobs....
>     CC      net/ipv4/tcp_fastopen.o
>   [...]
>     CC      lib/percpu-refcount.o
>   make[1]: *** [Makefile:1855: net] Error 2
>     CC      lib/rhashtable.o
>   make[1]: *** Waiting for unfinished jobs....
>     CC      lib/base64.o
>   [...]
>     AR      lib/built-in.a
>     CC      kernel/kheaders.o
>     AR      kernel/built-in.a
>   make: *** [Makefile:353: __build_one_by_one] Error 2
>   Error: Process completed with exit code 2.


it does not break on my cross build with gcc 12, but I can
reproduce with gcc 8 (CI seems to be on gcc 9)

the problem seems to be wrong assembler code with extra '%'
that's generated for patchable_function_entry(5)

gcc 8 generates:

.LPFE1:
        nopr    %%r0
        nopr    %%r0
        nopr    %%r0
        nopr    %%r0
        nopr    %%r0

and gcc 12 generates:

.LPFE1:
        nopr    %r0
        nopr    %r0
        nopr    %r0
        nopr    %r0
        nopr    %r0

perhaps we need to upgrade gcc in CI? cc-ing Ilya, any idea?

thanks,
jirka

> 
> > [1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
> > ---
> > Jiri Olsa (1):
> >        bpf: Move bpf_dispatcher function out of ftrace locations
> > 
> > Peter Zijlstra (Intel) (1):
> >        ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> > 
> >   arch/x86/Kconfig                  |  1 +
> >   include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
> >   include/linux/bpf.h               |  2 ++
> >   kernel/trace/Kconfig              |  6 ++++++
> >   tools/objtool/check.c             |  3 ++-
> >   5 files changed, 21 insertions(+), 2 deletions(-)
> > 
> 
