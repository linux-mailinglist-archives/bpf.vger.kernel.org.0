Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8459319B
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiHOPST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiHOPSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 11:18:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2C26AF0;
        Mon, 15 Aug 2022 08:17:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o22so9955088edc.10;
        Mon, 15 Aug 2022 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ouVrghtSSuQOBBxR3odg7fAexnfue10H0ZICw3MXbrE=;
        b=KN69bJhOi+4eHRQCQooNl+YS574QD0pXjZ97SDVn7Nphx/6UopnXXXT5nByoisxixB
         MNNKM3gDX4m6IhZgGUJM7AE4QKh8b9Xjyp6c/7f6Vcfqje8cnrP/Syq8PRM5+3/FHfh+
         FWsX+F5JGlp3SGhZQwJ7CO5Z1/YGYxIgXZv6s6Xr894+6Elc88/bY8WMCQTH5D9iuGfl
         avohwPMX43VYi3nVS3+xiAaPBE8jYi1VqRnXckcJQK4ydb/HAT4yg1/J1skRLBbWfAaa
         HpsVbpk/G52c4k+v9bjstxDMWRy7uJmOXDc789s9Otg1iOoRrUz0vAvP3+q/iTFNM6ir
         3WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ouVrghtSSuQOBBxR3odg7fAexnfue10H0ZICw3MXbrE=;
        b=bcJghvpptOtFLRua5J6k7BAPqg95Z3J/sPWHUP+8VQOcbHXUuG4bmoL6XStc49i/Wx
         6nKEwvPaEcryLhkwnD1dTF+yeFe3Wc7ZukDYbBTLqemSTqwLYqNz4cB5g2asQ0Gyi9iN
         7uWKCIqbFErkgI4qHZRMeZHsUI471mZQfA2atjlhsuduWRsuHxbl3ZARrViKZ2H7tN52
         LyidJnggkjO8Ie9bBmFBk1E/j5PZwxhZJj+zNRoLn8b9c9s9ClALTBhYjwgM2OjAGF3H
         GVodRv/b4drNU1/D1KlJj0SW08oEJ3A8YQaOTgbdVHVMxjliNJBzrVCy2MLNSYJIO6Oz
         anWQ==
X-Gm-Message-State: ACgBeo0nTTq+T8Vk6ZHXU68BlvPU7lsOkdcMqVfZzL2o2BF/u0rWxddC
        J1emUJ5Ua+UDoW/w8jYN7xoMwGf/RWPTgJVA+g0=
X-Google-Smtp-Source: AA6agR6znBWvxnvgOP58aUhDd8zXRF3Y6Yx/ME38hL9lJQe2zAMpdApa4tZUAH5dHr/DT8F0zwis196bjIqro8vpg4o=
X-Received: by 2002:a05:6402:3697:b0:443:1c6:acc3 with SMTP id
 ej23-20020a056402369700b0044301c6acc3mr15268812edb.421.1660576674799; Mon, 15
 Aug 2022 08:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220722174120.688768a3@gandalf.local.home> <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net> <YvoVgMzMuQbAEayk@krava>
 <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net> <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
 <YvpZJQGQdVaa2Oh4@worktop.programming.kicks-ass.net> <CAADnVQKyfrFTZOM9F77i0NbaXLZZ7KbvKBvu7p6kgdnRgG+2=Q@mail.gmail.com>
 <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
In-Reply-To: <Yvpf67eCerqaDmlE@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 08:17:42 -0700
Message-ID: <CAADnVQKX5xJz5N_mVyf7wg4BT8Q2cNh8ze-SxTRfk6KtcFQ0=Q@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 8:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 07:45:16AM -0700, Alexei Starovoitov wrote:
> > On Mon, Aug 15, 2022 at 7:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > It is in full control of the 'call __fentry__'. Absolute full NAK on you
> > > trying to make it otherwise.
> >
> > Don't mix 'call fentry' generated by the compiler with nop5 inserted
> > by macroses or JITs.
>
> Looking at:
>
>  https://lore.kernel.org/all/20191211123017.13212-3-bjorn.topel@gmail.com/
>
> this seems to want to prod at the __fentry__ sites.
>
> > > > Soon we will have nop5 in the middle of the function.
> > > > ftrace must not touch it.
> > >
> > > How are you generating that NOP and what for?
> >
> > We're generating nop5-s in JITed code to further
> > attach to.
>
> Ftrace doesn't know about those; so how can it break that?
>
> Likewise it doesn't know about the static_branch/static_call NOPs and
> nothing is broken.
>
> Ftrace only knows about the __fentry__ sites, and it *does* own them.
> Are you saying ftrace is writing to a code location not a __fentry__
> site?

Let's keep it in one thread:

> It wasn't long before. Yes it landed a few months prior to the
> static_call work, but the whole static_call thing was in progress for a
> long long time.
>
> Anyway, yes it is different. But it's still very much broken. You simply
> cannot step on __fentry__ sites like that.

Ask yourself: should static_call patching logic go through
ftrace infra ? No. Right?
static_call has nothing to do with ftrace (function tracing).
Same thing here. bpf dispatching logic is nothing to do with
function tracing.
In this case bpf_dispatcher_xdp_func is a placeholder written C.
If it was written in asm, fentry recording wouldn't have known about it.
And that's more or less what Jiri patch is doing.
It's hiding a fake function from ftrace, since it's not a function
and ftrace infra shouldn't show it tracing logs.
In other words it's a _notrace_ function with nop5.
