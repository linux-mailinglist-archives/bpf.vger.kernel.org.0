Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD05883D9
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiHBWCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 18:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiHBWCU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 18:02:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67C83ED4D
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 15:02:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r4so11556211edi.8
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=IOKp7j5RdeLWCFlagh2P08KKgE0rajw729gyquDZJwk=;
        b=VQ4XUe+kAZEDrj87dG//ge8KnW/dPmMQ1aHeqRbmaexUZmR5PWBEoGx3YiVNd5EoAE
         wwBQ/SUdRCAoTw6g2KAaQpdlwLM/xF0YDEsh+x1MfaahAW+THUm0E328NQcJZJMdZGne
         UEEtPAb10LjnhN+Of9Q/ZcLnnTYGwndtngivRwQlYhpziWApF9BbISAxS8sFpBS17WA0
         KSiBxeaHf8LnWwRmauRI9AQG0SseYhJum3yY5AKOE/kJAeHmAO4aTloKIRARRLuNpfIa
         6RG3hpocbi+FmwK4D1S6nnrkeueeNxd8q7hcpKWJ3+eOUgCxLwPvtxBqaI9rQWbKlHnE
         qu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=IOKp7j5RdeLWCFlagh2P08KKgE0rajw729gyquDZJwk=;
        b=4BUcweL6wqvcT1MuWyWg7sF+LPpbscogKPd+NxhorGwaIaflfNPj7QnDDWGG871aTp
         yOVUmxgqbr1leQcSldwqupbxdbLx+3NvfBasKR5zALilaqZrQnqSojFShsdRuNSq12UV
         OMJANNaJgqNYZGLv4+GMYaWqNfMX46vnfV2ED5th6Cmb0XuD+6wOUCP4lD2IpfUXdqrf
         O3RsYRdtBpnDdLnwgyAu29cNlIFRWDNREePklv4PUbxV3YPRmzQPivLI0YSxrDsYE9HF
         kuOWKv+m+C8QbaU/F1hT6sPKrjwuzOJVH965MdnMmncwCBFaVC0Q4Z4inCPt3nyoBVU1
         l/Hg==
X-Gm-Message-State: ACgBeo2hfpgGuncNaAzUwnV1cZF80BFsI+IG4H5L/cxNWlLlBewXOWWT
        igLpFgzuT9TWMbJr62HYz/Ymsrlj/WntFn+p3og=
X-Google-Smtp-Source: AA6agR7xuPlvpcJCx1QEp/OFZ/GvWtecJTxhFXXFbQrZGaxm8nFmuy4jRp6PzWmCxzv/V6p/keskSUZvTpK1ioNbd7k=
X-Received: by 2002:aa7:de18:0:b0:43d:30e2:d22b with SMTP id
 h24-20020aa7de18000000b0043d30e2d22bmr20387842edv.224.1659477737220; Tue, 02
 Aug 2022 15:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Aug 2022 15:02:05 -0700
Message-ID: <CAEf4BzZC=RQfWedkX7L=-nAsWNrX8+Lz8_RWeOeY4ROQP26UJA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/11] bpf: Introduce rbtree map
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 11:34 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Introduce bpf_rbtree map data structure. As the name implies, rbtree map
> allows bpf programs to use red-black trees similarly to kernel code.
> Programs interact with rbtree maps in a much more open-coded way than
> more classic map implementations. Some example code to demonstrate:
>
>   node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
>   if (!node)
>     return 0;
>
>   node->one = calls;
>   node->two = 6;
>   bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
>
>   ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
>   if (!ret) {
>     bpf_rbtree_free_node(&rbtree, node);
>     goto unlock_ret;
>   }
>
> unlock_ret:
>   bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>   return 0;
>
>
> This series is in a heavy RFC state, with some added verifier semantics
> needing improvement before they can be considered safe. I am sending
> early to gather feedback on approach:
>
>   * Does the API seem reasonable and might it be useful for others?
>
>   * Do new verifier semantics added in this series make logical sense?
>     Are there any glaring safety holes aside from those called out in
>     individual patches?
>
> Please see individual patches for more in-depth explanation. A quick
> summary of patches follows:
>
>
> Patches 1-3 extend verifier and BTF searching logic in minor ways to
> prepare for rbtree implementation patch.
>   bpf: Pull repeated reg access bounds check into helper fn
>   bpf: Add verifier support for custom callback return range
>   bpf: Add rb_node_off to bpf_map
>
>
> Patch 4 adds basic rbtree map implementation.
>   bpf: Add rbtree map
>
> Note that 'complete' implementation requires concepts and changes
> introduced in further patches in the series. The series is currently
> arranged in this way to ease RFC review.
>
>
> Patches 5-7 add a spinlock to the rbtree map, with some differing
> semantics from existing verifier spinlock handling.
>   bpf: Add bpf_spin_lock member to rbtree
>   bpf: Add bpf_rbtree_{lock,unlock} helpers
>   bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
>
> Notably, rbtree's bpf_spin_lock must be held while manipulating the tree
> via helpers, while existing spinlock verifier logic prevents any helper
> calls while lock is held. In current state this is worked around by not
> having the verifier treat rbtree's lock specially in any way. This
> needs to be improved before leaving RFC state as it's unsafe.
>
>
> Patch 8 adds the concept of non-owning references, firming up the
> semantics of helpers that return a ptr to node which is owned by
> a rbtree. See patch 4's summary for additional discussion of node
> ownership.
>
>
> Patch 9 adds a 'conditional release' concept: helpers which release a
> resource, but may fail to do so and need to enforce that the BPF program
> handles this failure appropriately, namely by freeing the resource
> another way.
>
>
> Path 10 adds 'iter' type flags which teach the verifier to understand
> open-coded iteration of a data structure. Specifically, with such flags
> the verifier can understand that this loop eventually ends:
>
>   struct node_data *iter = (struct node_data *)bpf_rbtree_first(&rbtree);
>
>   while (iter) {
>     node_ct++;
>     iter = (struct node_data *)bpf_rbtree_next(&rbtree, iter);
>   }
>
> NOTE: Patch 10's logic is currently very unsafe and it's unclear whether
> there's a safe path forward that isn't too complex. It's the most RFC-ey
> of all the patches.
>
>
> Patch 11 adds tests. Best to start here to see BPF programs using rbtree
> map as intended.
>
>
> This series is based ontop of "bpf: Cleanup check_refcount_ok" patch,
> which was submitted separately [0] and therefore is not included here. That
> patch is likely to be applied before this is out of RFC state, so will
> just rebase on newer bpf-next/master.
>
>   [0]: lore.kernel.org/bpf/20220719215536.2787530-1-davemarchevsky@fb.com/
>
> Dave Marchevsky (11):
>   bpf: Pull repeated reg access bounds check into helper fn
>   bpf: Add verifier support for custom callback return range
>   bpf: Add rb_node_off to bpf_map
>   bpf: Add rbtree map
>   bpf: Add bpf_spin_lock member to rbtree
>   bpf: Add bpf_rbtree_{lock,unlock} helpers
>   bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
>   bpf: Add OBJ_NON_OWNING_REF type flag
>   bpf: Add CONDITIONAL_RELEASE type flag
>   bpf: Introduce PTR_ITER and PTR_ITER_END type flags
>   selftests/bpf: Add rbtree map tests
>
>  include/linux/bpf.h                           |  13 +
>  include/linux/bpf_types.h                     |   1 +
>  include/linux/bpf_verifier.h                  |   2 +
>  include/linux/btf.h                           |   1 +
>  include/uapi/linux/bpf.h                      | 121 ++++++
>  kernel/bpf/Makefile                           |   2 +-
>  kernel/bpf/btf.c                              |  21 +
>  kernel/bpf/helpers.c                          |  42 +-
>  kernel/bpf/rbtree.c                           | 401 ++++++++++++++++++
>  kernel/bpf/syscall.c                          |   3 +
>  kernel/bpf/verifier.c                         | 382 +++++++++++++++--
>  tools/include/uapi/linux/bpf.h                | 121 ++++++
>  .../selftests/bpf/prog_tests/rbtree_map.c     | 164 +++++++
>  .../testing/selftests/bpf/progs/rbtree_map.c  | 108 +++++
>  .../selftests/bpf/progs/rbtree_map_fail.c     | 236 +++++++++++
>  .../bpf/progs/rbtree_map_load_fail.c          |  24 ++
>  16 files changed, 1605 insertions(+), 37 deletions(-)
>  create mode 100644 kernel/bpf/rbtree.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_fail.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
>
> --
> 2.30.2
>

I just skimmed through commit descriptions and wanted to ask few questions.

1. It's not exactly clear from descriptions what are the advantages of
having struct node_data data vs sticking to more typical BPF map
interface with bpf_map_lookup_elem() and so on. Am I right that the
biggest advantage is that we can move node from one RB tree to
another? But if that's the only reason, why can't we have a
specialized bpf_rbtree_move(rb1, rb2, value) (where rb1 and rb2 are
trees involved in a move, and value is whatever is returned by
bpf_map_lookup_elem, which internally will also keep rbtree_node
hidden in front of value pointer, just like we do it with ringbuf).

2. As for rbtree node pre-allocated in more permissive mode and then
inserting into RB tree later on in more restrictive (e.g., NMI) mode.
Wouldn't this problem be mostly solved by Alexei's BPF-specific memory
allocator? And right now you are requiring to insert in the same mode
as when node was allocated (or free it), right? That's just a current
limitation and you are planning to lift this restriction? If yes, what
would be the mechanism to "temporarily" store rbtree_node somewhere?
kptr? dynptr? In both cases not exactly clear how type information is
preserved.

3. As for locking. Assuming we add bpf_rbtree_move_node() helper, you
can pass lock as an argument to it instead of storing lock inside the
RB tree itself. Preventing deadlocks and stuff like that is still hard
and tricky, but at least you won't have to worry about storing locks
inside RB trees themselves.


Just some questions that I still remember from a brief reading of
this. I think it would be extremely helpful for me and others to have
a clear "why we need open-coded rbtree_node approach" question
answered with comparison to possible alternative using a bit more
conventional BPF approach.

Overall, I'm still trying to wrap my head around this, this approach
and stated goals (e.g., moving nodes between two trees, all the
locking story, etc) look very complicated, so will take some time to
internalize this new approach and convince myself it's doable.
