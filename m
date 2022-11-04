Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24AF6195FD
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 13:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKDMN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 08:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiKDMN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 08:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2E1C920
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 05:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A8A62171
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 12:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6533C433C1
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 12:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667564003;
        bh=HOZ9NUwoxpM0XsGdoIEycF6uVUnl1teTqJmePN05vsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dY2ioLvCjH7kVn39RwAPkXtXmuFfzICL1IHghDemKAX+m38Nkq/pPnHfDNS/VrEdt
         IUyYEMBJ55obFB0c1/BOgJuw/zgW9bqmRorF6Z2onTVumZNnhPJgQShPjQxkp0eqON
         xU/2D3g7xHEh4OYEz+YlLRDrC9OhMp7aEyz37s56XCIPiJbh3A+JmQk4ecqAZk1Vf0
         yTqo+UL5hv8oaO/AM/ji7auMHtk73KdAJ/A1FLrBXgkqVn3wiar27ps605k9WesHqY
         itv7YdrDsidUyLj6ZilJyFnp5QMbx4EVLbqcjiULQtkzMYBnIfItsPgs4Z/85XqNHc
         pOI6cLChu/uEg==
Received: by mail-lf1-f44.google.com with SMTP id c1so5522420lfi.7
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 05:13:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf03sFmgCQgB4zvNO6AaTNP/9UCyrU/AyvaqHiP3pTEMpe1C0XXP
        ebFdF0TyNTDeGmk7JeM1rKu3AaRBh4IRU2xiH9QmFg==
X-Google-Smtp-Source: AMsMyM6QKVmUoc8taCu3sm2j4ePS23Ac30y4T9hwIpd6b5dbeJIrNhKQwXiEGPxg8kw1Ooob7Mj5qaTf7/DRtZxtf80=
X-Received: by 2002:a05:6512:36c3:b0:4a4:7627:c57 with SMTP id
 e3-20020a05651236c300b004a476270c57mr13915826lfs.398.1667564001510; Fri, 04
 Nov 2022 05:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221103072102.2320490-1-yhs@fb.com> <20221103072118.2323222-1-yhs@fb.com>
 <20221103221715.zyegpoc3puz6oimx@apollo>
In-Reply-To: <20221103221715.zyegpoc3puz6oimx@apollo>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Nov 2022 13:13:10 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6m_H4cq=7SgYcaoYE9qGgquEh6FPHe9Kpr=j-DUCnvXg@mail.gmail.com>
Message-ID: <CACYkzJ6m_H4cq=7SgYcaoYE9qGgquEh6FPHe9Kpr=j-DUCnvXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 11:17 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, Nov 03, 2022 at 12:51:18PM IST, Yonghong Song wrote:
> > A new bpf_type_flag MEM_RCU is added to indicate a PTR_TO_BTF_ID
> > object access needing rcu_read_lock protection. The rcu protection
> > is not needed for non-sleepable program. So various verification
> > checking is only done for sleepable programs. In particular, only
> > the following insns can be inside bpf_rcu_read_lock() region:
> >   - any non call insns except BPF_ABS/BPF_IND
> >   - non sleepable helpers and kfuncs.
> > Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
> > allocation flag) should be GFP_ATOMIC.
> >
> > If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
> > this pointer and the load which gets this pointer needs to be
> > protected by bpf_rcu_read_lock(). The following shows a couple
> > of examples:
> >   struct task_struct {
> >       ...
> >       struct task_struct __rcu        *real_parent;
> >       struct css_set __rcu            *cgroups;
> >       ...
> >   };
> >   struct css_set {
> >       ...
> >       struct cgroup *dfl_cgrp;
> >       ...
> >   }
> >   ...
> >   task = bpf_get_current_task_btf();
> >   cgroups = task->cgroups;
> >   dfl_cgroup = cgroups->dfl_cgrp;
> >   ... using dfl_cgroup ...
> >
> > The bpf_rcu_read_lock/unlock() should be added like below to
> > avoid verification failures.
> >   task = bpf_get_current_task_btf();
> >   bpf_rcu_read_lock();
> >   cgroups = task->cgroups;
> >   dfl_cgroup = cgroups->dfl_cgrp;
> >   bpf_rcu_read_unlock();
> >   ... using dfl_cgroup ...
> >
> > The following is another example for task->real_parent.
> >   task = bpf_get_current_task_btf();
> >   bpf_rcu_read_lock();
> >   real_parent = task->real_parent;
> >   ... bpf_task_storage_get(&map, real_parent, 0, 0);
> >   bpf_rcu_read_unlock();
> >
> > There is another case observed in selftest bpf_iter_ipv6_route.c:
> >   struct fib6_info *rt = ctx->rt;
> >   ...
> >   fib6_nh = &rt->fib6_nh[0]; // Not rcu protected
> >   ...
> >   if (rt->nh)
> >     fib6_nh = &nh->nh_info->fib6_nh; // rcu protected
> >   ...
> >   ... using fib6_nh ...
> > Currently verification will fail with
> >   same insn cannot be used with different pointers
> > since the use of fib6_nh is tag with rcu in one path
> > but not in the other path. The above use case is a valid
> > one so the verifier is changed to ignore MEM_RCU type tag
> > in such cases.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  include/linux/bpf.h          |   3 +
> >  include/linux/bpf_verifier.h |   1 +
> >  kernel/bpf/btf.c             |  11 +++
> >  kernel/bpf/verifier.c        | 126 ++++++++++++++++++++++++++++++++---
> >  4 files changed, 133 insertions(+), 8 deletions(-)

[...]

> > +
>
> This isn't right. Every load that obtains an RCU pointer needs to become tied to
> the current RCU section, and needs to be invalidated once the RCU section ends.
>
> So in addition to checking that bpf_rcu_read_lock is held around MEM_RCU access,
> you need to invalidate all MEM_RCU pointers when bpf_rcu_read_unlock is called.
>
> Otherwise, with the current logic, the following would become possible:
>
> bpf_rcu_read_lock();
> p = rcu_dereference(foo->rcup);
> bpf_rcu_read_unlock();
>
> // p is possibly dead
>
> bpf_rcu_read_lock();
> // use p
> bpf_rcu_read_unlock();
>

What do want to do about cases like:

bpf_rcu_read_lock();

q = rcu_derference(foo->rcup);

bpf_rcu_read_lock();

p = rcu_derference(foo->rcup);

bpf_rcu_read_unlock();

// Use q
// Use p
bpf_rcu_read_unlock();

I think this is probably implied in your statement but just making it clear,

The invalidation needs to happen only when the outermost bpf_rcu_read_unlock
is called. i.e. when active_rcu_lock goes back down to 0.


> bpf_rcu_read_lock();
> // use p
> bpf_rcu_read_unlock();


> I have pretty much the same patchset lying locally in my tree (waiting for the
> kfunc rework to get in before I post it), but I can also rebase other stuff
> using explicit bpf_rcu_read_lock on top of yours.
>
> >       /* If this is an untrusted pointer, all pointers formed by walking it
> >        * also inherit the untrusted flag.
> >        */
> > @@ -5684,7 +5722,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> >  static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
> >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > +static const struct bpf_reg_types btf_ptr_types = {
> > +     .types = {
> > +             PTR_TO_BTF_ID,
> > +             PTR_TO_BTF_ID | MEM_RCU,
> > +     }
> > +};
> >  static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
> >  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
> >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > @@ -5758,6 +5801,20 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >       if (arg_type & PTR_MAYBE_NULL)
> >               type &= ~PTR_MAYBE_NULL;
> >
> > +     /* If the reg type is marked as MEM_RCU, ensure the usage is in the rcu_read_lock
> > +      * region, and remove MEM_RCU from the type since the arg_type won't encode
> > +      * MEM_RCU.
> > +      */
> > +     if (type & MEM_RCU) {
> > +             if (env->prog->aux->sleepable && !env->cur_state->active_rcu_lock) {
> > +                     verbose(env,
> > +                             "R%d is arg type %s needs rcu protection\n",
> > +                             regno, reg_type_str(env, reg->type));
> > +                     return -EACCES;
> > +             }
> > +             type &= ~MEM_RCU;
> > +     }
> > +
> >       for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
> >               expected = compatible->types[i];
> >               if (expected == NOT_INIT)
> > @@ -5774,7 +5831,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >       return -EACCES;
> >
> >  found:
> > -     if (reg->type == PTR_TO_BTF_ID) {
> > +     /* reg is already protected by rcu_read_lock(). Peel off MEM_RCU from reg->type. */
> > +     if ((reg->type & ~MEM_RCU) == PTR_TO_BTF_ID) {
> >               /* For bpf_sk_release, it needs to match against first member
> >                * 'struct sock_common', hence make an exception for it. This
> >                * allows bpf_sk_release to work for multiple socket types.
> > @@ -5850,6 +5908,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >        * fixed offset.
> >        */
> >       case PTR_TO_BTF_ID:
> > +     case PTR_TO_BTF_ID | MEM_RCU:
> >               /* When referenced PTR_TO_BTF_ID is passed to release function,
> >                * it's fixed offset must be 0. In the other cases, fixed offset
> >                * can be non-zero.
> > @@ -7289,6 +7348,26 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >       }
> >
> >       meta.func_id = func_id;
> > +
> > +     if (func_id == BPF_FUNC_rcu_read_lock)
> > +             env->cur_state->active_rcu_lock++;
> > +     if (func_id == BPF_FUNC_rcu_read_unlock) {
> > +             if (env->cur_state->active_rcu_lock == 0) {
> > +                     verbose(env, "missing bpf_rcu_read_lock\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             env->cur_state->active_rcu_lock--;
> > +     }
> > +     if (env->cur_state->active_rcu_lock) {
> > +             if (is_sleepable_function(func_id))
> > +                     verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",
> > +                             func_id_name(func_id), func_id);
> > +
> > +             if (env->prog->aux->sleepable && is_storage_get_function(func_id))
> > +                     insn->off = BPF_STORAGE_GET_CALL;
>
> This is a bit ugly. Why not use bpf_insn_aux_data?
>
> > +     }
> > +
> >       /* check args */
> >       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> >               err = check_func_arg(env, i, &meta, fn);
> > @@ -10470,6 +10549,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >               return -EINVAL;
> >       }
> >
> > +     if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {
> > +             verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock-ed region\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (regs[ctx_reg].type != PTR_TO_CTX) {
> >               verbose(env,
> >                       "at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
> > @@ -11734,6 +11818,9 @@ static bool states_equal(struct bpf_verifier_env *env,
> >       if (old->active_spin_lock != cur->active_spin_lock)
> >               return false;
> >
> > +     if (old->active_rcu_lock != cur->active_rcu_lock)
> > +             return false;
> > +
> >       /* for states to be equal callsites have to be the same
> >        * and all frame states need to be equivalent
> >        */
> > @@ -12141,6 +12228,11 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
> >                              !reg_type_mismatch_ok(prev));
> >  }
> >
> > +static bool reg_type_mismatch_ignore_rcu(enum bpf_reg_type src, enum bpf_reg_type prev)
> > +{
> > +     return reg_type_mismatch(src & ~MEM_RCU, prev & ~MEM_RCU);
> > +}
> > +
>
> See the discussion about this in David's set:
> https://lore.kernel.org/bpf/CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com
>
> >  static int do_check(struct bpf_verifier_env *env)
> >  {
> >       bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
> > @@ -12266,6 +12358,18 @@ static int do_check(struct bpf_verifier_env *env)
> >
> >                       prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
> >
> > +                     /* For NOT_INIT *prev_src_type, ignore rcu type tag.
> > +                      * For code like below,
> > +                      *   struct foo *f;
> > +                      *   if (...)
> > +                      *     f = ...; // f with MEM_RCU type tag.
> > +                      *   else
> > +                      *     f = ...; // f without MEM_RCU type tag.
> > +                      *   ... f ...  // Here f could be with/without MEM_RCU
> > +                      *
> > +                      * It is safe to ignore MEM_RCU type tag here since
> > +                      * base types are the same.
> > +                      */
> >                       if (*prev_src_type == NOT_INIT) {
> >                               /* saw a valid insn
> >                                * dst_reg = *(u32 *)(src_reg + off)
> > @@ -12273,7 +12377,7 @@ static int do_check(struct bpf_verifier_env *env)
> >                                */
> >                               *prev_src_type = src_reg_type;
> >
> > -                     } else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
> > +                     } else if (reg_type_mismatch_ignore_rcu(src_reg_type, *prev_src_type)) {
> >                               /* ABuser program is trying to use the same insn
> >                                * dst_reg = *(u32*) (src_reg + off)
> >                                * with different pointer types:
> > @@ -12412,6 +12516,11 @@ static int do_check(struct bpf_verifier_env *env)
> >                                       return -EINVAL;
> >                               }
> >
> > +                             if (env->cur_state->active_rcu_lock) {
> > +                                     verbose(env, "bpf_rcu_read_unlock is missing\n");
> > +                                     return -EINVAL;
> > +                             }
> > +
> >                               /* We must do check_reference_leak here before
> >                                * prepare_func_exit to handle the case when
> >                                * state->curframe > 0, it may be a callback
> > @@ -13499,6 +13608,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >                       convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
> >                       break;
> >               case PTR_TO_BTF_ID:
> > +             case PTR_TO_BTF_ID | MEM_RCU:
>
> This shouldn't be needed, right? If it is RCU protected, there shouldn't be a
> need for handling faults (or it's a bug in the kernel).
>
> >               case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> >                       if (type == BPF_READ) {
> >                               insn->code = BPF_LDX | BPF_PROBE_MEM |
> > @@ -14148,11 +14258,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >                       goto patch_call_imm;
> >               }
> >
> > -             if (insn->imm == BPF_FUNC_task_storage_get ||
> > -                 insn->imm == BPF_FUNC_sk_storage_get ||
> > -                 insn->imm == BPF_FUNC_inode_storage_get ||
> > -                 insn->imm == BPF_FUNC_cgrp_storage_get) {
> > -                     if (env->prog->aux->sleepable)
> > +             if (is_storage_get_function(insn->imm)) {
> > +                     if (env->prog->aux->sleepable && insn->off) {
> > +                             insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> > +                             insn->off = 0;
> > +                     } else if (env->prog->aux->sleepable)
> >                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
> >                       else
> >                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> > --
> > 2.30.2
> >
