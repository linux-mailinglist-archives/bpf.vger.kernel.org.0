Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122265A06C7
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiHYBq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 21:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiHYBpT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 21:45:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52229E696
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 18:40:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x26so976629pfo.8
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ubE1fr7S2OS0ddd595LjBfqIVl+cVC1p9rQC9W1q/40=;
        b=PDNITf3HDnw1NuyB6yCi5BToYUsnmOXKIBN6FUoRbuT5GI08XW7dfkGq+PfOWLGsLO
         Ja+mrQvo1QUFvyOVZw9j32Jeh0UIutNp/aaeCwFxOu1aLczv8mzn7/sKtVZdIviY7tAf
         ZlWcQRTJyq5om2iXWyPYCKkxSQZ4REz9e9OxqDJyiChrqBTuVgOuZLo5PDvoOjwtA6JD
         3+HKjUcg24uEIDo0eba2JVG/jW9++U/gOW2Rwv27njiF4zjye+fTIfFRXhO3sOMTYCKB
         dF8FDtcrm1Ab34kxHeBTna3h17CIuJHfthYjNquFSjmNuu7QkdkMemgY0kNJeF9ZAiKQ
         mKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ubE1fr7S2OS0ddd595LjBfqIVl+cVC1p9rQC9W1q/40=;
        b=mxZUn7esUdtpQGm26BmzbJL6n3A7QAQKvRHS2GCH/tBxwOHDz+1PBfWWE3PPl+BPG7
         tAREcsIic5mHNgNxOdCRsBPQKkNuA5QYNsM1JSpPWmtI0kcxfJ2aawYJLftvEmOzu51Z
         29PnceoJJY+Vz5IoYy7DRx4qpV0zvwAHejVK5/z3/dC9cU8LqXP6Bqjen4OZn7lMr4Ow
         tgFfxnKekrqmR5KJGcvNdD/ynRmml1M38BdZidwjBbgmkFLNrCnq22YZ1s/PKC6pqML1
         evpI3cbif1JHH7cspdkeudlyrVovBR34KKKKrzCKuK9qRwht60bw8QBLd0D0XSI6D1dp
         u2rw==
X-Gm-Message-State: ACgBeo0dOdf7A1v6w1PMeZ5Ci3rzxy1uMUBTSOSldEO9f+zqFSPp5kr/
        Fwpi0aK2kmFTjJigjkZBHBOR23ZPbwg=
X-Google-Smtp-Source: AA6agR74ne1kQz4Bq7RW8KfdRG1Xyv/TA5PO/qK63TRIXz7cpTHvYbdxz6C1ilYiPffVUaRWcQ5VpQ==
X-Received: by 2002:a65:5805:0:b0:42b:22f4:7821 with SMTP id g5-20020a655805000000b0042b22f47821mr1407730pgr.2.1661391619882;
        Wed, 24 Aug 2022 18:40:19 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:500::2:bbf])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79591000000b0052aaff953aesm13819702pfj.115.2022.08.24.18.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 18:40:19 -0700 (PDT)
Date:   Wed, 24 Aug 2022 18:40:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Subject: Re: BPF Linked Lists discussion
Message-ID: <20220825014017.6z5swmnplfzc42qx@MacBook-Pro-3.local>
References: <CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com>
 <232c8439-4e34-f89c-bc97-c3a445a15ac4@fb.com>
 <CAP01T77PBfQ8QvgU-ezxGgUh8WmSYL3wsMT7yo4tGuZRW0qLnQ@mail.gmail.com>
 <20220819190334.gmu6ewdumam4ggzi@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <CAP01T75Xq8evu_-g+1BCW1WXVRR0LN8s7n+MCCKLFn7bQTYKjQ@mail.gmail.com>
 <20220823200232.s253rim2thlzpzon@MacBook-Pro-3.local>
 <CAP01T74SPu0eL2C5MWBAF2CeEjzW4UGAdSOVL4iV0ESOePnr2Q@mail.gmail.com>
 <20220824235304.rgpsug34tv2bnojd@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <CAP01T77RCPcECUnFgUueARnLfoVvooCQALFRrGOqNGMxjVp+TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77RCPcECUnFgUueARnLfoVvooCQALFRrGOqNGMxjVp+TQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 03:02:44AM +0200, Kumar Kartikeya Dwivedi wrote:
> > >
> > > I'm thinking of more realistic cases and whether this will cover them
> > > in the future. This comparison idea works fine when locks are in the
> > > same _type_.
> > >
> > > Eventually you will have cases where you have lock hierarchies: When
> > > holding two locks in two _different_ types, you have the ordering A,
> > > B. When holding the locks of different _types_, you can determine that
> > > you never go and take them in B, A ordering.
> > >
> > > So you have lock 'domains', each domain defines an ordering rule and
> > > comprises a set of types.
> > >
> > > When the user doesn't specify anything, there is the default domain
> > > with all prog BTF types, and the rule is lock address based ordering.
> > > When the user defines an ordering between types, they cannot be locked
> > > now with the address based rule, they can only be held in A, B order
> > > (or whatever it is). Lock in A cannot be held with anything else, lock
> > > in B cannot be held unless lock of type A is held.
> > >
> > > Within the same type, address based ordering will still be ok.
> >
> > Not following at all.
> > What is the 'type' of lock ? spin_lock vs mutex ?
> 
> Lock within a type. Lock inside type A, Lock inside type B.

Hmm. Did you mean the case of:
struct map_value_A {
  struct bpf_lock lock;
  struct bpf_rb_root root;
};

struct map_value_B {
  struct bpf_lock lock;
  struct bpf_rb_root root;
};

and because the locks (and corresponding rb trees) are in different
allocations it's ok to take both locks in whatever order?
That's still a looming deadlock.
Even if bpf progs has tags that tell the verifier "no deadlock" here
we cannot rely on that.

lockdep's concept of lock classes cannot be used here, since the verifier
have to guarantee safety.

> 
> > Why bother distinguishing?
> >
> > > This is not exhaustive, but it will cover the majority of the cases.
> > > The good thing is then you don't need comparisons, and we can extend
> > > this to even more than two locks, as long as the constraints are
> > > specified in BTF.
> > >
> > > So I lean more towards letting the verifier understand the
> > > relationship between two lock calls, instead of bpf_spin_lock_double.
> > > That can either come from address comparisons, or it can come from
> > > BTF. bpf_spin_lock_double is ok for 2 levels of locking, but with BTF
> > > we will be able to go beyond that.
> >
> > It doesn't look like that the address of the lock will stay known
> > to the verifier.
> 
> But when you lock it, you need to pass the bpf_spin_lock pointer to
> the call, right? We only need to determine ordering between lock
> pointers passed to two spin lock calls, the address doesn't have to be
> known to the verifier. Same thing which bpf_spin_lock_double does. We
> can do inside the program whatever it can do.
> 
> if (l1 < l2)
>  lock(l1); lock(l2);
> else
>  lock(l2); lock(l1);

as an open coded version lock_double? Sure. That can be made to work,
but I'm missing why the verifier has to support that when the helper
can do the same.

The "dynamic" lock I'm talking about is the case where we do:
struct map_value {
   struct bpf_lock *lock;
   struct bpf_rb_root root;
};
and the verifier checks that the program did
 bpf_lock(elem->lock);
before bpf_rb_add(... &elem->root);

Same concept as "lock and corresponding rb tree / list head are part of
the same allocation", but now lock is only known at run-time.
So bpf_rb_add needs to cmpxchg it and stash it similar to
cmpxchg(rb_node->owner, rb_root) check that we will do for shared objects.

bpf_rb_add() will do two run-time checks: one that lock is actually
correct lock used to protect the rbtree and second check that
node-to-be-added is associated with corrent rbtree.

> > I've considered it, but it only adds run-time overhead and extra UX pain. Consider:
> 
> That I agree with.
> 
> > if (bpf_can_rb_add(node, root))
> >   bpf_rb_add(node, root, cb);
> >
> > It's non-trivial for the verifier to enforce that 'root' is the same
> > in both calls. Especially when 'root' arg in 2nd call is unnecessary, since it was cmpxchg-ed
> > and stored in the first call.
> > So the user should write:
> > if (bpf_can_rb_add(node, root))
> >   bpf_rb_add(node, cb);
> >
> > So bpf_can_rb_add did: node->owner = root; refcount_inc(node->refcnt)
> 
> This is a bit different from what I proposed. Once you do cmpxchg
> node->owner to root to 'own for add' (can_add in your email), some
> other CPU can see node->owner == root and try to remove node which is
> not part of the rb_tree yet. What you want to store is BPF_PTR_POISON.
> Invalid non-NULL value that can never match that is_owner load.
> Basically mark the node as 'busy'.
> 
> And then it is usable for rb_add in the success branch, but not to
> just some single rb_tree 'root', to any rb_tree. No need for
> 'associating' node and root. You can do this op outside the lock. Add
> will finally do a simple store of the owner to complete the add (you
> can call it the linearization point of bpf_rb_add, as now the node is
> visible as 'added to rb_tree' to other CPUs).
> 
> When doing rb_add, you will see the 'root' we are adding to is locked,
> and we already own the node parameter for add, so we don't check
> anything else. As soon as you unlock, your ownership to simply remove
> or add is gone.

I see. So it will be:
obj = bpf_obj_alloc();
if (bpf_can_rb_add(&obj->rb_node)) {
  bpf_spin_lock();
  bpf_rb_add(&obj->rb_node, &rb_root, cb);
  bpf_spin_unlock();
} else {
  bpf_obj_free(obj);
}
and that has to be done every time we do bpf_rb_add?
Because the verifier has to see this data flow within the same program
it cannot be done once earlier or outside of the iterator loop.
This 'if' has to be there for every obj->rb_node.

And the cost of rb_add for shared owner case is still the same:
cmpxchg, cmpxchg, atomic_inc, stores, cmpxchg.

That doesn't help performance and comes to UX preferences.

> But I guess it might be a bit tiring for everyone slogging through
> this over and over :), 

Brainstorming consumes more calories than physical exercise :)

> so I'll focus on single ownership first, and
> we'll discuss this shared case in the RFC patches next time... More
> easier to poke holes theories then.
> 
> Because I think it is clear by now that unless we restrict usage
> heavily, to ensure safety for the shared ownership case we need to
> track the owner. It will just depend on what protocol is chosen to
> transfer the ownership of the node from one tree to another.
> 
> > the only thing it didn't do is rb_add.
> > bpf_rb_add() at least doing some work, but for bpf_list_add() it's a pointer assignment
> > that left to do.
> > And now these code spawns two function calls.
> > And above code has hidden logic that 'root' was remembered earlier.
> > These side effects make reading such code unpleasant.
> >
> > But turning the same argument around... and thinking about can_add differently...
> >
> > Single owner case:
> > bpf_lock, bpf_list_add, bpf_unlock -> cmpxchg, stores, cmpxchg
> >
> > Shared owner case:
> > bpf_lock, bpf_list_add, bpf_unlock -> cmpxchg, cmpxchg, atomic_inc, stores, cmpxchg.
> >
> > While discussing this with Tejun and Dave the idea came to split association
> > of the node with a tree and actual addition.
> > Something like:
> > obj = bpf_obj_alloc();
> > bpf_obj_assoc(&obj->rb_node, &rb_root);
> > bpf_spin_lock();
> > bpf_rbtree_add(&obj->rb_node, cb);
> > bpf_spin_unlock();
> >
> > The assumption is that nodes will belong to the same tree much longer
> > than add/erase from the tree. This will move cmpxchg + atomic_inc from add/erase path.
> 
> But whenever you move from one rb_root to another, then you have to
> change object association again, right? I.e. that call is part of move
> operation, so what changed from above where you have to own for add
> because someone else might try to 'steal' it after unlock? Maybe I
> missed something.

Correct. To move the node from one tree to another the prog has to
do another bpf_obj_assoc.

> >
> > But now the verifier has to make sure that correct root is locked at the time
> > of bpf_rbtree_add... if above example is in one function it's doable, but consider:
> > bpf_prog1()
> > {
> >   obj = bpf_obj_alloc();
> >   bpf_obj_assoc(&obj->rb_node, &rb_root);
> >   kptr_xchg(obj, map_value); // stash it for future use
> > }
> > bpf_prog2()
> > {
> >   obj = kptr_xchg(map_value); // get it from local storage or else
> >   bpf_spin_lock();
> >   bpf_rbtree_add(&obj->rb_node, cb);
> >   bpf_spin_unlock();
> > }
> >
> > Not only btf_type_id needs to be known in kptr_xchg, but the specific root
> > to be able to check that root and lock are from the same allocation.
> >
> > So bpf_can_rb_add and bpf_obj_assoc are not quite dead-ends yet, but
> > I propose to implement bpf_list_add() the way I drafted earlier as the first step.
> > The rest can be an optimization later.
> 
> Agreed, going to work on just the single ownership case first, and
> this shared case after that (and think about making it better in the
> mean time).

+1.
