Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FCA4A5736
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 07:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiBAGbG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 1 Feb 2022 01:31:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234097AbiBAGbF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 01:31:05 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21111OFv008600
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:31:05 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxer3x19t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 22:31:05 -0800
Received: from twshared7500.02.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 22:31:04 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D8201290EC8E9; Mon, 31 Jan 2022 22:28:13 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <peterz@infradead.org>, <x86@kernel.org>,
        <iii@linux.ibm.com>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v8 bpf-next 2/9] bpf: use bytes instead of pages for bpf_jit_[charge|uncharge]_modmem
Date:   Mon, 31 Jan 2022 22:27:56 -0800
Message-ID: <20220201062803.2675204-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201062803.2675204-1-song@kernel.org>
References: <20220201062803.2675204-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2QjCq0CvizL7vIt1GRtUVoZw_F5P4_GM
X-Proofpoint-ORIG-GUID: 2QjCq0CvizL7vIt1GRtUVoZw_F5P4_GM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_02,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010033
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
index 6eb0b180d33b..366f88afd56b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -846,8 +846,8 @@ void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym);
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
index 04a8d5bea552..6ca0550c4b24 100644
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

