Return-Path: <bpf+bounces-57304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A0AA7DD4
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 03:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12DA9A418C
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB627456;
	Sat,  3 May 2025 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GxWrbMEl"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474746B8
	for <bpf@vger.kernel.org>; Sat,  3 May 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234491; cv=none; b=c4PI3RSqIHpMlRCcpW9fx4+xEtnX5AfsC8NvGTuyEhC/gYopU3KwN7C5MT1/9mbddFhmML4dLBrrWIf1lw1kjq/aK+iqQC8LYztKCSZvpm2EE5i8q4Xc68iFh7kTQJY7/B9yoUgPgvkGJCtYNAsiScH2P1mXsI9hFm2azfBq5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234491; c=relaxed/simple;
	bh=RYvmcQbuRmZesR4aqJivdmCiCWHEL77UgiecWvrF2Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOmDNvGDSr2kAWZEkBVqS12GLI5S90ys/XjPyT5H9usQY9FN1Spz/UaNewg5qScxV+47xRJZDeqomGwVTgqQuPyWMOY7ewxsIUlop/CJOpcrF4s977qdfjyRhvfp4dOi9wLSjA72fHg8p8EDajKgeSRwdQd7SvCsycWeCTRr7gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GxWrbMEl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746234484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CKuyWgX9z869Bb99WFsFBIpbYFJIpD1WLWI8Sa6BKwU=;
	b=GxWrbMElbUw+4i5QotdIolm14WqD9EBIjQwosDPo4WVXIGB6hYtR/gypgke3u+TLalYHXF
	KrOxHyMzoml+lFFpZFmC8+ntdI7H+Px1R5Ze0tJYruCxVPsrIf/NK1vL3WZyAp7J/JR2tk
	8y/HYJ9Nm/7dnUP2jwx29garEyqSR4w=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2025-05-02
Date: Fri,  2 May 2025 18:07:55 -0700
Message-ID: <20250503010755.4030524-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 14 non-merge commits during the last 10 day(s) which contain
a total of 13 files changed, 740 insertions(+), 121 deletions(-).

The main changes are:

1) Avoid skipping or repeating a sk when using a UDP bpf_iter,
   from Jordan Rife.

2) Fixed a crash when a bpf qdisc is set in
   the net.core.default_qdisc, from Amery Hung.

3) A few other fixes in the bpf qdisc, from Amery Hung.
   - Always call qdisc_watchdog_init() in the .init prologue such that
     the .reset/.destroy epilogue can always call qdisc_watchdog_cancel()
     without issue.
   - bpf_qdisc_init_prologue() was incorrectly returning an error
     when the bpf qdisc is set as the default_qdisc and the mq is creating
     the default_qdisc. It is now fixed.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Kuniyuki Iwashima

----------------------------------------------------------------

The following changes since commit 8ff6175139967cd17b2a62bca4b2de2559942b7e:

  bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code (2025-04-23 14:46:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 30190f82a1a9eb555703879cfe835627cff7a0e2:

  Merge branch 'fix-bpf-qdisc-bugs-and-clean-up' (2025-05-02 15:51:17 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Amery Hung (6):
      bpf: net_sched: Fix using bpf qdisc as default qdisc
      bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
      selftests/bpf: Test setting and creating bpf qdisc as default qdisc
      bpf: net_sched: Make some Qdisc_ops ops mandatory
      selftests/bpf: Test attaching a bpf qdisc with incomplete operators
      selftests/bpf: Cleanup bpf qdisc selftests

Feng Yang (1):
      selftests/bpf: Fix compilation errors

Jordan Rife (7):
      bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
      bpf: udp: Make sure iter->batch always contains a full bucket snapshot
      bpf: udp: Get rid of st_bucket_done
      bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
      bpf: udp: Avoid socket skips and repeats during iteration
      selftests/bpf: Return socket cookies from sock_iter_batch progs
      selftests/bpf: Add tests for bucket resume logic in UDP socket iterators

Martin KaFai Lau (2):
      Merge branch 'bpf-udp-exactly-once-socket-iteration'
      Merge branch 'fix-bpf-qdisc-bugs-and-clean-up'

 include/linux/udp.h                                |   3 +
 net/ipv4/udp.c                                     | 173 +++++---
 net/sched/bpf_qdisc.c                              |  24 +-
 net/sched/sch_api.c                                |   4 +-
 net/sched/sch_generic.c                            |   4 +-
 tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c | 119 ++++--
 .../selftests/bpf/prog_tests/sock_iter_batch.c     | 447 ++++++++++++++++++++-
 .../testing/selftests/bpf/progs/bpf_qdisc_common.h |   6 +-
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c        |  41 ++
 tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c |   9 +
 tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c   |   6 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   1 +
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |  24 +-
 13 files changed, 740 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c

