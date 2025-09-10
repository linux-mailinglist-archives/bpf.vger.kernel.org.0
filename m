Return-Path: <bpf+bounces-68014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA6B51775
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3525E05AA
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3A31CA5D;
	Wed, 10 Sep 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LaYpPBm8"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431231CA4A
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509081; cv=none; b=r38QpZNRGr0uCAcbDzBMpCy4bKvx1kP14NcCYynh44HMKq4cUQ0SnzYJtwfm3UvNDnyYrjq4dGQ8RLS+7Oa3rujFpO6HRuBNaK9cN/6rqTTDG8+D6ABb+UcRV832K3GXm+qlSCZJYS4conoueJyDzK9hxNERAM0cLc2l0xEWAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509081; c=relaxed/simple;
	bh=qI31VrlRrJLqzFNLBeqBnM/lwnWydgvJTwVESF3TOrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktbUTuxzX0mQrscFBEU3h4MAwMTbT5IVsFXtqDaEMBE370UMCUBNUG4u9wRhG4pKFgF6KUMXKWNjujo2GS2ei3K8bH7WWPm9hnOHnNkMNXgRQDLM/tWJysPeitn5NCbaMzAQjLgFOKxzO3ldNQ1gqkQp0zpV+mLZt85xN9L/dAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LaYpPBm8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757509077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1hzYX7bbYPN0LcZihqrDJz82LnX6gybd0biUGWAdyo=;
	b=LaYpPBm8DGVmLitHgs4WfoTNWfW+kDBgnYD9jK15pu+QF2+AbkBFWDOzS1/na2CtKkio2u
	tmKv0jwYiXiQuCULsXU+CUmnRUkm3GssGTWyypQANIQGi5Yv1KwYgRr8AUZegeQI0YD770
	wKumPS5m4MgVX+KJRjcBOFYjui+bnK8=
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
Subject: [PATCH bpf v3 1/2] bpf: Reject bpf_timer for PREEMPT_RT
Date: Wed, 10 Sep 2025 20:57:39 +0800
Message-ID: <20250910125740.52172-2-leon.hwang@linux.dev>
In-Reply-To: <20250910125740.52172-1-leon.hwang@linux.dev>
References: <20250910125740.52172-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When enable CONFIG_PREEMPT_RT, the kernel will warn when run timer
selftests by './test_progs -t timer':

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48

In order to avoid such warning, reject bpf_timer in verifier when
PREEMPT_RT is enabled.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c89e2b1bc644b..9fb1f957a0937 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8547,6 +8547,10 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
+		return -EOPNOTSUPP;
+	}
 	meta->map_uid = reg->map_uid;
 	meta->map_ptr = map;
 	return 0;
-- 
2.50.1


