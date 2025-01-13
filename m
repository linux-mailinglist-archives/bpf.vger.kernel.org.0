Return-Path: <bpf+bounces-48701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4A6A0BBBA
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 16:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B6F16242E
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B2240249;
	Mon, 13 Jan 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tUFWAT5d"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2405240233
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781908; cv=none; b=SyiwWcw3/yjHwjnGq/QsUz9pOEnjiApeQAbjeDOx6fZNZvu0hPq6vPxgGpgQ37OPfI+adaierrlYZ70lKvz9cN6/tr/Y+Pjdp0894d5wiAZnEmebb8vK5CwLcvO0SWFcCS2IyvYgd9V5jazroIxDsBIOPxXEzqXGKdQyugcwjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781908; c=relaxed/simple;
	bh=sM+nGxqaufS4FPePXRtAYceRlcGNQiY74X4M/wAGCMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X78pM4xWatcyc/dysV3q8/5j0cWY6AsXtSNM+7D8VXeannNAQcFRHsparvlUK2LGiU3Rmewy9nbiL4RKBaySBG0md9gaQQDIxnvGjHRl6P+q7z61Wyo3o491VzMdpIypLNZtb40EFh+y47HjRFaV95UZKSqnxV7zZZI5ktwPinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tUFWAT5d; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736781903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L/lTBHN9Bo5PEFoov3JojQYOFh+P1Kyr9yxIoyV2k8Q=;
	b=tUFWAT5d/TSeKbskr8b/3vFl0xb/tMJoOy5E7vgL0HCdUpH4GIbDlZ57yUzarf2JVcBAqm
	d8YetfsQoyE7CV2ojKLi1HipYs2cno2LDMqnJnObDAIkc63kjR7O3ajMvx9JRRvBlZaaV0
	8XlRdtHt4kutuOQVyWsp3dsUJGN3PRE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [RFC PATCH bpf-next 0/2] bpf: Introduce global percpu data
Date: Mon, 13 Jan 2025 23:24:35 +0800
Message-ID: <20250113152437.67196-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch set introduces global per-CPU data, similar to commit
6316f78306c1 ("Merge branch 'support-global-data'"), to reduce restrictions
in C for BPF programs.

With this enhancement, it becomes possible to define and use global per-CPU
variables, much like the DEFINE_PER_CPU() macro in the kernel[0].

The idea stems from the bpflbr project[1], which itself was inspired by
retsnoop[2]. During testing of bpflbr on the v6.6 kernel, two LBR
(Last Branch Record) entries were observed related to the
bpf_get_smp_processor_id() helper.

Since commit 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper"),
the bpf_get_smp_processor_id() helper has been inlined on x86_64, reducing
the overhead and consequently minimizing these two LBR records.

However, the introduction of global per-CPU data offers a more robust
solution. By leveraging the percpu_array map and percpu instructions,
global per-CPU data can be implemented intrinsically.

This feature also facilitates sharing per-CPU information between tail
callers and callees or between freplace callers and callees through a
shared global per-CPU variable. Previously, this was achieved using a
1-entry percpu map, which this patch set aims to improve upon.

Links:
[0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
[1] https://github.com/Asphaltt/bpflbr
[2] https://github.com/anakryiko/retsnoop

Leon Hwang (2):
  bpf: Introduce global percpu data
  selftests/bpf: Add a case to test global percpu data

 kernel/bpf/arraymap.c                         |  39 +++++-
 kernel/bpf/verifier.c                         |  45 +++++++
 tools/lib/bpf/libbpf.c                        | 112 ++++++++++++++----
 .../bpf/prog_tests/global_data_init.c         |  83 ++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       |  21 ++++
 5 files changed, 274 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

-- 
2.47.1


