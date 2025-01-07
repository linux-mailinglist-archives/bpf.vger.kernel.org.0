Return-Path: <bpf+bounces-48055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A0A039F9
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D91B3A5487
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109301E1027;
	Tue,  7 Jan 2025 08:44:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83211E0B91;
	Tue,  7 Jan 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239441; cv=none; b=jIB9eWB/QaJmk2BIpf8r/Tj1x2rCQaV85+z+nM0xhIz2dJQZgnHsZAVEnRI7m/zSw5hxjHkIlgwodhe1NbD6ogyVp+wHObBqvvVxlv9xRLmYn2LMEw+ph0kWk3TLaBXMnSJvK3xyBGIwO+AsAVDferg0nVM0X/5G/zSCkAZFTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239441; c=relaxed/simple;
	bh=YIRIy6EIg2ShCQZ2Aqk/7mvJenquahz9NqZBD/YsqfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjDvnJVQSEprg/hzRXq9CDDWmAxGMU2ePpZtjz66Am7uDh1TK290KWRfpv2k39SZYSIhQFQyw1++cyRqIxq9WKZG8iXRJDF8W3bk2kbOy29QGxYS7nxFczd+oXNlVMzGsM8nez9KOvGepN7zTwOBGspWqwyyOJMhjmqo2j9Hktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YS4MV1Jc1z4f3jXw;
	Tue,  7 Jan 2025 16:43:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5000E1A0E33;
	Tue,  7 Jan 2025 16:43:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S6;
	Tue, 07 Jan 2025 16:43:54 +0800 (CST)
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
Subject: [PATCH bpf-next 2/7] bpf: Bail out early in __htab_map_lookup_and_delete_elem()
Date: Tue,  7 Jan 2025 16:55:54 +0800
Message-Id: <20250107085559.3081563-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5tw1rXry8tw1fGw1xKrg_yoW5JFyrpF
	Z3Kry7Wry8ursIqa4ftw1jka95J340qw48Ka4DJFyrCF13Zryvqw13AF93GFy3Gr92yr4r
	trs2qF1fK3y2vrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I3
	85UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Use goto statement to bail out early when the target element is not
found, instead of using a large else branch to handle the more likely
case. This change doesn't affect functionality and simply make the code
cleaner.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8fecf21c132a..59eb117908c5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1641,37 +1641,38 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	l = lookup_elem_raw(head, hash, key, key_size);
 	if (!l) {
 		ret = -ENOENT;
-	} else {
-		if (is_percpu) {
-			u32 roundup_value_size = round_up(map->value_size, 8);
-			void __percpu *pptr;
-			int off = 0, cpu;
+		goto out_unlock;
+	}
 
-			pptr = htab_elem_get_ptr(l, key_size);
-			for_each_possible_cpu(cpu) {
-				copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
-				check_and_init_map_value(&htab->map, value + off);
-				off += roundup_value_size;
-			}
-		} else {
-			u32 roundup_key_size = round_up(map->key_size, 8);
+	if (is_percpu) {
+		u32 roundup_value_size = round_up(map->value_size, 8);
+		void __percpu *pptr;
+		int off = 0, cpu;
 
-			if (flags & BPF_F_LOCK)
-				copy_map_value_locked(map, value, l->key +
-						      roundup_key_size,
-						      true);
-			else
-				copy_map_value(map, value, l->key +
-					       roundup_key_size);
-			/* Zeroing special fields in the temp buffer */
-			check_and_init_map_value(map, value);
+		pptr = htab_elem_get_ptr(l, key_size);
+		for_each_possible_cpu(cpu) {
+			copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
+			check_and_init_map_value(&htab->map, value + off);
+			off += roundup_value_size;
 		}
+	} else {
+		u32 roundup_key_size = round_up(map->key_size, 8);
 
-		hlist_nulls_del_rcu(&l->hash_node);
-		if (!is_lru_map)
-			free_htab_elem(htab, l);
+		if (flags & BPF_F_LOCK)
+			copy_map_value_locked(map, value, l->key +
+					      roundup_key_size,
+					      true);
+		else
+			copy_map_value(map, value, l->key +
+				       roundup_key_size);
+		/* Zeroing special fields in the temp buffer */
+		check_and_init_map_value(map, value);
 	}
+	hlist_nulls_del_rcu(&l->hash_node);
+	if (!is_lru_map)
+		free_htab_elem(htab, l);
 
+out_unlock:
 	htab_unlock_bucket(htab, b, hash, bflags);
 
 	if (is_lru_map && l)
-- 
2.29.2


