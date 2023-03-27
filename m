Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD456CADF3
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC0SwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Mar 2023 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjC0SwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:52:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A001732
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RDAbvJ009866
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:14 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3phxnuu6ky-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:52:13 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Mar 2023 11:52:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 67D242C1D3DD8; Mon, 27 Mar 2023 11:52:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 2/3] veristat: add -d debug mode option to see debug libbpf log
Date:   Mon, 27 Mar 2023 11:52:01 -0700
Message-ID: <20230327185202.1929145-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327185202.1929145-1-andrii@kernel.org>
References: <20230327185202.1929145-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1VjdZ9yM7J4iOCWkrkpHdFerROtTb4xE
X-Proofpoint-ORIG-GUID: 1VjdZ9yM7J4iOCWkrkpHdFerROtTb4xE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
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

