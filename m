Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC15D4B3398
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 08:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiBLHbI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 12 Feb 2022 02:31:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiBLHbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 02:31:08 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040C26AD9
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 23:31:05 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BLIgiE030122
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 23:31:05 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e5sv74yea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 23:31:05 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 23:31:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4E5DE10C02D43; Fri, 11 Feb 2022 23:30:59 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH v5 bpf-next 1/2] perf: Stop using deprecated bpf_load_program() API
Date:   Fri, 11 Feb 2022 23:30:53 -0800
Message-ID: <20220212073054.1052880-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220212073054.1052880-1-andrii@kernel.org>
References: <20220212073054.1052880-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tB-OMUKaX0a3WhFq9pLM_FhDmGKvzc2y
X-Proofpoint-ORIG-GUID: tB-OMUKaX0a3WhFq9pLM_FhDmGKvzc2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_02,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120044
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Christy Lee <christylee@fb.com>

bpf_load_program() API is deprecated, remove perf's usage of the
deprecated function. Add a __weak function declaration for libbpf
version compatibility.

Signed-off-by: Christy Lee <christylee@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/tests/bpf.c      | 14 ++++----------
 tools/perf/util/bpf-event.c | 13 +++++++++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 573490530194..57b9591f7cbb 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -281,8 +281,8 @@ static int __test__bpf(int idx)
 
 static int check_env(void)
 {
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	int err;
-	unsigned int kver_int;
 	char license[] = "GPL";
 
 	struct bpf_insn insns[] = {
@@ -290,19 +290,13 @@ static int check_env(void)
 		BPF_EXIT_INSN(),
 	};
 
-	err = fetch_kernel_version(&kver_int, NULL, 0);
+	err = fetch_kernel_version(&opts.kern_version, NULL, 0);
 	if (err) {
 		pr_debug("Unable to get kernel version\n");
 		return err;
 	}
-
-/* temporarily disable libbpf deprecation warnings */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-	err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
-			       ARRAY_SIZE(insns),
-			       license, kver_int, NULL, 0);
-#pragma GCC diagnostic pop
+	err = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
+			    ARRAY_SIZE(insns), &opts);
 	if (err < 0) {
 		pr_err("Missing basic BPF support, skip this test: %s\n",
 		       strerror(errno));
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index a517eaa51eb3..bd1bc3c86cac 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -33,6 +33,19 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
        return err ? ERR_PTR(err) : btf;
 }
 
+int __weak bpf_prog_load(enum bpf_prog_type prog_type,
+			 const char *prog_name __maybe_unused,
+			 const char *license,
+			 const struct bpf_insn *insns, size_t insn_cnt,
+			 const struct bpf_prog_load_opts *opts)
+{
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+	return bpf_load_program(prog_type, insns, insn_cnt, license,
+				opts->kern_version, opts->log_buf, opts->log_size);
+#pragma GCC diagnostic pop
+}
+
 struct bpf_program * __weak
 bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
 {
-- 
2.30.2

