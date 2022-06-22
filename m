Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4427556EB7
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359766AbiFVW5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376575AbiFVW5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 18:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7706278
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 15:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E9F61B30
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 22:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69020C385A2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655938633;
        bh=zy2hYvlZB5C6WT4gShd2UGvyuEiCGB9i0qeovbB+lUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bf1jrFNLMsSx5r5AVLxLMEcQSWkbM0ILrfH4bTQuOyL8PviWf8pQH2our+u4uMhbg
         NIWb66nIC8xCwWmYW51SoU/KWfaa9ZfSFP6JtBh+oS2I7PIcAc0aKMYKtz6CYTJNUB
         q10JqGfL9GA+S6mLpl9OWQY39anWsBQBawmHjUpgAXVZlMMuYUp8YKQuTWTIOLoJng
         fnwLVMXB1sC3CALZTPOb4WuFf0B8B+ZaYNHTCZMI1ZwOdaupKMfqFjNKIjZAlcDdFS
         8Gk9LpG3TYGtmJfIvje7wIUgHzlLr3kuQWbyW3V/UCqfpQfEzaaB6Iex5Eu4V+gYsb
         CP3GhNohIOlIA==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-317741c86fdso175812397b3.2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 15:57:13 -0700 (PDT)
X-Gm-Message-State: AJIora9wJAwRJpcgTYnwttLSMCCyFEmHpVgAb2tpBltJqU+ZBZgjzlrM
        hzRpe8f3qy3KZzMMr4sFPgQn0eemkDn9a3BizdAyGA==
X-Google-Smtp-Source: AGRyM1vKodLr4kvqZA/HWpA/HA/q+S9mOhYyF5PStPVkGzgJUuLSbjboBhZ5BUBPiLIKfSUkbqG9hfCNfVWPZScWHxE=
X-Received: by 2002:a0d:cbc8:0:b0:317:95ef:399e with SMTP id
 n191-20020a0dcbc8000000b0031795ef399emr7190585ywd.340.1655938632364; Wed, 22
 Jun 2022 15:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220621204642.2891979-1-kpsingh@kernel.org> <20220621204642.2891979-3-kpsingh@kernel.org>
 <20220622012654.xl5bax75muwdd764@apollo.legion>
In-Reply-To: <20220622012654.xl5bax75muwdd764@apollo.legion>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 22 Jun 2022 17:57:01 -0500
X-Gmail-Original-Message-ID: <CACYkzJ5Fh9jMaj3KRBYFvJ=E_DJdyfzk9QY5JOzxSBs8F7AYHA@mail.gmail.com>
Message-ID: <CACYkzJ5Fh9jMaj3KRBYFvJ=E_DJdyfzk9QY5JOzxSBs8F7AYHA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Jun 21, 2022 at 8:27 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Jun 22, 2022 at 02:16:39AM IST, KP Singh wrote:
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
> >  kernel/bpf/btf.c             | 26 +++++++++++
> >  kernel/bpf/verifier.c        | 89 +++++++++++++++++++++---------------
> >  3 files changed, 79 insertions(+), 38 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 3930c963fa67..60d490354397 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -548,6 +548,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >                            u32 regno);
> >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >                  u32 regno, u32 mem_size);
> > +int check_const_str(struct bpf_verifier_env *env,
> > +                 const struct bpf_reg_state *reg, int regno);
> >
> >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 668ecf61649b..6608e8a0c5ca 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6162,6 +6162,23 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
> >       return true;
> >  }
> >
> > +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> > +                                    const struct btf_param *param)
> > +{
> > +     const struct btf_type *t;
> > +
> > +     t = btf_type_by_id(btf, param->type);
> > +     if (!btf_type_is_ptr(t))
> > +             return false;
> > +
> > +     t = btf_type_by_id(btf, t->type);
> > +     if (!(BTF_INFO_KIND(t->info) == BTF_KIND_CONST))
> > +             return false;
> > +
>
> Forgot to change this to !=.
>
> > +     t = btf_type_skip_modifiers(btf, t->type, NULL);
> > +     return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
> > +}
> > +
> >  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                   const struct btf *btf, u32 func_id,
> >                                   struct bpf_reg_state *regs,
> > @@ -6344,6 +6361,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >               } else if (ptr_to_mem_ok) {
> >                       const struct btf_type *resolve_ret;
> >                       u32 type_size;
> > +                     int err;
> >
> >                       if (is_kfunc) {
> >                               bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> > @@ -6354,6 +6372,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                * When arg_mem_size is true, the pointer can be
> >                                * void *.
> >                                */
> > +                             if (btf_param_is_const_str_ptr(btf, &args[i])) {
> > +                                     err = check_const_str(env, reg, regno);
> > +                                     if (err < 0)
> > +                                             return err;
> > +                                     i++;
>
> Sorry for not seeing it before, I think this i++ is incorrect. It is skipping
> over the next argument. Which means mem, len pair is not being seen, otherwise
> it should have given an error with the void * argument, because the next
> argument does not have __sz prefix, so there is no mem, len pair in the kfunc
> args.

Thanks for spotting this. Updated my patches, will send v4.

- KP


> The i++ is done for arg_mem_size case because we processed both argno and argno + 1
> together, so the next size arg doesn't need to be processed.
>
> So the bpf_getxattr declaration needs to change from:
>
> noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
>                                      const char *name, void *value, int size)
>
> to
>
> noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
>                                      const char *name, void *value, int value__sz)
>
> You only need the __sz suffix, the part before that is your choice.
> Then it will actually check the size for the value pointer.
> Also, I think neither noinline nor __weak are needed.
>
> > +                                     continue;
> > +                             }
> > +
> >                               if (!btf_type_is_scalar(ref_t) &&
> >                                   !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> >                                   (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2859901ffbe3..7ac501122df0 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5840,6 +5840,56 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
> >       return state->stack[spi].spilled_ptr.id;
> >  }
> >
> > +int check_const_str(struct bpf_verifier_env *env,
> > +                 const struct bpf_reg_state *reg, int regno)
> > +{
> > +     struct bpf_map *map;
> > +     int map_off;
> > +     u64 map_addr;
> > +     char *str_ptr;
> > +     int err;
> > +
> > +     if (reg->type != PTR_TO_MAP_VALUE)
> > +             return -EACCES;
> > +
> > +     map = reg->map_ptr;
> > +     if (!bpf_map_is_rdonly(map)) {
> > +             verbose(env, "R%d does not point to a readonly map'\n", regno);
> > +             return -EACCES;
> > +     }
> > +
> > +     if (!tnum_is_const(reg->var_off)) {
> > +             verbose(env, "R%d is not a constant address'\n", regno);
> > +             return -EACCES;
> > +     }
> > +
> > +     if (!map->ops->map_direct_value_addr) {
> > +             verbose(env,
> > +                     "no direct value access support for this map type\n");
> > +             return -EACCES;
> > +     }
> > +
> > +     err = check_map_access(env, regno, reg->off, map->value_size - reg->off,
> > +                            false, ACCESS_HELPER);
> > +     if (err)
> > +             return err;
> > +
> > +     map_off = reg->off + reg->var_off.value;
> > +     err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> > +     if (err) {
> > +             verbose(env, "direct value access on string failed\n");
> > +             return err;
> > +     }
> > +
> > +     str_ptr = (char *)(long)(map_addr);
> > +     if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> > +             verbose(env, "string is not zero-terminated\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                         struct bpf_call_arg_meta *meta,
> >                         const struct bpf_func_proto *fn)
> > @@ -6074,44 +6124,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                       return err;
> >               err = check_ptr_alignment(env, reg, 0, size, true);
> >       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > -             struct bpf_map *map = reg->map_ptr;
> > -             int map_off;
> > -             u64 map_addr;
> > -             char *str_ptr;
> > -
> > -             if (!bpf_map_is_rdonly(map)) {
> > -                     verbose(env, "R%d does not point to a readonly map'\n", regno);
> > -                     return -EACCES;
> > -             }
> > -
> > -             if (!tnum_is_const(reg->var_off)) {
> > -                     verbose(env, "R%d is not a constant address'\n", regno);
> > -                     return -EACCES;
> > -             }
> > -
> > -             if (!map->ops->map_direct_value_addr) {
> > -                     verbose(env, "no direct value access support for this map type\n");
> > -                     return -EACCES;
> > -             }
> > -
> > -             err = check_map_access(env, regno, reg->off,
> > -                                    map->value_size - reg->off, false,
> > -                                    ACCESS_HELPER);
> > -             if (err)
> > -                     return err;
> > -
> > -             map_off = reg->off + reg->var_off.value;
> > -             err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> > -             if (err) {
> > -                     verbose(env, "direct value access on string failed\n");
> > -                     return err;
> > -             }
> > -
> > -             str_ptr = (char *)(long)(map_addr);
> > -             if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> > -                     verbose(env, "string is not zero-terminated\n");
> > -                     return -EINVAL;
> > -             }
> > +             err = check_const_str(env, reg, regno);
> >       } else if (arg_type == ARG_PTR_TO_KPTR) {
> >               if (process_kptr_func(env, regno, meta))
> >                       return -EACCES;
> > --
> > 2.37.0.rc0.104.g0611611a94-goog
> >
>
> --
> Kartikeya
