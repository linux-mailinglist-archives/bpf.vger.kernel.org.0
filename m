Return-Path: <bpf+bounces-63661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBCB09510
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5944E839E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914A2FC3B0;
	Thu, 17 Jul 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FmzMOaJw"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138932080C4
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781107; cv=none; b=OLHIo8BrSe7+39hGql4tMjc6yhLY8DhbtKv6LZ1WNHDttMo1vgvRPCZvedumu+hvHre2qQk9MduIPr3xuqHVKEKjG9YPM7vnSW8IAFJ2LlaZysioVY0udqYsMpqhL3qE5gBXw0bFYgBVanB1djL9Ei9BCLYDMlB0Q2bJNpGwseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781107; c=relaxed/simple;
	bh=u31ewS7J3OV8pXU3O32TUapFTPORcIPr/gpxJZfDV2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Idp6JM0WZflNJVAd9l1SAfuurUCQj0T22rZg1YEaUGkC0iS4xiDmarCC07w9x2cT3BwJJTdIBnbXcTnmgGW+qj1kH4XOepwld760lI1IMaPLcmGVHsxEPhhp+YvORQxzf95U7uZSXj2L7igH/veaGDrh/TAzd6RkfnOyTP0RyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FmzMOaJw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752781100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZGeN12KXgxb0qnQuDF2Kp1whOX5zF3rEWjQeYajVxqc=;
	b=FmzMOaJwZg80Zd8EShLx1YUPh7AaQjglvQqq4yoFcoaX7px90rrXbpIqA5flGACjfcOURX
	mSzOJDAwNmY5Sf0qlsko1Q+GYh3X+JSNVwgR99DfXYTs3Vs4hjhGYT/MZI7ZI459jsz3EW
	mubyYd7TTPUcuV9DYuVQL+dIhSmKlmU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf: Introduce BPF_F_CPU flag for percpu_array map
Date: Fri, 18 Jul 2025 03:37:53 +0800
Message-ID: <20250717193756.37153-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces the BPF_F_CPU flag for percpu_array maps, as
discussed in the thread of
"[PATCH bpf-next v3 0/4] bpf: Introduce global percpu data"[1].

The goal is to reduce data caching overhead in light skeletons by allowing
a single value to be reused across all CPUs. This avoids the M:N problem
where M cached values are used to update a map on N CPUs kernel.

The BPF_F_CPU flag is accompanied by a cpu field, which specifies the
target CPUs for the operation:

* For lookup operations: the flag and cpu field enable querying a value
  on the specified CPU.
* For update operations:
  * If cpu == (u32)~0, the provided value is copied to all CPUs.
  * Otherwise, the value is copied to the specified CPU only.

Currently, this functionality is only supported for percpu_array maps.

Links:
[1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

Changes:
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


Leon Hwang (3):
  bpf: Introduce BPF_F_CPU flag for percpu_array map
  bpf, libbpf: Support BPF_F_CPU for percpu_array map
  selftests/bpf: Add case to test BPF_F_CPU

 include/linux/bpf.h                           |   3 +-
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/arraymap.c                         |  54 ++++--
 kernel/bpf/syscall.c                          |  52 ++++--
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  23 +++
 tools/lib/bpf/bpf.h                           |  36 +++-
 tools/lib/bpf/libbpf.c                        |  56 +++++-
 tools/lib/bpf/libbpf.h                        |  53 +++++-
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_common.h                 |  14 ++
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 172 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 13 files changed, 459 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

--
2.50.1


