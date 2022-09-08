Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D35B1BE5
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 13:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIHLuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 07:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHLuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 07:50:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC00E124D
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 04:50:53 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b17so9122134ilh.0
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=r8lEN9S3dwrybQCURrsIGLH9ycjxozcpfGCLyAhNOqY=;
        b=h0N7EwUlelTe5EE8LzYQFZRiHrVL8LH3DBx+BKc7+Ej9J6TwCNW7knNUpT9zIa5ulS
         q/RyXsgoThZDxUEDmMIrTE2TsLkvkkFk/5/BqfB9i8lcZ8SQ1aA5r7x0tK85EY9bR2TS
         e+tQ6RHCgDgwdJtwr1mYiNhnuUx6HPjo0jMvcOmkBAPdWfMdw2CVMMYR0UQik5bSddHJ
         AqEl3ryFBkQnAZluzSIDmBVJHjf6IGCE6UHCADKguiPmLe60tnDn9PuNoCk8m2wwhwi5
         N+BPNxKScqLrgEwBEKjoZAZbY/+KShhpmS+UTVB3Sgj21sCx7Q7w1zybYSz0aAPwl9zF
         /P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=r8lEN9S3dwrybQCURrsIGLH9ycjxozcpfGCLyAhNOqY=;
        b=ARY7hqvInusWIY4IYrCb0OFS7XRdhWrLwacPRBqp7k9ZZ79ehZRB0Wd2bmD0DtF19v
         663kZk8QwlHL7plziHLsiBSMXPBPCYt94SWfguSEsOafdDs/L8BcGiN0Dw0I/PnXbgXe
         4R53s+cfPiFauiKRMc+olC4AOpisTi4eovcgO4HfmyfMeFSlqmLI9qXsLmQ0qZTlrBd6
         GIFc/FhchmMCt+EI9O5FlfP9Ja87IRY8Zw/5oddbZYbipNDg9VgMss0de5/PNnMkEcpE
         HM8FSO2aLSqpUVS3ULzVPCqKQdldDwGfiwn9yHee91fTQOPeE7BcUD657GC/lMOyj8FJ
         Iz2Q==
X-Gm-Message-State: ACgBeo2cZiuqrWFVemPed0WlftvNpi+KykU69ebpFtbL9gJn7VqOvPN5
        xp7n0/d0dq/SqWmzSgIy0QEYsBKFv8OeJiKtvLpRRDvfN9R7cQ==
X-Google-Smtp-Source: AA6agR4mA4iy1K9iFxsBKyRXPtwuCaKBQYpdGb35ChXzCoXneFhLoH0elHtR8kgbGOUoOE/ZmWnvawnWuQPPPucPJoI=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr1585926ill.216.1662637852337; Thu, 08
 Sep 2022 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-17-memxor@gmail.com>
 <20220908003429.wsucvsdcxnkipcja@macbook-pro-4.dhcp.thefacebook.com>
 <CAP01T77-ygt+MvvwzRwo+3kDrk_8sCv-ASGT8qL2PvPjL_11jw@mail.gmail.com> <20220908033741.l6zhopfhnfrpi72y@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220908033741.l6zhopfhnfrpi72y@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 13:50:14 +0200
Message-ID: <CAP01T76YqSKUMFCVz-WqQQL29SFFn4DG6wqwm0HVpN2-DqJuFA@mail.gmail.com>
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

On Thu, 8 Sept 2022 at 05:37, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 08, 2022 at 04:39:43AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu, 8 Sept 2022 at 02:34, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Sep 04, 2022 at 10:41:29PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > Add the concept of a memory object model to BPF verifier.
> > > >
> > > > What this means is that there are now some types that are not just plain
> > > > old data, but require explicit action when they are allocated on a
> > > > storage, before their lifetime is considered as started and before it is
> > > > allowed for them to escape the program. The verifier will track state of
> > > > such fields during the various phases of the object lifetime, where it
> > > > can be sure about certain invariants.
> > > >
> > > > Some inspiration is taken from existing memory object and lifetime
> > > > models in C and C++ which have stood the test of time. See [0], [1], [2]
> > > > for more information, to find some similarities. In the future, the
> > > > separation of storage and object lifetime may be made more stark by
> > > > allowing to change effective type of storage allocated for a local kptr.
> > > > For now, that has been left out. It is only possible when verifier
> > > > understands when the program has exclusive access to storage, and when
> > > > the object it is hosting is no longer accessible to other CPUs.
> > > >
> > > > This can be useful to maintain size-class based freelists inside BPF
> > > > programs and reuse storage of same size for different types. This would
> > > > only be safe to allow if verifier can ensure that while storage lifetime
> > > > has not ended, object lifetime for the current type has. This
> > > > necessiates separating the two and accomodating a simple model to track
> > > > object lifetime (composed recursively of more objects whose lifetime
> > > > is individually tracked).
> > > >
> > > > Everytime a BPF program allocates such non-trivial types, it must call a
> > > > set of constructors on the object to fully begin its lifetime before it
> > > > can make use of the pointer to this type. If the program does not do so,
> > > > the verifier will complain and lead to failure in loading of the
> > > > program.
> > > >
> > > > Similarly, when ending the lifetime of such types, it is required to
> > > > fully destruct the object using a series of destructors for each
> > > > non-trivial member, before finally freeing the storage the object is
> > > > making use of.
> > > >
> > > > During both the construction and destruction phase, there can be only
> > > > one program that can own and access such an object, hence their is no
> > > > need of any explicit synchronization. The single ownership of such
> > > > objects makes it easy for the verifier to enforce the safety around the
> > > > beginning and end of the lifetime without resorting to dynamic checks.
> > > >
> > > > When there are multiple fields needing construction or destruction, the
> > > > program must call their constructors in ascending order of the offset of
> > > > the field.
> > > >
> > > > For example, consider the following type (support for such fields will
> > > > be added in subsequent patches):
> > > >
> > > > struct data {
> > > >       struct bpf_spin_lock lock;
> > > >       struct bpf_list_head list __contains(struct, foo, node);
> > > >       int data;
> > > > };
> > > >
> > > > struct data *d = bpf_kptr_alloc(...);
> > > > if (!d) { ... }
> > > >
> > > > Now, the type of d would be PTR_TO_BTF_ID | MEM_TYPE_LOCAL |
> > > > OBJ_CONSTRUCTING, as it needs two constructor calls (for lock and head),
> > > > before it can be considered fully initialized and alive.
> > > >
> > > > Hence, we must do (in order of field offsets):
> > > >
> > > > bpf_spin_lock_init(&d->lock);
> > > > bpf_list_head_init(&d->list);
> > >
> > > All sounds great in theory, but I think it's unnecessary complex at this point.
> > > There is still a need to __bpf_list_head_init_zeroed as seen in later patches.
> >
> > This particular call is only because of map values. INIT_LIST_HEAD for
> > prealloc init or alloc_elem would be costly.
> > There won't be any concern to do it in check_and_init_map_value, we
> > zero out the field there already. Nothing else needs this check.
> >
> > List helpers I am planning to inline, it doesn't make sense to have
> > two loads/stores inside kfuncs. And then for local kptrs there is no
> > need to zero init. pop_front/pop_back are even uglier. There you need
> > NULL check + zero init, _then_ check for list_empty. Same with future
> > list_splice.
>
> The inlining is an orthogonal topic.
> It doesn't have to be done the way of map_gen_lookup().
>
> > I don't believe list helpers are going to be so infrequent such that
> > all this might not matter at all.
> >
> > But fine, I still consider this a fair point. I thought a lot about this too.
> >
> > It really boils down to: do we really want to always zero init?
>
> Special fields like locks, timers, lists, trees -> yes.
>
> >
> > What seems more desirable to me is forcing initialization like this,
> > esp. since memory reuse is going to be the more common case,
> > and then simply relaxing initialization when we know it comes from
> > bpf_kptr_zalloc. needs_construction similar to needs_destruction.
> > We aren't requiring bpf_list_node_fini, same idea there.
> >
> > Zeroing the entire big struct vs zeroing/initing two fields makes a
> > huge difference.
>
> Right, but too many assumptions in this reasoning.
> I wasn't proposing to do bzero the whole sizeof(struct foo) in bpf_kptr_zalloc.
> I wasn't proposing to have zalloc flavor either.
> We can do selective zeroing.
> The prog will call bpf_kptr_alloc and bpf_kptr_free,
> but it doesn't have to be the same kfunc-s for all btf types.
> We can substitute kfuncs with custom implicit dtors and ctors based on type info.
> Sort of like C++ calls constructors in operator new.
> But here we can go pretty far with _implicit_ ctors/dtors only.
>
> > > So all this verifier enforced constructors we don't need _today_.
> > > Zero init of everything works.
> > > It's the case for list_head, list_node, spin_lock, rb_root, rb_node.
> > > Pretty much all new data structures will work with zero init
> > > and all of them need async dtors.
> > > The verifier cannot help during destruction.
> > > dtors have to be specified declaratively in a bpf prog for new types
> >
> > I think about it the other way around.
> >
> > There actually isn't a need to specify any dtor IMO for custom types.
> > Just init and free your type inline. Much more familiar to people
> > doing C already.
> > Custom types are always just data without special fields, and we know
> > how to destroy BPF special fields.
> > Map already knows how to 'destruct' these types, just like it has to
> > know how to destruct map value.
> >
> > map value type and local kptr type are similar in that regard. They
> > are both local types in prog BTF with special fields.
> > If it can do it for map value, it can do it for local kptr if it finds
> > it in map (it has to).
> >
> > To me taking prog reference and setting up per-type dtor is the uglier
> > solution. It's unnecessary for the user. That then forces you to have
> > similar semantics like bpf_timer. map_release_uref will be used to
> > break the reference cycle between map and prog, which is undesirable.
> > More effort then - to think about some way to alleviate that, or live
> > with it and compromise.
>
> Completely agree. I think explicit (bpf prog provided) dtor is an extreme case.
> Hopefully we won't need to add support for it for long time.
> The verifier should be able to do implicit ctor/dtor based on BTF only
> and that will allow us to build pretty complex data structures with rbtrees,
> link lists, etc.
>
> The main point is dtor of bpf_list_head in map value has to be implicit anyway.
> The prog can do:
> struct foo {
>   struct bpf_list_head head;
>   struct bpf_spin_lock lock;
> };
>
> bpf_list_lock
> bpf_list_add(&val->head, ...);
> bpf_list_unlock
> exit
>
> The map will have elements allocated and these elements will contain kptrs
> and populated link lists and rbtrees.
> The bpf infra has to be able to free all these things automatically
> based on BTF and it obviously can do so.
> Since it has to do it anyway we can allow:
> foo_ptr = bpf_kptr_xchg(...);
> bpf_kptr_free(foo_ptr);
> and that free function will do the same implicit destruction of
> the link list which will include walking the list and deleting
> elements recursively.
> Maybe it means that it would have to grab the locks automatically as well.
> Not sure. For single owner case locks won't be needed.
>

Nope, no locks will be held whenever bpf_kptr_free is called. At that
point, concurrency wrt BPF special fields is always zero.
Even with bpf_refcount you will call it in true branch of
if (bpf_refcount_put(...)) { bpf_kptr_free(kptr); }

For RCU protected ones, lock may be held without refcount to e.g.
manipulate data, but manipulation of BPF fields will require refcount,
to protect against concurrent destruction.

> > It shouldn't be invoked on bpf_kptr_free automagically. That is the
> > job of the language and best suited to that.
> > Verifier will see BPF ASM after translation from C/C++/Rust/etc., so
> > for us the destruction at language level appears as the destructing
> > phase of local kptr in verifier. For maps it's the last resort, where
> > programs are already gone, so there is nothing left to do but free
> > stuff.
>
> The C++ compiler generated ctors/dtors sequences instructs "dumb"
> cpu execute them. We have the verifier in-between and the whole run-time.
> The map destruction case is not "last resort". It's a feature provided by
> the bpf run-time. Just like golang garbage collector is not a "last resort".
>
> Anyway back to original point which is:
> we don't have to add support to the verifier to enforce explicit ctor/dtor
> sequences. We can solve practical use cases without that additional complexity.
> There are plenty of other complex things in this patch set.

I slept over this. I think I can get behind this idea of implicit
ctor/dtor. We might have open coded construction/destruction later if
we want.

I am however thinking of naming these helpers:
bpf_kptr_new
bpf_kptr_delete
to make it clear it does a little more than just allocating the type.
The open coded cases can later derive their allocation from the more
bare bones bpf_kptr_alloc instead in the future.

The main reason to have open coded-ness was being able to 'manage'
resources once visibility reduces to current CPU (bpf_refcount_put,
single ownership after xchg, etc.). Even with RCU, we won't allow
touching the BPF special fields without refcount. bpf_spin_lock is
different, as it protects more than just bpf special fields.

But one can still splice or kptr_xchg before passing to bpf_kptr_free
to do that. bpf_kptr_free is basically cleaning up whatever is left by
then, forcefully. In the future, we might even be able to do elision
of implicit dtors based on the seen data flow (splicing in single
ownership implies list is empty, any other op will undo that, etc.) if
there are big structs with too many fields. Can also support that in
open coded cases.

What I want to think about more is whether we should still force
calling bpf_refcount_set vs always setting it to 1.

I know we don't agree about whether list_add in shared mode should
take ref vs transfer ref. I'm leaning towards transfer since that will
be most intuitive. It then works the same way in both cases, single
ownership only transfers the sole reference you have, so you lose
access, but in shared you may have more than one. If you have just one
you will still lose access.

It will be odd for list_add to consume it in one case and not the
other. People should already be fully conscious of how they are
managing the lifetime of their object.

It then seems better to require users to set the initial refcount
themselves. When doing the initial linking it can be very cheap.
Later get/put/inc are always available.

But forcing it to be called is going to be much simpler than this patch.
