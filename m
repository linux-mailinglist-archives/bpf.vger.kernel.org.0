Return-Path: <bpf+bounces-10368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656117A5E9B
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE13A282147
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB73FB38;
	Tue, 19 Sep 2023 09:52:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED75538C
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E366C433C8;
	Tue, 19 Sep 2023 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695117126;
	bh=FX1cnRlb3O6rxZ9f+WVi159ypwdXAk1xbue8JbMVBNw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TbuKPe+p8HkzJ2I68rtfH/29K0mRx4t33w88mZGMLxKssu9XXBNzP1zfqJZ/zSMsP
	 mXz5TYqNDD6sJlTtxDtxVr1eX6f3vpw97MTuwsK5ktiliBpS/RQxH0477+yhwpDdVw
	 IuO+RHmoUdBejeXRKeXG6fyqjZ5igbeUTVYqsKhPEXq3+59tcPFmZtGj/MjFyw7zBC
	 JPSwgp3IU47OG9ALzfLm5cdnKG+HimXPMHBbm0HROJX/Ollitrud4jv9tX1vCQoFp6
	 SineHgOKV6pIabvzAzE8WGZdNObVvZ6s6d1ZjtHiW+0Waic82naUAo1fLcPpV4ss9j
	 iW+3HB9CtjrWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04E2DCE0975; Tue, 19 Sep 2023 02:52:04 -0700 (PDT)
Date: Tue, 19 Sep 2023 02:52:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Barret Rhoden <brho@google.com>
Cc: Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
	davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org,
	ast@kernel.org
Subject: Re: BPF memory model
Message-ID: <e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>

On Mon, Sep 18, 2023 at 11:09:26AM -0400, Barret Rhoden wrote:
> On 9/8/23 04:42, Paul E. McKenney wrote:
> > But what BPF programs are you running that are seeing excessive
> > synchronization overhead? That will tell us which operations to start
> > with. (Or maybe it is time to just add the full Linux-kernel
> > atomic-operations kitchen sink, but that would not normally be the way
> > to bet.)
> 
> Here's what I use in BPF, (also for writing parallel schedulers):
> - READ_ONCE/WRITE_ONCE
> - compiler atomic builtins, like CAS, swap/exchange, fetch_and_add, etc.
> - smp_store_release, __atomic_load_n, etc.
> - at one point, i was sprinkling asm volatile ("" ::: "memory") around too,
> though not in any active code at the moment.

Good to know, thank you very much!!!

> My mental model, right or wrong, is that I am operating under something like
> the LKMM, and that I need to convince the compiler to spit out the right
> code (sort of like writing shared memory code to talk to a device or
> userspace) and hope the JIT does the right thing.

Just to make sure that I understand, the idea is to compile from (say)
__atomic_load_n() to BPF instructions, correct?  Or is this compiling
all the way to the target x86/ARMv8/whatever machine instructions?

							Thanx, Paul

