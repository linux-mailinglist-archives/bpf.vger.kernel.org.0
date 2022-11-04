Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F02619BB1
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiKDPcu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiKDPcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:32:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621832F64E
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C515CB82ECC
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 15:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828AFC43141
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667575964;
        bh=dLSH+DwEVz4vun+AsZ3b5YnBzlsmVak/OGQ54LL2Ecs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VOuBB+hkgcJWfx3yxT4jblspJxlnLpdYVQE6Taf69vSBjzKs7uAXUUSrLqEQK04nD
         ffjCWlb4UwZgF0sGW9I0PXfpwZWn3Kk0aXLdHRwchZCp3JfRhJQRhtfZJPgTDGZA4r
         FiT+3ZYTfpbef9fXcSKzxBsmUewsXKPmZLnvY4ToO7hSwGofn4hpE8AunJBft7gwXU
         Z8PDA9ZVzjKMGhW5qFGwaqTi3YWqSODVniQjtOrwBoYMfm5r8clWbOUKZdRNCpSFHz
         XG3UgCQe30Lf/KYWQf2r9ehjrB8xo0iyR5+1nPvUCmaeBX4hRuGVMmJdzlbvlIS1FQ
         MBRSwcylUxxiw==
Received: by mail-lf1-f54.google.com with SMTP id f37so7870522lfv.8
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 08:32:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf2hPT3GWUSgnwCl2/PwpIt2NigOaK9fZjNsqGQbMYWSzBbJQRvP
        /yKLk01TziL1RUV+aOjJNeNozCz6n5qlcvjdgDF20Q==
X-Google-Smtp-Source: AMsMyM7PePEeSO3ScGKEjQmwD4316+YXMC0fNKbQJ7TJOX+DbKWg8aBL2pqH4Ck9meUBGsgwqRMYAfjNsW9txBzpYmM=
X-Received: by 2002:a05:6512:22c2:b0:4a2:abd1:6cab with SMTP id
 g2-20020a05651222c200b004a2abd16cabmr13436768lfu.584.1667575962465; Fri, 04
 Nov 2022 08:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221103072102.2320490-1-yhs@fb.com> <20221103072118.2323222-1-yhs@fb.com>
 <20221103221715.zyegpoc3puz6oimx@apollo> <CACYkzJ6m_H4cq=7SgYcaoYE9qGgquEh6FPHe9Kpr=j-DUCnvXg@mail.gmail.com>
 <429dc3c0-f7f8-6d4f-16ba-63042d9f0487@meta.com>
In-Reply-To: <429dc3c0-f7f8-6d4f-16ba-63042d9f0487@meta.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Nov 2022 16:32:31 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4ta8sKkpQS1VkPSz9zLwh2uBErHQhetuWWFEYdCs2cDQ@mail.gmail.com>
Message-ID: <CACYkzJ4ta8sKkpQS1VkPSz9zLwh2uBErHQhetuWWFEYdCs2cDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
To:     Alexei Starovoitov <ast@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 4:27 PM Alexei Starovoitov <ast@meta.com> wrote:
>
> On 11/4/22 5:13 AM, KP Singh wrote:
> > On Thu, Nov 3, 2022 at 11:17 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>
> >> On Thu, Nov 03, 2022 at 12:51:18PM IST, Yonghong Song wrote:
> >>> A new bpf_type_flag MEM_RCU is added to indicate a PTR_TO_BTF_ID
> >>> object access needing rcu_read_lock protection. The rcu protection
> >>> is not needed for non-sleepable program. So various verification
> >>> checking is only done for sleepable programs. In particular, only
> >>> the following insns can be inside bpf_rcu_read_lock() region:
> >>>    - any non call insns except BPF_ABS/BPF_IND
> >>>    - non sleepable helpers and kfuncs.
> >>> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
> >>> allocation flag) should be GFP_ATOMIC.
> >>>
> >>> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
> >>> this pointer and the load which gets this pointer needs to be
> >>> protected by bpf_rcu_read_lock(). The following shows a couple
> >>> of examples:
> >>>    struct task_struct {
> >>>        ...
> >>>        struct task_struct __rcu        *real_parent;
> >>>        struct css_set __rcu            *cgroups;
> >>>        ...
> >>>    };
> >>>    struct css_set {
> >>>        ...
> >>>        struct cgroup *dfl_cgrp;
> >>>        ...
> >>>    }
> >>>    ...
> >>>    task = bpf_get_current_task_btf();
> >>>    cgroups = task->cgroups;
> >>>    dfl_cgroup = cgroups->dfl_cgrp;
> >>>    ... using dfl_cgroup ...
> >>>
> >>> The bpf_rcu_read_lock/unlock() should be added like below to
> >>> avoid verification failures.
> >>>    task = bpf_get_current_task_btf();
> >>>    bpf_rcu_read_lock();
> >>>    cgroups = task->cgroups;
> >>>    dfl_cgroup = cgroups->dfl_cgrp;
> >>>    bpf_rcu_read_unlock();
> >>>    ... using dfl_cgroup ...
> >>>
> >>> The following is another example for task->real_parent.
> >>>    task = bpf_get_current_task_btf();
> >>>    bpf_rcu_read_lock();
> >>>    real_parent = task->real_parent;
> >>>    ... bpf_task_storage_get(&map, real_parent, 0, 0);
> >>>    bpf_rcu_read_unlock();
> >>>
> >>> There is another case observed in selftest bpf_iter_ipv6_route.c:
> >>>    struct fib6_info *rt = ctx->rt;
> >>>    ...
> >>>    fib6_nh = &rt->fib6_nh[0]; // Not rcu protected
> >>>    ...
> >>>    if (rt->nh)
> >>>      fib6_nh = &nh->nh_info->fib6_nh; // rcu protected
> >>>    ...
> >>>    ... using fib6_nh ...
> >>> Currently verification will fail with
> >>>    same insn cannot be used with different pointers
> >>> since the use of fib6_nh is tag with rcu in one path
> >>> but not in the other path. The above use case is a valid
> >>> one so the verifier is changed to ignore MEM_RCU type tag
> >>> in such cases.
> >>>
> >>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>> ---
> >>>   include/linux/bpf.h          |   3 +
> >>>   include/linux/bpf_verifier.h |   1 +
> >>>   kernel/bpf/btf.c             |  11 +++
> >>>   kernel/bpf/verifier.c        | 126 ++++++++++++++++++++++++++++++++---
> >>>   4 files changed, 133 insertions(+), 8 deletions(-)
> >
> > [...]
> >
> >>> +
> >>
> >> This isn't right. Every load that obtains an RCU pointer needs to become tied to
> >> the current RCU section, and needs to be invalidated once the RCU section ends.
> >>
> >> So in addition to checking that bpf_rcu_read_lock is held around MEM_RCU access,
> >> you need to invalidate all MEM_RCU pointers when bpf_rcu_read_unlock is called.
> >>
> >> Otherwise, with the current logic, the following would become possible:
> >>
> >> bpf_rcu_read_lock();
> >> p = rcu_dereference(foo->rcup);
> >> bpf_rcu_read_unlock();
> >>
> >> // p is possibly dead
> >>
> >> bpf_rcu_read_lock();
> >> // use p
> >> bpf_rcu_read_unlock();
> >>
> >
> > What do want to do about cases like:
> >
> > bpf_rcu_read_lock();
> >
> > q = rcu_derference(foo->rcup);
> >
> > bpf_rcu_read_lock();
>
> This one should be rejected for simplicity.
> Let's not complicated things with nested cs-s.

Agreed, the current logic tries to count the number of active
critical sections and the verifier should just reject if there
is a nested bpf_rcu_read_lock() call.

>
> >
> > p = rcu_derference(foo->rcup);
> >
> > bpf_rcu_read_unlock();
> >
> > // Use q
> > // Use p
> > bpf_rcu_read_unlock();
> >
> > I think this is probably implied in your statement but just making it clear,
> >
> > The invalidation needs to happen only when the outermost bpf_rcu_read_unlock
> > is called. i.e. when active_rcu_lock goes back down to 0.
> >
>
