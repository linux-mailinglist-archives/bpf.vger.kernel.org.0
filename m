Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD895EB074
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIZSsI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Sep 2022 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIZSsI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E980BE0
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:06 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QI9K3l020616
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:06 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jt174n3kc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:06 -0700
Received: from twshared3307.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:47:58 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 55A6BD6AB47C; Mon, 26 Sep 2022 11:47:45 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, <haoluo@google.com>, <jlayton@kernel.org>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
Date:   Mon, 26 Sep 2022 11:47:38 -0700
Message-ID: <20220926184739.3512547-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926184739.3512547-1-song@kernel.org>
References: <20220926184739.3512547-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HrctmjVIACfAmsXw9dEbjY8rdNEUuQ4l
X-Proofpoint-ORIG-GUID: HrctmjVIACfAmsXw9dEbjY8rdNEUuQ4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allocate bpf_dispatcher with bpf_prog_pack_alloc so that bpf_dispatcher
can share pages with bpf programs.

arch_prepare_bpf_dispatcher() is updated to provide a RW buffer as working
area for arch code to write to.

This also fixes CPA W^X warnning like:

CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: ...

Signed-off-by: Song Liu <song@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 16 ++++++++--------
 include/linux/bpf.h         |  3 ++-
 include/linux/filter.h      |  5 +++++
 kernel/bpf/core.c           |  9 +++++++--
 kernel/bpf/dispatcher.c     | 27 +++++++++++++++++++++------
 5 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ae89f4143eb4..f62c05385fa7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2243,7 +2243,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	return ret;
 }
 
-static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
+static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
 {
 	u8 *jg_reloc, *prog = *pprog;
 	int pivot, err, jg_bytes = 1;
@@ -2259,12 +2259,12 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 		EMIT2_off32(0x81, add_1reg(0xF8, BPF_REG_3),
 			    progs[a]);
 		err = emit_cond_near_jump(&prog,	/* je func */
-					  (void *)progs[a], prog,
+					  (void *)progs[a], image + (prog - buf),
 					  X86_JE);
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, prog);
+		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
@@ -2289,7 +2289,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 	jg_reloc = prog;
 
 	err = emit_bpf_dispatcher(&prog, a, a + pivot,	/* emit lower_part */
-				  progs);
+				  progs, image, buf);
 	if (err)
 		return err;
 
@@ -2303,7 +2303,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs)
 	emit_code(jg_reloc - jg_bytes, jg_offset, jg_bytes);
 
 	err = emit_bpf_dispatcher(&prog, a + pivot + 1,	/* emit upper_part */
-				  b, progs);
+				  b, progs, image, buf);
 	if (err)
 		return err;
 
@@ -2323,12 +2323,12 @@ static int cmp_ips(const void *a, const void *b)
 	return 0;
 }
 
-int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
+int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs)
 {
-	u8 *prog = image;
+	u8 *prog = buf;
 
 	sort(funcs, num_funcs, sizeof(funcs[0]), cmp_ips, NULL);
-	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs);
+	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
 }
 
 struct x64_jit_data {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index edd43edb27d6..9ae155c75014 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -946,6 +946,7 @@ struct bpf_dispatcher {
 	struct bpf_dispatcher_prog progs[BPF_DISPATCHER_MAX];
 	int num_progs;
 	void *image;
+	void *rw_image;
 	u32 image_off;
 	struct bpf_ksym ksym;
 };
@@ -964,7 +965,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
-int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
+int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
 #define BPF_DISPATCHER_INIT(_name) {				\
 	.mutex = __MUTEX_INITIALIZER(_name.mutex),		\
 	.func = &_name##_func,					\
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 98e28126c24b..efc42a6e3aed 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1023,6 +1023,8 @@ extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
+void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -1035,6 +1037,9 @@ void bpf_jit_free(struct bpf_prog *fp);
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
+void bpf_prog_pack_free(struct bpf_binary_header *hdr);
+
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
 {
 	return list_empty(&fp->aux->ksym.lnode) ||
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d1be78c28619..711fd293b6de 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -825,6 +825,11 @@ struct bpf_prog_pack {
 	unsigned long bitmap[];
 };
 
+void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
+{
+	memset(area, 0, size);
+}
+
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
 static DEFINE_MUTEX(pack_mutex);
@@ -864,7 +869,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	return pack;
 }
 
-static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
+void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
 	struct bpf_prog_pack *pack;
@@ -905,7 +910,7 @@ static void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insn
 	return ptr;
 }
 
-static void bpf_prog_pack_free(struct bpf_binary_header *hdr)
+void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 {
 	struct bpf_prog_pack *pack = NULL, *tmp;
 	unsigned int nbits;
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 2444bd15cc2d..fa64b80b8bca 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -85,12 +85,12 @@ static bool bpf_dispatcher_remove_prog(struct bpf_dispatcher *d,
 	return false;
 }
 
-int __weak arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs)
+int __weak arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs)
 {
 	return -ENOTSUPP;
 }
 
-static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image)
+static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image, void *buf)
 {
 	s64 ips[BPF_DISPATCHER_MAX] = {}, *ipsp = &ips[0];
 	int i;
@@ -99,12 +99,12 @@ static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image)
 		if (d->progs[i].prog)
 			*ipsp++ = (s64)(uintptr_t)d->progs[i].prog->bpf_func;
 	}
-	return arch_prepare_bpf_dispatcher(image, &ips[0], d->num_progs);
+	return arch_prepare_bpf_dispatcher(image, buf, &ips[0], d->num_progs);
 }
 
 static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 {
-	void *old, *new;
+	void *old, *new, *tmp;
 	u32 noff;
 	int err;
 
@@ -117,8 +117,14 @@ static void bpf_dispatcher_update(struct bpf_dispatcher *d, int prev_num_progs)
 	}
 
 	new = d->num_progs ? d->image + noff : NULL;
+	tmp = d->num_progs ? d->rw_image + noff : NULL;
 	if (new) {
-		if (bpf_dispatcher_prepare(d, new))
+		/* Prepare the dispatcher in d->rw_image. Then use
+		 * bpf_arch_text_copy to update d->image, which is RO+X.
+		 */
+		if (bpf_dispatcher_prepare(d, new, tmp))
+			return;
+		if (IS_ERR(bpf_arch_text_copy(new, tmp, PAGE_SIZE / 2)))
 			return;
 	}
 
@@ -140,9 +146,18 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 
 	mutex_lock(&d->mutex);
 	if (!d->image) {
-		d->image = bpf_jit_alloc_exec_page();
+		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero);
 		if (!d->image)
 			goto out;
+		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
+		if (!d->rw_image) {
+			u32 size = PAGE_SIZE;
+
+			bpf_arch_text_copy(d->image, &size, sizeof(size));
+			bpf_prog_pack_free((struct bpf_binary_header *)d->image);
+			d->image = NULL;
+			goto out;
+		}
 		bpf_image_ksym_add(d->image, &d->ksym);
 	}
 
-- 
2.30.2

