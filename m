Return-Path: <bpf+bounces-69424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B90B963F0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E73E2A2343
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B223532951B;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrV3QjWB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74332897F;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=Tq8JtYvCU3sbdLg+ImMevpqfEXXOyZaJaDzADfYTkzbQZghcXoQ6CZgsqGkzarPuSDVjYXCcesrLqnTYwHXxmCcq6+rZGDOnvxe8sCe+odQU8lwXwwZy+4uhjn65Og53bVcljKexOwAgSQg1eDkJ5ZNBl9FvXL418A/P/6V1NDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=1LD05Jje7JY4+QRieuy7/gMogSMrNyvAzrT45QnCY+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0ncqXQK4571eA0yGC/aDfSAr7mMIMUYv7P3DZljR8YpNX4EkHde2gbkqFoCbQNbLQJFOaGyswIUmELWGd+NuPiDrN9Qh3SouRUCFbxldGJQ9mMshfZ2neTxnB5rkziBORrj+Usk2apH9nX10DnBBdGuihsoHOSfa5sqB15NOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrV3QjWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2312C19424;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=1LD05Jje7JY4+QRieuy7/gMogSMrNyvAzrT45QnCY+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrV3QjWBTs00EdQF3t4xT8BmwIulEwEyj+2C86PmYn1Z/ImvxTZ9aSTdntkKAR/sF
	 E+PZebkgvIiG6KvcvdL17qNv1mLHqjr7+xzsIUjKUVt6BCgNKOJkLvUmaZT1tt6Wm7
	 jinoFsHeH7f8/J88yNEFbgbO0u00qyTDdah9gv+TNb7ibNg36TRGJtDWZAAW2lo66V
	 vOcLnNF2KtWnLTLqjsRKGw3I8onscKGVutCJ9/syMd7CqXzDGaPay3jgh4d77u6cQE
	 2byaePensyVGX56JAqm/JmJRZqazyOUXlG0c3/YIOTgxrRDsuGcCNBztksy3CwmT7d
	 b5BGIqpjr41Qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7D2DCE158D; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 19/34] rcu: Update Requirements.rst for RCU Tasks Trace
Date: Tue, 23 Sep 2025 07:20:21 -0700
Message-Id: <20250923142036.112290-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
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


