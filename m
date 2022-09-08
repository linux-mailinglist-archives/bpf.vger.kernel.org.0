Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912665B1293
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIHCkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIHCkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:40:21 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA8A6ADE
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:40:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r141so13037162iod.4
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jW85X7zAQUAr1wtWSFahkphFt/IlIqcU8wTZk8OGWJU=;
        b=IBo+0UhdkbGEYeS8kmvxFGgucr964xIo53ewTOrT69RaImfgSXx78ZUKK8YiRGAmTc
         rUYR1Wpg2nMlPaxygj3oC/lKaKbJrMDFTQVoeiYdpqr6uzOtq1mUDvhAyZbOSrT8vvKf
         nKTBAcQzO1lrQRST4b+B0pegtCnOiRS6slniaslaNGgzc93wYhg4fSa9RSHpeir6jU7u
         Ln8WR/HkkGmfcp3/sNJ1e/lhwZsbs6X6uS42lsniQQjKBwyve+faQAg9cnE3PyhyTM9W
         eeLIMVItm7b6BSYZKQ1doovCqZ/ueH72VS3GrcqvAlHnnK8ClrGzBxjO48CUigvY0mkG
         IIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jW85X7zAQUAr1wtWSFahkphFt/IlIqcU8wTZk8OGWJU=;
        b=UzMnUQN2cIhUljSK/rr8DbRG0Ebal4j+cMuUik3rC59n57Gcha+s7PiF7X4Xlk579H
         AFTjfVzL8TLKr/xQqzkcBO3EiAuW3iPZ9cbFucPHDEk8vGgDjqNmDUYlkgZgB7KjbnOB
         W18oLvz0i5T82t5vAB0aYV8LrTYGRFAGutRy5X+r103LdwaG6nDNZ2PnDBEC3Q7mWLPF
         dYVG02huS1pAb6FL5Zt0FaRTMl5YTPW4K9nZN6XwPzfzrph5vbI20AKdo31iSi7RBzK2
         ZYUnRx8HFM2miqpp1yRIzmF45oVd85nPX8J/OTctUwGwUHgvOljMYscLpfrgqrcbjudu
         asvQ==
X-Gm-Message-State: ACgBeo3+t0qAECgM4JiQjcNbiY8vnBk3NogQcnZF/VRL/y/o/+zTxTwE
        xcDx2seqALEPGPmzrjjLjwPx7AjY9i0NiQ9cGzc=
X-Google-Smtp-Source: AA6agR4L+mi0JEyS8OSQX83L972rXo0JSgwUsiiJvNLJ9dOIZ90o8MRbIf3V9kIuWA/aDsdcpd2MeBK6oYVKA5CXyG8=
X-Received: by 2002:a05:6638:2388:b0:34a:e033:396b with SMTP id
 q8-20020a056638238800b0034ae033396bmr3513654jat.93.1662604819579; Wed, 07 Sep
 2022 19:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-17-memxor@gmail.com>
 <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 04:39:43 +0200
Message-ID: <CAP01T77-ygt+MvvwzRwo+3kDrk_8sCv-ASGT8qL2PvPjL_11jw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object model
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
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

On Thu, 8 Sept 2022 at 02:34, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 10:41:29PM +0200, Kumar Kartikeya Dwivedi wrote:
> > Add the concept of a memory object model to BPF verifier.
> >
> > What this means is that there are now some types that are not just plain
> > old data, but require explicit action when they are allocated on a
> > storage, before their lifetime is considered as started and before it is
> > allowed for them to escape the program. The verifier will track state of
> > such fields during the various phases of the object lifetime, where it
> > can be sure about certain invariants.
> >
> > Some inspiration is taken from existing memory object and lifetime
> > models in C and C++ which have stood the test of time. See [0], [1], [2]
> > for more information, to find some similarities. In the future, the
> > separation of storage and object lifetime may be made more stark by
> > allowing to change effective type of storage allocated for a local kptr.
> > For now, that has been left out. It is only possible when verifier
> > understands when the program has exclusive access to storage, and when
> > the object it is hosting is no longer accessible to other CPUs.
> >
> > This can be useful to maintain size-class based freelists inside BPF
> > programs and reuse storage of same size for different types. This would
> > only be safe to allow if verifier can ensure that while storage lifetime
> > has not ended, object lifetime for the current type has. This
> > necessiates separating the two and accomodating a simple model to track
> > object lifetime (composed recursively of more objects whose lifetime
> > is individually tracked).
> >
> > Everytime a BPF program allocates such non-trivial types, it must call a
> > set of constructors on the object to fully begin its lifetime before it
> > can make use of the pointer to this type. If the program does not do so,
> > the verifier will complain and lead to failure in loading of the
> > program.
> >
> > Similarly, when ending the lifetime of such types, it is required to
> > fully destruct the object using a series of destructors for each
> > non-trivial member, before finally freeing the storage the object is
> > making use of.
> >
> > During both the construction and destruction phase, there can be only
> > one program that can own and access such an object, hence their is no
> > need of any explicit synchronization. The single ownership of such
> > objects makes it easy for the verifier to enforce the safety around the
> > beginning and end of the lifetime without resorting to dynamic checks.
> >
> > When there are multiple fields needing construction or destruction, the
> > program must call their constructors in ascending order of the offset of
> > the field.
> >
> > For example, consider the following type (support for such fields will
> > be added in subsequent patches):
> >
> > struct data {
> >       struct bpf_spin_lock lock;
> >       struct bpf_list_head list __contains(struct, foo, node);
> >       int data;
> > };
> >
> > struct data *d = bpf_kptr_alloc(...);
> > if (!d) { ... }
> >
> > Now, the type of d would be PTR_TO_BTF_ID | MEM_TYPE_LOCAL |
> > OBJ_CONSTRUCTING, as it needs two constructor calls (for lock and head),
> > before it can be considered fully initialized and alive.
> >
> > Hence, we must do (in order of field offsets):
> >
> > bpf_spin_lock_init(&d->lock);
> > bpf_list_head_init(&d->list);
>
> All sounds great in theory, but I think it's unnecessary complex at this point.
> There is still a need to __bpf_list_head_init_zeroed as seen in later patches.

This particular call is only because of map values. INIT_LIST_HEAD for
prealloc init or alloc_elem would be costly.
There won't be any concern to do it in check_and_init_map_value, we
zero out the field there already. Nothing else needs this check.

List helpers I am planning to inline, it doesn't make sense to have
two loads/stores inside kfuncs. And then for local kptrs there is no
need to zero init. pop_front/pop_back are even uglier. There you need
NULL check + zero init, _then_ check for list_empty. Same with future
list_splice.

I don't believe list helpers are going to be so infrequent such that
all this might not matter at all.

But fine, I still consider this a fair point. I thought a lot about this too.

It really boils down to: do we really want to always zero init?

What seems more desirable to me is forcing initialization like this,
esp. since memory reuse is going to be the more common case,
and then simply relaxing initialization when we know it comes from
bpf_kptr_zalloc. needs_construction similar to needs_destruction.
We aren't requiring bpf_list_node_fini, same idea there.

Zeroing the entire big struct vs zeroing/initing two fields makes a
huge difference.

> So all this verifier enforced constructors we don't need _today_.
> Zero init of everything works.
> It's the case for list_head, list_node, spin_lock, rb_root, rb_node.
> Pretty much all new data structures will work with zero init
> and all of them need async dtors.
> The verifier cannot help during destruction.
> dtors have to be specified declaratively in a bpf prog for new types

I think about it the other way around.

There actually isn't a need to specify any dtor IMO for custom types.
Just init and free your type inline. Much more familiar to people
doing C already.
Custom types are always just data without special fields, and we know
how to destroy BPF special fields.
Map already knows how to 'destruct' these types, just like it has to
know how to destruct map value.

map value type and local kptr type are similar in that regard. They
are both local types in prog BTF with special fields.
If it can do it for map value, it can do it for local kptr if it finds
it in map (it has to).

To me taking prog reference and setting up per-type dtor is the uglier
solution. It's unnecessary for the user. That then forces you to have
similar semantics like bpf_timer. map_release_uref will be used to
break the reference cycle between map and prog, which is undesirable.
More effort then - to think about some way to alleviate that, or live
with it and compromise.

Later, asynchronous destruction (RCU case where it won't be done
immediately) is just setting reg->states for all fields as
FIELD_STATE_CONSTRUCTED for reg in callback, but type as
OBJ_DESTRUCTING, forcing you to do nothing but unwind and free in that
context.

The real reason to give destruction control to users for local kptrs
is the ability to manage what to do with drained resources.
They might as well splice out their list when freeing a node to a
local list_head, or move it to a map. Same with more cases in the
future (kptr inside kptr).

It shouldn't be invoked on bpf_kptr_free automagically. That is the
job of the language and best suited to that.
Verifier will see BPF ASM after translation from C/C++/Rust/etc., so
for us the destruction at language level appears as the destructing
phase of local kptr in verifier. For maps it's the last resort, where
programs are already gone, so there is nothing left to do but free
stuff.




> and as known kfuncs for list_head/node, rb_root/node.
> There will be unfreed link lists in maps and the later patches handle that
> without OBJ_DESTRUCTING.
> So let's postpone this patch.
