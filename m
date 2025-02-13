Return-Path: <bpf+bounces-51430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299BCA34931
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB7F16102A
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF4201026;
	Thu, 13 Feb 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LM0RBFn6"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01B1F866A
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463057; cv=none; b=bHg2wqMXPTV3/1EWvVDGeSqjh+qXFImNkrkJy6IdiasWzbZLRYuNTpnNWVt919X1IWOE3NhztH3yv9BPufUD2g5z6afY3F94agtwi79wJBY/aOLqRB9TxHqZ0hdMsFsA2oO6EmGf8mTtwrmGEdhRrNelfrdyrzUvSY49dcG1VMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463057; c=relaxed/simple;
	bh=0kqD/vkPX7Wr71h/9N4W+I3XlYaJNhB4AQoPv8NAy1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMI4TP8CpHO2XrxZ1xZiwQlrTTxdIEab08NILQKZEDnEKaVE33UOXtbr3d3/IslV3EYykuBQX2ZduRqPyyn4EL2SUwQJPYdvtY3c9mIy45fYxcS/bSG6qGNt5GczjzUTUFP8THOyXsH7Snt3Xld7icFd7tUWgaXGyfl6Srn6tZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LM0RBFn6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739463052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HzxBf4EdPphdknrTLrSFA7l/wI+Wdl8+i6sT4IEUa4c=;
	b=LM0RBFn6grGjOhjC7zoN2fZUPRZl9Tp4x5P2AaekEOEcQGx5UhBC1Q8ZQ2rHtNHKAJZ+SP
	9hPMUD0Ts90c7JlyY72ZtMgwpnD4kUdMXv0jFrgfoEt/WEjMOVo8vNQ2vCaB8aWmvQdYIA
	zO6/bNz/y3HVj3FZk10uzSahVrhFe9o=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/4] bpf: Introduce global percpu data
Date: Fri, 14 Feb 2025 00:06:22 +0800
Message-ID: <20250213160626.34943-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces global percpu data, similar to commit
6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictions
in C for BPF programs.

With this enhancement, it becomes possible to define and use global percpu
variables, much like the DEFINE_PER_CPU() macro in the kernel[0].

The idea stems from the bpflbr project[1], which itself was inspired by
retsnoop[2]. During testing of bpflbr on the v6.6 kernel, two LBR
(Last Branch Record) entries were observed related to the
bpf_get_smp_processor_id() helper.

Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
the overhead and consequently minimizing these two LBR records.

However, the introduction of global percpu data offers a more robust
solution. By leveraging the percpu_array map and percpu instructions,
global percpu data can be implemented intrinsically.

This feature also facilitates sharing percpu information between tail
callers and callees or between freplace callers and callees through a
shared global percpu variable. Previously, this was achieved using a
1-entry percpu_array map, which this patch set aims to improve upon.

Links:
[0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
[1] https://github.com/Asphaltt/bpflbr
[2] https://github.com/anakryiko/retsnoop

Changes:
v1 -> v2:
  * Address comments from Andrii:
    * Use LIBBPF_MAP_PERCPU and SEC_PERCPU.
    * Reuse mmaped of libbpf's struct bpf_map for .percpu map data.
    * Set .percpu struct pointer to NULL after loading skeleton.
    * Make sure value size of .percpu map is __aligned(8).
    * Use raw_tp and opts.cpu to test global percpu variables on all CPUs.
  * Address comments from Alexei:
    * Test non-zero offset of global percpu variable.
    * Test case about BPF_PSEUDO_MAP_IDX_VALUE.

rfc -> v1:
  * Address comments from Andrii:
    * Keep one image of global percpu variable for all CPUs.
    * Reject non-ARRAY map in bpf_map_direct_read(), check_reg_const_str(),
      and check_bpf_snprintf_call() in verifier.
    * Split out libbpf changes from kernel-side changes.
    * Use ".percpu" as PERCPU_DATA_SEC.
    * Use enum libbpf_map_type to distinguish BSS, DATA, RODATA and
      PERCPU_DATA.
    * Avoid using errno for checking err from libbpf_num_possible_cpus().
    * Use "map '%s': " prefix for error message.

Leon Hwang (4):
  bpf: Introduce global percpu data
  bpf, libbpf: Support global percpu data
  bpf, bpftool: Generate skeleton for global percpu data
  selftests/bpf: Add cases to test global percpu data

 kernel/bpf/arraymap.c                         |  41 +++-
 kernel/bpf/verifier.c                         |  45 ++++
 tools/bpf/bpftool/gen.c                       |  47 +++-
 tools/lib/bpf/libbpf.c                        | 101 ++++++--
 tools/lib/bpf/libbpf.h                        |   9 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 218 +++++++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       |  20 ++
 9 files changed, 449 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

-- 
2.47.1


