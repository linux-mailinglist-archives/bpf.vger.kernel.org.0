Return-Path: <bpf+bounces-50151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C7A23459
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9249A3A62FE
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEC01F2394;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS6xS4ac"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F661F1504;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=H20Z7fTlb27nkiJfmrLgbKc/AKBulraVRJE9DDjbZqaggyOYrmHYoVV8TyvH+T+yraeBdQvB86haQrQY+0NXBaqGC8Gt92rtXLoDt3lGFXFXQYnQgyrVJrPJWa5NMwMbRhMyBgQxgojEPhrIkFmDPoZ8MGc1I12pgmoEqrPsbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=SkUVKqjw0WvQtf+SfCmutLxRl7zCrBQzPzWYoA+XivA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRFDk8T7A1G0AsqNgQWs5wRNqX2rb7Yk+FCAF62U3Om/c7PTIgP0VtI6ovx+F9Aa5rpJ9YVrAy3IBWblNknZ+YoXoISwCtNNvDZy1olMN+4YIxlJEDx3fr+MR1MGGLSz4K78lUwQyrsWBmTOmUTyAMerZBqG/dGcX3pDoverb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS6xS4ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB06C113CF;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=SkUVKqjw0WvQtf+SfCmutLxRl7zCrBQzPzWYoA+XivA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OS6xS4acMqdnO7P+wLHcO2rqe7zKb4QNs0dmAfQcPUs3Dw1zmCwK5rRpEz1anNIuE
	 7sifKsR+CVdGHqtgzRiPXnTFpHE1uiIHT/dmdIeCAsp6GHUC2A02J17e0tyLCorePi
	 iuGk8zAiE89tkricbNJQHwSWR10fKVPQz2YAfKxXzwET7SHVEzaPBybeBAtx/N/ekN
	 IJMgyJIfIkj/lhm/3HQFjPaTaBq5OSIApNt9mh2R5DmNqi/pE/Mrm9fpV4AyU7Z9Rg
	 ZPFWkIjC9dz/CDIBgmdOIVMkqFYV6QiFsfAqI0de0CByoQPfbApJHaHZCWsLHKZAqE
	 YPwTyPPRgZVrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04825CE3805; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu v2] 14/20] rcutorture: Add ability to test srcu_read_{,un}lock_fast()
Date: Thu, 30 Jan 2025 11:03:11 -0800
Message-Id: <20250130190317.1652481-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit permits rcutorture to test srcu_read_{,un}lock_fast(), which
is specified by the rcutorture.reader_flavor=0x8 kernel boot parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1d2de50fb5d6..1bd3eaa0b8e7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -677,6 +677,7 @@ static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
 static int srcu_torture_read_lock(void)
 {
 	int idx;
+	struct srcu_ctr __percpu *scp;
 	int ret = 0;
 
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
@@ -694,6 +695,12 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 2;
 	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 3;
+	}
 	return ret;
 }
 
@@ -719,6 +726,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
 	if (reader_flavor & SRCU_READ_FLAVOR_LITE)
 		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
-- 
2.40.1


