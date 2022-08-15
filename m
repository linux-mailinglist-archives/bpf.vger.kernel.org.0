Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA725930AA
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiHOOZl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243054AbiHOOZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 10:25:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665B612754;
        Mon, 15 Aug 2022 07:25:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so13771610ejc.10;
        Mon, 15 Aug 2022 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rBv/EtKNQsu4Ho+mwFizya2hNYTglt1r0iIr17ai3ek=;
        b=XAmu8c+LAk9Me1I3vra7NnsGvniBdp+S2b9omehR1nhcQxN9Bb95QkntR9TKvTjq9v
         dDga6p7dKng0JuNRhOD5tJtj1xF7wSxxEu7BdbG0L/LxGSpF9scTn9oGdIj7O0Wntz/u
         /44VyfRzPPrBRXFS+oMoa1+7/kyakvryt9hlAr6kmrGK4NcjnGNnz6RLtck6FfleOi/9
         sLVHTEjX540xrimptqjvmJ7roqkzHkcDWbx/yW7ECEUHxHEkOnXUqPWh4DmtYQqAtPkj
         PRcqaGBM70vBhy3AFzILaUEa4M5CECgbXnZq4YqJYHzlL2kKwW7waF692Lak2X3afYVV
         w7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rBv/EtKNQsu4Ho+mwFizya2hNYTglt1r0iIr17ai3ek=;
        b=2Ru7EB2it4KBjLcKnjuAv1IhN0I9w9Vg3bF4ZZFGawJxHQT3fClf4pDZrC7VvGY6/O
         9xDp7ECtpbqYTbhx0rLnKj+31IdlUYdzjMo6mBdD8FpP/g6v/IBQPtyF7TLtolZmXIIC
         3/IN/ioA4eejhWCs5eqOL1fmclS6L3WfppIlR/0Sv5jBcGikRWfUwFDQmOob3JPAVMHI
         vcXcR7LPhLowwYne4JEp6LOUuAp6VuyKwTxFkO/hSipCDsjnjW/OOyPWVMNyD7TizICL
         NRNk1J9e60L9w/kgTCBdSmYRGqxClwhxeyxj2k9C7AfTFSAcrGVIL8QJDM8xcNI4zzDA
         gJVw==
X-Gm-Message-State: ACgBeo1PdHGgTNGB88engf2NKIEJQQUoryNwBZZAvFHHK3eETc99ZFxK
        p1EUFoF2sOpwELQuwX2YyevrwiclArRXEYG25C6LTwHr1mg=
X-Google-Smtp-Source: AA6agR6ekY0zazLt2DfExbVoCwXuyEH9Hubcj8nLMjv8IYfy8Bdp/OyQX9k7IkVSdgqNoZBcpU7PnEjloe2MLv54VvM=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr10722633ejc.676.1660573535816; Mon, 15
 Aug 2022 07:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home> <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava> <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava> <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <Yvn9xR7qhXW7FnFL@worktop.programming.kicks-ass.net> <YvoVgMzMuQbAEayk@krava> <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
In-Reply-To: <Yvo+EpO9dN30G0XE@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 15 Aug 2022 07:25:24 -0700
Message-ID: <CAADnVQJfvn2RYydqgO-nS_K+C8WJL7BdCnR44MiMF4rnAwWM5A@mail.gmail.com>
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

On Mon, Aug 15, 2022 at 5:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 15, 2022 at 11:44:32AM +0200, Jiri Olsa wrote:
> > On Mon, Aug 15, 2022 at 10:03:17AM +0200, Peter Zijlstra wrote:
> > > On Sat, Aug 13, 2022 at 03:02:52PM -0400, Steven Rostedt wrote:
> > > > On Fri, 12 Aug 2022 23:18:15 +0200
> > > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > > the patch below moves the bpf function into sepatate object and switches
> > > > > off the -mrecord-mcount for it.. so the function gets profile call
> > > > > generated but it's not visible to ftrace
> > >
> > > Why ?!?
> >
> > there's bpf dispatcher code that updates bpf_dispatcher_xdp_func
> > function with bpf_arch_text_poke and that can race with ftrace update
> > if the function is traced
>
> I thought bpf_arch_text_poke() wasn't allowed to touch kernel code and
> ftrace is in full control of it ?

ftrace is not in "full control" of nop5 and must not be.
Soon we will have nop5 in the middle of the function.
ftrace must not touch it.
