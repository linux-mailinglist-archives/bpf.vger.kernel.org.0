Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EC26DA63A
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbjDFXn3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbjDFXnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336993C5
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:42:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336MW08I013285
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:42:47 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt6y20abf-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:42:46 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:42:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B9DFA2D5BE547; Thu,  6 Apr 2023 16:42:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 14/19] bpf: relax log_buf NULL conditions when log_level>0 is requested
Date:   Thu, 6 Apr 2023 16:42:00 -0700
Message-ID: <20230406234205.323208-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KL4bIgwkbPhsMPPeJUmuJ7SHZAgjgphf
X-Proofpoint-GUID: KL4bIgwkbPhsMPPeJUmuJ7SHZAgjgphf
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

Drop the log_size>0 and log_buf!=NULL condition when log_level>0. This
allows users to request log_true_size of a full log without providing
actual (even if small) log buffer. Verifier log handling code was mostly
ready to handle NULL log->ubuf, so only few small changes were necessary
to prevent NULL log->ubuf from causing problems.

Note, that if user provided NULL log_buf with log_level>0 we don't
consider this a log truncation, and thus won't return -ENOSPC.

We also enforce that either (log_buf==NULL && log_size==0) or
(log_buf!=NULL && log_size>0).

Suggested-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1fae2c5d7ae4..046ddff37a76 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -12,8 +12,17 @@
 
 static bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 {
-	return log->len_total > 0 && log->len_total <= UINT_MAX >> 2 &&
-	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
+	/* ubuf and len_total should both be specified (or not) together */
+	if (!!log->ubuf != !!log->len_total)
+		return false;
+	/* log buf without log_level is meaningless */
+	if (log->ubuf && log->level == 0)
+		return false;
+	if (log->level & ~BPF_LOG_MASK)
+		return false;
+	if (log->len_total > UINT_MAX >> 2)
+		return false;
+	return true;
 }
 
 int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
@@ -89,9 +98,15 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 			new_start = new_end - log->len_total;
 		else
 			new_start = log->start_pos;
+
+		log->start_pos = new_start;
+		log->end_pos = new_end - 1; /* don't count terminating '\0' */
+
+		if (!log->ubuf)
+			return;
+
 		new_n = min(n, log->len_total);
 		cur_pos = new_end - new_n;
-
 		div_u64_rem(cur_pos, log->len_total, &buf_start);
 		div_u64_rem(new_end, log->len_total, &buf_end);
 		/* new_end and buf_end are exclusive indices, so if buf_end is
@@ -101,12 +116,6 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		if (buf_end == 0)
 			buf_end = log->len_total;
 
-		log->start_pos = new_start;
-		log->end_pos = new_end - 1; /* don't count terminating '\0' */
-
-		if (!log->ubuf)
-			return;
-
 		/* if buf_start > buf_end, we wrapped around;
 		 * if buf_start == buf_end, then we fill ubuf completely; we
 		 * can't have buf_start == buf_end to mean that there is
@@ -156,12 +165,15 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 	if (log->end_pos < log->start_pos)
 		log->start_pos = log->end_pos;
 
+	if (!log->ubuf)
+		return;
+
 	if (log->level & BPF_LOG_FIXED)
 		pos = log->end_pos + 1;
 	else
 		div_u64_rem(new_pos, log->len_total, &pos);
 
-	if (log->ubuf && pos < log->len_total && put_user(zero, log->ubuf + pos))
+	if (pos < log->len_total && put_user(zero, log->ubuf + pos))
 		log->ubuf = NULL;
 }
 
@@ -211,11 +223,6 @@ static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start, int en
 	return 0;
 }
 
-static bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
-{
-	return log->len_max > log->len_total;
-}
-
 int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 {
 	u32 sublen;
@@ -228,7 +235,7 @@ int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 	if (!log->ubuf)
 		goto skip_log_rotate;
 	/* If we never truncated log, there is nothing to move around. */
-	if ((log->level & BPF_LOG_FIXED) || log->start_pos == 0)
+	if (log->start_pos == 0)
 		goto skip_log_rotate;
 
 	/* Otherwise we need to rotate log contents to make it start from the
@@ -283,7 +290,8 @@ int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 	if (!!log->ubuf != !!log->len_total)
 		return -EFAULT;
 
-	if (bpf_vlog_truncated(log))
+	/* did truncation actually happen? */
+	if (log->ubuf && log->len_max > log->len_total)
 		return -ENOSPC;
 
 	return 0;
-- 
2.34.1

