Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601846C8937
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXX2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 24 Mar 2023 19:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCXX2B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:28:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478265BA
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:27:57 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OMZsKX022491
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:27:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pgxmqf8c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:27:56 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 16:27:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AE8002BC9C965; Fri, 24 Mar 2023 16:27:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 2/3] veristat: add -d debug mode option to see debug libbpf log
Date:   Fri, 24 Mar 2023 16:27:44 -0700
Message-ID: <20230324232745.3959567-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324232745.3959567-1-andrii@kernel.org>
References: <20230324232745.3959567-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: c8c1k74pR_SQk06tQTyJdPA-rzAJ9vxD
X-Proofpoint-ORIG-GUID: c8c1k74pR_SQk06tQTyJdPA-rzAJ9vxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add -d option to allow requesting libbpf debug logs from veristat.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 83231456d3c5..263df32fbda8 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -135,6 +135,7 @@ static struct env {
 	char **filenames;
 	int filename_cnt;
 	bool verbose;
+	bool debug;
 	bool quiet;
 	int log_level;
 	enum resfmt out_fmt;
@@ -169,7 +170,7 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
 {
 	if (!env.verbose)
 		return 0;
-	if (level == LIBBPF_DEBUG /* && !env.verbose */)
+	if (level == LIBBPF_DEBUG  && !env.debug)
 		return 0;
 	return vfprintf(stderr, format, args);
 }
@@ -186,6 +187,7 @@ static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
 	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
+	{ "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug logging)" },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -212,6 +214,10 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'v':
 		env.verbose = true;
 		break;
+	case 'd':
+		env.debug = true;
+		env.verbose = true;
+		break;
 	case 'q':
 		env.quiet = true;
 		break;
-- 
2.34.1

