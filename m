Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0375C049C
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiIUQt4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 21 Sep 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIUQtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 12:49:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37F9AF87
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:42 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LFUjZH015200
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jqbbub3q6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 09:43:41 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:43:36 -0700
Received: from twshared15978.04.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:43:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 138791F2B4F9A; Wed, 21 Sep 2022 09:42:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/4] selftests/bpf: add CSV output mode for veristat
Date:   Wed, 21 Sep 2022 09:42:52 -0700
Message-ID: <20220921164254.3630690-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921164254.3630690-1-andrii@kernel.org>
References: <20220921164254.3630690-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: q6in8Ouq-kDPvkFsgW9_YCm5PlhC5zfx
X-Proofpoint-GUID: q6in8Ouq-kDPvkFsgW9_YCm5PlhC5zfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_09,2022-09-20_02,2022-06-22_01
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

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 111 +++++++++++++++++--------
 1 file changed, 75 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c0c8a65cda52..0472bfae3c9d 100644
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
@@ -78,8 +85,9 @@ const char argp_program_doc[] =
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
 	{ "verbose", 'v', NULL, 0, "Verbose mode" },
-	{ "output", 'o', "SPEC", 0, "Specify output stats" },
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
@@ -385,7 +403,21 @@ static int cmp_prog_stats(const void *v1, const void *v2)
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
 
@@ -393,34 +425,30 @@ static void output_headers(bool calc_len)
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
 
@@ -453,23 +481,36 @@ static void output_stats(const struct verif_stats *s, bool calc_len)
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
@@ -505,20 +546,18 @@ int main(int argc, char **argv)
 
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

