Return-Path: <bpf+bounces-49867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41282A1DA6C
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F511162696
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563015442D;
	Mon, 27 Jan 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpMBTOT8"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D814E2E8
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994948; cv=none; b=q7VdV6ykoqPk4payapYH7rTJHqzhEOgIMA+kEPs0+BGx9SIRPsmE4OqEcTKjzYUFkLZJZdRS+fhXu18U/0hHJm47fnCOe2lnK9qo7SbeESqgAvWxUZjYSxbTBrySFqJuMpFojukuNR3kK14/dNa/FoEGbJY6GDqVuQ2UN2jPOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994948; c=relaxed/simple;
	bh=xeaE0s1tUBtCaWKr730a+Zpx3gx2XZJW8WErnnP01p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFlz5o5dd/tOBLbjTCfEIRJLSdt6sWT3F7WfvD/6cfBGhwCDfw9q6dLOqrmKJgLJ3Qf5XhxPvlzII7ivzdfNVX1oiyWuUDg/d4r0YO1ANNZF7Tpf/6EVgZ4aQDDMHmYxfSHdsalUbt7X/JwvwjMZCOZnhJbBf3o+OBm9VixGDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpMBTOT8; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737994943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yYjSiglpl5sAVK1Kei7Yu9LFHMAm4yswlMhmPa5GXYM=;
	b=cpMBTOT8Sy0rBqtE7GInwfwVle/MScWVOc1Swybs2M8yIlRHypoE/PC1T+DM/HV5oZrwMU
	4keJNQ7kq0maPpI0mYigRGMooRYtzNV+imZSHAbYa7vmeNCxWwEVTKjMbUzC++yop5TjHX
	4dBk5Zxq/L1xybGNtb06kyLiy0Vl0Oo=
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
Date: Tue, 28 Jan 2025 00:21:54 +0800
Message-ID: <20250127162158.84906-1-leon.hwang@linux.dev>
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
  selftests/bpf: Add a case to test global percpu data

 kernel/bpf/arraymap.c                         |  39 +++-
 kernel/bpf/verifier.c                         |  45 +++++
 tools/bpf/bpftool/gen.c                       |  13 +-
 tools/lib/bpf/libbpf.c                        | 175 ++++++++++++++----
 tools/lib/bpf/libbpf.h                        |   1 +
 .../bpf/prog_tests/global_data_init.c         |  89 ++++++++-
 .../bpf/progs/test_global_percpu_data.c       |  21 +++
 7 files changed, 340 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

-- 
2.47.1


