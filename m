Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A34A9FA1
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiBDTBV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 14:01:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65044 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbiBDTBJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 14:01:09 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214Iiv94015990
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 11:01:09 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e17qcs0jq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:01:09 -0800
Received: from twshared9880.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 11:01:07 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CB519296C57BD; Fri,  4 Feb 2022 10:58:11 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v9 bpf-next 8/9] bpf: introduce bpf_jit_binary_pack_[alloc|finalize|free]
Date:   Fri, 4 Feb 2022 10:57:41 -0800
Message-ID: <20220204185742.271030-9-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204185742.271030-1-song@kernel.org>
References: <20220204185742.271030-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cCgZQsGgdCs2YdP6hgZE8XL4-bvcmYvE
X-Proofpoint-GUID: cCgZQsGgdCs2YdP6hgZE8XL4-bvcmYvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This is the jit binary allocator built on top of bpf_prog_pack.

bpf_prog_pack allocates RO memory, which cannot be used directly by the
JIT engine. Therefore, a temporary rw buffer is allocated for the JIT
engine. Once JIT is done, bpf_jit_binary_pack_finalize is used to copy
the program to the RO memory.

bpf_jit_binary_pack_alloc reserves 16 bytes of extra space for illegal
instructions, which is small than the 128 bytes space reserved by
bpf_jit_binary_alloc. This change is necessary for bpf_jit_binary_hdr
to find the correct header. Also, flag use_bpf_prog_pack is added to
differentiate a program allocated by bpf_jit_binary_pack_alloc.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h    |   1 +
 include/linux/filter.h |  21 ++++----
 kernel/bpf/core.c      | 108 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ea0d7fd4a410..2fc7e5c5ef41 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -953,6 +953,7 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
+	bool use_bpf_prog_pack;
 	struct hlist_node tramp_hlist;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 5855eb474c62..1cb1af917617 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -890,15 +890,6 @@ static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 	set_memory_x((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
-static inline struct bpf_binary_header *
-bpf_jit_binary_hdr(const struct bpf_prog *fp)
-{
-	unsigned long real_start = (unsigned long)fp->bpf_func;
-	unsigned long addr = real_start & PAGE_MASK;
-
-	return (void *)addr;
-}
-
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
 static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
 {
@@ -1068,6 +1059,18 @@ void *bpf_jit_alloc_exec(unsigned long size);
 void bpf_jit_free_exec(void *addr);
 void bpf_jit_free(struct bpf_prog *fp);
 
+struct bpf_binary_header *
+bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
+			  unsigned int alignment,
+			  struct bpf_binary_header **rw_hdr,
+			  u8 **rw_image,
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns);
+int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
+				 struct bpf_binary_header *ro_header,
+				 struct bpf_binary_header *rw_header);
+void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
+			      struct bpf_binary_header *rw_header);
+
 int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 				struct bpf_jit_poke_descriptor *poke);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ae590897b73..306aa63fa58e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1031,6 +1031,109 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 	bpf_jit_uncharge_modmem(size);
 }
 
+/* Allocate jit binary from bpf_prog_pack allocator.
+ * Since the allocated memory is RO+X, the JIT engine cannot write directly
+ * to the memory. To solve this problem, a RW buffer is also allocated at
+ * as the same time. The JIT engine should calculate offsets based on the
+ * RO memory address, but write JITed program to the RW buffer. Once the
+ * JIT engine finishes, it calls bpf_jit_binary_pack_finalize, which copies
+ * the JITed program to the RO memory.
+ */
+struct bpf_binary_header *
+bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
+			  unsigned int alignment,
+			  struct bpf_binary_header **rw_header,
+			  u8 **rw_image,
+			  bpf_jit_fill_hole_t bpf_fill_ill_insns)
+{
+	struct bpf_binary_header *ro_header;
+	u32 size, hole, start;
+
+	WARN_ON_ONCE(!is_power_of_2(alignment) ||
+		     alignment > BPF_IMAGE_ALIGNMENT);
+
+	/* add 16 bytes for a random section of illegal instructions */
+	size = round_up(proglen + sizeof(*ro_header) + 16, BPF_PROG_CHUNK_SIZE);
+
+	if (bpf_jit_charge_modmem(size))
+		return NULL;
+	ro_header = bpf_prog_pack_alloc(size);
+	if (!ro_header) {
+		bpf_jit_uncharge_modmem(size);
+		return NULL;
+	}
+
+	*rw_header = kvmalloc(size, GFP_KERNEL);
+	if (!*rw_header) {
+		bpf_prog_pack_free(ro_header);
+		bpf_jit_uncharge_modmem(size);
+		return NULL;
+	}
+
+	/* Fill space with illegal/arch-dep instructions. */
+	bpf_fill_ill_insns(*rw_header, size);
+	(*rw_header)->size = size;
+
+	hole = min_t(unsigned int, size - (proglen + sizeof(*ro_header)),
+		     BPF_PROG_CHUNK_SIZE - sizeof(*ro_header));
+	start = (get_random_int() % hole) & ~(alignment - 1);
+
+	*image_ptr = &ro_header->image[start];
+	*rw_image = &(*rw_header)->image[start];
+
+	return ro_header;
+}
+
+/* Copy JITed text from rw_header to its final location, the ro_header. */
+int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
+				 struct bpf_binary_header *ro_header,
+				 struct bpf_binary_header *rw_header)
+{
+	void *ptr;
+
+	ptr = bpf_arch_text_copy(ro_header, rw_header, rw_header->size);
+
+	kvfree(rw_header);
+
+	if (IS_ERR(ptr)) {
+		bpf_prog_pack_free(ro_header);
+		return PTR_ERR(ptr);
+	}
+	prog->aux->use_bpf_prog_pack = true;
+	return 0;
+}
+
+/* bpf_jit_binary_pack_free is called in two different scenarios:
+ *   1) when the program is freed after;
+ *   2) when the JIT engine fails (before bpf_jit_binary_pack_finalize).
+ * For case 2), we need to free both the RO memory and the RW buffer.
+ * Also, ro_header->size in 2) is not properly set yet, so rw_header->size
+ * is used for uncharge.
+ */
+void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
+			      struct bpf_binary_header *rw_header)
+{
+	u32 size = rw_header ? rw_header->size : ro_header->size;
+
+	bpf_prog_pack_free(ro_header);
+	kvfree(rw_header);
+	bpf_jit_uncharge_modmem(size);
+}
+
+static inline struct bpf_binary_header *
+bpf_jit_binary_hdr(const struct bpf_prog *fp)
+{
+	unsigned long real_start = (unsigned long)fp->bpf_func;
+	unsigned long addr;
+
+	if (fp->aux->use_bpf_prog_pack)
+		addr = real_start & BPF_PROG_CHUNK_MASK;
+	else
+		addr = real_start & PAGE_MASK;
+
+	return (void *)addr;
+}
+
 /* This symbol is only overridden by archs that have different
  * requirements than the usual eBPF JITs, f.e. when they only
  * implement cBPF JIT, do not set images read-only, etc.
@@ -1040,7 +1143,10 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 	if (fp->jited) {
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
 
-		bpf_jit_binary_free(hdr);
+		if (fp->aux->use_bpf_prog_pack)
+			bpf_jit_binary_pack_free(hdr, NULL /* rw_buffer */);
+		else
+			bpf_jit_binary_free(hdr);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
-- 
2.30.2

