Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5F621BC7
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKHSWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 13:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiKHSWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 13:22:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102DC22
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:22:19 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b11so14565063pjp.2
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DV7XZbOa3stBvXdS1BPhzFXOjB6SlxegDXEH5N30ZPg=;
        b=fVui4H1MVZnB+sS5aPpIxJnfI9p2w9NPIjKUvCLn3YFYSqocZqJInE+Uii2KBtzJZT
         Do1nY6CdSUT5K9RoB562ok29lp94c8sQ0tpA4SXEZ+nz47cbQW50JQoCxsreNJ5gjOgD
         400Mzyfr32uSb28x5P0Gss5NYHssoyTrM4YguyaTK0wLdfO9rV3c+3/HeOaqnA07g+km
         UXhXBR+uj5WcXdtT7Cu+vHXZCwgXas6OrNiwppPn9J//QQyI5AbEyCCyUBXpUdUtBgI3
         YoxJmgXWtK/aa2IdyamSQTqMcFQtmVNhMcuM+6AHc9luscX1hnU6LVZ/0P2YJn56BsSt
         gbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV7XZbOa3stBvXdS1BPhzFXOjB6SlxegDXEH5N30ZPg=;
        b=tx5++PfL7Piyi/77YqWo271UL6qfaURAcHTYBokrY/xDn6eS472kB49Q8TZvztVoLb
         E0m+tOD7b2/daBCVMIy2esUMZyjCBpGGZNB4sN+Rpwo1msRBTe1aQhlf9VMCdDulYfiD
         YAYzb3ivTWbuSRpUVpvY2f9K24yk91VKC0KhkA057NlZs0xlqu3BA+KTe/23YG455i3G
         9mnz/icvSkw1oMgoCe2m4Rxf4DIaIIJtJEn+w6i7JLXyLJRKhNd8aCJQnYPUThzsx73i
         qgEcEo0eNaJaT3z0XwpMYyTuqymEYuoNSgd48Vr51GCLzk+QeunQuP9UYWlkpwnDXIGC
         hZgg==
X-Gm-Message-State: ACrzQf3MWP3/gsdQSqjGNlfjpYuOvJ/79dB0MBaV63gVme+1N+4DVCDX
        jVW03yckV4ZIGQy3i2MtORI=
X-Google-Smtp-Source: AMsMyM4sf8GzcQsbAHoOamHHc3lkn1nZEexJ/N8Gg3L9QWlkMxyOxSN87+Vly44oHbx0tVIRznktsQ==
X-Received: by 2002:a17:902:a383:b0:187:34f6:439d with SMTP id x3-20020a170902a38300b0018734f6439dmr41018530pla.35.1667931738648;
        Tue, 08 Nov 2022 10:22:18 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a08cf00b001efa9e83927sm8227951pjn.51.2022.11.08.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:22:18 -0800 (PST)
Date:   Tue, 8 Nov 2022 23:52:13 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 04/13] bpf: Rework check_func_arg_reg_off
Message-ID: <20221108182213.bljgkbay2bcz2xch@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-5-memxor@gmail.com>
 <CAJnrk1Y0F=+CGUhDZH6HTumbosG3EsoEnUC8TryxpV3amFowkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Y0F=+CGUhDZH6HTumbosG3EsoEnUC8TryxpV3amFowkg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 04:47:08AM IST, Joanne Koong wrote:
> On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > While check_func_arg_reg_off is the place which performs generic checks
> > needed by various candidates of reg->type, there is some handling for
> > special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> > ARG_PTR_TO_ALLOC_MEM.
> >
> > This commit aims to streamline these special cases and instead leave
> > other things up to argument type specific code to handle.
> >
> > This is done primarily for two reasons: associating back reg->type to
> > its argument leaves room for the list getting out of sync when a new
> > reg->type is supported by an arg_type.
> >
> > The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> > we already handle, whenever a release argument is expected, it should
> > be passed as the pointer that was received from the acquire function.
> > Hence zero fixed and variable offset.
> >
> > There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> > its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> > with non-zero offset to other helper functions, which makes sense.
> >
> > Hence, lift the arg_type_is_release check for reg->off and cover all
> > possible register types, instead of duplicating the same kind of check
> > twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).
> >
> > Finally, for the release argument, arg_type_is_dynptr is the special
> > case, where we go to actual object being freed through the dynptr, so
> > the offset of the pointer still needs to allow fixed and variable offset
> > and process_dynptr_func will verify them later for the release argument
> > case as well.
> >
> > Finally, since check_func_arg_reg_off is meant to be generic, move
> > dynptr specific check into process_dynptr_func.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 55 +++++++++++++++----
> >  .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
> >  2 files changed, 44 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a49b95c1af1b..a8c277e51d63 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5654,6 +5654,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >                 return -EFAULT;
> >         }
> >
> > +       /* CONST_PTR_TO_DYNPTR has fixed and variable offset as zero, ensured by
> > +        * check_func_arg_reg_off, so this is only needed for PTR_TO_STACK.
> > +        */
> > +       if (reg->off % BPF_REG_SIZE) {
> > +               verbose(env, "cannot pass in dynptr at an offset\n");
> > +               return -EINVAL;
> > +       }
> > +
>
> Imo, this logic belongs more in check_func_arg_reg_off(). It's cleaner
> to me to have all the logic for reg->off checking consolidated in one
> place.
>

I think this alignment requirement is specific to dynptr, so it should be here.
My idea with this patch was to only force offset rules per register type that
don't harcode any assumptions about what each helper does with that register
type. Each ARG_TYPE_* can then further build upon what this function guarantees
about the register type.

e.g. PTR_TO_MAP_VALUE doesn't have restriction to have constant var_off, but a
lot of helpers require it to be const. It wouldn't make sense to move their
helper specific offset checks to this function. Same reasoning here.

> >         /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
> >          * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> >          *
> > @@ -5672,6 +5680,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >          *               destroyed, including mutation of the memory it points
> >          *               to.
> >          */
> > +
> >         if (arg_type & MEM_UNINIT) {
> >                 if (!is_dynptr_reg_valid_uninit(env, reg)) {
> >                         verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> > @@ -5983,14 +5992,37 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >         enum bpf_reg_type type = reg->type;
> >         bool fixed_off_ok = false;
> >
> > -       switch ((u32)type) {
> > -       /* Pointer types where reg offset is explicitly allowed: */
> > -       case PTR_TO_STACK:
> > -               if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> > -                       verbose(env, "cannot pass in dynptr at an offset\n");
> > +       /* When referenced register is passed to release function, it's fixed
> > +        * offset must be 0.
> > +        *
> > +        * We will check arg_type_is_release reg has ref_obj_id when storing
> > +        * meta->release_regno.
> > +        */
> > +       if (arg_type_is_release(arg_type)) {
> > +               /* ARG_PTR_TO_DYNPTR is a bit special, as it may not directly
> > +                * point to the object being released, but to dynptr pointing
> > +                * to such object, which might be at some offset on the stack.
> > +                *
> > +                * In that case, we simply to fallback to the default handling.
> > +                */
> > +               if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
>
> Do we need the "arg_type_is_dynptr(arg_type)" part? I think just "if
> (type == PTR_TO_STACK)" suffices since any release args on the stack
> will be at some fp offset.
>

Just being more careful here. We can drop it once we have more cases, but it's
better IMO to be more restrictive by default to prevent things from slipping
through.

In the future there will be more helpers that work similar to dynptr (e.g.
initializing a bpf_list_head on stack), then we can abstract them behind a
common check.

> > +                       goto check_type;
>
> I think this logic is a lot simpler to read:
>
> if (arg_type_is_release(arg_type)) {
>     if (type != PTR_TO_STACK) {
>         if (reg->off) {
>             verbose(env, "R%d must have zero offset...");
>             return -EINVAL;
>         }
>         return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>     }
> }
>

Sure, I can rewrite it like this.

> > +               /* Going straight to check will catch this because fixed_off_ok
> > +                * is false, but checking here allows us to give the user a
> > +                * better error message.
> > +                */
> > +               if (reg->off) {
> > +                       verbose(env, "R%d must have zero offset when passed to release func\n",
> > +                               regno);
> >                         return -EINVAL;
> >                 }
> > -               fallthrough;
> > +               goto check;
>
> I think it's cleaner here to just "return __check_ptr_off_reg(env,
> reg, regno, fixed_off_ok);" instead of adding the goto check.
>
> > +       }
> > +check_type:
> > +       switch ((u32)type) {
>
> btw I don't think we need this (u32) cast. type is an enum
> bpf_reg_type, which is by default a u32.
>

nit: it's an int by default.

I've found clang complaining when you switch over an enum type and cases contain
non-enum constants (like type | flag). For clarity I'll declare the variable as
u32.

> > +       /* Pointer types where both fixed and variable reg offset is explicitly
> > +        * allowed: */
> > +       case PTR_TO_STACK:
> >         case PTR_TO_PACKET:
> >         case PTR_TO_PACKET_META:
> >         case PTR_TO_MAP_KEY:
> > @@ -6001,12 +6033,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >         case PTR_TO_BUF:
> >         case PTR_TO_BUF | MEM_RDONLY:
> >         case SCALAR_VALUE:
> > -               /* Some of the argument types nevertheless require a
> > -                * zero register offset.
> > -                */
> > -               if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> > -                       return 0;
> > -               break;
> > +               return 0;
> >         /* All the rest must be rejected, except PTR_TO_BTF_ID which allows
> >          * fixed offset.
> >          */
>
> We should also remove the "if (arg_type_is_release(arg_type) &&
> reg->off)" code in the PTR_TO_BTF_ID case.
>

Ack.
