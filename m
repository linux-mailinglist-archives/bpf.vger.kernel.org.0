Return-Path: <bpf+bounces-67688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CECAB4834E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 06:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36D7167319
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BEB21CA0E;
	Mon,  8 Sep 2025 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIpq/Dxz"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497A189F5C
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306439; cv=none; b=B0/8bVg3Po03AtE9Tmtxshxn371Pt+ZUGtV7oOL/d43q1AQVTpTeUufXEqIR7bY36iS6QBCXnAYroGyVXMiqyFc3jJ9dRti5HkY1CCL718HibjcpmAQAT6sm2Xvj4Ko3I1nqYr31JfWQkMELqRkF5S+RNDctSDgemqUPbNRnYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306439; c=relaxed/simple;
	bh=HVnXSpdlmuhwNa8bwrEb3g9ss9OzYcRmk2w/U6sPUnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghK3ts+OGvr037cCnmuNIBjZheU91KAfD0r5f847DgJ4cDrrADrb4D7VNWodQjEwrJFw/cyHJZayyYgVypBs/glkZkBy1kIivKu90UoD6jZaaw/qT/JM+9dLLjngyeJFwhwbr/rH1veMaxFj02cskhzT+l9J2ByhPtRrB7r8p9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIpq/Dxz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757306433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XcyXBpfavjGm0x+LBS4L4aULs2/PfG00IfQuoPVVq5g=;
	b=vIpq/Dxz63t1mYYX1EDMUMWLaGrV2yb1qvogQjyKrsX9ueya7glKpPyC5jWv9bzlX3Mj/N
	M7e2W7PAILBLpd7c43Gx2tNCfGD3k1E16vS/HWKYVBhpgInJ+DXAGahqQOiV2AL4Jpqe5n
	nXkjqH/E5TPwiXonlESYMOoNMrfkuw0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf: Reject bpf_timer for PREEMPT_RT
Date: Mon,  8 Sep 2025 12:40:23 +0800
Message-ID: <20250908044025.77519-1-leon.hwang@linux.dev>
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
PREEMPT_RT, I encountered a kernel panic.

To address this, reject bpf_timer usage in the verifier when
PREEMPT_RT is enabled, and skip the corresponding timer selftests.

Changes:
v1 -> v2:
* Skip test case 'timer_interrupt'.

Links:
[0] https://lore.kernel.org/bpf/20250903140438.59517-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Reject bpf_timer for PREEMPT_RT
  selftests/bpf: Skip timer cases when bpf_timer is not supported

 kernel/bpf/verifier.c                                 | 4 ++++
 tools/testing/selftests/bpf/prog_tests/free_timer.c   | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer.c        | 8 ++++++++
 tools/testing/selftests/bpf/prog_tests/timer_crash.c  | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_mim.c    | 4 ++++
 6 files changed, 28 insertions(+)

--
2.51.0


