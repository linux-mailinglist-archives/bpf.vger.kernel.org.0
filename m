Return-Path: <bpf+bounces-74827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0F0C66AED
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E553352A90
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119212EC08C;
	Tue, 18 Nov 2025 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpVea7XV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A3254AE1;
	Tue, 18 Nov 2025 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426518; cv=none; b=u7eNxl65KaCY7tYiVlZ2UUP02PMfFcbTiGl86fZmB+f6Hi3apPR5WN7lq2qNzRdW+UljAlPmEK+8gsLX8qFjeiFxnV1eiamN9Qq+s9jRFjiibosc3MB4YjcHPOvdGDJopd+SdV+Ih8/QCOI2AdsI/LJQQ93gYsBETcdxSrJu1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426518; c=relaxed/simple;
	bh=xfZHz3v2ewR46Sew96PsxefW8LblD1BtQqdSnA7/hpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgl7Lj02o3ZLlfv9zeYANLq8vxNnfM5OHYykJCo8uhu/UwyJy5UVseBSXcQumdRkIgzcGC8ithvpUGzDW/tm9bQ0y86xVzBfjnlx9uud4z22oFl83ZVdzpLAYr3xtNrWxZHyVRakPSJftxDYq8apW+8Qu0jc4qakSYgLMTlTyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpVea7XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F94C2BCB2;
	Tue, 18 Nov 2025 00:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426518;
	bh=xfZHz3v2ewR46Sew96PsxefW8LblD1BtQqdSnA7/hpo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qpVea7XV0nMdbO4MV5Lx+3Ws+eBv2q7EP4DClJwAdF/2T02uPz9jQrSr7BEPRv+C7
	 9RzQvw0qrC+NhGG3tfHCFxu5+8xTl6gm/xKAuWbEFeap/+IimihgnM3+bE4izdIcYS
	 UaCFCdNYXJpgejbFa6dNUquhexQVxfdYG2hPnLXt/SR5InFqTj7IqPNJb/am0Qa3Z/
	 FyR0pij0iYGySQNoo8V6enBRRrppmGZ4xJhwbrizGPzqoCPdWqCDh5swyNZA3mQTWt
	 8nobIMiW4aIy/Iu5P4TcLsS9AcIw1KSxIbbOZYfIG5Cg2N/YPQhik08zhKuLXfVBkz
	 WtLfqFH5cptZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B889CCE0B6A; Mon, 17 Nov 2025 16:41:56 -0800 (PST)
Date: Mon, 17 Nov 2025 16:41:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
Message-ID: <db1fb12b-dfd1-4f2e-bc0c-c29515963bc1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
 <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
 <CAADnVQ+FC5dscjW0MQbG2qYP7KSQ2Ld6LCt5uK8+M2xreyeU7w@mail.gmail.com>
 <450751b2-5bc4-4c76-b9ca-019b87b96074@paulmck-laptop>
 <CAMB2axM==X6+WJFenbuwTn82=2iRL-5_GCmj5RmK_fsGf07x7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axM==X6+WJFenbuwTn82=2iRL-5_GCmj5RmK_fsGf07x7w@mail.gmail.com>

On Mon, Nov 17, 2025 at 04:24:56PM -0800, Amery Hung wrote:
> On Mon, Nov 17, 2025 at 3:46 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 17, 2025 at 03:36:08PM -0800, Alexei Starovoitov wrote:
> > > On Mon, Nov 17, 2025 at 12:37 PM Amery Hung <ameryhung@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 14, 2025 at 6:01 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 14, 2025 at 12:13 PM Amery Hung <ameryhung@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > > -       if (smap->bpf_ma) {
> > > > > > +       if (smap->use_kmalloc_nolock) {
> > > > > >                 rcu_barrier_tasks_trace();
> > > > > > -               if (!rcu_trace_implies_rcu_gp())
> > > > > > -                       rcu_barrier();
> > > > > > -               bpf_mem_alloc_destroy(&smap->selem_ma);
> > > > > > -               bpf_mem_alloc_destroy(&smap->storage_ma);
> > > > > > +               rcu_barrier();
> > > > >
> > > > > Why unconditional rcu_barrier() ?
> > > > > It's implied in rcu_barrier_tasks_trace().
> > > >
> > > > Hmm, I am not sure.
> > > >
> > > > > What am I missing?
> > > >
> > > > I hit a UAF in v1 in bpf_selem_free_rcu() when running selftests and
> > > > making rcu_barrier() unconditional addressed it. I think the bug was
> > > > due to map_free() not waiting for bpf_selem_free_rcu() (an RCU
> > > > callback) to finish.
> > > >
> > > > Looking at rcu_barrier() and rcu_barrier_tasks_trace(), they pass
> > > > different rtp to rcu_barrier_tasks_generic() so I think both are
> > > > needed to make sure in-flight RCU and RCU tasks trace callbacks are
> > > > done.
> > > >
> > > > Not an expert in RCU so I might be wrong and it was something else.
> > >
> > > Paul,
> > >
> > > Please help us here.
> > > Does rcu_barrier_tasks_trace() imply rcu_barrier() ?
> >
> > I am sorry, but no, it does not.
> 
> Thanks for the clarification, Paul!

No problem!

> > If latency proves to be an issue, one approach is to invoke rcu_barrier()
> > and rcu_barrier_tasks_trace() each in its own workqueue handler.  But as
> > always, I suggest invoking them one after the other to see if a latency
> > problem really exists before adding complexity.
> >
> > Except that rcu_barrier_tasks_trace() is never invoked by rcu_barrier(),
> > only rcu_barrier_tasks() and rcu_barrier_tasks_trace().  So do you really
> > mean rcu_barrier()?  Or rcu_barrier_tasks()?
> 
> Sorry for the confusion. I misread the code. I was trying to say that
> rcu_barrier() and rcu_barrier_tasks_trace() seem to wait on different
> callacks but then referring to rcu_barrier_tasks() implementation
> wrongly.

Well, you did reach the correct conclusion, even if by dubious means.  ;-)

							Thanx, Paul

> > Either way, rcu_barrier_tasks() and rcu_barrier_tasks_trace() are also
> > independent of each other in the sense that if you need tw wait on
> > callbacks from both call_rcu_tasks() and call_rcu_tasks_trace(), you
> > need both rcu_barrier_tasks() and rcu_barrier_tasks_trace() to be invoked.
> >
> >                                                         Thanx, Paul

