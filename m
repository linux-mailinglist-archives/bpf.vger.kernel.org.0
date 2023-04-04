Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09FF6D5793
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjDDEh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjDDEh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:37:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A3E1FEF
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:37:26 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NLkg5009581
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:37:25 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqxk25a9s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:37:25 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0B8722D051927; Mon,  3 Apr 2023 21:37:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 05/19] veristat: add more veristat control over verifier log options
Date:   Mon, 3 Apr 2023 21:36:45 -0700
Message-ID: <20230404043659.2282536-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MNdbVQbejK96zpBXuZxe5ANjpoCDRMfg
X-Proofpoint-ORIG-GUID: MNdbVQbejK96zpBXuZxe5ANjpoCDRMfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add --log-size to be able to customize log buffer sent to bpf() syscall
for BPF program verification logging.

Add --log-fixed to enforce BPF_LOG_FIXED behavior for BPF verifier log.
This is useful in unlikely event that beginning of truncated verifier
log is more important than the end of it (which with rotating verifier
log behavior is the default now).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 44 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 53d7ec168268..af6d7a555dbd 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -141,12 +141,15 @@ static struct env {
 	bool verbose;
 	bool debug;
 	bool quiet;
-	int log_level;
 	enum resfmt out_fmt;
 	bool show_version;
 	bool comparison_mode;
 	bool replay_mode;
 
+	int log_level;
+	int log_size;
+	bool log_fixed;
+
 	struct verif_stats *prog_stats;
 	int prog_stat_cnt;
 
@@ -193,12 +196,19 @@ const char argp_program_doc[] =
 "   OR: veristat -C <baseline.csv> <comparison.csv>\n"
 "   OR: veristat -R <results.csv>\n";
 
+enum {
+	OPT_LOG_FIXED = 1000,
+	OPT_LOG_SIZE = 1001,
+};
+
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
 	{ "version", 'V', NULL, 0, "Print version" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
-	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
 	{ "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug logging)" },
+	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for normal mode, 1 for verbose mode)" },
+	{ "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rotation" },
+	{ "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log size (default to 16MB)" },
 	{ "quiet", 'q', NULL, 0, "Quiet mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
@@ -263,6 +273,17 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			argp_usage(state);
 		}
 		break;
+	case OPT_LOG_FIXED:
+		env.log_fixed = true;
+		break;
+	case OPT_LOG_SIZE:
+		errno = 0;
+		env.log_size = strtol(arg, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "invalid log size: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
 	case 'C':
 		env.comparison_mode = true;
 		break;
@@ -929,8 +950,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 {
 	const char *prog_name = bpf_program__name(prog);
 	const char *base_filename = basename(filename);
-	size_t buf_sz = sizeof(verif_log_buf);
-	char *buf = verif_log_buf;
+	char *buf;
+	int buf_sz, log_level;
 	struct verif_stats *stats;
 	int err = 0;
 	void *tmp;
@@ -948,18 +969,23 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	memset(stats, 0, sizeof(*stats));
 
 	if (env.verbose) {
-		buf_sz = 16 * 1024 * 1024;
+		buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
 		buf = malloc(buf_sz);
 		if (!buf)
 			return -ENOMEM;
-		bpf_program__set_log_buf(prog, buf, buf_sz);
-		bpf_program__set_log_level(prog, env.log_level | 4); /* stats + log */
+		/* ensure we always request stats */
+		log_level = env.log_level | 4 | (env.log_fixed ? 8 : 0);
 	} else {
-		bpf_program__set_log_buf(prog, buf, buf_sz);
-		bpf_program__set_log_level(prog, 4); /* only verifier stats */
+		buf = verif_log_buf;
+		buf_sz = sizeof(verif_log_buf);
+		/* request only verifier stats */
+		log_level = 4 | (env.log_fixed ? 8 : 0);
 	}
 	verif_log_buf[0] = '\0';
 
+	bpf_program__set_log_buf(prog, buf, buf_sz);
+	bpf_program__set_log_level(prog, log_level);
+
 	/* increase chances of successful BPF object loading */
 	fixup_obj(obj, prog, base_filename);
 
-- 
2.34.1

