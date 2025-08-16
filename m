Return-Path: <bpf+bounces-65798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB10B28905
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD383AB320
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1651400C;
	Sat, 16 Aug 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrHVkK0e"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CF944F;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302761; cv=none; b=maAlBPbO9jxZljx6eXzchogf2W29SZkKK0PhbYSR3IZa69e9gELDGkrp1v79BlT9JjcOjUxr9ZB+CpGmbT7fchg4UPN20s9ni33qfL2BG0O6ZFvic91xzY+QG+3MVqbBXdJob5dOWCeZ/8UmsaDbx5TpAw+ajuxNkWndYyeSu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302761; c=relaxed/simple;
	bh=Nsb0nSy5MOec7iftbI+KS9MGNfFWdbMuV/dAsboyXJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZ81bPxDa8mZugENC/HyO8eKMH9wq/GJ8tUOYKSQQ44qvyl7My+tSy1Qmf5heAg19hp64/o8lFa5MQjbKV/o339uPvX/OHhbBhLelWFIttZODhVISo2MOnuXl5v9jNoBA4aD1xsOXLuwi46XANcSIULGpvDG/bm2MtEeU+UjRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrHVkK0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C0AC4CEF6;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302761;
	bh=Nsb0nSy5MOec7iftbI+KS9MGNfFWdbMuV/dAsboyXJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrHVkK0eULQgxNHH/Gd+LKc/qRhrcPLxwa5IKJe2uApV+ykhHK41+YvBEGKAJmAAz
	 O6KdrN+WM3/zieqPAfoqqyL2kH4FO0eJp9L1uMUnQYiLz0KBGXkzcBsrfY+LcHHKuf
	 ZkvCNQYv7AtIWQhpPT8zHY6E+YBkXuOboR1b5UwfZNGa5TV0WF0cfaxeRA1JYlfx7D
	 bmBA7B4pyMj9cZkFeeYseTZvDM9wj9KnC8nkIo9KlAEXlxepJyaaJhqOUg1weyBCTX
	 We+nvxy8UziZTjOG+JXMIgJn9RHI5BOCGRgg+9TxreB6rKbZofyVXg2/y/v3v8UNiS
	 Zq5TCalh9hM6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88ED0CE0B31; Fri, 15 Aug 2025 17:06:00 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v6 3/6] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Fri, 15 Aug 2025 17:05:56 -0700
Message-Id: <20250816000559.2622626-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
References: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the usual scoped_guard(srcu_fast_notrace, &my_srcu) and
guard(srcu_fast_notrace)(&my_srcu).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 7a692bf8f99b96..ada65b58bc4c5f 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -515,4 +515,9 @@ DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
 		    srcu_read_unlock_fast(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
 
+DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
+		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
+		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
+		    struct srcu_ctr __percpu *scp)
+
 #endif
-- 
2.40.1


