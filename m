Return-Path: <bpf+bounces-50141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D9A2344D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6988F188839E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA11DE8B2;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUZblHjr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D31F0E5E;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263799; cv=none; b=U2AcBRA1QGwP6tHIHVr1lgm3bkWLQ6yPvcUKUQwUDrZayocf28MH4R6crKTTz5A6yYAXTvhbKbGdsM+hUKtNAVdBbtijKecC5OpFv92rSgJCYv3bt6s9ZTxe890tO2yGD0Frl6NfX8aVX2/7aL38cOJ1xidhC/q4gmJd5EG5U3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263799; c=relaxed/simple;
	bh=UR/Rn9pC0dW/p+KqOSW1aQQ3aCqXOaNXwo4KDYRCE0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXtlkCDe8bKwoYCh13jVAbCtt54j4gO9ioPg5cyehVvdluH/17nmOziRVs5/6yIebdD895bP+CaQ92ujPlGVxzJQahqJ45MF/WkG9Phtt/E3IgseXd9uByIZKDH3XWRXvq8GrnsHcbiEDf5zIWVbQCw/aiDzU7n8YpzINxRmzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUZblHjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3006BC4CEE1;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=UR/Rn9pC0dW/p+KqOSW1aQQ3aCqXOaNXwo4KDYRCE0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUZblHjrbz3nWQNMO5Xh60kKeMGmSSMuTzDW1+YPxiZ2udqWkSkoM+i1SQWd3UPXw
	 x7AokFxQqAbE7WRJrXFrpYT7BH3YTXN6ybyNIooH3D13rbsCLogXQwIA9IZIuzUy/j
	 Bdk4ew8jkglRu7Qr3rXBwIAU/ePbGm1kyXbKbQXLpYWmxQP0wMFjz8Yo0ASUtiuJhz
	 lbVOOyj3drjFnSUbqvTQQmmB9KI8SPkJooUIM4SeWa/XqIuUk/OUXoG6hKJfR9nIb8
	 MCI5eBZ2IZwdgosrM/488UeW537uRtKUgOjbCzIjrM49DIQro0wJx5+r1pMG0sGdMq
	 vNrSg5CksFXUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4BCCCE37DA; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu v2] 02/20] srcu: Define SRCU_READ_FLAVOR_ALL in terms of symbols
Date: Thu, 30 Jan 2025 11:02:59 -0800
Message-Id: <20250130190317.1652481-2-paulmck@kernel.org>
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

This commit defines SRCU_READ_FLAVOR_ALL in terms of the
SRCU_READ_FLAVOR_* definitions instead of a hexadecimal constant.

Suggested-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
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
index d7ba46e74f58..f6f779b9d9ff 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -47,7 +47,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
-#define SRCU_READ_FLAVOR_ALL	0x7		// All of the above.
+#define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
+				SRCU_READ_FLAVOR_LITE) // All of the above.
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
-- 
2.40.1


