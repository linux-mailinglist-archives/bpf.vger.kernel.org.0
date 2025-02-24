Return-Path: <bpf+bounces-52374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCBA42669
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26140165E2C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFED219300;
	Mon, 24 Feb 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mw3sMGP2"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF213D26B
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411282; cv=none; b=NbNNeSqr4SmHuTZ5w6E0o++gEtxtGSMyUbVchmSMQiR0FOpCUxoEcN7XeCOIaMPSAzkwObXafBDr/DyYSByGpTHA5p1A5QFPc+w2FwN9fk8HrZK3XUyagUJ0SS2DD4wsnSCuvmixWywiRuJE2ssnjepi6Uc8FYCMMmaaWZvyW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411282; c=relaxed/simple;
	bh=oGAXwbtbi7BVHwOB0s54f/sqDdObG3B2K+cxxb2TsOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyTC/8J8fZtgK9FEs6aii6yzdXFWQGcgZ8hz31TY9iSLdyHbd6yMddAzrGlYJNaPIomkZ81d0HJRoslavr5ZFFoPG2KmQpkaY92dy+j5XLnI41YDvvol1VjBZZBIW3+bTJ4qjdQGisU3Jj9dImTSoYw9rdUYj36Y5okNRZph56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mw3sMGP2; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740411277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AH2ViVqIJIpQPEeyXNmpj3QM1LI7DWlAvUcdY/DIMR0=;
	b=mw3sMGP2gGpsEN22NuTqlZ9ZRBNJU0uniAKIlxJA4dCv4tywFwXvz50lcMLgLbIw9Hy6Dl
	+AaTUrCZFMfRLnrkqiJkqPoanaFYIwXdLAINoOmd9oO9f10UC1LXC38riJZGCmuA41oktn
	xRxPxNIkSAPamj4kx+v7PePOIGNrvq0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	me@manjusaka.me,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/4] bpf: Improve error reporting for freplace attachment failure
Date: Mon, 24 Feb 2025 23:33:48 +0800
Message-ID: <20250224153352.64689-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series improves error reporting for BPF_LINK_CREATE when
attaching freplace programs. Inspired by the discussion in
"[PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog method to
output failure logs to kernel"[0], this series enhances that freplace
attachment failure returns meaningful logs to userspace, aiding debugging.

Patch breakdown:
1. bpf, verifier: Add missing newline of bpf_log in bpf_check_attach_target
    * Add the missing newline in
      bpf_log(log, "Target program bound device mismatch").
2. bpf: Improve error reporting for freplace attachment failure
    * Extends BPF_LINK_CREATE to report detailed log.
3. bpf, libbpf: Capture error message of freplace attachment failure
    * Modifies libbpf to capture freplace attachment failure log.
4. selftests/bpf: Add test case for freplace attachment failure log
    * Introduces a selftest to validate error reporting.

Links:
[0] https://lore.kernel.org/bpf/CAEf4BzbbyojuFSS7xQ3+jZb=dHzOaZfMbtT+WnypW2LPwOUwRw@mail.gmail.com/

Changes:
v3 -> v4:
  * Add libbpf API bpf_program__attach_freplace_opts() to use users'
    supplied log buffer.

v2: https://lore.kernel.org/bpf/20240725051511.57112-1-me@manjusaka.me/
v2 -> v3:
  * Address comment from Andrii:
    * Report back the reason for declining freplace attachment instead of
      logging in dmesg.

Leon Hwang (4):
  bpf, verifier: Add missing newline of bpf_log in
    bpf_check_attach_target
  bpf: Improve error reporting for freplace attachment failure
  bpf, libbpf: Capture error message of freplace attachment failure
  selftests/bpf: Add test case for freplace attachment failure log

 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/syscall.c                          | 51 ++++++++++++++++---
 kernel/bpf/verifier.c                         |  2 +-
 tools/include/uapi/linux/bpf.h                |  2 +
 tools/lib/bpf/bpf.c                           |  6 ++-
 tools/lib/bpf/bpf.h                           |  2 +
 tools/lib/bpf/libbpf.c                        | 29 +++++++++--
 tools/lib/bpf/libbpf.h                        | 14 +++++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../bpf/prog_tests/tracing_link_attach_log.c  | 48 +++++++++++++++++
 10 files changed, 143 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_link_attach_log.c

-- 
2.47.1


