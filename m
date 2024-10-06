Return-Path: <bpf+bounces-41064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF526991E56
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 15:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D7B1C20E0E
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D13175562;
	Sun,  6 Oct 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iBTv6NBy"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E717335E
	for <bpf@vger.kernel.org>; Sun,  6 Oct 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219708; cv=none; b=eH8MxSPhfy/6obWVZQzgX0SpI9yMKnkhEBEvu03X8/NcwTXsRP3elf7E836havkPHGS2wg1QqNa1D2vXWeWHBcRY6EVpQFHV7ApevgULkcoDS/KTy63FvjGtMRB0ZYRzw9ZqSqQ4FJbtTlJ2g9nwy/BM+M1Tt/nss6vLkIgC2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219708; c=relaxed/simple;
	bh=cA+h/JR7weAMDgsChI/hR9hb8Q4TJDwVwDrR5Vn2DSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=An/L2DrCWvlzbQzf8xOw6Os+ih49E7hBrWdRDIH25/SFvB2EOg7TwR+xyeMReR3MISGP/DnjLUrZvMmIAv8LOa+T2IYBVZwC4jccLdbCup5DO0u/WfPBGjlNsM9Nq7lFIdnhnqAARUFneOL47awHPpMkLUbXaA40qoACJGzjmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iBTv6NBy; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728219704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eVCNkqDciH0La3PUJvJMQeH0Y5vEZ0ILHzvVIrTrfGA=;
	b=iBTv6NByy6pT7y8d/DdmMyxwFIy85nw1EJ+JWcOwiPltqBrbV6BnEz0JbxK42cHl2HucMP
	Vlm+EjEZFv026ajKXDrwdgwa6kx1yFzz6T2m9yYADiophkTbUlk9Uy7b3wF+xJZMqKI1EX
	0NvWXg5ByaQl++6J1Nu54koMSNznSXQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 0/3] bpf: Fix tailcall infinite loop caused by freplace
Date: Sun,  6 Oct 2024 21:01:26 +0800
Message-ID: <20241006130130.77125-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Previously, I fixed a tailcall infinite loop issue caused by trampoline[0].

At this time, I fix a tailcall infinite loop issue caused by tailcall and
freplace combination by preventing updating extended prog to prog_array map
and preventing extending tail callee prog with freplace:

1. If a prog or its subprog has been extended by freplace prog, the prog
   can not be updated to prog_array map.
2. If a prog has been updated to prog_array map, it or its subprog can not
   be extended by freplace prog.

v4 -> v5:
  * Move code of linking/unlinking target prog of freplace to trampoline.c.
  * Address comments from Alexei:
    * Change type of prog_array_member_cnt to u64.
    * Combine two patches to one.

v3 -> v4:
  * Address comments from Eduard:
    * Rename 'tail_callee_cnt' to 'prog_array_member_cnt'.
    * Add comment to 'prog_array_member_cnt'.
    * Use a mutex to protect 'is_extended' and 'prog_array_member_cnt'.

v2 -> v3:
  * Address comments from Alexei:
    * Stop hacking JIT.
    * Prevent the specific use case at attach/update time.

v1 -> v2:
  * Address comment from Eduard:
    * Explain why nop5 and xor/nop3 are swapped at prologue.
  * Address comment from Alexei:
    * Disallow attaching tail_call_reachable freplace prog to
      not-tail_call_reachable target in verifier.
  * Update "bpf, arm64: Fix tailcall infinite loop caused by freplace" with
    latest arm64 JIT code.

Links:
[0] https://lore.kernel.org/bpf/20230912150442.2009-1-hffilwlqm@gmail.com/

Leon Hwang (3):
  bpf: Prevent tailcall infinite loop caused by freplace
  selftests/bpf: Add a test case to confirm a tailcall infinite loop
    issue has been prevented
  selftests/bpf: Add cases to test tailcall in freplace

 include/linux/bpf.h                           |  21 ++
 kernel/bpf/arraymap.c                         |  23 +-
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/syscall.c                          |  21 +-
 kernel/bpf/trampoline.c                       |  43 ++++
 .../selftests/bpf/prog_tests/tailcalls.c      | 196 +++++++++++++++++-
 .../tailcall_bpf2bpf_hierarchy_freplace.c     |  30 +++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  37 +++-
 8 files changed, 361 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

-- 
2.44.0


