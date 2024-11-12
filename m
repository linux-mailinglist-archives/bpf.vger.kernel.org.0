Return-Path: <bpf+bounces-44627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECF9C5AD1
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583FC286133
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F61FF047;
	Tue, 12 Nov 2024 14:48:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439E157A6B;
	Tue, 12 Nov 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422898; cv=none; b=Ymw0Ozc6e5Kby1ZbmEIIdEhm1lIde78m9Eyzks1PiYPE/E2ApDB9zqUAhoUQ2/X20xMp14yoABPtGiS8DO6lOA+yUZAqyd7JCvkFqzVoeNBBCwjHTvxECH5EF0txRNVquqNZrghskmYmVbO1NrSTfTqr3O6azy0pC6IRaZO5PNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422898; c=relaxed/simple;
	bh=nfPnBy9kduPMic7hSqNyV7DrJk+di1xfxClKNK1OA6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKu+wisicCGUK3jn8VOFOF1ikv0bCmYRgaxXSOtMRvjUfFIARGHIpnLfcpxF/S4Gk+ZPOuWzESbZovU32Iv//xrNHtarx/AVAb5/X5ZO0XP32XiYSTf+y+65JJZ1PuY6o2MXGh/C/ryGe+IcKTQCmjpaIPg6VOySwZatmio5ZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xnq5b4Xj1z4f3lDK;
	Tue, 12 Nov 2024 22:47:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B535B1A0197;
	Tue, 12 Nov 2024 22:48:06 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgBnjoKhajNnscdXBg--.33841S4;
	Tue, 12 Nov 2024 22:48:06 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 2/3] bpf: Use function pointers count as struct_ops links count
Date: Tue, 12 Nov 2024 22:58:48 +0800
Message-Id: <20241112145849.3436772-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
References: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnjoKhajNnscdXBg--.33841S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxAry7WFy3JFWUWw45Wrg_yoWrJF1kp3
	W2k3s8Cr4UXr47WF4rJa1UAF4aga40q3W7GFZrJ34Fv390qrykXFy0gF10934avFWDAF17
	AFnFgrW7uayxArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU047K7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Only function pointers in a struct_ops structure can be linked to bpf
progs, so set the links count to the function pointers count, instead
of the total members count in the structure.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/bpf_struct_ops.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 40a93e690473..ff94c8120ebb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -31,7 +31,7 @@ struct bpf_struct_ops_map {
 	 * (in kvalue.data).
 	 */
 	struct bpf_link **links;
-	u32 links_cnt;
+	u32 funcs_cnt;
 	u32 image_pages_cnt;
 	/* image_pages is an array of pages that has all the trampolines
 	 * that stores the func args before calling the bpf_prog.
@@ -480,11 +480,11 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 {
 	u32 i;
 
-	for (i = 0; i < st_map->links_cnt; i++) {
-		if (st_map->links[i]) {
-			bpf_link_put(st_map->links[i]);
-			st_map->links[i] = NULL;
-		}
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->links[i])
+			break;
+		bpf_link_put(st_map->links[i]);
+		st_map->links[i] = NULL;
 	}
 }
 
@@ -600,6 +600,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	int prog_fd, err;
 	u32 i, trampoline_start, image_off = 0;
 	void *cur_image = NULL, *image = NULL;
+	struct bpf_link **plink;
 
 	if (flags)
 		return -EINVAL;
@@ -638,6 +639,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	udata = &uvalue->data;
 	kdata = &kvalue->data;
 
+	plink = st_map->links;
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
@@ -713,7 +715,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		}
 		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
 			      &bpf_struct_ops_link_lops, prog);
-		st_map->links[i] = &link->link;
+		*plink++ = &link->link;
 
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
@@ -894,6 +896,19 @@ static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
+static u32 count_func_ptrs(const struct btf *btf, const struct btf_type *t)
+{
+	int i;
+	u32 count;
+	const struct btf_member *member;
+
+	count = 0;
+	for_each_member(i, t, member)
+		if (btf_type_resolve_func_ptr(btf, member->type, NULL))
+			count++;
+	return count;
+}
+
 static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 {
 	const struct bpf_struct_ops_desc *st_ops_desc;
@@ -960,9 +975,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	map = &st_map->map;
 
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
-	st_map->links_cnt = btf_type_vlen(t);
+	st_map->funcs_cnt = count_func_ptrs(btf, t);
 	st_map->links =
-		bpf_map_area_alloc(st_map->links_cnt * sizeof(struct bpf_links *),
+		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_link *),
 				   NUMA_NO_NODE);
 	if (!st_map->uvalue || !st_map->links) {
 		ret = -ENOMEM;
@@ -993,7 +1008,7 @@ static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
 	usage = sizeof(*st_map) +
 			vt->size - sizeof(struct bpf_struct_ops_value);
 	usage += vt->size;
-	usage += btf_type_vlen(vt) * sizeof(struct bpf_links *);
+	usage += st_map->funcs_cnt * sizeof(struct bpf_link *);
 	usage += PAGE_SIZE;
 	return usage;
 }
-- 
2.39.5


