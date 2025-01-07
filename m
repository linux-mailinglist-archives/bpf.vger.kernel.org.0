Return-Path: <bpf+bounces-48056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4FAA039FB
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54883A557B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E31E1044;
	Tue,  7 Jan 2025 08:44:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55F1E0081;
	Tue,  7 Jan 2025 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239442; cv=none; b=tIbwe9GnWg4YAlCwNyXpYCPplpNMKi+AT3krRMlPvuhpJL6sM/5kdokDGOPVZocoXaeQWDuwdztBQsvX7Z/fG3DfmLmZUyUdb5MHGCVFpusVR88QyWalh/y7f+sPJGs/Y+NhgHP9qEjNmoMDFvjcVKNrK8u3laOv2bxLVKEMT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239442; c=relaxed/simple;
	bh=lhnhxSv5zKbJCqmAxSQ/AntzPxJ+BQvoBoUQQpKr44g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG82eQ0WTHR+ZOg1d2rlsCmVb9Jpi8mm/V3XINNlgC5TiIBqfvFFoBBlyqV425TaJY7qDM/9v6VWx63m3UQGykz6HQYbYvJUkuBzIQYagr/lTYTCO+BF1F64S11zX+lZV1gMxpqnwe5k3pEmGJq9gx+Ec0J2uR5HiBaLTQKdOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YS4MT3XNDz4f3jXK;
	Tue,  7 Jan 2025 16:43:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9CFD11A166C;
	Tue,  7 Jan 2025 16:43:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S5;
	Tue, 07 Jan 2025 16:43:53 +0800 (CST)
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
Subject: [PATCH bpf-next 1/7] bpf: Free special fields after unlock in htab_lru_map_delete_node()
Date: Tue,  7 Jan 2025 16:55:53 +0800
Message-Id: <20250107085559.3081563-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250107085559.3081563-1-houtao@huaweicloud.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDGw4rKw48Gw1rtw1kKrg_yoW8GF1Dpa
	n5Gay3Ga1kZF1qkayrtF4vgry5Cw45Gw47KFW8GFyYy3W7JFyDW3W5KF93KFyaqrWkZrsa
	qrWqq3s8ta4UurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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
index 007571ce4343..8fecf21c132a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -826,13 +826,14 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
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


