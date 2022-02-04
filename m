Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466574A9F99
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiBDTBG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 14:01:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4216 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbiBDTBG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 14:01:06 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214IisJi023465
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 11:01:05 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e18wfgewe-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:01:05 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 11:01:01 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6FDD1296C57A3; Fri,  4 Feb 2022 10:58:09 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <song@kernel.org>
Subject: [PATCH v9 bpf-next 7/9] bpf: introduce bpf_prog_pack allocator
Date:   Fri, 4 Feb 2022 10:57:40 -0800
Message-ID: <20220204185742.271030-8-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204185742.271030-1-song@kernel.org>
References: <20220204185742.271030-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: C6ryiEijyKNfwxuQcvqywjbuSj5y_qxu
X-Proofpoint-GUID: C6ryiEijyKNfwxuQcvqywjbuSj5y_qxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202040104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Most BPF programs are small, but they consume a page each. For systems
with busy traffic and many BPF programs, this could add significant
pressure to instruction TLB. High iTLB pressure usually causes slow down
for the whole system, which includes visible performance degradation for
production workloads.

Introduce bpf_prog_pack allocator to pack multiple BPF programs in a huge
page. The memory is then allocated in 64 byte chunks.

Memory allocated by bpf_prog_pack allocator is RO protected after initial
allocation. To write to it, the user (jit engine) need to use text poke
API.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a5ec480f9862..7ae590897b73 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -805,6 +805,133 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
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
+#define BPF_PROG_CHUNK_MASK	(~(BPF_PROG_CHUNK_SIZE - 1))
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
+	set_vm_flush_reset_perms(pack->ptr);
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
+	if (size > BPF_PROG_MAX_PACK_PROG_SIZE) {
+		size = round_up(size, PAGE_SIZE);
+		ptr = module_alloc(size);
+		if (ptr) {
+			set_vm_flush_reset_perms(ptr);
+			set_memory_ro((unsigned long)ptr, size / PAGE_SIZE);
+			set_memory_x((unsigned long)ptr, size / PAGE_SIZE);
+		}
+		return ptr;
+	}
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
+	struct bpf_prog_pack *pack = NULL, *tmp;
+	unsigned int nbits;
+	unsigned long pos;
+	void *pack_ptr;
+
+	if (hdr->size > BPF_PROG_MAX_PACK_PROG_SIZE) {
+		module_memfree(hdr);
+		return;
+	}
+
+	pack_ptr = (void *)((unsigned long)hdr & ~(BPF_PROG_PACK_SIZE - 1));
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
-- 
2.30.2

