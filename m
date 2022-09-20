Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271E5BDB26
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 06:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiITEIE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 20 Sep 2022 00:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITEID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 00:08:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96144B496
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:02 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsuKq026487
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jn9jm0u4r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:02 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 21:08:01 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 064871F1BEC23; Mon, 19 Sep 2022 21:07:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: add CSV output mode for veristat
Date:   Mon, 19 Sep 2022 21:07:34 -0700
Message-ID: <20220920040736.342025-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920040736.342025-1-andrii@kernel.org>
References: <20220920040736.342025-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 45Bk4gXvch_PgeY2vJHLjdpxzUzNLMw3
X-Proofpoint-GUID: 45Bk4gXvch_PgeY2vJHLjdpxzUzNLMw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_13,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach veristat to output results as CSV table for easier programmatic
processing. Change what was --output/-o argument to now be --emit/-e.
And then use --output-format/-o <fmt> to specify output format.
Currently "table" and "csv" is supported, table being default.

For CSV output mode veristat is using spec identifiers as column names.
E.g., instead of "Total states" veristat uses "total_states" as a CSV
header name.

Internally veristat recognizes three formats, one of them
(RESFMT_TABLE_CALCLEN) is a special format instructing veristat to
calculate column widths for table output. This felt a bit cleaner and
more uniform than either creating separate functions just for this.

Also fix double-free of bpf_object in process_prog, which didn't feel
important enough to have a separate patch for.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 114 ++++++++++++++++---------
 1 file changed, 76 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 39e6dc41e504..317f7736dd59 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -46,10 +46,17 @@ struct stat_specs {
 	int lens[ALL_STATS_CNT];
 };
 
+enum resfmt {
+	RESFMT_TABLE,
+	RESFMT_TABLE_CALCLEN, /* fake format to pre-calculate table's column widths */
+	RESFMT_CSV,
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
 	bool verbose;
+	enum resfmt out_fmt;
 
 	struct verif_stats *prog_stats;
 	int prog_stat_cnt;
@@ -77,9 +84,10 @@ const char argp_program_doc[] =
 
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
-	{ "verbose", 'v', NULL, 0, "Verbose mode" },
-	{ "output", 'o', "SPEC", 0, "Specify output stats" },
+	{ "vereose", 'v', NULL, 0, "Verbose mode" },
+	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
+	{ "output-format", 'o', "FMT", 0, "Result output format (table, csv), default is table." },
 	{},
 };
 
@@ -97,7 +105,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case 'v':
 		env.verbose = true;
 		break;
-	case 'o':
+	case 'e':
 		err = parse_stats(arg, &env.output_spec);
 		if (err)
 			return err;
@@ -107,6 +115,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		if (err)
 			return err;
 		break;
+	case 'o':
+		if (strcmp(arg, "table") == 0) {
+			env.out_fmt = RESFMT_TABLE;
+		} else if (strcmp(arg, "csv") == 0) {
+			env.out_fmt = RESFMT_CSV;
+		} else {
+			fprintf(stderr, "Unrecognized output format '%s'\n", arg);
+			return -EINVAL;
+		}
+		break;
 	case ARGP_KEY_ARG:
 		tmp = realloc(env.filenames, (env.filename_cnt + 1) * sizeof(*env.filenames));
 		if (!tmp)
@@ -147,7 +165,7 @@ static struct stat_def {
 	[FILE_NAME] = { "File", {"file_name", "filename", "file"}, true /* asc */ },
 	[PROG_NAME] = { "Program", {"prog_name", "progname", "prog"}, true /* asc */ },
 	[VERDICT] = { "Verdict", {"verdict"}, true /* asc: failure, success */ },
-	[DURATION] = { "Duration, us", {"duration", "dur"}, },
+	[DURATION] = { "Duration (us)", {"duration", "dur"}, },
 	[TOTAL_INSNS] = { "Total insns", {"total_insns", "insns"}, },
 	[TOTAL_STATES] = { "Total states", {"total_states", "states"}, },
 	[PEAK_STATES] = { "Peak states", {"peak_states"}, },
@@ -300,7 +318,6 @@ static int process_obj(const char *filename)
 		prog = bpf_object__next_program(obj, NULL);
 		bpf_program__set_autoload(prog, true);
 		process_prog(filename, obj, prog);
-		bpf_object__close(obj);
 		goto cleanup;
 	}
 
@@ -386,7 +403,21 @@ static int cmp_prog_stats(const void *v1, const void *v2)
 #define HEADER_CHAR '-'
 #define COLUMN_SEP "  "
 
-static void output_headers(bool calc_len)
+static void output_header_underlines(void)
+{
+	int i, j, len;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		len = env.output_spec.lens[i];
+
+		printf("%s", i == 0 ? "" : COLUMN_SEP);
+		for (j = 0; j < len; j++)
+			printf("%c", HEADER_CHAR);
+	}
+	printf("\n");
+}
+
+static void output_headers(enum resfmt fmt)
 {
 	int i, len;
 
@@ -394,34 +425,30 @@ static void output_headers(bool calc_len)
 		int id = env.output_spec.ids[i];
 		int *max_len = &env.output_spec.lens[i];
 
-		if (calc_len) {
+		switch (fmt) {
+		case RESFMT_TABLE_CALCLEN:
 			len = snprintf(NULL, 0, "%s", stat_defs[id].header);
 			if (len > *max_len)
 				*max_len = len;
-		} else {
+			break;
+		case RESFMT_TABLE:
 			printf("%s%-*s", i == 0 ? "" : COLUMN_SEP,  *max_len, stat_defs[id].header);
+			if (i == env.output_spec.spec_cnt - 1)
+				printf("\n");
+			break;
+		case RESFMT_CSV:
+			printf("%s%s", i == 0 ? "" : ",", stat_defs[id].names[0]);
+			if (i == env.output_spec.spec_cnt - 1)
+				printf("\n");
+			break;
 		}
 	}
 
-	if (!calc_len)
-		printf("\n");
+	if (fmt == RESFMT_TABLE)
+		output_header_underlines();
 }
 
-static void output_header_underlines(void)
-{
-	int i, j, len;
-
-	for (i = 0; i < env.output_spec.spec_cnt; i++) {
-		len = env.output_spec.lens[i];
-
-		printf("%s", i == 0 ? "" : COLUMN_SEP);
-		for (j = 0; j < len; j++)
-			printf("%c", HEADER_CHAR);
-	}
-	printf("\n");
-}
-
-static void output_stats(const struct verif_stats *s, bool calc_len)
+static void output_stats(const struct verif_stats *s, enum resfmt fmt, bool last)
 {
 	int i;
 
@@ -454,23 +481,36 @@ static void output_stats(const struct verif_stats *s, bool calc_len)
 			exit(1);
 		}
 
-		if (calc_len) {
+		switch (fmt) {
+		case RESFMT_TABLE_CALCLEN:
 			if (str)
 				len = snprintf(NULL, 0, "%s", str);
 			else
 				len = snprintf(NULL, 0, "%ld", val);
 			if (len > *max_len)
 				*max_len = len;
-		} else {
+			break;
+		case RESFMT_TABLE:
 			if (str)
 				printf("%s%-*s", i == 0 ? "" : COLUMN_SEP, *max_len, str);
 			else
 				printf("%s%*ld", i == 0 ? "" : COLUMN_SEP,  *max_len, val);
+			if (i == env.output_spec.spec_cnt - 1)
+				printf("\n");
+			break;
+		case RESFMT_CSV:
+			if (str)
+				printf("%s%s", i == 0 ? "" : ",", str);
+			else
+				printf("%s%ld", i == 0 ? "" : ",", val);
+			if (i == env.output_spec.spec_cnt - 1)
+				printf("\n");
+			break;
 		}
 	}
 
-	if (!calc_len)
-		printf("\n");
+	if (last && fmt == RESFMT_TABLE)
+		output_header_underlines();
 }
 
 int main(int argc, char **argv)
@@ -506,20 +546,18 @@ int main(int argc, char **argv)
 
 	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp_prog_stats);
 
-	/* calculate column widths */
-	output_headers(true);
-	for (i = 0; i < env.prog_stat_cnt; i++) {
-		output_stats(&env.prog_stats[i], true);
+	if (env.out_fmt == RESFMT_TABLE) {
+		/* calculate column widths */
+		output_headers(RESFMT_TABLE_CALCLEN);
+		for (i = 0; i < env.prog_stat_cnt; i++)
+			output_stats(&env.prog_stats[i], RESFMT_TABLE_CALCLEN, false);
 	}
 
 	/* actually output the table */
-	output_headers(false);
-	output_header_underlines();
+	output_headers(env.out_fmt);
 	for (i = 0; i < env.prog_stat_cnt; i++) {
-		output_stats(&env.prog_stats[i], false);
+		output_stats(&env.prog_stats[i], env.out_fmt, i == env.prog_stat_cnt - 1);
 	}
-	output_header_underlines();
-	printf("\n");
 
 	printf("Done. Processed %d object files, %d programs.\n",
 	       env.filename_cnt, env.prog_stat_cnt);
-- 
2.30.2

