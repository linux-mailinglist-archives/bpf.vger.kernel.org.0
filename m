Return-Path: <bpf+bounces-57473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9AAAB98A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7D33B3897
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72C628DB75;
	Tue,  6 May 2025 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L09Y+8zj"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7489157A48
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496759; cv=none; b=F17N+E6tGmSm0IjPy9jKXseXhU+/SebANS83WwekKSdaqu9Tx5Lwa7TapKezHJKjRzB694rCPht2uCo0fXBpyl4OQNIZHXQJjzieEnjWjxnMouPZLmCsjP6cIDu69qDIIXekj65Us9NKAn1qYEcYDwUhOwX12nDhtSXIwuEmcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496759; c=relaxed/simple;
	bh=eeUTgP0NwfL3qcRcHy5b3DMLeOMNME57EQ6Yo/Tcm70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnUs9PioWJ3I2d3uerihtjzeTVrQ8pqCyvEfBoEL2GWOF8Bc8v6fLuT+jB4CmPR9oHAc3kli/B6Bqxylhc+Udt21Mp9CrgGdvMp6q8zoj34VhOGvhhn+a1NJL/j7dcHHE+xuv/N3wJYBWIUkwYiKXHQaYQ6DXjjg5laxY9YYc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L09Y+8zj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V0AQQ4m6E+YaRU1E5pmNn0Fa+e5mr/bxq64cWLQpUlM=;
	b=L09Y+8zjpJj/+TvmfFZhzEo+kyq1lqZUuNrEtpAXKtRyWd/jxfRTvu8bzKdpEPrJAvhvqu
	8CkEYq0C7jttGgdNHb+Kn6H3Q/R5nXbyPqFt5epqIYCbnTm0O7hjHxq17kA7n6JcEgkqZi
	Wrvv6u+gL2PyGnV48ITWpWLgpxS9r1I=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/8] bpf: Support bpf rbtree traversal and list peeking
Date: Mon,  5 May 2025 18:58:47 -0700
Message-ID: <20250506015857.817950-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The RFC v1 [1] showed a fq qdisc implementation in bpf
that is much closer to the kernel sch_fq.c.

The fq example and bpf qdisc changes are separated out from this set.
This set is to focus on the kfunc and verifier changes that
enable the bpf rbtree traversal and list peeking.

v2:
- Added tests to check that the return value of
  the bpf_rbtree_{root,left,right} and bpf_list_{front,back} is
  marked as a non_own_ref node pointer. (Kumar)
- Added tests to ensure that the bpf_rbtree_{root,left,right} and
  bpf_list_{front,back} must be called after holding the spinlock.
- Squashed the selftests adjustment to the corresponding verifier
  changes to avoid bisect failure. (Kumar)
- Separated the bpf qdisc specific changes and fq selftest example
  from this set.

[1]: https://lore.kernel.org/bpf/20250418224652.105998-1-martin.lau@linux.dev/

Martin KaFai Lau (8):
  bpf: Check KF_bpf_rbtree_add_impl for the "case KF_ARG_PTR_TO_RB_NODE"
  bpf: Simplify reg0 marking for the rbtree kfuncs that return a
    bpf_rb_node pointer
  bpf: Add bpf_rbtree_{root,left,right} kfunc
  bpf: Allow refcounted bpf_rb_node used in
    bpf_rbtree_{remove,left,right}
  selftests/bpf: Add tests for bpf_rbtree_{root,left,right}
  bpf: Simplify reg0 marking for the list kfuncs that return a
    bpf_list_node pointer
  bpf: Add bpf_list_{front,back} kfunc
  selftests/bpf: Add test for bpf_list_{front,back}

 kernel/bpf/helpers.c                          |  52 +++++
 kernel/bpf/verifier.c                         |  64 ++++--
 .../selftests/bpf/prog_tests/linked_list.c    |   6 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |   6 +
 .../selftests/bpf/progs/linked_list_peek.c    | 113 ++++++++++
 .../testing/selftests/bpf/progs/rbtree_fail.c |  29 +--
 .../selftests/bpf/progs/rbtree_search.c       | 206 ++++++++++++++++++
 7 files changed, 445 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_search.c

-- 
2.47.1


