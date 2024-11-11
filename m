Return-Path: <bpf+bounces-44510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39839C3DF1
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090D2B22349
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40919ABB7;
	Mon, 11 Nov 2024 12:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019317BECA;
	Mon, 11 Nov 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326758; cv=none; b=IzuuGNrahVcUHCb9JrPnVyf+ovRnmUJ++wCcpdn3qLDK51mAWeMGp1x3SRZNqDTJa2atYpqeBca0IrxU05jQPrRrUgoNTENxxUVkfx3HGFfDxEhtQPVMJf/OMiXrjdHOPeaS6zIXeHVQ1RHMTpmppldlNp9KMfArW63zNQajnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326758; c=relaxed/simple;
	bh=TXnwsp44Zy0rcR1HsWf307XQtxlwptmdt+Lz4wakjqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJe7566/r5C1NSLbmIPqky0FAlaMMcpP/BdlHfJoCqNf+hK//F9tGZ7C0I9hzVOpfkmjJJ3IxSSs5aZMZxx6st5I6ihQTGVlnBP6j/fxiQ2UoBpODpYd1H/M7CK4MxCBxqiu3dTYcZVO+3N2+2EFrGQu0OId2zjnKFZx7DCDag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xn7Xs2XBkz4f3jdK;
	Mon, 11 Nov 2024 20:05:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 811C91A0359;
	Mon, 11 Nov 2024 20:05:51 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgBH9uIc8zFnxbLkBQ--.11390S4;
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
Subject: [PATCH bpf-next v3 2/2] bpf: Add kernel symbol for struct_ops trampoline
Date: Mon, 11 Nov 2024 20:16:41 +0800
Message-Id: <20241111121641.2679885-3-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBH9uIc8zFnxbLkBQ--.11390S4
X-Coremail-Antispam: 1UD129KBjvJXoW3KF1xXrWfXw1DJw13Ar45trb_yoWkJw4DpF
	1jy345CF4UXr47WrW8Xa15uF9xKw1vq3W7GFWDJ3yFkrWYgr1kX3W8tFyUu398tr4DuF17
	tFn2grW2yay7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Without kernel symbols for struct_ops trampoline, the unwinder may
produce unexpected stacktraces.

For example, the x86 ORC and FP unwinders check if an IP is in kernel
text by verifying the presence of the IP's kernel symbol. When a
struct_ops trampoline address is encountered, the unwinder stops due
to the absence of symbol, resulting in an incomplete stacktrace that
consists only of direct and indirect child functions called from the
trampoline.

The arm64 unwinder is another example. While the arm64 unwinder can
proceed across a struct_ops trampoline address, the corresponding
symbol name is displayed as "unknown", which is confusing.

Thus, add kernel symbol for struct_ops trampoline. The name is
bpf__<struct_ops_name>_<member_name>, where <struct_ops_name> is the
type name of the struct_ops, and <member_name> is the name of
the member that the trampoline is linked to.

Below is a comparison of stacktraces captured on x86 by perf record,
before and after this patch.

Before:
ffffffff8116545d __lock_acquire+0xad ([kernel.kallsyms])
ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
ffffffff813088f4 __bpf_prog_enter+0x34 ([kernel.kallsyms])

After:
ffffffff811656bd __lock_acquire+0x30d ([kernel.kallsyms])
ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
ffffffff81309024 __bpf_prog_enter+0x34 ([kernel.kallsyms])
ffffffffc000d7e9 bpf__tcp_congestion_ops_cong_avoid+0x3e ([kernel.kallsyms])
ffffffff81f250a5 tcp_ack+0x10d5 ([kernel.kallsyms])
ffffffff81f27c66 tcp_rcv_established+0x3b6 ([kernel.kallsyms])
ffffffff81f3ad03 tcp_v4_do_rcv+0x193 ([kernel.kallsyms])
ffffffff81d65a18 __release_sock+0xd8 ([kernel.kallsyms])
ffffffff81d65af4 release_sock+0x34 ([kernel.kallsyms])
ffffffff81f15c4b tcp_sendmsg+0x3b ([kernel.kallsyms])
ffffffff81f663d7 inet_sendmsg+0x47 ([kernel.kallsyms])
ffffffff81d5ab40 sock_write_iter+0x160 ([kernel.kallsyms])
ffffffff8149c67b vfs_write+0x3fb ([kernel.kallsyms])
ffffffff8149caf6 ksys_write+0xc6 ([kernel.kallsyms])
ffffffff8149cb5d __x64_sys_write+0x1d ([kernel.kallsyms])
ffffffff81009200 x64_sys_call+0x1d30 ([kernel.kallsyms])
ffffffff82232d28 do_syscall_64+0x68 ([kernel.kallsyms])
ffffffff8240012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])

Note that while adding new member ksyms to struct bpf_struct_ops_map,
this patch also removes an unused member rcu from the structure.

Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h         |  3 +-
 kernel/bpf/bpf_struct_ops.c | 81 ++++++++++++++++++++++++++++++++++++-
 kernel/bpf/dispatcher.c     |  3 +-
 kernel/bpf/trampoline.c     |  9 ++++-
 4 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b84613b10ac..6fc6398d86c6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1402,7 +1402,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 				struct bpf_prog *to);
 /* Called only from JIT-enabled code, so there's no need for stubs. */
-void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym);
+void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym *ksym);
+void bpf_image_ksym_add(struct bpf_ksym *ksym);
 void bpf_image_ksym_del(struct bpf_ksym *ksym);
 void bpf_ksym_add(struct bpf_ksym *ksym);
 void bpf_ksym_del(struct bpf_ksym *ksym);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index e99fce81e916..d6dd56fc80d8 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -23,7 +23,6 @@ struct bpf_struct_ops_value {
 
 struct bpf_struct_ops_map {
 	struct bpf_map map;
-	struct rcu_head rcu;
 	const struct bpf_struct_ops_desc *st_ops_desc;
 	/* protect map_update */
 	struct mutex lock;
@@ -32,6 +31,8 @@ struct bpf_struct_ops_map {
 	 * (in kvalue.data).
 	 */
 	struct bpf_link **links;
+	/* ksyms for bpf trampolines */
+	struct bpf_ksym **ksyms;
 	u32 funcs_cnt;
 	u32 image_pages_cnt;
 	/* image_pages is an array of pages that has all the trampolines
@@ -586,6 +587,49 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	return 0;
 }
 
+static void bpf_struct_ops_ksym_init(const char *tname, const char *mname,
+				     void *image, unsigned int size,
+				     struct bpf_ksym *ksym)
+{
+	snprintf(ksym->name, KSYM_NAME_LEN, "bpf__%s_%s", tname, mname);
+	INIT_LIST_HEAD_RCU(&ksym->lnode);
+	bpf_image_ksym_init(image, size, ksym);
+}
+
+static void bpf_struct_ops_map_ksyms_add(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->ksyms[i])
+			break;
+		bpf_image_ksym_add(st_map->ksyms[i]);
+	}
+}
+
+static void bpf_struct_ops_map_del_ksyms(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->ksyms[i])
+			break;
+		bpf_image_ksym_del(st_map->ksyms[i]);
+	}
+}
+
+static void bpf_struct_ops_map_free_ksyms(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->ksyms[i])
+			break;
+		kfree(st_map->ksyms[i]);
+		st_map->links[i] = NULL;
+	}
+}
+
 static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 					   void *value, u64 flags)
 {
@@ -602,6 +646,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	u32 i, trampoline_start, image_off = 0;
 	void *cur_image = NULL, *image = NULL;
 	struct bpf_link **plink;
+	struct bpf_ksym **pksym;
+	const char *tname, *mname;
 
 	if (flags)
 		return -EINVAL;
@@ -641,14 +687,18 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	kdata = &kvalue->data;
 
 	plink = st_map->links;
+	pksym = st_map->ksyms;
+	tname = btf_name_by_offset(st_map->btf, t->name_off);
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
 		struct bpf_tramp_link *link;
+		struct bpf_ksym *ksym;
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
+		mname = btf_name_by_offset(st_map->btf, member->name_off);
 		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
@@ -718,6 +768,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog);
 		*plink++ = &link->link;
 
+		ksym = kzalloc(sizeof(*ksym), GFP_USER);
+		if (!ksym) {
+			bpf_prog_put(prog);
+			err = -ENOMEM;
+			goto reset_unlock;
+		}
+		*pksym = ksym;
+
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[i],
@@ -737,6 +795,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 		/* put prog_id to udata */
 		*(unsigned long *)(udata + moff) = prog->aux->id;
+
+		/* init ksym for this trampoline */
+		bpf_struct_ops_ksym_init(tname, mname,
+					 image + trampoline_start,
+					 image_off - trampoline_start,
+					 *pksym++);
 	}
 
 	if (st_ops->validate) {
@@ -785,6 +849,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 */
 
 reset_unlock:
+	bpf_struct_ops_map_free_ksyms(st_map);
 	bpf_struct_ops_map_free_image(st_map);
 	bpf_struct_ops_map_put_progs(st_map);
 	memset(uvalue, 0, map->value_size);
@@ -792,6 +857,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 unlock:
 	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
+	if (!err)
+		bpf_struct_ops_map_ksyms_add(st_map);
 	return err;
 }
 
@@ -851,7 +918,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 
 	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
+	if (st_map->ksyms)
+		bpf_struct_ops_map_free_ksyms(st_map);
 	bpf_map_area_free(st_map->links);
+	bpf_map_area_free(st_map->ksyms);
 	bpf_struct_ops_map_free_image(st_map);
 	bpf_map_area_free(st_map->uvalue);
 	bpf_map_area_free(st_map);
@@ -868,6 +938,9 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
+	if (st_map->ksyms)
+		bpf_struct_ops_map_del_ksyms(st_map);
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -980,7 +1053,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	st_map->links =
 		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
-	if (!st_map->uvalue || !st_map->links) {
+
+	st_map->ksyms =
+		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_ksyms *),
+				   NUMA_NO_NODE);
+	if (!st_map->uvalue || !st_map->links || !st_map->ksyms) {
 		ret = -ENOMEM;
 		goto errout_free;
 	}
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 70fb82bf1637..aad8a11cc7e5 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -154,7 +154,8 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 			d->image = NULL;
 			goto out;
 		}
-		bpf_image_ksym_add(d->image, PAGE_SIZE, &d->ksym);
+		bpf_image_ksym_init(d->image, PAGE_SIZE, &d->ksym);
+		bpf_image_ksym_add(d->image);
 	}
 
 	prev_num_progs = d->num_progs;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9f36c049f4c2..c3efca44c8f7 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -115,10 +115,14 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
-void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym)
+void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym *ksym)
 {
 	ksym->start = (unsigned long) data;
 	ksym->end = ksym->start + size;
+}
+
+void bpf_image_ksym_add(struct bpf_ksym *ksym)
+{
 	bpf_ksym_add(ksym);
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF, ksym->start,
 			   PAGE_SIZE, false, ksym->name);
@@ -377,7 +381,8 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
 	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", key);
-	bpf_image_ksym_add(image, size, ksym);
+	bpf_image_ksym_init(image, size, ksym);
+	bpf_image_ksym_add(image);
 	return im;
 
 out_free_image:
-- 
2.39.5


