Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3356D285F
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCaS6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 31 Mar 2023 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCaS6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 14:58:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051022206
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 11:58:24 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VIj2CB009060
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 11:57:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pnx3ju3f6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 11:57:41 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 31 Mar 2023 11:57:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 734792C9C1922; Fri, 31 Mar 2023 11:57:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/2] veristat: improve version reporting
Date:   Fri, 31 Mar 2023 11:56:37 -0700
Message-ID: <20230331185637.2026519-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331185637.2026519-1-andrii@kernel.org>
References: <20230331185637.2026519-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dddi0bNUZaKcoIiZQYucgPBNlg3ucq_R
X-Proofpoint-GUID: dddi0bNUZaKcoIiZQYucgPBNlg3ucq_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For packaging version of the tool is important, so add a simple way to
specify veristat version for upstream mirror at Github.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 612ca52c6fba..daac72b76508 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -140,6 +140,7 @@ static struct env {
 	bool quiet;
 	int log_level;
 	enum resfmt out_fmt;
+	bool show_version;
 	bool comparison_mode;
 	bool replay_mode;
 
@@ -176,16 +177,22 @@ static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va
 	return vfprintf(stderr, format, args);
 }
 
-const char *argp_program_version = "veristat";
+#ifndef VERISTAT_VERSION
+#define VERISTAT_VERSION "<kernel>"
+#endif
+
+const char *argp_program_version = "veristat v" VERISTAT_VERSION;
 const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
 const char argp_program_doc[] =
 "veristat    BPF verifier stats collection and comparison tool.\n"
 "\n"
 "USAGE: veristat <obj-file> [<obj-file>...]\n"
-"   OR: veristat -C <baseline.csv> <comparison.csv>\n";
+"   OR: veristat -C <baseline.csv> <comparison.csv>\n"
+"   OR: veristat -R <results.csv>\n";
 
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
+	{ "version", 'V', NULL, 0, "Print version" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
 	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
 	{ "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug logging)" },
@@ -212,6 +219,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'h':
 		argp_state_help(state, stderr, ARGP_HELP_STD_HELP);
 		break;
+	case 'V':
+		env.show_version = true;
+		break;
 	case 'v':
 		env.verbose = true;
 		break;
@@ -1991,6 +2001,11 @@ int main(int argc, char **argv)
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		return 1;
 
+	if (env.show_version) {
+		printf("%s\n", argp_program_version);
+		return 0;
+	}
+
 	if (env.verbose && env.quiet) {
 		fprintf(stderr, "Verbose and quiet modes are incompatible, please specify just one or neither!\n\n");
 		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
-- 
2.34.1

