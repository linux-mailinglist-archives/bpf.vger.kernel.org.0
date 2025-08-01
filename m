Return-Path: <bpf+bounces-64857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C57B17A66
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E499C16776F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AA2E371B;
	Fri,  1 Aug 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWgl+S9v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933623AD;
	Fri,  1 Aug 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007159; cv=none; b=T4tPNC5bXZeL7zJ4KPfXybA1G+JbLrDPAvokkcDKQA29a1RxE1m1dw1M5DaNwZiC62oOMk2yFlMr5XTrwlfPIMtu+/xfOxOx5U3Sm80SmrF9Mv+SGBuccyV6NxVkhv2Js+ysCvUGl3wyuFmEBSCLC9JCJk7IqPmhO8OA3NcuqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007159; c=relaxed/simple;
	bh=MJ5bAfE9Srk8OX6f3Xl/KDXvlfaoSrdv9K67Uthyu4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POhfH3lzYLP0sEI86FGUF/QZPPg/exbDzAsv0g2riag7nNhc6EC6JoKhwZjO5IuGn0sp16TAeJSaP1eKY+eCxZbAIh21l6N3bFpj/2u5vN+teziEwwT7Hlny6JQffOOelXVSuviE40c2veIDQOSMdDbjxAVkGb6Lv2jx7abaIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWgl+S9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82100C4CEF7;
	Fri,  1 Aug 2025 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754007158;
	bh=MJ5bAfE9Srk8OX6f3Xl/KDXvlfaoSrdv9K67Uthyu4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWgl+S9vzmpUr3PRe/9zMBRIhYjco/mdhRVDOU2M+3ZfXzPGMyaQm+tHBTX8RZOM/
	 Oe6FNaWPfAXEpOODP4gwU9PBKi0v/IU9QjTfkogNupsbqaASHIXY4W8oOvuQmT19rH
	 JBDYGr1O+O1xMtd2SSzq4j963ozDkD3ZwGjRlyRG5H1+vCRqnrWu0/tTFOWS3JCa1u
	 3zJ+qeHmUB8DLihBk2NeYzdYXiV0jnDJkJGO46CIMmCbMR4TuaJZ6VhSb5hA+l9oxf
	 oCNNqRFeIdNGzOMf1TxynrSllKw4G4WhCMHukeJmmIKqt93V9RcXZ8chfn8t5Sdm2b
	 VKXbd4DBBWE0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B728CE0BB1; Thu, 31 Jul 2025 17:12:38 -0700 (PDT)
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
Subject: [PATCH v5 3/6] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Thu, 31 Jul 2025 17:12:33 -0700
Message-Id: <20250801001236.4091760-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
References: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
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
index 7a692bf8f99b9..ada65b58bc4c5 100644
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


