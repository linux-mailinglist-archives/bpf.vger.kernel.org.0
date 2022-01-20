Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0244954B9
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 20:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377575AbiATTOZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 20 Jan 2022 14:14:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1377504AbiATTNh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 14:13:37 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20KHxXWV015005
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:13:37 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dpynjcu71-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 11:13:36 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 20 Jan 2022 11:13:34 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4F51128324603; Thu, 20 Jan 2022 11:13:28 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v5 bpf-next 6/7] bpf: introduce bpf_prog_pack allocator
Date:   Thu, 20 Jan 2022 11:13:04 -0800
Message-ID: <20220120191306.1801459-7-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120191306.1801459-1-song@kernel.org>
References: <20220120191306.1801459-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 76CYtFEPV1KkfMt_VFT4v5ai6Dz3UXzm
X-Proofpoint-GUID: 76CYtFEPV1KkfMt_VFT4v5ai6Dz3UXzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_07,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=979 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Most BPF programs are small, but they consume a page each. For systems
with busy traffic and many BPF programs, this could add significant
pressure to instruction TLB.

Introduce bpf_prog_pack allocator to pack multiple BPF programs in a huge
page. The memory is then allocated in 64 byte chunks.

Memory allocated by bpf_prog_pack allocator is RO protected after initial
allocation. To write to it, the user (jit engine) need to use text poke
API.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/filter.h |   7 ++
 kernel/bpf/core.c      | 187 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 190 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 27ea68604c22..a58658442d2e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1074,6 +1074,13 @@ void *bpf_jit_alloc_exec(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 
+struct bpf_binary_header *
+bpf_jit_binary_alloc_pack(unsigned int proglen, u8 **image_r_ptr,
+			  unsigned int alignment,
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns);
+void bpf_jit_binary_free_pack(struct bpf_binary_header *hdr);
+int bpf_prog_pack_max_size(void);
+
 int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 				struct bpf_jit_poke_descriptor *poke);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f252d8529b0b..f1bc89047173 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -808,6 +808,116 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 	return slot;
 }
 
+/*
+ * BPF program pack allocator.
+ *
+ * Most BPF programs are pretty small. Allocating a hole page for each
+ * program is sometime a waste. Many small bpf program also adds pressure
+ * to instruction TLB. To solve this issue, we introduce a BPF program pack
+ * allocator. The prog_pack allocator uses HPAGE_PMD_SIZE page (2MB on x86)
+ * to host BPF programs.
+ */
+#define BPF_PROG_PACK_SIZE	HPAGE_PMD_SIZE
+#define BPF_PROG_CHUNK_SHIFT	6
+#define BPF_PROG_CHUNK_SIZE	(1 << BPF_PROG_CHUNK_SHIFT)
+#define BPF_PROG_CHUNK_COUNT	(BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
+
+struct bpf_prog_pack {
+	struct list_head list;
+	void *ptr;
+	unsigned long bitmap[BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)];
+};
+
+#define BPF_PROG_MAX_PACK_PROG_SIZE	HPAGE_PMD_SIZE
+#define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
+
+static DEFINE_MUTEX(pack_mutex);
+static LIST_HEAD(pack_list);
+
+static struct bpf_prog_pack *alloc_new_pack(void)
+{
+	struct bpf_prog_pack *pack;
+
+	pack = kzalloc(sizeof(*pack), GFP_KERNEL);
+	if (!pack)
+		return NULL;
+	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
+	if (!pack->ptr) {
+		kfree(pack);
+		return NULL;
+	}
+	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
+	list_add_tail(&pack->list, &pack_list);
+
+	set_vm_flush_reset_perms(pack);
+	set_memory_ro((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	set_memory_x((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	return pack;
+}
+
+static void *bpf_prog_pack_alloc(u32 size)
+{
+	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
+	struct bpf_prog_pack *pack;
+	unsigned long pos;
+	void *ptr = NULL;
+
+	mutex_lock(&pack_mutex);
+	list_for_each_entry(pack, &pack_list, list) {
+		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
+						 nbits, 0);
+		if (pos < BPF_PROG_CHUNK_COUNT)
+			goto found_free_area;
+	}
+
+	pack = alloc_new_pack();
+	if (!pack)
+		goto out;
+
+	pos = 0;
+
+found_free_area:
+	bitmap_set(pack->bitmap, pos, nbits);
+	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
+
+out:
+	mutex_unlock(&pack_mutex);
+	return ptr;
+}
+
+static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
+{
+	void *pack_ptr = (void *)((unsigned long)hdr & ~(BPF_PROG_PACK_SIZE - 1));
+	struct bpf_prog_pack *pack = NULL, *tmp;
+	unsigned int nbits;
+	unsigned long pos;
+
+	mutex_lock(&pack_mutex);
+
+	list_for_each_entry(tmp, &pack_list, list) {
+		if (tmp->ptr == pack_ptr) {
+			pack = tmp;
+			break;
+		}
+	}
+
+	if (WARN_ONCE(!pack, "bpf_prog_pack bug\n"))
+		goto out;
+
+	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
+	pos = ((unsigned long)hdr - (unsigned long)pack_ptr) >> BPF_PROG_CHUNK_SHIFT;
+
+	bitmap_clear(pack->bitmap, pos, nbits);
+	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
+				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
+		list_del(&pack->list);
+		module_memfree(pack->ptr);
+		kfree(pack);
+	}
+out:
+	mutex_unlock(&pack_mutex);
+}
+
 static atomic_long_t bpf_jit_current;
 
 /* Can be overridden by an arch's JIT compiler if it has a custom,
@@ -860,10 +970,59 @@ void __weak bpf_jit_free_exec(void *addr)
 	module_memfree(addr);
 }
 
+static struct bpf_binary_header *
+__bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
+		       unsigned int alignment,
+		       bpf_jit_fill_hole_t bpf_fill_ill_insns,
+		       u32 round_up_to)
+{
+	struct bpf_binary_header *hdr;
+	u32 size, hole, start;
+
+	WARN_ON_ONCE(!is_power_of_2(alignment) ||
+		     alignment > BPF_IMAGE_ALIGNMENT);
+
+	/* Most of BPF filters are really small, but if some of them
+	 * fill a page, allow at least 128 extra bytes to insert a
+	 * random section of illegal instructions.
+	 */
+	size = round_up(proglen + sizeof(*hdr) + 128, round_up_to);
+
+	if (bpf_jit_charge_modmem(size))
+		return NULL;
+	hdr = bpf_jit_alloc_exec(size);
+	if (!hdr) {
+		bpf_jit_uncharge_modmem(size);
+		return NULL;
+	}
+
+	/* Fill space with illegal/arch-dep instructions. */
+	bpf_fill_ill_insns(hdr, size);
+
+	hdr->size = size;
+	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
+		     PAGE_SIZE - sizeof(*hdr));
+	start = (get_random_int() % hole) & ~(alignment - 1);
+
+	/* Leave a random number of instructions before BPF code. */
+	*image_ptr = &hdr->image[start];
+
+	return hdr;
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns)
+{
+	return __bpf_jit_binary_alloc(proglen, image_ptr, alignment,
+				      bpf_fill_ill_insns, PAGE_SIZE);
+}
+
+struct bpf_binary_header *
+bpf_jit_binary_alloc_pack(unsigned int proglen, u8 **image_ptr,
+			  unsigned int alignment,
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_binary_header *hdr;
 	u32 size, hole, start;
@@ -875,11 +1034,19 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	 * fill a page, allow at least 128 extra bytes to insert a
 	 * random section of illegal instructions.
 	 */
-	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
+	size = round_up(proglen + sizeof(*hdr) + 128, BPF_PROG_CHUNK_SIZE);
+
+	/* for too big program, use __bpf_jit_binary_alloc with round_up_to
+	 * of BPF_PROG_MAX_PACK_PROG_SIZE.
+	 */
+	if (size > BPF_PROG_MAX_PACK_PROG_SIZE)
+		return __bpf_jit_binary_alloc(proglen, image_ptr,
+					      alignment, bpf_fill_ill_insns,
+					      BPF_PROG_MAX_PACK_PROG_SIZE);
 
 	if (bpf_jit_charge_modmem(size))
 		return NULL;
-	hdr = bpf_jit_alloc_exec(size);
+	hdr = bpf_prog_pack_alloc(size);
 	if (!hdr) {
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
@@ -888,9 +1055,8 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	/* Fill space with illegal/arch-dep instructions. */
 	bpf_fill_ill_insns(hdr, size);
 
-	hdr->size = size;
 	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
-		     PAGE_SIZE - sizeof(*hdr));
+		     BPF_PROG_CHUNK_SIZE - sizeof(*hdr));
 	start = (get_random_int() % hole) & ~(alignment - 1);
 
 	/* Leave a random number of instructions before BPF code. */
@@ -907,6 +1073,19 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 	bpf_jit_uncharge_modmem(size);
 }
 
+void bpf_jit_binary_free_pack(struct bpf_binary_header *hdr)
+{
+	u32 size = hdr->size;
+
+	bpf_prog_pack_free(hdr);
+	bpf_jit_uncharge_modmem(size);
+}
+
+int bpf_prog_pack_max_size(void)
+{
+	return BPF_PROG_MAX_PACK_PROG_SIZE;
+}
+
 /* This symbol is only overridden by archs that have different
  * requirements than the usual eBPF JITs, f.e. when they only
  * implement cBPF JIT, do not set images read-only, etc.
-- 
2.30.2

