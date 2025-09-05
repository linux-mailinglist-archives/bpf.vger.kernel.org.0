Return-Path: <bpf+bounces-67588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D5B4602A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954801BC8E11
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726ED34F482;
	Fri,  5 Sep 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BpTCvPUk"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069D4D599
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093480; cv=none; b=K2Z2tsulLLTgu88MPrHm+NIk35S76LcDmr0D2yRm2hNmq9pPSZWU0F7m+VDRLHrfKpqBK3xhSwKLrmy8537XS6bwSg/z4j9PtVnStWMIniJfsCfJdarhKsYrZeey7uK5RqunyzPIwxkpDJ9R8iU1BMdciue2LBnlKRDVdi8wWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093480; c=relaxed/simple;
	bh=fnCM7kciL/wRTgi7qXWfJ/zXcNESklBB6MilqOk6Ijk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHBzVepSo7hvtA868a9ODPL5beDzx7/2C4wc+9x+EkVHFGtb9Zkylg+K/DWHGgw+ppBtRK61YNyWtpFiJcvBb/rcF+DLFiu/MUYQFE2jPqKZAhuwWpFFRuMqJtqIOI4LylGKk+zUWqjjOYFeg3DvcC8AIRYXpSPSbe+D4Q0tEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BpTCvPUk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 10:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757093476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKUOxUkpu87y0JAxWfPS0hdSys91o2uD8NOBJG7K0rg=;
	b=BpTCvPUktRzrG+iXU0FzgQsLrNO2LYX/uFi6fH2cRqj6a/1KhipVksQ2SzTj1j6pEg3Jw7
	mT8SfMHdOBXj8e1SwcUd3N3soT8ljERduQ2Zx9tT4ay/QAmVs7i7VcL4r5IKDxvPVOWduw
	q9fU3PHD3PFGDI/uOcbPBJEYO01JLU4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peilin Ye <yepeilin@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>
References: <20250905061919.439648-1-yepeilin@google.com>
 <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 08:18:25AM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 4, 2025 at 11:20 PM Peilin Ye <yepeilin@google.com> wrote:
> >
> > Calling bpf_map_kmalloc_node() from __bpf_async_init() can cause various
> > locking issues; see the following stack trace (edited for style) as one
> > example:
> >
> > ...
> >  [10.011566]  do_raw_spin_lock.cold
> >  [10.011570]  try_to_wake_up             (5) double-acquiring the same
> >  [10.011575]  kick_pool                      rq_lock, causing a hardlockup
> >  [10.011579]  __queue_work
> >  [10.011582]  queue_work_on
> >  [10.011585]  kernfs_notify
> >  [10.011589]  cgroup_file_notify
> >  [10.011593]  try_charge_memcg           (4) memcg accounting raises an
> >  [10.011597]  obj_cgroup_charge_pages        MEMCG_MAX event
> >  [10.011599]  obj_cgroup_charge_account
> >  [10.011600]  __memcg_slab_post_alloc_hook
> >  [10.011603]  __kmalloc_node_noprof
> > ...
> >  [10.011611]  bpf_map_kmalloc_node
> >  [10.011612]  __bpf_async_init
> >  [10.011615]  bpf_timer_init             (3) BPF calls bpf_timer_init()
> >  [10.011617]  bpf_prog_xxxxxxxxxxxxxxxx_fcg_runnable
> >  [10.011619]  bpf__sched_ext_ops_runnable
> >  [10.011620]  enqueue_task_scx           (2) BPF runs with rq_lock held
> >  [10.011622]  enqueue_task
> >  [10.011626]  ttwu_do_activate
> >  [10.011629]  sched_ttwu_pending         (1) grabs rq_lock
> > ...
> >
> > The above was reproduced on bpf-next (b338cf849ec8) by modifying
> > ./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
> > ops.runnable(), and hacking [1] the memcg accounting code a bit to make
> > it (much more likely to) raise an MEMCG_MAX event from a
> > bpf_timer_init() call.
> >
> > We have also run into other similar variants both internally (without
> > applying the [1] hack) and on bpf-next, including:
> >
> >  * run_timer_softirq() -> cgroup_file_notify()
> >    (grabs cgroup_file_kn_lock) -> try_to_wake_up() ->
> >    BPF calls bpf_timer_init() -> bpf_map_kmalloc_node() ->
> >    try_charge_memcg() raises MEMCG_MAX ->
> >    cgroup_file_notify() (tries to grab cgroup_file_kn_lock again)
> >
> >  * __queue_work() (grabs worker_pool::lock) -> try_to_wake_up() ->
> >    BPF calls bpf_timer_init() -> bpf_map_kmalloc_node() ->
> >    try_charge_memcg() raises MEMCG_MAX -> m() ->
> >    __queue_work() (tries to grab the same worker_pool::lock)
> >  ...
> >
> > As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> > bpf_hrtimer and bpf_work, to skip memcg accounting.
> 
> This is a short term workaround that we shouldn't take.
> Long term bpf_mem_alloc() will use kmalloc_nolock() and
> memcg accounting that was already made to work from any context
> except that the path of memcg_memory_event() wasn't converted.
> 
> Shakeel,
> 
> Any suggestions how memcg_memory_event()->cgroup_file_notify()
> can be fixed?
> Can we just trylock and skip the event?

Will !gfpflags_allow_spinning(gfp_mask) be able to detect such call
chains? If yes, then we can change memcg_memory_event() to skip calls to
cgroup_file_notify() if spinning is not allowed.

