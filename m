Return-Path: <bpf+bounces-41258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4C99542E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5831C24968
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410EE4F8A0;
	Tue,  8 Oct 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4DmITZj"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A2833986
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404209; cv=none; b=RJY/2c9jIKEYh0rHSsQPK2TIg+EV4KysrXn2plkJ5HtKhr2aAI6ZdthbyFO//wrRbSY8MAusxZPY9wCROYJ04O5TH/DqIp/m7biQ/oeIgMEulgG+ZIYSw36NihP9eK+cfVhfDWAeetO9xLFMj19JQRaStutX6O0r3TeO+B1GLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404209; c=relaxed/simple;
	bh=d3rLaK90byeGE8JPEf7fcgRVfGgbIw5Xh3yfCnfm5HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPS45qVKdR0ls5Q3LDHE8NigusVUlEHw7PtJi0W8xob2dGGALPwFwTMN6Fmf7jQmyDbXu5uSV8hP1p6bESV+pX98Cv2qPdFVFhMnmT9/FFs06tNXTWa1iYdqoGdgIlqNxg9sWYvvl9oAURZd688A0vMFfCTKKPy6hQZ7xHoF7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4DmITZj; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728404204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FJYrN5SuilSXytbhTyPhAYiLmEnU66WbJIPSLOdkl/4=;
	b=v4DmITZjH73ygArTDP4fBj6R4sN9wEEgxd9tyOznT/fwEHyPqnT2nsjPEp/cIiWkn7i1KY
	o7hlKHWGq0M3i599hq4IUohU/YTVC0Lju1VR9JMdtxnsO52jN1egKGphkxymi2enVTCLoi
	uzzRhHYBi6drdB4zvFxATlT86pCMVjI=
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
	kernel-patches-bot@fb.com,
	lkp@intel.com
Subject: [PATCH bpf-next v6 0/3] bpf: Fix tailcall infinite loop caused by freplace
Date: Wed,  9 Oct 2024 00:13:30 +0800
Message-ID: <20241008161333.33469-1-leon.hwang@linux.dev>
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

Changes:
v5 -> v6:
  * Fix a build warning reported by kernel test robot.

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


