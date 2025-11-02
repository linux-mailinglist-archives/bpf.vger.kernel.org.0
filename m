Return-Path: <bpf+bounces-73311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C568DC2A488
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C9C188E6A4
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09E2BE7D1;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwySrBey"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8C2BDC15;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=EgooI0OwDCPfWrJWYPq1HmUskypYz8/V0xcJRJJP1rR5vw8XnHFUfFspQT101vGSmEj8LorzTv2g8plm3JPQUwH3Mghng7QGNk4s9RCxud38MNgt736ef+oxEF5MIGm01j87TcC/Pg2OggBHAeJwdkae32cs+cnhYAOtpXhxeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=wzU2Qnm2GHt6DLOx5HoozrHwNMWUtEvwOpzlAH8V7/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jn3xUt6bGrbZYx8q6WfkAf+6Zn1advPiQjf9oq+mHncUudr4BRF7/hT0cIFDEhrd8jLhuKYenjzQ4wcqZwNiIr9a7R7Ats+JvjZtLos73qlcsoYytO7asKBVh65dhkDpO2ORMqu5G//2hthdxf6nkdmGsAQFrkq3cfvDW7qlLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwySrBey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B58C19424;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=wzU2Qnm2GHt6DLOx5HoozrHwNMWUtEvwOpzlAH8V7/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwySrBeyrHwqMf9to0lO3sOlJKkPtKOMXAsK6+2zva43tRL6JRWPA3UnfMxLCnmE+
	 Edx9nSmuQSQER9WZndKlYUGLPDB+K0dgFASq+JHOxPdAitsazq1mGU3689YehQNeIF
	 bqDGfBR15LIjiGtgxU6MJ4UMcPyPiAAF6OZuO3G1mu1o+/NhEzpTas1oxfd1XsLFTS
	 2ksjoLtHJ/QzN3bT/LKhkVEF4prpJW/XIRH/rZSi6EuZC5BuhW4Z7ShsgF8ixl+fa+
	 TND3OMU8XUYiIVz86s12iGvQVfP34HqWw2uMKfAEpknNoggqoCy8jv4+5gthttbT5+
	 f7HgD/XHcVwCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E60B4CE0F65; Sun,  2 Nov 2025 14:49:49 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 1/8] refscale: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Sun,  2 Nov 2025 14:49:41 -0800
Message-Id: <20251102224948.3906224-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the initialization for the "srcu-fast" scale
type to use DEFINE_STATIC_SRCU_FAST() when reader_flavor is equal to
SRCU_READ_FLAVOR_FAST.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 19841704d8f5..ece77f6d055b 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -184,6 +184,7 @@ static const struct ref_scale_ops rcu_ops = {
 
 // Definitions for SRCU ref scale testing.
 DEFINE_STATIC_SRCU(srcu_refctl_scale);
+DEFINE_STATIC_SRCU_FAST(srcu_fast_refctl_scale);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
 
 static void srcu_ref_scale_read_section(const int nloops)
@@ -216,6 +217,12 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static bool srcu_fast_sync_scale_init(void)
+{
+	srcu_ctlp = &srcu_fast_refctl_scale;
+	return true;
+}
+
 static void srcu_fast_ref_scale_read_section(const int nloops)
 {
 	int i;
@@ -240,7 +247,7 @@ static void srcu_fast_ref_scale_delay_section(const int nloops, const int udl, c
 }
 
 static const struct ref_scale_ops srcu_fast_ops = {
-	.init		= rcu_sync_scale_init,
+	.init		= srcu_fast_sync_scale_init,
 	.readsection	= srcu_fast_ref_scale_read_section,
 	.delaysection	= srcu_fast_ref_scale_delay_section,
 	.name		= "srcu-fast"
-- 
2.40.1


