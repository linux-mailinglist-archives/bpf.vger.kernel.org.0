Return-Path: <bpf+bounces-66123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B605AB2E857
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2661BC15AD
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AED2DBF49;
	Wed, 20 Aug 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nB9asYOT"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F57244693
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730207; cv=none; b=t8ZYZXPxgcJ+guGOPoMbqbPZxJISVnWP1UMfaOVXFRyGPRhTVhzHSZCEA+Ioy50xBlkg0oJE54KG/tXsKzd3ln0VVia338YFmaIjrn7Ay2M9G/2h5lcrgoIlO4zRE6pfEAmy+CDyQAhWoeHPKRP91sJNlKR3tVnFqaH9MWoFs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730207; c=relaxed/simple;
	bh=eCL8GsLf3uYEog+ER630EOsJ52icnZjOcTqvUQPw3lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bwth8ZgJ0Mww6EwVENtKHMxaWKKyY9fUKWTW5Ki8jZFVcFz7d6kngeF7XGa0BrKRK8lMxI5dBjFFSe9cOR1KjaneuDx5+RDnQtwbS2ORxiNxKECcdb+dUXrc+gTEhMuiSgNpKFgYwff3/KvIYxN1s/hVYAvDi2P7EFT9rVU4Z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nB9asYOT; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755730200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsdDNWT0aPaFWkXNVMSJrwjwzzlXY8/IesqRJaJrUFg=;
	b=nB9asYOTay3SplClMlGUjqJrUlNm40iBpD5ePjlHlcko7ltyfZdyC8gCY3jD40zA+3I/ZU
	UINeNtc0dBEbM/WktZuxCAHr4Af/b1uEbFb0lAqxvpNyZU8B1+B1tmnxpcRHvi2ZRfyOR/
	NZWzYbGQCeZ/LrkD4Df+fjs3Ag8mOic=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/14] bpf: selftests: bpf OOM handler test
In-Reply-To: <CAP01T75_ArZiy9AB6TwNZCxKJKw+2yg58xz1ubTGZr4ynVt+Mg@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 20 Aug 2025 11:33:42
	+0200")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-11-roman.gushchin@linux.dev>
	<CAP01T75_ArZiy9AB6TwNZCxKJKw+2yg58xz1ubTGZr4ynVt+Mg@mail.gmail.com>
Date: Wed, 20 Aug 2025 15:49:53 -0700
Message-ID: <878qjdobfy.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 18 Aug 2025 at 19:02, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> Implement a pseudo-realistic test for the OOM handling
>> functionality.
>>
>> The OOM handling policy which is implemented in bpf is to
>> kill all tasks belonging to the biggest leaf cgroup, which
>> doesn't contain unkillable tasks (tasks with oom_score_adj
>> set to -1000). Pagecache size is excluded from the accounting.
>>
>> The test creates a hierarchy of memory cgroups, causes an
>> OOM at the top level, checks that the expected process will be
>> killed and checks memcg's oom statistics.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  [...]
>> +
>> +/*
>> + * Find the largest leaf cgroup (ignoring page cache) without unkillable tasks
>> + * and kill all belonging tasks.
>> + */
>> +SEC("struct_ops.s/handle_out_of_memory")
>> +int BPF_PROG(test_out_of_memory, struct oom_control *oc)
>> +{
>> +       struct task_struct *task;
>> +       struct mem_cgroup *root_memcg = oc->memcg;
>> +       struct mem_cgroup *memcg, *victim = NULL;
>> +       struct cgroup_subsys_state *css_pos;
>> +       unsigned long usage, max_usage = 0;
>> +       unsigned long pagecache = 0;
>> +       int ret = 0;
>> +
>> +       if (root_memcg)
>> +               root_memcg = bpf_get_mem_cgroup(&root_memcg->css);
>> +       else
>> +               root_memcg = bpf_get_root_mem_cgroup();
>> +
>> +       if (!root_memcg)
>> +               return 0;
>> +
>> +       bpf_rcu_read_lock();
>> +       bpf_for_each(css, css_pos, &root_memcg->css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
>> +               if (css_pos->cgroup->nr_descendants + css_pos->cgroup->nr_dying_descendants)
>> +                       continue;
>> +
>> +               memcg = bpf_get_mem_cgroup(css_pos);
>> +               if (!memcg)
>> +                       continue;
>> +
>> +               usage = bpf_mem_cgroup_usage(memcg);
>> +               pagecache = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
>> +
>> +               if (usage > pagecache)
>> +                       usage -= pagecache;
>> +               else
>> +                       usage = 0;
>> +
>> +               if ((usage > max_usage) && mem_cgroup_killable(memcg)) {
>> +                       max_usage = usage;
>> +                       if (victim)
>> +                               bpf_put_mem_cgroup(victim);
>> +                       victim = bpf_get_mem_cgroup(&memcg->css);
>> +               }
>> +
>> +               bpf_put_mem_cgroup(memcg);
>> +       }
>> +       bpf_rcu_read_unlock();
>> +
>> +       if (!victim)
>> +               goto exit;
>> +
>> +       bpf_for_each(css_task, task, &victim->css, CSS_TASK_ITER_PROCS) {
>> +               struct task_struct *t = bpf_task_acquire(task);
>> +
>> +               if (t) {
>> +                       if (!bpf_task_is_oom_victim(task))
>> +                               bpf_oom_kill_process(oc, task, "bpf oom test");
>
> Is there a scenario where we want to invoke bpf_oom_kill_process when
> the task is not an oom victim?

Not really, but...

> Would it be better to subsume this check in the kfunc itself?

bpf_task_is_oom_victim() is useful by itself, because if we see
a task which is about to be killed, we can likely simple bail out.
Let me adjust the test to reflect it.

