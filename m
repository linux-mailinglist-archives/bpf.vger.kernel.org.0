Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403D58D066
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 01:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiHHXMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiHHXMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 19:12:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BCB15A3E
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 16:12:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o22so13106891edc.10
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=befLvs3ESWmIRGXkmV5anmwWSuFMfn5HdqmKtxrXfk8=;
        b=bJY5w9czhjgAPXyTEEZDkbdNdW3zo4+FeMnMeVUVU8NIajZW9VhNO2KGA7NkXBj0OS
         4VwbwUQRBhZ1NpiGCkw9J52ULvj3mgbyMOPQJ4Z4gFqjs2O0XC2+dIF+f8Sg3aS0MBlQ
         6pD3qRMjgYJ8CMavw77pDixz1Niow4dDtbPmVa0FRUULcooQqE7AR7Hxxhb+rFe+I5oT
         D5Z+K+SWWMSVWa4PoTWrQ0QPIMaQzs+s/L5BnJm1IzeajaRV8Z6wCciXFnjxWfytMPgN
         +2WlDL5mnoQLZfVlwfCPZjjThujRLE/XS88v4v72eFayEfPk+cAB9KSr8TUD9BEMUMW+
         uTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=befLvs3ESWmIRGXkmV5anmwWSuFMfn5HdqmKtxrXfk8=;
        b=hpqeV6819s6SBoBKtjStrFu+m9Q88On6QdtPd4xiU+ME0OD2cQ13su0NBnBDjIFvXa
         CS/ZXjJlBsmJQdc/KB9zs28m8KIYt+8DuQPUY6pKRdb+EfL9hCI2QRUZiAttVBOP4D6b
         rfOmn2LrjNvd0Ijz31ViKEnKEW9s3prPRMUJsVf1Rkm0baphfxgzMHa2cwd9oGjM7547
         oSBhNNPj1C45DpV42/SF938GXNPsPRGQBuScDMw5nrv8uVU+P4xm95a8c/Psbsukbl12
         GtHET0LLmDmw5UpIllmJyjCL79UN+HC6QRuxxGLQgoyx3CSA8F9ydI47Og4NK2jf1ZYI
         yZgQ==
X-Gm-Message-State: ACgBeo0vsOGwDU0XWBaipu1/6PIcQ96DSsOzy4ZVJubidTlRAeG4sDXR
        v34cpTmSoo9ibcvucyjhvLXRuxwwOLarM2xVWNxiGhpf
X-Google-Smtp-Source: AA6agR6Zqpmb6pzyl3f4WdZ0xugL9nC9vMstbUhRJwCokjnNUG1DPns3bpyY+ObKgE/K+p5D1VoqbaGqSTbMMm0z8tg=
X-Received: by 2002:a05:6402:280f:b0:43d:f946:a895 with SMTP id
 h15-20020a056402280f00b0043df946a895mr20075522ede.229.1660000322384; Mon, 08
 Aug 2022 16:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220722175807.4038317-1-joannelkoong@gmail.com> <20220808211433.oz3fuvtayfdwrnwi@dev0025.ash9.facebook.com>
In-Reply-To: <20220808211433.oz3fuvtayfdwrnwi@dev0025.ash9.facebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 8 Aug 2022 16:11:51 -0700
Message-ID: <CAJnrk1a=rz7HKd_4FR=kUO-oqg8KepqJ0t9CKDaDpnT0E6Sc8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, jolsa@kernel.org,
        haoluo@google.com, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
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

On Mon, Aug 8, 2022 at 2:14 PM David Vernet <void@manifault.com> wrote:
>
> On Fri, Jul 22, 2022 at 10:58:06AM -0700, Joanne Koong wrote:
> > When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> > the ref obj id of the dynptr must be found and then associated with the data
> > slice.
> >
> > The ref obj id of the dynptr must be found *before* the caller saved regs are
> > reset. Without this fix, the ref obj id tracking is not correct for
> > dynptrs that are at an offset from the frame pointer.
> >
> > Please also note that the data slice's ref obj id must be assigned after the
> > ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> > zero-marked.
> >
> > Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
>
> Hi Joanne,
>
> Overall this looks great, thanks. Just a couple small comments / questions.
>
> >  kernel/bpf/verifier.c | 62 ++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 33 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c59c3df0fea6..29987b2ea26f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5830,7 +5830,8 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
> >
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> > -                       const struct bpf_func_proto *fn)
> > +                       const struct bpf_func_proto *fn,
> > +                       int func_id)
>
> Can we get the func_id from meta instead of adding another argument? It
> looks like the func_id is stored there before we call check_func_arg.

Great idea! I didn't realize the func id is already stored in meta :)

Btw, for v3, I'm planning to move this logic out of check_func_arg,
and instead to the end of the "switch (func_id)" statement in
check_helper_call(). I think keeping check_func_arg() free of checking
func ids ends up being logically cleaner. Will send v3 out shortly

>
> >  {
> >       u32 regno = BPF_REG_1 + arg;
> >       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > @@ -6040,23 +6041,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                       }
> >
> >                       meta->uninit_dynptr_regno = regno;
> > -             } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > -                     const char *err_extra = "";
> > +             } else {
> > +                     if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > +                             const char *err_extra = "";
> >
> > -                     switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > -                     case DYNPTR_TYPE_LOCAL:
> > -                             err_extra = "local ";
> > -                             break;
> > -                     case DYNPTR_TYPE_RINGBUF:
> > -                             err_extra = "ringbuf ";
> > -                             break;
> > -                     default:
> > -                             break;
> > -                     }
> > +                             switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > +                             case DYNPTR_TYPE_LOCAL:
> > +                                     err_extra = "local ";
> > +                                     break;
> > +                             case DYNPTR_TYPE_RINGBUF:
> > +                                     err_extra = "ringbuf ";
> > +                                     break;
> > +                             default:
> > +                                     break;
> > +                             }
> >
> > -                     verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > -                             err_extra, arg + 1);
> > -                     return -EINVAL;
> > +                             verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > +                                     err_extra, arg + 1);
> > +                             return -EINVAL;
> > +                     }
> > +                     if (func_id == BPF_FUNC_dynptr_data) {
> > +                             if (meta->ref_obj_id) {
> > +                                     verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> > +                                     return -EFAULT;
> > +                             }
> > +                             /* Find the id of the dynptr we're tracking the reference of */
> > +                             meta->ref_obj_id = stack_slot_get_id(env, reg);
> > +                     }
> >               }
> >               break;
> >       case ARG_CONST_ALLOC_SIZE_OR_ZERO:
> > @@ -7227,7 +7238,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >       meta.func_id = func_id;
> >       /* check args */
> >       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > -             err = check_func_arg(env, i, &meta, fn);
> > +             err = check_func_arg(env, i, &meta, fn, func_id);
> >               if (err)
> >                       return err;
> >       }
> > @@ -7457,7 +7468,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >       if (type_may_be_null(regs[BPF_REG_0].type))
> >               regs[BPF_REG_0].id = ++env->id_gen;
> >
> > -     if (is_ptr_cast_function(func_id)) {
> > +     if (is_ptr_cast_function(func_id) || func_id == BPF_FUNC_dynptr_data) {
>
> Just a nit and my two cents, but IMO, is_ptr_cast_function() feels like a
> bit of an unclear function name. It's only used for this specific if
> statement, so maybe we should change that function name to something like
> is_meta_stored_ref() and just add BPF_FUNC_dynptr_data to that list?

I think is_ptr_cast_function() is named that because it refers to the
class of functions whose only purpose is to cast the ptr and return it
back. is_ptr_cast_function() and bpf_dynptr_data() are similar in that
they need to make sure the ref obj id from the reference arg is copied
to the return reg's ref obj id - so maybe renaming it to something
like "copies_ref_obj_id" ends up being clearer?

>
> >               /* For release_reference() */
> >               regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> >       } else if (is_acquire_function(func_id, meta.map_ptr)) {
> > @@ -7469,21 +7480,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               regs[BPF_REG_0].id = id;
> >               /* For release_reference() */
> >               regs[BPF_REG_0].ref_obj_id = id;
> > -     } else if (func_id == BPF_FUNC_dynptr_data) {
> > -             int dynptr_id = 0, i;
> > -
> > -             /* Find the id of the dynptr we're acquiring a reference to */
> > -             for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > -                     if (arg_type_is_dynptr(fn->arg_type[i])) {
> > -                             if (dynptr_id) {
> > -                                     verbose(env, "verifier internal error: multiple dynptr args in func\n");
> > -                                     return -EFAULT;
> > -                             }
> > -                             dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> > -                     }
> > -             }
> > -             /* For release_reference() */
> > -             regs[BPF_REG_0].ref_obj_id = dynptr_id;
> >       }
> >
> >       do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> > --
> > 2.30.2
> >
>
> Looks good otherwise, as mentioned above.
>
> Thanks,
> David
