Return-Path: <bpf+bounces-67447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C9B43F18
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAC18851E9
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7E830DED9;
	Thu,  4 Sep 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xLHA9PwT"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B61DE894
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996356; cv=none; b=Rk/xF49igSKXp1W8fNu17nzc3wjVscAoobQRztENAr6YKnNwccuijF4hznKSBP+6l0IHTWchyguvlNlRJ++F+Egc+hkUUqxn3usxMFzi5dWLiHZF8/5jdc00aNPY6HfS2+IT4mVznr33iVpM3JiowissRiwGPdArBmODaZcwUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996356; c=relaxed/simple;
	bh=WgUuQ1W3XX2FdIpW0v0jLY23t+y2Yy9SRFFnlSel6AE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+lpPuIgfWi0zI9ZxXY1IRF35IZRYgnShn2lr25lLwQpgFaOS+ZwQnfAHRFTESfAyyRWVjz1Vdm9vKf2WLzAWtOyBf9Lk7234jPu3shAc5e856B6bQsXqS0NP5JZZNCJVQ9ioBbjzVX7Rexc2XnrbVZ/btlLfHY7Sh6W3BQQMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xLHA9PwT; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756996342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDBdIXqGhXisdI9dGc4nJcjo34W6QqppuoGXLGaIWNs=;
	b=xLHA9PwTaXoDBP744wDjpvRy1G72Zi59tr/7Y5cji3JaVm31+i7+3GsunlrLWew29Q06wB
	pqQesQNb4k0tq/5fkOp6hNSUTdaj4z1zkNydhaw46Myh/YE15jmwtN5elShJvFGRZSSzWZ
	pkh2e+M3ejdcOqenmCq4q5Z2ZDcIqEc=
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
In-Reply-To: <aLk0FuezkcInlM_r@slm.duckdns.org> (Tejun Heo's message of "Wed,
	3 Sep 2025 20:39:18 -1000")
References: <20250818170136.209169-2-roman.gushchin@linux.dev>
	<CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
	<87ms7tldwo.fsf@linux.dev>
	<1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
	<87wm6rwd4d.fsf@linux.dev>
	<ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
	<CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
	<87iki0n4lm.fsf@linux.dev> <aLeLzWygjrTsgBo8@slm.duckdns.org>
	<87qzwnxgfr.fsf@linux.dev> <aLk0FuezkcInlM_r@slm.duckdns.org>
Date: Thu, 04 Sep 2025 07:32:14 -0700
Message-ID: <87h5xi1e6p.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Wed, Sep 03, 2025 at 04:30:16PM -0700, Roman Gushchin wrote:
> ...
>> > - I'm passing in cgroup_id as an optional field in struct_ops and then in
>> >   enable path, look up the matching cgroup, verify it can attach there and
>> >   insert and update data structures accordingly:
>> >
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/kernel/sched/ext.c?h=scx-hier-prototype#n5280
>> 
>> Yeah, we discussed this option with Martin up in this thread. It doesn't
>> look as the best possible solution, but maybe the best we have at the moment.
>> 
>> Ideally, I want something like this:
>> 
>> void test_oom(void)
>> {
>> 	struct test_oom *skel;
>> 	int err, cgroup_fd;
>> 
>>         cgroup_fd = open(...);
>>         if (cgroup_fd < 0)
>> 		goto cleanup;
>> 
>> 	skel = test_oom__open_and_load();
>>         if (!skel)
>> 		goto cleanup;
>> 
>> 	err = test_oom__attach_cgroup(skel, cgroup_fd);
>> 	if (CHECK_FAIL(err))
>> 		goto cleanup;
>
> Yeah, that'd look better but are there practical differences? The only one I
> can think of is fs based permission check but that can be done separately
> too.

The practical difference is that a single struct ops can be attached
to multiple cgroups.

