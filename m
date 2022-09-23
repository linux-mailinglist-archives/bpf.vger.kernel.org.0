Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280E15E8137
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiIWR7f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 23 Sep 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiIWR7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 13:59:34 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B72F8
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 10:59:29 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NGcAo9013137
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 10:59:28 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3js7mxc3m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 10:59:28 -0700
Received: from twshared17341.24.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 10:59:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7F1521F41C91E; Fri, 23 Sep 2022 10:59:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/5] selftests/bpf: make veristat's verifier log parsing faster and more robust
Date:   Fri, 23 Sep 2022 10:59:10 -0700
Message-ID: <20220923175913.3272430-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923175913.3272430-1-andrii@kernel.org>
References: <20220923175913.3272430-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GgCZ72qNAhKr4iaz896ZzsiO5CPDUYNF
X-Proofpoint-GUID: GgCZ72qNAhKr4iaz896ZzsiO5CPDUYNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_06,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure veristat doesn't spend ridiculous amount of time parsing
verifier stats from verifier log, especially for very large logs or
truncated logs (e.g., when verifier returns -ENOSPC due to too small
buffer). For this, parse lines from the end of the log and make sure we
parse only up to 100 last lines, where stats should be, if at all.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 29 ++++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 51030234b60a..77bdfd6fe302 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -419,19 +419,30 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 
 static char verif_log_buf[64 * 1024];
 
-static int parse_verif_log(const char *buf, size_t buf_sz, struct verif_stats *s)
+#define MAX_PARSED_LOG_LINES 100
+
+static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
-	const char *next;
-	int pos;
+	const char *cur;
+	int pos, lines;
+
+	buf[buf_sz - 1] = '\0';
 
-	for (pos = 0; buf[0]; buf = next) {
-		if (buf[0] == '\n')
-			buf++;
-		next = strchrnul(&buf[pos], '\n');
+	for (pos = strlen(buf) - 1, lines = 0; pos >= 0 && lines < MAX_PARSED_LOG_LINES; lines++) {
+		/* find previous endline or otherwise take the start of log buf */
+		for (cur = &buf[pos]; cur > buf && cur[0] != '\n'; cur--, pos--) {
+		}
+		/* next time start from end of previous line (or pos goes to <0) */
+		pos--;
+		/* if we found endline, point right after endline symbol;
+		 * otherwise, stay at the beginning of log buf
+		 */
+		if (cur[0] == '\n')
+			cur++;
 
-		if (1 == sscanf(buf, "verification time %ld usec\n", &s->stats[DURATION]))
+		if (1 == sscanf(cur, "verification time %ld usec\n", &s->stats[DURATION]))
 			continue;
-		if (6 == sscanf(buf, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
+		if (6 == sscanf(cur, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
 				&s->stats[TOTAL_INSNS],
 				&s->stats[MAX_STATES_PER_INSN],
 				&s->stats[TOTAL_STATES],
-- 
2.30.2

