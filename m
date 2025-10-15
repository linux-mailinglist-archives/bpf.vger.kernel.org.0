Return-Path: <bpf+bounces-71066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF9BE1025
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 01:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFCB84E74E0
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DD4304BCD;
	Wed, 15 Oct 2025 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W38opNAC"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCD74420
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760570301; cv=none; b=oO2B3fxQMG/GqtFnzgBypufnqiyB4AB0tuyd5iMIsWPppGjSP9FnBXn2+SN/3le6vDFiS++AmrDucTaZCCxn95K7EphzA2jRHNnen6CZZE7unZG+0KUIv6PUImMIEyEbD39vNQPwuQov1L1eiZr9KS8sqsgtPYIvdwZy+JXmvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760570301; c=relaxed/simple;
	bh=e/h0ndzeV7Ib47ZmHsSQOQubBr3CKZlr/pkqecfFeb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2w8P1bTVwvtL99z+AdU7tvg6shit2dyPz6RfnQQHpUnxCCuOs5GPjOUey8FkxurZA9RylPQyEUfo3ZsjW/wVv4nCevZLyM5PRwp36PeJRC0sAXvkkPRT83mzGyN+5PSYEc8PaaKE7sTk/jQJAxwZ6Svt72F8pjPtFzK1yr4uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W38opNAC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 16:17:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760570287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0uBjbFB8TPeE1gahyDYnX1z/Z4HIYIQ/tWnWdhuezaM=;
	b=W38opNACFB8YHAPsyJLA+361VAldOqeOmEf4d1uSLMK8ck0qLB3TyQP1pkt54brWK1S5x4
	X2FawelaGsALDLREBoxrMz8KTm1+BIle9V6op6NJYEtYyIwPj7czciZDzafnmcVBx5CaL4
	Da+iDlZwjWZl5uPjlZCU5ZVOrkLoUYk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, mkoutny@suse.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] memcg: selftests for memcg stat kfuncs
Message-ID: <3lhd7qnv425xhj6ivbjxeecybkzid3tfjegnk77kdydmkldnzw@6r4lj7jmpupc>
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015190813.80163-3-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 15, 2025 at 12:08:13PM -0700, JP Kobryn wrote:
> Add test coverage for the kfuncs that fetch memcg stats. Using some common
> stats, test before and after scenarios ensuring that the given stat
> increases by some arbitrary amount. The stats selected cover the three
> categories represented by the enums: node_stat_item, memcg_stat_item,
> vm_event_item.
> 
> Since only a subset of all stats are queried, use a static struct made up
> of fields for each stat. Write to the struct with the fetched values when
> the bpf program is invoked and read the fields in the user mode program for
> verification.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
>  .../bpf/prog_tests/cgroup_iter_memcg.c        | 295 ++++++++++++++++++
>  .../selftests/bpf/progs/cgroup_iter_memcg.c   |  61 ++++
>  3 files changed, 374 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> 
> diff --git a/tools/testing/selftests/bpf/cgroup_iter_memcg.h b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
> new file mode 100644
> index 000000000000..5f4c6502d9f1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#ifndef __CGROUP_ITER_MEMCG_H
> +#define __CGROUP_ITER_MEMCG_H
> +
> +struct memcg_query {
> +	/* some node_stat_item's */
> +	long nr_anon_mapped;
> +	long nr_shmem;
> +	long nr_file_pages;
> +	long nr_file_mapped;
> +	/* some memcg_stat_item */
> +	long memcg_kmem;
> +	/* some vm_event_item */
> +	long pgfault;
> +};
> +
> +#endif /* __CGROUP_ITER_MEMCG_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> new file mode 100644
> index 000000000000..264dc3c9ec30
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include "cgroup_helpers.h"
> +#include "cgroup_iter_memcg.h"
> +#include "cgroup_iter_memcg.skel.h"
> +
> +int read_stats(struct bpf_link *link)
> +{
> +	int fd, ret = 0;
> +	ssize_t bytes;
> +
> +	fd = bpf_iter_create(bpf_link__fd(link));

Do we need to create a new fd for every new stat read? Is there lseek()
like approach possible here?

> +	if (!ASSERT_OK_FD(fd, "bpf_iter_create"))
> +		return 1;
> +
> +	/*
> +	 * Invoke iter program by reading from its fd. We're not expecting any
> +	 * data to be written by the bpf program so the result should be zero.
> +	 * Results will be read directly through the custom data section
> +	 * accessible through skel->data_query.memcg_query.
> +	 */
> +	bytes = read(fd, NULL, 0);
> +	if (!ASSERT_EQ(bytes, 0, "read fd"))
> +		ret = 1;
> +
> +	close(fd);
> +	return ret;
> +}
> +

[...]

> +static void test_shmem(struct bpf_link *link,
> +		struct memcg_query *memcg_query)
> +{
> +	size_t len;
> +	int fd;
> +	void *map;
> +	long val;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val = memcg_query->nr_shmem;
> +	if (!ASSERT_GE(val, 0, "init shmem val"))
> +		return;
> +
> +	/*
> +	 * Increase memcg shmem usage by creating and writing
> +	 * to a shmem object.
> +	 */
> +	fd = shm_open("/tmp_shmem", O_CREAT | O_RDWR, 0644);
> +	if (!ASSERT_OK_FD(fd, "shm_open"))
> +		return;
> +
> +	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
> +		goto cleanup_fd;
> +
> +	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fd, 0);

You don't need to mmap(), you can just fallocate() or simply write to
increase shmem stats.

> +	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap shmem"))
> +		goto cleanup_fd;
> +
> +	memset(map, 1, len);
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup_map;
> +
> +	ASSERT_GT(memcg_query->nr_shmem, val, "final shmem value");
> +
> +cleanup_map:
> +	munmap(map, len);
> +cleanup_fd:
> +	close(fd);
> +	shm_unlink("/tmp_shmem");
> +}
> +
> +static void test_kmem(struct bpf_link *link,
> +		struct memcg_query *memcg_query)
> +{
> +	int fds[2];
> +	int err;
> +	ssize_t bytes;
> +	size_t len;
> +	char *buf;
> +	long val;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val = memcg_query->memcg_kmem;
> +	if (!ASSERT_GE(val, 0, "initial kmem val"))
> +		return;
> +
> +	err = pipe2(fds, O_NONBLOCK);

You will need to create a bit more of these cause the kernel memory
stats to be updated due to per-cpu memcg stock caching kmem stats.

> +	if (!ASSERT_OK(err, "pipe"))
> +		return;
> +
> +	buf = malloc(len);
> +	memset(buf, 1, len);
> +	bytes = write(fds[1], buf, len);
> +	if (!ASSERT_GT(bytes, 0, "write"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup;
> +
> +	ASSERT_GT(memcg_query->memcg_kmem, val, "kmem value");
> +
> +cleanup:
> +	free(buf);
> +	close(fds[0]);
> +	close(fds[1]);
> +}
> +

