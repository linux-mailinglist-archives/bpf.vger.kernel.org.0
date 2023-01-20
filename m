Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC06747E3
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 01:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjATAQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 19:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATAQt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 19:16:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C5A296B
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 16:16:47 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so10093718ejc.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 16:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qOF2FRjBl7aUv2hW79G2fw8Id3l5jrcHNFw2k2S6tUk=;
        b=hH31UVh4J3WUEctgjd0/y9NDxQsioJbf6GuvnnHDCA1HpF/9t11Ya0OVS1ctzbKVah
         qdayDKZG89z5a9A+Sd2ClSyVRliKyrHhclYU3fqBjPbs4j4cfoPuhcgSto6H7FtUkWys
         Vfvh5gz0/3ChnB4xpW5t487ppWw5nalqlCv3Dw3aNSFnvg2mrDYp1kMtd0vZAnG3f+R7
         8eUiHrUEkCCR8oAYW6UhppSGyDTv5b719FY6fjhvDAd/wVShzB/r0sS1Sx/HsYU2Q4oi
         csh+jIzmtpK+LSBEyjoqDplpxonx/ETg3qRbgsW6P80FP/NxdcAvNT1bX17VgWXbRvct
         5iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOF2FRjBl7aUv2hW79G2fw8Id3l5jrcHNFw2k2S6tUk=;
        b=DpJ21ALmGtWnnBnnQ3lXzUmjjZ4RUqCHpM/kzFtRTSk5tVvAFjKwV4LbNGrjEoOP9n
         OAu1r+pTfGEZoG/kKTg0qEZFPNYxbKbk3zotmgMNkImmrg8ErexmDvYhxTF7t871lnZe
         U1NQyvq50xWpYCzRgep/y8ZF5RqHVtPhjMa8kXWuuFCAtgMYxjvvzwCH5U2eJBnS3BOt
         bfZ7jSqyLR1IJa5MUplpFeJzQPIHj/X1Xl1MC7adROAX1AgP9tCY/NaGryX6OjX8vYJX
         +1oKqPVjCgtiWz/E/2aXWaTyKIIcjpJj8Wkxk9OGKiVM1YuXNR+207CRpPCu2x0DtTI8
         KIaA==
X-Gm-Message-State: AFqh2kp3pxPOzEOobqbAy0OLfnbb8mMd6bUpF55+j6HyjJqw2CtxKGBf
        zNGsPwPHZLFmQHSfqJod93Vu31sSaRsRpuQlvgU=
X-Google-Smtp-Source: AMrXdXvEURny9IpWP2MJTuavowMrI6twyeXAdHLHyPBihwX6Wx88P38uKhouCX5JArb+ApodNM8zns90VKhUXDmlqOc=
X-Received: by 2002:a17:906:8294:b0:867:cbca:a397 with SMTP id
 h20-20020a170906829400b00867cbcaa397mr1072939ejx.87.1674173806087; Thu, 19
 Jan 2023 16:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20230106142214.1040390-1-eddyz87@gmail.com> <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
 <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
 <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
 <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
 <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
 <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com> <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
In-Reply-To: <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 16:16:34 -0800
Message-ID: <CAADnVQLybn06cYYV3uf3FeAGMjOiL5riRzhV6f9fuFOHr9bL=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
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

On Thu, Jan 19, 2023 at 3:52 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 13, 2023 at 5:31 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 13, 2023 at 5:17 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jan 13, 2023 at 4:10 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > >
> > > > On Fri, 2023-01-13 at 14:22 -0800, Andrii Nakryiko wrote:
> > > > > On Fri, Jan 13, 2023 at 12:02 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
> > > > > > [...]
> > > > > > >
> > > > > > > I'm wondering if we should consider allowing uninitialized
> > > > > > > (STACK_INVALID) reads from stack, in general. It feels like it's
> > > > > > > causing more issues than is actually helpful in practice. Common code
> > > > > > > pattern is to __builtin_memset() some struct first, and only then
> > > > > > > initialize it, basically doing unnecessary work of zeroing out. All
> > > > > > > just to avoid verifier to complain about some irrelevant padding not
> > > > > > > being initialized. I haven't thought about this much, but it feels
> > > > > > > that STACK_MISC (initialized, but unknown scalar value) is basically
> > > > > > > equivalent to STACK_INVALID for all intents and purposes. Thoughts?
> > > > > >
> > > > > > Do you have an example of the __builtin_memset() usage?
> > > > > > I tried passing partially initialized stack allocated structure to
> > > > > > bpf_map_update_elem() and bpf_probe_write_user() and verifier did not
> > > > > > complain.
> > > > > >
> > > > > > Regarding STACK_MISC vs STACK_INVALID, I think it's ok to replace
> > > > > > STACK_INVALID with STACK_MISC if we are talking about STX/LDX/ALU
> > > > > > instructions because after LDX you would get a full range register and
> > > > > > you can't do much with a full range value. However, if a structure
> > > > > > containing un-initialized fields (e.g. not just padding) is passed to
> > > > > > a helper or kfunc is it an error?
> > > > >
> > > > > if we are passing stack as a memory to helper/kfunc (which should be
> > > > > the only valid use case with STACK_MISC, right?), then I think we
> > > > > expect helper/kfunc to treat it as memory with unknowable contents.
> > > > > Not sure if I'm missing something, but MISC says it's some unknown
> > > > > value, and the only difference between INVALID and MISC is that MISC's
> > > > > value was written by program explicitly, while for INVALID that
> > > > > garbage value was there on the stack already (but still unknowable
> > > > > scalar), which effectively is the same thing.
> > > >
> > > > I looked through the places where STACK_INVALID is used, here is the list:
> > > >
> > > > - unmark_stack_slots_dynptr()
> > > >   Destroy dynptr marks. Suppose STACK_INVALID is replaced by
> > > >   STACK_MISC here, in this case a scalar read would be possible from
> > > >   such slot, which in turn might lead to pointer leak.
> > > >   Might be a problem?
> > >
> > > We are already talking to enable reading STACK_DYNPTR slots directly.
> > > So not a problem?
> > >
> > > >
> > > > - scrub_spilled_slot()
> > > >   mark spill slot STACK_MISC if not STACK_INVALID
> > > >   Called from:
> > > >   - save_register_state() called from check_stack_write_fixed_off()
> > > >     Would mark not all slots only for 32-bit writes.
> > > >   - check_stack_write_fixed_off() for insns like `fp[-8] = <const>` to
> > > >     destroy previous stack marks.
> > > >   - check_stack_range_initialized()
> > > >     here it always marks all 8 spi slots as STACK_MISC.
> > > >   Looks like STACK_MISC instead of STACK_INVALID wouldn't make a
> > > >   difference in these cases.
> > > >
> > > > - check_stack_write_fixed_off()
> > > >   Mark insn as sanitize_stack_spill if pointer is spilled to a stack
> > > >   slot that is marked STACK_INVALID. This one is a bit strange.
> > > >   E.g. the program like this:
> > > >
> > > >     ...
> > > >     42:  fp[-8] = ptr
> > > >     ...
> > > >
> > > >   Will mark insn (42) as sanitize_stack_spill.
> > > >   However, the program like this:
> > > >
> > > >     ...
> > > >     21:  fp[-8] = 22   ;; marks as STACK_MISC
> > > >     ...
> > > >     42:  fp[-8] = ptr
> > > >     ...
> > > >
> > > >   Won't mark insn (42) as sanitize_stack_spill, which seems strange.
> > > >
> > > > - stack_write_var_off()
> > > >   If !env->allow_ptr_leaks only allow writes if slots are not
> > > >   STACK_INVALID. I'm not sure I understand the intention.
> > > >
> > > > - clean_func_state()
> > > >   STACK_INVALID is used to mark spi's that are not REG_LIVE_READ as
> > > >   such that should not take part in the state comparison. However,
> > > >   stacksafe() has REG_LIVE_READ check as well, so this marking might
> > > >   be unnecessary.
> > > >
> > > > - stacksafe()
> > > >   STACK_INVALID is used as a mark that some bytes of an spi are not
> > > >   important in a state cached for state comparison. E.g. a slot in an
> > > >   old state might be marked 'mmmm????' and 'mmmmmmmm' or 'mmmm0000' in
> > > >   a new state. However other checks in stacksafe() would catch these
> > > >   variations.
> > > >
> > > > The conclusion being that some pointer leakage checks might need
> > > > adjustment if STACK_INVALID is replaced by STACK_MISC.
> > >
> > > Just to be clear. My suggestion was to *treat* STACK_INVALID as
> > > equivalent to STACK_MISC in stacksafe(), not really replace all the
> > > uses of STACK_INVALID with STACK_MISC. And to be on the safe side, I'd
> > > do it only if env->allow_ptr_leaks, of course.
> >
> > Well, that, and to allow STACK_INVALID if env->allow_ptr_leaks in
> > check_stack_read_fixed_off(), of course, to avoid "invalid read from
> > stack off %d+%d size %d\n" error (that's fixing at least part of the
> > problem with uninitialized struct padding).
>
> +1 to Andrii's idea.
> It should help us recover this small increase in processed states.
>
> Eduard,
>
> The fix itself is brilliant. Thank you for investigating
> and providing the detailed explanation.
> I've read this thread and the previous one,
> walked through all the points and it all looks correct.
> Sorry it took me a long time to remember the details
> of liveness logic to review it properly.
>
> While you, Andrii and me keep this tricky knowledge in our
> heads could you please document how liveness works in
> Documentation/bpf/verifier.rst ?
> We'll be able to review it now and next time it will be
> easier to remember.
>
> I've tried Andrii's suggestion:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7ee218827259..0f71ba6a56e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3591,7 +3591,7 @@ static int check_stack_read_fixed_off(struct
> bpf_verifier_env *env,
>
> copy_register_state(&state->regs[dst_regno], reg);
>                                 state->regs[dst_regno].subreg_def = subreg_def;
>                         } else {
> -                               for (i = 0; i < size; i++) {
> +                               for (i = 0; i < size &&
> !env->allow_uninit_stack; i++) {
>                                         type = stype[(slot - i) % BPF_REG_SIZE];
>                                         if (type == STACK_SPILL)
>                                                 continue;
> @@ -3628,7 +3628,7 @@ static int check_stack_read_fixed_off(struct
> bpf_verifier_env *env,
>                 }
>                 mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
>         } else {
> -               for (i = 0; i < size; i++) {
> +               for (i = 0; i < size && !env->allow_uninit_stack; i++) {
>                         type = stype[(slot - i) % BPF_REG_SIZE];
>                         if (type == STACK_MISC)
>                                 continue;
> @@ -13208,6 +13208,10 @@ static bool stacksafe(struct bpf_verifier_env
> *env, struct bpf_func_state *old,
>                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] ==
> STACK_INVALID)
>                         continue;
>
> +               if (env->allow_uninit_stack &&
> +                   old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
> +                       continue;
>
> and only dynptr/invalid_read[134] tests failed
> which is expected and acceptable.
> We can tweak those tests.
>
> Could you take over this diff, run veristat analysis and
> submit it as an official patch? I suspect we should see nice
> improvements in states processed.

Indeed, some massive improvements:
./veristat -e file,prog,states -C -f 'states_diff<-10' bb aa
File                              Program                  States (A)
States (B)  States    (DIFF)
--------------------------------  -----------------------  ----------
----------  ----------------
bpf_flow.bpf.o                    flow_dissector_0                 78
        67     -11 (-14.10%)
loop6.bpf.o                       trace_virtqueue_add_sgs         336
       316      -20 (-5.95%)
pyperf100.bpf.o                   on_event                       6213
      4670   -1543 (-24.84%)
pyperf180.bpf.o                   on_event                      11470
      8364   -3106 (-27.08%)
pyperf50.bpf.o                    on_event                       3263
      2370    -893 (-27.37%)
pyperf600.bpf.o                   on_event                      30335
     22200   -8135 (-26.82%)
pyperf600_bpf_loop.bpf.o          on_event                        287
       145    -142 (-49.48%)
pyperf600_nounroll.bpf.o          on_event                      37101
     34169    -2932 (-7.90%)
strobemeta.bpf.o                  on_event                      15939
      4893  -11046 (-69.30%)
strobemeta_nounroll1.bpf.o        on_event                       1936
      1538    -398 (-20.56%)
strobemeta_nounroll2.bpf.o        on_event                       4436
      3991    -445 (-10.03%)
strobemeta_subprogs.bpf.o         on_event                       2025
      1689    -336 (-16.59%)
test_cls_redirect.bpf.o           cls_redirect                   4865
      4042    -823 (-16.92%)
test_cls_redirect_subprogs.bpf.o  cls_redirect                   4506
      4389     -117 (-2.60%)
test_tcp_hdr_options.bpf.o        estab                           211
       178     -33 (-15.64%)
test_xdp_noinline.bpf.o           balancer_ingress_v4             262
       235     -27 (-10.31%)
test_xdp_noinline.bpf.o           balancer_ingress_v6             253
       210     -43 (-17.00%)
xdp_synproxy_kern.bpf.o           syncookie_tc                  25086
      7016  -18070 (-72.03%)
xdp_synproxy_kern.bpf.o           syncookie_xdp                 24206
      6941  -17265 (-71.33%)
--------------------------------  -----------------------  ----------
----------  ----------------
