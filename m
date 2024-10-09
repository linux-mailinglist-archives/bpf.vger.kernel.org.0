Return-Path: <bpf+bounces-41467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26D997421
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD11C23DA2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9101E2604;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA6hLzEp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF91E1A34;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497242; cv=none; b=FDVlhdNs53rflxJgYJxT8BMYzbeNUH2FTa6KdeJc6or+2Ys2Xv910MQDaIIZPgXn4bFib8xvhwb4A03uWJGEDvW20WfKIUkchIS+WJcOu1M7mpB4bcvUqPkljWsbMoe1tXBqTBaooYCZubtqt9Uoed7DBCcbuLphOU7IXSsnK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497242; c=relaxed/simple;
	bh=QWCIBNJNmX4+TG7swbkj7aZiNkC9qbNnmlcDDakdbbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMzjkNCiINupEIwMFC56Yl9H33qhtuDFqTJmsI0F+ctcTk4PGBLS7NLji1RBahnhvlMK/5bucmM+DrZa3o++0r0W3Me9Jc9Oz6xnkLhwyY6ds7Llyp1WXQ/DvvH88AOdbBlwL8MHGfJeGROq9D3GxrIxfGhfMgfMfz7GDn9wn54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA6hLzEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4443C4CEE0;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=QWCIBNJNmX4+TG7swbkj7aZiNkC9qbNnmlcDDakdbbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hA6hLzEpFWyGDXIAMJn3qPtajMjZ0ydsTDW+K/ujmWL4Buwjrm8R+ZyS7U6fkhTkG
	 QZrgPMneOetW0mb5wLhsmUvkZpuBgYK30KrYbUym3p8p9nYCWcntd+WJodPthm/4OB
	 G8ZQZDL0lsDXdDXWb/p+FWJTa8hQCKlaGzbuX4f4cWC++aOYESOIjwPKVY97sRAPWV
	 6VTBy0JWHrvtZNmYsuPpwaYMdX7GIy7ACHTULxkL/EruzFZvMzWzrrgp/rWe/9WVvw
	 4cC4vvlFW/j14FkgJbGI/xq9W1X6F+CTnWHehoxGSybPbhjBUXmRh76+lqKYzKYV5s
	 QrYKe8Piy2WIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2CD1FCE158E; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 10/12] rcutorture: Add srcu_read_lock_lite() support to rcutorture.reader_flavor
Date: Wed,  9 Oct 2024 11:07:17 -0700
Message-Id: <20241009180719.778285-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes bit 0x4 of rcutorture.reader_flavor to select the new
srcu_read_lock_lite() and srcu_read_unlock_lite() functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 kernel/rcu/rcutorture.c                         | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2d5a09ff6449b..686ea876a89c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5426,8 +5426,8 @@
 			If there is more than one bit set, the readers
 			are entered from low-order bit up, and are
 			exited in the opposite order.  For SRCU, the
-			0x1 bit is normal readers and the 0x2 bit is
-			for NMI-safe readers.
+			0x1 bit is normal readers, 0x2 NMI-safe readers,
+			and 0x4 light-weight readers.
 
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index daf60c988299d..2ae8a5e5e99aa 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -660,6 +660,11 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 1;
 	}
+	if (reader_flavor & 0x4) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 2;
+	}
 	return ret;
 }
 
@@ -685,6 +690,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & 0x4)
+		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & 0x2)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7))
-- 
2.40.1


