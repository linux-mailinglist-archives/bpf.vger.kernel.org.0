Return-Path: <bpf+bounces-50154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33861A2345E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DCB188646E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31B1F2C4E;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjXuxQtU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733621F1532;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=HfLHRzlpc6ft4vOz/tHhIbnYvEom2LFj5btW5D7Do+UKQ1SsO7KyhbVRD24l+ocFaf5oWFBBn0eN4nvV7IrI5VcEe9mI8bp6E1IDmvNn5oeFaQVL7N8yzhQvUW+akZl+Pm5fjsYgCS4zwOZvslpR+BzOfRxCWtencAyje+PIixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=30XXM/g0QL56tERVc0DUJKEyOjPfoRcWi9Er6+x7o44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c43V04tLaCst70XjDE0g5a+h1mneR4z6xtND2uSVRlF8SGyBtpVfgGcrFLx96CnENGcz3iZULsnblb/CbZJAx0Scz8xBy4i1EXt63alOq7/xb2XH/jc+7BTTehrXr+ZANMYh+FLfJfk3Ulo0XToUpAz7WkeL46yJ6+317gD6gcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjXuxQtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2F0C2BCAF;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=30XXM/g0QL56tERVc0DUJKEyOjPfoRcWi9Er6+x7o44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjXuxQtUeOOKiCNcmPaykO8j1qT1piQ/7RfYIvr6iD1UvIlfPGhq2mzMe7/UKpGtF
	 aYraHQCGDQZE5aozUHSyTXmpi5uT2nE5kBs+lqHY2dYKSnmALygRQ0kZOQGjexjAU3
	 LFDuAB5g8IORM9w2PrpdBk/0jCnKoHc4RM9UoU64ICdrxlNeBsE+wBLWBt8sCRGkx0
	 De66pjDO2Trui2r7Rpbwcu3bq+/Qi3GfqamDYPmv405AnQ8ONhtvn65ULNqBLJ3KY7
	 KJ8yC/CqbUFH17ueFhMaeXU5kzdS4u56yE8XngcTSScm8rmohi0CouKvYCwimDbHWt
	 Um1rYWkSmQ5gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0F47DCE398C; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
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
Subject: [PATCH rcu v2] 18/20] srcu: Document that srcu_{read_lock,down_read}() can share srcu_struct
Date: Thu, 30 Jan 2025 11:03:15 -0800
Message-Id: <20250130190317.1652481-18-paulmck@kernel.org>
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

This commit adds a sentence to the srcu_down_read() function's kernel-doc
header noting that it is permissible to use srcu_down_read() and
srcu_read_lock() on the same srcu_struct, even concurrently.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a0df80baaccf..317eab82a5f0 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -359,7 +359,8 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
  * srcu_down_read() nor srcu_up_read() may be invoked from an NMI handler.
  *
  * Calls to srcu_down_read() may be nested, similar to the manner in
- * which calls to down_read() may be nested.
+ * which calls to down_read() may be nested.  The same srcu_struct may be
+ * used concurrently by srcu_down_read() and srcu_read_lock().
  */
 static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
 {
-- 
2.40.1


