Return-Path: <bpf+bounces-66684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C82B387ED
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B5C1BA27F5
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900A22E004;
	Wed, 27 Aug 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6j78a2g"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8F17F4F6
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313128; cv=none; b=nRyFudQojPXrq6fgOSz5lu6w/4m/4FmMDQL3AoNIKwSTP4fAyMDALx+T3OTthzKyZtRJqmSWpOlRnFLbOCY5QGvnt4ro8VqJRjwyTf8U+vogvQQM1XkjHUf4m+hRb2Ja7YFIjQBcffBLgDKOhrN+ydSS0fPt4YlgshgdqDEJ3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313128; c=relaxed/simple;
	bh=+GazPPqFc6RrIIXrvA8BNxzf8qh2Xf6JDrZLYOYpwhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7aaTK0+V5r+w9KHpMbx/oYFbmW0OfUsaywxb43L+p4SJRH0x3IhoeFqwQy+QmFmwAh79V1NOB7kV8tJNdRQmiBHL9pVXMcIj6YX0WBCmtq67NEP16QIZL70jNKwZGNByL2LI8DDLyEGJw5DRNcc4KlMAqRCZ7sR5mdYbJfgSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6j78a2g; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756313121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2FkRlhiRvGBSiFCUrNDFJt9G0SpZy+QyM11Xpve/gWE=;
	b=n6j78a2gU/IQfAqRtdCEUpUqfZLL8VLjiMtLb+DiV1rULTbBIs8laiGqwfvXqrlprB7YML
	bpi3zhhc69JVdK11jmkgwAUeM7fKE5Vnh6DAo+cW1ioA3w9wBNpglB0D1jk1PPOPsvEOij
	i8EA5MgKuYGYTMtfdzKVOTYMa4gW8G8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps
Date: Thu, 28 Aug 2025 00:45:02 +0800
Message-ID: <20250827164509.7401-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces the BPF_F_CPU and BPF_F_ALL_CPUS flags for
percpu maps, as the requirement of BPF_F_ALL_CPUS flag for percpu_array
maps was discussed in the thread of
"[PATCH bpf-next v3 0/4] bpf: Introduce global percpu data"[1].

The goal of BPF_F_ALL_CPUS flag is to reduce data caching overhead in light
skeletons by allowing a single value to be reused to update values across all
CPUs. This avoids the M:N problem where M cached values are used to update a
map on N CPUs kernel.

The BPF_F_CPU flag is accompanied by *flags*-embedded cpu info, which
specifies the target CPU for the operation:

* For lookup operations: the flag field alongside cpu info enable querying
  a value on the specified CPU.
* For update operations: the flag field alongside cpu info enable
  updating value for specified CPU.

Links:
[1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

Changes:
v3 -> v4:
* Address comments from Andrii:
  * Remove unnecessary map_type check in bpf_map_value_size().
  * Reduce code churn.
  * Remove unnecessary do_delete check in
    __htab_map_lookup_and_delete_batch().
  * Introduce bpf_percpu_copy_to_user() and bpf_percpu_copy_from_user().
  * Rename check_map_flags() to bpf_map_check_op_flags() with
    extra_flags_mask.
  * Add human-readable pr_warn() explanations in validate_map_op().
  * Use flags in bpf_map__delete_elem() and
    bpf_map__lookup_and_delete_elem().
  * Drop "for alignment reasons".
v3 link: https://lore.kernel.org/bpf/20250821160817.70285-1-leon.hwang@linux.dev/

v2 -> v3:
* Address comments from Alexei:
  * Use BPF_F_ALL_CPUS instead of BPF_ALL_CPUS magic.
  * Introduce these two cpu flags for all percpu maps.
* Address comments from Jiri:
  * Reduce some unnecessary u32 cast.
  * Refactor more generic map flags check function.
  * A code style issue.
v2 link: https://lore.kernel.org/bpf/20250805163017.17015-1-leon.hwang@linux.dev/

v1 -> v2:
* Address comments from Andrii:
  * Embed cpu info as high 32 bits of *flags* totally.
  * Use ERANGE instead of E2BIG.
  * Few format issues.

RFC v2 -> v1:
* Address comments from Andrii:
  * Use '&=' and '|='.
  * Replace 'reuse_value' with simpler and less duplication code.
  * Replace 'ASSERT_FALSE' with two 'ASSERT_OK_PTR's in self test.

RFC v1 -> RFC v2:
* Address comments from Andrii:
  * Embed cpu to flags on kernel side.
  * Change BPF_ALL_CPU macro to BPF_ALL_CPUS enum.
  * Copy/update element within RCU protection.
  * Update bpf_map_value_size() including BPF_F_CPU case.
  * Use zero as default value to get cpu option.
  * Update documents of APIs to be generic.
  * Add size_t:0 to opts definitions.
  * Update validate_map_op() including BPF_F_CPU case.
  * Use LIBBPF_OPTS instead of DECLARE_LIBBPF_OPTS.

Leon Hwang (7):
  bpf: Introduce internal bpf_map_check_op_flags helper function
  bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
  bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu_array
    maps
  bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu_hash and
    lru_percpu_hash maps
  bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for
    percpu_cgroup_storage maps
  libbpf: Support BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps
  selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags

 include/linux/bpf-cgroup.h                    |   5 +-
 include/linux/bpf.h                           | 126 +++++++++-
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/arraymap.c                         |  28 +--
 kernel/bpf/hashtab.c                          |  95 +++++---
 kernel/bpf/local_storage.c                    |  42 ++--
 kernel/bpf/syscall.c                          |  64 +++--
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |  33 ++-
 tools/lib/bpf/libbpf.h                        |  21 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 224 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 +++
 13 files changed, 549 insertions(+), 133 deletions(-)

--
2.50.1


