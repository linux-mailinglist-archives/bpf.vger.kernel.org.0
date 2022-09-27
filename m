Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A515EB895
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 05:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiI0DVX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiI0DUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 23:20:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBF83BC0
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 20:18:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r18so17939003eja.11
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 20:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CWlSkEAKOt3CjBH1gb42Gn/ILQzE4rDyMFp8HMJEEAw=;
        b=loYZj2zvDp4NCOvbSGj+kFjut/qPA/x/LZQwUlo+Rkob/6xtmQcEChda7veKNd+kOi
         wgnq7/5bv4w4A+f/0eegRUF1Ex3Rsbe44ov2+HL5tf1xTMHsjgPAk+EljUHV5cAnlpRt
         w1I3g19YnJQx6CTPCaOo7CfWLQXcR520ll69/mUaUczZbK43ppcsVifb2++Mt/0Gr/yz
         dqUbPW839jeVo+rLf50Psi+9PFObepR/v9PgtLmT2voSQpRUsdH6EZcv3KI0qqm0ORZX
         BDQ8Vz0Dlm2ZXNOj4D6JLqkDmV8G4wdqSLJscvICgSoS6FSyaIGO+paFkN42LAc2qknB
         QBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CWlSkEAKOt3CjBH1gb42Gn/ILQzE4rDyMFp8HMJEEAw=;
        b=4VUaR02zCj/NaoCR/0aJNkRjifiuAXs5TPKFFkTx8+lAP2kiDWLGpx/bc6QikrJoj0
         isJI3+CYQCuaLalCtP2f5U4MBItRPlG4emnA1v6REaIloiRJgdpgRSBHoQNIWu3X3BO5
         SadhB54GIPmec1rm51yIoVdDie/2bY86WDJiF1tLPCQHd9QZl4BlMi+RwRaXqTV0K+IN
         CCr2UheFF0Ic4OUtbY1wtCGwbYhONA/OCGC93dSgSJwPq0jXCJwzpvu2UWJ3th5Fcu97
         R8AM12s4VRFVU2oVDTVImV+N0mCv301MeVilSyReB2ZjpNM1/nxuauBlBcry0gpzV2T8
         NYqQ==
X-Gm-Message-State: ACrzQf0ay63G61J3cS9Q0qh0hzOGHxVQfM0J+eBiF/C8Tp8C0UWMdhVD
        +8if7mD3p57m6RDOKmhqGCrxBhD0sPs7se1ls6o=
X-Google-Smtp-Source: AMsMyM5pSM5TQq+M+vhBtgzK0uc5Ml3XDeFGY7jTkWbCtIT8TYD+f5k1ggDLPPrkUn/VlCs4hCVPtGUtASr6jC1Dhdw=
X-Received: by 2002:a17:906:3a15:b0:73d:80bf:542c with SMTP id
 z21-20020a1709063a1500b0073d80bf542cmr21392425eje.633.1664248698542; Mon, 26
 Sep 2022 20:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local> <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com> <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
In-Reply-To: <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 26 Sep 2022 20:18:07 -0700
Message-ID: <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Hou Tao <houtao1@huawei.com>
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

On Mon, Sep 26, 2022 at 8:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 9/27/2022 9:19 AM, Alexei Starovoitov wrote:
> > On Mon, Sep 26, 2022 at 09:18:46PM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 9/26/2022 9:25 AM, Alexei Starovoitov wrote:
> >>> On Sat, Sep 24, 2022 at 09:36:07PM +0800, Hou Tao wrote:
> >>>> From: Hou Tao <houtao1@huawei.com>
> >> SNIP
> >>>> For atomic ops and kmalloc overhead, I think I can reuse the idea from
> >>>> patchset "bpf: BPF specific memory allocator". I have given bpf_mem_alloc
> >>>> a simple try and encounter some problems. One problem is that
> >>>> immediate reuse of freed object in bpf memory allocator. Because qp-trie
> >>>> uses bpf memory allocator to allocate and free qp_trie_branch, if
> >>>> qp_trie_branch is reused immediately, the lookup procedure may oops due
> >>>> to the incorrect content in qp_trie_branch. And another problem is the
> >>>> size limitation in bpf_mem_alloc() is 4096. It may be a little small for
> >>>> the total size of key size and value size, but maybe I can use two
> >>>> separated bpf_mem_alloc for key and value.
> >>> 4096 limit for key+value size would be an acceptable trade-off.
> >>> With kptrs the user will be able to extend value to much bigger sizes
> >>> while doing <= 4096 allocation at a time. Larger allocations are failing
> >>> in production more often than not. Any algorithm relying on successful
> >>>  >= 4096 allocation is likely to fail. kvmalloc is a fallback that
> >>> the kernel is using, but we're not there yet in bpf land.
> >>> The benefits of bpf_mem_alloc in qp-trie would be huge though.
> >>> qp-trie would work in all contexts including sleepable progs.
> >>> As presented the use cases for qp-trie are quite limited.
> >>> If I understand correctly the concern for not using bpf_mem_alloc
> >>> is that qp_trie_branch can be reused. Can you provide an exact scenario
> >>> that will casue issuses?
> >> The usage of branch node during lookup is as follows:
> >> (1) check the index field of branch node which records the position of nibble in
> >> which the keys of child nodes are different
> >> (2) calculate the index of child node by using the nibble value of lookup key in
> >> index position
> >> (3) get the pointer of child node by dereferencing the variable-length pointer
> >> array in branch node
> >>
> >> Because both branch node and leaf node have variable length, I used one
> >> bpf_mem_alloc for these two node types, so if a leaf node is reused as a branch
> >> node, the pointer got in step 3 may be invalid.
> >>
> >> If using separated bpf_mem_alloc for branch node and leaf node, it may still be
> >> problematic because the updates to a reused branch node are not atomic and
> >> branch nodes with different child node will reuse the same object due to size
> >> alignment in allocator, so the lookup procedure below may get an uninitialized
> >> pointer in the pointer array:
> >>
> >> lookup procedure                                update procedure
> >>
> >>
> >> // three child nodes, 48-bytes
> >> branch node x
> >>                                                               //  four child
> >> nodes, 56-bytes
> >>                                                               reuse branch node x
> >>                                                               x->bitmap = 0xf
> >> // got an uninitialized pointer
> >> x->nodes[3]
> >>                                                               Initialize
> >> x->nodes[0~3]
> > Looking at lookup:
> > +     while (is_branch_node(node)) {
> > +             struct qp_trie_branch *br = node;
> > +             unsigned int bitmap;
> > +             unsigned int iip;
> > +
> > +             /* When byte index equals with key len, the target key
> > +              * may be in twigs->nodes[0].
> > +              */
> > +             if (index_to_byte_index(br->index) > data_len)
> > +                     goto done;
> > +
> > +             bitmap = calc_br_bitmap(br->index, data, data_len);
> > +             if (!(bitmap & br->bitmap))
> > +                     goto done;
> > +
> > +             iip = calc_twig_index(br->bitmap, bitmap);
> > +             node = rcu_dereference_check(br->nodes[iip], rcu_read_lock_bh_held());
> > +     }
> >
> > To be safe the br->index needs to be initialized after br->nodex and br->bitmap.
> > While deleting the br->index can be set to special value which would mean
> > restart the lookup from the beginning.
> > As you're suggesting with smp_rmb/wmb pairs the lookup will only see valid br.
> > Also the race is extremely tight, right?
> > After brb->nodes[iip] + is_branch_node that memory needs to deleted on other cpu
> > after spin_lock and reused in update after another spin_lock.
> > Without artifical big delay it's hard to imagine how nodes[iip] pointer
> > would be initialized to some other qp_trie_branch or leaf during delete,
> > then memory reused and nodes[iip] is initialized again with the same address.
> > Theoretically possible, but unlikely, right?
> > And with correct ordering of scrubbing and updates to
> > br->nodes, br->bitmap, br->index it can be made safe.
> The reuse of node not only introduces the safety problem (e.g. access an invalid
> pointer), but also incur the false negative problem (e.g. can not find an
> existent element) as show below:
>
> lookup A in X on CPU1            update X on CPU 2
>
>      [ branch X v1 ]
>  leaf A | leaf B | leaf C
>                                                  [ branch X v2 ]
>                                                leaf A | leaf B | leaf C | leaf D
>
>                                                   // free and reuse branch X v1
>                                                   [ branch X v1 ]
>                                                 leaf O | leaf P | leaf Q
> // leaf A can not be found

Right. That's why I suggested to consider hlist_nulls-like approach
that htab is using.

> > We can add a sequence number to qp_trie_branch as well and read it before and after.
> > Every reuse would inc the seq.
> > If seq number differs, re-read the node pointer form parent.
> A seq number on qp_trie_branch is a good idea. Will try it. But we also need to
> consider the starvation of lookup by update/deletion. Maybe need fallback to the
> subtree spinlock after some reread.

I think the fallback is an overkill. The race is extremely unlikely.

> >> The problem may can be solved by zeroing the unused or whole part of allocated
> >> object. Maybe adding a paired smp_wmb() and smp_rmb() to ensure the update of
> >> node array happens before the update of bitmap is also OK and the cost will be
> >> much cheaper in x86 host.
> > Something like this, right.
> > We can also consider doing lookup under spin_lock. For a large branchy trie
> > the cost of spin_lock maybe negligible.
> Do you meaning adding an extra spinlock to qp_trie_branch to protect again reuse
> or taking the subtree spinlock during lookup ? IMO the latter will make the
> lookup performance suffer, but I will check it as well.

subtree lock. lookup perf will suffer a bit.
The numbers will tell the true story.

> >
> >> Beside lookup procedure, get_next_key() from syscall also lookups trie
> >> locklessly. If the branch node is reused, the order of returned keys may be
> >> broken. There is also a parent pointer in branch node and it is used for reverse
> >> lookup during get_next_key, the reuse may lead to unexpected skip in iteration.
> > qp_trie_lookup_next_node can be done under spin_lock.
> > Iterating all map elements is a slow operation anyway.
> OK. Taking subtree spinlock is simpler but the scalability will be bad. Not sure
> whether or not the solution for lockless lookup will work for get_next_key. Will
> check.

What kind of scalability are you concerned about?
get_next is done by user space only. Plenty of overhead already.

> >
> >>> Instead of call_rcu in qp_trie_branch_free (which will work only for
> >>> regular progs and have high overhead as demonstrated by mem_alloc patches)
> >>> the qp-trie freeing logic can scrub that element, so it's ready to be
> >>> reused as another struct qp_trie_branch.
> >>> I guess I'm missing how rcu protects this internal data structures of qp-trie.
> >>> The rcu_read_lock of regular bpf prog helps to stay lock-less during lookup?
> >>> Is that it?
> >> Yes. The update is made atomic by copying the parent branch node to a new branch
> >> node and replacing the pointer to the parent branch node by the new branch node,
> >> so the lookup procedure either find the old branch node or the new branch node.
> >>> So to make qp-trie work in sleepable progs the algo would need to
> >>> be changed to do both call_rcu and call_rcu_task_trace everywhere
> >>> to protect these inner structs?
> >>> call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
> >>> around. So quick update/delete (in sleepable with call_rcu_task_trace)
> >>> may very well exhaust memory. With bpf_mem_alloc we don't have this issue
> >>> since rcu_task_trace gp is observed only when freeing into global mem pool.
> >>> Say qp-trie just uses bpf_mem_alloc for qp_trie_branch.
> >>> What is the worst that can happen? qp_trie_lookup_elem will go into wrong
> >>> path, but won't crash, right? Can we do hlist_nulls trick to address that?
> >>> In other words bpf_mem_alloc reuse behavior is pretty much SLAB_TYPESAFE_BY_RCU.
> >>> Many kernel data structures know how to deal with such object reuse.
> >>> We can have a private bpf_mem_alloc here for qp_trie_branch-s only and
> >>> construct a logic in a way that obj reuse is not problematic.
> >> As said above, qp_trie_lookup_elem may be OK with SLAB_TYPESAFE_BY_RCU. But I
> >> don't know how to do it for get_next_key because the iteration result needs to
> >> be ordered and can not skip existed elements before the iterations begins.
> > imo it's fine to spin_lock in get_next_key.
> > We should measure the lock overhead in lookup. It might be acceptable too.
> Will check that.
> >
> >> If removing immediate reuse from bpf_mem_alloc, beside the may-decreased
> >> performance, is there any reason we can not do that ?
> > What do you mean?
> > Always do call_rcu + call_rcu_tasks_trace for every bpf_mem_free ?
> Yes. Does doing call_rcu() + call_rcu_task_trace in batch help just like
> free_bulk does ?
> > As I said above:
> > " call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
> >   around. So quick update/delete (in sleepable with call_rcu_task_trace)
> >   may very well exhaust memory.
> > "
> > As an exercise try samples/bpf/map_perf_test on non-prealloc hashmap
> > before mem_alloc conversion. Just regular call_rcu consumes 100% of all cpus.
> > With call_rcu_tasks_trace it's worse. It cannot sustain such flood.
> > .
> Will check the result of map_perf_test. But it seems bpf_mem_alloc may still
> exhaust memory if __free_rcu_tasks_trace() can not called timely, Will take a
> close lookup on that.

In theory. yes. The batching makes a big difference.
