Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4890D58F3EB
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 23:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiHJVr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiHJVr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 17:47:29 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D090974CE3
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 14:47:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id x64so13308536iof.1
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tMq305SjMEye+QQQuURLPP8w1FPRVvNLBHgaBKPuUIA=;
        b=KHgfg/T6gBWJC8ThAUf08+Eyg6M73o+bHvg1sgcN/iF7IWP/oOgtDtSPZQWcgvVn0f
         VHCPK0QrguW2JSjkPhiA4MDdqqeWa10MPn1qr1RUxkj6QyAYTJ64P/SKmpDrZnzExfxL
         3lUrgX8SEcQ/zbEwfFDRt2E2UiOhjFAwdvBQO8sQr8l+f6P9wPIrmtF677WBcj6kbXWs
         poul15gHHH1t7Fm16kt9obUx3xZDTbv0MmOfY4txP/qtJM+mFIjPcVLDnlG84g/qIJKn
         EUImqvSkw3qJfNdlbTlE8X2PajJvec6LUVns9DP5YsiY6jsV8F5k7xKUshfc66joesDd
         QJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tMq305SjMEye+QQQuURLPP8w1FPRVvNLBHgaBKPuUIA=;
        b=4c3/jI7s4X9T+sQY5gLFjSTEwR5+5OOLdQq1V/xn9fYwv3O2MeN2mRxNfyEXAlSwHB
         xERrbI4t1KRZOMv+6XEr2F3LUInTc+rA37ZXW7y6wdmrwsL3NciXTH8kuSsyydC49W/E
         KXIaP3ywixtKyODEwFe+acEbuAFPkYp5E+iYNiVUww8XHE1yvUwzA/rZZffMC5lms0QP
         xMbNKkmtWGVJiE+8ZD1CDvW+8279N02MkwinGuR3LypgbxS6jwCnYMkbA+Om2cvv1qic
         G1BGXuG2Lkx5admUs3lj/vimMYYkcAqWEzpdm5Tqxbo8TfUoTWgHOp41vhjhIXrL9JBT
         fk0g==
X-Gm-Message-State: ACgBeo2b90mhXr44Gqj3OuIA2GHfjJ+UxkgufwtGM20ftOtmOl2U6dXE
        fWg8+Kb9fQoGezlAMcXmaFY0blylgOu79EeBfRuDnsC/
X-Google-Smtp-Source: AA6agR4abcECth/M4pVNPVQ/EV11bl5IiVCx/f2zpkC4fMUhoMZ36aE0yyeHGJ59IVbL2tUet3CDIpIgIC95S84OMoo=
X-Received: by 2002:a05:6638:3392:b0:343:13f3:44c with SMTP id
 h18-20020a056638339200b0034313f3044cmr6530808jav.93.1660168047038; Wed, 10
 Aug 2022 14:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com> <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
In-Reply-To: <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 10 Aug 2022 23:46:50 +0200
Message-ID: <CAP01T75nt69=jgGPGXYXHSGc5EDHejgLQpyY8TMeUy2U4Prxvg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to rbtree
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
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

On Tue, 2 Aug 2022 at 00:23, Alexei Starovoitov <ast@fb.com> wrote:
>
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> > This patch adds a struct bpf_spin_lock *lock member to bpf_rbtree, as
> > well as a bpf_rbtree_get_lock helper which allows bpf programs to access
> > the lock.
> >
> > Ideally the bpf_spin_lock would be created independently oustide of the
> > tree and associated with it before the tree is used, either as part of
> > map definition or via some call like rbtree_init(&rbtree, &lock). Doing
> > this in an ergonomic way is proving harder than expected, so for now use
> > this workaround.
> >
> > Why is creating the bpf_spin_lock independently and associating it with
> > the tree preferable? Because we want to be able to transfer nodes
> > between trees atomically, and for this to work need same lock associated
> > with 2 trees.
>
> Right. We need one lock to protect multiple rbtrees.
> Since add/find/remove helpers will look into rbtree->lock
> the two different rbtree (== map) have to point to the same lock.
> Other than rbtree_init(&rbtree, &lock) what would be an alternative ?
>
> >
> > Further locking-related patches will make it possible for the lock to be
> > used in BPF programs and add code which enforces that the lock is held
> > when doing any operation on the tree.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> >   include/uapi/linux/bpf.h       |  7 +++++++
> >   kernel/bpf/helpers.c           |  3 +++
> >   kernel/bpf/rbtree.c            | 24 ++++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  7 +++++++
> >   4 files changed, 41 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4688ce88caf4..c677d92de3bc 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5385,6 +5385,12 @@ union bpf_attr {
> >    *  Return
> >    *          0
> >    *
> > + * void *bpf_rbtree_get_lock(struct bpf_map *map)
> > + *   Description
> > + *           Return the bpf_spin_lock associated with the rbtree
> > + *
> > + *   Return
> > + *           Ptr to lock
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)               \
> >       FN(unspec),                     \
> > @@ -5600,6 +5606,7 @@ union bpf_attr {
> >       FN(rbtree_find),                \
> >       FN(rbtree_remove),              \
> >       FN(rbtree_free_node),           \
> > +     FN(rbtree_get_lock),            \
> >       /* */
> >
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 35eb66d11bf6..257a808bb767 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1587,6 +1587,7 @@ const struct bpf_func_proto bpf_rbtree_add_proto __weak;
> >   const struct bpf_func_proto bpf_rbtree_find_proto __weak;
> >   const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
> >   const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
> > +const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
> >
> >   const struct bpf_func_proto *
> >   bpf_base_func_proto(enum bpf_func_id func_id)
> > @@ -1686,6 +1687,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >               return &bpf_rbtree_remove_proto;
> >       case BPF_FUNC_rbtree_free_node:
> >               return &bpf_rbtree_free_node_proto;
> > +     case BPF_FUNC_rbtree_get_lock:
> > +             return &bpf_rbtree_get_lock_proto;
> >       default:
> >               break;
> >       }
> > diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
> > index 250d62210804..c6f0a2a083f6 100644
> > --- a/kernel/bpf/rbtree.c
> > +++ b/kernel/bpf/rbtree.c
> > @@ -9,6 +9,7 @@
> >   struct bpf_rbtree {
> >       struct bpf_map map;
> >       struct rb_root_cached root;
> > +     struct bpf_spin_lock *lock;
> >   };
> >
> >   BTF_ID_LIST_SINGLE(bpf_rbtree_btf_ids, struct, rb_node);
> > @@ -39,6 +40,14 @@ static struct bpf_map *rbtree_map_alloc(union bpf_attr *attr)
> >
> >       tree->root = RB_ROOT_CACHED;
> >       bpf_map_init_from_attr(&tree->map, attr);
> > +
> > +     tree->lock = bpf_map_kzalloc(&tree->map, sizeof(struct bpf_spin_lock),
> > +                                  GFP_KERNEL | __GFP_NOWARN);
> > +     if (!tree->lock) {
> > +             bpf_map_area_free(tree);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> >       return &tree->map;
> >   }
> >
> > @@ -139,6 +148,7 @@ static void rbtree_map_free(struct bpf_map *map)
> >
> >       bpf_rbtree_postorder_for_each_entry_safe(pos, n, &tree->root.rb_root)
> >               kfree(pos);
> > +     kfree(tree->lock);
> >       bpf_map_area_free(tree);
> >   }
> >
> > @@ -238,6 +248,20 @@ static int rbtree_map_get_next_key(struct bpf_map *map, void *key,
> >       return -ENOTSUPP;
> >   }
> >
> > +BPF_CALL_1(bpf_rbtree_get_lock, struct bpf_map *, map)
> > +{
> > +     struct bpf_rbtree *tree = container_of(map, struct bpf_rbtree, map);
> > +
> > +     return (u64)tree->lock;
> > +}
> > +
> > +const struct bpf_func_proto bpf_rbtree_get_lock_proto = {
> > +     .func = bpf_rbtree_get_lock,
> > +     .gpl_only = true,
> > +     .ret_type = RET_PTR_TO_MAP_VALUE,
>
> This hack and
>
> +const struct bpf_func_proto bpf_rbtree_unlock_proto = {
> +       .func = bpf_rbtree_unlock,
> +       .gpl_only = true,
> +       .ret_type = RET_INTEGER,
> +       .arg1_type = ARG_PTR_TO_SPIN_LOCK,
>
> may be too much arm twisting to reuse bpf_spin_lock.
>
> May be return ptr_to_btf_id here and bpf_rbtree_lock
> should match the type?
> It could be new 'struct bpf_lock' in kernel's BTF.
>
> Let's figure out how to associate locks with rbtrees.
>
> Reiterating my proposal that was done earlier in the context
> of Delyan's irq_work, but for different type:
> How about:
> struct bpf_lock *l;
> l = bpf_mem_alloc(allocator, bpf_core_type_id_kernel(*l));
>
> that would allocate ptr_to_btf_id object from kernel's btf.
> The bpf_lock would have constructor and destructor provided by the
> kernel code.
> constructor will set bpf_lock's refcnt to 1.
> then bpf_rbtree_init(&map, lock) will bump the refcnt.
> and dtor will eventually free it when all rbtrees are freed.
> That would be similar to kptr's logic with kptr_get and dtor's
> associated with kernel's btf_id-s.

Just to continue brainstorming: Comments on this?

Instead of a rbtree map, you have a struct bpf_rbtree global variable
which works like a rbtree. To associate a lock with multiple
bpf_rbtree, you do clang style thread safety annotation in the bpf
program:

#define __guarded_by(lock) __attribute__((btf_type_tag("guarded_by:" #lock))

struct bpf_spin_lock shared_lock;
struct bpf_rbtree rbtree1 __guarded_by(shared_lock);
struct bpf_rbtree rbtree2 __guarded_by(shared_lock);

guarded_by tag is mandatory for the rbtree. Verifier ensures
shared_lock spin lock is held whenever rbtree1 or rbtree2 is being
accessed, and whitelists add/remove helpers inside the critical
section.

I don't think associating locks to rbtree dynamically is a hard
requirement for your use case? But if you need that, you may probably
also allocate sets of rbtree that are part of the same lock "class"
dynamically using bpf_kptr_alloc, and do similar annotation for the
struct being allocated.
struct rbtree_set {
  struct bpf_spin_lock lock;
  struct bpf_rbtree rbtree1 __guarded_by(lock);
  struct bpf_rbtree rbtree2 __guarded_by(lock);
};
struct rbtree_set *s = bpf_kptr_alloc(sizeof(*s), btf_local_type_id(*s));
// Just stash the pointer somewhere with kptr_xchg
On bpf_kptr_free, the verifier knows this is not a "trivial" struct,
so inserts destructor calls for bpf_rbtree fields during program
fixup.

The main insight is that lock and rbtree are part of the same
allocation (map value for global case, ptr_to_btf_id for dynamic case)
so the locked state can be bound to the reg state in the verifier.
Then we can also make this new rbtree API use kfuncs instead of UAPI
helpers, to get some field experience before baking it in.

Any opinions? Any brainos or deficiencies in the scheme above?

Background: I have been thinking about how I can bind kptr and normal
data synchronization without having unneeded atomic xchg cost when
lock is already protecting kptr. In my tests this guarded_by
annotation has been proving very useful (you mark data and kptr
protected by lock as guarded_by some spin lock member in same map
value, verifier ensures lock is held during access, and kptr_xchg for
guarded kptr is lowered to non-atomic load/store assuming no
concurrent access, and kptr_xchg from outside the lock section is
rejected).
