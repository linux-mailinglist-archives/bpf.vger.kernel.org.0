Return-Path: <bpf+bounces-48361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E280CA06DF9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 07:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FBF1672FF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8B214814;
	Thu,  9 Jan 2025 06:07:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAB2147F8;
	Thu,  9 Jan 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736402825; cv=none; b=Ihb92m9jr3nc2buN6Fbgk8vyn20YpKb3tpzG7jweg5DOBM0esCjqZu2EfVzYF5qPfuJEiadvj/ynlyOKUPyXK5D7YZhzfcgtLPwtdtW8apiRt5Pg3fveKfzmhPMvH3neliKDpDNMcsKoh9Yl8vxXV6drqvhAGG4DGtzr8CJh6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736402825; c=relaxed/simple;
	bh=M20n8oEPRFgP6hJG00kr3BZfyGsN6BOq4MAUzZqbdhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgOOf1XrKoSBGrZkIWX7dzHwGy99gnFlK4lg2QtWtOhlxEk8ZnzGC45z/vfov67Jw1LrsvI/w/WIStGvUq23RYu6PlBFp4wEha6a1ncFIC7Bs5FgtFBmh0hYu+LI7ShctxIXHjT2C9VaspdeHtFyHvr4Ubg3x1+cIIk9WlUAdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YTDnW5lf8z4f3jqr;
	Thu,  9 Jan 2025 14:06:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CEB381A06DC;
	Thu,  9 Jan 2025 14:06:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAni196Z39nvD3QAQ--.4010S5;
	Thu, 09 Jan 2025 14:06:54 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 1/5] bpf: Free special fields after unlock in htab_lru_map_delete_node()
Date: Thu,  9 Jan 2025 14:18:57 +0800
Message-Id: <20250109061901.2620825-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250109061901.2620825-1-houtao@huaweicloud.com>
References: <20250109061901.2620825-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni196Z39nvD3QAQ--.4010S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDGw4rKw48Gw1rtw1kKrg_yoW8GF4Upa
	n5Gay3Ga18ZF1qkayrtF4vgryrCw45Gw47KrW8GFyYy3W7Za4DW3W5GF93KFyaqrWkZrna
	qrZ0qr98tFyUurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When bpf_timer is used in LRU hash map, calling check_and_free_fields()
in htab_lru_map_delete_node() will invoke bpf_timer_cancel_and_free() to
free the bpf_timer. If the timer is running on other CPUs and PREEMPT_RT
is enabled, hrtimer_cancel will invoke hrtimer_cancel_wait_running() and
it will try to acquire a spin-lock, however, htab_lru_map_delete_node()
has already acquired a raw-spin-lock, it violates the lockdep rule and
may trigger the "BUG: scheduling while atomic" warning.

Fix the issue by moving the invocation of check_and_free_fields() out of
bucket lock.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 40095dda891d3..963cccb01daae 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -824,13 +824,14 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
-			check_and_free_fields(htab, l);
 			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
 
 	htab_unlock_bucket(htab, b, tgt_l->hash, flags);
 
+	if (l == tgt_l)
+		check_and_free_fields(htab, l);
 	return l == tgt_l;
 }
 
-- 
2.29.2


