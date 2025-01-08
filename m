Return-Path: <bpf+bounces-48186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF935A04E5A
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0BD166001
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33673136341;
	Wed,  8 Jan 2025 00:55:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236A70818;
	Wed,  8 Jan 2025 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297727; cv=none; b=PP4yl0fCTEB1/eeGmQiTV9Qse7YgvheI6sP2JjyszIpKBW6KDgEleW9KwvBQXp7AL6sWpNqhdyaoRspCxVTMq9r6ozl0a++ELiajwdGfBUcnqynR2tm4eEMA2XdEAtk8uCeMBRbMoogRxpp22Ot3QmgjXEPM2Wujp5+9w/cEJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297727; c=relaxed/simple;
	bh=kXxVK/q3MuKspswfzamV6qyTo4xorE5V0zGoJrIHy70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSOfNedDG3o49uRN0PjR91FW5umrnQpHyYoH0xYjd8kCG492mb5AJBQ1WSbWhnS1xs+WMJr0O1HmG6UC6XFvADo/EU8RPH3zH8ctE+DLV3/pq9mkN+1yF6bJ49GGzI43Del0ocdfbwuXiHBEwsc0FzuKqybhAj4orGhamncZvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSTwV74q7z4f3jqr;
	Wed,  8 Jan 2025 08:55:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 00EAD1A0B23;
	Wed,  8 Jan 2025 08:55:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S6;
	Wed, 08 Jan 2025 08:55:21 +0800 (CST)
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 02/16] bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
Date: Wed,  8 Jan 2025 09:07:14 +0800
Message-Id: <20250108010728.207536-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250108010728.207536-1-houtao@huaweicloud.com>
References: <20250108010728.207536-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1UurWktF4xCr17Aw43ZFb_yoW5JFWrpF
	409Fyxtr48X3ZrX3y3J34q9ry5Aw1YgayxG3s5ta4Fyr45GrnIqry8AayFqFyYvw4jyr1S
	va4jvw12ya4kWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

BPF program may call bpf_for_each_map_elem(), and it will call
the ->map_for_each_callback callback of related bpf map. Considering the
running context of bpf program has already disabled migration, remove
the unnecessary migrate_{disable|enable} pair in the implementations of
->map_for_each_callback. To ensure the guarantee will not be voilated
later, also add cant_migrate() check in the implementations.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/arraymap.c |  6 ++----
 kernel/bpf/hashtab.c  | 11 +++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 6cdbb4c33d31d..eb28c0f219ee4 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -735,13 +735,13 @@ static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback
 	u64 ret = 0;
 	void *val;
 
+	cant_migrate();
+
 	if (flags != 0)
 		return -EINVAL;
 
 	is_percpu = map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
 	array = container_of(map, struct bpf_array, map);
-	if (is_percpu)
-		migrate_disable();
 	for (i = 0; i < map->max_entries; i++) {
 		if (is_percpu)
 			val = this_cpu_ptr(array->pptrs[i]);
@@ -756,8 +756,6 @@ static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback
 			break;
 	}
 
-	if (is_percpu)
-		migrate_enable();
 	return num_elems;
 }
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8e2775848e0dc..3c1122281d986 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2230,17 +2230,18 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 	bool is_percpu;
 	u64 ret = 0;
 
+	cant_migrate();
+
 	if (flags != 0)
 		return -EINVAL;
 
 	is_percpu = htab_is_percpu(htab);
 
 	roundup_key_size = round_up(map->key_size, 8);
-	/* disable migration so percpu value prepared here will be the
-	 * same as the one seen by the bpf program with bpf_map_lookup_elem().
+	/* migration has been disabled, so percpu value prepared here will be
+	 * the same as the one seen by the bpf program with
+	 * bpf_map_lookup_elem().
 	 */
-	if (is_percpu)
-		migrate_disable();
 	for (i = 0; i < htab->n_buckets; i++) {
 		b = &htab->buckets[i];
 		rcu_read_lock();
@@ -2266,8 +2267,6 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		rcu_read_unlock();
 	}
 out:
-	if (is_percpu)
-		migrate_enable();
 	return num_elems;
 }
 
-- 
2.29.2


