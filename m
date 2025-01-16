Return-Path: <bpf+bounces-49099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71387A14306
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7E0166DC9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06D242247;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJC2PpuG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77723243D;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=TC6QQv9YCI7U1fKYkbE998oOhjgRg/v3/tbNbmHgx9BURtE6ms7eDm1szJYtL8tIFdA/LT0hrvdZ9R1O3EtEsIZKAxjB6C0noDSmDhwiPT0TLSHMZWem1uJspBlwlF7HuSs8yhn09fUkzJuUizkw40TkZ8NDJTCkG+HiHIBEN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=oUfzD2bTUdiWx5sH1tOTawIpY4y49KbPxHHZxd6j63E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pa2wsqRXif8p/shGwK0PSX42rCcI2jR3/MGg8IcG4QAnzVZ0BAKeu/NYs8xeEkQSbmyJXjjP/HHFoRi1SgIbcxj7RvcFs4UZpaWpVlbDxpRkzxvyBkpf0oQJKiaT+UGG1wA6FL9EQkH4GLyUdG3nPaAasSCyRL/E6Fns0IH6rBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJC2PpuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9232C4CEDD;
	Thu, 16 Jan 2025 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058874;
	bh=oUfzD2bTUdiWx5sH1tOTawIpY4y49KbPxHHZxd6j63E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJC2PpuG1toGYkxxEu0g0O2rX+soQar90oDJSmeFB5mlYEf0YUe3fLVfcvVtlGvdD
	 X3GHnzyStkUT/0Nm1dDWDRI0qF9ewIxHXd6Hh4Z0b1OCoO/Q04oWieZiOH0wl0r6wm
	 rYHLS7HmHkEFT+X0lIayFaKVDkB/wIRWhhUTzfEMoGE5I34Kx49KqP+Mo6agZZbYSR
	 /Y+ecQ7uCymgNn/mQnn8a7HAYsRZGiDYaCfyMesHf7Thuf8BLPNtfDpAvCqSoxHRa+
	 tCdHmaBOZ9jfESVYGpMBCJoJLGY6cRw34orzY4C3YyW9BgSUVT/CguOirDs9tqu+dV
	 C+ruiUqxd98Mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84CD5CE13C5; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 02/17] srcu: Define SRCU_READ_FLAVOR_ALL in terms of symbols
Date: Thu, 16 Jan 2025 12:20:57 -0800
Message-Id: <20250116202112.3783327-2-paulmck@kernel.org>
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
index d7ba46e74f58e..f6f779b9d9ff2 100644
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


