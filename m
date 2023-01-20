Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDCC674BCE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjATFIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjATFIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:08:15 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8FC28D3E
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:55:24 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4fd37a1551cso32575457b3.13
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzgl69tZy3NqlEHUdA1iMYThHKROrtfzchCmDz/ERb4=;
        b=A2IhXDtkDTdKGZdGLVmzo01g7PKiXFrqzGohFvx+qyR9SUycBXHrrCE7hihUAm2d9v
         eg0J56M/v8LRjrBAF1Vc0C1qEWNHFBcFis9R45KcggGWjEWTPPsg14fZjxUGkQ1T7AXS
         1wJ/NdoxI46oYRxVD7BtzmdxaW0zX/g1DpczdjeJT9IFK1qNpRFeLDzE5BjvqAMu9oaq
         bxGv/huQEHKipV/JqBvznv4O5W51r7c5pmiSKThHYn0dI6kjaabaFpwhkvIXAfo5VzOr
         mecVk53wv9dVBv3K9fZpAPvYv2Bctdj1OMnQj0Jb+Fr4eFge1GPD04wtqrJGebuu3/Fx
         uAjQ==
X-Gm-Message-State: AFqh2koUt2zO1jinKI95mJzK6BeSZ1EH6YFulqb5mIIEXqlOmJeKURwC
        WaE/iKMKLHoxERmCy9/Yn6aEPBoJHMnDImdq
X-Google-Smtp-Source: AMrXdXsR1qHGOK8/Y/rlaO4gFzdrBqTibJ+xRe94sySs7fbF1ADoA9gQFQBVX7E30Gr3WXnLIcvwyw==
X-Received: by 2002:ac8:5053:0:b0:3b6:3577:2fe7 with SMTP id h19-20020ac85053000000b003b635772fe7mr16710234qtm.49.1674189916173;
        Thu, 19 Jan 2023 20:45:16 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006fa4ac86bfbsm25223232qki.55.2023.01.19.20.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:45:15 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:45:19 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 13/13] bpf, documentation: Add graph
 documentation for non-owning refs
Message-ID: <Y8ocXyqUWMmUl4uB@maniforge.lan>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-14-davemarchevsky@fb.com>
 <Y6y0l30bFTK7KalE@maniforge.lan>
 <02b5f2ab-ed78-d006-f6b0-0f391c67ea5e@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b5f2ab-ed78-d006-f6b0-0f391c67ea5e@meta.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 09:16:00PM -0500, Dave Marchevsky wrote:
> On 12/28/22 4:26 PM, David Vernet wrote:
> > On Sat, Dec 17, 2022 at 12:25:06AM -0800, Dave Marchevsky wrote:
> >> It is difficult to intuit the semantics of owning and non-owning
> >> references from verifier code. In order to keep the high-level details
> >> from being lost in the mailing list, this patch adds documentation
> >> explaining semantics and details.
> >>
> >> The target audience of doc added in this patch is folks working on BPF
> >> internals, as there's focus on "what should the verifier do here". Via
> >> reorganization or copy-and-paste, much of the content can probably be
> >> repurposed for BPF program writer audience as well.
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > 
> > Hey Dave,
> > 
> > Thanks for writing this up. I left a few comments and suggestions as a
> > first pass. Feel free to push back on any of them.
> > 
> >> ---
> >>  Documentation/bpf/graph_ds_impl.rst | 208 ++++++++++++++++++++++++++++
> >>  Documentation/bpf/other.rst         |   3 +-
> >>  2 files changed, 210 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/bpf/graph_ds_impl.rst
> >>
> >> diff --git a/Documentation/bpf/graph_ds_impl.rst b/Documentation/bpf/graph_ds_impl.rst
> >> new file mode 100644
> >> index 000000000000..f92cbd223dc3
> >> --- /dev/null
> >> +++ b/Documentation/bpf/graph_ds_impl.rst
> >> @@ -0,0 +1,208 @@
> >> +=========================
> >> +BPF Graph Data Structures
> >> +=========================
> >> +
> >> +This document describes implementation details of new-style "graph" data
> >> +structures (linked_list, rbtree), with particular focus on verifier
> > 
> > s/with particular/with a particular
> > 
> 
> I'm no grammar expert, but based on my googling
> "with particular focus" is widely used in newspapers and other places
> where grammarians lurk.

I have no doubt whatsoever that people who write professionally know
better than I do, so yeah, I'm probably wrong and it's fine to leave it
as is.

> 
> >> +implementation of semantics particular to those data structures.
> > 
> > s/particular/specific
> > 
> > Just because we already use the word "particular" in the sentence?
> > 
> 
> Ack
> 
> > In general this sentence feels a bit difficult to parse. Wdyt about
> > this?
> > 
> > ...with a particular focus on how the verifier ensures that they are
> > properly and safely used by BPF programs.
> > 
> 
> Agreed in general, but re: your specific suggestion: "the verifier's
> implementation of semantics specific to those data structures" communicates
> that there are semantics specific to those data structures which required
> verifier changes. 
> 
> "ensures that they are properly and safely used by BPF programs" is more
> vague, but definitely easier to parse.
> 
> Will rewrite in some other way which is hopefully best of both worlds.

Yeah that's fair, feel free to keep the way you had it before if you
prefer that. Or reword it, up to you.

> 
> >> +
> >> +Note that the intent of this document is to describe the current state of
> >> +these graph data structures, **no guarantees** of stability for either
> > 
> > I think we can end the sentence in the middle here.
> > 
> > ...these graph data structures. **No guarantees**...
> 
> Ack
> 
> > 
> > Should we also add a sentence or two here about the intended audience
> > (people working on the verifier or readers who are interested in
> > learning more about BPF internals)?
> > 
> 
> Ack
> 
> >> +semantics or APIs are made or implied here.
> >> +
> >> +.. contents::
> >> +    :local:
> >> +    :depth: 2
> >> +
> >> +Introduction
> >> +------------
> >> +
> >> +The BPF map API has historically been the main way to expose data structures
> >> +of various types for use within BPF programs. Some data structures fit naturally
> >> +with the map API (HASH, ARRAY), others less so. Consequentially, programs
> > 
> > Would you mind please adding some details on why some data structures
> > don't fit naturally into the existing map APIs? I feel like that's kind
> > of the main focus of the article, so it would probably help to give some
> > high-level context up front.
> > 
> >> +interacting with the latter group of data structures can be hard to parse
> >> +for kernel programmers without previous BPF experience.
> > 
> > I'm not sure I quite follow how this latter point about data structures
> > being hard to parse is derived from the point about how some data
> > structures don't fit naturally with the map APIs. Maybe we should say
> > something like:
> > 
> > ..., others less so. Given that the API surface and behavioral semantics
> > are fundmentally different between these two classes of BPF data
> > structures, kernel programmers who are used to interacting with map-type
> > data structures may find these graph-type data structures to be
> > confusing or unfamiliar.
> > 
> > Wdyt?
> > 
> 
> The "Introduction" section is trying to make these points:
> 
>   * Data structures have historically been forced to adhere to the Map API
>   * Some data structures (linked list, rbtree) don't fit the Map API well
>   * For data stuctures that don't fit the Map API well, two problems would
>     arise if they were exposed as maps:
>     * "square peg / round hole" - in a vacuum, it'd be hard to make sense
>       of how Map API manipulates those data structures
>     * "Familiarity" - we're not in a vacuum, folks would prefer to write / read
>       code that interacts with these data structures in a "normal" kernel style
> 
> I will expand upon these, but FWIW the main point of this document is to explain
> why new verifier functionality is necessary to make Graph datastructures work,
> and what said new functionality does.
> 
> Explaining why map API is a bad fit is part of that, but I expect the reader to
> have some experience writing BPF programs which interact with maps, so I
> probably won't elaborate too much on the basics here. The sentence(s) added to
> satisfy your "intended audience" suggestion will say as much.
> 
> >> +
> >> +Luckily, some restrictions which necessitated the use of BPF map semantics are
> >> +no longer relevant. With the introduction of kfuncs, kptrs, and the any-context
> >> +BPF allocator, it is now possible to implement BPF data structures whose API
> >> +and semantics more closely match those exposed to the rest of the kernel.
> > 
> > Suggestion, I'd consider explicitly contrasting the map-type
> > implementation here with the graph-type implementation. What do you
> > think of something like this instead of the above paragraph:
> > 
> > BPF map-type data structures are defined as part of the UAPI in ``enum
> > bpf_map_type``, and are accessed and manipulated using BPF
> > :doc:`helpers`. The behaviors, backing memory, and implementations of
> > these map-type data structures are entirely encapsulated from BPF
> > programs, and mostly encapsulated from the verifier, by the helper
> > functions. The logic in the verifier for ensuring that map-type data
> > structures are correctly used therefore essentially amounts to
> > statically verifying that the helper functions that manipulate and
> > access the data structure are called correctly by the program, as
> > defined in the helper prototypes. The verifier then relies on the helper
> > to properly manipulate the backing data structure with its validated
> > arguments.
> >> BPF graph-type data structures, on the other hand, leverage more modern
> > features such as :doc:`kfuncs`, kptrs, and the any-context BPF
> > allocator. They allow BPF programs to manipulate the data structures
> > directly using APIs and semantics which more closely match those exposed
> > to code in the main kernel, with the verifier's job now being to ensure
> > that the programs are properly manipulating the data structures, rather
> > than relying on helper functions to properly manipulate the data
> > structures in the main kernel.
> > 
> 
> There's good info here, but I think it belongs in specific sections where
> new approach is discussed, not in introduction. For "intended audience" reasons
> touched on in my response above.

Sounds good.

> For "non-owning references section", I will add some paragraphs explaining why
> there's no equivalent concept for Map API. For other things you touched on (UAPI
> vs kptrs, prealloc vs any-context allocator, etc), I'll add other sections.

Thanks!

> 
> >> +
> >> +Two such data structures - linked_list and rbtree - have many verification
> >> +details in common. Because both have "root"s ("head" for linked_list) and
> >> +"node"s, the verifier code and this document refer to common functionality
> >> +as "graph_api", "graph_root", "graph_node", etc.
> > 
> > 
> > 
> >> +
> >> +Unless otherwise stated, examples and semantics below apply to both graph data
> >> +structures.
> >> +
> >> +Non-owning references
> >> +---------------------
> >> +
> >> +**Motivation**
> >> +
> >> +Consider the following BPF code:
> >> +
> >> +.. code-block:: c
> > 
> > You need an extra newline here or the docs build will complain:
> > 
> > bpf-next/Documentation/bpf/graph_ds_impl.rst:46: ERROR: Error in "code-block" directive:
> > maximum 1 argument(s) allowed, 9 supplied.
> > 
> > .. code-block:: c
> >         struct node_data *n = bpf_obj_new(typeof(*n)); /* BEFORE */
> > 
> >         bpf_spin_lock(&lock);
> > 
> >         bpf_rbtree_add(&tree, n); /* AFTER */
> > 
> >         bpf_spin_unlock(&lock);
> > 
> 
> Ack
> 
> >> +        struct node_data *n = bpf_obj_new(typeof(*n)); /* BEFORE */
> >> +
> >> +        bpf_spin_lock(&lock);
> >> +
> >> +        bpf_rbtree_add(&tree, n); /* AFTER */
> >> +
> >> +        bpf_spin_unlock(&lock);
> > 
> > Also need a newline here or sphinx will get confused and think the
> > vertical line is part of the code block.
> > 
> 
> Ack, all sphinx build errors / warnings for this doc have been fixed.
> 
> >> +----
> >> +
> >> +From the verifier's perspective, after bpf_obj_new ``n`` has type
> >> +``PTR_TO_BTF_ID | MEM_ALLOC`` with btf_id of ``struct node_data`` and a
> >> +nonzero ``ref_obj_id``. Because it holds ``n``, the program has ownership
> > 
> > I had to read this first sentence a few times to parse it, maybe due to
> > a missing comma between "after bpf_obj_new" and "``n`` has type...".
> > What do you think about this wording?
> > 
> > From the verifier's perspective, the pointer ``n`` returned from
> > ``bpf_obj_new`` has type ``PTR_TO_BTF_ID | MEM_ALLOC``, with a `btf_id`
> > of ``struct node_data``, and a nonzero ``ref_obj_id``.
> > 
> 
> Ack, your wording is better.
> 
> >> +of the pointee's lifetime (object pointed to by ``n``). The BPF program must
> > 
> > Should we move (object pointed to by ``n``) to be directly after
> > "pointee's" / before "lifetime"? Otherwise it reads kind of odd given
> > that "lifetime" is really the indirect object in the sentence.
> > 
> 
> Ack.
> 
> >> +pass off ownership before exiting - either via ``bpf_obj_drop``, which free's
> > 
> > s/free's/frees
> > 
> 
> I did ``free``'s and ``free``'d instead of these suggested changes. Want to make
> it obvious that the action taken is equivalent to free() from malloc API.
> 
> >> +the object, or by adding it to ``tree`` with ``bpf_rbtree_add``.
> >> +
> >> +(``BEFORE`` and ``AFTER`` comments in the example denote beginning of "before
> >> +ownership is passed" and "after ownership is passed")
> > 
> > Should we use something like ACQUIRED / PASSED / RELEASED instead of
> > BEFORE / AFTER?
> > 
> 
> Ack. None of the code samples need RELEASED comment yet, but this scheme is
> easier to follow regardless.
> 
> >> +
> >> +What should the verifier do with ``n`` after ownership is passed off? If the
> >> +object was free'd with ``bpf_obj_drop`` the answer is obvious: the verifier
> > 
> > s/free'd/freed
> > 
> >> +should reject programs which attempt to access ``n`` after ``bpf_obj_drop`` as
> >> +the object is no longer valid. The underlying memory may have been reused for
> >> +some other allocation, unmapped, etc.
> >> +
> >> +When ownership is passed to ``tree`` via ``bpf_rbtree_add`` the answer is less
> >> +obvious. The verifier could enforce the same semantics as for ``bpf_obj_drop``,
> >> +but that would result in programs with useful, common coding patterns being
> >> +rejected, e.g.:
> >> +
> >> +.. code-block:: c
> > 
> > Same here (newline)
> > 
> >> +        int x;
> >> +        struct node_data *n = bpf_obj_new(typeof(*n)); /* BEFORE */
> >> +
> >> +        bpf_spin_lock(&lock);
> >> +
> >> +        bpf_rbtree_add(&tree, n); /* AFTER */
> >> +        x = n->data;
> >> +        n->data = 42;
> >> +
> >> +        bpf_spin_unlock(&lock);
> > 
> > Same here (newline)
> > 
> >> +----
> >> +
> >> +Both the read from and write to ``n->data`` would be rejected. The verifier
> >> +can do better, though, by taking advantage of two details:
> >> +
> >> +  * Graph data structure APIs can only be used when the ``bpf_spin_lock``
> >> +    associated with the graph root is held
> > 
> > I'd consider giving a bit more background information on this somewhere
> > above. This is the first time we've mentioned anything about a lock, so
> > it might be worth it to give some context on how these graph-type maps
> > are defined and initialized.
> > 
> > I realize we could be approaching "useful even to people who aren't
> > working on the verifier" territory if we go into too much detail, but I
> > also think it's important to give backround context on this stuff
> > regardless of the intended audience in order for the documentation to
> > really be useful.
> > 
> 
> Agreed, this document is missing important background information about
> spin_locks + Graph Datastructures.
> 
> >> +  * Both graph data structures have pointer stability
> > 
> > You also need a newline between nested list entries or sphinx will get
> > confused. My suggestion would be to just always have a newline between
> > list entries (applies elsewhere in the file as well).
> > 
> 
> Ack. Apparently I needed three spaces to trigger the next nesting level (had
> two). After doing that, it was obvious why your "always have a newline"
> suggestion is good.
> 
> >> +    * Because graph nodes are allocated with ``bpf_obj_new`` and
> >> +      adding / removing from the root involves fiddling with the
> >> +      ``bpf_{list,rb}_node`` field of the node struct, a graph node will
> >> +      remain at the same address after either operation.
> >> +
> >> +Because the associated ``bpf_spin_lock`` must be held by any program adding
> >> +or removing, if we're in the critical section bounded by that lock, we know
> >> +that no other program can add or remove until the end of the critical section.
> >> +This combined with pointer stability means that, until the critical section
> >> +ends, we can safely access the graph node through ``n`` even after it was used
> >> +to pass ownership.
> >> +
> >> +The verifier considers such a reference a *non-owning reference*. The ref
> >> +returned by ``bpf_obj_new`` is accordingly considered an *owning reference*.
> >> +Both terms currently only have meaning in the context of graph nodes and API.
> >> +
> >> +**Details**
> >> +
> >> +Let's enumerate the properties of both types of references.
> >> +
> >> +*owning reference*
> >> +
> >> +  * This reference controls the lifetime of the pointee
> >> +  * Ownership of pointee must be 'released' by passing it to some graph API
> >> +    kfunc, or via ``bpf_obj_drop``, which free's the pointee
> > 
> > s/free's/frees. "Frees" is a verb, "free's" is a possessive.
> > 
> >> +    * If not released before program ends, verifier considers program invalid
> >> +  * Access to the pointee's memory will not page fault
> >> +
> >> +*non-owning reference*
> >> +
> >> +  * This reference does not own the pointee
> >> +    * It cannot be used to add the graph node to a graph root, nor free via
> >> +      ``bpf_obj_drop``
> >> +  * No explicit control of lifetime, but can infer valid lifetime based on
> >> +    non-owning ref existence (see explanation below)
> >> +  * Access to the pointee's memory will not page fault
> > 
> > I'd consider defining references, or at least giving some high-level
> > description of how they work, somewhere a bit earlier in the page. The
> > "Non-owning references" section kind of just jumps right into examples
> > of what the verifier allows without describing the concept at a higher
> > level, so readers will have a difficult time applying what they're
> > reading to the examples being provided.
> > 
> >> +
> >> +From verifier's perspective non-owning references can only exist
> >> +between spin_lock and spin_unlock. Why? After spin_unlock another program
> >> +can do arbitrary operations on the data structure like removing and free-ing
> > 
> > s/free-ing/freeing
> > 
> >> +via bpf_obj_drop. A non-owning ref to some chunk of memory that was remove'd,
> > 
> > s/remove'd/removed
> 
> Similarly to ``free``'d, 'remove' here is referring to a specific function, so
> did ``remove``'d instead.
> 
> > 
> > I'll stop pointing these out for now, they apply throughout the page.
> > 
> >> +free'd, and reused via bpf_obj_new would point to an entirely different thing.
> >> +Or the memory could go away.
> >> +
> >> +To prevent this logic violation all non-owning references are invalidated by
> >> +verifier after critical section ends. This is necessary to ensure "will
> > 
> > - s/by verifier/by the verifier
> > - s/after critical section/after a critical section
> > - s/to ensure "will not"/to ensure a "will not"
> > 
> > 
> 
> Ack, except s/to ensure "will not"/to ensure the "will not"
> 
> >> +not page fault" property of non-owning reference. So if verifier hasn't
> > 
> > - s/of non-owning/of the non-owning
> > - s/So if verifier/So if the verifier
> > 
> 
> Ack, except s/of non-owning reference/of non-owning references
> 
> >> +invalidated a non-owning ref, accessing it will not page fault.
> >> +
> >> +Currently ``bpf_obj_drop`` is not allowed in the critical section, so
> >> +if there's a valid non-owning ref, we must be in critical section, and can
> > 
> > s/in critical section/in a critical section
> > 
> 
> Ack
> 
> >> +conclude that the ref's memory hasn't been dropped-and-free'd or dropped-
> >> +and-reused.
> > 
> > If you split the line like this, it will render as "dropped-and- reused".
> > 
> 
> Ack
> 
> >> +
> >> +Any reference to a node that is in a rbtree _must_ be non-owning, since
> > 
> > s/a rbtree/an rbtree
> > 
> 
> TIL, ack.
> 
> >> +the tree has control of pointee lifetime. Similarly, any ref to a node
> > 
> > s/of pointee lifetime/of the pointee's lifetime
> > 
> 
> ack
> 
> >> +that isn't in rbtree _must_ be owning. This results in a nice property:
> > 
> > s/in rbtree/in an rbtree
> > 
> 
> ack
> 
> >> +graph API add / remove implementations don't need to check if a node
> >> +has already been added (or already removed), as the verifier type system
> >> +prevents such a state from being valid.
> > 
> > I feel like "verifier type system" isn't quite accurate here, though I
> > may be wrong. When I think of something like "verifier type system" I'm
> > more envisioning how the verifier ensures that the correct BTF IDs are
> > passed. In this case, it's really the BPF graph-object ownership model
> > that's ensuring that the state is valid, right?
> > 
> 
> I mean "type system" here in the PL / language runtime sense. Although the
> verifier doesn't execute the code at runtime, at verification time it augments
> the raw BPF bytecode with type information (BTF or type inferred from attach
> context) and does some execution-like things with the program, including
> complaining if some function expects type X but gets type Y as input.
> 
> In this case "owning reference" and "non-owning reference" are distinct types
> (owning has nonzero ref_obj_id) and the verifier rejects wrong type for kfunc
> input based on this info alone. "graph-object ownership model" is responsible
> for changing refs of one type to another.
> 
> Regardless, your broader point stands - "verifier type system" isn't commonly
> used to describe this behavior, so I should phrase this better.

Thanks for explaining. That all makes sense, but yeah, might be worth
tinkering with the wording a bit just to avoid future confusion for
others.

> 
> >> +
> >> +However, pointer aliasing poses an issue for the above "nice property".
> >> +Consider the following example:
> >> +
> >> +.. code-block:: c
> > 
> > Same here (newline)
> > 
> >> +        struct node_data *n, *m, *o, *p;
> >> +        n = bpf_obj_new(typeof(*n));     /* 1 */
> >> +
> >> +        bpf_spin_lock(&lock);
> >> +
> >> +        bpf_rbtree_add(&tree, n);        /* 2 */
> >> +        m = bpf_rbtree_first(&tree);     /* 3 */
> >> +
> >> +        o = bpf_rbtree_remove(&tree, n); /* 4 */
> >> +        p = bpf_rbtree_remove(&tree, m); /* 5 */
> >> +
> >> +        bpf_spin_unlock(&lock);
> >> +
> >> +        bpf_obj_drop(o);
> >> +        bpf_obj_drop(p); /* 6 */
> > 
> > Same here (newline)
> > 
> >> +----
> >> +
> >> +Assume tree is empty before this program runs. If we track verifier state
> > 
> > s/Assume tree,/Assume the tree
> > 
> 
> ack
> 
> >> +changes here using numbers in above comments:
> >> +
> >> +  1) n is an owning reference
> >> +  2) n is a non-owning reference, it's been added to the tree
> >> +  3) n and m are non-owning references, they both point to the same node
> >> +  4) o is an owning reference, n and m non-owning, all point to same node
> >> +  5) o and p are owning, n and m non-owning, all point to the same node
> >> +  6) a double-free has occurred, since o and p point to same node and o was
> >> +     free'd in previous statement
> >> +
> >> +States 4 and 5 violate our "nice property", as there are non-owning refs to
> >> +a node which is not in a rbtree. Statement 5 will try to remove a node which
> >> +has already been removed as a result of this violation. State 6 is a dangerous
> >> +double-free.
> >> +
> >> +At a minimum we should prevent state 6 from being possible. If we can't also
> >> +prevent state 5 then we must abandon our "nice property" and check whether a
> >> +node has already been removed at runtime.
> >> +
> >> +We prevent both by generalizing the "invalidate non-owning references" behavior
> >> +of ``bpf_spin_unlock`` and doing similar invalidation after
> >> +``bpf_rbtree_remove``. The logic here being that any graph API kfunc which:
> >> +
> >> +  * takes an arbitrary node argument
> >> +  * removes it from the datastructure
> >> +  * returns an owning reference to the removed node
> >> +
> >> +May result in a state where some other non-owning reference points to the same
> >> +node. So ``remove``-type kfuncs must be considered a non-owning reference
> >> +invalidation point as well.
> > 
> > Could you please also add the new kfunc flags that signal this to
> > Documentation/bpf/kfuncs.rst?
> > 
> 
> ack
> 
> >> diff --git a/Documentation/bpf/other.rst b/Documentation/bpf/other.rst
> >> index 3d61963403b4..7e6b12018802 100644
> >> --- a/Documentation/bpf/other.rst
> >> +++ b/Documentation/bpf/other.rst
> >> @@ -6,4 +6,5 @@ Other
> >>     :maxdepth: 1
> >>  
> >>     ringbuf
> >> -   llvm_reloc
> >> \ No newline at end of file
> >> +   llvm_reloc
> >> +   graph_ds_impl
> >> -- 
> >> 2.30.2
> >>
