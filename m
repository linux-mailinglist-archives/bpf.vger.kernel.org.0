Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC945B0AF
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhKXA1G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:27:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233523AbhKXA1F (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:27:05 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANMf3f8007397
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:57 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgvrxnyk4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:57 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:56 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E6801A666ACB; Tue, 23 Nov 2021 16:23:45 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 09/13] selftests/bpf: prevent misaligned memory access in get_stack_raw_tp test
Date:   Tue, 23 Nov 2021 16:23:21 -0800
Message-ID: <20211124002325.1737739-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: VMUSgq-6nN97iqgQucoyT8Wq4Hsx9Hin
X-Proofpoint-ORIG-GUID: VMUSgq-6nN97iqgQucoyT8Wq4Hsx9Hin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Perfbuf doesn't guarantee 8-byte alignment of the data like BPF ringbuf
does, so struct get_stack_trace_t can arrive not properly aligned for
subsequent u64 accesses. Easiest fix is to just copy data locally.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/get_stack_raw_tp.c    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 4184c399d4c6..977ab433a946 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -24,13 +24,19 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 {
 	bool good_kern_stack = false, good_user_stack = false;
 	const char *nonjit_func = "___bpf_prog_run";
-	struct get_stack_trace_t *e = data;
+	/* perfbuf-submitted data is 4-byte aligned, but we need 8-byte
+	 * alignment, so copy data into a local variable, for simplicity
+	 */
+	struct get_stack_trace_t e;
 	int i, num_stack;
 	static __u64 cnt;
 	struct ksym *ks;
 
 	cnt++;
 
+	memset(&e, 0, sizeof(e));
+	memcpy(&e, data, size <= sizeof(e) ? size : sizeof(e));
+
 	if (size < sizeof(struct get_stack_trace_t)) {
 		__u64 *raw_data = data;
 		bool found = false;
@@ -57,19 +63,19 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 			good_user_stack = true;
 		}
 	} else {
-		num_stack = e->kern_stack_size / sizeof(__u64);
+		num_stack = e.kern_stack_size / sizeof(__u64);
 		if (env.jit_enabled) {
 			good_kern_stack = num_stack > 0;
 		} else {
 			for (i = 0; i < num_stack; i++) {
-				ks = ksym_search(e->kern_stack[i]);
+				ks = ksym_search(e.kern_stack[i]);
 				if (ks && (strcmp(ks->name, nonjit_func) == 0)) {
 					good_kern_stack = true;
 					break;
 				}
 			}
 		}
-		if (e->user_stack_size > 0 && e->user_stack_buildid_size > 0)
+		if (e.user_stack_size > 0 && e.user_stack_buildid_size > 0)
 			good_user_stack = true;
 	}
 
-- 
2.30.2

