Return-Path: <bpf+bounces-14676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F0B7E76C6
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7495B2811E3
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917CEA4;
	Fri, 10 Nov 2023 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgMAp0kz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97EA47
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23760C433C7;
	Fri, 10 Nov 2023 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699580738;
	bh=MF/4Hy96k6GBb7R9eqRA4Yb1UPzZ3IbQlM7JbBNVhqQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BgMAp0kzZP6JX60dC7CwPTCzsHXibxVBVqouVMeFePCr9P54057/OaQx1pAsimtcX
	 MAxMITEN0gxIGoVeAvtjntr5/NH3xm2ZPIWKzh53IiMkB5t8CkhxTzSgHXNvIPjLBJ
	 sU0mcr66PViukOFWVM9nmVlyo75pZZPNTiGwz2mSDA7BrB/AqZtuiwABzv3AmyOKRj
	 dFmvmz09GdDV+5AsfQ10NRb+9yoezI8E82ViePBF1BYT57PGjF4Zw4R1H6mg46cvDI
	 ZAQQEgRVInTrcAcFVvtNzZ9x0Oudah5dGUHUUnmAJbtkhBKK/963lSFiPzPAxxLkWP
	 obl2O4N0sKwPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CAB64CE1999; Thu,  9 Nov 2023 17:45:34 -0800 (PST)
Date: Thu, 9 Nov 2023 17:45:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hou Tao <houtao1@huawei.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
Message-ID: <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com>
 <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
 <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
 <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
 <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>

On Fri, Nov 10, 2023 at 09:06:56AM +0800, Hou Tao wrote:
> Hi,
> 
> On 11/10/2023 3:55 AM, Paul E. McKenney wrote:
> > On Thu, Nov 09, 2023 at 07:55:50AM -0800, Alexei Starovoitov wrote:
> >> On Wed, Nov 8, 2023 at 11:26 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >>> Hi,
> >>>
> >>> On 11/9/2023 2:36 PM, Martin KaFai Lau wrote:
> >>>> On 11/7/23 6:06 AM, Hou Tao wrote:
> >>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>
> >>>>> bpf_map_of_map_fd_get_ptr() will convert the map fd to the pointer
> >>>>> saved in map-in-map. bpf_map_of_map_fd_put_ptr() will release the
> >>>>> pointer saved in map-in-map. These two helpers will be used by the
> >>>>> following patches to fix the use-after-free problems for map-in-map.
> >>>>>
> >>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>>> ---
> >>>>>   kernel/bpf/map_in_map.c | 51 +++++++++++++++++++++++++++++++++++++++++
> >>>>>   kernel/bpf/map_in_map.h | 11 +++++++--
> >>>>>   2 files changed, 60 insertions(+), 2 deletions(-)
> >>>>>
> >>>>>
> >>> SNIP
> >>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
> >>>>> +{
> >>>>> +    struct bpf_inner_map_element *element = ptr;
> >>>>> +
> >>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks trace
> >>>>> +     * RCU grace period, so it is certain that the bpf program which is
> >>>>> +     * manipulating the map now has exited when bpf_map_put() is
> >>>>> called.
> >>>>> +     */
> >>>>> +    if (need_defer)
> >>>> "need_defer" should only happen from the syscall cmd? Instead of
> >>>> adding rcu_head to each element, how about
> >>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
> >>> No. I have tried the method before, but it didn't work due to dead-lock
> >>> (will mention that in commit message in v2). The reason is that bpf
> >>> syscall program may also do map update through sys_bpf helper. Because
> >>> bpf syscall program is running with sleep-able context and has
> >>> rcu_read_lock_trace being held, so call synchronize_rcu_mult(call_rcu,
> >>> call_rcu_tasks) will lead to dead-lock.
> >> Dead-lock? why?
> >>
> >> I think it's legal to do call_rcu_tasks_trace() while inside RCU CS
> >> or RCU tasks trace CS.
> > Just confirming that this is the case.  If invoking call_rcu_tasks_trace()
> > within under either rcu_read_lock() or rcu_read_lock_trace() deadlocks,
> > then there is a bug that needs fixing.  ;-)
> 
> The case for dead-lock is that calling synchronize_rcu_mult(call_rcu,
> call_rcu_tasks_trace) within under rcu_read_lock_trace() and I think it
> is expected. The case that calling call_rcu_tasks_trace() with
> rcu_read_lock_trace() being held is OK.

Very good, you are quite right.  In this particular case, deadlock is
expected behavior.

The problem here is that synchronize_rcu_mult() doesn't just invoke its
arguments, instead, it also waits for all of the corresponding grace
periods to complete.  But if you call this while under the protection of
rcu_read_lock_trace(), then synchronize_rcu_mult(call_rcu_tasks_trace)
cannot return until the corresponding rcu_read_unlock_trace() is
reached, but that rcu_read_unlock_trace() cannot be reached until after
synchronize_rcu_mult(call_rcu_tasks_trace) returns.

(I did leave out the call_rcu argument because it does not participate
in this particular deadlock.)

							Thanx, Paul

