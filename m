Return-Path: <bpf+bounces-66233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF80B2FFA4
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745A87A486E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F742E1EF0;
	Thu, 21 Aug 2025 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KBpRntGQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740D2E1EED
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792521; cv=none; b=AuB4Dh80Cbkp4wV8FYYgXoQXHf7WKhUNuiBUcBzBPvRlHmQGi7ZEWmOtXFLyJDwPMNtzP4BR0YietlWtHa2C+67X8M/4A+2q1BIJIUixHmmLkFMpJKuQokx6FZE8uMLirF9SeSZoYDDKhSfVX2m//ZxRCZxN1btiFlYGxJhN+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792521; c=relaxed/simple;
	bh=oX4YaMnD5OFZMKdW88h17zszKSgHHHoGP1j1t1furcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtNENDagQAO4NR18sKK/jhmgvWqmpRDEI4o+LBNGvqIQmX7YrzgBQrbv47+82M9BbOyil/OTlKWo8FFTrfZdfS6uunGvKCK3/BSedB99dtzz140Y0+ly4Lc0u7VEyuQe+EdpTqZGf/hEn7XeUxgBaQojjLMWAJ9mC7/jSbJ9gCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KBpRntGQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755792515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XyQ86V0N0TfdPFpEmrW7MIMzH+F4s03yBW8K82LKwjA=;
	b=KBpRntGQvpJggVx7cu3PsqPRcZDSUD+cg8Vdgd071WmxMiALmIdRlpRxtWS5rIpAFwUMAK
	xUQOobxW0rrUb30onf7Wpexv76ai5HQLk8mssGfXrcOcRadFT4ByZcPKHuf5UbPVr3VH4T
	Cs0pEI/42NxN/MNGndEtm2YD7LOvEmY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/6] Introduce BPF_F_CPU flag for percpu maps
Date: Fri, 22 Aug 2025 00:08:11 +0800
Message-ID: <20250821160817.70285-1-leon.hwang@linux.dev>
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

The goal of BPF_ALL_CPUS flag is to reduce data caching overhead in light
skeletons by allowing a single value to be reused across all CPUs. This
avoids the M:N problem where M cached values are used to update a map on
N CPUs kernel.

The BPF_F_CPU flag is accompanied by *flags*-embedded cpu info, which
specifies the target CPUs for the operation:

* For lookup operations: the flag field alongside cpu info enable querying
  a value on the specified CPU.
* For update operations: the flag field alongside cpu info enable
  updating value for specified CPU.

Links:
[1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

Changes:
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

Leon Hwang (6):
  bpf: Introduce internal check_map_flags helper function
  bpf: Introduce BPF_F_CPU flag for percpu_array maps
  bpf: Introduce BPF_F_CPU flag for percpu_hash and lru_percpu_hash maps
  bpf: Introduce BPF_F_CPU flag for percpu_cgroup_storage maps
  libbpf: Support BPF_F_CPU for percpu maps
  selftests/bpf: Add cases to test BPF_F_CPU flag

 include/linux/bpf-cgroup.h                    |   5 +-
 include/linux/bpf.h                           |  58 ++++-
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/arraymap.c                         |  51 ++--
 kernel/bpf/hashtab.c                          | 111 ++++++---
 kernel/bpf/local_storage.c                    |  47 +++-
 kernel/bpf/syscall.c                          |  60 ++---
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |  25 +-
 tools/lib/bpf/libbpf.h                        |  21 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 224 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 +++
 13 files changed, 527 insertions(+), 119 deletions(-)

--
2.50.1


