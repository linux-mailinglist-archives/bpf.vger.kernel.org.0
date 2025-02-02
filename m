Return-Path: <bpf+bounces-50287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C482A24CE7
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797D0164B4D
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A521D5154;
	Sun,  2 Feb 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="A113EQaC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AE1D61A7
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482626; cv=none; b=K3iLhLBkvFXDMGNwcxbzvjhY9hPhRjZVHscIMdx/1hCTFxB/SBKSrQyV7LQbtAwis0YDvzhEmY/YF2ELFJESunycsDHgQwLHS/WAhVx+thwAR8kmjiuzcX8BVMxhO3WwjTfay9YtgFjJipSoZg1DZEZ5ltPjsngNmq27l34/Ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482626; c=relaxed/simple;
	bh=E5jezsg5GyYCK2gkhVXTYcW5B4KXEOfaOklGO1rmKBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyhDYQY5PlJ8Qr6iHZNAHHOl12OUKwaoGzjyo4y2UTLR3Si8/ZzP5gSmX0pWU2lPG03fBX3HwRwZuoblVugBQjnID+XBbjOmi9zXXUM9/0vd0uFv7Thi5OnklpABt4S+gkdLGSP7+YF5m6oPX1/b/27V+DbuIe8uzArYBs5pgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=A113EQaC; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 890321C242F
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:22 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482621; x=1739346622; bh=E5jezsg5GyYCK2gkhVXTYcW5B4K
	XEOfaOklGO1rmKBA=; b=A113EQaCg4b5L0DPAWsfALfNljmnwdFwU1D85rNpe+R
	xlK1g1WKONplF/ifk9SwU/tHvDQ1kmPfUJDj8YCSDH+RZYxyge5izyCP43xbejPU
	jtO/y7TZxyCecKFlez0OKjVq9xTjQkPoeodKG4XmtK2So3NsHti9rqlDExJ9o/zU
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uVH2zmc63KxI for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:21 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 511561C243B;
	Sun,  2 Feb 2025 10:50:16 +0300 (MSK)
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
Subject: [PATCH 6.1 05/16] bpf: Refactor alloc_bulk().
Date: Sun,  2 Feb 2025 07:46:42 +0000
Message-ID: <20250202074709.932174-6-sdl@nppct.ru>
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

commit 05ae68656a8e9d9386ce4243fe992122fd29bb51 upstream.

Factor out inner body of alloc_bulk into separate helper.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-5-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 46 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0cd863839557..0f45ea4259cb 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,11 +154,35 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		/* In RT irq_work runs in per-cpu kthread, so disable
+		 * interrupts to avoid preemption and interrupts and
+		 * reduce the chance of bpf prog executing on this cpu
+		 * when active counter is busy.
+		 */
+		local_irq_save(flags);
+	/* alloc_bulk runs from irq_work which will not preempt a bpf
+	 * program that does unit_alloc/unit_free since IRQs are
+	 * disabled there. There is no race to increment 'active'
+	 * counter. It protects free_llist from corruption in case NMI
+	 * bpf prog preempted this loop.
+	 */
+	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	local_dec(&c->active);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
-	unsigned long flags;
 	void *obj;
 	int i;
 
@@ -188,25 +212,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 			if (!obj)
 				break;
 		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			/* In RT irq_work runs in per-cpu kthread, so disable
-			 * interrupts to avoid preemption and interrupts and
-			 * reduce the chance of bpf prog executing on this cpu
-			 * when active counter is busy.
-			 */
-			local_irq_save(flags);
-		/* alloc_bulk runs from irq_work which will not preempt a bpf
-		 * program that does unit_alloc/unit_free since IRQs are
-		 * disabled there. There is no race to increment 'active'
-		 * counter. It protects free_llist from corruption in case NMI
-		 * bpf prog preempted this loop.
-		 */
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-		__llist_add(obj, &c->free_llist);
-		c->free_cnt++;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
-- 
2.43.0


