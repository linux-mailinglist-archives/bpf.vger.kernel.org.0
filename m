Return-Path: <bpf+bounces-41463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD09997419
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F131B1C2332F
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607CD1E22E4;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqGPF8Aq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F21E1A15;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497241; cv=none; b=L12yV3O9MCcw4Dv7QM9ufwJbW0iTSlTtHUwmAMJ3TGuvJeh7dws5JkQS02ETl4SjAxDDaB8RJme+7AX/JWQJyJFT1BksZvZ7SQqHj2ey7YZCP/ZkBKsjsFBPO7pK3PXjcITo6lJkU1jaFBvgZZrEgsEO6IrxcrB9tTIy3L2uJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497241; c=relaxed/simple;
	bh=HtkA9wBw7Sojuw5HhHk7JjMMtDq6tne9Y9iMOe1hFF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hl2OwjL3sW9sLD6nA9983XK6/2RKKNk8c2vL4QU4tHEjs1cx6vyaYEX2oML14uNo7SHozHKvDMrwF/kC9R5QcjPifzhIwVDPwVc3s7mH3sgwc0JutuUmzHJev7sHkDn71eLerv7boy+HmxNl3aGDOeT6fGjsErz2rxB8PmQemjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqGPF8Aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F304C4CED1;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=HtkA9wBw7Sojuw5HhHk7JjMMtDq6tne9Y9iMOe1hFF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqGPF8AqxWt/aL5IflAfoA230W+8o//V+Z2zhRDAQwwntw3FvlmAPKdZYgZZdZIGi
	 khwys5GRAwatZlqCM82NEqUK457Sb2erAn7DxBcV686NpjeqghOj2h8e1zqR7OjJIl
	 C64pLzxzeJ5kJgB2BICFQ8QcFIFf7X4rcNkHDo0WsPob6eyNO/oo25Tw+tB+aootXF
	 NcDxrrSkIBv2qTyQ3UfQQCoBg91oo+E8d1e9SqD4alLOM1ZDZ842/nBcTpSyArb0RF
	 f2FlBveOvWqjtqLcGJaYCnbqF/XbJIvdgAGiG/331fFV07qClA/7egqhTqNXbjzkt/
	 7bXgVlw42rwXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 18532CE0DD1; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
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
Subject: [PATCH rcu 04/12] srcu: Bit manipulation changes for additional reader flavor
Date: Wed,  9 Oct 2024 11:07:11 -0700
Message-Id: <20241009180719.778285-4-paulmck@kernel.org>
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


