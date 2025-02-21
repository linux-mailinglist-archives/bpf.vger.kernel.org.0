Return-Path: <bpf+bounces-52196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F0A3FBA8
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 17:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A38C188B259
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848F1F3FE2;
	Fri, 21 Feb 2025 16:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GHaDMBaL"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B811D798E
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155763; cv=none; b=dRBBLcSIh9bV/iPkwS4n+mBzZK76W6DNRCAYSbKX6nqx78aaFfmiD0NAfL2Zz3mZtbnQK8aX305KvVh5HgGsxOTK9aFn6zNKeXH8sWM13dokgJi//fBBhstC7GJGDTlDYb1QKIvvhw2Y4lQy8nikWamyCtYdt9BVYFGGlnMLLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155763; c=relaxed/simple;
	bh=Sr3f1g459K/6/ITL+NGfJ4Yi43IIAbhmbcbxvCUhxdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvAKqM1aw783BgjkoOUolP5bgGSWU6BJJ7XZ0GbswmXZ8GC3ojy6NZGZ6LgZI/+ryAidxZFbcG+NIFSy2nu7IjpYPnTkkNOb7gfFABrdMDvWFGfodDNmkf5pAQ2mC3exghJQqARfZKDiq9sGDf+S5hhRkZkRAdCd4ZycR9UmJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GHaDMBaL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740155760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=15urwD8tU7xz6Ga1f6pR/GGSFt7Xlh+6gykid3HgNXs=;
	b=GHaDMBaLBliHOvYiCcpuqOHrngTB+PpYvFYe4ZXouiLufI4Eo46UrZBDrRjfVwXR5332k3
	mop8D50UDg0jtR4EPTYKX/k6fZ7IiIYPR8jAQbrdopZnmnIjYdehFEiK7i8+scWE0YUNAX
	GfHmlY4XqxYyXt6akEddhOA2hOr83T4=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v8 0/4] Add prog_kfunc feature probe
Date: Sat, 22 Feb 2025 00:33:31 +0800
Message-Id: <20250221163335.262143-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Change list:
- v7 -> v8:
  - fix "kfuncs require device-bound" verifier info
  - add test_libbpf_probe_kfuncs_many test case Co-developed-by 
    Eduard
  - patchset Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
- v7
  https://lore.kernel.org/bpf/20250212153912.24116-1-chen.dylane@gmail.com/  

- v6 -> v7:
  - wrap err with libbpf_err
  - comments fix
  - handle btf_fd < 0 as vmlinux
  - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
- v6
  https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.com

- v5 -> v6:
  - remove fd_array_cnt
  - test case clean code
- v5
  https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com

- v4 -> v5:
  - use fd_array on stack
  - declare the scope of use of btf_fd
- v4
  https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/

- v3 -> v4:
  - add fd_array init for kfunc in mod btf
  - add test case for kfunc in mod btf
  - refactor common part as prog load type check for
    libbpf_probe_bpf_{helper,kfunc}
- v3
  https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com

- v2 -> v3:
  - rename parameter off with btf_fd
  - extract the common part for libbpf_probe_bpf_{helper,kfunc}
- v2
  https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com

- v1 -> v2:
  - check unsupported prog type like probe_bpf_helper
  - add off parameter for module btf
  - check verifier info when kfunc id invalid
- v1
  https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com

Tao Chen (4):
  libbpf: Extract prog load type check from libbpf_probe_bpf_helper
  libbpf: Init fd_array when prog probe load
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        |  19 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_probes.c                 |  89 +++++++--
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 173 ++++++++++++++++++
 4 files changed, 266 insertions(+), 16 deletions(-)

-- 
2.43.0


