Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487365B3605
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIILF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIILFu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:05:50 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F4E9003
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:05:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k2so612261ilu.9
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dPKny+89jfZeC8iCjIsR4B7cGJEgIMFE4XymBlGIhwM=;
        b=ikAo8YZkasvYP33X6QsSNO5HS/UAPWAJ4YSwYPgxwGnJYkc6eTW+77W/4tTRXqngKA
         gTenLu0sWcDhrsG1vZWYe2DD3QuXRt41PIaaPfg/5w7McwEv5ep+kUpix1l40h3VfVrp
         VuOpFhrQNtOTYW5DzfrPCxOzkVggaJ7H1INmAanBww3P1X7IRb8dzVb8L0+Yb2riv05/
         qmuOsLvkoPI26AsCSMGGGMgq2zBZ9bHqlJ5FyRVpUe3NEvy7EET0ZKuVedIx2YtxdjEs
         0i0l2z1E2KDIFlvGpzUAk4td3F1OlzicSbdPiujdWel+KIPMlkYHQ+qsxPSGiHUU5q7x
         5Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dPKny+89jfZeC8iCjIsR4B7cGJEgIMFE4XymBlGIhwM=;
        b=dTUn7CG5ns0r7q2aG1vIgmXTMErr2Ws0pkQNwpq1PcM/PjcVUVNp4H4kxEzBedgSA2
         npzrPk1aUyeOLrGhCRMfLyDAOxz4m8DOWV3zHxKLFni5EUSADrw4BfqzbNS6wo51jfi0
         KmW/v+7cIJFiyNynT33canYh/T2x2iyI3K50ncIwONEA4OcEB8sCsyTcvJf4rqJXEgsU
         ANt6m1SUpiNwAcsg9mcXtQW9GrboQtIRRIDcNfz71Ng0bQNaPzKCBTZ38dO15rar/nz2
         SECoO9EOD3c9Jkx5hEagbdXWOp20uYB7dbT/arptJZbtHdOSDqUMmFqMWcivlcl1oCGA
         pxMg==
X-Gm-Message-State: ACgBeo3ypHJ61JYCyeUU1qGFj+AuWyBCWoWL0S7Ynns17H8J2nuQrxNj
        P1USfuPTi956Vwtriu7BWIb0nxLfA4HWEzIlfZG/OiFH
X-Google-Smtp-Source: AA6agR5i+3NjTXkkWRLQPDst02QvrLiVhFPL2u0JYL3kCOEdPwIEpvckgwzjVkse+BXeDXOlwu5Nvyst4LJ7WNc0FA0=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr3910010ila.164.1662721545883; Fri, 09
 Sep 2022 04:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com>
In-Reply-To: <311eb0d0-777a-4240-9fa0-59134344f051@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 9 Sep 2022 13:05:10 +0200
Message-ID: <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > Global variables reside in maps accessible using direct_value_addr
> > callbacks, so giving each load instruction's rewrite a unique reg->id
> > disallows us from holding locks which are global.
> >
> > This is not great, so refactor the active_spin_lock into two separate
> > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > enough to allow it for global variables, map lookups, and local kptr
> > registers at the same time.
> >
> > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > lock. But the active_spin_lock_id also needs to be compared to ensure
> > whether bpf_spin_unlock is for the same register.
> >
> > Next, pseudo load instructions are not given a unique reg->id, as they
> > are doing lookup for the same map value (max_entries is never greater
> > than 1).
> >
>
> For libbpf-style "internal maps" - like .bss.private further in this series -
> all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
>
>   struct bpf_spin_lock lock1 SEC(".bss.private");
>   struct bpf_spin_lock lock2 SEC(".bss.private");
>   ...
>   spin_lock(&lock1);
>   ...
>   spin_lock(&lock2);
>
> will result in same map but different offsets for the direct read (and different
> aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
>

That won't be a problem. Two spin locks in a map value or datasec are
already rejected on BPF_MAP_CREATE,
so there is no bug. See idx >= info_cnt check in
btf_find_struct_field, btf_find_datasec_var.

I can include offset as the third part of the tuple. The problem then
is figuring out which lock protects which bpf_list_head. We need
another __guarded_by annotation and force users to use that to
eliminate the ambiguity. So for now I just put it in the commit log
and left it for the future.

But it does seem like it's going to be needed at least for the global
case, which should probably do it from the get go.
How does the above idea sound to you?

> > Essentially, we consider that the tuple of (active_spin_lock_ptr,
> > active_spin_lock_id) will always be unique for any kind of argument to
> > bpf_spin_{lock,unlock}.
> >
> > Note that this can be extended in the future to also remember offset
> > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > in the same allocation.
> >
>
> In light of the above the "multiple spin locks in same map_value"
> is probably needed for the common case, probably similar enough to
> "same allocation" logic.
>

Yes, it would be the same idea. Only need to remember an additional
field, the 'offset'.
{ptr, id} already distinguishes between allocations. Offset allows to
distinguish locks within the same allocation or {ptr, id}.

> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  3 ++-
> >  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
> >  2 files changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 2a9dcefca3b6..00c21ad6f61c 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -348,7 +348,8 @@ struct bpf_verifier_state {
> >       u32 branches;
> >       u32 insn_idx;
> >       u32 curframe;
> > -     u32 active_spin_lock;
> > +     void *active_spin_lock_ptr;
> > +     u32 active_spin_lock_id;
>
> It would be good to make this "(lock_ptr, lock_id) is identifier for lock"
> concept more concrete by grouping these fields in a struct w/ type enum + union,
> or something similar. Will make it more obvious that they should be used / set
> together.
>
> But if you'd prefer to keep it as two fields, active_spin_lock_ptr is a
> confusing name. In the future with no context as to what that field is, I'd
> assume that it holds a pointer to a spin_lock instead of a "spin lock identity
> pointer".
>

That's a good point.

I'm thinking
struct active_lock {
  void *id_ptr;
  u32 offset;
  u32 reg_id;
};
How does that look?

> >       bool speculative;
> >
> >       /* first and last insn idx of this verifier state */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b1754fd69f7d..ed19e4036b0a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1202,7 +1202,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
> >       }
> >       dst_state->speculative = src->speculative;
> >       dst_state->curframe = src->curframe;
> > -     dst_state->active_spin_lock = src->active_spin_lock;
> > +     dst_state->active_spin_lock_ptr = src->active_spin_lock_ptr;
> > +     dst_state->active_spin_lock_id = src->active_spin_lock_id;
> >       dst_state->branches = src->branches;
> >       dst_state->parent = src->parent;
> >       dst_state->first_insn_idx = src->first_insn_idx;
> > @@ -5504,22 +5505,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
> >               return -EINVAL;
> >       }
> >       if (is_lock) {
> > -             if (cur->active_spin_lock) {
> > +             if (cur->active_spin_lock_ptr) {
> >                       verbose(env,
> >                               "Locking two bpf_spin_locks are not allowed\n");
> >                       return -EINVAL;
> >               }
> > -             cur->active_spin_lock = reg->id;
> > +             if (map)
> > +                     cur->active_spin_lock_ptr = map;
> > +             else
> > +                     cur->active_spin_lock_ptr = btf;
> > +             cur->active_spin_lock_id = reg->id;
> >       } else {
> > -             if (!cur->active_spin_lock) {
> > +             void *ptr;
> > +
> > +             if (map)
> > +                     ptr = map;
> > +             else
> > +                     ptr = btf;
> > +
> > +             if (!cur->active_spin_lock_ptr) {
> >                       verbose(env, "bpf_spin_unlock without taking a lock\n");
> >                       return -EINVAL;
> >               }
> > -             if (cur->active_spin_lock != reg->id) {
> > +             if (cur->active_spin_lock_ptr != ptr ||
> > +                 cur->active_spin_lock_id != reg->id) {
> >                       verbose(env, "bpf_spin_unlock of different lock\n");
> >                       return -EINVAL;
> >               }
> > -             cur->active_spin_lock = 0;
> > +             cur->active_spin_lock_ptr = NULL;
> > +             cur->active_spin_lock_id = 0;
> >       }
> >       return 0;
> >  }
> > @@ -11207,8 +11221,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >           insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
> >               dst_reg->type = PTR_TO_MAP_VALUE;
> >               dst_reg->off = aux->map_off;
>
> Here's where check_ld_imm uses aux->map_off.
>
> > -             if (map_value_has_spin_lock(map))
> > -                     dst_reg->id = ++env->id_gen;
> > +             WARN_ON_ONCE(map->max_entries != 1);
> > +             /* We want reg->id to be same (0) as map_value is not distinct */
> >       } else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
> >                  insn->src_reg == BPF_PSEUDO_MAP_IDX) {
> >               dst_reg->type = CONST_PTR_TO_MAP;
> > @@ -11286,7 +11300,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >               return err;
> >       }
> >
> > -     if (env->cur_state->active_spin_lock) {
> > +     if (env->cur_state->active_spin_lock_ptr) {
> >               verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
> >               return -EINVAL;
> >       }
> > @@ -12566,7 +12580,8 @@ static bool states_equal(struct bpf_verifier_env *env,
> >       if (old->speculative && !cur->speculative)
> >               return false;
> >
> > -     if (old->active_spin_lock != cur->active_spin_lock)
> > +     if (old->active_spin_lock_ptr != cur->active_spin_lock_ptr ||
> > +         old->active_spin_lock_id != cur->active_spin_lock_id)
> >               return false;
> >
> >       /* for states to be equal callsites have to be the same
> > @@ -13213,7 +13228,7 @@ static int do_check(struct bpf_verifier_env *env)
> >                                       return -EINVAL;
> >                               }
> >
> > -                             if (env->cur_state->active_spin_lock &&
> > +                             if (env->cur_state->active_spin_lock_ptr &&
> >                                   (insn->src_reg == BPF_PSEUDO_CALL ||
> >                                    insn->imm != BPF_FUNC_spin_unlock)) {
> >                                       verbose(env, "function calls are not allowed while holding a lock\n");
> > @@ -13250,7 +13265,7 @@ static int do_check(struct bpf_verifier_env *env)
> >                                       return -EINVAL;
> >                               }
> >
> > -                             if (env->cur_state->active_spin_lock) {
> > +                             if (env->cur_state->active_spin_lock_ptr) {
> >                                       verbose(env, "bpf_spin_unlock is missing\n");
> >                                       return -EINVAL;
> >                               }
