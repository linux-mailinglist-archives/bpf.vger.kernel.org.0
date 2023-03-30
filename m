Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B26CFA0E
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 06:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjC3EST convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 30 Mar 2023 00:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjC3ESQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 00:18:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82381BB
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:14 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32U0BEj7004057
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:14 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmyn5s2ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:14 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 21:18:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 013442C67670F; Wed, 29 Mar 2023 21:18:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/8] bpf: simplify logging related error conditions handling
Date:   Wed, 29 Mar 2023 21:16:38 -0700
Message-ID: <20230330041642.1118787-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330041642.1118787-1-andrii@kernel.org>
References: <20230330041642.1118787-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tjisDJ_JZRIwPvDb3O7umngqm-IwEFk4
X-Proofpoint-ORIG-GUID: tjisDJ_JZRIwPvDb3O7umngqm-IwEFk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_16,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move log->level == 0 check into bpf_vlog_truncated() instead of doing it
explicitly. Also remove unnecessary goto in kernel/bpf/verifier.c.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c      | 2 +-
 kernel/bpf/log.c      | 4 +++-
 kernel/bpf/verifier.c | 6 ++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a67b1b669b0c..36e3c25bdca5 100644
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
index 0bcc0c5ce697..a64cc430a9c9 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -167,7 +167,9 @@ static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start, int en
 
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
index 82a5876940aa..efeeafe590b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18787,12 +18787,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
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

