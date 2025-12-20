Return-Path: <bpf+bounces-77214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FEDCD260D
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24BB5300A8F3
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0397427FD51;
	Sat, 20 Dec 2025 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AqfSN9En"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF23A1E72
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766200829; cv=none; b=F7Mh57g8tEFJItai5xMd1WjFL3jT7niNDKFeNCK8CoZslLySV3jd9afACXOKwX4p+uhZMrHo/jboKt6IicMunER4V5j0R/WwJUZXP3JmvD7/wnKe24ezutjPcqpySgANLCD58vtXXsjzTj67XadJeJD8/KpDxOvk7skn6OR/Cfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766200829; c=relaxed/simple;
	bh=IkyeGu9OFPgLYqYZ1qqfIh0vElhnNuk0wiIh82Svu3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPL8XvqfVyH5ZOw+Us63EqWgPY1sAbwTDmIHRo872lF9C1uU8/XJRtlzH6j8UR6q0Cwwrikk8pB4SYB7tO0t6oY0QIjE8jMYy/ekEivAJbaihHng3DRTk5Eof4bUofAHPcpIgtfv8QHb5jKiUTbReNUhntr5l3V+P+4PseYx2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AqfSN9En; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766200810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSWnxPF7s7XrgaAgGOnY7K1GNIzL+YqDV6JYLvAhZaU=;
	b=AqfSN9EnBu+pQ+55c6KrxraFWofHwRehkLXlObC2WQPuyODI6sRp51PUDiCH3FSpSQ7hHV
	WCMjBb/r91usuQ1LiKsr/XDzXH2rvZl2CtPrYl/dV9uHmZAF0fjFp3qytDa7/4JaXToPF3
	h06Y8zGnLjlifMc3TK1SqU1GZykFUFQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  JP Kobryn <inwardvessel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Michal Hocko
 <mhocko@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v1 6/6] bpf: selftests: selftests for memcg
 stat kfuncs
In-Reply-To: <2xhmcrporen72rskghn6hmg6obnojptuerwzqgu7mqzhnxaxs5@33dxlwa6rqlh>
	(Shakeel Butt's message of "Fri, 19 Dec 2025 15:07:11 -0800")
References: <20251219015750.23732-1-roman.gushchin@linux.dev>
	<20251219015750.23732-7-roman.gushchin@linux.dev>
	<2xhmcrporen72rskghn6hmg6obnojptuerwzqgu7mqzhnxaxs5@33dxlwa6rqlh>
Date: Fri, 19 Dec 2025 19:20:04 -0800
Message-ID: <87cy49g7q3.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Thu, Dec 18, 2025 at 05:57:50PM -0800, Roman Gushchin wrote:
>> From: JP Kobryn <inwardvessel@gmail.com>
>> 
>> Add test coverage for the kfuncs that fetch memcg stats. Using some common
>> stats, test scenarios ensuring that the given stat increases by some
>> arbitrary amount. The stats selected cover the three categories represented
>> by the enums: node_stat_item, memcg_stat_item, vm_event_item.
>> 
>> Since only a subset of all stats are queried, use a static struct made up
>> of fields for each stat. Write to the struct with the fetched values when
>> the bpf program is invoked and read the fields in the user mode program for
>> verification.
>> 
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>
> Need your signoff

Sure, will add, thanks.

>
> [...]
>> +
>> +#define NR_PIPES 64
>> +static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
>> +{
>> +	int fds[NR_PIPES][2], i;
>> +
>> +	/*
>> +	 * Increase kmem value by creating pipes which will allocate some
>> +	 * kernel buffers.
>> +	 */
>> +	for (i = 0; i < NR_PIPES; i++) {
>> +		if (!ASSERT_OK(pipe(fds[i]), "pipe"))
>> +			goto cleanup;
>> +	}
>> +
>> +	if (!ASSERT_OK(read_stats(link), "read stats"))
>> +		goto cleanup;
>> +
>> +	ASSERT_GT(memcg_query->memcg_kmem, 0, "kmem value");
>> +
>> +cleanup:
>> +	for (i = 0; i < NR_PIPES; i++) {
>
> Instead of from 0 to NR_PIPES, we need to go from i-1 to (and equal to) 0
> otherwise we can potentially close() junk values.

Good catch, will fix.

>
>> +		close(fds[i][0]);
>> +		close(fds[i][1]);
>> +	}
>> +}
>> +
>
> [...]
>
>> +
>> +SEC("iter.s/cgroup")
>> +int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>> +{
>> +	struct cgroup *cgrp = ctx->cgroup;
>> +	struct cgroup_subsys_state *css;
>> +	struct mem_cgroup *memcg;
>> +
>> +	if (!cgrp)
>> +		return 1;
>> +
>> +	css = &cgrp->self;
>> +	if (!css)
>
> Will css ever be NULL here?

Hm, I think previously the verifier wasn't smart enough to understand
that it's always a valid pointer, but I just tested it with linux-next
and it worked well. I'll drop the check.

Thanks!

