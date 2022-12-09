Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2A647AD8
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLIAjq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIAjo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:39:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5521A38B
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:39:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3287942pjm.2
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJVd6ilonC+4OMmW2+o4T7v1/1aq86Xo3dE76W+Y2kU=;
        b=GUsq1JCuOBLTTT20xQ4mXuPZQ7UpDEHBUFF8tsSo/zQI70YyooueDWyM9e8lD+YJvD
         LzSQk5SDyJOhdaJJKhmAQu1meOLuWppLhL7QN5CvNIIekCrJsZhRFRhjBDYP6BAHBQMB
         ebNILYF9Ycct4MW52DlmfpCqOPXpBHaKy8XdmbJ435AoLIga+tOP2Sn9+FAdrGRt1dy7
         wZRIBZQ44WxkDiVTQg9lPETmi3Vr3RDyAA2CW5hfVsKenVUcnMfa6Dg9+O0UjViWsvVo
         sMrsypztwWo2YKpbuxRNbMHWzc0oniQ2gTF+Vc26ha3uoGuwgqVLnuJU1IbjlRMR0pFN
         3QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJVd6ilonC+4OMmW2+o4T7v1/1aq86Xo3dE76W+Y2kU=;
        b=rvozG8ApFQwtHh4TasRL2dof3Y+UvBz2kVaTdlvx/vfSmGwWvqEupuvRe+T5PdYiC6
         42clIe0RU0sUrOSs9kdlJ5MPH1BSs4B9ysBr8Bp+P7Wy1vxp8bZo3KPqIb75PL+uqlVf
         Tozid6Prn/el0HhSErIr3i+7SDPcZ7H3e/bXTuEpF5UQgexbAbaIHBqwWw/YwgXK1CX5
         4X3Ck0LcM36y3XGNJyW4/x8CL3GOIU4DNaujjuie75/4y5WQCJeZD7tzScNuWJvlFPLh
         QUsVY8fwp3xa1L10Nr2IiYq131iuSXLHvX7szxUwckvCRAFPWVmRBvBBlgPGlnVxfKvH
         S/eQ==
X-Gm-Message-State: ANoB5plIs4ZfTrerlq/qfCP/7W5TJ7bkb3tzUJejQA0lDAcscznitHY/
        c/mNlVP4QRH3QPQ0WE0Ob6cwZd4mrWY=
X-Google-Smtp-Source: AA0mqf5GSHSlscP1p9KeaQfRLBSaMHCXcPyy+qmGf/imX/uqVkYrnzIAitCLaEdElMqYx4/Bz3AcFw==
X-Received: by 2002:a17:902:f283:b0:189:7d30:7623 with SMTP id k3-20020a170902f28300b001897d307623mr3180278plc.30.1670546382567;
        Thu, 08 Dec 2022 16:39:42 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm43525plh.66.2022.12.08.16.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:39:41 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:39:39 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Message-ID: <20221209003939.tsgkghhwznj44agl@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
 <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
 <33b0c075-3551-b57a-76e4-bc40452b3253@meta.com>
 <20221208035140.skuadnybf5aqb4o5@macbook-pro-6.dhcp.thefacebook.com>
 <4dc1def4-74a1-d1a6-386a-32e84962a55a@meta.com>
 <20221208125729.73qr3glbyd7p6buq@apollo>
 <20221208203654.zwwqxzjhx563d3z3@macbook-pro-6.dhcp.thefacebook.com>
 <3e6af95f-1d8b-aaf9-7e65-002b8fff19b6@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6af95f-1d8b-aaf9-7e65-002b8fff19b6@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 08, 2022 at 06:35:24PM -0500, Dave Marchevsky wrote:
> > 
> > Here is the proposal with one new field 'active_lock_id':
> > 
> > first = bpf_rbtree_first(root) KF_RET_NULL
> >   check_reg_allocation_locked() checks that root->reg->id == cur->active_lock.id
> >   R0 = PTR_TO_BTF_ID|MEM_ALLOC|PTR_MAYBE_NULL ref_obj_id = 0;
> >   R0->active_lock_id = root->reg->id
> >   R0->id = ++env->id_gen; which will be cleared after !NULL check inside prog.
> > 
> > same way we can add rb_find, rb_find_first,
> > but not rb_next, rb_prev, since they don't have 'root' argument.
> > 
> > bpf_rbtree_add(root, node, cb); KF_RELEASE.
> >   needs to see PTR_TO_BTF_ID|MEM_ALLOC node->ref_obj_id > 0
> >   check_reg_allocation_locked() checks that root->reg->id == cur->active_lock.id
> >   calls release_reference(node->ref_obj_id)
> >   converts 'node' to PTR_TO_BTF_ID|MEM_ALLOC ref_obj_id = 0;
> >   node->active_lock_id = root->reg->id
> > 
> > 'node' is equivalent to 'first'. They both point to some element
> > inside rbtree and valid inside spin_locked region.
> > It's ok to read|write to both under lock.
> > 
> > removed_node = bpf_rbtree_remove(root, node); KF_ACQUIRE|KF_RET_NULL
> >   need to see PTR_TO_BTF_ID|MEM_ALLOC node->ref_obj_id = 0; and 
> >   usual check_reg_allocation_locked(root)
> >   R0 = PTR_TO_BTF_ID|MEM_ALLOC|MAYBE_NULL
> >   R0->ref_obj_id = R0->id = acquire_reference_state();
> >   R0->active_lock_id should stay 0
> >   mark_reg_unknown(node)
> > 
> > bpf_spin_unlock(lock);
> >   checks lock->id == cur->active_lock.id
> >   for all regs in state 
> >     if (reg->active_lock_id == lock->id)
> >        mark_reg_unknown(reg)
> 
> OK, so sounds like a few more points of agreement, regardless of whether
> we go the runtime checking route or the other one:
> 
>   * We're tossing 'full untrusted' for now. non-owning references will not be
>     allowed to escape critical section. They'll be clobbered w/
>     mark_reg_unknown.

agree

>     * No pressing need to make bpf_obj_drop callable from critical section.
>       As a result no owning or non-owning ref access can page fault.

agree

> 
>   * When spin_lock is unlocked, verifier needs to know about all non-owning
>     references so that it can clobber them. Current implementation -
>     ref_obj_id + release_on_unlock - is bad for a number of reasons, should
>     be replaced with something that doesn't use ref_obj_id or reg->id.
>     * Specific better approach was proposed above: new field + keep track
>       of lock and datastructure identity.

yes

> 
> Differences in proposed approaches:
> 
> "Type System checks + invalidation on 'destructive' rbtree ops"
> 
>   * This approach tries to prevent aliasing problems by invalidating
>     non-owning refs after 'destructive' rbtree ops - like rbtree_remove -
>     in addition to invalidation on spin_unlock
> 
>   * Type system guarantees invariants:
>     * "if it's an owning ref, the node is guaranteed to not be in an rbtree"
>     * "if it's a non-owning ref, the node is guaranteed to be in an rbtree"
> 
>   * Downside: mass non-owning ref invalidation on rbtree_remove will make some
>     programs that logically don't have aliasing problem will be rejected by
>     verifier. Will affect usability depending on how bad this is.

yes.

> 
> 
> "Runtime checks + spin_unlock invalidation only"
> 
>   * This approach allows for the possibility of aliasing problem. As a result
>     the invariants guaranteed in point 2 above don't necessarily hold.
>     * Helpers that add or remove need to account for possibility that the node
>       they're operating on has already been added / removed. Need to check this
>       at runtime and nop if so.

Only 'remove' needs to check.
'add' is operating on 'owning ref'. It cannot fail.
Some future 'add_here(root, owning_node_to_add, nonowning_location)'
may need to fail.

> 
>   * non-owning refs are only invalidated on spin_unlock.
>     * As a result, usability issues of previous approach don't happen here.
> 
>   * Downside: Need to do runtime checks, some additional verifier complexity
>     to deal with "runtime check failed" case due to prev approach's invariant
>     not holding
> 
> Conversion of non-owning refs to 'untrusted' at a invalidation point (unlock
> or remove) can be added to either approach (maybe - at least it was specifically
> discussed for "runtime checks"). Such untrusted refs, by virtue of being
> PTR_UNTRUSTED, can fault, and aren't accepted by rbtree_{add, remove} as input.

correct.

> For the "type system" approach this might ameliorate some of the usability
> issues. For the "runtime checks" approach it would only be useful to let
> such refs escape spin_unlock.

the prog can do bpf_rdonly_cast() even after mark_unknown.

> But we're not going to do non-owning -> 'untrusted' for now, just listing for
> completeness.

right, because of bpf_rdonly_cast availability.

> The distance between what I have now and "type system" approach is smaller
> than "runtime checks" approach. And to get from "type system" to "runtime
> checks" I'd need to:
> 
>   * Remove 'destructive op' invalidation points
>   * Add runtime checks to rbtree_{add,remove}
>   * Add verifier handling of runtime check failure possibility
> 
> Of which only the first point is getting rid of something added for the
> "type system" approach, and won't be much work relative to all the refactoring
> and other improvements that are common between the two approaches.
> 
> So for V2 I will do the "type system + invalidation on 'destructive' ops"
> approach as it'll take less time. This'll get eyes on common improvements
> faster. Then can do a "runtime checks" v3 and we can compare usability of both
> on same base.

Sure, if you think cleanup on rbtree_remove is faster to implement
then definitely go for it.
I was imagining the other way around, but it's fine. Happy to be wrong.
I'm not seeing though how you gonna do that cleanup.
Another id-like field?
Before doing all coding could you post a proposal in the format that I did above?
imo it's much easier to think through in that form instead of analyzing the src code.
