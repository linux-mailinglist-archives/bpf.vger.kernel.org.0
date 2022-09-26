Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764885E97AF
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiIZBZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIZBZm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 21:25:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6891EC5C
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 18:25:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso10998772pjk.0
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=ajOPTBWaa/jtqnIGLfy5k1bh2KgD3AX+ns6IuCxiiZs=;
        b=ad8q+B7vCu3Mk7NOg1sfypw78RCoG/pSLjKEtGY8FSXrOQ1vIfVRSg+GieIesJAyNL
         m1suU63BpjRKM4kiIriqS18XUg8jelUcACGJW9fAHUah8M0t9zk8/j0eC9V55GLG6TbQ
         RrQ4euxQgsvyKJMTww6TQnQaZ61yIj7fuO0krjv8jvOVcNVp0oExGODzGL/Hzm85nGFu
         d8QxDEt2TSLFzVEO+Uqb9brZnStIT3vaaWUg0BXjQS0H02WSQtSoumsCsP+wslhWftFK
         te5jPhvREFDJ6gd1VkszsaWglLVUK2cvyQWRF3v50HRr3Y7ZdWWQlffu6XifzF5RaXuo
         ZAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ajOPTBWaa/jtqnIGLfy5k1bh2KgD3AX+ns6IuCxiiZs=;
        b=khZv3UM+rBsXz7Kw2zrx7r41srSqZg+yPI17r6SyhOEWoGdFlAAEfO8Q+89mSEcpnV
         My2CljwCwKN6aWROJ/uhO7031urssiToR+4MEIXRZdqRI4ndmWjYJUzD1jNR+IpbuTQ3
         butl3EOOg53USPXsTEPytIVTD/sHHMrYkLpuiMu2Av/BIMAfG5bpgmANfBv7tFpMXAnq
         Gm3vzwXZ30HLURQiqmatjHsiOovdSS/ZZ+h3+10r1Wkc5CQKHeNRXq6ED3YEl7I8bW4d
         TTTAuByxQQkDNC55UDjaCWgsH1sMoVu9xTpFIv2/uctULRgHyk3I12uX7RjrEpBYWdsk
         0Qng==
X-Gm-Message-State: ACrzQf1h1DVipAtwno3J0nH6EvHxXn2vwqqEAJV0X1gsCpKDostIQKBS
        B5UL7bKOvoZUfstnRArSnGTZwy4BPlw=
X-Google-Smtp-Source: AMsMyM73O84zLog6u1hT8zNNo/Ki3Tn/Hqvs5l7Yxd1EBSDQ+liab2kgOnn0RDYXBejFHKvCRAmGVQ==
X-Received: by 2002:a17:902:d2c8:b0:178:6f5b:f905 with SMTP id n8-20020a170902d2c800b001786f5bf905mr19359408plc.2.1664155540253;
        Sun, 25 Sep 2022 18:25:40 -0700 (PDT)
Received: from MacBook-Pro-4.local ([2620:10d:c090:400::5:2d3c])
        by smtp.gmail.com with ESMTPSA id h34-20020a635322000000b0043c5cb8efdfsm4719476pgb.91.2022.09.25.18.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 18:25:39 -0700 (PDT)
Date:   Sun, 25 Sep 2022 18:25:35 -0700
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
Message-ID: <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 24, 2022 at 09:36:07PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The initial motivation for qp-trie map is to reduce memory usage for
> string keys special those with large differencies in length as
> discussed in [0]. And as a big-endian lexicographical ordered map, it
> can also be used for any binary data with fixed or variable length.
> 
> Now the basic functionality of qp-trie is ready, so posting it to get
> more feedback or suggestions about qp-trie. Specially feedback
> about the following questions:
> 
> (1) Use cases for qp-trie
> Andrii had proposed to re-implement lpm-trie by using qp-trie. The
> advantage would be the speed up of lookup operations due to lower tree
> depth of qp-trie and the performance of update may also increase.
> But is there any other use cases for qp-trie ? Specially those cases
> which need both ordering and memory efficiency or cases in which qp-trie
> will have high fan-out and its lookup performance will be much better than
> hash-table as shown below:
> 
>   Randomly-generated binary data (key size=255, max entries=16K, key length range:[1, 255])
>   htab lookup      (1  thread)    4.968 ± 0.009M/s (drops 0.002 ± 0.000M/s mem 8.169 MiB)
>   htab lookup      (2  thread)   10.118 ± 0.010M/s (drops 0.007 ± 0.000M/s mem 8.169 MiB)
>   htab lookup      (4  thread)   20.084 ± 0.022M/s (drops 0.007 ± 0.000M/s mem 8.168 MiB)
>   htab lookup      (8  thread)   39.866 ± 0.047M/s (drops 0.010 ± 0.000M/s mem 8.168 MiB)
>   htab lookup      (16 thread)   79.412 ± 0.065M/s (drops 0.049 ± 0.000M/s mem 8.169 MiB)
>   
>   qp-trie lookup   (1  thread)   10.291 ± 0.007M/s (drops 0.004 ± 0.000M/s mem 4.899 MiB)
>   qp-trie lookup   (2  thread)   20.797 ± 0.009M/s (drops 0.006 ± 0.000M/s mem 4.879 MiB)
>   qp-trie lookup   (4  thread)   41.943 ± 0.019M/s (drops 0.015 ± 0.000M/s mem 4.262 MiB)
>   qp-trie lookup   (8  thread)   81.985 ± 0.032M/s (drops 0.025 ± 0.000M/s mem 4.215 MiB)
>   qp-trie lookup   (16 thread)  164.681 ± 0.051M/s (drops 0.050 ± 0.000M/s mem 4.261 MiB)
> 
>   * non-zero drops is due to duplicated keys in generated keys.
> 
> (2) Improve update/delete performance for qp-trie
> Now top-5 overheads in update/delete operations are:
> 
>     21.23%  bench    [kernel.vmlinux]    [k] qp_trie_update_elem
>     13.98%  bench    [kernel.vmlinux]    [k] qp_trie_delete_elem
>      7.96%  bench    [kernel.vmlinux]    [k] native_queued_spin_lock_slowpath
>      5.16%  bench    [kernel.vmlinux]    [k] memcpy_erms
>      5.00%  bench    [kernel.vmlinux]    [k] __kmalloc_node
> 
> The top-2 overheads are due to memory access and atomic ops on
> max_entries. I had tried memory prefetch but it didn't work out, maybe
> I did it wrong. For subtree spinlock overhead, I also had tried the
> hierarchical lock by using hand-over-hand lock scheme, but it didn't
> scale well [1]. I will try to increase the number of subtrees from 256
> to 1024, 4096 or bigger and check whether it makes any difference.
> 
> For atomic ops and kmalloc overhead, I think I can reuse the idea from
> patchset "bpf: BPF specific memory allocator". I have given bpf_mem_alloc
> a simple try and encounter some problems. One problem is that
> immediate reuse of freed object in bpf memory allocator. Because qp-trie
> uses bpf memory allocator to allocate and free qp_trie_branch, if
> qp_trie_branch is reused immediately, the lookup procedure may oops due
> to the incorrect content in qp_trie_branch. And another problem is the
> size limitation in bpf_mem_alloc() is 4096. It may be a little small for
> the total size of key size and value size, but maybe I can use two
> separated bpf_mem_alloc for key and value.

4096 limit for key+value size would be an acceptable trade-off.
With kptrs the user will be able to extend value to much bigger sizes
while doing <= 4096 allocation at a time. Larger allocations are failing
in production more often than not. Any algorithm relying on successful
 >= 4096 allocation is likely to fail. kvmalloc is a fallback that
the kernel is using, but we're not there yet in bpf land.
The benefits of bpf_mem_alloc in qp-trie would be huge though.
qp-trie would work in all contexts including sleepable progs.
As presented the use cases for qp-trie are quite limited.
If I understand correctly the concern for not using bpf_mem_alloc
is that qp_trie_branch can be reused. Can you provide an exact scenario
that will casue issuses?
Instead of call_rcu in qp_trie_branch_free (which will work only for
regular progs and have high overhead as demonstrated by mem_alloc patches)
the qp-trie freeing logic can scrub that element, so it's ready to be
reused as another struct qp_trie_branch.
I guess I'm missing how rcu protects this internal data structures of qp-trie.
The rcu_read_lock of regular bpf prog helps to stay lock-less during lookup?
Is that it?
So to make qp-trie work in sleepable progs the algo would need to
be changed to do both call_rcu and call_rcu_task_trace everywhere
to protect these inner structs?
call_rcu_task_trace can take long time. So qp_trie_branch-s may linger
around. So quick update/delete (in sleepable with call_rcu_task_trace)
may very well exhaust memory. With bpf_mem_alloc we don't have this issue
since rcu_task_trace gp is observed only when freeing into global mem pool.
Say qp-trie just uses bpf_mem_alloc for qp_trie_branch.
What is the worst that can happen? qp_trie_lookup_elem will go into wrong
path, but won't crash, right? Can we do hlist_nulls trick to address that?
In other words bpf_mem_alloc reuse behavior is pretty much SLAB_TYPESAFE_BY_RCU.
Many kernel data structures know how to deal with such object reuse.
We can have a private bpf_mem_alloc here for qp_trie_branch-s only and
construct a logic in a way that obj reuse is not problematic.

Another alternative would be to add explicit rcu_read_lock in qp_trie_lookup_elem
to protect qp_trie_branch during lookup while using bpf_mem_alloc
for both qp_trie_branch and leaf nodes, but that's not a great solution either.
It will allow qp-trie to be usable in sleepable, but use of call_rcu
in update/delete will prevent qp-trie to be usable in tracing progs.

Let's try to brainstorm how to make qp_trie_branch work like SLAB_TYPESAFE_BY_RCU.

Other than this issue the patches look great. This new map would be awesome addition.
