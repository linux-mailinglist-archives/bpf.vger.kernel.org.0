Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF63864C763
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiLNKrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiLNKrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:47:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D630233B6;
        Wed, 14 Dec 2022 02:47:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so9767189lfb.1;
        Wed, 14 Dec 2022 02:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OOfDqnDmZreJyIzvRztZ+g+nyHtC9YBDCnmJg83zL7o=;
        b=mfCSH/TqUf403/6Wtp2CVDcx3k9l7ZFQ5K41iZXw2QGkR5x7NEcC4SIovztp2ztR+O
         PVLkxwmhLLpaVpqujuddSZfF/NrR1+XoYLslQYjBi1A/WBSQEmj739Q0Ar6eTurfJuai
         o0LU4gYanImwFYiuIXtD4FWwhmR5rH+/rjKLgz5OR7bCseHTyh03h0Np4PobmHsqlkmj
         m0HS/FJxxymNQFOCf8+TJtSBOmxYzzPd1+wKedGvGKp5BajG086vybDLpIoEQgF6a0CW
         OjvcfaCy5Hnll//+iU4Hh9EnPDHI7zrpInmVc0zUhPDry8zbiqCu9LXeKEdSHkSxQrbj
         aq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOfDqnDmZreJyIzvRztZ+g+nyHtC9YBDCnmJg83zL7o=;
        b=E0wDV91xkO6cxyRalK+FQTAzKPXgMJFNPNbwLkx+4KYtih9fq3GXGkNj3BTDM0qXyJ
         lZMSpK3uXdcboZiFhQeGz2Inz9mihxICTlSy1PMhppCF9b4uDflxLXroN0KDE7ELmByY
         Vcqnj5DUfQ3Ax61Pc1UTSuz1oE0/oYUCKO257iJYknfobnW3vXTuMQvcZmof6vK8araU
         EVDDlDtRSIecyH2PrnbFgUwwt9eaV+q4sVQfL3wBuvw8FpYvCuGBMZv8C0/ROkgKPlOB
         dH1bkne13bjWoJwYL+xCRNKS6jr1OvpnT1TBLBDysxThk7K8NcBCCVu7Z58B/sKnIUtB
         ZBqg==
X-Gm-Message-State: ANoB5plfPwJKYzPF0FmVZ6r6YNvXX4vdhi6lg0NfPB1mz3kHrTdsKPmd
        smYN/XhZrJUFBpLNsyECQSWCTdqn/l+cvuJq3r4=
X-Google-Smtp-Source: AA0mqf4oC063wWy1jk/2G2pZYBeB0lqoqdYLKypw1R5NdhTdWxq4Pz/Gtx3VCgAjjQjN3oxtX5t/xMRgI2B9ARowx3E=
X-Received: by 2002:ac2:5a50:0:b0:4b5:4387:8e1c with SMTP id
 r16-20020ac25a50000000b004b543878e1cmr12271490lfn.58.1671014848402; Wed, 14
 Dec 2022 02:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20221212003711.24977-1-laoar.shao@gmail.com> <c43d8d42-ecb1-a044-eb9a-b68d5808562a@suse.cz>
 <CALOAHbC7xWFAYz0qc1XpREbw8=nAquFNTi5k4TA02UQ_7w5k0A@mail.gmail.com>
 <Y5iSsdDmXhC5nxuM@hyeyoo> <6f9bb391-580e-cfc2-e039-25f47d162d17@suse.cz> <20221213192156.GS4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221213192156.GS4001@paulmck-ThinkPad-P17-Gen-1>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 14 Dec 2022 18:46:52 +0800
Message-ID: <CALOAHbBxim-ahGQ8AQz5B4NCMFCza+Pzm9+jiQHPerMKHg_6Eg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] mm, bpf: Add BPF into /proc/meminfo
To:     paulmck@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        linux-mm@kvack.org, bpf@vger.kernel.org, rcu@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
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

On Wed, Dec 14, 2022 at 3:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Dec 13, 2022 at 04:52:09PM +0100, Vlastimil Babka wrote:
> > On 12/13/22 15:56, Hyeonggon Yoo wrote:
> > > On Tue, Dec 13, 2022 at 07:52:42PM +0800, Yafang Shao wrote:
> > >> On Tue, Dec 13, 2022 at 1:54 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >> >
> > >> > On 12/12/22 01:37, Yafang Shao wrote:
> > >> > > Currently there's no way to get BPF memory usage, while we can only
> > >> > > estimate the usage by bpftool or memcg, both of which are not reliable.
> > >> > >
> > >> > > - bpftool
> > >> > >   `bpftool {map,prog} show` can show us the memlock of each map and
> > >> > >   prog, but the memlock is vary from the real memory size. The memlock
> > >> > >   of a bpf object is approximately
> > >> > >   `round_up(key_size + value_size, 8) * max_entries`,
> > >> > >   so 1) it can't apply to the non-preallocated bpf map which may
> > >> > >   increase or decrease the real memory size dynamically. 2) the element
> > >> > >   size of some bpf map is not `key_size + value_size`, for example the
> > >> > >   element size of htab is
> > >> > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > >> > >   That said the differece between these two values may be very great if
> > >> > >   the key_size and value_size is small. For example in my verifaction,
> > >> > >   the size of memlock and real memory of a preallocated hash map are,
> > >> > >
> > >> > >   $ grep BPF /proc/meminfo
> > >> > >   BPF:             1026048 B <<< the size of preallocated memalloc pool
> > >> > >
> > >> > >   (create hash map)
> > >> > >
> > >> > >   $ bpftool map show
> > >> > >   3: hash  name count_map  flags 0x0
> > >> > >           key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > >> > >
> > >> > >   $ grep BPF /proc/meminfo
> > >> > >   BPF:            84919344 B
> > >> > >
> > >> > >   So the real memory size is $((84919344 - 1026048)) which is 83893296
> > >> > >   bytes while the memlock is only 8388608 bytes.
> > >> > >
> > >> > > - memcg
> > >> > >   With memcg we only know that the BPF memory usage is less than
> > >> > >   memory.usage_in_bytes (or memory.current in v2). Furthermore, we only
> > >> > >   know that the BPF memory usage is less than $MemTotal if the BPF
> > >> > >   object is charged into root memcg :)
> > >> > >
> > >> > > So we need a way to get the BPF memory usage especially there will be
> > >> > > more and more bpf programs running on the production environment. The
> > >> > > memory usage of BPF memory is not trivial, which deserves a new item in
> > >> > > /proc/meminfo.
> > >> > >
> > >> > > This patchset introduce a solution to calculate the BPF memory usage.
> > >> > > This solution is similar to how memory is charged into memcg, so it is
> > >> > > easy to understand. It counts three types of memory usage -
> > >> > >  - page
> > >> > >    via kmalloc, vmalloc, kmem_cache_alloc or alloc pages directly and
> > >> > >    their families.
> > >> > >    When a page is allocated, we will count its size and mark the head
> > >> > >    page, and then check the head page at page freeing.
> > >> > >  - slab
> > >> > >    via kmalloc, kmem_cache_alloc and their families.
> > >> > >    When a slab object is allocated, we will mark this object in this
> > >> > >    slab and check it at slab object freeing. That said we need extra memory
> > >> > >    to store the information of each object in a slab.
> > >> > >  - percpu
> > >> > >    via alloc_percpu and its family.
> > >> > >    When a percpu area is allocated, we will mark this area in this
> > >> > >    percpu chunk and check it at percpu area freeing. That said we need
> > >> > >    extra memory to store the information of each area in a percpu chunk.
> > >> > >
> > >> > > So we only need to annotate the allcation to add the BPF memory size,
> > >> > > and the sub of the BPF memory size will be handled automatically at
> > >> > > freeing. We can annotate it in irq, softirq or process context. To avoid
> > >> > > counting the nested allcations, for example the percpu backing allocator,
> > >> > > we reuse the __GFP_ACCOUNT to filter them out. __GFP_ACCOUNT also make
> > >> > > the count consistent with memcg accounting.
> > >> >
> > >> > So you can't easily annotate the freeing places as well, to avoid the whole
> > >> > tracking infrastructure?
> > >>
> > >> The trouble is kfree_rcu().  for example,
> > >>     old_item = active_vm_item_set(ACTIVE_VM_BPF);
> > >>     kfree_rcu();
> > >>     active_vm_item_set(old_item);
> > >> If we want to pass the ACTIVE_VM_BPF into the deferred rcu context, we
> > >> will change lots of code in the RCU subsystem. I'm not sure if it is
> > >> worth it.
> > >
> > > (+Cc rcu folks)
> > >
> > > IMO adding new kfree_rcu() varient for BPF that accounts BPF memory
> > > usage would be much less churn :)
> >
> > Alternatively, just account the bpf memory as freed already when calling
> > kfree_rcu()? I think the amount of memory "in flight" to be freed by rcu is
> > a separate issue (if it's actually an issue) and not something each
> > kfree_rcu() user should think about separately?
>
> If the in-flight memory really does need to be accounted for, then one
> straightforward approach is to use call_rcu() and do the first part of
> the needed accounting at the call_rcu() callsite and the rest of the
> accounting when the callback is invoked.  Or, if memory must be freed
> quickly even on ChromeOS and Android, use call_rcu_hurry() instead
> of call_rcu().
>

Right, call_rcu() can make it work.
But I'm not sure if all kfree_rcu() in kernel/bpf can be replaced by call_rcu().
Alexei, any comment on it ?

$ grep -r "kfree_rcu" kernel/bpf/
kernel/bpf/local_storage.c:     kfree_rcu(new, rcu);
kernel/bpf/lpm_trie.c:          kfree_rcu(node, rcu);
kernel/bpf/lpm_trie.c:          kfree_rcu(parent, rcu);
kernel/bpf/lpm_trie.c:          kfree_rcu(node, rcu);
kernel/bpf/lpm_trie.c:  kfree_rcu(node, rcu);
kernel/bpf/bpf_inode_storage.c:         kfree_rcu(local_storage, rcu);
kernel/bpf/bpf_task_storage.c:          kfree_rcu(local_storage, rcu);
kernel/bpf/trampoline.c:        kfree_rcu(im, rcu);
kernel/bpf/core.c:      kfree_rcu(progs, rcu);
kernel/bpf/core.c:       * no need to call kfree_rcu(), just call
kfree() directly.
kernel/bpf/core.c:              kfree_rcu(progs, rcu);
kernel/bpf/bpf_local_storage.c:  * kfree(), else do kfree_rcu().
kernel/bpf/bpf_local_storage.c:         kfree_rcu(local_storage, rcu);
kernel/bpf/bpf_local_storage.c:         kfree_rcu(selem, rcu);
kernel/bpf/bpf_local_storage.c:         kfree_rcu(selem, rcu);
kernel/bpf/bpf_local_storage.c:                 kfree_rcu(local_storage, rcu);

-- 
Regards
Yafang
