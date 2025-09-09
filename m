Return-Path: <bpf+bounces-67870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7489B4FF09
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5081BC344E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F883314B9;
	Tue,  9 Sep 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Twnd48gB"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA321922FD
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427280; cv=none; b=tLXuLUaCNQ8Q4yVQmrTW5kZi3Lzk/caK1o991Il/6wj9Mqr64aSBTzJ0th9dUfae98twwMe4iM/bpFOgjnrQnRN6ui52TfQirBqLLQKN7PH65QqWnkjLaUzzBEktwJAX/YV7PsdHQXZPx2kOGgbILCWQwjbfRF2odzkDu5uUBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427280; c=relaxed/simple;
	bh=esbhtJR8LV9vvUWI1VXany8ROHQW3AyMoqKcafIYkC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kG8g3DSvBbytploNRd8n6uWPrCEeJrla6Y7hViZB0yTxuZiRHuckYCWpzRZipW0tbk22aDNeIcnLCHZZpjuLLdhXCiTPlRUw555AHEOmbPLmKfdGx0u9Ysm12kFe3JxCvYs1ZmkoitZhieTC5GEsuhLVYWw5pWbwYc0HrjDys9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Twnd48gB; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757427274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rwzSOdp/LI3duJ241R+m1ZpYClms7qlgiTFaWpfkUPA=;
	b=Twnd48gBAGx/xd6NnuEzHmRNsJHMjPkdda/1avUkhSsdBH3wIFxX3KbOQMisXv7w1Xmz5r
	AvxRCWnqK8vSMJOb5pkxnSFqCk0JRLgiwqJaJpQLfIwmodmZFHXTR11XB+J0eeVhmQCFiA
	SGFhshCYM9rbz3DyInqpeRWm4yH9zfY=
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
Subject: [PATCH bpf-next v6 0/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu maps
Date: Tue,  9 Sep 2025 22:14:14 +0800
Message-ID: <20250909141422.45450-1-leon.hwang@linux.dev>
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
v5 -> v6:
* Move bpf_map_check_op_flags() from 'bpf.h' to 'syscall.c'.
* Address comments from Alexei:
  * Drop the refactoring code of data copying logic for percpu maps.
  * Drop bpf_map_check_op_flags() wrappers.

v4 -> v5:
* Address comments from Andrii:
  * Refactor data copying logic for all percpu maps.
  * Drop this_cpu_ptr() micro-optimization.
  * Drop cpu check in libbpf's validate_map_op().
  * Enhance bpf_map_check_op_flags() using *allowed flags* instead of
    'extra_flags_mask'.

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

Leon Hwang (7):
  bpf: Introduce internal bpf_map_check_op_flags helper function
  bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
  bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array
    maps
  bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash
    and lru_percpu_hash maps
  bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for
    percpu_cgroup_storage maps
  libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps
  selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags

 include/linux/bpf-cgroup.h                    |   4 +-
 include/linux/bpf.h                           |  26 +-
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/arraymap.c                         |  36 ++-
 kernel/bpf/hashtab.c                          | 105 +++++---
 kernel/bpf/local_storage.c                    |  46 +++-
 kernel/bpf/syscall.c                          |  93 ++++---
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.h                           |   8 +
 tools/lib/bpf/libbpf.c                        |  26 +-
 tools/lib/bpf/libbpf.h                        |  21 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 233 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 +++
 13 files changed, 528 insertions(+), 106 deletions(-)

--
2.50.1


