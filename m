Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C705E84C2
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIWVS6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Sep 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWVS6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:18:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF112206C
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:18:57 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NIGA0I012506
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:18:57 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsb1nmeh8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:18:57 -0700
Received: from twshared20273.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 14:18:53 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 5AE63D4BF99F; Fri, 23 Sep 2022 14:18:49 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, <haoluo@google.com>, <jlayton@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
Date:   Fri, 23 Sep 2022 14:18:36 -0700
Message-ID: <20220923211837.3044723-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923211837.3044723-1-song@kernel.org>
References: <20220923211837.3044723-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1B836LWFb6HA2DAHYWn1GboiKxMxVNZn
X-Proofpoint-GUID: 1B836LWFb6HA2DAHYWn1GboiKxMxVNZn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
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

This also fixes CPA W^X warnning like:

CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: ...

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h     |  1 +
 include/linux/filter.h  |  5 +++++
 kernel/bpf/core.c       |  9 +++++++--
 kernel/bpf/dispatcher.c | 21 ++++++++++++++++++---
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index edd43edb27d6..a8d0cfe14372 100644
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
index 2444bd15cc2d..8a10300854b6 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -104,7 +104,7 @@ static int bpf_dispatcher_prepare(struct bpf_dispatcher *d, void *image)
 
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
+		if (bpf_dispatcher_prepare(d, tmp))
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

