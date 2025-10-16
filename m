Return-Path: <bpf+bounces-71159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353FBBE56DE
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9463C546E17
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE842DF71F;
	Thu, 16 Oct 2025 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQVY+MC9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5954221299
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647547; cv=none; b=Z8C1TOVxf2+KmBrS4LA/qEqnmPqpniaXK/00cQbRlu6BA/ih976/tEcVeRys3EhuXO+UiRFYNSRVpnZsMrhVbKrsLsDqNv07t5pqPkBVRAiAGUsajp/R+iBdL7qVX12EdYqG4ea9THk6SF5f6a1itixVbWRq7evEa5PnX1mM7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647547; c=relaxed/simple;
	bh=MduJfsMZNecaLdb0+8wa/tl4GWaUKuc4J2PpP1baFPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coW0iJW3J20OB8GA8NQZwKNqpvfl1No6AWkdzy58VhPn7ynh08zrKCqky9Uza6E9j9ELH184KPsAgjep+gfGtSUjiGpXyN6SeA8Wickzy3lo/oHPwcri8nX9d4EhKCpfta03cwTGkYPbHKHW3LPwteSbUhvSFS0ghUwCRsPIP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQVY+MC9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-796f9a8a088so1198325b3a.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647545; x=1761252345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kpH/IPeNwgc8siGpWHSiGFjX32BfbjsHkNF2cmzC/U=;
        b=CQVY+MC9iBOW+DOvGIFDQnsinpRnyWmmO1CjRwfVhK8qJfvGhx12UB7fE34DWzsQNo
         zULp6ZyJVBstiEU50VKIH84ovZsHI2FqlOVaBDhmmhP2xCmC/ZiETVKuXJIWG6ijnDRi
         GKioRse8bGwItiaCgjhN9AoptdzIrtNgCO/m9OOx5MMOauLt2E6DQwVshwQLTqBiX291
         sPaFsofvBfXn4KFWo1QLcH4V5z2nLS/KHT2foqIqrhzzP13r0D8vPPUDHJv4NU49gfRI
         eTxnMxhcl/VPEZJeSgM511PGaV6bN/tJ/JNe+YPTaf9Xz2wfDjsqBBgZqM+vdOX9QOLo
         +P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647545; x=1761252345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kpH/IPeNwgc8siGpWHSiGFjX32BfbjsHkNF2cmzC/U=;
        b=TmoEZQD8oiuUkROBFDMU2iLfCiREI28Gfj/wmGmSmbgFPtROXiKf6bjAyZRPGqL6c0
         N8TjidIehSiOILPUBNpkA7JEUSdcKbQ68wG++PeY5U3sdhBYPo0hoZR3buEsMZwVtive
         8Lp0+XOjG008XIy8xcX3onazTsjJFd98SI03ywC0rHopG1m8f4MwMGPzqRMEHUGaoDXy
         J3nRsqQV3xYNt9aJ3J3azZiBTdRIYoj+ZJZfYh1n3fhqo2PSjskw7bT6lu0LxtbApj8b
         IbPKyY36HsUItlac5OtNfyHV9JsmyyyBFnfJNN/s5j8zr4QfXqghhmJoqK8mDD0NX3bZ
         Ln2w==
X-Forwarded-Encrypted: i=1; AJvYcCU1OLRB7RYqPc9Zav2IvLyJmRCTytveQFO+ZjVdEABYvgKJBNjWwQajw6ruIUYjOD7mXQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVc+n5NVhQIkFh/NQ0SGO8D28UazyklIESUpaqr9bB0rvb++I
	oPity3EDDy24NLIkmNmME83mEcPV8rNZ2H7pMfm2ZnFIVYO5ivALJE25
X-Gm-Gg: ASbGncvK6yGaj6iNklXxdPlvi0lBPGzPQ64GzczzuH2zgGQKCikkKhJ7cwFnp2KmpjN
	plwSl7nZdoeFm08KQiQIRgLgt7GBxyMuG7DKKaT8ShXdU7s8VYhtEDR67qflmo1G4k6HPM1G0hX
	kZI0W8GMf1hwuzJXkizzJJU3kSxqtlUIjd/oyiAgL5ne4J0RmEUn1Kam/y+9zAgGlPgWmE1Q7ZX
	Itzd+S1R68vz7nOtRA/uusCvpqqKHShPG50KwVPIYwMVmMfT/kCj9LGqgPGdW1B0/fWopuqR4Ae
	N9eJ4xHvz/6/kFAyuGZFxm6TwnwnEgA8s1+gRx8EiupIwml14bM9fpPYOtRebFmHJdNrDRpVlPs
	0zseWHU/WjtupB8kfL5bdT59Bo3BS/Wr95dQCbI+VOg5mpEHsV9WSMtU89G1yEFPwpX60ZOMtfu
	1QZ2s+T5ZQD9zUDBv8JWVeoWUWp6GWLonFOYbGJz5K+T/D
X-Google-Smtp-Source: AGHT+IEoAMG2mVaG+NEkk3ZlOYGx2UdFMICSOF0uPohRDbPIlD8LLNH2B8Z8QyGDdKqZ5YjGUOuVCw==
X-Received: by 2002:a05:6a20:7344:b0:334:88a2:d985 with SMTP id adf61e73a8af0-334a864fec8mr1996525637.54.1760647545100;
        Thu, 16 Oct 2025 13:45:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6028:a61a:a132:9634? ([2620:10d:c090:500::5:e774])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22877ebcsm3792046a12.4.2025.10.16.13.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 13:45:44 -0700 (PDT)
Message-ID: <fe0c8bb4-938f-4432-a0ff-584c7322a478@gmail.com>
Date: Thu, 16 Oct 2025 13:45:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] memcg: selftests for memcg stat kfuncs
To: Yonghong Song <yonghong.song@linux.dev>, shakeel.butt@linux.dev,
 andrii@kernel.org, ast@kernel.org, mkoutny@suse.com, yosryahmed@google.com,
 hannes@cmpxchg.org, tj@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-3-inwardvessel@gmail.com>
 <f1558b5d-41be-4f56-8428-d5ae63d696ea@linux.dev>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <f1558b5d-41be-4f56-8428-d5ae63d696ea@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 10:04 PM, Yonghong Song wrote:
> 
> 
> On 10/15/25 12:08 PM, JP Kobryn wrote:
>> Add test coverage for the kfuncs that fetch memcg stats. Using some 
>> common
>> stats, test before and after scenarios ensuring that the given stat
>> increases by some arbitrary amount. The stats selected cover the three
>> categories represented by the enums: node_stat_item, memcg_stat_item,
>> vm_event_item.
>>
>> Since only a subset of all stats are queried, use a static struct made up
>> of fields for each stat. Write to the struct with the fetched values when
>> the bpf program is invoked and read the fields in the user mode 
>> program for
>> verification.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> ---
>>   .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
>>   .../bpf/prog_tests/cgroup_iter_memcg.c        | 295 ++++++++++++++++++
>>   .../selftests/bpf/progs/cgroup_iter_memcg.c   |  61 ++++
>>   3 files changed, 374 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/ 
>> cgroup_iter_memcg.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/ 
>> cgroup_iter_memcg.c
>>
>> diff --git a/tools/testing/selftests/bpf/cgroup_iter_memcg.h b/tools/ 
>> testing/selftests/bpf/cgroup_iter_memcg.h
>> new file mode 100644
>> index 000000000000..5f4c6502d9f1
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +#ifndef __CGROUP_ITER_MEMCG_H
>> +#define __CGROUP_ITER_MEMCG_H
>> +
>> +struct memcg_query {
>> +    /* some node_stat_item's */
>> +    long nr_anon_mapped;
>> +    long nr_shmem;
>> +    long nr_file_pages;
>> +    long nr_file_mapped;
>> +    /* some memcg_stat_item */
>> +    long memcg_kmem;
>> +    /* some vm_event_item */
>> +    long pgfault;
>> +};
>> +
>> +#endif /* __CGROUP_ITER_MEMCG_H */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/ 
>> cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/ 
>> cgroup_iter_memcg.c
>> new file mode 100644
>> index 000000000000..264dc3c9ec30
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
>> @@ -0,0 +1,295 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <bpf/libbpf.h>
>> +#include <bpf/btf.h>
>> +#include <fcntl.h>
>> +#include <sys/mman.h>
>> +#include <unistd.h>
>> +#include "cgroup_helpers.h"
>> +#include "cgroup_iter_memcg.h"
>> +#include "cgroup_iter_memcg.skel.h"
>> +
>> +int read_stats(struct bpf_link *link)
> 
> static int read_stats(...)
> 
>> +{
>> +    int fd, ret = 0;
>> +    ssize_t bytes;
>> +
>> +    fd = bpf_iter_create(bpf_link__fd(link));
>> +    if (!ASSERT_OK_FD(fd, "bpf_iter_create"))
>> +        return 1;
>> +
>> +    /*
>> +     * Invoke iter program by reading from its fd. We're not 
>> expecting any
>> +     * data to be written by the bpf program so the result should be 
>> zero.
>> +     * Results will be read directly through the custom data section
>> +     * accessible through skel->data_query.memcg_query.
>> +     */
>> +    bytes = read(fd, NULL, 0);
>> +    if (!ASSERT_EQ(bytes, 0, "read fd"))
>> +        ret = 1;
>> +
>> +    close(fd);
>> +    return ret;
>> +}
>> +
>> +static void test_anon(struct bpf_link *link,
>> +        struct memcg_query *memcg_query)
> 
> Alignment between arguments? Actually two arguments can be in the same 
> line.

Thanks. I was using a limit of 75 chars but will increase to 100 where
applicable.

[...]
>> +{
>> +    int fds[2];
>> +    int err;
>> +    ssize_t bytes;
>> +    size_t len;
>> +    char *buf;
>> +    long val;
>> +
>> +    len = sysconf(_SC_PAGESIZE) * 1024;
>> +
>> +    if (!ASSERT_OK(read_stats(link), "read stats"))
>> +        return;
>> +
>> +    val = memcg_query->memcg_kmem;
>> +    if (!ASSERT_GE(val, 0, "initial kmem val"))
>> +        return;
>> +
>> +    err = pipe2(fds, O_NONBLOCK);
>> +    if (!ASSERT_OK(err, "pipe"))
>> +        return;
>> +
>> +    buf = malloc(len);
> 
> buf could be NULL?

Thanks. I'll add the check unless this test is simplified and a buffer
is not needed for v3.

[...]
>> +
>> +    skel = cgroup_iter_memcg__open();
>> +    if (!ASSERT_OK_PTR(skel, "cgroup_iter_memcg__open"))
>> +        goto cleanup_cgroup_fd;
>> +
>> +    err = cgroup_iter_memcg__load(skel);
>> +    if (!ASSERT_OK(err, "cgroup_iter_memcg__load"))
>> +        goto cleanup_skel;
> 
> The above two can be combined with cgroup_iter_memcg__open_and_load().

I'll do that in v3.

> 
>> +
>> +    DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>> +    union bpf_iter_link_info linfo = {
>> +        .cgroup.cgroup_fd = cgroup_fd,
>> +        .cgroup.order = BPF_CGROUP_ITER_SELF_ONLY,
>> +    };
>> +    opts.link_info = &linfo;
>> +    opts.link_info_len = sizeof(linfo);
>> +
>> +    link = bpf_program__attach_iter(skel->progs.cgroup_memcg_query, 
>> &opts);
>> +    if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
>> +        goto cleanup_cgroup_fd;
> 
> goto cleanup_skel;

Good catch.

> 
>> +
>> +    if (test__start_subtest("cgroup_iter_memcg__anon"))
>> +        test_anon(link, &skel->data_query->memcg_query);
>> +    if (test__start_subtest("cgroup_iter_memcg__shmem"))
>> +        test_shmem(link, &skel->data_query->memcg_query);
>> +    if (test__start_subtest("cgroup_iter_memcg__file"))
>> +        test_file(link, &skel->data_query->memcg_query);
>> +    if (test__start_subtest("cgroup_iter_memcg__kmem"))
>> +        test_kmem(link, &skel->data_query->memcg_query);
>> +    if (test__start_subtest("cgroup_iter_memcg__pgfault"))
>> +        test_pgfault(link, &skel->data_query->memcg_query);
>> +
>> +    bpf_link__destroy(link);
>> +cleanup_skel:
>> +    cgroup_iter_memcg__destroy(skel);
>> +cleanup_cgroup_fd:
>> +    close(cgroup_fd);
>> +    cleanup_cgroup_environment();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/ 
>> tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
>> new file mode 100644
>> index 000000000000..0d913d72b68d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_core_read.h>
>> +#include "cgroup_iter_memcg.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +extern void memcg_flush_stats(struct cgroup *cgrp) __ksym;
>> +extern unsigned long memcg_stat_fetch(struct cgroup *cgrp,
>> +        enum memcg_stat_item item) __ksym;
>> +extern unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
>> +        enum node_stat_item item) __ksym;
>> +extern unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
>> +        enum vm_event_item item) __ksym;
> 
> The above four extern functions are not needed. They should be included
> in vmlinux.h if the latest pahole version (1.30) is used.

Thanks, was not aware of that. Will remove.

> 
>> +
>> +/* The latest values read are stored here. */
>> +struct memcg_query memcg_query SEC(".data.query");
>> +
>> +/*
>> + * Helpers for fetching any of the three different types of memcg stats.
>> + * BPF core macros are used to ensure an enumerator is present in the 
>> given
>> + * kernel. Falling back on -1 indicates its absence.
>> + */
>> +#define node_stat_fetch_if_exists(cgrp, item) \
>> +    bpf_core_enum_value_exists(enum node_stat_item, item) ? \
>> +        memcg_node_stat_fetch((cgrp), bpf_core_enum_value( \
>> +                     enum node_stat_item, item)) : -1
>> +
>> +#define memcg_stat_fetch_if_exists(cgrp, item) \
>> +    bpf_core_enum_value_exists(enum memcg_stat_item, item) ? \
>> +        memcg_node_stat_fetch((cgrp), bpf_core_enum_value( \
>> +                     enum memcg_stat_item, item)) : -1
>> +
>> +#define vm_event_fetch_if_exists(cgrp, item) \
>> +    bpf_core_enum_value_exists(enum vm_event_item, item) ? \
>> +        memcg_vm_event_fetch((cgrp), bpf_core_enum_value( \
>> +                     enum vm_event_item, item)) : -1
>> +
>> +SEC("iter.s/cgroup")
>> +int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>> +{
>> +    struct cgroup *cgrp = ctx->cgroup;
>> +
>> +    if (!cgrp)
>> +        return 1;
>> +
>> +    memcg_flush_stats(cgrp);
>> +
>> +    memcg_query.nr_anon_mapped = node_stat_fetch_if_exists(cgrp,
>> +            NR_ANON_MAPPED);
>> +    memcg_query.nr_shmem = node_stat_fetch_if_exists(cgrp, NR_SHMEM);
>> +    memcg_query.nr_file_pages = node_stat_fetch_if_exists(cgrp,
>> +            NR_FILE_PAGES);
>> +    memcg_query.nr_file_mapped = node_stat_fetch_if_exists(cgrp,
>> +            NR_FILE_MAPPED);
>> +    memcg_query.memcg_kmem = memcg_stat_fetch_if_exists(cgrp, 
>> MEMCG_KMEM);
>> +    memcg_query.pgfault = vm_event_fetch_if_exists(cgrp, PGFAULT);
> 
> There is a type mismatch:
> 
> +struct memcg_query {
> +    /* some node_stat_item's */
> +    long nr_anon_mapped;
> +    long nr_shmem;
> +    long nr_file_pages;
> +    long nr_file_mapped;
> +    /* some memcg_stat_item */
> +    long memcg_kmem;
> +    /* some vm_event_item */
> +    long pgfault;
> +};
> 
> memcg_query.nr_anon_mapped is long, but node_stat_fetch_if_exists
> (...) return value type is unsigned long. It would be good if two
> types are the same.

Good call, will do.

