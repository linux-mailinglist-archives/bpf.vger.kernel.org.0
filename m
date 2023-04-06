Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088446DA647
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjDFXo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbjDFXnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1253BB97
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:43:03 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336LRnhv020297
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:43:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3psfmg8yjs-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:43:02 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:39 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id ACF202D5BE3EE; Thu,  6 Apr 2023 16:42:27 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 10/19] bpf: simplify logging-related error conditions handling
Date:   Thu, 6 Apr 2023 16:41:56 -0700
Message-ID: <20230406234205.323208-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qqSqMQkQz0BCrb8o1v-Bv8A0X3BCEoxc
X-Proofpoint-ORIG-GUID: qqSqMQkQz0BCrb8o1v-Bv8A0X3BCEoxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_13,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move log->level == 0 check into bpf_vlog_truncated() instead of doing it
explicitly. Also remove unnecessary goto in kernel/bpf/verifier.c.

Acked-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c      | 2 +-
 kernel/bpf/log.c      | 4 +++-
 kernel/bpf/verifier.c | 6 ++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6372c144a294..5aa540ee611f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5594,7 +5594,7 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	}
 
 	bpf_vlog_finalize(log);
-	if (log->level && bpf_vlog_truncated(log)) {
+	if (bpf_vlog_truncated(log)) {
 		err = -ENOSPC;
 		goto errout_meta;
 	}
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index d99a50f07187..c778f3b290cb 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -169,7 +169,9 @@ static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start, int en
 
 bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
 {
-	if (log->level & BPF_LOG_FIXED)
+	if (!log->level)
+		return false;
+	else if (log->level & BPF_LOG_FIXED)
 		return bpf_log_used(log) >= log->len_total - 1;
 	else
 		return log->start_pos > 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52fb5216f44c..392b821bb27c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18841,12 +18841,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	env->prog->aux->verified_insns = env->insn_processed;
 
 	bpf_vlog_finalize(log);
-	if (log->level && bpf_vlog_truncated(log))
+	if (bpf_vlog_truncated(log))
 		ret = -ENOSPC;
-	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf) {
+	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf)
 		ret = -EFAULT;
-		goto err_release_maps;
-	}
 
 	if (ret)
 		goto err_release_maps;
-- 
2.34.1

