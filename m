Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EEB5BDB27
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITEIM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 20 Sep 2022 00:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiITEIL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 00:08:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB44DF11
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:08 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsjcM004524
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpyt7j5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:07 -0700
Received: from twshared12284.04.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 21:08:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A0ADB1F1BEC37; Mon, 19 Sep 2022 21:08:00 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: add comparison mode to veristat
Date:   Mon, 19 Sep 2022 21:07:35 -0700
Message-ID: <20220920040736.342025-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920040736.342025-1-andrii@kernel.org>
References: <20220920040736.342025-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ii7ZlB3iThQcfg7EoB-ysTTdzylVydh5
X-Proofpoint-GUID: Ii7ZlB3iThQcfg7EoB-ysTTdzylVydh5
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

Add ability to compare and contrast two veristat runs, previously
recorded with veristat using CSV output format.

When veristat is called with -C (--compare) flag, veristat expects
exactly two input files specified, both should be in CSV format.
Expectation is that it's output from previous veristat runs, but as long
as column names and formats match, it should just work. First CSV file
is designated as a "baseline" provided, and the second one is
comparison (experiment) data set. Establishing baseline matters later
when calculating difference percentages, see below.

Veristat parses these two CSV files and "reconstructs" verifier stats
(it could be just a subset of all possible stats). File and program
names are mandatory as they are used as joining key (these two "stats"
are designated as "key stats" in the code).

Veristat currently enforces that the set of stats recorded in both CSV
has to exactly match, down to exact order. This is just a simplifying
condition which can be lifted with a bit of additional pre-processing to
reorded stat specs internally, which I didn't bother doing, yet.

For all the non-key stats, veristat will output three columns: one for
baseline data, one for comparison data, and one with an absolute and
relative percentage difference. If either baseline or comparison values
are missing (that is, respective CSV file doesn't have a row with
*exactly* matching file and program name), those values are assumed to
be empty or zero. In such case relative percentages are forced to +100%
or -100% output, for consistency with a typical case.

Veristat's -e (--emit) and -s (--sort) specs still apply, so even if CSV
contains lots of stats, user can request to compare only a subset of
them (and specify desired column order as well). Similarly, both CSV and
human-readable table output is honored. Note that input is currently
always expected to be CSV.

Here's an example shell session, recording data for biosnoop tool on two
different kernels and comparing them afterwards, outputting data in table
format.

  # on slightly older production kernel
  $ sudo ./veristat biosnoop_bpf.o
  File            Program                   Verdict  Duration (us)  Total insns  Total states  Peak states
  --------------  ------------------------  -------  -------------  -----------  ------------  -----------
  biosnoop_bpf.o  blk_account_io_merge_bio  success             37           24             1            1
  biosnoop_bpf.o  blk_account_io_start      failure              0            0             0            0
  biosnoop_bpf.o  block_rq_complete         success             76          104             6            6
  biosnoop_bpf.o  block_rq_insert           success             83           85             7            7
  biosnoop_bpf.o  block_rq_issue            success             79           85             7            7
  --------------  ------------------------  -------  -------------  -----------  ------------  -----------
  Done. Processed 1 object files, 5 programs.
  $ sudo ./veristat ~/local/tmp/fbcode-bpf-objs/biosnoop_bpf.o -o csv > baseline.csv
  $ cat baseline.csv
  file_name,prog_name,verdict,duration,total_insns,total_states,peak_states
  biosnoop_bpf.o,blk_account_io_merge_bio,success,36,24,1,1
  biosnoop_bpf.o,blk_account_io_start,failure,0,0,0,0
  biosnoop_bpf.o,block_rq_complete,success,82,104,6,6
  biosnoop_bpf.o,block_rq_insert,success,78,85,7,7
  biosnoop_bpf.o,block_rq_issue,success,74,85,7,7

  # on latest bpf-next kernel
  $ sudo ./veristat biosnoop_bpf.o
  File            Program                   Verdict  Duration (us)  Total insns  Total states  Peak states
  --------------  ------------------------  -------  -------------  -----------  ------------  -----------
  biosnoop_bpf.o  blk_account_io_merge_bio  success             31           24             1            1
  biosnoop_bpf.o  blk_account_io_start      failure              0            0             0            0
  biosnoop_bpf.o  block_rq_complete         success             76          104             6            6
  biosnoop_bpf.o  block_rq_insert           success             83           91             7            7
  biosnoop_bpf.o  block_rq_issue            success             74           91             7            7
  --------------  ------------------------  -------  -------------  -----------  ------------  -----------
  Done. Processed 1 object files, 5 programs.
  $ sudo ./veristat biosnoop_bpf.o -o csv > comparison.csv
  $ cat comparison.csv
  file_name,prog_name,verdict,duration,total_insns,total_states,peak_states
  biosnoop_bpf.o,blk_account_io_merge_bio,success,71,24,1,1
  biosnoop_bpf.o,blk_account_io_start,failure,0,0,0,0
  biosnoop_bpf.o,block_rq_complete,success,82,104,6,6
  biosnoop_bpf.o,block_rq_insert,success,83,91,7,7
  biosnoop_bpf.o,block_rq_issue,success,87,91,7,7

  # now let's compare with human-readable output (note that no sudo needed)
  # we also ignore verification duration in this case to shortned output
  $ ./veristat -C baseline.csv comparison.csv -e file,prog,verdict,insns
  File            Program                   Verdict (A)  Verdict (B)  Verdict (DIFF)  Total insns (A)  Total insns (B)  Total insns (DIFF)
  --------------  ------------------------  -----------  -----------  --------------  ---------------  ---------------  ------------------
  biosnoop_bpf.o  blk_account_io_merge_bio  success      success      MATCH                        24               24         +0 (+0.00%)
  biosnoop_bpf.o  blk_account_io_start      failure      failure      MATCH                         0                0       +0 (+100.00%)
  biosnoop_bpf.o  block_rq_complete         success      success      MATCH                       104              104         +0 (+0.00%)
  biosnoop_bpf.o  block_rq_insert           success      success      MATCH                        91               85         -6 (-6.59%)
  biosnoop_bpf.o  block_rq_issue            success      success      MATCH                        91               85         -6 (-6.59%)
  --------------  ------------------------  -----------  -----------  --------------  ---------------  ---------------  ------------------

While not particularly exciting example (it turned out to be kind of hard to
quickly find a nice example with significant difference just because of kernel
version bump), it should demonstrate main features.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 545 ++++++++++++++++++++++---
 1 file changed, 493 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 317f7736dd59..158b03aab517 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -43,7 +43,7 @@ struct stat_specs {
 	int spec_cnt;
 	enum stat_id ids[ALL_STATS_CNT];
 	bool asc[ALL_STATS_CNT];
-	int lens[ALL_STATS_CNT];
+	int lens[ALL_STATS_CNT * 3]; /* 3x for comparison mode */
 };
 
 enum resfmt {
@@ -57,16 +57,20 @@ static struct env {
 	int filename_cnt;
 	bool verbose;
 	enum resfmt out_fmt;
+	bool comparison_mode;
 
 	struct verif_stats *prog_stats;
 	int prog_stat_cnt;
 
+	/* baseline_stats is allocated and used only in comparsion mode */
+	struct verif_stats *baseline_stats;
+	int baseline_stat_cnt;
+
 	struct stat_specs output_spec;
 	struct stat_specs sort_spec;
 } env;
 
-static int libbpf_print_fn(enum libbpf_print_level level,
-		    const char *format, va_list args)
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
 {
 	if (!env.verbose)
 		return 0;
@@ -78,16 +82,18 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 const char *argp_program_version = "veristat";
 const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
 const char argp_program_doc[] =
-"veristat    BPF verifier stats collection tool.\n"
+"veristat    BPF verifier stats collection and comparison tool.\n"
 "\n"
-"USAGE: veristat <obj-file> [<obj-file>...]\n";
+"USAGE: veristat <obj-file> [<obj-file>...]\n"
+"   OR: veristat -C <baseline.csv> <comparison.csv>\n";
 
 static const struct argp_option opts[] = {
 	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
-	{ "vereose", 'v', NULL, 0, "Verbose mode" },
+	{ "verbose", 'v', NULL, 0, "Verbose mode" },
 	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
 	{ "sort", 's', "SPEC", 0, "Specify sort order" },
 	{ "output-format", 'o', "FMT", 0, "Result output format (table, csv), default is table." },
+	{ "compare", 'C', NULL, 0, "Comparison mode" },
 	{},
 };
 
@@ -125,6 +131,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -EINVAL;
 		}
 		break;
+	case 'C':
+		env.comparison_mode = true;
+		break;
 	case ARGP_KEY_ARG:
 		tmp = realloc(env.filenames, (env.filename_cnt + 1) * sizeof(*env.filenames));
 		if (!tmp)
@@ -141,6 +150,12 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	return 0;
 }
 
+static const struct argp argp = {
+	.options = opts,
+	.parser = parse_arg,
+	.doc = argp_program_doc,
+};
+
 static const struct stat_specs default_output_spec = {
 	.spec_cnt = 7,
 	.ids = {
@@ -219,6 +234,20 @@ static int parse_stats(const char *stats_str, struct stat_specs *specs)
 	return 0;
 }
 
+static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
+{
+	int i;
+
+	if (!stats)
+		return;
+
+	for (i = 0; i < stat_cnt; i++) {
+		free(stats[i].file_name);
+		free(stats[i].prog_name);
+	}
+	free(stats);
+}
+
 static char verif_log_buf[64 * 1024];
 
 static int parse_verif_log(const char *buf, size_t buf_sz, struct verif_stats *s)
@@ -448,6 +477,33 @@ static void output_headers(enum resfmt fmt)
 		output_header_underlines();
 }
 
+static void prepare_value(const struct verif_stats *s, enum stat_id id,
+			  const char **str, long *val)
+{
+	switch (id) {
+	case FILE_NAME:
+		*str = s->file_name;
+		break;
+	case PROG_NAME:
+		*str = s->prog_name;
+		break;
+	case VERDICT:
+		*str = s->stats[VERDICT] ? "success" : "failure";
+		break;
+	case DURATION:
+	case TOTAL_INSNS:
+	case TOTAL_STATES:
+	case PEAK_STATES:
+	case MAX_STATES_PER_INSN:
+	case MARK_READ_MAX_LEN:
+		*val = s->stats[id];
+		break;
+	default:
+		fprintf(stderr, "Unrecognized stat #%d\n", id);
+		exit(1);
+	}
+}
+
 static void output_stats(const struct verif_stats *s, enum resfmt fmt, bool last)
 {
 	int i;
@@ -458,28 +514,7 @@ static void output_stats(const struct verif_stats *s, enum resfmt fmt, bool last
 		const char *str = NULL;
 		long val = 0;
 
-		switch (id) {
-		case FILE_NAME:
-			str = s->file_name;
-			break;
-		case PROG_NAME:
-			str = s->prog_name;
-			break;
-		case VERDICT:
-			str = s->stats[VERDICT] ? "success" : "failure";
-			break;
-		case DURATION:
-		case TOTAL_INSNS:
-		case TOTAL_STATES:
-		case PEAK_STATES:
-		case MAX_STATES_PER_INSN:
-		case MARK_READ_MAX_LEN:
-			val = s->stats[id];
-			break;
-		default:
-			fprintf(stderr, "Unrecognized stat #%d\n", id);
-			exit(1);
-		}
+		prepare_value(s, id, &str, &val);
 
 		switch (fmt) {
 		case RESFMT_TABLE_CALCLEN:
@@ -509,38 +544,28 @@ static void output_stats(const struct verif_stats *s, enum resfmt fmt, bool last
 		}
 	}
 
-	if (last && fmt == RESFMT_TABLE)
+	if (last && fmt == RESFMT_TABLE) {
 		output_header_underlines();
+		printf("Done. Processed %d object files, %d programs.\n",
+		       env.filename_cnt, env.prog_stat_cnt);
+	}
 }
 
-int main(int argc, char **argv)
+static int handle_verif_mode(void)
 {
-	static const struct argp argp = {
-		.options = opts,
-		.parser = parse_arg,
-		.doc = argp_program_doc,
-	};
-	int err = 0, i;
-
-	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
-		return 1;
+	int i, err;
 
 	if (env.filename_cnt == 0) {
 		fprintf(stderr, "Please provide path to BPF object file!\n");
 		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
-		return 1;
+		return -EINVAL;
 	}
 
-	if (env.output_spec.spec_cnt == 0)
-		env.output_spec = default_output_spec;
-	if (env.sort_spec.spec_cnt == 0)
-		env.sort_spec = default_sort_spec;
-
 	for (i = 0; i < env.filename_cnt; i++) {
 		err = process_obj(env.filenames[i]);
 		if (err) {
 			fprintf(stderr, "Failed to process '%s': %d\n", env.filenames[i], err);
-			goto cleanup;
+			return err;
 		}
 	}
 
@@ -559,15 +584,431 @@ int main(int argc, char **argv)
 		output_stats(&env.prog_stats[i], env.out_fmt, i == env.prog_stat_cnt - 1);
 	}
 
-	printf("Done. Processed %d object files, %d programs.\n",
-	       env.filename_cnt, env.prog_stat_cnt);
+	return 0;
+}
+
+static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats *st)
+{
+	switch (id) {
+	case FILE_NAME:
+		st->file_name = strdup(str);
+		if (!st->file_name)
+			return -ENOMEM;
+		break;
+	case PROG_NAME:
+		st->prog_name = strdup(str);
+		if (!st->prog_name)
+			return -ENOMEM;
+		break;
+	case VERDICT:
+		if (strcmp(str, "success") == 0) {
+			st->stats[VERDICT] = true;
+		} else if (strcmp(str, "failure") == 0) {
+			st->stats[VERDICT] = false;
+		} else {
+			fprintf(stderr, "Unrecognized verification verdict '%s'\n", str);
+			return -EINVAL;
+		}
+		break;
+	case DURATION:
+	case TOTAL_INSNS:
+	case TOTAL_STATES:
+	case PEAK_STATES:
+	case MAX_STATES_PER_INSN:
+	case MARK_READ_MAX_LEN: {
+		long val;
+		int err, n;
+
+		if (sscanf(str, "%ld %n", &val, &n) != 1 || n != strlen(str)) {
+			err = -errno;
+			fprintf(stderr, "Failed to parse '%s' as integer\n", str);
+			return err;
+		}
+
+		st->stats[id] = val;
+		break;
+	}
+	default:
+		fprintf(stderr, "Unrecognized stat #%d\n", id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int parse_stats_csv(const char *filename, struct stat_specs *specs,
+			   struct verif_stats **statsp, int *stat_cntp)
+{
+	char line[4096];
+	FILE *f;
+	int err = 0;
+	bool header = true;
+
+	f = fopen(filename, "r");
+	if (!f) {
+		err = -errno;
+		fprintf(stderr, "Failed to open '%s': %d\n", filename, err);
+		return err;
+	}
+
+	*stat_cntp = 0;
+
+	while (fgets(line, sizeof(line), f)) {
+		char *input = line, *state = NULL, *next;
+		struct verif_stats *st = NULL;
+		int col = 0;
+
+		if (!header) {
+			void *tmp;
+
+			tmp = realloc(*statsp, (*stat_cntp + 1) * sizeof(**statsp));
+			if (!tmp) {
+				err = -ENOMEM;
+				goto cleanup;
+			}
+			*statsp = tmp;
+			st = &(*statsp)[*stat_cntp];
+			*stat_cntp += 1;
+		}
+
+		while ((next = strtok_r(state ? NULL : input, ",\n", &state))) {
+			if (header) {
+				/* for the first line, set up spec stats */
+				err = parse_stat(next, specs);
+				if (err)
+					goto cleanup;
+				continue;
+			}
+
+			/* for all other lines, parse values based on spec */
+			if (col >= specs->spec_cnt) {
+				fprintf(stderr, "Found extraneous column #%d in row #%d of '%s'\n",
+					col, *stat_cntp, filename);
+				err = -EINVAL;
+				goto cleanup;
+			}
+			err = parse_stat_value(next, specs->ids[col], st);
+			if (err)
+				goto cleanup;
+			col++;
+		}
+
+		if (!header && col < specs->spec_cnt) {
+			fprintf(stderr, "Not enough columns in row #%d in '%s'\n",
+				*stat_cntp, filename);
+			err = -EINVAL;
+			goto cleanup;
+		}
+
+		header = false;
+	}
+
+	if (!feof(f)) {
+		err = -errno;
+		fprintf(stderr, "Failed I/O for '%s': %d\n", filename, err);
+	}
 
 cleanup:
-	for (i = 0; i < env.prog_stat_cnt; i++) {
-		free(env.prog_stats[i].file_name);
-		free(env.prog_stats[i].prog_name);
+	fclose(f);
+	return err;
+}
+
+/* empty/zero stats for mismatched rows */
+static const struct verif_stats fallback_stats = { .file_name = "", .prog_name = "" };
+
+static bool is_key_stat(enum stat_id id)
+{
+	return id == FILE_NAME || id == PROG_NAME;
+}
+
+static void output_comp_header_underlines(void)
+{
+	int i, j, k;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		int id = env.output_spec.ids[i];
+		int max_j = is_key_stat(id) ? 1 : 3;
+
+		for (j = 0; j < max_j; j++) {
+			int len = env.output_spec.lens[3 * i + j];
+
+			printf("%s", i + j == 0 ? "" : COLUMN_SEP);
+
+			for (k = 0; k < len; k++)
+				printf("%c", HEADER_CHAR);
+		}
+	}
+	printf("\n");
+}
+
+static void output_comp_headers(enum resfmt fmt)
+{
+	static const char *table_sfxs[3] = {" (A)", " (B)", " (DIFF)"};
+	static const char *name_sfxs[3] = {"_base", "_comp", "_diff"};
+	int i, j, len;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		int id = env.output_spec.ids[i];
+		/* key stats don't have A/B/DIFF columns, they are common for both data sets */
+		int max_j = is_key_stat(id) ? 1 : 3;
+
+		for (j = 0; j < max_j; j++) {
+			int *max_len = &env.output_spec.lens[3 * i + j];
+			bool last = (i == env.output_spec.spec_cnt - 1) && (j == max_j - 1);
+			const char *sfx;
+
+			switch (fmt) {
+			case RESFMT_TABLE_CALCLEN:
+				sfx = is_key_stat(id) ? "" : table_sfxs[j];
+				len = snprintf(NULL, 0, "%s%s", stat_defs[id].header, sfx);
+				if (len > *max_len)
+					*max_len = len;
+				break;
+			case RESFMT_TABLE:
+				sfx = is_key_stat(id) ? "" : table_sfxs[j];
+				printf("%s%-*s%s", i + j == 0 ? "" : COLUMN_SEP,
+				       *max_len - (int)strlen(sfx), stat_defs[id].header, sfx);
+				if (last)
+					printf("\n");
+				break;
+			case RESFMT_CSV:
+				sfx = is_key_stat(id) ? "" : name_sfxs[j];
+				printf("%s%s%s", i + j == 0 ? "" : ",", stat_defs[id].names[0], sfx);
+				if (last)
+					printf("\n");
+				break;
+			}
+		}
+	}
+
+	if (fmt == RESFMT_TABLE)
+		output_comp_header_underlines();
+}
+
+static void output_comp_stats(const struct verif_stats *base, const struct verif_stats *comp,
+			      enum resfmt fmt, bool last)
+{
+	char base_buf[1024] = {}, comp_buf[1024] = {}, diff_buf[1024] = {};
+	int i;
+
+	for (i = 0; i < env.output_spec.spec_cnt; i++) {
+		int id = env.output_spec.ids[i], len;
+		int *max_len_base = &env.output_spec.lens[3 * i + 0];
+		int *max_len_comp = &env.output_spec.lens[3 * i + 1];
+		int *max_len_diff = &env.output_spec.lens[3 * i + 2];
+		const char *base_str = NULL, *comp_str = NULL;
+		long base_val = 0, comp_val = 0, diff_val = 0;
+
+		prepare_value(base, id, &base_str, &base_val);
+		prepare_value(comp, id, &comp_str, &comp_val);
+
+		/* normalize all the outputs to be in string buffers for simplicity */
+		if (is_key_stat(id)) {
+			/* key stats (file and program name) are always strings */
+			if (base != &fallback_stats)
+				snprintf(base_buf, sizeof(base_buf), "%s", base_str);
+			else
+				snprintf(base_buf, sizeof(base_buf), "%s", comp_str);
+		} else if (base_str) {
+			snprintf(base_buf, sizeof(base_buf), "%s", base_str);
+			snprintf(comp_buf, sizeof(comp_buf), "%s", comp_str);
+			if (strcmp(base_str, comp_str) == 0)
+				snprintf(diff_buf, sizeof(diff_buf), "%s", "MATCH");
+			else
+				snprintf(diff_buf, sizeof(diff_buf), "%s", "MISMATCH");
+		} else {
+			snprintf(base_buf, sizeof(base_buf), "%ld", base_val);
+			snprintf(comp_buf, sizeof(comp_buf), "%ld", comp_val);
+
+			diff_val = comp_val - base_val;
+			if (base == &fallback_stats || comp == &fallback_stats || base_val == 0) {
+				snprintf(diff_buf, sizeof(diff_buf), "%+ld (%+.2lf%%)",
+					 diff_val, comp_val < base_val ? -100.0 : 100.0);
+			} else {
+				snprintf(diff_buf, sizeof(diff_buf), "%+ld (%+.2lf%%)",
+					 diff_val, diff_val * 100.0 / base_val);
+			}
+		}
+
+		switch (fmt) {
+		case RESFMT_TABLE_CALCLEN:
+			len = strlen(base_buf);
+			if (len > *max_len_base)
+				*max_len_base = len;
+			if (!is_key_stat(id)) {
+				len = strlen(comp_buf);
+				if (len > *max_len_comp)
+					*max_len_comp = len;
+				len = strlen(diff_buf);
+				if (len > *max_len_diff)
+					*max_len_diff = len;
+			}
+			break;
+		case RESFMT_TABLE: {
+			/* string outputs are left-aligned, number outputs are right-aligned */
+			const char *fmt = base_str ? "%s%-*s" : "%s%*s";
+
+			printf(fmt, i == 0 ? "" : COLUMN_SEP, *max_len_base, base_buf);
+			if (!is_key_stat(id)) {
+				printf(fmt, COLUMN_SEP, *max_len_comp, comp_buf);
+				printf(fmt, COLUMN_SEP, *max_len_diff, diff_buf);
+			}
+			if (i == env.output_spec.spec_cnt - 1)
+				printf("\n");
+			break;
+		}
+		case RESFMT_CSV:
+			printf("%s%s", i == 0 ? "" : ",", base_buf);
+			if (!is_key_stat(id)) {
+				printf("%s%s", i == 0 ? "" : ",", comp_buf);
+				printf("%s%s", i == 0 ? "" : ",", diff_buf);
+			}
+			if (i == env.output_spec.spec_cnt - 1)
+				printf("\n");
+			break;
+		}
+	}
+
+	if (last && fmt == RESFMT_TABLE)
+		output_comp_header_underlines();
+}
+
+static int cmp_stats_key(const struct verif_stats *base, const struct verif_stats *comp)
+{
+	int r;
+
+	r = strcmp(base->file_name, comp->file_name);
+	if (r != 0)
+		return r;
+	return strcmp(base->prog_name, comp->prog_name);
+}
+
+static int handle_comparison_mode(void)
+{
+	struct stat_specs base_specs = {}, comp_specs = {};
+	enum resfmt cur_fmt;
+	int err, i, j;
+
+	if (env.filename_cnt != 2) {
+		fprintf(stderr, "Comparison mode expects exactly two input CSV files!\n");
+		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
+		return -EINVAL;
+	}
+
+	err = parse_stats_csv(env.filenames[0], &base_specs,
+			      &env.baseline_stats, &env.baseline_stat_cnt);
+	if (err) {
+		fprintf(stderr, "Failed to parse stats from '%s': %d\n", env.filenames[0], err);
+		return err;
+	}
+	err = parse_stats_csv(env.filenames[1], &comp_specs,
+			      &env.prog_stats, &env.prog_stat_cnt);
+	if (err) {
+		fprintf(stderr, "Failed to parse stats from '%s': %d\n", env.filenames[1], err);
+		return err;
 	}
-	free(env.prog_stats);
+
+	/* To keep it simple we validate that the set and order of stats in
+	 * both CSVs are exactly the same. This can be lifted with a bit more
+	 * pre-processing later.
+	 */
+	if (base_specs.spec_cnt != comp_specs.spec_cnt) {
+		fprintf(stderr, "Number of stats in '%s' and '%s' differs (%d != %d)!\n",
+			env.filenames[0], env.filenames[1],
+			base_specs.spec_cnt, comp_specs.spec_cnt);
+		return -EINVAL;
+	}
+	for (i = 0; i < base_specs.spec_cnt; i++) {
+		if (base_specs.ids[i] != comp_specs.ids[i]) {
+			fprintf(stderr, "Stats composition differs between '%s' and '%s' (%s != %s)!\n",
+				env.filenames[0], env.filenames[1],
+				stat_defs[base_specs.ids[i]].names[0],
+				stat_defs[comp_specs.ids[i]].names[0]);
+			return -EINVAL;
+		}
+	}
+
+	qsort(env.prog_stats, env.prog_stat_cnt, sizeof(*env.prog_stats), cmp_prog_stats);
+	qsort(env.baseline_stats, env.baseline_stat_cnt, sizeof(*env.baseline_stats), cmp_prog_stats);
+
+	/* for human-readable table output we need to do extra pass to
+	 * calculate column widths, so we substitute current output format
+	 * with RESFMT_TABLE_CALCLEN and later revert it back to RESFMT_TABLE
+	 * and do everything again.
+	 */
+	if (env.out_fmt == RESFMT_TABLE)
+		cur_fmt = RESFMT_TABLE_CALCLEN;
+	else
+		cur_fmt = env.out_fmt;
+
+one_more_time:
+	output_comp_headers(cur_fmt);
+
+	/* If baseline and comparison datasets have different subset of rows
+	 * (we match by 'object + prog' as a unique key) then assume
+	 * empty/missing/zero value for rows that are missing in the opposite
+	 * data set
+	 */
+	i = j = 0;
+	while (i < env.prog_stat_cnt || j < env.baseline_stat_cnt) {
+		bool last = (i == env.prog_stat_cnt - 1) || (j == env.baseline_stat_cnt - 1);
+		const struct verif_stats *base, *comp;
+		int r;
+
+		base = i < env.prog_stat_cnt ? &env.prog_stats[i] : &fallback_stats;
+		comp = j < env.baseline_stat_cnt ? &env.baseline_stats[j] : &fallback_stats;
+
+		if (!base->file_name || !base->prog_name) {
+			fprintf(stderr, "Entry #%d in '%s' doesn't have file and/or program name specified!\n",
+				i, env.filenames[0]);
+			return -EINVAL;
+		}
+		if (!comp->file_name || !comp->prog_name) {
+			fprintf(stderr, "Entry #%d in '%s' doesn't have file and/or program name specified!\n",
+				j, env.filenames[1]);
+			return -EINVAL;
+		}
+
+		r = cmp_stats_key(base, comp);
+		if (r == 0) {
+			output_comp_stats(base, comp, cur_fmt, last);
+			i++;
+			j++;
+		} else if (comp == &fallback_stats || r < 0) {
+			output_comp_stats(base, &fallback_stats, cur_fmt, last);
+			i++;
+		} else {
+			output_comp_stats(&fallback_stats, comp, cur_fmt, last);
+			j++;
+		}
+	}
+
+	if (cur_fmt == RESFMT_TABLE_CALCLEN) {
+		cur_fmt = RESFMT_TABLE;
+		goto one_more_time; /* ... this time with feeling */
+	}
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int err = 0, i;
+
+	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
+		return 1;
+
+	if (env.output_spec.spec_cnt == 0)
+		env.output_spec = default_output_spec;
+	if (env.sort_spec.spec_cnt == 0)
+		env.sort_spec = default_sort_spec;
+
+	if (env.comparison_mode)
+		err = handle_comparison_mode();
+	else
+		err = handle_verif_mode();
+
+	free_verif_stats(env.prog_stats, env.prog_stat_cnt);
+	free_verif_stats(env.baseline_stats, env.baseline_stat_cnt);
 	for (i = 0; i < env.filename_cnt; i++)
 		free(env.filenames[i]);
 	free(env.filenames);
-- 
2.30.2

