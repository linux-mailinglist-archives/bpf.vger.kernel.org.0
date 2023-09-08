Return-Path: <bpf+bounces-9483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D379844C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83E82819DC
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68471FB3;
	Fri,  8 Sep 2023 08:42:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01491849
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 08:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6010BC433C7;
	Fri,  8 Sep 2023 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694162577;
	bh=Uyiizhh+IK0vx+pfmA2p6u6AKOg9RTYS8DWCIf21G5A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FamC6/Of20gd05LQxt7NAEACB17Vv3AlR7tZUcSzzfes1/wOOtGlyY96ylD+hRse0
	 btkJuEuM7wO1ieN6IQ5pDQehHzdgCbSBhvYocNCBCKIl8KybRTgRUrXuX7Xfh7Ujaf
	 x0ztAZh3RBQo3jFTB/NDt6RGghVz4U6Iwa7+9TIQlPXkxJIbpuR8D2P46QqqS/vEqn
	 neFY8uyYE9sTuXCU8TMG/Hcg7oiWRl1/G7WSkqH6QpWzegQtM6bZiJ4ESM13aTbTeJ
	 aetrDGRO25rxVaau8Vf0iAGS16tYGmyAMxJd/E8OE8M+Y7KE+yeuGrLy3GB+69hW/s
	 wmHfilpADDZiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D46BCCE0BB0; Fri,  8 Sep 2023 01:42:56 -0700 (PDT)
Date: Fri, 8 Sep 2023 01:42:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Don <joshdon@google.com>
Cc: Hao Luo <haoluo@google.com>, davemarchevsky@meta.com,
	Tejun Heo <tj@kernel.org>, David Vernet <dvernet@meta.com>,
	Neel Natu <neelnatu@google.com>,
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org,
	ast@kernel.org
Subject: Re: BPF memory model
Message-ID: <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>

On Thu, Sep 07, 2023 at 03:00:56PM -0700, Josh Don wrote:
> Hi Paul,
> 
> I was chatting with Dave Marchevsky about the BPF memory model, and
> had some followup questions you might be able to answer.
> 
> I've been using the built-in RMW operations to do a lot of lockless
> programming, for concurrent BPF-BPF, but also especially for
> userspace-BPF (the latter of which has become a lot more interesting
> with the sched_ext work from Meta). It would of course be nice to
> sometimes lower the synchronization overhead to a hardware barrier or
> a compiler barrier, to allow for general use acquire/release semantics
> (rather than needing to fall back to a lock RMW instruction). I saw
> your presentation from 2021 on this topic here:
> https://lpc.events/event/11/contributions/941/attachments/859/1667/bpf-memory-model.2020.09.22a.pdf
> 
> Has there been any further interest in supporting additional
> kernel-style atomics in BPF that you know of?

This is one of the first that I have heard of.  ;-)

But what BPF programs are you running that are seeing excessive
synchronization overhead?  That will tell us which operations to
start with.  (Or maybe it is time to just add the full Linux-kernel
atomic-operations kitchen sink, but that would not normally be the way
to bet.)

> And on a different BPF note, one thing I wasn't sure about was the
> ability of the cpu to reorder loads and stores across the BPF program
> call boundary. For example, could the load of "z" in the BPF program
> below be reordered before the store to x in the kernel? I'm sure that
> no compiler barrier is ever necessary here since the BPF program is
> compiled separately from the kernel, but I'm not sure whether a
> hardware barrier is necessary.
> <kernel>
> x = 3
> call_bpf();
>   <bpf>
>   int y = z;

Given that a major goal of BPF is the ability to add low-overhead
programs to code on fastpaths, I would not expect any implicit barriers
in that case.  Consider for example counting the number of calls to a
"hot" function in the Linux kernel, in which case adding full ordering
would incur unacceptable performance degradation.  I would instead
expect that the BPF program would need to add explicit barriers or
ordered RMW operations.

But people will not be shy about correcting me if I am confused on
either of these points!

							Thanx, Paul

