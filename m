Return-Path: <bpf+bounces-39537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CE97447D
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 23:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB521C20CCB
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8AC1AB52D;
	Tue, 10 Sep 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lqlkbteB"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4E1A7AE2
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002195; cv=none; b=PUtHhsTviRGkFyAcNJtLFeSXtz2m/kHX/pkVmAH8uWg9okgeuHpD/qVYIsci7JKyUKhn4nX1bURirZEpKQjOeMH2wt2t6QzrIabbv/M8qxHD0Ge00nJvQ+sgyFSPnxmKxWeV/WhtoZSw+GMBHK5xaJWQmiWtCQrlFVO3XP+YHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002195; c=relaxed/simple;
	bh=hlEYni8fOLnkCWMm8r07WgYSK1hynH9xu0T5bSqq5No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaADKzI2IC0ccMdcrtI2Ia7eI9a3W7nKmTTUAbFeAQOMMR7U1q4WctaEhmq4LwJjDnI3uzF4yh8IaUU0L0CRFpAz7to4A3wf88DcVr8Tb5DwToJjteyNgsBGUTZQbxrYjERKxjrs2iBdvfd8L7scV3H/qKiaBh5iGql/PZIj4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lqlkbteB; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 21:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726002188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsVo8obNrl4B56Z1DT7qfsDEPK0f8VCrizIedNb7y58=;
	b=lqlkbteBtNaegQrtJh9zP/apV9nd3yEsmo007zqH75d5V6vUQ+CtnidmkHezK0hXYKelBz
	dXx+Vq+b6qBzXhs6vxVYZox9qjdiUfdKtyxkSGlTVXorDNFDAJ+Md0xb5+JrTSk8NnOvIF
	PdQbNdNyyxODjdSz5WPSi9YE7sBVB+E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huawei.com>, martin.lau@linux.dev,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <ZuC0A98pxYc3TODM@google.com>
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
 <07501c67-3b18-48e3-8929-e773d8d6920f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07501c67-3b18-48e3-8929-e773d8d6920f@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 10, 2024 at 09:31:41AM +0800, Chen Ridong wrote:
> 
> 
> On 2024/9/9 22:19, Michal Koutný wrote:
> > On Sat, Aug 17, 2024 at 09:33:34AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> > > The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
> > > acquired in different tasks, which may lead to deadlock.
> > > It can lead to a deadlock through the following steps:
> > > 1. A large number of cpusets are deleted asynchronously, which puts a
> > >     large number of cgroup_bpf_release works into system_wq. The max_active
> > >     of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
> > >     cgroup_bpf_release works, and many cgroup_bpf_release works will be put
> > >     into inactive queue. As illustrated in the diagram, there are 256 (in
> > >     the acvtive queue) + n (in the inactive queue) works.
> > > 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
> > >     smp_call_on_cpu work into system_wq. However step 1 has already filled
> > >     system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
> > >     to wait until the works that were put into the inacvtive queue earlier
> > >     have executed (n cgroup_bpf_release), so it will be blocked for a while.
> > > 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
> > > 4. Cpusets that were deleted at step 1 put cgroup_release works into
> > >     cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
> > >     When cgroup_metux is acqured by work at css_killed_work_fn, it will
> > >     call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
> > >     However, cpuset_css_offline will be blocked for step 3.
> > > 5. At this moment, there are 256 works in active queue that are
> > >     cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
> > >     a result, all of them are blocked. Consequently, sscs.work can not be
> > >     executed. Ultimately, this situation leads to four processes being
> > >     blocked, forming a deadlock.
> > > 
> > > system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
> > > ...
> > > 2000+ cgroups deleted asyn
> > > 256 actives + n inactives
> > > 				__lockup_detector_reconfigure
> > > 				P(cpu_hotplug_lock.read)
> > > 				put sscs.work into system_wq
> > > 256 + n + 1(sscs.work)
> > > sscs.work wait to be executed
> > > 				warting sscs.work finish
> > > 								percpu_down_write
> > > 								P(cpu_hotplug_lock.write)
> > > 								...blocking...
> > > 											css_killed_work_fn
> > > 											P(cgroup_mutex)
> > > 											cpuset_css_offline
> > > 											P(cpu_hotplug_lock.read)
> > > 											...blocking...
> > > 256 cgroup_bpf_release
> > > mutex_lock(&cgroup_mutex);
> > > ..blocking...
> > 
> > Thanks, Ridong, for laying this out.
> > Let me try to extract the core of the deps above.
> > 
> > The correct lock ordering is: cgroup_mutex then cpu_hotplug_lock.
> > However, the smp_call_on_cpu() under cpus_read_lock may lead to
> > a deadlock (ABBA over those two locks).
> > 
> 
> That's right.
> 
> > This is OK
> > 	thread T					system_wq worker
> > 	
> > 	  						lock(cgroup_mutex) (II)
> > 							...
> > 							unlock(cgroup_mutex)
> > 	down(cpu_hotplug_lock.read)
> > 	smp_call_on_cpu
> > 	  queue_work_on(cpu, system_wq, scss) (I)
> > 							scss.func
> > 	  wait_for_completion(scss)
> > 	up(cpu_hotplug_lock.read)
> > 
> > However, there is no ordering between (I) and (II) so they can also happen
> > in opposite
> > 
> > 	thread T					system_wq worker
> > 	
> > 	down(cpu_hotplug_lock.read)
> > 	smp_call_on_cpu
> > 	  queue_work_on(cpu, system_wq, scss) (I)
> > 	  						lock(cgroup_mutex)  (II)
> > 							...
> > 							unlock(cgroup_mutex)
> > 							scss.func
> > 	  wait_for_completion(scss)
> > 	up(cpu_hotplug_lock.read)
> > 
> > And here the thread T + system_wq worker effectively call
> > cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
> > two threads, it won't be caught by lockdep.)
> > 
> > By that reasoning any holder of cgroup_mutex on system_wq makes system
> > susceptible to a deadlock (in presence of cpu_hotplug_lock waiting
> > writers + cpuset operations). And the two work items must meet in same
> > worker's processing hence probability is low (zero?) with less than
> > WQ_DFL_ACTIVE items.

Right, I'm on the same page. Should we document then somewhere that
the cgroup mutex can't be locked from a system wq context?

I think thus will also make the Fixes tag more meaningful.

Thank you!

