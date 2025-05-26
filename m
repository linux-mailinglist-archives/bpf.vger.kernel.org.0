Return-Path: <bpf+bounces-58943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A4AC42EF
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E591317A938
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77523D2A1;
	Mon, 26 May 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Np8aN9lJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031704C6D
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276527; cv=none; b=JkLWb9/gdcvzPxG5HF0/PXe/dtJrgIXOHhNaIcQVTpPsCb5W6J3txc54S87WyVPv9zCuWV2f+7P+gMcwxYcesXoyuSY9yYsB0lU49SyBQ/MLlqr7PsDRA3ISkuwlBIGZqLYCHoG5SpXr7ttV6jP4wXLwGXp1XxY5ZjxDyfmCWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276527; c=relaxed/simple;
	bh=81bifABnEJj5XhtQn+6T+xZMHYdVp+De57111gq/fWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBv5Ub8oXHJBSKz3c6AssAkdrwbk+uuaBpcrmCqKcVHjnpk0SEMIg8kl/X+Al7ZorN+0JvIn6YuHnPDHnJHhCK7buefSwjSxrg46RgFEt/UiDptDubJ0HNdNDpSBJhSFsz8mfIqnugMecUCiA5tsnlysmWfq/B716I+bhwA9zgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Np8aN9lJ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748276521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vPtQWmQIFfjYwu1gr8kfj6bnIWV/YiA0WIE+g83JRis=;
	b=Np8aN9lJ1LCHK6aZF6MVxCoRe7eDK38HDksPbWhUXWcNGdd1ooaPc/OZ2fn4ktsG0AsmKI
	0uL27Z5qUeQrMpme5ogSzjQ3EA8aMLqYFNFfxMA+OHudMrbvhlAoaeEw8Boz464bVHF7eJ
	PFzCrQn9YNeFQc5sOgQ8U9bYfjPxKJQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 0/4] bpf: Introduce global percpu data
Date: Tue, 27 May 2025 00:21:42 +0800
Message-ID: <20250526162146.24429-1-leon.hwang@linux.dev>
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
variables, like the DEFINE_PER_CPU() macro in the kernel[0].

The section name for global peurcpu data is ".data..percpu". It cannot be
named ".percpu" or ".percpudata" because defining a one-byte percpu
variable (e.g., char run SEC(".data..percpu") = 0;) can trigger a crash
with Clang 17[1]. The name ".data.percpu" is also avoided because some
users already use section names prefixed with ".data.percpu", such as in
this example from test_global_map_resize.c:

int percpu_arr[1] SEC(".data.percpu_arr");

The idea stems from the bpfsnoop[2], which itself was inspired by
retsnoop[3]. During testing of bpfsnoop on the v6.6 kernel, two LBR
(Last Branch Record) entries were observed related to the
bpf_get_smp_processor_id() helper.

Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
the overhead and consequently minimizing these two LBR records.

However, the introduction of global percpu data offers a more robust
solution. By leveraging the percpu_array map and percpu instruction,
global percpu data can be implemented intrinsically.

This feature also facilitates sharing percpu information between tail
callers and callees or between freplace callers and callees through a
shared global percpu variable. Previously, this was achieved using a
1-entry percpu_array map, which this patch set aims to improve upon.

Links:
[0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
[1] https://lore.kernel.org/bpf/fd1b3f58-c27f-403d-ad99-644b7d06ecb3@linux.dev/
[2] https://github.com/bpfsnoop/bpfsnoop
[3] https://github.com/anakryiko/retsnoop

Changes:
v2 -> v3:
  * Use ".data..percpu" as PERCPU_DATA_SEC.
  * Address comment from Alexei:
    * Add u8, array of ints and struct { .. } vars to selftest.

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
 tools/bpf/bpftool/gen.c                       |  47 ++--
 tools/lib/bpf/libbpf.c                        | 102 ++++++--
 tools/lib/bpf/libbpf.h                        |   9 +
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 221 +++++++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       |  29 +++
 9 files changed, 459 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

-- 
2.49.0


