Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73403D6185
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhGZPcN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Jul 2021 11:32:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48443 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233069AbhGZPb6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 11:31:58 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QGAB7g028962
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:24 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0gm0aet2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:24 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:12:20 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 373A63D405AD; Mon, 26 Jul 2021 09:12:16 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 bpf-next 01/14] bpf: refactor BPF_PROG_RUN into a function
Date:   Mon, 26 Jul 2021 09:11:58 -0700
Message-ID: <20210726161211.925206-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726161211.925206-1-andrii@kernel.org>
References: <20210726161211.925206-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: frI7OocXK5uKvEeJA4VGf5yewu1jzsRQ
X-Proofpoint-GUID: frI7OocXK5uKvEeJA4VGf5yewu1jzsRQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 mlxlogscore=940 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260094
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

