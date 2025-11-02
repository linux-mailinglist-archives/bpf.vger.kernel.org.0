Return-Path: <bpf+bounces-73287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDE8C29787
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502723AF7F4
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DFE262FEC;
	Sun,  2 Nov 2025 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D82gWrNG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15C260580;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119881; cv=none; b=bfwGEBBzwX++YqKpP2nN5eu8qjONv+IGb2LAfxZ21s3AlrZ1yh1+1H4YdqiigZhrqkuPvbVPFQvW7y6PIaYO8gLH5KqVsWuvKhzAlU3mmpmxA3KUY2RQIDKFCYFe027fXsjgEFI1unAImeVaniijC1fLNEYUI5eBwSbHdIQ8joA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119881; c=relaxed/simple;
	bh=zFl0SXTsIUbs2MDRVmkN9CUYpYD2KuyK1hQqp11YVqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+YCXyF9tEfPrZshJsosRSzY3Imfn+2YM7bZb8zTuJ1QJwTRqietTd5VQ75/TKUG8XG8paQfN/XYoN+PQTJJn4lH4RAvip7IZl0NmI9dvpnd4hz9oL5N3l3M6EO+ZcP0lBFWECEm/aEKN1Jbx2x3Po0Xk/62xzV1Vjv/9QcWGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D82gWrNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B1C4CEF7;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119880;
	bh=zFl0SXTsIUbs2MDRVmkN9CUYpYD2KuyK1hQqp11YVqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D82gWrNGxstlUCU9VV2MvFrp7nU7tasVHLoYKTIF33XrY/YeGkGAHH+BJlWdZ2AVh
	 BLFibrsVZftE10OqB8eCRi4Ns8Wy1eFKCs4TYIW8qYSwyeb0HA+Iukccp/2V6r6o35
	 zXncR6fnfLR9Dt5rEaB3n/LMiWZb+A7lu+kGMGAaMRB+GIUc93oK9Vi/O3SqtwZtYb
	 USdDEfjqg8FZfhkYaYu1pdiYCB9PWQSRELF/lR3hehXO4UURlvAFcQeYXUw1R6jO3E
	 QzQq+0m321s7Oy5gXczjbYUhJVZ4uDnr/y+ehrT7msJpHfFlsChiM7TWLLgz0PnUiT
	 DYWGTepITycXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A2DF0CE1699; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
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
Subject: [PATCH 16/19] rcutorture: Test SRCU-fast separately from SRCU-fast-updown
Date: Sun,  2 Nov 2025 13:44:33 -0800
Message-Id: <20251102214436.3905633-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes rcutorture to use the 0x4 value of the reader_flavor
module parameter to test SRCU-fast.  The 0x8 value tests SRCU-fast-updown.
However, most SRCU-fast testing will be via the RCU Tasks Trace wrappers.

[ paulmck: Apply s/0x8/0x4/ missing change per Boqun Feng feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 587b28258b6e..4a9b6866c0cc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -693,6 +693,7 @@ static struct rcu_torture_ops rcu_busted_ops = {
 
 DEFINE_STATIC_SRCU(srcu_ctl);
 DEFINE_STATIC_SRCU_FAST(srcu_ctlf);
+DEFINE_STATIC_SRCU_FAST_UPDOWN(srcu_ctlfud);
 static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
@@ -703,7 +704,7 @@ static void srcu_torture_init(void)
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		srcu_ctlp = &srcu_ctlf;
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		srcu_ctlp = &srcu_ctlf;
+		srcu_ctlp = &srcu_ctlfud;
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -736,7 +737,7 @@ static int srcu_torture_read_lock(void)
 		ret += idx << 2;
 	}
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
-		scp = srcu_read_lock_fast(srcu_ctlp);
+		scp = srcu_read_lock_fast_updown(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 3;
@@ -767,9 +768,10 @@ static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+		srcu_read_unlock_fast_updown(srcu_ctlp,
+					     __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
-		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 2));
+		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x4) >> 2));
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
@@ -919,7 +921,7 @@ static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
+		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
 	else if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
 	else
-- 
2.40.1


