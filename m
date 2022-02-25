Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E24C4467
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 13:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiBYMP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 07:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiBYMP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 07:15:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928D22A281;
        Fri, 25 Feb 2022 04:14:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x5so7111472edd.11;
        Fri, 25 Feb 2022 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A2FVJDFG4ibaxj79FQb/YJJI3anhvnerrRSVnXQAfAw=;
        b=dt/lNJw72+T81FEiDA19lduriUfnxHeIltO1nP7R28UfWgjrDo62JCHLS6Vh6aRk+U
         EpZwHd933a3Geua4QsuCnNeVbl6Zgf/6Gw/ukBtyXh3GlW3HW1/7DN+7EdTOgTGNoRSq
         aRqAGDbuXZgxPocxlFmnuaWuFJ7ndrmpxIZQa2ItnGwHTbwohtH0spBZGBs0VI9waHNw
         xVRF7225Nar4n4ElEdcMpkvcYDtlT//Qt2H9rf2P8lY0eM85HUseKuCKyrttUtiXhREg
         8tSiKOMRylyt2EafCF820vhePFON2MyE0++vHu9Z2pTGtZ/8nyOtrAeG+khFdiOnC2bT
         csbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A2FVJDFG4ibaxj79FQb/YJJI3anhvnerrRSVnXQAfAw=;
        b=A1vktcSYAs84O0WxpwuSeqAQ7KxNJT0kjyJ5/dQ7JLXeN6+iESwN6qddqzXHJZ+sMi
         VAceox+ShKTdoEt9Zdzi0qpuE7ewoMmMclr7p37bHG2+FdUJ00EiMkiNT7parYLa5dBy
         YvLnIeFn1xuUTKGW5JXCJmFNKaB2mgj0S8SiKnd631oeQXJEeA2iwuJDqszMLv1LCcSU
         wSCKDzn79lw393sV85hpI6vcPquKhL/lK6BFjFm8aKRlvqd1CokJJY79UfjQqmhI6Bru
         UvmwuGh3E5q2gRWq5ryJILgYqj3x6FW7QAWXmfA1yBQVXob3+O0aSapqOONCktkXnTUV
         xBjQ==
X-Gm-Message-State: AOAM5318QirpnEKy6rRxSwaWDpsnUNVkvzFBuMbnZCd/knLGG1Uq2V8R
        XAm49AgLdRn8eI3wCuw0Iq0=
X-Google-Smtp-Source: ABdhPJxMYT46AhwHEC2FZp0SSxqfNdIQMflUJ8Wv/R3v3/j7jgnFrrQU5XfuKQaVFvbrh/vOsU8mdQ==
X-Received: by 2002:aa7:d2da:0:b0:410:b9f1:ff35 with SMTP id k26-20020aa7d2da000000b00410b9f1ff35mr6947663edr.217.1645791292336;
        Fri, 25 Feb 2022 04:14:52 -0800 (PST)
Received: from krava ([83.240.63.118])
        by smtp.gmail.com with ESMTPSA id o8-20020a50d808000000b00412b240e008sm1236389edj.69.2022.02.25.04.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:14:51 -0800 (PST)
Date:   Fri, 25 Feb 2022 13:14:49 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/3] perf tools: Rework prologue generation code
Message-ID: <YhjIOX5BDYh4SRZB@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
 <Yg9geQ0LJjhnrc7j@krava>
 <CAEf4BzZaFWhWf73JbfO7gLi82Nn4ma-qmaZBPij=giNzzoSCTQ@mail.gmail.com>
 <YhJF00d9baPtXjzH@krava>
 <CAEf4BzaiBO3_617kkXZdYJ8hS8YF--ZLgapNbgeeEJ-pY0H88g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaiBO3_617kkXZdYJ8hS8YF--ZLgapNbgeeEJ-pY0H88g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 23, 2022 at 02:29:56PM -0800, Andrii Nakryiko wrote:

SNIP

> > and R3 is loaded in the prologue code (first 15 instructions)
> > and it also sets 'err' (R2) with the result of the reading:
> >
> >            0: (bf) r6 = r1
> >            1: (79) r3 = *(u64 *)(r6 +96)
> >            2: (bf) r7 = r10
> >            3: (07) r7 += -8
> >            4: (7b) *(u64 *)(r10 -8) = r3
> >            5: (b7) r2 = 8
> >            6: (bf) r1 = r7
> >            7: (85) call bpf_probe_read_user#-60848
> >            8: (55) if r0 != 0x0 goto pc+2
> >            9: (61) r3 = *(u32 *)(r10 -8)
> >           10: (05) goto pc+3
> >           11: (b7) r2 = 1
> >           12: (b7) r3 = 0
> >           13: (05) goto pc+1
> >           14: (b7) r2 = 0
> >           15: (bf) r1 = r6
> >
> >           16: (b7) r1 = 100
> >           17: (6b) *(u16 *)(r10 -8) = r1
> >           18: (18) r1 = 0x6c25203a6f697270
> >           20: (7b) *(u64 *)(r10 -16) = r1
> >           21: (bf) r1 = r10
> >           22: (07) r1 += -16
> >           23: (b7) r2 = 10
> >           24: (85) call bpf_trace_printk#-54848
> >           25: (b7) r0 = 1
> >           26: (95) exit
> >
> >
> > I'm still scratching my head how to workaround this.. we do want maps
> > and all the other updates to the code, but verifier won't let it pass
> > without the prologue code
> 
> ugh, perf cornered itself into supporting this crazy scheme and now

well, it just used the interface that was provided at the time

> there is no good solution. I'm still questioning the value of
> supporting this going forward. Is there an evidence that anyone is
> using this functionality at all? Is it worth it trying to carry it on
> just because we have some example that exercises this feature?

yea we discussed this again and I think we can somehow mark this
feature in perf as deprecated and remove it after some time,
because even with the workaround below it'll be pita ;-)

or people will come and scream and we will find some other solution

I already sent the rest of the changes (prog/map priv) separately
and will send some RFC for the deprecation

thanks,
jirka

> 
> Anyways, one way to solve this is to add bpf_program__set_insns() that
> could be called from prog_init_fn callback (which I just realized
> hasn't landed yet, I'll send v4 today) to prepend a simple preamble
> like this:
> 
> r1 = 0;
> r2 = 0;
> r3 = 0;
> f4 = 0;
> r5 = 0; /* how many input arguments we support? */
> 
> This will make all input arguments initialized, libbpf will be able to
> adjust all the relocations and stuff. Once this "prototype program" is
> loaded, perf can grab final instructions and replace first X
> instructions with desired preamble.
> 
> But... ugliness and horror, yeah :(
> 
> 
> >
> > jirka
