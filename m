Return-Path: <bpf+bounces-47926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45BA02050
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16C5163B59
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1611DA622;
	Mon,  6 Jan 2025 08:07:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4751D9337;
	Mon,  6 Jan 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150827; cv=none; b=hqNFx2uKTJ0LaAz0F8GI5VbZ/BL/ftzK/kJp16hCq9Xa/DlSNeMpAIECzh88/5Vj1ckkFaNkxMF+/UFx1OBmHUzP3puLp61bozXBhKd8CzKhr12zoD2OHlXR1sMeU916tJCi8an0r0zFvStatfKqBRVSZuAZiK1TMvk4sj56igA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150827; c=relaxed/simple;
	bh=Kpkyp3Ozm5zn9XwP8P+KJVOEIumTc00mLK6DZAiXIt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CV4gYlK9Z5Bb1+6kUsn7cfTe6+wanLqHGyUN40i1OLUc2UqXhfZNrEZCc5P7xXsEehPZpiGHV06KPLUI6rfi+6FnI6fs50hg5V7ZQteA6f7jOdDhlTKLpa/vc76ypGRa5xO1w5ZzYjc+t8VKJOL/Cr1/kQdxfXOx7MQapjnR83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbV1RM4z4f3jqj;
	Mon,  6 Jan 2025 16:06:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 254CE1A0A02;
	Mon,  6 Jan 2025 16:07:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S15;
	Mon, 06 Jan 2025 16:07:00 +0800 (CST)
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
Subject: [PATCH bpf-next 11/19] bpf: Disable migration in htab_map_free()
Date: Mon,  6 Jan 2025 16:18:52 +0800
Message-Id: <20250106081900.1665573-12-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4fAw1UWryUKF1UXw4rGrg_yoW5JF47pF
	Z3G347Kr48XFn29wsxXw4Ikry3Crs3Ka47G3yjg34F9ws8ur97Gw1xAFyFvFyrAr1ktF4S
	qr90vw1ayw18ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When freeing the hash map, the destroy procedure may invoke
bpf_obj_free_fields() to free the special fields in pre-allocated values
or dynamically-allocated values. Since these special fields may be
allocated from bpf memory allocator, migrate_{disable|enable} pairs are
necessary for the freeing of these objects.

To simplify reasoning about when migrate_disable() is needed for the
freeing of these dynamically-allocated objects, let the caller to
guarantee migration is disabled before invoking bpf_obj_free_fields().

For dynamically allocated values, delete_all_elements() already disables
migration before invoking bpf_obj_free_fields(). Therefore, the patch
moves migrate_{disable|enable} pair from delete_all_elements() to
htab_map_free() to handle all bpf_obj_free_fields() invocations. The
migrate_{disable|enable} pairs in the underlying implementation of
bpf_obj_free_fields() will be removed by the following patch.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 1db71d25836e..8bf1ad326e02 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1502,10 +1502,9 @@ static void delete_all_elements(struct bpf_htab *htab)
 {
 	int i;
 
-	/* It's called from a worker thread, so disable migration here,
-	 * since bpf_mem_cache_free() relies on that.
+	/* It's called from a worker thread and migration has been disabled,
+	 * therefore, it is OK to invoke bpf_mem_cache_free() directly.
 	 */
-	migrate_disable();
 	for (i = 0; i < htab->n_buckets; i++) {
 		struct hlist_nulls_head *head = select_bucket(htab, i);
 		struct hlist_nulls_node *n;
@@ -1517,7 +1516,6 @@ static void delete_all_elements(struct bpf_htab *htab)
 		}
 		cond_resched();
 	}
-	migrate_enable();
 }
 
 static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
@@ -1572,12 +1570,14 @@ static void htab_map_free(struct bpf_map *map)
 	 * underneath and is responsible for waiting for callbacks to finish
 	 * during bpf_mem_alloc_destroy().
 	 */
+	migrate_disable();
 	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
 	} else {
 		htab_free_prealloced_fields(htab);
 		prealloc_destroy(htab);
 	}
+	migrate_enable();
 
 	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
-- 
2.29.2


