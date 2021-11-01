Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49104423A5
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 00:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKAXEA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 1 Nov 2021 19:04:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62278 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhKAXD7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 19:03:59 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GoD5K015691
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 16:01:25 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2d4eda0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 16:01:25 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 16:01:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CD1127A9D884; Mon,  1 Nov 2021 16:01:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix also no-alu32 strobemeta selftest
Date:   Mon, 1 Nov 2021 16:01:18 -0700
Message-ID: <20211101230118.1273019-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: oQpbkgZjMNJQkNzerdajSaR9irJAN6KU
X-Proofpoint-GUID: oQpbkgZjMNJQkNzerdajSaR9irJAN6KU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_08,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=490 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous fix aded bpf_clamp_umax() helper use to re-validate boundaries.
While that works correctly, it introduces more branches, which blows up
past 1 million instructions in no-alu32 variant of strobemeta selftests.

Switching len variable from u32 to u64 also fixes the issue and reduces
the number of validated instructions, so use that instead. Fix this
patch and bpf_clamp_umax() removed, both alu32 and no-alu32 selftests
pass.

Fixes: 0133c20480b1 ("selftests/bpf: Fix strobemeta selftest regression")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index 3687ea755ab5..60c93aee2f4a 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -10,14 +10,6 @@
 #include <linux/types.h>
 #include <bpf/bpf_helpers.h>
 
-#define bpf_clamp_umax(VAR, UMAX)					\
-	asm volatile (							\
-		"if %0 <= %[max] goto +1\n"				\
-		"%0 = %[max]\n"						\
-		: "+r"(VAR)						\
-		: [max]"i"(UMAX)					\
-	)
-
 typedef uint32_t pid_t;
 struct task_struct {};
 
@@ -366,7 +358,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 					     void *payload)
 {
 	void *location;
-	uint32_t len;
+	uint64_t len;
 
 	data->str_lens[idx] = 0;
 	location = calc_location(&cfg->str_locs[idx], tls_base);
@@ -398,7 +390,7 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 	struct strobe_map_descr* descr = &data->map_descrs[idx];
 	struct strobe_map_raw map;
 	void *location;
-	uint32_t len;
+	uint64_t len;
 	int i;
 
 	descr->tag_len = 0; /* presume no tag is set */
@@ -421,7 +413,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 
 	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, map.tag);
 	if (len <= STROBE_MAX_STR_LEN) {
-		bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
 		descr->tag_len = len;
 		payload += len;
 	}
@@ -439,7 +430,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
 					      map.entries[i].key);
 		if (len <= STROBE_MAX_STR_LEN) {
-			bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
 			descr->key_lens[i] = len;
 			payload += len;
 		}
@@ -447,7 +437,6 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
 					      map.entries[i].val);
 		if (len <= STROBE_MAX_STR_LEN) {
-			bpf_clamp_umax(len, STROBE_MAX_STR_LEN);
 			descr->val_lens[i] = len;
 			payload += len;
 		}
-- 
2.30.2

