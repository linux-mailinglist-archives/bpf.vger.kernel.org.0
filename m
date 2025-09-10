Return-Path: <bpf+bounces-68013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A8B51770
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B00F7AE2A4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031131DD82;
	Wed, 10 Sep 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nmug2tKi"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9D31C57E
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509076; cv=none; b=As/KMPdSayZH0ao8BgtGUG/SutX+mFosaTXvNHPJ9XLsPAQ/D7H3IfDd0WzCqac8W2qhsknIlJ958b88QdBeyoliBXFRMZgxL2vNReDkI6/u0jfkrFAMCtO25aCcY62dRnbb9NFV0FP/0tfhKafDPF4O1TDP6G+HNUCm0zIIp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509076; c=relaxed/simple;
	bh=dHONHElPynn2qhHwWWVODUtNcR6LeeE+cz23213YR7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxYRnzW48JlCDrgkqzIu8oXEcpMg2HvavF2e7mHJVVBMunU2G9jzKpu5nsC0EJW+5I3HLUuy/m3hEr8Qq0pfhLowpIs5CyorUV9gLqnb4TfOYF6/OVSq+D6yGnRHyOg/xm2e8JUT3fQFQwulBP+CzURanEcgAHZFsVTuMyHBPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nmug2tKi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757509071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3DVfvx2Mh8yyfiMNUNjl2xW2yR74GBA/U1dKiV8JtBw=;
	b=Nmug2tKiLcN8rcbdUQgUN25s1Jsm9mnWWa5zPDkcj7ifV7tyP16lX2R2Xk5YdFrqP7UA0H
	vLoMPWywo5PhF5bbrOr1vy6y9nA7C1qTRSbFbjAQPo+MAs3STvZCOQtOHNBBt0zjCclwUT
	IVBE0h2Odj/X3IzlIldZud/fbdBXo+E=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yepeilin@google.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v3 0/2] bpf: Reject bpf_timer for PREEMPT_RT
Date: Wed, 10 Sep 2025 20:57:38 +0800
Message-ID: <20250910125740.52172-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While running './test_progs -t timer' to validate the test case from
"selftests/bpf: Introduce experimental bpf_in_interrupt()"[0] for
PREEMPT_RT, I encountered a kernel warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48

To address this, reject bpf_timer usage in the verifier when
PREEMPT_RT is enabled, and skip the corresponding timer selftests.

Changes:
v2 -> v3:
* Drop skipping test case 'timer_interrupt'.
* Address comments from Alexei:
  * Respin targeting bpf tree.
  * Trim commit log.

v1 -> v2:
* Skip test case 'timer_interrupt'.

Links:
[0] https://lore.kernel.org/bpf/20250903140438.59517-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Reject bpf_timer for PREEMPT_RT
  selftests/bpf: Skip timer cases when bpf_timer is not supported

 kernel/bpf/verifier.c                                 | 4 ++++
 tools/testing/selftests/bpf/prog_tests/free_timer.c   | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer.c        | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_crash.c  | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_mim.c    | 4 ++++
 6 files changed, 24 insertions(+)

--
2.50.1


