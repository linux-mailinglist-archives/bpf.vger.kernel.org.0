Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B78F505FB4
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 00:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiDRWXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 18:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiDRWXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 18:23:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717B29CB4
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:20:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u7so26320690lfs.8
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+pPEgwjMxsdFgWZ1LJ8YuaAFzPGK66v01j3/5B/rO8=;
        b=ON5wv49wF7HCllbSoGpmTO1OzeRpN0G2rXESNwhBzTczYbhvRx5M0O/dCGg+87lxiW
         0/Bpw1FJFCUa/SvvlyqATFUThpdnDtvAUeyemhNF4/11CTyhPCSIUmVA7QBonzRDuvX1
         oQQM1fD33ZESPFMFmz+lrjxa/1NXj8vOd4e1aF8aPlBsAFrNKYPTqTyMWGi9j8Db9ASR
         bezUWN0o7ezOjQmKY2djHawr+HBvHtUKPuytYTJ1breUiZTYjs+Rsdt7ML0FJ3MtDzsq
         mNvvauccL5ieQCvEw8J3p/qZ+0bZca+38FkN/Vyn+M+fH4zPgupomMCImXaxdlg0oOUn
         pHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+pPEgwjMxsdFgWZ1LJ8YuaAFzPGK66v01j3/5B/rO8=;
        b=zyaP7/g19+lDCg7D3OEAsy5bNUBg40r1zltKQQBTGspq+LJLdzJvp+sf6lwM0SzNlh
         CGZ67Uu9L8mbDYi8J6eb+NVoUdvClelTymBRTNmkDeR9jb7DMNO3yqFqW3+lG4sPguCM
         UjtSht9T+WVJ/qMx2ALs3RfQBjHZ1wHEIZ6yHTbDtSFnRM0lxWwgTcu+UUx1LKyWUikU
         Bx20xNQPrW89L35M7qJhlfKecExyZ1/BroWFvCsXDmx0m54Drxa69zLx44+oRK0HwDot
         MDfseo22k4jKtUQQvgsrXYB/uqSoVI8oRcsrll5GCmWPN42Cj26yzDndQqCcJ1vr4Q8z
         +ybA==
X-Gm-Message-State: AOAM5307odm7IUB1aYU4SBDv8jUZpGctF5sLW6yZLUpzGKpXbYUv7yjK
        XPDndhaC+f8G/M/B47rUYbyVxFn3PqflFkYXwPY=
X-Google-Smtp-Source: ABdhPJyFn5TsD4cQGjgAgdNOGF5hqamhby48lgsNdNmpxnajQa+NCOYgrV6ETP1hkb5pn9OHXP0BHw2QYdYawHN4chg=
X-Received: by 2002:a05:6512:39d3:b0:471:a8ce:823b with SMTP id
 k19-20020a05651239d300b00471a8ce823bmr168526lfu.331.1650320449048; Mon, 18
 Apr 2022 15:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220416174205.hezp2jnow3hqk6s6@apollo.legion>
In-Reply-To: <20220416174205.hezp2jnow3hqk6s6@apollo.legion>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 18 Apr 2022 15:20:38 -0700
Message-ID: <CAJnrk1adv16+wgEN+euJgfhXFQ+TUDjL36Bo=w_TtzqgomX00Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

()On Sat, Apr 16, 2022 at 10:42 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Apr 16, 2022 at 12:04:25PM IST, Joanne Koong wrote:
> > This patch adds 3 new APIs and the bulk of the verifier work for
> > supporting dynamic pointers in bpf.
> >
> > There are different types of dynptrs. This patch starts with the most
> > basic ones, ones that reference a program's local memory
> > (eg a stack variable) and ones that reference memory that is dynamically
> > allocated on behalf of the program. If the memory is dynamically
> > allocated by the program, the program *must* free it before the program
> > exits. This is enforced by the verifier.
> >
> > The added APIs are:
> >
> > long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynptr *ptr);
> > long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> > void bpf_dynptr_put(struct bpf_dynptr *ptr);
> >
> > This patch sets up the verifier to support dynptrs. Dynptrs will always
> > reside on the program's stack frame. As such, their state is tracked
> > in their corresponding stack slot, which includes the type of dynptr
> > (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
> >
> > When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> > MEM_UNINIT), the stack slots corresponding to the frame pointer
> > where the dynptr resides at are marked as STACK_DYNPTR. For helper functions
> > that take in initialized dynptrs (such as the next patch in this series
> > which supports dynptr reads/writes), the verifier enforces that the
> > dynptr has been initialized by checking that their corresponding stack
> > slots have been marked as STACK_DYNPTR. Dynptr release functions
> > (eg bpf_dynptr_put) will clear the stack slots. The verifier enforces at
> > program exit that there are no acquired dynptr stack slots that need
> > to be released.
> >
> > There are other constraints that are enforced by the verifier as
> > well, such as that the dynptr cannot be written to directly by the bpf
> > program or by non-dynptr helper functions. The last patch in this series
> > contains tests that trigger different cases that the verifier needs to
> > successfully reject.
> >
> > For now, local dynptrs cannot point to referenced memory since the
> > memory can be freed anytime. Support for this will be added as part
> > of a separate patchset.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            |  68 +++++-
> >  include/linux/bpf_verifier.h   |  28 +++
> >  include/uapi/linux/bpf.h       |  44 ++++
> >  kernel/bpf/helpers.c           | 110 ++++++++++
> >  kernel/bpf/verifier.c          | 372 +++++++++++++++++++++++++++++++--
> >  scripts/bpf_doc.py             |   2 +
> >  tools/include/uapi/linux/bpf.h |  44 ++++
> >  7 files changed, 654 insertions(+), 14 deletions(-)
> >
[...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8deb588a19ce..bf132c6822e4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -187,6 +187,9 @@ struct bpf_verifier_stack_elem {
> >                                         POISON_POINTER_DELTA))
> >  #define BPF_MAP_PTR(X)               ((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
> >
> > +/* forward declarations */
> > +static bool arg_type_is_mem_size(enum bpf_arg_type type);
> > +
> >  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
> >  {
> >       return BPF_MAP_PTR(aux->map_ptr_state) == BPF_MAP_PTR_POISON;
> > @@ -257,7 +260,9 @@ struct bpf_call_arg_meta {
> >       struct btf *ret_btf;
> >       u32 ret_btf_id;
> >       u32 subprogno;
> > -     bool release_ref;
> > +     u8 release_regno;
> > +     bool release_dynptr;
> > +     u8 uninit_dynptr_regno;
> >  };
> >
> >  struct btf *btf_vmlinux;
> > @@ -576,6 +581,7 @@ static char slot_type_char[] = {
> >       [STACK_SPILL]   = 'r',
> >       [STACK_MISC]    = 'm',
> >       [STACK_ZERO]    = '0',
> > +     [STACK_DYNPTR]  = 'd',
> >  };
> >
> >  static void print_liveness(struct bpf_verifier_env *env,
> > @@ -591,6 +597,25 @@ static void print_liveness(struct bpf_verifier_env *env,
> >               verbose(env, "D");
> >  }
> >
> > +static inline int get_spi(s32 off)
> > +{
> > +     return (-off - 1) / BPF_REG_SIZE;
> > +}
> > +
> > +static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, u32 nr_slots)
> > +{
> > +     int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> > +
> > +     /* We need to check that slots between [spi - nr_slots + 1, spi] are
> > +      * within [0, allocated_stack).
> > +      *
> > +      * Please note that the spi grows downwards. For example, a dynptr
> > +      * takes the size of two stack slots; the first slot will be at
> > +      * spi and the second slot will be at spi - 1.
> > +      */
> > +     return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
> > +}
> > +
> >  static struct bpf_func_state *func(struct bpf_verifier_env *env,
> >                                  const struct bpf_reg_state *reg)
> >  {
> > @@ -642,6 +667,191 @@ static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
> >       env->scratched_stack_slots = ~0ULL;
> >  }
> >
> > +#define DYNPTR_TYPE_FLAG_MASK (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_MALLOC)
> > +
> > +static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
> > +{
> > +     switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > +     case DYNPTR_TYPE_LOCAL:
> > +             return BPF_DYNPTR_TYPE_LOCAL;
> > +     case DYNPTR_TYPE_MALLOC:
> > +             return BPF_DYNPTR_TYPE_MALLOC;
> > +     default:
> > +             return BPF_DYNPTR_TYPE_INVALID;
> > +     }
> > +}
> > +
> > +static inline bool dynptr_type_refcounted(enum bpf_dynptr_type type)
> > +{
> > +     return type == BPF_DYNPTR_TYPE_MALLOC;
> > +}
> > +
> > +static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                enum bpf_arg_type arg_type)
> > +{
> > +     struct bpf_func_state *state = cur_func(env);
> > +     enum bpf_dynptr_type type;
> > +     int spi, i;
> > +
> > +     spi = get_spi(reg->off);
> > +
> > +     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > +             return -EINVAL;
> > +
> > +     type = arg_to_dynptr_type(arg_type);
> > +     if (type == BPF_DYNPTR_TYPE_INVALID)
> > +             return -EINVAL;
> > +
> > +     for (i = 0; i < BPF_REG_SIZE; i++) {
> > +             state->stack[spi].slot_type[i] = STACK_DYNPTR;
> > +             state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> > +     }
> > +
> > +     state->stack[spi].spilled_ptr.dynptr.type = type;
> > +     state->stack[spi - 1].spilled_ptr.dynptr.type = type;
> > +
> > +     state->stack[spi].spilled_ptr.dynptr.first_slot = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int spi, i;
> > +
> > +     spi = get_spi(reg->off);
> > +
> > +     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > +             return -EINVAL;
> > +
> > +     for (i = 0; i < BPF_REG_SIZE; i++) {
> > +             state->stack[spi].slot_type[i] = STACK_INVALID;
> > +             state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > +     }
> > +
> > +     state->stack[spi].spilled_ptr.dynptr.type = 0;
> > +     state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> > +
> > +     state->stack[spi].spilled_ptr.dynptr.first_slot = 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int mark_as_dynptr_data(struct bpf_verifier_env *env, const struct bpf_func_proto *fn,
> > +                            struct bpf_reg_state *regs)
> > +{
> > +     struct bpf_func_state *state = cur_func(env);
> > +     struct bpf_reg_state *reg, *mem_reg = NULL;
> > +     enum bpf_arg_type arg_type;
> > +     u64 mem_size;
> > +     u32 nr_slots;
> > +     int i, spi;
> > +
> > +     /* We must protect against the case where a program tries to do something
> > +      * like this:
> > +      *
> > +      * bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local);
> > +      * bpf_dynptr_alloc(16, 0, &ptr);
> > +      * bpf_dynptr_write(&local, 0, corrupt_data, sizeof(ptr));
> > +      *
> > +      * If ptr is a variable on the stack, we must mark the stack slot as
> > +      * dynptr data when a local dynptr to it is created.
> > +      */
> > +     for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > +             arg_type = fn->arg_type[i];
> > +             reg = &regs[BPF_REG_1 + i];
> > +
> > +             if (base_type(arg_type) == ARG_PTR_TO_MEM) {
> > +                     if (base_type(reg->type) == PTR_TO_STACK) {
> > +                             mem_reg = reg;
> > +                             continue;
> > +                     }
> > +                     /* if it's not a PTR_TO_STACK, then we don't need to
> > +                      * mark anything since it can never be used as a dynptr.
> > +                      * We can just return here since there will always be
> > +                      * only one ARG_PTR_TO_MEM in fn.
> > +                      */
> > +                     return 0;
> > +             } else if (arg_type_is_mem_size(arg_type)) {
> > +                     mem_size = roundup(reg->var_off.value, BPF_REG_SIZE);
> > +             }
> > +     }
> > +
> > +     if (!mem_reg || !mem_size) {
> > +             verbose(env, "verifier internal error: invalid ARG_PTR_TO_MEM args for %s\n", __func__);
> > +             return -EFAULT;
> > +     }
> > +
> > +     spi = get_spi(mem_reg->off);
> > +     if (!is_spi_bounds_valid(state, spi, mem_size)) {
> > +             verbose(env, "verifier internal error: variable not initialized on stack in %s\n", __func__);
> > +             return -EFAULT;
> > +     }
> > +
> > +     nr_slots = mem_size / BPF_REG_SIZE;
> > +     for (i = 0; i < nr_slots; i++)
> > +             state->stack[spi - i].spilled_ptr.is_dynptr_data = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                    bool *is_dynptr_data)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int spi;
> > +
> > +     spi = get_spi(reg->off);
> > +
> > +     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > +             return true;
> > +
> > +     if (state->stack[spi].slot_type[0] == STACK_DYNPTR ||
> > +         state->stack[spi - 1].slot_type[0] == STACK_DYNPTR)
> > +             return false;
> > +
> > +     if (state->stack[spi].spilled_ptr.is_dynptr_data ||
> > +         state->stack[spi - 1].spilled_ptr.is_dynptr_data) {
> > +             *is_dynptr_data = true;
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                  enum bpf_arg_type arg_type)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int spi = get_spi(reg->off);
> > +
> > +     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > +         state->stack[spi].slot_type[0] != STACK_DYNPTR ||
> > +         state->stack[spi - 1].slot_type[0] != STACK_DYNPTR ||
> > +         !state->stack[spi].spilled_ptr.dynptr.first_slot)
> > +             return false;
> > +
> > +     /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> > +     if (arg_type == ARG_PTR_TO_DYNPTR)
> > +             return true;
> > +
> > +     return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
> > +}
> > +
> > +static bool stack_access_into_dynptr(struct bpf_func_state *state, int spi, int size)
> > +{
> > +     int nr_slots = roundup(size, BPF_REG_SIZE) / BPF_REG_SIZE;
> > +     int i;
> > +
> > +     for (i = 0; i < nr_slots; i++) {
> > +             if (state->stack[spi - i].slot_type[0] == STACK_DYNPTR)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /* The reg state of a pointer or a bounded scalar was saved when
> >   * it was spilled to the stack.
> >   */
> > @@ -2878,6 +3088,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >       }
> >
> >       mark_stack_slot_scratched(env, spi);
> > +
> > +     if (stack_access_into_dynptr(state, spi, size)) {
> > +             verbose(env, "direct write into dynptr is not permitted\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> >           !register_is_null(reg) && env->bpf_capable) {
> >               if (dst_reg != BPF_REG_FP) {
> > @@ -2999,6 +3215,12 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
> >               slot = -i - 1;
> >               spi = slot / BPF_REG_SIZE;
> >               stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
> > +
> > +             if (*stype == STACK_DYNPTR) {
> > +                     verbose(env, "direct write into dynptr is not permitted\n");
> > +                     return -EINVAL;
> > +             }
> > +
> >               mark_stack_slot_scratched(env, spi);
> >
> >               if (!env->allow_ptr_leaks
> > @@ -5141,6 +5363,16 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> >              type == ARG_PTR_TO_LONG;
> >  }
> >
> > +static inline bool arg_type_is_dynptr(enum bpf_arg_type type)
> > +{
> > +     return base_type(type) == ARG_PTR_TO_DYNPTR;
> > +}
> > +
> > +static inline bool arg_type_is_dynptr_uninit(enum bpf_arg_type type)
> > +{
> > +     return arg_type_is_dynptr(type) && (type & MEM_UNINIT);
> > +}
> > +
> >  static int int_ptr_type_to_size(enum bpf_arg_type type)
> >  {
> >       if (type == ARG_PTR_TO_INT)
> > @@ -5278,6 +5510,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> >       [ARG_PTR_TO_STACK]              = &stack_ptr_types,
> >       [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
> >       [ARG_PTR_TO_TIMER]              = &timer_types,
> > +     [ARG_PTR_TO_DYNPTR]             = &stack_ptr_types,
> >  };
> >
> >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > @@ -5450,10 +5683,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               return err;
> >
> >  skip_type_check:
> > -     /* check_func_arg_reg_off relies on only one referenced register being
> > -      * allowed for BPF helpers.
> > -      */
> >       if (reg->ref_obj_id) {
> > +             if (arg_type & NO_OBJ_REF) {
> > +                     verbose(env, "Arg #%d cannot be a referenced object\n",
> > +                             arg + 1);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /* check_func_arg_reg_off relies on only one referenced register being
> > +              * allowed for BPF helpers.
> > +              */
> >               if (meta->ref_obj_id) {
> >                       verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> >                               regno, reg->ref_obj_id,
> > @@ -5463,16 +5702,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               meta->ref_obj_id = reg->ref_obj_id;
> >       }
> >       if (arg_type & OBJ_RELEASE) {
> > -             if (!reg->ref_obj_id) {
> > +             if (arg_type_is_dynptr(arg_type)) {
> > +                     struct bpf_func_state *state = func(env, reg);
> > +                     int spi = get_spi(reg->off);
> > +
> > +                     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > +                         !state->stack[spi].spilled_ptr.id) {
> > +                             verbose(env, "arg %d is an unacquired reference\n", regno);
> > +                             return -EINVAL;
> > +                     }
> > +                     meta->release_dynptr = true;
> > +             } else if (!reg->ref_obj_id) {
> >                       verbose(env, "arg %d is an unacquired reference\n", regno);
> >                       return -EINVAL;
> >               }
> > -             if (meta->release_ref) {
> > -                     verbose(env, "verifier internal error: more than one release_ref arg R%d\n",
> > -                             regno);
> > +             if (meta->release_regno) {
> > +                     verbose(env, "verifier internal error: more than one release_regno %u %u\n",
> > +                             meta->release_regno, regno);
> >                       return -EFAULT;
> >               }
> > -             meta->release_ref = true;
> > +             meta->release_regno = regno;
> >       }
> >
> >       if (arg_type == ARG_CONST_MAP_PTR) {
> > @@ -5565,6 +5814,44 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> >
> >               err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > +     } else if (arg_type_is_dynptr(arg_type)) {
> > +             /* Can't pass in a dynptr at a weird offset */
> > +             if (reg->off % BPF_REG_SIZE) {
>
> In invalid_helper2 test, you are passing &dynptr + 8, which means reg will be
> fp-8 (assuming dynptr is at top of stack), get_spi will compute spi as 0, so
> spi-1 will lead to OOB access for the second dynptr stack slot. If you run the
> dynptr test under KASAN, you should see a warning for this.
>
> So we should ensure here that reg->off is atleast -16.
I think this is already checked against in is_spi_bounds(), where we
explicitly check that spi - 1 and spi is between [0, the allocated
stack). is_spi_bounds() gets called in "is_dynptr_reg_valid_init()" a
few lines down where we check if the initialized dynptr arg that's
passed in by the program is valid.

On my local environment, I simulated this "reg->off = -8" case and
this fails the is_dynptr_reg_valid_init() -> is_spi_bounds() check and
we get back the correct verifier error "Expected an initialized dynptr
as arg #3" without any OOB accesses. I also tried running it with
CONFIG_KASAN=y as well and didn't see any warnings show up. But maybe
I'm missing something in this analysis - what are your thoughts?
>
> > +                     verbose(env, "cannot pass in non-zero dynptr offset\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (arg_type & MEM_UNINIT)  {
> > +                     bool is_dynptr_data = false;
> > +
> > +                     if (!is_dynptr_reg_valid_uninit(env, reg, &is_dynptr_data)) {
> > +                             if (is_dynptr_data)
> > +                                     verbose(env, "Arg #%d cannot be a memory reference for another dynptr\n",
> > +                                             arg + 1);
> > +                             else
> > +                                     verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
> > +                                             arg + 1);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     meta->uninit_dynptr_regno = arg + BPF_REG_1;
> > +             } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > +                     const char *err_extra = "";
> > +
> > +                     switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > +                     case DYNPTR_TYPE_LOCAL:
> > +                             err_extra = "local ";
> > +                             break;
> > +                     case DYNPTR_TYPE_MALLOC:
> > +                             err_extra = "malloc ";
> > +                             break;
> > +                     default:
> > +                             break;
> > +                     }
> > +                     verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > +                             err_extra, arg + 1);
> > +                     return -EINVAL;
> > +             }
> >       } else if (arg_type_is_alloc_size(arg_type)) {
> >               if (!tnum_is_const(reg->var_off)) {
> >                       verbose(env, "R%d is not a known constant'\n",
> > @@ -6545,6 +6832,28 @@ static int check_reference_leak(struct bpf_verifier_env *env)
> >       return state->acquired_refs ? -EINVAL : 0;
> >  }
> >
> > +/* Called at BPF_EXIT to detect if there are any reference-tracked dynptrs that have
> > + * not been released. Dynptrs to local memory do not need to be released.
> > + */
> > +static int check_dynptr_unreleased(struct bpf_verifier_env *env)
> > +{
> > +     struct bpf_func_state *state = cur_func(env);
> > +     int allocated_slots, i;
> > +
> > +     allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> > +
> > +     for (i = 0; i < allocated_slots; i++) {
> > +             if (state->stack[i].slot_type[0] == STACK_DYNPTR) {
> > +                     if (dynptr_type_refcounted(state->stack[i].spilled_ptr.dynptr.type)) {
> > +                             verbose(env, "spi=%d is an unreleased dynptr\n", i);
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> >                                  struct bpf_reg_state *regs)
> >  {
> > @@ -6686,8 +6995,38 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                       return err;
> >       }
> >
> > -     if (meta.release_ref) {
> > -             err = release_reference(env, meta.ref_obj_id);
> > +     regs = cur_regs(env);
> > +
> > +     if (meta.uninit_dynptr_regno) {
> > +             enum bpf_arg_type type;
> > +
> > +             /* we write BPF_W bits (4 bytes) at a time */
> > +             for (i = 0; i < BPF_DYNPTR_SIZE; i += 4) {
> > +                     err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
> > +                                            i, BPF_W, BPF_WRITE, -1, false);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +
> > +             type = fn->arg_type[meta.uninit_dynptr_regno - BPF_REG_1];
> > +
> > +             err = mark_stack_slots_dynptr(env, &regs[meta.uninit_dynptr_regno], type);
> > +             if (err)
> > +                     return err;
> > +
> > +             if (type & DYNPTR_TYPE_LOCAL) {
> > +                     err = mark_as_dynptr_data(env, fn, regs);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +     }
> > +
> > +     if (meta.release_regno) {
> > +             if (meta.release_dynptr) {
> > +                     err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> > +             } else {
> > +                     err = release_reference(env, meta.ref_obj_id);
> > +             }
> >               if (err) {
> >                       verbose(env, "func %s#%d reference has not been acquired before\n",
> >                               func_id_name(func_id), func_id);
> > @@ -6695,8 +7034,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >               }
> >       }
> >
> > -     regs = cur_regs(env);
> > -
> >       switch (func_id) {
> >       case BPF_FUNC_tail_call:
> >               err = check_reference_leak(env);
> > @@ -6704,6 +7041,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                       verbose(env, "tail_call would lead to reference leak\n");
> >                       return err;
> >               }
> > +             err = check_dynptr_unreleased(env);
> > +             if (err) {
> > +                     verbose(env, "tail_call would lead to dynptr memory leak\n");
> > +                     return err;
> > +             }
> >               break;
> >       case BPF_FUNC_get_local_storage:
> >               /* check that flags argument in get_local_storage(map, flags) is 0,
> > @@ -11696,6 +12038,10 @@ static int do_check(struct bpf_verifier_env *env)
> >                                       return -EINVAL;
> >                               }
> >
> > +                             err = check_dynptr_unreleased(env);
> > +                             if (err)
> > +                                     return err;
> > +
> >                               if (state->curframe) {
> >                                       /* exit from nested function */
> >                                       err = prepare_func_exit(env, &env->insn_idx);
[...]
> > --
> > 2.30.2
> >
>
> --
> Kartikeya
