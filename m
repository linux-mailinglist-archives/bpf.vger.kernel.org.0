Return-Path: <bpf+bounces-40495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4B9895A9
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B46F1C21053
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945A13C816;
	Sun, 29 Sep 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFPwOeC2"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDDAD24
	for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727616500; cv=none; b=KaxNzD+K/D853HNPk1FYFL9zFAIXh616UvVHqJnMKlmfX1dfsIvPVU0t2k6elNJilL1kZcs0lax1RC23KPGnMTuWn3TAqswnSWcqlNo0a5hfcslGydAiLkFOeW9qwmEHLiXTAZWEflhTCSNHIRLe4u8kW16941ZgmLOG02ZNoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727616500; c=relaxed/simple;
	bh=wRuryGddViZoj0M5mHxd0KIwl3Pi1ftLyms2NYZhmZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwtfrvAcxBj/Ozl4NlxQOBwuzpiGiMk1BIDugp/9pap8tkcugvjJJbOjrl2PlCY0JWv/SvHezqBzhoYtx/I73IlCVpva5DIarc03l4KUxI5DDbytx3zS9fwijUqwXn1B0UVXZyl3ZFdxvP6uVOP9QLfrSfsN+fkxA18gHg1AZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFPwOeC2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727616496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MP7egvaOL+u+UnlpYIG2XyDmYiYlz0H6oPBEyjothb4=;
	b=WFPwOeC2oVrKf7SR8JotJ68XBm5RVrA8Z4hw/ptfiNWqEXOd5tDXqsPNPbs3gw2Nb85ACp
	RufRMxgsVftO7kWsk2Ha2GNMihBIKhoRgUO/KYU6Mfr4CZPp+y3WwTOlZBeVFa/fYq+vNH
	bP9RO7t5k4yoqScSiYQV0IdfIK7jGWY=
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
Subject: [PATCH bpf-next v4 0/4] bpf: Fix tailcall infinite loop caused by freplace
Date: Sun, 29 Sep 2024 21:27:53 +0800
Message-ID: <20240929132757.79826-1-leon.hwang@linux.dev>
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

Leon Hwang (4):
  bpf: Prevent updating extended prog to prog_array map
  bpf: Prevent extending tail callee prog with freplace prog
  selftests/bpf: Add a test case to confirm a tailcall infinite loop
    issue has been prevented
  selftests/bpf: Add cases to test tailcall in freplace

 include/linux/bpf.h                           |   3 +
 kernel/bpf/arraymap.c                         |  30 ++-
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/syscall.c                          |  53 ++++-
 .../selftests/bpf/prog_tests/tailcalls.c      | 196 +++++++++++++++++-
 .../tailcall_bpf2bpf_hierarchy_freplace.c     |  30 +++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  37 +++-
 7 files changed, 335 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

-- 
2.44.0


