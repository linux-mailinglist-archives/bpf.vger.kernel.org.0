Return-Path: <bpf+bounces-38028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE195E375
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBDA1F2177E
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446B514A639;
	Sun, 25 Aug 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbJ51UVw"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC31EA91
	for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724591397; cv=none; b=bF6mOG1pWF+Ngg8mu41ywoXg3FdzOAtLK0KP1MZa2NwIOsSWGzhgRPF/POEJMAZl/9LbpNIlT/p8mK0BOBHlh4ZmIouukSELzySax6xYzNlbz7OeAc1pCP10iERnrwWnmzqZziRUR57Rr4Pua/P2vYkTPXrzkhsEATGeNawkLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724591397; c=relaxed/simple;
	bh=/zI2trWa0W5EnLlsmDM/5LB6/eUj5zIDpCXU3wZs2d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIzfhdOjlITkh027j7b0OaMBwpMpGRucvlGwz+tzOwhjvNBBy1cGmbHE/MlPx4z6ei4WolO523aJWGAFGmyNlN0DVZ97ka7Q2ee5Fd3tshnfw6LmpO8X7qHxyfl+xnhGBUk9FW7GPie00xGuiGZ4vz9eouYstW+qkwI6yRISPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbJ51UVw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724591392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J05nSbQX+or//p+tkZuIve0nmMyeilYLu2fDPc7dpqg=;
	b=nbJ51UVw76B5fFIr7xVq0qtnzZEqCoDi5Qw4JxYKqRa7j92w1f+yofqO2+zMCsx6cU3iBQ
	fzw8XmDAzuqEu38B4DD233W6YTRhnPnYVm3tf7TTggVWFd1DV1i9ua7gHh+FlW7eXqePQH
	Gds8N9IVgbzkaLLaFtjNQiHR7N8Ugks=
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
Subject: [PATCH bpf-next 0/4] bpf: Fix tailcall infinite loop caused by freplace
Date: Sun, 25 Aug 2024 21:09:39 +0800
Message-ID: <20240825130943.7738-1-leon.hwang@linux.dev>
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

Links:
[0] https://lore.kernel.org/bpf/20230912150442.2009-1-hffilwlqm@gmail.com/
[1] https://github.com/kernel-patches/bpf/pull/7591

Leon Hwang (4):
  bpf, x64: Fix tailcall infinite loop caused by freplace
  bpf, arm64: Fix tailcall infinite loop caused by freplace
  selftests/bpf: Add testcases for another tailcall infinite loop fixing
  selftests/bpf: Fix verifier tailcall jit selftest

 arch/arm64/net/bpf_jit_comp.c                 |  39 +++-
 arch/x86/net/bpf_jit_comp.c                   |  44 ++--
 include/linux/bpf.h                           |   6 +-
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         |   4 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 209 +++++++++++++++++-
 .../tailcall_bpf2bpf_hierarchy_freplace.c     |  30 +++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  18 +-
 .../bpf/progs/verifier_tailcall_jit.c         |   4 +-
 9 files changed, 322 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_freplace.c

-- 
2.44.0


