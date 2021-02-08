Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9F6313D13
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBHSSc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhBHSRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:17:20 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406AC061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:16:40 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id d184so4192683ybf.1
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYnWZOJ2mGwtlJZgnFg3aoCYKyQaiyc2KOYdCzfWtgI=;
        b=szyNc0aVZpha6P/chzq6bLTwDYspoj4LxtgYXh7upoApdjwk3Vssuq1gWu71knsHqd
         VPhGbHtGeJLOB9MblyzkRnS0I8C6Q8zJSwJrnkIi3X7UrYX4nXIQLJmAMl6SsqK4gfSG
         /sOPUmWUJMsNK1/G39Z+SELmUNgkWPCFb1cNXFwhTT/7vnzIKQl3kEbACh0gRrs5k/lN
         ZAKLEZyGfVCmBimFZuST8fiCVzM1BcY0LdRpG4DmlRSITywP+r8x3gBLzSNyliZX5nga
         HlzziOzRcZwRqWtIj5DtlEeq0zYDv6tTTm8mS3yJRnNPdtESQQKyCqHkj/IBEUNMHh7G
         jLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYnWZOJ2mGwtlJZgnFg3aoCYKyQaiyc2KOYdCzfWtgI=;
        b=At1oF3mdcj0Bzgddw7H7HADPgtnaM7cKMMYuK+3xSx67QxevWxNQbLMicDgs0VGyXX
         7C0fixa087/CGURWqWOYvc+sRH9CvRu3R1FvFAd9MbjOIGdfHgWYojDXjDu7pLVVd7Z9
         HY+Jx94GX4b4VsLWA8VXVeSsF6JupvrE7boGYLW2RT6dKiEKgR73k/4EyCrBOg2dk0Ma
         /LOuT7krTEdscIf9vx+6TUd5UgDcAG7VFsAPnTfHsL2bh1wHdAVSPperIZPLcy7h1s6n
         DrzTdeKz7cF3z/KFH2pBUETSdbMRnNQr4hl7rdy5aq7iFg5f0IFzW0a748/ngxvvkH/w
         aXbQ==
X-Gm-Message-State: AOAM531an4g35aFUX0g4l8pmBT8EDMlGRV3CnYjzc6ytflPMq4ES9vu7
        fAEuYHq5hoFcGd+YrOwZohUanGJToCCLphBN3As=
X-Google-Smtp-Source: ABdhPJyni1Sc0piqSkaDGUzh0l5sGGej3WAoGfnCincZJtCy2OjpNx7RdYyngLxJvoekDFehT6IczIn/K7htIbMmQRw=
X-Received: by 2002:a25:9882:: with SMTP id l2mr25826120ybo.425.1612808199535;
 Mon, 08 Feb 2021 10:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234829.1629159-1-yhs@fb.com>
In-Reply-To: <20210204234829.1629159-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 10:16:28 -0800
Message-ID: <CAEf4BzYL5cmWyyHq4RzMdOmCbmicvQSGMKCih-eVdOUM_q_0Rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: add bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
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

This is a great feature! Few questions and nits below.

>  include/linux/bpf.h            |  14 ++
>  include/linux/bpf_verifier.h   |   3 +
>  include/uapi/linux/bpf.h       |  28 ++++
>  kernel/bpf/bpf_iter.c          |  16 +++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/verifier.c          | 251 ++++++++++++++++++++++++++++++---
>  kernel/trace/bpf_trace.c       |   2 +
>  tools/include/uapi/linux/bpf.h |  28 ++++
>  8 files changed, 328 insertions(+), 16 deletions(-)
>

[...]

>  const struct bpf_func_proto *bpf_tracing_func_proto(
>         enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index dfe6f85d97dd..c4366b3da342 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -68,6 +68,8 @@ struct bpf_reg_state {
>                         unsigned long raw1;
>                         unsigned long raw2;
>                 } raw;
> +
> +               u32 subprog; /* for PTR_TO_FUNC */

is it offset to subprog (in bytes or instructions?) or it's subprog
index? Let's make it clear with a better name or at least a comment.

>         };
>         /* For PTR_TO_PACKET, used to find other pointers with the same variable
>          * offset, so they can share range knowledge.
> @@ -204,6 +206,7 @@ struct bpf_func_state {
>         int acquired_refs;
>         struct bpf_reference_state *refs;
>         int allocated_stack;
> +       bool with_callback_fn;
>         struct bpf_stack_state *stack;
>  };
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c001766adcbc..d55bd4557376 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -393,6 +393,15 @@ enum bpf_link_type {
>   *                   is struct/union.
>   */
>  #define BPF_PSEUDO_BTF_ID      3
> +/* insn[0].src_reg:  BPF_PSEUDO_FUNC
> + * insn[0].imm:      insn offset to the func
> + * insn[1].imm:      0
> + * insn[0].off:      0
> + * insn[1].off:      0
> + * ldimm64 rewrite:  address of the function
> + * verifier type:    PTR_TO_FUNC.
> + */
> +#define BPF_PSEUDO_FUNC                4
>
>  /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
>   * offset to another bpf function
> @@ -3836,6 +3845,24 @@ union bpf_attr {
>   *     Return
>   *             A pointer to a struct socket on success or NULL if the file is
>   *             not a socket.
> + *
> + * long bpf_for_each_map_elem(struct bpf_map *map, void *callback_fn, void *callback_ctx, u64 flags)

struct bpf_map * here might be problematic. In other instances where
we pass map (bpf_map_update_elem, for example) we specify this as
(void *). Let's do that instead here?

> + *     Description
> + *             For each element in **map**, call **callback_fn** function with
> + *             **map**, **callback_ctx** and other map-specific parameters.
> + *             For example, for hash and array maps, the callback signature can
> + *             be `u64 callback_fn(map, map_key, map_value, callback_ctx)`.
> + *             The **callback_fn** should be a static function and
> + *             the **callback_ctx** should be a pointer to the stack.
> + *             The **flags** is used to control certain aspects of the helper.
> + *             Currently, the **flags** must be 0.
> + *
> + *             If **callback_fn** return 0, the helper will continue to the next
> + *             element. If return value is 1, the helper will skip the rest of
> + *             elements and return. Other return values are not used now.
> + *     Return
> + *             0 for success, **-EINVAL** for invalid **flags** or unsupported
> + *             **callback_fn** return value.

just a thought: returning the number of elements *actually* iterated
seems useful (even though I don't have a specific use case right now).

>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -4001,6 +4028,7 @@ union bpf_attr {
>         FN(ktime_get_coarse_ns),        \
>         FN(ima_inode_hash),             \
>         FN(sock_from_file),             \
> +       FN(for_each_map_elem),          \

to be more in sync with other map operations, can we call this
`bpf_map_for_each_elem`? I think it makes sense and doesn't read
backwards at all.

>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 5454161407f1..5187f49d3216 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -675,3 +675,19 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>          */
>         return ret == 0 ? 0 : -EAGAIN;
>  }
> +
> +BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
> +          void *, callback_ctx, u64, flags)
> +{
> +       return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
> +}
> +
> +const struct bpf_func_proto bpf_for_each_map_elem_proto = {
> +       .func           = bpf_for_each_map_elem,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_CONST_MAP_PTR,
> +       .arg2_type      = ARG_PTR_TO_FUNC,
> +       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,

I looked through this code just once but haven't noticed anything that
would strictly require that pointer is specifically to stack. Can this
be made into a pointer to any allocated memory? E.g., why can't we
allow passing a pointer to a ringbuf sample, for instance? Or
MAP_VALUE?

> +       .arg4_type      = ARG_ANYTHING,
> +};
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 308427fe03a3..074800226327 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -708,6 +708,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_ringbuf_discard_proto;
>         case BPF_FUNC_ringbuf_query:
>                 return &bpf_ringbuf_query_proto;
> +       case BPF_FUNC_for_each_map_elem:
> +               return &bpf_for_each_map_elem_proto;
>         default:
>                 break;
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db294b75d03b..050b067a0be6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -234,6 +234,12 @@ static bool bpf_pseudo_call(const struct bpf_insn *insn)
>                insn->src_reg == BPF_PSEUDO_CALL;
>  }
>

[...]

>         map = env->used_maps[aux->map_index];
>         mark_reg_known_zero(env, regs, insn->dst_reg);
>         dst_reg->map_ptr = map;
> @@ -8195,9 +8361,23 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>
>         /* All non-branch instructions have a single fall-through edge. */
>         if (BPF_CLASS(insns[t].code) != BPF_JMP &&
> -           BPF_CLASS(insns[t].code) != BPF_JMP32)
> +           BPF_CLASS(insns[t].code) != BPF_JMP32 &&
> +           !bpf_pseudo_func(insns + t))
>                 return push_insn(t, t + 1, FALLTHROUGH, env, false);
>
> +       if (bpf_pseudo_func(insns + t)) {


if you check this before above JMP|JMP32 check, you won't need to do
!bpf_pseudo_func, right? I think it's cleaner.

> +               ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> +               if (ret)
> +                       return ret;
> +
> +               if (t + 1 < insn_cnt)
> +                       init_explored_state(env, t + 1);
> +               init_explored_state(env, t);
> +               ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> +                               env, false);
> +               return ret;
> +       }
> +
>         switch (BPF_OP(insns[t].code)) {
>         case BPF_EXIT:
>                 return DONE_EXPLORING;

[...]
