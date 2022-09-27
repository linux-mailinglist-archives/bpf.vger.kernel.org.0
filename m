Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AEC5EB6BF
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 03:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiI0BT6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiI0BT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 21:19:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B350185
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 18:19:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso8611544pjd.4
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=jQE5+PmUOftkOSJ9XRtLFySBSJBzPTR18hpFMxVHlZE=;
        b=TC9tc+cOQd2pKK90T84eCxFEC1pnSoY+rEDmNmqt+rb7fXCv86cy9BwChd+iIz+L0B
         sPNX9rmPDSmD1Nt39nfQbN6uA6XpATSP2lJ/zAhw3fRSCRn0Puxg/MnSPZD3358DSuU/
         OeQGShoqnn+qesjjxL40pwXExClmeb9GAz3gGzci4taD/Kh4bMtnwvMRRowFPR30b0Xr
         dqoscE0iGxSY9XGMI4rp25JgAMld6z6OdHqV7JT3WL2766sIOL/1oECNfSd87Ma/IkPm
         TKAOeXw4mmzOQFRBefS7321e0AGV+rJ6cHW4tK8pMOCfz7hECc/u5bTrOy/2VKc1PKIu
         blMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jQE5+PmUOftkOSJ9XRtLFySBSJBzPTR18hpFMxVHlZE=;
        b=rMH10oh/bHSw2MHplH0JrhebVWRKqJ25vsKJUKpyugpjnMWBnPVFGzqZT4OeSzUbL5
         P6g/kmaoneFWHIbWIjQk+vAHZSDEXGbGvtm/NVhcegINMtHRi/fBNl6JIOlet2DUxtLu
         u7U47/PoQqYFPGWyGXtp8w/sXfZvoUX9IaNYG99H0D7Jk+ZS90VgwEp0hWeqtyxLIQ/p
         eGg70RMIfidU1//Q1y+4MRzRDE3mDYsnZRS5LDj7jrcNjgcnyjvO0mz2XyjtmM8tMIWR
         dVAh9ZnzNB5Cr+KiM6lM2yMP8cO7uiFJK87S5+TNRlAL5kM/VhOvdt/inhCLDpsjl6xy
         VaHQ==
X-Gm-Message-State: ACrzQf27UQvcdC89JaoUYNuJLQ+aVFRP/2aO+4NmL3Ov+kwLQSh+Sgwi
        NzT+BBUJTvK1ju8jPevVjIDQ5zOb9ts=
X-Google-Smtp-Source: AMsMyM4R6HTak8wwfm7eGjX2RonPDBWIu5/cQ7g6sU5EzgJp4+m0T/m0/MdqV7yfQOCi2lIcU6RElA==
X-Received: by 2002:a17:902:bf46:b0:179:eba5:90ba with SMTP id u6-20020a170902bf4600b00179eba590bamr731211pls.16.1664241594010;
        Mon, 26 Sep 2022 18:19:54 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:2d3c])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0016c57657977sm103842pln.41.2022.09.26.18.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 18:19:53 -0700 (PDT)
Date:   Mon, 26 Sep 2022 18:19:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
Message-ID: <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local>
 <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 26, 2022 at 09:18:46PM +0800, Hou Tao wrote:
> Hi,
> 
> On 9/26/2022 9:25 AM, Alexei Starovoitov wrote:
> > On Sat, Sep 24, 2022 at 09:36:07PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> SNIP
> >> For atomic ops and kmalloc overhead, I think I can reuse the idea from
> >> patchset "bpf: BPF specific memory allocator". I have given bpf_mem_alloc
> >> a simple try and encounter some problems. One problem is that
> >> immediate reuse of freed object in bpf memory allocator. Because qp-trie
> >> uses bpf memory allocator to allocate and free qp_trie_branch, if
> >> qp_trie_branch is reused immediately, the lookup procedure may oops due
> >> to the incorrect content in qp_trie_branch. And another problem is the
> >> size limitation in bpf_mem_alloc() is 4096. It may be a little small for
> >> the total size of key size and value size, but maybe I can use two
> >> separated bpf_mem_alloc for key and value.
> > 4096 limit for key+value size would be an acceptable trade-off.
> > With kptrs the user will be able to extend value to much bigger sizes
> > while doing <= 4096 allocation at a time. Larger allocations are failing
> > in production more often than not. Any algorithm relying on successful
> >  >= 4096 allocation is likely to fail. kvmalloc is a fallback that
> > the kernel is using, but we're not there yet in bpf land.
> > The benefits of bpf_mem_alloc in qp-trie would be huge though.
> > qp-trie would work in all contexts including sleepable progs.
> > As presented the use cases for qp-trie are quite limited.
> > If I understand correctly the concern for not using bpf_mem_alloc
> > is that qp_trie_branch can be reused. Can you provide an exact scenario
> > that will casue issuses?
> The usage of branch node during lookup is as follows:
> (1) check the index field of branch node which records the position of nibble in
> which the keys of child nodes are different
> (2) calculate the index of child node by using the nibble value of lookup key in
> index position
> (3) get the pointer of child node by dereferencing the variable-length pointer
> array in branch node
> 
> Because both branch node and leaf node have variable length, I used one
> bpf_mem_alloc for these two node types, so if a leaf node is reused as a branch
> node, the pointer got in step 3 may be invalid.
> 
> If using separated bpf_mem_alloc for branch node and leaf node, it may still be
> problematic because the updates to a reused branch node are not atomic and
> branch nodes with different child node will reuse the same object due to size
> alignment in allocator, so the lookup procedure below may get an uninitialized
> pointer in the pointer array:
> 
> lookup procedure                                update procedure
> 
> 
> // three child nodes, 48-bytes
> branch node x
>                                                               //  four child
> nodes, 56-bytes
>                                                               reuse branch node x
>                                                               x->bitmap = 0xf
> // got an uninitialized pointer
> x->nodes[3]
>                                                               Initialize
> x->nodes[0~3]

Looking at lookup:
+	while (is_branch_node(node)) {
+		struct qp_trie_branch *br = node;
+		unsigned int bitmap;
+		unsigned int iip;
+
+		/* When byte index equals with key len, the target key
+		 * may be in twigs->nodes[0].
+		 */
+		if (index_to_byte_index(br->index) > data_len)
+			goto done;
+
+		bitmap = calc_br_bitmap(br->index, data, data_len);
+		if (!(bitmap & br->bitmap))
+			goto done;
+
+		iip = calc_twig_index(br->bitmap, bitmap);
+		node = rcu_dereference_check(br->nodes[iip], rcu_read_lock_bh_held());
+	}

To be safe the br->index needs to be initialized after br->nodex and br->bitmap.
While deleting the br->index can be set to special value which would mean
restart the lookup from the beginning.
As you're suggesting with smp_rmb/wmb pairs the lookup will only see valid br.
Also the race is extremely tight, right?
After brb->nodes[iip] + is_branch_node that memory needs to deleted on other cpu
after spin_lock and reused in update after another spin_lock.
Without artifical big delay it's hard to imagine how nodes[iip] pointer
would be initialized to some other qp_trie_branch or leaf during delete,
then memory reused and nodes[iip] is initialized again with the same address.
Theoretically possible, but unlikely, right?
And with correct ordering of scrubbing and updates to
br->nodes, br->bitmap, br->index it can be made safe.

We can add a sequence number to qp_trie_branch as well and read it before and after.
Every reuse would inc the seq.
If seq number differs, re-read the node pointer form parent.

> The problem may can be solved by zeroing the unused or whole part of allocated
> object. Maybe adding a paired smp_wmb() and smp_rmb() to ensure the update of
> node array happens before the update of bitmap is also OK and the cost will be
> much cheaper in x86 host.

Something like this, right.
We can also consider doing lookup under spin_lock. For a large branchy trie
the cost of spin_lock maybe negligible.

> Beside lookup procedure, get_next_key() from syscall also lookups trie
> locklessly. If the branch node is reused, the order of returned keys may be
> broken. There is also a parent pointer in branch node and it is used for reverse
> lookup during get_next_key, the reuse may lead to unexpected skip in iteration.

qp_trie_lookup_next_node can be done under spin_lock.
Iterating all map elements is a slow operation anyway.

> > Instead of call_rcu in qp_trie_branch_free (which will work only for
> > regular progs and have high overhead as demonstrated by mem_alloc patches)
> > the qp-trie freeing logic can scrub that element, so it's ready to be
> > reused as another struct qp_trie_branch.
> > I guess I'm missing how rcu protects this internal data structures of qp-trie.
> > The rcu_read_lock of regular bpf prog helps to stay lock-less during lookup?
> > Is that it?
> Yes. The update is made atomic by copying the parent branch node to a new branch
> node and replacing the pointer to the parent branch node by the new branch node,
> so the lookup procedure either find the old branch node or the new branch node.
> > So to make qp-trie work in sleepable progs the algo would need to
> > be changed to do both call_rcu and call_rcu_task_trace everywhere
> > to protect these inner structs?
> > call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
> > around. So quick update/delete (in sleepable with call_rcu_task_trace)
> > may very well exhaust memory. With bpf_mem_alloc we don't have this issue
> > since rcu_task_trace gp is observed only when freeing into global mem pool.
> > Say qp-trie just uses bpf_mem_alloc for qp_trie_branch.
> > What is the worst that can happen? qp_trie_lookup_elem will go into wrong
> > path, but won't crash, right? Can we do hlist_nulls trick to address that?
> > In other words bpf_mem_alloc reuse behavior is pretty much SLAB_TYPESAFE_BY_RCU.
> > Many kernel data structures know how to deal with such object reuse.
> > We can have a private bpf_mem_alloc here for qp_trie_branch-s only and
> > construct a logic in a way that obj reuse is not problematic.
> As said above, qp_trie_lookup_elem may be OK with SLAB_TYPESAFE_BY_RCU. But I
> don't know how to do it for get_next_key because the iteration result needs to
> be ordered and can not skip existed elements before the iterations begins.

imo it's fine to spin_lock in get_next_key.
We should measure the lock overhead in lookup. It might be acceptable too.

> If removing immediate reuse from bpf_mem_alloc, beside the may-decreased
> performance, is there any reason we can not do that ?

What do you mean?
Always do call_rcu + call_rcu_tasks_trace for every bpf_mem_free ?
As I said above:
" call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
  around. So quick update/delete (in sleepable with call_rcu_task_trace)
  may very well exhaust memory.
"
As an exercise try samples/bpf/map_perf_test on non-prealloc hashmap
before mem_alloc conversion. Just regular call_rcu consumes 100% of all cpus.
With call_rcu_tasks_trace it's worse. It cannot sustain such flood.
