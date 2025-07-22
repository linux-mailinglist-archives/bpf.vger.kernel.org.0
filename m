Return-Path: <bpf+bounces-64115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80301B0E64E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF371669B8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685C288CA8;
	Tue, 22 Jul 2025 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGBtmpHa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBC286880;
	Tue, 22 Jul 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222593; cv=none; b=HJeH0F2UXaml6Kc3ajeyjJROnUswvZAF2nrzCVNzRUAw1UdCTyMB5d1dDv6bO36NU3Fh3YxknAUQkmKSNc38tVCSDEUseuY8MFDaoEbNiix71TfKP6l16kIrq4FJGtlV0f/qowaxKiy/w5yezrHwW2eiCoDOrugIbUNqIe252Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222593; c=relaxed/simple;
	bh=XP+sVWW4AN1gL3AcsGgjJ89qOVHp/Q606n0jAmQCKsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=catmzsmIjA8NidKnWXR5OxS2PT4R6vD+OkRW9yhtYAq+wCwnsg3LgJqV2/XbB+6FX1DUqYMed+zMHuXJnkxAi5c3CzULrBYpFUmHFUvNa43gH2rbrXSP1QsMtJkXPXNWEP9aHsDvx3gakA6Q2KEA609/KPydC+7voGS+5jnk3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGBtmpHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37957C4CEEB;
	Tue, 22 Jul 2025 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753222592;
	bh=XP+sVWW4AN1gL3AcsGgjJ89qOVHp/Q606n0jAmQCKsw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aGBtmpHaQSKXa/vldcrNntKFVYSfSiWQvcLpMUIvi85TIyRCG9z8Qv07Uv6af4NEZ
	 yR2K4t5GKVJ5dOi9/sJxMyAuERQmfAGMU9Ek/nhz0QiSFnAVXAXSQx8jGzlt9yEVyL
	 y5+CT+b9PF4Ni7ETQcvWbAfpEfYbYG4P37hD1i6agKbOSL+1odZXI5In4ga0NqWX1B
	 ExVwnhwTYCerfMNRpRO1CY0UqVn/c+7ocJ/cm7sffQvCDwJON7vSxl/ojUXM0J6cF6
	 7JeQLGMxBgRgkURQ3uYpKMJmSKmq5RUemPm7GH5W1lyEcgC8NoxZNz2dA7ppzPtZwQ
	 x4/ZWaIYshCIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD651CE0CF0; Tue, 22 Jul 2025 15:16:31 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:16:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 5/4] srcu: Document __srcu_read_{,un}lock_fast() implicit
 RCU readers
Message-ID: <ce304859-e258-45e7-b40f-b5cacc968eaf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>

This commit documents the implicit RCU readers that are implied by the
this_cpu_inc() and atomic_long_inc() operations in __srcu_read_lock_fast()
and __srcu_read_unlock_fast().  While in the area, fix the documentation
of the memory pairing of atomic_long_inc() in __srcu_read_lock_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 043b5a67ef71e..78e1a7b845ba9 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -245,9 +245,9 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_locks.counter); /* Y */
+		this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
 	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
 	barrier(); /* Avoid leaking the critical section. */
 	return scp;
 }
@@ -271,9 +271,9 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 {
 	barrier();  /* Avoid leaking the critical section. */
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
 	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);

