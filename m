Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6869B524
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 22:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBQV6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 16:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQV6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 16:58:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A359726
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 13:58:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ez12so9449478edb.1
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WTy1fGrOcoSCfQOCKC4t8WY9YDzwm0LovsNEh6jPL1U=;
        b=fsNpCm8/8EHNmocH+ChZV4J7MZWIbvI4sLcVpIXCVnSouMRbXTatYm6xknb6hGZQcZ
         KPDH7FTvNhyiYCk8l3+cl2slglImjl1g79TJSnuoeYmwTvKpQBJVWsuV+iBTUbxVOY/8
         mNFyJnJHEeqihr2vPle5p+fgM5PAlzNEDm9vPHtOsyqDlqvZQ1Qy+Gq1826V7w2Utrh0
         XdcCQh/9OCU5FDlvGkcLp9W4xXly62zFJVmu+1UL/vguR0+gXexFupxmGELcPJpro4qs
         n+gl4Mgzmir9YOg8vYM/P8O6Oz6a12QxqrsHfWeUl3duJPhoI37iMrMoUM13uSKE0Yaa
         Tmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTy1fGrOcoSCfQOCKC4t8WY9YDzwm0LovsNEh6jPL1U=;
        b=7z5HuR1XyfH8suMehi5Cm+KKAXMVg7QOdke7WTvk3uJEQjbZtGeWBdjuPI1YdIwLIL
         yqLovxf6zVRTiohcPZHUo1b3MjwkAJVojxYOpjDtKU/tBKzMNfkAiGDBbha/GULNGLg2
         G9oHMmrLDADFpWLvdGYakhmZ5sCM8CXmSagHm3Y7/3Ht7nvI3El7f/8MnTaF3T1fcTFl
         6/Pb1AnXzsdxqZvSDBgHR8V2X/pIrjH76sAjCmMXCpAaB7bboWa3znEw+r4chdDb2t6v
         s1fuxHxRgRCvOf578AsCF4p2uccmLBdNrLvnESRIMtgNRp86WgKERooZ2D9tEvHbidx/
         h16Q==
X-Gm-Message-State: AO0yUKUQxR03npxdGrfABjqLLL0kAtM8y+mvz7ImS6s0TrY/LnWThQEQ
        4oXanvKh3SJoE2TvQgeo6fVz9f4MifROuZrfXxY=
X-Google-Smtp-Source: AK7set9qR0bAr5hD0F8SPxTOpmhhRxud/QUSuyWguGIL7olxbeXIgE7N6BezwUdUi04iWfxb3BwK62C88iIYe7ftssM=
X-Received: by 2002:a17:906:b746:b0:88d:64e7:a2be with SMTP id
 fx6-20020a170906b74600b0088d64e7a2bemr1034950ejb.15.1676671122360; Fri, 17
 Feb 2023 13:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20230216183606.2483834-1-eddyz87@gmail.com> <20230216183606.2483834-2-eddyz87@gmail.com>
 <CAEf4Bza5rbWbgHW96d+G5n3Wn6eUTs8USO3oXEsH3pFX8kVqbQ@mail.gmail.com> <15b495c31b7aa6ed5ec6805a7d04e914788c0d1a.camel@gmail.com>
In-Reply-To: <15b495c31b7aa6ed5ec6805a7d04e914788c0d1a.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Feb 2023 13:58:30 -0800
Message-ID: <CAEf4Bzaxh56m6gpujDxiLnEWUi748kexwRigb6a0xnanXTsXzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow reads from uninit stack
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 5:13 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2023-02-16 at 16:36 -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 16, 2023 at 10:36 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > This commits updates the following functions to allow reads from
> > > uninitialized stack locations when env->allow_uninit_stack option is
> > > enabled:
> > > - check_stack_read_fixed_off()
> > > - check_stack_range_initialized(), called from:
> > >   - check_stack_read_var_off()
> > >   - check_helper_mem_access()
> > >
> > > Such change allows to relax logic in stacksafe() to treat STACK_MISC
> > > and STACK_INVALID in a same way and make the following stack slot
> > > configurations equivalent:
> > >
> > >   |  Cached state    |  Current state   |
> > >   |   stack slot     |   stack slot     |
> > >   |------------------+------------------|
> > >   | STACK_INVALID or | STACK_INVALID or |
> > >   | STACK_MISC       | STACK_SPILL   or |
> > >   |                  | STACK_MISC    or |
> > >   |                  | STACK_ZERO    or |
> > >   |                  | STACK_DYNPTR     |
> > >
> > > This leads to significant verification speed gains (see below).
> > >
> > > The idea was suggested by Andrii Nakryiko [1] and initial patch was
> > > created by Alexei Starovoitov [2].
> > >
> > > Currently the env->allow_uninit_stack is allowed for programs loaded
> > > by users with CAP_PERFMON or CAP_SYS_ADMIN capabilities.
> > >
> > > A number of test cases from verifier/*.c were expecting uninitialized
> > > stack access to be an error. These test cases were updated to execute
> > > in unprivileged mode (thus preserving the tests).
> > >
> > > The test progs/test_global_func10.c expected "invalid indirect access
> > > to stack" error message because of the access to uninitialized memory
> > > region. The test is updated to provoke the same error message by
> > > accessing stack out of allocated range.
> > >
> > > The following tests had to be removed because these can't be made
> > > unprivileged:
> > > - verifier/sock.c:
> > >   - "sk_storage_get(map, skb->sk, &stack_value, 1): partially init
> > >   stack_value"
> > >   BPF_PROG_TYPE_SCHED_CLS programs are not executed in unprivileged mode.
> > > - verifier/var_off.c:
> > >   - "indirect variable-offset stack access, max_off+size > max_initialized"
> > >   - "indirect variable-offset stack access, uninitialized"
> > >   These tests verify that access to uninitialized stack values is
> > >   detected when stack offset is not a constant. However, variable
> > >   stack access is prohibited in unprivileged mode, thus these tests
> > >   are no longer valid.
> > >
> > >  * * *
> > >
> > > Here is veristat log comparing this patch with current master on a
> > > set of selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
> > > and cilium BPF binaries (see [3]):
> > >
> > > $ ./veristat -e file,prog,states -C -f 'states_pct<-30' master.log current.log
> > > File                        Program                     States (A)  States (B)  States    (DIFF)
> > > --------------------------  --------------------------  ----------  ----------  ----------------
> > > bpf_host.o                  tail_handle_ipv6_from_host         349         244    -105 (-30.09%)
> > > bpf_host.o                  tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
> > > bpf_lxc.o                   tail_handle_nat_fwd_ipv4          1320         895    -425 (-32.20%)
> > > bpf_sock.o                  cil_sock4_connect                   70          48     -22 (-31.43%)
> > > bpf_sock.o                  cil_sock4_sendmsg                   68          46     -22 (-32.35%)
> > > bpf_xdp.o                   tail_handle_nat_fwd_ipv4          1554         803    -751 (-48.33%)
> > > bpf_xdp.o                   tail_lb_ipv4                      6457        2473   -3984 (-61.70%)
> > > bpf_xdp.o                   tail_lb_ipv6                      7249        3908   -3341 (-46.09%)
> > > pyperf600_bpf_loop.bpf.o    on_event                           287         145    -142 (-49.48%)
> > > strobemeta.bpf.o            on_event                         15915        4772  -11143 (-70.02%)
> > > strobemeta_nounroll2.bpf.o  on_event                         17087        3820  -13267 (-77.64%)
> > > xdp_synproxy_kern.bpf.o     syncookie_tc                     21271        6635  -14636 (-68.81%)
> > > xdp_synproxy_kern.bpf.o     syncookie_xdp                    23122        6024  -17098 (-73.95%)
> > > --------------------------  --------------------------  ----------  ----------  ----------------
> > >
> > > Note: I limited selection by states_pct<-30%.
> > >
> > > Inspection of differences in pyperf600_bpf_loop behavior shows that
> > > the following patch for the test removes almost all differences:
> > >
> > >     - a/tools/testing/selftests/bpf/progs/pyperf.h
> > >     + b/tools/testing/selftests/bpf/progs/pyperf.h
> > >     @ -266,8 +266,8 @ int __on_event(struct bpf_raw_tracepoint_args *ctx)
> > >             }
> > >
> > >             if (event->pthread_match || !pidData->use_tls) {
> > >     -               void* frame_ptr;
> > >     -               FrameData frame;
> > >     +               void* frame_ptr = 0;
> > >     +               FrameData frame = {};
> > >                     Symbol sym = {};
> > >                     int cur_cpu = bpf_get_smp_processor_id();
> > >
> > > W/o this patch the difference comes from the following pattern
> > > (for different variables):
> > >
> > >     static bool get_frame_data(... FrameData *frame ...)
> > >     {
> > >         ...
> > >         bpf_probe_read_user(&frame->f_code, ...);
> > >         if (!frame->f_code)
> > >             return false;
> > >         ...
> > >         bpf_probe_read_user(&frame->co_name, ...);
> > >         if (frame->co_name)
> > >             ...;
> > >     }
> > >
> > >     int __on_event(struct bpf_raw_tracepoint_args *ctx)
> > >     {
> > >         FrameData frame;
> > >         ...
> > >         get_frame_data(... &frame ...) // indirectly via a bpf_loop & callback
> > >         ...
> > >     }
> > >
> > >     SEC("raw_tracepoint/kfree_skb")
> > >     int on_event(struct bpf_raw_tracepoint_args* ctx)
> > >     {
> > >         ...
> > >         ret |= __on_event(ctx);
> > >         ret |= __on_event(ctx);
> > >         ...
> > >     }
> > >
> > > With regards to value `frame->co_name` the following is important:
> > > - Because of the conditional `if (!frame->f_code)` each call to
> > >   __on_event() produces two states, one with `frame->co_name` marked
> > >   as STACK_MISC, another with it as is (and marked STACK_INVALID on a
> > >   first call).
> > > - The call to bpf_probe_read_user() does not mark stack slots
> > >   corresponding to `&frame->co_name` as REG_LIVE_WRITTEN but it marks
> > >   these slots as BPF_MISC, this happens because of the following loop
> > >   in the check_helper_call():
> > >
> > >         for (i = 0; i < meta.access_size; i++) {
> > >                 err = check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
> > >                                        BPF_WRITE, -1, false);
> > >                 if (err)
> > >                         return err;
> > >         }
> > >
> > >   Note the size of the write, it is a one byte write for each byte
> > >   touched by a helper. The BPF_B write does not lead to write marks
> > >   for the target stack slot.
> > > - Which means that w/o this patch when second __on_event() call is
> > >   verified `if (frame->co_name)` will propagate read marks first to a
> > >   stack slot with STACK_MISC marks and second to a stack slot with
> > >   STACK_INVALID marks and these states would be considered different.
> > >
> > > [1] https://lore.kernel.org/bpf/CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com/
> > > [2] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
> > > [3] git@github.com:anakryiko/cilium.git
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c                         |  10 ++
> > >  .../selftests/bpf/progs/test_global_func10.c  |   6 +-
> > >  tools/testing/selftests/bpf/verifier/calls.c  |  13 ++-
> > >  .../bpf/verifier/helper_access_var_len.c      | 104 ++++++++++++------
> > >  .../testing/selftests/bpf/verifier/int_ptr.c  |   9 +-
> > >  .../selftests/bpf/verifier/search_pruning.c   |  13 ++-
> > >  tools/testing/selftests/bpf/verifier/sock.c   |  27 -----
> > >  .../selftests/bpf/verifier/spill_fill.c       |   7 +-
> > >  .../testing/selftests/bpf/verifier/var_off.c  |  52 ---------
> > >  9 files changed, 107 insertions(+), 134 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 272563a0b770..6fbd0e25ccab 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3826,6 +3826,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
> > >                                                 continue;
> > >                                         if (type == STACK_MISC)
> > >                                                 continue;
> > > +                                       if (type == STACK_INVALID && env->allow_uninit_stack)
> > > +                                               continue;
> > >                                         verbose(env, "invalid read from stack off %d+%d size %d\n",
> > >                                                 off, i, size);
> > >                                         return -EACCES;
> > > @@ -3863,6 +3865,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
> > >                                 continue;
> > >                         if (type == STACK_ZERO)
> > >                                 continue;
> > > +                       if (type == STACK_INVALID && env->allow_uninit_stack)
> > > +                               continue;
> > >                         verbose(env, "invalid read from stack off %d+%d size %d\n",
> > >                                 off, i, size);
> > >                         return -EACCES;
> > > @@ -5761,6 +5765,8 @@ static int check_stack_range_initialized(
> > >                         }
> > >                         goto mark;
> > >                 }
> > > +               if (*stype == STACK_INVALID && env->allow_uninit_stack)
> > > +                       goto mark;
> >
> > should we support clobber and conversion to STACK_MISC like we do for
> > STACK_ZERO? If yes, probably cleaner to just extend condition to
> >
> > if ((*stype == STACK_ZERO) || (*stype == STACK_INVALID &&
> > env->allow_uninit_stack))
> >
> > ?
>
> As far as I understand, conversion of STACK_ZERO to STACK_MISC is
> necessary for safety reasons (like we can't be sure that memory will
> remain STACK_ZERO after clobber call).
>
> However for STACK_INVALID -> STACK_MISC case, I don't think there is a
> way to observe such change (apart from log output). After this patch
> there would be no difference between STACK_INVALID and STACK_MISC in
> privileged mode.
>
> Hence, such change is a matter of style and does not affect verifier
> behavior. If you think that the following is more concise:
>
>                 if ((*stype == STACK_ZERO) ||
>                     (*stype == STACK_INVALID && env->allow_uninit_stack)) {
>                         if (clobber) {
>                                 /* helper can write anything into the stack */
>                                 *stype = STACK_MISC;
>                         }
>                         goto mark;
>                 }
>
> I can make this update and add appropriate test, checking log output.
> Personally, I that intent would be more clear if the current notation
> is preserved.

It seems like the clobber flag is used when helper is writing out data
into stack memory. So it makes sense to represent that memory as
initialized but unknown, that is STACK_MISC. It's not INVALID anymore
after the helper call, is my point.

>
> >
> >
> > Other than that, looks good:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > >
> > >                 if (is_spilled_reg(&state->stack[spi]) &&
> > >                     (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
> > > @@ -13936,6 +13942,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
> > >                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
> > >                         continue;
> > >
> > > +               if (env->allow_uninit_stack &&
> > > +                   old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
> > > +                       continue;
> > > +
> > >                 /* explored stack has more populated slots than current stack
> > >                  * and these slots were used
> > >                  */
> >
> > [...]
>
