Return-Path: <bpf+bounces-48358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E3A06DF3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 07:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F9C164A51
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 06:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5132010EF;
	Thu,  9 Jan 2025 06:07:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6D43169;
	Thu,  9 Jan 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736402821; cv=none; b=oJyzgqNJY2AEwkUr7upzrnAkX1rkFzA0V3AvtYoYOsaA3wOuQL8gNHbYFThbYBnf1a2l+vSMBVWQdc+f9QvLlrO2VSe8BA46wPGDiu58pa6QEiSInTZFq2to21XAmVzWRAvxMXDdBqx/v1niitPFRY946tT6lVzrrcEf5csMGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736402821; c=relaxed/simple;
	bh=SKJQGbJxuETkb4XV2d3Je3W09hUwJSEILdjytyLB7qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdhY5nfDgUp8t/1lQShr3n2x6m73Bn89fyQNZLeI1Iznqc2FldLsArsQqPgSlxJmUgD1fxeUgHZO6Hih9SEQdodhEg7AnNV+AiMblypwyPNPbHGmdkgVijzLP2i4NEbpayLZbmfucNSonPfXaKV2T0o+khaxS7hxacw0zBpILGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YTDnR6q4Vz4f3jRG;
	Thu,  9 Jan 2025 14:06:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 26F1D1A0BFF;
	Thu,  9 Jan 2025 14:06:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAni196Z39nvD3QAQ--.4010S7;
	Thu, 09 Jan 2025 14:06:55 +0800 (CST)
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
Subject: [PATCH bpf-next v2 3/5] bpf: Free element after unlock in __htab_map_lookup_and_delete_elem()
Date: Thu,  9 Jan 2025 14:18:59 +0800
Message-Id: <20250109061901.2620825-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAni196Z39nvD3QAQ--.4010S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7JryfXrWDZw43tF4xJFb_yoW8Gry7pF
	Z5KrW2ga1kWrnYv343Ja1vkrWUGw1rXw1UGF1kG34rtFn8Wr97Gw12vF92qF13Xr1vyFZ5
	XFW2yw15t3y5CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04x
	RDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The freeing of special fields in map value may acquire a spin-lock
(e.g., the freeing of bpf_timer), however, the lookup_and_delete_elem
procedure has already held a raw-spin-lock, which violates the lockdep
rule.

The running context of __htab_map_lookup_and_delete_elem() has already
disabled the migration. Therefore, it is OK to invoke free_htab_elem()
after unlocking the bucket lock.

Fix the potential problem by freeing element after unlocking bucket lock
in __htab_map_lookup_and_delete_elem().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6545ef40e128a..4a9eeb7aef855 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1663,14 +1663,16 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		check_and_init_map_value(map, value);
 	}
 	hlist_nulls_del_rcu(&l->hash_node);
-	if (!is_lru_map)
-		free_htab_elem(htab, l);
 
 out_unlock:
 	htab_unlock_bucket(htab, b, hash, bflags);
 
-	if (is_lru_map && l)
-		htab_lru_push_free(htab, l);
+	if (l) {
+		if (is_lru_map)
+			htab_lru_push_free(htab, l);
+		else
+			free_htab_elem(htab, l);
+	}
 
 	return ret;
 }
-- 
2.29.2


