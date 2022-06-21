Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE66553B66
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354128AbiFUUUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354129AbiFUUUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B38289AC
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5DE7617AE
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313C5C341C4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842801;
        bh=YoDYixmqiox8/TPfNaZ8gV3oL7yhI/ApGBNMpO9NroQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a6n/y0+m2kqG+XYI8UXcVyi7xOwXGfXm9iuxJq5gcayrwD4F7h6VbEKxhYsWFEiET
         +rmrdUW2U9k6CZia54uFdGJGI8xVaLXIrhmxJEBOSxRbfXzF55keZ9kaiXCaQzlW8c
         uBKgwS7jOHD3pv/UVuoUfICzK4ySpXJ37EJH8Ne+uyg2a8oMpbOwZAFgI8eiEBiSYs
         4pZssizLXeu32oyTWyH1vOF09Q6/rP8ABqeQQpDMNecHDek+145zqveBdFhtX0UJWI
         uZWaBqc1wpD35XGvkzSoE46NDmmsBgK+Ql7+zw+hiD7+VrPHoLsPftOJkEZIl+4Fba
         /D2HKMBCw86kA==
Received: by mail-yb1-f180.google.com with SMTP id 23so26435391ybe.8
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:20:01 -0700 (PDT)
X-Gm-Message-State: AJIora9g51cyqE5rndY3MvGsUGNJieEuSVjvXnQgEVFsXHbppm5u4byd
        W6AsSeNJl8RDcleLnFiTW44VHS3BqM+mlDwLIYpToQ==
X-Google-Smtp-Source: AGRyM1vRaDQwBNtSRQ7g7P5WUyd0wXiYS/+tiHhYXXUZssMSZgcrV76m+gfy9uND1VI+neuN6yYHPQzgLbsVVCloMpM=
X-Received: by 2002:a25:a0ca:0:b0:664:c86b:4c24 with SMTP id
 i10-20020a25a0ca000000b00664c86b4c24mr32946772ybm.65.1655842800211; Tue, 21
 Jun 2022 13:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-1-kpsingh@kernel.org> <20220621012811.2683313-3-kpsingh@kernel.org>
 <CAJnrk1ZzvocB8i5iBrbEQBFnbSw9ek423ps9uOmm4ahp5z3bVg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZzvocB8i5iBrbEQBFnbSw9ek423ps9uOmm4ahp5z3bVg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Jun 2022 22:19:49 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4sS+oAbCJwA38SkUb2+GmRsC+dqZ-vy4O4+xwkO3uBjw@mail.gmail.com>
Message-ID: <CACYkzJ4sS+oAbCJwA38SkUb2+GmRsC+dqZ-vy4O4+xwkO3uBjw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 8:04 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Jun 20, 2022 at 6:29 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > kfuncs can handle pointers to memory when the next argument is
> > the size of the memory that can be read and verify these as
> > ARG_CONST_SIZE_OR_ZERO
> >
> > Similarly add support for string constants (const char *) and
> > verify it similar to ARG_PTR_TO_CONST_STR.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h |  2 +
> >  kernel/bpf/btf.c             | 29 ++++++++++++
> >  kernel/bpf/verifier.c        | 85 ++++++++++++++++++++----------------
> >  3 files changed, 79 insertions(+), 37 deletions(-)
> >
> [...]
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 668ecf61649b..02d7951591ae 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6162,6 +6162,26 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
> >         return true;
> >  }
> >
> > +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> > +                                      const struct btf_param *param)
> > +{
> > +       const struct btf_type *t;
> > +
> > +       t = btf_type_by_id(btf, param->type);
> > +       if (!btf_type_is_ptr(t))
> > +               return false;
> > +
> > +       t = btf_type_by_id(btf, t->type);
> > +       if (!(BTF_INFO_KIND(t->info) == BTF_KIND_CONST))
> "if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)" looks clearer to me
> > +               return false;
> > +
> > +       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > +       if (!strcmp(btf_name_by_offset(btf, t->name_off), "char"))
> "return !strcmp(btf_name_by_offset(btf, t->name_off), "char")" looks
> clearer to me here too

Agreed. Updated.

> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                     const struct btf *btf, u32 func_id,
> >                                     struct bpf_reg_state *regs,
> > @@ -6344,6 +6364,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                 } else if (ptr_to_mem_ok) {
> >                         const struct btf_type *resolve_ret;
> >                         u32 type_size;
> > +                       int err;
> >
> >                         if (is_kfunc) {
> >                                 bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> > @@ -6354,6 +6375,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                  * When arg_mem_size is true, the pointer can be
> >                                  * void *.
> >                                  */
> > +                               if (btf_param_is_const_str_ptr(btf, &args[i])) {
> > +                                       err = check_const_str(env, reg, regno);
> > +                                       if (err < 0)
> > +                                               return err;
> > +                                       i++;
> > +                                       continue;
> If I'm understanding it correctly, this patch is intended to allow
> helper functions to take in a kfunc as an arg as long as the next arg
> is the size of the memory. Do we need to check the memory size access
> here (eg like a call to check_mem_size_reg() in the verifier) to
> ensure that memory accesses of that size are safe?

No, this is different. We already have the verification for where we pair a
void * pointer to a size argument in the next arg.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/btf.c#n6366

This logic is similar to the verification we do for ARG_PTR_TO_CONST_STR where
we do not need a matching size argument and we just check for a null
terminated string
passed via a R/O map.


> > +                               }
> > +
> >                                 if (!btf_type_is_scalar(ref_t) &&
> >                                     !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> >                                     (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2859901ffbe3..14a434792d7b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5840,6 +5840,52 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
> >         return state->stack[spi].spilled_ptr.id;
> >  }
> [...]
> > +
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                           struct bpf_call_arg_meta *meta,
> >                           const struct bpf_func_proto *fn)
> > @@ -6074,44 +6120,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         return err;
> >                 err = check_ptr_alignment(env, reg, 0, size, true);
> >         } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > -               struct bpf_map *map = reg->map_ptr;
> > -               int map_off;
> > -               u64 map_addr;
> > -               char *str_ptr;
> > -
> > -               if (!bpf_map_is_rdonly(map)) {
> > -                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > -                       return -EACCES;
> > -               }
> > -
> > -               if (!tnum_is_const(reg->var_off)) {
> > -                       verbose(env, "R%d is not a constant address'\n", regno);
> > -                       return -EACCES;
> > -               }
> > -
> > -               if (!map->ops->map_direct_value_addr) {
> > -                       verbose(env, "no direct value access support for this map type\n");
> > -                       return -EACCES;
> > -               }
> > -
> > -               err = check_map_access(env, regno, reg->off,
> > -                                      map->value_size - reg->off, false,
> > -                                      ACCESS_HELPER);
> > -               if (err)
> > -                       return err;
> > -
> > -               map_off = reg->off + reg->var_off.value;
> > -               err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> > -               if (err) {
> > -                       verbose(env, "direct value access on string failed\n");
> > +               err = check_const_str(env, reg, regno);
> > +               if (err < 0)
> >                         return err;
> nit: I don't think you need the if check here since thsi function will
> return err automatically in the next line

Makes sense. Fixed.

>
> > -               }
> > -
> > -               str_ptr = (char *)(long)(map_addr);
> > -               if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> > -                       verbose(env, "string is not zero-terminated\n");
> > -                       return -EINVAL;
> > -               }
> >         } else if (arg_type == ARG_PTR_TO_KPTR) {
> >                 if (process_kptr_func(env, regno, meta))
> >                         return -EACCES;
> > --
> > 2.37.0.rc0.104.g0611611a94-goog
> >
