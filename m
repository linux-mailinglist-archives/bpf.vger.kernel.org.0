Return-Path: <bpf+bounces-76676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54DCC0B21
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 04:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64D5301D5A8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73B2ED161;
	Tue, 16 Dec 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QzTdP/dI"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2A1F92E;
	Tue, 16 Dec 2025 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854861; cv=none; b=OJ6dCK1CJZ6RaRUo7SfxkTuRDCniJ6LxuQzgLuez6ko5vwF9qYNM9DdERv75iDKQZ72IfmfoFonoeH1tAQccFEf2+QKem6qWSbVow+CDIWcGSniDU3P0dDURx42OXBDgO3JUP85c581KymFnlruDQYW6HH6pE2+vfTdwpKCmhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854861; c=relaxed/simple;
	bh=puOVVC4YLN0nBKtz3o3a/cuXlWyJvQes7C0VLh1ReME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhOLFzXYrXEXw63/1PJzooygAV+7JkbhWNK0F2QxU6sBPb3ma6dhDlwv4bd6KwO4hXDGkLsd4/xdb+JOi8Z5rtRRLFzTzwoNVDLJjH3zs1GoyJxA3Ve7PSIe4oWKkBHydo6NF1daHG+b7cM90pZVflooETxyXLRnKY2B69mT59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QzTdP/dI; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xy
	2ZWl7O84CNJ1+Mxls8EdlSwbzidzX95E9A+UqPdBg=; b=QzTdP/dIi1/KuUTQCg
	bwvOeQjq0aucVS55GGB+uLOjw2jK8cA/7b0ghD0Rg3OBqnRIGlJSpQly5OnEe1BG
	WA0FCw4thU+kcFxnWAJP4CPb6L/iPxUjkWZZ59xmqBMMwF+byE0aDJSTcLzjcL1v
	Zh1RgYtb9uzxOFNupMaw5HykU=
Received: from MacPro.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX7_GczUBpgKueAQ--.44865S2;
	Tue, 16 Dec 2025 11:10:21 +0800 (CST)
From: donglaipang@126.com
To: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	DLpang <donglaipang@126.com>
Subject: [PATCH] bpf: Fix NULL deref in __list_del_clearprev for flush_node
Date: Tue, 16 Dec 2025 11:10:18 +0800
Message-ID: <20251216031018.1615363-1-donglaipang@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69369331.a70a0220.38f243.009d.GAE@google.com>
References: <69369331.a70a0220.38f243.009d.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX7_GczUBpgKueAQ--.44865S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy8ArykCF17ZF4kurWfZrb_yoW5Wryxp3
	45K345JrWktr1vk3y8tr1xC34Sq3W8Way2kay5Ca4ay3WDXr9FgrZagr18XF15tr4rGrWF
	yr1jgFsYq3y8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcXocUUUUU=
X-CM-SenderInfo: pgrqwzpdlst0bj6rjloofrz/xtbBnx4FXWlAzZ5fQQAA39

From: DLpang <donglaipang@126.com>

#syz test

Hi,

This patch fixes a NULL pointer dereference in the BPF subsystem that occurs
when __list_del_clearprev() is called on an already-cleared flush_node list_head.

The fix includes two parts:
1. Properly initialize the flush_node list_head during per-CPU bulk queue allocation
   using INIT_LIST_HEAD(&bq->flush_node)
2. Add defensive checks before calling __list_del_clearprev() to ensure the node
   is actually in the list by checking if (bq->flush_node.prev)

According to the __list_del_clearprev documentation in include/linux/list.h,
'The code that uses this needs to check the node 'prev' pointer instead of calling list_empty()'.

This patch fixes the following syzbot-reported issue:
https://syzkaller.appspot.com/bug?extid=2b3391f44313b3983e91

Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2b3391f44313b3983e91
Signed-off-by: DLpang <donglaipang@126.com>
---
 kernel/bpf/cpumap.c | 4 +++-
 kernel/bpf/devmap.c | 3 ++-
 net/xdp/xsk.c       | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..248336df591a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -450,6 +450,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 
 	for_each_possible_cpu(i) {
 		bq = per_cpu_ptr(rcpu->bulkq, i);
+		INIT_LIST_HEAD(&bq->flush_node);
 		bq->obj = rcpu;
 	}
 
@@ -737,7 +738,8 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 	bq->count = 0;
 	spin_unlock(&q->producer_lock);
 
-	__list_del_clearprev(&bq->flush_node);
+	if (bq->flush_node.prev)
+		__list_del_clearprev(&bq->flush_node);
 
 	/* Feedback loop via tracepoints */
 	trace_xdp_cpumap_enqueue(rcpu->map_id, processed, drops, to_cpu);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..7a7347e709cc 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -428,7 +428,8 @@ void __dev_flush(struct list_head *flush_list)
 		bq_xmit_all(bq, XDP_XMIT_FLUSH);
 		bq->dev_rx = NULL;
 		bq->xdp_prog = NULL;
-		__list_del_clearprev(&bq->flush_node);
+		if (bq->flush_node.prev)
+			__list_del_clearprev(&bq->flush_node);
 	}
 }
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..052b8583542d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -406,7 +406,8 @@ void __xsk_map_flush(struct list_head *flush_list)
 
 	list_for_each_entry_safe(xs, tmp, flush_list, flush_node) {
 		xsk_flush(xs);
-		__list_del_clearprev(&xs->flush_node);
+		if (xs->flush_node.prev)
+			__list_del_clearprev(&xs->flush_node);
 	}
 }
 
-- 
2.43.0


