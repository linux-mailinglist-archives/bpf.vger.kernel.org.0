Return-Path: <bpf+bounces-64212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD57DB0FB6C
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52BA1AA71A3
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD65237713;
	Wed, 23 Jul 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihYGrKPM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28F1EEA5F;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302484; cv=none; b=fHV1GUSLM5RsB+O+GNxk46pFB1rcoDlGH6pYpd8BsyK72aTnhucDFVn92L9QOB6k90qOib2cgwYX1XW6vZWosfQ8WMSDg8wGewf8QBDWyKBeSYSGj+5VTJAxGrLv87TP6UF1L4ERKLewkCKydSJejkjNJDlH10yAaC6lsY5DvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302484; c=relaxed/simple;
	bh=Ta9aIor4BQit4OnpAbqvXNX0/P6L2jwLAeMWjUv0sC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfTHId27DAcS9MBkMFpMfVVf/TEc1tBmluD/m3LRmJX0aig6/Psl1zacIBzVngu+8dK0PeeJWtMOYkSjcmv3H7kNlfp2zch5K9muMa7WkiCrhyR3qnb/4pRkZ5oXDZO3EQCpFKc5wGxoSwINYk0JkD+IP5BMV9747doEZ5hNpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihYGrKPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61674C4CEF4;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302484;
	bh=Ta9aIor4BQit4OnpAbqvXNX0/P6L2jwLAeMWjUv0sC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihYGrKPMCy5cws+s+fpf18WAvJTd9r/nB9FO7xBwudYl6By+Of5NlBdDmvZUB6Fbk
	 5ado4AxIN1gcnCG/kweyRmJKz5y3825rIXXMEY+PRtiTdltzHrJsAkzJG2bZZKjG1z
	 nHfVtF/eWbEa3ZLrTZEQAEPWa8fWVbNW4BIvGz1YmEuiqdgV4Xwsujk9bzo3utXWLB
	 gYOVpqcZSZsYFXOUumaaosiUVMkphO+K/rg8F3c48V21Si/uTI3r+OgEsWFUQsdDbe
	 N5VuhCJsSbUAALPh3QcNp1J/3blr4woLIfyRbEryvufNQ0ypMU3Zez3gc7VfDYvhAI
	 k/jSxgPkar45Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0B5F2CE0AD7; Wed, 23 Jul 2025 13:28:04 -0700 (PDT)
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
Subject: [PATCH v4 3/6] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Wed, 23 Jul 2025 13:27:57 -0700
Message-Id: <20250723202800.2094614-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
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
index ec3b8e27d6c5a..1dc677bc9abca 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -516,4 +516,9 @@ DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
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


