Return-Path: <bpf+bounces-38681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319009676C6
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C066B20E3A
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729117DFEC;
	Sun,  1 Sep 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A9Vn+jS7"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2121552FD
	for <bpf@vger.kernel.org>; Sun,  1 Sep 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198058; cv=none; b=NNlWeUGTGwXU1v3The8lVcwILAwG1m5oac3aB1Kq/bkjKJDM5iOCNBf/hv/3djrvQf+3vwHc/c9HuMUIM6oTOJH/9T782FBjgdWTxZMid5DN5VgJrSVf7CM9sAj/V3qNhloqOBjXQmn6IyNdW0JaP9S8ECQaHAAuX/fcu5JNQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198058; c=relaxed/simple;
	bh=KEpN/xL8V6ye/JpDpwh5+Jxx5/8ZNMUgnSZH07PvhdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrmEnZS2Uo+0NijSWY9B3EmsHANZQbfJrRHqGow6Z/yrb6a2ECj/oPnkl/OegCVL2yFj0D8ZFv3y3UHKZIvHis3RYBkjHLobVpCegDTatK2yMBGHFdDU217hFNAKdVuXKV/QGjqhPGx9ku6e+r7gUrCQO/NrzGN4MrWyJa9RiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A9Vn+jS7; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725198054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TLHuHFAKB6kRffkee8vLvUJLNlpchf/vu2wgV+vRCJw=;
	b=A9Vn+jS7zOEZJ4hPuxGmEla7LT9lY1PNislGmQ4lqLk4KCKJg5BhCHjWUyBSJQ3vat4MCw
	G9MGX9m441NeC5Etz5DBaSY5DIk2cx+Pcz+846qpJ0lZPezditJ1DBjNR5DidJvX97kNRP
	fjbFWtuheL3QbqjM8CAMGJmEKZBCFuU=
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
Subject: [PATCH bpf-next v2 0/4] bpf: Fix tailcall infinite loop caused by freplace
Date: Sun,  1 Sep 2024 21:38:52 +0800
Message-ID: <20240901133856.64367-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Previously, I fixed a tailcall infinite loop issue caused by trampoline[0].

At this time, I fix a tailcall infinite loop issue caused by freplace.

Since commit 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility"),
freplace prog is able to tail call its target prog.

What happens when freplace prog attaches to its target prog's subprog and
tail calls its target prog?

The kernel will panic because TASK stack guard page was hit.

The panic is fixed on both x64 and arm64[1]. Please check the corresponding
patch to see the details.

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
[1] https://github.com/kernel-patches/bpf/pull/7638

Leon Hwang (4):
  bpf, x64: Fix tailcall infinite loop caused by freplace
  bpf, arm64: Fix tailcall infinite loop caused by freplace
  selftests/bpf: Add testcases for another tailcall infinite loop fixing
  selftests/bpf: Fix verifier tailcall jit selftest

 arch/arm64/net/bpf_jit_comp.c                 |  44 +++-
 arch/x86/net/bpf_jit_comp.c                   |  26 ++-
 kernel/bpf/verifier.c                         |   6 +
 .../selftests/bpf/prog_tests/tailcalls.c      | 216 +++++++++++++++++-
 .../tailcall_bpf2bpf_hierarchy_freplace.c     |  30 +++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  37 ++-
 .../bpf/progs/verifier_tailcall_jit.c         |   4 +-
 7 files changed, 344 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

-- 
2.44.0


