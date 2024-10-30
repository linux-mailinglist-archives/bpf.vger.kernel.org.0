Return-Path: <bpf+bounces-43546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91BA9B610E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 12:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767FF282C3E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE21E4908;
	Wed, 30 Oct 2024 11:04:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD31E3DD7;
	Wed, 30 Oct 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286258; cv=none; b=ZBo5HdqsWe8j2wTR6YGoq3i2r4oLy1VEL81BQj6Pj+6lZUAqpvuAL4spt2tm6ZDlsrkfcr0DzaKSoPB3ylvOk3sxw6OjfIlAJUxbqEVzWLign0GkaxiQqntH78GVZshQ2dWDo4795uM1S/0R6855coP3oMjTwJdxC/8SOFlDFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286258; c=relaxed/simple;
	bh=8s8IpDMAS8qPMxmQ0mLQ4tIc7fIRGbpEaIzNDZOo/X4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=csAnA9b2sC/xKo4lS23V8hhsJMbR1uO2UMeAyrI9XgMqMfDBAh0fmIqEwX7mwCvhuc2jIo7uBOMjo/wXXjmyU12M+k7XVeSmGriBOMCUvQIJcsaFXVx/ZYpCV8Ah9HdA0ry0RQUmOA4DZaTBRmMOp976/SdAva71Dv4Sjr7mTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdklD09wtz4f3nbY;
	Wed, 30 Oct 2024 19:03:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8A4231A0568;
	Wed, 30 Oct 2024 19:04:10 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDnjrCoEiJnTrxqAQ--.48468S2;
	Wed, 30 Oct 2024 19:04:10 +0800 (CST)
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
Subject: [PATCH bpf-next] bpf: Add kernel symbol for struct_ops trampoline
Date: Wed, 30 Oct 2024 19:15:33 +0800
Message-Id: <20241030111533.907289-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnjrCoEiJnTrxqAQ--.48468S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy5uF17Wr1xAF4rXw13Arb_yoW3tw47pF
	18Jw15Ar4UXr47WryrXa1UuFnIkr1kX347GFWDG34Fk3yYqr1DXF18tFy7Z3ySyr4UAF12
	yFnYgrWj9ayxArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxU2MmhUUUUU
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
bpf_trampoline_<PROG_NAME>, where PROG_NAME is the name of the
struct_ops prog linked to the trampoline.

Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h         |  3 +-
 kernel/bpf/bpf_struct_ops.c | 65 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/dispatcher.c     |  3 +-
 kernel/bpf/trampoline.c     |  9 +++--
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3ba4d475174..46f8d6c1a55c 100644
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
index fda3dd2ee984..7bd93c716c87 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -38,6 +38,9 @@ struct bpf_struct_ops_map {
 	 * that stores the func args before calling the bpf_prog.
 	 */
 	void *image_pages[MAX_TRAMP_IMAGE_PAGES];
+	u32 ksyms_cnt;
+	/* ksyms for bpf trampolines */
+	struct bpf_ksym *ksyms;
 	/* The owner moduler's btf. */
 	struct btf *btf;
 	/* uvalue->data stores the kernel struct
@@ -586,6 +589,33 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	return 0;
 }
 
+static void bpf_struct_ops_ksym_init(struct bpf_prog *prog, void *image,
+				     unsigned int size, struct bpf_ksym *ksym)
+{
+	INIT_LIST_HEAD_RCU(&ksym->lnode);
+	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%s",
+		 prog->aux->ksym.name);
+	bpf_image_ksym_init(image, size, ksym);
+}
+
+static void bpf_struct_ops_map_ksyms_add(struct bpf_struct_ops_map *st_map)
+{
+	struct bpf_ksym *ksym = st_map->ksyms;
+	struct bpf_ksym *end = ksym + st_map->ksyms_cnt;
+
+	while (ksym != end && ksym->start)
+		bpf_image_ksym_add(ksym++);
+}
+
+static void bpf_struct_ops_map_ksyms_del(struct bpf_struct_ops_map *st_map)
+{
+	struct bpf_ksym *ksym = st_map->ksyms;
+	struct bpf_ksym *end = ksym + st_map->ksyms_cnt;
+
+	while (ksym != end && ksym->start)
+		bpf_image_ksym_del(ksym++);
+}
+
 static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 					   void *value, u64 flags)
 {
@@ -601,6 +631,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	int prog_fd, err;
 	u32 i, trampoline_start, image_off = 0;
 	void *cur_image = NULL, *image = NULL;
+	struct bpf_ksym *ksym;
 
 	if (flags)
 		return -EINVAL;
@@ -640,6 +671,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	kdata = &kvalue->data;
 
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
+	ksym = st_map->ksyms;
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
@@ -735,6 +767,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 		/* put prog_id to udata */
 		*(unsigned long *)(udata + moff) = prog->aux->id;
+
+		/* init ksym for this trampoline */
+		bpf_struct_ops_ksym_init(prog, image + trampoline_start,
+					 image_off - trampoline_start,
+					 ksym++);
 	}
 
 	if (st_ops->validate) {
@@ -790,6 +827,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 unlock:
 	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
+	if (!err)
+		bpf_struct_ops_map_ksyms_add(st_map);
 	return err;
 }
 
@@ -883,6 +922,10 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	 */
 	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
 
+	/* no trampoline in the map is running anymore, delete symbols */
+	bpf_struct_ops_map_ksyms_del(st_map);
+	synchronize_rcu();
+
 	__bpf_struct_ops_map_free(map);
 }
 
@@ -895,6 +938,19 @@ static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
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
@@ -905,6 +961,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
+	size_t ksyms_offset;
+	u32 ksyms_cnt;
 
 	if (attr->map_flags & BPF_F_VTYPE_BTF_OBJ_FD) {
 		/* The map holds btf for its whole life time. */
@@ -951,6 +1009,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		 */
 		(vt->size - sizeof(struct bpf_struct_ops_value));
 
+	st_map_size = round_up(st_map_size, sizeof(struct bpf_ksym));
+	ksyms_offset = st_map_size;
+	ksyms_cnt = count_func_ptrs(btf, t);
+	st_map_size += ksyms_cnt * sizeof(struct bpf_ksym);
+
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
 	if (!st_map) {
 		ret = -ENOMEM;
@@ -958,6 +1021,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	}
 
 	st_map->st_ops_desc = st_ops_desc;
+	st_map->ksyms = (void *)st_map + ksyms_offset;
+	st_map->ksyms_cnt = ksyms_cnt;
 	map = &st_map->map;
 
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 70fb82bf1637..b77db7413f8c 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -154,7 +154,8 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 			d->image = NULL;
 			goto out;
 		}
-		bpf_image_ksym_add(d->image, PAGE_SIZE, &d->ksym);
+		bpf_image_ksym_init(d->image, PAGE_SIZE, &d->ksym);
+		bpf_image_ksym_add(&d->ksym);
 	}
 
 	prev_num_progs = d->num_progs;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9f36c049f4c2..ecdd2660561f 100644
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
+	bpf_image_ksym_add(ksym);
 	return im;
 
 out_free_image:
-- 
2.39.5


