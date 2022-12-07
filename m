Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2634A6464BE
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 00:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLGXGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 18:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLGXGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 18:06:07 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BE13E16
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 15:06:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 82so17758344pgc.0
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 15:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDEKu1JmN9s5S7YM6tgTX9WRBoiIFw3DLK/AbIPq4Ww=;
        b=Vhdo5s0NtGJseAfZ57hhkQFRU8YW8mPmqy/ltRCYNuwT4iGIsSuR+rxDcgQEDK2NgA
         vAgDhvGfQmHx5PLYyIPuZsaMokFy/QH5VY0ql6Sx811EGPVR5rsyMpJvafFHcMNj3hPb
         fOLagtwDj4FnBNBhBZQ+WyHWUU3XSvLJ0WIR39FQVqhnulxUjGVyjvECbP7XokEn52yl
         uGA3HtDdpIn6Ipp2PUqL6dddyPi9GVfpLvHCW2A/p+lS3wNWk9WQ5erMen37f+fujYzG
         jN0Qp6CxjrHv4ep/3o4nj7tTk6MWpVz1NNHB6ReOPOnLhIkCxztTnBuSb464DyrTAUyQ
         RQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDEKu1JmN9s5S7YM6tgTX9WRBoiIFw3DLK/AbIPq4Ww=;
        b=gUQ0J1gmN8Jp8BtmgWz5HN1zfqc98xvDSoUzMDqHD/+XI8iKAv0S58B2L74GXmkLYP
         W5OZvS3JcDRJ3GKAYpxKo9JERGdHlFWqSjpVr0XRIQBsrVhdc9Yfbz8iWW3aAqBNPOFO
         J4EvQBRHwdSOq8kkAha6zXjpYDAcdOcTupTdxGA+vvrPB1XXOtyjn6hTsJEMeGFgRcJ5
         x8NLCeuxglauTJGhfCgycCv62kEjYLEuyBqXmbT2Va+9VSvaivBo51w+9d0OaFiE1sX6
         xryIHPYhrhX+HZrGeZm8Dd2EYI1TGnm3Vb5qsa0D1hR7Epv+h74KfgICeohYH8vsp8Ia
         DxuA==
X-Gm-Message-State: ANoB5pnd+waglSnrAplaShuA2YJRCpY9tyWjFfXfbpHALN0PbK+lgcfu
        LVHHF9CUbAwbUw1TvSkzSDg=
X-Google-Smtp-Source: AA0mqf4OgKSwAizJQDDRLAuS4nIw+m8r/KU65uMqE/FWC3gNWWQQVGFS0vfn9C5m+mZzL0xDDPv2Fw==
X-Received: by 2002:a05:6a00:1caa:b0:575:e923:9181 with SMTP id y42-20020a056a001caa00b00575e9239181mr953335pfw.18.1670454365095;
        Wed, 07 Dec 2022 15:06:05 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id a5-20020aa795a5000000b0056bd1bf4243sm5384289pfk.53.2022.12.07.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:06:04 -0800 (PST)
Date:   Wed, 7 Dec 2022 15:06:02 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 00/13] BPF rbtree next-gen datastructure
Message-ID: <20221207230602.logjjjv3kwiiy6u3@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221207193616.y7n4lmufztjsq6tr@apollo>
 <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5756f37f-c61a-71e1-5559-e6e009b606d6@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 05:28:34PM -0500, Dave Marchevsky wrote:
> On 12/7/22 2:36 PM, Kumar Kartikeya Dwivedi wrote:
> > On Wed, Dec 07, 2022 at 04:39:47AM IST, Dave Marchevsky wrote:
> >> This series adds a rbtree datastructure following the "next-gen
> >> datastructure" precedent set by recently-added linked-list [0]. This is
> >> a reimplementation of previous rbtree RFC [1] to use kfunc + kptr
> >> instead of adding a new map type. This series adds a smaller set of API
> >> functions than that RFC - just the minimum needed to support current
> >> cgfifo example scheduler in ongoing sched_ext effort [2], namely:
> >>
> >>   bpf_rbtree_add
> >>   bpf_rbtree_remove
> >>   bpf_rbtree_first
> >>
> >> [...]
> >>
> >> Future work:
> >>   Enabling writes to release_on_unlock refs should be done before the
> >>   functionality of BPF rbtree can truly be considered complete.
> >>   Implementing this proved more complex than expected so it's been
> >>   pushed off to a future patch.
> >>
> 
> > 
> > TBH, I think we need to revisit whether there's a strong need for this. I would
> > even argue that we should simply make the release semantics of rbtree_add,
> > list_push helpers stronger and remove release_on_unlock logic entirely,
> > releasing the node immediately. I don't see why it is so critical to have read,
> > and more importantly, write access to nodes after losing their ownership. And
> > that too is only available until the lock is unlocked.
> > 
> 
> Moved the next paragraph here to ease reply, it was the last paragraph
> in your response.
> 
> > 
> > Can you elaborate on actual use cases where immediate release or not having
> > write support makes it hard or impossible to support a certain use case, so that
> > it is easier to understand the requirements and design things accordingly?
> >
> 
> Sure, the main usecase and impetus behind this for me is the sched_ext work
> Tejun and others are doing (https://lwn.net/Articles/916291/). One of the
> things they'd like to be able to do is implement a CFS-like scheduler using
> rbtree entirely in BPF. This would prove that sched_ext + BPF can be used to
> implement complicated scheduling logic.
> 
> If we can implement such complicated scheduling logic, but it has so much
> BPF-specific twisting of program logic that it's incomprehensible to scheduler
> folks, that's not great. The overlap between "BPF experts" and "scheduler
> experts" is small, and we want the latter group to be able to read BPF
> scheduling logic without too much struggle. Lower learning curve makes folks
> more likely to experiment with sched_ext.
> 
> When 'rbtree map' was in brainstorming / prototyping, non-owning reference
> semantics were called out as moving BPF datastructures closer to their kernel
> equivalents from a UX perspective.

Our emails crossed. See my previous email.
Agree on the above.

> If the "it makes BPF code better resemble normal kernel code" argumentwas the
> only reason to do this I wouldn't feel so strongly, but there are practical
> concerns as well:
> 
> If we could only read / write from rbtree node if it isn't in a tree, the common
> operation of "find this node and update its data" would require removing and
> re-adding it. For rbtree, these unnecessary remove and add operations could

Not really. See my previous email.

> result in unnecessary rebalancing. Going back to the sched_ext usecase,
> if we have a rbtree with task or cgroup stats that need to be updated often,
> unnecessary rebalancing would make this update slower than if non-owning refs
> allowed in-place read/write of node data.

Agree. Read/write from non-owning refs is necessary.
In the other email I'm arguing that PTR_TRUSTED with ref_obj_id == 0
(your non-owning ref) should not be mixed with release_on_unlock logic.

KF_RELEASE should still accept as args and release only ptrs with ref_obj_id > 0.

> 
> Also, we eventually want to be able to have a node that's part of both a
> list and rbtree. Likely adding such a node to both would require calling
> kfunc for adding to list, and separate kfunc call for adding to rbtree.
> Once the node has been added to list, we need some way to represent a reference
> to that node so that we can pass it to rbtree add kfunc. Sounds like a
> non-owning reference to me, albeit with different semantics than current
> release_on_unlock.

A node with both link list and rbtree would be a new concept.
We'd need to introduce 'struct bpf_refcnt' and make sure prog does the right thing.
That's a future discussion.

> 
> > I think this relaxed release logic and write support is the wrong direction to
> > take, as it has a direct bearing on what can be done with a node inside the
> > critical section. There's already the problem with not being able to do
> > bpf_obj_drop easily inside the critical section with this. That might be useful
> > for draining operations while holding the lock.
> > 
> 
> The bpf_obj_drop case is similar to your "can't pass non-owning reference
> to bpf_rbtree_remove" concern from patch 1's thread. If we have:
> 
>   n = bpf_obj_new(...); // n is owning ref
>   bpf_rbtree_add(&tree, &n->node); // n is non-owning ref

what I proposed in the other email...
n should be untrusted here.
That's != 'n is non-owning ref'

>   res = bpf_rbtree_first(&tree);
>   if (!res) {...}
>   m = container_of(res, struct node_data, node); // m is non-owning ref

agree. m == PTR_TRUSTED with ref_obj_id == 0.

>   res = bpf_rbtree_remove(&tree, &n->node);

a typo here? Did you mean 'm->node' ?

and after 'if (res)' ...
>   n = container_of(res, struct node_data, node); // n is owning ref, m points to same memory

agree. n -> ref_obj_id > 0

>   bpf_obj_drop(n);

above is ok to do.
'n' becomes UNTRUSTED or invalid.

>   // Not safe to use m anymore

'm' should have become UNTRUSTED after bpf_rbtree_remove.

> Datastructures which support bpf_obj_drop in the critical section can
> do same as my bpf_rbtree_remove suggestion: just invalidate all non-owning
> references after bpf_obj_drop.

'invalidate all' sounds suspicious.
I don't think we need to do sweaping search after bpf_obj_drop.

> Then there's no potential use-after-free.
> (For the above example, pretend bpf_rbtree_remove didn't already invalidate
> 'm', or that there's some other way to obtain non-owning ref to 'n''s node
> after rbtree_remove)
> 
> I think that, in practice, operations where the BPF program wants to remove
> / delete nodes will be distinct from operations where program just wants to 
> obtain some non-owning refs and do read / write. At least for sched_ext usecase
> this is true. So all the additional clobbers won't require program writer
> to do special workarounds to deal with verifier in the common case.
> 
> > Semantically in other languages, once you move an object, accessing it is
> > usually a bug, and in most of the cases it is sufficient to prepare it before
> > insertion. We are certainly in the same territory here with these APIs.
> 
> Sure, but 'add'/'remove' for these intrusive linked datastructures is
> _not_ a 'move'. Obscuring this from the user and forcing them to use
> less performant patterns for the sake of some verifier complexity, or desire
> to mimic semantics of languages w/o reference stability, doesn't make sense to
> me.

I agree, but everything we discuss in the above looks orthogonal
to release_on_unlock that myself and Kumar are proposing to drop.

> If we were to add some datastructures without reference stability, sure, let's
> not do non-owning references for those. So let's make this non-owning reference
> stuff easy to turn on/off, perhaps via KF_RELEASE_NON_OWN or similar flags,
> which will coincidentally make it very easy to remove if we later decide that
> the complexity isn't worth it. 

You mean KF_RELEASE_NON_OWN would be applied to bpf_rbtree_remove() ?
So it accepts PTR_TRUSTED ref_obj_id == 0 arg and makes it PTR_UNTRUSTED ?
If so then I agree. The 'release' part of the name was confusing.
It's also not clear which arg it applies to.
bpf_rbtree_remove has two args. Both are PTR_TRUSTED.
I wouldn't introduce a new flag for this just yet.
We can hard code bpf_rbtree_remove, bpf_list_pop for now
or use our name suffix hack.
