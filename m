Return-Path: <bpf+bounces-44511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F79C3DF4
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DE6B22B49
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617419B3D3;
	Mon, 11 Nov 2024 12:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49F17C227;
	Mon, 11 Nov 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326758; cv=none; b=kXwK5De+gGRGojNIevYqv7yIhqlt5gyG/16OTrOEzz4Eci8tOFRj9aP6ZaqVg12KStBvYc9HphLtBULr8ZbakMpF9/xuuGVVXrdRCGAMeXWFJLZcd7HDOo9cK0NiT3F3ekNQrO+ucxr4wYT2/a9zsfIlzCjKT6k5ki7tKuVakc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326758; c=relaxed/simple;
	bh=ZizdZ9nSfPeDXJ1YmAkhRgpc8ZfjHg20vFWfgN9TZoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqSuTvCMYZHoihnZnDwsF60PF5s2wZZKV6/3nU2hVLsXcja00S94uYBwLcmXeQ1QpQv7xIkgOx7FQzye+amtJaMpMpPR26+3GnfAm4wJXMmLILJqvq+56pDoRO43Z0qnFgRt/DwKzXC0adjydgp5fp4al856A+3mdyljnzSD4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xn7Xy2d6qz4f3m8X;
	Mon, 11 Nov 2024 20:05:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6C8291A018C;
	Mon, 11 Nov 2024 20:05:51 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgBH9uIc8zFnxbLkBQ--.11390S3;
	Mon, 11 Nov 2024 20:05:51 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/2] bpf: Use function pointers count as struct_ops links count
Date: Mon, 11 Nov 2024 20:16:40 +0800
Message-Id: <20241111121641.2679885-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
References: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH9uIc8zFnxbLkBQ--.11390S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrCw13uFW8AF1xXrWUJwb_yoW5uF43p3
	W2k345Cr4UXF47WF4rJa1UAF1aga40q3W7GFZrJ34FvrWYqrykXF10gF10934akFWDAF13
	AFnFgryDuayxArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	vfC2KfnxnUUI43ZEXa7IU8A9N7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Only function pointers in a struct_ops structure can be linked to bpf
progs, so set the links count to the function pointers count, instead
of the total members count in the structure.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/bpf_struct_ops.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fda3dd2ee984..e99fce81e916 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -32,7 +32,7 @@ struct bpf_struct_ops_map {
 	 * (in kvalue.data).
 	 */
 	struct bpf_link **links;
-	u32 links_cnt;
+	u32 funcs_cnt;
 	u32 image_pages_cnt;
 	/* image_pages is an array of pages that has all the trampolines
 	 * that stores the func args before calling the bpf_prog.
@@ -481,11 +481,11 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
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
 
@@ -601,6 +601,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	int prog_fd, err;
 	u32 i, trampoline_start, image_off = 0;
 	void *cur_image = NULL, *image = NULL;
+	struct bpf_link **plink;
 
 	if (flags)
 		return -EINVAL;
@@ -639,6 +640,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	udata = &uvalue->data;
 	kdata = &kvalue->data;
 
+	plink = st_map->links;
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
@@ -714,7 +716,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		}
 		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
 			      &bpf_struct_ops_link_lops, prog);
-		st_map->links[i] = &link->link;
+		*plink++ = &link->link;
 
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
@@ -895,6 +897,19 @@ static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
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
@@ -961,9 +976,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	map = &st_map->map;
 
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
-	st_map->links_cnt = btf_type_vlen(t);
+	st_map->funcs_cnt = count_func_ptrs(btf, t);
 	st_map->links =
-		bpf_map_area_alloc(st_map->links_cnt * sizeof(struct bpf_links *),
+		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
 	if (!st_map->uvalue || !st_map->links) {
 		ret = -ENOMEM;
-- 
2.39.5


