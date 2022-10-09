Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5A5F8A41
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJIJFk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJIJFj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 05:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F702252B
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 02:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B4460B10
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 09:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AA4C433D6;
        Sun,  9 Oct 2022 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665306336;
        bh=NZ3ExjXIAviVAYaf/sFDyqxjncqFrtTybLZIo+oOCFs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AGETsLP/zlb5onu/hMj7I0Lm1n3rNA3GPtVlTBXxEOXbhJkmuGQURbHUL16/g6u8J
         /uVfiGjQSvWgE50paM7VMRebKMGs1GV2R01Pg/LPzxJO/gkUbtXXYbKCURo7J8XgXV
         Y5q9WNexBLGVa3mJAhEdtBnqkRwdRwdoMhTx5cFSqDoHd06CKxc2d3dpKBG030Mfcn
         VjeY3VFVMt7cMhNNXA1dxVrxB5bbPb13l5j9aD1qe9epwrdIHtNBGi0XJxy2BOAWLG
         oKTeizSf4v6i4j/o2QYJGac/Ffm1A7UTTtUBE8En+tIkSWqp9LctqXAcDs95LCAT3z
         UrIzTKGjz8MJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DABD85C0546; Sun,  9 Oct 2022 02:05:35 -0700 (PDT)
Date:   Sun, 9 Oct 2022 02:05:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
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
Message-ID: <20221009090535.GO4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
 <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
 <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
 <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
 <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
 <20221008132244.GL4196@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQLuo+aJ0ke5M3Oz6+B=VtFfD2Qr_9c6KDjfEwHUMsx58w@mail.gmail.com>
 <20221008201142.GN4196@paulmck-ThinkPad-P17-Gen-1>
 <1186f2f8-5d2a-fe3f-2f11-27d269143e2b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1186f2f8-5d2a-fe3f-2f11-27d269143e2b@huaweicloud.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 09, 2022 at 09:09:44AM +0800, Hou Tao wrote:
> Hi Paul,
> 
> On 10/9/2022 4:11 AM, Paul E. McKenney wrote:
> > On Sat, Oct 08, 2022 at 09:40:04AM -0700, Alexei Starovoitov wrote:
> >> On Sat, Oct 8, 2022 at 6:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> On Fri, Oct 07, 2022 at 06:59:08PM -0700, Alexei Starovoitov wrote:
> SNIP
> >>>>> Understand. I was just trying to understand the exact performance overhead of
> >>>>> call_rcu(). If the overhead of map operations are much greater than the overhead
> >>>>> of call_rcu(), I think calling call_rcu() one millions a second will be not a
> >>>>> problem and  it also makes the implementation of qp-trie being much simpler. The
> >>>>> OOM problem is indeed a problem, although it is also possible for the current
> >>>>> implementation, so I will try to implement the lookup procedure which handles
> >>>>> the reuse problem.
> >>>> call_rcu is not just that particular function.
> >>>> It's all the work rcu subsystem needs to do to observe gp
> >>>> and execute that callback. Just see how many kthreads it will
> >>>> start when overloaded like this.
> >>> The kthreads to watch include rcu_preempt, rcu_sched, ksoftirqd*, rcuc*,
> >>> and rcuo*.  There is also the back-of-interrupt softirq context, which
> >>> requires some care to measure accurately.
> >>>
> >>> The possibility of SLAB_TYPESAFE_BY_RCU has been discussed.  I take it
> >>> that the per-element locking overhead for exact iterations was a problem?
> >>> If so, what exactly are the consistency rules for iteration?  Presumably
> >>> stronger than "if the element existed throughout, it is included in the
> >>> iteration; if it did not exist throughout, it is not included; otherwise
> >>> it might or might not be included" given that you get that for free.
> >>>
> >>> Either way, could you please tell me the exact iteration rules?
> >> The rules are the way we make them to be.
> >> iteration will be under lock.
> >> lookup needs to be correct. It can retry if necessary (like htab is doing).
> >> Randomly returning 'noexist' is, of course, not acceptable.
> > OK, so then it is important that updates to this data structure be
> > carried out in such a way as to avoid discombobulating lockless readers.
> > Do the updates have that property?
> 
> Yes. The update procedure will copy the old pointer array to a new array first,
> then update the new array and replace the pointer of old array by the pointer of
> new array.

Very good.  But then why is there a problem?  Is the iteration using
multiple RCU read-side critical sections or something?

> > The usual way to get that property is to leave the old search structure
> > around, replacing it with the new one, and RCU-freeing the old one.
> > In case it helps, Kung and Lehman describe how to do that for search trees:
> >
> > http://www.eecs.harvard.edu/~htk/publication/1980-tods-kung-lehman.pdf
> Thanks for the paper. Just skimming through it, it seems that it uses
> reference-counting and garbage collection to solve the safe memory reclamation
> problem. It may be too heavy for qp-trie and we plan to use seqcount-like way to
> check whether or not the branch and the leaf node is reused during lookup, and
> retry the lookup if it happened. Now just checking the feasibility of the
> solution and it seems a little complicated than expected.

The main thing in that paper is the handling of rotations in the
search-tree update.  But if you are not using a tree, that won't be all
that relevant.

								Thanx, Paul
