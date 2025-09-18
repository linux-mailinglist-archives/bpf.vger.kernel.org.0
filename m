Return-Path: <bpf+bounces-68770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F8B8413B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0561C188950F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726652F5A1B;
	Thu, 18 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erl13Lw2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5E28FA9A;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191207; cv=none; b=qKIkvolQdtPYIPZqvLnTGFQML8rtUnRV9hzlGKn4Kc+b1SdTopdc4nz+mBzBW7ClOugX4lAOg3GCI2H/LyOEpJr0rj7xUOOxRw6VGYrtZ2UlnefCY1PaWrrlUYQaP9zzC0w01ay4qUH9dBYnROFhsjdvJJ91llaxnwZH4+zlSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191207; c=relaxed/simple;
	bh=Nsb0nSy5MOec7iftbI+KS9MGNfFWdbMuV/dAsboyXJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwzfvyPUj1OBJrTkzhS10HONzFCFAUvjgv2YXuKY4DgirpUCOLb4K0OBMFjCtK7w7Nqb73x58XN8jSCsxm8hNG7vtPIeqAl7MLsbRcWsuXrf09IPm3qu48/sP08/72PLzTyjaG6zCdZievLfFbT2PhUKyacweqfcgQgSzTlRyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erl13Lw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B653C4CEF7;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191207;
	bh=Nsb0nSy5MOec7iftbI+KS9MGNfFWdbMuV/dAsboyXJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Erl13Lw2D6g5crg6B62xZXtL7Z29gdMGd3A21xt2dIu4H2icsiP8qe0DdcSAbLFpl
	 Knh3ppD4mhTAnv4TnMSL/6rGnnzm4P/x+iGfM0nUbHJt1jULB1Svjje7NLSZF0tczH
	 8h4UI04/FszYESsKRhiDP903aYg8/O8noOyzBvaDZEoGE3RZ6L3x8tC2XNoWApwoMs
	 viq7SC78c+5j0uXwP4C+NgpDOdPXbM4yRUyWNhULXxJJG6Xjp4IjL9fzwJHyN6cxR5
	 R6eGFRrWa3kmVypGzxKd9vKj9w787/6FEPsDE5YFSp3nWfUtqVu0M1sxNnyBCfW7YT
	 IP/0NOhYkM7zA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E9851CE0EFF; Thu, 18 Sep 2025 03:26:46 -0700 (PDT)
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
Subject: [PATCH v2 3/6] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Thu, 18 Sep 2025 03:26:43 -0700
Message-Id: <20250918102646.2592821-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
References: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
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


