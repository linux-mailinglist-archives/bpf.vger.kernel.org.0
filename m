Return-Path: <bpf+bounces-15058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7A7EB06C
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 13:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE51F24A83
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685F3FE27;
	Tue, 14 Nov 2023 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG9w4LHD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AE18637
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B980FC433C7;
	Tue, 14 Nov 2023 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699966760;
	bh=KKuJZTYZBluSmb80QF3UMVQxN/zqipWwj+t34OUqGOE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rG9w4LHDUQIvLeMctg6TFwjBEPx+GYmAeo+BhkQdF9fE0FSWnCl/31TFLRXwxajEo
	 oU9mAlFknRjlqtqUrV2VUZNRydD5S6UmRrhHgNBI0QKKM5YGrX/4eEVZja0Dpuj+Cb
	 sNsb9vkePjFQ8E6UciygKCW28e6nXA4GCRUEcITzJdZ2AmZTCccOQQDbLR6DIZD6JI
	 HtcnQ060ZPriU/SsykVf1CKQ/OwWbGHWw4/n0X01gPyQjeSbNo/u2bdZrcsW+Iacru
	 5BUqbtIjRbusIG5HhmVt6qwRk2CU7nbpzx45frzlT3+yPoA057FiINAZ7imWB4Ofnz
	 dTUIpNluQHwfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D41BACE2119; Tue, 14 Nov 2023 04:58:37 -0800 (PST)
Date: Tue, 14 Nov 2023 04:58:37 -0800
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
Message-ID: <ed634d38-3383-4367-a97d-973800dc64c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
 <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
 <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
 <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
 <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
 <23b55935-0ad4-5a0a-f19a-ba718793902b@linux.dev>
 <f8e1e390-2f12-33c0-cd4b-e59c8223711f@huaweicloud.com>
 <61d71a4f-5216-452b-a695-75fef5d37dd6@paulmck-laptop>
 <0757f77f-9186-39c5-e3f5-c8d3fe530d65@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0757f77f-9186-39c5-e3f5-c8d3fe530d65@huaweicloud.com>

On Mon, Nov 13, 2023 at 08:53:06AM +0800, Hou Tao wrote:
> Hi,
> 
> On 11/10/2023 12:58 PM, Paul E. McKenney wrote:
> > On Fri, Nov 10, 2023 at 11:34:03AM +0800, Hou Tao wrote:
> >> Hi Martin,
> >>
> >> On 11/10/2023 10:48 AM, Martin KaFai Lau wrote:
> >>> On 11/9/23 5:45 PM, Paul E. McKenney wrote:
> >>>>>>>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
> >>>>>>>>>> +{
> >>>>>>>>>> +    struct bpf_inner_map_element *element = ptr;
> >>>>>>>>>> +
> >>>>>>>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks
> >>>>>>>>>> trace
> >>>>>>>>>> +     * RCU grace period, so it is certain that the bpf program
> >>>>>>>>>> which is
> >>>>>>>>>> +     * manipulating the map now has exited when bpf_map_put() is
> >>>>>>>>>> called.
> >>>>>>>>>> +     */
> >>>>>>>>>> +    if (need_defer)
> >>>>>>>>> "need_defer" should only happen from the syscall cmd? Instead of
> >>>>>>>>> adding rcu_head to each element, how about
> >>>>>>>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
> >>>>>>>> No. I have tried the method before, but it didn't work due to
> >>>>>>>> dead-lock
> >>>>>>>> (will mention that in commit message in v2). The reason is that bpf
> >>>>>>>> syscall program may also do map update through sys_bpf helper.
> >>>>>>>> Because
> >>>>>>>> bpf syscall program is running with sleep-able context and has
> >>>>>>>> rcu_read_lock_trace being held, so call
> >>>>>>>> synchronize_rcu_mult(call_rcu,
> >>>>>>>> call_rcu_tasks) will lead to dead-lock.
> >>> Need to think of a less intrusive solution instead of adding rcu_head
> >>> to each element and lookup also needs an extra de-referencing.
> >> I see.
> >>> May be the bpf_map_{update,delete}_elem(&outer_map, ....) should not
> >>> be done by the syscall program? Which selftest does it?
> >> Now bpf_map_update_elem is allowed for bpf_sys_bpf helper. If I
> >> remembered correctly it was map_ptr.
> >>> Can the inner_map learn that it has been deleted from an outer map
> >>> that is used in a sleepable prog->aux->used_maps? The
> >>> bpf_map_free_deferred() will then wait for a task_trace gp?
> >> Considering an inner_map may be used by multiple outer_map, the
> >> following solution will be simpler: if the inner map has been deleted
> >> from an outer map once, its free must be delayed after one RCU GP and
> >> one tasks trace RCU GP. But I will check whether it is possible to only
> >> wait for one RCU GP instead of two.
> > If you are freeing a large quantity of elements at a time, one approach
> > is to use a single rcu_head structure for the group.  (Or, in this case,
> > maybe a pair of rcu_head structures, one for call_rcu() and the other
> > for call_rcu_tasks_trace().)
> >
> > This requires that you be able to link the elements in the group
> > together somehow, which requires some per-element storage, but only
> > one word per element instead of two.
> >
> > There are other variations on this theme, depending on what constraints
> > apply here.
> 
> Thanks for your suggestions. Although there are batch update support for
> inner map, but I think inner map is updated one-by-one at most case. And
> the main concern here is the extra dereference due to memory allocation,
> so I think adding extra flags to indicate bpf_mem_free_deferred() to
> free the map differently may be appropriate.

Whatever gets the job done is of course goodness, and yes, if the freeing
cannot be batched, my suggestion won't help much.  ;-)

							Thanx, Paul

