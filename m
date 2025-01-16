Return-Path: <bpf+bounces-49108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B64A14314
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D7B162F53
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50D243878;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNi8Ii+q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D2241A0B;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=LemwpHzxCmlR6v7RKde3yyLtwnESsdjx13/cvkyynb+7d0wJ6bb86ZP6g4cWouHwgweYlk6VBmHJDwGnYF5gtoDoeeKDFOs++6AvMf3xKoQNGD/Qe8T9zFieaUU3FKMsT5+JBClwFR9QQW40v222x416Xyd1MJByxj0VqdmEsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=wIcgVIt7KUOyhwlcdCHRrRl0aW6cD0lJgYWfyk5heZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj1nKKDDVCjHjoFppyc05DMNBZXeqG4/zu4cf8s4nPCOuH5ziBT0aaxD6TFypRXPxcWQb4oXolj3SsmKMqlvKt5F0Vk0UV9ZZf7zMn8hJrpjNjTieiazMnuot2su6rSQ2AOwAKqWGGZgklYcc07GI+XcdkLOz1P/YR2h5d8Sy+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNi8Ii+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55538C4CEF2;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=wIcgVIt7KUOyhwlcdCHRrRl0aW6cD0lJgYWfyk5heZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNi8Ii+qgjgaTu1tG5B3a4QsQAvh3Hc/i7zZV2scBG81N3Nom0/VmZpDhaP0pTDUA
	 aiApUOfi57VGdH3w0xK2hfo6UTOkv/9WHBOY1NSe4C7mzeYm8WolnHw0B355NVB46c
	 jvxvDKwzX4ni7ImgIBjskCzxqz7/NmRas2tE33zDHeCHDTaX/yWGPlzOREphoXydBt
	 XM5atRv05tFLhxdsWpwaI+SUaFPuTo+oR5JA1lxwNf75cWo5+tCMZQ/er4TUuUs5kD
	 qCIWTryNtp/mcT1YXX7iQK5aoCVL2dzZlP0X1r2IBCTCYYmE3GejNPKW6/2WC8I1kR
	 uDzQQuL4AiAeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9DAE2CE37D9; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 12/17] srcu: Move SRCU Tree/Tiny definitions from srcu.h
Date: Thu, 16 Jan 2025 12:21:07 -0800
Message-Id: <20250116202112.3783327-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a couple of definitions under "#ifdef CONFIG_TINY_SRCU"
in include/linux/srcu.h.  There is no point in them being there,
so this commit moves them to include/linux/srcutiny.h and
include/linux/srcutree.c, thus eliminating that #ifdef.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 10 +---------
 include/linux/srcutiny.h |  3 +++
 include/linux/srcutree.h |  1 +
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 505f5bdce4446..2bd0e24e9b554 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -52,6 +52,7 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
+void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
@@ -64,15 +65,6 @@ int init_srcu_struct(struct srcu_struct *ssp);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
-int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
-#ifdef CONFIG_TINY_SRCU
-#define __srcu_read_lock_lite __srcu_read_lock
-#define __srcu_read_unlock_lite __srcu_read_unlock
-#else // #ifdef CONFIG_TINY_SRCU
-int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
-#endif // #else // #ifdef CONFIG_TINY_SRCU
 void synchronize_srcu(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 6b1a7276aa4c9..07a0c4489ea2f 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,9 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	return idx;
 }
 
+#define __srcu_read_lock_lite __srcu_read_lock
+#define __srcu_read_unlock_lite __srcu_read_unlock
+
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 55fa400624bb4..ef3065c0cadcd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -207,6 +207,7 @@ struct srcu_struct {
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
 
+int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
-- 
2.40.1


