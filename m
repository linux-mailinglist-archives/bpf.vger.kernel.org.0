Return-Path: <bpf+bounces-14716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ECF7E78A0
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 05:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C28B20FCA
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 04:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A81FDA;
	Fri, 10 Nov 2023 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cadC9vdo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369A111B
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 04:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117D4C43391;
	Fri, 10 Nov 2023 04:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699592333;
	bh=v2AuGNwtvuGyPoXp8otkZYqoO1Bb8t79T5dnXL36k3k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cadC9vdovtPcns33+HLsSTMmv0D2razRLsIQlzLoZNUli1oBnPEsIPJ2HfUHbqjnb
	 rIvVM6EevwsLDCwXEGHLmR5OOiPaRCBPAYNgljeeqHiBYp414MNdbGHrDfz7qmB2Q8
	 dVLAO/V06FWxJDqTD/rS5fo0kMbPAjxLPQEmmc0FgpOrnQIk3O0NkGQrj7glG/yLJe
	 dFKQDGy7M8aJas8V+jReeYRB6AVpgeY4MM3q4FLedwYxu+rmkIDhkToWWU7Mpdn+JX
	 iFLyf/WFL4JO0V4y8CzqZQTids6YNuFIhsHat83pbP5mggxXMeqn5plasBkdyVdbXH
	 LcAZXG9Qrznaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9CBE0CE1999; Thu,  9 Nov 2023 20:58:51 -0800 (PST)
Date: Thu, 9 Nov 2023 20:58:51 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf <bpf@vger.kernel.org>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
Message-ID: <61d71a4f-5216-452b-a695-75fef5d37dd6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com>
 <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
 <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
 <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
 <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
 <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
 <23b55935-0ad4-5a0a-f19a-ba718793902b@linux.dev>
 <f8e1e390-2f12-33c0-cd4b-e59c8223711f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8e1e390-2f12-33c0-cd4b-e59c8223711f@huaweicloud.com>

On Fri, Nov 10, 2023 at 11:34:03AM +0800, Hou Tao wrote:
> Hi Martin,
> 
> On 11/10/2023 10:48 AM, Martin KaFai Lau wrote:
> > On 11/9/23 5:45 PM, Paul E. McKenney wrote:
> >>>>>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
> >>>>>>>> +{
> >>>>>>>> +    struct bpf_inner_map_element *element = ptr;
> >>>>>>>> +
> >>>>>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks
> >>>>>>>> trace
> >>>>>>>> +     * RCU grace period, so it is certain that the bpf program
> >>>>>>>> which is
> >>>>>>>> +     * manipulating the map now has exited when bpf_map_put() is
> >>>>>>>> called.
> >>>>>>>> +     */
> >>>>>>>> +    if (need_defer)
> >>>>>>> "need_defer" should only happen from the syscall cmd? Instead of
> >>>>>>> adding rcu_head to each element, how about
> >>>>>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
> >>>>>> No. I have tried the method before, but it didn't work due to
> >>>>>> dead-lock
> >>>>>> (will mention that in commit message in v2). The reason is that bpf
> >>>>>> syscall program may also do map update through sys_bpf helper.
> >>>>>> Because
> >>>>>> bpf syscall program is running with sleep-able context and has
> >>>>>> rcu_read_lock_trace being held, so call
> >>>>>> synchronize_rcu_mult(call_rcu,
> >>>>>> call_rcu_tasks) will lead to dead-lock.
> >
> > Need to think of a less intrusive solution instead of adding rcu_head
> > to each element and lookup also needs an extra de-referencing.
> 
> I see.
> >
> > May be the bpf_map_{update,delete}_elem(&outer_map, ....) should not
> > be done by the syscall program? Which selftest does it?
> 
> Now bpf_map_update_elem is allowed for bpf_sys_bpf helper. If I
> remembered correctly it was map_ptr.
> >
> > Can the inner_map learn that it has been deleted from an outer map
> > that is used in a sleepable prog->aux->used_maps? The
> > bpf_map_free_deferred() will then wait for a task_trace gp?
> 
> Considering an inner_map may be used by multiple outer_map, the
> following solution will be simpler: if the inner map has been deleted
> from an outer map once, its free must be delayed after one RCU GP and
> one tasks trace RCU GP. But I will check whether it is possible to only
> wait for one RCU GP instead of two.

If you are freeing a large quantity of elements at a time, one approach
is to use a single rcu_head structure for the group.  (Or, in this case,
maybe a pair of rcu_head structures, one for call_rcu() and the other
for call_rcu_tasks_trace().)

This requires that you be able to link the elements in the group
together somehow, which requires some per-element storage, but only
one word per element instead of two.

There are other variations on this theme, depending on what constraints
apply here.

							Thanx, Paul

