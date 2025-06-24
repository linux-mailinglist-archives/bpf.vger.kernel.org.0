Return-Path: <bpf+bounces-61407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C123FAE6D00
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0151BC3FA4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66DA26CE2C;
	Tue, 24 Jun 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BTacA2Jy"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E422B8AB
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784095; cv=none; b=KQ8kQ1ygcJqI0iI66D7/REKWG4fZzouxJx1LFfblmBjKxinE3XPPVGYFZWgUAnGI2EhAV6aQvtrll6i5BG+lpch18U6uAaDcLpQbWT5cn0/01Js5sALCsI/cyFx4yWkcvPcte4lEhTYbf01K9MF5m77okpi7hDE8w67W8x+gc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784095; c=relaxed/simple;
	bh=p5+obejP06MIydCnavrqDuJIE6fzb6G6nr9lsu1mlRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVvpsFMjQLzx/ymvbdqoOVNPDMazVk6S3ShEiOfkWpXkiwfShiDckQte5m9wkOTuqDZGb1U25yba/jQ9QSgwp2e0UEfaFCea85VKfi7mZRvyEAiHVHPbfMARnGixPa5brnitatFlzTUh226RClRlhRm3NjGfCXJLmGqPlfuF4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BTacA2Jy; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750784090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f2dHgt3TZ34ZZCl09/xVevYpGhr1cRGPjs0TddzxB5Q=;
	b=BTacA2Jy2wbVSaV4eYBaukJ51YyElY0NVOcsi37bT+b1bnble5uSmnyzbCNA/Pz8lYFCHs
	jmQ3bXDCZwchpa2iZvqny+ND3JYpRlTT0EvMcJTIGFb/zVOKhH6eFVEXoiq98y9C4CMV40
	jBBg7ihPKPZK1aNG1DdEywczeswdD1Q=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 0/3] bpf: Introduce BPF_F_CPU flag for percpu_array map
Date: Wed, 25 Jun 2025 00:53:51 +0800
Message-ID: <20250624165354.27184-1-leon.hwang@linux.dev>
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
  * If cpu == 0xFFFFFFFF, the provided value is copied to all CPUs.
  * Otherwise, the value is copied to the specified CPU only.

Currently, this functionality is only supported for percpu_array maps.

Links:
[1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.dev/

Leon Hwang (3):
  bpf: Introduce BPF_F_CPU flag for percpu_array map
  bpf, libbpf: Support BPF_F_CPU for percpu_array map
  selftests/bpf: Add case to test BPF_F_CPU

 include/linux/bpf.h                           |   5 +-
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/arraymap.c                         |  46 ++++-
 kernel/bpf/syscall.c                          |  56 ++++--
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/lib/bpf/bpf.c                           |  37 ++++
 tools/lib/bpf/bpf.h                           |  35 +++-
 tools/lib/bpf/libbpf.c                        |  56 ++++++
 tools/lib/bpf/libbpf.h                        |  45 +++++
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/lib/bpf/libbpf_common.h                 |  12 ++
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 169 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 13 files changed, 473 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

-- 
2.49.0


