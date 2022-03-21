Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBEC4E348C
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiCUXkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiCUXke (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:40:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1216B502
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:38:51 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z7so18579762iom.1
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/SHCqhCrUCz638cI3GDGikQbywn1mOUhEbgKWDNN44=;
        b=Ro40EgBslrhZAaVxxppZ2eOlvD1RuNh4gBkvOA5KO+N30KCtOw7faYeif1aswWFnhM
         zMBQsvHmPLVksG+kt/gI3/hz1de53+DhIv5MKbploA0a99Ygjn1ew7jrhUMMzkyyG3XX
         x0eH/2ToXs/tRXQPpIEzZDF0Aj31mNpT9azn9ySU5vgAL8uWWy77Xo6eH08NeS+6fWib
         iAxapvfZHqE4ffjXWCos5TmrA9VN6WVMkLcD3EGIParXCuRZ14ITrotfiLUoNXEH57hD
         UGgZ8dpzx271ZoSfvPUD0/pSqM3Ko15vlSz7JkiGSvQl/RC0F63vdbkikEUz8q3MPPe9
         DtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/SHCqhCrUCz638cI3GDGikQbywn1mOUhEbgKWDNN44=;
        b=ge+jAeKAZSFRkrdTEfQWUhy8by2WLPLy2xaVBGyA26zqW/4tu/Ghe2AxmnK+8jgKP0
         qO8VagK6eojNlVjvGGFf6OXq8JQAdRfD9bGXNVUer7kD1ZSJ4ZkH/IEq7Ai87rA+K4vv
         7IV3UvumxJH9hMbIMrbrGsfghNaXf/ARH/CVjDHAt98WuyYZ7JRDhipwJkKWmR7Xf1Kb
         ZI41sJMhLxxBC3J6Uf3KoYfw6/Z0+DF4uHcOZnjhd9632wrD8g4xjqfKuNaB6cl4XGQb
         /fHgQLWTZy9LdcS4IBe7dDUUZWKkENhgycCok08XxGarChNVQxdxDJtC1NcazGgTeGiR
         Pe1Q==
X-Gm-Message-State: AOAM532yvBHEIeiWU4j5uYVmVsTwD1nOmmltlG/0iea/i+FqhrTy2MYD
        xsEtoCJcmm7jg9nJaI1HtljUvmzdXOpIC4JUqJ0psnX7
X-Google-Smtp-Source: ABdhPJwUlemYvwF1ABUqpG8tQP/ieFY8SC0DNTO+23ALeV0jNFVX3LRJCgdiItJVr7i5eIJJFfHo6o+P04WHwkazLHQ=
X-Received: by 2002:a02:a08c:0:b0:314:ede5:1461 with SMTP id
 g12-20020a02a08c000000b00314ede51461mr11932003jah.103.1647905930867; Mon, 21
 Mar 2022 16:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-3-kuifeng@fb.com>
 <CAEf4BzbYb6XOcBCeJCT0_MRZns6L04eYgnuYOm5Hg-5wHFaXEw@mail.gmail.com> <CAADnVQJq8sTmJir6bkrxQcJH452jrZ2ryN05_CRJ5acVyibTSQ@mail.gmail.com>
In-Reply-To: <CAADnVQJq8sTmJir6bkrxQcJH452jrZ2ryN05_CRJ5acVyibTSQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:38:39 -0700
Message-ID: <CAEf4BzbgfXm=mpF=7izpfpwC8YpC7ddXPUrbro0-dzSfBD75nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Mar 21, 2022 at 4:25 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 21, 2022 at 4:04 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Mar 15, 2022 at 5:44 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > >
> > > BPF trampolines will create a bpf_trace_run_ctx on their stacks, and
> > > set/reset the current bpf_run_ctx whenever calling/returning from a
> > > bpf_prog.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
> > >  include/linux/bpf.h         | 12 ++++++++----
> > >  kernel/bpf/syscall.c        |  4 ++--
> > >  kernel/bpf/trampoline.c     | 21 +++++++++++++++++----
> > >  4 files changed, 59 insertions(+), 10 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 54c695d49ec9..0b050aa2f159 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -580,9 +580,12 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
> > >   * [2..MAX_U64] - execute bpf prog and record execution time.
> > >   *     This is start time.
> > >   */
> > > -u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
> > > +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
> > >         __acquires(RCU)
> > >  {
> > > +       if (run_ctx)
> > > +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> > > +
> >
> > In all current cases we bpf_set_run_ctx() after migrate_disable and
> > rcu_read_lock, let's keep this consistent (even if I don't remember if
> > that order matters or not).
> >
> > >         rcu_read_lock();
> > >         migrate_disable();
> > >         if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
> > > @@ -614,17 +617,23 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
> > >         }
> > >  }
> > >
> > > -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> > > +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_trace_run_ctx *run_ctx)
> > >         __releases(RCU)
> > >  {
> > > +       if (run_ctx)
> > > +               bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> > > +
> > >         update_prog_stats(prog, start);
> > >         __this_cpu_dec(*(prog->active));
> > >         migrate_enable();
> > >         rcu_read_unlock();
> > >  }
> > >
> > > -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> > > +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
> > >  {
> > > +       if (run_ctx)
> > > +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> > > +
> > >         rcu_read_lock_trace();
> > >         migrate_disable();
> > >         might_fault();
> > > @@ -635,8 +644,12 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> > >         return bpf_prog_start_time();
> > >  }
> > >
> > > -void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
> > > +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
> > > +                                      struct bpf_trace_run_ctx *run_ctx)
> >
> > now that we have entire run_ctx, can we move `start` into run_ctx and
> > simplify __bpf_prog_enter/exit calls a bit? Or extra indirection will
> > hurt performance and won't be compensated by simpler enter/exit
> > calling convention?
>
> The "start" is an optional and temporary argument.
> I suspect it will look odd inside run_ctx.
> imo the current way is simpler.

So is saved_run_ctx (they have identical lifetimes), but I'm fine
either way. Was thinking it would result in simpler trampoline
generation code (both for humans and CPU), that's all.
