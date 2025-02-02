Return-Path: <bpf+bounces-50290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB8A24CF0
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CC41659F8
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3881D8A14;
	Sun,  2 Feb 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="NlnFUH7G"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB31D86ED
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482634; cv=none; b=sPvY/F0BYtvAg78XaXxBmz8DLdp8FnooSJx1VnwDP2g2EcofpztOjTuQdmvw411HjCkHYX39QIAX44xCbYoBeZ847BTpl3ZzUB0qccXddVdWSBUfIunN+fotx/oNo9ne55zydBERIap29LwwTmJojqkpqN+aX+sS8iUr/Q2sytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482634; c=relaxed/simple;
	bh=Ldo/Ykq4wKZ/UskHvq7gtWqHWtFrRYbBgy/43Zu43LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQLmeJgvliquMZCUtSGY71vMoseJP5bHXhDdfTNpRMpoB36SsXpNShi0KgEDw4U1Ge4AWmanzT2wUUTuXRjZoEuhtAu0u52naX1mzeoT16cAzTf9Gr/1x7aXbhWI2yMRs7ibUYl48llUYez6qCeYgaH1IDNpClp1QT4oSLwP62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=NlnFUH7G; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 50F291C243E
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:31 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482629; x=1739346630; bh=Ldo/Ykq4wKZ/UskHvq7gtWqHWtF
	rRYbBgy/43Zu43LU=; b=NlnFUH7GKZ3svAqGf1kAVc8Mvg7PeY70/qCvpXN+vAd
	8MRfsXiRvQjxiNbc0Gu0HENVSxnaSUI+uLEn4+vz0sX8b5ZbTe2OLnYjdk/ZCsBE
	d8eb2s+lurdSi+/27P42GKW+ZZCc/dCzCheyxx4PVM76E8r3TlwhNuvL3/Uv3Ygw
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lUA1t79cjoE9 for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:29 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 74D741C242C;
	Sun,  2 Feb 2025 10:50:19 +0300 (MSK)
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
Subject: [PATCH 6.1 08/16] bpf: Further refactor alloc_bulk().
Date: Sun,  2 Feb 2025 07:46:45 +0000
Message-ID: <20250202074709.932174-9-sdl@nppct.ru>
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

commit 7468048237b8a99c03e1325b11373f9b29ef4139 upstream.

In certain scenarios alloc_bulk() might be taking free objects mainly from
free_by_rcu_ttrace list. In such case get_memcg() and set_active_memcg() are
redundant, but they show up in perf profile. Split the loop and only set memcg
when allocating from slab. No performance difference in this patch alone, but
it helps in combination with further patches.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-7-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9a4fb4ea73ef..bbd3fa2bf119 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -196,8 +196,6 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
-	memcg = get_memcg(c);
-	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * free_by_rcu_ttrace is only manipulated by irq work refill_work().
@@ -212,16 +210,24 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		 * numa node and it is not a guarantee.
 		 */
 		obj = __llist_del_first(&c->free_by_rcu_ttrace);
-		if (!obj) {
-			/* Allocate, but don't deplete atomic reserves that typical
-			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-			 * will allocate from the current numa node which is what we
-			 * want here.
-			 */
-			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
-			if (!obj)
-				break;
-		}
+		if (!obj)
+			break;
+		add_obj_to_free_list(c, obj);
+	}
+	if (i >= cnt)
+		return;
+
+	memcg = get_memcg(c);
+	old_memcg = set_active_memcg(memcg);
+	for (; i < cnt; i++) {
+		/* Allocate, but don't deplete atomic reserves that typical
+		 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+		 * will allocate from the current numa node which is what we
+		 * want here.
+		 */
+		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+		if (!obj)
+			break;
 		add_obj_to_free_list(c, obj);
 	}
 	set_active_memcg(old_memcg);
-- 
2.43.0


