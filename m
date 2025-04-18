Return-Path: <bpf+bounces-56259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055CBA93FF4
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 00:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7454D1B6639A
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F323252905;
	Fri, 18 Apr 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HRYV8/+Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124201B3934;
	Fri, 18 Apr 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016432; cv=none; b=M+eGw8KkHXCM5svwpI6uavJZ7zyM21R/HsoBbwGiG820JHABBN/fMlYZXTwM7iwPiE4fGeE5fYozeez+ReeJ6ZRURtadg7GW8qYchgE71kSBcVG0ordQWngEftqWdx6wBrpLdo/5MG3UB1nzlg1VcE9e4e31heIvuIUfpVwLfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016432; c=relaxed/simple;
	bh=H7WqCHpMdMB/CokFMW1lD3oOtXmiHlojAeUQOBskS1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bn0QUwea33teXqQC34e/Zc+aPSlNt43YNmanaEZFiWsRwewki8VrlqXLC+Os9/8Ra1JAva6imTsXWZfXND4oHUhRtYrjDZS9EgbkZ7aju5UYkTHwcVdr68yMPGPLEx9qvoMReTR4R4q0JyrSPFP5tyzWrZckzvE0ERJNE7JD6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HRYV8/+Y; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qcKnD4zXJrwrRXzvHBW77UtWisyqoslN/MBRZmCmbX0=;
	b=HRYV8/+YATbqXQkzcxvKyuFmK1RLrpG8krSJA8QdqBjA8FiusSkn5nhTYGRZSmoHkWEkkR
	B1GcteOl7T3vt778A0sqUvUkybZ7OJn+OokCsQYV1NdewksyOMhOqRADVuCqtmQsjqAMA8
	SCAKW8Q0He3zBE2evcp9GUth+PqaR70=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 00/12] bpf: A fq example similar to the kernel sch_fq.c implementation
Date: Fri, 18 Apr 2025 15:46:38 -0700
Message-ID: <20250418224652.105998-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch is to show a fq implementation closer to the
sch_fq.c and how it can be done in bpf.

The first part of the set adds a few rbtree and list
traverse kfuncs.

The second part adds a bpf qdisc specific kfunc and then
a new bpf_sch_fq.c implementation in the selftest.

The second part of the set depends on the bpf qdisc changes in
the bpf-next/net. If bpf change is viable, it will be easier to
merge the first part of the set with the bpf specific changes
to the bpf-next/master first. The second part depending on the
bpf qdisc piece can wait for the next cycle.

A few more bpf tests are still needed and a few things
may still need to clean up in the bpf_sch_fq.c, so in RFC.

Martin KaFai Lau (12):
  bpf: Check KF_bpf_rbtree_add_impl for the "case KF_ARG_PTR_TO_RB_NODE"
  bpf: Simplify reg0 marking for the rbtree kfuncs that return a
    bpf_rb_node pointer
  bpf: Add bpf_rbtree_{root,left,right} kfunc
  selftests/bpf: Adjust failure message in the rbtree_fail test
  bpf: Allow refcounted bpf_rb_node used in
    bpf_rbtree_{remove,left,right}
  selftests/bpf: Adjust test that does not allow refcounted node in
    rbtree_remove
  selftests/bpf: Add rbtree_search test
  bpf: Simplify reg0 marking for the list kfuncs that return a
    bpf_list_node pointer
  bpf: Add bpf_list_{front,back} kfunc
  selftests/bpf: Add test for bpf_list_{front,back}
  bpf: net: Add a qdisc kfunc to set sk_pacing_status.
  selftests/bpf: A bpf fq implementation similar to the kernel sch_fq

 kernel/bpf/helpers.c                          |   52 +
 kernel/bpf/verifier.c                         |   65 +-
 net/sched/bpf_qdisc.c                         |   14 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |   21 +
 .../selftests/bpf/prog_tests/linked_list.c    |    2 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |    6 +
 .../selftests/bpf/progs/bpf_qdisc_common.h    |   97 +-
 .../selftests/bpf/progs/bpf_qdisc_fq.c        |    2 -
 .../testing/selftests/bpf/progs/bpf_sch_fq.c  | 1171 +++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |    1 +
 .../selftests/bpf/progs/linked_list_peek.c    |  104 ++
 .../testing/selftests/bpf/progs/rbtree_fail.c |   26 +-
 .../selftests/bpf/progs/rbtree_search.c       |  137 ++
 13 files changed, 1665 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_sch_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search.c

-- 
2.47.1


