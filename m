Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF504E3443
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiCUX2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiCUX2l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:28:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC837ABD
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:25:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s72so8660503pgc.5
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faGGXZff+1eZRnmcLsLXzV8MNspws6YAoo8jGjISyMI=;
        b=CmS/IyHnanppe1hkm8PuPU34821GCxVhrpQVx/ejKZ6tWgYDQrLMHCqd4YJtGUzTrG
         yvYod757XB9IU8pqkEX3mRVipL+T0R/7wfNyVS5mAkw4Ca8uoP/XdlDn78YaBkcsKPWZ
         fqk8VJwY4ymDu7rgc46k74gz82ICa4lrgQvYUwdMHwnccU/FDHevw95EszMz7uQU1/v1
         kWQEzIAKddu5eYeDMoX1ymn50zVVWTGBtmKvtFwfv7TTdSzI2js5UgbZNe4RBDrZ/tKa
         1gZJGx+WqedfBU/NPQmIiLaqc4jMrjWpl+J6ZNQbbJZSwVrtFjP9WDB3wCAH3TLPsBZ7
         lfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faGGXZff+1eZRnmcLsLXzV8MNspws6YAoo8jGjISyMI=;
        b=6vdKh8HA3qAB7kusSZ63+hEPUzb4YjWjxRizMNUaMiXUmk9mjGGqEBTzhJ0d1+kcDI
         B5mGQCe1f0ognPPyGpULjZwje3BG06PZ5EzFdoBSuhi+N7dQe7iwzEHa/6TLG4XFZUhv
         tX7T9qhrI9YxaQFxeqm1ve2WJr3jPbslyklep7pdvPBwiQ4wXMiyn/WO1CTi3QUXYBdV
         VTOdtXjubrWoBuHtWDz/EbhMBckfMM/tfLUvLPFa52A8ymCOAIoMDa81kDEj8MzLavgV
         du6Mqfd5hq8Bhp61mc2iX2da+oUDBwvDARcQg1Y9dQsejniCjLAMilYaHWksMGW8o++8
         nctg==
X-Gm-Message-State: AOAM530hYaXKt0bYInxV/L+RDiB5zEzmyIhp9+Q8jTz4sMTev1pV6/2j
        gmYuKMSRj8jQQvFp01Uq28FxSJIToWQj4JYCIDw=
X-Google-Smtp-Source: ABdhPJweiWd8288ceGkzj92eTuNVE5aJZQ/p2AGA/lVfn7eWhznb3zWFgxz+1Q0UAnvebAlh4D6vftZAG7mbjytManM=
X-Received: by 2002:aa7:805a:0:b0:4f6:dc68:5d41 with SMTP id
 y26-20020aa7805a000000b004f6dc685d41mr26096141pfm.69.1647905137492; Mon, 21
 Mar 2022 16:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-3-kuifeng@fb.com>
 <CAEf4BzbYb6XOcBCeJCT0_MRZns6L04eYgnuYOm5Hg-5wHFaXEw@mail.gmail.com>
In-Reply-To: <CAEf4BzbYb6XOcBCeJCT0_MRZns6L04eYgnuYOm5Hg-5wHFaXEw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Mar 2022 16:25:26 -0700
Message-ID: <CAADnVQJq8sTmJir6bkrxQcJH452jrZ2ryN05_CRJ5acVyibTSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Mar 21, 2022 at 4:04 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 5:44 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > BPF trampolines will create a bpf_trace_run_ctx on their stacks, and
> > set/reset the current bpf_run_ctx whenever calling/returning from a
> > bpf_prog.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/bpf.h         | 12 ++++++++----
> >  kernel/bpf/syscall.c        |  4 ++--
> >  kernel/bpf/trampoline.c     | 21 +++++++++++++++++----
> >  4 files changed, 59 insertions(+), 10 deletions(-)
> >
>
> [...]
>
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 54c695d49ec9..0b050aa2f159 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -580,9 +580,12 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
> >   * [2..MAX_U64] - execute bpf prog and record execution time.
> >   *     This is start time.
> >   */
> > -u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
> > +u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
> >         __acquires(RCU)
> >  {
> > +       if (run_ctx)
> > +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> > +
>
> In all current cases we bpf_set_run_ctx() after migrate_disable and
> rcu_read_lock, let's keep this consistent (even if I don't remember if
> that order matters or not).
>
> >         rcu_read_lock();
> >         migrate_disable();
> >         if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
> > @@ -614,17 +617,23 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
> >         }
> >  }
> >
> > -void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
> > +void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_trace_run_ctx *run_ctx)
> >         __releases(RCU)
> >  {
> > +       if (run_ctx)
> > +               bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> > +
> >         update_prog_stats(prog, start);
> >         __this_cpu_dec(*(prog->active));
> >         migrate_enable();
> >         rcu_read_unlock();
> >  }
> >
> > -u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> > +u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_trace_run_ctx *run_ctx)
> >  {
> > +       if (run_ctx)
> > +               run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
> > +
> >         rcu_read_lock_trace();
> >         migrate_disable();
> >         might_fault();
> > @@ -635,8 +644,12 @@ u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog)
> >         return bpf_prog_start_time();
> >  }
> >
> > -void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start)
> > +void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
> > +                                      struct bpf_trace_run_ctx *run_ctx)
>
> now that we have entire run_ctx, can we move `start` into run_ctx and
> simplify __bpf_prog_enter/exit calls a bit? Or extra indirection will
> hurt performance and won't be compensated by simpler enter/exit
> calling convention?

The "start" is an optional and temporary argument.
I suspect it will look odd inside run_ctx.
imo the current way is simpler.
