Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE24F3259C0
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhBYWmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 17:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBYWl7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 17:41:59 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E3CC061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:41:19 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c131so7036731ybf.7
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpL4gOaX7bpGIn/9hfk72lPDaRH7iq1HBvUiS/L1Hzg=;
        b=FoMo6EJMb6NIWprjZ0ZPzdpA63D1ql2GtRy1MKsH8hIH8LAjE83QiZyvqo9+pakkcN
         RFETiBCr0vuQsOZm1Stcl3KrYiB/A1BUy2eRiaHYhcBTRJVI+8NOHSWb7WfyQ73nDRfu
         Hu7MhRbIEL6uh5Gywb0xUanQPPM2DWRJFUpBeu1ixOKW/2CUoujW8sMjxUA6VW333bUP
         03Md41HOgTQ4y1lNQFSBtVXOFHsTiJqaXph5ZlhKKCabe6z9YNAFwKcxXLniaiew5ZF8
         VQ82RZDfbWug9Ts1UQelWTuj1wx3kWuDtby/nRfJI7Kq5jpHptPZs5bUqKlJK5RBW3nh
         tnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpL4gOaX7bpGIn/9hfk72lPDaRH7iq1HBvUiS/L1Hzg=;
        b=casH24tkei2M/7QyxaQb5imb/IE9xe9d1qyEu5c+497gZW/TzATXrRdi7W5R7s+ceH
         XCnfM3rird3eAEECjwzbGl6iGXyn52rwmIG1BWpRlVJhk6TRdraWjHFTl3KMyxIt/qq/
         rBXsFo8AtZflvswQ5Z3ROR7ESADhiyK+guRHm5IhaxteaGel69oWA8qZrsdpWtKyoFIC
         Uv7fLIVYJTwjOXbqsDqBJYCcxhXto77airxWclaFalMCGE+qS1wx2f74ZxrfGUHT1vx0
         BzGygNlfsfpDo6xtLKZQZ1vAuKdgVoi2FDj8jgxfW9sYj9qElIh4i7x3C1BNFi6212Ww
         TQIg==
X-Gm-Message-State: AOAM533ma1UZc74bZkHWs/wpLFNZimuFFlIZUjW+/8UNcOQVLbrRY1mO
        uH9bOVOw1GTJwYmRAvr9d4JOJjqIoZrKpXQ/jAQ=
X-Google-Smtp-Source: ABdhPJyujbqTmASt+iehuyptZWE4VC45L1IG+7S67evrdoQp/PLqGH0TAyxgk13PtV/EDlkCesl/39MSPjJ7HaIgico=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr182169yba.510.1614292878841;
 Thu, 25 Feb 2021 14:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073313.4120653-1-yhs@fb.com>
In-Reply-To: <20210225073313.4120653-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 14:41:07 -0800
Message-ID: <CAEf4BzZMCOi__1Y86AbQDD_=kgT22G10pJqzEVwF5r37M2CB6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> The bpf_for_each_map_elem() helper is introduced which
> iterates all map elements with a callback function. The
> helper signature looks like
>   long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
> and for each map element, the callback_fn will be called. For example,
> like hashmap, the callback signature may look like
>   long callback_fn(map, key, val, callback_ctx)
>
> There are two known use cases for this. One is from upstream ([1]) where
> a for_each_map_elem helper may help implement a timeout mechanism
> in a more generic way. Another is from our internal discussion
> for a firewall use case where a map contains all the rules. The packet
> data can be compared to all these rules to decide allow or deny
> the packet.
>
> For array maps, users can already use a bounded loop to traverse
> elements. Using this helper can avoid using bounded loop. For other
> type of maps (e.g., hash maps) where bounded loop is hard or
> impossible to use, this helper provides a convenient way to
> operate on all elements.
>
> For callback_fn, besides map and map element, a callback_ctx,
> allocated on caller stack, is also passed to the callback
> function. This callback_ctx argument can provide additional
> input and allow to write to caller stack for output.
>
> If the callback_fn returns 0, the helper will iterate through next
> element if available. If the callback_fn returns 1, the helper
> will stop iterating and returns to the bpf program. Other return
> values are not used for now.
>
> Currently, this helper is only available with jit. It is possible
> to make it work with interpreter with so effort but I leave it
> as the future work.
>
> [1]: https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gmail.com/
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

It looks good from the perspective of implementation (though I
admittedly lost track of all the insn[0|1].imm transformations). But
see some suggestions below (I hope you can incorporate them).

Overall, though:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |  13 +++
>  include/linux/bpf_verifier.h   |   3 +
>  include/uapi/linux/bpf.h       |  29 ++++-
>  kernel/bpf/bpf_iter.c          |  16 +++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/verifier.c          | 208 ++++++++++++++++++++++++++++++---
>  kernel/trace/bpf_trace.c       |   2 +
>  tools/include/uapi/linux/bpf.h |  29 ++++-
>  8 files changed, 287 insertions(+), 15 deletions(-)
>

[...]

> @@ -3850,7 +3859,6 @@ union bpf_attr {
>   *
>   * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, u64 flags)
>   *     Description
> -
>   *             Check ctx packet size against exceeding MTU of net device (based
>   *             on *ifindex*).  This helper will likely be used in combination
>   *             with helpers that adjust/change the packet size.
> @@ -3910,6 +3918,24 @@ union bpf_attr {
>   *             * **BPF_MTU_CHK_RET_FRAG_NEEDED**
>   *             * **BPF_MTU_CHK_RET_SEGS_TOOBIG**
>   *
> + * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void *callback_ctx, u64 flags)
> + *     Description
> + *             For each element in **map**, call **callback_fn** function with
> + *             **map**, **callback_ctx** and other map-specific parameters.
> + *             For example, for hash and array maps, the callback signature can
> + *             be `long callback_fn(map, map_key, map_value, callback_ctx)`.

I think this is the place to describe all supported maps and
respective callback signatures. Otherwise users would have to dig into
kernel sources quite deeply to understand what signature is expected.

How about something like this.

Here's a list of supported map types and their respective expected
callback signatures:

BPF_MAP_TYPE_A, BPF_MAP_TYPE_B:
    long (*callback_fn)(struct bpf_map *map, const void *key, void
*value, void *ctx);

BPF_MAP_TYPE_C:
    long (*callback_fn)(struct bpf_map *map, int cpu, const void *key,
void *value, void *ctx);

(whatever the right signature for per-cpu iteration is)

This probably is the right place to also leave notes like below:

"For per_cpu maps, the map_value is the value on the cpu where the
bpf_prog is running." (I'd move it out from below to be more visible).

If we don't leave such documentation, it is going to be a major pain
for users (and people like us helping them).

> + *             The **callback_fn** should be a static function and
> + *             the **callback_ctx** should be a pointer to the stack.
> + *             The **flags** is used to control certain aspects of the helper.
> + *             Currently, the **flags** must be 0. For per_cpu maps,
> + *             the map_value is the value on the cpu where the bpf_prog is running.
> + *
> + *             If **callback_fn** return 0, the helper will continue to the next
> + *             element. If return value is 1, the helper will skip the rest of
> + *             elements and return. Other return values are not used now.
> + *     Return
> + *             The number of traversed map elements for success, **-EINVAL** for
> + *             invalid **flags**.
>   */

[...]

> @@ -1556,6 +1568,19 @@ static int check_subprogs(struct bpf_verifier_env *env)
>
>         /* determine subprog starts. The end is one before the next starts */
>         for (i = 0; i < insn_cnt; i++) {
> +               if (bpf_pseudo_func(insn + i)) {
> +                       if (!env->bpf_capable) {
> +                               verbose(env,
> +                                       "function pointers are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
> +                               return -EPERM;
> +                       }
> +                       ret = add_subprog(env, i + insn[i].imm + 1);
> +                       if (ret < 0)
> +                               return ret;
> +                       /* remember subprog */
> +                       insn[i + 1].imm = find_subprog(env, i + insn[i].imm + 1);

hm... my expectation would be that add_subprog returns >= 0 on
success, which is an index of subprog, so that precise no one needs to
call find_subprog yet again (it's already called internally in
add_subprog). Do you think it would be terrible to do that? It doesn't
seem like anything would break with that convention.

> +                       continue;
> +               }
>                 if (!bpf_pseudo_call(insn + i))
>                         continue;
>                 if (!env->bpf_capable) {

[...]

>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>         struct bpf_verifier_state *state = env->cur_state;
> @@ -5400,8 +5487,22 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>
>         state->curframe--;
>         caller = state->frame[state->curframe];
> -       /* return to the caller whatever r0 had in the callee */
> -       caller->regs[BPF_REG_0] = *r0;
> +       if (callee->in_callback_fn) {
> +               /* enforce R0 return value range [0, 1]. */
> +               struct tnum range = tnum_range(0, 1);
> +
> +               if (r0->type != SCALAR_VALUE) {
> +                       verbose(env, "R0 not a scalar value\n");
> +                       return -EACCES;
> +               }
> +               if (!tnum_in(range, r0->var_off)) {

if (!tnum_in(tnum_range(0, 1), r0->var_off)) should work as well,
unless you find it less readable (I don't but no strong feeling here)


> +                       verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
> +                       return -EINVAL;
> +               }
> +       } else {
> +               /* return to the caller whatever r0 had in the callee */
> +               caller->regs[BPF_REG_0] = *r0;
> +       }
>
>         /* Transfer references to the caller */
>         err = transfer_reference_state(caller, callee);
> @@ -5456,7 +5557,8 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>             func_id != BPF_FUNC_map_delete_elem &&
>             func_id != BPF_FUNC_map_push_elem &&
>             func_id != BPF_FUNC_map_pop_elem &&
> -           func_id != BPF_FUNC_map_peek_elem)
> +           func_id != BPF_FUNC_map_peek_elem &&
> +           func_id != BPF_FUNC_for_each_map_elem)
>                 return 0;
>
>         if (map == NULL) {
> @@ -5537,15 +5639,18 @@ static int check_reference_leak(struct bpf_verifier_env *env)
>         return state->acquired_refs ? -EINVAL : 0;
>  }
>
> -static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn_idx)
> +static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +                            int *insn_idx_p)
>  {
>         const struct bpf_func_proto *fn = NULL;
>         struct bpf_reg_state *regs;
>         struct bpf_call_arg_meta meta;
> +       int insn_idx = *insn_idx_p;
>         bool changes_data;
> -       int i, err;
> +       int i, err, func_id;
>
>         /* find function prototype */
> +       func_id = insn->imm;
>         if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
>                 verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
>                         func_id);
> @@ -5641,6 +5746,13 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>                 return -EINVAL;
>         }
>
> +       if (func_id == BPF_FUNC_for_each_map_elem) {
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,

so here __check_func_call never updates *insn_idx_p, which means
check_helper_call() doesn't need int * for instruction index. This
pointer is just adding to confusion, because it's not used to pass
value back. So unless I missed something, let's please drop the
pointer and pass the index by value.

> +                                       set_map_elem_callback_state);
> +               if (err < 0)
> +                       return -EINVAL;
> +       }
> +
>         /* reset caller saved regs */
>         for (i = 0; i < CALLER_SAVED_REGS; i++) {
>                 mark_reg_not_init(env, regs, caller_saved[i]);

[...]

> +       case PTR_TO_MAP_KEY:
>         case PTR_TO_MAP_VALUE:
>                 /* If the new min/max/var_off satisfy the old ones and
>                  * everything else matches, we are OK.
> @@ -10126,10 +10274,9 @@ static int do_check(struct bpf_verifier_env *env)
>                                 if (insn->src_reg == BPF_PSEUDO_CALL)
>                                         err = check_func_call(env, insn, &env->insn_idx);
>                                 else
> -                                       err = check_helper_call(env, insn->imm, env->insn_idx);
> +                                       err = check_helper_call(env, insn, &env->insn_idx);

see, here again. Will env->insn_idx change here? What would that mean?
Just lots of unnecessary worries.

>                                 if (err)
>                                         return err;
> -
>                         } else if (opcode == BPF_JA) {
>                                 if (BPF_SRC(insn->code) != BPF_K ||
>                                     insn->imm != 0 ||

[...]
