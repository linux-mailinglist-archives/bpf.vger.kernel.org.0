Return-Path: <bpf+bounces-43723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77A9B8FFF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 12:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CA9B2120A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78851990A8;
	Fri,  1 Nov 2024 11:08:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21B14F126;
	Fri,  1 Nov 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459308; cv=none; b=F7xER8/RsYTqKemovCSxXq/3tBH/mWSamYVV6+njfV6QmT9Y/0uscsIRgYMLXMVwUCpcoZLN91Z9CmH1Xw+UXDJQ2CSQG3HFBfCLrM2mmrdY9pV7Ln7SV4A3cq6B8KTK/cjl5yg4c3O21swEd5pSLfZb2DWgYy+/3VCgnQ/DGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459308; c=relaxed/simple;
	bh=N24mt5ovwBEmQOtPdNhGmB2V+k39f517dREE5jgDYAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VQxuCjbFyjR+3LYrfEfHkHWxl1tohdL+G2qS6kwHe2HSqgsGpHi9cegeaaUerNbyvJ3IdwpfMIisiMJFQnXK2/QE5ubnpRKVXL0sSfISYOTQPMWaA4DEt6FLdQ/VMcYMTmrv6P1m+8k8hcvXJjA18oDWc9ZskEISw8ykptv7EaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xfyl54hJ4z4f3jXl;
	Fri,  1 Nov 2024 19:08:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E2C41A018D;
	Fri,  1 Nov 2024 19:08:19 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4OgtiRnaRMxAg--.38718S2;
	Fri, 01 Nov 2024 19:08:17 +0800 (CST)
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
Subject: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops trampoline
Date: Fri,  1 Nov 2024 19:19:48 +0800
Message-Id: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4OgtiRnaRMxAg--.38718S2
X-Coremail-Antispam: 1UD129KBjvAXoW3KF17AF47GF18WFWfuryUWrg_yoW8Gry8Wo
	W7Jr1UXFyxJw18XrZ5Gwn5XFWaqrWUtr9rAr4Fqrn5WF4fJ3yUKry7Gr15JFWvq348tF47
	Aw4UK3yrA3Z3JF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY97kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x07jeLvtUUUUU=
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

Below is a comparison of stacktraces captured on x86 by perf record,
before and after this patch.

Before:

... FP chain: nr:4
.....  0: ffffffffffffff80 # PERF_CONTEXT_KERNEL mark
.....  1: ffffffff8116545d
.....  2: ffffffff81167fcc
.....  3: ffffffff813088f4
 ... thread: iperf:595
 ...... dso: /proc/kcore
iperf     595 [002]  9015.616291:     824245  cycles:
        ffffffff8116545d __lock_acquire+0xad ([kernel.kallsyms])
        ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
        ffffffff813088f4 __bpf_prog_enter+0x34 ([kernel.kallsyms])

After:

... FP chain: nr:44
.....  0: ffffffffffffff80 # PERF_CONTEXT_KERNEL mark
.....  1: ffffffff81165930
.....  2: ffffffff81167fcc
.....  3: ffffffff813088f4
.....  4: ffffffffc000da5e
.....  5: ffffffff81f243df
.....  6: ffffffff81f27326
.....  7: ffffffff81f3a3c3
.....  8: ffffffff81f3c99b
.....  9: ffffffff81ef9870
..... 10: ffffffff81ef9b13
..... 11: ffffffff81ef9c69
..... 12: ffffffff81ef9f47
..... 13: ffffffff81efa15d
..... 14: ffffffff81efa9c0
..... 15: ffffffff81d979eb
..... 16: ffffffff81d987e8
..... 17: ffffffff81ddce16
..... 18: ffffffff81bc7b90
..... 19: ffffffff81bcf677
..... 20: ffffffff81bd1b4f
..... 21: ffffffff81d99693
..... 22: ffffffff81d99a52
..... 23: ffffffff810c9eb2
..... 24: ffffffff810ca631
..... 25: ffffffff822367db
..... 26: ffffffff824015ef
..... 27: ffffffff811678e6
..... 28: ffffffff814f7d85
..... 29: ffffffff814f8119
..... 30: ffffffff81492fb9
..... 31: ffffffff81355c53
..... 32: ffffffff813d79d7
..... 33: ffffffff813d88fc
..... 34: ffffffff8139a52e
..... 35: ffffffff8139a661
..... 36: ffffffff8152c193
..... 37: ffffffff8152cbc5
..... 38: ffffffff814a5908
..... 39: ffffffff814a72d3
..... 40: ffffffff814a758b
..... 41: ffffffff81008869
..... 42: ffffffff822323e8
..... 43: ffffffff8240012f
 ... thread: sleep:493
 ...... dso: /proc/kcore
sleep     493 [000]    55.483168:     410428  cycles:
        ffffffff81165930 __lock_acquire+0x580 ([kernel.kallsyms])
        ffffffff81167fcc lock_acquire+0xcc ([kernel.kallsyms])
        ffffffff813088f4 __bpf_prog_enter+0x34 ([kernel.kallsyms])
        ffffffffc000da5e bpf_trampoline_bpf_prog_075f577900bac1d2_bpf_cubic_acked+0x3a ([kernel.kallsyms])
        ffffffff81f243df tcp_ack+0xd4f ([kernel.kallsyms])
        ffffffff81f27326 tcp_rcv_established+0x3b6 ([kernel.kallsyms])
        ffffffff81f3a3c3 tcp_v4_do_rcv+0x193 ([kernel.kallsyms])
        ffffffff81f3c99b tcp_v4_rcv+0x11fb ([kernel.kallsyms])
        ffffffff81ef9870 ip_protocol_deliver_rcu+0x50 ([kernel.kallsyms])
        ffffffff81ef9b13 ip_local_deliver_finish+0xb3 ([kernel.kallsyms])
        ffffffff81ef9c69 ip_local_deliver+0x79 ([kernel.kallsyms])
        ffffffff81ef9f47 ip_sublist_rcv_finish+0xb7 ([kernel.kallsyms])
        ffffffff81efa15d ip_sublist_rcv+0x18d ([kernel.kallsyms])
        ffffffff81efa9c0 ip_list_rcv+0x110 ([kernel.kallsyms])
        ffffffff81d979eb __netif_receive_skb_list_core+0x21b ([kernel.kallsyms])
        ffffffff81d987e8 netif_receive_skb_list_internal+0x208 ([kernel.kallsyms])
        ffffffff81ddce16 napi_gro_receive+0xf6 ([kernel.kallsyms])
        ffffffff81bc7b90 virtnet_receive_done+0x340 ([kernel.kallsyms])
        ffffffff81bcf677 receive_buf+0xd7 ([kernel.kallsyms])
        ffffffff81bd1b4f virtnet_poll+0xcbf ([kernel.kallsyms])
        ffffffff81d99693 __napi_poll.constprop.0+0x33 ([kernel.kallsyms])
        ffffffff81d99a52 net_rx_action+0x1c2 ([kernel.kallsyms])
        ffffffff810c9eb2 handle_softirqs+0xe2 ([kernel.kallsyms])
        ffffffff810ca631 irq_exit_rcu+0x91 ([kernel.kallsyms])
        ffffffff822367db sysvec_apic_timer_interrupt+0x9b ([kernel.kallsyms])
        ffffffff824015ef asm_sysvec_apic_timer_interrupt+0x1f ([kernel.kallsyms])
        ffffffff811678e6 lock_release+0x186 ([kernel.kallsyms])
        ffffffff814f7d85 prepend_path+0x395 ([kernel.kallsyms])
        ffffffff814f8119 d_path+0x159 ([kernel.kallsyms])
        ffffffff81492fb9 file_path+0x19 ([kernel.kallsyms])
        ffffffff81355c53 perf_event_mmap+0x1e3 ([kernel.kallsyms])
        ffffffff813d79d7 mmap_region+0x2e7 ([kernel.kallsyms])
        ffffffff813d88fc do_mmap+0x4ec ([kernel.kallsyms])
        ffffffff8139a52e vm_mmap_pgoff+0xde ([kernel.kallsyms])
        ffffffff8139a661 vm_mmap+0x31 ([kernel.kallsyms])
        ffffffff8152c193 elf_load+0xa3 ([kernel.kallsyms])
        ffffffff8152cbc5 load_elf_binary+0x655 ([kernel.kallsyms])
        ffffffff814a5908 bprm_execve+0x2a8 ([kernel.kallsyms])
        ffffffff814a72d3 do_execveat_common.isra.0+0x193 ([kernel.kallsyms])
        ffffffff814a758b __x64_sys_execve+0x3b ([kernel.kallsyms])
        ffffffff81008869 x64_sys_call+0x1399 ([kernel.kallsyms])
        ffffffff822323e8 do_syscall_64+0x68 ([kernel.kallsyms])
        ffffffff8240012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])

Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
v2:
Refine the commit message for clarity and fix a test bot warning

v1:
https://lore.kernel.org/bpf/20241030111533.907289-1-xukuohai@huaweicloud.com/
---
 include/linux/bpf.h         |  3 +-
 kernel/bpf/bpf_struct_ops.c | 67 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/dispatcher.c     |  3 +-
 kernel/bpf/trampoline.c     |  9 +++--
 4 files changed, 78 insertions(+), 4 deletions(-)

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
index fda3dd2ee984..172a081ed1c3 100644
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
@@ -586,6 +589,35 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	return 0;
 }
 
+static void bpf_struct_ops_ksym_init(struct bpf_prog *prog, void *image,
+				     unsigned int size, struct bpf_ksym *ksym)
+{
+	int n;
+
+	n = strscpy(ksym->name, "bpf_trampoline_", KSYM_NAME_LEN);
+	strncat(ksym->name + n, prog->aux->ksym.name, KSYM_NAME_LEN - 1 - n);
+	INIT_LIST_HEAD_RCU(&ksym->lnode);
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
@@ -601,6 +633,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	int prog_fd, err;
 	u32 i, trampoline_start, image_off = 0;
 	void *cur_image = NULL, *image = NULL;
+	struct bpf_ksym *ksym;
 
 	if (flags)
 		return -EINVAL;
@@ -640,6 +673,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	kdata = &kvalue->data;
 
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
+	ksym = st_map->ksyms;
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
@@ -735,6 +769,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 		/* put prog_id to udata */
 		*(unsigned long *)(udata + moff) = prog->aux->id;
+
+		/* init ksym for this trampoline */
+		bpf_struct_ops_ksym_init(prog, image + trampoline_start,
+					 image_off - trampoline_start,
+					 ksym++);
 	}
 
 	if (st_ops->validate) {
@@ -790,6 +829,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 unlock:
 	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
+	if (!err)
+		bpf_struct_ops_map_ksyms_add(st_map);
 	return err;
 }
 
@@ -883,6 +924,10 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	 */
 	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
 
+	/* no trampoline in the map is running anymore, delete symbols */
+	bpf_struct_ops_map_ksyms_del(st_map);
+	synchronize_rcu();
+
 	__bpf_struct_ops_map_free(map);
 }
 
@@ -895,6 +940,19 @@ static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
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
@@ -905,6 +963,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
+	size_t ksyms_offset;
+	u32 ksyms_cnt;
 
 	if (attr->map_flags & BPF_F_VTYPE_BTF_OBJ_FD) {
 		/* The map holds btf for its whole life time. */
@@ -951,6 +1011,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
@@ -958,6 +1023,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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


