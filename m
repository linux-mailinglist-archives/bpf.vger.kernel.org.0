Return-Path: <bpf+bounces-65075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43BB1B886
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D5618A6B70
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0201EA7DB;
	Tue,  5 Aug 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y05xnUi0"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FF191F92
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411431; cv=none; b=QU/1lC/EGGS5fwk6bSlVGWKKYtoKkvr6znRtvNi6hKH3clTsEzDsjptMscmY8TBC757ktNlgC6D2RYZUvix4ed8S0Mwcr9KgLGpIBEO15fUOnVknI9VcPE4d3VcB/mNypPu1M/A80ZFedHyHIJMmP3RcNccvgW4gxEXm96f1V+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411431; c=relaxed/simple;
	bh=k7Q+IPuqWzRt9hmBMV/+HueWOtnbK4STrKz8u9OCqok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfEMNd1mByVfeTb2yFLRfjOAe1NZVn+7T5lOUuszg7b8cN4qXzryIJGGyBpbsSK0QHoi19gZffl2PrLH/Wfa2cItwm/hg6HgDqxyUmtvfZg87GAdbwPk7T7lZumplcrBeNjd2LbOdA2srRUMrE35ETsRChmAM5Ne6jZkVVu38p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y05xnUi0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754411427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tayzkUBhwRhOA634CV9rRuf2MeOAVoZCJihPh/Y3DZc=;
	b=Y05xnUi0U7D6UIZ/ir0v1pp0hMehvxDWSMKRnQTKdzWxzJP33TdYB4OWeygk5uyN0PSrhW
	x1XAqooKYNKboUf96huwb6h3xkzaDjthIZPx2DHer0qC48MLb+k4T8+T7/N/SZ0zCR37yC
	FeGVsYeEiJp4+Pq8t/lmInmA+PBCtCA=
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
Subject: [PATCH bpf-next v2 0/3] bpf: Introduce BPF_F_CPU flag for percpu_array maps
Date: Wed,  6 Aug 2025 00:30:14 +0800
Message-ID: <20250805163017.17015-1-leon.hwang@linux.dev>
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

The BPF_F_CPU flag is accompanied by *flags*-embedded cpu info, which
specifies the target CPUs for the operation:

* For lookup operations: the flag field alongside cpu info enable querying
  a value on the specified CPU.
* For update operations:
  * If cpu == (u32)~0, the provided value is copied to all CPUs.
  * Otherwise, the value is copied to the specified CPU only.

Currently, this functionality is only supported for percpu_array maps.

Links:
[1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

Changes:
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

Leon Hwang (3):
  bpf: Introduce BPF_F_CPU flag for percpu_array maps
  libbpf: Support BPF_F_CPU for percpu_array maps
  selftests/bpf: Add case to test BPF_F_CPU

Leon Hwang (3):
  bpf: Introduce BPF_F_CPU flag for percpu_array maps
  libbpf: Support BPF_F_CPU for percpu_array maps
  selftests/bpf: Add case to test BPF_F_CPU

 include/linux/bpf.h                           |   3 +-
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/arraymap.c                         |  54 +++++--
 kernel/bpf/syscall.c                          |  77 +++++----
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/lib/bpf/bpf.h                           |   5 +
 tools/lib/bpf/libbpf.c                        |  28 +++-
 tools/lib/bpf/libbpf.h                        |  17 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 149 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 10 files changed, 309 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

--
2.50.1


