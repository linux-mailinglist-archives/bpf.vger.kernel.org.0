Return-Path: <bpf+bounces-67566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A3B45A44
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97627B4C87
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3636CDF6;
	Fri,  5 Sep 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DoeCjKak"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BE36CE1D
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082143; cv=none; b=WFUrfR/fpteKfyn5p/C1pVI1F5FoHqhJWDYSNhpfVqn/fSQ27YAJLIDEMachF6+9ZAaSSbDf15VLIbgznMPPmYNCDYb3bGok5AKUfyRbCupol9R3QRNjRe0Qsg5FrpBo3oVI457Aar/dbs+MRFuhTzjg3rXpX8Ceij3qEH1fzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082143; c=relaxed/simple;
	bh=UepX9/jEeWK8We6oi1qeH6us2nIqO/wf+O7KJHzSFcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcjsQpwzXozibQhjymOqhQx+7I0Xgsod5TJBxKuRh18/eBdwG6CZfpXyeTXNYdaY4fBSpuFzY6KvTKF2N86QtpghGOJS5UrJtMvUybMD7P92sfYb+W47QmD1otQkSUaNDRmJW958o+O0LpU7GNPiGA7zg/IpTNDUZxlw8zb7Ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DoeCjKak; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757082138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zsin2meqwVVQQcMY1d3LwVjxp65TINTaRF6/iUyJoqg=;
	b=DoeCjKak5IP/DmwxBthoObpyRlJw/r0MF98s+5wLwyKLmP7ESxmv7H6g7FvfAXxnaaZtzR
	wgIFWgDekwWs4R5M6DPYbe78GhsW+OIjnV02t73D4DJlckNGzwdIVVp64ARIy6mnru5tme
	Td4VA0IJmrkiww/ALAOq5Y/hhEfY0os=
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
Subject: [PATCH bpf-next 0/2] bpf: Reject bpf_timer for PREEMPT_RT
Date: Fri,  5 Sep 2025 22:22:03 +0800
Message-ID: <20250905142206.88132-1-leon.hwang@linux.dev>
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


