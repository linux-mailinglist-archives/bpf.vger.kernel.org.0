Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6FB6D5798
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjDDEhj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjDDEhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:37:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED041FEF
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:37:36 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NLWe7030368
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:37:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pr0m74kqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:37:35 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5BC602D0519E0; Mon,  3 Apr 2023 21:37:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 11/19] bpf: keep track of total log content size in both fixed and rolling modes
Date:   Mon, 3 Apr 2023 21:36:51 -0700
Message-ID: <20230404043659.2282536-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zd9vFnAQ8GctoxWncDh0IGC-2auJ7NfY
X-Proofpoint-ORIG-GUID: zd9vFnAQ8GctoxWncDh0IGC-2auJ7NfY
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

Change how we do accounting in BPF_LOG_FIXED mode and adopt log->end_pos
as *logical* log position. This means that we can go beyond physical log
buffer size now and be able to tell what log buffer size should be to
fit entire log contents without -ENOSPC.

To do this for BPF_LOG_FIXED mode, we need to remove a short-circuiting
logic of not vsnprintf()'ing further log content once we filled up
user-provided buffer, which is done by bpf_verifier_log_needed() checks.
We modify these checks to always keep going if log->level is non-zero
(i.e., log is requested), even if log->ubuf was NULL'ed out due to
copying data to user-space, or if entire log buffer is physically full.
We adopt bpf_verifier_vlog() routine to work correctly with
log->ubuf == NULL condition, performing log formatting into temporary
kernel buffer, doing all the necessary accounting, but just avoiding
copying data out if buffer is full or NULL'ed out.

With these changes, it's now possible to do this sort of determination of
log contents size in both BPF_LOG_FIXED and default rolling log mode.
We need to keep in mind bpf_vlog_reset(), though, which shrinks log
contents after successful verification of a particular code path. This
log reset means that log->end_pos isn't always increasing, so to return
back to users what should be the log buffer size to fit all log content
without causing -ENOSPC even in the presenec of log resetting, we need
to keep maximum over "lifetime" of logging. We do this accounting in
bpf_vlog_update_len_max() helper.

A related and subtle aspect is that with this logical log->end_pos even in
BPF_LOG_FIXED mode we could temporary "overflow" buffer, but then reset
it back with bpf_vlog_reset() to a position inside user-supplied
log_buf. In such situation we still want to properly maintain
terminating zero. We will eventually return -ENOSPC even if final log
buffer is small (we detect this through log->len_max check). This
behavior is simpler to reason about and is consistent with current
behavior of verifier log. Handling of this required a small addition to
bpf_vlog_reset() logic to avoid doing put_user() beyond physical log
buffer dimensions.

Another issue to keep in mind is that we limit log buffer size to 32-bit
value and keep such log length as u32, but theoretically verifier could
produce huge log stretching beyond 4GB. Instead of keeping (and later
returning) 64-bit log length, we cap it at UINT_MAX. Current UAPI makes
it impossible to specify log buffer size bigger than 4GB anyways, so we
don't really loose anything here and keep everything consistently 32-bit
in UAPI. This property will be utilized in next patch.

Doing the same determination of maximum log buffer for rolling mode is
trivial, as log->end_pos and log->start_pos are already logical
positions, so there is nothing new there.

These changes do incidentally fix one small issue with previous logging
logic. Previously, if use provided log buffer of size N, and actual log
output was exactly N-1 bytes + terminating \0, kernel logic coun't
distinguish this condition from log truncation scenario which would end
up with truncated log contents of N-1 bytes + terminating \0 as well.

But now with log->end_pos being logical position that could go beyond
actual log buffer size, we can distinguish these two conditions, which
we do in this patch. This plays nicely with returning log_size_actual
(implemented in UAPI in the next patch), as we can now guarantee that if
user takes such log_size_actual and provides log buffer of that exact
size, they will not get -ENOSPC in return.

All in all, all these changes do conceptually unify fixed and rolling
log modes much better, and allow a nice feature requested by users:
knowing what should be the size of the buffer to avoid -ENOSPC.

We'll plumb this through the UAPI and the code in the next patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 12 ++-----
 kernel/bpf/log.c             | 68 +++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4c926227f612..98d2eb382dbb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -504,6 +504,7 @@ struct bpf_verifier_log {
 	char __user *ubuf;
 	u32 level;
 	u32 len_total;
+	u32 len_max;
 	char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
 };
 
@@ -517,23 +518,16 @@ struct bpf_verifier_log {
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U
 
-static inline u32 bpf_log_used(const struct bpf_verifier_log *log)
-{
-	return log->end_pos - log->start_pos;
-}
-
 static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
 {
 	if (log->level & BPF_LOG_FIXED)
-		return bpf_log_used(log) >= log->len_total - 1;
+		return log->end_pos >= log->len_total;
 	return false;
 }
 
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 {
-	return log &&
-		((log->level && log->ubuf && !bpf_verifier_log_full(log)) ||
-		 log->level == BPF_LOG_KERNEL);
+	return log && log->level;
 }
 
 #define BPF_MAX_SUBPROGS 256
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 14dc4d90adbe..acfe8f5d340a 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -16,10 +16,26 @@ bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
 }
 
+static void bpf_vlog_update_len_max(struct bpf_verifier_log *log, u32 add_len)
+{
+	/* add_len includes terminal \0, so no need for +1. */
+	u64 len = log->end_pos + add_len;
+
+	/* log->len_max could be larger than our current len due to
+	 * bpf_vlog_reset() calls, so we maintain the max of any length at any
+	 * previous point
+	 */
+	if (len > UINT_MAX)
+		log->len_max = UINT_MAX;
+	else if (len > log->len_max)
+		log->len_max = len;
+}
+
 void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		       va_list args)
 {
-	unsigned int n;
+	u64 cur_pos;
+	u32 new_n, n;
 
 	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
 
@@ -33,21 +49,28 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		return;
 	}
 
+	n += 1; /* include terminating zero */
 	if (log->level & BPF_LOG_FIXED) {
-		n = min(log->len_total - bpf_log_used(log) - 1, n);
-		log->kbuf[n] = '\0';
-		n += 1;
-
-		if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n))
-			goto fail;
+		/* check if we have at least something to put into user buf */
+		new_n = 0;
+		if (log->end_pos < log->len_total - 1) {
+			new_n = min_t(u32, log->len_total - log->end_pos, n);
+			log->kbuf[new_n - 1] = '\0';
+		}
 
+		bpf_vlog_update_len_max(log, n);
+		cur_pos = log->end_pos;
 		log->end_pos += n - 1; /* don't count terminating '\0' */
+
+		if (log->ubuf && new_n &&
+		    copy_to_user(log->ubuf + cur_pos, log->kbuf, new_n))
+			goto fail;
 	} else {
-		u64 new_end, new_start, cur_pos;
+		u64 new_end, new_start;
 		u32 buf_start, buf_end, new_n;
 
-		log->kbuf[n] = '\0';
-		n += 1;
+		log->kbuf[n - 1] = '\0';
+		bpf_vlog_update_len_max(log, n);
 
 		new_end = log->end_pos + n;
 		if (new_end - log->start_pos >= log->len_total)
@@ -66,6 +89,12 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		if (buf_end == 0)
 			buf_end = log->len_total;
 
+		log->start_pos = new_start;
+		log->end_pos = new_end - 1; /* don't count terminating '\0' */
+
+		if (!log->ubuf)
+			return;
+
 		/* if buf_start > buf_end, we wrapped around;
 		 * if buf_start == buf_end, then we fill ubuf completely; we
 		 * can't have buf_start == buf_end to mean that there is
@@ -89,9 +118,6 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 					 buf_end))
 				goto fail;
 		}
-
-		log->start_pos = new_start;
-		log->end_pos = new_end - 1; /* don't count terminating '\0' */
 	}
 
 	return;
@@ -114,8 +140,13 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 	log->end_pos = new_pos;
 	if (log->end_pos < log->start_pos)
 		log->start_pos = log->end_pos;
-	div_u64_rem(new_pos, log->len_total, &pos);
-	if (put_user(zero, log->ubuf + pos))
+
+	if (log->level & BPF_LOG_FIXED)
+		pos = log->end_pos + 1;
+	else
+		div_u64_rem(new_pos, log->len_total, &pos);
+
+	if (log->ubuf && pos < log->len_total && put_user(zero, log->ubuf + pos))
 		log->ubuf = NULL;
 }
 
@@ -167,12 +198,7 @@ static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start, int en
 
 bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
 {
-	if (!log->level)
-		return false;
-	else if (log->level & BPF_LOG_FIXED)
-		return bpf_log_used(log) >= log->len_total - 1;
-	else
-		return log->start_pos > 0;
+	return log->len_max > log->len_total;
 }
 
 void bpf_vlog_finalize(struct bpf_verifier_log *log)
-- 
2.34.1

