Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8565F8235
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJHB7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 21:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHB7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 21:59:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F0BEAF0
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 18:59:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r17so14692261eja.7
        for <bpf@vger.kernel.org>; Fri, 07 Oct 2022 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N691Ln/9BwtMLEVA7ZxtOSwlvjd3rcC7zbscCQ808d4=;
        b=CceBM3tp/b8imxBjVTyrC/3f17UYILzY6IPSf/Q/blQVwwjYX9sAu+fK3Jb76pgyvs
         FPuzd2DvZDX5ZhbJiied1xD9Y+Au6APKckqsX9L1PxJdrmsT5NO5DvQYvBKXNAv3UODn
         gQ1qe6xyxwtvpE5Ckkd/1frdl62jlz8yYw0BKmP4IEWJvMZ+ETLlKHw2XfzBOleNg5EB
         HzeOW5+eS2RVlMmoLZ51jw+nqQeVIRlBkoc+p+c3bQmLBEGUmziTGItv0fEQMpEEbajK
         zxOEXBQCNtU/rw9Rv6Hu+nXledR3TAqxV02+j09B60FTaYyFc1atoWfir9bEAZGodNN5
         zaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N691Ln/9BwtMLEVA7ZxtOSwlvjd3rcC7zbscCQ808d4=;
        b=ZE5RR9Ax4OlDn+6teuDADR82lBpKPo/FevUsGdD5tBjkTGQYNKfp1KExMR32aojQ8L
         1bpWeAoOTDa7HFd6prvfMJwuSTr3+gu5vubP8aXoUpYaa51MHnQksjZe6gWU2O4gm4El
         PgaCaB9MfbY6w97piE4TpuFxVwOdksjZtrdPXKsnGhqMDje2Ga3JDWKDpPTMzvh+7J7A
         Om2s26Ors2K1W4yGFhnDoP7aa7n15j2d0MrMC+a1gDkOgS0oq6IYHNvD9PI8Gs8Zpm/e
         J0aoXxbH88MMmd/Uh85u2dx9fmGh5K91MrmNaZ5768jxYkVi70M2mNQDPH2plJFayhgT
         QvpQ==
X-Gm-Message-State: ACrzQf32KsQeqvaaZtGcokVRc0rxuKmdlzeqZqOuqwhhZyq+kLk3fBPd
        DkTOClyD0kINzfJ3x+LYMN++dOXa3UimPD5ZTUU=
X-Google-Smtp-Source: AMsMyM76c3qiOVnaAwxPuVFFEJMPrcf80UyuzXJowE2Gb+7QdLYRLuix3p8ZyG+ngbYX0f2iU43IgBQya2DUho6NVFo=
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id
 nb24-20020a1709071c9800b0078d3b06dc8fmr6174908ejc.58.1665194360456; Fri, 07
 Oct 2022 18:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local> <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com> <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com> <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com> <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
 <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
In-Reply-To: <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 7 Oct 2022 18:59:08 -0700
Message-ID: <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
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

On Fri, Oct 7, 2022 at 6:56 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 9/29/2022 11:22 AM, Alexei Starovoitov wrote:
> > On Wed, Sep 28, 2022 at 1:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >> Hi,
> >>
> >> On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> >>> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >>>
> >>> Looks like the perf is lost on atomic_inc/dec.
> >>> Try a partial revert of mem_alloc.
> >>> In particular to make sure
> >>> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> >>> is reverted and call_rcu is in place,
> >>> but percpu counter optimization is still there.
> >>> Also please use 'map_perf_test 4'.
> >>> I doubt 1000 vs 10240 will make a difference, but still.
> >>>
> >> I have tried the following two setups:
> >> (1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
> >> # Samples: 1M of event 'cycles:ppp'
> >> # Event count (approx.): 1041345723234
> >> #
> >> # Overhead  Command          Shared Object                                Symbol
> >> # ........  ...............  ...........................................
> >> ...............................................
> >> #
> >>     10.36%  map_perf_test    [kernel.vmlinux]                             [k]
> >> bpf_map_get_memcg.isra.0
> > That is per-cpu counter and it's consuming 10% ?!
> > Something is really odd in your setup.
> > A lot of debug configs?
> Sorry for the late reply. Just back to work from a long vacation.
>
> My local .config is derived from Fedora distribution. It indeed has some DEBUG
> related configs. Will turn these configs off to check it again :)
> >>      9.82%  map_perf_test    [kernel.vmlinux]                             [k]
> >> bpf_map_kmalloc_node
> >>      4.24%  map_perf_test    [kernel.vmlinux]                             [k]
> >> check_preemption_disabled
> > clearly debug build.
> > Please use production build.
> check_preemption_disabled is due to CONFIG_DEBUG_PREEMPT. And it is enabled on
> Fedora distribution.
> >>      2.86%  map_perf_test    [kernel.vmlinux]                             [k]
> >> htab_map_update_elem
> >>      2.80%  map_perf_test    [kernel.vmlinux]                             [k]
> >> __kmalloc_node
> >>      2.72%  map_perf_test    [kernel.vmlinux]                             [k]
> >> htab_map_delete_elem
> >>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
> >> memcg_slab_post_alloc_hook
> >>      2.21%  map_perf_test    [kernel.vmlinux]                             [k]
> >> entry_SYSCALL_64
> >>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> >> syscall_exit_to_user_mode
> >>      2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
> >>      2.11%  map_perf_test    [kernel.vmlinux]                             [k]
> >> syscall_return_via_sysret
> >>      2.05%  map_perf_test    [kernel.vmlinux]                             [k]
> >> alloc_htab_elem
> >>      1.94%  map_perf_test    [kernel.vmlinux]                             [k]
> >> _raw_spin_lock_irqsave
> >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> >> preempt_count_add
> >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> >> preempt_count_sub
> >>      1.87%  map_perf_test    [kernel.vmlinux]                             [k]
> >> call_rcu
> SNIP
> >> Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
> >> you think ?
> > We've discussed it twice already. It's not an option due to OOM
> > and performance considerations.
> > call_rcu doesn't scale to millions a second.
> Understand. I was just trying to understand the exact performance overhead of
> call_rcu(). If the overhead of map operations are much greater than the overhead
> of call_rcu(), I think calling call_rcu() one millions a second will be not a
> problem and  it also makes the implementation of qp-trie being much simpler. The
> OOM problem is indeed a problem, although it is also possible for the current
> implementation, so I will try to implement the lookup procedure which handles
> the reuse problem.

call_rcu is not just that particular function.
It's all the work rcu subsystem needs to do to observe gp
and execute that callback. Just see how many kthreads it will
start when overloaded like this.
