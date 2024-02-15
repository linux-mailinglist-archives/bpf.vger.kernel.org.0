Return-Path: <bpf+bounces-22106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61441856F1D
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935B61C222C8
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAA213B791;
	Thu, 15 Feb 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbOCsCZt"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CA135A66
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031560; cv=none; b=qoeucrAAvO+7xniA6nBvyJimGdw5AD28v24v6XFk/MMYRWAZdX02EcMH2ZMxb1fic3+af0+bB2ebBG5lL2c2dUeWaul94S9PZ5wIsi4ZKL4C85MQ+z/0HgOfUSpHX/+1MYTdT8o98LGjfjvk/Z+gjJwneUGbmQdExnzV0Z0MrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031560; c=relaxed/simple;
	bh=WnQlAUoPaOq0riWFICNCJZ2GacqZG+XDDVp2SNa9Nnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDT4fIUFw1vyCEf5pC3Rg8dint/Ra1f4wzrqay25vH6M2pMkQeqPQMBeaNzB/NK5pHSqlAr7CXJxgtgMgoScx02/HYk4AbQCA6X2oxOIJvVM63hqPPB12+vNmI+jqk+hpMSV1SGbERxgvhzx3f1YabpZQ06hxdunYIaEzVd318Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JbOCsCZt; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708031556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4xQU1NAHNvLSXv9fJK/aKOfTnBei6Bpc3D8TitP0rFY=;
	b=JbOCsCZtlBSRHcOC2Wb0Lcfm7Kv+5sNIuLAXfgpacPs1EHE0Mri1ddY4rdFXHvzTasip4S
	gFV0jT5C1Q0Mv85dOS5nPvU3JR77ufpI48ep5dcLn+N2HwIhz2VLeQTKxefrRllaEeZon/
	Xl2d0omG2y2AP2yoR0NGujSmmQoOfy8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH bpf 1/2] bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel
Date: Thu, 15 Feb 2024 13:12:17 -0800
Message-Id: <20240215211218.990808-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The following race is possible between bpf_timer_cancel_and_free
and bpf_timer_cancel. It will lead a UAF on the timer->timer.

bpf_timer_cancel();
	spin_lock();
	t = timer->time;
	spin_unlock();

					bpf_timer_cancel_and_free();
						spin_lock();
						t = timer->timer;
						timer->timer = NULL;
						spin_unlock();
						hrtimer_cancel(&t->timer);
						kfree(t);

	/* UAF on t */
	hrtimer_cancel(&t->timer);

In bpf_timer_cancel_and_free, this patch frees the timer->timer
after a rcu grace period. This requires a rcu_head addition
to the "struct bpf_hrtimer". Another kfree(t) happens in bpf_timer_init,
this does not need a kfree_rcu because it is still under the
spin_lock and timer->timer has not been visible by others yet.

In bpf_timer_cancel, rcu_read_lock() is added because this helper
can be used in a non rcu critical section context (e.g. from
a sleepable bpf prog). Other timer->timer usages in helpers.c
have been audited, bpf_timer_cancel() is the only place where
timer->timer is used outside of the spin_lock.

Another solution considered is to mark a t->flag in bpf_timer_cancel
and clear it after hrtimer_cancel() is done.  In bpf_timer_cancel_and_free,
it busy waits for the flag to be cleared before kfree(t). This patch
goes with a straight forward solution and frees timer->timer after
a rcu grace period.

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be72824f32b2..d19cd863d294 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1101,6 +1101,7 @@ struct bpf_hrtimer {
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
+	struct rcu_head rcu;
 };
 
 /* the actual struct hidden inside uapi struct bpf_timer */
@@ -1332,6 +1333,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
+	rcu_read_lock();
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
 	if (!t) {
@@ -1353,6 +1355,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -1407,7 +1410,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 */
 	if (this_cpu_read(hrtimer_running) != t)
 		hrtimer_cancel(&t->timer);
-	kfree(t);
+	kfree_rcu(t, rcu);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
-- 
2.34.1


