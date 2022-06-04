Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945053D402
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 02:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiFDAGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 20:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFDAGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 20:06:42 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0901D4F9EF
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 17:06:41 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 63so3019811uaw.10
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PbKIp+odkFJcBkYN1ZjyoEJuv0aebK+7rWnlWmDbGA=;
        b=SiD4Y/CvCkkJ80o2GyxCZExOX4vRSfy1nr+46Ie9YclbZHd4gH30/qKnWHAh2uN3dH
         3NQl9HUyDEOxUfDwtFY3P2M87/QqpyRSv8NBQ/jEDod1o07KkpkD/7nvG6p8WpoXbqLq
         RA8mScVNjqeT6ZXwKaRx81+Irg8p9x91t3qGQ63j9Tp9Bn7Pp+pIZqyQFg2clr05lu+C
         EQavERAtvlJWpD+1/AkpVKfkm8NUw3dGmOKgU1AjpRoidrbgvwF6qEtI+dsto2e63NCJ
         L6XK7YqsdEyFcpnrg90mCM54C3rDYTiMJWXx+zM5VzdChi2t/chtu95fYXSp86mcOU6f
         9KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PbKIp+odkFJcBkYN1ZjyoEJuv0aebK+7rWnlWmDbGA=;
        b=hTnGc7PNVQPdFGzxH51aaLJR+4HPMxseB2FCWWxjE8q5oo/FPAOwrqZ2OC4VR3HTed
         QvyXQ5frso/zy6a7LjhBRkXAi6agRldW5idi3HmCB8iGqqfmU/N9WFx0J/9hWZh4Zh9h
         HEazi5LfYdR2cjQT84UkL2p/NmL52Jj+G6cP4FSutYxUPNtFj8e6kGWflK+DR9qbZ9g/
         qtHv8ZpByzHGD1v/7SOhgO8d+Xb0mOgtGQbW1bS81SQePXUv9tVIBsoRWctJ2nFZPiB0
         2ORfRIo5EL+bx35GnVPiSX/q6ydcV63g2w7/CvGgEnZFM2G9zAKdLgMoSEWjAUuevzKE
         1wqw==
X-Gm-Message-State: AOAM532m5JRijjaEu70tbwUJu/Tyfs+Ty4JgeFhhaYEVIlFZJ8Yr5fMT
        uTi3HhAwI0/zWcLs+cEUfkvZE2MAf1O920tHPDQ=
X-Google-Smtp-Source: ABdhPJxr52HCdf4tpJhcsgR42ee4sFDLPK+Td0donPWCFup/AbOKSESN434ZtA/h4kdFLrwd6K5JMLJiAs++SVHmYUM=
X-Received: by 2002:ab0:3810:0:b0:373:5d1e:ecb4 with SMTP id
 x16-20020ab03810000000b003735d1eecb4mr10342565uav.71.1654301199954; Fri, 03
 Jun 2022 17:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-4-eddyz87@gmail.com>
In-Reply-To: <20220603141047.2163170-4-eddyz87@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 3 Jun 2022 17:06:29 -0700
Message-ID: <CAJnrk1YZB_9WNtUv1yU4VacDuMUSA_iB6=Nc14fR7sw9RadZ2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        song@kernel.org
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

On Fri, Jun 3, 2022 at 11:51 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Calls to `bpf_loop` are replaced with direct loops to avoid
> indirection. E.g. the following:
>
>   bpf_loop(10, foo, NULL, 0);
>
> Is replaced by equivalent of the following:
>
>   for (int i = 0; i < 10; ++i)
>     foo(i, NULL);
>
> This transformation could be applied when:
> - callback is known and does not change during program execution;
> - flags passed to `bpf_loop` are always zero.
>
> Inlining logic works as follows:
>
> - During execution simulation function `update_loop_inline_state`
>   tracks the following information for each `bpf_loop` call
>   instruction:
>   - is callback known and constant?
>   - are flags constant and zero?
> - Function `adjust_stack_depth_for_loop_inlining` increases stack
>   depth for functions where `bpf_loop` calls could be inlined. This is
>   needed to spill registers R6, R7 and R8. These registers are used as
>   loop counter, loop maximal bound and callback context parameter;
> - Function `inline_bpf_loop` called from `do_misc_fixups` replaces
>   `bpf_loop` calls fit for inlining with corresponding loop
>   instructions.
>
> Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU / KVM on
> i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  16 +++
>  kernel/bpf/bpf_iter.c        |   9 +-
>  kernel/bpf/verifier.c        | 199 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 215 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e8439f6cbe57..80279616a76b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -20,6 +20,8 @@
>  #define BPF_MAX_VAR_SIZ        (1 << 29)
>  /* size of type_str_buf in bpf_verifier. */
>  #define TYPE_STR_BUF_LEN 64
> +/* Maximum number of loops for bpf_loop */
> +#define BPF_MAX_LOOPS  BIT(23)

Should this be moved to include/linux/bpf.h since
kernel/bpf/bpf_iter.c also uses this? Then we don't need the "#include
<linux/bpf_verifier.h>" in bpf_iter.c

>
>  /* Liveness marks, used for registers and spilled-regs (in stack slots).
>   * Read marks propagate upwards until they find a write mark; they record that
> @@ -344,6 +346,16 @@ struct bpf_verifier_state_list {
>         int miss_cnt, hit_cnt;
>  };
>
> +struct bpf_loop_inline_state {
> +       u32 initialized:1; /* set to true upon first entry */
> +       u32 callback_is_constant:1; /* true if callback function
> +                                    * is the same at each call
> +                                    */
> +       u32 flags_is_zero:1; /* true if flags register is zero at each call */

I think the more straightforward

bool initialized;
bool callback_is_constant;
bool flags_is_zero;

ends up being the same size as using bit fields.

If your intention was to use bit fields to try to minimize the size of
the struct, I think we could do something like:

bool initialized:1;
bool callback_is_constant:1;
bool flags_is_zero:1;
 /* u16 since bpf_subprog_info.stack_depth is u16; we take the
negative of it whenever we use it since the stack grows downwards */
u16 stack_depth;
u32 callback_subprogno;

to make the struct more compact.

Also, as a side-note, I think if we have an "is_valid" field, then we
don't need both the "callback_is_constant" and "flags_is_zero" fields.
If the flags is not zero or the callback subprogno is not the same on
each invocation of the instruction, then we could represent that by
just setting is_valid to false.

> +       u32 callback_subprogno; /* valid when callback_is_constant == 1 */
> +       s32 stack_base; /* stack offset for loop vars */
> +};
> +
>  /* Possible states for alu_state member. */
>  #define BPF_ALU_SANITIZE_SRC           (1U << 0)
>  #define BPF_ALU_SANITIZE_DST           (1U << 1)
> @@ -380,6 +392,10 @@ struct bpf_insn_aux_data {
>         bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
>         bool zext_dst; /* this insn zero extends dst reg */
>         u8 alu_state; /* used in combination with alu_limit */
> +       /* if instruction is a call to bpf_loop this field tracks
> +        * the state of the relevant registers to take decision about inlining
> +        */
> +       struct bpf_loop_inline_state loop_inline_state;

Is placing this inside the union in "struct bpf_insn_aux_data" an option?

>
>         /* below fields are initialized once */
>         unsigned int orig_idx; /* original instruction index */
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index d5d96ceca105..cdb898fce118 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -6,6 +6,7 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/rcupdate_trace.h>
> +#include <linux/bpf_verifier.h>
>
>  struct bpf_iter_target_info {
>         struct list_head list;
> @@ -723,9 +724,6 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>         .arg4_type      = ARG_ANYTHING,
>  };
>
> -/* maximum number of loops */
> -#define MAX_LOOPS      BIT(23)
> -
>  BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>            u64, flags)
>  {
> @@ -733,9 +731,12 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>         u64 ret;
>         u32 i;
>
> +       /* note: these safety checks are also verified when bpf_loop is inlined,
> +        * be careful to modify this code in sync
> +        */
>         if (flags)
>                 return -EINVAL;
> -       if (nr_loops > MAX_LOOPS)
> +       if (nr_loops > BPF_MAX_LOOPS)
>                 return -E2BIG;
>
>         for (i = 0; i < nr_loops; i++) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index aedac2ac02b9..27d78fe6c3f9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7103,6 +7103,78 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
>         return -ENOTSUPP;
>  }
>
> +static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
> +{
> +       return &env->insn_aux_data[env->insn_idx];
> +}
> +
> +static bool fit_for_bpf_loop_inline(struct bpf_insn_aux_data *insn_aux)
> +{
> +       return insn_aux->loop_inline_state.initialized &&
> +               insn_aux->loop_inline_state.flags_is_zero &&
> +               insn_aux->loop_inline_state.callback_is_constant;
> +}
> +
> +/* For all sub-programs in the program (including main) checks

nit: "check" without the extra s :)

> + * insn_aux_data to see if there are bpf_loop calls that require
> + * inlining. If such calls are found subprog stack_depth is increased
> + * by the size of 3 registers. Reserved space would be used in the
> + * do_misc_fixups to spill values of the R6, R7, R8 to use these
> + * registers for loop iteration.
> + */
> +static void adjust_stack_depth_for_loop_inlining(struct bpf_verifier_env *env)
> +{
> +       int i, subprog_end, cur_subprog = 0;
> +       struct bpf_subprog_info *subprogs = env->subprog_info;
nit: I think this needs to be above the "int i, subprog_end..." line
since it's longer

> +       int insn_cnt = env->prog->len;
> +       bool subprog_updated = false;
> +       s32 stack_base;
> +
> +       subprog_end = (env->subprog_cnt > 1
> +                      ? subprogs[cur_subprog + 1].start
> +                      : insn_cnt);
> +       for (i = 0; i < insn_cnt; i++) {
> +               struct bpf_insn_aux_data *aux = &env->insn_aux_data[i];

Maybe this should be "struct bpf_loop_inline_state *inline_state =
&env->insn_aux_data[i].loop_inline_state" since we only use aux for
aux.loop_inline_state

> +
> +               if (fit_for_bpf_loop_inline(aux)) {
> +                       if (!subprog_updated) {
> +                               subprog_updated = true;
> +                               subprogs[cur_subprog].stack_depth += BPF_REG_SIZE * 3;
> +                               stack_base = -subprogs[cur_subprog].stack_depth;
> +                       }
> +                       aux->loop_inline_state.stack_base = stack_base;
> +               }
> +               if (i == subprog_end - 1) {
> +                       subprog_updated = false;
> +                       cur_subprog++;
> +                       if (cur_subprog < env->subprog_cnt)
> +                               subprog_end = subprogs[cur_subprog + 1].start;
> +               }
> +       }
> +
> +       env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;

In the case where a subprogram that is not subprogram 0 is a fit for
the bpf loop inline and thus increases its stack depth, won't
env->prog->aux->stack_depth need to also be updated?

> +}
> +
> +static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> +{
> +       struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> +       struct bpf_reg_state *regs = cur_regs(env);
> +       struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
> +
> +       int flags_is_zero =
> +               register_is_const(flags_reg) && flags_reg->var_off.value == 0;
> +
> +       if (state->initialized) {
> +               state->flags_is_zero &= flags_is_zero;
> +               state->callback_is_constant &= state->callback_subprogno == subprogno;
> +       } else {
> +               state->initialized = 1;
> +               state->callback_is_constant = 1;
> +               state->flags_is_zero = flags_is_zero;
> +               state->callback_subprogno = subprogno;
> +       }
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                              int *insn_idx_p)
>  {
> @@ -7255,6 +7327,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 err = check_bpf_snprintf_call(env, regs);
>                 break;
>         case BPF_FUNC_loop:
> +               update_loop_inline_state(env, meta.subprogno);
>                 err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
>                                         set_loop_callback_state);
>                 break;
> @@ -7661,11 +7734,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
>         return true;
>  }
>
> -static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
> -{
> -       return &env->insn_aux_data[env->insn_idx];
> -}
> -
>  enum {
>         REASON_BOUNDS   = -1,
>         REASON_TYPE     = -2,
> @@ -12920,6 +12988,22 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
>         return new_prog;
>  }
>
> +static void adjust_loop_inline_subprogno(struct bpf_verifier_env *env,
> +                                        u32 first_removed,
> +                                        u32 first_remaining)
> +{
> +       int delta = first_remaining - first_removed;
> +
> +       for (int i = 0; i < env->prog->len; ++i) {
> +               struct bpf_loop_inline_state *state =
> +                       &env->insn_aux_data[i].loop_inline_state;
> +
> +               if (state->initialized &&
> +                   state->callback_subprogno >= first_remaining)
> +                       state->callback_subprogno -= delta;
> +       }
> +}
> +
>  static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
>                                               u32 off, u32 cnt)
>  {
> @@ -12963,6 +13047,8 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
>                          * in adjust_btf_func() - no need to adjust
>                          */
>                 }
> +
> +               adjust_loop_inline_subprogno(env, i, j);
>         } else {
>                 /* convert i from "first prog to remove" to "first to adjust" */
>                 if (env->subprog_info[i].start == off)
> @@ -13773,6 +13859,94 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> +static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
> +                                       int position, u32 *cnt)
> +{
> +       struct bpf_insn_aux_data *aux = &env->insn_aux_data[position];
> +       s32 stack_base = aux->loop_inline_state.stack_base;
> +       s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
> +       s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
> +       s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
> +       int reg_loop_max = BPF_REG_6;
> +       int reg_loop_cnt = BPF_REG_7;
> +       int reg_loop_ctx = BPF_REG_8;
> +
> +       struct bpf_prog *new_prog;
> +       u32 callback_subprogno = aux->loop_inline_state.callback_subprogno;
> +       u32 callback_start;
> +       u32 call_insn_offset;
> +       s32 callback_offset;
> +       struct bpf_insn insn_buf[19];
> +       struct bpf_insn *next = insn_buf;
> +       struct bpf_insn *call, *jump_to_end, *loop_header;
> +       struct bpf_insn *jump_to_header, *loop_exit;
> +
> +       /* Return error and jump to the end of the patch if
> +        * expected number of iterations is too big.  This
> +        * repeats the check done in bpf_loop helper function,
> +        * be careful to modify this code in sync.
> +        */
> +       (*next++) = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
> +       (*next++) = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
> +       jump_to_end = next;
> +       (*next++) = BPF_JMP_IMM(BPF_JA, 0, 0, 0 /* set below */);
> +       /* spill R6, R7, R8 to use these as loop vars */
> +       (*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
> +       (*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
> +       (*next++) = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
> +       /* initialize loop vars */
> +       (*next++) = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
> +       (*next++) = BPF_MOV32_IMM(reg_loop_cnt, 0);
> +       (*next++) = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
> +       /* loop header;
> +        * if reg_loop_cnt >= reg_loop_max skip the loop body
> +        */
> +       loop_header = next;
> +       (*next++) = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max,
> +                               0 /* set below */);
> +       /* callback call */
> +       (*next++) = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
> +       (*next++) = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
> +       call = next;
> +       (*next++) = BPF_CALL_REL(0 /* set below after patching */);
> +       /* increment loop counter */
> +       (*next++) = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
> +       /* jump to loop header if callback returned 0 */
> +       jump_to_header = next;
> +       (*next++) = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0 /* set below */);
> +       /* return value of bpf_loop;
> +        * set R0 to the number of iterations
> +        */
> +       loop_exit = next;
> +       (*next++) = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
> +       /* restore original values of R6, R7, R8 */
> +       (*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
> +       (*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
> +       (*next++) = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
> +
> +       *cnt = next - insn_buf;
> +       if (*cnt > ARRAY_SIZE(insn_buf)) {
> +               WARN_ONCE(1, "BUG %s: 'next' exceeds bounds for 'insn_buf'\n",
> +                         __func__);
> +               return NULL;
> +       }
> +       jump_to_end->off = next - jump_to_end - 1;
> +       loop_header->off = loop_exit - loop_header - 1;
> +       jump_to_header->off = loop_header - jump_to_header - 1;
> +
> +       new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
> +       if (!new_prog)
> +               return new_prog;
> +
> +       /* callback start is known only after patching */
> +       callback_start = env->subprog_info[callback_subprogno].start;
> +       call_insn_offset = position + (call - insn_buf);
> +       callback_offset = callback_start - call_insn_offset - 1;
> +       env->prog->insnsi[call_insn_offset].imm = callback_offset;
> +
> +       return new_prog;
> +}
> +
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> @@ -14258,6 +14432,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                         continue;
>                 }
>
> +               if (insn->imm == BPF_FUNC_loop &&
> +                   fit_for_bpf_loop_inline(&env->insn_aux_data[i + delta])) {
> +                       new_prog = inline_bpf_loop(env, i + delta, &cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    += cnt - 1;
> +                       env->prog = prog = new_prog;
> +                       insn      = new_prog->insnsi + i + delta;
> +                       continue;
> +               }
> +
>  patch_call_imm:
>                 fn = env->ops->get_func_proto(insn->imm, env->prog);
>                 /* all functions that have prototype and verifier allowed
> @@ -15030,6 +15216,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>         if (ret == 0)
>                 ret = check_max_stack_depth(env);
>
> +       if (ret == 0)
> +               adjust_stack_depth_for_loop_inlining(env);

Do we need to do this before the check_max_stack_depth() call above
since adjust_stack_depth_for_loop_inlining() adjusts the stack depth?

> +
>         /* instruction rewrites happen after this point */
>         if (is_priv) {
>                 if (ret == 0)
> --
> 2.25.1
>
