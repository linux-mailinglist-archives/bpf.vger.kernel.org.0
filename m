Return-Path: <bpf+bounces-42067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A699F260
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969F9281AB3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31621F76D8;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgLXKw6N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E11CB9E2;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=qrsIqPUqkBKajWnQ8dlZ24YsLbsg2clZwhfXayl4TWy+DlfomLM4DBOz3sGU8dZhvPZp79AhXb2QDK6t9uRFarWmceuYdUfaxPREzzbhNkQ6RctW5IJM7ocg9ecwyKPLHpnbf8RKwbOewjKilVY6bd7+OIE0hCRNj8a82D7rD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=HtkA9wBw7Sojuw5HhHk7JjMMtDq6tne9Y9iMOe1hFF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOyEPZXWwx+6agripVQX0BeCUrfZMVbt1i4UNZ8XRyVjsrlkJfzAsKzD8Kgj1cC+ft9JWqn0g4ra9letBrxuheEq2EE5mYxEUiemS94r27+H/i0JzVYCbK1gk8fwZyuWvUfhbtUocFcKmcEge/M3HN+u2iHzjBryrs56OxMaDEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgLXKw6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E766C4CED1;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=HtkA9wBw7Sojuw5HhHk7JjMMtDq6tne9Y9iMOe1hFF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgLXKw6N3AW+UE0XMhLDqSIskVLB+HpYigMBdbsRUvuki4N7849L9Qsef8x0PCOuW
	 sVKIg7vmnpeAmr4apZ0rwwbgih3UMRxEGxm32fXVw8nxp8dZKFLGANx//Y4SJRHBDE
	 4oD7Q6CUrBGrbVavbSKqXTi1I6v0DXk/2RZmeBy/T9zLtg0SLGXPik28l9fEKAduBm
	 SYdgy3BCwcbvD4pui/epYistnTi7xQxmUyRXFVMDnzF/lce7Wdu5mxL0gl0hXoiz0N
	 33f0I0KfDui+jzdbhJXWmjHbP2rt7xVHU6lGOPpExt9h0DDU87ACcalCaaz7kTQhQ7
	 fBlLYRICxSdBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC0B7CE0F9A; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
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
Subject: [PATCH rcu 04/15] srcu: Bit manipulation changes for additional reader flavor
Date: Tue, 15 Oct 2024 09:11:01 -0700
Message-Id: <20241015161112.442758-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
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


