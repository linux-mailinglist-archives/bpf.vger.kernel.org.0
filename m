Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D904660549E
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 02:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJTA4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 20:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJTA4E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 20:56:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC82162528
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:56:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g28so18814142pfk.8
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FmgFon34ewyLdT0h9flWMOd5YRCL8ZnIfPzObrUeTQE=;
        b=Wzw8LY1zfwoh/8+vyQAZzb5xzmfLG0g4WsMYTYY8rwuvQ+98yyza4sLjaS0mpJR2bA
         FXfCKQALv9s2ys/vZ09yc7aXC9YnUte2UGNtsHrnXMulSRtwKOF8N13hUgXWNKWWqc2i
         Q8LmBt74LFFgQYqg7r740Cn56hgdAD+24Kw2jhMeUk1rfordY6kqEcLApHUZ/1hveKWE
         Ju7G4CSmjn7QwX0BZhN4El2gJCyNi7AODW2h056ebWMo3tKuzDKh8hZX89Sb7orLDxCj
         9BYtRDuSzWVfuIYWIe1LQoyfZiRxBacEkn30oyRcvmLIsCJsrp/rf0EqpsJe4Cg1gnDE
         owSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmgFon34ewyLdT0h9flWMOd5YRCL8ZnIfPzObrUeTQE=;
        b=O0t6GI30J36fVAluqh6oKajBBwucWQkobLtS7QAu45WnVFjyor7cr35Sv35iZg5/eO
         Ula3LSOrdbifhj8gF9CaSlAs1nOlTvG0fKJweGzKolpECI7vazxKKzCQWL73YoV3AmUf
         Nn1TziwsbRKvSSpHw7RvkujuKHmnzJJxkbcTommwDpqBACPOntzlXiT5P77tlTNQRkcJ
         tud1sKnGUBBBLt8yPxmm8+SkgY02TMR2fyfHvn+TA6PpYe4Mm22XM+0rZF5tyr2PCcHY
         8Z5FnOOPJGAvky/9r6rIBIGVGvf3IjDX5DL8km9NnsOycdDlKbMnT3NmHlLQlFHVPLmU
         OHlQ==
X-Gm-Message-State: ACrzQf0xbrSYZHCZlvKydRHyTr6XXmbnL8SyHa7xw2fXodxFHSLRaw4S
        eJYvnkOZorDSMu6GnkD5aitp6+0Cl/l8fA==
X-Google-Smtp-Source: AMsMyM7cZB+z3hc3L8eqmtHC0HKgElynS6HMFSxQQvk/4Ioqxyjj5xOduh/r7mXXs4zglhMc4QHZyg==
X-Received: by 2002:a05:6a00:1749:b0:563:8346:12e9 with SMTP id j9-20020a056a00174900b00563834612e9mr11459815pfc.68.1666227362448;
        Wed, 19 Oct 2022 17:56:02 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u21-20020a62d455000000b0053b2681b0e0sm11971383pfl.39.2022.10.19.17.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 17:56:02 -0700 (PDT)
Date:   Thu, 20 Oct 2022 06:25:50 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor ARG_PTR_TO_DYNPTR checks
 into process_dynptr_func
Message-ID: <20221020005550.fhty2mhdpua7ogpf@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-2-memxor@gmail.com>
 <CAJnrk1b+cBapTLcgLk41AQFMsSFOwB6HR4Nu-Wsi3=pzkN+nfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b+cBapTLcgLk41AQFMsSFOwB6HR4Nu-Wsi3=pzkN+nfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 04:29:57AM IST, Joanne Koong wrote:
> On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > ARG_PTR_TO_DYNPTR is akin to ARG_PTR_TO_TIMER, ARG_PTR_TO_KPTR, where
> > the underlying register type is subjected to more special checks to
> > determine the type of object represented by the pointer and its state
> > consistency.
> >
> > Move dynptr checks to their own 'process_dynptr_func' function so that
> > is consistent and in-line with existing code. This also makes it easier
> > to reuse this code for kfunc handling.
> >
> > To this end, remove the dependency on bpf_call_arg_meta parameter by
> > instead taking the uninit_dynptr_regno by pointer. This is only needed
> > to be set to a valid pointer when arg_type has MEM_UNINIT.
> >
> > Then, reuse this consolidated function in kfunc dynptr handling too.
> > Note that for kfuncs, the arg_type constraint of DYNPTR_TYPE_LOCAL has
> > been lifted.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h                  |   8 +-
> >  kernel/bpf/btf.c                              |  17 +--
> >  kernel/bpf/verifier.c                         | 115 ++++++++++--------
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       |   5 +-
> >  .../bpf/progs/test_kfunc_dynptr_param.c       |  12 --
> >  5 files changed, 69 insertions(+), 88 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 9e1e6965f407..a33683e0618b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -593,11 +593,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >                              u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >                    u32 regno, u32 mem_size);
> > -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > -                             struct bpf_reg_state *reg);
> > -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > -                            struct bpf_reg_state *reg,
> > -                            enum bpf_arg_type arg_type);
> > +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > +                       enum bpf_arg_type arg_type, int argno,
> > +                       u8 *uninit_dynptr_regno);
> >
> >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index eba603cec2c5..1827d889e08a 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6486,23 +6486,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                                 return -EINVAL;
> >                                         }
> >
> > -                                       if (!is_dynptr_reg_valid_init(env, reg)) {
> > -                                               bpf_log(log,
> > -                                                       "arg#%d pointer type %s %s must be valid and initialized\n",
> > -                                                       i, btf_type_str(ref_t),
> > -                                                       ref_tname);
> > +                                       if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))
>
> I think it'd be helpful to add a bpf_log statement here that this failed
>

I left it out because process_dynptr_func itself will do the logging we were
doing here before.

> >                                                 return -EINVAL;
> > -                                       }
> > -
> > -                                       if (!is_dynptr_type_expected(env, reg,
> > -                                                       ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> > -                                               bpf_log(log,
> > -                                                       "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> > -                                                       i, btf_type_str(ref_t),
> > -                                                       ref_tname);
> > -                                               return -EINVAL;
> > -                                       }
> > -
> >                                         continue;
> >                                 }
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6f6d2d511c06..31c0c999448e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -782,8 +782,7 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> >         return true;
> >  }
> >
> > -bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> > -                             struct bpf_reg_state *reg)
> > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >         struct bpf_func_state *state = func(env, reg);
> >         int spi = get_spi(reg->off);
> > @@ -802,9 +801,8 @@ bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> >         return true;
> >  }
> >
> > -bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> > -                            struct bpf_reg_state *reg,
> > -                            enum bpf_arg_type arg_type)
> > +static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                   enum bpf_arg_type arg_type)
> >  {
> >         struct bpf_func_state *state = func(env, reg);
> >         enum bpf_dynptr_type dynptr_type;
> > @@ -5573,6 +5571,65 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> >         return 0;
> >  }
> >
> > +int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > +                       enum bpf_arg_type arg_type, int argno,
>
> Do we need both regno and argno given that regno is always argno +
> BPF_REG_1 and in this function we only use the argno param for "argno
> + 1"? I think we could just pass in regno.
>

Hmm, not really. I can drop it.

> > +                       u8 *uninit_dynptr_regno)
>
> nit: this is personal preference, but I think it looks cleaner passing
> "struct bpf_call_arg_meta *meta" here instead of "u8
> *uninit_dynptr_regno".
>

Right, the thinking was that kfuncs could also handle MEM_UNINIT case, in both
cases the meta type is different but this could be same, but let's think about
that when/if dynptr API function is added as a kfunc.

> > +{
> > +       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > +
> > +       /* We only need to check for initialized / uninitialized helper
> > +        * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> > +        * assumption is that if it is, that a helper function
> > +        * initialized the dynptr on behalf of the BPF program.
> > +        */
> > +       if (base_type(reg->type) == PTR_TO_DYNPTR)
> > +               return 0;
> > +       if (arg_type & MEM_UNINIT) {
> > +               if (!is_dynptr_reg_valid_uninit(env, reg)) {
> > +                       verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> > +                       return -EINVAL;
> > +               }
> > +
> > +               /* We only support one dynptr being uninitialized at the moment,
> > +                * which is sufficient for the helper functions we have right now.
> > +                */
> > +               if (*uninit_dynptr_regno) {
> > +                       verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> > +                       return -EFAULT;
> > +               }
> > +
> > +               *uninit_dynptr_regno = regno;
> > +       } else {
> > +               if (!is_dynptr_reg_valid_init(env, reg)) {
> > +                       verbose(env,
> > +                               "Expected an initialized dynptr as arg #%d\n",
> > +                               argno + 1);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               if (!is_dynptr_type_expected(env, reg, arg_type)) {
> > +                       const char *err_extra = "";
> > +
> > +                       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > +                       case DYNPTR_TYPE_LOCAL:
> > +                               err_extra = "local";
> > +                               break;
> > +                       case DYNPTR_TYPE_RINGBUF:
> > +                               err_extra = "ringbuf";
> > +                               break;
> > +                       default:
> > +                               err_extra = "<unknown>";
> > +                               break;
> > +                       }
> > +                       verbose(env,
> > +                               "Expected a dynptr of type %s as arg #%d\n",
> > +                               err_extra, argno + 1);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +       return 0;
> > +}
> > +
> >  static bool arg_type_is_mem_size(enum bpf_arg_type type)
> >  {
> >         return type == ARG_CONST_SIZE ||
> > @@ -6086,52 +6143,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                 err = check_mem_size_reg(env, reg, regno, true, meta);
> >                 break;
> >         case ARG_PTR_TO_DYNPTR:
> > -               /* We only need to check for initialized / uninitialized helper
> > -                * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> > -                * assumption is that if it is, that a helper function
> > -                * initialized the dynptr on behalf of the BPF program.
> > -                */
> > -               if (base_type(reg->type) == PTR_TO_DYNPTR)
> > -                       break;
> > -               if (arg_type & MEM_UNINIT) {
> > -                       if (!is_dynptr_reg_valid_uninit(env, reg)) {
> > -                               verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> > -                               return -EINVAL;
> > -                       }
> > -
> > -                       /* We only support one dynptr being uninitialized at the moment,
> > -                        * which is sufficient for the helper functions we have right now.
> > -                        */
> > -                       if (meta->uninit_dynptr_regno) {
> > -                               verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
> > -                               return -EFAULT;
> > -                       }
> > -
> > -                       meta->uninit_dynptr_regno = regno;
> > -               } else if (!is_dynptr_reg_valid_init(env, reg)) {
> > -                       verbose(env,
> > -                               "Expected an initialized dynptr as arg #%d\n",
> > -                               arg + 1);
> > -                       return -EINVAL;
> > -               } else if (!is_dynptr_type_expected(env, reg, arg_type)) {
> > -                       const char *err_extra = "";
> > -
> > -                       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > -                       case DYNPTR_TYPE_LOCAL:
> > -                               err_extra = "local";
> > -                               break;
> > -                       case DYNPTR_TYPE_RINGBUF:
> > -                               err_extra = "ringbuf";
> > -                               break;
> > -                       default:
> > -                               err_extra = "<unknown>";
> > -                               break;
> > -                       }
> > -                       verbose(env,
> > -                               "Expected a dynptr of type %s as arg #%d\n",
> > -                               err_extra, arg + 1);
> > -                       return -EINVAL;
> > -               }
> > +               if (process_dynptr_func(env, regno, arg_type, arg, &meta->uninit_dynptr_regno))
> > +                       return -EACCES;
>
> process_dynptr_func could return -EFAULT so I think we should do "err
> = process_dynptr_func(...)" here instead.
>

Agreed, I'll also propagate errors from other similar named functions.
