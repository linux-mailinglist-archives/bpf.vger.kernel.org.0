Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8F5EB072
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIZSsC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Sep 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIZSsB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:48:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E080BCF
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:48:00 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QI9TlL010413
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:47:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jsyqun696-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:47:59 -0700
Received: from twshared17341.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:47:52 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 80929D6AB481; Mon, 26 Sep 2022 11:47:47 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <kernel-team@fb.com>, <haoluo@google.com>, <jlayton@kernel.org>,
        <bjorn@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 2/2] bpf: Enforce W^X for bpf trampoline
Date:   Mon, 26 Sep 2022 11:47:39 -0700
Message-ID: <20220926184739.3512547-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926184739.3512547-1-song@kernel.org>
References: <20220926184739.3512547-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9SgplpeaMzQ5z_aWxfgCZC4qgyBDhojA
X-Proofpoint-GUID: 9SgplpeaMzQ5z_aWxfgCZC4qgyBDhojA
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

Mark the trampoline as RO+X after arch_prepare_bpf_trampoline, so that
the trampoine follows W^X rule strictly. This will turn off warnings like

CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: ...

Also remove bpf_jit_alloc_exec_page(), since it is not used any more.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h     |  1 -
 kernel/bpf/trampoline.c | 22 +++++-----------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9ae155c75014..5161fac0513f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1008,7 +1008,6 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 				struct bpf_prog *to);
 /* Called only from JIT-enabled code, so there's no need for stubs. */
-void *bpf_jit_alloc_exec_page(void);
 void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym);
 void bpf_image_ksym_del(struct bpf_ksym *ksym);
 void bpf_ksym_add(struct bpf_ksym *ksym);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 41b67eb83ab3..6f7b939321d6 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -116,22 +116,6 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
-void *bpf_jit_alloc_exec_page(void)
-{
-	void *image;
-
-	image = bpf_jit_alloc_exec(PAGE_SIZE);
-	if (!image)
-		return NULL;
-
-	set_vm_flush_reset_perms(image);
-	/* Keep image as writeable. The alternative is to keep flipping ro/rw
-	 * every time new program is attached or detached.
-	 */
-	set_memory_x((long)image, 1);
-	return image;
-}
-
 void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym)
 {
 	ksym->start = (unsigned long) data;
@@ -404,9 +388,10 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 		goto out_free_im;
 
 	err = -ENOMEM;
-	im->image = image = bpf_jit_alloc_exec_page();
+	im->image = image = bpf_jit_alloc_exec(PAGE_SIZE);
 	if (!image)
 		goto out_uncharge;
+	set_vm_flush_reset_perms(image);
 
 	err = percpu_ref_init(&im->pcref, __bpf_tramp_image_release, 0, GFP_KERNEL);
 	if (err)
@@ -483,6 +468,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out;
 
+	set_memory_ro((long)im->image, 1);
+	set_memory_x((long)im->image, 1);
+
 	WARN_ON(tr->cur_image && tr->selector == 0);
 	WARN_ON(!tr->cur_image && tr->selector);
 	if (tr->cur_image)
-- 
2.30.2

