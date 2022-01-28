Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C44A04A4
	for <lists+bpf@lfdr.de>; Sat, 29 Jan 2022 00:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351845AbiA1Xvp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 28 Jan 2022 18:51:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351865AbiA1Xvf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Jan 2022 18:51:35 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20SKoIXZ002143
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 15:51:35 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dv695y15n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 15:51:35 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 15:51:26 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4A35B28E02F2B; Fri, 28 Jan 2022 15:45:28 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v7 bpf-next 2/9] bpf: use bytes instead of pages for bpf_jit_[charge|uncharge]_modmem
Date:   Fri, 28 Jan 2022 15:45:10 -0800
Message-ID: <20220128234517.3503701-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128234517.3503701-1-song@kernel.org>
References: <20220128234517.3503701-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oUm1PkOr3bHbO3Bm8gALEOrp2LCdaYqT
X-Proofpoint-GUID: oUm1PkOr3bHbO3Bm8gALEOrp2LCdaYqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_08,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201280130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This enables sub-page memory charge and allocation.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h     |  4 ++--
 kernel/bpf/core.c       | 17 ++++++++---------
 kernel/bpf/trampoline.c |  6 +++---
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e8ec8d2f2fe3..28ac752f21ba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -838,8 +838,8 @@ void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym);
 void bpf_image_ksym_del(struct bpf_ksym *ksym);
 void bpf_ksym_add(struct bpf_ksym *ksym);
 void bpf_ksym_del(struct bpf_ksym *ksym);
-int bpf_jit_charge_modmem(u32 pages);
-void bpf_jit_uncharge_modmem(u32 pages);
+int bpf_jit_charge_modmem(u32 size);
+void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_prog *prog,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0a1cfd8544b9..d96ad87f0a2c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -833,12 +833,11 @@ static int __init bpf_jit_charge_init(void)
 }
 pure_initcall(bpf_jit_charge_init);
 
-int bpf_jit_charge_modmem(u32 pages)
+int bpf_jit_charge_modmem(u32 size)
 {
-	if (atomic_long_add_return(pages, &bpf_jit_current) >
-	    (bpf_jit_limit >> PAGE_SHIFT)) {
+	if (atomic_long_add_return(size, &bpf_jit_current) > bpf_jit_limit) {
 		if (!bpf_capable()) {
-			atomic_long_sub(pages, &bpf_jit_current);
+			atomic_long_sub(size, &bpf_jit_current);
 			return -EPERM;
 		}
 	}
@@ -846,9 +845,9 @@ int bpf_jit_charge_modmem(u32 pages)
 	return 0;
 }
 
-void bpf_jit_uncharge_modmem(u32 pages)
+void bpf_jit_uncharge_modmem(u32 size)
 {
-	atomic_long_sub(pages, &bpf_jit_current);
+	atomic_long_sub(size, &bpf_jit_current);
 }
 
 void *__weak bpf_jit_alloc_exec(unsigned long size)
@@ -879,11 +878,11 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
 
-	if (bpf_jit_charge_modmem(pages))
+	if (bpf_jit_charge_modmem(size))
 		return NULL;
 	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
-		bpf_jit_uncharge_modmem(pages);
+		bpf_jit_uncharge_modmem(size);
 		return NULL;
 	}
 
@@ -906,7 +905,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 	u32 pages = hdr->pages;
 
 	bpf_jit_free_exec(hdr);
-	bpf_jit_uncharge_modmem(pages);
+	bpf_jit_uncharge_modmem(pages << PAGE_SHIFT);
 }
 
 /* This symbol is only overridden by archs that have different
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 4b6974a195c1..e76a488c09c3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -213,7 +213,7 @@ static void __bpf_tramp_image_put_deferred(struct work_struct *work)
 	im = container_of(work, struct bpf_tramp_image, work);
 	bpf_image_ksym_del(&im->ksym);
 	bpf_jit_free_exec(im->image);
-	bpf_jit_uncharge_modmem(1);
+	bpf_jit_uncharge_modmem(PAGE_SIZE);
 	percpu_ref_exit(&im->pcref);
 	kfree_rcu(im, rcu);
 }
@@ -310,7 +310,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 	if (!im)
 		goto out;
 
-	err = bpf_jit_charge_modmem(1);
+	err = bpf_jit_charge_modmem(PAGE_SIZE);
 	if (err)
 		goto out_free_im;
 
@@ -332,7 +332,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 out_free_image:
 	bpf_jit_free_exec(im->image);
 out_uncharge:
-	bpf_jit_uncharge_modmem(1);
+	bpf_jit_uncharge_modmem(PAGE_SIZE);
 out_free_im:
 	kfree(im);
 out:
-- 
2.30.2

