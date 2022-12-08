Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C785646802
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 04:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLHDvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 22:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHDvq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 22:51:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB2A6392
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 19:51:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w23so319814ply.12
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 19:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4G0JZH8Dnz0I/sMjKaJq7RwfjAiwf4ucpwIRM0YONyY=;
        b=alXzoIjFMNLmfmWBtGemEAIIle/w4mkBUiyQ+j8+VlG6a83StODjlf9fb9yU123bOY
         xnGdOPz4+RI9y0mg8z3MGyMk7CNVcybg4BAQBOCZXKvAyPrvXTXkFooC5ogfbfNPZu6m
         DHvdi2mIUWW/CWDg9RHvBdMX08L69g43MG2MS4XF8CfCzNzPvhfodpIfYmxj0tWP50YU
         kVNsOL4ZXluU3iunt3TEMasDvU/vPVduA+A3negHYwXOJ/aetwnt0M6l29UNKjd6598D
         pnPhEcRz6REKGcuEb1IcRR4IeszbH4yDl5flhu5TZbrfdHyxdZQ8dSsCf1s6V+Hl4/hk
         2KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G0JZH8Dnz0I/sMjKaJq7RwfjAiwf4ucpwIRM0YONyY=;
        b=maYJ/Upu1RwsTmf9ru1dUPE49P/O4pKWJns7AYRALVUWJkJUw6pzhkwPTqww31Urta
         UujKpU6MLJjCRDTUgWMJrz8iPHf97xLtV+mISN0OstDtaPYvpD+fTREwLLapxeonUNjc
         jrnhwqRssyW6L9sK8iCPT9CEMoGZ4HKb8IS5X6zZBzSfT1h3NX/jjUQTt9+C4dJrihdz
         5LCIQtLaSm/MCnyPbgH71Cdgq7cLKLjLKAag6Jy+edONTmyys9LC+/IJMZ3ntgMkVkQO
         jd8lbAmTdSS8LtK437ZlHgo/UGl435vyxTMGwvhTUHBg0obJHKSEURFy8ITE8OOGpBDh
         foZQ==
X-Gm-Message-State: ANoB5pmYXDqdBlP2g+usg/FbPXuTGaIsa/WivjwGjC0hiLyfKlMiCUtE
        h3C5YYFn/KjNurtXxpK+Qqs=
X-Google-Smtp-Source: AA0mqf7t9wX4p3u6jwa0kl38mnkwzw7Krm4GMqyARyeok+voczoGhF5ZHPxN028q1VNS4ZrDNhrw2A==
X-Received: by 2002:a17:903:442:b0:189:469c:dc0 with SMTP id iw2-20020a170903044200b00189469c0dc0mr1284953plb.7.1670471504004;
        Wed, 07 Dec 2022 19:51:44 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902d54400b001769206a766sm15281269plf.307.2022.12.07.19.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 19:51:43 -0800 (PST)
Date:   Wed, 7 Dec 2022 19:51:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Message-ID: <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
 <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 08:18:25PM -0500, Dave Marchevsky wrote:
> 
> Before replying to specific things in this email, I think it would be useful
> to have a subthread clearing up definitions and semantics, as I think we're
> talking past each other a bit.

Yeah. We were not on the same page.
The concepts of 'owning ref' and 'non-owning ref' appeared 'new' to me.
I remember discussing 'conditional release' and OBJ_NON_OWNING_REF long ago
and I thought we agreed that both are not necessary and with that
I assumed that anything 'non-owning' as a concept is gone too.
So the only thing left (in my mind) was the 'owning' concept.
Which I mapped as ref_obj_id > 0. In other words 'owning' meant 'acquired'.

Please have this detailed explanation in the commit log next time to
avoid this back and forth.
Now to the fun part...

> 
> On a conceptual level I've still been using "owning reference" and "non-owning
> reference" to understand rbtree operations. I'll use those here and try to map
> them to actual verifier concepts later.
> 
> owning reference
> 
>   * This reference controls the lifetime of the pointee
>   * Ownership of pointee must be 'released' by passing it to some rbtree
>     API kfunc - rbtree_add in our case -  or via bpf_obj_drop, which free's
>     * If not released before program ends, verifier considers prog invalid
>   * Access to the memory ref is pointing at will not page fault

agree.

> non-owning reference
> 
>   * No ownership of pointee so can't pass ownership via rbtree_add, not allowed
>     to bpf_obj_drop
>   * No control of lifetime, but can infer memory safety based on context
>     (see explanation below)
>   * Access to the memory ref is pointing at will not page fault
>     (see explanation below)

agree with addition that both read and write should be allowed into this
'non-owning' ptr.
Which breaks if you map this to something that ORs with PTR_UNTRUSTED.

> 2) From verifier's perspective non-owning references can only exist
> between spin_lock and spin_unlock. Why? After spin_unlock another program
> can do arbitrary operations on the rbtree like removing and free-ing
> via bpf_obj_drop. A non-owning ref to some chunk of memory that was remove'd,
> free'd, and reused via bpf_obj_new would point to an entirely different thing.
> Or the memory could go away.

agree that spin_unlock needs to clean up 'non-owning'.

> To prevent this logic violation all non-owning references are invalidated by
> verifier after critical section ends. This is necessary to ensure "will
> not page fault" property of non-owning reference. So if verifier hasn't
> invalidated a non-owning ref, accessing it will not page fault.
> 
> Currently bpf_obj_drop is not allowed in the critical section, so similarly,
> if there's a valid non-owning ref, we must be in critical section, and can
> conclude that the ref's memory hasn't been dropped-and-free'd or dropped-
> and-reused.

I don't understand why is that a problem.

> 1) Any reference to a node that is in a rbtree _must_ be non-owning, since
> the tree has control of pointee lifetime. Similarly, any ref to a node
> that isn't in rbtree _must_ be owning. (let's ignore raw read from kptr_xchg'd
> node in map_val for now)

Also not clear why such restriction is necessary.

> Moving on to rbtree API:
> 
> bpf_rbtree_add(&tree, &node);
>   'node' is an owning ref, becomes a non-owning ref.
> 
> bpf_rbtree_first(&tree);
>   retval is a non-owning ref, since first() node is still in tree
> 
> bpf_rbtree_remove(&tree, &node);
>   'node' is a non-owning ref, retval is an owning ref

agree on the above definition.

> All of the above can only be called when rbtree's lock is held, so invalidation
> of all non-owning refs on spin_unlock is fine for rbtree_remove.
> 
> Nice property of paragraph marked with 1) above is the ability to use the
> type system to prevent rbtree_add of node that's already in rbtree and
> rbtree_remove of node that's not in one. So we can forego runtime
> checking of "already in tree", "already not in tree".

I think it's easier to add runtime check inside bpf_rbtree_remove()
since it already returns MAYBE_NULL. No 'conditional release' necessary.
And with that we don't need to worry about aliases.

> But, as you and Kumar talked about in the past and referenced in patch 1's
> thread, non-owning refs may alias each other, or an owning ref, and have no
> way of knowing whether this is the case. So if X and Y are two non-owning refs
> that alias each other, and bpf_rbtree_remove(tree, X) is called, a subsequent
> call to bpf_rbtree_remove(tree, Y) would be removing node from tree which
> already isn't in any tree (since prog has an owning ref to it). But verifier
> doesn't know X and Y alias each other. So previous paragraph's "forego
> runtime checks" statement can only hold if we invalidate all non-owning refs
> after 'destructive' rbtree_remove operation.

right. we either invalidate all non-owning after bpf_rbtree_remove
or do run-time check in bpf_rbtree_remove.
Consider the following:
bpf_spin_lock
n = bpf_rbtree_first(root);
m = bpf_rbtree_first(root);
x = bpf_rbtree_remove(root, n)
y = bpf_rbtree_remove(root, m)
bpf_spin_unlock
if (x)
   bpf_obj_drop(x)
if (y)
   bpf_obj_drop(y)

If we invalidate after bpf_rbtree_remove() the above will be rejected by the verifier.
If we do run-time check the above will be accepted and will work without crashing.

The problem with release_on_unlock is that it marks 'n' after 1st remove
as UNTRUSTED which means 'no write' and 'read via probe_read'.
That's not good imo.

> 
> It doesn't matter to me which combination of type flags, ref_obj_id, other
> reg state stuff, and special-casing is used to implement owning and non-owning
> refs. Specific ones chosen in this series for rbtree node:
> 
> owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
>             ref_obj_id > 0
> 
> non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ type that contains bpf_rb_node)
>                 PTR_UNTRUSTED
>                   - used for "can't pass ownership", not PROBE_MEM
>                   - this is why I mentioned "decomposing UNTRUSTED into more
>                     granular reg traits" in another thread

Now I undestand, but that was very hard to grasp.
UNTRUSTED means 'no write' and 'read via probe_read'.
ref_set_release_on_unlock() also keeps ref_obj_id > 0 as you're correctly
pointing out below:
>                 ref_obj_id > 0
>                 release_on_unlock = true
>                   - used due to paragraphs starting with 2) above                

but the problem with ref_set_release_on_unlock() that it mixes real ref-d
pointers with ref_obj_id > 0 with UNTRUSTED && ref_obj_id > 0.
And the latter is a quite confusing combination in my mind,
since we consider everything with ref_obj_id > 0 as good for KF_TRUSTED_ARGS.

> Any other combination of type and reg state that gives me the semantics def'd
> above works4me.
> 
> 
> Based on this reply and others from today, I think you're saying that these
> concepts should be implemented using:
> 
> owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
>             PTR_TRUSTED
>             ref_obj_id > 0

Almost.
I propose:
PTR_TO_BTF_ID | MEM_ALLOC  && ref_obj_id > 0

See the definition of is_trusted_reg().
It's ref_obj_id > 0 || flag == (MEM_ALLOC | PTR_TRUSTED)

I was saying 'trusted' because of is_trusted_reg() definition.
Sorry for confusion.

> non-owning ref: PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
>                 PTR_TRUSTED
>                 ref_obj_id == 0
>                  - used for "can't pass ownership", since funcs that expect
>                    owning ref need ref_obj_id > 0

I propose:
PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0

Both 'owning' and 'non-owning' will fit for KF_TRUSTED_ARGS kfuncs.

And we will be able to pass 'non-owning' under spin_lock into other kfuncs
and owning outside of spin_lock into other kfuncs.
Which is a good thing.

> And you're also adding 'untrusted' here, mainly as a result of
> bpf_rbtree_add(tree, node) - 'node' becoming untrusted after it's added,
> instead of becoming a non-owning ref. 'untrusted' would have state like:
> 
> PTR_TO_BTF_ID | MEM_ALLOC (w/ rb_node type)
> PTR_UNTRUSTED
> ref_obj_id == 0?

I'm not sure whether we really need full untrusted after going through bpf_rbtree_add()
or doing 'non-owning' is enough.
If it's full untrusted it will be:
PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0

tbh I don't remember why we even have 'MEM_ALLOC | PTR_UNTRUSTED'.

> I think your "non-owning ref" definition also differs from mine, specifically
> yours doesn't seem to have "will not page fault". For this reason, you don't
> see the need for release_on_unlock logic, since that's used to prevent refs
> escaping critical section and potentially referring to free'd memory.

Not quite.
We should be able to read/write directly through
PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
and we need to convert it to __mark_reg_unknown() after bpf_spin_unlock
the way release_reference() is doing.
I'm just not happy with using acquire_reference/release_reference() logic
(as release_on_unlock is doing) for cleaning after unlock.
Since we need to clean 'non-owning' ptrs in unlock it's confusing
to call the process 'release'.
I was hoping we can search through all states and __mark_reg_unknown() (or UNTRUSTED)
every reg where 
reg->id == cur_state->active_lock.id &&
flag == PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0

By deleting relase_on_unlock I meant delete release_on_unlock flag
and remove ref_set_release_on_unlock.

> This is where I start to get confused. Some questions:
> 
>   * If we get rid of release_on_unlock, and with mass invalidation of
>     non-owning refs entirely, shouldn't non-owning refs be marked PTR_UNTRUSTED?

Since we'll be cleaning all
PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0
it shouldn't affect ptrs with ref_obj_id > 0 that came from bpf_obj_new.

The verifier already enforces that bpf_spin_unlock will be present
at the right place in bpf prog.
When the verifier sees it it will clean all non-owning refs with this spinlock 'id'.
So no concerns of leaking 'non-owning' outside.

While processing bpf_rbtree_first we need to:
regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
regs[BPF_REG_0].id = active_lock.id;
regs[BPF_REG_0].ref_obj_id = 0;

>   * Since refs can alias each other, how to deal with bpf_obj_drop-and-reuse
>     in this scheme, since non-owning ref can escape spin_unlock b/c no mass
>     invalidation? PTR_UNTRUSTED isn't sufficient here

run-time check in bpf_rbtree_remove (and in the future bpf_list_remove)
should address it, no?

>   * If non-owning ref can live past spin_unlock, do we expect read from
>     such ref after _unlock to go through bpf_probe_read()? Otherwise direct
>     read might fault and silently write 0.

unlock has to clean them.

>   * For your 'untrusted', but not non-owning ref concept, I'm not sure
>     what this gives us that's better than just invalidating the ref which
>     gets in this state (rbtree_{add,remove} 'node' arg, bpf_obj_drop node)

Whether to mark unknown or untrusted or non-owning after bpf_rbtree_add() is a difficult one.
Untrusted will allow prog to do read only access (via probe_read) into the node
but might hide bugs.
The cleanup after bpf_spin_unlock of non-owning and clean up after
bpf_rbtree_add() does not have to be the same.
Currently I'm leaning towards PTR_UNTRUSTED for cleanup after bpf_spin_unlock
and non-owning after bpf_rbtree_add.

Walking the example from previous email:

struct bpf_rbtree_iter it;
struct bpf_rb_node * node;
struct bpf_rb_node *n, *m;

bpf_rbtree_iter_init(&it, rb_root); // locks the rbtree works as bpf_spin_lock
while ((node = bpf_rbtree_iter_next(&it)) {
  // node -> PTR_TO_BTF_ID | MEM_ALLOC | MAYBE_NULL && ref_obj_id == 0
  if (node && node->field == condition) {

    n = bpf_rbtree_remove(rb_root, node);
    if (!n) ...;
    // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == X
    m = bpf_rbtree_remove(rb_root, node); // ok, but fails in run-time
    if (!m) ...;
    // m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y

    // node is still:
    // node -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[0].id

    // assume we allow double locks one day
    bpf_spin_lock(another_rb_root);
    bpf_rbtree_add(another_rb_root, n);
    // n -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[1].id
    bpf_spin_unlock(another_rb_root);
    // n -> PTR_TO_BTF_ID | PTR_UNTRUSTED && ref_obj_id == 0
    break;
  }
}
// node -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == 0 && id == active_lock[0].id
bpf_rbtree_iter_destroy(&it); // does unlock
// node -> PTR_TO_BTF_ID | PTR_UNTRUSTED
// n -> PTR_TO_BTF_ID | PTR_UNTRUSTED
// m -> PTR_TO_BTF_ID | MEM_ALLOC && ref_obj_id == Y
bpf_obj_drop(m);
