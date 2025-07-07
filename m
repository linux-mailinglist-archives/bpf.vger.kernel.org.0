Return-Path: <bpf+bounces-62536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F6AFB83B
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F071AA2043
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C29209F45;
	Mon,  7 Jul 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4Dl7793"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20828224AF0
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904263; cv=none; b=EeRaUmzqe/QOopvx+kdTXMQ0lGAp4/pvptrvh/0QcTeor2rhGSDOGHD7+BsLLJeeZvLAfFCivWzPhQcUcEIj1dIQwAxY1jmd7xRb+V+k2Jdm+/ZZgiKHmp6e1M4L4drzs9Iv9QVPcuL6+cwrcksrY5S2cB2cx/DiLPUsF5vbxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904263; c=relaxed/simple;
	bh=VgGbdWjfNdJsZaWwir4NenUucbIYMBU9rdrFEUgIGKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ti2mzVyot79HHQaPUVQ/EXn2FrZHONegyU0hOjibDzadhQtN4jvhvienPW6k9cULrRGd/dWsCvkBANJcecf/hYTQTjzUynnIH/GCMAVlqenYFjL4o24dwcP/PeGK6UoDdA2JressYj9Vpxm+qIQNfeWHT554qtPxNOgGLElr9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P4Dl7793; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751904256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ph8TmGaPrzQ55Y1SRwBP8NQBt33l3GOVS2N10HwbBcE=;
	b=P4Dl7793zDQvgY/HOt1nIlZKta1lzyc2oY49ROzykzygg2YnBR92VPMg+OFEOHKhx9shSg
	s76cHeNMnpYx0EA+VvYyq4F6gRUmyWkr1xA+6C7k6eerfKdmUIeY9A6Unl/VVoGiShH6UZ
	uMaYBus+j4hGH7nWRXocgxS/J/hZbZ4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 0/3] bpf: Introduce BPF_F_CPU flag for percpu_array map
Date: Tue,  8 Jul 2025 00:04:01 +0800
Message-ID: <20250707160404.64933-1-leon.hwang@linux.dev>
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
 kernel/bpf/arraymap.c                         |  56 ++++--
 kernel/bpf/syscall.c                          |  52 ++++--
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/lib/bpf/bpf.c                           |  23 +++
 tools/lib/bpf/bpf.h                           |  36 +++-
 tools/lib/bpf/libbpf.c                        |  58 +++++-
 tools/lib/bpf/libbpf.h                        |  53 +++++-
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/lib/bpf/libbpf_common.h                 |  14 ++
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 170 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 13 files changed, 460 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

--
2.50.0


