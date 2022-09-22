Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575B5E7015
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 01:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiIVXIC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 22 Sep 2022 19:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIVXH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 19:07:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31AF1138FF
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:07:54 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MKiqQS027803
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:07:54 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrpfvwbu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:07:54 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:07:52 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4C9CE1F3844B7; Thu, 22 Sep 2022 16:07:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: emit processing progress and add quiet mode to veristat
Date:   Thu, 22 Sep 2022 16:07:38 -0700
Message-ID: <20220922230739.1288536-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922230739.1288536-1-andrii@kernel.org>
References: <20220922230739.1288536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mNT7_xVxwYcWPZdU5m6pXefC5ad2__5G
X-Proofpoint-ORIG-GUID: mNT7_xVxwYcWPZdU5m6pXefC5ad2__5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_15,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Emit "Processing <filepath>..." for each BPF object file to be
processed, to show progress. But also add -q (--quiet) flag to silence
such messages. Doing something more clever (like overwriting same output
line) is to cumbersome and easily breakable if there is any other
console output (e.g., errors from libbpf).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index f09dd143a8df..b92c017364b2 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -63,6 +63,7 @@ static struct env {
 	char **filenames;
 	int filename_cnt;
 	bool verbose;
+	bool quiet;
 	enum resfmt out_fmt;
 	bool comparison_mode;
 
@@ -107,6 +108,7 @@ const char argp_program_doc[] =
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
+	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
 	{ "output-format", 'o', "FMT", 0, "Result output format (table, csv), default is table." },
@@ -131,6 +133,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'v':
 		env.verbose = true;
 		break;
+	case 'q':
+		env.quiet = true;
+		break;
 	case 'e':
 		err = parse_stats(arg, &env.output_spec);
 		if (err)
@@ -569,8 +574,10 @@ static int process_obj(const char *filename)
 		return 0;
 	}
 
-	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
+	if (!env.quiet)
+		printf("Processing '%s'...\n", basename(filename));
 
+	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
 	obj = bpf_object__open_file(filename, &opts);
 	if (!obj) {
 		/* if libbpf can't open BPF object file, it could be because
@@ -1268,6 +1275,12 @@ int main(int argc, char **argv)
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		return 1;
 
+	if (env.verbose && env.quiet) {
+		fprintf(stderr, "Verbose and quiet modes are incompatible, please specify just one or neither!\n");
+		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
+		return 1;
+	}
+
 	if (env.output_spec.spec_cnt == 0)
 		env.output_spec = default_output_spec;
 	if (env.sort_spec.spec_cnt == 0)
-- 
2.30.2

