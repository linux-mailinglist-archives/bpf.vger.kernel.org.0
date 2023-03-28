Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965936CCE54
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 01:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjC1X5B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Mar 2023 19:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjC1X46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70340CB
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:34 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SLaPFn010199
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pm89s0prm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:30 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Mar 2023 16:56:30 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 99ECC2C40039D; Tue, 28 Mar 2023 16:56:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 3/6] bpf: switch BPF verifier log to be a rotating log by default
Date:   Tue, 28 Mar 2023 16:56:06 -0700
Message-ID: <20230328235610.3159943-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328235610.3159943-1-andrii@kernel.org>
References: <20230328235610.3159943-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MxabP8w498AyPecdpm_6BtxiaGnAz8J4
X-Proofpoint-GUID: MxabP8w498AyPecdpm_6BtxiaGnAz8J4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, if user-supplied log buffer to collect BPF verifier log turns
out to be too small to contain full log, bpf() syscall returns -ENOSPC,
fails BPF program verification/load, and preserves first N-1 bytes of
the verifier log (where N is the size of user-supplied buffer).

This is problematic in a bunch of common scenarios, especially when
working with real-world BPF programs that tend to be pretty complex as
far as verification goes and require big log buffers. Typically, it's
when debugging tricky cases at log level 2 (verbose). Also, when BPF program
is successfully validated, log level 2 is the only way to actually see
verifier state progression and all the important details.

Even with log level 1, it's possible to get -ENOSPC even if the final
verifier log fits in log buffer, if there is a code path that's deep
enough to fill up entire log, even if normally it would be reset later
on (there is a logic to chop off successfully validated portions of BPF
verifier log).

In short, it's not always possible to pre-size log buffer. Also, what's
worse, in practice, the end of the log most often is way more important
than the beginning, but verifier stops emitting log as soon as initial
log buffer is filled up.

This patch switches BPF verifier log behavior to effectively behave as
rotating log. That is, if user-supplied log buffer turns out to be too
short, verifier will keep overwriting previously written log,
effectively treating user's log buffer as a ring buffer. -ENOSPC is
still going to be returned at the end, to notify user that log contents
was truncated, but the important last N bytes of the log would be
returned, which might be all that user really needs. This consistent
-ENOSPC behavior, regardless of rotating or fixed log behavior, allows
to prevent backwards compatibility breakage. The only user-visible
change is which portion of verifier log user ends up seeing *if buffer
is too small*. Given contents of verifier log itself is not an ABI,
there is no breakage due to this behavior change. Specialized tools that
rely on specific contents of verifier log in -ENOSPC scenario are
expected to be easily adapted to accommodate old and new behaviors.

Importantly, though, to preserve good user experience and not require
every user-space application to adopt to this new behavior, before
exiting to user-space verifier will rotate log (in place) to make it
start at the very beginning of user buffer as a continuous
zero-terminated string. The contents will be a chopped off N-1 last
bytes of full verifier log, of course.

Given beginning of log is sometimes important as well, we add
BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
tools like veristat to request first part of verifier log, if necessary.
BPF_LOG_FIXED flag is also a simple and straightforward way to check if
BPF verifier supports rotating behavior.

On the implementation side, conceptually, it's all simple. We maintain
64-bit logical start and end positions. If we need to truncate the log,
start position will be adjusted accordingly to lag end position by
N bytes. We then use those logical positions to calculate their matching
actual positions in user buffer and handle wrap around the end of the
buffer properly. Finally, right before returning from bpf_check(), we
rotate user log buffer contents in-place as necessary, to make log
contents contiguous. See comments in relevant functions for details.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h                  |  33 ++-
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/log.c                              | 195 +++++++++++++++++-
 kernel/bpf/verifier.c                         |  19 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
 5 files changed, 225 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 83dff25545ee..4c926227f612 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -491,25 +491,42 @@ struct bpf_insn_aux_data {
 #define BPF_VERIFIER_TMP_LOG_SIZE	1024
 
 struct bpf_verifier_log {
-	u32 level;
-	char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
+	/* Logical start and end positions of a "log window" of the verifier log.
+	 * start_pos == 0 means we haven't truncated anything.
+	 * Once truncation starts to happen, start_pos + len_total == end_pos,
+	 * except during log reset situations, in which (end_pos - start_pos)
+	 * might get smaller than len_total (see bpf_vlog_reset()).
+	 * Generally, (end_pos - start_pos) gives number of useful data in
+	 * user log buffer.
+	 */
+	u64 start_pos;
+	u64 end_pos;
 	char __user *ubuf;
-	u32 len_used;
+	u32 level;
 	u32 len_total;
+	char kbuf[BPF_VERIFIER_TMP_LOG_SIZE];
 };
 
 #define BPF_LOG_LEVEL1	1
 #define BPF_LOG_LEVEL2	2
 #define BPF_LOG_STATS	4
+#define BPF_LOG_FIXED	8
 #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
-#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS)
+#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED)
 #define BPF_LOG_KERNEL	(BPF_LOG_MASK + 1) /* kernel internal flag */
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U
 
+static inline u32 bpf_log_used(const struct bpf_verifier_log *log)
+{
+	return log->end_pos - log->start_pos;
+}
+
 static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
 {
-	return log->len_used >= log->len_total - 1;
+	if (log->level & BPF_LOG_FIXED)
+		return bpf_log_used(log) >= log->len_total - 1;
+	return false;
 }
 
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
@@ -596,7 +613,7 @@ struct bpf_verifier_env {
 	u32 scratched_regs;
 	/* Same as scratched_regs but for stack slots */
 	u64 scratched_stack_slots;
-	u32 prev_log_len, prev_insn_print_len;
+	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used in reg_type_str() to generate reg_type string */
 	char type_str_buf[TYPE_STR_BUF_LEN];
 };
@@ -608,7 +625,9 @@ __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
-void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos);
+void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos);
+void bpf_vlog_finalize(struct bpf_verifier_log *log);
+bool bpf_vlog_truncated(const struct bpf_verifier_log *log);
 
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b7e5a5510b91..2574cc9b3e28 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5593,7 +5593,8 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 		}
 	}
 
-	if (log->level && bpf_verifier_log_full(log)) {
+	bpf_vlog_finalize(log);
+	if (log->level && bpf_vlog_truncated(log)) {
 		err = -ENOSPC;
 		goto errout_meta;
 	}
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1974891fc324..beab7c7f52a7 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/math64.h>
 
 bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
 {
@@ -32,23 +33,199 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 		return;
 	}
 
-	n = min(log->len_total - log->len_used - 1, n);
-	log->kbuf[n] = '\0';
-	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
-		log->len_used += n;
-	else
-		log->ubuf = NULL;
+	if (log->level & BPF_LOG_FIXED) {
+		n = min(log->len_total - bpf_log_used(log) - 1, n);
+		log->kbuf[n] = '\0';
+		n += 1;
+
+		if (copy_to_user(log->ubuf + log->end_pos, log->kbuf, n))
+			goto fail;
+
+		log->end_pos += n - 1; /* don't count terminating '\0' */
+	} else {
+		u64 new_end, new_start, cur_pos;
+		u32 buf_start, buf_end, new_n;
+
+		log->kbuf[n] = '\0';
+		n += 1;
+
+		new_end = log->end_pos + n;
+		if (new_end - log->start_pos >= log->len_total)
+			new_start = new_end - log->len_total;
+		else
+			new_start = log->start_pos;
+		new_n = min(n, log->len_total);
+		cur_pos = new_end - new_n;
+
+		div_u64_rem(cur_pos, log->len_total, &buf_start);
+		div_u64_rem(new_end, log->len_total, &buf_end);
+		/* new_end and buf_end are exclusive indices, so if buf_end is
+		 * exactly zero, then it actually points right to the end of
+		 * ubuf and there is no wrap around
+		 */
+		if (buf_end == 0)
+			buf_end = log->len_total;
+
+		/* if buf_start > buf_end, we wrapped around;
+		 * if buf_start == buf_end, then we fill ubuf completely; we
+		 * can't have buf_start == buf_end to mean that there is
+		 * nothing to write, because we always write at least
+		 * something, even if terminal '\0'
+		 */
+		if (buf_start < buf_end) {
+			/* message fits within contiguous chunk of ubuf */
+			if (copy_to_user(log->ubuf + buf_start,
+					 log->kbuf + n - new_n,
+					 buf_end - buf_start))
+				goto fail;
+		} else {
+			/* message wraps around the end of ubuf, copy in two chunks */
+			if (copy_to_user(log->ubuf + buf_start,
+					 log->kbuf + n - new_n,
+					 log->len_total - buf_start))
+				goto fail;
+			if (copy_to_user(log->ubuf,
+					 log->kbuf + n - buf_end,
+					 buf_end))
+				goto fail;
+		}
+
+		log->start_pos = new_start;
+		log->end_pos = new_end - 1; /* don't count terminating '\0' */
+	}
+
+	return;
+fail:
+	log->ubuf = NULL;
 }
 
-void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
+void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 {
 	char zero = 0;
+	u32 pos;
 
 	if (!bpf_verifier_log_needed(log))
 		return;
 
-	log->len_used = new_pos;
-	if (put_user(zero, log->ubuf + new_pos))
+	/* if position to which we reset is beyond current log window,
+	 * then we didn't preserve any useful content and should adjust
+	 * start_pos to end up with an empty log (start_pos == end_pos)
+	 */
+	log->end_pos = new_pos;
+	if (log->end_pos < log->start_pos)
+		log->start_pos = log->end_pos;
+	div_u64_rem(new_pos, log->len_total, &pos);
+	if (put_user(zero, log->ubuf + pos))
+		log->ubuf = NULL;
+}
+
+static void bpf_vlog_reverse_kbuf(char *buf, int len)
+{
+	int i, j;
+
+	for (i = 0, j = len - 1; i < j; i++, j--)
+		swap(buf[i], buf[j]);
+}
+
+static int bpf_vlog_reverse_ubuf(struct bpf_verifier_log *log, int start, int end)
+{
+	/* we split log->kbuf into two equal parts for both ends of array */
+	int n = sizeof(log->kbuf) / 2, nn;
+	char *lbuf = log->kbuf, *rbuf = log->kbuf + n;
+
+	/* Read ubuf's section [start, end) two chunks at a time, from left
+	 * and right side; within each chunk, swap all the bytes; after that
+	 * reverse the order of lbuf and rbuf and write result back to ubuf.
+	 * This way we'll end up with swapped contents of specified
+	 * [start, end) ubuf segment.
+	 */
+	while (end - start > 1) {
+		nn = min(n, (end - start ) / 2);
+
+		if (copy_from_user(lbuf, log->ubuf + start, nn))
+			return -EFAULT;
+		if (copy_from_user(rbuf, log->ubuf + end - nn, nn))
+			return -EFAULT;
+
+		bpf_vlog_reverse_kbuf(lbuf, nn);
+		bpf_vlog_reverse_kbuf(rbuf, nn);
+
+		/* we write lbuf to the right end of ubuf, while rbuf to the
+		 * left one to end up with properly reversed overall ubuf
+		 */
+		if (copy_to_user(log->ubuf + start, rbuf, nn))
+			return -EFAULT;
+		if (copy_to_user(log->ubuf + end - nn, lbuf, nn))
+			return -EFAULT;
+
+		start += nn;
+		end -= nn;
+	}
+
+	return 0;
+}
+
+bool bpf_vlog_truncated(const struct bpf_verifier_log *log)
+{
+	if (log->level & BPF_LOG_FIXED)
+		return bpf_log_used(log) >= log->len_total - 1;
+	else
+		return log->start_pos > 0;
+}
+
+void bpf_vlog_finalize(struct bpf_verifier_log *log)
+{
+	u32 sublen;
+	int err;
+
+	if (!log || !log->level || !log->ubuf)
+		return;
+	if ((log->level & BPF_LOG_FIXED) || log->level == BPF_LOG_KERNEL)
+		return;
+
+	/* If we never truncated log, there is nothing to move around. */
+	if (log->start_pos == 0)
+		return;
+
+	/* Otherwise we need to rotate log contents to make it start from the
+	 * buffer beginning and be a continuous zero-terminated string. Note
+	 * that if log->start_pos != 0 then we definitely filled up entire log
+	 * buffer with no gaps, and we just need to shift buffer contents to
+	 * the left by (log->start_pos % log->len_total) bytes.
+	 *
+	 * Unfortunately, user buffer could be huge and we don't want to
+	 * allocate temporary kernel memory of the same size just to shift
+	 * contents in a straightforward fashion. Instead, we'll be clever and
+	 * do in-place array rotation. This is a leetcode-style problem, which
+	 * could be solved by three rotations.
+	 *
+	 * Let's say we have log buffer that has to be shifted left by 7 bytes
+	 * (spaces and vertical bar is just for demonstrative purposes):
+	 *   E F G H I J K | A B C D
+	 *
+	 * First, we reverse entire array:
+	 *   D C B A | K J I H G F E
+	 *
+	 * Then we rotate first 4 bytes (DCBA) and separately last 7 bytes
+	 * (KJIHGFE), resulting in a properly rotated array:
+	 *   A B C D | E F G H I J K
+	 *
+	 * We'll utilize log->kbuf to read user memory chunk by chunk, swap
+	 * bytes, and write them back. Doing it byte-by-byte would be
+	 * unnecessarily inefficient. Altogether we are going to read and
+	 * write each byte twice.
+	 */
+
+	/* length of the chopped off part that will be the beginning;
+	 * len(ABCD) in the example above
+	 */
+	div_u64_rem(log->start_pos, log->len_total, &sublen);
+	sublen = log->len_total - sublen;
+
+	err = bpf_vlog_reverse_ubuf(log, 0, log->len_total);
+	err = err ?: bpf_vlog_reverse_ubuf(log, 0, sublen);
+	err = err ?: bpf_vlog_reverse_ubuf(log, sublen, log->len_total);
+	if (err)
 		log->ubuf = NULL;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9028a40107c4..e121c6c13635 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1439,10 +1439,10 @@ static inline u32 vlog_alignment(u32 pos)
 static void print_insn_state(struct bpf_verifier_env *env,
 			     const struct bpf_func_state *state)
 {
-	if (env->prev_log_len && env->prev_log_len == env->log.len_used) {
+	if (env->prev_log_pos && env->prev_log_pos == env->log.end_pos) {
 		/* remove new line character */
-		bpf_vlog_reset(&env->log, env->prev_log_len - 1);
-		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_len), ' ');
+		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
+		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_pos), ' ');
 	} else {
 		verbose(env, "%d:", env->insn_idx);
 	}
@@ -1750,7 +1750,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
-	elem->log_pos = env->log.len_used;
+	elem->log_pos = env->log.end_pos;
 	env->head = elem;
 	env->stack_size++;
 	err = copy_verifier_state(&elem->st, cur);
@@ -2286,7 +2286,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
-	elem->log_pos = env->log.len_used;
+	elem->log_pos = env->log.end_pos;
 	env->head = elem;
 	env->stack_size++;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
@@ -15564,11 +15564,11 @@ static int do_check(struct bpf_verifier_env *env)
 				print_insn_state(env, state->frame[state->curframe]);
 
 			verbose_linfo(env, env->insn_idx, "; ");
-			env->prev_log_len = env->log.len_used;
+			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
 			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
-			env->prev_insn_print_len = env->log.len_used - env->prev_log_len;
-			env->prev_log_len = env->log.len_used;
+			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
+			env->prev_log_pos = env->log.end_pos;
 		}
 
 		if (bpf_prog_is_offloaded(env->prog->aux)) {
@@ -18786,7 +18786,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	print_verification_stats(env);
 	env->prog->aux->verified_insns = env->insn_processed;
 
-	if (log->level && bpf_verifier_log_full(log))
+	bpf_vlog_finalize(log);
+	if (log->level && bpf_vlog_truncated(log))
 		ret = -ENOSPC;
 	if (log->level && !log->ubuf) {
 		ret = -EFAULT;
diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
index 239e1c5753b0..bc27170bdeb0 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -24,6 +24,7 @@ static void bad_core_relo(size_t log_buf_size, enum trunc_type trunc_type)
 	bpf_program__set_autoload(skel->progs.bad_relo, true);
 	memset(log_buf, 0, sizeof(log_buf));
 	bpf_program__set_log_buf(skel->progs.bad_relo, log_buf, log_buf_size ?: sizeof(log_buf));
+	bpf_program__set_log_level(skel->progs.bad_relo, 1 | 8); /* BPF_LOG_FIXED to force truncation */
 
 	err = test_log_fixup__load(skel);
 	if (!ASSERT_ERR(err, "load_fail"))
-- 
2.34.1

