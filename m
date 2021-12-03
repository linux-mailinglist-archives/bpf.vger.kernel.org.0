Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B122466EB0
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 01:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbhLCAuO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Dec 2021 19:50:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5954 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238220AbhLCAuO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Dec 2021 19:50:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2JSahr004447
        for <bpf@vger.kernel.org>; Thu, 2 Dec 2021 16:46:50 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cpr0pqyeb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 16:46:50 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 16:46:48 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 20B6EB9EEA27; Thu,  2 Dec 2021 16:46:41 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] perf: mute libbpf API deprecations temporarily
Date:   Thu, 2 Dec 2021 16:46:40 -0800
Message-ID: <20211203004640.2455717-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: dqsndcSxCkXagl_pM_FssBHtI7l-gdr7
X-Proofpoint-ORIG-GUID: dqsndcSxCkXagl_pM_FssBHtI7l-gdr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf development version was bumped to 0.7 in c93faaaf2f67
("libbpf: Deprecate bpf_prog_load_xattr() API"), activating a bunch of
previously scheduled deprecations. Most APIs are pretty straightforward
to replace with newer APIs, but perf has a complicated mixed setup with
libbpf used both as static and shared configurations, which makes it
non-trivial to migrate the APIs.

Further, bpf_program__set_prep() needs more involved refactoring, which
will require help from Arnaldo and/or Jiri.

So for now, mute deprecation warnings and work on migrating perf off of
deprecated APIs separately with the input from owners of the perf tool.

Fixes: c93faaaf2f67 ("libbpf: Deprecate bpf_prog_load_xattr() API")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/tests/bpf.c       | 4 ++++
 tools/perf/util/bpf-loader.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 2bf146e49ce8..c52bf10f746e 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -312,9 +312,13 @@ static int check_env(void)
 		return err;
 	}
 
+/* temporarily disable libbpf deprecation warnings */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
 			       sizeof(insns) / sizeof(insns[0]),
 			       license, kver_int, NULL, 0);
+#pragma GCC diagnostic pop
 	if (err < 0) {
 		pr_err("Missing basic BPF support, skip this test: %s\n",
 		       strerror(errno));
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index fbb3c4057c30..528aeb0ab79d 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -29,6 +29,9 @@
 
 #include <internal/xyarray.h>
 
+/* temporarily disable libbpf deprecation warnings */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
 			      const char *fmt, va_list args)
 {
-- 
2.30.2

