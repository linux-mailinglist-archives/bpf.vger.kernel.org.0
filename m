Return-Path: <bpf+bounces-66121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B522B2E83A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C6BA074C1
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C925235C01;
	Wed, 20 Aug 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HV5VSKFw"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3918FDAB
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755729916; cv=none; b=IQUviGvkM4iTZ7ZDoAFhopikXhsYUCIC6pl3nI1imfT9R8vZLl2TiJCXyE08UIhVq0FbF+gGcS/YkDGA4ZZhZdcaxL1FBsPXZe2xGSlN53A0xkqQc4Y1aW5j3c6yLIelBCwmxwamVj7CT+H9r4DyVVjrcG8+abGs4jT2wmXePns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755729916; c=relaxed/simple;
	bh=1NB+1kQ7punO/zTLJ3mZAGULp1WI7Buii+7JUE/b9hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJUamEfgoyCs13slBm/EWLqkB/okK+WxcQPHY5nnaNLA7qPMcNvAWd5RHAGatvIdk1TVsFtTO94+LoRIJo8knr6G4XNag43VX8zBgTdj/3B58Srz2ozCgJx6O4D03aPFeC0MqGO/5IQgd8n2O2bEYpFU41+gyL6ar3NizgI1G0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HV5VSKFw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755729912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DXWWj4a5hAcoBW3C/vlPFTjK0POV17XOJOPajxQapM=;
	b=HV5VSKFwPy8UA04gdJnWB5Yp0IuZOqSxs1cY/kYt/0LylCkkoID2MktjpiHSlPrUOq+ZEf
	2Wpg2bKI7PsH/H31yoyXyb5Rzg/kBwcNuuBbh5bRHLbgKmf6KIHBVvjnB4mXJi5jhWXPK2
	mAmtyY+8NWUGgmXhwyTdNcQ63KWd0XI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/14] mm: introduce bpf_get_root_mem_cgroup() bpf kfunc
In-Reply-To: <CAP01T772oh8t05Pth2eWFzfSGVWDuW6kujRVSYQEreqZy==nOQ@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 20 Aug 2025 11:25:02
	+0200")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-6-roman.gushchin@linux.dev>
	<CAP01T772oh8t05Pth2eWFzfSGVWDuW6kujRVSYQEreqZy==nOQ@mail.gmail.com>
Date: Wed, 20 Aug 2025 15:45:07 -0700
Message-ID: <87ms7tobnw.fsf@linux.dev>
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
>> Introduce a bpf kfunc to get a trusted pointer to the root memory
>> cgroup. It's very handy to traverse the full memcg tree, e.g.
>> for handling a system-wide OOM.
>>
>> It's possible to obtain this pointer by traversing the memcg tree
>> up from any known memcg, but it's sub-optimal and makes bpf programs
>> more complex and less efficient.
>>
>> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
>> however in reality it's not necessarily to bump the corresponding
>> reference counter - root memory cgroup is immortal, reference counting
>> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
>> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
>> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  mm/bpf_memcontrol.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 66f2a359af7e..a8faa561bcba 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -10,6 +10,20 @@
>>
>>  __bpf_kfunc_start_defs();
>>
>> +/**
>> + * bpf_get_root_mem_cgroup - Returns a pointer to the root memory cgroup
>> + *
>> + * The function has KF_ACQUIRE semantics, even though the root memory
>> + * cgroup is never destroyed after being created and doesn't require
>> + * reference counting. And it's perfectly safe to pass it to
>> + * bpf_put_mem_cgroup()
>> + */
>> +__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>> +{
>> +       /* css_get() is not needed */
>> +       return root_mem_cgroup;
>> +}
>> +
>>  /**
>>   * bpf_get_mem_cgroup - Get a reference to a memory cgroup
>>   * @css: pointer to the css structure
>> @@ -122,6 +136,7 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>>  __bpf_kfunc_end_defs();
>>
>>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQUIRE | KF_RET_NULL)
>
> Same suggestion here (re: trusted args).

It's not really taking any arguments, so I don't think it's applicable:
	struct mem_cgroup *bpf_get_root_mem_cgroup(void)

