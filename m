Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B26D579A
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDDEhy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjDDEht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:37:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811E1FFA
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:37:47 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33449kEU006408
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:37:47 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3prcme0343-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:37:46 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 86FA02D051A3B; Mon,  3 Apr 2023 21:37:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when log_level>0 is requested
Date:   Mon, 3 Apr 2023 21:36:54 -0700
Message-ID: <20230404043659.2282536-15-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _ExHI_AxUgt9NhwevQtXQVDSs4mXXkAN
X-Proofpoint-GUID: _ExHI_AxUgt9NhwevQtXQVDSs4mXXkAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop the log_size>0 and log_buf!=NULL condition when log_level>0. This
allows users to request log_size_actual of a full log without providing
actual (even if small) log buffer. Verifier log handling code was mostly ready to handle NULL log->ubuf, so only few small changes were necessary to prevent NULL log->ubuf from causing problems.

Note, that user is basically guaranteed to receive -ENOSPC when
providing log_level>0 and log_buf==NULL. We also still enforce that
either (log_buf==NULL && log_size==0) or (log_buf!=NULL && log_size>0).

Suggested-by: Lorenz Bauer <lmb@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1198b6ad235a..ab8149448724 100644
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
@@ -64,15 +73,15 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 	}
 
 	n += 1; /* include terminating zero */
+	bpf_vlog_update_len_max(log, n);
+
 	if (log->level & BPF_LOG_FIXED) {
 		/* check if we have at least something to put into user buf */
 		new_n = 0;
-		if (log->end_pos < log->len_total - 1) {
+		if (log->end_pos + 1 < log->len_total) {
 			new_n = min_t(u32, log->len_total - log->end_pos, n);
 			log->kbuf[new_n - 1] = '\0';
 		}
-
-		bpf_vlog_update_len_max(log, n);
 		cur_pos = log->end_pos;
 		log->end_pos += n - 1; /* don't count terminating '\0' */
 
@@ -84,16 +93,21 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		u32 buf_start, buf_end, new_n;
 
 		log->kbuf[n - 1] = '\0';
-		bpf_vlog_update_len_max(log, n);
 
 		new_end = log->end_pos + n;
 		if (new_end - log->start_pos >= log->len_total)
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
@@ -103,12 +117,6 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
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
@@ -155,12 +163,15 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
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
 
-- 
2.34.1

