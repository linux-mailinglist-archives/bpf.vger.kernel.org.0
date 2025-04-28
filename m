Return-Path: <bpf+bounces-56852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F85CA9F75E
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39CF3ABAA9
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C6293B4A;
	Mon, 28 Apr 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGRNXySn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A127A937
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861496; cv=none; b=YxJpmwGyhMhdTonaibx4g2tAWWJjNo+I61Yu7F/PEK+nMW1J8/1LZhcPGZr6p/B/alrs3aHW4ivZV0Ga9Bn1lrpil/QDJ8rFSksIbTjxbLYxxu1/MSqmHWdkM3Tc9FSFhi2Xr52ZWe9W/feotOXtZem0W0H/6K3UigAvtb/zvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861496; c=relaxed/simple;
	bh=10LCu5wuOTUBF6tN20viyf0/7mfv2brHKId7sfu97o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3eacy8doxJhyoGhOySiMU2y0TUkUx74w+OMiIsV0LzvoXnscxWXbyPaStk+vqTgimt7qXscA4TdVSkCW/gUmFeILgT8nIVWVnzPRM0ghOGiRcvt/ZfrqYjS6rovw1hK5cIJ+yXci/Z+O8gfWdPIDKxsJr65pCvg/trSfwbu4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGRNXySn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso6009827f8f.0
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745861492; x=1746466292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N86Ievxl1EvG85SIvtPJYsUovyyd+sCqYbReuP/e4c=;
        b=fGRNXySnnXmLLQfLE+kmuoecrtvTQSvyDd22Vxr98Xms06rQV5RmUCi7cLU6gOO4d/
         TUtFTQE3IzlzhC+4QE90nnDyAuaQBJJbAqPnIxp4yyxcjnbpgCWbdAA3Xrf8i6ABHar5
         4ky1JWIWpi7Ca/C2xIbyl3mCSg1ZOFwyw/snczmnwD8RmaHBCYBWCV3mgu+hKx2wqmGV
         3fQ0xSN7RSKQPok55RvEsOPLZUSEpE5H6+/I/YwfLCvPGxnNVf+FVlZzL00u6jXnZ4Eg
         U5QBzOoVHgFE+1LaElOuDJizSKRVerFiTLW9hvhhPzGvEDmKDc+Dhk8mbG3KgWv/OXnU
         CfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861492; x=1746466292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N86Ievxl1EvG85SIvtPJYsUovyyd+sCqYbReuP/e4c=;
        b=Wk8AEBENNjWwXULBc2yJYuvmnUXvNyFD18BuC7/rtdMjUIt4I18CO/IFFoNfkq0CuU
         fPZN2udxFlk4cjn6n+/k0sX63XPxYogcD6uJba7sM84mH/AZp0tcstrzql6lqMKiJ3TK
         Z0GXZ+jij1wzn94gkOemjHkHnrf4Wvkhxb2vZ6b0Sw0pMhExyHFN1o2Y2HFa2boWIERo
         ar+jD4Mo3jdm9eZ1zEfQbxYZx9NFRxwQplyxGQMwCQDn673jCSRVogWtY9cvZuQXMXQF
         8Z4YgW2nbGrfj20ZzN+l+QlT/MMUWhjJFgcHJaOmkc6/YhElYhzgr1bhkdfOdt5TOeop
         Adzg==
X-Gm-Message-State: AOJu0Yz2dyz3PEirnOMXgEFiQZvpH8oHFdmdKpISg6Ci8DDvuwBBUZZh
	xCcSLip7/3yabDu0lk+YAFVBrAV2lZ/X3lgcDDb8kXAccbGL3I0SjYLXT+WXEwgZvm1VsvLW9Gg
	nZtlq6rsB24BVbK3t2lLaw5qLzWo=
X-Gm-Gg: ASbGncu8/uOqsKx4kLSX9vKcnGSeskpuN5/mRwtoXOzVAyiAq52vBpjE7nNHn4YemPj
	bczd055aok86xEXzHMECIZockoX/XcInuvtyjV60B0HrnbbdvyvXUUpbV3BDtS8HLyFm8IKkAzK
	aRuBK25O2KyXfhP/5iN7L8HmQlF6n0nU8cApjF7w==
X-Google-Smtp-Source: AGHT+IHVQlac0PdYUDb5VK/cpNlE0v9MvSvHyVUO1WrrK30+ZHsuWbSjxJNN8kQwhlzOnyACrPBmS6rC9+S2EhMX4qg=
X-Received: by 2002:a05:6000:2ce:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3a08a3550eemr128525f8f.19.1745861491904; Mon, 28 Apr 2025
 10:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426104634.744077-1-eddyz87@gmail.com> <20250426104634.744077-4-eddyz87@gmail.com>
In-Reply-To: <20250426104634.744077-4-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Apr 2025 10:31:20 -0700
X-Gm-Features: ATxdqUGATEC72AsuE5Sd8W3lbe_Mw76_NUsUURzylwOhA1QTLjMetShNSLrT5W8
Message-ID: <CAADnVQK1tP1_of=pn7HdeZNqmPu=4AqpRETeOVeQMjDfSt0NOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 3:46=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Replace loop_entry-based exact states comparison logic.
> Instead, for states within an iterator based loop, mark all registers
> as read and precise. Use control flow graph strongly connected
> components information to detect states that are members of a loop.
> See comments for mark_all_regs_read_and_precise() for a detailed
> explanation.
>
> This change addresses the cases described in [1].
> These cases can be illustrated with the following diagram:
>
>  .-> A --.  Assume the states are visited in the order A, B, C.
>  |   |   |  Assume that state B reaches a state equivalent to state A.
>  |   v   v  At this point, state C is not processed yet, so state A
>  '-- B   C  has not received any read or precision marks from C.
>             As a result, these marks won't be propagated to B.
>
> If B has incomplete marks, it is unsafe to use it in states_equal()
> checks.
>
> See selftests later in a series for examples of unsafe programs that
> are not detected without this change.
>
> [1] https://lore.kernel.org/bpf/3c6ac16b7578406e2ddd9ba889ce955748fe636b.=
camel@gmail.com/
>
> Fixes: 2a0992829ea3 ("bpf: correct loop detection for iterators convergen=
ce")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  42 ++--
>  kernel/bpf/verifier.c        | 440 ++++++++++++++++++-----------------
>  2 files changed, 249 insertions(+), 233 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cb8e1ae67180..e718ef265a7b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -445,16 +445,6 @@ struct bpf_verifier_state {
>         /* first and last insn idx of this verifier state */
>         u32 first_insn_idx;
>         u32 last_insn_idx;
> -       /* If this state is a part of states loop this field points to so=
me
> -        * parent of this state such that:
> -        * - it is also a member of the same states loop;
> -        * - DFS states traversal starting from initial state visits loop=
_entry
> -        *   state before this state.
> -        * Used to compute topmost loop entry for state loops.
> -        * State loops might appear because of open coded iterators logic=
.
> -        * See get_loop_entry() for more information.
> -        */
> -       struct bpf_verifier_state *loop_entry;
>         /* Sub-range of env->insn_hist[] corresponding to this state's
>          * instruction history.
>          * Backtracking is using it to go from last to first.
> @@ -466,11 +456,10 @@ struct bpf_verifier_state {
>         u32 dfs_depth;
>         u32 callback_unroll_depth;
>         u32 may_goto_depth;
> -       /* If this state was ever pointed-to by other state's loop_entry =
field
> -        * this flag would be set to true. Used to avoid freeing such sta=
tes
> -        * while they are still in use.
> +       /* If this state is a checkpoint at insn_idx that belongs to an S=
CC,
> +        * record the SCC epoch at the time of checkpoint creation.
>          */

Please use normal kernel comment style for all new code:
/*
 * multi-
 * line
 * comment
 */

> -       u32 used_as_loop_entry;
> +       u32 scc_epoch;
>  };
>
>  #define bpf_get_spilled_reg(slot, frame, mask)                         \
> @@ -717,6 +706,29 @@ struct bpf_idset {
>         u32 ids[BPF_ID_MAP_SIZE];
>  };
>
> +/* Information tracked for CFG strongly connected components */
> +struct bpf_scc_info {
> +       /* True if states_equal(... RANGE_WITHIN) ever returned
> +        * true for a state with insn_idx within this SCC.
> +        * E.g. for iterator next call.

I feel RANGE_WITHIN is unnecessary information here.
Maybe reword it as:
Set to true when is_state_visited() detected convergence of open coded iter=
ator.
?

> +        * Indicates that read and precision marks are incomplete for
> +        * states with insn_idx in this SCC.
> +        */
> +       u32 state_loops_possible:1;
> +       /* Number of verifier states with .branches > 0 that have
> +        * state->parent->insn_idx within this SCC.
> +        * In other words, the number of states originating from this
> +        * SCC that have not yet been fully explored.
> +        */
> +       u32 branches:31;
> +       /* Number of times this SCC was entered by some verifier state
> +        * and that state was fully explored.
> +        * In other words, number of times .branches became non-zero
> +        * and then zero again.
> +        */
> +       u32 scc_epoch;
> +};
> +
>  /* single container for all structs
>   * one verifier_env per bpf_check() call
>   */
> @@ -809,6 +821,8 @@ struct bpf_verifier_env {
>         u64 prev_log_pos, prev_insn_print_pos;
>         /* buffer used to temporary hold constants as scalar registers */
>         struct bpf_reg_state fake_reg[2];
> +       struct bpf_scc_info *scc_info;
> +       u32 num_sccs;
>         /* buffer used to generate temporary string representations,
>          * e.g., in reg_type_str() to generate reg_type string
>          */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 67903270b217..ae642459f342 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1672,7 +1672,7 @@ static void free_verifier_state(struct bpf_verifier=
_state *state,
>                 kfree(state);
>  }
>
> -/* struct bpf_verifier_state->{parent,loop_entry} refer to states
> +/* struct bpf_verifier_state->parent refers to states
>   * that are in either of env->{expored_states,free_list}.
>   * In both cases the state is contained in struct bpf_verifier_state_lis=
t.
>   */
> @@ -1683,36 +1683,18 @@ static struct bpf_verifier_state_list *state_pare=
nt_as_list(struct bpf_verifier_
>         return NULL;
>  }
>
> -static struct bpf_verifier_state_list *state_loop_entry_as_list(struct b=
pf_verifier_state *st)
> -{
> -       if (st->loop_entry)
> -               return container_of(st->loop_entry, struct bpf_verifier_s=
tate_list, state);
> -       return NULL;
> -}
> -
>  /* A state can be freed if it is no longer referenced:
>   * - is in the env->free_list;
>   * - has no children states;
> - * - is not used as loop_entry.
> - *
> - * Freeing a state can make it's loop_entry free-able.
>   */
>  static void maybe_free_verifier_state(struct bpf_verifier_env *env,
>                                       struct bpf_verifier_state_list *sl)
>  {
> -       struct bpf_verifier_state_list *loop_entry_sl;
> -
> -       while (sl && sl->in_free_list &&
> -                    sl->state.branches =3D=3D 0 &&
> -                    sl->state.used_as_loop_entry =3D=3D 0) {
> -               loop_entry_sl =3D state_loop_entry_as_list(&sl->state);
> -               if (loop_entry_sl)
> -                       loop_entry_sl->state.used_as_loop_entry--;
> +       if (sl->in_free_list && sl->state.branches =3D=3D 0) {
>                 list_del(&sl->node);
>                 free_verifier_state(&sl->state, false);
>                 kfree(sl);
>                 env->free_list_size--;
> -               sl =3D loop_entry_sl;
>         }
>  }
>
> @@ -1753,9 +1735,8 @@ static int copy_verifier_state(struct bpf_verifier_=
state *dst_state,
>         dst_state->insn_hist_end =3D src->insn_hist_end;
>         dst_state->dfs_depth =3D src->dfs_depth;
>         dst_state->callback_unroll_depth =3D src->callback_unroll_depth;
> -       dst_state->used_as_loop_entry =3D src->used_as_loop_entry;
>         dst_state->may_goto_depth =3D src->may_goto_depth;
> -       dst_state->loop_entry =3D src->loop_entry;
> +       dst_state->scc_epoch =3D src->scc_epoch;
>         for (i =3D 0; i <=3D src->curframe; i++) {
>                 dst =3D dst_state->frame[i];
>                 if (!dst) {
> @@ -1798,157 +1779,77 @@ static bool same_callsites(struct bpf_verifier_s=
tate *a, struct bpf_verifier_sta
>         return true;
>  }
>
> -/* Open coded iterators allow back-edges in the state graph in order to
> - * check unbounded loops that iterators.
> - *
> - * In is_state_visited() it is necessary to know if explored states are
> - * part of some loops in order to decide whether non-exact states
> - * comparison could be used:
> - * - non-exact states comparison establishes sub-state relation and uses
> - *   read and precision marks to do so, these marks are propagated from
> - *   children states and thus are not guaranteed to be final in a loop;
> - * - exact states comparison just checks if current and explored states
> - *   are identical (and thus form a back-edge).
> - *
> - * Paper "A New Algorithm for Identifying Loops in Decompilation"
> - * by Tao Wei, Jian Mao, Wei Zou and Yu Chen [1] presents a convenient
> - * algorithm for loop structure detection and gives an overview of
> - * relevant terminology. It also has helpful illustrations.
> - *
> - * [1] https://api.semanticscholar.org/CorpusID:15784067
> - *
> - * We use a similar algorithm but because loop nested structure is
> - * irrelevant for verifier ours is significantly simpler and resembles
> - * strongly connected components algorithm from Sedgewick's textbook.
> - *
> - * Define topmost loop entry as a first node of the loop traversed in a
> - * depth first search starting from initial state. The goal of the loop
> - * tracking algorithm is to associate topmost loop entries with states
> - * derived from these entries.
> - *
> - * For each step in the DFS states traversal algorithm needs to identify
> - * the following situations:
> - *
> - *          initial                     initial                   initia=
l
> - *            |                           |                         |
> - *            V                           V                         V
> - *           ...                         ...           .---------> hdr
> - *            |                           |            |            |
> - *            V                           V            |            V
> - *           cur                     .-> succ          |    .------...
> - *            |                      |    |            |    |       |
> - *            V                      |    V            |    V       V
> - *           succ                    '-- cur           |   ...     ...
> - *                                                     |    |       |
> - *                                                     |    V       V
> - *                                                     |   succ <- cur
> - *                                                     |    |
> - *                                                     |    V
> - *                                                     |   ...
> - *                                                     |    |
> - *                                                     '----'
> - *
> - *  (A) successor state of cur   (B) successor state of cur or it's entr=
y
> - *      not yet traversed            are in current DFS path, thus cur a=
nd succ
> - *                                   are members of the same outermost l=
oop
> - *
> - *                      initial                  initial
> - *                        |                        |
> - *                        V                        V
> - *                       ...                      ...
> - *                        |                        |
> - *                        V                        V
> - *                .------...               .------...
> - *                |       |                |       |
> - *                V       V                V       V
> - *           .-> hdr     ...              ...     ...
> - *           |    |       |                |       |
> - *           |    V       V                V       V
> - *           |   succ <- cur              succ <- cur
> - *           |    |                        |
> - *           |    V                        V
> - *           |   ...                      ...
> - *           |    |                        |
> - *           '----'                       exit
> - *
> - * (C) successor state of cur is a part of some loop but this loop
> - *     does not include cur or successor state is not in a loop at all.
> - *
> - * Algorithm could be described as the following python code:
> - *
> - *     traversed =3D set()   # Set of traversed nodes
> - *     entries =3D {}        # Mapping from node to loop entry
> - *     depths =3D {}         # Depth level assigned to graph node
> - *     path =3D set()        # Current DFS path
> - *
> - *     # Find outermost loop entry known for n
> - *     def get_loop_entry(n):
> - *         h =3D entries.get(n, None)
> - *         while h in entries:
> - *             h =3D entries[h]
> - *         return h
> - *
> - *     # Update n's loop entry if h comes before n in current DFS path.
> - *     def update_loop_entry(n, h):
> - *         if h in path and depths[entries.get(n, n)] < depths[n]:
> - *             entries[n] =3D h1
> +static struct bpf_scc_info *insn_scc(struct bpf_verifier_env *env, int i=
nsn_idx)
> +{
> +       u32 scc;
> +
> +       scc =3D env->insn_aux_data[insn_idx].scc;
> +       return scc ? &env->scc_info[scc] : NULL;
> +}
> +
> +/* Returns true iff:
> + * - verifier is currently exploring states with origins in some CFG SCC=
s;
> + * - st->insn_idx belongs to one of these SCCs;
> + * - st->scc_epoch is the current SCC epoch, indicating that some parent
> + *   of st started current SCC exploration epoch.
>   *
> - *     def dfs(n, depth):
> - *         traversed.add(n)
> - *         path.add(n)
> - *         depths[n] =3D depth
> - *         for succ in G.successors(n):
> - *             if succ not in traversed:
> - *                 # Case A: explore succ and update cur's loop entry
> - *                 #         only if succ's entry is in current DFS path=
.
> - *                 dfs(succ, depth + 1)
> - *                 h =3D entries.get(succ, None)
> - *                 update_loop_entry(n, h)
> - *             else:
> - *                 # Case B or C depending on `h1 in path` check in upda=
te_loop_entry().
> - *                 update_loop_entry(n, succ)
> - *         path.remove(n)
> + * When above conditions are true, mark_all_regs_read_and_precise()
> + * has not yet been called for st, meaning that read and precision
> + * marks can't be relied upon.
>   *
> - * To adapt this algorithm for use with verifier:
> - * - use st->branch =3D=3D 0 as a signal that DFS of succ had been finis=
hed
> - *   and cur's loop entry has to be updated (case A), handle this in
> - *   update_branch_counts();
> - * - use st->branch > 0 as a signal that st is in the current DFS path;
> - * - handle cases B and C in is_state_visited().
> + * See comments for mark_all_regs_read_and_precise().
>   */
> -static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env=
 *env,
> -                                                struct bpf_verifier_stat=
e *st)
> +static bool incomplete_read_marks(struct bpf_verifier_env *env,
> +                                 struct bpf_verifier_state *st)
>  {
> -       struct bpf_verifier_state *topmost =3D st->loop_entry;
> -       u32 steps =3D 0;
> +       struct bpf_scc_info *scc_info;
>
> -       while (topmost && topmost->loop_entry) {
> -               if (steps++ > st->dfs_depth) {
> -                       WARN_ONCE(true, "verifier bug: infinite loop in g=
et_loop_entry\n");
> -                       verbose(env, "verifier bug: infinite loop in get_=
loop_entry()\n");
> -                       return ERR_PTR(-EFAULT);
> -               }
> -               topmost =3D topmost->loop_entry;
> -       }
> -       return topmost;
> +       scc_info =3D insn_scc(env, st->insn_idx);
> +       return scc_info &&
> +              scc_info->state_loops_possible &&
> +              scc_info->scc_epoch =3D=3D st->scc_epoch &&
> +              scc_info->branches > 0;
>  }
>
> -static void update_loop_entry(struct bpf_verifier_env *env,
> -                             struct bpf_verifier_state *cur, struct bpf_=
verifier_state *hdr)
> +static void mark_state_loops_possible(struct bpf_verifier_env *env,
> +                                     struct bpf_verifier_state *st)
>  {
> -       /* The hdr->branches check decides between cases B and C in
> -        * comment for get_loop_entry(). If hdr->branches =3D=3D 0 then
> -        * head's topmost loop entry is not in current DFS path,
> -        * hence 'cur' and 'hdr' are not in the same loop and there is
> -        * no need to update cur->loop_entry.
> -        */
> -       if (hdr->branches && hdr->dfs_depth < (cur->loop_entry ?: cur)->d=
fs_depth) {
> -               if (cur->loop_entry) {
> -                       cur->loop_entry->used_as_loop_entry--;
> -                       maybe_free_verifier_state(env, state_loop_entry_a=
s_list(cur));
> -               }
> -               cur->loop_entry =3D hdr;
> -               hdr->used_as_loop_entry++;
> +       struct bpf_scc_info *scc_info;
> +
> +       scc_info =3D insn_scc(env, st->insn_idx);
> +       if (scc_info)
> +               scc_info->state_loops_possible =3D 1;
> +}
> +
> +/* See comments for bpf_scc_info->{branches,visit_count} and
> + * mark_all_regs_read_and_precise().
> + */
> +static void parent_scc_enter(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *st)
> +{
> +       struct bpf_scc_info *scc_info;
> +
> +       if (!st->parent)
> +               return;
> +       scc_info =3D insn_scc(env, st->parent->insn_idx);
> +       if (scc_info)
> +               scc_info->branches++;
> +}
> +
> +/* See comments for bpf_scc_info->{branches,visit_count} and
> + * mark_all_regs_read_and_precise().
> + */
> +static void parent_scc_exit(struct bpf_verifier_env *env, struct bpf_ver=
ifier_state *st)
> +{
> +       struct bpf_scc_info *scc_info;
> +
> +       if (!st->parent)
> +               return;
> +       scc_info =3D insn_scc(env, st->parent->insn_idx);
> +       if (scc_info) {
> +               WARN_ON_ONCE(scc_info->branches =3D=3D 0);
> +               scc_info->branches--;
> +               if (scc_info->branches =3D=3D 0)
> +                       scc_info->scc_epoch++;
>         }
>  }
>
> @@ -1960,14 +1861,6 @@ static void update_branch_counts(struct bpf_verifi=
er_env *env, struct bpf_verifi
>         while (st) {
>                 u32 br =3D --st->branches;
>
> -               /* br =3D=3D 0 signals that DFS exploration for 'st' is f=
inished,
> -                * thus it is necessary to update parent's loop entry if =
it
> -                * turned out that st is a part of some loop.
> -                * This is a part of 'case A' in get_loop_entry() comment=
.
> -                */
> -               if (br =3D=3D 0 && st->parent && st->loop_entry)
> -                       update_loop_entry(env, st->parent, st->loop_entry=
);
> -
>                 /* WARN_ON(br > 1) technically makes sense here,
>                  * but see comment in push_stack(), hence:
>                  */
> @@ -1976,6 +1869,7 @@ static void update_branch_counts(struct bpf_verifie=
r_env *env, struct bpf_verifi
>                           br);
>                 if (br)
>                         break;
> +               parent_scc_exit(env, st);
>                 parent =3D st->parent;
>                 parent_sl =3D state_parent_as_list(st);
>                 if (sl)
> @@ -2053,6 +1947,7 @@ static struct bpf_verifier_state *push_stack(struct=
 bpf_verifier_env *env,
>                  * which might have large 'branches' count.
>                  */
>         }
> +       parent_scc_enter(env, &elem->st);
>         return &elem->st;
>  err:
>         free_verifier_state(env->cur_state, true);
> @@ -2242,6 +2137,18 @@ static void __mark_reg64_unbounded(struct bpf_reg_=
state *reg)
>         reg->umax_value =3D U64_MAX;
>  }
>
> +static bool is_reg_unbounded(struct bpf_reg_state *reg)
> +{
> +       return reg->smin_value =3D=3D S64_MIN &&
> +              reg->smax_value =3D=3D S64_MAX &&
> +              reg->umin_value =3D=3D 0 &&
> +              reg->umax_value =3D=3D U64_MAX &&
> +              reg->s32_min_value =3D=3D S32_MIN &&
> +              reg->s32_max_value =3D=3D S32_MAX &&
> +              reg->u32_min_value =3D=3D 0 &&
> +              reg->u32_max_value =3D=3D U32_MAX;
> +}
> +
>  static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
>  {
>         reg->s32_min_value =3D S32_MIN;
> @@ -18222,15 +18129,17 @@ static void clean_func_state(struct bpf_verifie=
r_env *env,
>         }
>  }
>
> +static bool verifier_state_cleaned(struct bpf_verifier_state *st)
> +{
> +       /* all regs in this state in all frames were already marked */
> +       return st->frame[0]->regs[0].live & REG_LIVE_DONE;
> +}

move refactor into pre-patch.

> +
>  static void clean_verifier_state(struct bpf_verifier_env *env,
>                                  struct bpf_verifier_state *st)
>  {
>         int i;
>
> -       if (st->frame[0]->regs[0].live & REG_LIVE_DONE)
> -               /* all regs in this state in all frames were already mark=
ed */
> -               return;
> -
>         for (i =3D 0; i <=3D st->curframe; i++)
>                 clean_func_state(env, st->frame[i]);
>  }
> @@ -18243,6 +18152,114 @@ static u32 frame_insn_idx(struct bpf_verifier_s=
tate *st, u32 frame)
>                : st->frame[frame + 1]->callsite;
>  }
>
> +/* Open coded iterators introduce loops in the verifier state graph.
> + * State graph loops can result in incomplete read and precision marks
> + * on individual states. E.g. consider the following states graph:
> + *
> + *  .-> A --.  Assume the states are visited in the order A, B, C.
> + *  |   |   |  Assume that state B reaches a state equivalent to state A=
.
> + *  |   v   v  At this point, state C has not been processed yet,
> + *  '-- B   C  so state A does not have any read or precision marks from=
 C yet.
> + *             As a result, these marks won't be propagated to B.
> + *
> + * If the marks on B are incomplete, it would be unsafe to use it in
> + * states_equal() checks.

earlier RANGE_WITHIN distinction was unnecessary,
but here we should clarify that
states_equal(NOT_EXACT) is unsafe,
while states_equal(RANGE_WITHIN) is fine.
Right?

> + *
> + * To avoid this safety issue, and since states with incomplete read
> + * marks can only occur within control flow graph loops, the verifier
> + * assumes that any state with bpf_verifier_state->insn_idx residing
> + * in a strongly connected component (SCC) has read and precision
> + * marks for all registers. This assumption is enforced by the
> + * function mark_all_regs_read_and_precise(), which assigns
> + * corresponding marks.
> + *
> + * An intuitive point to call mark_all_regs_read_and_precise() would
> + * be when a new state is created in is_state_visited().
> + * However, doing so would interfere with widen_imprecise_scalars(),
> + * which widens scalars in the current state after checking registers in=
 a
> + * parent state. Registers are not widened if they are marked as precise
> + * in the parent state.
> + *
> + * To avoid interfering with widening logic,
> + * a call to mark_all_regs_read_and_precise() for state is postponed
> + * until no widening is possible in any descendant of state S.
> + *
> + * Another intuitive spot to call mark_all_regs_read_and_precise()
> + * would be in update_branch_counts() when S's branches counter
> + * reaches 0. However, this falls short in the following case:
> + *
> + *     sum =3D 0
> + *     bpf_repeat(10) {                              // a
> + *             if (unlikely(bpf_get_prandom_u32()))  // b
> + *                     sum +=3D 1;
> + *             if (bpf_get_prandom_u32())            // c
> + *                     asm volatile ("");
> + *             asm volatile ("goto +0;");            // d
> + *     }
> + *
> + * Here a checkpoint is created at (d) with {sum=3D0} and the branch cou=
nter
> + * for (d) reaches 0, so 'sum' would be marked precise.
> + * When second branch of (c) reaches (d), checkpoint would be hit,
> + * and the precision mark for 'sum' propagated to (a).
> + * When the second branch of (b) reaches (a), the state would be {sum=3D=
1},
> + * no widening would occur, causing verification to continue forever.
> + *
> + * To avoid such premature precision markings, the verifier postpones
> + * the call to mark_all_regs_read_and_precise() for state S even further=
.
> + * Suppose state P is a [grand]parent of state S and is the first state
> + * in the current state chain with state->insn_idx within current SCC.
> + * mark_all_regs_read_and_precise() for state S is only called once P
> + * is fully explored.
> + *
> + * The struct 'bpf_scc_info' is used to track this condition:
> + * - bpf_scc_info->branches counts how many states currently
> + *   in env->cur_state or env->head originate from this SCC;

I'm still struggling with this definition of scc_info->branches
and this extra 'enter':

>         cur->insn_hist_start =3D cur->insn_hist_end;
>         cur->dfs_depth =3D new->dfs_depth + 1;
>         list_add(&new_sl->node, head);
> +       parent_scc_enter(env, env->cur_state);

since we don't do it for st->branches.

Can we make scc->branches symmetrical to st->branches ?
Only push_stack() will do scc_enter(),
and scc_exit() in update_branch_counts()
even if st->branches > 0.

If that's not possible let's pick a different name for scc_info->branches
to make it clear that the logic is quite different to st->branches.

> + * - bpf_scc_info->scc_epoch counts how many times 'branches'
> + *   has reached zero;
> + * - bpf_verifier_state->scc_epoch records the epoch of the SCC
> + *   corresponding to bpf_verifier_state->insn_idx at the moment
> + *   of state creation.
> + *
> + * Functions parent_scc_enter() and parent_scc_exit() maintain the
> + * bpf_scc_info->{branches,scc_epoch} counters.
> + *
> + * bpf_scc_info->branches reaching zero indicates that state P is
> + * fully explored. Its descendants residing in the same SCC have
> + * state->scc_epoch =3D=3D scc_info->scc_epoch. parent_scc_exit()
> + * increments scc_info->scc_epoch, allowing clean_live_states() to
> + * detect these states and apply mark_all_regs_read_and_precise().
> + */

