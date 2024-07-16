Return-Path: <bpf+bounces-34919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5779329C4
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B709280F4C
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487419D097;
	Tue, 16 Jul 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v9WstOPZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E01990D7
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141596; cv=none; b=jigQjOSqBrnKbh+Y8V06ZQ2xY8K8KqIKpFVJHhaI1grCQtlseRBm0T4s9GorEFwXHcPyIjORr3l9ULXkPEG8O+QL3Tq5GR1amWPrujpmPokOTUH7EAinKskvd/1um7Emt5ub99Il3CvwfJZBOqFgxHD0qJo0ZScddRulTet89NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141596; c=relaxed/simple;
	bh=7oKTwM0hEprlyuW4WVtS91nyNIkr4Ba3tkadujS8A7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8zT40PkI4AsgmVsmZ7R9hmn6dq6/Yen0FoL0Lv5yKHK2jtH1KucMNiEU6OuGZIOXqgYEGY3oiQ7kZpxNn7v2APVdJ/wRmBqU93ahy+5Wn1PL1sqtDwgOdKUA8uZDt1JVA4WyFCnzmORVBDxuDQJDlgQWExMtrLUpZPPQv6mXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v9WstOPZ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: chenridong@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721141591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FP4n22+iU/rM22MavGx8TeM69+CmD5kfDoX2X7lRpqs=;
	b=v9WstOPZ1cHIkeGJgEacvtBfhvH8Ht9LRJ+pVzSloChphtxmhR/WgF8dkdS3UdzuWZfBa+
	FJm2o/wRJqx5tRm+/ZWnprGDdbRLLeWrhtkQzC1ZwwZPafIHDLxu3AkZ/wbNZgu9tLsmMs
	u7md5z1vcsjMl+EYVAU/gIpU7q/1XEI=
X-Envelope-To: tj@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 16 Jul 2024 14:53:04 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: chenridong <chenridong@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, martin.lau@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
Message-ID: <ZpaJUIyiDguRQWSn@google.com>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
 <300f9efa-cc15-4bee-b710-25bff796bf28@huawei.com>
 <a1b23274-4a35-4cbf-8c4c-5f770fbcc187@huawei.com>
 <Zo9XAmjpP6y0ZDGH@google.com>
 <ZpAYGU7x6ioqBir5@slm.duckdns.org>
 <5badbb85-b9e9-4170-a1b9-9b6d13135507@huawei.com>
 <c6d10b39-4583-4162-b481-375f41aaeba1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d10b39-4583-4162-b481-375f41aaeba1@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 16, 2024 at 08:14:31PM +0800, chenridong wrote:
> 
> 
> On 2024/7/12 9:15, chenridong wrote:
> > 
> > 
> > On 2024/7/12 1:36, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Thu, Jul 11, 2024 at 03:52:34AM +0000, Roman Gushchin wrote:
> > > > > The max_active of system_wq is WQ_DFL_ACTIVE(256). If all
> > > > > active works are
> > > > > cgroup bpf release works, it will block smp_call_on_cpu work
> > > > > which enque
> > > > > after cgroup bpf releases. So smp_call_on_cpu holding
> > > > > cpu_hotplug_lock will
> > > > > wait for completion, but it can never get a completion
> > > > > because cgroup bpf
> > > > > release works can not get cgroup_mutex and will never finish.
> > > > > However, Placing the cgroup bpf release works on cgroup
> > > > > destroy will never
> > > > > block smp_call_on_cpu work, which means loop is broken.
> > > > > Thus, it can solve
> > > > > the problem.
> > > > 
> > > > Tejun,
> > > > 
> > > > do you have an opinion on this?
> > > > 
> > > > If there are certain limitations from the cgroup side on what
> > > > can be done
> > > > in a generic work context, it would be nice to document (e.g. don't grab
> > > > cgroup mutex), but I still struggle to understand what exactly is wrong
> > > > with the blamed commit.
> > > 
> > > I think the general rule here is more "don't saturate system wqs" rather
> > > than "don't grab cgroup_mutex from system_wq". system wqs are for misc
> > > things which shouldn't create a large number of concurrent work items. If
> > > something is going to generate 256+ concurrent work items, it should
> > > use its
> > > own workqueue. We don't know what's in system wqs and can't expect
> > > its users
> > > to police specific lock usages.
> > > 
> > Thank you, Tj. That's exactly what I'm trying to convey. Just like
> > cgroup, which has its own workqueue and may create a large number of
> > release works, it is better to place all its related works on its
> > workqueue rather than on system wqs.
> > 
> > Regards,
> > Ridong
> > 
> > > Another aspect is that the current WQ_DFL_ACTIVE is an arbitrary number I
> > > came up with close to 15 years ago. Machine size has increased by
> > > multiple
> > > times, if not an order of magnitude since then. So, "there can't be a
> > > reasonable situation where 256 concurrency limit isn't enough" is most
> > > likely not true anymore and the limits need to be pushed upward.
> > > 
> > > Thanks.
> > > 
> > 
> Hello, Tejun, and Roman, is the patch acceptable? Do I need to take any
> further actions?
> 

I'm not against merging it. I still find the explanation/commit message
a bit vague and believe that maybe some changes need to be done on the watchdog
side to make such lockups impossible. As I understand the two most important
pieces are the watchdog which tries to run a system work on every cpu while
holding cpu_hotplug_lock on read and the cpuset controller which tries
to grab cpu_hotplug_lock on writing.

It's indeed a tricky problem, so maybe there is no simple and clear explanation.

Anyway thank you for finding the problem and providing a reproducer!

Thanks!

