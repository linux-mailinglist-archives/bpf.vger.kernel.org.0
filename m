Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388A45F8749
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJHULr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Oct 2022 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJHULq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Oct 2022 16:11:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D729364
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 13:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BAE3B80BE6
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 20:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6322C433D6;
        Sat,  8 Oct 2022 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665259902;
        bh=IQmJXwa3aMYmRM+fyFRAk5tNIrOzLduUp/39+92iIBQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Sg0Oc631HAApViD8KtFJvr7FaJsbZR2JnauCf9sp+Gd1oC5ABJNNVPCtjddWMjzXK
         RRqE75nVceitf/g11vKbDn4UfBDp+Y5L8fne7w2LF+x9nyTyxU+el2GrXQ3ebLgMmO
         gSfQFwVlBKsSqmAGTkg+bqxro8IWM6H9riU79oXaYtpNIahsSc6qVph+8+5I940YZZ
         49LFh9+tKaFthB7YyXq8dsNwNsNrrzUp8rqr9B24g9bVrfdkXunNYC5nEySAKpPDSd
         fpo3NdkfBIj+b2WS9bhn7sdXzator8L+ZjrSSpLWmrCd9kE0/iphvNNUyG/GVMwQHO
         1q7mcmol7xlMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5AB465C05C0; Sat,  8 Oct 2022 13:11:42 -0700 (PDT)
Date:   Sat, 8 Oct 2022 13:11:42 -0700
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
Message-ID: <20221008201142.GN4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com>
 <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
 <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
 <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
 <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
 <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
 <20221008132244.GL4196@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQLuo+aJ0ke5M3Oz6+B=VtFfD2Qr_9c6KDjfEwHUMsx58w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLuo+aJ0ke5M3Oz6+B=VtFfD2Qr_9c6KDjfEwHUMsx58w@mail.gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 08, 2022 at 09:40:04AM -0700, Alexei Starovoitov wrote:
> On Sat, Oct 8, 2022 at 6:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Oct 07, 2022 at 06:59:08PM -0700, Alexei Starovoitov wrote:
> > > On Fri, Oct 7, 2022 at 6:56 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 9/29/2022 11:22 AM, Alexei Starovoitov wrote:
> > > > > On Wed, Sep 28, 2022 at 1:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > > > >> Hi,
> > > > >>
> > > > >> On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> > > > >>> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > > > >>>
> > > > >>> Looks like the perf is lost on atomic_inc/dec.
> > > > >>> Try a partial revert of mem_alloc.
> > > > >>> In particular to make sure
> > > > >>> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> > > > >>> is reverted and call_rcu is in place,
> > > > >>> but percpu counter optimization is still there.
> > > > >>> Also please use 'map_perf_test 4'.
> > > > >>> I doubt 1000 vs 10240 will make a difference, but still.
> > > > >>>
> > > > >> I have tried the following two setups:
> > > > >> (1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
> > > > >> # Samples: 1M of event 'cycles:ppp'
> > > > >> # Event count (approx.): 1041345723234
> > > > >> #
> > > > >> # Overhead  Command          Shared Object                                Symbol
> > > > >> # ........  ...............  ...........................................
> > > > >> ...............................................
> > > > >> #
> > > > >>     10.36%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> bpf_map_get_memcg.isra.0
> > > > > That is per-cpu counter and it's consuming 10% ?!
> > > > > Something is really odd in your setup.
> > > > > A lot of debug configs?
> > > > Sorry for the late reply. Just back to work from a long vacation.
> > > >
> > > > My local .config is derived from Fedora distribution. It indeed has some DEBUG
> > > > related configs. Will turn these configs off to check it again :)
> > > > >>      9.82%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> bpf_map_kmalloc_node
> > > > >>      4.24%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> check_preemption_disabled
> > > > > clearly debug build.
> > > > > Please use production build.
> > > > check_preemption_disabled is due to CONFIG_DEBUG_PREEMPT. And it is enabled on
> > > > Fedora distribution.
> > > > >>      2.86%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> htab_map_update_elem
> > > > >>      2.80%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> __kmalloc_node
> > > > >>      2.72%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> htab_map_delete_elem
> > > > >>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> memcg_slab_post_alloc_hook
> > > > >>      2.21%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> entry_SYSCALL_64
> > > > >>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> syscall_exit_to_user_mode
> > > > >>      2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
> > > > >>      2.11%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> syscall_return_via_sysret
> > > > >>      2.05%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> alloc_htab_elem
> > > > >>      1.94%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> _raw_spin_lock_irqsave
> > > > >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> preempt_count_add
> > > > >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> preempt_count_sub
> > > > >>      1.87%  map_perf_test    [kernel.vmlinux]                             [k]
> > > > >> call_rcu
> > > > SNIP
> > > > >> Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
> > > > >> you think ?
> > > > > We've discussed it twice already. It's not an option due to OOM
> > > > > and performance considerations.
> > > > > call_rcu doesn't scale to millions a second.
> > > > Understand. I was just trying to understand the exact performance overhead of
> > > > call_rcu(). If the overhead of map operations are much greater than the overhead
> > > > of call_rcu(), I think calling call_rcu() one millions a second will be not a
> > > > problem and  it also makes the implementation of qp-trie being much simpler. The
> > > > OOM problem is indeed a problem, although it is also possible for the current
> > > > implementation, so I will try to implement the lookup procedure which handles
> > > > the reuse problem.
> > >
> > > call_rcu is not just that particular function.
> > > It's all the work rcu subsystem needs to do to observe gp
> > > and execute that callback. Just see how many kthreads it will
> > > start when overloaded like this.
> >
> > The kthreads to watch include rcu_preempt, rcu_sched, ksoftirqd*, rcuc*,
> > and rcuo*.  There is also the back-of-interrupt softirq context, which
> > requires some care to measure accurately.
> >
> > The possibility of SLAB_TYPESAFE_BY_RCU has been discussed.  I take it
> > that the per-element locking overhead for exact iterations was a problem?
> > If so, what exactly are the consistency rules for iteration?  Presumably
> > stronger than "if the element existed throughout, it is included in the
> > iteration; if it did not exist throughout, it is not included; otherwise
> > it might or might not be included" given that you get that for free.
> >
> > Either way, could you please tell me the exact iteration rules?
> 
> The rules are the way we make them to be.
> iteration will be under lock.
> lookup needs to be correct. It can retry if necessary (like htab is doing).
> Randomly returning 'noexist' is, of course, not acceptable.

OK, so then it is important that updates to this data structure be
carried out in such a way as to avoid discombobulating lockless readers.
Do the updates have that property?

The usual way to get that property is to leave the old search structure
around, replacing it with the new one, and RCU-freeing the old one.
In case it helps, Kung and Lehman describe how to do that for search trees:

http://www.eecs.harvard.edu/~htk/publication/1980-tods-kung-lehman.pdf

							Thanx, Paul
