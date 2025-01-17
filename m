Return-Path: <bpf+bounces-49170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3DA14D35
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AD83A8CCD
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68791FE466;
	Fri, 17 Jan 2025 10:06:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3A1FC118
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108376; cv=none; b=ecy5b4tUhLiI58yEHygvFLOPLcVD/cj9ftFb0fT+H0YgiAroDZ0c59X8saDnJsP4GQyNFOpR1HqJq8zhB7NAqnMTkgZ6RI/maTwExrOBFdPOqP3Kb0flH1lPQPiKVPQD6SoJjTKg4xZjDnO6QvFb50kV+cNmZxLdOhg660wEYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108376; c=relaxed/simple;
	bh=6o10SZRDc5p07gjMhZv7/S2ZOo9knqa4RQ2yI/MOSN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmhnFuIZkMgWaEVmTIWWMfs1zzRC3/gusRRpr70274LjdnTja0XKQTYDCr9ugTbK2kqwL7TT5mIccJ4FNSpszxZAs8Ovw8+lVGbMNBpZx7SN4uRNZwnHBE+l5m0eCtrLmFkPESAMgZoq8F+b2rmQTS2ld15abTvb2b4U+3KRJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZFjm73KDz4f3lVX
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:05:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ACD191A1A2A
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 18:06:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGCNK4pnQRDPBA--.48008S5;
	Fri, 17 Jan 2025 18:06:10 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
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
Subject: [PATCH bpf-next v3 1/5] bpf: Free special fields after unlock in htab_lru_map_delete_node()
Date: Fri, 17 Jan 2025 18:18:12 +0800
Message-Id: <20250117101816.2101857-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250117101816.2101857-1-houtao@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGCNK4pnQRDPBA--.48008S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UXw17Jr45WF4fJr4xJFb_yoW8XrWkpa
	n3Gay3Gw18Zr1q9a95tF4vgry5Cw4fGw47Kry8GFyFy3W3XasFgw4aqryftFyaqrWkArna
	vrZYqry5tryUCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When bpf_timer is used in LRU hash map, calling check_and_free_fields()
in htab_lru_map_delete_node() will invoke bpf_timer_cancel_and_free() to
free the bpf_timer. If the timer is running on other CPUs,
hrtimer_cancel() will invoke hrtimer_cancel_wait_running() to spin on
current CPU to wait for the completion of the hrtimer callback.

Considering that the deletion has already acquired a raw-spin-lock
(bucket lock). To reduce the time holding the bucket lock, move the
invocation of check_and_free_fields() out of bucket lock. However,
because htab_lru_map_delete_node() is invoked with LRU raw spin lock
being held, the freeing of special fields still happens in a locked
scope.

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


