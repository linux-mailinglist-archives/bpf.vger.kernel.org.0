Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4D3D4F1E
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGYQ62 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 25 Jul 2021 12:58:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhGYQ62 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 12:58:28 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16PHXZCo007534
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:38:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0j67w5tt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:38:58 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 10:38:57 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0BB8F3D405AD; Sun, 25 Jul 2021 10:38:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a function
Date:   Sun, 25 Jul 2021 10:38:32 -0700
Message-ID: <20210725173845.2593626-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725173845.2593626-1-andrii@kernel.org>
References: <20210725173845.2593626-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lgEQzzMHY-6NlWLt_8e7e8JKykmvESYC
X-Proofpoint-GUID: lgEQzzMHY-6NlWLt_8e7e8JKykmvESYC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_05:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=940 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107250126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turn BPF_PROG_RUN into a proper always inlined function. No functional and
performance changes are intended, but it makes it much easier to understand
what's going on with how BPF programs are actually get executed. It's more
obvious what types and callbacks are expected. Also extra () around input
parameters can be dropped, as well as `__` variable prefixes intended to avoid
naming collisions, which makes the code simpler to read and write.

This refactoring also highlighted one possible issue. BPF_PROG_RUN is both
a macro and an enum value (BPF_PROG_RUN == BPF_PROG_TEST_RUN). Turning
BPF_PROG_RUN into a function causes naming conflict compilation error. So
rename BPF_PROG_RUN into lower-case bpf_prog_run(), similar to
bpf_prog_run_xdp(), bpf_prog_run_pin_on_cpu(), etc. To avoid unnecessary code
churn across many networking calls to BPF_PROG_RUN, #define BPF_PROG_RUN as an
alias to bpf_prog_run.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/filter.h | 58 +++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index ba36989f711a..e59c97c72233 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -585,25 +585,41 @@ struct sk_filter {
 
 DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
-#define __BPF_PROG_RUN(prog, ctx, dfunc)	({			\
-	u32 __ret;							\
-	cant_migrate();							\
-	if (static_branch_unlikely(&bpf_stats_enabled_key)) {		\
-		struct bpf_prog_stats *__stats;				\
-		u64 __start = sched_clock();				\
-		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
-		__stats = this_cpu_ptr(prog->stats);			\
-		u64_stats_update_begin(&__stats->syncp);		\
-		__stats->cnt++;						\
-		__stats->nsecs += sched_clock() - __start;		\
-		u64_stats_update_end(&__stats->syncp);			\
-	} else {							\
-		__ret = dfunc(ctx, (prog)->insnsi, (prog)->bpf_func);	\
-	}								\
-	__ret; })
-
-#define BPF_PROG_RUN(prog, ctx)						\
-	__BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func)
+typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
+					  const struct bpf_insn *insnsi,
+					  unsigned int (*bpf_func)(const void *,
+								   const struct bpf_insn *));
+
+static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
+					  const void *ctx,
+					  bpf_dispatcher_fn dfunc)
+{
+	u32 ret;
+
+	cant_migrate();
+	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
+		struct bpf_prog_stats *stats;
+		u64 start = sched_clock();
+
+		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		stats = this_cpu_ptr(prog->stats);
+		u64_stats_update_begin(&stats->syncp);
+		stats->cnt++;
+		stats->nsecs += sched_clock() - start;
+		u64_stats_update_end(&stats->syncp);
+	} else {
+		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+	}
+	return ret;
+}
+
+static __always_inline u32 bpf_prog_run(const struct bpf_prog *prog, const void *ctx)
+{
+	return __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
+}
+
+/* avoids name conflict with BPF_PROG_RUN enum definedi uapi/linux/bpf.h */
+#define BPF_PROG_RUN bpf_prog_run
 
 /*
  * Use in preemptible and therefore migratable context to make sure that
@@ -622,7 +638,7 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 	u32 ret;
 
 	migrate_disable();
-	ret = __BPF_PROG_RUN(prog, ctx, bpf_dispatcher_nop_func);
+	ret = __bpf_prog_run(prog, ctx, bpf_dispatcher_nop_func);
 	migrate_enable();
 	return ret;
 }
@@ -768,7 +784,7 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	return __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
 }
 
 void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
-- 
2.30.2

