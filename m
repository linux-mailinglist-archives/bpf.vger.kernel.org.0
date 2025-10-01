Return-Path: <bpf+bounces-70095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87455BB0D05
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B8D3BB40A
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A8304985;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGwYKN9Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5849303A22;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330119; cv=none; b=L8DRqrXcZl3iLSgbf+6qnf5KnS+LWT/lgTa8iB94dekx+esV7ADOD/G/Wj6x6FEeYLwUAJAfJIWuRaCTbvh512gh/ZUpcOlCOeZhoDWrsvIxjUXcoKppSdFmfpdFADD02HxXweFA90GeGWslXOVtorR6vq07GZ2imnv9vuAQe1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330119; c=relaxed/simple;
	bh=1LD05Jje7JY4+QRieuy7/gMogSMrNyvAzrT45QnCY+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNj9sR1Z4d7xQZ3CXzTsL0GqLeISETsOKavRBgUNqNhcn0lLVNaq4yxt6ZtiMd5VM9ueV7pwmLh8AsTgfyZuB9MvASTNq4Hdg5NKJhzn9YVfirJ6OlzRRHVMDgpq6B/dPvOtWsdXBGc8yC/Ss1mNFps4mfhGVMcYGwuZUKJ7pgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGwYKN9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E97BC4CEF9;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=1LD05Jje7JY4+QRieuy7/gMogSMrNyvAzrT45QnCY+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGwYKN9Q2GnrQ2++a4QBcrC3JPlemY5oGyYqbWqaBzOHRdf872rSKrTknDuOrFqFU
	 GdmkAG9gc4Wa7ziRv40WAdYo1fuFXLWHlXgcW6AOTeqroznLCqh6pg+K/GYgAfM+pt
	 aTM9mm7TJZ2t8SmUSx+4L1XRs2JfEIIwRFHwHi4pPw4If76NvCtiIf9WlSAVymvRtZ
	 9lKLptiLH0IeLPO6MZ9uhZhTMLk42z04sWlAu093AjCMO3GsnaJkQTDfIkLNUgBHU1
	 966/Z4x4yC2aLM2aubQKW0gHam6dClRefZ3nAlxeqa2oXGWp3DBiqyGpgNRe5RburP
	 J6gNWXMb3+MOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 77EBBCE12C3; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
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
Subject: [PATCH v2 09/21] rcu: Update Requirements.rst for RCU Tasks Trace
Date: Wed,  1 Oct 2025 07:48:20 -0700
Message-Id: <20251001144832.631770-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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
index f24b3c0b9b0dc6..4a116d7a564edc 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2779,12 +2779,12 @@ Tasks Trace RCU
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


