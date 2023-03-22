Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07F6C5A4B
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 00:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCVXZ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Mar 2023 19:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCVXZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 19:25:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51AD310
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:25:25 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32MNK6Oa010096
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:25:24 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3pg28av3vq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:25:24 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Mar 2023 16:25:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B8E832B939820; Wed, 22 Mar 2023 16:25:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH bpf-next] bpf: remember meta->iter info only for initialized iters
Date:   Wed, 22 Mar 2023 16:25:02 -0700
Message-ID: <20230322232502.836171-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wcYBByJFNCVLf4KDKy47Y-P4fMH9BSjo
X-Proofpoint-ORIG-GUID: wcYBByJFNCVLf4KDKy47Y-P4fMH9BSjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_18,2023-03-22_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For iter_new() functions iterator state's slot might not be yet
initialized, in which case iter_get_spi() will return -ERANGE. This is
expected and is handled properly. But for iter_next() and iter_destroy()
cases iter slot is supposed to be initialized and correct, so -ERANGE is
not possible.

Move meta->iter.{spi,frameno} initialization into iter_next/iter_destroy
handling branch to make it more explicit that valid information will be
remembered in meta->iter block for subsequent use in process_iter_next_call(),
avoiding confusingly looking -ERANGE assignment for meta->iter.spi.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50c995697f0e..b3d3db5058e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6778,13 +6778,6 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	t = btf_type_skip_modifiers(meta->btf, t->type, &btf_id);	/* STRUCT */
 	nr_slots = t->size / BPF_REG_SIZE;
 
-	spi = iter_get_spi(env, reg, nr_slots);
-	if (spi < 0 && spi != -ERANGE)
-		return spi;
-
-	meta->iter.spi = spi;
-	meta->iter.frameno = reg->frameno;
-
 	if (is_iter_new_kfunc(meta)) {
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
@@ -6811,10 +6804,17 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 			return -EINVAL;
 		}
 
+		spi = iter_get_spi(env, reg, nr_slots);
+		if (spi < 0)
+			return spi;
+
 		err = mark_iter_read(env, reg, spi, nr_slots);
 		if (err)
 			return err;
 
+		/* remember meta->iter info for process_iter_next_call() */
+		meta->iter.spi = spi;
+		meta->iter.frameno = reg->frameno;
 		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
 
 		if (is_iter_destroy_kfunc(meta)) {
-- 
2.34.1

