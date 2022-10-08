Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8405F8574
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJHNWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Oct 2022 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJHNWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Oct 2022 09:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3512356C4
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 06:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8652560B26
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 13:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8CBC433D6;
        Sat,  8 Oct 2022 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665235364;
        bh=d08U98yWQa/6PLNr0TFsCfjTT2slS2k6oG3TVohl6d0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BL/aCb5Virv+I2t50Fy3zwJB/xNNX9cm3gQq4/j5ejRT1xTXMB8sezD8Jm+1VuQyZ
         fViGl7nxalYoktOyiIzLlgap9TxAzaNKQ5/dyKBPrMCkAC+Y0PYsH45Q/SdI+YZEy0
         G1mCxjEJMah+0teZ4qOB0eOttzz+n2HIoLeYvCSaRxI46Oh31AALfDIhOHA34KCaHC
         44WHAgsbCpHT81gwSicVilw3WF7ySpDGw+2WVdWCFA7j5uhRAOnzyJj/GFXzhxltwE
         wwH54L1wfD4P+ZngXljm2flHhjRyn/xgCyQEq4QcJ16SGkwEtTI6WHxQJsK1yk4nyn
         zvym8U9wfsXwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 625F75C04B0; Sat,  8 Oct 2022 06:22:44 -0700 (PDT)
Date:   Sat, 8 Oct 2022 06:22:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
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
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
Message-ID: <20221008132244.GL4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
 <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
 <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
 <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
 <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
 <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 07, 2022 at 06:59:08PM -0700, Alexei Starovoitov wrote:
> On Fri, Oct 7, 2022 at 6:56 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > Hi,
> >
> > On 9/29/2022 11:22 AM, Alexei Starovoitov wrote:
> > > On Wed, Sep 28, 2022 at 1:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > >> Hi,
> > >>
> > >> On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> > >>> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > >>>
> > >>> Looks like the perf is lost on atomic_inc/dec.
> > >>> Try a partial revert of mem_alloc.
> > >>> In particular to make sure
> > >>> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> > >>> is reverted and call_rcu is in place,
> > >>> but percpu counter optimization is still there.
> > >>> Also please use 'map_perf_test 4'.
> > >>> I doubt 1000 vs 10240 will make a difference, but still.
> > >>>
> > >> I have tried the following two setups:
> > >> (1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
> > >> # Samples: 1M of event 'cycles:ppp'
> > >> # Event count (approx.): 1041345723234
> > >> #
> > >> # Overhead  Command          Shared Object                                Symbol
> > >> # ........  ...............  ...........................................
> > >> ...............................................
> > >> #
> > >>     10.36%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> bpf_map_get_memcg.isra.0
> > > That is per-cpu counter and it's consuming 10% ?!
> > > Something is really odd in your setup.
> > > A lot of debug configs?
> > Sorry for the late reply. Just back to work from a long vacation.
> >
> > My local .config is derived from Fedora distribution. It indeed has some DEBUG
> > related configs. Will turn these configs off to check it again :)
> > >>      9.82%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> bpf_map_kmalloc_node
> > >>      4.24%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> check_preemption_disabled
> > > clearly debug build.
> > > Please use production build.
> > check_preemption_disabled is due to CONFIG_DEBUG_PREEMPT. And it is enabled on
> > Fedora distribution.
> > >>      2.86%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> htab_map_update_elem
> > >>      2.80%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> __kmalloc_node
> > >>      2.72%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> htab_map_delete_elem
> > >>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> memcg_slab_post_alloc_hook
> > >>      2.21%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> entry_SYSCALL_64
> > >>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> syscall_exit_to_user_mode
> > >>      2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
> > >>      2.11%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> syscall_return_via_sysret
> > >>      2.05%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> alloc_htab_elem
> > >>      1.94%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> _raw_spin_lock_irqsave
> > >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> preempt_count_add
> > >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> preempt_count_sub
> > >>      1.87%  map_perf_test    [kernel.vmlinux]                             [k]
> > >> call_rcu
> > SNIP
> > >> Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
> > >> you think ?
> > > We've discussed it twice already. It's not an option due to OOM
> > > and performance considerations.
> > > call_rcu doesn't scale to millions a second.
> > Understand. I was just trying to understand the exact performance overhead of
> > call_rcu(). If the overhead of map operations are much greater than the overhead
> > of call_rcu(), I think calling call_rcu() one millions a second will be not a
> > problem and  it also makes the implementation of qp-trie being much simpler. The
> > OOM problem is indeed a problem, although it is also possible for the current
> > implementation, so I will try to implement the lookup procedure which handles
> > the reuse problem.
> 
> call_rcu is not just that particular function.
> It's all the work rcu subsystem needs to do to observe gp
> and execute that callback. Just see how many kthreads it will
> start when overloaded like this.

The kthreads to watch include rcu_preempt, rcu_sched, ksoftirqd*, rcuc*,
and rcuo*.  There is also the back-of-interrupt softirq context, which
requires some care to measure accurately.

The possibility of SLAB_TYPESAFE_BY_RCU has been discussed.  I take it
that the per-element locking overhead for exact iterations was a problem?
If so, what exactly are the consistency rules for iteration?  Presumably
stronger than "if the element existed throughout, it is included in the
iteration; if it did not exist throughout, it is not included; otherwise
it might or might not be included" given that you get that for free.

Either way, could you please tell me the exact iteration rules?

							Thanx, Paul
