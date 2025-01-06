Return-Path: <bpf+bounces-47919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012FDA0203F
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DA9163A70
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9441D8DEA;
	Mon,  6 Jan 2025 08:07:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43F1D7E5C;
	Mon,  6 Jan 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150821; cv=none; b=FTlTEmjEMbTBLy3BOOog33HZiuvHan6q/cTvCO7K/6EK2vv5fuZ5Y/7aOcy26RGhrhYBRuIUtmNq/gOa/PVtaFZsErKUGb2QevIEJicL8bhdeMAsTqIzzI/72JuTUTUIlNtfhvVbUmnbfxYlB5QHWt7OqokbixdN+YHKn7/VEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150821; c=relaxed/simple;
	bh=HaDwQy1yQBv/qTlGAYxcsy5x1VSElke0GPZ96c3E/YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tx0h+5HC11sFd+R6f39Wzu//Z8ZNByuqzjaEoSmxZHjG5nhoW1YdI373C8X85D7E3qH3pgNIcNkSWIhX54124b0GsNzFelWG5InjwUg4RYLPdR26tPEIKm6mTZFiKEI2Q1wefwCjnGz3MW8ltzkMck9hnx00+HFbE0Rl2JleIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbH1jfcz4f3jMw;
	Mon,  6 Jan 2025 16:06:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 551181A08F4;
	Mon,  6 Jan 2025 16:06:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S6;
	Mon, 06 Jan 2025 16:06:55 +0800 (CST)
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
Subject: [PATCH bpf-next 02/19] bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
Date: Mon,  6 Jan 2025 16:18:43 +0800
Message-Id: <20250106081900.1665573-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1UurWktF4xCF4fCFyxAFb_yoW8KFWkpF
	WI9a4xtr48XFnrZ3y3J34v9ry5Aw1YgayxGas5ta4Fyry3GrnIq340yayFqFyYvw4Iyr1S
	9a42vw12yaykWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

BPF program may call bpf_for_each_map_elem(), and it will call
the ->map_for_each_callback callback of related bpf map. Considering the
running context of bpf program has already disabled migration, remove
the unnecessary migrate_{disable|enable} pair in the implementations of
->map_for_each_callback.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/arraymap.c |  6 ++----
 kernel/bpf/hashtab.c  | 11 +++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 6cdbb4c33d31..eb28c0f219ee 100644
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
index 3ec941a0ea41..42af7fac61b9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2208,17 +2208,18 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
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
@@ -2244,8 +2245,6 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 		rcu_read_unlock();
 	}
 out:
-	if (is_percpu)
-		migrate_enable();
 	return num_elems;
 }
 
-- 
2.29.2


