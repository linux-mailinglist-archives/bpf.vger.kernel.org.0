Return-Path: <bpf+bounces-55037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40AA7744F
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E1718898B6
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3B1E2823;
	Tue,  1 Apr 2025 06:11:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAD1372
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487860; cv=none; b=Tt+cQxyzosGMXMKGNN7Q5Ucf2z/3EYqK5hmy0EmoMVoQZmb3VAHH9SBNg0pFmkFwtxcGuKtTChkL/KhfxXHOrrkGQdBuDmCsCGQdxDz6v68aUiagqZ2SbtzfEhX7+sZHZgQf7+rquRBa6i/1ZivISQXh4B4eyPEMdWlv8naljXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487860; c=relaxed/simple;
	bh=qB+jqCRnvk42qN14gOkTjAPQ7Qt1Dg8uyi4MMC04b3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTgPkj6AeocV1GuHQPu5zl/qFA1y1zmfTdZG6XGqQGFAXBzQEHjbkhAuvB9QSx0chXUTL4pc5hDlOSyuJyCbexsAhEb3NDn8xnYuGe8k76ZR/984a6xQEZwqSqSNJovToGDNQaGlNHBGsXdxS2VnyVMULKCJFa98z/oD9a8TpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZRd012xc7z4f3m7d
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1590B1A0EC2
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9ig+tnpa6yIA--.16784S9;
	Tue, 01 Apr 2025 14:10:49 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 5/6] bpf: Don't allocate per-cpu extra_elems for fd htab
Date: Tue,  1 Apr 2025 14:22:49 +0800
Message-Id: <20250401062250.543403-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250401062250.543403-1-houtao@huaweicloud.com>
References: <20250401062250.543403-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9ig+tnpa6yIA--.16784S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18tr4fGFyDGF1kAF45trb_yoW8ZFyDpF
	4xGr129r1rXr1vgws8JanFkryYvr1xtFyUCrZ0q34FyF1jvrn7Kr17Aa1IvFyYkryxtw1f
	Xryava4Fv3y8ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The update of element in fd htab is in-place now, therefore, there is no
need to allocate per-cpu extra_elems, just remove it.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 097992efef05..2e18d7e50d9b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -206,9 +206,13 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+/* Both percpu and fd htab support in-place update, so no need for
+ * extra elem. LRU itself can remove the least used element, so
+ * there is no need for an extra elem during map_update.
+ */
 static bool htab_has_extra_elems(struct bpf_htab *htab)
 {
-	return !htab_is_percpu(htab) && !htab_is_lru(htab);
+	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
 static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
@@ -464,8 +468,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		       attr->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
-	bool lru = (attr->map_type == BPF_MAP_TYPE_LRU_HASH ||
-		    attr->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
 	/* percpu_lru means each cpu has its own LRU list.
 	 * it is different from BPF_MAP_TYPE_PERCPU_HASH where
 	 * the map's value itself is percpu.  percpu_lru has
@@ -560,10 +562,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		if (err)
 			goto free_map_locked;
 
-		if (!percpu && !lru) {
-			/* lru itself can remove the least used element, so
-			 * there is no need for an extra elem during map_update.
-			 */
+		if (htab_has_extra_elems(htab)) {
 			err = alloc_extra_elems(htab);
 			if (err)
 				goto free_prealloc;
-- 
2.29.2


