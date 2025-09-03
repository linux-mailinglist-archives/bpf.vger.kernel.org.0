Return-Path: <bpf+bounces-67355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193A6B42D70
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EE41C21D60
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A5277007;
	Wed,  3 Sep 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gYjEgMLd"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71B21CA14
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942233; cv=none; b=MJi6tOT3gdop7/4JzZmilbPIsn5LLKPriymWoO72HVif6kw2Qp2ZKvf/zSfwq9qvLQvaSo3NHYC99h9RXd14GKAQnoML7Nfn5nTXyE/I+KaNB81bzpQIsJoLhSl8X7FDZ+uaOL/BOTssFt/9cv+G9MMjYWUpcv7hoB0t8/dotHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942233; c=relaxed/simple;
	bh=9k8cwHFfS6mQi0rNbfS1VSFnFMFfe9G0/khjroNDtY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KM7VXKBt/43chNmFyee5QaM+Y91XzkoY4zVQiZQXj4QTiAj87jfC36vIyOe6MBoRWzWwpv5QTK0RtdqLMLZgfUCURLxloVY7+iDo2VRn0rgu9Tn99m7tEqYyoetxnkCNWebjPRGMD+0x2drdbk9TZoDmnjLxlWWGH33GQN4jYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gYjEgMLd; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756942224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gF9nx6eMMapslYLJpUtDnYswISTCfOBidr6oM0KZc8=;
	b=gYjEgMLdGEMiHywRyPh4AwLwNc75TYOydh6kp33yMxnfVzV1BouIN0nxrkTulAYnaG2JBi
	yZsMEjQd92BV97Vi3eqFf0h1TtMm8Dv2xXaojDidujJ3jIoGt98F/++5B/gzwgQ/l0XafC
	yAAYoXegRTtt4lnB867FOPkjVtCwobw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  linux-mm <linux-mm@kvack.org>,  bpf <bpf@vger.kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,
  Matt Bobrowski <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
In-Reply-To: <aLeLzWygjrTsgBo8@slm.duckdns.org> (Tejun Heo's message of "Tue,
	2 Sep 2025 14:29:01 -1000")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	<87iki0n4lm.fsf@linux.dev> <aLeLzWygjrTsgBo8@slm.duckdns.org>
Date: Wed, 03 Sep 2025 16:30:16 -0700
Message-ID: <87qzwnxgfr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> Hello, Roman. How are you?

Hi Tejun! Thank you for the links...

>
> On Tue, Sep 02, 2025 at 10:31:33AM -0700, Roman Gushchin wrote:
> ...
>> Btw, what's the right way to attach struct ops to a cgroup, if there is
>> one? Add a cgroup_id field to the struct and use it in the .reg()
>> callback? Or there is something better?
>
> So, I'm trying to do something similar with sched_ext. Right now, I only
> have a very rough prototype (I can attach multiple schedulers with warnings
> and they even can schedule for several seconds before melting down).
> However, the basic pieces should may still be useful. The branch is:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-hier-prototype
>
> There are several pieces:
>
> - cgroup recently grew lifetime notifiers that you can hook in there to
>   receive on/offline events. This is useful for initializing per-cgroup
>   fields and cleaning up when cgroup dies:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5469

This is neat, I might use this for the psi struct ops to give a user a
chance to create new trigger(s) if a new cgroup is created.

>
> - I'm passing in cgroup_id as an optional field in struct_ops and then in
>   enable path, look up the matching cgroup, verify it can attach there and
>   insert and update data structures accordingly:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5280

Yeah, we discussed this option with Martin up in this thread. It doesn't
look as the best possible solution, but maybe the best we have at the moment.

Ideally, I want something like this:

void test_oom(void)
{
	struct test_oom *skel;
	int err, cgroup_fd;

        cgroup_fd = open(...);
        if (cgroup_fd < 0)
		goto cleanup;

	skel = test_oom__open_and_load();
        if (!skel)
		goto cleanup;

	err = test_oom__attach_cgroup(skel, cgroup_fd);
	if (CHECK_FAIL(err))
		goto cleanup;

