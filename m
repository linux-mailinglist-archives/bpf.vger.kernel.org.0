Return-Path: <bpf+bounces-73307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAF2C2A485
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69482188E6AD
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0462BE642;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6s7tB/L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBA29E11D;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=cHj/c6DVojjPITIhxoeKA7ajRIgN9xFustT4FQt0V37IE/Hsnd7tSG3gNTTiSCVCLk64LUjnKOMBW9seS0pnDhfVvAc6UiA8AAQVNR5MnMIfrR7ofZQVgsJ5tsjbiIGTQwNZgeZmfBYOsU0YnAMbBTu+i5Mva3rMxubLNMe1Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=aydO2EhRnpEhX554P/jNNt/MVcgcdriGe2FZRVAojYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIff+N6wx2hbzEVYA+unE5d9jODzgSIHQI25Sj0DN2VKnAATBSk9wb1AA0PEm7/LCJ9g6qVDgl8RfP2NJQ/6PsGrkvgDNkYZ3wXvcvghI9BoskqGleVrnWIowf4KLw/kMJUCNGoq3iAVBba38z1dzPg8nmohJUywLcPx/nmlxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6s7tB/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E3C116D0;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=aydO2EhRnpEhX554P/jNNt/MVcgcdriGe2FZRVAojYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6s7tB/LZ7/744EIHVe37Q9UmM+FEa5vb/Tb06xPS1G5qodkTWnuTf21k+jXqQEAU
	 PGcUBtMUAiefrDAhdiativnUP4nQHMU+H3SjIwI3SaW8Cg7OcrjeeiFujR1Jcc/FZT
	 ZjzxW/c6N49rhLYy1LGSdJKfKV+bs5wqFPDHk4ipF2IOpwrtmTc/OtA+mtLY7UDgC/
	 o0nHGicL8+UhTwE98GJw92rhBTb48wM5TyaT76xHML91moIojjTK1+jWeriJQxCTMA
	 PxfBGfIw0elHvRdIOh8ihxNVCLIxJ8VAuyP8T956qoa2Bki5bHfcnMrwtcf2mWY6i+
	 ClTJbBARxSjjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C33A9CE191D; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 6/9] rcu: Update Requirements.rst for RCU Tasks Trace
Date: Sun,  2 Nov 2025 15:06:56 -0800
Message-Id: <20251102230659.3906740-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the documentation to declare that RCU Tasks Trace
is implemented as a thin wrapper around SRCU-fast.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst         | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index ba417a08b93d..b5cdbba3ec2e 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2780,12 +2780,12 @@ Tasks Trace RCU
 ~~~~~~~~~~~~~~~
 
 Some forms of tracing need to sleep in readers, but cannot tolerate
-SRCU's read-side overhead, which includes a full memory barrier in both
-srcu_read_lock() and srcu_read_unlock().  This need is handled by a
-Tasks Trace RCU that uses scheduler locking and IPIs to synchronize with
-readers.  Real-time systems that cannot tolerate IPIs may build their
-kernels with ``CONFIG_TASKS_TRACE_RCU_READ_MB=y``, which avoids the IPIs at
-the expense of adding full memory barriers to the read-side primitives.
+SRCU's read-side overhead, which includes a full memory barrier in
+both srcu_read_lock() and srcu_read_unlock().  This need is handled by
+a Tasks Trace RCU API implemented as thin wrappers around SRCU-fast,
+which avoids the read-side memory barriers, at least for architectures
+that apply noinstr to kernel entry/exit code (or that build with
+``CONFIG_TASKS_TRACE_RCU_NO_MB=y``.
 
 The tasks-trace-RCU API is also reasonably compact,
 consisting of rcu_read_lock_trace(), rcu_read_unlock_trace(),
-- 
2.40.1


