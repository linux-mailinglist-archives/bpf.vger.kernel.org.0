Return-Path: <bpf+bounces-40200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23797EC74
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EED1C214EE
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82392199932;
	Mon, 23 Sep 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="irqDm2xU"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338538394
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098858; cv=none; b=mGREKsktU+NujiR/M/wJR7PfX4/u/cG3llB1g50chGmLWNGXI9cAt0vSyi5ou8rQ3JA42o08OSH4ziGMyqica7TLnmppevuXCgH32uwpjH9PRowj0ZtoeuyEl56P7KeBjhehzNjyuJw1t3A7mCRwilAYG/Zn+F7zLHjd87rXnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098858; c=relaxed/simple;
	bh=ffP1p87UCzd+wdlCh2KZv4XFPU6UNDxuAJQKIQXf+fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFZAoIkCfW2B1utww7UsIFS/x1C4SPZ91ZfwYS6Z0lRYYkxOpqAUwqyfg6/QF3yAa4FykZ6KvkeCKUvZfwbpULsy2FnllDAG/+Lk/YEgg2EyLmZssqHswhFA2ZPzgN1ZPcOWSdZEqll72N1R0EFcIda6Q5I0z4rXUcBDSRt5D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=irqDm2xU; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727098854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JioXZmWGMtD/Q7yLQeQWB+vObuUoPDoqE1udKMSt1EM=;
	b=irqDm2xUayHZlSbWxV7qJ8LxNMdgMf/cAp0JBKs5DEigUKMjnrHkh0Z8n4iAW7v/rnsR/3
	hH78A9dMpGLiU8prD3dHBayOI9O7qBo0LPSzXBa9lyyDxFkG9oCcZQ0YzvbPOVxb+q1FZ9
	iL1XFwij45fvjEIqCA8RZ9L0qsmJcbo=
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
Subject: [PATCH bpf-next v3 0/4] bpf: Fix tailcall infinite loop caused by freplace
Date: Mon, 23 Sep 2024 21:40:40 +0800
Message-ID: <20240923134044.22388-1-leon.hwang@linux.dev>
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
and preventing extending tail callee prog with freplace.

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
  bpf: Prevent extending tail callee prog with freplace
  selftests/bpf: Add a test case to confirm a tailcall infinite loop
    issue has been prevented
  selftests/bpf: Add cases to test tailcall in freplace

 include/linux/bpf.h                           |   2 +
 kernel/bpf/arraymap.c                         |  13 +-
 kernel/bpf/syscall.c                          |  19 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 196 +++++++++++++++++-
 .../tailcall_bpf2bpf_hierarchy_freplace.c     |  30 +++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  37 +++-
 6 files changed, 290 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

-- 
2.44.0


