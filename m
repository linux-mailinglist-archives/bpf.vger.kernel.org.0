Return-Path: <bpf+bounces-41761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA01899AA80
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D9F1C21489
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EED21CEADB;
	Fri, 11 Oct 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob2jLMg4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6241BFDFE;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=ePT9IFfRwROBDYr+oMwk8AK4xA3h6e+K3fzqidS9k8MlsuP99048PidkrH2ZNsIcccKBdGWI+BB4fgc4JQQ17SJxV9NEpLbrIHK26AQc9MepTLUwq5mHXk9aMS1vN8WIwMkEzjHxE3rAUQsPlY/8ShLT/thAvWXqwKZd3lekNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=HtkA9wBw7Sojuw5HhHk7JjMMtDq6tne9Y9iMOe1hFF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+LpScnC3EGii6NfOgQ9jk15xHn7a3bt7b2U2qE+CJ88WBCNPkSWgElmXpTpvoGWnhbvXHF1QaYwyxVSz9UsxsINhg6DQjbNuCvddhf9guFGb6VxC2Qtd8yhjTEQRqCVO8MSdb2m3KLulUkv7wJr0QIDv7Gj/RwWoKIWGIJ8Np4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob2jLMg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1463FC4CED1;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=HtkA9wBw7Sojuw5HhHk7JjMMtDq6tne9Y9iMOe1hFF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ob2jLMg4ro6J/JB+s3BjG3i2e2uU3jB6u1ItK0YKX2XGOkVVVX9hAhmGcg9c8NWwI
	 Xzvex1iXc4Lk5/XZJqY4SBRZLRusIroPNFGq4HP024arBgDozXDx5sIiyi7Qfz3H5V
	 AqGTw9+PBZY2HW9KVXz+wk0B9J937n3ZBY8Zxt56SvSzk13n7ZdeSnC32sCYpWtaKK
	 4dQjAdP/Ahd3RFLqfscl8j/5wDB4oYeiRSTkVgrO5dqzOuKy2yi/3UXlMH4YiqIJDv
	 96A0e2dynnX0PykpHlWbZnWw1XQuFgoY21amh8HGLPX4/rT5jU2fvKrvijttYqDxCU
	 ctPhmi/K01UGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1D56CE0EBC; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
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
Subject: [PATCH v2 rcu 04/13] srcu: Bit manipulation changes for additional reader flavor
Date: Fri, 11 Oct 2024 10:39:22 -0700
Message-Id: <20241011173931.2050422-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are only two flavors of readers, normal and NMI-safe.
Very straightforward state updates suffice to check for erroneous
mixing of reader flavors on a given srcu_struct structure.  This commit
upgrades the checking in preparation for the addition of light-weight
(as in memory-barrier-free) readers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 18f2eae5e14bd..abe55777c4335 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -462,7 +462,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
 			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
 	}
-	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
+	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
@@ -712,8 +712,9 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	sdp = raw_cpu_ptr(ssp->sda);
 	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
 	if (!old_reader_flavor_mask) {
-		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
-		return;
+		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
+		if (!old_reader_flavor_mask)
+			return;
 	}
 	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
 }
-- 
2.40.1


