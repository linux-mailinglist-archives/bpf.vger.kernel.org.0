Return-Path: <bpf+bounces-50288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D1A24CED
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493897A2F6C
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936B1D6DA1;
	Sun,  2 Feb 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="VJpZTJeA"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069621D63DE
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482627; cv=none; b=GD1enSE+PSDjzYZ5d0pbEpSkXkaTlkT20kUORzxgRzYF1fmHoiex2eAR+69leA8mdM32U1EuwlVGgReqSdSRHmX5h13/ocLfFBJu942IA8FL7S98vs8cGthwvkDLjl0rP/S0QqBzn6/gyvvaX+hUdRnVrPLsVuczrtazX4216Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482627; c=relaxed/simple;
	bh=ct4FVMAhR3QrzY31JTgnzGPReYFrJVc3mEqKmQgn9CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6DBt9vGpyiOlwmVCFJYdDQkDgPVFPF4c2IGKz/ZA6Ru4aYgHROW/9CZUBkg5iz+LAaP+ZiXFE7huQ/vxelkfyVd+UlIfbRyGBx6GbWzolXFpkQ6AaPspy9FFRZWg7y845DypGP6Bjlvc6Z/MNjMQsFe1YWSD4BA1EAylLNQRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=VJpZTJeA; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 7208F1C2449
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:24 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482624; x=1739346625; bh=ct4FVMAhR3QrzY31JTgnzGPReYF
	rJVc3mEqKmQgn9CA=; b=VJpZTJeA9ThpTI0zjaBNTtZI0clNKmNFG7czTLllQw7
	aDMkdEu5O3vgNVJsnwVKhd4GB/4tAPNRgpXRubftDbGVrH/RgYDDa5zahCmORrB6
	D3EBCnYBAmh43bRJrelT5is/3ByoIjl6xRoKK8Z/FGdG3mwJ0AM7/cSxxi33RKA0
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sQDtRQwZT1e4 for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:24 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 6FD1E1C2429;
	Sun,  2 Feb 2025 10:50:17 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 06/16] bpf: Factor out inc/dec of active flag into helpers.
Date: Sun,  2 Feb 2025 07:46:43 +0000
Message-ID: <20250202074709.932174-7-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

commit 18e027b1c7c6dd858b36305468251a5e4a6bcdf7 upstream.

Factor out local_inc/dec_return(&c->active) into helpers.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-6-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0f45ea4259cb..5c4e54e17f95 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,17 +154,15 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
-static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
-	unsigned long flags;
-
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		/* In RT irq_work runs in per-cpu kthread, so disable
 		 * interrupts to avoid preemption and interrupts and
 		 * reduce the chance of bpf prog executing on this cpu
 		 * when active counter is busy.
 		 */
-		local_irq_save(flags);
+		local_irq_save(*flags);
 	/* alloc_bulk runs from irq_work which will not preempt a bpf
 	 * program that does unit_alloc/unit_free since IRQs are
 	 * disabled there. There is no race to increment 'active'
@@ -172,13 +170,25 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 	 * bpf prog preempted this loop.
 	 */
 	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-	__llist_add(obj, &c->free_llist);
-	c->free_cnt++;
+}
+
+static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+{
 	local_dec(&c->active);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(flags);
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	inc_active(c, &flags);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	dec_active(c, flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -295,17 +305,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 	int cnt;
 
 	do {
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_save(flags);
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
 		if (llnode)
 			cnt = --c->free_cnt;
 		else
 			cnt = 0;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		dec_active(c, flags);
 		if (llnode)
 			enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
-- 
2.43.0


