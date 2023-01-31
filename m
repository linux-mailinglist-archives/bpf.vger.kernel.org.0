Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1766682150
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjAaBRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 20:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAaBRe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 20:17:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D2626B0
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 17:17:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so12922550edv.3
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 17:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5XgGzbFdxRBrwG30TwdomA/gWRCq7QGlGUA1KoeUeY=;
        b=BG/rb5kSy2KFi8oWFQEL/djbexPoT7zvfMfP27OmiCuKBI49sz3myOC+qwSVNJ15fr
         eayDHxumgOdn5as+5wdHFN6ypbMj0gbAp17IaIIDwmnL7jmZ+B6lbPeoWkzFphZ1eWEG
         9AgwxdigbXNsWQYaNcsAFGU1N8chlEqETbj/g80ZKp9ZAE94IM5ompvRoP3Z0NeCtKDM
         Fny+wWdw2U3q2SKsx9le0884E5U0ihP7M+Eaml2CyX+whNFbK9Sns+pLwIOoLtpWmTOb
         rW05rGbpxX+AilaN/EDd1ELvM5oymaj6y0hqkG64hZdEI18waucEau+NX/bexyxahsct
         ICcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5XgGzbFdxRBrwG30TwdomA/gWRCq7QGlGUA1KoeUeY=;
        b=3bLeewuse8/sTHMiUb1LyiCCNnd5hxT2Xl1QZwcPm1eec26krVVA3hS/JNF00Qcegt
         K260wy99V1sOlEciE1enFTzioOCGoALXHA80UPlUGsaiUAxj0vEiSrh23FBf3zVOw4um
         QnF/XWtfaWp33RsUPeUaVWXx0PoEtmR5r3OXzJu7NttBdE1tlHYuwDtdZ9v8xAaFdETZ
         t5JEdCZaYOAFZXov9NNF6gyJsdYN3TXhFjrg9u1JJJs77FuG7SQI3X0eT31vhj6t8QWo
         eOCsDDe/Si693oFSwOaNF2d+PraeAw59LpK1dUVWg1PssGHCbP92xH7OlSzHgOwjElc3
         +QEQ==
X-Gm-Message-State: AFqh2kqgf/SOPyRUKJbpdVZVrh1Q09+ubtNZ5cha2BS29bKV60c675ct
        kdJhbVbtSqCRn/eaXJud2ZGXVRRc2HEGXiC2zRPH1DpB
X-Google-Smtp-Source: AMrXdXsUVWbML2G7BzKe2TWFMAweVqE4cKFkvo1vNeI7k19KhzyE9w4C/ARV32KGQqOo9Kz/CeGq123ZHd18xjh4zvc=
X-Received: by 2002:aa7:dbd9:0:b0:49c:ea59:46b with SMTP id
 v25-20020aa7dbd9000000b0049cea59046bmr10191418edt.54.1675127851703; Mon, 30
 Jan 2023 17:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20230106142214.1040390-1-eddyz87@gmail.com> <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
 <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
 <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
 <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
 <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
 <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
 <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
 <CAADnVQLybn06cYYV3uf3FeAGMjOiL5riRzhV6f9fuFOHr9bL=g@mail.gmail.com> <dd76a0254d08b25d83ad30d6f07acef36e6223e1.camel@gmail.com>
In-Reply-To: <dd76a0254d08b25d83ad30d6f07acef36e6223e1.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Jan 2023 17:17:19 -0800
Message-ID: <CAEf4BzYsVOiQLXu8tH75FA0Zvey2b7-0TR3aW2Wuqi+fKEtwgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Mon, Jan 30, 2023 at 7:34 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2023-01-19 at 16:16 -0800, Alexei Starovoitov wrote:
> [...]
> > > > >
> > > > > Just to be clear. My suggestion was to *treat* STACK_INVALID as
> > > > > equivalent to STACK_MISC in stacksafe(), not really replace all the
> > > > > uses of STACK_INVALID with STACK_MISC. And to be on the safe side, I'd
> > > > > do it only if env->allow_ptr_leaks, of course.
> > > >
> > > > Well, that, and to allow STACK_INVALID if env->allow_ptr_leaks in
> > > > check_stack_read_fixed_off(), of course, to avoid "invalid read from
> > > > stack off %d+%d size %d\n" error (that's fixing at least part of the
> > > > problem with uninitialized struct padding).
> > >
> > > +1 to Andrii's idea.
> > > It should help us recover this small increase in processed states.
> > >
> [...]
> > >
> > > I've tried Andrii's suggestion:
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 7ee218827259..0f71ba6a56e2 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3591,7 +3591,7 @@ static int check_stack_read_fixed_off(struct
> > > bpf_verifier_env *env,
> > >
> > > copy_register_state(&state->regs[dst_regno], reg);
> > >                                 state->regs[dst_regno].subreg_def = subreg_def;
> > >                         } else {
> > > -                               for (i = 0; i < size; i++) {
> > > +                               for (i = 0; i < size &&
> > > !env->allow_uninit_stack; i++) {
> > >                                         type = stype[(slot - i) % BPF_REG_SIZE];
> > >                                         if (type == STACK_SPILL)
> > >                                                 continue;
> > > @@ -3628,7 +3628,7 @@ static int check_stack_read_fixed_off(struct
> > > bpf_verifier_env *env,
> > >                 }
> > >                 mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
> > >         } else {
> > > -               for (i = 0; i < size; i++) {
> > > +               for (i = 0; i < size && !env->allow_uninit_stack; i++) {
> > >                         type = stype[(slot - i) % BPF_REG_SIZE];
> > >                         if (type == STACK_MISC)
> > >                                 continue;
> > > @@ -13208,6 +13208,10 @@ static bool stacksafe(struct bpf_verifier_env
> > > *env, struct bpf_func_state *old,
> > >                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] ==
> > > STACK_INVALID)
> > >                         continue;
> > >
> > > +               if (env->allow_uninit_stack &&
> > > +                   old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
> > > +                       continue;
> > >
> > > and only dynptr/invalid_read[134] tests failed
> > > which is expected and acceptable.
> > > We can tweak those tests.
> > >
> > > Could you take over this diff, run veristat analysis and
> > > submit it as an official patch? I suspect we should see nice
> > > improvements in states processed.
> >
>
> Hi Alexei, Andrii,
>
> Please note that the patch
> "bpf: Fix to preserve reg parent/live fields when copying range info"
> that started this conversation was applied to `bpf` tree, not `bpf-next`,
> so I'll wait until it gets its way to `bpf-next` before submitting formal
> patches, as it changes the performance numbers collected by veristat.
> I did all my experiments with this patch applied on top of `bpf-next`.
>
> I adapted the patch suggested by Alexei and put it to my github for
> now [1]. The performance gains are indeed significant:
>
> $ ./veristat -e file,states -C -f 'states_pct<-30' master.log uninit-reads.log
> File                        States (A)  States (B)  States    (DIFF)
> --------------------------  ----------  ----------  ----------------
> bpf_host.o                         349         244    -105 (-30.09%)
> bpf_host.o                        1320         895    -425 (-32.20%)
> bpf_lxc.o                         1320         895    -425 (-32.20%)
> bpf_sock.o                          70          48     -22 (-31.43%)
> bpf_sock.o                          68          46     -22 (-32.35%)
> bpf_xdp.o                         1554         803    -751 (-48.33%)
> bpf_xdp.o                         6457        2473   -3984 (-61.70%)
> bpf_xdp.o                         7249        3908   -3341 (-46.09%)
> pyperf600_bpf_loop.bpf.o           287         145    -142 (-49.48%)
> strobemeta.bpf.o                 15879        4790  -11089 (-69.83%)
> strobemeta_nounroll2.bpf.o       20505        3931  -16574 (-80.83%)
> xdp_synproxy_kern.bpf.o          22564        7009  -15555 (-68.94%)
> xdp_synproxy_kern.bpf.o          24206        6941  -17265 (-71.33%)
> --------------------------  ----------  ----------  ----------------
>
> However, this comes at a cost of allowing reads from uninitialized
> stack locations. As far as I understand access to uninitialized local
> variable is one of the most common errors when programming in C
> (although citation is needed).

Yeah, a citation is really needed :) I don't see this often in
practice, tbh. What I do see in practice is that people are
unnecessarily __builtint_memset(0) struct and initialize all fields
with field-by-field initialization, instead of just using a nice C
syntax:

struct my_struct s = {
   .field_a = 123,
   .field_b = 234,
};


And all that just because there is some padding between field_a and
field_b which the compiler won't zero-initialize.

>
> Also more tests are failing after register parentage chains patch is
> applied than in Alexei's initial try: 10 verifier tests and 1 progs
> test (test_global_func10.c, I have not modified it yet, it should wait
> for my changes for unprivileged execution mode support in
> test_loader.c). I don't really like how I had to fix those tests.
>
> I took a detailed look at the difference in verifier behavior between
> master and the branch [1] for pyperf600_bpf_loop.bpf.o and identified
> that the difference is caused by the fact that helper functions do not
> mark the stack they access as REG_LIVE_WRITTEN, the details are in the
> commit message [3], but TLDR is the following example:
>
>         1: bpf_probe_read_user(&foo, ...);
>         2: if (*foo) ...
>
> Here `*foo` will not get REG_LIVE_WRITTEN mark when (1) is verified,
> thus `*foo` read at (2) might lead to excessive REG_LIVE_READ marks
> and thus more verification states.

This is a good fix in its own right, of course, we should definitely do this!

>
> I prepared a patch that changes helper calls verification to apply
> REG_LIVE_WRITTEN when write size and alignment allow this, again
> currently on my github [2]. This patch has less dramatic performance
> impact, but nonetheless significant:
>
> $ veristat -e file,states -C -f 'states_pct<-30' master.log helpers-written.log
> File                        States (A)  States (B)  States    (DIFF)
> --------------------------  ----------  ----------  ----------------
> pyperf600_bpf_loop.bpf.o           287         156    -131 (-45.64%)
> strobemeta.bpf.o                 15879        4772  -11107 (-69.95%)
> strobemeta_nounroll1.bpf.o        2065        1337    -728 (-35.25%)
> strobemeta_nounroll2.bpf.o       20505        3788  -16717 (-81.53%)
> test_cls_redirect.bpf.o           8129        4799   -3330 (-40.96%)
> --------------------------  ----------  ----------  ----------------
>
> I suggest that instead of dropping a useful safety check I can further
> investigate difference in behavior between "uninit-reads.log" and
> "helpers-written.log" and maybe figure out other improvements.
> Unfortunately the comparison process is extremely time consuming.
>
> wdyt?

I think reading uninitialized stack slot concerns are overblown in
practice (in terms of their good implications for programmer's
productivity), I'd still do it if only in the name of improving user
experience.

>
> [1] https://github.com/eddyz87/bpf/tree/allow-uninit-stack-reads
> [2] https://github.com/eddyz87/bpf/tree/mark-helper-stack-as-written
> [3] https://github.com/kernel-patches/bpf/commit/b29842309271c21cbcb3f85d56cdf9f45f8382d2
>
> > Indeed, some massive improvements:
> > ./veristat -e file,prog,states -C -f 'states_diff<-10' bb aa
> > File                              Program                  States (A)
> > States (B)  States    (DIFF)
> > --------------------------------  -----------------------  ----------
> > ----------  ----------------
> > bpf_flow.bpf.o                    flow_dissector_0                 78
> >         67     -11 (-14.10%)
> > loop6.bpf.o                       trace_virtqueue_add_sgs         336
> >        316      -20 (-5.95%)
> > pyperf100.bpf.o                   on_event                       6213
> >       4670   -1543 (-24.84%)
> > pyperf180.bpf.o                   on_event                      11470
> >       8364   -3106 (-27.08%)
> > pyperf50.bpf.o                    on_event                       3263
> >       2370    -893 (-27.37%)
> > pyperf600.bpf.o                   on_event                      30335
> >      22200   -8135 (-26.82%)
> > pyperf600_bpf_loop.bpf.o          on_event                        287
> >        145    -142 (-49.48%)
> > pyperf600_nounroll.bpf.o          on_event                      37101
> >      34169    -2932 (-7.90%)
> > strobemeta.bpf.o                  on_event                      15939
> >       4893  -11046 (-69.30%)
> > strobemeta_nounroll1.bpf.o        on_event                       1936
> >       1538    -398 (-20.56%)
> > strobemeta_nounroll2.bpf.o        on_event                       4436
> >       3991    -445 (-10.03%)
> > strobemeta_subprogs.bpf.o         on_event                       2025
> >       1689    -336 (-16.59%)
> > test_cls_redirect.bpf.o           cls_redirect                   4865
> >       4042    -823 (-16.92%)
> > test_cls_redirect_subprogs.bpf.o  cls_redirect                   4506
> >       4389     -117 (-2.60%)
> > test_tcp_hdr_options.bpf.o        estab                           211
> >        178     -33 (-15.64%)
> > test_xdp_noinline.bpf.o           balancer_ingress_v4             262
> >        235     -27 (-10.31%)
> > test_xdp_noinline.bpf.o           balancer_ingress_v6             253
> >        210     -43 (-17.00%)
> > xdp_synproxy_kern.bpf.o           syncookie_tc                  25086
> >       7016  -18070 (-72.03%)
> > xdp_synproxy_kern.bpf.o           syncookie_xdp                 24206
> >       6941  -17265 (-71.33%)
> > --------------------------------  -----------------------  ----------
> > ----------  ----------------
>
